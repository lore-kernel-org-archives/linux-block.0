Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C936DC07E9D
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 17:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIZR7M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIZR6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 13:58:55 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C507287A
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 10:37:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id cs3FoyDRoC5LCcs3FoinIN; Mon, 26 Sep 2022 19:37:56 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 26 Sep 2022 19:37:56 +0200
X-ME-IP: 86.243.100.34
Message-ID: <4463371a-2b71-1153-7814-fdff59eb99cd@wanadoo.fr>
Date:   Mon, 26 Sep 2022 19:37:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] block/swim3: add __init annotation to module init
 func
Content-Language: fr
To:     ruanjinjie <ruanjinjie@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926092241.1191846-1-ruanjinjie@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220926092241.1191846-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Le 26/09/2022 à 11:22, ruanjinjie a écrit :
> Add missing __init annotation to module init func.
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>   drivers/block/swim3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
> index da811a7da03f..1f65d506fbc9 100644
> --- a/drivers/block/swim3.c
> +++ b/drivers/block/swim3.c
> @@ -1278,7 +1278,7 @@ static struct macio_driver swim3_driver =
>   };
>   
>   
> -int swim3_init(void)
> +int __init swim3_init(void)
>   {
>   	macio_register_driver(&swim3_driver);
>   	return 0;

Hi,

unrelated, but should there be a swim3_exit() to call 
macio_register_driver(), as already done in some other drivers using 
these functions?

CJ
