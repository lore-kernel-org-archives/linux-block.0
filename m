Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F93DC77B61
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 16:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjEAQiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjEAQiU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 12:38:20 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41910D1
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 09:38:10 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1a6762fd23cso21996715ad.3
        for <linux-block@vger.kernel.org>; Mon, 01 May 2023 09:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959090; x=1685551090;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gvDwSskIrgGYH9XtUvqkKfmxbJ3M2d9b3BcMuOD1CE=;
        b=PbslFtULy2mJp/sYS3kXEJmaMTnpfnDTU7qEe1uD1i8wW/wZtsQjunhhABB5ZrKZ6x
         fmM2uVOQGnc1qM+VHl4/Z0GrvP7FI+p3oc3S5zeAwvCdtshHrtYIVOS1N+k6LC8fXSs4
         tRskYP62EkHCQYD2AWmtNRiBC6RlRR+cTi/b0K6CfGv8hYCHxeu7eiaRfUgOEVwAL5Rc
         xxLw6aApBNwRrjopsLmKtcOAJX1iJ8LBIfl57XTKBq4weV/BSGHuyOBh0+L+CgGL9jWz
         YRVa+DnRXaO+MWABcBTqSQ1CP4dKltKsXDYjDdfngTPPcvI83jECj/HzaXKWdZxfRX92
         WBsw==
X-Gm-Message-State: AC+VfDznosrvtCMy6MKJY4Cjg/UdNcBJmMiIDIpQ6Zdtd8QOUSOc++Rp
        2ifPDygO0nj5m7xZOamwOOKbmWFqlwg=
X-Google-Smtp-Source: ACHHUZ4KMKazWk2BOvnSSkTg98M3TDMBDLUBySoq/GUE0j9i4itb8ZQg6TWVMQthBFZgUm5v2zaexA==
X-Received: by 2002:a17:902:f54d:b0:1a1:e01e:7279 with SMTP id h13-20020a170902f54d00b001a1e01e7279mr16795909plf.4.1682959090290;
        Mon, 01 May 2023 09:38:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:eba5:79b2:92dd:67e? ([2620:15c:211:201:eba5:79b2:92dd:67e])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902868d00b001a221d14179sm18033074plo.302.2023.05.01.09.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 09:38:09 -0700 (PDT)
Message-ID: <a8064311-1e5a-936f-8517-e84a23a8876e@acm.org>
Date:   Mon, 1 May 2023 09:38:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH blktests] common/rc: fix kernel version parse failure
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
References: <20230501041415.49939-1-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230501041415.49939-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/23 21:14, Shin'ichiro Kawasaki wrote:
> When kernel version numbers have postfix letters, _have_fio_ver fail to
> parse the version. For example, uname -r returns "6.3.0+", it handles
> "0+" as a number and fails to parse. Fix it by dropping all letters
> other than numbers or period.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   common/rc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index af4c0b1..525867c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -207,7 +207,7 @@ _have_kernel_option() {
>   _have_kver() {
>   	local d=$1 e=$2 f=$3
>   
> -	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//')
> +	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//' | sed 's/[^.0-9]//')
>   	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
>   	then
>   		SKIP_REASONS+=("Kernel version too old")

Please combine the two sed statements into a single sed statement, e.g. as
follows:

sed 's/-.*//;s/[^.0-9]//'

Thanks,

Bart.
