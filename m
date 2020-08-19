Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C8C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7150A208DB
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 16:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgHSQvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:51:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgHSQvF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 12:51:05 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B4E5CE62BFCF43E078F0;
        Wed, 19 Aug 2020 17:51:02 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.203) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 19 Aug
 2020 17:51:02 +0100
Subject: Re: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
To:     Ming Lei <ming.lei@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
 <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
 <20200819000009.GB2712797@T590>
 <585bb054-2009-4abc-f1e8-802e494ba49b@huawei.com>
 <20200819085843.GA2730150@T590>
 <83de2368-a122-3b9c-db15-63ea442eecd9@huawei.com>
 <20200819142147.GA2795390@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <165cddcd-ad2c-7022-cae2-7995db39e570@huawei.com>
Date:   Wed, 19 Aug 2020 17:48:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200819142147.GA2795390@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.203]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/08/2020 15:21, Ming Lei wrote:
> I guess that elevator switch may have to be involved in your reproducer, stale
> request which are freed before switching to new elevator can stay in tags->rqs[],
> then these stale requests are retrieved when reading iostat before old request slots in
> tags->rqs[] are reset.

Yeah, just switching -> "none" seems to do it. If I hack the elevator 
code to default to "none", then no issue.

Thanks
