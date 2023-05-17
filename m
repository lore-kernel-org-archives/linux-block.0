Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA3C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 01:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjEQBNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 21:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEQBNv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 21:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2D19A6
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 18:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA9763CEE
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 01:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC942C433D2;
        Wed, 17 May 2023 01:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684286029;
        bh=mlC/PuKfQ18sG+bfwwF73NrepieyVzWbXOw0l/ME6KU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f7G2JEClnF/t0Rci32E3yi962VIlFl8utaUliQVlcsHXF3vAucZPVvRubMSJzdoHu
         YbXmC8QT+q/HMlSH3u0DoK4uPlrah3mkwHNqTs+aV4uJmISJYhfAnz3mCJej7uywQE
         DQCxM4Fy+hvaPhI8RHxhxVBmZmLMWSV4f7R99BJ2/uUuav0e61J0CAfY3d31Y6H39b
         rsxzDLACPkCj3KeTGdK6tlUbKadWJgbq7CHMa3tFkYYQI4WTXEfcmfQob5otd2rQNT
         TnvguuC6iK5bz6o08Mm2CfAFzvgZYzJaB19iq4HvDlKqSEsF2iOihIcaNgmROuPZSp
         s09GIvEB5MY+A==
Message-ID: <9c64b867-6c6c-67c7-1e77-64c97a0ff2c8@kernel.org>
Date:   Wed, 17 May 2023 10:13:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 09/11] block: mq-deadline: Track the dispatch position
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-10-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-10-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Track the position (sector_t) of the most recently dispatched request
> instead of tracking a pointer to the next request to dispatch. This
> patch is the basis for patch "Handle requeued requests correctly".
> Without this patch it would be significantly more complicated to make
> sure that zoned writes are dispatched in LBA order per zone.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK. One nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -433,9 +445,11 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	 * batches are currently reads XOR writes
>  	 */
>  	rq = deadline_next_request(dd, per_prio, dd->last_dir);
> -	if (rq && dd->batching < dd->fifo_batch)
> +	if (rq && dd->batching < dd->fifo_batch) {
>  		/* we have a next request are still entitled to batch */

Nit: while at it, please fix this comment:

...next request are still... -> ...next request and are still...

-- 
Damien Le Moal
Western Digital Research

