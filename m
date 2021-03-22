Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7764C433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC2D6199E
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 16:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhCVQhc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhCVQhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 12:37:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8329C061574;
        Mon, 22 Mar 2021 09:37:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k4so6880088plk.5;
        Mon, 22 Mar 2021 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DvVttcUkZlRGv8XA7Nx8sgxweprJ5gTHp/2B/Eb8+RA=;
        b=tv+8ArA36eP3BmttNYizPpaf0r5ZvioHivx5A3/XZlJF8eCr/fCidRscTwtBH8yDhO
         URQZCuvrjLZvOKZWXj/7XwKGyxXGgf/A5PDThz1QqFVm4xzHK8L8iRLmhL1h25IcDOMw
         SheNF+sbbMzFrFA2vCUInYlodW1rpIL+CBlDJTaq+lvfqXRz3E82eGEwwSjNITdDEv/R
         Id9tFXjQR03hgZ/PliEcsppsPTVuJHGmcwv9gThDy5rZeUhI403cVKcLxMXjVN5ul+bW
         nwxTLVjW1a4mMPXzKZTLT3w+ppoFH3NICfD1a917kac7EL6MzwT+a9FChOJYAXv2rWCO
         LVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DvVttcUkZlRGv8XA7Nx8sgxweprJ5gTHp/2B/Eb8+RA=;
        b=bdN0Q/Oily8sK9bMGlEUAnRpXk8u2LruNejhWZXal9TQR/I0y1VUGo2Mb5GZcSLkR7
         AajXe3DRn0dotoMFKUuWJRRpdTuj423eo5Z+BG6h8bepULCL4ThI2tiyRVEK0FymwYlY
         zIdCJh1KYPfoM9tk4/qjNQucKLn/632DHlyMyJ4x6fpBMiCyKnQ4ZzYNvTI5Ws39zOHr
         UoWhenjO5BaOgIgAiFV6YK32g46jKmGwLbbj0jA9Gq6nSVG9qOtbzDwokEM7k4oprkqV
         8RKJrcG0izSX0Fd4/Z+XecRrm0Hj1rd0aYUYdEoNrjIi6PUanYr8UCKch+yjK1nBJP24
         IVRA==
X-Gm-Message-State: AOAM530Baq+UZNGrrP7qLfjPsiJaw3W4kUJPBX5SimK1nau4mdhr6x8/
        +ymvQds2eVG9r2+ASP1zdB3We2iMiZg=
X-Google-Smtp-Source: ABdhPJzJ9z4f2zT+0rGP+VMc7s/eDxunEtnDBbNxCbTMybevW/c9dKXdP5hO7g/syYELdIXwUnVxaQ==
X-Received: by 2002:a17:902:82c7:b029:e4:74ad:9450 with SMTP id u7-20020a17090282c7b02900e474ad9450mr414643plz.58.1616431041151;
        Mon, 22 Mar 2021 09:37:21 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6568:690d:7590:b7b5])
        by smtp.gmail.com with ESMTPSA id p22sm14233213pjg.39.2021.03.22.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:37:19 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 22 Mar 2021 09:37:17 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YFjHvUolScp3btJ9@google.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319190924.GK4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 07:09:24PM +0000, Luis Chamberlain wrote:
> On Fri, Mar 12, 2021 at 11:28:21AM -0800, Minchan Kim wrote:
> > On Fri, Mar 12, 2021 at 06:32:38PM +0000, Luis Chamberlain wrote:
> > > On Thu, Mar 11, 2021 at 06:14:40PM -0800, Minchan Kim wrote:
> > > > On Wed, Mar 10, 2021 at 09:21:28PM +0000, Luis Chamberlain wrote:
> > > > > On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> > > > > > If I understand correctly, bugs you found were related to module
> > > > > > unloading race while the zram are still working.
> > > > > 
> > > > > No, that is a simplifcation of the issue. The issue consists of
> > > > > two separate issues:
> > > > > 
> > > > >  a) race against module unloading in light of incorrect racty use of
> > > > >     cpu hotplug multistate support
> > > > 
> > > > 
> > > > Could you add some pusedo code sequence to show the race cleary?
> > > 
> > > Let us deal with each issue one at time. First, let's address
> > > understanding the kernel warning can be reproduced easily by
> > > triggering zram02.sh from LTP twice:
> > > 
> > > kernel: ------------[ cut here ]------------
> > > kernel: Error: Removing state 63 which has instances left.
> > > kernel: WARNING: CPU: 7 PID: 70457 at kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
> > > kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>
> > > 
> > > The first patch prevents this race. This race is possible because on
> > > module init we associate callbacks for CPU hotplug add / remove:
> > > 
> > > static int __init zram_init(void)                                               
> > > {
> > > 	...
> > > 	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
> > > 	                              zcomp_cpu_up_prepare, zcomp_cpu_dead); 
> > > 	...
> > > }
> > > 
> > > The zcomp_cpu_dead() accesses the zcom->comp, and if zcomp->comp is
> > > removed and this function is called, clearly we'll be accessing some
> > > random data here and can easily crash afterwards:
> > 
> > I am trying to understand this crash. You mentioned the warning
> > above but here mention crash(I understand sysfs race but this is
> > different topic). What's the relation with above warning and
> > crash here? You are talking the warning could change to the
> > crash sometimes? 
> 

