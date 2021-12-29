Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBCC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 20:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhL2U7y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 15:59:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50070 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhL2U7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 15:59:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F0461574
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 20:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973E1C36AE9;
        Wed, 29 Dec 2021 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640811588;
        bh=NAqyhgw99dAwFdyQP9icowfMzXhwfK1rXJgGi/VcBC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dx+PRw3oJdRxSinCLrl5tEkpWAT9MVuSuSQvv/2sNivxh0putoKe03auS0T5Rt2LE
         M88FUYwAJcwKHNBaiBycj5wfivzV+3vkqtu9+Hyk+FajgwPPe+NZH1ipuE2IU6KNlv
         jKylh6HuMe9dYHG3on8nIdWVFKMlpJxRWM8oCsDn9vtjVDveSpCz1THSSkbgmKQW7u
         FgU/ZtvOuhnqX1tIHZWqkfFaGh1BNHO7z4ni6zfaw6T7NdqvRr/C1xv3aNxSRmCC60
         zgiG7ZkckZvRMRszbTyxuDS6sA6OsukN8GsnetrIjLqjVcYL/iryX8NxkJ35YzhWHD
         F1MjhY6uV5v4A==
Date:   Wed, 29 Dec 2021 12:59:45 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 2/3] block: introduce rq_list_move
Message-ID: <20211229205945.GB2493133@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-2-kbusch@kernel.org>
 <20211229174109.GB28058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229174109.GB28058@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 29, 2021 at 06:41:09PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 27, 2021 at 08:41:37AM -0800, Keith Busch wrote:
> > +/**
> > + * rq_list_move() - move a struct request from one list to another
> > + * @src: The source list @rq is currently in
> > + * @dst: The destination list that @rq will be appended to
> > + * @rq: The request to move
> > + * @prv: The request preceding @rq in @src (NULL if @rq is the head)
> > + * @nxt: The request following @rq in @src (NULL if @rq is the tail)
> > + */
> > +static void inline rq_list_move(struct request **src, struct request **dst,
> > +				struct request *rq, struct request *prv,
> > +				struct request *nxt)
> > +{
> > +	if (prv)
> > +		prv->rq_next = nxt;
> > +	else
> > +		*src = nxt;
> > +	rq_list_add(dst, rq);
> > +}
> 
> Do we even need the nxt argument?  I think it should always be
> rq->rq_next?

Sure. I only used it here because the safe iterator already has rq_next.
It's not an optimization, so I'll remove it.
