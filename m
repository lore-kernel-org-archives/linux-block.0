Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091DCC54FCD
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69D42051A
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="EuCeoyTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTMR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:17:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40230 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgCTMR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 08:17:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so301972wmf.5
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=EuCeoyTPoMZfi0ECxiY+ov5mYOnJxbzRq/2KmiZNZCoLs4siHWz/m1Y+vJ5J2DuctW
         ICQsImR48nnjQSxGYiBRFQhwQQbhwj1gfP2Qk1adiU/ATA2pYDDD5+Yn3tfwEm12FFLH
         Zlz6KfFckMr63BPkgoFx3zkKJPcrp/2Y4MZtr9yt1OxvfxcQQN8F5J0xGA/qDNxrrk40
         Ibl0gW6I8ukO+LYFjx0tyBP2qhaDIjv3nGvoKvE7mIgteIuaI1qd54DUzdX4RSrpSlpw
         a3flrDuOWxe9PChUixfw7YbAR1R4lAoUs/4KV/Xo/t8B1UABiLUfURe3Mia3Zz3hrdRx
         uBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=CL2oaD4WogBYPXxltZ+6gpBfUd9V6uoF8L3ULUAWd0ihsnCdErkaBc+u6/fqhMIJH5
         ZZAiKGuzF+9Plb9NDlomNsELFjZKHyg4uTOpDnhKrXo8NjV1UZ9JK9/TtxMtdmgiBRcb
         im5nj7CiSvRWoralWhl2KFyvc4puu2r8RkL38I2Cl0OFxrkSP2gr1xiOmIZnTxwSemC8
         Y48B3tzjqgjNlr2GVGsOE7Ml3+cO+e5jaKpdwQZWZm64pYVRk5+bfjiJIuDEpLA77KlB
         XLi1T5Jf0voC1sgj0AQFZZXW/bTE0eP4rv0JtYBUl1EMyLoa4mMD3uOkta2gQqxxExLp
         933w==
X-Gm-Message-State: ANhLgQ3oCDfGbdGidp5TMTZ8PMVmlbbVZ0L3dDtUX3R5FPwZUkro+GjI
        C8PYWjoTvp8yv5dSZwfzCeJWFnICiiE=
X-Google-Smtp-Source: ADFU+vvs711CH6Mf1TkExttVVSrv1NFN6YmXhTEK/JATngvBlW8YfDz9X/0t3ZFUi2Yi3abigx2wJg==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr9931588wmf.11.1584706644532;
        Fri, 20 Mar 2020 05:17:24 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:23 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 15/26] block: reexport bio_map_kern
Date:   Fri, 20 Mar 2020 13:16:46 +0100
Message-Id: <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To avoid duplicate code in rnbd-srv, we need to reexport
bio_map_kern.

This reverts commit 00ec4f3039a9e36cbccd1aea82d06c77c440a51c.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..9190d68adad7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1564,6 +1564,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	bio->bi_end_io = bio_map_kern_endio;
 	return bio;
 }
+EXPORT_SYMBOL(bio_map_kern);
 
 static void bio_copy_kern_endio(struct bio *bio)
 {
-- 
2.17.1

