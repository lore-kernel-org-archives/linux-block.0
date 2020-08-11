Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB71C433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 03:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700F82075D
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 03:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgHKDNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:13:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726981AbgHKDNW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 23:13:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7E13A863C7704E13A4B4;
        Tue, 11 Aug 2020 11:13:20 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 11 Aug 2020
 11:13:14 +0800
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To:     Ming Lei <ming.lei@redhat.com>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
 <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
 <20200810031547.GB2202641@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <6dc6bb01-5bfd-bf13-f53a-1bc75a6b3991@huawei.com>
Date:   Tue, 11 Aug 2020 11:13:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810031547.GB2202641@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/10 11:15, Ming Lei wrote:
>> About using per_cpu to replace SRCU, I suggest separate discussion.
>> Can you show the patch? This will make it easier to discuss.
> https://lore.kernel.org/linux-block/20200728134938.1505467-1-ming.lei@redhat.com/
Directly replace SRCU with percpu_ref, is not safe.
This may make quiesce queue wait extra time, in extreme scenario,
maybe wait for ever.
