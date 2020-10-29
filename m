Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E465C55179
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 07:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BB9218AC
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 07:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SMVH32pB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgJ2Hab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:30:31 -0400
Received: from m12-11.163.com ([220.181.12.11]:54485 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgJ2H3D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 03:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=qvOfV
        N76kvCqakXlOnB+OC6oakS2ax+nlaKu5gpN3bQ=; b=SMVH32pBrfLcWweNvjMjR
        Pu5v7RxdfYsLlte9wAcc5PxrnmKKwEWIySsmkh1CFaWB+0qknZC640szZ259aPGF
        NXChF8gHzKpu/E6xY+KK3haXV43BV5rCqoNvMyho99xZy9t+NsuEX/tMw07/W2nh
        rBvOGdCuvgojd/U8QeAu8g=
Received: from [172.20.145.84] (unknown [223.112.105.132])
        by smtp7 (Coremail) with SMTP id C8CowAAHR4NBM5pfswjLFw--.19478S2;
        Thu, 29 Oct 2020 11:13:06 +0800 (CST)
Subject: Re: [PATCH] nbd: don't update block size after device is started
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Jan Kara <jack@suse.cz>, yanhaishuang@cmss.chinamobile.com
References: <20201028072434.1922108-1-ming.lei@redhat.com>
From:   lining <lining2020x@163.com>
Message-ID: <4145dd3d-dc1b-9833-9be6-9550eb2fcd13@163.com>
Date:   Thu, 29 Oct 2020 11:13:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201028072434.1922108-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAHR4NBM5pfswjLFw--.19478S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4fXryrXF47GF4kGrykZrb_yoW8Zw18pF
        yUCayrGrW8Wa1DXa1jvr90grW5K34vk340gry7A3409r93tr9ayr4kta42qrWDtr95JFsx
        uFsagFWIv3WxXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jldgZUUUUU=
X-Originating-IP: [223.112.105.132]
X-CM-SenderInfo: polqx0bjsqjir06rljoofrz/1tbifBXMNlr6nItafQABsC
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tested on Ubuntu 20.04.1 LTS with kernel 5.10.0-rc1+, it works fine.

Tested-by: lining <lining2020x@163.com>

ÔÚ 2020/10/28 15:24, Ming Lei Ð´µÀ:
> Mounted NBD device can be resized, one use case is rbd-nbd.
> 
> Fix the issue by setting up default block size, then not touch it
> in nbd_size_update() any more. This kind of usage is aligned with loop
> which has same use case too.
> 
> Reported-by: lining <lining2020x@163.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/block/nbd.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 3c9485acdd81..e13ce0f75f80 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -296,7 +296,7 @@ static void nbd_size_clear(struct nbd_device *nbd)
>   	}
>   }
>   
> -static void nbd_size_update(struct nbd_device *nbd)
> +static void nbd_size_update(struct nbd_device *nbd, bool start)
>   {
>   	struct nbd_config *config = nbd->config;
>   	struct block_device *bdev = bdget_disk(nbd->disk, 0);
> @@ -313,7 +313,8 @@ static void nbd_size_update(struct nbd_device *nbd)
>   	if (bdev) {
>   		if (bdev->bd_disk) {
>   			bd_set_nr_sectors(bdev, nr_sectors);
> -			set_blocksize(bdev, config->blksize);
> +			if (start)
> +				set_blocksize(bdev, config->blksize);
>   		} else
>   			set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
>   		bdput(bdev);
> @@ -328,7 +329,7 @@ static void nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
>   	config->blksize = blocksize;
>   	config->bytesize = blocksize * nr_blocks;
>   	if (nbd->task_recv != NULL)
> -		nbd_size_update(nbd);
> +		nbd_size_update(nbd, false);
>   }
>   
>   static void nbd_complete_rq(struct request *req)
> @@ -1308,7 +1309,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>   		args->index = i;
>   		queue_work(nbd->recv_workq, &args->work);
>   	}
> -	nbd_size_update(nbd);
> +	nbd_size_update(nbd, true);
>   	return error;
>   }
>   
> 

