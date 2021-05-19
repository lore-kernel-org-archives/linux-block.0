Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FBEC433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26119611BD
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 15:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbhESPrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbhESPrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 11:47:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2B6C06175F
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 08:45:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d11so14506170wrw.8
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HoKYm+RjM06T+m3egtchaR58vmg5foFNNoFnXFUB4KY=;
        b=phFLT6WX5XjFqlAJ2BgYX842reXlESb1xa0R+IiKVQ6WIIKoKdPG43/E3kpo7zNRNB
         nrXDAsOZniI1FT34Vhyuqc1X726KIogvzJSoGKh3uW25RH2h+jFAhALb2ltwbwAQs+u2
         Sof4k1V/Fg32JefxEeDOnkuVSdbbxDHnuaXe6Um1licTwRl4B5zRDpUbDIJ8ewyCxpP0
         dP87iU7gHnsfaDd19MyyoymjcJikUgqAfmzDTwxU3DawPtz+CArVq2H+ybJ+5aqzlOsL
         lrdJknxv44rGDMZFkPHK2EH4zY8CJgWVKeUkG+Pl08PzzCTxRTiUZL2I6qUzvZ8rWGix
         w2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HoKYm+RjM06T+m3egtchaR58vmg5foFNNoFnXFUB4KY=;
        b=rWniBgNsVnFW4A5RWBw4mQaI4VpnJeHf5uV9uLzsqZtLnz9ZcwJnFby1yANT3NTVrh
         ihHmfZ/cp/W/2iCECUtKjLRTz72m8JkaEn5Qwl+PhIAR7ePywxj1iWGfGc0cI2EYm3IU
         OJmWd0lvd5ZuOVtTWQkge0z4wSUBWU8Yz+Tois1l6dtcd9lD4pEVoS4iBp6ClJaluD6j
         edeGEAnLLGh+iRt2bFwAVw7NQsC3sEfhP4YqZudvOMvRagPyPf6uXCzlJ2G/7Gylucx1
         EkCxC4iucQx7f5eAGxAREdIVne5bJ6Lmsn9c2eY1AQkZPDcz+g1083EqOT6l/b2VZUWo
         3Fog==
X-Gm-Message-State: AOAM530exDcX79YJ0b2oceCmU+QjJ1qh0WT59fGHtN0Z78XMr7nYAqiv
        MnvVQKhWe9zdZEb1wMWcJ2Q=
X-Google-Smtp-Source: ABdhPJw1u1uMzrO7DRYw/EmjZmzNxiFE44IwvHFTvvcnJYVrkdDG8gz/h5qX98I3BBLxrENzbKmEbQ==
X-Received: by 2002:a5d:64e5:: with SMTP id g5mr15623125wri.30.1621439148157;
        Wed, 19 May 2021 08:45:48 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id j14sm6534412wmj.19.2021.05.19.08.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 08:45:47 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH 11/11] dm crypt: Fix zoned block device support
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-12-damien.lemoal@wdc.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <cbbf8310-cc46-7925-c8e9-1edb23d245ca@gmail.com>
Date:   Wed, 19 May 2021 17:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210519025529.707897-12-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/05/2021 04:55, Damien Le Moal wrote:
> Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector
> of the zone to be written instead of the actual sector location to
> write. The write location is determined by the device and returned to
> the host upon completion of the operation. This interface, while simple
> and efficient for writing into sequential zones of a zoned block
> device, is incompatible with the use of sector values to calculate a
> cypher block IV. All data written in a zone end up using the same IV
> values corresponding to the first sectors of the zone, but read
> operation will specify any sector within the zone resulting in an IV
> mismatch between encryption and decryption.
> 
> To solve this problem, report to DM core that zone append operations are
> not supported. This result in the zone append operations being emulated
> using regular write operations.

Yes, I think this is definitive better approach and it does not need
to fiddle with dm-crypt crypto, thanks.

Just one comment below:

> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/md/dm-crypt.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index f410ceee51d7..44339823371c 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -3280,14 +3280,28 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	}
>  	cc->start = tmpll;
>  
> -	/*
> -	 * For zoned block devices, we need to preserve the issuer write
> -	 * ordering. To do so, disable write workqueues and force inline
> -	 * encryption completion.
> -	 */
>  	if (bdev_is_zoned(cc->dev->bdev)) {
> +		/*
> +		 * For zoned block devices, we need to preserve the issuer write
> +		 * ordering. To do so, disable write workqueues and force inline
> +		 * encryption completion.
> +		 */
>  		set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
>  		set_bit(DM_CRYPT_WRITE_INLINE, &cc->flags);
> +
> +		/*
> +		 * All zone append writes to a zone of a zoned block device will
> +		 * have the same BIO sector, the start of the zone. When the
> +		 * cypher IV mode uses sector values, all data targeting a
> +		 * zone will be encrypted using the first sector numbers of the
> +		 * zone. This will not result in write errors but will
> +		 * cause most reads to fail as reads will use the sector values
> +		 * for the actual data locations, resulting in IV mismatch.
> +		 * To avoid this problem, ask DM core to emulate zone append
> +		 * operations with regular writes.
> +		 */
> +		DMWARN("Zone append operations will be emulated");

Do we really want to fill log with these?

(I know it is not a good example in this context - but during online reencryption,
dm-crypt table segments are continuously reloaded and because the message is in in table constructor,
it will flood the syslog with repeated message.)

Maybe move it to debug or remove it completely?
What would be nice to have some zoned info extension to lsblk so we can investigate
storage stack over zoned device (if there is some sysfs knob to detect it, it should be trivial)... 

Thanks,
Milan

> +		ti->emulate_zone_append = true;
>  	}
>  
>  	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {
> 

