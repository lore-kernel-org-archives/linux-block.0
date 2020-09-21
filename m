Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB4C4363A
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A6221D91
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ouqtkDDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIUSBa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSBa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 14:01:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14FC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 11:01:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w16so16115975qkj.7
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BEKm5BdGZ0I7bWDny206FOs0HiTvM3zZllXglCtiZJc=;
        b=ouqtkDDpVA1XvQn42tRtsgrQyDq59fmp1feQ1VewFq7N+FiT1OR1Zj1+sZg6bGiZVj
         RLPLDVD9brj5X6pphFfzsGm+zyOraO61NQtMplmQbEExaWMqAAoB23EitMOFqMXtDzMm
         agV0K81f/9GzFgr2hFyE1/fIa4UXYgsUJ6EFQKhU5Z4BcVF7NquDyWpiUPKZ3bX8+XOZ
         pIMx/cHfRPXmxcYdd74scsePr82c2OJss53qzhVs/ilCjD4s3AA6vhDZulDT1+sCTXDE
         +bTnM78qm+MIagvun9PHv3AMZ4Sq/ssvI6H/9DtHqQw8VuqFP8lsX91abEgCXUXh4l1y
         X5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BEKm5BdGZ0I7bWDny206FOs0HiTvM3zZllXglCtiZJc=;
        b=rmRXe7ri3BiUht68C5H3Ddp3Yp/XaDe3dUYVyUihnndCZRRDegXpXi4DLFmy33WDek
         jhQ2FDLfSlLhmJUHeB4+4UizTS97jPNcfWBb6RQmU5jlzXLvnHZaP2PbrU38uAsjKt+d
         zNpK9U9mqNH16RQDEg2M5nHb53TkvJOOgfUT+2AnToZqQsA/R/E92auAhJpc7djLlwDN
         DSGHHnOzJTcOYdyWoaYlJwR0YW4gtFdmV6JG4qL1FsuHAyOdAvS1aSGAfkk1V7uC54kd
         M4HMhTVZkusgonVQQo475yHxD7fmUkyo3zlzMBF0pyk/5NT7vn7Hsc4LsFhsP9TvLiU4
         TRPg==
X-Gm-Message-State: AOAM532g8T+2f6/0ARLRg4u1r4oO1DK3gWhyi+Bgd0e+8W4Vm34aAmOa
        XBv6KfdjosAI2P4nyHcGUtViFg==
X-Google-Smtp-Source: ABdhPJxSB7rwOqzDUgtBFa98VCKM6R/xVW5x+xBn+1OZMRjGnNceaFk3Fnemyi36NBk07nFeFS8nmg==
X-Received: by 2002:a05:620a:a10:: with SMTP id i16mr1001418qka.31.1600711289343;
        Mon, 21 Sep 2020 11:01:29 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f189sm9876417qkd.20.2020.09.21.11.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:01:28 -0700 (PDT)
Subject: Re: [PATCH 2/3] nbd: unify behavior in timeout no matter how many
 sockets is configured
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200921105718.29006-1-houpu@bytedance.com>
 <20200921105718.29006-3-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7f56fc84-5fbd-cf4a-e1d7-c6a75396a6bf@toxicpanda.com>
Date:   Mon, 21 Sep 2020 14:01:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921105718.29006-3-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/20 6:57 AM, Hou Pu wrote:
> When an nbd device is configured with multiple sockets, the request
> is requeued to an active socket in xmit_timeout, the original socket
> is closed if not.
> 
> Some time, the backend nbd server hang, thus all sockets will be
> dropped and the nbd device is not usable. It would be better to have an
> option to wait for more time (just reset timer in nbd_xmit_timeout).
> Like what we do if we only have one socket. This patch allows it.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>
> ---
>   drivers/block/nbd.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 538e9dcf5bf2..4c0bbb981cbc 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -400,8 +400,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>   	    nbd->tag_set.timeout)
>   		goto error_out;
>   
> -	if (config->num_connections > 1 ||
> -	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
> +	if (nbd->tag_set.timeout) {

So now if you don't set a .timeout and have num_connections > 1 we don't close 
the socket, so this won't work.  Thanks,

Josef
