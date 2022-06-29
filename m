Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 19:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiF2T7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiF2T7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 15:59:14 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D266461
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:59:13 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id cs6so26505322qvb.6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VC1d/RtUMcFNbbvAAhEUHb9go0eBXP9ttr+DE79ATiQ=;
        b=Fv23tTJ6quaYi2LvKMo1nA66eOBgrSIRnXQ+rAkmSA0P7xaPUowQc9+kNqAT0b9Hqy
         347Zari8Q1UonhAFd94sTpPMUv90W4fKvOZEHS5c0eCIkFJMpT4eCQTpJB9zZJgacVwR
         IVkRFpbb3J6gQdrH9QsJzK2OUmeFZLa0nWpr5yIHxyYh787HoGfeoBfhDfd3hEzYGqgF
         NhBBdJuTwDwnQMnOBOVj70AA9GnsXiMxfdQN0CIJcb04jm7Wu12pHg9MLHGyUDuuHAXf
         rSKnfk/47/+iaDKfuQBgdKW7j7viw9Mk5SvyKnrZzwD5QR33zLNBb/tB/9VszZqT7GyB
         Wv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VC1d/RtUMcFNbbvAAhEUHb9go0eBXP9ttr+DE79ATiQ=;
        b=4/u2EbeGrv49Slj5frsFR1AUq3TdQQHwrj3m700THpf8rJ765dQjTSdrQHyL58bhac
         mU9IghongebvpEEoZ3ps3GAFOarxfGaAsMvAX64GdkuMFmjg5W6B3rse2C4ge86r2pNd
         TQC89A7nQZxk3sXca6H4eJbydAEMlNKX4jS7PJ4Pxr59rmtfMt5lLUh5NSGIVWlT4+Ts
         fkfncTOnv5y59Bu0VknawssCFSQZbYXl01kQKmbPd16xw4nUSmpmjJoUrwOTWIjtE9cF
         WctTIYe/rBQpjudzxtuNUoBExxK+GNWeZclDfGfpMmxfWxJ6EUo2xola1DmaXrmGqNpn
         0fDQ==
X-Gm-Message-State: AJIora8tO5vSTK8nsQcz3JDeWtTi9k15jSUdZhnu/KchcJe1YLRVZ56Q
        0Cp2IuW/oVQC/G5ggZ0ZEeUJ/9/zd/XsFTU=
X-Google-Smtp-Source: AGRyM1uSdd9e1HeXILcCMJ3BPfsY+q4doaVEd0sI0eppLIPowfIBd2RkwQmcFci0vDsGg6DAH44Ytw==
X-Received: by 2002:a05:6214:29ef:b0:470:b680:ad6f with SMTP id jv15-20020a05621429ef00b00470b680ad6fmr9407023qvb.80.1656532752181;
        Wed, 29 Jun 2022 12:59:12 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a414c00b006aefe22d75bsm13576490qko.80.2022.06.29.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:59:11 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:59:10 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220629195910.wi5u5pelescihorn@moria.home.lan>
References: <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
 <20220629184001.b66bt4jnppjquzia@moria.home.lan>
 <486ec9e2-d34d-abd5-8667-f58a07f5efad@acm.org>
 <20220629190540.fwspv66a4byzqxmg@moria.home.lan>
 <75aa2055-0f50-47ce-b9cc-8f79eba77807@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aa2055-0f50-47ce-b9cc-8f79eba77807@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 12:37:59PM -0700, Bart Van Assche wrote:
> On 6/29/22 12:05, Kent Overstreet wrote:
> > On Wed, Jun 29, 2022 at 11:51:27AM -0700, Bart Van Assche wrote:
> > > On 6/29/22 11:40, Kent Overstreet wrote:
> > > > But Jens, to be blunt - I know we have different priorities in the way we write code.
> > > 
> > > Please stay professional in your communication and focus on the technical
> > > issues instead of on the people involved.
> > > 
> > > BTW, I remember that some time ago I bisected a kernel bug to one of your
> > > commits and that you refused to fix the bug introduced by that commit. I had
> > > to spend my time on root-causing it and sending a fix upstream.
> > 
> > I'd be genuinely appreciative if you'd refresh my memory on what it was. Because
> > yeah, if I did that that was my fuckup and I want to learn from my mistakes.
> 
> I was referring to the following two conversations from May 2018:
> * [PATCH] Revert "block: Add warning for bi_next not NULL in bio_endio()" (https://lore.kernel.org/linux-block/20180522235505.20937-1-bart.vanassche@wdc.com/)
> * [PATCH v2] Revert "block: Add warning for bi_next not NULL in bio_endio()" (https://lore.kernel.org/linux-block/20180619172640.15246-1-bart.vanassche@wdc.com/)

And also, why did you decide to just revert instead of fixing the issue within
DM? You had a WARN() printed, you shouldn't have needed to bisect, the commit
message explained what was going on - but you never explained that part?
