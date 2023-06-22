Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A37EB64D7
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 01:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFVBPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 21:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVBPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 21:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A065F10D
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 18:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34C3261725
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 01:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC100C433C9;
        Thu, 22 Jun 2023 01:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687396539;
        bh=JdIafGwpK4p0nw2kk/x4D+mv6bGd/IoCzMir38qc//k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XUynSh9zweAAMDPC1GHjQv98bZlUqSKgtcf6fG0Tq8EI/IZj9gAu1sLtJJJDzhcA7
         iJGajmxiaqYmOdvPGHYpnhfNCZcErtvhyUHPWYvGrojYbACSUleNHF9bF18tNeFt9w
         IOr7w+B7jVgEm0coBeS5ampl7Uh9R+KvB3AF3+pmPKrd+U5mS6DGMkgSHTflo+TVV8
         +T59PaxqNbV6NRV1aD2KfItojV+pd4IvsQI6Hqpniys2sWbVvw/JRQVoYQ57wMLBZL
         fdANqrPuWrXsAWKLVC6YEOZB1fNnaioUvLW/+z4XEZjpGMWyrOZX2UQVCcfgTI3fFR
         XvYH5TUWsBoRg==
Message-ID: <7d951564-24e2-b8cc-ddc7-6a93fe640482@kernel.org>
Date:   Thu, 22 Jun 2023 10:15:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/7] block: Rename a local variable in
 blk_mq_requeue_work()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230621201237.796902-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 05:12, Bart Van Assche wrote:
> Two data structures in blk_mq_requeue_work() represent request lists. Make
> it clear that rq_list holds requests that come from the requeue list by
> renaming that data structure.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

