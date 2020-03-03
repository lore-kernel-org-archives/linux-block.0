Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E2EC3F2C6
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DFB20848
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Vaq2dpQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbgCCVML (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:12:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39745 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbgCCVML (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 16:12:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id e16so4939610qkl.6
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7+rNtwc3taKkaB/BWsH2V4WaM282d/1lxQTUPD2UwBw=;
        b=Vaq2dpQ6rRdONuhCdFMMR0HIfubWJbWCLbfZAgsNTqg4O4a09poVhXrEDLD6zjcY2d
         JHE5rF3BUUX8kanVAjUnZstP8kVKl6NOyub5rx/sigjkTvtzMZwQju5RSqiIHr0xTglJ
         2XdntdihhYKdZ8mMsB8XpF2WWHqXYDkc9kmL/5LwtYFuGHNBHrvJOdhIRBvOk4AbYhJH
         FLGlhYiCG/JIkt5HTj6gUBPdQ1wAHEYLr38JyZX0UdaSWZP8FWIZUOoqww8aM4n63EnC
         OhS2fedbCHLv9tvXQ61E2DpZ6hWMeeMSQy+NjbNGLGxG0J1+qbz86OIFXIULffqy2fH0
         wF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7+rNtwc3taKkaB/BWsH2V4WaM282d/1lxQTUPD2UwBw=;
        b=TP5xmCC3JCGfc2XMtp+tHWZrhMPv3naNeksldn2i7ZMhX4yWZC8OarQgj36T/GGL1I
         aerOtVGnItcsfWjl/+c7459vUlSuIqQfmczWUatyut7pCZBRR9kps9yLuxMieAJNJaFY
         XyPjrDft2Z8FhL2RlORfVP1hmwjDnvHQ94gVqiXlPHNOUqhTRFaYdNIT9diNYy8CbuAI
         d8AOB5ga8JrXo9YNyD3PgXe1U5c4UMCGuq4CEH++JTjEzzpKvrsKqQXqwS56OJqzo9VD
         4mklTI7DjVwQumzdi4qAX+DfSUAPDdL6DRNcvGrP//XealdoHuTPnfc/An7fHMTA9XyG
         45jg==
X-Gm-Message-State: ANhLgQ3L/wXRKCb3xE6Cd+2e0kZlcSDYzi4/D8otLGzFG4tHDtX0Zwbv
        OlcNT12mbkqq69DVDFjvvDUkPFK/xJI=
X-Google-Smtp-Source: ADFU+vvlY9Ns+7ioJ4OLOFRK0oVo13JpxjmwUkzD16hudS4jYTmPzIRaQp3gLzV3hcGOiM36kwE9PA==
X-Received: by 2002:ae9:e104:: with SMTP id g4mr5777015qkm.133.1583269930094;
        Tue, 03 Mar 2020 13:12:10 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c13sm7034032qtv.37.2020.03.03.13.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 13:12:09 -0800 (PST)
Subject: Re: [PATCH 1/2] nbd: enable replace socket if only one connection is
 configured
To:     Hou Pu <houpu.main@gmail.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
References: <20200228064030.16780-1-houpu@bytedance.com>
 <20200228064030.16780-2-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3b6ae210-f942-b74d-1e53-768c7e8c3675@toxicpanda.com>
Date:   Tue, 3 Mar 2020 16:12:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228064030.16780-2-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/20 1:40 AM, Hou Pu wrote:
> Nbd server with multiple connections could be upgraded since
> 560bc4b (nbd: handle dead connections). But if only one conncection
> is configured, after we take down nbd server, all inflight IO
> would finally timeout and return error. We could requeue them
> like what we do with multiple connections and wait for new socket
> in submit path.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>
> ---
>   drivers/block/nbd.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 78181908f0df..83070714888b 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -395,16 +395,19 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>   	}
>   	config = nbd->config;
>   
> -	if (config->num_connections > 1) {
> +	if (config->num_connections > 1 ||
> +	    (config->num_connections == 1 && nbd->tag_set.timeout)) {

This is every connection, do you mean to couple this with dead_conn_timeout? 
Thanks,

Josef
