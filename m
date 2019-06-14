Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E4C46477
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 05:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7DF2133D
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 05:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfFNFpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:45:43 -0400
Received: from verein.lst.de ([213.95.11.211]:44066 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfFNFpn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 01:45:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9EDEB68B02; Fri, 14 Jun 2019 07:45:14 +0200 (CEST)
Date:   Fri, 14 Jun 2019 07:45:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: alternative take on the same page merging leak fix v2
Message-ID: <20190614054514.GB6722@lst.de>
References: <20190613095529.25005-1-hch@lst.de> <00c908ad-ca33-164d-3741-6c67813c1f0d@kernel.dk> <20190614011946.GB14436@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614011946.GB14436@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 14, 2019 at 09:19:47AM +0800, Ming Lei wrote:
> On Thu, Jun 13, 2019 at 04:04:03AM -0600, Jens Axboe wrote:
> > On 6/13/19 3:55 AM, Christoph Hellwig wrote:
> > > Hi Jens, hi Ming,
> > > 
> > > this is the tested and split version of what I think is the better
> > > fix for the get_user_pages page leak, as it leaves the intelligence
> > > in the callers instead of in bio_try_to_merge_page.
> > > 
> > > Changes since v1:
> > >   - drop patches not required for 5.2
> > >   - added Reviewed-by tags
> > 
> > Applied for 5.2, thanks.
> 
> Hi Jens & Christoph,
> 
> Looks the following change is missed in patch 1, otherwise kernel oops
> is triggered during kernel booting:

Ok, true, sorry.

Reviewed-by: Christoph Hellwig <hch@lst.de>

and you probably want to cook it up for Jens with a proper changelog.
