Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB33C636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09724613D0
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhGOU0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:26:45 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:33385 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhGOU0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:44 -0400
Received: by mail-pf1-f169.google.com with SMTP id m83so6637410pfd.0;
        Thu, 15 Jul 2021 13:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVsr1fX8J+OKyDxLP2345UQteGC2+U9nxo54Lj42XiA=;
        b=Nq3rhKO4bGMcSDUP0YgONgPbaSY3CUJ62cbYwmj3etV4gBfxuKJGYnCumDN57BdPot
         Fsk3FTllN+kyCY+aC09m0jiI5ljvVJ91n00c3JftvQ3kGsyVyaE5RQH3V0gURm62Ibep
         BQSRX817Y1N4vB2GuW2hCD5iWIoIjQsigq2aAhnh6oLTBWO8BN1sJ7TuHnndCroTY/Jk
         f+WYBo9rvzYca0RkSGNWFuHgsMniH1Fn2ilRxEHglqFimm5G3206BPUMSIYTZV36HOpj
         Ze3tAaSOdcAp50xiE06V+ennCHGHkn0UwhANsEkcSObMHt2W3DFzeXsjr28u5BSGdo2i
         SRYA==
X-Gm-Message-State: AOAM530ZY4OIxQ/od++NORmTCJ4neQsb6ICTiKtFfH6AZgLIBXjvGTuM
        ofgvwoCIK6+VFRI2cplxbJA=
X-Google-Smtp-Source: ABdhPJyaYPb4KP2OaC4kTOlrbbamuA54sMl1Thpw90JLO6d0l9sIDNwI/4na5eiV4Qm7RGIgz7jc2w==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr6191005pgb.127.1626380629620;
        Thu, 15 Jul 2021 13:23:49 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id c14sm8119114pgv.86.2021.07.15.13.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:23:48 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 2/6] block: add flag for add_disk() completion notation
Date:   Thu, 15 Jul 2021 13:23:37 -0700
Message-Id: <20210715202341.2016612-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715202341.2016612-1-mcgrof@kernel.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Often drivers may have complex setups where it is not
clear if their disk completed their respective *add_disk*()
call. They either have to invent a setting or, they
incorrectly use GENHD_FL_UP. Using GENHD_FL_UP however is
used internally so we know when we can add / remove
partitions safely. We can easily fail along the way
prior to add_disk() completing and still have
GENHD_FL_UP set, so it would not be correct in that case
to call del_gendisk() on the disk.

Provide a new flag then which allows us to check if
*add_disk*() completed, and conversely just make
del_gendisk() check for this for drivers so that
they can safely call del_gendisk() and we'll figure
it out if it is safe for you to call this.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c         |  8 ++++++++
 include/linux/genhd.h | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index c6c9c196ff27..72703d243b44 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -630,6 +630,8 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
 	if (ret)
 		goto exit_del_events;
 
+	disk->flags |= GENHD_FL_DISK_ADDED;
+
 	return 0;
 exit_del_events:
 	disk_del_events(disk);
@@ -677,6 +679,9 @@ EXPORT_SYMBOL(device_add_disk_no_queue_reg);
  * with put_disk(), which should be called after del_gendisk(), if
  * __device_add_disk() was used.
  *
+ * Drivers can safely call this even if they are not sure if the respective
+ * __device_add_disk() call succeeded.
+ *
  * Drivers exist which depend on the release of the gendisk to be synchronous,
  * it should not be deferred.
  *
@@ -686,6 +691,9 @@ void del_gendisk(struct gendisk *disk)
 {
 	might_sleep();
 
+	if (!blk_disk_registered(disk))
+		return;
+
 	if (WARN_ON_ONCE(!disk->queue))
 		return;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index dc07a957c9e1..73024416d2d5 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -56,6 +56,10 @@ struct partition_meta_info {
  * Must not be set for devices which are removed entirely when the
  * media is removed.
  *
+ * ``GENHD_FL_DISK_ADDED`` (0x0002): used to clarify that the
+ * respective add_disk*() call completed successfully, so that
+ * we know we can safely process del_gendisk() on the disk.
+ *
  * ``GENHD_FL_CD`` (0x0008): the block device is a CD-ROM-style
  * device.
  * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
@@ -94,7 +98,7 @@ struct partition_meta_info {
  * Used for multipath devices.
  */
 #define GENHD_FL_REMOVABLE			0x0001
-/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
+#define GENHD_FL_DISK_ADDED			0x0002
 /* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
 #define GENHD_FL_CD				0x0008
 #define GENHD_FL_UP				0x0010
@@ -189,6 +193,11 @@ struct gendisk {
 #define disk_to_cdi(disk)	NULL
 #endif
 
+static inline bool blk_disk_registered(struct gendisk *disk)
+{
+	return disk && (disk->flags & GENHD_FL_DISK_ADDED);
+}
+
 static inline int disk_max_parts(struct gendisk *disk)
 {
 	if (disk->flags & GENHD_FL_EXT_DEVT)
-- 
2.27.0

