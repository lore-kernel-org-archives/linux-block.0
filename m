Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFBDC4743D
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94FF613EC
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFDUCi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:02:38 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:44575 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDUCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:02:37 -0400
Received: by mail-qv1-f74.google.com with SMTP id i16-20020a0cf4900000b029022023514900so3063331qvm.11
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iozWCMAtYKCt6ZARG1CR093QIL86BP6w5zG4UHfXEaY=;
        b=b/kMgaiP4rlyi9fuWXIOgNTdRw55igKDtzrELiZWocSzKWGap6DizpaWVP+Lfjm+ln
         /cPr3m1S2oel7iIXg+Fk1im2HQZ2fT67rNzIKydVKheLsJS5z0Sf8Z0B0XuEu3tiJKRF
         qIfcfJdTI5zlglUpYLUxdazXc+jaV+Mq6y5HSNYZwrQF+g9FE3xoes7rwLqulvdfgzg4
         xWn2ABcu9/h2szpHEjkSJlWQ3x7adfX2f/3z+4j8fq/yb4kHyqujPx1VhNW2EgQytzMK
         NiROUYq89hZBQ0UzVhNsA1gPWgP5kviimgtGgAwZgHSfdPSTtqeMZ3dQUNuD+625uC/d
         Y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iozWCMAtYKCt6ZARG1CR093QIL86BP6w5zG4UHfXEaY=;
        b=G3EuVvZsfwDLIJ2kdFD6Pu88g4Sbj1ZWs/yCWjoLn1nQEGITnEpIcpCYeTOCwkIwfi
         eRca5TZOPh/vB7fMI/vt6muGyMnlh8NxZyHyUNQR7iFLBC6kRm+AygAqAnCXnpjnR5L5
         9bqVabAVhET95f9Wc0/TUyOyUxBsEBi6yN4c6C/aXmB69KNClOF/FzgnM/KtKAnMYuo7
         4LlTKRgL06s6MJTQ2Xey1gSGcWmltjoALKYpxoYY6oP2Jm4i/a5vTvk2+YGCAM8zCdZ1
         x/8gAmzNEk9mX1y2PGRJW2568mbVe0XaipTp3rDDpn4jqJFF3/7lFB60eLvavo1pvJmJ
         HHeQ==
X-Gm-Message-State: AOAM5331PnNdcZgVMoBRAkoonTfgh2AuLPjWm7SjR0DA/wBCgfYpM6xL
        64gTwrgqokwKDYuPKs76S/XkJVkMvFh9Fg57OftEcia2KajXDL2NkloOzBnuvhSO2IYFlP3FqNz
        YvA9D5Mab6dCVO3S0VwRc0iKKnUW709SCDH6QSo4D6Z4hKp5310DnumoBA1WkfZUSlbb6
X-Google-Smtp-Source: ABdhPJxOCXfXppSqFV4bTzkHDML8kpyuDCPBL7nXZkg5gEUEj9B5DzrhhwOgM13tbDILoEWyZdZmaQq+gIs=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:62a:: with SMTP id
 a10mr6531397qvx.5.1622836780529; Fri, 04 Jun 2021 12:59:40 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:59:00 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-11-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 10/10] block: add WARN_ON_ONCE() to bio_split() for sector alignment
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The number of sectors passed to bio_split() should be aligned to
bio_required_sector_alignment(). All callers (other than bounce.c) have
been updated to ensure this, so add a WARN_ON_ONCE() if the number of
sectors is not aligned. (bounce.c was not updated since it's legacy code -
any device that enables bounce buffering won't declare inline
encryption support, so bounce.c will never see a bio with an encryption
context).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..32f75f31bb5c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1436,6 +1436,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
+	WARN_ON_ONCE(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));
 
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-- 
2.32.0.rc1.229.g3e70b5a671-goog

