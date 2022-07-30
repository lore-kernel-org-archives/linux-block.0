Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D2FC00144
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 00:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiG3Aj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiG3Aj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 20:39:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C14F671
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 17:39:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvlmZ5Ch4zWfM6;
        Sat, 30 Jul 2022 08:35:58 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 08:39:54 +0800
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <sagi@grimberg.me>, <kbusch@kernel.org>, <axboe@kernel.dk>
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
Date:   Sat, 30 Jul 2022 08:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220729142605.GA395@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/7/29 22:26, Christoph Hellwig wrote:
> Why can't we have a per-tagset quiesce flag and just wait for the
> one?  That also really nicely supports the problem with changes in
> the namespace list during that time.
Because If quiesce queues based on tagset, it is difficult to
distinguish non-IO queues. The I/O queues process is different
from other queues such as fabrics_q, admin_q, etc, which may cause
confusion in the code logic.
> 
> .
> 
