Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62DC04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A796206B7
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 17:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A796206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeLBEYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:24:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbeLBEYW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 23:24:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA638AF41;
        Sat,  1 Dec 2018 17:11:22 +0000 (UTC)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
Date:   Sat, 1 Dec 2018 18:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181201164804.GB19557@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/18 5:48 PM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 01:36:09PM -0700, Jens Axboe wrote:
>> On 11/30/18 1:26 PM, Keith Busch wrote:
>>> A driver may wish to iterate every tagged request, not just ones that
>>> satisfy blk_mq_request_started(). The intended use is so a driver may
>>> terminate entered requests on quiesced queues.
>>
>> How about we just move the started check into the handler passed in for
>> those that care about it? Much saner to make the interface iterate
>> everything, and leave whatever state check to the callback.
> 
> So we used to do that, and I changed it back in May to test for
> MQ_RQ_IN_FLIGHT, and then Ming changed it to check
> blk_mq_request_started.  So this is clearly a minefield of sorts..
> 
> Note that at least mtip32xx, nbd, skd and the various nvme transports
> want to use the function to terminate all requests in the error
> path, and it would be great to have one single understood, documented
> and debugged helper for that in the core, so this is a vote for moving
> more of the logic in your second helper into the core code.  skd
> will need actually use ->complete to release resources for that, though
> and mtip plays some odd abort bits.  If it weren't for the interesting
> abort behavior in nvme-fc that means we could even unexport the
> low-level interface.
> 
Yes, I'm very much in favour of this, too.
We always have this IMO slightly weird notion of stopping the queue, set 
some error flags in the driver, then _restarting_ the queue, just so 
that the driver then sees the error flag and terminates the requests.
Which I always found quite counter-intuitive.
So having a common helper for terminating requests for queue errors 
would be very welcomed here.

But when we have that we really should audit all drivers to ensure they 
do the right thin (tm).

Cheers,

Hannes

