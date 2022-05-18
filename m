Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9370EC4332F
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 07:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiERH10 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 03:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiERH1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 03:27:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB65C864
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KrOGjE8ph4fsDqFnPoybk0p+WwHmXP/l4xSU8S8a9Pg=; b=D3+TL/FK/VUl2zKlpVngwos4CV
        7Uj0t2HuZ5mfhK+3nXIwcHIkb7FfccnqGjdAXr7kybTwRGhD8RMkz61z70hg+4NLD/WiDpsz9YiNn
        vAPZmjt8kQZJiGjYZhLbqP9GJ1wrOcyYuF/ASUHVNk3ZTKxGGuV1ZvONiwf59DvKyWfkR1nybv/s/
        GkkNbAeODnKRspjSy+A5em4kZNzYNhA6D7hLLnAwKg/dUCNPhXdNJLycQaI1wcjZELNn9Kp6+r4df
        oNHI1c6b7iIjg/EwHFF2yhtL41iJ75CPnnYUz2VfCcISq6xOe64P0ZHlNSA8VFB2x3BjyoEjdfSkt
        HHoh6WRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrE5Z-0004h0-7W; Wed, 18 May 2022 07:27:21 +0000
Date:   Wed, 18 May 2022 00:27:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Message-ID: <YoSf2UvYcW9fHebf@infradead.org>
References: <YoSWZoB1/38DdP4S@infradead.org>
 <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 09:23:45AM +0200, Hannes Reinecke wrote:
> On 5/18/22 08:47, Christoph Hellwig wrote:
> > The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
> > 
> >    loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
> > 
> Hmm. So how do we progress with the authentication patches?
> Shall I resubmit them?
> Will you be picking them up?
> Is there anything I need to fix up?

I'm a little worried adding it this late in the cycle, especially with
the (although rather trivial) crypto patches not having any reviews from
the crypto maintainers.  If you can get those we should be ready early
for the next merge window which is going to start in just a few days.
