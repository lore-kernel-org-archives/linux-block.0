Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9BCC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C9D20823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="kngLo3Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCDWgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:36:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37685 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 17:36:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so4091241pgq.4
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 14:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/tXxgffQThbUWkJCv4RlMCT6uGDTJL6ogygI0uMdsU=;
        b=kngLo3Fb4qMH9Idu+obZp6rUbKx5L07lBRAkiZ+z1WnKsu73Nu3HhM092DeJleee3Z
         Tq+vKvzytYO/0nsoI2I6kwwXF2E7qWl+GTb+HZOgDI0HdvoS7dixDiocrjOuWoqzL7xD
         +LyKwE732hjmIR3ZY+OW8j36J/nqH7fIQ0FiJi0Ju79yV9aL1jb+XsXKWjVkIUYkW8bC
         OK1TLdSzq6dTtSf7D5JiEnpL+I5u406YuhoY9R/oyaw0RM/rDh7KERRW9naA9MqmZ2O7
         PwO5OK263i9sXZmtU7NcOHCaLXPkqX5RmYOCZeRNgLsFsX8LyR7K9YBQzN7bSeHiMyep
         1+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/tXxgffQThbUWkJCv4RlMCT6uGDTJL6ogygI0uMdsU=;
        b=SFn5tmoYLOou2BGNMUyMzN6yBC/jfIclhciD3Uc+XBlUnEcqOSQ0uP0lAR/03L9Xb0
         F7MqNtTxRsxKZM6BbrC8XcsPwMpKGw2vgcmeXhzm3q73x3GUBlZn2Rx87Yz035ZJHyh3
         2Qo/yUKl01ZBBZY4YUhAZemuSJWrPux1iDrCr1aKqgcjJ9HI0s74wXY046UwyvQzlcD+
         rzyoiNJnZrp4gItk2ws2P10/acIYsk3E1edc+nrhBFFq54/8gG+riILm3DCmu9l1osca
         e7ahvKEv5QkQW68p2kX3FnrosGu5NcJBC1sA+G9ysLrAVCFLCOnnXvSO6j2+ThL1Xlig
         bLuQ==
X-Gm-Message-State: AHQUAubaCvGAq0SjSDPk+pu44r8hLEtXHFv/tv3qSRi8F7Xf8pLdar6x
        yoMoiCHqcAW0zl536NjjYco34w==
X-Google-Smtp-Source: AHgI3IZfSxmTuZvRhx0EUDlcYtq/Ahimb/0QECCeb0xzHpvru/4MlJLLeUR+dBtqibtz9RUoQCcykg==
X-Received: by 2002:a62:20c9:: with SMTP id m70mr21928111pfj.118.1551739006278;
        Mon, 04 Mar 2019 14:36:46 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:9d2c])
        by smtp.gmail.com with ESMTPSA id y9sm8867139pfn.120.2019.03.04.14.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 14:36:45 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:36:45 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 5/5] zbd: Change sysfs path for partition devices
Message-ID: <20190304223645.GE5450@vader>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
 <20190220081231.15366-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220081231.15366-6-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 05:12:31PM +0900, Shin'ichiro Kawasaki wrote:
> zbd/001 and zbd/002 test cases fail for partition devices because of
> sysfs path difference between partition devices and their holder
> devices. The size parameter in sysfs path is different between the
> partition devices and their holder devices. The holder devices have
> nr_zones parameter in sysfs but the partition devices do not.
> 
> Utilize _test_dev_is_partition() helper function and TEST_DEV_PART_SYSFS
> variable to refer correct sysfs size parameter for the partition devices.
> Do not refer sysfs nr_zones parameter for the partition devices. Instead,
> calculate the expected nr_zones from device capacity and zone size.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/zbd/rc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/zbd/rc b/tests/zbd/rc
> index c32bf31..88538d0 100644
> --- a/tests/zbd/rc
> +++ b/tests/zbd/rc
> @@ -75,7 +75,11 @@ export SV_NR_ZONES=4
>  _get_sysfs_variable() {
>  	unset SYSFS_VARS
>  	local _dir=${TEST_DEV_SYSFS}
> -	SYSFS_VARS[$SV_CAPACITY]=$(<"${_dir}"/size)
> +	if _test_dev_is_partition; then
> +		SYSFS_VARS[$SV_CAPACITY]=$(<"${TEST_DEV_PART_SYSFS}"/size)
> +	else
> +		SYSFS_VARS[$SV_CAPACITY]=$(<"${_dir}"/size)
> +	fi
>  	SYSFS_VARS[$SV_CHUNK_SECTORS]=$(<"${_dir}"/queue/chunk_sectors)
>  	SYSFS_VARS[$SV_PHYS_BLK_SIZE]=$(<"${_dir}"/queue/physical_block_size)
>  	SYSFS_VARS[$SV_PHYS_BLK_SECTORS]=$((SYSFS_VARS[SV_PHYS_BLK_SIZE] / 512))
> @@ -83,7 +87,7 @@ _get_sysfs_variable() {
>  	# If the nr_zones sysfs attribute exists, get its value. Otherwise,
>  	# calculate its value based on the total capacity and zone size, taking
>  	# into account that the last zone can be smaller than other zones.
> -	if [[ -e ${TEST_DEV_SYSFS}/queue/nr_zones ]]; then
> +	if [[ -e "${_dir}"/queue/nr_zones ]] && ! _test_dev_is_partition; then
>  		SYSFS_VARS[$SV_NR_ZONES]=$(<"${_dir}"/queue/nr_zones)
>  	else
>  		SYSFS_VARS[$SV_NR_ZONES]=$(( (SYSFS_VARS[SV_CAPACITY] - 1) \
> -- 
> 2.20.1
> 
