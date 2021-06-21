Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DE8C49361
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 06:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE1761153
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 06:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUGYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 02:24:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:63827 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhFUGYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 02:24:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210621062209euoutp014c9dde14c4da74eba9b36db9ccaaa9ba~KhLUtpE661300613006euoutp01V
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 06:22:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210621062209euoutp014c9dde14c4da74eba9b36db9ccaaa9ba~KhLUtpE661300613006euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624256529;
        bh=gbPqD+sBunTmpz3Er2hHmw4y0PrpnmbBVQ75wBTV0T8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EE2tnOWwCsHngg7ACw8jWkqxp40qYYrWvo7oeUrhyC2jlqekJUnKnGbXEPlJpRfvg
         LFNAqTGMsBHcpaONmejYIeHT0LZWNdSkoQmC7tJ+CWqHWoNgYGXDVpaLCeSXuFFIsa
         4RKRlnECl2AeOid1pB1XNXnFmsQLCbvuT91kJ2xA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210621062209eucas1p159284ab1fc51ddd67a945aa9b4a9d044~KhLUmXMs80238602386eucas1p1I;
        Mon, 21 Jun 2021 06:22:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6E.9B.42068.11030D06; Mon, 21
        Jun 2021 07:22:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753~KhLULC0MI0792907929eucas1p2e;
        Mon, 21 Jun 2021 06:22:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210621062208eusmtrp228c98a69bd75086e64422a2276def14a~KhLUKVTmY2100721007eusmtrp2k;
        Mon, 21 Jun 2021 06:22:08 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-d3-60d0301186b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E4.03.20981.01030D06; Mon, 21
        Jun 2021 07:22:08 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210621062208eusmtip2f88fa1e93399c2450d16baf62235c854~KhLTxlLPi1379813798eusmtip2d;
        Mon, 21 Jun 2021 06:22:08 +0000 (GMT)
Subject: Re: [PATCH 2/2] mmc: switch to blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1c5b5018-f7ca-609b-b607-827cedc161e6@samsung.com>
Date:   Mon, 21 Jun 2021 08:22:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616053934.880951-3-hch@lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzneV1BgwsJBlMXslmsXH2UyWLvLW2L
        I//7GS2Orw13YPG4c20Pm8fumw1sHp83yQUwR3HZpKTmZJalFunbJXBl9J2czFgwxahi6pNt
        bA2MjzW7GDk5JARMJP5e2MHWxcjFISSwglGi4+VzdpCEkMAXRolZd5khEp8ZJTacucbYxcgB
        1rHuRQZEfDmjRG/DAqjuj0BO13FWkG5hAUuJSedaWUBsEQEPib2n34JNZRawkji4r50NxGYT
        MJToetsFZvMK2El8P7SDCcRmEVCVmPhvF9gcUYFkiffzZrBC1AhKnJz5BGwmJ1DvzzMHoWbK
        SzRvnc0MYYtL3HoynwnkIAmBLRwSj/9eZYH400Xi36qHbBC2sMSr41vYIWwZif87YRqaGSUe
        nlvLDuH0MEpcbprBCFFlLXHn3C82kP+ZBTQl1u/ShwSFo8TvbUUQJp/EjbeCEDfwSUzaNp0Z
        Iswr0dEmBDFDTWLW8XVwWw9euMQ8gVFpFpLPZiH5ZhaSb2YhrF3AyLKKUTy1tDg3PbXYKC+1
        XK84Mbe4NC9dLzk/dxMjMJWc/nf8yw7G5a8+6h1iZOJgPMQowcGsJMLLmXkmQYg3JbGyKrUo
        P76oNCe1+BCjNAeLkjhv0pY18UIC6YklqdmpqQWpRTBZJg5OqQYmh7BnV+8pxJS0XWOQd3rE
        seCBo7tDqZ73XNsJH7/5Fzwu21y0a9/KKsuEXV85uvnOn+5dLMEUomfucbkz0vISj2PeXLtD
        vmoyT50MUjoT8pMeJp/RyWaxfZu6IeQb55F+TrbXtzXu7WwzufbhYOZXKZ/Gh4vvivmf8CiK
        brq2TcfjwG9dict/rLNXvWc+oRbOr2if+Fl/5j/bJ98Fm7gOL6wVLPyvUG5neuj9z3cNPfO3
        iC96+OnE6YijH7xbM79+Od1wvTsld5For0ZMxCYL7ZXN8q8Xr7S43TCv4h9/ssceP4Z85UWq
        iXO2fl1xUfnl2eypZ3Z+YRY5bqPw0P/16//n0jUi59yYmM+cq+OsxFKckWioxVxUnAgAPRP3
        EZQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7oCBhcSDB70qVusXH2UyWLvLW2L
        I//7GS2Orw13YPG4c20Pm8fumw1sHp83yQUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY
        6hkam8daGZkq6dvZpKTmZJalFunbJehl9J2czFgwxahi6pNtbA2MjzW7GDk4JARMJNa9yOhi
        5OIQEljKKHG2ZQ5rFyMnUFxG4uS0BihbWOLPtS42iKL3jBJn1vewgSSEBSwlJp1rZQGxRQQ8
        JPaefssOYjMLWEkc3NcOViMkEC5xedJqRhCbTcBQouttF1icV8BO4vuhHUwgNouAqsTEf7vA
        lokKJEv8XN8OVSMocXLmE7D5nEC9P88chJpvJjFv80NmCFteonnrbChbXOLWk/lMExiFZiFp
        n4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJ5tx35u2cG48tVHvUOM
        TByMhxglOJiVRHg5M88kCPGmJFZWpRblxxeV5qQWH2I0BfpnIrOUaHI+MH7zSuINzQxMDU3M
        LA1MLc2MlcR5TY6siRcSSE8sSc1OTS1ILYLpY+LglGpgil3DHnT6yjvTp2nHEzx2CBVNuXop
        pGVrPt/hb08MZ8kdCfy0nN/+uHmgR+SJh3YG1ztEGdpTlrqe7Wy3fKk+6cRTdf39ivwJWXIf
        KuJN5hZMuGjKMH3+ucPr6x93pat0pud1PtxbYeC8Xit3/89HTVsC7nkrNK3WWi40+552qtGV
        nmbB8hnHD95Ouq7h8InB/mlVQkHeiclvK564nK25lFUlVa+kWOCafuB6bodORO3Z/x9OMRww
        m3f36U6Vh+cb/z6QtXAqVvv06e358rC/v28Kzd45YedFbZM76x84Hwn8I/lm4TnOrIiPhQ1l
        y+1+NM7c3Xf07+1Zcwoe3P/TMT0ncpMK2wveA4f1qz8/rFNiKc5INNRiLipOBAAUy6faJwMA
        AA==
