Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC699C433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 08:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiJZIhQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiJZIhP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 04:37:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D5FB3B0F
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 01:37:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4My2D142j7zJn8L;
        Wed, 26 Oct 2022 16:34:25 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:37:11 +0800
Subject: Re: [PATCH 12/17] nvme-pci: don't unquiesce the I/O queues in
 apple_nvme_reset_work
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-13-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <f18af4bb-6b85-c85f-ed0f-d2b9621fb264@huawei.com>
Date:   Wed, 26 Oct 2022 16:37:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221025144020.260458-13-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/25 22:40, Christoph Hellwig wrote:
> apple_nvme_reset_work schedules apple_nvme_remove, to be called, which
> will call apple_nvme_disable and unquiesce the I/O queues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/apple.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 14bee207316a0..44e7daf93e19c 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1154,7 +1154,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
>   	nvme_get_ctrl(&anv->ctrl);
>   	apple_nvme_disable(anv, false);
Same suggestion as the previous patch:
	apple_nvme_disable(anv, true);
