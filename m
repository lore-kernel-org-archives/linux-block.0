Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3991C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB922084C
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9XZtRBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDCDlj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:41:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32975 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDli (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 23:41:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so19290135wrp.0;
        Tue, 02 Apr 2019 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaSiMHEWzq5YcNB0Dy8OixgROMdy1CiI/WJgS5uPIno=;
        b=V9XZtRBT/7TD1m2Z5RZrZmr8h8bjuPWizb+W8i3dr1AhR956ArdF5/DX9dAHOVDH4h
         cCuF1cWBGDSaEjnVfa/Yxxr8PqnK3oBoOD4X0jzqcEDv0y2cjwzWnZQQkpQASYCDcGaf
         qrUTp2bWSwaUse8IRyz/pKHl2mNREZw5YS9tuT89lzUgZC3L45OBGXZ0DZueUqGnZdiF
         EGVwEk3vCKTOR9yhBBu6FFRTn96Bfkr2SrMh0i9FR/r/dzSW5Tzm31t7esUVv0ZHZr/h
         R/Febdt1MFQCPbsV+jQXkxHQb+ZSJwcACzUkKh8B6pyp0F1fncmRwqIXBk0YN5COoCjv
         ITMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaSiMHEWzq5YcNB0Dy8OixgROMdy1CiI/WJgS5uPIno=;
        b=NowVlOctnxWyrzKZkObKPpMg0Qklbcb1qRUvXI7SE0YZBj6dEA9JVlgF0tRpKMVl3m
         aj1Xe2NPAuWtAtcuS5qV+X0AmedcAPpCELDOhI7Yu0XBFS2Fd4o4HrsJJUdzOIAADcyN
         ey3RD3vnD7+LIVJxb3Qjs6IK3QSvaqvCpSbA9UKIsZRGb1D9Dr1Ezq8Xizm6IzMQ/5b2
         ZFNIPLwxuWTbowFpCJzJiG9dE8GN5q1ZHFXA8Sp2WcxZZprkhSm5Tetxf2ITp/W2jZ0m
         M6VLOIA9fo16RabI5HbFhCIwomlJUmluuK5yEveORTlpXXX8GmqozcZZrZbJjVVWLQxF
         Qiew==
X-Gm-Message-State: APjAAAXsRGdzG/IHsUIogHngWAnNMNmMmFepE4bnZdsQ8joHnnhX7XUH
        HWFRYfMz8CUPuQJADfF3GEm6BTmkPHisLvXiD5E=
X-Google-Smtp-Source: APXvYqykn37wDjoTo+uoyWpzPXfWZd6bulH8ntp8yR8OnwySsfVqaskWWEpI9x5u7gTTpLR5scJPwgMWMdnWlartXWY=
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr44708409wrn.90.1554262896967;
 Tue, 02 Apr 2019 20:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190402114800.2281-1-ming.lei@redhat.com> <1554220294.118779.142.camel@acm.org>
In-Reply-To: <1554220294.118779.142.camel@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 3 Apr 2019 11:41:24 +0800
Message-ID: <CACVXFVPnMW_2EXQd0Uj5GxSR3aVcW6yrXGghf0By+uSnQ8oG+g@mail.gmail.com>
Subject: Re: [PATCH] SCSI: don't hold device refcount in IO path
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        jianchao wang <jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 3, 2019 at 12:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2019-04-02 at 19:48 +0800, Ming Lei wrote:
> > scsi_device's refcount is always grabed in IO path.
>                                    ^^^^^^
>                                    grabbed?
>
> > Turns out it isn't necessary, becasue blk_queue_cleanup() will
> > drain any in-flight IOs, then cancel timeout/requeue work, and
> > SCSI's requeue_work is canceled too in __scsi_remove_device().
> >
> > Also scsi_device won't go away until blk_cleanup_queue() is done.
> >
> > So don't hold the refcount in IO path.
>
> Holding the device reference count was definitely necessary in the past.
> You may want to reflect this in the patch description by mentioning that
> grabbing that reference count is no longer required today because the
> draining mechanism now waits for requeuing to occur. I don't think that
> was the case for the legacy block layer.

You must forget we have switched to blk_queue_enter() for legacy block
layer for a while, :-)


Thanks,
Ming Lei
