Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2483C33C8C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 18:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F41214D8
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 18:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH1/vrQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGSLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:11:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33596 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgAGSLs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 13:11:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so14566plb.0;
        Tue, 07 Jan 2020 10:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6O3O34rgc7CINfgc+RVC/ki3vvyaSU5XOtmKFi/Of8=;
        b=JH1/vrQsxf1Y4O4p96nFoibOtHJcIgbyThlqEUPP8TUPwnO3WAisWgDBpJFwrCWVZO
         xwphb4/fWKMZyMF4grKsk2Aak1eecpanHNEDLGZrSPt2bTVkjfRNyePoheFOXjq8kI5x
         MuTAvXaoMMSlzo8PRsE+l5AAYf+ulk6I/25+HYnunZe2b7WOtgDg/QxJEpdbUZIW/rt5
         4d9JxDZJHXJzhpAnrgG3KmwfdSowZ1q/C+TZNkqOroysEKU2SD+JvWxXSwKTzGpTIMJO
         kavDigEYg1W/Nvhw9xLqBX1uMWAJBSMMOIw/EyiN/+trmfdI9i9p4abshqa7XacmdDiz
         fl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6O3O34rgc7CINfgc+RVC/ki3vvyaSU5XOtmKFi/Of8=;
        b=sVjr2YfM3nyx7lHvnyA6NJcEl69FeznzuYQ3dwXndYinNbnxzvxaY5AU8j2d119M/O
         njXXiCmOT5y5yXM3ez254dhsH8jvIz45M2B+bRyOGIkLSqUKfHbCFtkbseq6XiwLrx3X
         gszKIUKTvtprn3IJIP/DcHVZcT+Cm/T0Z8TnigfHTu4SAckFs0F/mngCH/50XSYshyyW
         omWfT/aN5vCM59Vv/Nr+Rt3M5y0Fjod/eDOFMwyzUBcROGLdPqUC4LJV8VERYzEkWEw3
         gOyqbz6geTLTgIHGJTVa0+0L6oioC9uBa9NCIZbo7Jqhw6pO94K1Bvp4lA4NKbtonWbF
         mW+A==
X-Gm-Message-State: APjAAAVINwAzoJJDo9pmFzA/NYJnGWzwYu0kqkEMQYew+Vfmk3UqmKIE
        OWIcFvJCwwBdit3QIacrXVo5o7A1
X-Google-Smtp-Source: APXvYqzj5RQ0GphBq3Y/5Dr8oxw4ybskjNB5OFqaooqh0TeLANOMxm58K2DlTju0rd7zEyJ+XFg5Yw==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21mr925983pls.49.1578420707897;
        Tue, 07 Jan 2020 10:11:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s21sm225147pfe.20.2020.01.07.10.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 10:11:46 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:11:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200107181145.GA22076@roeck-us.net>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200107124708.GA20285@roeck-us.net>
 <20200107152339.GA23622@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107152339.GA23622@ming.t460p>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 11:23:39PM +0800, Ming Lei wrote:
> On Tue, Jan 07, 2020 at 04:47:08AM -0800, Guenter Roeck wrote:
> > Hi,
> > 
> > On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
> > > There are two issues in get_max_segment_size():
> > > 
> > > 1) the default segment boudary mask is bypassed, and some devices still
> > > require segment to not cross the default 4G boundary
> > > 
> > > 2) the segment start address isn't taken into account when checking
> > > segment boundary limit
> > > 
> > > Fixes the two issues.
> > > 
> > > Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > This patch, pushed into mainline as "block: fix splitting segments on
> > boundary masks", results in the following crash when booting 'versatilepb'
> > in qemu from disk. Bisect log is attached. Detailed log is at
> > https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio
> > 
> > Guenter
> > 
> > ---
> > Crash:
> > 
> > kernel BUG at block/bio.c:1885!
> > Internal error: Oops - BUG: 0 [#1] ARM
> 
> Please apply the following debug patch, and post the log.
> 

Here you are:

max_sectors 2560 max_segs 96 max_seg_size 65536 mask ffffffff
c738da80: 8c80/0 2416 28672, 0
         total sectors 56

(I replaced %p with %px).

Guenter

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 347782a24a35..c4aa683a1c20 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -217,6 +217,33 @@ static bool bvec_split_segs(const struct request_queue *q,
>  	return len > 0 || bv->bv_len > max_len;
>  }
>  
> +static void blk_dump_bio(struct request_queue *q, struct bio *bio,
> +		unsigned secs)
> +{
> +	struct bvec_iter iter;
> +	struct bio_vec bvec;
> +	int i = 0;
> +	unsigned sectors = 0;
> +
> +	printk("max_sectors %u max_segs %u max_seg_size %u mask %lx\n",
> +			get_max_io_size(q, bio), queue_max_segments(q),
> +			queue_max_segment_size(q), queue_segment_boundary(q));
> +	printk("%p: %hx/%hx %llu %u, %u\n",
> +                       bio,
> +                       bio->bi_flags, bio->bi_opf,
> +                       (unsigned long long)bio->bi_iter.bi_sector,
> +                       bio->bi_iter.bi_size, secs);
> +	bio_for_each_bvec(bvec, bio, iter) {
> +		sectors += bvec.bv_len >> 9;
> +		trace_printk("\t %d: %lu %u %u(%u)\n", i++,
> +				(unsigned long)page_to_pfn(bvec.bv_page),
> +				bvec.bv_offset,
> +				bvec.bv_len, bvec.bv_len >> 12);
> +	}
> +	printk("\t total sectors %u\n", sectors);
> +}
> +
> +
>  /**
>   * blk_bio_segment_split - split a bio in two bios
>   * @q:    [in] request queue pointer
> @@ -273,6 +300,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	return NULL;
>  split:
>  	*segs = nsegs;
> +
> +	if (sectors <= 0 || sectors >= bio_sectors(bio))
> +		blk_dump_bio(q, bio, sectors);
>  	return bio_split(bio, sectors, GFP_NOIO, bs);
>  }
>  
> 
> Thanks,
> Ming
> 
