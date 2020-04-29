Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD4C83004
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B542076B
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Em9EgEXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD2HZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2HZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:25:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77AC03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 00:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fz7YvTteGsbwDD1xQ7rtJeSrJPCkNtXf+waUXaJnNJU=; b=Em9EgEXjr9UTQ5kbnTMeNMwpV9
        QVZ+lof1shiLJ/wUTCqnqscSFZa8MPfonJ0EvbjJrlUkSFJ4PKjYheBmP1Wlh6KE5SDpnfpHmZ9lo
        wmq/A5zgtA//HJUSCDV22fPPoI8bt4OACkSMRIYwADPALZm26Kwg1cbr/90sxCReF+ToLZkZKvKji
        tbIacBz+FDxzS/ASRzRMMCpszQYiUCM0w8uC3KBtSGHp5KMqXBNdT008OSC8JPpKXX5BGvJfsX32E
        HrzvSaK7JjXBWVJ9Wn7YvUS9XFFQO9Gw5esoggZMCpSpk5qUPJdfVcxw+DctJnb9dNfnNrBjlOKLi
        EosBUhMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTh5y-0000iB-B2; Wed, 29 Apr 2020 07:25:26 +0000
Date:   Wed, 29 Apr 2020 00:25:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/3] block: move blkcg_bio_issue_check out of line
Message-ID: <20200429072526.GB11410@infradead.org>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
 <20200428164434.1517-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428164434.1517-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Follow up comments below:

> +	rcu_read_lock();
> +
> +	if (!bio->bi_blkg) {
> +		char b[BDEVNAME_SIZE];
> +
> +		WARN_ONCE(1,
> +			  "no blkg associated for bio on block-device: %s\n",
> +			  bio_devname(bio, b));
> +		bio_associate_blkg(bio);
> +	}
> +
> +	blkg = bio->bi_blkg;

We now always assign a bi_blkg, so as a follow on patch we should
probab;y remove this check and assign blkg at the time of declaration.

> +
> +	throtl = blk_throtl_bio(q, blkg, bio);
> +
> +	if (!throtl) {

The empty line hurts my feelings :)

> +		struct blkg_iostat_set *bis;
> +		int rwd, cpu;
> +
> +		if (op_is_discard(bio->bi_opf))
> +			rwd = BLKG_IOSTAT_DISCARD;
> +		else if (op_is_write(bio->bi_opf))
> +			rwd = BLKG_IOSTAT_WRITE;
> +		else
> +			rwd = BLKG_IOSTAT_READ;
> +
> +		cpu = get_cpu();
> +		bis = per_cpu_ptr(blkg->iostat_cpu, cpu);
> +		u64_stats_update_begin(&bis->sync);
> +
> +		/*
> +		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
> +		 * is a split bio and we would have already accounted for the
> +		 * size of the bio.
> +		 */
> +		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))
> +			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
> +		bis->cur.ios[rwd]++;
> +
> +		u64_stats_update_end(&bis->sync);
> +		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> +			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
> +		put_cpu();

As-is this will clash with my BIO_QUEUE_ENTERED cleanup.

> @@ -666,6 +609,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
>  	}
>  }
>  
> +bool blkcg_bio_issue_check(struct request_queue *q, struct bio *bio);

It might be worth to just throw a IS_ENABLED(CONFIG_BLK_CGROUP) into
the caller and avoid the need for a stub in the header.
