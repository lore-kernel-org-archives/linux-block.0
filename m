Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5A0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 06:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346570AbiCPG43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 02:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbiCPG42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 02:56:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E095EBCF
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647413714; x=1678949714;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Nh3QpcN3O3uzkHoTd6unJET9stO5ehOKv8zxVHcnBhs=;
  b=TI+UUXLTj7UqzwnjxmC79uXf+4r6Qbvh64M2wGCt2j5+NrTIAwaMjalL
   voKnNyko+P5+owr8jC9VmdAD9VwuHZtrJaVCBREfJaBXh5d+vj7/lF1ck
   PM4dGrZJ9Bi8j8HakL6a5EV6W+lrX5vxT8BEBM3zskJX+L4dD9o405rIo
   JAH3j4mYiz2+ub2RaOG0BqtjRCRyRLR0otLAnFLkqTRNcRhX5TtnyPruA
   PemIdWs+SXljVQbjNjLI1m//pphnDQSR13tqDwFjKq+AGiL8nvvg8CFAp
   QPsQoGZeYi9wOOpMi+e9jHBoNzDa2GJ/Qqql6ErP+ZwfTKKwHamHCfS1h
   w==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="307434834"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 14:55:14 +0800
IronPort-SDR: zo2rmN6Eub8Ss9V0X/VUNvz8c9QY27segTT8BOo35AnDeE8MegUplxCXCQU6xWDxR8viOCtDJi
 fByiZnbJbbK6SgJVm9u8QH/ha902JWrzZ5fXSodJ2rJ+jXxP1u3Lioyo8OAoqgjuveDXenaiGS
 zFjb6kbQTktbuVAz48oApYIAiv7Q3q6OqLKpQP1M1/Dn9aHGeyL3rAEX/bILTV2AFe9PLFyv0q
 UsA69QlalTscL74LL25ejDbjDM3xTXt4DljoYVhisANvSMZ6ym0Bf6JFzi8+ZelS7w/hpNl0uh
 9Ddbc1KOy5LDCq0Cy3bJOEG9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 23:27:19 -0700
IronPort-SDR: 4Kp92/XGqvbd9Gu5uK3LsaoLhQndj02EouzU96+VWW3gqTlxTILHtbEeBEZY59EgU5qGur1SVK
 eHxLdjkSvi9g7G+yr8UMXCyU3HRKuycOt9Q+fYCVsRaqRoD1t5ODqXFSvv8AKhS2DPfboiJa0V
 22/xf//o9iqPkHbhd8qxGD51033IgtYw0PY2RLxLtI4ReFDIlMqRL9iyxRmKwe7rejNA9h/JOa
 +GO4acFBmeSSSxrx1DVviJl1qonF79ZWmyBJVVqcT/GSUjqBQZ7dl7UTijaReslgidhgYtWRUn
 rwE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 23:55:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJLcy21RHz1Rwrw
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 23:55:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647413713; x=1650005714; bh=Nh3QpcN3O3uzkHoTd6unJET9stO5ehOKv8z
        xVHcnBhs=; b=qKCVuuyUUBxlPddsS75RbCM+lcynigkPn6FlKZeLtPQgVyipkL3
        qQGVkNZ1nvn5jPnoDrbnZffoNvakUi7QrYtT5l1qfcpfufnY6G7nc5hY8BUfUaI2
        YH09jEtlfiK11UDTu29eUmrTZ/g6ZvzBFFEXtE+GofuCQZbxqFSflT4KLAnmXm4+
        yJfX5kBdn7NDPdjR0LP6XFT/U/a1ML0UEQK5THyFJZoexbIYLxYrivrJXNvmvLyJ
        Xrr9OTPOPKAT3GA8r/OXAFuyei6b/qmk2M/CLgCu6SzkQI8tFzpZJAFKGzbY67e7
        QA1vcN2rYnXD487En3PCEWh4Xf3lXu1sV6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BfmJs81hHddl for <linux-block@vger.kernel.org>;
        Tue, 15 Mar 2022 23:55:13 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJLcx0LpWz1Rvlx;
        Tue, 15 Mar 2022 23:55:12 -0700 (PDT)
