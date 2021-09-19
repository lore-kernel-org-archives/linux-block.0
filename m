Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFFC433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE3261052
	for <linux-block@archiver.kernel.org>; Sun, 19 Sep 2021 10:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhISKf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Sep 2021 06:35:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19993 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhISKf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Sep 2021 06:35:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HC3qJ1zD7zbm1c;
        Sun, 19 Sep 2021 18:30:20 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Sun, 19 Sep 2021 18:34:29 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sun, 19 Sep 2021 18:34:29 +0800
Subject: Re: [patch v8 3/7] nbd: check sock index in nbd_read_stat()
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-4-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7e2913ca-1089-9ab7-cfdb-5e8837d36034@huawei.com>
Date:   Sun, 19 Sep 2021 18:34:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210916093350.1410403-4-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/16 17:33, Yu Kuai wrote:
> The sock that clent send request in nbd_send_cmd() and receive reply
> in nbd_read_stat() should be the same.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/block/nbd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 614c6ab2b8fe..c724a5bd7fa4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -746,6 +746,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>   		ret = -ENOENT;
>   		goto out;
>   	}
> +	if (cmd->index != index) {
> +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d from different sock %d (expected %d)",
> +			tag, index, cmd->index);
> +	}
>   	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
>   		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
>   			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
> 

Hi, Ming

Any suggestions about this patch?

Thanks,
Kuai
