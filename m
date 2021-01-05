Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B56FC433E0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2928522482
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbhAETr4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbhAETr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 14:47:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A6C061574
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 11:47:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 3so627108wmg.4
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6LCQJms9giJq/EpbZ0PSbPtVi1d03oCPduFEMPKzLgo=;
        b=KlvjbvPx0UW75rze6PyzyW8FAtd0mxtDmznR6DPmRoS5j/6Gy+JLyXM+tcaPoPOgYD
         ephd0DhVys3LIfG5P8b2eXlC8rwYFUb+K3o3shSzV6j949HN/l78Wpr3KwEe+cLm00Ly
         kO7XBAn1kY+TjmZB+J3TsZJLzkmY19J/Uqak5iD/yFsBOsZd4bQajuuUYlb0x7oLxkfK
         +mclkqCMdO5+uo5K81uk7tNfOlTs4R4MvU/m7E2DpETO5AMwH3ltYhhYSIHmBxvXJMS5
         HWnC0Z/bVrZg0Fm+/HahNoDX4dYWD/9Had7+IyfZTYLhaEkxXuSSEtSSWQUzywkPdwZW
         JOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6LCQJms9giJq/EpbZ0PSbPtVi1d03oCPduFEMPKzLgo=;
        b=NeZt2oPRS8dVoOCz1jUcvdoSHtYSkVwJOCqOepcZScbidVlSXJpmi2k7fiZjNPr9ct
         hG+V5SwVZeIx58IcVGISuEWZQ5B8NrhlXcKwiFlm22YT9CRyFyxsiZm/ZDtKFsjSKwuD
         kTv/NEmYa/DJv3qJr/Qn0BeA0bo4F00DGVIXXuAR5qYdb87FDyLOOrasS5trOahUvm/0
         QY+yAWWAwR/jWxpN+nsv9yaQPz0+T7kQhC6R3JEs9enE6Z9tt3Gvso9GsHGE9slqgwnq
         h8X2bKwclgu9yqIOFD9ZYR/QGNMF0VMa26UHSsVNu6vMUE7TnXMSSkoQvmbSMdmiwICx
         776A==
X-Gm-Message-State: AOAM533s/J857rqdTCdNTr7o5FqFGJqrwlCErGwBLK3l1OJGAeS6b7hc
        2z/u87QPP0uwELfhx7JdvE4r2IIACNxI9g==
X-Google-Smtp-Source: ABdhPJyF13Gvy6H1JiMuAX7p99qMIv0AmZwy4W9oFsQF0jHAmQ4VbwVc/wc/wujsffbmjCCD6CaY0A==
X-Received: by 2002:a7b:c198:: with SMTP id y24mr619129wmi.151.1609876034743;
        Tue, 05 Jan 2021 11:47:14 -0800 (PST)
Received: from localhost.localdomain ([185.69.144.125])
        by smtp.gmail.com with ESMTPSA id z6sm238014wmi.15.2021.01.05.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:47:14 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC 0/2] optimise split bio
Date:   Tue,  5 Jan 2021 19:43:36 +0000
Message-Id: <cover.1609875589.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the no-copy bvec patches and nullb eats blk_bio_segment_split()
eats >7%. It adds yet another fast path for it.

        8K              16K             32K             64K
before: 932             904             868             788
after:  934             919             902             862

Would appreciate if anyone knows off the bat typical queue_max_segments, etc.
numbers for NVMe.

Pavel Begunkov (2):
  block: add a function for *segment_split fast path
  block: add a fast path for seg split of large bio

 block/blk-merge.c | 107 +++++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 39 deletions(-)

-- 
2.24.0