Message-ID: <c6e917ca-0192-4ef1-5483-284b2007ecf4@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 15:55:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] block: limit request dispatch loop duration
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
References: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 15:11, Shin'ichiro Kawasaki wrote:
> When IO requests are made continuously and the target block device
> handles requests faster than request arrival, the request dispatch loop
> keeps on repeating to dispatch the arriving requests very long time,
> more than a minute. Since the loop runs as a workqueue worker task, the
> very long loop duration triggers workqueue watchdog timeout and BUG [1].
> 
> To avoid the very long loop duration, break the loop periodically. When
> opportunity to dispatch requests still exists, check need_resched(). If
> need_resched() returns true, the dispatch loop already consumed its time
> slice, then reschedule the dispatch work and break the loop. With heavy
> IO load, need_resched() does not return true for 20~30 seconds. To cover
> such case, check time spent in the dispatch loop with jiffies. If more
> than 1 second is spent, reschedule the dispatch work and break the loop.
> 
> [1]
> 
> [  609.691437] BUG: workqueue lockup - pool cpus=10 node=1 flags=0x0 nice=-20 stuck for 35s!
> [  609.701820] Showing busy workqueues and worker pools:
> [  609.707915] workqueue events: flags=0x0
> [  609.712615]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [  609.712626]     pending: drm_fb_helper_damage_work [drm_kms_helper]
> [  609.712687] workqueue events_freezable: flags=0x4
> [  609.732943]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [  609.732952]     pending: pci_pme_list_scan
> [  609.732968] workqueue events_power_efficient: flags=0x80
> [  609.751947]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [  609.751955]     pending: neigh_managed_work
> [  609.752018] workqueue kblockd: flags=0x18
> [  609.769480]   pwq 21: cpus=10 node=1 flags=0x0 nice=-20 active=3/256 refcnt=4
> [  609.769488]     in-flight: 1020:blk_mq_run_work_fn
> [  609.769498]     pending: blk_mq_timeout_work, blk_mq_run_work_fn
> [  609.769744] pool 21: cpus=10 node=1 flags=0x0 nice=-20 hung=35s workers=2 idle: 67
> [  639.899730] BUG: workqueue lockup - pool cpus=10 node=1 flags=0x0 nice=-20 stuck for 66s!
> [  639.909513] Showing busy workqueues and worker pools:
> [  639.915404] workqueue events: flags=0x0
> [  639.920197]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [  639.920215]     pending: drm_fb_helper_damage_work [drm_kms_helper]
> [  639.920365] workqueue kblockd: flags=0x18
> [  639.939932]   pwq 21: cpus=10 node=1 flags=0x0 nice=-20 active=3/256 refcnt=4
> [  639.939942]     in-flight: 1020:blk_mq_run_work_fn
> [  639.939955]     pending: blk_mq_timeout_work, blk_mq_run_work_fn
> [  639.940212] pool 21: cpus=10 node=1 flags=0x0 nice=-20 hung=66s workers=2 idle: 67
> 
> Fixes: 6e6fcbc27e778 ("blk-mq: support batching dispatch in case of io")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # v5.10+
> Link: https://lore.kernel.org/linux-block/20220310091649.zypaem5lkyfadymg@shindev/
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55488ba97823..64941615befc 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  {
>  	int ret;
> +	unsigned long end = jiffies + HZ;
>  
>  	do {
>  		ret = __blk_mq_do_dispatch_sched(hctx);
> +		if (ret == 1 &&
> +		    (need_resched() || time_is_after_jiffies(end))) {
> +			blk_mq_delay_run_hw_queue(hctx, 0);
> +			break;

Minor nit: you could "return 1;" directly here.

> +		}
>  	} while (ret == 1);
>  
>  	return ret;

Otherwise, looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
