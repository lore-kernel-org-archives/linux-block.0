Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9563C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 03:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiGGDem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 23:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGGDel (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 23:34:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA81C91F
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 20:34:39 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ldhnd6S1nzkX6S;
        Thu,  7 Jul 2022 11:33:09 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 11:34:37 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 11:34:37 +0800
Subject: Re: [PATCH blktests] nbd: add a module install and device connect
 test
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <shinichiro.kawasaki@wdc.com>
References: <20220706070209.1494417-1-sunke32@huawei.com>
 <YsVC42qMNKN7Jomo@infradead.org>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <6f360d4a-bd0c-96f3-23c4-8be13c8fbe14@huawei.com>
Date:   Thu, 7 Jul 2022 11:34:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YsVC42qMNKN7Jomo@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/7/6 16:08, Christoph Hellwig 写道:
> On Wed, Jul 06, 2022 at 03:02:09PM +0800, Sun Ke wrote:
>> This is a regression test for commit 06c4da89c24e
>> nbd: call genl_unregister_family() first in nbd_cleanup()
>>
>> Two concurrent processes，one install and uninstall nbd module
>> cyclically, the other one connect and disconnect nbd device cyclically.
>> Last for 10 seconds.
> 
> I think you mean load/unlock instead of install.
Thanks for your suggestion, I do not sure how to descibe it. I will fix 
it in both function name and commit info.
> 
>> +requires() {
>> +	_have_nbd
>> +}
> 
> This needs to use _have_modules instead.
ok

Thanks,
Sun Ke
> .
> 
