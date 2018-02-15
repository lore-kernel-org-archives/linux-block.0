Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32886 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030307AbeBOMvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Feb 2018 07:51:49 -0500
Received: by mail-lf0-f66.google.com with SMTP id j193so17914361lfe.0
        for <linux-block@vger.kernel.org>; Thu, 15 Feb 2018 04:51:48 -0800 (PST)
Subject: Re: [PATCH 5/8] lightnvm: implement get log report chunk helpers
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
 <1518530768-20956-6-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <866a9dcc-7e8a-c547-cd53-7e1577f02da0@lightnvm.io>
Date: Thu, 15 Feb 2018 13:51:45 +0100
MIME-Version: 1.0
In-Reply-To: <1518530768-20956-6-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/13/2018 03:06 PM, Javier González wrote:
> From: Javier González <javier@javigon.com>
> 
> The 2.0 spec provides a report chunk log page that can be retrieved
> using the stangard nvme get log page. This replaces the dedicated
> get/put bad block table in 1.2.
> 
> This patch implements the helper functions to allow targets retrieve the
> chunk metadata using get log page
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/core.c      | 28 +++++++++++++++++++++++++
>   drivers/nvme/host/lightnvm.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/lightnvm.h     | 32 ++++++++++++++++++++++++++++
>   3 files changed, 110 insertions(+)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 80492fa6ee76..6857a888544a 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -43,6 +43,8 @@ struct nvm_ch_map {
>   struct nvm_dev_map {
>   	struct nvm_ch_map *chnls;
>   	int nr_chnls;
> +	int bch;
> +	int blun;
>   };

bch/blun should be unnecessary if the map_to_dev / map_to_tgt functions 
are implemented correctly (they can with the ppa_addr order update as 
far as I can see)

What is the reason they can't be used? I might be missing something.

>   
>   static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
> @@ -171,6 +173,9 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
>   	if (!dev_map->chnls)
>   		goto err_chnls;
>   
> +	dev_map->bch = bch;
> +	dev_map->blun = blun;
> +
>   	luns = kcalloc(nr_luns, sizeof(struct ppa_addr), GFP_KERNEL);
>   	if (!luns)
>   		goto err_luns;
> @@ -561,6 +566,19 @@ static void nvm_unregister_map(struct nvm_dev *dev)
>   	kfree(rmap);
>   }
>   
> +static unsigned long nvm_log_off_tgt_to_dev(struct nvm_tgt_dev *tgt_dev)
> +{
> +	struct nvm_dev_map *dev_map = tgt_dev->map;
> +	struct nvm_geo *geo = &tgt_dev->geo;
> +	int lun_off;
> +	unsigned long off;
> +
> +	lun_off = dev_map->blun + dev_map->bch * geo->num_lun;
> +	off = lun_off * geo->c.num_chk * sizeof(struct nvm_chunk_log_page);
> +
> +	return off;
> +}
> +
>   static void nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
>   {
>   	struct nvm_dev_map *dev_map = tgt_dev->map;
> @@ -720,6 +738,16 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
>   	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
>   }
>   
> +int nvm_get_chunk_log_page(struct nvm_tgt_dev *tgt_dev,
> +			   struct nvm_chunk_log_page *log,
> +			   unsigned long off, unsigned long len)
> +{
> +	struct nvm_dev *dev = tgt_dev->parent;
> +
> +	off += nvm_log_off_tgt_to_dev(tgt_dev);
> +
> +	return dev->ops->get_chunk_log_page(tgt_dev->parent, log, off, len);
> +}

I think that this should be exported as get_bb and set_bb. Else linking 
fails if pblk is compiled as a module.

>   
>   int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
>   		       int nr_ppas, int type)
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 7bc75182c723..355d9b0cf084 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
>   	nvme_nvm_admin_set_bb_tbl	= 0xf1,
>   };
>   
> +enum nvme_nvm_log_page {
> +	NVME_NVM_LOG_REPORT_CHUNK	= 0xCA,
> +};
> +