Hi Luis,

> Indeed one issue is a consequence of the other but a bit better
> description can be put together for both separately.
> 
> The warning comes up when cpu hotplug detects that the callback
> is being removed, but yet "instances" for multistate are left behind,
> ie, not removed. CPU hotplug multistate allows us to dedicate a callback
> for zram so that it gets called every time a CPU hot plugs or unplugs.
> In the zram driver's case we want to trigger the callback per each
> struct zcomp, one is used per supported and used supported compression

     you meant "each one is used per supported compression"?

> algorithm. The zram driver allocates a struct zcomp for an compression
> algorithm on a need basis. The default compressor is CONFIG_ZRAM_DEF_COMP
> which today is CONFIG_ZRAM_DEF_COMP_LZORLE ("lzo-rle"). Although we may
> have different zram devices, zram devices which use the same compression
> algorithm share the same struct zcomp. The "multi" in CPU hotplug multstate

It allocates each own zcomp, not sharing even though zram devices
use the same compression algorithm.

> refers to these different struct zcomp instances, each of these will
> have the callback routine registered run for it. The kernel's CPU
> hotplug multistate keeps a linked list of these different structures
> so that it will iterate over them on CPU transitions. By default at
> driver initialization we will create just one zram device (num_devices=1)
> and a zcomp structure then set for the lzo-rle comrpession algorithm.
> At driver removal we first remove each zram device, and so we destroy
> the struct zcomp. But since we expose sysfs attributes to create new
> devices or reset / initialize existing ones, we can easily end up
> re-initializing a struct zcomp before the exit routine of the module
> removes the cpu hotplug callback. When this happens the kernel's
> CPU hotplug will detect that at least one instance (struct zcomp for
> us) exists.

It's very helpful to understand. Thanks a lot!S

So IIUC, it's fundamentally race between destroy_devices(i.e., module
unload) and every sysfs knobs in zram. Isn't it?
Below specific example is one of them and every sysfs code in zram
could access freed object(e.g., zram->something).
And you are claiming there isn't good way to fix it in kernfs(please
add it in the description, too) even though it's general problem.
(If we had, we may detect the race and make zram_remove_cb fails
so unloading modulies fails, finally)

So, shouldn't we introcude a global rw_semaphore?

destroy_devices
  class_unregister
  down_write(&zram_unload);
  idr_for_each(zram_remove_cb);
  up_write(&zram_unload);

And every sysfs code hold the lock with down_read in the first place
and release the lock right before return. So, introduce a zram sysfs
wrapper to centralize all of locking logic.

Does it make sense?

> 
> And so we can have:
> 
> static void destroy_devices(void)
> {
> 	class_unregister(&zram_control_class);
> 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
> 	zram_debugfs_destroy();
> 	idr_destroy(&zram_index_idr);
> 	unregister_blkdev(zram_major, "zram");
> 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
> }
> 
> While destroy_devices() runs we can have this race:
> 
> 
> CPU 1                            CPU 2
> 
> class_unregister(...);
> idr_for_each(...);
				  I think sysfs was already remove here.
> zram_debugfs_destroy();
>                                 disksize_store(...)
> idr_destroy(...);
> unregister_blkdev(...);
> cpuhp_remove_multi_state(...);

So,

	CPU 1                            CPU 2
 
destroy_devices
..
				 disksize_store()
				   zcomp_create
				   zcomp_init
idr_for_each(zram_remove_cb
  zram_remove
  zram_reset
  zcomp_destroy
  cpuhp_state_remove_instance
				   cpuhp_state_add_instance
..

cpuhp_remove_multi_state(...)
  Detect!
    kernel: Error: Removing state 63 which has instances left.

> 
> 
> The warning comes up on cpuhp_remove_multi_state() when it sees
> that the state for CPUHP_ZCOMP_PREPARE does not have an empty
> instance linked list.
> 
> After the idr_destory() its also easy to run into a crash. The
> above predicament also leads to memory leaks.
> 
> And so we need to have a state machine for when we're up and when
> we're going down generically.
> 
> Let me know if it makes sense now, if so I can amend the commit log
> accordingly.

Yub, It's much better. Let's have it in the commit log.

Thanks.
