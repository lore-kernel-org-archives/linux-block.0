Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5576C433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 990EC64F88
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 19:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhCLT24 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 14:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhCLT2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 14:28:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27046C061574;
        Fri, 12 Mar 2021 11:28:25 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z5so12408686plg.3;
        Fri, 12 Mar 2021 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xsXCUAe7GzyEFcIbzRGPi+QWjqVbRvQwSdbS7Lm1E4M=;
        b=myFMEhn81hANx0heDy1GieIbR1tsA44TdlU0yulRozgxvyj5qQ7FTmE1fCBxSfcWE7
         cthXXk+g9MsuaAlmFNRgv6U5/VYUVPrmCIDlaKiMBbxvP5YsmpSABPa/W5wsDpF9Al1A
         NIUyOkqi3aP5gX7p3HcPsV1rvdcOw3ffJHZ9lHAvHil1Y+wUklRd5/6lFTorMIxR4IkC
         jn9qXU1yP2Rh4trZX5VPSPXXcFSt44P+Rk58R/k3exJsMf6P7TX9L4sZn/QskmENj/7j
         A4pImP9Z6TQajenglJM/VSAWR+mGoM446jHKvevW1INOeokZsIpFgTYGaUQfhnkuyySz
         KpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xsXCUAe7GzyEFcIbzRGPi+QWjqVbRvQwSdbS7Lm1E4M=;
        b=lGVUpbv+v1uqOnVQBq0Am/yDtDa7kKytlbj7XcqyChFBc1EyCIXIwdbfhvJFQtLm4A
         DlcCCr5+dtPSWELwgxBvMw9Q1QUK38Ht8II2cAObUj3V/qJrDOewFCUDqctvqG5/z25J
         BMBPu0VO1DTn1FLLHqwkpgnd8TJyOG7jp+EJ8aggnkoCJ7LBOedS3l1FiaAdSFrQvYEf
         lu0rAaKjpiTfQGWRNnucQv9zGQOLcPZyv13O0HJbLSA0pmoY0ujI1Pg8Nkz83QUg8lqd
         Y8J3+wBFTr7eK88ptrZwIKm1Nv0N8TdqldiXFfIfq5LsX3hoISyZ75xi4AKq8zSXMqg6
         hF8w==
X-Gm-Message-State: AOAM532XzSceOY7Cso2rYXrQ5TgrOdwpFzsSwSmlcRl/HgcFnZXbsM5Y
        U7rl/7JPP+kTzmU9FfNXnKfGPacgPWY=
X-Google-Smtp-Source: ABdhPJwiqRNbh75mJffl6hk0vK3fzTsi3TZRyV8aavY5U5bATh+Y6qeE+rzd9REB9mvVMlSfghGUtw==
X-Received: by 2002:a17:902:6a87:b029:e6:6a3d:29e8 with SMTP id n7-20020a1709026a87b02900e66a3d29e8mr83679plk.10.1615577304498;
        Fri, 12 Mar 2021 11:28:24 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8d76:9272:43a9:a6d0])
        by smtp.gmail.com with ESMTPSA id b9sm6020236pgn.42.2021.03.12.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:28:23 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 12 Mar 2021 11:28:21 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YEvA1dzDsFOuKdZ/@google.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312183238.GW4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 12, 2021 at 06:32:38PM +0000, Luis Chamberlain wrote:
> On Thu, Mar 11, 2021 at 06:14:40PM -0800, Minchan Kim wrote:
> > On Wed, Mar 10, 2021 at 09:21:28PM +0000, Luis Chamberlain wrote:
> > > On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> > > > If I understand correctly, bugs you found were related to module
> > > > unloading race while the zram are still working.
> > > 
> > > No, that is a simplifcation of the issue. The issue consists of
> > > two separate issues:
> > > 
> > >  a) race against module unloading in light of incorrect racty use of
> > >     cpu hotplug multistate support
> > 
> > 
> > Could you add some pusedo code sequence to show the race cleary?
> 
> Let us deal with each issue one at time. First, let's address
> understanding the kernel warning can be reproduced easily by
> triggering zram02.sh from LTP twice:
> 
> kernel: ------------[ cut here ]------------
> kernel: Error: Removing state 63 which has instances left.
> kernel: WARNING: CPU: 7 PID: 70457 at kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
> kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>
> 
> The first patch prevents this race. This race is possible because on
> module init we associate callbacks for CPU hotplug add / remove:
> 
> static int __init zram_init(void)                                               
> {
> 	...
> 	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
> 	                              zcomp_cpu_up_prepare, zcomp_cpu_dead); 
> 	...
> }
> 
> The zcomp_cpu_dead() accesses the zcom->comp, and if zcomp->comp is
> removed and this function is called, clearly we'll be accessing some
> random data here and can easily crash afterwards:

I am trying to understand this crash. You mentioned the warning
above but here mention crash(I understand sysfs race but this is
different topic). What's the relation with above warning and
crash here? You are talking the warning could change to the
crash sometimes? 

> 
> int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)                   
> {
> 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
> 	struct zcomp_strm *zstrm;
> 
> 	zstrm = per_cpu_ptr(comp->stream, cpu);
> 	zcomp_strm_free(zstrm);
> 	return 0;
> }
> 
> And zram's syfs reset_store() lets userspace call zram_reset_device()
> which calls zcomp_destroy():
> 
> void zcomp_destroy(struct zcomp *comp)
> {
> 	cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
> 	free_percpu(comp->stream);
> 	kfree(comp);
> }

Do you mean the race between module unloading and zram_reset_device?
If I understood correctly, the approach I put in the first reply would
prevent this problem.

> 
> > It would be great if it goes in the description, too since it's
> > more clear to show the problme.
> 
> Does the above do it?

Rather than that, let's have this kinds of explanation, which is
more clear(it's a just example, not describing exact race you saw.
You could be better to descibe it).

CPU A                       CPU B
moudle_unload
destroy_devices           
zram_remove_cb
                            reset_store
zcomp_cpu_dead
                            zram_reset_device
                            zcomp_destroy
                            cpuhp_state_remove_instance
zcomp_strm_free
    
> > 
> > >  b) module unload race with sysfs attribute race on *any* driver which
> > >     has sysfs attributes which also shares the same lock as used during
> > >     module unload
> > 
> > Yub, that part I missed. Maybe, we need some wrapper to zram sysfs
> > to get try_module_get in the warapper funnction and then call sub
> > rountine only if it got the refcount.
> > 
> > zram_sysfs_wrapper(func, A, B)
> >     if (!try_module_get(THIS_MODULE)
> >         return -ENODEV;
> >     ret = func(A,B);
> >     module_put(THIS_MODULE);
> >     return ret;
> 
> I'd much prefer this be resolved in kernfs later, if you look at the kernel
> there are already some drivers which may have realized this requirement
> the hard way. Open coding this I think makes the race / intent clearer.
> 
> Right now we have no semantics possible for a generic solution, but I
> can work on one later.

Yub, no problem. My point is let's have some zram sysfs wrapper to manage
module_get/put automatically as I mentioned above so no need to deal with
module refcount in worker functions.
