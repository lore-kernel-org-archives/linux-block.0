Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10599C4724C
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 23:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81615208D6
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 23:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbekk.com header.i=@orbekk.com header.b="pwmvA8X8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZ6IP3l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEGXGF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 19:06:05 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53605 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbgEGXGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 19:06:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 376B7D28;
        Thu,  7 May 2020 19:06:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 May 2020 19:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orbekk.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=c2bhUSve0a+ngR0oMRAfr3JhVi
        m3Fhq3SE2mbsHZgcQ=; b=pwmvA8X8bt7lchsV74JWZqNlk5N3odBRRssjIG8IzT
        yoJeAd5G+P5afGplgHxbqAmKXcVtcOSs+gQvgs7MEj6bsXRaXuS/PVNft48Sc7Q+
        ALMf1v7ctlbq7aIur0jlG1ARygnA3vGPcAAgUYuZdLndcfiw+r6VcdZ9CsqF4RqP
        0+Ttgl6y8npeDv7QqAUu3DLpamZt9DJdeI9Uo2SVX0MZ/w9gNzbco82xN+FsM2Qn
        o3y3ymar449W/QST5abQnwec4tjuhg6guwlREinUs8xy+xl4CPaDRofbiePvWOUU
        tCc0ZHQ65ZcMn+o3M6ZyvmBL4W+F2nb7KC1ykXP0jbhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=c2bhUSve0a+ngR0oM
        RAfr3JhVim3Fhq3SE2mbsHZgcQ=; b=nZ6IP3l5S9UihhfP1AYDrzWJFs49BQAq/
        TKx76tdObQMLfxqV0vKHDsmbF4lsptJ8KYyXX1dKZeHdrmTS4Qez/3a9aaNxnQS/
        65wRzGdusHSFEx/taZlbDvMeY6/4XYK7MRUz2CCJ404z+e4wZK8EZhOSRb8spTqO
        i2CeNYbWNdx2DX3dvT1vARE05R75Bz8DhPQTR3kSdlUDJNvppswdmUJhrdX1Knqg
        qIW0Ae2UMR5q2MfE1TXsMf2TrYmU0Vgx/QwFH5yqv2FWpy4MH08H8VWjPhS8Hjfn
        8fDnYlg7HsSLVEMXaAVgI3Tk1Ho9AmGTVapKeOu/lelYAMyeXZ3XQ==
X-ME-Sender: <xms:WpS0Xm8chMSlePsvAajlUfAQ-1T6roEGtDNKPsy6wg6E-QlG1MK6Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkedugdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhjvghtihhlucfq
    rhgsvghkkhcuoehkjhesohhrsggvkhhkrdgtohhmqeenucggtffrrghtthgvrhhnpeegke
    dtudfhveevteeugfdvueekgedugeeihfektdefhfelueeuudfhvdeludejtdenucfkphep
    vdegrdduleefrdejrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhjsehorhgsvghkkhdrtghomh
X-ME-Proxy: <xmx:WpS0XkE-4GmzHRk9FXTPnrNr1Kc2TDaAqLFZHSb2cUwjhodEvKlg8A>
    <xmx:WpS0Xlj4xhAmsPWDB6434B3j5aleF_yM1HeXBV5QairIRPeZ1-smEA>
    <xmx:WpS0XpuPcbL8LMRuK0UEr6KTly44YCwZUM4P7FwNpvG-5O6EPBxF_g>
    <xmx:WpS0XseQwdx3jd36EBLKzkjooNgW8oFCt98aUjKrlWlxSR-VwG13GQ>
Received: from firelink.nyc.rr.com (cpe-24-193-7-101.nyc.res.rr.com [24.193.7.101])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA0FF3280067;
        Thu,  7 May 2020 19:06:01 -0400 (EDT)
From:   Kjetil Orbekk <kj@orbekk.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     harshads@google.com, Khazhismel Kumykov <khazhy@google.com>,
        Kjetil Orbekk <kj@orbekk.com>
Subject: [PATCH] dm: track io errors per mapped device
Date:   Thu,  7 May 2020 19:05:33 -0400
Message-Id: <20200507230532.5733-1-kj@orbekk.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Khazhismel Kumykov <khazhy@google.com>

