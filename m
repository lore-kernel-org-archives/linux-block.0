Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F5CC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjERXQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjERXPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE2E52
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 677BD65266
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2939BC433D2;
        Thu, 18 May 2023 23:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684451733;
        bh=kr/AnwCOrW3nqe3fm1KH4aTTVslCui+13HkjtGE9OWo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k1fIXPgP54KXY9khis3nrCbi3y8KOc8MoExqjIrp8/pm0OspMe0cIx7zyuMXVrQkj
         /jW1Alpw5VDNYXOzj3ZvCcEyVGZ9aaGhTEn52PB7wonLRSp8/y39Pwwo/MEqnkP5J6
         5oQzpHhT3RMRLhEvyTzOVA88t4+X7UhjomFvft6hw31sK0tUDIFrU6/7vNvZUfLzx7
         +5UMJFdwFlUMkRM5uKdW0Axf11X8KEHqxzPEgOm0mEus3LGsjsfcEWGZ1VZMgOF9W4
         cBCzRpaUjYUJwClhvps2zn+7gcwtKmK3zuS5zuNuEsKVjRWusQoI1HBuApayMIdicL
         ryHtU+sy7Cvcg==
Message-ID: <1aa5bb07-5830-b6a6-9c33-c051b258c6aa@kernel.org>
Date:   Fri, 19 May 2023 08:15:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 10/11] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <20230517174230.897144-1-bvanassche@acm.org>
 <20230517174230.897144-11-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230517174230.897144-11-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 02:42, Bart Van Assche wrote:
> Start dispatching from the start of a zone instead of from the starting
> position of the most recently dispatched request.
> 
> If a zoned write is requeued with an LBA that is lower than already
> inserted zoned writes, make sure that it is submitted first.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

