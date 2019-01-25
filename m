Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5791FC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F93218A6
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="IWeHSkih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfAYVJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:09:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46327 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVJE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 16:09:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so4673425pgp.13
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VbdXCTp7kOwZwq7JD9brZRat3p193NuZ+5qv7Wr1oBU=;
        b=IWeHSkihTeuUkm7oW0rFu0Jg/9BLvwZJhoj95CrTppGVzioArwxDa3P9vejnD/EOb6
         9l+8u6dBpKtldkveukGXk1pZPy29A7GDQSPoFcF64zKMYU8SmZkVA2J27DUEopxgwlhp
         hNaYDzYGmiwy1tsH+XS7jrSOxEHpk0vwKJX1g+DT5wtWruPT+vfPJ/TlFA+4VXSX1WHh
         xpmGiVeaONFsAAslGYfRz0pSGnugRAxqFWTnGCDnnOExIbAUDNq9lNR0jmOHfZC0CHIF
         m7V7CmrxhxO2n22Wq/ETzWkoXvgizX813QRdEaDkSm2GoJh8OJBT6iq41lMG8FMWB9lu
         KhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VbdXCTp7kOwZwq7JD9brZRat3p193NuZ+5qv7Wr1oBU=;
        b=HG87tSUasspvlZDVxZ9rKTZcnyBZtkj7NjUFiUv5p2E6cNAyFlAmgXj5Z4pdpzWyNF
         47RXIAY7FL9T6p9cPYbxAT0ySZe1bAfIP3jfi/vRoI6+yY3m11BiLrNInf6fvPRrhFB7
         qkv4YAGKeT9bRzDo7Uhj76RuLfdQxaRJ+DNoISEA4/biwDfeIHA+z2PbO00nFfJxcvJQ
         Pyq5W5ZoebJ4EyZPOU/sJO4z6w1wzgk4/2FUVqOUL6qpxct1W6VmYGSNii2XbZeNizOd
         muTuj/b6PKuLzNx5dFZgQr9KL42WqAxzu8GHeIqXW/aDsMxYMdQiTJDo0niOStOq3vqS
         0Dtg==
X-Gm-Message-State: AJcUukelkRKvSy6fViDoszEfs58UHcLIFOmrSX/SZzF8MnuJKnhHMI4D
        CN/TeG23sAgm6nvspJVcJLdI8Q==
X-Google-Smtp-Source: ALg8bN5psT1VuCY9tZi+BBWxg0pqAI83kAbmne1hBu3PMBnvRr9scrOE23f4pGub0upUi53uGgiKIw==
X-Received: by 2002:a63:f141:: with SMTP id o1mr11537604pgk.134.1548450542949;
        Fri, 25 Jan 2019 13:09:02 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:f0e2])
        by smtp.gmail.com with ESMTPSA id t13sm30199203pgr.42.2019.01.25.13.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 13:09:02 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:09:01 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v3 03/13] block/004: Adjust fio conditions for
 zoned block devices
Message-ID: <20190125210901.GB26739@vader>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118094453.13773-4-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 06:44:43PM +0900, Shin'ichiro Kawasaki wrote:
> For a random write pattern to a zoned block device, fio requires --direct=1
> and --zonemode=zbd options as well as deadline I/O scheduler to be
> specified. Specify these options and set the I/O scheduler if the target
> device is a zoned block device. Before doing that, also make sure that the
> deadline scheduler is available and that fio supports the zbd zone mode.
> Set CAN_BE_ZONED flag to run this test case for zoned block devices.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/block/004 | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/block/004 b/tests/block/004
> index 4c14c4b..7340d33 100755
> --- a/tests/block/004
> +++ b/tests/block/004
> @@ -8,6 +8,7 @@
>  
>  DESCRIPTION="run lots of flushes"
>  TIMED=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_fio
> @@ -16,10 +17,25 @@ requires() {
>  test_device() {
>  	echo "Running ${TEST_NAME}"
>  
> +	local directio=""
> +	local zbdmode=""
> +
> +	if _test_dev_is_zoned; then
> +		if ! _have_fio_zbd_zonemode; then
> +			echo "${SKIP_REASON}"
> +			return 1
> +		fi

This will be marked as a failure instead of skipped. This check can be
in device_requires instead:

device_requires() {
	! _test_dev_is_zoned || _have_fio_zbd_zonemode
}

> +		_test_dev_queue_set scheduler deadline
> +
> +		directio="--direct=1"
> +		zbdmode="--zonemode=zbd"
> +	fi
> +
>  	FIO_PERF_FIELDS=("write iops")
>  	_fio_perf --bs=4k --rw=randwrite --norandommap --fsync=1 \
>  		--number_ios=256 --numjobs=64 --name=flushes \
> -		--filename="$TEST_DEV"
> +		${directio} ${zbdmode} --filename="$TEST_DEV"

I'm surprised that shellcheck is smart enough to see that directio and
zbdmode are always one word so this doesn't need quotes :)

>  
>  	echo "Test complete"
>  }
> -- 
> 2.20.1
> 
