Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C4EC4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 09:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDBA610CC
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 09:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhHMJZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:25:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8410 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbhHMJZl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 05:25:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GmJ2f6zrbz86NJ;
        Fri, 13 Aug 2021 17:21:14 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 17:25:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 13 Aug 2021 17:25:13 +0800
To:     <tj@kernel.org>, linux-block <linux-block@vger.kernel.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Subject: questions about sane_behavior in cgroup v1
Message-ID: <7ecceefb-ba98-399f-38b0-5a7717a51649@huawei.com>
Date:   Fri, 13 Aug 2021 17:25:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We want to support that configuration in parent cgroup will work on
child cgroup in cgroup v1. The feature was once supported and was
reverted in commit 67e9c74b8a87 ("cgroup: replace __DEVEL__sane_behavior
with cgroup2 fs type").

Switching to cgroup v2 can support that, however, the cost is too high
because all of our products are using v1, and there's a big difference
in usage between v1 and v2.

My question is that why is the feature reverted in cgroup v1? Is it
because there are some severe problems? If not, we'll try to backport
the feature to cgroup v1 again.

Thanks,
Kuai