X-CMS-MailID: 20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753
References: <20210616053934.880951-1-hch@lst.de>
        <20210616053934.880951-3-hch@lst.de>
        <CGME20210621062208eucas1p2949c830b948c3cf7b3d636c5c5746753@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

On 16.06.2021 07:39, Christoph Hellwig wrote:
> Use the blk_mq_alloc_disk to allocate the request_queue and gendisk
> together.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch landed recently in linux-next as commit 281ea6a5bfdc ("mmc: 
switch to blk_mq_alloc_disk"). It triggers the following warning during 
boot on all my systems with MMC devices:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 10 at block/genhd.c:491 __device_add_disk+0x4e8/0x630
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 
5.13.0-rc3-00090-g281ea6a5bfdc #3542
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_freezable mmc_rescan
[<c0111844>] (unwind_backtrace) from [<c010d014>] (show_stack+0x10/0x14)
[<c010d014>] (show_stack) from [<c0b6f84c>] (dump_stack+0xa4/0xc4)
[<c0b6f84c>] (dump_stack) from [<c0127630>] (__warn+0x118/0x11c)
[<c0127630>] (__warn) from [<c01276e8>] (warn_slowpath_fmt+0xb4/0xbc)
[<c01276e8>] (warn_slowpath_fmt) from [<c052a52c>] 
(__device_add_disk+0x4e8/0x630)
[<c052a52c>] (__device_add_disk) from [<c08a8e10>] (mmc_add_disk+0x24/0x120)
[<c08a8e10>] (mmc_add_disk) from [<c08a9e68>] (mmc_blk_probe+0x420/0x65c)
[<c08a9e68>] (mmc_blk_probe) from [<c06bece4>] (really_probe+0x250/0x4dc)
[<c06bece4>] (really_probe) from [<c06beff4>] 
(driver_probe_device+0x84/0x1e4)
[<c06beff4>] (driver_probe_device) from [<c06bcc70>] 
(bus_for_each_drv+0x78/0xbc)
[<c06bcc70>] (bus_for_each_drv) from [<c06be9f4>] 
(__device_attach+0xe8/0x180)
[<c06be9f4>] (__device_attach) from [<c06bda1c>] 
(bus_probe_device+0x88/0x90)
[<c06bda1c>] (bus_probe_device) from [<c06bb5f0>] (device_add+0x4c8/0x874)
[<c06bb5f0>] (device_add) from [<c089ac6c>] (mmc_add_card+0x110/0x2d0)
[<c089ac6c>] (mmc_add_card) from [<c089ebd8>] (mmc_attach_mmc+0xc8/0x180)
[<c089ebd8>] (mmc_attach_mmc) from [<c089a5c4>] (mmc_rescan+0x2ec/0x334)
[<c089a5c4>] (mmc_rescan) from [<c014a994>] (process_one_work+0x30c/0x884)
[<c014a994>] (process_one_work) from [<c014af64>] (worker_thread+0x58/0x594)
[<c014af64>] (worker_thread) from [<c0151f34>] (kthread+0x154/0x19c)
[<c0151f34>] (kthread) from [<c010011c>] (ret_from_fork+0x14/0x38)
Exception stack(0xc1d25fb0 to 0xc1d25ff8)
...
irq event stamp: 3653
hardirqs last  enabled at (3667): [<c0100b4c>] __irq_svc+0x8c/0xb0
hardirqs last disabled at (3678): [<c0b749c4>] __schedule+0x54c/0x9dc
softirqs last  enabled at (3648): [<c0101790>] __do_softirq+0x528/0x63c
softirqs last disabled at (3641): [<c01311b8>] irq_exit+0x214/0x220
---[ end trace e60288107691b657 ]---

It looks that something is missing in this conversion.

> ---
>   drivers/mmc/core/block.c | 14 +++-----------
>   drivers/mmc/core/queue.c | 23 ++++++++++-------------
>   drivers/mmc/core/queue.h |  2 +-
>   3 files changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 947624e76c33..6652e1f1d4b2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2310,27 +2310,21 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   	 */
>   	md->read_only = mmc_blk_readonly(card);
>   
> -	md->disk = alloc_disk(perdev_minors);
> -	if (md->disk == NULL) {
> -		ret = -ENOMEM;
> +	md->disk = mmc_init_queue(&md->queue, card);
> +	if (IS_ERR(md->disk)) {
> +		ret = PTR_ERR(md->disk);
>   		goto err_kfree;
>   	}
>   
>   	INIT_LIST_HEAD(&md->part);
>   	INIT_LIST_HEAD(&md->rpmbs);
>   	md->usage = 1;
> -
> -	ret = mmc_init_queue(&md->queue, card);
> -	if (ret)
> -		goto err_putdisk;
> -
>   	md->queue.blkdata = md;
>   
>   	md->disk->major	= MMC_BLOCK_MAJOR;
>   	md->disk->first_minor = devidx * perdev_minors;
>   	md->disk->fops = &mmc_bdops;
>   	md->disk->private_data = md;
> -	md->disk->queue = md->queue.queue;
>   	md->parent = parent;
>   	set_disk_ro(md->disk, md->read_only || default_ro);
>   	md->disk->flags = GENHD_FL_EXT_DEVT;
> @@ -2379,8 +2373,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   
>   	return md;
>   
> - err_putdisk:
> -	put_disk(md->disk);
>    err_kfree:
>   	kfree(md);
>    out:
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index d600e0a4a460..cc3261777637 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -424,9 +424,10 @@ static inline bool mmc_merge_capable(struct mmc_host *host)
>    *
>    * Initialise a MMC card request queue.
>    */
> -int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
> +struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>   {
>   	struct mmc_host *host = card->host;
> +	struct gendisk *disk;
>   	int ret;
>   
>   	mq->card = card;
> @@ -464,26 +465,22 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>   
>   	ret = blk_mq_alloc_tag_set(&mq->tag_set);
>   	if (ret)
> -		return ret;
> +		return ERR_PTR(ret);
> +		
>   
> -	mq->queue = blk_mq_init_queue(&mq->tag_set);
> -	if (IS_ERR(mq->queue)) {
> -		ret = PTR_ERR(mq->queue);
> -		goto free_tag_set;
> +	disk = blk_mq_alloc_disk(&mq->tag_set, mq);
> +	if (IS_ERR(disk)) {
> +		blk_mq_free_tag_set(&mq->tag_set);
> +		return disk;
>   	}
> +	mq->queue = disk->queue;
>   
>   	if (mmc_host_is_spi(host) && host->use_spi_crc)
>   		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, mq->queue);
> -
> -	mq->queue->queuedata = mq;
>   	blk_queue_rq_timeout(mq->queue, 60 * HZ);
>   
>   	mmc_setup_queue(mq, card);
> -	return 0;
> -
> -free_tag_set:
> -	blk_mq_free_tag_set(&mq->tag_set);
> -	return ret;
> +	return disk;
>   }
>   
>   void mmc_queue_suspend(struct mmc_queue *mq)
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 3319d8ab57d0..9ade3bcbb714 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -94,7 +94,7 @@ struct mmc_queue {
>   	struct work_struct	complete_work;
>   };
>   
> -extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *);
> +struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card);
>   extern void mmc_cleanup_queue(struct mmc_queue *);
>   extern void mmc_queue_suspend(struct mmc_queue *);
>   extern void mmc_queue_resume(struct mmc_queue *);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

