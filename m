Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07388C07E9C
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE0F61CB0
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhGGFct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhGGFcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:41 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E896C061760;
        Tue,  6 Jul 2021 22:30:01 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso1114326otq.13;
        Tue, 06 Jul 2021 22:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUtu6qPrt9CdnsRN6tfeZYE0y1TuRMKLEMOtOSTruJY=;
        b=F06mQqx24VR82ubSqMr70LXkWrojQ2fAgEEriUfQhVIL5gkXPeibuMGe/8tMcuRIPb
         632eJPDaifcKxAwzYs40NCwfFaOu/z98z/d4LcjeTmpyHgxpUP5+FyeT4SqSg5FdO/u5
         J7pfVZKU1EsJtW62JoMp/7eKRvapOr7a+fRtPySMNDU3abOzclvWQMboc+xHZsO9IHs2
         B2ENfiF7bNV5SH7Lq8w+9p5WFLw9uZN7PfbljRxl+F9xEQg/DU9PTzEQKwdazC+GomVq
         UwiTPRCA+iU+z5p8q+QQ6XzGAZ1UIuVWk9EMVcEYa9fjU8mo9GA213i4vf9JjbTF2cZr
         eZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUtu6qPrt9CdnsRN6tfeZYE0y1TuRMKLEMOtOSTruJY=;
        b=en8f22dPoFLgm8j6OQe+1eeAFvW7pg3FT/xs+6EtvmHFIlXLXVjTZxaREy9ZJNF0EP
         1uWp4azhKYZOprZMrS2JqNJ2/52Hkk6H3HSmTYfzMMW74wN4+sWxn+UHgyWCw/1NVipn
         DEayX5SqqWs2vXjdxTEUH+exzQ3xSDneRS136GKP6vDs4hQLRrNNMliDUCz/fDjo0v62
         plkU9RBXI3fOh5+N1Yd1fKfINr9JC0mcKYLHcYUI6LDww2y9gZP+dTgU1p0c8TUEw5lh
         aZ4qmcGW27jXSoVnqpxX+JeWA23i13FTD61p9+8jQERg+Ir05TKdmmj2WF2IlBhnDDD1
         NO/A==
X-Gm-Message-State: AOAM531pome2++CdozX1kAaxFkMuyiP7H+KyurrF+rvZN9CkPYmz+Mlc
        LkHkhh0q4tmjhP4VagbFyG1ykLFiXrU=
X-Google-Smtp-Source: ABdhPJwRIztdZpECFdRXqSfmD9731oTE0Bqq3ahr4H0r1uAH/ZlPm3mY7WfUxJMU9+epYWRz3mp0pA==
X-Received: by 2002:a9d:2781:: with SMTP id c1mr17536139otb.34.1625635800420;
        Tue, 06 Jul 2021 22:30:00 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:30:00 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 9/9] block: add WARN_ON_ONCE() to bio_split() for sector alignment
Date:   Tue,  6 Jul 2021 22:29:43 -0700
Message-Id: <20210707052943.3960-10-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

The number of sectors passed to bio_split() must be aligned to
bio_required_sector_alignment(). All callers (other than bounce.c) have
been updated to ensure this, so add a WARN_ON_ONCE() if the number of
sectors is not aligned. (bounce.c was not updated since it's legacy code
- any device that enables bounce buffering won't declare inline
encryption support, so bounce.c will never see a bio with an encryption
context).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 1fab762e079b..4c7bfdeefe76 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1435,6 +1435,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
+	WARN_ON_ONCE(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));
 
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-- 
2.25.1

