Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AAFC4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 07:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F349E61A8E
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 07:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhHPHYm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234090AbhHPHYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 03:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629098650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=raXZ9wS6uRXZ08WEw0+7FaHAEkjqyrsEFRdbyxNvvYc=;
        b=L3IWRFzdJrBh3DGzVMXszGhyX14Qjmoz4v49NwkMCyH084MMr+UL/wgeSSYRAtAIvr+IhZ
        7vYBtYfkRbHJQfK+hh5DlgDiwlbp2VmlPYsrA5c+6FdLVKJSpO0i8if5J37eBbkgJq5hE+
        Y45DRJQvojnQctlOkmUvU1iNH9ko0qY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-_xQKX4D_OlmmXZEwXg89XQ-1; Mon, 16 Aug 2021 03:24:09 -0400
X-MC-Unique: _xQKX4D_OlmmXZEwXg89XQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C363E8799E0;
        Mon, 16 Aug 2021 07:24:07 +0000 (UTC)
Received: from T590 (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E48C5D6D5;
        Mon, 16 Aug 2021 07:23:59 +0000 (UTC)
Date:   Mon, 16 Aug 2021 15:23:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/7] blk-mq: build default queue map via
 group_cpus_evenly()
Message-ID: <YRoSiXYhcIsvPNX6@T590>
References: <20210814123532.229494-8-ming.lei@redhat.com>
 <202108150441.EPrLDMTH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108150441.EPrLDMTH-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Sun, Aug 15, 2021 at 04:49:25AM +0800, kernel test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/irq/core]
> [also build test ERROR on next-20210813]
> [cannot apply to block/for-next linux/master linus/master v5.14-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/genirq-affinity-abstract-new-API-from-managed-irq-affinity-spread/20210814-203741
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 04c2721d3530f0723b4c922a8fa9f26b202a20de
> config: riscv-buildonly-randconfig-r005-20210814 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 1f7b25ea76a925aca690da28de9d78db7ca99d0c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/46b1d0ed609db266f6f18e7156c4f294bf6c4502
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ming-Lei/genirq-affinity-abstract-new-API-from-managed-irq-affinity-spread/20210814-203741
>         git checkout 46b1d0ed609db266f6f18e7156c4f294bf6c4502
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from block/blk-mq-cpumap.c:13:
> >> include/linux/group_cpus.h:17:26: error: implicit declaration of function 'kcalloc' [-Werror,-Wimplicit-function-declaration]
>            struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
>                                    ^
>    include/linux/group_cpus.h:17:26: note: did you mean 'kvcalloc'?
>    include/linux/mm.h:827:21: note: 'kvcalloc' declared here
>    static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>                        ^
>    In file included from block/blk-mq-cpumap.c:13:
> >> include/linux/group_cpus.h:17:18: warning: incompatible integer to pointer conversion initializing 'struct cpumask *' with an expression of type 'int' [-Wint-conversion]
>            struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
>                            ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Will fix it in next version, and it can be done by include <linux/slab.h> into
include/linux/group_cpus.h.


Thanks,
Ming

