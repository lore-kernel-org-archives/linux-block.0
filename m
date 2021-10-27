Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AA8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE99C60F0F
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhJ0CVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237219AbhJ0CVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 22:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UBzGUnOUEFcF6KLWEluzYL4mLQjg1E6PUhcyyR60VNU=;
        b=LgbfryfvZOqSCkQMBo51PXs6RWcvXcb8i1+EAFiH2iZW3Kz/UqVuo89cGL8I/EfF5WZZm1
        C3K2bJigySx5TX7uRFyDNojXtff7lnuecB4eSaIWUnqHnEOrC1wvu8cO/xg96FFy6b2TsI
        NhKOTrP6VXyHy9woK6Ymqvuy0Gifyl8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-PDT9hNZOPuaUnc_A5go0Vw-1; Tue, 26 Oct 2021 22:18:40 -0400
X-MC-Unique: PDT9hNZOPuaUnc_A5go0Vw-1
Received: by mail-lf1-f71.google.com with SMTP id k15-20020a05651239cf00b003fe1ba9c94cso642876lfu.6
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 19:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBzGUnOUEFcF6KLWEluzYL4mLQjg1E6PUhcyyR60VNU=;
        b=x641jry8UDhs7aFYlYS9V5jTwcOUa99Dq3o8ObilRBQ+c+8HAXjLlUR1ee8IOvOaoh
         RYqXbJy+j8TsFLt/VoM0f++QwbRc9hBH5sHgIGy0rvuHU0eucr9udJSVzn2wKKK2cTWN
         9AzX+fWXtihkFS+WJXk4hgPN6I7k+E/LDeG5NTSl5/TUoPGqujWbC7uShgmYKRxIYBjz
         CZAznqT99ijVGPOZQ9R8niKyN0liZaNXOc7y0ZRwjC4C82njdKAt79+30Seq4kqTncmq
         bVMM+dU06Jbbiyn+9Ytvdc/606cAMBsvze0gAuujmqCfuRHWJX4Ktb6X6W1q08eIbpBj
         sLHA==
X-Gm-Message-State: AOAM530ur6bJWD73d3StSSEclY94nAPspL7/vpzuvWEisUF86Fywo0Rq
        SGV4iVcUmoD8ubUz0QNSrblM+3f7XszmltdtIJQ0d35VdP7wlVa08t1KzPdrNQX018q+58gWHiM
        iyD8WAvaWvoilLU6oGLg6htQsP/kG1utiJnEQH78=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr29943462ljg.448.1635301118975;
        Tue, 26 Oct 2021 19:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+WkJqJ7pHPSdrcPy5Ze4mNvUI2dJhewRaerkMzgGNgWAOUKSx17NXREubDi/lXrB/ymdEoifp1TYQO2vnjlk=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr29943446ljg.448.1635301118723;
 Tue, 26 Oct 2021 19:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210806142914.70556-1-pkalever@redhat.com> <20210806142914.70556-2-pkalever@redhat.com>
 <YUL+1PE1z5aM0eTM@T590>
In-Reply-To: <YUL+1PE1z5aM0eTM@T590>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Wed, 27 Oct 2021 07:48:27 +0530
Message-ID: <CANwsLLEgHhrh7uh+awJp-qs8xxxpwQBc6fMkEys3VMU4anvWZg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] block: cleanup: define default command timeout and
 use it
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     Ilya Dryomov <idryomov@redhat.com>, Xiubo Li <xiubli@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 1:52 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Aug 06, 2021 at 07:59:13PM +0530, pkalever@redhat.com wrote:
> > From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> >
> > defined BLK_DEFAULT_CMD_TIMEOUT and reuse it everywhere else.
> >
> > Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > ---
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks for the review Ming.

Attempting to bring this to the top again for more reviews/acks.


BRs,
--
Prasanna

>
> --
> Ming
>

