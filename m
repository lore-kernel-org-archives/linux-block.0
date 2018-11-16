Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDAAC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161F22086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161F22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbeKQA7Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:59:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44297 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeKQA7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 19:59:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so2048651pgr.11;
        Fri, 16 Nov 2018 06:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSE+5kXNTvXlC9JYAATl1oJkdaJMPT6LWmZa3NZs56w=;
        b=o5XkDPOtKJhpiv9WNHhEJyqqtf3qC2QCsA55TQXuWVCdbGlCsn4DLbN18DmI8IAyL5
         1NNtDxZuL3Zd4T3s6LLKeeG76KzPt2pO3xJ+/RmhudWNEtnCQNv/IcjwZEwY3NEJdXfN
         Fo67eqXNGOPY1teLFoS88Lw7GXUWBmQFxHjl3gtDV/Kksv5oCZPNuKF5g2O5F+ucupL/
         RAXsnLN/p3j3sUH9Pzm+ZU3szwEt+wKKqqpJruE5mWS/h1xi2RTh6vqzeCmHtn4nCZwQ
         nbVTGhFisdsw650O4fu//wYzvAgav9wnstx6QJomg7bNLhxHlFkvFzFjEAVN1vKNVD5e
         bujg==
X-Gm-Message-State: AGRZ1gLgRAf8QV44G7vYePF9/KxOAsDS1S/ZLPHWAAAfdzfzMPiIXHWu
        nfNkroMoYxAo7VSDixGQc+cWmgLM
X-Google-Smtp-Source: AJdET5cPw/OKYoOEOQwOUL9Uo7uAOXIgQkBFFKM9/C7A8sosVOzWniiZcIAqbfJ7FgedRk5hYQ2+Ww==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr10355747pgh.129.1542379603715;
        Fri, 16 Nov 2018 06:46:43 -0800 (PST)
Received: from [192.168.40.151] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id z5-v6sm39281778pfd.99.2018.11.16.06.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 06:46:42 -0800 (PST)
Message-ID: <1542379600.100259.38.camel@acm.org>
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
From:   Bart Van Assche <bvanassche@acm.org>
To:     Hannes Reinecke <hare@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>
Date:   Fri, 16 Nov 2018 06:46:40 -0800
In-Reply-To: <05c4ea6a-9beb-063c-a91c-aca5826cc5b5@suse.de>
References: <20181115175820.13391-1-keith.busch@intel.com>
         <20181115175820.13391-3-keith.busch@intel.com>
         <05c4ea6a-9beb-063c-a91c-aca5826cc5b5@suse.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-11-16 at 10:53 +-0100, Hannes Reinecke wrote:
