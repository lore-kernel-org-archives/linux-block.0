Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25675C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 18:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiFNSD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 14:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbiFNSD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 14:03:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F246C9E
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 11:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92182B81A43
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 18:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A3BC3411C;
        Tue, 14 Jun 2022 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655229835;
        bh=CM3K/ma6uO602Yy0eprlZDj5lcgRgrVCXieO7D2DUG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/5xBAzrsqto4Bi9qhSVspjRZZpl9PPizc8em5SSNJJueFwSNrGVbGfGKqQ2asD8K
         OruWdqFqd6F0sddAPW3kj/zF9uEKQWI21r2YNPXVo7fFWVEg2rmXb7klRUgIOgPN/t
         1FoV36LG8LLrFueuuDl+davY/oPnUYVoXlfr4XJvEX9ogqtfGwrmtS44XrDa0BBfm5
         OF3ojKWUqR8OCMtWKZWtpcKX0piVBQIVY9oD8weAWrDtkjkI6I+G4OFm8TuqEtRTR7
         ecvmw2FK5pTp6mExp/jmyHVKpnruHXY+SykMjMU+gnG/38QbS6sPVB9nxyZ728Ja8r
         R0eA1WOjw0Epw==
Date:   Tue, 14 Jun 2022 11:03:51 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 4/5] nvme: Increase the number of retries for zoned writes
Message-ID: <YqjNh4T+m1C4voTj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614174943.611369-5-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 10:49:42AM -0700, Bart Van Assche wrote:
> @@ -854,6 +854,10 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  	if (req->cmd_flags & REQ_RAHEAD)
>  		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>  
> +	if (blk_rq_is_seq_write(req))
> +		nvme_req(req)->max_retries += req->q->nr_hw_queues *
> +			req->q->nr_requests;

Even with the weakest nvme devices, the result of this is unlikely to fit in a
u8.
