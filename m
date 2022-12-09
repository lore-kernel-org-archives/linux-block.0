Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252B1C4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 01:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLIBvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLIBvF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 20:51:05 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604AF9232D;
        Thu,  8 Dec 2022 17:51:04 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NSv5Q5rP4zqSqH;
        Fri,  9 Dec 2022 09:46:50 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 09:51:02 +0800
Subject: Re: [PATCH] blktrace: Fix output non-blktrace event when blk_classic
 option enabled
To:     Jens Axboe <axboe@kernel.dk>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <acme@redhat.com>, <mingo@elte.hu>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221122040410.85113-1-yangjihong1@huawei.com>
 <e5654353-9850-beb5-cf72-7a7473a14743@huawei.com>
 <2dab17f3-65de-e237-4374-7040d945404c@kernel.dk>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <ab47346d-9c36-c5aa-b04c-20507a7f354c@huawei.com>
Date:   Fri, 9 Dec 2022 09:51:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2dab17f3-65de-e237-4374-7040d945404c@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 2022/12/9 0:26, Jens Axboe wrote:
> Get your company email fixed so that messages don't get marked as spam,
> that would help ensure your patches are more visible.

OK, I'll consult with the relevant department of our company about this 
issue.

Thanks,
Yang
