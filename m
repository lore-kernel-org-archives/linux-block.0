Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07591C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 15:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D683E20842
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 15:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHLPeq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLPeq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 11:34:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE0BF307D84B;
        Mon, 12 Aug 2019 15:34:45 +0000 (UTC)
Received: from [10.10.124.11] (ovpn-124-11.rdu2.redhat.com [10.10.124.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0938637DD;
        Mon, 12 Aug 2019 15:34:44 +0000 (UTC)
Subject: Re: [PATCH] nbd: add a missed nbd_config_put() in nbd_xmit_timeout()
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <1565613086-13776-1-git-send-email-sunke32@huawei.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D518714.5000408@redhat.com>
Date:   Mon, 12 Aug 2019 10:34:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1565613086-13776-1-git-send-email-sunke32@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 12 Aug 2019 15:34:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/12/2019 07:31 AM, Sun Ke wrote:
> When try to get the lock failed, before return, execute the
> nbd_config_put() to decrease the nbd->config_refs.
> 
> If the nbd->config_refs is added but not decreased. Then will not
> execute nbd_clear_sock() in nbd_config_put(). bd->task_setup will
> not be cleared away. Finally, print"Device being setup by another
> task" in nbd_add_sock() and nbd device can not be reused.
> 
> Fixes: 8f3ea35929a0 ("nbd: handle unexpected replies better")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  drivers/block/nbd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index e21d2de..a69a90a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -357,8 +357,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>  	}
>  	config = nbd->config;
>  
> -	if (!mutex_trylock(&cmd->lock))
> +	if (!mutex_trylock(&cmd->lock)) {
> +		nbd_config_put(nbd);
>  		return BLK_EH_RESET_TIMER;
> +	}
>  
>  	if (config->num_connections > 1) {
>  		dev_err_ratelimited(nbd_to_dev(nbd),
> 

I just sent the same patch

https://www.spinics.net/lists/linux-block/msg43718.html

here

https://www.spinics.net/lists/linux-block/msg43715.html

so it looks good to me.

Reviewed-by: Mike Christie <mchristi@redhat.com>
