Return-Path: <hch@lst.de>
Date: Tue, 29 May 2018 19:24:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Verkamp, Daniel" <daniel.verkamp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Busch, Keith" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 08/14] nvmet: implement the changed namespaces log
Message-ID: <20180529172458.GB1022@lst.de>
References: <20180526102735.31404-1-hch@lst.de> <20180526102735.31404-9-hch@lst.de> <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2527@FMSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2527@FMSMSX103.amr.corp.intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 04:59:05PM +0000, Verkamp, Daniel wrote:
> > +	} else if (ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES) {
> > +		ctrl->changed_ns_list[0] = cpu_to_le32(0xffffffff);
> > +	}
> 
> Unless I'm missing it happening somewhere else, the list-full case that sets element 0 to 0xffffffff should also explicitly zero out the rest of the list to satisfy the "remainder of the list shall be zero-filled" wording in the spec, since the other changed_ns_list entries will be filled with non-zero NSIDs when we get here.

True.  We actually zero out unused elements already, but that doesn't
catch the ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES special
case.  This relative patch should fix it:

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d7b6293e830b..7b69c348d608 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -136,7 +136,10 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 		goto out;
 
 	mutex_lock(&ctrl->lock);
-	len = ctrl->nr_changed_ns * sizeof(__le32);
+	if (ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES)
+		len = sizeof(__le32);
+	else
+		len = ctrl->nr_changed_ns * sizeof(__le32);
 	status = nvmet_copy_to_sgl(req, 0, ctrl->changed_ns_list, len);
 	if (!status)
 		status = nvmet_zero_sgl(req, len, req->data_len - len);