The convention is to have it as lower-case.

>   struct nvme_nvm_ph_rw {
>   	__u8			opcode;
>   	__u8			flags;
> @@ -553,6 +557,50 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
>   	return ret;
>   }
>   
> +static int nvme_nvm_get_chunk_log_page(struct nvm_dev *nvmdev,
> +				       struct nvm_chunk_log_page *log,
> +				       unsigned long off,
> +				       unsigned long total_len)

The chunk_log_page interface are both to be used by targets and the 
block layer code. Therefore, it is not convenient to have a 
byte-addressible interface exposed all the way up to a target. Instead, 
use slba and nlb. That simplifies what a target has to implement, and 
also allows the offset check to be removed.

Chunk log page should be defined in the nvme implementation, such that 
it can be accessed through the traditional LBA path.

struct nvme_nvm_chk_meta {
        __u8    state;
       __u8    type;
        __u8    wli;
        __u8    rsvd[5];
        __le64  slba;
        __le64  cnlb;
        __le64  wp;
};

> +{
> +	struct nvme_ns *ns = nvmdev->q->queuedata;
> +	struct nvme_command c = { };
> +	unsigned long offset = off, left = total_len;
> +	unsigned long len, len_dwords;
> +	void *buf = log;
> +	int ret;
> +
> +	/* The offset needs to be dword-aligned */
> +	if (offset & 0x3)
> +		return -EINVAL;

No need to check for this with the above interface changes.

> +
> +	do {
> +		/* Send 256KB at a time */
> +		len = (1 << 18) > left ? left : (1 << 18);
> +		len_dwords = (len >> 2) - 1;

This is namespace dependent. Use ctrl->max_hw_sectors << 9 instead.

> +
> +		c.get_log_page.opcode = nvme_admin_get_log_page;
> +		c.get_log_page.nsid = cpu_to_le32(ns->head->ns_id);
> +		c.get_log_page.lid = NVME_NVM_LOG_REPORT_CHUNK;
> +		c.get_log_page.lpol = cpu_to_le32(offset & 0xffffffff);
> +		c.get_log_page.lpou = cpu_to_le32(offset >> 32);
> +		c.get_log_page.numdl = cpu_to_le16(len_dwords & 0xffff);
> +		c.get_log_page.numdu = cpu_to_le16(len_dwords >> 16);
> +
> +		ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, buf, len);
> +		if (ret) {
> +			dev_err(ns->ctrl->device,
> +				"get chunk log page failed (%d)\n", ret);
> +			break;
> +		}
> +
> +		buf += len;
> +		offset += len;
> +		left -= len;
> +	} while (left);
> +
> +	return ret;
> +}
> +
>   static inline void nvme_nvm_rqtocmd(struct nvm_rq *rqd, struct nvme_ns *ns,
>   				    struct nvme_nvm_command *c)
>   {
> @@ -684,6 +732,8 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
>   	.get_bb_tbl		= nvme_nvm_get_bb_tbl,
>   	.set_bb_tbl		= nvme_nvm_set_bb_tbl,
>   
> +	.get_chunk_log_page	= nvme_nvm_get_chunk_log_page,
> +
>   	.submit_io		= nvme_nvm_submit_io,
>   	.submit_io_sync		= nvme_nvm_submit_io_sync,
>   
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 1148b3f22b27..eb2900a18160 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -73,10 +73,13 @@ struct nvm_rq;
>   struct nvm_id;
>   struct nvm_dev;
>   struct nvm_tgt_dev;
> +struct nvm_chunk_log_page;
>   
>   typedef int (nvm_id_fn)(struct nvm_dev *);
>   typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
>   typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
> +typedef int (nvm_get_chunk_lp_fn)(struct nvm_dev *, struct nvm_chunk_log_page *,
> +				  unsigned long, unsigned long);
>   typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
>   typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
>   typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
> @@ -90,6 +93,8 @@ struct nvm_dev_ops {
>   	nvm_op_bb_tbl_fn	*get_bb_tbl;
>   	nvm_op_set_bb_fn	*set_bb_tbl;
>   
> +	nvm_get_chunk_lp_fn	*get_chunk_log_page;
> +
>   	nvm_submit_io_fn	*submit_io;
>   	nvm_submit_io_sync_fn	*submit_io_sync;
>   
> @@ -286,6 +291,30 @@ struct nvm_dev_geo {
>   	struct nvm_common_geo c;
>   };
>   
> +enum {
> +	/* Chunk states */
> +	NVM_CHK_ST_FREE =	1 << 0,
> +	NVM_CHK_ST_CLOSED =	1 << 1,
> +	NVM_CHK_ST_OPEN =	1 << 2,
> +	NVM_CHK_ST_OFFLINE =	1 << 3,
> +	NVM_CHK_ST_HOST_USE =	1 << 7,
> +
> +	/* Chunk types */
> +	NVM_CHK_TP_W_SEQ =	1 << 0,
> +	NVM_CHK_TP_W_RAN =	1 << 2,

The RAN bit is the second bit (1 << 1)

> +	NVM_CHK_TP_SZ_SPEC =	1 << 4,
> +};
> +
> +struct nvm_chunk_log_page {
> +	__u8	state;
> +	__u8	type;
> +	__u8	wear_index;
> +	__u8	rsvd[5];
> +	__u64	slba;
> +	__u64	cnlb;
> +	__u64	wp;
> +};

Should be represented both within the device driver and the lightnvm 
header file.
> +
>   struct nvm_target {
>   	struct list_head list;
>   	struct nvm_tgt_dev *dev;
> @@ -505,6 +534,9 @@ extern struct nvm_dev *nvm_alloc_dev(int);
>   extern int nvm_register(struct nvm_dev *);
>   extern void nvm_unregister(struct nvm_dev *);
>   
> +extern int nvm_get_chunk_log_page(struct nvm_tgt_dev *,
> +				  struct nvm_chunk_log_page *,
> +				  unsigned long, unsigned long);
>   extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
>   			      int, int);
>   extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
> 

Here is a compile tested and lightly tested patch with the fixes above. 
Note that the chunk state definition has been taken out, as it properly 
shall go into the next patch. Also note that it uses the get log page 
patch I sent that wires up the 1.2.1 get log page support.

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 689c97b97775..cc22bf48fd13 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -841,6 +841,19 @@ int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, 
struct ppa_addr ppa,
  }
  EXPORT_SYMBOL(nvm_get_tgt_bb_tbl);

+int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct nvm_chk_meta 
*meta,
+		struct ppa_addr ppa, int nchks)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+
+	nvm_map_to_dev(tgt_dev, &ppa);
+	ppa = generic_to_dev_addr(tgt_dev, ppa);
+
+	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
+			(sector_t)ppa.ppa, nchks);
+}
+EXPORT_SYMBOL(nvm_get_chunk_meta);
+
  static int nvm_core_init(struct nvm_dev *dev)
  {
  	struct nvm_id *id = &dev->identity;
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 839c0b96466a..8f81f41a504c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
  	nvme_nvm_admin_set_bb_tbl	= 0xf1,
  };

