Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA49C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBC520878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 23:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JxW2AeBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBC520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLFXEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:04:46 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50544 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeLFXEq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 18:04:46 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so4185013iti.0
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZdK/IUOy/AhO2+3fcWMrKyyXskj17whavI7R3Y5s0Lg=;
        b=JxW2AeByRPtAvWwch73aQGXpG7R6NTK2Bjxjj0WlnQwEwoMaevj3DcmI54VkvEosOY
         uNZ2UG4Vn7L08fmPWA8iqDn8EXcPahsyB6zuy2nFlIgVIsNlIOGLmu7pFNqxHbvWLYtn
         dp+ojU/+eDEbDMgHAuasVFOPELe+t4pmTk2NhfGqeDIbqXALdixmisc7P5inU2yPN6Vd
         Tlofy+bAIMF8U+DoP+C0QwOnK9+t8Xsf6FAZLrYO+pFSc+a0Zn6dmSX6+lp9Fxa9aHGB
         DytM0kKVeuiC455bh4LW+8VkWmtiEywygJPBzrY3yK1GEEONGM2ykOBpgebEAFWCih2p
         zvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZdK/IUOy/AhO2+3fcWMrKyyXskj17whavI7R3Y5s0Lg=;
        b=c/l3YY/HHWZudMqnETDKQHqUZgtQe5DIrT+4H4/EhrkephBSRqs/nEicj/yItMNP5d
         CzWKJ4aKiLwQcI6/jtzohTNtrtQdDLGmLbk06foDObp7SSGRPEuyzfQObzrDZsFXJksW
         sZTZK9si5v3LciR8IQjB6na9jnvKv5ZheuvRiYpMyaetFxlUsqXrlfHtRCXHkCMqCkWO
         o2wKgfAuh8+9Fj1/lVicYGl7WDeET+E+BVXNOh+itzuOMB/kRNTgsC2uAPGMU4aSUZvW
         jkkoJhFfhX9x42t0CyT9VaZ1SBFbujVGWZpwT3mbSSCqLa+K6TcnBU6tMfAerBmfPZC/
         VGVQ==
X-Gm-Message-State: AA+aEWbZX27J5HPi2Y2XNhs9K/lSzzSLxcXYymRyx3WsmaaNzwEY1h3L
        GHA/LDCUF3zM1FyK5U0hHVBlbg==
X-Google-Smtp-Source: AFSGD/X64GVyF4lDQOEj/5c9EJ9ZQ8bZJ9Y93ptMBml4/UJfIiG0bHwhI7GwOgDqZCNFlE44mTt03w==
X-Received: by 2002:a05:660c:64f:: with SMTP id y15mr216336itk.29.1544137485298;
        Thu, 06 Dec 2018 15:04:45 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l25sm642406ioj.68.2018.12.06.15.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 15:04:43 -0800 (PST)
Subject: Re: [PATCH] dm crypt: fix lost ioprio when queuing crypto bios from
 task with ioprio
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Wheeler <dm-devel@lists.ewheeler.net>
References: <20181206221507.5423-1-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3cc2f4c2-956d-bae4-563f-33d122e258e8@kernel.dk>
Date:   Thu, 6 Dec 2018 16:04:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206221507.5423-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 > diff --git a/block/bio.c b/block/bio.c
> index 0c2208a5446d..ed68fdd78547 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -647,6 +647,30 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
>  }
>  EXPORT_SYMBOL(bio_clone_fast);
>  
> +/**
> + *	bio_set_task_prio - set bio's ioprio to task's ioprio, if any.
> + *	@bio: bio to set the ioprio of, can be NULL
> + *	@task: task of interest
> + *	@gfp_flags: allocation flags, used if allocation is necessary
> + *	@node: allocation node, used if allocation is necessary
> + */
> +void bio_set_task_prio(struct bio *bio, struct task_struct *task,
> +		       gfp_t gfp_flags, int node)
> +{
> +	struct io_context *ioc;
> +
> +	if (!bio)
> +		return;
> +
> +	ioc = get_task_io_context(current, gfp_flags, node);
> +	if (ioc) {
> +		if (ioprio_valid(ioc->ioprio))
> +			bio_set_prio(bio, ioc->ioprio);
> +		put_io_context(ioc);
> +	}
> +}
> +EXPORT_SYMBOL(bio_set_task_prio);
>

Shouldn't this just be a lookup, not a create io context? If the io
priority has been set, the ioc would exist anyway.

void bio_set_prio_from_current(struct bio *bio)
{
	struct io_context *ioc = current->io_context;

	if (ioc && ioprio_valid(ioc->ioprio))
		bio_set_prio(bio, ioc->ioprio);
}

and rename it like so. I don't like passing in the task, and all the
users are 'current' anyway. Passing in a task_struct implies that we
could have looked it up and would need a reference to it.

And don't make it pass in bio == NULL, that's just odd.

Apart from that, looks fine ;-)

-- 
Jens Axboe

