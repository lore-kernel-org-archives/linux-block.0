Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C67C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76294610FD
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 16:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbhIXQHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbhIXQHh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 12:07:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB2C061571
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0xKq1HpoG77uyZLooIefWCYmJq2K5BRkIpXbt/aPNh0=; b=PF2xHQh9j6kGzcfn89MqpkzQ69
        lTsGmA32GuOC6qro8FH86EcPElUMYXjiC5ApnyY5kkTL22nMmh0vA+ylNO3cpSPjYxN3exUPvF8EZ
        boqlyZ7wkXOT7aqptHh6x4vJcSW64wPv7ygmRPDmgcy0n7H2c8yzp27Te0HzHC520YL79SlkGA4Mh
        PSHR/babMUurjT/Ip1edfhKhHoDUTNyMKpc4uKkX8QgNj+uoo4c1ILxXU91VsYZPW9XUPUg8a9foZ
        wriOdzw5k47FuWfoKkpUO9yEaQtMxLXadrtk+O+ZPD16y81PYkxue7k8B4mb/Uhj3/N6QgAz1uxf/
        VB8Hib0A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTnge-007NJL-VP; Fri, 24 Sep 2021 16:05:01 +0000
Date:   Fri, 24 Sep 2021 17:04:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Tejun Heo <tj@kernel.org>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH] block: only allocate blkcg->fc_app_id when starting to
 use it
Message-ID: <YU33EJ8dLgwPj2/5@infradead.org>
References: <20210924122416.1552721-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924122416.1552721-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 24, 2021 at 08:24:16PM +0800, Ming Lei wrote:
> So far the feature of BLK_CGROUP_FC_APPID is only used for LPFC, and
> only when it is setup via sysfs. It is very likely for one system to
> never use the feature, so allocate the application id buffer in case
> that someone starts to use it, then we save 129 bytes in each blkcg
> if no one uses the feature.
> 
> Cc: Muneendra Kumar <muneendra.kumar@broadcom.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-cgroup.c         |  3 +++
>  include/linux/blk-cgroup.h | 15 ++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 38b9f7684952..e452adf5f4f6 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1061,6 +1061,9 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
>  
>  	mutex_unlock(&blkcg_pol_mutex);
>  
> +#ifdef CONFIG_BLK_CGROUP_FC_APPID
> +	kfree(blkcg->fc_app_id);
> +#endif
>  	kfree(blkcg);
>  }
>  
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index b4de2010fba5..75094c0a752b 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -58,7 +58,7 @@ struct blkcg {
>  
>  	struct list_head		all_blkcgs_node;
>  #ifdef CONFIG_BLK_CGROUP_FC_APPID
> -	char                            fc_app_id[FC_APPID_LEN];
> +	char                            *fc_app_id;
>  #endif
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	struct list_head		cgwb_list;
> @@ -699,7 +699,16 @@ static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_le
>  	 * the vmid from the fabric.
>  	 * Adding the overhead of a lock is not necessary.
>  	 */
> -	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
> +	if (!blkcg->fc_app_id) {
> +		char *buf = kzalloc(FC_APPID_LEN, GFP_KERNEL);
> +
> +		if (cmpxchg(&blkcg->fc_app_id, NULL, buf))
> +			kfree(buf);
> +	}
> +	if (blkcg->fc_app_id)
> +		strlcpy(blkcg->fc_app_id, app_id, app_id_len);
> +	else
> +		ret = -ENOMEM;

This looks a little cumbersome.  Why not return -ENOMEM using a new
label directly after the kzalloc?  More importantly there alredy must
be something synchronizing the strlcpy, so why do we even need the
cmpxchg?

>  static inline char *blkcg_get_fc_appid(struct bio *bio)
>  {
> -	if (bio && bio->bi_blkg &&
> +	if (bio && bio->bi_blkg && bio->bi_blkg->blkcg->fc_app_id &&
>  		(bio->bi_blkg->blkcg->fc_app_id[0] != '\0'))
>  		return bio->bi_blkg->blkcg->fc_app_id;
>  	return NULL;

And given that we must have some synchronization anyway, why not just
free the appid when it is set to an empty string rather than adding yet
another check here in the fast path?
