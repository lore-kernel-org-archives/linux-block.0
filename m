Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D658C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67220675
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="la054NaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfAQCXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:23:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34964 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 21:23:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so3714166pgs.2
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 18:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wBUJlFheRtapZ5fsNqpngAVBkuJLQBld4r7qLvPmOLw=;
        b=la054NaQ7bq5O92v2XJa0GqDFFFTGW7RmNNyJ3tkvcxBriIzSUSfVAACFISXYD74Ep
         4ZJLXxqADtXCEs0WEOKB7kDfqCkTMW+67ycWrR0A+HkmIX/qKTfO09idAbrAoe0NBzoc
         MLnEzRwipn0EC5OUktQE2GeO4yvAS2VoSruDbS2dh2vXkd3ZlWndEzDEao4cUJIFSAT1
         aQyhKuOHMvF9RPONPYK+vih0+qETzPAb12/9I+i9CyQlD3S4gplph7/DK1VLlJ8wHKQy
         7PsxHGimXuPFa9kbgTcI09vsvoxQSAJYtVOmOfDEpXIcKTemcLFO7Wxd8qtnv7CSMrkQ
         i76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wBUJlFheRtapZ5fsNqpngAVBkuJLQBld4r7qLvPmOLw=;
        b=tacG4OSzIISCqpLWXJwzdQJnBE8nzMWin0yRRxRPCPnSUT8+zawNH2n7FmMnB2kgrO
         VxQ+2iI6NK0ZSR6bdnz744sCrcjTpPK7tMI4ZRpiy+E73f1yO6jstH3nOLh/ViH5jXya
         l5z8leGcKR5EP6FvwKRL65omXH1C5/mJ8VaMIocJjy/usi3loY9AbEVKQhH/sp6mJk9Y
         O6VeBK4S8tC90zlrCWaIoT3wBSxl/03WOyMLo/OPltX0UAzbVbMLToPCT2fTW45LoHpD
         ZgyDlUYPjsHIywHz61Z23jYFVGKU1Hpkig2wnwydlc1/1QpmmVJMjzd9oHU1zaNKLQUw
         j6yg==
X-Gm-Message-State: AJcUukc4ZniAJ+5IO5VsWMf9w5LlEDW3T1GvHjp/elqxffR9Yr1F6Znq
        v/5nuhSAkn9H/+sJUFHIMjBxYg==
X-Google-Smtp-Source: ALg8bN7iSVixIPLucELfCbHcIOCcTSK/VDp4f8FlnesXoSRnoPTk7uIxg3ZQ0ohMRFa47Z26vyUviA==
X-Received: by 2002:a63:7b06:: with SMTP id w6mr11750658pgc.288.1547691780079;
        Wed, 16 Jan 2019 18:23:00 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id u186sm169025pfu.51.2019.01.16.18.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 18:22:59 -0800 (PST)
Date:   Wed, 16 Jan 2019 18:22:58 -0800
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
Subject: Re: [PATCH blktests v2 04/16] common: Introduce
 _have_fio_zbd_zonemode() helper function
Message-ID: <20190117022258.GD25494@vader>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
 <20190110093725.32675-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110093725.32675-5-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 10, 2019 at 06:37:13PM +0900, Shin'ichiro Kawasaki wrote:
> Fio zbd zone mode is necessary for zoned block devices. Introduce the
> helper function _have_fio_zbd_zonemode() to check that the installed
> fio version supports the option --zonemode=zbd.

Testing version numbers is fragile. How about

if ! fio --cmdhelp=zonemode | grep -q zbd; then
	SKIP_REASON="Fio version too old (does not support --zonemode=zbd)"
	return 1
fi

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/fio | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/common/fio b/common/fio
> index e407088..44d9c86 100644
> --- a/common/fio
> +++ b/common/fio
> @@ -17,6 +17,18 @@ _have_fio() {
>  	return 0
>  }
>  
> +_have_fio_zbd_zonemode() {
> +	local -a v
> +
> +	_have_fio || return $?
> +	mapfile -t v < <(fio --version | tr -s -c "[:digit:]" "\n")
> +	if [[ ${v[1]} -lt 3 || ( ${v[1]} -eq 3 && ${v[2]} -lt 9 ) ]]; then
> +		SKIP_REASON="Fio version too old (does not support --zonemode=zbd)"
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  declare -A FIO_TERSE_FIELDS
>  FIO_TERSE_FIELDS=(
>  	# Read status
> -- 
> 2.20.1
> 
