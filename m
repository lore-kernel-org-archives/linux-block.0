Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E19CC05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 19:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjBBT5V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjBBT5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 14:57:20 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D647BE43
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 11:56:37 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id h24so3275449qtr.0
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 11:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puPH7Nn4Vxt3kUnQKHCGR9XbgEDlt42vfosxQIpu+cs=;
        b=MVkrrHH7Pm97r2f0LZmxGqpxhI1cb8PRvdrtjdnWEaQ3klTssiooPbXzZiIUqsjmAt
         CO22I3qrhMNoNcZcpPQLeNhAKtnc7VSBAPj6uscH9MC0k2fvalUryYXdiDqHIREC9kZ/
         dBaFi4JwEgnTDuQR2A+YzzdvpWIBDPV7fAmbfkSa5sRR1vkzM/+s7VuGL0qR/K5J6hv2
         0lyb6GCFtjqCIjIcOSFxcGxG0FNi0TcKV7O5UQqsM6eq/fvDepaZ67gzmzOhZC151zch
         UfBVWOb175SPiVjPMZyE0amrBMtMs5m6lhnktdVC1b85YrwcNH1jMlTQWTJYu+dHg6ec
         ckyg==
X-Gm-Message-State: AO0yUKVYBYyFni+Uo+z2ZsltuWGiF9F6U0uu2TNXHtaQ/tvOM7C6vgv+
        trXz4hR2uWCDbcwqEiCao3lA
X-Google-Smtp-Source: AK7set92dyhIkHCdWF7e92O2MXu6mUmZ6lpekQmSoPBHbD1dR3CVvDYQ1CtAQ9IvY8M0gdRPR2pO1A==
X-Received: by 2002:a05:622a:511:b0:3b8:6c68:6109 with SMTP id l17-20020a05622a051100b003b86c686109mr13439452qtx.21.1675367796153;
        Thu, 02 Feb 2023 11:56:36 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a10a600b007246f005d8bsm293223qkk.116.2023.02.02.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:56:35 -0800 (PST)
Date:   Thu, 2 Feb 2023 14:56:34 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, dm-devel@redhat.com
Subject: Re: [RFC PATCH 0/7] Allow race-free block device handling
Message-ID: <Y9wVcskXyOk3bbzC@redhat.com>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <Y9vp3XDEQAl7TLND@redhat.com>
 <Y9wEF3rWfpiCKc2i@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9wEF3rWfpiCKc2i@itl-email>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 02 2023 at  1:41P -0500,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> On Thu, Feb 02, 2023 at 11:50:37AM -0500, Mike Snitzer wrote:
> > On Wed, Jan 25 2023 at 10:33P -0500,
> > Demi Marie Obenour <demi@invisiblethingslab.com> wrote:
> > 
> > > This work aims to allow userspace to create and destroy block devices
> > > in a race-free and leak-free way,
> > 
> > "race-free and leak-free way" implies there both races and leaks in
> > existing code. You're making claims that are likely very specific to
> > your Xen use-case.  Please explain more carefully.
> 
> Will do in v2.
> 
> > > and to allow them to be exposed to
> > > other Xen VMs via blkback without leaks or races.  It’s marked as RFC
> > > for a few reasons:
> > > 
> > > - The code has been only lightly tested.  It might be unstable or
> > >   insecure.
> > > 
> > > - The DM_DEV_CREATE ioctl gains a new flag.  Unknown flags were
> > >   previously ignored, so this could theoretically break buggy userspace
> > >   tools.
> > 
> > Not seeing a reason that type of DM change is needed. If you feel
> > strongly about it send a separate patch and we can discuss it.
> 
> Patch 2/7 is the diskseq change.  v2 will contain a revised and tested
> version with a greatly expanded commit message.

I'm aware that 2/7 is where you make the DM change to disallow unknown
flags, what I'm saying is I don't see a reason for that change.

Certainly doesn't look to be a requirement for everything else in that
patch.

So send a separate patch, but I'm inclined to _not_ accept it because
it does potentially break some userspace.
 
> > > - I have no idea if I got the block device reference counting and
> > >   locking correct.
> > 
> > Your headers and justifcation for this line of work are really way too
> > terse. Please take the time to clearly make the case for your changes
> > in both the patch headers and code.
> 
> I will expand the commit message in v2, but I am not sure what you want
> me to add to the code comments.  Would you mind explaining?

Nothing specific about code, was just a general reminder (based on how
terse the 2/7 header was).

Mike
