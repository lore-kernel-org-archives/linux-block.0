Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFA6C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDLHbf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDLHbd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808235FE4
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F421C62EBD
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0675C433EF;
        Wed, 12 Apr 2023 07:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681284678;
        bh=3cwFJ72iL4y6F6rT+iGBbyBepDWobNN1pvpOhLX5Sfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X87GAJ8cabwzDyz4JCDdpF1pax5OxdhnAgCFIRFiMRm7IdOD9E9NTD+Y9a3KNo6V+
         XW6DgqNwMULiOC0dyGQ+lndW7f1sFJ4lRBQDXEgCKS+mButlYCRQSF1iQ7E+3Si4ko
         X8tjDcQ7hv0R9Up9xgmN1+Kx3XmHpudzuUTrsj0mh2v8CWrQq8aK8lhMN5eNsslsz9
         BL0q5FA/rcrwocs0a6o3TO+V6eJEqVuGvUs+yXaEALEgTo9gYlPrU2PJjgHRktEP/y
         beFyrxGxQI4acwzwixFJszn7KXHrZalbj/Suj7tKtZiCeorCRIiyB2mzBRZNQP3R87
         OMwMXAkFdtFnQ==
Message-ID: <e709d89f-6209-d50e-02c2-fc555d1d03b7@kernel.org>
Date:   Wed, 12 Apr 2023 16:31:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 13/18] blk-mq: fold __blk_mq_try_issue_directly into its
 two callers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-14-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Due the wildly different behavior based on the bypass_insert argument,

s/Due/Due to

> not a whole lot of code in __blk_mq_try_issue_directly is actually shared
> between blk_mq_try_issue_directly and blk_mq_request_issue_directly.
> 
> Remove __blk_mq_try_issue_directly and fold the code into the two callers
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Otherwise looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


