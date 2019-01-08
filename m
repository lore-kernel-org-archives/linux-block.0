Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E321AC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0D92070B
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 17:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfAHRY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:24:26 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50344 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHRY0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 12:24:26 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ggv72-0002D1-MF; Tue, 08 Jan 2019 10:24:25 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
 <20190108131913.GA6677@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <eee4c4b3-52c7-f9d0-8028-3cd136ae5491@deltatee.com>
Date:   Tue, 8 Jan 2019 10:24:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190108131913.GA6677@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: Regression in v5.0-rc1: Panic at boot
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-01-08 6:19 a.m., Christoph Hellwig wrote:
> On Mon, Jan 07, 2019 at 12:41:06PM -0700, Logan Gunthorpe wrote:
>> Hey,
>>
>> I found a regression in v5.0-rc1 this morning. My system panics on boot.
>> I've attached a log of the panic.
>>
>> I bisected to find the problematic commit is:
>>
>> Fixes: 9d037ad707ed ("block: remove req->timeout_list")
>>
>> But it makes no sense to me why this commit would cause a problem like
>> this. I've attached a bisect log. I've also tested v5.0-rc1 with this
>> commit reverted and that boots fine.
>>
>> The traceback seems to indicate the problem is on the bip_get_seed()
>> line in t10_pi_complete(). Which suggests that bio_integrity() is
>> returning NULL.
> 
> Very odd.  Can you try an experiment?  Can you add padding the size
> of struct timer_list to struct request to check if that makes the
> problem go away?  Then move the padding from the where the field
> was to the end and see if that still "helps"?

Ok I tried these things and they all boot without panic:

1) Add two void pointers to where 'timer_list' was
2) Add two void pointer to the end of the struct
3) Add one void pointer to the end of the struct

So it seems to be a struct size issue...

Logan

