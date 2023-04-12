Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDFEC7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLHmk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDLHmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D27BE5D
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0813F6287A
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE40C433EF;
        Wed, 12 Apr 2023 07:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681285357;
        bh=BI0MtQHDiORf6KPkYF9vDnwup+nuWljDdQyx+LKcOco=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cHyx9tYR320ZpS/hhrluC18xhbK4tCZSicaaUX+j4vBpLZfyWbZIWVL+tgu0YZx+m
         ARBl6rxHWtL8+LGUdsRXJA6G3TEEqeswRdWva66kTiaKm2mPkS4VwYYzLpFXUNq4n1
         D3E2u90bYJV6p08G1QfVPOoQRoFd+OdA7XgtjsVYEdGDhLbquZYVZLZUwmLN3tnvTD
         Cw2A39l24naDwEbhLEljuSn0nOvEsKQeH1xk2gq6TcsAUOj/af7f59jzSA1lNCpg8X
         Ysfya7QTyZnFkKHahMRuYINQLY1xyojh1irySD9/G4m09pJOTkuzXwsRNQj5Trc0Eq
         Mz+zOzJrI16zw==
Message-ID: <6d09f78b-33ae-377d-d056-f84c0972b0fc@kernel.org>
Date:   Wed, 12 Apr 2023 16:42:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 15/18] blk-mq: don't run the hw_queue from
 blk_mq_request_bypass_insert
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-16-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> blk_mq_request_bypass_insert takes a bool parameter to control how to run
> the queue at the end of the function.  Move the blk_mq_run_hw_queue call
> to the callers that want it instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


