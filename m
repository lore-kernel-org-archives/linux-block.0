Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDBFC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A549A20675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfAPX4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:56:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32825 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfAPX4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:56:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so3556843pgu.0;
        Wed, 16 Jan 2019 15:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bOz8YlXJ8FLcF1hxh1wajCkXrSrJ+pb9Qicthv3D1s=;
        b=BKjd/JwSoXRjpS0v9tcEFaKTXSj8VLs/97MAtcf5ABhjGfChJuYZ52whtEhcutUfJM
         bTcNeKPHTaW/f9RjcbLSRGi55X4Jn4LwvxGbD/FT3n+AVPaRYnDWyJXxujP/nY9E+ci9
         vZylvkF2UQB+jz652L79Fk/oImP8Eyz7AQ1p5HZoOFsgolkWyImYjbQJ1cKonOBl4XBH
         mRvQMYFQ9hIhXeg338CXTKJRI/gw5C8UWR5mOzm0fT5iHeR5X8S7JLiT6ttFagevFmB7
         LupxZySpFruqU34xsKZTUcSfeU5D8qYcLUXNqxFaGle8EsBtDoTbi5eVFO5YrG8yoj7I
         JM4Q==
X-Gm-Message-State: AJcUukcyelkUiCr7npe8DGf/KaeHPJhIaoNO9VRB/H5KldrN2fk6jCiF
        xaGeHfzx9jfFe7iXIvvz4xo=
X-Google-Smtp-Source: ALg8bN4ABiBxGFqmruaBZegi5y8N3+pDK5ojSejzoUOT0caf1OKEQ7k/Tmuqh9Jho/86k6pefs32xw==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr12815406pfc.135.1547682982563;
        Wed, 16 Jan 2019 15:56:22 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u70sm9828242pfa.176.2019.01.16.15.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 15:56:21 -0800 (PST)
Message-ID: <1547682979.83374.126.camel@acm.org>
Subject: Re: [PATCH fix] scsi_lib: make sure scsi_request.sense valid
From:   Bart Van Assche <bvanassche@acm.org>
To:     Douglas Gilbert <dgilbert@interlog.com>, hch@infradead.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
Date:   Wed, 16 Jan 2019 15:56:19 -0800
In-Reply-To: <20190116155700.28967-1-dgilbert@interlog.com>
References: <20190116155700.28967-1-dgilbert@interlog.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-01-16 at 10:57 -0500, Douglas Gilbert wrote:
+AD4 The block layer assumes scsi+AF8-request:sense is always a valid
+AD4 pointer. This is set up once in scsi+AF8-mq+AF8-init+AF8-request() and the
+AD4 containing scsi+AF8-cmnd object is used often, being re-initialized
+AD4 by scsi+AF8-init+AF8-command(). That works unless some code re-purposes
+AD4 part of the scsi+AF8-cmnd object for something else. And that is
+AD4 what bidi handling does in scsi+AF8-mq+AF8-prep+AF8-fn(). The result is an
+AD4 oops at some later time when the partly overwritten object is
+AD4 re-used. The overwrite is from d285203cf647d but 'git blame'
+AD4 does not show removed code, so that commit may not be the
+AD4 culprit.
+AD4 
+AD4 Signed-off-by: Douglas Gilbert +ADw-dgilbert+AEA-interlog.com+AD4
+AD4 ---
+AD4 
+AD4 This was found while injecting errors (thus generating sense data)
+AD4 into a sequence of bidi commands. At some later time the block
+AD4 layer blew up with a scsi+AF8-request::sense NULL dereference in
+AD4 sg+AF8-rq+AF8-end+AF8-io(). Without testing I'm confident the bsg driver,
+AD4 the osd ULD and exofs are exposed to this bug.
+AD4 
+AD4  drivers/scsi/scsi+AF8-lib.c +AHw 1 +-
+AD4  1 file changed, 1 insertion(+-)
+AD4 
+AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 index b13cc9288ba0..71259bd4040a 100644
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -1175,6 +-1175,7 +AEAAQA void scsi+AF8-init+AF8-command(struct scsi+AF8-device +ACo-dev, struct scsi+AF8-cmnd +ACo-cmd)
+AD4  
+AD4  	cmd-+AD4-device +AD0 dev+ADs
+AD4  	cmd-+AD4-sense+AF8-buffer +AD0 buf+ADs
+AD4 +-	cmd-+AD4-req.sense +AD0 buf+ADs
+AD4  	cmd-+AD4-prot+AF8-sdb +AD0 prot+ADs
+AD4  	cmd-+AD4-flags +AD0 flags+ADs
+AD4  	INIT+AF8-DELAYED+AF8-WORK(+ACY-cmd-+AD4-abort+AF8-work, scmd+AF8-eh+AF8-abort+AF8-handler)+ADs

Hi Doug,

The description of this patch does not look correct to me. scsi+AF8-init+AF8-command()
does not overwrite the sense pointer. From the body of that function:

	/+ACo zero out the cmd, except for the embedded scsi+AF8-request +ACo-/
	memset((char +ACo)cmd +- sizeof(cmd-+AD4-req), 0,
		sizeof(+ACo-cmd) - sizeof(cmd-+AD4-req) +- dev-+AD4-host-+AD4-hostt-+AD4-cmd+AF8-size)+ADs

It is not clear to me which code overwrites the sense pointer. I think that
needs to be figured out before discussion of this patch can continue.

Thanks,

Bart.