+enum nvme_nvm_log_page {
+	NVME_NVM_LOG_REPORT_CHUNK	= 0xca,
+};
+
  struct nvme_nvm_ph_rw {
  	__u8			opcode;
  	__u8			flags;
@@ -236,6 +240,16 @@ struct nvme_nvm_id20 {
  	__u8			vs[1024];
  };

+struct nvme_nvm_chk_meta {
+	__u8	state;
+	__u8	type;
+	__u8	wli;
+	__u8	rsvd[5];
+	__le64	slba;
+	__le64	cnlb;
+	__le64	wp;
+};
+
  /*
   * Check we didn't inadvertently grow the command struct
   */
@@ -252,6 +266,9 @@ static inline void _nvme_nvm_check_size(void)
  	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) != 64);
  	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20_addrf) != 8);
  	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) != 32);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) !=
+						sizeof(struct nvm_chk_meta));
  }

  static int init_grp(struct nvm_id *nvm_id, struct nvme_nvm_id12 *id12)
@@ -474,6 +491,48 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev 
*nvmdev, struct ppa_addr *ppas,
  	return ret;
  }

+static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
+				 struct nvm_chk_meta *meta,
+				 sector_t slba, int nchks)
+{
+	struct nvme_ns *ns = ndev->q->queuedata;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_nvm_chk_meta *dev_meta = (struct nvme_nvm_chk_meta *)meta;
+	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
+	size_t offset, len;
+	int ret, i;
+
+	offset = slba * sizeof(struct nvme_nvm_chk_meta);
+
+	while (left) {
+		len = min_t(unsigned, left, ctrl->max_hw_sectors << 9);
+
+		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
+				dev_meta, len, offset);
+		if (ret) {
+			dev_err(ctrl->device, "Get REPORT CHUNK log error\n");
+			break;
+		}
+
+		for (i = 0; i < len; i += sizeof(struct nvme_nvm_chk_meta)) {
+			meta->state = dev_meta->state;
+			meta->type = dev_meta->type;
+			meta->wli = dev_meta->wli;
+			meta->slba = le64_to_cpu(dev_meta->slba);
+			meta->cnlb = le64_to_cpu(dev_meta->cnlb);
+			meta->wp = le64_to_cpu(dev_meta->wp);
+
+			meta++;
+			dev_meta++;
+		}
+
+		offset += len;
+		left -= len;
+	}
+
+	return ret;
+}
+
  static inline void nvme_nvm_rqtocmd(struct nvm_rq *rqd, struct nvme_ns 
*ns,
  				    struct nvme_nvm_command *c)
  {
@@ -605,6 +664,8 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
  	.get_bb_tbl		= nvme_nvm_get_bb_tbl,
  	.set_bb_tbl		= nvme_nvm_set_bb_tbl,

+	.get_chk_meta		= nvme_nvm_get_chk_meta,
+
  	.submit_io		= nvme_nvm_submit_io,
  	.submit_io_sync		= nvme_nvm_submit_io_sync,

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1ca08f4993ba..12abe16d6e64 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -396,6 +396,10 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
  int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
  int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);

