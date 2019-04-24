Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C9C282E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E4B2084F
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129530;
	bh=6Kj/fMTnjLTWJOq409dK0XleAtsCLZBMkE1roOZ66a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YyTF2jTd8uFxpjEDQmzqSTXQGlx7JVB4Qekh/Jp+IxlAabiBjrMGTV2RDeoUskKIa
	 q4Z3WAMeXkwc5fNEEyQ94lh3HcYSlZ4wRvWFI5tAfG6gvtwe6OhSGe5t2wKUBbSora
	 wZqyBlFxoE7pAueenBISTIIy6RCSBSPA7BLh+Hpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfDXRNL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733277AbfDXRNJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:09 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0ED621903;
        Wed, 24 Apr 2019 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125989;
        bh=6Kj/fMTnjLTWJOq409dK0XleAtsCLZBMkE1roOZ66a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxcjSzhuCG/fUJ/nIm8zpNz3SR/vIyo/goQTxTQSBX3kV9GbAnDDIZUi4iKhCryhT
         G3HuKREJCuKnR7YCacRGJeJDKQe+sK3J2xxF36qnYevtFbVyDcKiwoQAw+RgvgqzKB
         KD+ibmgHIhkLNYgIQPWLHFG7lEndNrruf9yhcvpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3.18 054/104] block: do not leak memory in bio_copy_user_iov()
Date:   Wed, 24 Apr 2019 19:09:11 +0200
Message-Id: <20190424170902.295902372@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

commit a3761c3c91209b58b6f33bf69dd8bb8ec0c9d925 upstream.

When bio_add_pc_page() fails in bio_copy_user_iov() we should free
the page we just allocated otherwise we are leaking it.

Cc: linux-block@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -1217,8 +1217,11 @@ struct bio *bio_copy_user_iov(struct req
 			}
 		}
 
-		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes)
+		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes) {
+			if (!map_data)
+				__free_page(page);
 			break;
+		}
 
 		len -= bytes;
 		offset = 0;


