Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ECAC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjERXNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjERXNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:13:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7DE48
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C03BE60F11
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979D3C433D2;
        Thu, 18 May 2023 23:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684451620;
        bh=ivpRGLjmAoiZg3gMSvErdyT/4PYMSKErpB0fgw+EC5E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qTE2RhAAXmDbOgHgYYOedNLS8CRSXLaVJlilVlMMVjWYrLE6XSFHljuvV6rZj+9SA
         I1YdoRRz8SRY52H1foCGbqX4umBHZlXIr+YO01jjq63COTU7rC5cxIhKGUsdSogSQe
         raFZay4ZrbL8jdRYbaXDwFa7XNgMx4iMerzG1XzMEHlNwI5lPK7hJmimIAfITD9ll7
         HU2KqDOgC9x1wOPhbKqTVyHy61Mn5NSvP1wmhO3sVtBc+xUcfIGfw7oncz6D3WNlAg
         /pOA1EB3iY/6v2EPlT6ACS1IOkFPZdMqDw3QDiVxNm9ro8JYkZW0WikHomkLwhv5QU
         nrasn6nrlkgIw==
Message-ID: <23b5847c-f1ec-ebf9-4f52-aeb00c5f56e7@kernel.org>
Date:   Fri, 19 May 2023 08:13:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 05/11] block: Introduce blk_rq_is_seq_zoned_write()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20230517174230.897144-1-bvanassche@acm.org>
 <20230517174230.897144-6-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230517174230.897144-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 02:42, Bart Van Assche wrote:
> Introduce the function blk_rq_is_seq_zoned_write(). This function will
> be used in later patches to preserve the order of zoned writes that
> require write serialization.
> 
> This patch includes an optimization: instead of using
> rq->q->disk->part0->bd_queue to check whether or not the queue is
> associated with a zoned block device, use rq->q->disk->queue.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

