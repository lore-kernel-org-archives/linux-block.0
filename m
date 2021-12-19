Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957CDC433F5
	for <linux-block@archiver.kernel.org>; Sun, 19 Dec 2021 20:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhLSUAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Dec 2021 15:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhLSUAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Dec 2021 15:00:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39ADC061574
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WKnfsdrA27hz3Lg5En9wRqt9H4h1j7CXJCH/bJYdq58=; b=Qw2kiXDnsyynz5pSeIv6j9midA
        mPZiuGk9duDa4s+HsxJ1oQYPcU10wZOO+YxijhzRba0GSxfPAyctPARHoGzREjvxSjN6B6j4IwbLc
        RGQA+kosw2iT3VzPfvVMoLRui+WtyOOmlHJsr2xHukbGDRZThV0rumzQDU2QxnKSHr/EWeAyFUstP
        WhVx5M/Wv48bEXj8O9nn5LenfP2QcRw4zcmBHSxVOTAdI7Lhy2VgmtqV2FFbHTZvMboPzEMgciyGc
        /pNAz/8nm7NdZx/ijU35jyp+2NtpTQN3b/UvvcXiMtbJpqmJDMPDQyndEppmWLdxj9NvIM/sK6DF2
        2Ch+15xw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz2MR-00GtUZ-JG; Sun, 19 Dec 2021 20:00:47 +0000
Date:   Sun, 19 Dec 2021 12:00:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>, mcgrof@kernel.org
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Message-ID: <Yb+Pbz1pCNEs4xw3@bombadil.infradead.org>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
 <20211216161806.GA31879@lst.de>
 <20211216161928.GB31879@lst.de>
 <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 17, 2021 at 07:37:43PM +0900, Tetsuo Handa wrote:
> I think we can apply this patch as-is...

Unfortunately I don't think so, don't we end up still with a race
in between the first part of device_add() and the kobject_add()
which adds the kobject to generic layer and in return enables the
disk_release() call for the disk? I count 5 error paths in between
including kobject_add() which can fail as well.

If correct then something like the following may be needed:

diff --git a/block/genhd.c b/block/genhd.c
index 3c139a1b6f04..08ab7ce63e57 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -539,9 +539,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 out_device_del:
 	device_del(ddev);
 out_disk_release_events:
-	disk_release_events(disk);
+	if (!kobject_alive(&ddev->kobj))
+		disk_release_events(disk);
 out_free_ext_minor:
-	if (disk->major == BLOCK_EXT_MAJOR)
+	if (!kobject_alive(&ddev->kobj) && disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
 	return ret;
 }
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c740062b4b1a..4884aedbd4e0 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -117,6 +117,23 @@ extern void kobject_get_ownership(struct kobject *kobj,
 				  kuid_t *uid, kgid_t *gid);
 extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
 
+/**
+ * kobject_alive - Returns whether a kobject_add() has succeeded
+ * @kobj: the object to test
+ *
+ * This will return whether a kobject has been successfully added already with
+ * kobject_add(). It is useful for subsystems which have a kobj_type with its
+ * own kobj_type release() routine and want to verify that it will be called
+ * as otherwise if kobject_add() failed the subsystem is in charge of doing that
+ * cleanup.
+ */
+static inline bool kobject_alive(struct kobject *kobj)
+{
+	if (!kobj || kref_read(&kobj->kref) == 0)
+		return false;
+	return true;
+}
+
 /**
  * kobject_has_children - Returns whether a kobject has children.
  * @kobj: the object to test
