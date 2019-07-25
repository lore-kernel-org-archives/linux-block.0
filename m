Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDEEC76190
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 17:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2246229F3
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 17:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbfGYRyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:54:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40520 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfGYRyg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 13:54:36 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqhwZ-0001q5-DZ; Thu, 25 Jul 2019 11:54:20 -0600
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
 <20190725175023.GA30641@bombadil.infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>
Date:   Thu, 25 Jul 2019 11:54:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725175023.GA30641@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, willy@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-07-25 11:50 a.m., Matthew Wilcox wrote:
> On Thu, Jul 25, 2019 at 11:23:23AM -0600, Logan Gunthorpe wrote:
>> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
>> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
>>
>> The purpose of this function is to support NVMe-OF target passthru.
> 
> I can't find anywhere that you use this in this patchset.
> 

Oh sorry, the commit message is out of date the function was actually
called nvme_ctrl_get_by_path() and it's used in Patch 10.

I'll fix the commit message for the next version.

Logan
