Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32000C31E40
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 23:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F006220B1F
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 23:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565132466;
	bh=vGl/qyUj+m3xdNJaJ9fF/HjSzIEZvTJK5xJjIUiHOxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nT3VC3EhrIqqUNfL62mtO0W/+H449Ma8gKWOsA+JdbiaiUthgyWQnoQZTsN6bfWSj
	 U8rdPkHiamOGr9JNZbxX9AOsGT4kJowPy3hsCuoK6FNTJtolepF/8OcMR00q/4jdo1
	 czJcTE1cNgQbwY484Pf6YsS63728QYFSCwS5BeBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfHFXBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfHFXBF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 19:01:05 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7A32070D;
        Tue,  6 Aug 2019 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565132464;
        bh=vGl/qyUj+m3xdNJaJ9fF/HjSzIEZvTJK5xJjIUiHOxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ram+yxpjoZZlMPdi2p/p8wC9xbLXU244ul4IK2w7JME7Dob0R4Qy/D1hsmAvZ0GDM
         lPuIhCuLFw5/g2cagStWN5Eua65k6HVxgrIAfPon7hrUHTVSJGBaJH22M3WDg17C6L
         TdVf/pEW1LNxxYciU9FWLJmB9xyejRP00N6oKK4k=
Date:   Tue, 6 Aug 2019 16:01:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-Id: <20190806160102.11366694af6b56d9c4ca6ea3@linux-foundation.org>
In-Reply-To: <20190803140155.181190-3-tj@kernel.org>
References: <20190803140155.181190-1-tj@kernel.org>
        <20190803140155.181190-3-tj@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat,  3 Aug 2019 07:01:53 -0700 Tejun Heo <tj@kernel.org> wrote:

> There currently is no way to universally identify and lookup a bdi
> without holding a reference and pointer to it.  This patch adds an
> non-recycling bdi->id and implements bdi_get_by_id() which looks up
> bdis by their ids.  This will be used by memcg foreign inode flushing.

Why is the id non-recycling?  Presumably to address some
lifetime/lookup issues, but what are they?

Why was the IDR code not used?

> I left bdi_list alone for simplicity and because while rb_tree does
> support rcu assignment it doesn't seem to guarantee lossless walk when
> walk is racing aginst tree rebalance operations.
> 
> ...
>
> +/**
> + * bdi_get_by_id - lookup and get bdi from its id
> + * @id: bdi id to lookup
> + *
> + * Find bdi matching @id and get it.  Returns NULL if the matching bdi
> + * doesn't exist or is already unregistered.
> + */
> +struct backing_dev_info *bdi_get_by_id(u64 id)
> +{
> +	struct backing_dev_info *bdi = NULL;
> +	struct rb_node **p;
> +
> +	spin_lock_irq(&bdi_lock);

Why irq-safe?  Everywhere else uses spin_lock_bh(&bdi_lock).

> +	p = bdi_lookup_rb_node(id, NULL);
> +	if (*p) {
> +		bdi = rb_entry(*p, struct backing_dev_info, rb_node);
> +		bdi_get(bdi);
> +	}
> +	spin_unlock_irq(&bdi_lock);
> +
> +	return bdi;
> +}
> +
>
> ...
>
