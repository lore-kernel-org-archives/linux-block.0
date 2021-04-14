Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00546C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EB1611CC
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhDNMYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhDNMYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13609C061756
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m3so23451227edv.5
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4UM9nmnedCsNvLF6PWr9uH8F58/UWSesStUgueFg/I=;
        b=Oyx5UPJ3Hy8/0Wavps5C10WPQQ4etIKyYapxRMhZD4kXzhvOmNmn3OaDlclTYfeIkb
         iXuKnE6cVQ/TyuM+rn2j3DGQMnAISe46pC+PhYDpCcLRX+TRWR77f2BtlPam2fl+L5zp
         HmfITsqCLQqDZO98qs5nwK2VvpN1XGJgYnuF9b4XbvZKh8AyC8CZbSSXKSyxQLGhj1cP
         522s6xcKh9Wkejo6Luk71ntdS3QY5cGzq4YLv5NAVkmrwIkttYyBxn3M9/BodsKgEcE1
         N+wR01ZI6DkQrIrOVOY75HslaWTSqsEu0xFYi8LD1QMfT4y8bXFiKWSxwHJj8XcuLlcE
         3p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4UM9nmnedCsNvLF6PWr9uH8F58/UWSesStUgueFg/I=;
        b=jRVns/RdscxfgYsV5I95c4906G6fIgMak1Ivyd4U9nk94F4hS4zMHxI02WhAp6noup
         4/+Gz4Mp1U4wgTZvQkhxC/OiTR9+ceB8H9OwChAefCfMx/+o+JFg0hAbvIRNbao2n1Gk
         s43SGh17zSAt9dcIALVXysrKELiC/7rQFKbv2t/Bo6mjb/wPkTDA+yT6guZSE6Vl66Hi
         YN4jr3ORXOKENBAByS9yfHHxKNDYQbf+uQdhYg4DDPZhwsGql/hTcmwy6MNL6OpQiYot
         2KZIjxtA5Cv6c+qWQAP9873w+jvzULkCOgfy3DFSUpqYcYpQR8PxqiKOjm847PTY2+wt
         RkvQ==
X-Gm-Message-State: AOAM533vruyQ8UMre0sNYQpovNfea0EvgCrB7iImSYpoegqPpfe1YwS+
        Oq/S/K8JXpVhoOzhR9HoY65xKKp0xdkm+A==
X-Google-Smtp-Source: ABdhPJxlIApnFBw6IfqJvwtmu/2XLqrWLeiPqY5nz6/5NBjUHfDPEgqKf/ltsiqFkZMqcTsKDEV0vA==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr40669647edr.95.1618403049758;
        Wed, 14 Apr 2021 05:24:09 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:09 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv4 for-next 01/19] MAINTAINERS: Change maintainer for rnbd module
Date:   Wed, 14 Apr 2021 14:23:44 +0200
Message-Id: <20210414122402.203388-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Danil steps down, Haris will take over.
Also update email address to ionos.com, the old
cloud.ionos.com will still work for some time.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf947775390c..723ba354dce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15358,8 +15358,8 @@ N:	riscv
 K:	riscv
 
 RNBD BLOCK DRIVERS
-M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
-M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
+M:	Jack Wang <jinpu.wang@ionos.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	drivers/block/rnbd/
-- 
2.25.1

