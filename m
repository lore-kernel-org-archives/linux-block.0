Return-Path: <dverkamp@chromium.org>
Return-Path: <dverkamp@chromium.org>
MIME-Version: 1.0
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181101224035.215548-1-dverkamp@chromium.org> <378387af-25ec-f053-5204-a5a8fa65acf9@oracle.com>
In-Reply-To: <378387af-25ec-f053-5204-a5a8fa65acf9@oracle.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Fri, 2 Nov 2018 11:25:22 -0700
Message-ID: <CABVzXAnunpL3teBjgXOkrR+jTYun2sKjBy7vRA3U1K8rtg2TTw@mail.gmail.com>
Subject: Re: [PATCH v9] virtio_blk: add discard and write zeroes support
To: dongli.zhang@oracle.com
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk, stefanha@redhat.com,
	pbonzini@redhat.com, hch@infradead.org,
	Changpeng Liu <changpeng.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Dongli,

Unfortunately, I am not aware of any in-progress implementation of
this feature for qemu. It hopefully should not be too difficult to
wire up in the qemu virtio-blk model, but I haven't looked into it in
detail.

Thanks,
-- Daniel
On Thu, Nov 1, 2018 at 4:42 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> Hi Daniel,
>
> Other than crosvm, is there any version of qemu (e.g., repositories developed in
> progress on github) where I can try with this feature?
>
> Thank you very much!
>
> Dongli Zhang
>
> On 11/02/2018 06:40 AM, Daniel Verkamp wrote:
> > From: Changpeng Liu <changpeng.liu@intel.com>
> >
> > In commit 88c85538, "virtio-blk: add discard and write zeroes features
> > to specification" (https://github.com/oasis-tcs/virtio-spec), the virtio
> > block specification has been extended to add VIRTIO_BLK_T_DISCARD and
> > VIRTIO_BLK_T_WRITE_ZEROES commands.  This patch enables support for
> > discard and write zeroes in the virtio-blk driver when the device
> > advertises the corresponding features, VIRTIO_BLK_F_DISCARD and
> > VIRTIO_BLK_F_WRITE_ZEROES.
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > ---
> > dverkamp: I've picked up this patch and made a few minor changes (as
> > listed below); most notably, I changed the kmalloc back to GFP_ATOMIC,
> > since it can be called from a context where sleeping is not allowed.
> > To prevent large allocations, I've also clamped the maximum number of
> > discard segments to 256; this results in a 4K allocation and should be
> > plenty of descriptors for most use cases.
> >
> > I also removed most of the description from the commit message, since it
> > was duplicating the comments from virtio_blk.h and quoting parts of the
> > spec without adding any extra information.  I have tested this iteration
> > of the patch using crosvm with modifications to enable the new features:
> > https://chromium.googlesource.com/chromiumos/platform/crosvm/
> >
> > v9 fixes a number of review issues; I didn't attempt to optimize the
> > single-element write zeroes case, so it still does an allocation per
> > request (I did not see any easy place to put the payload that would
> > avoid the allocation).
> >
> > CHANGELOG:
> > v9: [dverkamp] fix LE types in discard struct; cleanups from Ming Lei
> > v8: [dverkamp] replace shifts by 9 with SECTOR_SHIFT constant
> > v7: [dverkamp] use GFP_ATOMIC for allocation that may not sleep; clarify
> > descriptor flags field; comment wording cleanups.
> > v6: don't set T_OUT bit to discard and write zeroes commands.
> > v5: use new block layer API: blk_queue_flag_set.
> > v4: several optimizations based on MST's comments, remove bit field
> > usage for command descriptor.
> > v3: define the virtio-blk protocol to add discard and write zeroes
> > support, first version implementation based on proposed specification.
> > v2: add write zeroes command support.
> > v1: initial proposal implementation for discard command.
> > ---
> >  drivers/block/virtio_blk.c      | 83 ++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/virtio_blk.h | 54 +++++++++++++++++++++
> >  2 files changed, 135 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 086c6bb12baa..0f39efb4b3aa 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -18,6 +18,7 @@
> >
> >  #define PART_BITS 4
> >  #define VQ_NAME_LEN 16
> > +#define MAX_DISCARD_SEGMENTS 256u
> >
> >  static int major;
> >  static DEFINE_IDA(vd_index_ida);
> > @@ -172,10 +173,48 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
> >       return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
> >  }
> >
> > +static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> > +{
> > +     unsigned short segments = blk_rq_nr_discard_segments(req);
> > +     unsigned short n = 0;
> > +     struct virtio_blk_discard_write_zeroes *range;
> > +     struct bio *bio;
> > +     u32 flags = 0;
> > +
> > +     if (unmap)
> > +             flags |= VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP;
> > +
> > +     range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
> > +     if (!range)
> > +             return -ENOMEM;
> > +
> > +     __rq_for_each_bio(bio, req) {
> > +             u64 sector = bio->bi_iter.bi_sector;
> > +             u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> > +
> > +             range[n].flags = cpu_to_le32(flags);
> > +             range[n].num_sectors = cpu_to_le32(num_sectors);
> > +             range[n].sector = cpu_to_le64(sector);
> > +             n++;
> > +     }
> > +
> > +     req->special_vec.bv_page = virt_to_page(range);
> > +     req->special_vec.bv_offset = offset_in_page(range);
> > +     req->special_vec.bv_len = sizeof(*range) * segments;
> > +     req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> > +
> > +     return 0;
> > +}
> > +
> >  static inline void virtblk_request_done(struct request *req)
> >  {
> >       struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> >
> > +     if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
> > +             kfree(page_address(req->special_vec.bv_page) +
> > +                   req->special_vec.bv_offset);
> > +     }
> > +
> >       switch (req_op(req)) {
> >       case REQ_OP_SCSI_IN:
> >       case REQ_OP_SCSI_OUT:
> > @@ -225,6 +264,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >       int qid = hctx->queue_num;
> >       int err;
> >       bool notify = false;
> > +     bool unmap = false;
> >       u32 type;
> >
> >       BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > @@ -237,6 +277,13 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >       case REQ_OP_FLUSH:
> >               type = VIRTIO_BLK_T_FLUSH;
> >               break;
> > +     case REQ_OP_DISCARD:
> > +             type = VIRTIO_BLK_T_DISCARD;
> > +             break;
> > +     case REQ_OP_WRITE_ZEROES:
> > +             type = VIRTIO_BLK_T_WRITE_ZEROES;
> > +             unmap = !(req->cmd_flags & REQ_NOUNMAP);
> > +             break;
> >       case REQ_OP_SCSI_IN:
> >       case REQ_OP_SCSI_OUT:
> >               type = VIRTIO_BLK_T_SCSI_CMD;
> > @@ -256,6 +303,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >
> >       blk_mq_start_request(req);
> >
> > +     if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
> > +             err = virtblk_setup_discard_write_zeroes(req, unmap);
> > +             if (err)
> > +                     return BLK_STS_RESOURCE;
> > +     }
> > +
> >       num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
> >       if (num) {
> >               if (rq_data_dir(req) == WRITE)
> > @@ -802,6 +855,32 @@ static int virtblk_probe(struct virtio_device *vdev)
> >       if (!err && opt_io_size)
> >               blk_queue_io_opt(q, blk_size * opt_io_size);
> >
> > +     if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > +             q->limits.discard_granularity = blk_size;
> > +
> > +             virtio_cread(vdev, struct virtio_blk_config,
> > +                          discard_sector_alignment, &v);
> > +             q->limits.discard_alignment = v ? v << SECTOR_SHIFT : 0;
> > +
> > +             virtio_cread(vdev, struct virtio_blk_config,
> > +                          max_discard_sectors, &v);
> > +             blk_queue_max_discard_sectors(q, v ? v : UINT_MAX);
> > +
> > +             virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
> > +                          &v);
> > +             blk_queue_max_discard_segments(q,
> > +                                            min_not_zero(v,
> > +                                                         MAX_DISCARD_SEGMENTS));
> > +
> > +             blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > +     }
> > +
> > +     if (virtio_has_feature(vdev, VIRTIO_BLK_F_WRITE_ZEROES)) {
> > +             virtio_cread(vdev, struct virtio_blk_config,
> > +                          max_write_zeroes_sectors, &v);
> > +             blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
> > +     }
> > +
> >       virtblk_update_capacity(vblk, false);
> >       virtio_device_ready(vdev);
> >
> > @@ -895,14 +974,14 @@ static unsigned int features_legacy[] = {
> >       VIRTIO_BLK_F_SCSI,
> >  #endif
> >       VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> > -     VIRTIO_BLK_F_MQ,
> > +     VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> >  }
> >  ;
> >  static unsigned int features[] = {
> >       VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
> >       VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
> >       VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> > -     VIRTIO_BLK_F_MQ,
> > +     VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> >  };
> >
> >  static struct virtio_driver virtio_blk = {
> > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > index 9ebe4d968dd5..0f99d7b49ede 100644
> > --- a/include/uapi/linux/virtio_blk.h
> > +++ b/include/uapi/linux/virtio_blk.h
> > @@ -38,6 +38,8 @@
> >  #define VIRTIO_BLK_F_BLK_SIZE        6       /* Block size of disk is available*/
> >  #define VIRTIO_BLK_F_TOPOLOGY        10      /* Topology information is available */
> >  #define VIRTIO_BLK_F_MQ              12      /* support more than one vq */
> > +#define VIRTIO_BLK_F_DISCARD 13      /* DISCARD is supported */
> > +#define VIRTIO_BLK_F_WRITE_ZEROES    14      /* WRITE ZEROES is supported */
> >
> >  /* Legacy feature bits */
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> > @@ -86,6 +88,39 @@ struct virtio_blk_config {
> >
> >       /* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
> >       __u16 num_queues;
> > +
> > +     /* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
> > +     /*
> > +      * The maximum discard sectors (in 512-byte sectors) for
> > +      * one segment.
> > +      */
> > +     __u32 max_discard_sectors;
> > +     /*
> > +      * The maximum number of discard segments in a
> > +      * discard command.
> > +      */
> > +     __u32 max_discard_seg;
> > +     /* Discard commands must be aligned to this number of sectors. */
> > +     __u32 discard_sector_alignment;
> > +
> > +     /* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
> > +     /*
> > +      * The maximum number of write zeroes sectors (in 512-byte sectors) in
> > +      * one segment.
> > +      */
> > +     __u32 max_write_zeroes_sectors;
> > +     /*
> > +      * The maximum number of segments in a write zeroes
> > +      * command.
> > +      */
> > +     __u32 max_write_zeroes_seg;
> > +     /*
> > +      * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
> > +      * deallocation of one or more of the sectors.
> > +      */
> > +     __u8 write_zeroes_may_unmap;
> > +
> > +     __u8 unused1[3];
> >  } __attribute__((packed));
> >
> >  /*
> > @@ -114,6 +149,12 @@ struct virtio_blk_config {
> >  /* Get device ID command */
> >  #define VIRTIO_BLK_T_GET_ID    8
> >
> > +/* Discard command */
> > +#define VIRTIO_BLK_T_DISCARD 11
> > +
> > +/* Write zeroes command */
> > +#define VIRTIO_BLK_T_WRITE_ZEROES    13
> > +
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  /* Barrier before this op. */
> >  #define VIRTIO_BLK_T_BARRIER 0x80000000
> > @@ -133,6 +174,19 @@ struct virtio_blk_outhdr {
> >       __virtio64 sector;
> >  };
> >
> > +/* Unmap this range (only valid for write zeroes command) */
> > +#define VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP   0x00000001
> > +
> > +/* Discard/write zeroes range for each request. */
> > +struct virtio_blk_discard_write_zeroes {
> > +     /* discard/write zeroes start sector */
> > +     __le64 sector;
> > +     /* number of discard/write zeroes sectors */
> > +     __le32 num_sectors;
> > +     /* flags for this range */
> > +     __le32 flags;
> > +};
> > +
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  struct virtio_scsi_inhdr {
> >       __virtio32 errors;
> >
