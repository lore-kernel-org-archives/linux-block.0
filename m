Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061BC35247
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 02:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3E32086A
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 02:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBDC26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:28:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbgBDC25 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 21:28:57 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BDF6794BC6A9C7913AE0;
        Tue,  4 Feb 2020 10:28:55 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Feb 2020
 10:28:54 +0800
Subject: Re: [v2] nbd: add a flush_workqueue in nbd_start_device
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <mchristi@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
References: <20200122031857.5859-1-sunke32@huawei.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <aaa74a5a-3213-7b97-7cc4-89686d985ff2@huawei.com>
Date:   Tue, 4 Feb 2020 10:28:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122031857.5859-1-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

ÔÚ 2020/1/22 11:18, Sun Ke Ð´µÀ:
> When kzalloc fail, may cause trying to destroy the
> workqueue from inside the workqueue.
> 
> If num_connections is m (2 < m), and NO.1 ~ NO.n
> (1 < n < m) kzalloc are successful. The NO.(n + 1)
> failed. Then, nbd_start_device will return ENOMEM
> to nbd_start_device_ioctl, and nbd_start_device_ioctl
> will return immediately without running flush_workqueue.
> However, we still have n recv threads. If nbd_release
> run first, recv threads may have to drop the last
> config_refs and try to destroy the workqueue from
> inside the workqueue.
> 
> To fix it, add a flush_workqueue in nbd_start_device.
> 
> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   drivers/block/nbd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..78181908f0df 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1265,6 +1265,16 @@ static int nbd_start_device(struct nbd_device *nbd)
>   		args = kzalloc(sizeof(*args), GFP_KERNEL);
>   		if (!args) {
>   			sock_shutdown(nbd);
> +			/*
> +			 * If num_connections is m (2 < m),
> +			 * and NO.1 ~ NO.n(1 < n < m) kzallocs are successful.
> +			 * But NO.(n + 1) failed. We still have n recv threads.
> +			 * So, add flush_workqueue here to prevent recv threads
> +			 * dropping the last config_refs and trying to destroy
> +			 * the workqueue from inside the workqueue.
> +			 */
> +			if (i)
> +				flush_workqueue(nbd->recv_workq);
>   			return -ENOMEM;
>   		}
>   		sk_set_memalloc(config->socks[i]->sock->sk);
> 

