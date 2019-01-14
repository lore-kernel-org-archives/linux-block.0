Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F2C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81F520659
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmk9nqiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfANUb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:31:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52079 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfANUb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 15:31:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so1035688wmj.1;
        Mon, 14 Jan 2019 12:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8nh8jBjJAPoF6fwDqu+/8Aopkkx0WnNQl3TsCm7S+4=;
        b=jmk9nqiKRQnRph8+ihehwHC6+N6POFsW5em+96L2quuU1a0aH0JkdvmOZOaSqB4rdH
         9UCmkRMVE9XD9HWSW5Movh6Wm2xHXg3ZArhIQ/hQWcFLFgjBttkHnwpY6Jr94jNBckUb
         JHEOAol2TAuTRyO67y/9G0iKsgx7a8Bp9/wVlTtJSEV/eUjzZeLIoegcQSrPYVzEXhYc
         UBEFv9zRo95WSwUWRBy8kUZd6O72boMN1dtGPyQ6r+ql+utjWELRbePX9poHHU5ioRPW
         96WSvzPIhVjd3aak/DjAlRBjXIFjE8JwR7ivfT2zTEPgW1Wa0DJPfBuYU2KjJ+wnJcCB
         qQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=g8nh8jBjJAPoF6fwDqu+/8Aopkkx0WnNQl3TsCm7S+4=;
        b=D6HL2Vzbhk4lhEwpJd3S4qQE6cMuOM9IHUhR0j8bu3/SgZB2Xa6DsU/b0LakdoXqxl
         a1Fl/bmJcdR0/easVtUsi22ExKA6DqlpxOB1nkoNquKHIOp5PK00BSs7AO6E0nTESRSO
         uNJEMuO89eN2yXh+XmTUQ6+ZLiVlVwGe4Nd78NY0n2WY7eXbC6nhqT2+GhcvEvl/EfGN
         rI1qNkxzRmKYIMlABBS5EOkGreqrM5Uj8EfQ3qZ7EWhzg2FoApuyofZNBWOVk9KdYvWW
         4NIOlQSae8VuWUD+mVgj5dHYa6O+bfXP/WQkK+1cdF3D9o6MnfdxuW2TEAYL4YB4lyrJ
         AdiA==
X-Gm-Message-State: AJcUukes41us79q0Y2/h4IWP4QbYiuB+j7Xs21lkeR4xDsT6e91+AVw4
        NzR1429MLy8UpIFF5EJ6+54=
X-Google-Smtp-Source: ALg8bN4YoDRIGRew0RuZZCLsD5+NxAljXGAzbXiT2W2yTeC3p/eFP4GU/x5aJRD4FWUgGy4yI0cJFQ==
X-Received: by 2002:a1c:578e:: with SMTP id l136mr642857wmb.124.1547497886017;
        Mon, 14 Jan 2019 12:31:26 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id t5sm19019357wmg.43.2019.01.14.12.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:31:25 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 29F4E11422AD; Mon, 14 Jan 2019 21:31:19 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blkcg: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:31:13 +0100
Message-Id: <20190114203113.16832-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  kernel/trace/blktrace.c:725:9: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/trace/blktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fac0ddf8a8e2..e1c6d79fb4cc 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -723,6 +723,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 #endif
 	case BLKTRACESTART:
 		start = 1;
+		/* fall through */
 	case BLKTRACESTOP:
 		ret = __blk_trace_startstop(q, start);
 		break;
-- 
2.19.2

