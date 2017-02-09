Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51298 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbdBIJne (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Feb 2017 04:43:34 -0500
Date: Thu, 9 Feb 2017 10:36:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] dm-zoned: Zoned block device target
Message-ID: <20170209093606.GA8189@lst.de>
References: <20170209041849.30964-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209041849.30964-1-damien.lemoal@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 09, 2017 at 01:18:49PM +0900, Damien Le Moal wrote:
> +
> +/*
> + * Target BIO completion.
> + */
> +static inline void dmz_bio_end(struct bio *bio, int err)
> +{
> +	struct dm_zone_bioctx *bioctx =
> +		dm_per_bio_data(bio, sizeof(struct dm_zone_bioctx));
> +
> +	if (atomic_dec_and_test(&bioctx->ref)) {

It seems like this could be simplified a bit by using bio_chain
to chain the clones to the original bio.
