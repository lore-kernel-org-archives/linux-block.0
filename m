Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64566C33C8C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B27D222D9
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz4Fvb9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgAGPXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:23:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728334AbgAGPXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 10:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578410633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uNiCTiEHFgNN9K+lpJkW469fllh6SCfCoNUo1eAVpg=;
        b=Qz4Fvb9BcjnqsbMcKCXvLw55s95WZJ7EGVFOmt2FnXz8Nvfghi4hy3C/B9PzTVQRFPRCH/
        TcRdBYpewr/Qx9StuQUI5NMuFscZz94LifeRbH629L93saThC0fsXIJrN4j2K7ePfCMdra
        +zYPbyKNLi4MQax2I9To+uxZdK//vU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-YZmiAk9SPXu1Dk_Vw51d_w-1; Tue, 07 Jan 2020 10:23:50 -0500
X-MC-Unique: YZmiAk9SPXu1Dk_Vw51d_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF6BA1005514;
        Tue,  7 Jan 2020 15:23:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9026E10018FF;
        Tue,  7 Jan 2020 15:23:43 +0000 (UTC)
Date:   Tue, 7 Jan 2020 23:23:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200107152339.GA23622@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200107124708.GA20285@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107124708.GA20285@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 04:47:08AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
> > There are two issues in get_max_segment_size():
> > 
> > 1) the default segment boudary mask is bypassed, and some devices still
> > require segment to not cross the default 4G boundary
> > 
> > 2) the segment start address isn't taken into account when checking
> > segment boundary limit
> > 
> > Fixes the two issues.
> > 
> > Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> This patch, pushed into mainline as "block: fix splitting segments on
> boundary masks", results in the following crash when booting 'versatilepb'
> in qemu from disk. Bisect log is attached. Detailed log is at
> https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio
> 
> Guenter
> 
> ---
> Crash:
> 
> kernel BUG at block/bio.c:1885!
> Internal error: Oops - BUG: 0 [#1] ARM

Please apply the following debug patch, and post the log.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 347782a24a35..c4aa683a1c20 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -217,6 +217,33 @@ static bool bvec_split_segs(const struct request_queue *q,
 	return len > 0 || bv->bv_len > max_len;
 }
 
+static void blk_dump_bio(struct request_queue *q, struct bio *bio,
+		unsigned secs)
+{
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	int i = 0;
+	unsigned sectors = 0;
+
+	printk("max_sectors %u max_segs %u max_seg_size %u mask %lx\n",
+			get_max_io_size(q, bio), queue_max_segments(q),
+			queue_max_segment_size(q), queue_segment_boundary(q));
+	printk("%p: %hx/%hx %llu %u, %u\n",
+                       bio,
+                       bio->bi_flags, bio->bi_opf,
+                       (unsigned long long)bio->bi_iter.bi_sector,
+                       bio->bi_iter.bi_size, secs);
+	bio_for_each_bvec(bvec, bio, iter) {
+		sectors += bvec.bv_len >> 9;
+		trace_printk("\t %d: %lu %u %u(%u)\n", i++,
+				(unsigned long)page_to_pfn(bvec.bv_page),
+				bvec.bv_offset,
+				bvec.bv_len, bvec.bv_len >> 12);
+	}
+	printk("\t total sectors %u\n", sectors);
+}
+
+
 /**
  * blk_bio_segment_split - split a bio in two bios
  * @q:    [in] request queue pointer
@@ -273,6 +300,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return NULL;
 split:
 	*segs = nsegs;
+
+	if (sectors <= 0 || sectors >= bio_sectors(bio))
+		blk_dump_bio(q, bio, sectors);
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 

Thanks,
Ming

