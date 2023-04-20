Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1DC6FD18
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 01:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjDTBAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 21:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDTBAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 21:00:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297140DA
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 18:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E34064426
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 01:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61184C433D2;
        Thu, 20 Apr 2023 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681952411;
        bh=F3mjbHMaxWU0QIu/h9Bcpba1Rql6qhBaqmx6dXQagVc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pIxpB+qaUZaO03mLcS1Vy+MuV2+1lHeoWW/oKMUfPPKligjR1Rg7JdP2qrdYlSbXX
         5FD4Jvsqyc0TVwmIjnBnJtneISsKfj6OqXFuiMvBZBM3X8XGw5fc8jQClF9/YwFpPs
         ++AzK6QdAFDbtcxTn1QnIxZjZ0egFKv6KKpeEUHyuvBLfayaYD2Wj1rVG48WYcnjeS
         duOL76z7XdovgflKI1JRq+LQYhVjcPEdckloFRk3CkAFCBbAa8+FtodMQfevWQ2RjK
         tnlKMfn79me8ddKAxL+qHeO8Cxu+bilh3Xgq9YwYROe7n2qmSM3U0JqOcE0U1uwyXE
         xCX22Yg0upjng==
Message-ID: <c7078aa8-76fb-6831-673e-5972208680d3@kernel.org>
Date:   Thu, 20 Apr 2023 10:00:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 08/11] block: mq-deadline: Fix a race condition related
 to zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-9-bvanassche@acm.org> <20230419050706.GC25898@lst.de>
 <efd020f5-9528-aa5e-ecd6-f0390c41fb02@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <efd020f5-9528-aa5e-ecd6-f0390c41fb02@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/23 03:46, Bart Van Assche wrote:
> On 4/18/23 22:07, Christoph Hellwig wrote:
>> On Tue, Apr 18, 2023 at 03:39:59PM -0700, Bart Van Assche wrote:
>>> Let deadline_next_request() only consider the first zoned write per
>>> zone. This patch fixes a race condition between deadline_next_request()
>>> and completion of zoned writes.
>>
>> Can you explain the condition in a bit more detail?
> 
> Hi Christoph,
> 
> I'm concerned about the following scenario:
> * deadline_next_request() starts iterating over the writes for a
>    particular zone.
> * blk_req_can_dispatch_to_zone() returns false for the first zoned write
>    examined by deadline_next_request().
> * A write for the same zone completes.
> * deadline_next_request() continues examining zoned writes and
>    blk_req_can_dispatch_to_zone() returns true for another write than the
>    first write for a zone. This would result in an UNALIGNED WRITE
>    COMMAND error for zoned SCSI devices.

Examining zoned writes has to be done with deadline zone lock held, exactly to
avoid this issue.

> 
> Bart.
> 

