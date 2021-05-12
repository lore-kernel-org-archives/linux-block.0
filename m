Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0DBC43619
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299E961CBF
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhELPan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 11:30:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:33336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233976AbhELPYH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 11:24:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6E02B173;
        Wed, 12 May 2021 15:22:49 +0000 (UTC)
Subject: Re: [PATCH v1 8/8] block: add add_disk() failure injection support
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-9-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e938c21f-3872-232c-4956-dfa53aec579b@suse.de>
Date:   Wed, 12 May 2021 17:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-9-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> For a long time we have lived without any error handling
> on the add_disk() error path. Now that we have some initial
> error handling, add error injection support for its path so
> that we can test it and ensure we don't regress this path
> moving forward.
> 
> This only adds runtime code *iff* the new bool CONFIG_FAIL_ADD_DISK is
> enabled in your kernel. If you don't have this enabled this provides
> no new functional. When CONFIG_FAIL_ADD_DISK is disabled the new routine
> blk_should_fail_add_disk() ends up being transformed to if (false), and
> so the compiler should optimize these out as dead code producing no
> new effective binary changes.
> 
> Failure injection lets us configure at boot how often we want a failure
> to take place by specifying the interval, the probability, and when needed
> a size constraint. We don't need to test for size constraints for
> add_disk() and so ignore that part of error injection. Although testing
> early boot failures with add_disk() failures might be useful we don't
> to make add_disk() fail every time as otherwise we wouldn't be able to
> boot. So enabling add_disk() error injection requires a second post
> boot step where you specify where in the add_disk() code path you want
> to enable failure injection for. This lets us verify correctness of
> the different error handling parts of add_disk(), while also allowing
> a respective blktests test to grow dynamically in case the add_disk()
> paths grows.
> 
> We currently enable 11 code paths on add_disk() which can fail
> and we can test for:
> 
> 	# ls -1 /sys/kernel/debug/block/config_fail_add_disk/
> 	alloc_devt
> 	alloc_events
> 	bdi_register
> 	device_add
> 	disk_add_events
> 	get_queue
> 	integrity_add
> 	register_disk
> 	register_queue
> 	sysfs_bdi_link
> 	sysfs_depr_link
> 
> If you want to modify the configuration of fail_add_disk dynamically
> at boot, you can enable CONFIG_FAULT_INJECTION_DEBUG_FS. If you've
> enabled CONFIG_FAIL_ADD_DISK you will see these knobs:
> 
> 	# ls -1 /sys/kernel/debug/block/fail_add_disk/
> 	interval
> 	probability
> 	space
> 	task-filter
> 	times
> 	verbose
> 	verbose_ratelimit_burst
> 	verbose_ratelimit_interval_ms
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   .../fault-injection/fault-injection.rst       | 23 ++++++++
>   block/Makefile                                |  1 +
>   block/blk-core.c                              |  1 +
>   block/blk.h                                   | 55 ++++++++++++++++++
>   block/failure-injection.c                     | 54 ++++++++++++++++++
>   block/genhd.c                                 | 57 +++++++++++++++++++
>   lib/Kconfig.debug                             | 13 +++++
>   7 files changed, 204 insertions(+)
>   create mode 100644 block/failure-injection.c
> 
[ .. ]
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d1467658361f..4fccc0fad190 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1917,6 +1917,19 @@ config FAULT_INJECTION_USERCOPY
>   	  Provides fault-injection capability to inject failures
>   	  in usercopy functions (copy_from_user(), get_user(), ...).
>   
> +config FAIL_ADD_DISK
> +	bool "Fault-injection capability for add_disk() callers"
> +	depends on FAULT_INJECTION && BLOCK
> +	help
> +	  Provide fault-injection capability for the add_disk() block layer
> +	  call path. This allows the kernel to provide error injection when
> +	  the add_disk() call is made. You would use something like blktests
> +	  test against this or just load the null_blk driver. This only
> +	  enables the error injection functionality. To use it you must
> +	  configure which path you want to trigger on error on using debugfs
> +	  under /sys/kernel/debug/block/config_fail_add_disk/. By default
> +	  all of these are disabled.
> +
>   config FAIL_MAKE_REQUEST
>   	bool "Fault-injection capability for disk IO"
>   	depends on FAULT_INJECTION && BLOCK
> 

Hmm. Not a fan of this approach.

Having to have a separate piece of code just to test individual 
functions, _and_ having to place hooks in the code to _simulate_ a 
failure seems rather fragile to me.

I would have vastly preferred if we could to this via generic tools like 
ebpf or livepatching.
Also I'm worried that this approach doesn't really scale; taken to 
extremes we would have to add duplicate calls to each and every function 
for full error injection, essentially double the size of the code just 
on the off-chance that someone wants to do error injection.

So I'd rather delegate the topic of error injection to a more general 
discussion (LSF springs to mind ...), and then agree on a framework 
which is suitable for every function.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
