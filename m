Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC1C433C1
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BFC61979
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSTJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:09:47 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36537 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSTJ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 15:09:27 -0400
Received: by mail-pg1-f180.google.com with SMTP id h25so4329328pgm.3;
        Fri, 19 Mar 2021 12:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXPICND++2jMUjaEuhFzfUn+kFVTMzS2+F5KwMeIch4=;
        b=Vwa87L7Vn2lg39AjbKzkxFRIABnQeNBvQC04rZ/4bQqD9o7Zm3ewpDsCiV4F5dpVzi
         e2zDvwzm8FRsecmlTCxVCHP7taWs+LY6nQIRCxoScE54aSAq4mQ/11Bwpa+DRBoo435m
         1RisAL4ESBbrwsLFJNJdPyQSOp1H7DrCbziQmIf63vNv9pg9fHn2hLNAlOAdMw1WQSMV
         4AqCzq2Rw2lmk4Z4rJURjDRDWmXiVFH7iJ595Kh3coUxRG6KgfM9n3T0Itajkjs/4inD
         e9Fy5sh2oxvPxWgUBaHa71TyDqG7AzO9JjxbNfeYUhOqiAHzKRMGyMus1XDo+W2k9Fwm
         xFWw==
X-Gm-Message-State: AOAM530dKbEVMCkifk0wRAWF0cbZhWCLYvfsu3Y3cy/iu478TVwmrvcM
        IXyNK1UH8BSjvoo96qwamZwqjOwyEbZwLw==
X-Google-Smtp-Source: ABdhPJwNHKg6QWcunKdi0zgdTovA8MicxSd1tryba29Ahp7Opw3KTv5cVTQ04PzdrqnWU6t2rPs1Dw==
X-Received: by 2002:aa7:94ad:0:b029:1ef:2392:4ee8 with SMTP id a13-20020aa794ad0000b02901ef23924ee8mr10654937pfl.75.1616180966625;
        Fri, 19 Mar 2021 12:09:26 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t16sm6386840pfc.204.2021.03.19.12.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:09:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 87B5740317; Fri, 19 Mar 2021 19:09:24 +0000 (UTC)
Date:   Fri, 19 Mar 2021 19:09:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210319190924.GK4332@42.do-not-panic.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEvA1dzDsFOuKdZ/@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 12, 2021 at 11:28:21AM -0800, Minchan Kim wrote:
> On Fri, Mar 12, 2021 at 06:32:38PM +0000, Luis Chamberlain wrote:
> > On Thu, Mar 11, 2021 at 06:14:40PM -0800, Minchan Kim wrote:
> > > On Wed, Mar 10, 2021 at 09:21:28PM +0000, Luis Chamberlain wrote:
> > > > On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> > > > > If I understand correctly, bugs you found were related to module
> > > > > unloading race while the zram are still working.
> > > > 
> > > > No, that is a simplifcation of the issue. The issue consists of
> > > > two separate issues:
> > > > 
> > > >  a) race against module unloading in light of incorrect racty use of
> > > >     cpu hotplug multistate support
> > > 
> > > 
> > > Could you add some pusedo code sequence to show the race cleary?
> > 
> > Let us deal with each issue one at time. First, let's address
> > understanding the kernel warning can be reproduced easily by
> > triggering zram02.sh from LTP twice:
> > 
> > kernel: ------------[ cut here ]------------
> > kernel: Error: Removing state 63 which has instances left.
> > kernel: WARNING: CPU: 7 PID: 70457 at kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
> > kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>
> > 
> > The first patch prevents this race. This race is possible because on
> > module init we associate callbacks for CPU hotplug add / remove:
> > 
> > static int __init zram_init(void)                                               
> > {
> > 	...
> > 	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
> > 	                              zcomp_cpu_up_prepare, zcomp_cpu_dead); 
> > 	...
> > }
> > 
> > The zcomp_cpu_dead() accesses the zcom->comp, and if zcomp->comp is
> > removed and this function is called, clearly we'll be accessing some
> > random data here and can easily crash afterwards:
> 
> I am trying to understand this crash. You mentioned the warning
> above but here mention crash(I understand sysfs race but this is
> different topic). What's the relation with above warning and
> crash here? You are talking the warning could change to the
> crash sometimes? 

Indeed one issue is a consequence of the other but a bit better
description can be put together for both separately.

The warning comes up when cpu hotplug detects that the callback
is being removed, but yet "instances" for multistate are left behind,
ie, not removed. CPU hotplug multistate allows us to dedicate a callback
for zram so that it gets called every time a CPU hot plugs or unplugs.
In the zram driver's case we want to trigger the callback per each
struct zcomp, one is used per supported and used supported compression
algorithm. The zram driver allocates a struct zcomp for an compression
algorithm on a need basis. The default compressor is CONFIG_ZRAM_DEF_COMP
which today is CONFIG_ZRAM_DEF_COMP_LZORLE ("lzo-rle"). Although we may
have different zram devices, zram devices which use the same compression
algorithm share the same struct zcomp. The "multi" in CPU hotplug multstate
refers to these different struct zcomp instances, each of these will
have the callback routine registered run for it. The kernel's CPU
hotplug multistate keeps a linked list of these different structures
so that it will iterate over them on CPU transitions. By default at
driver initialization we will create just one zram device (num_devices=1)
and a zcomp structure then set for the lzo-rle comrpession algorithm.
At driver removal we first remove each zram device, and so we destroy
the struct zcomp. But since we expose sysfs attributes to create new
devices or reset / initialize existing ones, we can easily end up
re-initializing a struct zcomp before the exit routine of the module
removes the cpu hotplug callback. When this happens the kernel's
CPU hotplug will detect that at least one instance (struct zcomp for
us) exists.

And so we can have:

static void destroy_devices(void)
{
	class_unregister(&zram_control_class);
	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
	zram_debugfs_destroy();
	idr_destroy(&zram_index_idr);
	unregister_blkdev(zram_major, "zram");
	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
}

While destroy_devices() runs we can have this race:


CPU 1                            CPU 2

class_unregister(...);
idr_for_each(...);
zram_debugfs_destroy();
                                disksize_store(...)
idr_destroy(...);
unregister_blkdev(...);
cpuhp_remove_multi_state(...);


The warning comes up on cpuhp_remove_multi_state() when it sees
that the state for CPUHP_ZCOMP_PREPARE does not have an empty
instance linked list.

After the idr_destory() its also easy to run into a crash. The
above predicament also leads to memory leaks.

And so we need to have a state machine for when we're up and when
we're going down generically.

Let me know if it makes sense now, if so I can amend the commit log
accordingly.

  Luis
