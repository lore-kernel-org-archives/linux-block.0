Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04919C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DCC20859
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WGfrZKVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfAIPdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:33:45 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:23873 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbfAIPdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:33:45 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190109153341epoutp0108490a71856cf34bf85be9739a779bbb~4N-qNnKg72870128701epoutp01F;
        Wed,  9 Jan 2019 15:33:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190109153341epoutp0108490a71856cf34bf85be9739a779bbb~4N-qNnKg72870128701epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547048021;
        bh=G264A4t+LV342oJ1Jco1jrCuJHTuuRU0aNShvcfmYJU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=WGfrZKVqX/yLx/T8zj8cfVnMn57BB5ICEwjYGUKca7Uz22PlXbNDt79+15Gozf27R
         6JHhGJ8QavS+k7SI5a7ViDWcVO650H8O5u7M9LcSexxLmN3bs3mgBMS7jFhYoymHBw
         3TcZtvFP4rBjxf3U7hkOIAcxX6fLp/U5Ga1KJh2E=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190109153339epcas2p28f65e137eb7f5eef85b15a7e77df1d5b~4N-o_Pv8w0299902999epcas2p22;
        Wed,  9 Jan 2019 15:33:39 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.18.04055.354163C5; Thu, 10 Jan 2019 00:33:39 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190109153339epcas2p4691a898dde0174a7565d62fcb3be0b6d~4N-oeeB7Y3007730077epcas2p4Y;
        Wed,  9 Jan 2019 15:33:39 +0000 (GMT)
X-AuditID: b6c32a48-3a9ff70000000fd7-b0-5c361453007c
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.6D.03627.354163C5; Thu, 10 Jan 2019 00:33:39 +0900 (KST)
Received: from test-PowerEdge-R720.sa.corp.samsungelectronics.net
        ([107.108.221.212]) by mmp1.samsung.com (Oracle Communications Messaging
        Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PL2000VLLVH1220@mmp1.samsung.com>; Thu, 10 Jan 2019 00:33:39 +0900 (KST)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nvme@lists.infradead.org, jack@suse.com, david@fromorbit.com,
        tytso@mit.edu, prakash.v@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 3/4] fs: introduce APIs to enable sending write-hint with
 buffer-head
Date:   Wed, 09 Jan 2019 21:01:00 +0530
Message-id: <1547047861-7271-4-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCmmW6wiFmMwdJmI4stx+4xWjxfvpjR
        4uj/t2wWe29pW8ycd4fNYs/ekywW85c9Zbe4MmURs0Vrz092B06PU4skPDYvqfdoOnOU2aNv
        yypGj/VbrrJ4fN4kF8AWxWWTkpqTWZZapG+XwJXxYPI69oJzwhWnF7E3MO4Q6GLk5JAQMJFo
        +3aJsYuRi0NIYAejRPP9L8wQzncgZ+1cZpiqdd9+sEIkdjNKdP2dyg7hTGeSOLhxEVAVBweb
        gKbEhcmlIKaIgKLE5fdOICXMAucYJZZ+nMgEMkhYIFyib9ITNhCbRUBVYvqblWBxXgEniWU7
        e9khlslJ3DzXCbaYU8BZ4lfPT7CLJAQWsEkcur+DBaLIReJ723UoW1ji1fEtUM3SEs9WbWSE
        sIslft05CtXcwShxvWEmVIO9xMU9f8E2MwvwSXQc/ssOcrWEAK9ER5sQRImHxM53B6FBMY1R
        Yuu8q8wTGCUXMDKsYhRLLSjOTU8tNiow0StOzC0uzUvXS87P3cQIjkotjx2MB875HGIU4GBU
        4uFN+GcaI8SaWFZcmXuIUYKDWUmEV/2OSYwQb0piZVVqUX58UWlOavEhRmkOFiVx3ofSc6OF
        BNITS1KzU1MLUotgskwcnFINjMYX+HX7O6sKGY9YPTq07dqOuSlxwnLBK59NY5K7ayKZWnjM
        V1zno0z845yqIOUJe24sl/PbKuTWeHU6t4GJUmfyfqt7q0/IySSf+r+Q5//k6ZfXzF97aEZj
        /QqhhT/YlHv68kyuTZx1fkfYdZUqWX6LSL/YzCfC12bd15JaFzMlR7yX+9UFFSWW4oxEQy3m
        ouJEAIc51w/GAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsVy+t9jAd1gEbMYg/kvBCy2HLvHaPF8+WJG
        i6P/37JZ7L2lbTFz3h02iz17T7JYzF/2lN3iypRFzBatPT/ZHTg9Ti2S8Ni8pN6j6cxRZo++
        LasYPdZvucri8XmTXABbFJdNSmpOZllqkb5dAlfGg8nr2AvOCVecXsTewLhDoIuRk0NCwERi
        3bcfrF2MXBxCAjsZJWZMes4IkhASmMkk8eKqdxcjBwebgKbEhcmlIKaIgKLE5fdOIOXMAucY
        Ja7f6GAGKRcWCJfom/SEDcRmEVCVmP5mJROIzSvgJLFsZy87xC45iZvnOsHqOQWcJX71/GSG
        WOUkcfHWVbYJjDwLGBlWMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIEBta2w1r9Oxgf
        L4k/xCjAwajEw5vwzzRGiDWxrLgy9xCjBAezkgiv+h2TGCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8/PnHIoUE0hNLUrNTUwtSi2CyTBycUg2MFeV60muPG+Zu/OvAWVPsnRzG6fXl6RLLrUvZ
        uWtqJ7j8bQxomfWM4b01W6Fie9mkgh6l9T2fJP3OTvp459C1hM/K666J9AcccPyf8HWN94sv
        J2u0vlq5zFtQNFVprkDcvNWrv3AVf1fdP0fuFdusL58OMTwOZZorcumObdl72cCIt7uqpdJ/
        K7EUZyQaajEXFScCAAyekXIoAgAA
