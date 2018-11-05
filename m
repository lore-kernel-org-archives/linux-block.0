Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeKEVKO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Nov 2018 16:10:14 -0500
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
Date: Mon, 5 Nov 2018 12:50:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181105105548.GC12367@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/11/2018 11:55, Ming Lei wrote:
> On Mon, Nov 05, 2018 at 11:23:01AM +0100, Johannes Thumshirn wrote:
>> With drivers like iSer we are seeing a lot of bio splitting and smaller I/Os
>> being submitted to the driver.
>>
>> The root cause of this issue that the virtual boundary mask code does not take
>> into consideration that some of the memory segments in the SG list may have
>> come from a huge memory page that is being managed in the SG list as 4K
> 
> I guess you mean something like 64K PAGE_SIZE, instead of huge page.

No I mean like a 2M page from an upper layer.

-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
