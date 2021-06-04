Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDC2C07E94
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7734261414
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 08:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFDIkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 04:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229980AbhFDIke (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Jun 2021 04:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622795928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uTBsVe7bzRrdJ/bmHfQYhbyvvHpibsEBI/sRQslKSu4=;
        b=g5nbSJxaBZZii3ZWZnyt1xxpAt7v97lfkHs2I0yskX2CDw5nX9GW8Np0m4f92VDygqWNPB
        CJsvyBD1mFCGYx2RyxQAAxt4d3+D5cXUvk5oMckXeDOz5iCzK3BK1D/oudYQrX8Yf8UPjd
        BuAqBvMQNynpc5tm7Ni3Ehe6rBKBlnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-1dhOmYYIOl61qf6ITT0eZQ-1; Fri, 04 Jun 2021 04:38:47 -0400
X-MC-Unique: 1dhOmYYIOl61qf6ITT0eZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2CFF1009446;
        Fri,  4 Jun 2021 08:38:45 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B88510013D6;
        Fri,  4 Jun 2021 08:38:37 +0000 (UTC)
Date:   Fri, 4 Jun 2021 16:38:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: return the correct bvec when checking for gaps
Message-ID: <YLnmg6EZCmauW0JK@T590>
References: <1622759671-14059-1-git-send-email-longli@linuxonhyperv.com>
 <YLmHi27PT5LAwJji@T590>
 <DM6PR21MB1513F1E0E0DDD017A4ED3B73CE3B9@DM6PR21MB1513.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR21MB1513F1E0E0DDD017A4ED3B73CE3B9@DM6PR21MB1513.namprd21.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 06:38:45AM +0000, Long Li wrote:
> > Subject: Re: [PATCH] block: return the correct bvec when checking for gaps
> > 
> > Hello Long,
> > 
> > On Thu, Jun 03, 2021 at 03:34:31PM -0700, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > After commit 07173c3ec276 ("block: enable multipage bvecs"), a bvec
> > > can have multiple pages. But bio_will_gap() still assumes one page
> > > bvec while checking for merging. This causes data corruption on
> > > drivers relying on the correct merging on virt_boundary_mask.
> > 
> > Can you explain the data corruption a bit?
> > 
> > IMO, either single page bvec or multipage bvec should be fine, because
> > bio_will_gap() just checks if the last bvec of prev bio and the 1st bvec of next
> > bio can be merged.
> 
> Hi Ming,
> 
> When bio_will_gap() calls into biovec_phys_mergeable (), seg_boundary_mask (queue_segment_boundary()) is used to test if the two bio_vecs can be merged. This test can succeed if only the 1st page in bvec is used, but at the same time it can fail if all the pages in bvec are used. In other words, if the pages in bvec go across the seg_boundary_mask, the test can potentially succeed if only the 1st page is tested, but can fail if all the pages are tested.
> 
> Later, when SCSI builds the SG list from BIOs (that calls into __blk_bios_map_sg), __blk_segment_map_sg_merge() calls biovec_phys_mergeable() doing the same test . This time it may fail if the pages in bvec go across the seg_boundary_mask (but tested okay in bio_will_gap() earlier, so those two BIOs were merged). If __blk_segment_map_sg_merge() fails, we end up with a broken SG list for drivers assuming the SG list not having offsets in intermediate pages.
> 

OK, the reason is that both bio_will_gap() and __blk_segment_map_sg_merge()
have to use same approach to check if two bvecs from two bios can be
mergeable.

Now __blk_segment_map_sg_merge() won't merge the 1st bvec of next bio into
previous bio if the 1st bvec of next bio crosses segment boundary, so bio_will_gap()
has to take same way to check if the two bvecs can be merged.

Please add the segment boundary and map SG list story in commit log,
then the patch looks fine.


Thanks,
Ming

