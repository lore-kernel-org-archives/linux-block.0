Return-Path: <SRS0=JXuJ=C2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D397AC433E2
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D53621582
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 13:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgIQN5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 09:57:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2879 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbgIQN5F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 09:57:05 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EB2F675E2715E024F0FF;
        Thu, 17 Sep 2020 14:56:58 +0100 (IST)
Received: from [127.0.0.1] (10.210.165.75) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 17 Sep
 2020 14:56:58 +0100
From:   John Garry <john.garry@huawei.com>
Subject: [blktests] About CPU hotplug test
To:     Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <02152473-3664-d758-7270-871fa4159203@huawei.com>
Date:   Thu, 17 Sep 2020 14:54:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.75]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

In kernel commit bf0beec0607d ("blk-mq: drain I/O when all CPUs in a 
hctx are offline"), we added support to ensure CPU hotplug works safely 
for devices with managed interrupts.

I was using my own script to test this, and I wanted to add something to 
blktests for this same thing - however I see block/008 is for that 
purpose. However, it does not seem effective for testing the above 
commit, as it just hot-unplugs and replugs random CPUs quickly, and does 
reliably ensure a specific group of CPUs are disabled for such a period 
that we would see IO timeouts (or not).

Anyway, would you suggest a whole new test for this?

Cheers,
John
