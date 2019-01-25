Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27821C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66ED218B0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="s2xssCPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfAYVOE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:14:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44643 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAYVOD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 16:14:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so5089914plt.11
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 13:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fj74Ot9Q1RDWie6XOTOuHrdCH53o0tvGieou9zxR5ls=;
        b=s2xssCPClqPVQOSHdKEBieTBzv1NRZ3rY7BFt9EUY85JZVreuG2FuCnuUutC6OXHFc
         q6muQ1xUd4lWesCZE9H48qMEGJaOrRd5Uw75lGfgqkxug5AEp/I2rQGtxCATPLmk8m09
         iS/bLSZvDDi33bwMvPkF6vcehSofgDPQkhN6WyHDrltO+C5J+nqKaK1Qoly/NU5iUHnv
         MkRy3vUM9AsTIZg7pgaZK/X3RUbTEm0KWEYg8hhjvfQENIQw2ZrGNwkcfslefvWWtBsA
         Om0CFVCSZlfXLI09TcpeSHeUhdlVWkCQHaPuCV4m18jIAeJ9AXCG4isrBAnWmAKosO1D
         ZZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fj74Ot9Q1RDWie6XOTOuHrdCH53o0tvGieou9zxR5ls=;
        b=lCycz7aRXtB9XxBXGf+L6mNP6ZJ3axbratw+FLya4cqgrLkioDgLKm3mSFiX7W8roD
         xLISCCRcZvL+mTuc8XrZ/gS0Q7XMzwnRs8+/0FVf9bhA19drme40HuxZr+jyi0itROVO
         5j8usS/KmpmhTZ37ixK0yivipFF7VLHpW4qcspVzJYMrFlCuQtpNb402dFvRRBhGulfD
         tSYsYl+2INSpIvo7XzxXMjGBcQMzaIpm1pjMqf/mjKkbt1meHXevRUm44F6HTPdAcmgW
         dVgtFkSQ7svi3WmIRKzEgFq/wVEg8YSY5ZNRfbluRuB+A0hRmF7uNbkiVIaxjleC7iVB
         +3zg==
X-Gm-Message-State: AJcUukeVxBTcEac+tfbiLiJFsLyUqRVZUPbAfsjQu49eI/PDGUyO+ch0
        u6iUNSEs4t6JwNrJdf/TPBPvojeP8cY=
X-Google-Smtp-Source: ALg8bN7+0QxqZa5fddpkoH6KjwyxAG45QN2YUw34zEFz8mp7UqmPVw9S9tW5fTuCf4Tg/q34ltBx1A==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13mr12697491pls.102.1548450842824;
        Fri, 25 Jan 2019 13:14:02 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:f0e2])
        by smtp.gmail.com with ESMTPSA id k14sm39759467pgs.52.2019.01.25.13.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 13:14:02 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:14:01 -0800
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
Subject: Re: [PATCH blktests v3 05/13] check: Introduce fallback_device() and
 cleanup_fallback_device()
Message-ID: <20190125211401.GD26739@vader>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118094453.13773-6-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 06:44:45PM +0900, Shin'ichiro Kawasaki wrote:
> These optional functions can be defined by a test case script. When
> defined and TEST_DEVS is empty, the fallback_device() is executed before
> runing the test case. The fallback_device() function intializes a virtual
> device to run the test case and return the device to be set in TEST_DEVS.
> After running the test case, cleanup_fallback_device() is executed to
> clean up the device.
> 
> This feature allows to run test cases with test_device() function even if
> TEST_DEVS is not set in the config, using virtaul devices such as null_blk.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  check | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/check b/check
> index 4563d62..4b66995 100755
> --- a/check
> +++ b/check
> @@ -407,6 +407,7 @@ _run_test() {
>  	CHECK_DMESG=1
>  	DMESG_FILTER="cat"
>  	RUN_FOR_ZONED=0
> +	FALLBACK_DEVICE=0
>  
>  	# shellcheck disable=SC1090
>  	. "tests/${TEST_NAME}"
> @@ -425,6 +426,23 @@ _run_test() {
>  			_call_test test
>  		fi
>  	else
> +		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
> +			declare -fF fallback_device >/dev/null && \
> +			declare -fF cleanup_fallback_device >/dev/null; then

We should check in _found_test that cleanup_fallback_device is defined
if fallback_device is defined, and vice versa. Then, we can just check
for fallback_device here.

> +			if ! test_dev=$(fallback_device); then
> +				_warning "$TEST_NAME: fallback_device call failure"
> +				return 0
> +			fi
> +			if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
> +				_warning "$TEST_NAME: could not find sysfs directory for ${test_dev}"
> +				cleanup_fallback_device
> +				return 0
> +			fi
> +			TEST_DEVS=( "${test_dev}" )
> +			TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
> +			FALLBACK_DEVICE=1
> +		fi
> +
>  		if [[ ${#TEST_DEVS[@]} -eq 0 ]]; then
>  			return 0
>  		fi
> @@ -451,6 +469,13 @@ _run_test() {
>  				ret=1
>  			fi
>  		done
> +
> +		if (( FALLBACK_DEVICE )); then
> +			cleanup_fallback_device
> +			unset TEST_DEV_SYSFS_DIRS["${TEST_DEVS[0]}"]
> +			TEST_DEVS=()
> +		fi
> +
>  		return $ret
>  	fi
>  }
> -- 
> 2.20.1
> 
