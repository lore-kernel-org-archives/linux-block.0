Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62813C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3267C2133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+FB6nQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeLQRYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:24:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33788 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeLQRYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 12:24:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so5238096wmh.0;
        Mon, 17 Dec 2018 09:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7LX8zkJ55ucDSuOlduiKG9DRTub6ofiKcrVx45LdZZA=;
        b=f+FB6nQbgVHJRUo06ueF+3puLuoN2e/pBiqEiizsMZxq5QH0gMc9st25ZF7VxmUsUO
         UU1VQX2NSMnxfQwxBR4LLEUVvEeuxXK/9B8rxuzav0N15+7MFF2e5ZNVbVzJs78zkx6/
         CuEF252kLfdctMzMXIC35T/6VQveK/ZQY9Vm8zy5AbfRtYIyYWG9BNtABYlRuGEOeo5W
         pha/VAjVGKw2dvwAneBbvRh5OxsuSO4u48pIp6vwo10hkSH7mmZQRuNtbcfVVvEBmkjW
         RRB5L3lMy4VV7XywRMNuh6NMgyczgrLuoAbBm80LpJ8mu8nwQaXetPvoawruqCVfrsLk
         9ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7LX8zkJ55ucDSuOlduiKG9DRTub6ofiKcrVx45LdZZA=;
        b=ka2rv0hVzyNV3G6+pEScYSSXGiK+pqbN4p++eGUE+RzPRDQPlIlQYjwbcM2TAVMgzF
         05x9JwS1Hia+Ujs42Y+zdpLjihyoW1Xj+JxGWpG0A23DWjZwRYSDkE4nCWyW/tVjnIh4
         p0X5tZrXtoC+Sfo2ChKXQ8a2Zj3c2ihK135EAcQ6A3Oc9QdiJzA4yG/KH9Wxn6bGoX1m
         e9TlkDRwFlXShf3N4WwVUuojQR0Dg09nAFALyGmuV6vgDESmgdUfXMWx+gJ4G7WWzzS1
         dsONmwNR1Yjr9RVVJHLqNNjmVGFA5PTltBDTL5NCzSVTNiEl56G5H4NwUfk8bRYzRFsW
         WdpA==
X-Gm-Message-State: AA+aEWbe/Kj9388cEFkxZwbPoIQEUrGwZbqv+kUMvccZvXUioEDedQxN
        yhgy8/06i8HfVxA4HK1Uzkw=
X-Google-Smtp-Source: AFSGD/USouePAPffhJ4eFfUEMz7SWiCzOaJoRPIFPRvssk+vIjL4l/jD714xkXSrqRan2Ctc2a4Dfw==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr12708174wma.85.1545067443531;
        Mon, 17 Dec 2018 09:24:03 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a12sm1098379wro.18.2018.12.17.09.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:24:02 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:24:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] drbd: Avoid Clang warning about pointless switch
 statment
Message-ID: <20181217172401.GA30635@flashbox>
References: <20181002171447.10765-1-natechancellor@gmail.com>
 <20181004200912.32348-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004200912.32348-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 04, 2018 at 01:09:13PM -0700, Nathan Chancellor wrote:
> There are several warnings from Clang about no case statement matching
> the constant 0:
> 
> In file included from drivers/block/drbd/drbd_receiver.c:48:
> In file included from drivers/block/drbd/drbd_int.h:48:
> In file included from ./include/linux/drbd_genl_api.h:54:
> In file included from ./include/linux/genl_magic_struct.h:236:
> ./include/linux/drbd_genl.h:321:1: warning: no case matching constant
> switch condition '0'
> GENL_struct(DRBD_NLA_HELPER, 24, drbd_helper_info,
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/genl_magic_struct.h:220:10: note: expanded from macro
> 'GENL_struct'
>         switch (0) {
>                 ^
> 
> Silence this warning by adding a 'case 0:' statement. Additionally,
> adjust the alignment of the statements in the ct_assert_unique macro to
> avoid a checkpatch warning.
> 
> This solution was originally sent by Arnd Bergmann with a default case
> statement: https://lore.kernel.org/patchwork/patch/756723/
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/43
> Suggested-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Since this is not the same as Arnd's patch, I took authorship for it
> while leaving a link to the original patch in the commit message. If
> this is not how it should have been done, please let me know.
> 
>  include/linux/genl_magic_struct.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
> index 5972e4969197..eeae59d3ceb7 100644
> --- a/include/linux/genl_magic_struct.h
> +++ b/include/linux/genl_magic_struct.h
> @@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
>  {
>  	switch (0) {
>  #include GENL_MAGIC_INCLUDE_FILE
> +	case 0:
>  		;
>  	}
>  }
> @@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
>  {
>  	switch (0) {
>  #include GENL_MAGIC_INCLUDE_FILE
> +	case 0:
>  		;
>  	}
>  }
> @@ -218,7 +220,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
>  static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
>  {									\
>  	switch (0) {							\
> -		s_fields						\
> +	s_fields							\
> +	case 0:								\
>  			;						\
>  	}								\
>  }
> -- 
> 2.19.0
> 

Hi Lars and Philipp,

Could you please make sure that this patch and the other one I sent make
it into 4.21/5.0? I am not sure when you were planning on sending the
pull request to Jens that you mentioned in the other thread but I've
noticed most maintainers typically send their requests for the impending
merge window around -rc7 or so and I wanted to make sure it was on your
radar.

Thank you,
Nathan
