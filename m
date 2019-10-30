Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55458CA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228F02080F
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 21:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Yqz57Pk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfJ3VQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:16:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40569 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3VQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 17:16:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id 15so2344709pgt.7
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u0Ueus/uSTyxnyoBVlWxgagnjB9iqVv0H5m9ChPqMEs=;
        b=Yqz57Pk++q2NuYoBSKsAPEgmCk6aupRVeWf5g3LOrBT8S9iDI/kQOrUAsJb4TiOCcg
         jEX6k6mFJtWu1VkcRlcXgfmSDs4O6gJsGSb0Y2yD64aPy74V5yhyTWFErfcO9pmIdmmZ
         jg9gzZnQQ86cAEAFDaac7i4qIij/GQRU3PmBGyGQrtSnR4jB+q+rq6SXjae4R0AuqEcW
         uz2KlNutxsEWllCJQBRjEeUNzEH1/JTrJx9ZYwXq6QsxqKG/bAlK67D6UB6byol+rw9B
         FkaIlyp1Ugb2jtWvhByVIhhUTL9r0xBer+Go1TVi94kFWKE1iLbRxRspkykxZsjq/S8W
         /uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u0Ueus/uSTyxnyoBVlWxgagnjB9iqVv0H5m9ChPqMEs=;
        b=PMETKVfJUYXQjG8jPj9mrgIKzzirKPjbx3AonzzuOmL0cS69oGOXku+VG+T0DY4xco
         hEC284beCx56DJS+8CHB1pDSk2ijaqPpSyaUxAHcScL1hhfIKoTiJk8BTD6cDoOAIfWA
         fGAwcV3Zbjtgq7NqWEBt3qbPAEvpI3ucVOXvg15sj4F+fhkK5h5t+0NvR6v2BsHDY2bV
         yGTbDbAmBng91D2F4gGbJnIbAdOjMa42WSJEOtRs2i4tsk7NUvJ6S5cydy5kwvjMbX37
         pfBmCyONlMR1bcWQWo/DDwNAJ9xp3IS1KITjJp1zNi5W2B+y4mL19gF17qIkxPuJj2/x
         FRfg==
X-Gm-Message-State: APjAAAVusDwUnt87qlNaH4C4TMvBb8/asxVNUGxqIHKSIJcQwapHJCvZ
        1PwJjLRKDpnhHW+8g2GaJ+YTxQ==
X-Google-Smtp-Source: APXvYqynz6GXsFuhxoZPIPFH44PIb7+U+VoE5Flu3kHygNL+oxJSsmKPLCRBViF8rBzey+4embCU7Q==
X-Received: by 2002:aa7:9d09:: with SMTP id k9mr1545076pfp.154.1572470213402;
        Wed, 30 Oct 2019 14:16:53 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id e8sm817895pga.17.2019.10.30.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:16:52 -0700 (PDT)
Date:   Wed, 30 Oct 2019 14:16:52 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, kernel@collabora.com,
        krisman@collabora.com
Subject: Re: [PATCH blktests 1/3] check: Add configuration file option
Message-ID: <20191030211652.GB326591@vader>
References: <20191029200942.83044-1-andrealmeid@collabora.com>
 <20191029200942.83044-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029200942.83044-2-andrealmeid@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 29, 2019 at 05:09:40PM -0300, André Almeida wrote:
> Add an option to be possible to use a different configuration file
> rather than the default "config" file.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  check | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/check b/check
> index 981058c..936b0c3 100755
> --- a/check
> +++ b/check
> @@ -635,6 +635,9 @@ Test runs:
>    -x, --exclude=TEST	 exclude a test (or test group) from the list of
>  			 tests to run
>  
> +  -c, --config=FILE	 use FILE for loading configuration instead of
> +			 default 'config' filename.
> +
>  Miscellaneous:
>    -h, --help             display this help message and exit"
>  
> @@ -650,7 +653,7 @@ Miscellaneous:
>  	esac
>  }
>  
> -if ! TEMP=$(getopt -o 'do:q::x:h' --long 'quick::,exclude:,output:,help' -n "$0" -- "$@"); then
> +if ! TEMP=$(getopt -o 'do:q::x:c:h' --long 'quick::,exclude:,output:,config:,help' -n "$0" -- "$@"); then
>  	exit 1
>  fi
>  
> @@ -659,10 +662,8 @@ unset TEMP
>  
>  LOGGER_PROG="$(type -P logger)" || LOGGER_PROG=true
>  
> -if [[ -r config ]]; then
> -	# shellcheck disable=SC1091
> -	. config
> -fi
> +# true if the default configuration file "config" should be used
> +DEFAULT_CONFIG=true
>  
>  # Default configuration.
>  : "${DEVICE_ONLY:=0}"
> @@ -706,6 +707,17 @@ while true; do
>  			EXCLUDE+=("$2")
>  			shift 2
>  			;;
> +		'-c'|'--config')
> +			if [[ -r "$2" ]]; then
> +				# shellcheck source=/dev/null
> +				. "$2"
> +				DEFAULT_CONFIG=false
> +			else
> +				echo "Configuration file $2 not found!"
> +				usage err
> +			fi
> +			shift 2
> +			;;

If the user specifies -c multiple times, it will source each one, not
just the last one. Is that intentional? That might actually be a useful
feature, but we'd want to document it.

>  		'-h'|'--help')
>  			usage out
>  			;;
> @@ -719,6 +731,13 @@ while true; do
>  	esac
>  done
>  
> +# if '-c' was not used, try to use the default config file
> +if [[ -r config ]] && $DEFAULT_CONFIG; then
> +	# shellcheck source=/dev/null
> +	. config
> +fi
> +
> +
>  if [[ $QUICK_RUN -ne 0 && ! "${TIMEOUT:-}" ]]; then
>  	_error "QUICK_RUN specified without TIMEOUT"
>  fi
> -- 
> 2.23.0
> 
