Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6096C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjERXJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjERXJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB2AB5
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8F31652D3
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44411C433EF;
        Thu, 18 May 2023 23:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684451380;
        bh=i2eRsM/WgayyB7dR19weAi3DEazD3TX95r2Ys4siX48=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KHcWN1ZAeePd5jw1RqWgl5xrfSASQDG32uTo8qH2Lb7XJM0tC8WIKNBR2UgMZVCPM
         jX3g20v4Dxh+xT4CeJ+JwxVY7cSwAYT3lUCpJmHV6Y80qsAiqJle7E/eYPWrlg5tcg
         yIS+Ki21flbu6ExhoCbc2Y96bv0k820eh2XBU1uszSMdN0cWT0YNU8BjrUWx9esJDC
         Ws5YfXF2Xoxj7YPpgIKvcAvTzSXiFmodUsUfXZ5hfgn6sXCVqBiVQmrtRmzsqXt7IZ
         4ZQ9eguG3xq+jLcfEKQE5yay+Wzk4G2Zbd1xEhxwYkOm5tVjfWuzPBlq/iRQO5c6Yo
         uCkQJO1Wtc+ew==
Message-ID: <dc8d1147-6979-6d9c-db9e-aa7c44d95e94@kernel.org>
Date:   Fri, 19 May 2023 08:09:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] block: Decode all flag names in the debugfs output
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20230518222708.1190867-1-bvanassche@acm.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230518222708.1190867-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/23 07:27, Bart Van Assche wrote:
> See also:
> * Commit 4d337cebcb1c ("blk-mq: avoid to touch q->elevator without any protection").
> * Commit 414dd48e882c ("blk-mq: add tagset quiesce interface").
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

