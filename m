Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A235C3F6B0
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 15:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbiHRPKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbiHRPK2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 11:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FCBD4F5
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660835426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUULX76OiwNqXhgv8GeiwLzhHZ06NzNoZnvqLZsNeCY=;
        b=De8NT+9mTACVr8eiO9Y5fQb6Nh2obi0gHNT1/rwqlbftcB+KQnVKk284LO92VpQa9eYCmD
        4W7m4ztz+80IQqlixp7iCcQm9aDmkPPdydM8TzavyeudZ8qJcyj9aFIM5Yu67LnKW1dHNx
        S0Wc+lESZKcWofpvxcaudlqq4iSX4uA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-RNUqCrBwO-emRgcKfu2_LA-1; Thu, 18 Aug 2022 11:10:25 -0400
X-MC-Unique: RNUqCrBwO-emRgcKfu2_LA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-3345ad926f2so31256907b3.12
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XUULX76OiwNqXhgv8GeiwLzhHZ06NzNoZnvqLZsNeCY=;
        b=NHWsQFAG3TmYsEN1TRt9cdrtSW3CVCpfAyXFl0a9d62CYj0tZO8ILuDfkFj5tbGjLo
         owkWH6PITRpa/Z0R2WyeJN9bra9GYRd4xZTaz+b6q4Jf/zC/3C6JsHUNbjYHdZCl0lUP
         D1zwJZZaAHC2dLfIXAE5wgCkj4WoyQBKXFEpFc4fBPlq79PQw8RVqXM6araFtVPWrRZG
         5/2nD1zOnb6sB5rwFU1LLr/YLYH2zTSoRELwulkxwv8Z9+MHqg4r9M3QrGYsv06k37GG
         g+lejgQRLc/F0ni4BheIpnEIMMa9ZxlOUYo9wxiTZogQXCdl1apkRFB5scYUKx/cZIJk
         NtFQ==
X-Gm-Message-State: ACgBeo2BZEqoC6gN5OIimNrim2QazXNo0aQwfA639yZUTITs2AKG+wk9
        y14pNYiuyKwm8UUIljKnNrsZtEe7Iob1/pbo36eW/mZsNHizc45jcsH1KSrJphxR1KbPQFkXyPG
        4zQA6UlbCMyj3yTFKCBGM1FGG9vFMrq/KZZ+r5Dw=
X-Received: by 2002:a81:86c2:0:b0:332:a104:f7e4 with SMTP id w185-20020a8186c2000000b00332a104f7e4mr3238167ywf.505.1660835424787;
        Thu, 18 Aug 2022 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR69OHtBUziCmC0IN9+McDoaQN+ei985YjilNjNksbt69AggGTnrOajU0/534Va/bKw++/9Ocx4DaI6fh5BH4gA=
X-Received: by 2002:a81:86c2:0:b0:332:a104:f7e4 with SMTP id
 w185-20020a8186c2000000b00332a104f7e4mr3238114ywf.505.1660835424442; Thu, 18
 Aug 2022 08:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <Yv0A6UhioH3rbi0E@T590> <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590> <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590> <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590> <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com> <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590> <aadeb600-4e3a-4b69-bc17-fd2918c5b061@www.fastmail.com>
In-Reply-To: <aadeb600-4e3a-4b69-bc17-fd2918c5b061@www.fastmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 18 Aug 2022 23:10:13 +0800
Message-ID: <CAFj5m9JGGMOc1k71KbiHWu07Vh5FucOtR_yU35eDAfX_2GL0TQ@mail.gmail.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 18, 2022 at 9:50 PM Chris Murphy <lists@colorremedies.com> wrote:
>
>
>
> On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
>
> >
> > Also please test the following one too:
> >
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 5ee62b95f3e5..d01c64be08e2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx
> > *hctx, struct list_head *list,
> >               if (!needs_restart ||
> >                   (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
> >                       blk_mq_run_hw_queue(hctx, true);
> > -             else if (needs_restart && needs_resource)
> > +             else if (needs_restart && (needs_resource ||
> > +                                     blk_mq_is_shared_tags(hctx->flags)))
> >                       blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> >
> >               blk_mq_update_dispatch_busy(hctx, true);
> >
>
> Should I test both patches at the same time, or separately? On top of v5.17 clean, or with b6e68ee82585 still reverted?

Please test it separately against v5.17.

thanks,

