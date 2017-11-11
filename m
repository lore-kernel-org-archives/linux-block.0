Return-Path: <BATV+f0546c30ddc9806fdc7a+5193+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sat, 11 Nov 2017 00:43:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme updates for Linux 4.15
Message-ID: <20171111084346.GA24802@infradead.org>
References: <20171110143407.zapukx3fhfcr4fm5@infradead.org>
 <e4ae08a2-4724-6ae5-6e64-7f42fb825bad@kernel.dk>
 <fe9a0a40-11d0-97b4-86e1-ba66d3932eb1@kernel.dk>
 <20171110172248.GA8381@infradead.org>
 <a2178e34-ecae-f90d-bef4-eb02af6eb43e@kernel.dk>
 <20171110173342.GA15114@infradead.org>
 <9bcc3b27-0008-b11e-5bbe-4e908326e031@kernel.dk>
 <5c78255c-2678-db0c-55a2-128a11aff660@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c78255c-2678-db0c-55a2-128a11aff660@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Do you want to apply this forward ported version of the patch
to your for-4.15/block tree?  That should at least make the conflict
go away for Linus when he pulls it.

---
>From 9a687c554af721a7a4d77a82d6d8be4e66c1e1a0 Mon Sep 17 00:00:00 2001
From: Martin Wilck <mwilck@suse.com>
Date: Thu, 28 Sep 2017 21:33:23 +0200
Subject: nvme: fix visibility of "uuid" ns attribute

"uuid" must be invisible if both ns->uuid and ns->nguid are unset,
not if either one is.

Fixes: d934f9848a77 "nvme: provide UUID value to userspace"
Signed-off-by: Martin Wilck <mwilck@suse.com>
[hch: rebased to the nvme-4.15 tree to help resolving a conflict]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b4d649039665..592fa6af227f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2524,7 +2524,7 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
 	if (a == &dev_attr_uuid.attr) {
-		if (uuid_is_null(&ids->uuid) ||
+		if (uuid_is_null(&ids->uuid) &&
 		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			return 0;
 	}
-- 
2.14.2
