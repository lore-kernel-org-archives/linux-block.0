Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA01C4321E
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 13:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiKXNCT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 08:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKXNCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 08:02:08 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F82D91529;
        Thu, 24 Nov 2022 05:02:07 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHyml5WzYzHw5Y;
        Thu, 24 Nov 2022 21:01:27 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:02:04 +0800
Subject: Re: [PATCH 11/11] blk-throttle: Use more siutable time_after check
 for update slice_start
To:     Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-12-shikemeng@huawei.com>
 <Y35mnXMNg8HeHXbb@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <ba735734-cffe-18a9-8bb5-03f47c3c8018@huawei.com>
Date:   Thu, 24 Nov 2022 21:02:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y35mnXMNg8HeHXbb@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



on 11/24/2022 2:29 AM, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 02:04:01PM +0800, Kemeng Shi wrote:
>> Use more siutable time_after check for update slice_start
> 
> Why is it more suitable?
There is no need to assign tg->slice_start[rw] to start when they are
equal already. So time_after seems more suitable here.

-- 
Best wishes
Kemeng Shi
