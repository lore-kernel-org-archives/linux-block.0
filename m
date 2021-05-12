Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF986C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82F061059
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbhELRcg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 13:32:36 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:42739 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbhELQ5u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 12:57:50 -0400
Received: by mail-pl1-f171.google.com with SMTP id v13so12813466ple.9;
        Wed, 12 May 2021 09:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uknf8jddePWS2IYubSH9Et4R9Rpo/P7qdwbcNygekGc=;
        b=K6WYwVKxCrPn9tLBY1dgvFgnObOkCxOXULhYo4KfIfBRCCXQJNbbdwLLxcWKiaUOrw
         qy7oYtFL0px8SRxJeyhScPw/vY95bY6X+nMkMJkf0sbTXmhC7jxdGho9jWrOtdZ/FKAi
         /+iki/7eOQ2Cq5ZLhNAeCPtpOOnIgklU3vhZibIMcGyIVvy/ySGkiPe23qT3ez30Quq1
         gctDR5U54lA8hj1LCIKNR1azZPMlqdHyivr8gBQS4868NEHeoMoWA434RV39zPJETO0E
         LNIvyVphxxLZMXSOQP0nAiT0vKWAFbXq6UYPuRkd9lnb/GJz9/ttciPN3wsmEBKUDHGr
         cIWQ==
X-Gm-Message-State: AOAM530eKcCiqor8+EiatE2eU14y3yElgGBiNbsMTnhSx4pui3Og4P2O
        0oHAlv5Hz8yPqFAmlxygUo8=
X-Google-Smtp-Source: ABdhPJyX7xXh6nmW3pjm+1mzXL4+huAcoF0LAXm6gpwnW+qMddYSo3pXEPYHm/FCAUXxL1mHJBNomA==
X-Received: by 2002:a17:902:8ec9:b029:ef:5a88:e7cf with SMTP id x9-20020a1709028ec9b02900ef5a88e7cfmr9837635plo.48.1620838602150;
        Wed, 12 May 2021 09:56:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y23sm313905pfb.83.2021.05.12.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 09:56:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7909141321; Wed, 12 May 2021 16:56:39 +0000 (UTC)
Date:   Wed, 12 May 2021 16:56:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 8/8] block: add add_disk() failure injection support
Message-ID: <20210512165639.GB4332@42.do-not-panic.com>
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-9-mcgrof@kernel.org>
 <e938c21f-3872-232c-4956-dfa53aec579b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e938c21f-3872-232c-4956-dfa53aec579b@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 12, 2021 at 05:22:48PM +0200, Hannes Reinecke wrote:
> On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d1467658361f..4fccc0fad190 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1917,6 +1917,19 @@ config FAULT_INJECTION_USERCOPY
> >   	  Provides fault-injection capability to inject failures
> >   	  in usercopy functions (copy_from_user(), get_user(), ...).
> > +config FAIL_ADD_DISK
> > +	bool "Fault-injection capability for add_disk() callers"
> > +	depends on FAULT_INJECTION && BLOCK
> > +	help
> > +	  Provide fault-injection capability for the add_disk() block layer
> > +	  call path. This allows the kernel to provide error injection when
> > +	  the add_disk() call is made. You would use something like blktests
> > +	  test against this or just load the null_blk driver. This only
> > +	  enables the error injection functionality. To use it you must
> > +	  configure which path you want to trigger on error on using debugfs
> > +	  under /sys/kernel/debug/block/config_fail_add_disk/. By default
> > +	  all of these are disabled.
> > +
> >   config FAIL_MAKE_REQUEST
> >   	bool "Fault-injection capability for disk IO"
> >   	depends on FAULT_INJECTION && BLOCK
> > 
> 
> Hmm. Not a fan of this approach.
> 
> Having to have a separate piece of code just to test individual functions,
> _and_ having to place hooks in the code to _simulate_ a failure seems rather
> fragile to me.
> 
> I would have vastly preferred if we could to this via generic tools like
> ebpf or livepatching.

Agreed. Now, we would then need a place to dump these as well. I guess
blktets would be it for the block layer... and fstests for fs. If done
with livepatching it would take a long time, consider the time added for
probing modules just for a new fault injection for a few routines...
how many modules.. and time.

ebpf maybe. Someone is going to have to try it.

Another possibility is kunit, and I think the tests would be faster.
However maintained boiler place would still be needed.

> Also I'm worried that this approach doesn't really scale; taken to extremes
> we would have to add duplicate calls to each and every function for full
> error injection, essentially double the size of the code just on the
> off-chance that someone wants to do error injection.

Indeed. What would be better is to have the ability to get this for
free and programatically enable knobs. Now fault-injection has some
ability to fail on functions dynamically but I haven't tested that.
Reason I didn't go with that is we want certain functions to fail but
*only* in certain context, not all the time for every caller. This
approach was safer and specific to the block layer, and in fact
only applicable to the add_disk() path.

> So I'd rather delegate the topic of error injection to a more general
> discussion (LSF springs to mind ...), and then agree on a framework which is
> suitable for every function.

Or we just get cranking and produce proof of concepts to compare and
contrast later. At least I hope this patch and the respective blktests
patches suffice to help demo what we need to test.

  Luis
