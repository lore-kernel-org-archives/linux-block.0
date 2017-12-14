Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 14 Dec 2017 18:09:27 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Bruno Wolff III <bruno@wolff.to>
CC: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>, Jens Axboe
	<axboe@kernel.dk>, <linux-mm@kvack.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, <regressions@leemhuis.info>,
	<linux-block@vger.kernel.org>
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171214100927.GA26167@localhost.didichuxing.com>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20171214082452.GA16698@wolff.to>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 14, 2017 at 02:24:52AM -0600, Bruno Wolff III wrote:
> On Wed, Dec 13, 2017 at 16:54:17 -0800,
>  Laura Abbott <labbott@redhat.com> wrote:
> >Hi,
> >
> >Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1520982
> >of a boot failure/bug on Linus' master (full bootlog at the bugzilla)
> 
> I'm available for testing. The problem happens on my x86_64 Dell
> Workstation, but not an old i386 server or an x86_64 mac hardware
> based laptop.

Hi,

It seems something wrong with bdi debugfs register, could you help
test the forllowing debug patch, I add some debug log, no function
change, thanks.


>From d2728c07589e8b83115a51e0c629451bff7308db Mon Sep 17 00:00:00 2001
From: weiping zhang <zhangweiping@didichuxing.com>
Date: Thu, 14 Dec 2017 17:56:22 +0800
Subject: [PATCH] bdi debugfs

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 mm/backing-dev.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 84b2dc7..fbbb9a6 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -39,6 +39,10 @@ static struct dentry *bdi_debug_root;
 static void bdi_debug_init(void)
 {
 	bdi_debug_root = debugfs_create_dir("bdi", NULL);
+	if (!bdi_debug_root)
+		pr_err("DEBUG:bdi_debug_root fail\n");
+	else
+		pr_err("DEBUG:bdi_debug_root success\n");
 }
 
 static int bdi_debug_stats_show(struct seq_file *m, void *v)
@@ -115,18 +119,29 @@ static const struct file_operations bdi_debug_stats_fops = {
 
 static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 {
-	if (!bdi_debug_root)
+	if (!bdi_debug_root) {
+		pr_err("DEBUG:dev:%s, bdi_debug_root fail\n", name);
 		return -ENOMEM;
+	} else {
+		pr_err("DEBUG:dev:%s, bdi_debug_root success\n", name);
+	}
 
 	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);
-	if (!bdi->debug_dir)
+	if (!bdi->debug_dir) {
+		pr_err("DEBUG:dev:%s, debug_dir fail\n", name);
 		return -ENOMEM;
+	} else {
+		pr_err("DEBUG:dev:%s, debug_dir success\n", name);
+	}
 
 	bdi->debug_stats = debugfs_create_file("stats", 0444, bdi->debug_dir,
 					       bdi, &bdi_debug_stats_fops);
 	if (!bdi->debug_stats) {
 		debugfs_remove(bdi->debug_dir);
+		pr_err("DEBUG:dev:%s, debug_stats fail\n", name);
 		return -ENOMEM;
+	} else {
+		pr_err("DEBUG:dev:%s, debug_stats success\n", name);
 	}
 
 	return 0;
@@ -879,13 +894,20 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 		return 0;
 
 	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
-	if (IS_ERR(dev))
+	if (IS_ERR(dev)) {
+		pr_err("DEBUG: bdi device_create_vargs fail\n");
 		return PTR_ERR(dev);
+	}
+	pr_err("DEBUG: bdi(0x%p) device_create_vargs sucess\n", bdi);
 
 	if (bdi_debug_register(bdi, dev_name(dev))) {
+		pr_err("DEBUG: dev:%s, bdi(0x%p) bdi_debug_register fail\n",
+			dev_name(dev), bdi);
 		device_destroy(bdi_class, dev->devt);
 		return -ENOMEM;
 	}
+	pr_err("DEBUG: dev:%s, bdi(0x%p) bdi_debug_register success\n",
+		dev_name(dev), bdi);
 	cgwb_bdi_register(bdi);
 	bdi->dev = dev;
 
-- 
2.9.4
