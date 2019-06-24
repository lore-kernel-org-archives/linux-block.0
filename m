Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474A0C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258E220663
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfFXTnX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:43:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40194 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfFXTnX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 15:43:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so8100769pfp.7;
        Mon, 24 Jun 2019 12:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7R7Jgd9WydHhug2XxYGNEVBmO/kY+JWSP4a6RvRNEUc=;
        b=kTf3jCT8YYEtHWRHlqY0mlPyWmEOLPURtHeDOHddHwukCVSq8UpduGKoqTqfDQxwCI
         HenM/HoXh/o5rWj2yLTzt0mZAoLgVv2GZWqH3EJQDYdOuUa0D7wRsoKMN0QT57nQuBwd
         wGABuM9vOpMtuCix0HnBDkamxDS7voE7jiXqIzmCg9uDOXTJWMQGATjjA0BcsrD447O2
         wCGqXPughtS/jt4wugBAsGfrXBvYgQHBYNcVax+OmXihs8ZwQ5KPoVmodan6xBcFQWpu
         ES3Qs6kM0BCl+LyNIZaQE6k2YbpTJqgUwiDA3wJukA5sOR6l0y9DOef5BCA8scBOXDbP
         eAiw==
X-Gm-Message-State: APjAAAUFMkOmZ9Tjtk5n2Opy52p77YbYyTL2oSOVLtcX5W0m9k87wxJJ
        nxEg3P7B7NfINQJGly7GZaI=
X-Google-Smtp-Source: APXvYqx4wwT4Vt+pefHMuYP0ynmzYuda85cfUyWcxolPX1QkAjR+jUxtY+0qzRZkpI1GHqDtXPxO8w==
X-Received: by 2002:a63:4105:: with SMTP id o5mr35523361pga.308.1561405402022;
        Mon, 24 Jun 2019 12:43:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c9sm12988231pfn.3.2019.06.24.12.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:43:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>, axboe@fb.com,
        hch@lst.de, damien.lemoal@wdc.com, chaitanya.kulkarni@wdc.com,
        dmitry.fomichev@wdc.com, ajay.joshi@wdc.com,
        aravind.ramesh@wdc.com, martin.petersen@oracle.com,
        James.Bottomley@HansenPartnership.com, agk@redhat.com,
        snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org>
Date:   Mon, 24 Jun 2019 12:43:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621130711.21986-2-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/19 6:07 AM, Matias Bjørling wrote:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 95202f80676c..067ef9242275 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -284,13 +284,20 @@ enum req_opf {
>   	REQ_OP_DISCARD		= 3,
>   	/* securely erase sectors */
>   	REQ_OP_SECURE_ERASE	= 5,
> -	/* reset a zone write pointer */
> -	REQ_OP_ZONE_RESET	= 6,
>   	/* write the same sector many times */
>   	REQ_OP_WRITE_SAME	= 7,
>   	/* write the zero filled sector many times */
>   	REQ_OP_WRITE_ZEROES	= 9,
>   
> +	/* reset a zone write pointer */
> +	REQ_OP_ZONE_RESET	= 16,
> +	/* Open zone(s) */
> +	REQ_OP_ZONE_OPEN	= 17,
> +	/* Close zone(s) */
> +	REQ_OP_ZONE_CLOSE	= 18,
> +	/* Finish zone(s) */
> +	REQ_OP_ZONE_FINISH	= 19,
> +
>   	/* SCSI passthrough using struct scsi_request */
>   	REQ_OP_SCSI_IN		= 32,
>   	REQ_OP_SCSI_OUT		= 33,
> @@ -375,6 +382,22 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
>   	bio->bi_opf = op | op_flags;
>   }

Are the new operation types ever passed to op_is_write()? The definition 
of that function is as follows:

static inline bool op_is_write(unsigned int op)
{
	return (op & 1);
}