This will track ioerr_cnt on all dm targets and expose it as
<device>/dm/ioerr_cnt.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
[kj@orbekk.com: added support for bio based devices in dm.c]
Signed-off-by: Kjetil Orbekk <kj@orbekk.com>
---
 drivers/md/dm-core.h  |  2 ++
 drivers/md/dm-rq.c    |  4 ++++
 drivers/md/dm-sysfs.c |  8 ++++++++
 drivers/md/dm.c       | 10 ++++++++++
 drivers/md/dm.h       |  1 +
 5 files changed, 25 insertions(+)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index c4ef1fceead6..c6cc0f9e4d9a 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -108,6 +108,8 @@ struct mapped_device {
 
 	struct dm_stats stats;
 
+	atomic_t ioerr_cnt;
+
 	/* for blk-mq request-based DM support */
 	struct blk_mq_tag_set *tag_set;
 	bool init_tio_pdu:1;
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 3f8577e2c13b..1c1fe96ca7a4 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -171,6 +171,8 @@ static void dm_end_request(struct request *clone, blk_status_t error)
 	tio->ti->type->release_clone_rq(clone, NULL);
 
 	rq_end_stats(md, rq);
+	if (error)
+		atomic_inc(&md->ioerr_cnt);
 	blk_mq_end_request(rq, error);
 	rq_completed(md);
 }
@@ -268,6 +270,8 @@ static void dm_softirq_done(struct request *rq)
 		struct mapped_device *md = tio->md;
 
 		rq_end_stats(md, rq);
+		if (tio->error)
+			atomic_inc(&md->ioerr_cnt);
 		blk_mq_end_request(rq, tio->error);
 		rq_completed(md);
 		return;
diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
index a05fcd50e1b9..5d59790b4b17 100644
--- a/drivers/md/dm-sysfs.c
+++ b/drivers/md/dm-sysfs.c
@@ -74,6 +74,12 @@ static ssize_t dm_attr_name_show(struct mapped_device *md, char *buf)
 	return strlen(buf);
 }
 
+static ssize_t dm_attr_ioerr_cnt_show(struct mapped_device *md, char *buf)
+{
+	sprintf(buf, "%d\n", dm_ioerr_cnt(md));
+	return strlen(buf);
+}
+
 static ssize_t dm_attr_uuid_show(struct mapped_device *md, char *buf)
 {
 	if (dm_copy_name_and_uuid(md, NULL, buf))
@@ -99,6 +105,7 @@ static ssize_t dm_attr_use_blk_mq_show(struct mapped_device *md, char *buf)
 }
 
 static DM_ATTR_RO(name);
+static DM_ATTR_RO(ioerr_cnt);
 static DM_ATTR_RO(uuid);
 static DM_ATTR_RO(suspended);
 static DM_ATTR_RO(use_blk_mq);
@@ -106,6 +113,7 @@ static DM_ATTR_RW(rq_based_seq_io_merge_deadline);
 
 static struct attribute *dm_attrs[] = {
 	&dm_attr_name.attr,
+	&dm_attr_ioerr_cnt.attr,
 	&dm_attr_uuid.attr,
 	&dm_attr_suspended.attr,
 	&dm_attr_use_blk_mq.attr,
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index db9e46114653..7a264379473e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1017,6 +1017,9 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
+	if (error)
+		atomic_inc(&md->ioerr_cnt);
+
 	if (endio) {
 		int r = endio(tio->ti, bio, &error);
 		switch (r) {
@@ -1304,6 +1307,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 		break;
 	case DM_MAPIO_KILL:
 		free_tio(tio);
+		atomic_inc(&md->ioerr_cnt);
 		dec_pending(io, BLK_STS_IOERR);
 		break;
 	case DM_MAPIO_REQUEUE:
@@ -2014,6 +2018,7 @@ static struct mapped_device *alloc_dev(int minor)
 		goto bad;
 
 	dm_stats_init(&md->stats);
+	atomic_set(&md->ioerr_cnt, 0);
 
 	/* Populate the mapping, nobody knows we exist yet */
 	spin_lock(&_minor_lock);
@@ -2992,6 +2997,11 @@ int dm_noflush_suspending(struct dm_target *ti)
 }
 EXPORT_SYMBOL_GPL(dm_noflush_suspending);
 
+int dm_ioerr_cnt(struct mapped_device *md)
+{
+	return atomic_read(&md->ioerr_cnt);
+}
+
 struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
 					    unsigned integrity, unsigned per_io_data_size,
 					    unsigned min_pool_size)
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index d7c4f6606b5f..fafb9d379ce9 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -82,6 +82,7 @@ void dm_unlock_md_type(struct mapped_device *md);
 void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type);
 enum dm_queue_mode dm_get_md_type(struct mapped_device *md);
 struct target_type *dm_get_immutable_target_type(struct mapped_device *md);
+int dm_ioerr_cnt(struct mapped_device *md);
 
 int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
 
-- 
2.25.4

