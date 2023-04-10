Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA4C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 08:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDJIHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 04:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJIHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 04:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A3C30C4
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 01:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DDD060FF4
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 08:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7147AC433EF;
        Mon, 10 Apr 2023 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681114056;
        bh=Hwcd0GM7EQCZeVknn8tUTdqslPGQqjypP7zJXNC1uiM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FBBSMnzfh0i0tlUAqydX1iQa+GYmo8u/n5vMIwiSVDmx+ltH/BINKlOhRvzkyackz
         Ic3Y82HaeqUdOLL8zZGKCq/Yi6n7HIPIixpluAiSPuvVMSo6VSZ1Y5kadJe7B8LIiP
         Ths7NT4UxrrZRaBn5xTd+uo5pPWS/9ByjNOqbXe+k53M71UVWPOh5maJF+mR1kEJwE
         dmy7/i64ynFpApDk6K/WGJErADxBbmvlQ5SVLX3lcjVL9ctkOlNyrlPt2MT5F0fMzZ
         T8OTe3X5PEyCUKoQ3Yo5eIQWo+eJ9/9qidudsIz/n+zwXctqwVQGOqMidk7b2SxQg9
         QpFOSB1O91k/Q==
Message-ID: <98e89013-293f-48ef-f3bd-99361a40e2fa@kernel.org>
Date:   Mon, 10 Apr 2023 17:07:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 08/12] block: mq-deadline: Simplify
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-9-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Make deadline_skip_seq_writes() shorter without changing its
> functionality.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index d885ccf49170..50a9d3b0a291 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -312,12 +312,9 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>  						struct request *rq)
>  {
>  	sector_t pos = blk_rq_pos(rq);
> -	sector_t skipped_sectors = 0;
>  
> -	while (rq) {
> -		if (blk_rq_pos(rq) != pos + skipped_sectors)
> -			break;
> -		skipped_sectors += blk_rq_sectors(rq);
> +	while (rq && blk_rq_pos(rq) == pos) {
> +		pos += blk_rq_sectors(rq);
>  		rq = deadline_latter_request(rq);
>  	}

Not really related to this series at all. But looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

