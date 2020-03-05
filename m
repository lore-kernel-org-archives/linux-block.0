Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B4C3F2CE
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0030A20866
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="B6FDQgsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgCEBcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:32:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45215 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCEBcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 20:32:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so1873206pls.12
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 17:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nwxPFZEgGm11LzXMpujG1wPjJC/1DwOKVtUkVXRUzU8=;
        b=B6FDQgsc5Di9w6Ee/h4bm0Vqvi19NC4Z0jZ9Xyw2MLAxzFadmBUrK6O4p9PAKl+CMw
         QGWF2PsP3DT73Lx11XKs91hR6qg1sf5U+IgLb6cZo2lGbc9u5NZ+5F6Xp9ZifB+I0sbI
         8cNkgrOaS5xtjkUQG1/Ati3fPt7SOmJuoMvvVYtQ6RPGDBhBjTi+q9To7wG1rsTiaq00
         T3zUbouArrMUSBaWrpYtL/Uw9hPodXEDtvzXQw3aNuRzyOujO8WnZLeLoPOwGmA9AmKR
         kFjw+HRjxGAC4iMm8UV1zWhsqFV4JH27U65n6fZHxeCGazUgasKAGdExG5HKCQ+LLQeG
         TzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nwxPFZEgGm11LzXMpujG1wPjJC/1DwOKVtUkVXRUzU8=;
        b=W1vyWFOdNGPwroyOF93ZiR1+cmsHY+l4orktQCBA/q2FHzCJ7Cl+GVWqlGmSW0MJ6n
         Kfyx2+85hwD2Kl5MjIBDITYdWrbUe+SNc8Bihnxr8+QZiLaCysEua/r/KiYSR+H2fWcG
         KJdUkmTYU7F9VS0TLSoVYYSGmSK6hHv2gz5ulSCKxNjOQKemM6MOt5uhH6MTLjQFkI6y
         ZxoT2KVkYwpREdisXJFcKl0uic/UYZqbByjXhy8nxfC1hXPqPW9StYY83emopHcAyWA8
         mzByqmZZ9RP+zJZleHgiJ9h2NRvqeSqjVke777Li9b6IilecQHe/CqiPYyn65WEHfZc0
         3cIQ==
X-Gm-Message-State: ANhLgQ0mXbKDkRmq8PXPIPSK9bDKJBujl6JmRu2SNANNyfhdoAhP5nJe
        E2OBTjecBcysxQwSysMl9J/8gA==
X-Google-Smtp-Source: ADFU+vtElY8w+ZmRXAghnthJ3g79718sNeIGHlH7lBnBlLwJwAqVpwiunF08EKg8w1kzRgIkAlMuJg==
X-Received: by 2002:a17:90b:3586:: with SMTP id mm6mr5714748pjb.147.1583371962448;
        Wed, 04 Mar 2020 17:32:42 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id 188sm25812591pfa.62.2020.03.04.17.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:32:41 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:32:41 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests V2 1/3] nvme: allow target to set cntlid min/max
 & model
Message-ID: <20200305013241.GB293405@vader>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
 <20200215013831.6715-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215013831.6715-2-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 14, 2020 at 05:38:29PM -0800, Chaitanya Kulkarni wrote:
> This patch updates helper function create_nvmet_subsystem() to handle
> newly introduced model, cntlid_min and cntlid_max attributes.
> Also, this adds SKIP reason when attributes are not found in the
> configfs.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/rc | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 40f0413..e4b57cb 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -121,11 +121,36 @@ _create_nvmet_subsystem() {
>  	local nvmet_subsystem="$1"
>  	local blkdev="$2"
>  	local uuid=$3
> +	local cntlid_min=$4
> +	local cntlid_max=$5
> +	local model=$6
>  	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>  
>  	mkdir -p "${cfs_path}"
>  	echo 1 > "${cfs_path}/attr_allow_any_host"
> +
> +	if [ $# -eq 5 ]; then

I still don't like that we ignore this if we also pass the model.
Instead, just make this

if [[ -n $cntlid ]]

Then the caller can pass an empty argument if they want it ignored.

> +		if [ -f "${cfs_path}"/attr_cntlid_min ]; then
> +			echo "${cntlid_min}" > "${cfs_path}"/attr_cntlid_min
> +			echo "${cntlid_max}" > "${cfs_path}"/attr_cntlid_max
> +		else
> +			SKIP_REASON="attr_cntlid_[min|max] not found"
> +			rmdir "${cfs_path}"
> +			return 1
> +		fi
> +	fi
