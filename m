Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBA8C06511
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F49218EA
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzT2FZTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGCAmp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:42:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35851 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCAmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:42:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so295743pfl.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+88rqRK28VKisC+37wlmaYyoSMpDKjaXlPRwLTc81A=;
        b=dzT2FZTy6mtiH9VhpzQzcGg9srgeIi7ULRstbUxhYdbumgVyC/BccJNUTeeqM1JxeU
         /aJ5Yh18Qhitb2uNCOgrqAJCQJCooh5kppJeFISYa3vTW8w8SZxXSzU3q+z+Y8nFvLFm
         7UmoIeMOk9x4NdUuGct6yT4j/uqa59drJqUwOsnG7+WOlDf9pYrCXpOMAb1Ug0jw04yr
         SAPFSsgeuDtEdJsxFXFieMadb9VHG15xWRp9t7JYXycs9+fXJ9FIhQsAwh+12iAX31ay
         fdkmhF4pBle4Q3xXpB/fyTvqk4KZ8o4Aea0TaSNKPkeiHJQDb+qfydVF0WnF17USk+zV
         1U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+88rqRK28VKisC+37wlmaYyoSMpDKjaXlPRwLTc81A=;
        b=reOON3dxWH2oVCCnJANpB9wx8wVR7ovcwgIuUTniFVW7XegYKD1WL30P/AOkpu4eIB
         EO43LRWnzgnyzcDRNjOC0dofiVg8lzrDGXTe0kRG88glqnW7VDc4kGrBP8fHaJkOhB4o
         Vsp5bO8D0KW/E9xcJi4tZ7R8sog1kTkpYX+ixTc1nfC2AeFOD0sQUO+glJwvgg24nl1i
         5pbKBtes1Z6g0Mj8hY492bDOMskwEjEuJkWzp+HNszdK9xbLe9cpi5dYYGzUQOP6wZkB
         Iw+JMaqSj/u6E1vUEI2mo/65Zzo9T3HJr6qO//Te7dblJ+x4+vUAS2TCaOOB0NDeBuTf
         bowg==
X-Gm-Message-State: APjAAAWMKqLarykm9QR/U8VzNtn5K/U8DrO3mgAcvZZyfVow8i2XQ+Hp
        FZsFu7pdMCLeKYX41YjDmMI=
X-Google-Smtp-Source: APXvYqy4XjIjmrg7EOdGeLB40liOwbHKiGqRa8PnbMoJxGCcXUMnLbqCHk5S0oYvRWhq9TvOZCkYow==
X-Received: by 2002:a63:6883:: with SMTP id d125mr34024381pgc.281.1562114563831;
        Tue, 02 Jul 2019 17:42:43 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id p1sm250858pff.74.2019.07.02.17.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 17:42:43 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:42:40 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        bvanassche@acm.org, axboe@kernel.dk,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 1/5] block: update error message for bio_check_ro()
Message-ID: <20190703004240.GA19081@minwoo-desktop>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
 <20190701215726.27601-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701215726.27601-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-01 14:57:22, Chaitanya Kulkarni wrote:
> The existing code in the bio_check_ro() relies on the op_is_write().
> op_is_write() checks for the last bit in the bio_op(). Now that we have
> multiple REQ_OP_XXX with last bit set to 1 such as, (from blk_types.h):
> 
> 	/* write sectors to the device */
> 	REQ_OP_WRITE		= 1,
> 	/* flush the volatile write cache */
> 	REQ_OP_DISCARD		= 3,
> 	/* securely erase sectors */
> 	REQ_OP_SECURE_ERASE	= 5,
> 	/* write the same sector many times */
> 	REQ_OP_WRITE_SAME	= 7,
> 	/* write the zero filled sector many times */
> 	REQ_OP_WRITE_ZEROES	= 9,
> 
> it is hard to understand which bio op failed in the bio_check_ro().
> 
> Modify the error message in bio_check_ro() to print correct REQ_OP_XXX
> with the help of blk_op_str().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/blk-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5d1fc8e17dd1..47c8b9c48a57 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -786,9 +786,9 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
>  			return false;
>  
>  		WARN_ONCE(1,
> -		       "generic_make_request: Trying to write "
> -			"to read-only block-device %s (partno %d)\n",
> -			bio_devname(bio, b), part->partno);
> +			"generic_make_request: Trying op %s on the "
> +			"read-only block-device %s (partno %d)\n",
> +			blk_op_str(op), bio_devname(bio, b), part->partno);

Maybe "s/Trying op %s on/Tyring op %s to" just like the previous one?
Not a native speaker, though ;)

I think it would be better to see the log which holds the exact request
operation type in a string.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
