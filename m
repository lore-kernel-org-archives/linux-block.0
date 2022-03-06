Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9311C433F5
	for <linux-block@archiver.kernel.org>; Sun,  6 Mar 2022 09:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiCFJac (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 04:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiCFJac (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 04:30:32 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D64222517
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 01:29:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E26C068B05; Sun,  6 Mar 2022 10:29:37 +0100 (CET)
Date:   Sun, 6 Mar 2022 10:29:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dm: support bio polling
Message-ID: <20220306092937.GC22883@lst.de>
References: <20220305020804.54010-1-snitzer@redhat.com> <20220305020804.54010-3-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305020804.54010-3-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/*
> + * Reuse ->bi_end_io as hlist head for storing all dm_io instances
> + * associated with this bio, and this bio's bi_end_io has to be
> + * stored in one of 'dm_io' instance first.
> + */
> +static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
> +{
> +	WARN_ON_ONCE(!(bio->bi_opf & REQ_DM_POLL_LIST));
> +
> +	return (struct hlist_head *)&bio->bi_end_io;
> +}

So this reuse is what I really hated.  I still think we should be able
to find space in the bio by creatively shifting fields around to just
add the hlist there directly, which would remove the need for this
override and more importantly the quite cumbersome saving and restoring
of the end_io handler.
