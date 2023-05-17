Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6EC77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 01:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjEQBY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 21:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEQBY6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 21:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D0CA
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 18:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA0A61444
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 01:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2852BC433EF;
        Wed, 17 May 2023 01:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684286696;
        bh=gXg4ekTzbWcZh4Y4J8q6th/iNDRqCZBXfW8F6/q5m+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kl16rRCrAMJqRoL/neQbiO2l3Pmb9/gZLrltYDTwiAW+ecVH8bonYWOVY3/cpinW9
         j/q+syoBiGNU4q2GHDNZg53OrM83+jZyQZeZnu/jbdYzTYCaofJfeQjLOrjL+TfC2k
         pulmLmV4Njs/+3WzwgMn2+ovP8VkIUvC9TttbN3Q9JEOiBgJpyChbYvHzI1LYbLwYZ
         Vpt67c0OgXJz4pNYvMx//NDRv56gjjML24xcSfq8MVdfXHoTdqAoRQoPjsS5ttIypo
         tn0BE3kesDUkeyyV5GYD5m5tx1rfH6zbgCvrzSFb/jf4wnRJTpcJFGgiBqqQa0NAI/
         M1K7UvbO3uXFQ==
Message-ID: <bc9036c1-0273-257a-0e62-60ff8f9d02ac@kernel.org>
Date:   Wed, 17 May 2023 10:24:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 11/11] block: mq-deadline: Fix handling of at-head
 zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-12-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-12-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Before dispatching a zoned write from the FIFO list, check whether there
> are any zoned writes in the RB-tree with a lower LBA for the same zone.
> This patch ensures that zoned writes happen in order even if at_head is
> set for some writes for a zone and not for others.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

