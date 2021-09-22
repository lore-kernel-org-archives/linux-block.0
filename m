Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D3C610A1
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhIVMXK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:23:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9756 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhIVMXJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:23:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDy701J3MzWCST;
        Wed, 22 Sep 2021 20:20:28 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 20:21:27 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 22 Sep 2021 20:21:26 +0800
Subject: Re: [patch v8 3/7] nbd: check sock index in nbd_read_stat()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-4-yukuai3@huawei.com>
 <7e2913ca-1089-9ab7-cfdb-5e8837d36034@huawei.com> <YUr1v8zylPOFFXTO@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <3bfd595e-20a6-c4ab-b041-9bca28a4584f@huawei.com>
Date:   Wed, 22 Sep 2021 20:21:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YUr1v8zylPOFFXTO@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/22 17:22, Ming Lei wrote:
> On Sun, Sep 19, 2021 at 06:34:28PM +0800, yukuai (C) wrote:
>> On 2021/09/16 17:33, Yu Kuai wrote:
>>> The sock that clent send request in nbd_send_cmd() and receive reply
>>> in nbd_read_stat() should be the same.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>    drivers/block/nbd.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index 614c6ab2b8fe..c724a5bd7fa4 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -746,6 +746,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>>>    		ret = -ENOENT;
>>>    		goto out;
>>>    	}
>>> +	if (cmd->index != index) {
>>> +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d from different sock %d (expected %d)",
>>> +			tag, index, cmd->index);
>>> +	}
>>>    	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
>>>    		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
>>>    			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
>>>
>>
>> Hi, Ming
>>
>> Any suggestions about this patch?
> 
> I think this one relies on nbd protocol between server and client, and
> does the protocol require both request and reply xmitted via same
> socket?
> 

I searched nbd-server source code, and found that socket_read() and
send_reply->socket_write() are always come in pares and using the same
socket.

BTW, if server reply a read request from a unexpected sock, then
nbd_read_stat() might stuck in receiving the read data. And for worse,
nbd_read_stat() can mistake the normal reply message for the read data
afterwards and corrupt client.

Thanks,
Kuai