+AD4 On 11/15/18 6:58 PM, Keith Busch wrote:
+AD4 +AD4 The scsi timeout error handling had been directly updating the block
+AD4 +AD4 layer's request state to prevent a error handling and a natural completion
+AD4 +AD4 from completing the same request twice. Fix this layering violation
+AD4 +AD4 by having scsi control the fate of its commands with scsi owned flags
+AD4 +AD4 rather than use blk-mq's.
+AD4 +AD4 
+AD4 +AD4 Signed-off-by: Keith Busch +ADw-keith.busch+AEA-intel.com+AD4
+AD4 +AD4 ---
+AD4 +AD4   drivers/scsi/scsi+AF8-error.c +AHw 22 +-+-+-+-+-+-+-+-+-+-+------------
+AD4 +AD4   drivers/scsi/scsi+AF8-lib.c   +AHw  6 +-+-+-+-+--
+AD4 +AD4   include/scsi/scsi+AF8-cmnd.h  +AHw  5 +-+-+-+--
+AD4 +AD4   3 files changed, 20 insertions(+-), 13 deletions(-)
+AD4 +AD4 
+AD4 +AD4 diff --git a/drivers/scsi/scsi+AF8-error.c b/drivers/scsi/scsi+AF8-error.c
+AD4 +AD4 index dd338a8cd275..e92e088f636f 100644
+AD4 +AD4 --- a/drivers/scsi/scsi+AF8-error.c
+AD4 +AD4 +-+-+- b/drivers/scsi/scsi+AF8-error.c
+AD4 +AD4 +AEAAQA -297,19 +-297,19 +AEAAQA enum blk+AF8-eh+AF8-timer+AF8-return scsi+AF8-times+AF8-out(struct request +ACo-req)
+AD4 +AD4   
+AD4 +AD4   	if (rtn +AD0APQ BLK+AF8-EH+AF8-DONE) +AHs
+AD4 +AD4   		/+ACo
+AD4 +AD4 -		 +ACo For blk-mq, we must set the request state to complete now
+AD4 +AD4 -		 +ACo before sending the request to the scsi error handler. This
+AD4 +AD4 -		 +ACo will prevent a use-after-free in the event the LLD manages
+AD4 +AD4 -		 +ACo to complete the request before the error handler finishes
+AD4 +AD4 -		 +ACo processing this timed out request.
+AD4 +AD4 +-		 +ACo Set the command to complete first in order to prevent a real
+AD4 +AD4 +-		 +ACo completion from releasing the command while error handling
+AD4 +AD4 +-		 +ACo is using it. If the command was already completed, then the
+AD4 +AD4 +-		 +ACo lower level driver beat the timeout handler, and it is safe
+AD4 +AD4 +-		 +ACo to return without escalating error recovery.
+AD4 +AD4   		 +ACo
+AD4 +AD4 -		 +ACo If the request was already completed, then the LLD beat the
+AD4 +AD4 -		 +ACo time out handler from transferring the request to the scsi
+AD4 +AD4 -		 +ACo error handler. In that case we can return immediately as no
+AD4 +AD4 -		 +ACo further action is required.
+AD4 +AD4 +-		 +ACo If timeout handling lost the race to a real completion, the
+AD4 +AD4 +-		 +ACo block layer may ignore that due to a fake timeout injection,
+AD4 +AD4 +-		 +ACo so return RESET+AF8-TIMER to allow error handling another shot
+AD4 +AD4 +-		 +ACo at this command.
+AD4 +AD4   		 +ACo-/
+AD4 +AD4 -		if (+ACE-blk+AF8-mq+AF8-mark+AF8-complete(req))
+AD4 +AD4 -			return rtn+ADs
+AD4 +AD4 +-		if (test+AF8-and+AF8-set+AF8-bit(+AF8AXw-SCMD+AF8-COMPLETE, +ACY-scmd-+AD4-flags))
+AD4 +AD4 +-			return BLK+AF8-EH+AF8-RESET+AF8-TIMER+ADs
+AD4 +AD4   		if (scsi+AF8-abort+AF8-command(scmd) +ACEAPQ SUCCESS) +AHs
+AD4 +AD4   			set+AF8-host+AF8-byte(scmd, DID+AF8-TIME+AF8-OUT)+ADs
+AD4 +AD4   			scsi+AF8-eh+AF8-scmd+AF8-add(scmd)+ADs
+AD4 +AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 index 5d83a162d03b..c1d5e4e36125 100644
+AD4 +AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +AEAAQA -1635,8 +-1635,11 +AEAAQA static blk+AF8-status+AF8-t scsi+AF8-mq+AF8-prep+AF8-fn(struct request +ACo-req)
+AD4 +AD4   
+AD4 +AD4   static void scsi+AF8-mq+AF8-done(struct scsi+AF8-cmnd +ACo-cmd)
+AD4 +AD4   +AHs
+AD4 +AD4 +-	if (unlikely(test+AF8-and+AF8-set+AF8-bit(+AF8AXw-SCMD+AF8-COMPLETE, +ACY-cmd-+AD4-flags)))
+AD4 +AD4 +-		return+ADs
+AD4 +AD4   	trace+AF8-scsi+AF8-dispatch+AF8-cmd+AF8-done(cmd)+ADs
+AD4 +AD4 -	blk+AF8-mq+AF8-complete+AF8-request(cmd-+AD4-request)+ADs
+AD4 +AD4 +-	if (unlikely(+ACE-blk+AF8-mq+AF8-complete+AF8-request(cmd-+AD4-request)))
+AD4 +AD4 +-		clear+AF8-bit(+AF8AXw-SCMD+AF8-COMPLETE, +ACY-cmd-+AD4-flags)+ADs
+AD4 +AD4   +AH0
+AD4 +AD4   
+AD4 +AD4   static void scsi+AF8-mq+AF8-put+AF8-budget(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx)
+AD4 +AD4 +AEAAQA -1701,6 +-1704,7 +AEAAQA static blk+AF8-status+AF8-t scsi+AF8-queue+AF8-rq(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4 +AD4   			goto out+AF8-dec+AF8-host+AF8-busy+ADs
+AD4 +AD4   		req-+AD4-rq+AF8-flags +AHwAPQ RQF+AF8-DONTPREP+ADs
+AD4 +AD4   	+AH0 else +AHs
+AD4 +AD4 +-		cmd-+AD4-flags +ACYAPQ +AH4-SCMD+AF8-COMPLETE+ADs
+AD4 +AD4   		blk+AF8-mq+AF8-start+AF8-request(req)+ADs
+AD4 +AD4   	+AH0
+AD4 +AD4   
+AD4 
+AD4 Why do you use a normal assignment here (and not a clear+AF8-bit() as in the 
+AD4 above hunk)?
+AD4 
+AD4 And shouldn't you add a barrier here to broadcast the state change to 
+AD4 other cores?

Although I don't like it that request state information is being moved from 
the block layer core into the SCSI core, I think that this patch is fine.
scsi+AF8-queue+AF8-rq() is only called after a request structure has been recycled
so I don't think that there can be any kind of race between the code paths
that use atomic instructions to manipulate the +AF8AXw-SCMD+AF8-COMPLETE bit and
scsi+AF8-queue+AF8-rq().

Bart.
