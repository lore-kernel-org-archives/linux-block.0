Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28ECC433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Apr 2022 04:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiDPEDj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Apr 2022 00:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiDPEDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Apr 2022 00:03:38 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFED6EB2E
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 21:01:06 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id ll10so8926607pjb.5
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 21:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y49V9VHQz/nF4aVhY2YnAmSiohT5VAchK0Uuz6JK1v8=;
        b=r7M+60bfJ0NmVELR1UCX/0Pwh4ff1V2sV32FryhOpyAS+t8N3svSFPfa6tsoAXeRI9
         7X+83iYBUUXOJtYN+P8ohU08RkfU+isy8KVypgrRmVbn7t5SubFOkQPVkRX43xDehS8t
         gSzBNwNddfjgYsgNP3k+0sjpL4xtJnFC7ejT64hg/Ir+WdVdSeIAE0hHc4USpgVFE6Ha
         AyE4wFbYLRUuAFjVDpmIjXDPxLnARGlUb8m72pMck98aPVgKjZo30UQ8jRw8Vs6uAHXb
         Co+CORe7wPIBsQm1F7+IAJ2K7h8na2pgbJfVJcRPbDWSluA1cVvCiJ1/rLdMq7kqRa9K
         t6kw==
X-Gm-Message-State: AOAM5310x/v8dD6wEALM6DIlgQ1pcmtH0a9/4AHY8uB6v8qP11ulcSTz
        jFhHr6Zs5F0TupgAe8grWn8JCQ08fIY=
X-Google-Smtp-Source: ABdhPJy9oABTCxVrEvqaaOsITBGHgbPB5SULkO94ZAGV1U0kN4C8AOZbrjnXoRsGsniXv/B6/D20iA==
X-Received: by 2002:a17:902:d511:b0:158:e2ff:8e4b with SMTP id b17-20020a170902d51100b00158e2ff8e4bmr1796600plg.77.1650081665868;
        Fri, 15 Apr 2022 21:01:05 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm10025804pjd.54.2022.04.15.21.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 21:01:04 -0700 (PDT)
Message-ID: <c584cf40-2181-2617-92aa-bcdbc56a5ab8@acm.org>
Date:   Fri, 15 Apr 2022 21:01:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] blktests: replace module removal with patient module
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, osandov@fb.com
Cc:     linux-block@vger.kernel.org
References: <YlogluONIoc1VTCI@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YlogluONIoc1VTCI@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/22 18:49, Luis Chamberlain wrote:
> -	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
> -		return 1
> -	fi
> +	_patient_rmmod null_blk || return 1
> +	modprobe null_blk "$@" "${zoned}" || 1

"1" is not a valid command. Should "|| 1" perhaps be changed into "|| 
return 1"?

> +_has_modprobe_patient()
> +{
> +	modprobe --help >& /dev/null || return 1
> +	modprobe --help | grep -q -1 "remove-patiently" || return 1
> +	return 0
> +}

I can't find the meaning of "-1" in the grep man page. Did I perhaps 
overlook something?

> +# checks the refcount and returns 0 if we can safely remove the module. rmmod
> +# does this check for us, but we can use this to also iterate checking for this
> +# refcount before we even try to remove the module. This is useful when using
> +# debug test modules which take a while to quiesce.
> +_patient_rmmod_check_refcnt()
> +{
> +	local module=$1
> +	local refcnt=0
> +
> +	if [[ -f "/sys/module/$module/refcnt" ]]; then
> +		refcnt=$(cat "/sys/module/$module/refcnt" 2>/dev/null)
> +		if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
> +			return 0
> +		fi
> +		return 1
> +	fi
> +	return 0
> +}

Hmm ... why is the check for existence of the refcnt separate from 
reading the refcnt? I think that just reading the refcnt should be 
sufficient. Additionally, that will avoid the race where the module is 
unloaded after the check and before the refcnt is read.

> -	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
> -	if [[ "${nvme_trtype}" != "loop" ]]; then
> -		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
> -	fi
> -	modprobe -r nvmet 2>/dev/null
> +	if [[ "${nvme_trtype}" == "loop" ]]; then
> +		_patient_rmmod nvme_"${nvme_trtype}"
> +        else
> +                _patient_rmmod nvme-"${nvme_trtype}"
> +                _patient_rmmod nvmet-"${nvme_trtype}"
> +        fi
> +	_patient_rmmod nvmet 2>/dev/null

The statement _patient_rmmod nvme-"${nvme_trtype}" occurs twice in the 
above code. How about preserving the structure of the existing code such 
that that statement only occurs once?

>   # Unload the SRP initiator driver.
>   stop_srp_ini() {
> -	local i
> -
>   	log_out
> -	for ((i=40;i>=0;i--)); do
> -		remove_mpath_devs || return $?
> -		unload_module ib_srp >/dev/null 2>&1 && break
> -		sleep 1
> -	done
> -	if [ -e /sys/module/ib_srp ]; then
> -		echo "Error: unloading kernel module ib_srp failed"
> -		return 1
> -	fi
> -	unload_module scsi_transport_srp || return $?
> +	remove_mpath_devs || return $?
> +	_patient_rmmod ib_srp || return 1
> +	_patient_rmmod scsi_transport_srp || return $?
>   }

Removing the loop from around remove_mpath_devs is wrong. It is 
important that that loop is preserved.

Thanks,

Bart.
