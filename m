Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A515FC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5F020851
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfAQK1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:27:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfAQK1l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 05:27:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B429CCB86;
        Thu, 17 Jan 2019 10:27:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF8F25C7B7;
        Thu, 17 Jan 2019 10:27:02 +0000 (UTC)
Date:   Thu, 17 Jan 2019 18:26:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [BUG bisect] kernel BUG at block/bio.c:1833 and fail to mount
 disk
Message-ID: <20190117102657.GB20220@ming.t460p>
References: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
 <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 17 Jan 2019 10:27:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 09:54:05AM +0100, Krzysztof Kozlowski wrote:
> On Wed, 16 Jan 2019 at 09:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Hi,
> >
> > On today's next-20190116 I see a bug during boot:
> > [ 6.843308] kernel BUG at ../block/bio.c:1833!
> > [ 6.847723] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > ...
> > [ 7.543824] [<c044c144>] (bio_split) from [<00000000>] ( (null))
> > [ 7.549881] Code: 13833b01 11c630bc e1a00006 e8bd8070 (e7f001f2)
> >
> > (not much in the calltrace)
> > On all my boards. Also QEMU-arm fails.
> >
> 
> I forgot the bisect commit:
> 
> 258cfdfaf7bd729e759a0a91fd00ac9794796ad3 is the first bad commit
> commit 258cfdfaf7bd729e759a0a91fd00ac9794796ad3
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Jan 11 19:01:15 2019 +0800
> 
>     block: use bio_for_each_bvec() to compute multi-page bvec count
> 
> :040000 040000 d79b2e71d308650df4764ff644f29d3a24dbab96
> 0a5d624843b805ee0c9fd9a7e2d5163f5b15b167 M block

It should be one 32-bit arch specific issue, I guess.

The following patch should fix this issue:

diff --git a/block/blk-merge.c b/block/blk-merge.c
index dc4877eaf9f9..4dd7183de849 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -166,6 +166,9 @@ static unsigned get_max_segment_size(struct request_queue *q,
 {
 	unsigned long mask = queue_segment_boundary(q);
 
+	if (mask == BLK_SEG_BOUNDARY_MASK)
+		return queue_max_segment_size(q);
+
 	return min_t(unsigned long, mask - (mask & offset) + 1,
 		     queue_max_segment_size(q));
 }

Thanks,
Ming
