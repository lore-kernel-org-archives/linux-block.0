Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6998AC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 04:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbiA1EIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 23:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236975AbiA1EIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 23:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643342884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6xI2q4JRMwbUUKNVQY8ddDYbQMyZc0rJHfSmrjO/C2I=;
        b=cr4/WZtGEnlke7XEpsJ0TcsWrtjSeExEGyvPchWIPPyCKPdW6kgGY1gD2GV4AkfMXM4g3m
        kPHw/UUa/hXEs/ND0yFORwUoa+QQwq3UQ5YP882BYTByFF2RNvSaZP/cz3urhNdZq+kUSq
        +iRPI3hYREsuUkBH+x1kpfGBTAG3Srs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-1JJL2rwBNTmFeeUFBTpPCA-1; Thu, 27 Jan 2022 23:08:02 -0500
X-MC-Unique: 1JJL2rwBNTmFeeUFBTpPCA-1
Received: by mail-qk1-f197.google.com with SMTP id p20-20020a05620a22b400b0047ecab0db4fso4001488qkh.2
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 20:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xI2q4JRMwbUUKNVQY8ddDYbQMyZc0rJHfSmrjO/C2I=;
        b=woMbOpJCP4dgA1DtwhgWmbLK9a2JFuJsxiZdIXUd54tuSOTYirBsbziTkY2Jkw5N8+
         s5GK5AzTG8ghVdBLpWO+qKli2c1eIRUWNm9Xyabkn7rd/swyWqH/l1RxBOtDR/6c0Cqs
         4INNeESNusToQIwE/Ajrv8k+rB76+BK9KaWzI3FXaVH7NZbuHN4q2kI+VJdItW9WEVG4
         rlj4aZMTBSJDLf1kKp6TT66GprGfxlhkVaaJKW5YmNiqR7of5GD2JBYkjGfPpZZgtYnV
         85fd1B92uQKSfI6+j3TlfCrTCvkJU1dTwve5Y5Cpgfc1Gh4nu1Rf9SCaIeXmzkCFRA6+
         /WVg==
X-Gm-Message-State: AOAM530ZOX7rTpI25BHtEeaSDF1or9zEI/nVEM3W3n8WUcc8FzcaaCV7
        aplle4t4iduksiiGoitcd1I/J4oUHJs7N+jVhw3/+vGJxS8r+6uG4RkISw05zc7dvvPZ9cWNWF4
        UhSEgW1xvSrgjDLKoTM41sQ==
X-Received: by 2002:a37:a50d:: with SMTP id o13mr4690897qke.43.1643342882444;
        Thu, 27 Jan 2022 20:08:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykB8s96fGvjnatQ4aYNG5YSnGZIPhh0tuM1T9LxfK+uT5UmElHRNJ9xxbe0ii1C52PKL03Bg==
X-Received: by 2002:a37:a50d:: with SMTP id o13mr4690893qke.43.1643342882227;
        Thu, 27 Jan 2022 20:08:02 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t13sm2307026qti.47.2022.01.27.20.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 20:08:01 -0800 (PST)
Date:   Thu, 27 Jan 2022 23:08:00 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dm: properly fix redundant bio-based IO accounting
Message-ID: <YfNsIP/iUX/xywO2@redhat.com>
References: <20220127225648.28729-1-snitzer@redhat.com>
 <20220127225648.28729-4-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127225648.28729-4-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27 2022 at  5:56P -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> Record the start_time for a bio but defer the starting block core's IO
> accounting until after IO is submitted using bio_start_io_acct_time().
> 
> This approach avoids the need to mess around with any of the
> individual IO stats in response to a bio_split() that follows bio
> submission.
> 
> Reported-by: Bud Brown <bubrown@redhat.com>
> Cc: stable@vger.kernel.org
> Depends-on: f9893e1da2e3 ("block: add bio_start_io_acct_time() to control start_time")
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 9849114b3c08..144436301a57 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -489,7 +489,7 @@ static void start_io_acct(struct dm_io *io)
>  	struct mapped_device *md = io->md;
>  	struct bio *bio = io->orig_bio;
>  
> -	io->start_time = bio_start_io_acct(bio);
> +	__bio_start_io_acct(bio, io->start_time);
>  	if (unlikely(dm_stats_used(&md->stats)))
>  		dm_stats_account_io(&md->stats, bio_data_dir(bio),
>  				    bio->bi_iter.bi_sector, bio_sectors(bio),

This should be calling bio_start_io_acct_time().
I updated the header but somehow dropped the code change before
sending.

Mike

> @@ -535,7 +535,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
>  	io->md = md;
>  	spin_lock_init(&io->endio_lock);
>  
> -	start_io_acct(io);
> +	io->start_time = READ_ONCE(jiffies);
>  
>  	return io;
>  }
> @@ -1482,6 +1482,7 @@ static void __split_and_process_bio(struct mapped_device *md,
>  			submit_bio_noacct(bio);
>  		}
>  	}
> +	start_io_acct(ci.io);
>  
>  	/* drop the extra reference count */
>  	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
> -- 
> 2.15.0
> 

