Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D441BEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 04:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjFOEPt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 00:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbjFOEPo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 00:15:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E3212A
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 21:15:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6075B67373; Thu, 15 Jun 2023 06:15:37 +0200 (CEST)
Date:   Thu, 15 Jun 2023 06:15:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Message-ID: <20230615041537.GB4281@lst.de>
References: <20230612203314.17820-1-bvanassche@acm.org> <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 14, 2023 at 08:22:31PM -0600, Jens Axboe wrote:
> I'm usually a fan of putting code in the core so we don't have to in
> drivers, that's how most of the block layer is designed. But this seems
> niche enough that perhaps it's worth considering just remapping these in
> the driver? It's peppering changes all over delicate parts of the core
> for cases that 99.9% don't need to worry about or should worry about.
> I will say that I do think the patches do look better than they did in
> earlier versions, however.
> 
> Maybe we've already discussed this before, but let's please have the
> discussion again. Because I'd really love to avoid this code, if at all
> possible.

I really hate having this core complexity, but I suspect trying to driver
hacks would be even worse than that, especially as this goes through
the SCSI midlayer.  I think the answer is simply that if Google keeps
buying broken hardware for their products from Samsung they just need
to stick to a 4k page size instead of moving to a larger one.

