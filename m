Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA03C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C320834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8C320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeLDTfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:35:08 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37263 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDTfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 14:35:08 -0500
Received: by mail-pg1-f174.google.com with SMTP id 80so7825728pge.4;
        Tue, 04 Dec 2018 11:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chND8r3WS/hguEE67ft5PJqXhGXMvedt4gxFiwZIX/M=;
        b=azCa0VFrY33QwJmHt7jv7Yqx+C/7ULEGjnrEUFpMJNYocwPMPsJL3uJnHUdDzcUstV
         xqOqP+cy4hkGr3DZmht9Fwyy1n+to1GWT8F53BYUZ0Npr2AwbWwo55Ft1df+JxhCVptR
         PtMik8g0KCM3ZzZ2XiQ+P6KwGrw4m5yu6YupiDr0OOQaTcBFALcgw4V72fHOm8e5OjAZ
         uYSOAUWnAHzZ+ViTGAsXenB7MhguotQcFrqkf2opkpfeqQQr5eoKvaXeLzUhMKCN6zdU
         CoKXXLctJLY/3x0jgK33lkzfVlo/HJIu2AOf3yK84Y7I3u+8TFtubQ3RwWnQ1670HYWU
         Ps5w==
X-Gm-Message-State: AA+aEWbq2iiDAywemlRmpLOcdtESFYlzMlBS0wgbScXA5weNvd1146kx
        +6rSMFSredtpxehnAOBe+0Q=
X-Google-Smtp-Source: AFSGD/UKi45mhB+LlnVN2R+UEwoLJFrhWw5lxPdfdSEEVLxXOyH0QX3se29BCEEYRrldROtr50SFpg==
X-Received: by 2002:a62:442:: with SMTP id 63mr20921230pfe.156.1543952107397;
        Tue, 04 Dec 2018 11:35:07 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id y1-v6sm23291532pfb.81.2018.12.04.11.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:35:06 -0800 (PST)
Message-ID: <1543952105.185366.210.camel@acm.org>
Subject: Re: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in
 blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Date:   Tue, 04 Dec 2018 11:35:05 -0800
In-Reply-To: <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
References: +ADw-CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe+AF8-pkFVGJg73v0Wp7O38A+AEA-mail.gmail.com+AD4- +ADw-7e8e1fe2-9f91-a370-a98c-43cdad1f6e8e+AEA-acm.org+AD4- +ADw-d56ddf2b485c13445fff5f9c36dd3c87+AEA-mail.gmail.com+AD4- +ADw-1543943674.185366.194.camel+AEA-acm.org+AD4- <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-04 at 23:48 +-0530, Kashyap Desai wrote:
+AD4 Let me explain the issue. It is not a race, but very straight issue.

Please clarify what makes you think that iterating over all requests does not
race with request completion. Is request submission perhaps blocked during the
firmware recovery process? Does the firmware recovery process wait for
completion interrupts that are in progress to finish?

+AD4 Let's
+AD4 say we have one scsi+AF8-device /dev/sda and total IO submitted +- completed are
+AD4 some number 100.
+AD4 All the 100 IO is +ACo-completed+ACo.   Now, As part of Firmware recovery, driver
+AD4 tries to find our outstanding IOs using scsi+AF8-host+AF8-find+AF8-tag().
+AD4 Block layer will return all the 100 commands to the driver but really those
+AD4 100 commands are not outstanding. This patch will return +ACo-actual+ACo
+AD4 outstanding commands.

Would iterating over started requests be a good alternative to the patch
that you had posted? The header above blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter() is as follows
(this function is used by e.g. the skd driver for firmware recovery):

/+ACoAKg
 +ACo blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter - iterate over all started requests in a tag set
 +ACo +AEA-tagset:	Tag set to iterate over.
 +ACo +AEA-fn:		Pointer to the function that will be called for each started
 +ACo		request. +AEA-fn will be called as follows: +AEA-fn(rq, +AEA-priv,
 +ACo		reserved) where rq is a pointer to a request. 'reserved'
 +ACo		indicates whether or not +AEA-rq is a reserved request.
 +ACo +AEA-priv:	Will be passed as second argument to +AEA-fn.
 +ACo-/

+AD4 I am not able to find right context from srp, but I check the srp code and
+AD4 looks like that driver is getting scmd using scsi+AF8-host+AF8-find+AF8-tag() for live
+AD4 command.

Sorry, my e-mail was a bit too short to be comprehensible. When running
sg+AF8-reset -d /dev/sd... in a loop it is possible that the SCSI reset handler
terminates a request while the SRP driver is handling a request completion
for one of the terminated requests. That is why both srp+AF8-process+AF8-srp() and
the reset handler call srp+AF8-claim+AF8-req() to make sure that only one of these
two contexts completes a request.

Bart.
