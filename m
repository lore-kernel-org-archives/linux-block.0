Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A1C001DB
	for <linux-block@archiver.kernel.org>; Mon, 14 Aug 2023 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjHNWf4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjHNWf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 18:35:29 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21085AB
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 15:35:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bca38a6618so4126620a34.3
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692052525; x=1692657325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwuEu0xxi7OZsGP6XW4kyOjFX1tqVyQHr5J1ijQXBHo=;
        b=dnpMWlXn52CsR46o8+LiEBq84JS767gRkP4oUSg7RZEswizaMNAt8fmkhwGgFIYo6/
         IPE1WkbepkHVm+hkiXtpMM8JtfvgcGLaIjxfxgpFHysWB4yshs40MWwKbZqGBX+79iNx
         RUdIOdHfD6PEC/6oaEdKqpWPBIs9ZCJE5z9h/9zP7xvWkLcwKNsH6kTURsem/sup2PP3
         gw9Z+8AJCV7xSddm5sbvmm6N0Qp24PCXCEKANPiznwYS3ANHpTykYXv+kRWlcu6/ly8t
         Gqm4L5wZ5nJoXbAu8FYGsQBvil3bdMXgDAq8MrvPXgGpA2j2/5JixHAjzCINqrYWACLY
         izKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052525; x=1692657325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwuEu0xxi7OZsGP6XW4kyOjFX1tqVyQHr5J1ijQXBHo=;
        b=c9kup+SMScSaJJPENkdzIKzM+nQo7TisSGOPUXReCyYe6ZNCOu4G8+oIct3xV3oUcq
         MfXqP7cFM/Gt/dEln+P6NtOWCP64G+zIg8VTNtHEfuNCV4ggeQFSpvz9xO2qnlEXDTxQ
         ojGRtec+9Jk0H2I27OgMZg1TivSGTZDlHNK9uFyyAP22kHihYUD8FcvDBETZ5p9grmsm
         SGRcInRJ2NQmkVqlclhrtcwVcTVv4e05gOn3eTXvRPsBaVMX804bR1ir7XMy2kwK3vwN
         ufUhwSweSUX1DYpLcGRZL6PGl2aKmn007BNVv/OaRlOFa178SZWb/T1JLO2VOAtjgmO5
         seWg==
X-Gm-Message-State: AOJu0YwdL17bsl6dJ4G7D87/aYH1j4GT25XCzy1tSIDiujaHavXEAAwf
        eXX6D4TGRuYn6rxgEaOH0q0YOQ==
X-Google-Smtp-Source: AGHT+IGUE4R7KKIE5B/8KlZ0Zsw1jLNTJkjgBJaaLUPvMTWiDYX38RRIL1HqodO8poqzVc47tQ/FpA==
X-Received: by 2002:a05:6830:1bc3:b0:6bc:8b5f:b616 with SMTP id v3-20020a0568301bc300b006bc8b5fb616mr8869520ota.38.1692052525312;
        Mon, 14 Aug 2023 15:35:25 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:5450:abd2:849f:72ce])
        by smtp.gmail.com with ESMTPSA id k19-20020aa790d3000000b00682bec0b680sm8370978pfk.89.2023.08.14.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 15:35:24 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:35:19 -0700
From:   Igor Pylypiv <ipylypiv@google.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: uapi: Fix compilation errors using ioprio.h with
 C++
Message-ID: <ZNqsJ5KkUwl8XsqG@google.com>
References: <20230814215833.259286-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814215833.259286-1-dlemoal@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 15, 2023 at 06:58:32AM +0900, Damien Le Moal wrote:
> The use of the "class" argument name in the ioprio_value() inline
> function in include/uapi/linux/ioprio.h confuses C++ compilers
> resulting in compilation errors such as:
> 
> /usr/include/linux/ioprio.h:110:43: error: expected primary-expression before ‘int’
>   110 | static __always_inline __u16 ioprio_value(int class, int level, int hint)
>       |                                           ^~~
> 
> for user C++ programs including linux/ioprio.h.
> 
> Avoid these errors by renaming the arguments of the ioprio_value()
> function to prioclass, priolevel and priohint. For consistency, the
> arguments of the IOPRIO_PRIO_VALUE() and IOPRIO_PRIO_VALUE_HINT() macros
> are also renamed in the same manner.
> 
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
> Fixes: 01584c1e2337 ("scsi: block: Improve ioprio value validity checks")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Tested-by: Igor Pylypiv <ipylypiv@google.com>

Thanks!
> ---
>  include/uapi/linux/ioprio.h | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index 99440b2e8c35..bee2bdb0eedb 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -107,20 +107,21 @@ enum {
>  /*
>   * Return an I/O priority value based on a class, a level and a hint.
>   */
> -static __always_inline __u16 ioprio_value(int class, int level, int hint)
> +static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
> +					  int priohint)
>  {
> -	if (IOPRIO_BAD_VALUE(class, IOPRIO_NR_CLASSES) ||
> -	    IOPRIO_BAD_VALUE(level, IOPRIO_NR_LEVELS) ||
> -	    IOPRIO_BAD_VALUE(hint, IOPRIO_NR_HINTS))
> +	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> +	    IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> +	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
>  		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
>  
> -	return (class << IOPRIO_CLASS_SHIFT) |
> -		(hint << IOPRIO_HINT_SHIFT) | level;
> +	return (prioclass << IOPRIO_CLASS_SHIFT) |
> +		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
>  }
>  
> -#define IOPRIO_PRIO_VALUE(class, level)			\
> -	ioprio_value(class, level, IOPRIO_HINT_NONE)
> -#define IOPRIO_PRIO_VALUE_HINT(class, level, hint)	\
> -	ioprio_value(class, level, hint)
> +#define IOPRIO_PRIO_VALUE(prioclass, priolevel)			\
> +	ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
> +#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)	\
> +	ioprio_value(prioclass, priolevel, priohint)
>  
>  #endif /* _UAPI_LINUX_IOPRIO_H */
> -- 
> 2.41.0
> 
