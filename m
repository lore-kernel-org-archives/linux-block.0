Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A777DC4321A
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 22:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CF664FA0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 22:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBEWTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:19:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2510 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhBEObN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 09:31:13 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DXKtg4Bs6z67kVq;
        Sat,  6 Feb 2021 00:02:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 17:08:39 +0100
Received: from [10.210.170.68] (10.210.170.68) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 16:08:38 +0000
Subject: Re: use-after-free access in bt_iter()
To:     <pragalla@codeaurora.org>
CC:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <evgreen@google.com>, <linux-block@vger.kernel.org>,
        <stummala@codeaurora.org>, Ming Lei <ming.lei@redhat.com>
References: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
 <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
 <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
 <bbed52ea0c788b07ca68142bd86a07df@codeaurora.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5ab6e628-6c93-618a-a10b-fe0df1ab4a40@huawei.com>
Date:   Fri, 5 Feb 2021 16:07:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <bbed52ea0c788b07ca68142bd86a07df@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.68]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

- bouncing jianchao.w.wang@oracle.com

>>
>>> Some time ago you replied the following to an email from me with a
>>> suggestion for a fix: "Please let me consider it a bit more." Are you
>>> still working on a fix?
>>
>> Unfortunately I have not had a chance, sorry. But I can look again.
>>
>> So I have only seen KASAN use-after-free's myself, but never an actual
>> oops. IIRC, someone did report an oops.
>>
> Hi John,
> 
>> @Pradeep, do you have a reliable re-creator? I noticed the timeout
>> handler stackframe in your mail, so I guess not. However, as an
>> experiment, could you test:
>> https://lore.kernel.org/linux-block/1608203273-170555-2-git-send-email-john.garry@huawei.com/ 
>>
>>
> Yes, i don't have a reliable re-creator. The oops was noticed as a part 
> of stability testing and
> was not an intentional try. This was noticed couple of times.
> Please share the steps (if any) to easy hit or to exercise this path 
> more frequently.
> Meanwhile, i will go with the usual stability procedure. i will update 
> the results here later.
> 

Do you have a full kernel log for your crash?

So there are different flavors of this issue, and you reported a crash 
from blk_mq_queue_tag_busy_iter().

If you check:
https://lore.kernel.org/linux-block/76190c94-c5c1-9553-5509-9969fc323544@huawei.com/

You can see how I artificially trigger an issue in 
blk_mq_queue_tag_busy_iter().

>> This should fix the common issue. But no final solution to issues
>> discussed from patch 2/2, which is more exotic.
>>
>> BTW, is this the same Pradeep who reported:
>> https://lore.kernel.org/linux-block/1606402925-24420-1-git-send-email-ppvk@codeaurora.org/ 
>>

Thanks,
John

