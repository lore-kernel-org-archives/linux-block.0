Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C147C433FF
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDEE2063F
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnerXueC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfHMIzx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:55:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35666 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfHMIzx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 04:55:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so9178338pgv.2
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2019 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucCbtaW3mcUwvCMG4hOmvtcjTxgqi+7JEdXZz9T3lJY=;
        b=EnerXueC/oHIgi3d8kdA6kpQUiCSirhtoEY8tvY8KCioL7GUWlR8Nz6R+0z4FWxsSR
         kUG7onaKxLTzs4zX0N9P0hBFHa4iFwuBEhoX76WmnsjcePu3blAoRSfYFDRYlMUAmw6/
         efcSgb55Tia2jQLzRggpA41X9dZXOCEYDcSLoOE25dGqBPczWFdg+W6M4zP12D47sbyB
         1ChLzYZakj4JDWcBz3Ye/K9A1HdgqmH19Jzz0ebaA3i9b+3V1CugBKR9gWfQ3bvhLsBz
         B0a1Y8QL0q/HnY3Xy947yEV4rTVcMhIC2cjpxD099iOh64HD0Ho5sCJaOk9XZqdcGY35
         9GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucCbtaW3mcUwvCMG4hOmvtcjTxgqi+7JEdXZz9T3lJY=;
        b=jXPJsQ3J3UmYq+ONcX03D7jY/C6c0109v33idps4uYCmYPalCyiobyV/YJporwPFl+
         PxSPzeMlicy2DuLjUuDQOJ9Ci54qcbQ2tn0WZj9B8Hb1dUMH9rzAveBD9eKS5WHLDoGK
         63mHDuZhTdXj72iEXhAASMbJqwAJS2a4Ww1fsuibWCy47xaO1aBZsKxDR6fEXCeJgb6y
         OkwGmB0ixhxZIkQexaywffsn20NdcbezOR3cq8AjnWdjKpZouRS73Dl3ieQL5m/mpPMz
         zg3hYCDodc1vpBv8FUVHNGdUF7PC/5ps4fHHI5hkq88nOu+6mA46q0fAgUsu2TQvp72m
         WJnw==
X-Gm-Message-State: APjAAAUpIfBvdceo9F6Tq3jxQf3WvmBr5RBnMCBeNVch93wSPo71G/S5
        bMIDfKB40TgMafKLrlXWjYw=
X-Google-Smtp-Source: APXvYqxHceLaVGjvvL/xLId6nl6YAKyl9ta49XmgSlKJB9llHLPKFXesVSJowg/Pt9CNHuhpYT82lA==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr33767479pgp.118.1565686552559;
        Tue, 13 Aug 2019 01:55:52 -0700 (PDT)
Received: from localhost.localdomain ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id l25sm132216686pff.143.2019.08.13.01.55.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 01:55:52 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] blk-sysfs: Make structure queue_attr_group constant
Date:   Tue, 13 Aug 2019 14:25:41 +0530
Message-Id: <20190813085541.7856-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The static structure queue_attr_group is used only once, when it is
passed as the second argument to the function sysfs_create_group().
However, the second parameter of sysfs_create_group() is already defined
as constant. Hence make queue_attr_group itself constant, as it is never
modified.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 block/blk-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 977c659dcd18..9401b0cc2e29 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -783,7 +783,7 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
 	return attr->mode;
 }
 
-static struct attribute_group queue_attr_group = {
+static const struct attribute_group queue_attr_group = {
 	.attrs = queue_attrs,
 	.is_visible = queue_attr_visible,
 };
-- 
2.19.1

