Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5B1C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCTVGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCTVGT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 17:06:19 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E43713515
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 14:06:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hf2so10707653qtb.3
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679346377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eYCDRHWojVMYeBPPf1Hm9ltYgVu+GxNJ7qAz+2Cxxs=;
        b=QhXhJMsYBmUPEVywAbg/+bsQkVgavetmZXMCJTcMfqMG8WJFDf108Zio8x3lDc8c8T
         eX9ff+/oioWoF3QX2QcXTmTlsJUlkytA/DxwcWQ0RjKv+Sw1r2BFmC907tqYmuwty5TQ
         t+hreelbWoUtz8mPL8DR+iFhkfmPAds1B8FDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679346377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eYCDRHWojVMYeBPPf1Hm9ltYgVu+GxNJ7qAz+2Cxxs=;
        b=DsvrYzecCHTDApC8fcqnCg9siKdwYbVqZzNPR0XM8EhYF72n1JRQeVLCkB+UbFJwfO
         MDhDfI8NMCjih/gB1jf+A3/JABa7Cdm0QBcvOIhscO94DygXhaJJ9XZ806Tz6URvFUql
         uyhmEwdaFIkzkzsr6VZ8VEsrMtIAN/m56pTsjO9zUS2jPm1/URAQuD5mCpdMGHahAuSo
         FA/meQJaddm9Dx1KkXjr0VRX2HIrQh1JE3zN5Pr4BZzicxpQoXay4kdqnecurND/sNs/
         PCdDRUZBK+1gGw6n8xizsksKVC+bK3T00n5TFqYDsaD+wOXb1eeEikyTb3jn4HOhLfJq
         OsPQ==
X-Gm-Message-State: AO0yUKUiRLpFvQNwoP+lLhJ0bWYdW4Fjql1HuEK7GeBVuI611gYZouRW
        HLVeqejDB3gxPCW+jhTgqeBwIUsk0POFy+iJSt8=
X-Google-Smtp-Source: AK7set9OBmhwqKw1y1rJCHvOMx/ca604Z/actLqGZbSr9Aee6K6zwsuS4IMPT8at7aW92CcpxOWTLA==
X-Received: by 2002:a05:622a:180f:b0:3bf:cfe8:f8f5 with SMTP id t15-20020a05622a180f00b003bfcfe8f8f5mr1078835qtc.41.1679346377032;
        Mon, 20 Mar 2023 14:06:17 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id i4-20020a378604000000b0073b3316bbd0sm8071592qkd.29.2023.03.20.14.06.15
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 14:06:16 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id x8so8473730qvr.9
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 14:06:15 -0700 (PDT)
X-Received: by 2002:ad4:4f07:0:b0:5a8:6ec7:b5ef with SMTP id
 fb7-20020ad44f07000000b005a86ec7b5efmr57413qvb.9.1679346375387; Mon, 20 Mar
 2023 14:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230318062909.GB24880@lst.de>
 <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
In-Reply-To: <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 20 Mar 2023 14:06:04 -0700
X-Gmail-Original-Message-ID: <CACGdZY+1_JDi850si0fJfnXrCh2TzfHNEsi+7BWP8V4GrfYMvw@mail.gmail.com>
Message-ID: <CACGdZY+1_JDi850si0fJfnXrCh2TzfHNEsi+7BWP8V4GrfYMvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 10:28=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 3/17/23 23:29, Christoph Hellwig wrote:
> > On Fri, Mar 17, 2023 at 12:59:36PM -0700, Bart Van Assche wrote:
> >> For zoned storage it is essential that split bios are submitted in LBA=
 order.
> >> This patch series realizes this by modifying __bio_split_to_limits() s=
uch that
> >> it submits the first bio fragment and returns the remainder instead of
> >> submitting the remainder and returning the first bio fragment. Please =
consider
> >> this patch series for the next merge window.
> >
> > Why are you sending large writes using REQ_OP_WRITE and not
> > using REQ_OP_ZONE_APPEND which side steps all these issues?
>
> Hi Christoph,
>
> How to achieve optimal performance with REQ_OP_ZONE_APPEND for SCSI
> devices? My understanding of how REQ_OP_ZONE_APPEND works for SCSI
> devices is as follows:
> * ATA devices cannot support this operation directly because there are
>    not enough bits in the ATA sense data to report where appended data
>    has been written.
> * T10 has not yet started with standardizing a zone append operation.
> * The code that emulates REQ_OP_ZONE_APPEND for SCSI devices (in
>    sd_zbc.c) serializes REQ_OP_ZONE_APPEND operations (QD=3D1).
> * To achieve optimal performance, QD > 1 is required.
I recall there were dragons lurking particularly with how we handle
requeues wherein just submitting in order was not sufficient to
guarantee IO is actually dispatched in order. (of note: when
requeueing a request, we splice it to the _end_ of the hctx dispatch
list, so if you get a requeue in the middle of a multi-segment IO, it
will get re-ordered. I recall this change went in specifically to
re-order requests in case there was a passthrough lurking to un-jam a
device.) Have you looked at this? Perhaps requeues are slowpath
anyways, so we could sort there? There may also be other requeue
weirdness with layered devices...

Khazhy
