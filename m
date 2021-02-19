Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77355C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Feb 2021 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF9064DFD
	for <linux-block@archiver.kernel.org>; Fri, 19 Feb 2021 09:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBSJhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Feb 2021 04:37:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2589 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSJhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Feb 2021 04:37:13 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DhmZV3HHQz67p2T;
        Fri, 19 Feb 2021 17:32:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 10:36:28 +0100
Received: from [10.47.6.112] (10.47.6.112) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Feb
 2021 09:36:27 +0000
Subject: Re: use-after-free access in bt_iter()
To:     <pragalla@codeaurora.org>
CC:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <evgreen@google.com>, <linux-block@vger.kernel.org>,
        <stummala@codeaurora.org>, Ming Lei <ming.lei@redhat.com>
References: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
 <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
 <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
 <bbed52ea0c788b07ca68142bd86a07df@codeaurora.org>
 <5ab6e628-6c93-618a-a10b-fe0df1ab4a40@huawei.com>
 <9ace4c26c47e84c3c6a1c68ef1a193f8@codeaurora.org>
 <b859618aeac58bd9bb620d7ebdb24b90@codeaurora.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <28be6446-7e06-b03c-a373-39c5eef89c8a@huawei.com>
Date:   Fri, 19 Feb 2021 09:34:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b859618aeac58bd9bb620d7ebdb24b90@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.112]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/02/2021 06:22, pragalla@codeaurora.org wrote:
>>>>
>>>
> Hi John,
> 
> we ran the stability with the above patch
> (https://lore.kernel.org/linux-block/1608203273-170555-2-git-send-email-john.garry@huawei.com/) 
> 
> with switching the io-schedulers in b/w for ~88hrs on 2 devices, we 
> didn't notice any crash/issue.
> 

Oh, good. I assume that this is same test which you were reporting 
crashes on previously.

So we still have the issue of changing IO scheduler and the tagset iters 
holding old references to tags. I tried Bart's idea to deal with the 
request queue tagset iter, and it seems to work, but not sure if 
acceptable. And also I might have a solution for blk_mq_tagset_busy_iter().

However I am not sure if these are seen in real-life, and whether the 
patch you tested is good enough for now.

Let me look at this again and I will report back.

Thanks very much,
John

>>> Do you have a full kernel log for your crash? 

