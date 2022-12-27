Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1881BC4167B
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 16:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiL0QtX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 11:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiL0QtW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 11:49:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED42393
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 08:49:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18813B80EC3
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 16:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4781EC433EF;
        Tue, 27 Dec 2022 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672159758;
        bh=9fVjb1wYQrxL91F9uk42SKxCwYZVJ20/WG5Bu5wrHG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nn3y2MFGYqK0BbWOPfMjdpLU1ZEPj6DSbTDPih5s34+qfnRYu72mSeEpAcfsui2hV
         GuZj9RftdMzwQmvx7u/OzS1UTUgiS3p7xXpJk6pKssqj+soOT8wxtVrxO6lm5U7JXU
         Zi6l2o/NWEDLLrZ9SMHly+Fpg99yLiNt+LOZbnlGldxWZDmZqL7L6WSTtqs5Fq4XOs
         l5WHevelLq1U3G2vMhIjUvo5lzicgyE/pRmfZsS5Ab3qXBjZwvRaRCy/JWZoev+VIW
         4jQy+Rv1dDEWqUaP5JaFA6uv3FizsvRBk6Kubbny7nQJqz++zKgsA/P7cmIfCHqwAL
         myaEJzpxCEMcQ==
Date:   Tue, 27 Dec 2022 09:49:15 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com
Subject: Re: [PATCH] block: save user max_sectors limit
Message-ID: <Y6siCw6JFqTpsObx@kbusch-mbp>
References: <20221222175204.1782061-1-kbusch@meta.com>
 <20221223060009.GA3088@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223060009.GA3088@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 23, 2022 at 07:00:09AM +0100, Christoph Hellwig wrote:
> On Thu, Dec 22, 2022 at 09:52:04AM -0800, Keith Busch wrote:
> > +		max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
> 
> And please make BLK_DEF_MAX_SECTORS an unsigned constant as it should be
> and drop the min_t here.  Instead of working around type mismatches
> just avoid them from the beginning..

Let me just make sure I understand: you don't want BLK_DEF_MAX_SECTORS
defined in an enum, and instead want it a 'const unsigned int'? Or
#define?
 
> > +	} else if (max_sectors_kb > max_hw_sectors_kb ||
> > +		   max_sectors_kb < page_kb)  {
> >  		return -EINVAL;
> 
> And this check should probably move above the old one to keep the
> sanity checks first.
> 
> > +	} else {
> > +		q->limits.max_user_sectors = max_sectors_kb << 1;
> > +	}
> 
> i.e.
> 
> 	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
> 		return -EINVAL;
> 
> 	q->limits.max_user_sectors = max_sectors_kb << 1;
> 
> 	/* reset to default when the user clears max_sectors_kb: */
> 	if (max_sectors_kb == 0) {

We'll never reach here since 0 is < page_kb. But I think I can clean
this up a little bit for the next version.

> 		max_sectors_kb =
> 			min(max_hw_sectors_kb, BLK_DEF_MAX_SECTORS >> 1);
> 	}
