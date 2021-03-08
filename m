Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B4C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60293651CA
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 11:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCHLVT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 06:21:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2652 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhCHLU7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 06:20:59 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvG2w4069z67wh2;
        Mon,  8 Mar 2021 19:15:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 12:20:58 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 11:20:56 +0000
Subject: Re: [RFC PATCH v3 1/3] blk-mq: Clean up references to old requests
 when freeing rqs
To:     Khazhy Kumykov <khazhy@google.com>
CC:     <hare@suse.de>, Bart Van Assche <bvanassche@acm.org>,
        <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, <hch@lst.de>,
        <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-2-git-send-email-john.garry@huawei.com>
 <CACGdZY+Qft=55Si5Lmjh1RmVb5Roe-KTsrJHJLz0opSXuesTBg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <03e09428-b4e1-c77c-2e00-5b6fd53bf894@huawei.com>
Date:   Mon, 8 Mar 2021 11:18:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CACGdZY+Qft=55Si5Lmjh1RmVb5Roe-KTsrJHJLz0opSXuesTBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.214]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/03/2021 02:52, Khazhy Kumykov wrote:
> On Fri, Mar 5, 2021 at 7:20 AM John Garry <john.garry@huawei.com> wrote:
>>
>> It has been reported many times that a use-after-free can be intermittently
>> found when iterating busy requests:
>>
>> - https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/
>> - https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
>> - https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/
>>
>> The issue is that when we switch scheduler or change queue depth, there may
>> be references in the driver tagset to the stale requests.
>>
>> As a solution, clean up any references to those requests in the driver
>> tagset. This is done with a cmpxchg to make safe any race with setting the
>> driver tagset request from another queue.
> 
> I noticed this crash recently when running blktests on a "debug"
> config on a 4.15 based kernel (it would always crash), and backporting
> this change fixes it. (testing on linus's latest tree also confirmed
> the fix, with the same config). I realize I'm late to the
> conversation, but appreciate the investigation and fixes :)

Good to know. I'll explicitly cc you on further versions.

Thanks,
John

