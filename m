Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A3C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDLHk4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDLHkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53666583
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F2762ED9
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4045C433EF;
        Wed, 12 Apr 2023 07:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681285242;
        bh=JTyL9OUSbUCdVJbynlfMkn/HFTyv5qej/d169iGnGaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eHW9KSeQqizTB6Fd1/MqKqnEYDZnzsHDQh+UmHeSzn6+9iCS0/eK3PJu58EW+7SrY
         t+sxLk8UBNz1nCfk0zfwSBssRo46oOZqAa5S6whiwaUPUP3yXQVXaWGuLNlhjXPwQ5
         AYW5a60HxYF/8womCHKKmGtD2ZUjrfhC/kmsWW1znRzhypr/3i7SIND8vMa6rYSbxP
         buYGR/7Hmvjwn23DSF7tFhtUJFnrE2pwKilNp6s8aj8Slh5nZo9MxDCGN32CeMHlXK
         CKCkiWepzuul2VTeLO2UVDidveoCPsP9VzIq/BIIlujIZDJdPl/H2wX3vm/tySY74S
         H65plb5uhS9Uw==
Message-ID: <80ccd89d-ea74-b342-1434-d3ab7a7b7fec@kernel.org>
Date:   Wed, 12 Apr 2023 16:40:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 14/18] blk-mq: don't run the hw_queue from
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-15-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> blk_mq_insert_request takes two bool parameters to control how to run
> the queue at the end of the function.  Move the blk_mq_run_hw_queue call
> to the callers that want it instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

This is nice !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

