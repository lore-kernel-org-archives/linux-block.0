Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1579C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEE361029
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhHDJ7p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:59:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:46709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236659AbhHDJ7p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628071170;
        bh=HvECcGFGcJTAE2bHM41N+X3Cm759WthDQjyaOyT5cak=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=LH93GhB+5GNwtr8xe1XS4zsHhztFDQhnQaHrvkUZrUUWhhZ4Wo1C7L+bB/uvHxIod
         9g0MjREiR4DT7RZ8mPMdtWOISzPnxngGiscQNyN99fFFShTo9QYq0KRSorx9yWIeZL
         EYybRJZi8XRy5MOLHT9sP5T5cJXoRAdpmwvRYJqw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Valinor ([82.203.167.171]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpSb-1mn3Tn1suv-00gKab; Wed, 04
 Aug 2021 11:59:30 +0200
Date:   Wed, 4 Aug 2021 13:01:36 +0300
From:   Lauri Kasanen <cand@gmx.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] n64cart: fix the dma address in n64cart_do_bvec
Message-Id: <20210804130136.55f633eeb4522f844463159a@gmx.com>
In-Reply-To: <20210804094958.460298-1-hch@lst.de>
References: <20210804094958.460298-1-hch@lst.de>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dIngT9OU74F4K/raFxfjZqZIFlSezg4YGnos4SCY4Xafl7GCk3j
 EOU9SKS+SjUDXcBtjOOO0xJCqKbs8ipFI5CC5jJ3Cm/YFBztps7vK5+yEY3tND36c2iujhS
 VJhdJ+O2RoFMwNSrwZ/zyYFDrV9s3HB2P4SQg/gZfoq0heVHhI/reXrrTPWhcWG/itgiSFz
 J2dyQJOQg8FE2wlyGZr7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ymQh6oyFhtk=:+UxAhYL/Xu3bdLX+zIeF5r
 5iUunfgytZR2RGXLX91qlaTr6zVkeHgxffLxwxM0mOZ9bpMwZu1TF4jDVNH+WSoTM8E9UPJkv
 4azca0mNbhpmcJ1/VFVISr+/nNkM+HhADOxG7ZxgI2+ukpM6Z7RmwwGZjMWPKfzpP9IZsabbd
 kW/J6aGn8wqGRzvi/E/XagShIGvWBV6OsHz95/0J97eFtyrskth8aUE1FC7ojNALpmp+2f1qP
 3vwfnEPd2t3R/1V/FUsMuI1HZ6Xm4Bc9mTRGlihUrMrUxz7MnlD6D0V2jdmfA58rzc4TySzUS
 mJi8LQsksQbtkyyfudBCt9ax3Fj3gQXDLE6KGdc9UiWoMPCswxsl+H9aFJb6xtKVUHEQF2A7q
 3ljHuPVX88y0MvCLSyAwdYrprxp+yjkrc2pLAI/jtBNsnfY00W3oitCHqDIbML969evfKUPFz
 3JfXjCHtkHDOzCT4I4xbrx5ifwasMOX8qOgNer+IJ4FlfGPEnl7wLN1drRv47Nh2n+DsO7F+M
 7gybi9ggnT0bga8PCYv7IPLSVnUToelR7Zz/41lbfeSugPYep2XrEzhRwqVU+L+wQginxQHFe
 Enq4TSBMEqRYdXJtKo6IVm0FfGxuBlgHDAgIgs/e7+jb6tjNBP+TCChaOQ76iU+H93lwQ6jai
 C6xaF45InFIVdx6DVDc2AL1scnnxIm97RfqqR9xr/+7pRcQxClDrFhhJillVPF1O63+u1DV05
 WX1eRNnf937Ox9E+raIosEXGiyF2YSJ7vAwRqkALDfvfwX912Li2Nit2WkF2SavDbGCsa12pJ
 pginbMAz1BtI+Dd+Me38DnK4PjOimeifvk5pGUV8vaejra2uSW91zF+0RWmDVXOIbRtFAIVd7
 XIzlcjDT2hPo4bzw58HdOiIbMXeW9/5uIch1JLYqvov5R+IMEIGEE6K5jCNsSk92mAH+1MjFn
 dwV1Nz9czPLwZy74bQceopcQxRUAQRcR+yHX5GpTDQFSDp8p/6R1b0NdHZZIJ1yS9LU3qv4Lg
 GchzbMdJc02QMm8x75wzXXX+XMZ32pzBpPCwNzDipWu1QZ3aB39Np8/ncjuu0dMnIIY8UCLoT
 i8afrj0BMDu9yC1hSCwtGdmZttmWJ3/xJ2r
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed,  4 Aug 2021 11:49:58 +0200
Christoph Hellwig <hch@lst.de> wrote:

> dma_map_bvec already takes bv_offset into account.
>
> Fixes: 9b2a2bbbb4d0 ("block: Add n64 cart driver")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/n64cart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
> index 7b4dd10af9ec..c84be0028f63 100644
> --- a/drivers/block/n64cart.c
> +++ b/drivers/block/n64cart.c
> @@ -74,7 +74,7 @@ static bool n64cart_do_bvec(struct device *dev, struct=
 bio_vec *bv, u32 pos)
>
>  	n64cart_wait_dma();
>
> -	n64cart_write_reg(PI_DRAM_REG, dma_addr + bv->bv_offset);
> +	n64cart_write_reg(PI_DRAM_REG, dma_addr);
>  	n64cart_write_reg(PI_CART_REG, (bstart | CART_DOMAIN) & CART_MAX);
>  	n64cart_write_reg(PI_WRITE_REG, bv->bv_len - 1);

Hm, then how did it work? Does it always happen to be zero?

Have you tested this? I don't have the equipment currently.

- Lauri
