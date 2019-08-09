Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40159C31E40
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B0D208C3
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfHIVcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:32:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfHIVcK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 17:32:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24F278E22B;
        Fri,  9 Aug 2019 21:32:10 +0000 (UTC)
Received: from [10.10.125.29] (ovpn-125-29.rdu2.redhat.com [10.10.125.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD11960BF7;
        Fri,  9 Aug 2019 21:32:09 +0000 (UTC)
Subject: Re: [PATCH 1/4] nbd: add set cmd timeout helper
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-2-mchristi@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D4DE659.5050909@redhat.com>
Date:   Fri, 9 Aug 2019 16:32:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190809212610.19412-2-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 09 Aug 2019 21:32:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/09/2019 04:26 PM, Mike Christie wrote:
>  
> +static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
> +{
> +	nbd->tag_set.timeout = timeout * HZ;
> +	blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
> +}
> +
>  /* Must be called with config_lock held */
>  static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  		       unsigned int cmd, unsigned long arg)
> @@ -1275,10 +1281,8 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  		nbd_size_set(nbd, config->blksize, arg);
>  		return 0;
>  	case NBD_SET_TIMEOUT:
> -		if (arg) {
> -			nbd->tag_set.timeout = arg * HZ;
> -			blk_queue_rq_timeout(nbd->disk->queue, arg * HZ);
> -		}
> +		if (arg)
> +			nbd_set_cmd_timeout(nbd, arg);
>  		return 0;

Josef,

These patches still leave one regression where you used to be able to
disable the timer after it has already been set. My patches did not fix
that yet. I will fix it on the resend after you give me your comments.

