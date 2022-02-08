Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE7C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 09:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiBHJDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 04:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352929AbiBHJDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 04:03:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F472C03FED0
        for <linux-block@vger.kernel.org>; Tue,  8 Feb 2022 01:02:59 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JtH4F10z1z67M49;
        Tue,  8 Feb 2022 16:58:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 10:02:57 +0100
Received: from [10.47.82.28] (10.47.82.28) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 09:02:54 +0000
Message-ID: <2fbebb37-625a-918e-ff53-98d6e6bc979e@huawei.com>
Date:   Tue, 8 Feb 2022 09:02:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V2] lib/sbitmap: kill 'depth' from sbitmap_word
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Martin Wilck <martin.wilck@suse.com>
References: <20220110072945.347535-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220110072945.347535-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.28]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/01/2022 07:29, Ming Lei wrote:
> Only the last sbitmap_word can have different depth, and all the others
> must have same depth of 1U << sb->shift, so not necessary to store it in
> sbitmap_word, and it can be retrieved easily and efficiently by adding
> one internal helper of __map_depth(sb, index).
> 
> Remove 'depth' field from sbitmap_word, then the annotation of
> ____cacheline_aligned_in_smp for 'word' isn't needed any more.
> 
> Not see performance effect when running high parallel IOPS test on
> null_blk.
> 
> This way saves us one cacheline(usually 64 words) per each sbitmap_word.
> 
> Cc: Martin Wilck <martin.wilck@suse.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
> V2:
> 	- remove the annotation of ____cacheline_aligned_in_smp for 'word'
> 	as suggested by Jens
> 
>   include/linux/sbitmap.h | 17 ++++++++++-------
>   lib/sbitmap.c           | 34 ++++++++++++++--------------------
>   2 files changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index fc0357a6e19b..3754dc45f890 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -27,15 +27,10 @@ struct seq_file;
>    * struct sbitmap_word - Word in a &struct sbitmap.
>    */
>   struct sbitmap_word {
> -	/**
> -	 * @depth: Number of bits being used in @word/@cleared
> -	 */
> -	unsigned long depth;
> -
>   	/**
>   	 * @word: word holding free bits
>   	 */
> -	unsigned long word ____cacheline_aligned_in_smp;
> +	unsigned long word;
>   
>   	/**
>   	 * @cleared: word holding cleared bits
> @@ -164,6 +159,14 @@ struct sbitmap_queue {
>   int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>   		      gfp_t flags, int node, bool round_robin, bool alloc_hint);
>   
> +/* sbitmap internal helper */
> +static inline unsigned int __map_depth(const struct sbitmap *sb, int index)
> +{
> +	if (index == sb->map_nr - 1)

Do you think that unlikely may be useful?

> +		return sb->depth - (index << sb->shift);
> +	return 1U << sb->shift;
> +}
> +
