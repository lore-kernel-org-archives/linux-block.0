Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:50258 "EHLO
        mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbcLPFB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2016 00:01:57 -0500
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 43CE1AC01F8
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2016 14:01:47 +0900 (JST)
Message-ID: <585374F0.6040407@jp.fujitsu.com>
Date: Fri, 16 Dec 2016 14:00:32 +0900
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-mm@kvack.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: avoid incorrect bdi_unregiter call
References: <584101D2.4090200@jp.fujitsu.com>
In-Reply-To: <584101D2.4090200@jp.fujitsu.com>
Content-Type: text/plain; charset="iso-2022-jp"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Could you add this patch for 4.10?

- Masayoshi Mizuma

On Fri, 2 Dec 2016 14:08:34 +0900 Masayoshi Mizuma wrote:
> bdi_unregister() should be called after bdi_register() is called,
> so we should check whether WB_registered flag is set.
> 
> For example of the situation, error path in device driver may call
> blk_cleanup_queue() before the driver calls bdi_register().
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>   mm/backing-dev.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 8fde443..f8b07d4 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -853,6 +853,9 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
>   
>   void bdi_unregister(struct backing_dev_info *bdi)
>   {
> +	if (!test_bit(WB_registered, &bdi->wb.state))
> +		return;
> +
>   	/* make sure nobody finds us on the bdi_list anymore */
>   	bdi_remove_from_list(bdi);
>   	wb_shutdown(&bdi->wb);
> 
