Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA856EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 21:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFVVvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjFVVu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 17:50:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5F10DB
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 14:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4922561923
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E27C433C0;
        Thu, 22 Jun 2023 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687470657;
        bh=jblg2o4aAEzxjX0Olw6I1LuplhDJ8VwDUHW5SyfIvzc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MvT+isUYJqW1v/xCASJq+iQZyAh3IBbLXWrx5KU3obkzd8JH0ugl8R77ZmEK53RNs
         LzFf8RxucLngDtcB9Kf+b1Brlac7o2w+pE+2epy7l737wLuMWflcetp5p9b+NXOIEH
         K3dsgG32/teelGDk72z3RbLI3K70btptJvzaVN7tPdP7lEFyoQpf2YkPJmBRn3wt4S
         SYx3PeRL4Kx9etTOTlmPDN6pXc3v5b4XMF04cPeWZ3E2dn4zDPJTtm6+MwgApie1gE
         v/fp4Xo5ukFch1qM6fp4xiXizLBzZqVJITawIEWi1fZ9HoMbxj+2M3DTucDlhGgVqx
         AHxNAGzfyN95w==
Message-ID: <2afba358-08ea-77ad-50ca-0cc931c6429f@kernel.org>
Date:   Fri, 23 Jun 2023 06:50:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/7] block: Send requeued requests to the I/O scheduler
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-4-bvanassche@acm.org>
 <989f9473-c17e-e85d-ab10-313182f7ac3b@kernel.org>
 <32a2617a-0c41-fb6c-3cfe-7c832487a6b4@acm.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <32a2617a-0c41-fb6c-3cfe-7c832487a6b4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/23 02:23, Bart Van Assche wrote:
> On 6/21/23 18:19, Damien Le Moal wrote:
>> Why ? I still do not understand the need for this. There is always only a single
>> in-flight write per sequential zone. Requeuing that in-flight write directly to
>> the dispatch list will not reorder writes and it will be better for the command
>> latency.
> Hi Damien,
> 
> After having taken a closer look I see that blk_req_zone_write_unlock() 
> is called from inside dd_insert_request() when requeuing a request. 
> Hence, there is no reordering risk when requeuing a zoned write. I will 
> drop this patch.

OK. Thanks.

> 
> Do you agree with having one requeue list per hctx instead of per 
> request queue? This change enables eliminating 
> blk_mq_kick_requeue_list(). I think that's an interesting simplification 
> of the block layer API.

I do not see any issue with that. Indeed, it does simplify the code nicely.
Reading patch 5, I wondered though if it is really worth keeping the helpers
blk_mq_kick_requeue_list() and blk_mq_delay_kick_requeue_list(). May be calling
blk_mq_run_hw_queues() and blk_mq_delay_run_hw_queues() is better ? No strong
opinion though.

-- 
Damien Le Moal
Western Digital Research

