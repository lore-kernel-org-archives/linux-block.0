Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF0BC433ED
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 13:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F79611CD
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 13:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhDVNTB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:19:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVNTA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 09:19:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A754B133;
        Thu, 22 Apr 2021 13:18:25 +0000 (UTC)
Subject: Re: [PATCH V6 02/12] block: define 'struct bvec_iter' as packed
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2ae12dc1-804f-59f9-6837-3508d6176804@suse.de>
Date:   Thu, 22 Apr 2021 15:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210422122038.2192933-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/21 2:20 PM, Ming Lei wrote:
> 'struct bvec_iter' is embedded into 'struct bio', define it as packed
> so that we can get one extra 4bytes for other uses without expanding
> bio.
> 
> 'struct bvec_iter' is often allocated on stack, so making it packed
> doesn't affect performance. Also I have run io_uring on both
> nvme/null_blk, and not observe performance effect in this way.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/linux/bvec.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index ff832e698efb..a0c4f41dfc83 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -43,7 +43,7 @@ struct bvec_iter {
>   
>   	unsigned int            bi_bvec_done;	/* number of bytes completed in
>   						   current bvec */
> -};
> +} __packed;
>   
>   struct bvec_iter_all {
>   	struct bio_vec	bv;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
