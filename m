Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E6C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 06:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D11120811
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 06:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfDYGGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:06:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfDYGGC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 02:06:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F27FAD5E;
        Thu, 25 Apr 2019 06:06:01 +0000 (UTC)
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20190418140632.60606-1-hare@suse.de>
 <1556135351.161891.138.camel@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3ff02420-8063-490a-271d-b7032c9d3b42@suse.de>
Date:   Thu, 25 Apr 2019 08:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556135351.161891.138.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 9:49 PM, Bart Van Assche wrote:
> On Thu, 2019-04-18 at 16:06 +0200, Hannes Reinecke wrote:
>> +static int __init blk_bio_split_init(void)
>> +{
>> +       return bioset_init(&bio_split_bio_set, BIO_POOL_SIZE, 0,
>> +                          BIOSET_NEED_BVECS);
>> +}
> 
> The slab allocator uses __init for some of its initialization. Can it happen
> that blk_bio_split_init() is called before slab initialization has finished?
> 
> Otherwise this patch looks fine to me.
> 
Most unlikely.
We have another static bioset (fs_bio_set in block/bio.c) which is 
initialised in the same manner.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
