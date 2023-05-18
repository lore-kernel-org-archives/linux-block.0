Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B9C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjERXMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjERXMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:12:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976FE48
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A06652DC
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F13C433EF;
        Thu, 18 May 2023 23:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684451570;
        bh=mH8w3ydGJDy0ttif0qz1ZOCvmT4IAvK2XNn4jJ/PzhI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LSixs/RiP6pd2TNIUjAt8sjWVT6lduWnhZYvZKcO2z0vD8ht4VNkaoYmkIcRwoU0h
         ky/jbi69nWKMf2J782x0niEsuCnEfV0odWcBu/bvR69m9j/DndChr3NNie0NnIqf7M
         oQJDiI9Wt2I81DEr7HeIa47vuDY2mlhahsgWOswKXSLH+7g053SbUCd7byIpH+i/iC
         RHGk1VfCLRIO2UmGXsIZoFDxCALqYLbXVpvMRwPKr16ggUzKANb20zsbbr0qEbfVhH
         MBFqojklwEPVrI+aR1B2Aq9kuJoDXBltONn7Y7huf3nCM4AZyS1u1HO4F/bjKDZIrK
         ExLLQmcMXJ0Iw==
Message-ID: <6629b6a4-58a3-21a5-adae-592927789347@kernel.org>
Date:   Fri, 19 May 2023 08:12:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 04/11] block: Introduce op_needs_zoned_write_locking()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20230517174230.897144-1-bvanassche@acm.org>
 <20230517174230.897144-5-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230517174230.897144-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 02:42, Bart Van Assche wrote:
> Introduce a helper function for checking whether write serialization is
> required if the operation will be sent to a zoned device. A second caller
> for op_needs_zoned_write_locking() will be introduced in the next patch
> in this series.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

