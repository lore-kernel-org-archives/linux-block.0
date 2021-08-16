Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED7C4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C55613A4
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhHPBFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232077AbhHPBFL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629075880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbfvwkokljU3OH/PzyLtJVDerFx7CfrHkMttzBcnp30=;
        b=LJgPK+V4UlLe9K+z0E2k7HNPP3XQM86vu+QLx85WnsO344ZGrM9AL8oEOUQnli1hfNV7Ic
        UM1TAWqRyZB5F+DBtBEJPzLEyA7eIFSYnnc9+6ES/PFGbq3w4UQ/4qtP5gEHM0BT7ht0g1
        iqPAkDmq+y3bY1lHRrd7DUtIBNgONvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-T7wyzkvIN2yAlijX0tPMew-1; Sun, 15 Aug 2021 21:04:36 -0400
X-MC-Unique: T7wyzkvIN2yAlijX0tPMew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F56F108292D;
        Mon, 16 Aug 2021 01:04:35 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F184B5D9D3;
        Mon, 16 Aug 2021 01:04:26 +0000 (UTC)
Date:   Mon, 16 Aug 2021 09:04:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/7] genirq/affinity: move group_cpus_evenly() into lib/
Message-ID: <YRm5lXfnukXU8Ebh@T590>
References: <20210814123532.229494-6-ming.lei@redhat.com>
 <202108150001.EBuNGcQ8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108150001.EBuNGcQ8-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Sun, Aug 15, 2021 at 01:01:07AM +0800, kernel test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/irq/core]
> [also build test WARNING on next-20210813]
> [cannot apply to block/for-next linux/master linus/master v5.14-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/genirq-affinity-abstract-new-API-from-managed-irq-affinity-spread/20210814-203741
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 04c2721d3530f0723b4c922a8fa9f26b202a20de
> config: hexagon-randconfig-r041-20210814 (attached as .config)
> compiler: clang version 12.0.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/759f72186bfdd5c3ba8b53ac0749cf7ba930012c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ming-Lei/genirq-affinity-abstract-new-API-from-managed-irq-affinity-spread/20210814-203741
>         git checkout 759f72186bfdd5c3ba8b53ac0749cf7ba930012c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> lib/group_cpus.c:344:17: warning: no previous prototype for function 'group_cpus_evenly' [-Wmissing-prototypes]
>    struct cpumask *group_cpus_evenly(unsigned int numgrps)
>                    ^
>    lib/group_cpus.c:344:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    struct cpumask *group_cpus_evenly(unsigned int numgrps)
>    ^
>    static 
>    1 warning generated.
> 
> 
> vim +/group_cpus_evenly +344 lib/group_cpus.c
> 
>    328	
>    329	/**
>    330	 * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>    331	 * @numgrps: number of groups
>    332	 *
>    333	 * Return: cpumask array if successful, NULL otherwise. And each element
>    334	 * includes CPUs assigned to this group
>    335	 *
>    336	 * Try to put close CPUs from viewpoint of CPU and NUMA locality into
>    337	 * same group, and run two-stage grouping:
>    338	 *	1) allocate present CPUs on these groups evenly first
>    339	 *	2) allocate other possible CPUs on these groups evenly
>    340	 *
>    341	 * We guarantee in the resulted grouping that all CPUs are covered, and
>    342	 * no same CPU is assigned to different groups
>    343	 */
>  > 344	struct cpumask *group_cpus_evenly(unsigned int numgrps)

But the above symbol is exported via EXPORT_SYMBOL_GPL(), in current
kernel tree, we usually keep such exported symbol as global, or is there
some change in kernel coding style recently?



Thanks,
Ming

