Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42238C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED51223DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED51223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbeKODzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:55:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40889 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKODzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 22:55:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so2679245pls.7;
        Wed, 14 Nov 2018 09:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZx2T+Gz3HpnZxYyErDdwAPTSvmlmRlovAP1awg7p6o=;
        b=UrEhMCY0ckjudXNrQx1L0ZRIzRGrKDqXWwOL93ygDN3y7VR5+Hw8UNmVuVqQID7Zzh
         93dUKHw1tuEz8H0dal0MFbUhNGYlyOmmp42Cuhbwz4nfK2INOqzn6Ak77K408u7ArS97
         /dCxpr/CaoknlnjmG2xW1VO6sPAKcwWsYZ/s0BXPLTDpDAYA+ARfH0TTpHAAnowMwlvP
         MVlOMKOCB4Jr0MoJAmGMlLDxGuPNXkJR+wncm9/twZLD5I7tnWRkD5E8arcENYAZgOzZ
         pk06fNe3B8OfU/19aWJN4MeqpFaNbYZjHLH8pTeIe3MMGrNGvCtdM12DH5XPdKwTWHKr
         eInQ==
X-Gm-Message-State: AGRZ1gK4T+Ixte+m/BNco2iiaKY0wXv0XMKcqSb8uTNcoxvq2GxUjIni
        HGY9hCav3WE09Yeqc1+u0NI=
X-Google-Smtp-Source: AJdET5cYYClSBMXFXZ6MA6CklPB+x95l70i6/N4yCusHQWDFJRUKRYUUMS7bTeh+Is5Wq3CDpy04sw==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20-v6mr2887000pll.218.1542217899352;
        Wed, 14 Nov 2018 09:51:39 -0800 (PST)
Received: from [172.30.51.210] ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id g123-v6sm25327965pfc.155.2018.11.14.09.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 09:51:38 -0800 (PST)
Message-ID: <1542217896.100259.2.camel@acm.org>
Subject: Re: [PATCH 2/3] scsi: Do not rely on blk-mq for double completions
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Date:   Wed, 14 Nov 2018 09:51:36 -0800
In-Reply-To: <20181114162601.11477-2-keith.busch@intel.com>
References: <20181114162601.11477-1-keith.busch@intel.com>
         <20181114162601.11477-2-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-11-14 at 09:26 -0700, Keith Busch wrote:
