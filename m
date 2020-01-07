Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F7C282DD
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3657820715
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/+8IKC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgAGXGf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:06:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAGXGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 18:06:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so573904pgb.9;
        Tue, 07 Jan 2020 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hn2E8TmwJXOaHmoVzcv3GA0FCQtIxiHPvPOQL+N/lCU=;
        b=p/+8IKC9TQursDveFr01JEpQ5bcHvMZC1uRj+JHRYHTReXw1CgY/77BhuOl5n9glJ0
         3ZHm3fdP/Dj9r+q43pCD+PxOVN11yRXwc9mTgcWI/yiPlgbiqcUOeH01Q2MWOJ1Xb75Q
         Rzb/1xI7I4IzVD4l/Wu86DQcK99NLvuTH/JTnDk5FLSveA2j01BQwNluDxUhV6XzChrf
         rDASSkkE1hHV/OGPSlR5RuHTUoQDjNYXZ24klfluQfkus1An7uy4UfbxljWYfm/ZIYBJ
         KpYfymAq+fvYouWkB+37JnekbzODcbo5NPJndmXDAH3sbV2bnPxmnfc9JRnpsq6fh+On
         r0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hn2E8TmwJXOaHmoVzcv3GA0FCQtIxiHPvPOQL+N/lCU=;
        b=V21vq5lM3vtqYMbFFqkri7W7N8gmlupc/iLkAsOXhOHO3svX0HOfJOIV0eaLGX3jDu
         jDAaU+CWF/TfzwPeFgO7aUtMuwYSm2hlKXcENGHcuXe+wT8nSYPKEf3Lm08lQsfQjIZy
         n0RRlszXTOsRicdlh5Ldv12MChxwW2whjwcpgPXqOyySyZ60bLWmI8ktjBcq026pHFPr
         w3kYjfpgfbZGdvtMiNd5rxW1lVy/4XvjPXxBdG0KBeYtE6LLGA3c0WATIhvc808EYuv4
         ysKAmPHOovZPGnYMpdAWr3P3nKNtfMFRjLUmCZ9BjDWHWuAxijhG6YRfsv+5sQar9GPL
         EXUg==
X-Gm-Message-State: APjAAAVOk9KYlMJVnkmQD/lPMHiWSSmPe2X66XqeZb5NTv07nLrQhc8c
        rrdtGbrazihGdVqMUcdllfw=
X-Google-Smtp-Source: APXvYqwQqKa9HG/4s4SU7tc2itIOKHHboTkZCG0qR76TQBRpNOLwB22DwvbBtUOwPSIGXgrYf+k7gA==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr1785033pfq.138.1578438394934;
        Tue, 07 Jan 2020 15:06:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19sm30654167pjr.2.2020.01.07.15.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 15:06:33 -0800 (PST)
Date:   Tue, 7 Jan 2020 15:06:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200107230632.GA24960@roeck-us.net>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200107124708.GA20285@roeck-us.net>
 <20200107152339.GA23622@ming.t460p>
 <20200107181145.GA22076@roeck-us.net>
 <20200107223035.GA7505@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107223035.GA7505@ming.t460p>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 08, 2020 at 06:30:35AM +0800, Ming Lei wrote:
> On Tue, Jan 07, 2020 at 10:11:45AM -0800, Guenter Roeck wrote:
> > On Tue, Jan 07, 2020 at 11:23:39PM +0800, Ming Lei wrote:
> > > On Tue, Jan 07, 2020 at 04:47:08AM -0800, Guenter Roeck wrote:
> > > > Hi,
> > > > 
> > > > On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
> > > > > There are two issues in get_max_segment_size():
> > > > > 
> > > > > 1) the default segment boudary mask is bypassed, and some devices still
> > > > > require segment to not cross the default 4G boundary
> > > > > 
> > > > > 2) the segment start address isn't taken into account when checking
> > > > > segment boundary limit
> > > > > 
> > > > > Fixes the two issues.
> > > > > 
> > > > > Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > 
> > > > This patch, pushed into mainline as "block: fix splitting segments on
> > > > boundary masks", results in the following crash when booting 'versatilepb'
> > > > in qemu from disk. Bisect log is attached. Detailed log is at
> > > > https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio
> > > > 
> > > > Guenter
> > > > 
> > > > ---
> > > > Crash:
> > > > 
> > > > kernel BUG at block/bio.c:1885!
> > > > Internal error: Oops - BUG: 0 [#1] ARM
> > > 
> > > Please apply the following debug patch, and post the log.
> > > 
> > 
> > Here you are:
> > 
> > max_sectors 2560 max_segs 96 max_seg_size 65536 mask ffffffff
> > c738da80: 8c80/0 2416 28672, 0
> >          total sectors 56
> > 
> > (I replaced %p with %px).
> > 
> 
> Please try the following patch and see if it makes a difference.
> If not, replace trace_printk with printk in previous debug patch,
> and apply the debug patch only & post the log.
> 

The patch below fixes the problem for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 347782a24a35..f152bdee9b05 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct request_queue *q,
>  
>  static inline unsigned get_max_segment_size(const struct request_queue *q,
>  					    struct page *start_page,
> -					    unsigned long offset)
> +					    unsigned long long offset)
>  {
>  	unsigned long mask = queue_segment_boundary(q);
>  
>  	offset = mask & (page_to_phys(start_page) + offset);
> -	return min_t(unsigned long, mask - offset + 1,
> +	return min_t(unsigned long long, mask - offset + 1,
>  		     queue_max_segment_size(q));
>  }
>  
> 
> Thanks,
> Ming
> 
