Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC742C433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 09:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiCAJJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiCAJJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 04:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9B8322B0A
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646125712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRuB1SEfC3LgzJZ2LYZ2zf/sw3E70orGW8XC0CyQcIE=;
        b=cz65Vf0sgYP27vx2t+yF6plv6YFrjAtVSQeTzea3aPJRh42ZNYr7kyQ5pimE/szostxapS
        dIHNBnsgX3LKnxLzWfjzK4UCzd+zTLA4qy6abZfTF4dh47b3+I/YcW+DDT4DgPGoX/bLFp
        +FqL8MLt/tJmJp3XKqb0ePIeHR0ntqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-uE4nz8L9N8uKjWws9S8atw-1; Tue, 01 Mar 2022 04:08:31 -0500
X-MC-Unique: uE4nz8L9N8uKjWws9S8atw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 522E01006AA7;
        Tue,  1 Mar 2022 09:08:30 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 705FC646CF;
        Tue,  1 Mar 2022 09:08:13 +0000 (UTC)
Date:   Tue, 1 Mar 2022 17:08:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <Yh3ieEj0dt7JFa6Z@T590>
References: <20220228090430.1064267-7-ming.lei@redhat.com>
 <202203010133.JIpKpP2Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203010133.JIpKpP2Z-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thanks for the report!

On Tue, Mar 01, 2022 at 01:57:33AM +0800, kernel test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on v5.17-rc6 next-20220225]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220228-170706
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: i386-randconfig-a002-20220228 (https://download.01.org/0day-ci/archive/20220301/202203010133.JIpKpP2Z-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/176e39bc0acb20f8fd869d170b429b7253b089c4
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220228-170706
>         git checkout 176e39bc0acb20f8fd869d170b429b7253b089c4
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from block/blk-mq-debugfs-zoned.c:7:
> >> block/blk-mq-debugfs.h:24:14: warning: declaration of 'struct blk_mq_hw_ctx' will not be visible outside of this function [-Wvisibility]
>                                      struct blk_mq_hw_ctx *hctx);


The warning is nothing to do with this patchset.

You can trigger that by just changing modify time of include/linux/blkdev.h.

The following patch can fix the warning, and I will post one formal
patch soon.

diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index a68aa6041a10..37fe2716e96e 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_BLK_DEBUG_FS

 #include <linux/seq_file.h>
+#include <linux/blk-mq.h>

 struct blk_mq_debugfs_attr {
        const char *name;


Thanks,
Ming

