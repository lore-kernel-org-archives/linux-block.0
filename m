Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC4C63797
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 13:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAQNkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjAQNkT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 08:40:19 -0500
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 05:40:18 PST
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6A57ABC
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 05:40:18 -0800 (PST)
Message-ID: <665d3904-1d46-cc17-fbc2-bc5ab269423f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673962256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3qghoH5dksUKHXTHbV97yWD8kZiHnnE/1XPA9H9Iec=;
        b=dNKNwofh2tH1N5henJqJdDSkcysUfKTzTb4PmkIPmWc9V+w5OgINFeY8n5jtBe7rr9v2q2
        r6I/8mzEEXrkZZOZHB+WYc2iJ1PQJHQ1lOWPZ7VPDEqf6x3EF5uD3KqoidA4SEQyEJlQUa
        90W66Vni+UbIiH5YSp6vb/lZ/lu0DWo=
Date:   Tue, 17 Jan 2023 21:30:43 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V2] block/rnbd-clt: fix wrong max ID in ida_alloc_max
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, haris.iqbal@ionos.com,
        christophe.jaillet@wanadoo.fr, jinpu.wang@ionos.com
References: <20221230010926.32243-1-guoqing.jiang@linux.dev>
Content-Language: en-US
In-Reply-To: <20221230010926.32243-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Could you pls merge this one?

Thanks,
Guoqing

On 12/30/22 09:09, Guoqing Jiang wrote:
> We need to pass 'end - 1' to ida_alloc_max after switch from
> ida_simple_get to ida_alloc_max.
>
> Otherwise smatch warns.
>
> drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
>
> Fixes: 24afc15dbe21 ("block/rnbd: Remove a useless mutex")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
> V2 changes:
> 1. add parentheses around ‘-’ per lkp
>
>   drivers/block/rnbd/rnbd-clt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 78334da74d8b..5eb8c7855970 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1440,7 +1440,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>   		goto out_alloc;
>   	}
>   
> -	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
> +	ret = ida_alloc_max(&index_ida, (1 << (MINORBITS - RNBD_PART_BITS)) - 1,
>   			    GFP_KERNEL);
>   	if (ret < 0) {
>   		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",

