Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E68DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 01:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiCWBHR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCWBHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 21:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5A586EC47
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647997547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KIXrnXvX7GYLDA5/0QRxJWSPAF+9OEsDz7pSHC4is9A=;
        b=h3LHqJPMEjPj0LXBeUZJIsAY6GlOI96Wvj4BxXr19UDnjevATINi2aUFPP7nBuLpz50R7r
        fTilVgi9m3THslWHjj9spGxeCNg05K/FlUw62hFhCeAzWNS8arBu5j4gYUcJ3dzVpQNwxm
        TPV6KPURb2q++yeXwM5VLrvEaZBGsZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-g5QBJKBCPSKRiT7ZRPyaew-1; Tue, 22 Mar 2022 21:05:46 -0400
X-MC-Unique: g5QBJKBCPSKRiT7ZRPyaew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF7DF80231F;
        Wed, 23 Mar 2022 01:05:45 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8B71400E6F;
        Wed, 23 Mar 2022 01:05:40 +0000 (UTC)
Date:   Wed, 23 Mar 2022 09:05:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: avoid to call blkg_free() in atomic context
Message-ID: <YjpyXhRrcIa+9qzb@T590>
References: <20220322161238.2006448-1-ming.lei@redhat.com>
 <202203230833.LMKQ6DdX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203230833.LMKQ6DdX-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 23, 2022 at 08:13:46AM +0800, kernel test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on v5.17 next-20220322]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/block-avoid-to-call-blkg_free-in-atomic-context/20220323-001434
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: i386-randconfig-a005-20220321 (https://download.01.org/0day-ci/archive/20220323/202203230833.LMKQ6DdX-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/c40ac630dd1d94497e427b4933efad4dbfaa0b5b
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ming-Lei/block-avoid-to-call-blkg_free-in-atomic-context/20220323-001434
>         git checkout c40ac630dd1d94497e427b4933efad4dbfaa0b5b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    block/blk-cgroup.c:75: warning: Function parameter or member 'work' not described in 'blkg_free_workfn'
> >> block/blk-cgroup.c:75: warning: expecting prototype for blkg_free(). Prototype was for blkg_free_workfn() instead

Not understand what the 'prototype' for blkg_freee() is. If it is type of
blkg_free(), the patch doesn't change that. If it is document, it can
be one issue.

Anyway, I have tested clang build on v2, and the above warning can't be
observed any more.


Thanks,
Ming

