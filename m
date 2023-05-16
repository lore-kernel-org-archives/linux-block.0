Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A5AC77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 23:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjEPX0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPX0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 19:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2F4C1A
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 16:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4D5D63E89
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 23:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C9AC433D2;
        Tue, 16 May 2023 23:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684279570;
        bh=c8XA21qLnE4qgxYSbYnkgWWcQ8N6tfeUSH11+hLxH3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eQnJBnnrmdxjDg3Irs06qZ3zgEM5yJxdtIM5j2cLUFPicGWTbHH+bOyiaKJroA+dj
         sfXIL9dzfXEXn8hb7y7dxY1CuX00/dLJBpIVSsZS7dEu6inzUYhL9Tde2dJ3JIP2Ef
         ryt8xmijCjJ9pArkC+po98F8XV1Zj14mufYXfOAvhCK6cyggLFbcb2aFH3GkZKazdw
         WpxdnoJ+GoPy5ejQ9Xf9Is8AQgR0lL2aneO8uSC474Cr25i7lu+F7/BgJ58JvbNGIr
         WYXQ1/OGvlC89K+U6wLBfl9TYujnjYasw3Sx85FaCNREeQ9D45ShT2z8LNQT0GmVzs
         qYINEF5kqfM+A==
Message-ID: <af645ae0-d021-b9a5-b411-14a0cee8a784@kernel.org>
Date:   Wed, 17 May 2023 08:26:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 02/11] block: Fix the type of the second
 bdev_op_is_zoned_write() argument
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-3-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Change the type of the second argument of bdev_op_is_zoned_write() from
> blk_opf_t into enum req_op because this function expects an operation
> without flags as second argument.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Fixes: 8cafdb5ab94c ("block: adapt blk_mq_plug() to not plug for writes that require a zone lock")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

