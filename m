Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC3CC433DB
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 19:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0DC22B2E
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 19:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgL1T2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:28:35 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46629 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbgL1T2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 14:28:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D05A95C0073;
        Mon, 28 Dec 2020 14:27:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 28 Dec 2020 14:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=LAf31SSA3emL1ZfbhVTJf6Edmd
        TealsQbl0QIPOUCdY=; b=rUQVUQ8Au/QGvekw5Rj6t6APq25bn3feDC5yzt3HKl
        sqSVkiTeSJecPOg4Ru8f9urOSRD+lECGFMZCmnSxJ9+H/Nhz8uPTKokukkHnak+P
        TpawTSmRHn9QOZdaOji48OfshF0nL2Jp/1wIAriyNbTiXiZ8oLC8ugFXF+vJtsmN
        g8MZtiyTeVIRMA0le9DvVaF37ZtNJFLQHCtfFX884K4nLoRGs+ElLagOCTuPTDDJ
        pBmnc0DYY8v5Vgn5ZGMpSTY5TqQm4Soakhfr+/4nxuziqcaG/DWnKHgxgn04KopF
        XGkW9iPNfpHLqwQ7iprcZpVxOHoU6/K/JbfEepM7K98w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=LAf31SSA3emL1Zfbh
        VTJf6EdmdTealsQbl0QIPOUCdY=; b=o93gCIVppRPYExdlc0sv0PPv7K5JrRXFo
        hsg7XTa9Y31Ln4G9JU+aRimOm/HgNUzkd5OOjffNkHtBTqWnxMkYo/xwSLF5IYol
        pp+zwfd6PsIs5utfUu6RrD8n1hz79rGrlxbX02G5J5nZ6XFc2U4T3BiDirc4TcCY
        PwTQxbJyamC8XhxSZ3/V6kwDgMzHMS50bX4pn75AXd79lJt/iJW78kB48CTdJBZL
        8h3zop8P0qizrCt/tRy6EHkxIhuTadjToX/zKBnqAL0JVewoF2CT0dAGVYrVc9tT
        jhtTejB+WaJDcIKI+KMx6VzKIVEnZnoUsdhO0+GjmqQBxD63FjuFw==
X-ME-Sender: <xms:nzHqX11AegeXGFKAhFAWgr7W6WjmQmwjne7yM5M2eETB84pvq4VA1Q>
    <xme:nzHqXwbhNJ6gMsKohi_Phbj13Kf5RqPRVKUONema-6YbreCqRyZECq4e6-2KYyxqH
    VXCnFhE5Dup__kH3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdduledguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepiedtkeelvdffveeuudfhteduieefteehfffgheeggfdvgfetueffleetvdej
    heejnecukfhppeeijedrudeitddrvddujedrvdehtdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdgu
    vg
X-ME-Proxy: <xmx:nzHqX1Dmy19HEvXZieOdSH3jbz-WLTdvYtb8oDTlzZpQaaeops8Uig>
    <xmx:nzHqX6_nTl56gItVyF0UhOELxBTeSpSl1RTN_F6U2sKmpYbEGQi4AQ>
    <xmx:nzHqX9_nkZdu-sNASTOB-IwgPKfQ9JYVxeyIPxlFb43jnOI_S8C_Tg>
    <xmx:oDHqX2MdPizDlP55wJhxuSmkRdCb1vAfr7qpbxhSc8cwY8bpPNyGJg>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 556B91080057;
        Mon, 28 Dec 2020 14:27:27 -0500 (EST)
From:   Andres Freund <andres@anarazel.de>
To:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Andres Freund <andres@anarazel.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: add debugfs stanza for QUEUE_FLAG_NOWAIT.
Date:   Mon, 28 Dec 2020 11:27:18 -0800
Message-Id: <20201228192717.1015629-1-andres@anarazel.de>
X-Mailer: git-send-email 2.29.2.540.g3cf59784d4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This was missed in 021a24460dc2. Leads to the numeric value of
QUEUE_FLAG_NOWAIT (i.e. 29) showing up in
/sys/kernel/debug/block/*/state.

Fixes: 021a24460dc28e7412aecfae89f60e1847e685c0
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3094542e12ae..e21eed20a155 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -129,6 +129,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(PCI_P2PDMA),
 	QUEUE_FLAG_NAME(ZONE_RESETALL),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
+	QUEUE_FLAG_NAME(NOWAIT),
 };
 #undef QUEUE_FLAG_NAME
 
-- 
2.29.2.540.g3cf59784d4

