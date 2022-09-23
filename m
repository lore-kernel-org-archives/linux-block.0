Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5ECC6FA8B
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 03:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIWDhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 23:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIWDhM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 23:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C0DF04E;
        Thu, 22 Sep 2022 20:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D57EC60FBC;
        Fri, 23 Sep 2022 03:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10E2C433C1;
        Fri, 23 Sep 2022 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663904230;
        bh=QmPpWXopgwAL7Zd/o9BkL4CFysr+ibZl4lTx3Cwj4jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4dbFjs1oyMJXwiwCltNONDBQKjZID3es7CHLiQ8jZF+fRgJ8CDpKbOQZ1O45BLCO
         MmNAChVSB5mmH1tr5QGDqkdQ9pqTlcawgEtYew3JClA0IUh2eEnT1oNSz0hkR98+JU
         A7OnpUAoy9jofoV/G3dUWAWnQdU5uwoQq9BdLYPYAcwt1BV7hTgPj/7Ry5F+bAfKnv
         sKkJnHbewEYUY85aITfJC6A1nnpxe7kUCXtehoB359a0HYqVm2dA+3N/kN0udxzpGL
         nfcbDcAl81OFcajInTCY9yDUUMubg/O35BjMi/AsZkzkqitpfpvLP2T2yrpYhyPy9Z
         LhLqbp70tiB3g==
Date:   Thu, 22 Sep 2022 20:37:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3 5/5] elevator: remove redundant code in
 elv_unregister_queue()
Message-ID: <Yy0p5O36yrnYCgH4@sol.localdomain>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922113558.1085314-6-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 07:35:58PM +0800, Yu Kuai wrote:
> "elevator_queue *e" is already declared and initialized in the beginning
> of elv_unregister_queue().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/elevator.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 7cb61820cfa0..0a72d6fbbdcc 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -524,8 +524,6 @@ void elv_unregister_queue(struct request_queue *q)
>  	lockdep_assert_held(&q->sysfs_lock);
>  
>  	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
> -		struct elevator_queue *e = q->elevator;
> -
>  		kobject_uevent(&e->kobj, KOBJ_REMOVE);
>  		kobject_del(&e->kobj);
>  	}
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
