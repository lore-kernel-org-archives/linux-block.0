Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD4BC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 12:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjDRMCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 08:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjDRL7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 07:59:51 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B01BE
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 04:57:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230418114947euoutp025730843f67f24d5a9fdc596a0ce4bcac~XBRg7qmg-0030100301euoutp02e
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 11:49:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230418114947euoutp025730843f67f24d5a9fdc596a0ce4bcac~XBRg7qmg-0030100301euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681818587;
        bh=1HWRoVNY6q5+ArJU2XMe3OlC8mWlJyYI99hjMR/uEiQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SIc1nyYjbTsGo6Szxjy9azLXYQA2xRkV14p+Zv/lEqxVaN0HBKS+5nz4K7IHu1Ha/
         Qv+pctZVZL77uDEa9ThP5Qiy3Fy3vzKX/vhlPCkbrHFExr6y4cXBeNg3VG8IZuXg1k
         hdNRBrb2ArCiBsSmFsvDK+GzY8MYCvmfCet5ZQZM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230418114947eucas1p2e11a3603606e470ae7c20847f3410a87~XBRgx6oVs0457604576eucas1p29;
        Tue, 18 Apr 2023 11:49:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 57.93.09503.BD38E346; Tue, 18
        Apr 2023 12:49:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230418114947eucas1p2350d60e2643c11bd01964805ef9baded~XBRgfQ4Va0364503645eucas1p2l;
        Tue, 18 Apr 2023 11:49:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230418114946eusmtrp269063632e8d3ec01b9e8ffa4e5691506~XBRgem8sK3225732257eusmtrp2M;
        Tue, 18 Apr 2023 11:49:46 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-52-643e83dbfd57
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.B2.22108.AD38E346; Tue, 18
        Apr 2023 12:49:46 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230418114946eusmtip2317db627b800edf886155851b80b68ab~XBRgLQEBy1020310203eusmtip2n;
        Tue, 18 Apr 2023 11:49:46 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 18 Apr 2023 12:49:46 +0100
Date:   Tue, 18 Apr 2023 13:41:15 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <yukuai3@huawei.com>,
        <p.raghav@samsung.com>
Subject: Re: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Message-ID: <20230418114115.zhcabb5lelbeyyeu@blixen>
MIME-Version: 1.0
In-Reply-To: <20230412084730.51694-2-kch@nvidia.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87q3m+1SDF685LdYfbefzWLah5/M
        Fr/Pnme2+Nt1j8ni6dVZTBZ7b2lb7JvlaTFnIZsDh8flK94eLUfesnpcPlvq0dv8js1jZ+t9
        Vo/Pm+Q82g90MwWwR3HZpKTmZJalFunbJXBlHH0rWHBbvGLJ0gksDYxfhLsYOTkkBEwkZtz+
        zNbFyMUhJLCCUeLIsjWsIAkhgS+MEj9PW0LYnxkllv13hmno+/ebCaJhOaPE6RNfGeGKJj3U
        g0hsYZS4OrePGSTBIqAqMfHQbfYuRg4ONgEticZOdpCwiIC6xNQDPawg9cwCPxkl7j34AzZI
        WMBN4tb3d2BX8AJte7DpHhOELShxcuYTFhCbEyi+vG8ZG8RFShINm8+wQNi1EnubD7CDDJUQ
        +MIhcf3tdFaIhIvErmU7mCFsYYlXx7ewQ9gyEv93zmeCsKslnt74zQzR3MIo0b9zPRvI1RIC
        1hJ9Z3JAapgFMiSe/mmFWuYo8ePOLiaIEj6JG28FIUr4JCZtm84MEeaV6GgTgqhWk1h97w0L
        RFhG4twnvgmMSrOQPDYLyXwIW0diwe5PbLOAOpgFpCWW/+OAMDUl1u/SX8DIuopRPLW0ODc9
        tdgwL7Vcrzgxt7g0L10vOT93EyMwTZ3+d/zTDsa5rz7qHWJk4mA8xCjBwawkwnvG1SpFiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA5PCSqU0m5XZj05e
        nKKrXv5rMf/KH48M/RuijiX/2h63Wf3hRaVzIrKTFmQ2b+t/u8iKb0/8Se0r7X7PYv6WVJzl
        mfRIlT2uk29/0cNfQiFONkIKvOd3WGp3/zm54+pXbeMX+5fHiM6ufBB+/EZlSdqzi1vPbfp6
        y7dZt0Z9/0+xxSdXZlus+N8ouOPOs94FolWXNmwx7zltYrz/4JyX5jcnWMYfsJywIFB6147G
        9143tdvErq3SW+h77Mne6l2PFr0qWWAT5nlBO5J9GWf53UU/dZ/39OfUh21PLNnp+rlKq/h+
        /dmjZd/ezHv+Py0j+BH/u2fndUL+5EavWJYivnCHyzeRf28qPJ/0TDEVar+0U4mlOCPRUIu5
        qDgRALT209PCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7q3mu1SDG59MLdYfbefzWLah5/M
        Fr/Pnme2+Nt1j8ni6dVZTBZ7b2lb7JvlaTFnIZsDh8flK94eLUfesnpcPlvq0dv8js1jZ+t9
        Vo/Pm+Q82g90MwWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTm
        ZJalFunbJehl7H93kL1gtmjFnU/v2RsYzwp2MXJySAiYSPT9+83UxcjFISSwlFHiRe9uRoiE
        jMTGL1dZIWxhiT/Xutggij4ySuxsucYI4WxhlNi+9wELSBWLgKrExEO32bsYOTjYBLQkGjvZ
        QcIiAuoSUw/0sILUMwv8ZJS49+AP2AZhATeJW9/fgW3gBTrjwaZ7TCC2kECsxLwvM5gh4oIS
        J2c+AZvPLKAjsWD3JzaQ+cwC0hLL/3GAhDmBWpf3LWODOFRJomHzGRYIu1ai89VptgmMwrOQ
        TJqFZNIshEkLGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbhtmM/N+9gnPfqo94hRiYO
        xkOMEhzMSiK8Z1ytUoR4UxIrq1KL8uOLSnNSiw8xmgJDYiKzlGhyPjAR5JXEG5oZmBqamFka
        mFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MK2pcvxgYmGT+iJ0TfGnxx5X//G+7Sy8
        up2hjGvNMe203xe+9VvcnH84tH+CRdXCJevVZ5l4r/ScJs+x+fLBVz/6m+tjd9uoOIpM2NWe
        bCx4ynH3KQ+Bdwc5qkM8lZNK1pepiF5S3vvY7Ypa5JG6b7LeKrsyjppFJBuXhq3j0peePfFn
        MbvOl6U3eefkKyW+XbrlwrRtFmuUV1+/IS72W/rKDa/+t0o/mmuKJ0uLiObsVVAKuCdosdD6
        r6/266BS0/Tewojfd2Q8OJdNy2cTDb2mLJeY9Ly+tsPw3VX19IBfF9Z3Mp/rdVQ7OLfqvX6l
        R35DZGnCokhd+UgGscvvgj5JuHz9qcGzjavZ5UyNEktxRqKhFnNRcSIAK4a+LkwDAAA=
