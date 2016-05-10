Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbcEJR64 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 13:58:56 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Michael Callahan <michaelcallahan@fb.com>
Cc: <linux-block@vger.kernel.org>, <coder.callahan@gmail.com>,
	<axboe@fb.com>
Subject: Re: [PATCH 3/4] block: Add and use a rw_stat_group function for indexing partition stat fields.
References: <tc2eg9en97m.fsf@vmbox.dyndns.org>
Date: Tue, 10 May 2016 13:58:54 -0400
In-Reply-To: <tc2eg9en97m.fsf@vmbox.dyndns.org> (Michael Callahan's message of
	"Fri, 6 May 2016 17:54:37 -0400")
Message-ID: <x49r3d96bhd.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Michael Callahan <michaelcallahan@fb.com> writes:

> @@ -856,6 +856,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
>  	}
>  
>  	rw = bio_data_dir(bio);
> +	sgrp = rw_stat_group(bio->bi_rw)
>  	bio_for_each_segment(bvec, bio, iter) {
>  		int max_transfer_size = PAGE_SIZE - offset;
>  

Missing semicolon.

> @@ -434,6 +434,14 @@ static inline void free_part_info(struct hd_struct *part)
>  	kfree(part->info);
>  }
>  
> +static inline int rw_stat_group(unsigned int rw_flags)
> +{
> +	return rw_flags & 1;
> +}

This depends on STAT_READ and STAT_WRITE corresponding to READ and
WRITE, but that's not enforced anywhere.  It's a minor nit, but it sure
bugs the heck out of me.

Cheers,
Jeff
