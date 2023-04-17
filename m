Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A30C77B72
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 06:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjDQGcY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDQGb5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA81706
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEAF761E54
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA44C433D2;
        Mon, 17 Apr 2023 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681713115;
        bh=FuqMeUUFUFqfx+vDVk7EkNdOnBFMe9AmahPF/gNdcnI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WW3Ibo/Myj4VZUBbnJYw6II6Ca11ARI3VbBseLNyo7YemW5v7PT+ovZhhsDTyPGoc
         hwmcRZEADbonqLWQbG3q/G+ssnPbCpSbU6uclCc71898HGhJSkIXIeuqCa5WZXnycE
         LnOo/xD/aSi6ivHynjS4tL3waGihgcYh2HY62RkjV3RXnHPkJMum0sVc9/mRjeYIaI
         fg1rxAhkPyGLFL1WmEUU5hnKfrV59w4cIsLl0gQ0fAnhbaOx06mz4v420iruYKOshH
         nWoayquyLJMvCZ/5cHvukDCm0MfMjLUenj9ApF5cOepXSdlHDmRP0l5hgvjfVYApok
         HnBldfg7ko3vw==
Message-ID: <55f7ec00-2e78-6de9-c8ce-95af82d0653b@kernel.org>
Date:   Mon, 17 Apr 2023 15:31:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/7] blk-mq: defer to the normal submission path for
 non-flush flush commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-4-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230416200930.29542-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/23 05:09, Christoph Hellwig wrote:
> If blk_insert_flush decides that a command does not need to use the
> flush state machine, return false and let blk_mq_submit_bio handle
> it the normal way (including using an I/O scheduler) instead of doing
> a bypass insert.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

