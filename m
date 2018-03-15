Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeCONrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 09:47:21 -0400
Date: Thu, 15 Mar 2018 06:47:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] bcache: enable big endian support for IBM s390x
Message-ID: <20180315134720.GA14209@infradead.org>
References: <20180315111500.24865-1-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315111500.24865-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +static void swap_cache_sb_from_cpu(struct cache_sb *sb,
> +				   struct cache_sb *out)
> +{
> +	int i;
> +
> +	out->offset		= cpu_to_le64(sb->offset);
> +	out->flags		= cpu_to_le64(sb->flags);
> +	out->seq		= cpu_to_le64(sb->seq);

This looks completely bogus and sparse will complain loudly about it.
Please make sure you have proper endianess annotations in place.
