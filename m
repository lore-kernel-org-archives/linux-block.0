Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF8C77B73
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjERXLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjERXLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE7B18F
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1B5160FD1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C30C433EF;
        Thu, 18 May 2023 23:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684451508;
        bh=2gfP4TjTrLmHmTfMPX/Z6puDPZgbedcVWY2FVR5fYzs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G5+WieNQHvJGVU++TxZI7LHTfLAa2SRVszU1KA27uggZirNnjMImty8uedi6o9rqy
         j9RnB7ZACl2nfLCXF9rHvRAiJ0sklJErcEHqkN0vsV/3xi5locTFk5rgpyVahS/d0l
         pfZp9C7sPPqsGBJZYR1pD5zVPawZQTK9fcl75zcWxWb4oBeECqhCu6rKUVKkAwNJUR
         4qlgWiieGqN0XvpJ2lZoS0q1XHteRTTG78T0F4u9BnzFcCrnuBuPUKyNa0D5cQlnr9
         //Pq4GldV+y4FUvUrlXWAsb06j3VpAQATBYNJcIuAbnH7zJNO85EkAErYdWS1ezK/C
         nltknM30b5czA==
Message-ID: <f6086451-0811-7f25-035c-9c06fc40b5bd@kernel.org>
Date:   Fri, 19 May 2023 08:11:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 01/11] block: mq-deadline: Add a word in a source code
 comment
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>
References: <20230517174230.897144-1-bvanassche@acm.org>
 <20230517174230.897144-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230517174230.897144-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 02:42, Bart Van Assche wrote:
> Add the missing word "and".
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the deadline IO scheduler")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Replying to this patch as there is no cover letter.

I gave this series a spin yesterday using a 26TB SMR drive. No issues detected
and no performance regression that I can see. Tested on top of 6.4-rc2.

So feel free to add:

Tested-by: Damien Le Moal <dlemoal@kernel.org>


