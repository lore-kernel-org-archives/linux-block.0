Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DAFC5ACD3
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21A320896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfARRvV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:51:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34642 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfARRvU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 12:51:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so6405613pga.1;
        Fri, 18 Jan 2019 09:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+KBIDAjn8vxI6NJ+u1RNmCxFTjp8V5zaRS8W+Mpne8=;
        b=EIgkPI9vvAfesaSpEVRMu16v2ddm+IMmCthpYTDjC9XLxJh/YB5CmKTUyTfTs+69G2
         w1/0nyJHPNp58dfVXJtIm6hKvsEKLt8pmeJqjSemG2AaOe8warOk1GK54xeBqPWdhoMt
         uHs8WwyWLSJWw62ewXhIqQwGFDDZpvaxFjpIp3RJAC+CbUjU/llsDFWYRXi7roO9IgrB
         fWyF3v7tB3V2yyNkYhDAYzlSIX0amh4QBJUpbba1rgQoiNdJJcojOzSQxcCAJgMbOS93
         gPf8EEWV1U70odGefRDgT/FxxzqPA8989G9Fl6a2q1ermv5Ekr9iA6Jw/kM+errxYqJl
         PFwg==
X-Gm-Message-State: AJcUukc9yLbHs7MNqyXhZzJTl4B/kaPNuieB9m9nqJnOwq2exr1n6SEY
        Wik3OeQRVhqBV0Lr0wuSNfA=
X-Google-Smtp-Source: ALg8bN5xWPCDf0Zer1YWX2agmR53PhI+vVeUozgZcdWZwCIUOni0FxDl2OGjXl0u9hQEddUws8AFTw==
X-Received: by 2002:a62:4851:: with SMTP id v78mr20398211pfa.97.1547833879138;
        Fri, 18 Jan 2019 09:51:19 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id k15sm9104288pfb.147.2019.01.18.09.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:51:18 -0800 (PST)
Message-ID: <1547833876.102272.0.camel@acm.org>
Subject: Re: dd hangs when reading large partitions
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
Date:   Fri, 18 Jan 2019 09:51:16 -0800
In-Reply-To: <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
         <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
         <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-01-18 at 10:48 -0700, Jens Axboe wrote:
