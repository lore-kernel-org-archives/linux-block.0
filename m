Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DDC4360D
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FC3208C0
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfIVCid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:38:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfIVCid (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 22:38:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB2243086218;
        Sun, 22 Sep 2019 02:38:32 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E5B85D9E2;
        Sun, 22 Sep 2019 02:38:28 +0000 (UTC)
Subject: Re: [PATCH RESEND] nbd: avoid losing pointer to reallocated
 config->socks in nbd_add_socket
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        nbd@other.debian.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20190920160644.GA15739@asgard.redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <b8c7fdec-700d-e4a6-9fd6-a63c09e7a613@redhat.com>
Date:   Sun, 22 Sep 2019 10:38:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920160644.GA15739@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 22 Sep 2019 02:38:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/21 0:06, Eugene Syromiatnikov wrote:
> In the (very unlikely) case of config->socks reallocation success
> and nsock allocation failure config->nsock will not get updated
> with the new pointer to socks array. Fix it by updating config->socks
> right after reallocation successfulness check.
>
> Fixes: 9561a7ade0c2 ("nbd: add multi-connection support")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Cc: stable@vger.kernel.org # 4.10+
> ---
>   drivers/block/nbd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index a8e3815..a04c686 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -987,14 +987,14 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>   		sockfd_put(sock);
>   		return -ENOMEM;
>   	}
> +	config->socks = socks;
> +
>   	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
>   	if (!nsock) {
>   		sockfd_put(sock);
>   		return -ENOMEM;
>   	}
>   
> -	config->socks = socks;
> -

This makes sense.

If the socks allocating successes, then the old config->socks will be 
freed by krealloc() and return the new one, but if the nsock allocating 
fails, the config->socks will hold the released memory, which may cause 
the kernel crash.

Thanks

BRs



>   	nsock->fallback_index = -1;
>   	nsock->dead = false;
>   	mutex_init(&nsock->tx_lock);


