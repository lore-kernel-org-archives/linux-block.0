Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C49C4CEC9
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 06:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0684B20882
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 06:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmDdv0Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408219AbfITGFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:05:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44661 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404716AbfITGFI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 02:05:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so5399965wru.11;
        Thu, 19 Sep 2019 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cED18m1mvjZ+niHvjAeZ+v1xJ6oH9Dol7OSVjJcLyuU=;
        b=EmDdv0Lzck9qjY3AmMNK8VHhZlfh9YkKN0+gv6DY6FojUJnC560+vgvJ7nnaWZSUrz
         s4cHXnPkVuduXEWZJ2pf6L/Rbje7VwoPtHY+AzUlKmeylLsbT/I5OpyLNgh9TZm0weED
         ur3d56IgMs0pQ1X6/0R890LmIgohd5ULnBYZ7A+mpxEEIdPUvVB6J1Uz6ocIP+EOZQ1a
         P6dKhenrIdziB4pZpv2ehc8RVlZcGIIjE2ghmLpjMRcqGDxgU2lAtqZuTejYVnq3fFi+
         HAfSuu0/6Z+DZS77Md7dLvNFq9URNo3Tw2lFkEt/QBx1jBDTk7+SfvSXNHrWt1x9cVp+
         Az5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cED18m1mvjZ+niHvjAeZ+v1xJ6oH9Dol7OSVjJcLyuU=;
        b=HM2zl29nIMnWJ/fDesL2XzVNFTb+sEJmPOB22RWz0c3V61CA8ZsxiXMxbNqCUCKLE5
         BipHiPuALizQFtHRaWEzk0fTfcJrBCpebp4GAAmnwTyKfuCFfHagicBBYXIrdA+7l5mk
         yujMSblZaiSwmJTN1U3BUWHh2EsvYRou1seygwCJx0sbn5FL9hpBfBpIdHMjnl0lFCW0
         GMnUoCYZ+Vsgez5Zb53U5Hrom2RE7yRX5cYRaKhhA9R9vIslXgeuzh3hFZLkw+9pwrWi
         S4iIy/029uMb2lGfIubB/hUbIm0JrtyO3dM7TaEIg2PaKlv9hPAlNdn0k7po93qK9olU
         haww==
X-Gm-Message-State: APjAAAUjQr33l64uJbcqt+v8z2hpHxTxMh0YQvZr2p2+V27nmp0TqwOg
        iuvsDaHOaEtasuv/mCVHEXSkLm2rk2E=
X-Google-Smtp-Source: APXvYqx9G70xEnXbHl9Gpjja/wrBXdZt5GW23xEsjeblfV1FMA9CU/z4o5/y77gPAMKzAPDd3jBitg==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr5806942wrn.234.1568959505815;
        Thu, 19 Sep 2019 23:05:05 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id h125sm913513wmf.31.2019.09.19.23.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 23:05:04 -0700 (PDT)
Date:   Thu, 19 Sep 2019 23:05:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] block: t10-pi: fix -Wswitch warning
Message-ID: <20190920060503.GA130425@archlinux-threadripper>
References: <20190919135725.1287963-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919135725.1287963-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 19, 2019 at 03:57:19PM +0200, Arnd Bergmann wrote:
> Changing the switch() statement to symbolic constants made
> the compiler (at least clang-9, did not check gcc) notice that
> there is one enum value that is not handled here:
> 
> block/t10-pi.c:62:11: error: enumeration value 'T10_PI_TYPE0_PROTECTION' not handled in switch [-Werror,-Wswitch]
> 
> Add another case for the missing value and do nothing there
> based on the assumption that the code was working correctly
> already.
> 
> Fixes: 9b2061b1a262 ("block: use symbolic constants for t10_pi type")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  block/t10-pi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 0c0120a672f9..055fac923946 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -60,6 +60,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
>  		__be16 csum;
>  
>  		switch (type) {
> +		case T10_PI_TYPE0_PROTECTION:
> +			break;
>  		case T10_PI_TYPE1_PROTECTION:
>  		case T10_PI_TYPE2_PROTECTION:
>  			if (pi->app_tag == T10_PI_APP_ESCAPE)
> -- 
> 2.20.0

I didn't have the break in my local patch but I think this is more
correct based on the description of the enums. Like Nick pointed out,
there is no functional change because this value is not used in this
file.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