+AD4 The scsi timeout error handling had been directly updating the request
+AD4 state to prevent a natural completion and error handling from completing
+AD4 the same request twice. Fix this layering violation by having scsi
+AD4 control the fate of its commands with scsi owned flags rather than
+AD4 use blk-mq's.
+AD4 
+AD4 Signed-off-by: Keith Busch +ADw-keith.busch+AEA-intel.com+AD4
+AD4 ---
+AD4  drivers/scsi/scsi+AF8-error.c +AHw 17 +-+-+---------------
+AD4  drivers/scsi/scsi+AF8-lib.c   +AHw  6 +-+-+-+-+--
+AD4  include/scsi/scsi+AF8-cmnd.h  +AHw  5 +-+-+-+--
+AD4  3 files changed, 12 insertions(+-), 16 deletions(-)
+AD4 
+AD4 diff --git a/drivers/scsi/scsi+AF8-error.c b/drivers/scsi/scsi+AF8-error.c
+AD4 index c736d61b1648..f89e829a1c51 100644
+AD4 --- a/drivers/scsi/scsi+AF8-error.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-error.c
+AD4 +AEAAQA -199,6 +-199,9 +AEAAQA scsi+AF8-abort+AF8-command(struct scsi+AF8-cmnd +ACo-scmd)
+AD4  		return FAILED+ADs
+AD4  	+AH0
+AD4  
+AD4 +-	if (test+AF8-and+AF8-set+AF8-bit(+AF8AXw-SCMD+AF8-COMPLETE, +ACY-scmd-+AD4-flags))
+AD4 +-		return SUCCESS+ADs
+AD4 +-
+AD4  	spin+AF8-lock+AF8-irqsave(shost-+AD4-host+AF8-lock, flags)+ADs
+AD4  	if (shost-+AD4-eh+AF8-deadline +ACEAPQ -1 +ACYAJg +ACE-shost-+AD4-last+AF8-reset)
+AD4  		shost-+AD4-last+AF8-reset +AD0 jiffies+ADs
+AD4 +AEAAQA -296,20 +-299,6 +AEAAQA enum blk+AF8-eh+AF8-timer+AF8-return scsi+AF8-times+AF8-out(struct request
+AD4 +ACo-req)
+AD4  		rtn +AD0 host-+AD4-hostt-+AD4-eh+AF8-timed+AF8-out(scmd)+ADs
+AD4  
+AD4  	if (rtn +AD0APQ BLK+AF8-EH+AF8-DONE) +AHs
+AD4 -		/+ACo
+AD4 -		 +ACo For blk-mq, we must set the request state to complete
+AD4 now
+AD4 -		 +ACo before sending the request to the scsi error handler.
+AD4 This
+AD4 -		 +ACo will prevent a use-after-free in the event the LLD
+AD4 manages
+AD4 -		 +ACo to complete the request before the error handler
+AD4 finishes
+AD4 -		 +ACo processing this timed out request.
+AD4 -		 +ACo
+AD4 -		 +ACo If the request was already completed, then the LLD beat
+AD4 the
+AD4 -		 +ACo time out handler from transferring the request to the
+AD4 scsi
+AD4 -		 +ACo error handler. In that case we can return immediately
+AD4 as no
+AD4 -		 +ACo further action is required.
+AD4 -		 +ACo-/
+AD4 -		if (req-+AD4-q-+AD4-mq+AF8-ops +ACYAJg +ACE-blk+AF8-mq+AF8-mark+AF8-complete(req))
+AD4 -			return rtn+ADs
+AD4  		if (scsi+AF8-abort+AF8-command(scmd) +ACEAPQ SUCCESS) +AHs
+AD4  			set+AF8-host+AF8-byte(scmd, DID+AF8-TIME+AF8-OUT)+ADs
+AD4  			scsi+AF8-eh+AF8-scmd+AF8-add(scmd)+ADs
+AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 index c7fccbb8f554..1e74137f1073 100644
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -2044,8 +-2044,11 +AEAAQA static int scsi+AF8-mq+AF8-prep+AF8-fn(struct request +ACo-req)
+AD4  
+AD4  static void scsi+AF8-mq+AF8-done(struct scsi+AF8-cmnd +ACo-cmd)
+AD4  +AHs
+AD4 +-	if (test+AF8-and+AF8-set+AF8-bit(+AF8AXw-SCMD+AF8-COMPLETE, +ACY-cmd-+AD4-flags))
+AD4 +-		return+ADs
+AD4  	trace+AF8-scsi+AF8-dispatch+AF8-cmd+AF8-done(cmd)+ADs
+AD4 -	blk+AF8-mq+AF8-complete+AF8-request(cmd-+AD4-request)+ADs
+AD4 +-	if (unlikely(+ACE-blk+AF8-mq+AF8-complete+AF8-request(cmd-+AD4-request)))
+AD4 +-		clear+AF8-bit(+AF8AXw-SCMD+AF8-COMPLETE, +ACY-cmd-+AD4-flags)+ADs
+AD4  +AH0
+AD4  
+AD4  static void scsi+AF8-mq+AF8-put+AF8-budget(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx)
+AD4 +AEAAQA -2104,6 +-2107,7 +AEAAQA static blk+AF8-status+AF8-t scsi+AF8-queue+AF8-rq(struct
+AD4 blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4  			goto out+AF8-dec+AF8-host+AF8-busy+ADs
+AD4  		req-+AD4-rq+AF8-flags +AHwAPQ RQF+AF8-DONTPREP+ADs
+AD4  	+AH0 else +AHs
+AD4 +-		cmd-+AD4-flags +ACYAPQ +AH4-SCMD+AF8-COMPLETE+ADs
+AD4  		blk+AF8-mq+AF8-start+AF8-request(req)+ADs
+AD4  	+AH0


Hi Keith,

Please Cc Martin Petersen and the scsi mailing list for SCSI patches.

Regarding this patch: I think this patch introduces a subtle but severe bug
in the SCSI core, namely that if an abort is processed concurrently with
request completion with +ACI-fake timeout+ACI enabled that the abort is ignored.

Bart.
