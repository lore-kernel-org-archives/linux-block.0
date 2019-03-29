Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65896C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343B22173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KBKZVHQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfC2O20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:28:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53347 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfC2O20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:28:26 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so3992351itf.3
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=STvL4YTma87tQWSV4qbhRRe4fPdg2yfrE0tdNyxAhv8=;
        b=KBKZVHQG9r3klJ/6juRuvnOXiUyYtqMIOQt/8bygdbHEvRPfB99UTccSezqP4O0DV5
         OImQzWucG1nrLdh/NmyT7NgabeXb5T8aPbxMYAsigakWQ029Jou8xImVkIcmpvAyYM82
         ebEkoaS+RcSidcLCzMyqm2Djtpj8QEqjaBlwi4jP6TxAQSzuxY3HfNVJNsG2suj/6WGq
         uGrgoxmhOEcH86Yh3qXV5b5bwuxYOKuhQ7JTSKjIJ8i00PmiwfitXR7n8i5dSeKl4HGQ
         IScbZCjDIA9nJAAEmbfitzKJLk0kkj1p3AlBI+g3UvR488r5CTuSebHoMicHOJyKoIs/
         cd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=STvL4YTma87tQWSV4qbhRRe4fPdg2yfrE0tdNyxAhv8=;
        b=cPEaOOXRWGPHvZe+uiGFQHYJfFBvufKtv2bDGqMysGsBGl/WBix66uk8o8tgRJrXee
         msM4FxMVsX9inahABnRungB3CpyjIZkkifCUE7mvAbl3rURiF65SQ9NPbYldnNay69AI
         YN+uc2/J1lMIPXcXZEHmnKl+m8F7DCTznd0e4klQPfk1PZQWRO4JpHBT8Hr/9oJ327cV
         6YJn6kD7um6uE8yNnGKuukg6mYEClLLECpudDV/vsZTjhyMJSVn+fmaH2jWckf+jqFvv
         ncx7POtXhszm3vvkxUgEvJi4Z02qILHF/0xzHwZXo2ARui0zXxTJHzW9CZj1HeyzgS/h
         woKw==
X-Gm-Message-State: APjAAAU8SfSayDqgwLCbcXBzuRoLUMrMehffVHKPrtXigh27EYyUN+qU
        MGKaVf1WSeEod7ueermgz0vQGRtKlBvnEg==
X-Google-Smtp-Source: APXvYqysU43l0fRv3x1UVzsyVewGUGXbMR7XpWvWWF+4Gn6B8RbQx9lAhfico6n3HcAiFnV7MDSrDg==
X-Received: by 2002:a24:7c44:: with SMTP id a65mr4470176itd.5.1553869705557;
        Fri, 29 Mar 2019 07:28:25 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w14sm860354iol.32.2019.03.29.07.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:28:24 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
Date:   Fri, 29 Mar 2019 08:28:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329142346.1677-3-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 8:23 AM, Bob Liu wrote:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d66bf5f32610..e9f25f162138 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -18,6 +18,7 @@ struct block_device;
>  struct io_context;
>  struct cgroup_subsys_state;
>  typedef void (bio_end_io_t) (struct bio *);
> +typedef int (bio_verifier_t) (struct bio *);
>  
>  /*
>   * Block error status values.  See block/blk-core:blk_errors for the details.
> @@ -187,6 +188,8 @@ struct bio {
>  		struct bio_integrity_payload *bi_integrity; /* data integrity */
>  #endif
>  	};
> +	bio_verifier_t		*bi_verifier;	/* verify callback when endio */
> +	struct work_struct      bi_work;	/* I/O completion */
>  
>  	unsigned short		bi_vcnt;	/* how many bio_vec's */

I told you this for the initial posting, and the objection still stands.
Adding 40 bytes to struct bio is a no-go.

So that's a big NAK on that series.

-- 
Jens Axboe

