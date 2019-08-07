Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1149FC31E40
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 00:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE2C21738
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 00:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="RFvhDhAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfHGAuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:50:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42175 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfHGAuq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 20:50:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so39700759wrr.9
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 17:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5+rKbwY4FKqVWmbsGvvdEeOmqTq+9PbufWY+vIRJyY=;
        b=RFvhDhAzsEGmP3R8DL+pcMrzIbrq7k+polU6BnPglD2j6Ds3u6BvfSCwQrHN/oSbUo
         ZQWbBRIwhTDubauU1tBRlsnHba4NQW5MFP6x+0n71sG6JIBHQJ6CgdFofTEp2E//sVeZ
         2NN6sWNnuDOyl6ehYH4jFJ28qsVckaeA4MhqeNCBtmdooWzBz4xpyCmIduZtAplwogqH
         oibugB4zkY5h7pF5VSgR1yDskxbQF74yap84y6xXHY1Sd1Q7fzyVWEeLuH+v9Q3yXMJV
         W0auuFW6rZErNPQflCH6ojmh9PLMuBUEvYpGu/yt49vkEevA1XB5Ks+baotLc5FA64Yb
         ENIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5+rKbwY4FKqVWmbsGvvdEeOmqTq+9PbufWY+vIRJyY=;
        b=bNdd7pACirpt2i+Dy26kJiFcvPWN7MLu4f2/t6p0SXHAjlBgbAlBvq+bE2rI12974U
         UYjUaoFsEXmfFwtDhoVDSUx2joiyir5wo++H4D8KcZ57UtiKlzi97x32KgGcIS4O7HS6
         3lgSWCWVAp+XRVJtVti5SumOje5E5NRKA7dvzwujrlM97rqyiuw0idEMZCdxpqwC1l8M
         2kOIrxa86juAnUK/GxVvk9Jy3VHkPhGAUkpw722fVDm12Fa2X3jgQyM3VDnAGebe4j5B
         hUMiMa8czXW9yJm+V+Dj1Fi1F55qSftSDCNhU9/PGB3xIFjRzlX4v4v1gwdld9CyOAmx
         jKtA==
X-Gm-Message-State: APjAAAX16JU07AdxnEW+XJcW6L3UVWWHjjtbMeRCThaTjwknqRb+t14G
        XnmWz5PaIehWbjXC5gN+16f0hZenlyHWsg==
X-Google-Smtp-Source: APXvYqy8KQjeNNxOIH8SeUbJwgyA5CS+DhnMMoQmPDKz4PGFRVmsXJYIn35yv5oyM8mLa/a/mW6Dow==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr6854010wrn.285.1565139044280;
        Tue, 06 Aug 2019 17:50:44 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id h8sm99831846wmf.12.2019.08.06.17.50.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:50:43 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, dvander@gmail.com,
        elsk@google.com, gregkh@linuxfoundation.org, joelaf@google.com,
        kernel-team@android.com
Subject: [PATCH v2] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Wed,  7 Aug 2019 01:48:28 +0100
Message-Id: <20190807004828.28059-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <CAJWu+oo=GrZ+SbA6=bboM4==TKXBsTRWkTrkWiZ55pqhJtgQqQ@mail.gmail.com>
References: <CAJWu+oo=GrZ+SbA6=bboM4==TKXBsTRWkTrkWiZ55pqhJtgQqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Enabling Direct I/O with loop devices helps reducing memory usage by
avoiding double caching.  32 bit applications running on 64 bits systems
are currently not able to request direct I/O because is missing from the
lo_compat_ioctl.

This patch fixes the compatibility issue mentioned above by exporting
LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
The input argument for this ioctl is a single long converted to a 1-bit
boolean, so compatibility is preserved.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alessio Balsini <balsini@android.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 44c9985f352ab..2e2193f754ab0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1753,6 +1753,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
 	case LOOP_SET_BLOCK_SIZE:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.23.0.rc1.153.gdeed80330f-goog

