Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E5EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 11:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGULv6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGULv5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 07:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC130C7
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 04:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD67461A00
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 11:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1AFC433C8;
        Fri, 21 Jul 2023 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689940314;
        bh=D8vVJ1uQVgiR+zO4irmFEQwTSlRGs/LgrVDt2U5GgIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEU1qXX/8SKcXSmDRwWEh3j5k7V6gSOH0fT2gsTY06FK8bwKl6wI5obfBqHgv2iEK
         f/XxHcyR05m+Ahwi8ZcJGm1MXwYbMPLiZZubD6jDFF1owDSsm0p0qZViXHou+DED4/
         znf7x0SAoF96u0cm/HWxeY8lB4nMk60VNOcLxGCVn7bbZHP98wUtanw0RTs6M/5qk4
         wIoGSCx9rMP5AI2ySTlgru8Zu1cXwggBMl5zCLNVzenfWAMqf3681N3FXz3TtvSyzv
         2Y3TflG/VKsdBwfFD9uiCLaCAAO8ndzXpGDKRVcaOWo6ubEYbC629PlisULXB3Fjmq
         z0RohcTMseIOA==
Date:   Fri, 21 Jul 2023 13:51:49 +0200
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-ID: <ZLpxVXw7aRh/oJ0Z@kbusch-mbp.dhcp.thefacebook.com>
References: <20230721095715.232728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721095715.232728-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 21, 2023 at 05:57:15PM +0800, Ming Lei wrote:
>  static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  {
> -	int i, wake_index;
> +	int i, wake_index, woken;
>  
>  	if (!atomic_read(&sbq->ws_active))
>  		return;
> @@ -567,13 +567,12 @@ static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  		 */
>  		wake_index = sbq_index_inc(wake_index);
>  
> -		/*
> -		 * It is sufficient to wake up at least one waiter to
> -		 * guarantee forward progress.
> -		 */
> -		if (waitqueue_active(&ws->wait) &&
> -		    wake_up_nr(&ws->wait, nr))
> -			break;
> +		if (waitqueue_active(&ws->wait)) {
> +			woken = wake_up_nr(&ws->wait, nr);
> +			if (woken == nr)
> +				break;
> +			nr -= woken;
> +		}
>  	}

This looks good. I had something similiar at one point, but after all
the churn this file had gone through, I somehow convinced myself it
wasn't necessary anymore. Your analysis and fix look correct to me!

Reviewed-by: Keith Busch <kbusch@kernel.org>
