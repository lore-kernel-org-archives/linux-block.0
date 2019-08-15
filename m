Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F1FC3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1917F20656
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bhktrSAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfHOO5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:57:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36172 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfHOO5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 10:57:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so2503878ljl.3
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPE/R7dk1PRW4fz9vq+RV8lPmiFDXVaOGpxZBaywzos=;
        b=bhktrSAq2ebXuUMlotB3r4hNLUEjLMFMqFzHRJWuSwfrGwo18FrUderietEAXPL+T9
         d/wc7hvHdj6X2uZ3KOFI3MdsNM9sRxthqttD8sH39xh4RllH4Y7BhXmKlznmLujipKKa
         wN4oPfY/UFCb9e1HqEHgTSJRo/y0T7NWp3EunitU/zQyVdSKXLsau5mDr7z3C99T5qQx
         fRbaC9NJnKtq7X/QFcz61tNLw8Km7PFMrhruxFRjsH2DVkQt6mQZvQSAK1n1m8wC8aSK
         zz/ip/EHHSc94JfJRnhOa4RPgG1zKYHM0DZ1GIAP8Sxd4P0m1Fe3hOPJkMEFbevdRGGF
         ridw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPE/R7dk1PRW4fz9vq+RV8lPmiFDXVaOGpxZBaywzos=;
        b=TBtmVxqu6i5bymBj0IYZWHau3kyUdS8DbYxRrfXPk1+H1CdHH6ODzgMMty3X03qFYA
         TBp0tntex9NxX2gHxvcHSuwr9CMevxx+y1WYLxAiiohEf6Cpkd3NOHUZxnF3N9zvTo2/
         veKBY+wpSsr7HM+7Is5JI1E5/fbIJWVKrgpT4rmdjPQEKEv9YyLuX25pb4GWDtHMWWt2
         APeVxAYY7x10Qum+q5TJ8sjAAl5mgpQagexUXNcCCwG8J6RWdEzf2oolZRS5bT8tbMee
         JEB5GB2lCSFPj3PA+EcxbOFg93KT8JfWkVtHCE28qETt2qtfyKz9esONF899/8jwhb0S
         JaUA==
X-Gm-Message-State: APjAAAVmW5q+bzkq2NPGhAxCfZHKRJ68J9OHRaG74yRr5a5S+fefQIYC
        7uEK84AA41i0VP3dPGzNII7wyaUQ9CMcKhlQWxeZOQ==
X-Google-Smtp-Source: APXvYqx8kBH1+wRLS/yGdm+aRT258MQm7az0BIAH5tA8X8DE1Rya7NvYSJ/zmx1zxfnJVVhU6dpgv2yrSpICirgs/ps=
X-Received: by 2002:a2e:860d:: with SMTP id a13mr2918768lji.215.1565881058066;
 Thu, 15 Aug 2019 07:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
 <CAB0TPYHdaOTUKf5ix-oU7cXsV12ZW6YDYBsG+VKr6zk=RCW2NA@mail.gmail.com> <20190814114646.GA14561@ming.t460p>
In-Reply-To: <20190814114646.GA14561@ming.t460p>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 15 Aug 2019 15:57:27 +0100
Message-ID: <CAB0TPYGc8H1pJZrDX1r5wO1gyYV9rzgi3acT9mp-vxxrdA-pyA@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 14, 2019 at 12:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> blk_queue_init_done() is only called in blk_queue_init_done() for
> this purpose, so this approach should be fine, IMO.

I was thinking somebody might add more stuff to "init" in the future,
and then that new stuff would now no longer be executed for the loop
driver. The name "init" is pretty generic...but if that's not a
concern I'm happy with your proposal as well. There's one more
"freeze" I'd like to get rid of - we also call LOOP_SET_STATUS(64),
and there's a freeze in there because lo->transfer is modified. That
makes sense, but I was hoping we can make that freeze conditional on
whether lo->transfer would actually change value; if it stays the
same, I think freezing is not necessary.

>
> > switching q_usage_counter to per-cpu mode in the block layer in
> > general, until the first request comes in?
>
> This approach may not help your issue on loop, IO request comes
> just after disk is added, such as by systemd, or reading partition table.

That's a good point, I thought we could avoid the partition scan, but
on some Android devices we'll have max_part set, and there will be a
partition scan.

Thanks,
Martijn

>
> However, loop only starts to handle IO really after it becomes 'Lo_bound'.
>
> thanks,
> Ming
