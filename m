Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE752C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF9D20818
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554801647;
	bh=ZHDTajHOpGP8T3Fta/OBev7zHubmKMsYTyu2qwGJLjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q0wYHVjkhIFJnjo6pb59NsmhOG540eqpq8xm1LbGymoIBwm1rg0nhvZzezlpAnzAp
	 1MeC4qXmAGqovgTXvlv/tBZwpZD2CF/+c0rNJoFCwIq8HU27hj4wJvk9H8vi4xOHGy
	 otNCNOS0HI0f904uNehEXI/L4+pq19xHcZVdpKDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDIJUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:20:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfDIJUq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 05:20:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F75FAEDF;
        Tue,  9 Apr 2019 09:20:44 +0000 (UTC)
Date:   Tue, 9 Apr 2019 11:20:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Christopher Lameter <cl@linux.com>,
        linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
Message-ID: <20190409092042.GB10383@dhcp22.suse.cz>
References: <20190319211108.15495-1-vbabka@suse.cz>
 <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
 <5d7fee9c-1a80-6ac9-ac1d-b1ce05ed27a8@suse.cz>
 <010001699c5563f8-36c6909f-ed43-4839-82da-b5f9f21594b8-000000@email.amazonses.com>
 <4d2a55dc-b29f-1309-0a8e-83b057e186e6@suse.cz>
 <01000169a68852ed-d621a35c-af0c-4759-a8a3-e97e7dfc17a5-000000@email.amazonses.com>
 <2b129aec-f9a5-7ab8-ca4a-0a325621d111@suse.cz>
 <20190407080020.GA9949@lst.de>
 <af1e0b95-f654-4fa9-d400-af01043907ab@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1e0b95-f654-4fa9-d400-af01043907ab@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 09-04-19 10:07:42, Vlastimil Babka wrote:
> On 4/7/19 10:00 AM, Christoph Hellwig wrote:
> > On Fri, Apr 05, 2019 at 07:11:17PM +0200, Vlastimil Babka wrote:
> >> On 3/22/19 6:52 PM, Christopher Lameter wrote:
> >> > On Thu, 21 Mar 2019, Vlastimil Babka wrote:
> >> > 
> >> >> That however doesn't work well for the xfs/IO case where block sizes are
> >> >> not known in advance:
> >> >>
> >> >> https://lore.kernel.org/linux-fsdevel/20190225040904.5557-1-ming.lei@redhat.com/T/#ec3a292c358d05a6b29cc4a9ce3ae6b2faf31a23f
> >> > 
> >> > I thought we agreed to use custom slab caches for that?
> >> 
> >> Hm maybe I missed something but my impression was that xfs/IO folks would have
> >> to create lots of them for various sizes not known in advance, and that it
> >> wasn't practical and would welcome if kmalloc just guaranteed the alignment.
> >> But so far they haven't chimed in here in this thread, so I guess I'm wrong.
> > 
> > Yes, in XFS we might have quite a few.  Never mind all the other
> > block level consumers that might have similar reasonable expectations
> > but haven't triggered the problematic drivers yet.
> 
> What about a LSF session/BoF to sort this out, then? Would need to have people
> from all three MM+FS+IO groups, I suppose.

Sounds like a good plan. Care to send an email to lsf-pc mailing list so
that it doesn't fall through cracks please?

-- 
Michal Hocko
SUSE Labs
