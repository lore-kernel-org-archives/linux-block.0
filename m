Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdFSPQ6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 11:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DC8EC0B39F9
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 15:16:57 +0000 (UTC)
Subject: Re: [dm-devel] dm integrity tests crash kernel (4.12-rc5)
To: Mike Snitzer <snitzer@redhat.com>
References: <2b97933e-3f94-8510-cefd-13fae445400e@redhat.com>
 <d32598d1-2ae3-6b0a-690f-7d7dfa43899e@redhat.com>
 <20170619142026.GA92582@redhat.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
        mpatocka@redhat.com, mbroz@redhat.com
From: Ondrej Kozina <okozina@redhat.com>
Message-ID: <ad400234-fde1-5ff7-246e-91ded98764e2@redhat.com>
Date: Mon, 19 Jun 2017 17:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170619142026.GA92582@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/19/2017 04:20 PM, Mike Snitzer wrote:
>
> Looks like submit_flush_bio() is disabling/enabling interrupts from
> interrupt context.  Ondrej, does this patch fix the issue?

I let it spin for 30 minutes on patched dm-integrity and everything 
seems ok now. The moment I loaded back the old one it fell on face 
almost immediately again.

Thanks!

>
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 4ab10cf..93b1810 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -1105,10 +1105,13 @@ static void schedule_autocommit(struct dm_integrity_c *ic)
>  static void submit_flush_bio(struct dm_integrity_c *ic, struct dm_integrity_io *dio)
>  {
>  	struct bio *bio;
> -	spin_lock_irq(&ic->endio_wait.lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ic->endio_wait.lock, flags);
>  	bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
>  	bio_list_add(&ic->flush_bio_list, bio);
> -	spin_unlock_irq(&ic->endio_wait.lock);
> +	spin_unlock_irqrestore(&ic->endio_wait.lock, flags);
> +
>  	queue_work(ic->commit_wq, &ic->commit_work);
>  }
>
>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
>
