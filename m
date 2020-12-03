Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC60C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 16:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DD3206F0
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgLCQ2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgLCQ2W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 11:28:22 -0500
Date:   Thu, 3 Dec 2020 08:27:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607012861;
        bh=wUReRo78XM5Uun2j0W/OqXqbsdFmm358R6HF2fNMoaY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJtdm//mY1LwvqvPuUVAtf7xwEZuN1uRDycZXkudTT2ElKUyw11OSApW6uVSMQ+L3
         ghKbn/7nOq37kAl35frcvmGGTlZEV2i3A2/I70FKMsWeJaBOWvaRoKSa0Yl1H/Hcq0
         nDouf96IRGUJ595RvA08/4xW2DGVCOPjhLHIan9fCVno//Z9nHtGziJfrvTi0rZuCr
         /Xs+3/A+FhYlZtU8NVEMb+rr2V/+b6RiK0u+vTW415aEEW6yi/cnCoq3kXHa3v3ZZN
         48i4FV0S6I22EJN0QJKWEeXIaPJqCRhqVBov0HJaeyZeq7sJqRx+Y0GyLL9aSoADg/
         RIqsj3toijR+A==
From:   Keith Busch <kbusch@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jdorminy@redhat.com, bjohnsto@redhat.com
Subject: Re: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
Message-ID: <20201203162738.GA3404013@dhcp-10-100-145-180.wdc.com>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <20201201160709.31748-1-snitzer@redhat.com>
 <20201203032608.GD540033@T590>
 <20201203143359.GA29261@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203143359.GA29261@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 03, 2020 at 09:33:59AM -0500, Mike Snitzer wrote:
> On Wed, Dec 02 2020 at 10:26pm -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > I understand it isn't related with correctness, because the underlying
> > queue can split by its own chunk_sectors limit further. So is the issue
> > too many further-splitting on queue with chunk_sectors 8? then CPU
> > utilization is increased? Or other issue?
> 
> No, this is all about correctness.
> 
> Seems you're confining the definition of the possible stacking so that
> the top-level device isn't allowed to have its own hard requirements on
> IO sizes it sends to its internal implementation.  Just because the
> underlying device can split further doesn't mean that the top-level
> virtual driver can service larger IO sizes (not if the chunk_sectors
> stacking throws away the hint the virtual driver provided because it
> used lcm_not_zero).

I may be missing something obvious here, but if the lower layers split
to their desired boundary already, why does this limit need to stack?
Won't it also work if each layer sets their desired chunk_sectors
without considering their lower layers? The commit that initially
stacked chunk_sectors doesn't provide any explanation.
