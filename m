Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B72C00140
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 20:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbiHRUIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345656AbiHRUHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 16:07:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E38D31D0
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 13:02:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w14so2381071plp.9
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dRbRKHviGp/b7CwYVDBVCa/DsxyS1q3SURr6YJnN5E8=;
        b=H8HJei8UInhN7JB9q2x14lOKy254AUjnRL+zOrUFV8kJn61l/wK+lLUMacQg4Hrv7g
         20Ill8co78+dzWWzeNxGl8qe/rDdcIy9yGfEIxGWdbdzwY2+Otz/hOaQNKzp/+HKqILK
         onC+4gkLwGoMIbRkNrauLjgv65LZGVTBWYq1rFObCts87Nk5XquQ7RA/lzY/0gvS6OIF
         tWr0uOMmjP8pGXAlbW8blDnAL46EyST3eVGmym55LeXXOdWYX8vwuwO4yiZeyk1b2mOu
         aOvzKuZ4evYiamg0RbpCGi37MQBQHSWKoMT6X2bzt1w52CWNO7BO08BFE4nfYrOacQSD
         i1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dRbRKHviGp/b7CwYVDBVCa/DsxyS1q3SURr6YJnN5E8=;
        b=Eyc5XudkQnw0JCOqmW4FCOzawOkI2rwd8VnlG5zagm1ntcA2Qz/nafkthd1R5JhnAv
         5w0p5BudA+UnO7zYsgZq/7+1G3LsAi/aD9VL3UP3qL/iM+YaM7AY0Giv3KhGuCnUs3DE
         ARKGGdro9/hef2zZEsYX5Tu7fcIHfVlz/BrGqM07VQ1THhObb3Fn+kBwATLvDTS9VJaX
         rQQqMqyMmh9eXozFD9kZqBzpmVAJUGF2dedknxFJ2ZIjYd3pgjTEq9jDG0HK3RvZXRr3
         25LDyNmyXyQ1fuzuNG708CpouEUab8s7QxDXMcRHYrizTbIE2Y/YcV31uDprowsIFmHE
         U+kw==
X-Gm-Message-State: ACgBeo2ik+o8SZStRXkqGnYg9K5JoArBWSuN7ftRUXtV5a4zJIiA6B7B
        GbuZAYHjxFI/SMU4E6VAHPES9jDhrzk=
X-Google-Smtp-Source: AA6agR4mJyk/dxKAS2p7LMwSDIrWs7wPB9Qi413Dv0gSukYuoX+n5fAs4eyMdVTtUmlLd/XFYvG/qQ==
X-Received: by 2002:a17:90b:1943:b0:1f7:b63e:60db with SMTP id nk3-20020a17090b194300b001f7b63e60dbmr10344805pjb.241.1660852932761;
        Thu, 18 Aug 2022 13:02:12 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902a51700b0016909be39e5sm1740417plq.177.2022.08.18.13.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 13:02:11 -0700 (PDT)
Message-ID: <e17212c6-d7dc-514e-e51d-ac818863a80c@gmail.com>
Date:   Thu, 18 Aug 2022 13:02:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests v2 1/6] common/rc: avoid module load in
 _have_driver()
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-2-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20220818012624.71544-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
> The helper function _have_driver() checks availability of the specified
> driver, or module, regardless whether it is loadable or not. When the
> driver is loadable, it loads the module for checking, but does not
> unload it. This makes following test cases fail.
> 
> Such failure happens when nvmeof-mp test group is executed after nvme
> test group with tcp transport. _have_driver() for tcp transport loads
> nvmet and nvmet-tcp modules. nvmeof-mp test group tries to unload the
> nvmet module but it fails because of dependency to the nvmet-tcp module.
> 
> To avoid the failure, do not load module in _have_driver() using -n
> dry run option of the modprobe command. While at it, fix a minor problem
> of modname '-' replacement. Currently, only the first '-' in modname is
> replaced with '_'. Replace all '-'s.
> 
> Fixes: e9645877fbf0 ("common: add a helper if a driver is available")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   common/rc | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 01df6fa..8150fee 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -30,9 +30,10 @@ _have_root() {
>   
>   _have_driver()
>   {
> -	local modname="${1/-/_}"
> +	local modname="${1//-/_}"
>   
> -	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; then
> +	if [[ ! -d "/sys/module/${modname}" ]] &&
> +		   ! modprobe -qn "${modname}"; then
>   		SKIP_REASONS+=("driver ${modname} is not available")
>   		return 1
>   	fi

There are two (unrelated?) changes in this patch but only one change has 
been explained in the patch description :-(

Bart.
