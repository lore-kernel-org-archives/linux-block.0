Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F62C4743E
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 00:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC32613B6
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 00:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFGALs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Jun 2021 20:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbhFGALr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Jun 2021 20:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623024597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VS0VjKAJZ5TDLigUxCxbJG/FM9ESIm9kTnLGe+d/ZcE=;
        b=RD9aKHLcJSGhKj9J4rabMZT7LQ779AQbR3iVro+Kg4chgSBx9RGK9m6uiGOuyFO7Fr45Ij
        Qo3eFvUfeKqaZ/NrgS8BOIQAId1Br0E1dKkHsp3baf9Rryp21I99C8gDnhRi0rD2f7KBuu
        G82O8lUJu+IgOj7riXqdd2hbsirNF2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-loLTsHyRMvymEOT77fI9Dw-1; Sun, 06 Jun 2021 20:09:54 -0400
X-MC-Unique: loLTsHyRMvymEOT77fI9Dw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 472D5800D55;
        Mon,  7 Jun 2021 00:09:52 +0000 (UTC)
Received: from T590 (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B7225D736;
        Mon,  7 Jun 2021 00:09:43 +0000 (UTC)
Date:   Mon, 7 Jun 2021 08:09:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     longli@linuxonhyperv.com
Cc:     linux-block@vger.kernel.org, Long Li <longli@microsoft.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Patch v2] block: return the correct bvec when checking for gaps
Message-ID: <YL1jwr2MfbW4hFb7@T590>
References: <1622849839-5407-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622849839-5407-1-git-send-email-longli@linuxonhyperv.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 04:37:19PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> After commit 07173c3ec276 ("block: enable multipage bvecs"), a bvec can
> have multiple pages. But bio_will_gap() still assumes one page bvec while
> checking for merging. If the pages in the bvec go across the
> seg_boundary_mask, this check for merging can potentially succeed if only
> the 1st page is tested, and can fail if all the pages are tested.
> 
> Later, when SCSI builds the SG list the same check for merging is done in
> __blk_segment_map_sg_merge() with all the pages in the bvec tested. This
> time the check may fail if the pages in bvec go across the
> seg_boundary_mask (but tested okay in bio_will_gap() earlier, so those
> BIOs were merged). If this check fails, we end up with a broken SG list
> for drivers assuming the SG list not having offsets in intermediate pages.
> This results in incorrect pages written to the disk.
> 
> Fix this by returning the multi-page bvec when testing gaps for merging.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: 07173c3ec276 ("block: enable multipage bvecs")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Change from v1: add commit details on how data corruption happens

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

