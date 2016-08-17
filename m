Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-block@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 08/15] nvme: Pass attribute group to device_add_disk
Date: Wed, 17 Aug 2016 15:15:08 +0800
Message-Id: <1471418115-3654-9-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Previously after device_add_disk returns, the KOBJ_ADD uevent is already
emitted. Adding attributes after that is a poor usage of kobject, and
in practice may result in race conditions with userspace, for
example udev checks availability of certain attributes and initializes
/dev entries conditionally.

device_add_disk can handle adding attribute group better, so use it.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/nvme/host/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 23a795f..1921cb2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1686,11 +1686,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
 
-	device_add_disk(ctrl->device, ns->disk, NULL);
-	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			ns->disk->disk_name);
+	device_add_disk(ctrl->device, ns->disk, &nvme_ns_attr_group);
 	return;
  out_free_disk:
 	kfree(disk);
-- 
2.7.4
