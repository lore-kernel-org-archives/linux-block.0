Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F5C433DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB4820789
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIY0DxS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgJOVqn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgJOVqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 17:46:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3391C0613D5
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b12so161406qte.11
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CuszbQJohiIvHkXMpAk7mXGLUK2ItD9Zlwxr1z+YlSA=;
        b=LIY0DxS58ce7g15m40GxdKtNbycLiavCNXrn7FERdEOefV5SeRcKNVs09L6wtROjDF
         kDBqIEu4LIIKCTQwVj8573cjlEtychr3869oD5MLX1HaV9sjxvXG8xr5AkMkOlGLpaHt
         pVpUgvCzATwuC4vLgE+YbM+ps8qUbSnK264/2GYNXEV/GYJ2HywQgXvMbAp+/LhC/FL2
         5hh9M/DnZHI2daihOdbT72Ri4uHBGP344/pMueE3xyr5IxvzrkTVQ4vNCw5syAuVo8pa
         Cz90AXqMnyaBZjn5/hy5E/aTPiikqfj6llKrez0LOULYfA/+psOh4n6Un6p2QUBEmX8H
         Ok4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CuszbQJohiIvHkXMpAk7mXGLUK2ItD9Zlwxr1z+YlSA=;
        b=rI4WziccqCCc2r3wkHSEWYoya0qvQZTiETsi9BWMiJZvzQyZvTZjneuXYGI1AWusqZ
         pP/Xw7k+mRuplAetTIc3IvQNuGScHhd2EByaHCuVRp/sMdon3asvsDWadcKOAk3CrsmE
         dLSpydRSV6KrKKuXRExWXVTtx29oz0ItCkLBKxGCQPcSosbwH6U3WrHwChzvNhNnJqvh
         Gu5CThgFooxaa/UHmwVio1pcHBSnH2Z5TyT/W6n0o31DjLyNFmI/dWZpsm4IIBQJjxhH
         R1WCotx2NDyiKVHLoXAiTAzpcKKT+WYIgu1hpgrfaqE1pFiCr0JB8pLvp/IX7UAbNARD
         6gmg==
X-Gm-Message-State: AOAM531W/7RSRaK9iPpHc8Zq549B97Faut9TWjcvbcM763+QOaQArg1W
        RzO2kS4veNHUkrnnbtvHNFFJ6SLT+B/U89BI2hyoWf/j6PDIU7tKqq/IlW4ivIgbYpw/U5no+rx
        COkc8wwRBn5zc6tTNj0Gzen6vJbYwf59yGlM12aDhjpgntQaCjdueWRlfEcgNmRWqmd4e
X-Google-Smtp-Source: ABdhPJxDIXTV51KQvEl0aGhmJoIfbkr36Ss/aBbOvc7pJMXIifvVm6XNIb5m+VCXOc8ctnCHHV0RmeFKFEI=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:8246:: with SMTP id h64mr862689qva.54.1602798402108;
 Thu, 15 Oct 2020 14:46:42 -0700 (PDT)
Date:   Thu, 15 Oct 2020 21:46:30 +0000
In-Reply-To: <20201015214632.41951-1-satyat@google.com>
Message-Id: <20201015214632.41951-3-satyat@google.com>
Mime-Version: 1.0
References: <20201015214632.41951-1-satyat@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 2/4] block: add private field to struct keyslot_manager
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a (void *) pointer to struct keyslot_manager that the owner of the
struct can use for any purpose it wants.

Right now, the struct keyslot_manager is expected to be embedded directly
into other structs (and the owner of the keyslot_manager would use
container_of() to access any other data the owner needs). However, this
might take up more space than is acceptable, and it would be better to be
able to add only a pointer to a struct keyslot_manager into other structs
rather than embed the entire struct directly. But container_of() can't be
used when only the pointer to the keyslot_manager is embded. The primary
motivation of this patch is to get around that issue.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 include/linux/keyslot-manager.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 323e15dd6fa7..37f1022b256f 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -59,6 +59,9 @@ struct blk_keyslot_manager {
 	/* Device for runtime power management (NULL if none) */
 	struct device *dev;
 
+	/* Private data for owner */
+	void *priv;
+
 	/* Here onwards are *private* fields for internal keyslot manager use */
 
 	unsigned int num_slots;
-- 
2.29.0.rc1.297.gfa9743e501-goog

