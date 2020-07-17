Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04763C433E6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 01:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD12120838
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 01:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQBhQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:37:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgGQBhQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 21:37:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 70E8D18C6EFF26CF5C9E;
        Fri, 17 Jul 2020 09:37:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.91) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 09:37:12 +0800
Subject: Re: [PATCH -next] rsxx: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200716090432.13691-1-miaoqinglang@huawei.com>
 <e4caa1de-db2c-c2f4-d1e8-fef7073a52ea@kernel.dk>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <c19c9e32-4b31-bcf1-df45-a29220e7e6cc@huawei.com>
Date:   Fri, 17 Jul 2020 09:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e4caa1de-db2c-c2f4-d1e8-fef7073a52ea@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


在 2020/7/16 23:45, Jens Axboe 写道:
> On 7/16/20 3:04 AM, Qinglang Miao wrote:
>> From: Liu Shixin <liushixin2@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> None of these apply against the 5.9 block tree, looks like some
> read -> read_iter conversion has happened in another branch that
> I'm not privy to.

Hi Jens,

     Sorry I didn't mention it in commit log, but this patch is based  
on linux-next where commit <4d4901c6d7> has switched over direct  
seq_read method calls to seq_read_iter, this is why there's conflict in  
your apply.

     Do you think I should send a new patch based on 5.8rc?

Thanks.



