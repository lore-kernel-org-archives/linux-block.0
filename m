Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBCCC433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 09:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiCCJdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiCCJdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 04:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2106BDD3
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 01:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646299944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0PZ0H54yfXoj1Ao/27vobiJPxhA7EjRaFy7SZasMoSE=;
        b=VaaYmC/ZwUkUzlqZOigDMPf8RkMTwz0p+9S0miRYeMkgJeuI7YyWjrS9n41YxkAIWSjl4M
        biOIrtK2BmRoZIFLO8URLu62dRn2mwKq5yjptKsFIYe+mwetOhVsuZely57LHwbu+yc/gX
        BvHb5+/h5DH+RrjMOSCJsFXcNdTGbAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-lxaGFSCqPhWo-JsHKWqrtQ-1; Thu, 03 Mar 2022 04:32:21 -0500
X-MC-Unique: lxaGFSCqPhWo-JsHKWqrtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65A211006AA5;
        Thu,  3 Mar 2022 09:32:20 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0DBE79C59;
        Thu,  3 Mar 2022 09:32:00 +0000 (UTC)
Date:   Thu, 3 Mar 2022 17:31:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 5/6] blk-mq: prepare for implementing hctx table via
 xarray
Message-ID: <YiCLCut1EP6hwdO/@T590>
References: <20220302121407.1361401-6-ming.lei@redhat.com>
 <202203031651.z0z86F6E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203031651.z0z86F6E-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 03, 2022 at 05:08:47PM +0800, kernel test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on v5.17-rc6 next-20220302]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/blk-mq-update_nr_hw_queues-related-improvement-bugfix/20220302-201636
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: m68k-randconfig-m031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203031651.z0z86F6E-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> block/blk-mq-sysfs.c:282 __blk_mq_register_dev() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'
> block/blk-mq-sysfs.c:282 __blk_mq_register_dev() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'

Good catch, will fix it by the following way in V3:

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 6a7fb960e046..851faacc2f78 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -279,8 +279,8 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
        return ret;

 unreg:
-       while (--i >= 0)
-               blk_mq_unregister_hctx(xa_load(&q->hctx_table, i));
+       queue_for_each_hw_ctx(q, hctx, i) {
+               blk_mq_unregister_hctx(hctx);

        kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
        kobject_del(q->mq_kobj);



Thanks,
Ming

