Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949E9C77B72
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDLHJh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDLHJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD93A90
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA3E62850
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8689C4339B;
        Wed, 12 Apr 2023 07:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283373;
        bh=bapXpQ+R2PodmGFiE4tTTVezxuI76uXKwHlz9GSIaAU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KCdyWA7YHThbHzsV77sc/dzJQmRlaCbmQcGZnGYVnYIFtd18lp7DDfgN53oNvWnkD
         dH14kHK0KfWj+6I/v4cEGK6rmxW3qiIxXy7RS3cFiQRoJNgZnhdKmJtCcoPYtEbPiw
         5G0d+61g5QePsiBEK8f9loL8ebUh10VKfVig6nx5smAVdiSHmjt1nNmQvccT+5UGBo
         MHj19pEEbPEvbNtlsPCrMTuYTi528bX1jCOOO+uo+bgNjk6TE3TCFR0Z1bx1J7tlN2
         a1wQknako4nM6OFu+hm5YmnByLD6a/qF5lpXb9DiCLPnXTAF1qflmz0U618D9CFRah
         XCCZouvMebnKw==
Message-ID: <11126a71-d43e-9b20-f043-067b3b264d38@kernel.org>
Date:   Wed, 12 Apr 2023 16:09:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 05/18] blk-mq: fold blk_mq_sched_insert_requests into
 blk_mq_dispatch_plug_list
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-6-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> blk_mq_dispatch_plug_list is the only caller of
> blk_mq_sched_insert_requests, and it makes sense to just fold it there
> as blk_mq_sched_insert_requests isn't specific to I/O schedulers despite
> the name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


