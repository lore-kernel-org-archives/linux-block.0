Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E804FC433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C468F611EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 16:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhKAQ7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhKAQ7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 12:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635785791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mfuVTEKtPZu4oGKU5CQj62mdS9UTfznANVeOzt6yo5M=;
        b=XwQhINaMF8PJN8POI9CYIsIOKv0cQcdjPmMVnVNU9ZTfX4r2Y6axXWJWbDI4MbLVzlgAHv
        +nd7NGuPhGiiSBRj+jyrt0XJPXDFQpDQnWExW4m2P68zLtHoDol+qdV/9b9cgf9pBDnwbw
        rbImXNe9rqUBUqtn9DP96HEE6fe0NkA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-gEMXPMYpOvWtVdadICIHew-1; Mon, 01 Nov 2021 12:56:30 -0400
X-MC-Unique: gEMXPMYpOvWtVdadICIHew-1
Received: by mail-qt1-f200.google.com with SMTP id x28-20020ac8701c000000b0029f4b940566so12465936qtm.19
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 09:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfuVTEKtPZu4oGKU5CQj62mdS9UTfznANVeOzt6yo5M=;
        b=kXTovnp9Ff71U0T71OzQNyLKq1J2O8UY/xpqAjhUAchmn9rm6xTFDDb41AxI86A7V9
         1MAm+Q9PrQKYBOgZyQJ3RJlVbAM+v6RXqsrTmsd9B9ToATFbbQoqPDcKYuo87qbRUv3C
         44+x9l5kSA3vAIBtMAhKgcBKokw8xlyhoxu2O676KOHm0qJE93y/RAHYEJii76Dzt3PH
         LSwFFbC/cLSbBZ1H/ycTaOodd8iiqEsoyjBgDs4FDG4zbopV71utGpAxcAplQ4WscVU2
         dG3pDA5C2Gw7YVMCOw5meO+lCJAvuvzDx7Q0111J1QD/8Gh4h2WH/uwvSI+bS0ttfyU9
         +Ghg==
X-Gm-Message-State: AOAM530VNdoyFsyf/G+kXqtKksjhwNWGLFeHKrVRQkCMADTZeuNoDE0T
        K15QgEWdtadtrW4FPuqAF/StFBB0XDuQte86UZTVZPA8vAFttW15Ds1eyZT1vyNJbUoXxZiwBaq
        5LgBksbd9Bhm5g8LF6AE8Hg==
X-Received: by 2002:a0c:fa07:: with SMTP id q7mr29081304qvn.18.1635785789550;
        Mon, 01 Nov 2021 09:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh4wJKFaHJKXShFvRsJDDiN/gGiV8SeRubZYTL3eGqZM/PtHnVS+1hVdsIppxoO3JwPYaACw==
X-Received: by 2002:a0c:fa07:: with SMTP id q7mr29081280qvn.18.1635785789312;
        Mon, 01 Nov 2021 09:56:29 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i1sm114002qkn.67.2021.11.01.09.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:56:28 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:56:27 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 3/3] dm: don't stop request queue after the dm device is
 suspended
Message-ID: <YYAcO1GAEGK7f3XI@redhat.com>
References: <20211021145918.2691762-1-ming.lei@redhat.com>
 <20211021145918.2691762-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021145918.2691762-4-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 21 2021 at 10:59P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> For fixing queue quiesce race between driver and block layer(elevator
> switch, update nr_requests, ...), we need to support concurrent quiesce
> and unquiesce, which requires the two call to be balanced.
> 
> __bind() is only called from dm_swap_table() in which dm device has been
> suspended already, so not necessary to stop queue again. With this way,
> request queue quiesce and unquiesce can be balanced.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: e70feb8b3e68 ("blk-mq: support concurrent queue quiesce/unquiesce")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/md/dm.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 7870e6460633..727282d79b26 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1927,16 +1927,6 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>  
>  	dm_table_event_callback(t, event_callback, md);
>  
> -	/*
> -	 * The queue hasn't been stopped yet, if the old table type wasn't
> -	 * for request-based during suspension.  So stop it to prevent
> -	 * I/O mapping before resume.
> -	 * This must be done before setting the queue restrictions,
> -	 * because request-based dm may be run just after the setting.
> -	 */
> -	if (request_based)
> -		dm_stop_queue(q);
> -
>  	if (request_based) {
>  		/*
>  		 * Leverage the fact that request-based DM targets are
> -- 
> 2.31.1
> 

I think this is fine given your previous commit (b4459b11e8f dm rq:
don't queue request to blk-mq during DM suspend).

Acked-by: Mike Snitzer <snitzer@redhat.com>

Jens: given this series fixes a 5.16 regression in srp test, please
pick it up for 5.16-rc

Thanks,
Mike

