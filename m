Return-Path: <SRS0=tn0U=Z4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C7C43603
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 04:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2724659
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 04:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFEhc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:37:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:40190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbfLFEhc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Dec 2019 23:37:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6180B2BD;
        Fri,  6 Dec 2019 04:37:29 +0000 (UTC)
Subject: Re: [RFC PATCH] bcache: enable zoned device support
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Eric Wheeler <bcache@lists.ewheeler.net>
Cc:     "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
References: <20191205152543.73885-1-colyli@suse.de>
 <alpine.LRH.2.11.1912060012380.11561@mx.ewheeler.net>
 <BYAPR04MB5816090B934A7CA17EFA688AE75F0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <a21ce3de-5591-198f-56bf-8dc3aee6c926@suse.de>
Date:   Fri, 6 Dec 2019 12:37:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816090B934A7CA17EFA688AE75F0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/12/6 8:30 上午, Damien Le Moal wrote:
> On 2019/12/06 9:22, Eric Wheeler wrote:
>> On Thu, 5 Dec 2019, Coly Li wrote:
>>> This is a very basic zoned device support. With this patch, bcache
>>> device is able to,
>>> - Export zoned device attribution via sysfs
>>> - Response report zones request, e.g. by command 'blkzone report'
>>> But the bcache device is still NOT able to,
>>> - Response any zoned device management request or IOCTL command
>>>
>>> Here are the testings I have done,
>>> - read /sys/block/bcache0/queue/zoned, content is 'host-managed'
>>> - read /sys/block/bcache0/queue/nr_zones, content is number of zones
>>>   including all zone types.
>>> - read /sys/block/bcache0/queue/chunk_sectors, content is zone size
>>>   in sectors.
>>> - run 'blkzone report /dev/bcache0', all zones information displayed.
>>> - run 'blkzone reset /dev/bcache0', operation is rejected with error
>>>   information: "blkzone: /dev/bcache0: BLKRESETZONE ioctl failed:
>>>   Operation not supported"
>>> - Sequential writes by dd, I can see some zones' write pointer 'wptr'
>>>   values updated.
>>>
>>> All of these are very basic testings, if you have better testing
>>> tools or cases, please offer me hint.
>>
>> Interesting. 
>>
>> 1. should_writeback() could benefit by hinting true when an IO would fall 
>>    in a zoned region.
>>
>> 2. The writeback thread could writeback such that they prefer 
>>    fully(mostly)-populated zones when choosing what to write out.
> 
> That definitely would be a good idea since that would certainly benefit
> backend-GC (that will be needed).
> 
> However, I do not see the point in exposing the /dev/bcacheX block
> device itself as a zoned disk. In fact, I think we want exactly the
> opposite: expose it as a regular disk so that any FS or application can
> run. If the bcache backend disk is zoned, then the writeback handles
> sequential writes. This would be in the end a solution similar to
> dm-zoned, that is, a zoned disk becomes useable as a regular block
> device (random writes anywhere are possible), but likely far more
> efficient and faster. That may result in imposing some limitations on
> bcache operations though, e.g. it can only be setup with writeback, no
> writethrough allowed (not sure though...).
> Thoughts ?
> 

I come to realize this is really an idea on the opposite. Let me try to
explain what I understand, please correct me if I am wrong. The idea you
proposed indeed is to make bcache act as something like FTL for the
backend zoned SMR drive, that is, for all random writes, bcache may
convert them into sequential write onto the backend zoned SMR drive. In
the meantime, if there are hot data, bcache continues to act as a
caching device to accelerate read request.

Yes, if I understand your proposal correctly, writeback mode might be
mandatory and backend-GC will be needed. The idea is interesting, it
looks like adding a log-structure storage layer between current bcache
B+tree indexing and zoned SMR hard drive.

-- 

Coly Li
