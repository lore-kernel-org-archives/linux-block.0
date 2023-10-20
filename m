Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B79CDB474
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 16:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377756AbjJTQZq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbjJTQZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 12:25:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075801A8
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 09:25:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE901C433C8;
        Fri, 20 Oct 2023 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697819142;
        bh=UP9gGnH+TMdepTYQpqbOnkkE8UJZHaoe0fFcfivPJXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+IuCMzFvhxtIx2NYnuc80RdD4Ae4RyQeD2dXvfhJtBivw/VeSML7krktd3dPs8Kx
         StkJT61SLa8OJ4o3i9o/yTI6QwxE61m4YOZ44+cTDhpGe5Gx50Th6P949Bg8lzbyf8
         knTg1e1YNcHosgJ/r8wJXvNbhfXeYpgR09uu9WVWvvlkO9DOgLoe9FA8BB/iVpUShw
         5WW4Mq737K/s1WvDP+Sy6rurGWoMQ4EvUykEGM9dxN/tkBzJmuwBFQIeupxhI1MBMH
         6Q7DjWq5SocQyZGW5OYq2AxtKcg0BnUuu+HvePyKvBdpCmjbmgg6SBIuKKid47d1A+
         QVQYQ8lUUUXyg==
Date:   Fri, 20 Oct 2023 10:25:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH] block: Improve shared tag set performance
Message-ID: <ZTKqAzSPNcBp4db0@kbusch-mbp>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
 <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 20, 2023 at 09:17:11AM -0700, Bart Van Assche wrote:
> On 10/19/23 21:41, Christoph Hellwig wrote:
> > On Wed, Oct 18, 2023 at 11:00:56AM -0700, Bart Van Assche wrote:
> > > Note: it has been attempted to rework this algorithm. See also "[PATCH
> > > RFC 0/7] blk-mq: improve tag fair sharing"
> > > (https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/).
> > > Given the complexity of that patch series, I do not expect that patch
> > > series to be merged.
> > 
> > Work is hard, so let's skip it?  That's not really the most convincing
> > argument.  Hey, I'm the biggest advocate for code improvement by code
> > removal, but you better have a really good argument why it doesn't hurt
> > anyone.
> 
> Hi Christoph,
> 
> No, it's not because it's hard to improve the tag fairness algorithm
> that I'm proposing to skip this work. It's because I'm convinced that
> an improved fairness algorithm will have a negative performance impact
> that is larger than that of the current algorithm.
> 
> Do you agree that the legacy block layer never had any such fairness
> algorithm and also that nobody ever complained about fairness issues
> for the legacy block layer? I think that's a strong argument in favor of
> removing the fairness algorithm.

The legacy block request layer didn't have a tag resource shared among
multiple request queues. Each queue had their own mempool for allocating
requests. The mempool, I think, would always guarantee everyone could
get at least one request.
