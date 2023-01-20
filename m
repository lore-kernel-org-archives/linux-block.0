Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EA9C004D4
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 02:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjATCHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Jan 2023 21:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATCHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 21:07:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E5FA5780;
        Thu, 19 Jan 2023 18:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7067E61DD6;
        Fri, 20 Jan 2023 02:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFE0C433EF;
        Fri, 20 Jan 2023 02:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674180449;
        bh=OHBGrZDS9hYZ63xAQOgXs0txuOMdKJTNhNwlzli36zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTPbThVNWK36wc5fhugZEj3dN20uYbPQj7oqWbo6/3N4Wh9OTpkOzpwwagGM5hhqT
         y1jpadu4XfDN6XdaT32gg2VOfKiGc72rVYCs/Dnm/Cn/xQXAWQvf+Vzk21kjNJap2S
         9S2DtiE6g+su/ecIxt3OTgJ4uyf33uSugwspf4LnqLM3YZ3BAftC/nQKyQQwhBoKaX
         b8i3BvbW2Fxv5yx8LyH9aETnnM+qjFOdEyh8niCknK0sH6Oh+GqEKaHTUpQGpb4GWb
         bVXlsfQilxFgQFsuRvRuLZ4ICfxPb4myQ0vCEXmQCJSA0XP1PjwFTb0Zg4IDvziXTn
         2hOBDN5P980OA==
Date:   Thu, 19 Jan 2023 18:07:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
        jack@suse.cz, bingjingc@synology.com, james.smart@broadcom.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH-next v3] lib: parser: optimize match_NUMER apis to use
 local array
Message-ID: <Y8n3Xxh+Rqo9vWHx@sol.localdomain>
References: <20230120021304.5773-1-lilingfeng3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120021304.5773-1-lilingfeng3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 20, 2023 at 10:13:04AM +0800, Li Lingfeng wrote:
> [PATCH-next v3] lib: parser: optimize match_NUMER apis to use

NUMER => NUMBER

> Memory will be allocated to store substring_t in match_strdup(), which means
> the caller of match_strdup() may need to be scheduled out to wait for reclaiming
> memory.

Text in commit messages should be wrapped at 72 columns.

> @@ -163,18 +169,16 @@ static int match_number(substring_t *s, int *result, int base)
>   */
>  static int match_u64int(substring_t *s, u64 *result, int base)
>  {
> -	char *buf;
> +	char buf[NUMBER_BUF_LEN];
>  	int ret;
>  	u64 val;
>  
> -	buf = match_strdup(s);
> -	if (!buf)
> -		return -ENOMEM;
> -
> +	if ((s->to - s->from) >= NUMBER_BUF_LEN)
> +		return -ERANGE;
> +	match_strlcpy(buf, s, NUMBER_BUF_LEN);

As I requested on v2, the return value of match_strlcpy() should be used instead
of checking '((s->to - s->from) >= NUMBER_BUF_LEN'.

- Eric
