Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 03:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49FF6112E
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 03:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhINDMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:12:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15409 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbhINDMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 23:12:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7pDJ74X3zR5xN;
        Tue, 14 Sep 2021 11:07:12 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:11:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:11:06 +0800
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com> <YT/2z4PSeW5oJWMq@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
Date:   Tue, 14 Sep 2021 11:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YT/2z4PSeW5oJWMq@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/14 9:11, Ming Lei wrote:
> On Thu, Sep 09, 2021 at 10:12:55PM +0800, Yu Kuai wrote:
>> blk_mq_tag_to_rq() can only ensure to return valid request in
>> following situation:
>>
>> 1) client send request message to server first
>> submit_bio
>> ...
>>   blk_mq_get_tag
>>   ...
>>   blk_mq_get_driver_tag
>>   ...
>>   nbd_queue_rq
>>    nbd_handle_cmd
>>     nbd_send_cmd
>>
>> 2) client receive respond message from server
>> recv_work
>>   nbd_read_stat
>>    blk_mq_tag_to_rq
>>
>> If step 1) is missing, blk_mq_tag_to_rq() will return a stale
>> request, which might be freed. Thus convert to use
>> blk_mq_find_and_get_req() to make sure the returned request is not
>> freed.
> 
> But NBD_CMD_INFLIGHT has been added for checking if the reply is
> expected, do we still need blk_mq_find_and_get_req() for covering
> this issue? BTW, request and its payload is pre-allocated, so there
> isn't real use-after-free.

Hi, Ming

Checking NBD_CMD_INFLIGHT relied on the request founded by tag is valid,
not the other way round.

nbd_read_stat
  req = blk_mq_tag_to_rq()
  cmd = blk_mq_rq_to_pdu(req)
  mutex_lock(cmd->lock)
  checking NBD_CMD_INFLIGHT

The checking doesn't have any effect on blk_mq_tag_to_rq().

Thanks,
Kuai
