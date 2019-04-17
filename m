Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9DEC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C4A20835
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfDQLwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:52:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbfDQLwx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 07:52:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E96F2AFFB;
        Wed, 17 Apr 2019 11:52:51 +0000 (UTC)
Subject: Re: [PATCH] block: make sure that bvec length can't be overflowed
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20190416153847.8173-1-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b36ab484-ce43-67b7-16d4-bdca59fd9e9a@suse.de>
Date:   Wed, 17 Apr 2019 13:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190416153847.8173-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/19 5:38 PM, Ming Lei wrote:
> bvec->bv_offset may be bigger than PAGE_SIZE sometimes, such as,
> when one bio is splitted in the middle of one bvec via bio_split(),
> and bi_iter.bi_bvec_done is used to build offset of the 1st bvec of
> remained bio.
> 
> So we have to make sure that every bvec's offset is less than
> PAGE_SIZE from bio_for_each_segment().
> 
> This patch fixes this issue reported by Zhang Yi When running nvme/011.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: 6dc4f100c175 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/linux/bvec.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 3bc91879e1e2..f179b370066f 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -160,8 +160,9 @@ static inline void bvec_advance(const struct bio_vec *bvec,
>   		bv->bv_page = nth_page(bv->bv_page, 1);
>   		bv->bv_offset = 0;
>   	} else {
> -		bv->bv_page = bvec->bv_page;
> -		bv->bv_offset = bvec->bv_offset;
> +		bv->bv_page = bvec_nth_page(bvec->bv_page, bvec->bv_offset /
> +					    PAGE_SIZE);
> +		bv->bv_offset = bvec->bv_offset % PAGE_SIZE;
>   	}
>   	bv->bv_len = min_t(unsigned int, PAGE_SIZE - bv->bv_offset,
>   			   bvec->bv_len - iter_all->done);
> 
Looks okay.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
