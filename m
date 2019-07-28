Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1819BC7618B
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EFF2075E
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0T69VKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfG1GLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:11:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38367 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG1GLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 02:11:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so26244298plb.5
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jTx7Y/r/xG8c10+KnesD9oqg8PyfoMKPyvB2yptpYzE=;
        b=T0T69VKgrDowa6QK8xrQHhqH6KeTkaUkizdDF/ms7hr//sLK+ImJhjrcXajgXckzkw
         /RL3y5nyZ8ex+Eq5l7xq/RCPG8Uv2XKcMYNU/F6RUP/dq1rXBOL8zFotO8wWxPzburW7
         Ez7Yhgy/2QG1Sqb82wI9c22dFFMkYeTwt7u4IQprqqzrA9diL+WZtn3/3+KrB/q4OJOn
         lc29MFqx+WSbki+89v3KbhBr2Y+AS2K9GRPCLyHSzG0AV0630VJtGt4QAbK8l0XpYkfM
         BtlhxeVy2YA48afMvwpH2JVVhU4RMsVcKzoaii3JnyZkOVXVONNXwxaIp9cPdc9on1Hi
         /1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTx7Y/r/xG8c10+KnesD9oqg8PyfoMKPyvB2yptpYzE=;
        b=A8EUYZsr65FI2XgCiOqky7v/sKBvlBC0kazkS82KW4hkjq2tFV7+KNqVNGmKHKCT9f
         8CGDcMiOHPbrb2joaDssp9kjHUGvFW2szrUbpsqzLbwF3l+RIzVrpFKkn2WItgqvND+b
         CEFGtDBjcOvuZz4Y6hHBO3y6qbiGy8CKLSXREiuSXs/FU2XU0pWMrdE4vceTsO6aT20C
         VhefuBEoBeRqVN7qVqLlMC/HF9dSX/z6ZaVsJI+DGpjgW7VRB7zty+dIpuS9FEq1ZRlC
         DxFoSSgKd/oti2Sjf+JTmvd3N6MImLG6Gr8h96rsZsG3zdkJyXAyfYj6JjPIsfzaccuR
         8MNQ==
X-Gm-Message-State: APjAAAWgFMV3/VTJAoQzB88DtXy1OSTId4e6QuWD0BQtOjkruwH/ZpCs
        ngiXeHTm1tO9xInIzZOkVzU=
X-Google-Smtp-Source: APXvYqxjwHRG1iYcfx8/vKM+071A5gkQB6KCiyO+DIYXwp1+0rcNtBrYygx1f2ad4KOtQPSWNljKMg==
X-Received: by 2002:a17:902:f087:: with SMTP id go7mr103757790plb.330.1564294275577;
        Sat, 27 Jul 2019 23:11:15 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id s5sm36465268pfm.97.2019.07.27.23.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 23:11:14 -0700 (PDT)
Date:   Sun, 28 Jul 2019 15:11:12 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 4/8] null_blk: allow memory-backed write-zeroes-req
Message-ID: <20190728061112.GF24390@minwoo-desktop>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
 <20190711175328.16430-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711175328.16430-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-11 10:53:24, Chaitanya Kulkarni wrote:
> This patch adds support for memory backed REQ_OP_WRITE_ZEROES
> operations for the null_blk request mode. We introduce two new
> functions where we zeroout the sector(s) using memset which are part
> of the payloadless write-zeroes request.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/block/null_blk_main.c | 45 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 65da7c2d93b9..fca011a05277 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -725,6 +725,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
>  	}
>  }
>  
> +static void null_zero_sector(struct nullb_device *d, sector_t sect,
> +			     sector_t nr_sects, bool cache)
> +{
> +	struct radix_tree_root *root = cache ? &d->cache : &d->data;
> +	struct nullb_page *t_page;
> +	unsigned int offset;
> +	void *dest;
> +
> +	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
> +	if (!t_page)
> +		return;
> +
> +	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
> +	dest = kmap_atomic(t_page->page);
> +	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
> +	kunmap_atomic(dest);
> +}
> +
>  static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
>  	struct nullb_page *t_page, bool is_cache)
>  {
> @@ -1026,6 +1044,25 @@ static void null_handle_discard(struct nullb *nullb, sector_t sector, size_t n)
>  	spin_unlock_irq(&nullb->lock);
>  }
>  
> +static void null_handle_write_zeroes(struct nullb *nullb, sector_t sector,
> +				     unsigned int bytes_left)
> +{
> +	sector_t nr_sectors;
> +	size_t curr_bytes;
> +
> +	spin_lock_irq(&nullb->lock);
> +	while (bytes_left > 0) {

Hi Chaitanya,

Thanks for your support for this!

I have a simple query here.  Is there any recommended rule about using
the function argument to be changed inside of that function like
_bytes_left_?  I'm not against it, but I'd like to know if it's okay to
decrement inside of this function in code-style point-of-view.

Thanks!
