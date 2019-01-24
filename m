Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A04BC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F84D218B0
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfAXQ2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:28:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34237 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAXQ2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 11:28:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so2882744pga.1;
        Thu, 24 Jan 2019 08:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXDIJV8/uIkS5fqUSWQGfeAHFwe0mqlsrnCb+5YhwAw=;
        b=YKtTIez83EZrWBTBa9FMhav9bEuud3yrJjJBUwXf5LAaIrcb/c9mF0ajWQW/wg3RBx
         IVTJK5fA6bGzB7cvKMLt4LY457QRPCaPORX5e8wFjoNOUjdTtjKY16GbHOl0VnZftLP5
         3jw8/vUKGccVzRA5GPsXUK6jSI4ni7KNsR0kZVCUOETMknwNx+TKfnFrCY08R6rF7g5a
         zTEosc/UzP7QkLQadWakGyF24f9gi/bM1iQWrMoOVxkeIyLixGV/09sN4CzEaGjYX1kR
         iP/gW/h+4D1onzGWTz+bchs1tcm+aNIWTK5Z/aDZw3FJhkkfTyMuPubOiXrMrcu3NURW
         jIiA==
X-Gm-Message-State: AJcUukdeqIsLpLJ6xdpGwnvNlbkuYx11isryqNv5DcQnBLGIo8A4cFgV
        hh5f03+819hkeXykR/8cJ4o=
X-Google-Smtp-Source: ALg8bN777GIVe99apnnFQiT5bVL4EukzunU+krQCAYSskKXa3VnPv+F8FQaj4u0w4cixQSiBUNALNA==
X-Received: by 2002:a62:7f93:: with SMTP id a141mr7188472pfd.96.1548347314512;
        Thu, 24 Jan 2019 08:28:34 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g11sm27045537pfo.139.2019.01.24.08.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 08:28:33 -0800 (PST)
Message-ID: <1548347312.9266.98.camel@acm.org>
Subject: Re: [PATCH] blk-mq: fix the cmd_flag_name array
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Jan 2019 08:28:32 -0800
In-Reply-To: <c3bde1b4-73ea-9120-0e6c-f9f57c0bbb24@kernel.dk>
References: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
         <x49h8dygkih.fsf@segfault.boston.devel.redhat.com>
         <c3bde1b4-73ea-9120-0e6c-f9f57c0bbb24@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-01-24 at 09:22 -0700, Jens Axboe wrote:
+AD4 On 1/24/19 8:09 AM, Jeff Moyer wrote:
+AD4 +AD4 Jianchao Wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4 writes:
+AD4 +AD4 
+AD4 +AD4 +AD4 Swap REQ+AF8-NOWAIT and REQ+AF8-NOUNMAP and add REQ+AF8-HIPRI.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Jianchao Wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4  block/blk-mq-debugfs.c +AHw 3 +-+--
+AD4 +AD4 +AD4  1 file changed, 2 insertions(+-), 1 deletion(-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
+AD4 +AD4 +AD4 index 90d6876..f812083 100644
+AD4 +AD4 +AD4 --- a/block/blk-mq-debugfs.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-mq-debugfs.c
+AD4 +AD4 +AD4 +AEAAQA -308,8 +-308,9 +AEAAQA static const char +ACo-const cmd+AF8-flag+AF8-name+AFsAXQ +AD0 +AHs
+AD4 +AD4 +AD4  	CMD+AF8-FLAG+AF8-NAME(PREFLUSH),
+AD4 +AD4 +AD4  	CMD+AF8-FLAG+AF8-NAME(RAHEAD),
+AD4 +AD4 +AD4  	CMD+AF8-FLAG+AF8-NAME(BACKGROUND),
+AD4 +AD4 +AD4 -	CMD+AF8-FLAG+AF8-NAME(NOUNMAP),
+AD4 +AD4 +AD4  	CMD+AF8-FLAG+AF8-NAME(NOWAIT),
+AD4 +AD4 +AD4 +-	CMD+AF8-FLAG+AF8-NAME(NOUNMAP),
+AD4 +AD4 +AD4 +-	CMD+AF8-FLAG+AF8-NAME(HIPRI),
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4  +ACM-undef CMD+AF8-FLAG+AF8-NAME
+AD4 +AD4 
+AD4 +AD4 Acked-by: Jeff Moyer +ADw-jmoyer+AEA-redhat.com+AD4
+AD4 +AD4 
+AD4 +AD4 You might consider also adding a comment above the req+AF8-flag+AF8-bits enum
+AD4 +AD4 noting that modifications also need to be propagated to cmd+AF8-flag+AF8-name.
+AD4 
+AD4 Agree... These things are notoriously difficult to keep in sync, this
+AD4 isn't the first time we've had a fixup. Not sure if that situation
+AD4 is improvable, but at least a comment might help.

How about making the build system derive the CMD+AF8-FLAG+AF8-NAME() declarations
from the include/linux/blk+ACo header files? It's not that hard to do that e.g.
with the help of sed. The output of sed could be written into a .h file and
that file could be +ACM-included from blk-mq-debugfs.c.

Bart.
