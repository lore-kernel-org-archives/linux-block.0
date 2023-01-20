Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A89C46467
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 06:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjATGfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 01:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjATGe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 01:34:59 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 22:34:54 PST
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3D99677A0
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 22:34:54 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id IkrwpGI0xDtWxIkrwpMJwz; Fri, 20 Jan 2023 07:27:22 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 20 Jan 2023 07:27:22 +0100
X-ME-IP: 86.243.2.178
Message-ID: <ea8f4717-5c23-83fa-7d14-4786d6bc4d77@wanadoo.fr>
Date:   Fri, 20 Jan 2023 07:27:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] block/rnbd-clt: fix wrong max ID in ida_alloc_max
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     error27@gmail.com, linux-block@vger.kernel.org
References: <20221229113501.16612-1-guoqing.jiang@linux.dev>
Content-Language: fr, en-US
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221229113501.16612-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Le 29/12/2022 à 12:35, Guoqing Jiang a écrit :
> We need to pass 'end - 1' to ida_alloc_max after switch from
> ida_simple_get to ida_alloc_max.
>
> And smatch warns.
>
> drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
>
> Fixes: 24afc15dbe21 ("block/rnbd: Remove a useless mutex")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---

Hi,

now in -next.

It triggered my "what is in my backlog and now applied in -next".
The reason is [1].

It was Ack-b, but never applied.

So I made my mistake, but tried to fix it :).

Honor is safe, (even if my Fixes tag was wrong), LoL !

CJ


[1]: 
https://lore.kernel.org/all/42165d3f9dfc7abb54542d34a4e33ea8e83b101c.1648379172.git.christophe.jaillet@wanadoo.fr/


>   drivers/block/rnbd/rnbd-clt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 78334da74d8b..8cdecec89d74 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1440,7 +1440,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>   		goto out_alloc;
>   	}
>   
> -	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
> +	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS) - 1,
>   			    GFP_KERNEL);
>   	if (ret < 0) {
>   		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
