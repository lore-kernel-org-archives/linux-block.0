Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43662 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbcEJSrV (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 14:47:21 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Michael Callahan <michaelcallahan@fb.com>
Cc: <linux-block@vger.kernel.org>, <coder.callahan@gmail.com>,
	<axboe@fb.com>
Subject: Re: [PATCH 3/4] block: Add and use a rw_stat_group function for indexing partition stat fields.
References: <tc2eg9en97m.fsf@vmbox.dyndns.org>
Date: Tue, 10 May 2016 14:47:18 -0400
In-Reply-To: <tc2eg9en97m.fsf@vmbox.dyndns.org> (Michael Callahan's message of
	"Fri, 6 May 2016 17:54:37 -0400")
Message-ID: <x49lh3h698p.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Michael Callahan <michaelcallahan@fb.com> writes:

Sorry for the segmented review.

> diff --git a/block/bio.c b/block/bio.c
> index 807d25e..91b082d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1678,27 +1678,29 @@ void bio_check_pages_dirty(struct bio *bio)
>  	}
>  }
>  
> -void generic_start_io_acct(int rw, unsigned long sectors,
> +void generic_start_io_acct(int sgrp, unsigned long sectors,
>  			   struct hd_struct *part)
>  {
> +	const int rw = stat_group_to_rw(sgrp);
>  	int cpu = part_stat_lock();
>  
>  	part_round_stats(cpu, part);
> -	part_stat_inc(cpu, part, ios[rw]);
> -	part_stat_add(cpu, part, sectors[rw], sectors);
> +	part_stat_inc(cpu, part, ios[sgrp]);
> +	part_stat_add(cpu, part, sectors[sgrp], sectors);
>  	part_inc_in_flight(part, rw);
>  
>  	part_stat_unlock();
>  }
>  EXPORT_SYMBOL(generic_start_io_acct);
>  
> -void generic_end_io_acct(int rw, struct hd_struct *part,
> +void generic_end_io_acct(int sgrp, struct hd_struct *part,
>  			 unsigned long start_time)
>  {
>  	unsigned long duration = jiffies - start_time;
> +	const int rw = stat_group_to_rw(sgrp);

You modified these functions to take a stat group, then changed all
callers to turn an rw_flag into a stat group, and then turn right around
and convert that back into rw as the first order of business.  Why can't
you do the conversion in generic_start/end_io_acct from rw to stat
group?

Cheers,
Jeff
