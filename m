Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE908C433E6
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F7664F77
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhCLScx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 13:32:53 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39791 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhCLSck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 13:32:40 -0500
Received: by mail-pg1-f173.google.com with SMTP id x29so16415646pgk.6;
        Fri, 12 Mar 2021 10:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrGljEZwb2bS+cueEd9y2/XUe0Gja93YKDJ2vBoyhUs=;
        b=rFFcycGySuQs/5LeDBOJDWW0lj4YtyHA60Ug9GB5839eSKT6sR8eBWu7gnkDGVc+Hx
         bfPolTS4I8wn/dUHSEelCKhRLQ1CY/3s7+aGV4rJvnIOwy5HSeSm+l5ysKTZp6nqxcax
         LWS/tJmdl1S0aGRfeD0cXxrpjPOq7cXjbkg6NQLzCOb9hlZlbjda8SkRJnw6e51Mg/KX
         T01w5fROeW2ndfPF+xIV+/gZSJjlzZP5o886PdLvx/8/R4FzG6g+bOJSmKJdzLl9DwRq
         AavnyvNnMr4pmJC8l0unKIH+vkJIRO3JQ94uYA2/BsJjj9ODkxh1alKBnLs806999zxi
         QDeA==
X-Gm-Message-State: AOAM531PUdDfrCxC19add0CE3DZjsMGXQZrqSU7d3mF/OLKw6kYnYb6+
        tjYGXbx6ujK2/SsDerx85ZCwOMsBtQgIJw==
X-Google-Smtp-Source: ABdhPJxObxLCPgA9Ydhlid7OJOWKBz7zBPkUEn94yrezjP+V5yT3o5+c64crDbXUf7YnDUPFMNbIdQ==
X-Received: by 2002:a63:4b04:: with SMTP id y4mr1485991pga.245.1615573960324;
        Fri, 12 Mar 2021 10:32:40 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d25sm6111030pfo.218.2021.03.12.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:32:39 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5D8614046C; Fri, 12 Mar 2021 18:32:38 +0000 (UTC)
Date:   Fri, 12 Mar 2021 18:32:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210312183238.GW4332@42.do-not-panic.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YErOkGrvtQODXtB0@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 11, 2021 at 06:14:40PM -0800, Minchan Kim wrote:
> On Wed, Mar 10, 2021 at 09:21:28PM +0000, Luis Chamberlain wrote:
> > On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> > > If I understand correctly, bugs you found were related to module
> > > unloading race while the zram are still working.
> > 
> > No, that is a simplifcation of the issue. The issue consists of
> > two separate issues:
> > 
> >  a) race against module unloading in light of incorrect racty use of
> >     cpu hotplug multistate support
> 
> 
> Could you add some pusedo code sequence to show the race cleary?

Let us deal with each issue one at time. First, let's address
understanding the kernel warning can be reproduced easily by
triggering zram02.sh from LTP twice:

kernel: ------------[ cut here ]------------
kernel: Error: Removing state 63 which has instances left.
kernel: WARNING: CPU: 7 PID: 70457 at kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>

The first patch prevents this race. This race is possible because on
module init we associate callbacks for CPU hotplug add / remove:

static int __init zram_init(void)                                               
{
	...
	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
	                              zcomp_cpu_up_prepare, zcomp_cpu_dead); 
	...
}

The zcomp_cpu_dead() accesses the zcom->comp, and if zcomp->comp is
removed and this function is called, clearly we'll be accessing some
random data here and can easily crash afterwards:

int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)                   
{
	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
	struct zcomp_strm *zstrm;

	zstrm = per_cpu_ptr(comp->stream, cpu);
	zcomp_strm_free(zstrm);
	return 0;
}

And zram's syfs reset_store() lets userspace call zram_reset_device()
which calls zcomp_destroy():

void zcomp_destroy(struct zcomp *comp)
{
	cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
	free_percpu(comp->stream);
	kfree(comp);
}

> It would be great if it goes in the description, too since it's
> more clear to show the problme.

Does the above do it?
> 
> >  b) module unload race with sysfs attribute race on *any* driver which
> >     has sysfs attributes which also shares the same lock as used during
> >     module unload
> 
> Yub, that part I missed. Maybe, we need some wrapper to zram sysfs
> to get try_module_get in the warapper funnction and then call sub
> rountine only if it got the refcount.
> 
> zram_sysfs_wrapper(func, A, B)
>     if (!try_module_get(THIS_MODULE)
>         return -ENODEV;
>     ret = func(A,B);
>     module_put(THIS_MODULE);
>     return ret;

I'd much prefer this be resolved in kernfs later, if you look at the kernel
there are already some drivers which may have realized this requirement
the hard way. Open coding this I think makes the race / intent clearer.

Right now we have no semantics possible for a generic solution, but I
can work on one later.

  Luis
