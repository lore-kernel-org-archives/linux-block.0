Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5533CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C6B2064E
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 14:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCVasasU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbgEMOgU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732972AbgEMOgT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 10:36:19 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B4EC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 07:36:19 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k13so5785415uap.13
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tH7OiVHQGINOryeoa0DxR2I/glBuqpkcK+aILBoCVs=;
        b=hCVasasUYDtK0VYLPOFKvOrYD6Dx1esxfVZX7Mtobf1+rmgUbBuSS5kaFFIHewbCq3
         r/dX/ToUTnhw/qrfUdXcWMpNlPnx29FdnKiU6PPlwy2PSshcTxW6mk5S/MBP2pGvOqav
         p2WxZs4rMflSRHCCbeBGwIMKdkVNqpVMrtWbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tH7OiVHQGINOryeoa0DxR2I/glBuqpkcK+aILBoCVs=;
        b=jzhnPyek66HwMW73/HT+Jqk1Le8yC009lN40qeAEhdUxAA7ByBHvOWHyhAvVMlkaRi
         PAlz3QQMEx708BCxqgKHzEEope0725HpR+Etea7UfLdVX47Yn57Ez3BKCQNA35ClsqQe
         s9V2+ThpqlkeW6vY0+p+npzpxSz5bQX7p0mQAhXZ2b6LHHHY4X7olfb9mOhek6pLw27a
         NEQj+pCR4LQxGMNsSnNO1vIN/tKrykSvCFfk+8Vi0LPzcirGXAC/XfYK7FH4dMnaoZRO
         B4ZZ0LCY5Hf81CGTMkVKj5mlcC7gO15ybcMht2irAM3ivdwLPuyRC09fsZA7AR4UUqb8
         r8Ww==
X-Gm-Message-State: AGi0PuZtyfoB2c3OgkfgOwuzC1jtW8JptZMCIN8lHfBDVo/Txubf4PhZ
        Yi1G83VMN1kbMSF8iwDfo/FArjUdLKw=
X-Google-Smtp-Source: APiQypJ0rIVGISmVz8Oe52yHdAFlcwq4dJAqz2kklN1a1mHv4nN+3eceJmRve68sW/cAesPjULAFAg==
X-Received: by 2002:a9f:3f49:: with SMTP id i9mr21183357uaj.78.1589380576520;
        Wed, 13 May 2020 07:36:16 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id j6sm10289783vkj.55.2020.05.13.07.36.15
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 07:36:15 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id x6so10224774vso.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 07:36:15 -0700 (PDT)
X-Received: by 2002:a67:fc46:: with SMTP id p6mr21646763vsq.169.1589380575233;
 Wed, 13 May 2020 07:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200513095443.2038859-1-ming.lei@redhat.com> <20200513095443.2038859-2-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-2-ming.lei@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 07:36:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xrw2+iGqSZSCOq9RSPtxZ19mFp8bN7pezko-ofFmzKEQ@mail.gmail.com>
Message-ID: <CAD=FV=Xrw2+iGqSZSCOq9RSPtxZ19mFp8bN7pezko-ofFmzKEQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] blk-mq: pass request queue into get/put budget callback
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Wed, May 13, 2020 at 2:55 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> blk-mq budget is abstract from scsi's device queue depth, and it is
> always per-request-queue instead of hctx.
>
> It can be quite absurd to get a budget from one hctx, then dequeue a
> request from scheduler queue, and this request may not belong to this
> hctx, at least for bfq and deadline.
>
> So fix the mess and always pass request queue to get/put budget
> callback.
>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c    |  8 ++++----
>  block/blk-mq.c          |  8 ++++----
>  block/blk-mq.h          | 12 ++++--------
>  drivers/scsi/scsi_lib.c |  8 +++-----
>  include/linux/blk-mq.h  |  4 ++--
>  5 files changed, 17 insertions(+), 23 deletions(-)

Seems sane to me and probably would have helped me understand this
code a little faster in the past.  ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
