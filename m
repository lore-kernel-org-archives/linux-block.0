Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2EFC4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 05:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B6961212
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 05:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhHYGAV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233184AbhHYGAT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 02:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629871174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hZq8ux83RWRAGT7dU7S94nIBykQroT633MHGxDAPovQ=;
        b=a91Zf2iAt/CNyQpw44Nx1QIWEk5odZ5GYQ1s8jK5JMmka94/yqBsfRvuIZ9yW7HmgWp+Xa
        rhBt4bvyjLBxRVK4cC2vrUTGocWCksRpeQqhq4zWj8g87U/YojRHNtyDA5cYOsKxu/4ttU
        CfUFo7EOEWNrRRYSeMg555TuWs/e2Gc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-BfqCIKyQN_-pt2uE7dTjKA-1; Wed, 25 Aug 2021 01:59:32 -0400
X-MC-Unique: BfqCIKyQN_-pt2uE7dTjKA-1
Received: by mail-yb1-f198.google.com with SMTP id v126-20020a254884000000b005991fd2f912so9869110yba.20
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 22:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZq8ux83RWRAGT7dU7S94nIBykQroT633MHGxDAPovQ=;
        b=tm7lwc6GKW8e66BoW7utGXGDW4JgvpeYhFX5O5MVGAsGVLEYNDmw+2iGvTWAIIays5
         DH7/HuDwMRM9cR8dERUhYpiX6CT08OZhk0sR8TEdXj3fUwaGaWYXMyAQ5f2vQ8Vm2wjy
         ymSf0hhqy6PhdqoY9EIoJ6B4ExyT3csHFhm7ajITpgqfJq1Qr4j+rqB3dbYPSw/nrZMY
         vX5EESiTZzqEbCfncVjsOGNyzd4roGvYQlBZ6YGYvhIwhHOcL1eYGDIAsoJNiTLVkkOF
         UnTHC3zZtcgTmGOeQi4MX2jF2aZ1rLUfUKanGICd409gLAMhrPOaR6bZz5aNyjVsE3KD
         PSRA==
X-Gm-Message-State: AOAM532phrFvw6rxOf0P/3H6+MJVNUd7HglfEKSHycE2cRb2092eWJtM
        Ealw5XtdKxrNNn/giulQ3yDzVXyQI0nx3Sj3IquFKjn6Zr4V8QAaRvnj8MeakLhOx0ImRzfxNhO
        5eQX6PAHdny5Ouci15r6FS1jrw3lNwO/Zm7NMVCM=
X-Received: by 2002:a25:cb11:: with SMTP id b17mr17075073ybg.438.1629871172167;
        Tue, 24 Aug 2021 22:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU6u2ecWhLicWmFg6FwEcsOJ/sHApqkz1nmY/9nb65gcMxPrdb8Dmgi6eXH0NLTjyMcu4XKdYt5m2iVC1FVJ0=
X-Received: by 2002:a25:cb11:: with SMTP id b17mr17075057ybg.438.1629871171995;
 Tue, 24 Aug 2021 22:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000072e53a05c983ab22@google.com> <20210816091041.3313-1-hdanton@sina.com>
 <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com>
 <20210819090510.GA12194@lst.de> <yt9dr1eph96a.fsf@linux.ibm.com>
 <20210819135308.GB3395@lst.de> <CAHj4cs-S7sTEMZ=zSreW5_PgQQVxvf-4netHy-paPR2kfY=-hQ@mail.gmail.com>
 <20210824072340.GA25108@lst.de>
In-Reply-To: <20210824072340.GA25108@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 25 Aug 2021 13:59:19 +0800
Message-ID: <CAHj4cs_Q=sL640Yb7C3=r-d4zfAPsfYT+xY5iGxd6vbyHczb2Q@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in wb_timer_fn
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 24, 2021 at 3:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Aug 21, 2021 at 03:48:01PM +0800, Yi Zhang wrote:
> > I also met similar issue with blktests, I tried to apply the patchset
> > but with no luck to apply them, any suggestions to fix it.
>
> Please just retests the latest for-5.15/block or for-next branch in
> Jens' tree.
>
Yeah, the issue was fixed with for-5.15/block

-- 
Best Regards,
  Yi Zhang

