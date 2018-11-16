Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2FBC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846852145D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="opcawud9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846852145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeKPS6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:58:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32937 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPS6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:58:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so7676199pgu.0
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uPq/OPbKPVGDg0gtLr+03FhuT1UBa0pOgr8PMRFL2H0=;
        b=opcawud9vU/F8nFNJZeI58AjH2Fyj+59Kvuh7gCsP/e8fVvTRmiKoeyJyKpxREusFo
         Zy/99NNvIUqDp0UF6dz4Dem1MOyLdTFFi6HpkdYP33gKHGBAhj3UzkSUFyZIPgH6Ua+j
         812UIRaKvRqTCIcMN4upQA/ZesXUq/WdKdZonbVDDyc6mTXJ6poJWmUiLl7PO7uG2KUu
         cCr95L3RDpkENEe+r13UMQX2SKSqlADeanbcHorlwKfRXavKvqwt4Yza6qlCosuYDCcf
         H9ksfxcB0kDDU8A9w3iYyJTEFjbCv7IFks+U+AdeRAtH8XM/3z6EP+tTy6VgzUiNzjYd
         tPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPq/OPbKPVGDg0gtLr+03FhuT1UBa0pOgr8PMRFL2H0=;
        b=bd4eIiAvvhxnQHQrGnMfDR8fyerv/dLfYimFqmjvoiVXBlAVX41DScqfl59XwvH2KX
         vD+XMRn1lta87mTNOPh23CYbAp/CPCrTmVI4PZv5mb+/zzZOlPijY7ZHpVx/nWVZ1QN3
         ujCg5/nikqVdxbavlR3fHgD1nztKtfm+qZWuG1h/A/MvzvyUSocB6p5b/jK2pkHEbqv/
         8GTxLG4SBcS5EO13r2bd/Wb1yAl2st1Td3CQg7/C25L+Mm07yvMvxJZR8nmXYM6Egj2U
         KfxncqqR1utYltblCabIlIm4yrSa6MNAaP/iN1rHQObkIZgdR2tIUajpr20tp1QYiu9M
         olWQ==
X-Gm-Message-State: AGRZ1gIoBp5/nMY/rNon1SEBEQ/I4JsP9k/q+9Excv9nH6QrQMJPRTsV
        paKqLt0WJv4flWr61O8bSQz6oQ==
X-Google-Smtp-Source: AJdET5dqGUXaWcxXBSzrxSGBGewuPx//JefFQRIQWzNjVtjFPFyc5/X7YfzKojkIYhS7awws9nYtLw==
X-Received: by 2002:a62:9642:: with SMTP id c63-v6mr10500026pfe.100.1542358019743;
        Fri, 16 Nov 2018 00:46:59 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id a18sm33834594pgj.30.2018.11.16.00.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:46:59 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:46:58 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
Message-ID: <20181116084658.GT23828@vader>
References: <20181113214337.20581-1-david@fromorbit.com>
 <10a8dd78-7c00-8593-9f4e-b20eb1161b92@kernel.dk>
 <20181115010651.GD32603@ming.t460p>
 <20181115012201.GX19305@dastard>
 <20181115031035.GE32603@ming.t460p>
 <20181115221337.GY19305@dastard>
 <20181115222419.GV4235@magnolia>
 <20181116040457.GA19305@dastard>
 <20181116083232.GA9023@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116083232.GA9023@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 12:32:33AM -0800, Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 03:04:57PM +1100, Dave Chinner wrote:
> > They don't run on my test machines because they require a modular
> > kernel and I run a monolithic kernel specified externally by the
> > qemu command line on all my test VMs.
> > 
> > generic/349     [not run] scsi_debug module not found
> > generic/350     [not run] scsi_debug module not found
> > generic/351     [not run] scsi_debug module not found
> 
> Same here, btw.  Any test that requires modules is a rather bad idea.

I'll plug my vm.py script that supports running a kernel build with
modules without installing them into the VM (by mounting the modules
over 9p): https://github.com/osandov/osandov-linux#vm-setup
