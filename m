Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE39C282E6
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 12:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C62218DE
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556193808;
	bh=3teiry0GP5N2V5/ntUrKPPVdSbI5eu3R9VMzfBJx9CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aswsgeSMojUZ7+Cwkd1RsV08ozLoVH5IZsrjK4Oc4/TF/i43AL/Ds1nDynZRy+oJ+
	 LoIUz+Lojngqoyq0lDYdwpDYHOkvsEIcQ1BrRd2wo+I2r6wx6FS6TP6FBAjKwBBpBZ
	 6uBb23GFD7uxOvII5y0cjV6jH5EWoMPkrnNgRwvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfDYMD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:03:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:55564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728167AbfDYMDZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 08:03:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43961AD45;
        Thu, 25 Apr 2019 12:03:24 +0000 (UTC)
Date:   Thu, 25 Apr 2019 14:03:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        lsf-pc@lists.linux-foundation.org,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM TOPIC] guarantee natural alignment for kmalloc()?
Message-ID: <20190425120322.GW12751@dhcp22.suse.cz>
References: <790b68b7-3689-0ff6-08ae-936728bc6458@suse.cz>
 <20190411132819.GB22763@bombadil.infradead.org>
 <20190425113358.GI19031@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425113358.GI19031@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 25-04-19 04:33:59, Matthew Wilcox wrote:
> On Thu, Apr 11, 2019 at 06:28:19AM -0700, Matthew Wilcox wrote:
> > On Thu, Apr 11, 2019 at 02:52:08PM +0200, Vlastimil Babka wrote:
> > > In the session I hope to resolve the question whether this is indeed the
> > > right thing to do for all kmalloc() users, without an explicit alignment
> > > requests, and if it's worth the potentially worse
> > > performance/fragmentation it would impose on a hypothetical new slab
> > > implementation for which it wouldn't be optimal to split power-of-two
> > > sized pages into power-of-two-sized objects (or whether there are any
> > > other downsides).
> > 
> > I think this is exactly the kind of discussion that LSFMM is for!  It's
> > really a whole-system question; is Linux better-off having the flexibility
> > for allocators to return non-power-of-two aligned memory, or allowing
> > consumers of the kmalloc API to assume that "sufficiently large" memory
> > is naturally aligned.
> 
> This has been scheduled for only the MM track.  I think at least the
> filesystem people should be involved in this discussion since it's for
> their benefit.

Agreed. I have marked it as a MM/IO/FS track, we just haven't added it
to the schedule that way. I still plan to go over all topics again and
consolidate the current (very preliminary) schedule. Thanks for catching
this up.

> Do we have an lsf-discuss mailing list this year?  Might be good to
> coordinate arrivals / departures for taxi sharing purposes.

Yes, the list should be established AFAIK and same address as last
years.

-- 
Michal Hocko
SUSE Labs
