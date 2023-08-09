Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D2C001B0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 01:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjHIBcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 21:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHIBcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 21:32:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79E19BC
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 18:32:12 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLCC36Xbfz1hwLF;
        Wed,  9 Aug 2023 09:29:19 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 09:32:09 +0800
Message-ID: <ee32b802-91a8-f7a8-cf2a-e17de1aef9a9@huawei.com>
Date:   Wed, 9 Aug 2023 09:32:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] drbd: Use helper put_drbd_dev() and get_drbd_dev()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <drbd-dev@lists.linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
References: <20230808090111.2420717-1-ruanjinjie@huawei.com>
 <5e560155-b2a4-e5bd-d22e-0e44a5a85f43@kernel.dk>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <5e560155-b2a4-e5bd-d22e-0e44a5a85f43@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2023/8/9 1:36, Jens Axboe wrote:
> On 8/8/23 3:01 AM, Ruan Jinjie wrote:
>> The drbd_destroy_device() arg of this code is already duplicated
>> 18 times, use helper function put_drbd_dev() to release drbd_device
>> and related resources instead of open coding it to help improve
>> code readability a bit.
>>
>> And add get_drbd_dev() helper function to be symmetrical with it.
>>
>> No functional change involved.
> 
> IMHO this just makes the code harder to read. You're not adding a
> helper, all it does is call the same get/put parts. Why not just keep
> it as-is then?

Sorry, I misunderstood the meaning of a helper.I'll learn more about
what other helper patches are doing. It's okay to keep it as it is.

> 
