Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC5EC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F68218A5
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfCUPyf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:54:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:36062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727823AbfCUPyf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 11:54:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6830FAB6D;
        Thu, 21 Mar 2019 15:54:34 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
To:     Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190321123045.32396-1-jthumshirn@suse.de>
 <20190321123045.32396-2-jthumshirn@suse.de>
 <78cf685f-2bb4-c494-4677-afa513b47339@fb.com>
 <17f1ef65-5fcf-0cba-4d37-a43d5e5038b0@kernel.dk>
 <64dce739-128b-1770-4062-9ba566ceda63@suse.de>
 <beaecea2-13b2-e8ef-de18-b841f4fe82de@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <40029cb8-f5bd-51e4-2019-797f443e3c03@suse.de>
Date:   Thu, 21 Mar 2019 16:54:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <beaecea2-13b2-e8ef-de18-b841f4fe82de@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 3:25 PM, Jens Axboe wrote:
> On 3/21/19 8:23 AM, Johannes Thumshirn wrote:
>> On 21/03/2019 15:21, Jens Axboe wrote:
>>> On 3/21/19 8:15 AM, Jens Axboe wrote:
>>>> You also haven't solved the issue of now having an extra bit, 2/2 uses
>>>> the last bit which the other patch already took...
>>>
>>> Here's one way - kill BIO_SEG_VALID. We should just use
>>> ->bi_phys_segments to tell if it's valid or not. This patch uses -1 to
>>> signify it's not.
>>>
>>> Totally untested...
>>
>>
>> That sounds like an idea, I'll trow some testing at it and report back.
> 
> That'd be great, thanks. If we can do that as a prep patch for you, then
> you can just use an enum and not worry about initializing since I'll just
> shove BIO_PAGE_NO_REF at the end.
> 
> And this is simpler than having to shift the masks around.
> 
And it would also remove the possiblity that SEG_VALID and 
nr_phys_segments get out of sync.
We still have some unresolved issues revolving around this problem...
So yeah, I do like it, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
