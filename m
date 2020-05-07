Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9961C38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC102075E
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 14:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BOEHVS+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGOQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgEGOQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 10:16:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D0C05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k65iyTew56Ke0FdLWFNdMdNQwScN1CG7NT2qO6sTg2U=; b=BOEHVS+baLjlTRPwsSCXI+qyHX
        MeyfaBp1IfnDhkhVIGDggFgFVE3qbAJbMbuy/NN8DhWbRng49nFgJN0Ul6jYz/TtD1B0b0dGkBt6T
        FKhNo6IzcDroE+csn/BT/8BVX9r4qb0g34oy5cZ3bU7X6Acapd8vFUmTbeI+RKYo0YVLtVo/M6Bh8
        oKw6aqOdTAhe1NOUINKtCWQ4l5aS7FQOYBz4ROe7PB1hF2Ezh0bbR/Cc/dlDi0MuxTEWV7c2egzdp
        5xCkaK8k7VncVewr5wcwzefDZd7SlwRd2rIZhP4zajC5+jg4otk0k7PeTP+D614EUXee+yxQesNR4
        lcnDlhGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWhK6-0002Ad-4a; Thu, 07 May 2020 14:16:26 +0000
Date:   Thu, 7 May 2020 07:16:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 1/4] block: fix use-after-free on cached last_lookup
 partition
Message-ID: <20200507141626.GA11551@infradead.org>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
 <20200507085239.1354854-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507085239.1354854-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 04:52:36PM +0800, Ming Lei wrote:
>  	for (i = 1; i < ptbl->len; i++) {
>  		part = rcu_dereference(ptbl->part[i]);
>  
>  		if (part && sector_in_part(part, sector)) {
> +			if (!hd_struct_try_get(part))
> +				goto exit;

I think this needs the comment that was in blk_account_io_start to
explain the logic.  Also no need for the goto, this can just be a break.

> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
>  	kobject_put(part->holder_dir);
>  	device_del(part_to_dev(part));
>  
> @@ -393,6 +402,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  	p->nr_sects = len;
>  	p->partno = partno;
>  	p->policy = get_disk_ro(disk);
> +	p->disk = disk;

Do we really need this pointer?  Can't we use part_to_disk in the
free path for some reason?
