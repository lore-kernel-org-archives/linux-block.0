Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB2C07E9B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEED611C1
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhGUETt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 00:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhGUETi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 00:19:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714EC061574;
        Tue, 20 Jul 2021 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IctsTVrtwipEv00mkrFyUnMJXKowudn2hKnX1KBUBjo=; b=IXImCDQ2qlkdgYwRnUusz3CUhb
        x3Uir6PJDYrIuiJWCCbQXFXPwpEh8Ygz9na3CmtqFlPzGL7QyppNWm2BPlCToQ+A8xvJAk9vE5uh5
        SmXfvm9o7alqEz7CzZ9hE+WCFs8/IRthEYy0GhaTwoi2aByAbp4fIOzC1OtpxtElaeI182YIe5yyr
        2otH1MtdwlbtYQ3ZpnEB691t+X9zOoV3WzOESfm2kC81aZxjog/LnuaMAZ75Bhf+6xdE1dox/IBgG
        X23ZNHb9LrkQ+bWZ9FMOdPlIpuAefmEUeqKDp4krHV4W4ZEpvuJy2WUsRNRemRf6CGm7/0nHH6VRD
        KxmAJmOw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m64KU-008o8T-0m; Wed, 21 Jul 2021 04:59:39 +0000
Date:   Wed, 21 Jul 2021 05:59:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] block: add flag for add_disk() completion notation
Message-ID: <YPeptlG19sdu18jD@infradead.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
 <20210720182048.1906526-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720182048.1906526-2-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 20, 2021 at 11:20:44AM -0700, Luis Chamberlain wrote:
> Often drivers may have complex setups where it is not
> clear if their disk completed their respective *add_disk*()
> call. They either have to invent a setting or, they
> incorrectly use GENHD_FL_UP. Using GENHD_FL_UP however is
> used internally so we know when we can add / remove
> partitions safely. We can easily fail along the way
> prior to add_disk() completing and still have
> GENHD_FL_UP set, so it would not be correct in that case
> to call del_gendisk() on the disk.
> 
> Provide a new flag then which allows us to check if
> *add_disk*() completed, and conversely just make
> del_gendisk() check for this for drivers so that
> they can safely call del_gendisk() and we'll figure
> it out if it is safe for you to call this.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/genhd.c         |  8 ++++++++
>  include/linux/genhd.h | 11 ++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index af4d2ab4a633..a858eed05e55 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -539,6 +539,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  
>  	disk_add_events(disk);
>  	blk_integrity_add(disk);
> +
> +	disk->flags |= GENHD_FL_DISK_ADDED;

I guess I failed to mention it last time - but I think this needs
to go into disk->state as dynamic state.

> + * Drivers can safely call this even if they are not sure if the respective
> + * __device_add_disk() call succeeded.
> + *
>   * Drivers exist which depend on the release of the gendisk to be synchronous,
>   * it should not be deferred.
>   *
> @@ -578,6 +583,9 @@ void del_gendisk(struct gendisk *disk)
>  {
>  	might_sleep();
>  
> +	if (!blk_disk_added(disk))
> +		return;

I still very much disagree with this check.  It just leads to really
bad driver code.  In genral we need to _fix_ the existing abuses of
the UP check in drivers, not spread this kind of sloppyness further.