+int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		u8 log_page, void *log,
+		size_t size, size_t offset);
+
  extern const struct attribute_group nvme_ns_id_attr_group;
  extern const struct block_device_operations nvme_ns_head_ops;

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e55b10573c99..f056cf72144f 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -49,10 +49,13 @@ struct nvm_rq;
  struct nvm_id;
  struct nvm_dev;
  struct nvm_tgt_dev;
+struct nvm_chk_meta;

  typedef int (nvm_id_fn)(struct nvm_dev *, struct nvm_id *);
  typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
  typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, 
int, int);
+typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, struct nvm_chk_meta *,
+								sector_t, int);
  typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
  typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
  typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
@@ -66,6 +69,8 @@ struct nvm_dev_ops {
  	nvm_op_bb_tbl_fn	*get_bb_tbl;
  	nvm_op_set_bb_fn	*set_bb_tbl;

+	nvm_get_chk_meta_fn	*get_chk_meta;
+
  	nvm_submit_io_fn	*submit_io;
  	nvm_submit_io_sync_fn	*submit_io_sync;

@@ -353,6 +358,20 @@ struct nvm_dev {
  	struct list_head targets;
  };

+/*
+ * Note: The structure size is linked to nvme_nvm_chk_meta such that 
the same
+ * buffer can be used when converting from little endian to cpu addressing.
+ */
+struct nvm_chk_meta {
+	u8	state;
+	u8	type;
+	u8	wli;
+	u8	rsvd[5];
+	u64	slba;
+	u64	cnlb;
+	u64	wp;
+};
+
  static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev 
*tgt_dev,
  						  struct ppa_addr r)
  {
