Return-Path: <andrey.v.kuzmin@gmail.com>
MIME-Version: 1.0
References: <20170208131343.4003-1-hch@lst.de> <20170208131343.4003-5-hch@lst.de>
In-Reply-To: <20170208131343.4003-5-hch@lst.de>
From: Andrey Kuzmin <andrey.v.kuzmin@gmail.com>
Date: Wed, 08 Feb 2017 13:32:22 +0000
Message-ID: <CANvN+ekrmaCZaYt02wX1DRz4+hTLicjyP-tYDTTcKsWe2Lo5MQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] nvme: support ranged discard requests
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: multipart/alternative; boundary=001a113fc302a4e571054804e561
List-ID: <linux-block@vger.kernel.org>

--001a113fc302a4e571054804e561
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 8, 2017, 16:14 Christoph Hellwig <hch@lst.de> wrote:

> NVMe supports up to 255 ranges per DSM command,


256 per spec, with number of ranges being zero-based.

Regards,
Andrey

so wire up support
> for ranged discards up to that limit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 28 +++++++++++++++++++++-------
>  include/linux/nvme.h     |  2 ++
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index efe8ec300126..3fb25d1d0512 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -238,26 +238,36 @@ static inline void nvme_setup_flush(struct nvme_ns
> *ns,
>  static inline int nvme_setup_discard(struct nvme_ns *ns, struct request
> *req,
>                 struct nvme_command *cmnd)
>  {
> +       unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
>         struct nvme_dsm_range *range;
> -       unsigned int nr_bytes = blk_rq_bytes(req);
> +       struct bio *bio;
>
> -       range = kmalloc(sizeof(*range), GFP_ATOMIC);
> +       range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
>         if (!range)
>                 return BLK_MQ_RQ_QUEUE_BUSY;
>
> -       range->cattr = cpu_to_le32(0);
> -       range->nlb = cpu_to_le32(nr_bytes >> ns->lba_shift);
> -       range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
> +       __rq_for_each_bio(bio, req) {
> +               u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
> +               u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> +
> +               range[n].cattr = cpu_to_le32(0);
> +               range[n].nlb = cpu_to_le32(nlb);
> +               range[n].slba = cpu_to_le64(slba);
> +               n++;
> +       }
> +
> +       if (WARN_ON_ONCE(n != segments))
> +               return BLK_MQ_RQ_QUEUE_ERROR;
>
>         memset(cmnd, 0, sizeof(*cmnd));
>         cmnd->dsm.opcode = nvme_cmd_dsm;
>         cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
> -       cmnd->dsm.nr = 0;
> +       cmnd->dsm.nr = segments - 1;
>         cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
>
>         req->special_vec.bv_page = virt_to_page(range);
>         req->special_vec.bv_offset = offset_in_page(range);
> -       req->special_vec.bv_len = sizeof(*range);
> +       req->special_vec.bv_len = sizeof(*range) * segments;
>         req->rq_flags |= RQF_SPECIAL_PAYLOAD;
>
>         return BLK_MQ_RQ_QUEUE_OK;
> @@ -877,6 +887,9 @@ static void nvme_config_discard(struct nvme_ns *ns)
>         struct nvme_ctrl *ctrl = ns->ctrl;
>         u32 logical_block_size = queue_logical_block_size(ns->queue);
>
> +       BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
> +                       NVME_DSM_MAX_RANGES);
> +
>         if (ctrl->quirks & NVME_QUIRK_DISCARD_ZEROES)
>                 ns->queue->limits.discard_zeroes_data = 1;
>         else
> @@ -885,6 +898,7 @@ static void nvme_config_discard(struct nvme_ns *ns)
>         ns->queue->limits.discard_alignment = logical_block_size;
>         ns->queue->limits.discard_granularity = logical_block_size;
>         blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
> +       blk_queue_max_discard_segments(ns->queue, NVME_DSM_MAX_RANGES);
>         queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
>  }
>
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 3d1c6f1b15c9..dcea305157c2 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -553,6 +553,8 @@ enum {
>         NVME_DSMGMT_AD          = 1 << 2,
>  };
>
> +#define NVME_DSM_MAX_RANGES    255
> +
>  struct nvme_dsm_range {
>         __le32                  cattr;
>         __le32                  nlb;
> --
> 2.11.0
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
-- 

Regards,
Andrey

--001a113fc302a4e571054804e561
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Feb 8, 2017, 16=
:14 Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de">hch@lst.de</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">NVMe supports up to 255 rang=
es per DSM command,</blockquote></div><div><br></div><div>256 per spec, wit=
h number of ranges being zero-based.</div><div><br></div><div>Regards,</div=
><div>Andrey</div><div><br></div><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"> so wire up support<br class=3D"gmail_msg">
for ranged discards up to that limit.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Signed-off-by: Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de" class=3D=
"gmail_msg" target=3D"_blank">hch@lst.de</a>&gt;<br class=3D"gmail_msg">
---<br class=3D"gmail_msg">
=C2=A0drivers/nvme/host/core.c | 28 +++++++++++++++++++++-------<br class=
=3D"gmail_msg">
=C2=A0include/linux/nvme.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br class=3D"gmai=
l_msg">
=C2=A02 files changed, 23 insertions(+), 7 deletions(-)<br class=3D"gmail_m=
sg">
<br class=3D"gmail_msg">
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c<br class=
=3D"gmail_msg">
index efe8ec300126..3fb25d1d0512 100644<br class=3D"gmail_msg">
--- a/drivers/nvme/host/core.c<br class=3D"gmail_msg">
+++ b/drivers/nvme/host/core.c<br class=3D"gmail_msg">
@@ -238,26 +238,36 @@ static inline void nvme_setup_flush(struct nvme_ns *n=
s,<br class=3D"gmail_msg">
=C2=A0static inline int nvme_setup_discard(struct nvme_ns *ns, struct reque=
st *req,<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nvme_command=
 *cmnd)<br class=3D"gmail_msg">
=C2=A0{<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned short segments =3D blk_rq_nr_discard_s=
egments(req), n =3D 0;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nvme_dsm_range *range;<br class=3D"gmail=
_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nr_bytes =3D blk_rq_bytes(req);<br=
 class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bio *bio;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0range =3D kmalloc(sizeof(*range), GFP_ATOMIC);<=
br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0range =3D kmalloc_array(segments, sizeof(*range=
), GFP_ATOMIC);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!range)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return BLK_MQ_RQ_QU=
EUE_BUSY;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0range-&gt;cattr =3D cpu_to_le32(0);<br class=3D=
"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0range-&gt;nlb =3D cpu_to_le32(nr_bytes &gt;&gt;=
 ns-&gt;lba_shift);<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0range-&gt;slba =3D cpu_to_le64(nvme_block_nr(ns=
, blk_rq_pos(req)));<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__rq_for_each_bio(bio, req) {<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 slba =3D nvme_b=
lock_nr(ns, bio-&gt;bi_iter.bi_sector);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 nlb =3D bio-&gt=
;bi_iter.bi_size &gt;&gt; ns-&gt;lba_shift;<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0range[n].cattr =3D =
cpu_to_le32(0);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0range[n].nlb =3D cp=
u_to_le32(nlb);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0range[n].slba =3D c=
pu_to_le64(slba);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br class=3D"gm=
ail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON_ONCE(n !=3D segments))<br class=3D"=
gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return BLK_MQ_RQ_QU=
EUE_ERROR;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(cmnd, 0, sizeof(*cmnd));<br class=3D"gma=
il_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmnd-&gt;dsm.opcode =3D nvme_cmd_dsm;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmnd-&gt;dsm.nsid =3D cpu_to_le32(ns-&gt;ns_id)=
;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cmnd-&gt;<a href=3D"http://dsm.nr" rel=3D"noref=
errer" class=3D"gmail_msg" target=3D"_blank">dsm.nr</a> =3D 0;<br class=3D"=
gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmnd-&gt;<a href=3D"http://dsm.nr" rel=3D"noref=
errer" class=3D"gmail_msg" target=3D"_blank">dsm.nr</a> =3D segments - 1;<b=
r class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmnd-&gt;dsm.attributes =3D cpu_to_le32(NVME_DS=
MGMT_AD);<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;special_vec.bv_page =3D virt_to_page(ra=
nge);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;special_vec.bv_offset =3D offset_in_pag=
e(range);<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;special_vec.bv_len =3D sizeof(*range);<=
br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;special_vec.bv_len =3D sizeof(*range) *=
 segments;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;rq_flags |=3D RQF_SPECIAL_PAYLOAD;<br c=
lass=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return BLK_MQ_RQ_QUEUE_OK;<br class=3D"gmail_ms=
g">
@@ -877,6 +887,9 @@ static void nvme_config_discard(struct nvme_ns *ns)<br =
class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nvme_ctrl *ctrl =3D ns-&gt;ctrl;<br clas=
s=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 logical_block_size =3D queue_logical_block_=
size(ns-&gt;queue);<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm=
_range) &lt;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NVME_DSM_MAX_RANGES);<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctrl-&gt;quirks &amp; NVME_QUIRK_DISCARD_ZE=
ROES)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ns-&gt;queue-&gt;li=
mits.discard_zeroes_data =3D 1;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br class=3D"gmail_msg">
@@ -885,6 +898,7 @@ static void nvme_config_discard(struct nvme_ns *ns)<br =
class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ns-&gt;queue-&gt;limits.discard_alignment =3D l=
ogical_block_size;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ns-&gt;queue-&gt;limits.discard_granularity =3D=
 logical_block_size;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_queue_max_discard_sectors(ns-&gt;queue, UIN=
T_MAX);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0blk_queue_max_discard_segments(ns-&gt;queue, NV=
ME_DSM_MAX_RANGES);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns-=
&gt;queue);<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
diff --git a/include/linux/nvme.h b/include/linux/nvme.h<br class=3D"gmail_=
msg">
index 3d1c6f1b15c9..dcea305157c2 100644<br class=3D"gmail_msg">
--- a/include/linux/nvme.h<br class=3D"gmail_msg">
+++ b/include/linux/nvme.h<br class=3D"gmail_msg">
@@ -553,6 +553,8 @@ enum {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NVME_DSMGMT_AD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 1 &lt;&lt; 2,<br class=3D"gmail_msg">
=C2=A0};<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
+#define NVME_DSM_MAX_RANGES=C2=A0 =C2=A0 255<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
=C2=A0struct nvme_dsm_range {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __le32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 cattr;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __le32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 nlb;<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
2.11.0<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
Linux-nvme mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:Linux-nvme@lists.infradead.org" class=3D"gmail_msg" targe=
t=3D"_blank">Linux-nvme@lists.infradead.org</a><br class=3D"gmail_msg">
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-nvme" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">http://lists.infradead.org=
/mailman/listinfo/linux-nvme</a><br class=3D"gmail_msg">
</blockquote></div><div dir=3D"ltr">-- <br></div><div data-smartmail=3D"gma=
il_signature"><p dir=3D"ltr">Regards,<br>
Andrey</p>
</div>

--001a113fc302a4e571054804e561--
