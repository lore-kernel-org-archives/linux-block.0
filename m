Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7F0C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020BD20868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu5HrG6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020BD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeK3C7Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:59:25 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37340 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeK3C7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:59:25 -0500
Received: by mail-yb1-f194.google.com with SMTP id d18-v6so928804yba.4;
        Thu, 29 Nov 2018 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GyIEYhvdRvJJ7cA9IrZUO0BaASlbo8wDkHEXFN/2IZI=;
        b=Yu5HrG6Via1jLCrMSeRY46VC9W1qnplO9X99/sbLV3hOCZQHRmll7T15VMunYtUkmd
         r6ZBbA4Nvae2WL/X+6NoIU+UwUbAL+afGzCzqtKFyRzXFR/6Hk9j8A0CD35J9O5RZ7wF
         DzUThCR0vYWT2qQY9X49fcICosw41pKdoL0gEW+bW8IuRzTmxy35L8iW/kw2Pkj+P4/M
         TKjCfttb52tlX7LsRtNxd1a3Hx3PNE+bWu2IZzp7O2Oo8gSDE+xAxwkC2Z5O5nng4JCg
         41+MKpxjW2URix2FDjrqSLT494f6d0DlZTPdWA9DoEBo0UH0Eyb5dePDI+JDdY6Rzddw
         cHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GyIEYhvdRvJJ7cA9IrZUO0BaASlbo8wDkHEXFN/2IZI=;
        b=uSnDnlxqR38YOKW3Bgc2/O1uvGtsirjU3ae9lZS9iVBpp6hDRCW1v6m8NeacsE3RsX
         kDoCbct73U5iObrk8tVZbpTo1wqOtVGCGJq8J+GpiMocuW75mW1vUXL2fLsprX04cI5Q
         LJaNgYHv2oG4/4PgoO/LB1JBQUPXHgIj4I2+PlvTOiY04vsv7x0c+jg3eOR5V4q4k7o1
         jXTYEeOHKJZCcxcBqm9tT2ae/xPdoeATI8o7AIR8Q+IUQLGv7Xm1vLxNvEM18LQdiJt8
         NDRbNZElF0N1e3nvRtYhVpFI1yi/8+X4PDcRdvAjI+iT9xt2PyWQ1rSBkePTiPnHHXyr
         AMQA==
X-Gm-Message-State: AA+aEWYMwiu+ccOwKVUmrCDlK2EdHMKZFtEm34eE0W1zfDhaLRLsSR2U
        BG/LXEotjrpSfyYRExLO/l5EvbjQ
X-Google-Smtp-Source: AFSGD/W5OZO180NFEAW70YxFgvelwyDJ8YiPZ5rYQYMnGK7d2aFI7htk0m/TVzb/op0Qzt5ZXGMF3g==
X-Received: by 2002:a25:5c88:: with SMTP id q130-v6mr1845610ybb.236.1543506816071;
        Thu, 29 Nov 2018 07:53:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:c5f4])
        by smtp.gmail.com with ESMTPSA id z37sm803549ywj.3.2018.11.29.07.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 07:53:35 -0800 (PST)
Date:   Thu, 29 Nov 2018 07:53:33 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] blkcg: associate blkg when associating a device
Message-ID: <20181129155333.GE2509588@devbig004.ftw2.facebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-6-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-6-dennis@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:38PM -0500, Dennis Zhou wrote:
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 62715a5a4f32..8bc9d9b29fd3 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -486,6 +486,12 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
>  extern const char *bio_devname(struct bio *bio, char *buffer);
>  
>  #define bio_set_dev(bio, bdev) 			\
> +do {						\
> +	bio_set_dev_only(bio, bdev);		\
> +	bio_associate_blkg(bio);		\
> +} while (0)
> +
> +#define bio_set_dev_only(bio, bdev)		\
>  do {						\
>  	if ((bio)->bi_disk != (bdev)->bd_disk)	\
>  		bio_clear_flag(bio, BIO_THROTTLED);\

Generally looks okay to me but I'm not sure about bio_set_dev_only().
Maybe sth more explicit like bio_set_dev_without_blkg()?  Also, can
you please add comments explaining which should be used when?

Thanks.

-- 
tejun
