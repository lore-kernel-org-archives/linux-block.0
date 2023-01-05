Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F857C3DA7A
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 21:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjAEVgb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 16:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjAEVga (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 16:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB72631B9
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 13:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BD961AC7
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 21:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0902EC433F0;
        Thu,  5 Jan 2023 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672954588;
        bh=KeVh1jKw9BdIxVrO4YoO91oxJe9JPk+ZXs+C4ESN3kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUBCQLuUzfMFj/5r+4dh2WQ4w8XavYfVqJmDlYPP84J7CMruT6eBpUATrNy4saVU5
         Lr7ar8muwWvySAP1+xXYmTx5/WOMpvL+lEwIUAtLaw3KVdJ0XaOoUfmR8AyKHRQzBS
         xGE+bfdduXpYVImVSJXaPm4TIt5e1tCB4FdxODvhpkElBtWRIdgu41TTJktqMm8lom
         /JMPVMY+7Ly98vhU+X9X3A+4tEdWZyvYhBJpsTJNhBsE88sVXreitp/AkGNCgk3pA+
         WVHQznhG0H8VzarkbrskGg2fjLXj5z3x+IcoJ2ibV9/WhUc/P4u2/GKiFVLklOwzLJ
         znQzxbGEOU56g==
Date:   Thu, 5 Jan 2023 14:36:25 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCHv4 2/2] block: save user max_sectors limit
Message-ID: <Y7dC2TsYBA4DeC0k@kbusch-mbp.dhcp.thefacebook.com>
References: <20230105205146.3610282-1-kbusch@meta.com>
 <20230105205146.3610282-3-kbusch@meta.com>
 <fff1ca57-b0ee-9598-9ea8-e6c8b7571f0d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff1ca57-b0ee-9598-9ea8-e6c8b7571f0d@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 05, 2023 at 01:28:35PM -0800, Bart Van Assche wrote:
> On 1/5/23 12:51, Keith Busch wrote:
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 93d9e9c9a6ea8..5486b6c57f6b8 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -239,19 +239,28 @@ static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
> >   static ssize_t
> >   queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
> >   {
> > -	unsigned long max_sectors_kb,
> > +	unsigned long var;
> > +	unsigned int max_sectors_kb,
> >   		max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1,
> >   			page_kb = 1 << (PAGE_SHIFT - 10);
> > -	ssize_t ret = queue_var_store(&max_sectors_kb, page, count);
> > +	ssize_t ret = queue_var_store(&var, page, count);
> >   	if (ret < 0)
> >   		return ret;
> > -	max_hw_sectors_kb = min_not_zero(max_hw_sectors_kb, (unsigned long)
> > +	max_sectors_kb = (unsigned int)var;
> 
> Shouldn't this function report an error if 'var' is too large to fit into an
> unsigned int?

Yes it should, and queue_var_store() will return -EINVAL if that
happens. That's certainly not clear just from reading this patch, but
the condition is handled.