X-CMS-MailID: 20230418114947eucas1p2350d60e2643c11bd01964805ef9baded
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5975_"
X-RootMTR: 20230418114947eucas1p2350d60e2643c11bd01964805ef9baded
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230418114947eucas1p2350d60e2643c11bd01964805ef9baded
References: <20230412084730.51694-1-kch@nvidia.com>
        <20230412084730.51694-2-kch@nvidia.com>
        <CGME20230418114947eucas1p2350d60e2643c11bd01964805ef9baded@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5975_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> +static bool g_nowait = true;
> +module_param_named(nowait, g_nowait, bool, 0444);
> +MODULE_PARM_DESC(virt_boundary, "Set QUEUE_FLAG_NOWAIT irrespective of queue mode. Default: True");
Copy paste error. MODULE_PARM_DESC(nowait,...
> +
>  static bool g_virt_boundary = false;
>  module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
>  MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
> @@ -983,11 +990,11 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
>  
>  	spin_unlock_irq(&nullb->lock);
>  
> -	t_page = null_alloc_page();
> +	t_page = null_alloc_page(nullb->dev->nowait ? GFP_NOWAIT : GFP_NOIO);
>  	if (!t_page)
>  		goto out_lock;
>  
> -	if (radix_tree_preload(GFP_NOIO))
> +	if (radix_tree_preload(nullb->dev->nowait ? GFP_NOWAIT : GFP_NOIO))

This is not correct. You need to use radix_tree_maybe_preload because
GFP_NOWAIT should not block and this WARN_ON_ONCE flag will trigger in
radix_tree_preload:

/* Warn on non-sensical use... */
WARN_ON_ONCE(!gfpflags_allow_blocking(gfp_mask));

I also verified this locally with your patch and while doing a simple fio 
write with setting memory_backed=1.

WARNING: CPU: 2 PID: 515 at lib/radix-tree.c:366 radix_tree_preload+0x12/0x20
...
RIP: 0010:radix_tree_preload+0x12/0x20
<snip>
Call Trace:
 <TASK>
 null_insert_page+0x186/0x4e0 [null_blk]
 null_transfer+0x588/0x990 [null_blk]
<snip>

>  		goto out_freepage;
>  
>  	spin_lock_irq(&nullb->lock);
> @@ -2093,6 +2100,11 @@ static int null_add_dev(struct nullb_device *dev)
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
>  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
>  
> +	if (dev->nowait)
> +		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, nullb->q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, nullb->q);
> +
>  	mutex_lock(&lock);
>  	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
>  	if (rv < 0) {
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index eb5972c50be8..1d7af446d728 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -107,6 +107,7 @@ struct nullb_device {
>  	unsigned int index; /* index of the disk, only valid with a disk */
>  	unsigned int mbps; /* Bandwidth throttle cap (in MB/s) */
>  	bool blocking; /* blocking blk-mq device */
> +	bool nowait; /* to set QUEUE_FLAG_NOWAIT on device queue */
>  	bool use_per_node_hctx; /* use per-node allocation for hardware context */
>  	bool power; /* power on/off the device */
>  	bool memory_backed; /* if data is stored in memory */
> -- 
> 2.29.0
> 

-- 
Pankaj Raghav

------FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5975_
Content-Type: text/plain; charset="utf-8"


------FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5975_--
