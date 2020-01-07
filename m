Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9607CC33C9B
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C2820715
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 22:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue5Czogp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgAGWax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:30:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgAGWax (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 17:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578436251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FN/82vVAxc6XEGEfrEz5NnjIGWwecvczTJRijpb0J5I=;
        b=Ue5CzogpB5PNr7hx9NpHn5Eg2dRB02WL7pZO0XqQv5fviL52SExJ8wH1QsH4AQgf7D1Dv/
        pKW6iWD+1myI7IeewlhE2o45THxv7uYqc7JrjM0yQWZWoz1w2LGFfBhJgJgYZRgiXzp4Zj
        w19dRzZ9Se8EAh/sgmIuZe5oCrwcjaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-pXs9sK5SP0a-kkriMQE20A-1; Tue, 07 Jan 2020 17:30:48 -0500
X-MC-Unique: pXs9sK5SP0a-kkriMQE20A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE501800D4E;
        Tue,  7 Jan 2020 22:30:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F1A7FB65;
        Tue,  7 Jan 2020 22:30:40 +0000 (UTC)
Date:   Wed, 8 Jan 2020 06:30:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200107223035.GA7505@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200107124708.GA20285@roeck-us.net>
 <20200107152339.GA23622@ming.t460p>
 <20200107181145.GA22076@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107181145.GA22076@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 10:11:45AM -0800, Guenter Roeck wrote:
> On Tue, Jan 07, 2020 at 11:23:39PM +0800, Ming Lei wrote:
> > On Tue, Jan 07, 2020 at 04:47:08AM -0800, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
> > > > There are two issues in get_max_segment_size():
> > > > 
> > > > 1) the default segment boudary mask is bypassed, and some devices still
> > > > require segment to not cross the default 4G boundary
> > > > 
> > > > 2) the segment start address isn't taken into account when checking
> > > > segment boundary limit
> > > > 
> > > > Fixes the two issues.
> > > > 
> > > > Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > 
> > > This patch, pushed into mainline as "block: fix splitting segments on
> > > boundary masks", results in the following crash when booting 'versatilepb'
> > > in qemu from disk. Bisect log is attached. Detailed log is at
> > > https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio
> > > 
> > > Guenter
> > > 
> > > ---
> > > Crash:
> > > 
> > > kernel BUG at block/bio.c:1885!
> > > Internal error: Oops - BUG: 0 [#1] ARM
> > 
> > Please apply the following debug patch, and post the log.
> > 
> 
> Here you are:
> 
> max_sectors 2560 max_segs 96 max_seg_size 65536 mask ffffffff
> c738da80: 8c80/0 2416 28672, 0
>          total sectors 56
> 
> (I replaced %p with %px).
> 

Please try the following patch and see if it makes a difference.
If not, replace trace_printk with printk in previous debug patch,
and apply the debug patch only & post the log.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 347782a24a35..f152bdee9b05 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 
 static inline unsigned get_max_segment_size(const struct request_queue *q,
 					    struct page *start_page,
-					    unsigned long offset)
+					    unsigned long long offset)
 {
 	unsigned long mask = queue_segment_boundary(q);
 
 	offset = mask & (page_to_phys(start_page) + offset);
-	return min_t(unsigned long, mask - offset + 1,
+	return min_t(unsigned long long, mask - offset + 1,
 		     queue_max_segment_size(q));
 }
 

Thanks,
Ming

