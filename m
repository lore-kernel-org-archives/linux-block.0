Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B19C43334
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 01:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiGABvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 21:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGABvX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 21:51:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A0617599
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:51:22 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LYyks3fS6zTgCW;
        Fri,  1 Jul 2022 09:47:49 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 09:51:20 +0800
Subject: Re: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, <tj@kernel.org>, <jack@suse.cz>,
        <hch@lst.de>
CC:     <linux-block@vger.kernel.org>
References: <20220629070917.3113016-1-yanaijie@huawei.com>
 <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
 <da262064-3952-0ded-03e3-9c0246960603@huawei.com>
 <9a9e6a5f-d03d-fbb5-71df-c4e2e35e898d@acm.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <6d604c3a-1321-d9ae-e0da-b8e6173c1932@huawei.com>
Date:   Fri, 1 Jul 2022 09:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9a9e6a5f-d03d-fbb5-71df-c4e2e35e898d@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/1 2:03, Bart Van Assche wrote:
> On 6/30/22 01:16, John Garry wrote:
>> Just wondering - are there any of my mails in your spam folder?
> 
> This morning I found the following email from you in my spam folder:
> 
> https://lore.kernel.org/linux-scsi/82e30007-1ffc-92e4-38b5-eaf7dd2e316d@huawei.com/ 
> 
> 
> I'm going to reinstall my email filter that keeps Huawei emails out of 
> the spam folder.
> 
> If the following information has not yet been shared with your IT 
> department, please share it: https://support.google.com/a/answer/174124
> 
> Bart.
> .

Sorry to bring your guys so many troubles.

And thanks Bart. Yes our IT department is planning to support DKIM. But
this needs time and they have to consider the performance issues. And we
are going to try a workaround approach before they fix it entirely.

Thanks you so much again.

Jason.
