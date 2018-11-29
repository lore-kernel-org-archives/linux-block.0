Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F1C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856C6213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vN0j/r2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856C6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeK3CzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:55:11 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35898 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeK3CzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:55:11 -0500
Received: by mail-yb1-f193.google.com with SMTP id g192-v6so925094ybf.3;
        Thu, 29 Nov 2018 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kz3dlz6bQKYwlGklFZS+mfDThvjV457sQrSsgWVJFng=;
        b=vN0j/r2RslOzzzUxYdvwqlYZlvRszVNX/btGSlpATxyvpI2/Y1pAMV2uPkrqvMXoRX
         nHvwy8NXinkgfGCnhQ/YrbWcp6fTQgua/fKOSIOV4Zbfc2ZXokJLb9KVvud3NSHxIQBa
         G0mIw1neHBa0XvVR5ROuv38YIPOMuumXHjVlZOTntH6BsRCtGBY+sm/YNwgMpBlKxKvi
         1ywaWVeJdQjR4soDpb/sifDolAYXlLTKJY6E5ENC+gBsrDp+TMuTAviQiuqO1xd8cYnR
         kvOq7NIdbQwSudVxpf42O1AHmetw5cm07OE9afOESCLEzlpskjuXg+EyVIo+HoGxleZ+
         43Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kz3dlz6bQKYwlGklFZS+mfDThvjV457sQrSsgWVJFng=;
        b=K2szJ+VQS+vcK4ObnrTDRc0ZJoPmBhTvWVU+DYWeLf6qAQgDW2YhPwRWD64tfP/Dkx
         6tv5Ic1jsz/wtMVSaNVyt/CBte9OtOyUT1SLOZ2XgWp4uJUQqh0RhRjj6hQatxZQcJOI
         UPwV0DMeHvt/EfWzh9eCF5YZcxwBS5O57MZfBYdf5pSHnUDeubHcS4AwA6DlvTtslxOE
         thsd7TFGP+U+BIG8aNOK9NGO+uwGJMgr69KNVj7148m/XCRcGWDAEt+o03WYwFYAGALs
         nqFIW+ua9VaXWM54gY693hPwms3wUEiTDPv3WGf1VpCZjskJPa7e/Bvt0eJjKsoKmY/L
         V1Ug==
X-Gm-Message-State: AA+aEWYzBfZFk70hue0OPnlD0i2jNao1ZrW+cTOTfqldYfeWf+hUsO11
        H7NASmgpCSEjBEtUBb/M0mqB8X/M
X-Google-Smtp-Source: AFSGD/XVmjVwxITljB/ilynmA7TD9g/XGCTLxyATc38pRqeySvJC1b1W82D587Os6lomaqv9PzTuZw==
X-Received: by 2002:a5b:eca:: with SMTP id a10-v6mr1734183ybs.242.1543506562214;
        Thu, 29 Nov 2018 07:49:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:c5f4])
        by smtp.gmail.com with ESMTPSA id p203-v6sm789514ywb.34.2018.11.29.07.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 07:49:21 -0800 (PST)
Date:   Thu, 29 Nov 2018 07:49:17 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] blkcg: introduce common blkg association logic
Message-ID: <20181129154917.GD2509588@devbig004.ftw2.facebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-5-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-5-dennis@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:37PM -0500, Dennis Zhou wrote:
> There are 3 ways blkg association can happen: association with the
> current css, with the page css (swap), or from the wbc css (writeback).
> 
> This patch handles how association is done for the first case where we
> are associating bsaed on the current css. If there is already a blkg
> associated, the css will be reused and association will be redone as the
> request_queue may have changed.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

A minor nit below.

> +/**
> + * bio_associate_blkg - associate a bio with a blkg from q
> + * @bio: target bio
> + *
> + * Associate @bio with the blkg found from the bio's css and request_queue.
> + * If one is not found, bio_lookup_blkg() creates the blkg.  If a blkg is
> + * already associated, the css is reused and association redone as the
> + * request_queue may have changed.
> + */
> +void bio_associate_blkg(struct bio *bio)
> +{
> +	struct request_queue *q;
> +	struct blkcg *blkcg;
> +	struct blkcg_gq *blkg;
> +
> +	if (!bio_has_queue(bio))
> +		return;

So, this isn't actually necessary cuz we don't stack with
request_queues but it might be more consistent to call disassociate
before returning above so that even if sth like that happens the
function always guarantees that the blkg and bio agree.

Thanks.

-- 
tejun
