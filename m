Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A6C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFD120848
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 07:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxl4luaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFD120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLCHpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:45:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53512 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLCHpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 02:45:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so4588740wmi.3
        for <linux-block@vger.kernel.org>; Sun, 02 Dec 2018 23:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNVkd13TImWK9c1N5Yyde6Y6ASFU3LTV6AkmuzU/OfY=;
        b=Oxl4luaYiISBhBLZOSpF1R6D9VE4SVwtiE/fvgeuTg3F5IFYUlE/u5nf3fXoLNLuVp
         LTW/MqW4EAA2YAJ9PC0QoAuMEpZhzlx5gdqffY1e3TuN3s4ZmItxAd8BT9F93MjZw7QX
         FiqOpKxgvcZFBUA1JjbgNatZyhwN6YV5vASbsixVpePYwSuE4lTTgJcxWIdBSXY+bTHT
         2BztP/OVK36LwTdP0fPI9sGvZr65SqeIHBb2WDjjZIwZlsltW6rREF+25Lbg1fzpwjVG
         0G+SRNolh1PaeF5ibyiorjZ1eyBgNN13sQBvHseWx1tf92sGKvZ7UzSwB12LUF1806YK
         Q2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNVkd13TImWK9c1N5Yyde6Y6ASFU3LTV6AkmuzU/OfY=;
        b=nB6p2v5dxZWmXjGEFchX972Ykch3++IE1WESNbxKFW86dNAEJ5XCheDmMHyTa8G/FP
         IY2CKftXKeFApctkrDVTD4iFBBl/FxoLbkI4U8kmiQj7aY3T1NQeLwyW/ZfKnfv8PQld
         JKjvQ2hJ3R8wvflHtHDNRXi1ex4JHZngKRYzcyEihBQhlxN/mIdvYVaSFVWV5Qou0N8h
         pwhMIEYzWF0dSaMZRTJ83RXiqxNwG7Ra5TNmGeywiB2WuYhezf79FyThfT2jT5Q4+UFG
         IYe0FYeDYAtm4Q74WHOUbAH57StRY63YVGYliDObwbGEHl69nXozOTRhUdOCfQwdgsCY
         Z7Lw==
X-Gm-Message-State: AA+aEWamCQmTc9B6y6pTY6MA5SChsdIweZtZBFH+Hfxjzo6NX4Ie5DSv
        7YtCdbtHuLSSvIgq1IPs1CKLRJk4h9UL/Au6p20=
X-Google-Smtp-Source: AFSGD/XQXL0qHzId8iLDzFAz078i2lSaw7I9KjA3rnI1CCvGPUllyBVAmJCa71ezB8cEiYqp6YhOkxUXYX6d84jrIPI=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr6801233wml.61.1543823100906;
 Sun, 02 Dec 2018 23:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20181130202635.11145-1-keith.busch@intel.com> <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
In-Reply-To: <20181201164804.GB19557@lst.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 3 Dec 2018 15:44:48 +0800
Message-ID: <CACVXFVMv1yT44=rGwyXxY+GKGLCzVH8-+A11wBTQMcaZOq5K9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 2, 2018 at 12:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Nov 30, 2018 at 01:36:09PM -0700, Jens Axboe wrote:
> > On 11/30/18 1:26 PM, Keith Busch wrote:
> > > A driver may wish to iterate every tagged request, not just ones that
> > > satisfy blk_mq_request_started(). The intended use is so a driver may
> > > terminate entered requests on quiesced queues.
> >
> > How about we just move the started check into the handler passed in for
> > those that care about it? Much saner to make the interface iterate
> > everything, and leave whatever state check to the callback.
>
> So we used to do that, and I changed it back in May to test for
> MQ_RQ_IN_FLIGHT, and then Ming changed it to check
> blk_mq_request_started.  So this is clearly a minefield of sorts..

The change to blk_mq_request_started() is for just fixing SCSI's boot
hang issue.

>
> Note that at least mtip32xx, nbd, skd and the various nvme transports
> want to use the function to terminate all requests in the error
> path, and it would be great to have one single understood, documented
> and debugged helper for that in the core, so this is a vote for moving
> more of the logic in your second helper into the core code.  skd
> will need actually use ->complete to release resources for that, though
> and mtip plays some odd abort bits.  If it weren't for the interesting
> abort behavior in nvme-fc that means we could even unexport the
> low-level interface.

Agree, and especially SCSI's use should be understood given
SCSI is so widely deployed in product system.

thanks,
Ming Lei
