Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D02C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDMGzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDMGzb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFD83D9
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD0DC614D3
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E80C433D2;
        Thu, 13 Apr 2023 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681368930;
        bh=U6w6fGpQSV4kY7dCP+Gqi5ibd1YpUzz8LiO5+UHx+4k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t9Fwaay8AORUFuVpGTBsovHYZLwh9Gu3ZjzDM05KxmcTctJaFiw/C/leK254vuwe7
         ckDbKcAd/BsRQTk/3+nNfu3kKQQb2s7Vvbbk1PUn5Y8fzmxwVckS5Bfg/hqYG4WSTl
         enHCEwebaNswSH06OFFg6CL327b87/1qFdc/4TFbQbL3AcFs4DEKv6tYBAeRiGSCIs
         R5kA5hmmtRzsQa9pAxCM5J1gByjxOtd0r+EPZqx5MmQKrxraDBMhmXvRXKPeOq+AXh
         HQd+rtqWrHJko3yjz01iBzlQBE8sC/D3TOOCcsFWTc+i1tCaKuCijbxgnM24vqq1p3
         ytpQ/HSTUMfPQ==
Message-ID: <1a516c42-75df-6794-a80c-93cbd0ed0e43@kernel.org>
Date:   Thu, 13 Apr 2023 15:55:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 20/20] blk-mq: pass a flags argument to
 blk_mq_add_to_requeue_list
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230413064057.707578-1-hch@lst.de>
 <20230413064057.707578-21-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413064057.707578-21-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:40, Christoph Hellwig wrote:
> Replace the boolean at_head argument with the same flags that are already
> passed to blk_mq_insert_request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


