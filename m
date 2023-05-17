Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5159FC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 06:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjEQGrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEQGrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 02:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287BFF5
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 23:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B229463644
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 06:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75187C433EF;
        Wed, 17 May 2023 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684306034;
        bh=ucuvTeQuwH03uZYf1uIk8w/xkArINbw6/P81y0rzvmk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QbxkBPxCh3rWZPh3iWUuI3vCK9g5K8D9xKE033tMPOs7bKnV91Qd9IT1gXWxc78+4
         H3rJkWkOC0QNayXsMXQHwo2g8qCXADvp6n0E308cVforHVobMW/7x3TIdRG/Zm/4HT
         ym4CUIkF3U7agXw2dq5CjjKyPQARjghA19VDvrwS0QPqK117a0cw7QbEZsRH3WTP2P
         X1AHgPrYjj13iSNPNom6sGjaaRkGWGB7DJMaPP0QB8WqR1CF6Bkpiv0fJkL+rhEBFl
         hzM/xdWoUnnAn5jhH4JrLJ3GMSUK/Lr0lPmCejvjrsN0S7Dk3u/ibaHUsGvHECu9ud
         70Q5Hm9zp2log==
Message-ID: <0fead295-dfe0-e486-cf22-7eca35d23ac7@kernel.org>
Date:   Wed, 17 May 2023 15:47:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 03/11] block: Introduce op_is_zoned_write()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-4-bvanassche@acm.org>
 <84348f20-6849-549c-5113-2faf1a6b40ad@kernel.org>
 <3cba6052-69ed-4ec4-dcbb-c0347a9ebd48@acm.org>
 <20230517064556.GA24536@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230517064556.GA24536@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/05/17 15:45, Christoph Hellwig wrote:
> On Tue, May 16, 2023 at 05:00:29PM -0700, Bart Van Assche wrote:
>> On 5/16/23 16:30, Damien Le Moal wrote:
>>> Or if you really want to rewrite this, may be something like:
>>>
>>> static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
>>>    					  enum req_op op)
>>> {
>>> 	return bdev_is_zoned(bdev) &&
>>> 	       (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES);
>>> }
>>>
>>> which is very easy to understand.
>>
>> The op_is_zoned_write() function was introduced to use it in patch 4/11 of 
>> this series. Anyway, I will look into open-coding it.
> 
> I think the idea here is that we're testing for an operation that needs
> zone locking.  Maybe that needs to be reflected in the name?
> op_needs_zone_write_locking() ?

Sounds better !

-- 
Damien Le Moal
Western Digital Research