+AD4 It's UFS that totally buggy, if you look at its queuecommand, it does:
+AD4 
+AD4         if (+ACE-down+AF8-read+AF8-trylock(+ACY-hba-+AD4-clk+AF8-scaling+AF8-lock))                         
+AD4                 return SCSI+AF8-MLQUEUE+AF8-HOST+AF8-BUSY+ADs
+AD4 
+AD4 UFS either needs to get fixed up, or we'll want a way to do something like
+AD4 the below.
+AD4 
+AD4 Marc, can you test this?
+AD4 
+AD4 
+AD4 diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
+AD4 index eaf329db3973..e28c3420a9d9 100644
+AD4 --- a/drivers/scsi/hosts.c
+AD4 +-+-+- b/drivers/scsi/hosts.c
+AD4 +AEAAQA -412,6 +-412,7 +AEAAQA struct Scsi+AF8-Host +ACo-scsi+AF8-host+AF8-alloc(struct scsi+AF8-host+AF8-template +ACo-sht, int privsize)
+AD4  	shost-+AD4-hostt +AD0 sht+ADs
+AD4  	shost-+AD4-this+AF8-id +AD0 sht-+AD4-this+AF8-id+ADs
+AD4  	shost-+AD4-can+AF8-queue +AD0 sht-+AD4-can+AF8-queue+ADs
+AD4 +-	shost-+AD4-queue+AF8-may+AF8-block +AD0 sht-+AD4-queue+AF8-may+AF8-block+ADs
+AD4  	shost-+AD4-sg+AF8-tablesize +AD0 sht-+AD4-sg+AF8-tablesize+ADs
+AD4  	shost-+AD4-sg+AF8-prot+AF8-tablesize +AD0 sht-+AD4-sg+AF8-prot+AF8-tablesize+ADs
+AD4  	shost-+AD4-cmd+AF8-per+AF8-lun +AD0 sht-+AD4-cmd+AF8-per+AF8-lun+ADs
+AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 index b13cc9288ba0..4e266af2871f 100644
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -1902,6 +-1902,8 +AEAAQA int scsi+AF8-mq+AF8-setup+AF8-tags(struct Scsi+AF8-Host +ACo-shost)
+AD4  	shost-+AD4-tag+AF8-set.flags +AD0 BLK+AF8-MQ+AF8-F+AF8-SHOULD+AF8-MERGE +AHw BLK+AF8-MQ+AF8-F+AF8-SG+AF8-MERGE+ADs
+AD4  	shost-+AD4-tag+AF8-set.flags +AHwAPQ
+AD4  		BLK+AF8-ALLOC+AF8-POLICY+AF8-TO+AF8-MQ+AF8-FLAG(shost-+AD4-hostt-+AD4-tag+AF8-alloc+AF8-policy)+ADs
+AD4 +-	if (shost-+AD4-queue+AF8-may+AF8-blocK)
+AD4 +-		shost-+AD4-tag+AF8-set.flags +AHwAPQ BLK+AF8-MQ+AF8-F+AF8-BLOCKING+ADs
+AD4  	shost-+AD4-tag+AF8-set.driver+AF8-data +AD0 shost+ADs
+AD4  
+AD4  	return blk+AF8-mq+AF8-alloc+AF8-tag+AF8-set(+ACY-shost-+AD4-tag+AF8-set)+ADs
+AD4 diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
+AD4 index 9ba7671b84f8..9ab354e43630 100644
+AD4 --- a/drivers/scsi/ufs/ufshcd.c
+AD4 +-+-+- b/drivers/scsi/ufs/ufshcd.c
+AD4 +AEAAQA -6981,6 +-6981,7 +AEAAQA static struct scsi+AF8-host+AF8-template ufshcd+AF8-driver+AF8-template +AD0 +AHs
+AD4  	.sg+AF8-tablesize		+AD0 SG+AF8-ALL,
+AD4  	.cmd+AF8-per+AF8-lun		+AD0 UFSHCD+AF8-CMD+AF8-PER+AF8-LUN,
+AD4  	.can+AF8-queue		+AD0 UFSHCD+AF8-CAN+AF8-QUEUE,
+AD4 +-	.queue+AF8-may+AF8-block	+AD0 1,
+AD4  	.max+AF8-host+AF8-blocked	+AD0 1,
+AD4  	.track+AF8-queue+AF8-depth	+AD0 1,
+AD4  	.sdev+AF8-groups		+AD0 ufshcd+AF8-driver+AF8-groups,
+AD4 diff --git a/include/scsi/scsi+AF8-host.h b/include/scsi/scsi+AF8-host.h
+AD4 index 6ca954e9f752..30aa7b6c4342 100644
+AD4 --- a/include/scsi/scsi+AF8-host.h
+AD4 +-+-+- b/include/scsi/scsi+AF8-host.h
+AD4 +AEAAQA -339,6 +-339,11 +AEAAQA struct scsi+AF8-host+AF8-template +AHs
+AD4  	 +ACo-/
+AD4  	int can+AF8-queue+ADs
+AD4  
+AD4 +-	/+ACo
+AD4 +-	 +ACo If the -+AD4-queuecommand() ever blocks, this should be set
+AD4 +-	 +ACo-/
+AD4 +-	int queue+AF8-may+AF8-block+ADs
+AD4 +-
+AD4  	/+ACo
+AD4  	 +ACo In many instances, especially where disconnect / reconnect are
+AD4  	 +ACo supported, our host also has an ID on the SCSI bus.  If this is
+AD4 +AEAAQA -584,6 +-589,7 +AEAAQA struct Scsi+AF8-Host +AHs
+AD4  
+AD4  	int this+AF8-id+ADs
+AD4  	int can+AF8-queue+ADs
+AD4 +-	int queue+AF8-may+AF8-block+ADs
+AD4  	short cmd+AF8-per+AF8-lun+ADs
+AD4  	short unsigned int sg+AF8-tablesize+ADs
+AD4  	short unsigned int sg+AF8-prot+AF8-tablesize+ADs

Hi Jens,

Did you perhaps want to include a change from down+AF8-read+AF8-trylock() into
down+AF8-read() in the UFS queuecommand function in this patch?

Thanks,

Bart.
