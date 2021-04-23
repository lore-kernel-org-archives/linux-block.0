Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC3C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 18:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206EB61425
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 18:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhDWS5V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 14:57:21 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:42711 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhDWS5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 14:57:21 -0400
Received: by mail-pg1-f176.google.com with SMTP id m12so15085038pgr.9;
        Fri, 23 Apr 2021 11:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SxbJFJCWJpOSbE1c6ddaCLcT2Rwq4ZCw7tfdFd6dWuA=;
        b=UeTvL33pzUa4XptHVx/SsyVFEIwB3GipJWcJ/DMfT/NuvYW4+HKvac0dnfxsXy2/Bz
         2s0UgI2X7+SOxs8zB0T7TjkeV/2af61vHVwqKEhvdQiauuD1KY+WCO2TQGTbCPnrjm7Q
         ExxLqyL2950mxDnYjtR7+hzfVWzseVOdwNNoDr1SFthLvOAs4aNhR3y3abYLqaw1ojn4
         rSJuB8ckeQIf7UaeezDKt9uj18d9QfJPiI1/zms6naePitxjOCIW3y9+2YBqg7swPxiX
         i5qPGX9yuaMEJTwlf2mVqSjSykNdH0csfWJLRGF9+TrqJtJp6S0+8IzW28XFWk/Ig/sh
         Nn6w==
X-Gm-Message-State: AOAM533LODYIgBV81LfOcSj0cMf1VqnRKh9tvXwbV322oMPwgg60voKQ
        ktFafqNl5+V30NlFzy3jUxawgH9msck=
X-Google-Smtp-Source: ABdhPJy1HOFzgbrS8XvHjIaWspo3NKboIANyPYHk/6ol8AyoWpBnGxGoOYrCFK8TQZ2IuYH/5Bheaw==
X-Received: by 2002:a63:aa06:: with SMTP id e6mr5107038pgf.178.1619204204042;
        Fri, 23 Apr 2021 11:56:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a976:f332:ee26:584f? ([2601:647:4000:d7:a976:f332:ee26:584f])
        by smtp.gmail.com with ESMTPSA id cv12sm5315519pjb.35.2021.04.23.11.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 11:56:43 -0700 (PDT)
Subject: Re: [PATCH] block: fix userspace documentation reference for
 del_gendisk()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117140658.12199-1-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <87d487f9-c81e-43e4-d03b-0e8789a9401e@acm.org>
Date:   Fri, 23 Apr 2021 11:56:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20201117140658.12199-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/17/20 6:06 AM, Luis Chamberlain wrote:
> Commit b5bd357cf8b ("block: add docs for gendisk / request_queue refcount
> helpers") has a typo where it references drivers for del_gendisk() when we
> instead meant userspace, as the reference is to the userspace experience.
> This fixes this.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/genhd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 0a273211fec2..9511620f558a 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -880,8 +880,8 @@ static void invalidate_partition(struct gendisk *disk, int partno)
>   * with put_disk(), which should be called after del_gendisk(), if
>   * __device_add_disk() was used.
>   *
> - * Drivers exist which depend on the release of the gendisk to be synchronous,
> - * it should not be deferred.
> + * Userspace may exist which depends on the release of the gendisk to be
> + * synchronous, it should not be deferred.

Please change "may exist which depends" into "software may depend" to
make the comment easier to understand.

Thanks,

Bart.
