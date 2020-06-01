Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4280FC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 23:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D2C207ED
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 23:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pp/8RPm1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+2N0452"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgFAXLr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:11:47 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53589 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgFAXLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 19:11:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BF2AB5800DD;
        Mon,  1 Jun 2020 19:11:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Jun 2020 19:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=EJxQtXEmzgFV7qYlHbiD6rvXvA
        D6+GpjivfAKXYShn8=; b=pp/8RPm1nMDp8zDWGn+jMh9zTt5XUJaZJT5CvG0dcX
        JRhtGOWyadjxXEh4fVuAcsq7QZZ+zbesJ2IUYWrXUcVzXmFHd1i3e+L2DhzM/yx5
        IQ2i1htYsKcVQtZi6UFEJqUmkGpN21btMEvllx5NFZaCwLJVDDvSZoX5shfxHGzy
        q9ZSZ6izbtxumf20J6CWzmEWtB/tk53hIAI+g91CvsyVaasvZ7hqTnMr//FEUT1c
        LrpDWDXjwIwtI/FfH9dtaqpXvLvGGZwkoDzJM5y4fq9KGJK6I4BUrr/hQmYTq9FN
        6V9Tya8NxGIILvr9/dwWfuDtlrEQTQtAHfWXb6VmZOmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EJxQtXEmzgFV7qYlH
        biD6rvXvAD6+GpjivfAKXYShn8=; b=A+2N0452c36DE0qjKhBkM9RicotCU+OXG
        ZRRHrE+KyZdHSShWo/lWsb0ey7SWaUKHObn2xZiTSll0E38D+FBamXZ+hV6MLXFn
        1qSTbnPBQJabyiC4iqyPb2BlwizRAIorwWZRQx8oLPD+5IhsVuugofC2/Vw3mhpv
        /7zfOGE2VnvdDAg1QV5TQZv2q4tDFmhkHcrHtrmvZ5v/ZqV/8HEUmOGt+KLL0+KX
        gp0WA+ZRhGh0m4opyE5Cc0lmBJNpwKBHCQrC6wIAXyzgSjN6Esp+CH53yWrtxn9U
        dDSOtDwnI56QVbuUYiSGPP+Yom5QkttwYg08dBWl5odn/JpcWwOGw==
X-ME-Sender: <xms:MIvVXkONr8XwPkgygnAIFRmnxuCcLIEGYTO0MNyCOoJFyBpfbIdNng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitd
    elueeijeefleffveelieefgfejjeeigeekudduteefkefffeethfdvjeevnecukfhppedu
    ieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MIvVXq9zY4BRoFGj3bm2LWIGoPL3_wwYPJmbiCXCTons26eZoFl0YQ>
    <xmx:MIvVXrTT-2KPnBB0IXj5dVx3rZSOaukhzkJIznA2kfMRoFvs__5NcA>
    <xmx:MIvVXstHQOxT9yyQjJKxK9dmJqTMSADbP6YATk8D-dzxP3Lt92saBg>
    <xmx:MYvVXk7gs-3IrbDI23hi0p6OsIDuE_K4pqbNR6lhpFZP-6ACCFHRklCdi80>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 216D63061CCB;
        Mon,  1 Jun 2020 19:11:44 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH] blk-cgroup: don't account iostat for root cgroup
Date:   Mon,  1 Jun 2020 16:11:41 -0700
Message-Id: <20200601231141.2218370-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This data is never flushed by rstat, so it is never used. We shouldn't
bother collecting it. We can access global disk stats to compute io
statistics for the root cgroup.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/blk-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a57ebe2f00ab..e9de4ec07182 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -591,7 +591,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	throtl = blk_throtl_bio(q, blkg, bio);
 
-	if (!throtl) {
+	if (blkg->parent && !throtl) {
 		struct blkg_iostat_set *bis;
 		int rwd, cpu;
 
-- 
2.24.1