X-CMS-MailID: 20190109153339epcas2p4691a898dde0174a7565d62fcb3be0b6d
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20190109153339epcas2p4691a898dde0174a7565d62fcb3be0b6d
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
        <CGME20190109153339epcas2p4691a898dde0174a7565d62fcb3be0b6d@epcas2p4.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit_bh and write_dirty_buffer do not take write-hint as parameter.
This patch introduces variants which do.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/buffer.c                 | 18 ++++++++++++++++--
 include/linux/buffer_head.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d60d61e..2a94676 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3094,6 +3094,13 @@ int submit_bh(int op, int op_flags, struct buffer_head *bh)
 }
 EXPORT_SYMBOL(submit_bh);
 
+int submit_bh_write_hint(int op, int op_flags, struct buffer_head *bh,
+			 enum rw_hint hint)
+{
+	return submit_bh_wbc(op, op_flags, bh, hint, NULL);
+}
+EXPORT_SYMBOL(submit_bh_write_hint);
+
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
  * @op: whether to %READ or %WRITE
@@ -3151,6 +3158,13 @@ EXPORT_SYMBOL(ll_rw_block);
 
 void write_dirty_buffer(struct buffer_head *bh, int op_flags)
 {
+	write_dirty_buffer_with_hint(bh, op_flags, 0);
+}
+EXPORT_SYMBOL(write_dirty_buffer);
+
+void write_dirty_buffer_with_hint(struct buffer_head *bh, int op_flags,
+				   enum rw_hint hint)
+{
 	lock_buffer(bh);
 	if (!test_clear_buffer_dirty(bh)) {
 		unlock_buffer(bh);
@@ -3158,9 +3172,9 @@ void write_dirty_buffer(struct buffer_head *bh, int op_flags)
 	}
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
-	submit_bh(REQ_OP_WRITE, op_flags, bh);
+	submit_bh_wbc(REQ_OP_WRITE, op_flags, bh, hint, NULL);
 }
-EXPORT_SYMBOL(write_dirty_buffer);
+EXPORT_SYMBOL(write_dirty_buffer_with_hint);
 
 /*
  * For a data-integrity writeout, we need to wait upon any in-progress I/O
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7..3d682ac 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -200,7 +200,10 @@ void ll_rw_block(int, int, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
 void write_dirty_buffer(struct buffer_head *bh, int op_flags);
+void write_dirty_buffer_with_hint(struct buffer_head *bh, int op_flags,
+				   enum rw_hint hint);
 int submit_bh(int, int, struct buffer_head *);
+int submit_bh_write_hint(int, int, struct buffer_head *, enum rw_hint hint);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
-- 
2.7.4

