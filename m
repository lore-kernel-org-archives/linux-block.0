Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C637EC2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDF7206D6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgEMLef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:34:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbgEMLee (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:34:34 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DA1B222B7CD946BCDEB2;
        Wed, 13 May 2020 12:34:32 +0100 (IST)
Received: from [127.0.0.1] (10.210.165.35) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 12:34:32 +0100
Subject: Re: [PATCH V11 00/12] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <2b4b0a75-c9c0-27de-77e8-85ada602b18f@huawei.com>
 <20200513103743.GC2038938@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b6e3525b-2c9e-2887-e654-4573cc5f9851@huawei.com>
Date:   Wed, 13 May 2020 12:33:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200513103743.GC2038938@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.35]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/05/2020 11:37, Ming Lei wrote:
>> Tip commit of
>> https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug  at
>> this moment is b55e97a4
> Hi John,
> 
> I just sent out V12 of patch 10/12, which can kill the warning on BLK_MQ_REQ_FORCE,
> and the warning is harmless actually. And the above git branch has been
> updated too.
> 
> Please retest and update with us.

ok, so this looks better - no issue after 12 from my normal 50 test 
loops, as opposed to an issue with loop 1/50 previously. I figure it's 
ok to send v12 series proper.

Thanks,
John
