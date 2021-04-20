Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63823C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E548613E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhDTUtJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:49:09 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.142]:40599 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234059AbhDTUtI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 16:49:08 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 3EFE5A9131
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 15:25:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwwElH5ixL7DmYwwFlPABr; Tue, 20 Apr 2021 15:25:39 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8WaJQOvWa34W2/gjggyjuGAo/HlnLHnW/HqDi/mf0Ak=; b=eNcKq1DbSrH6iad9NpTT715XoL
        UOHtRjGXWfBSB3vZTlFwpdFTYakeCFG3Z8gQnrL1ET4SKUjNX+EsHncYdkaBI8clEU05gYod2Ulmq
        00fce/NgsxUK9VmqWZXPra54/8+xHSdDER5yHv64uzPH/rCOdR5fDoc4wPfzMfSwXErcW+9ZpOvBg
        3FUKSjrXmv/2IhuxVH2OxW8MPI9unKaC2V1WehajcleSLqfcVHO6MqWFfjloI6Zo+xiplnhowAi6E
        fD8qdbyDo5mdnfEYSlzT7HislARTeHLTHNnSCXXjaqPJyR2XXxZcOPQcDtdL/PR+2UxqtzuWm94Y1
        auTPDUNQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49052 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwwB-0034SB-AG; Tue, 20 Apr 2021 15:25:35 -0500
Subject: Re: [PATCH 027/141] drbd: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44663f18fb12e39c53b0e69039c98505b7c6d5da.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba77fcbe-8770-d234-509b-7dc5ac079319@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:25:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <44663f18fb12e39c53b0e69039c98505b7c6d5da.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYwwB-0034SB-AG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49052
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 183
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:28, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> of warnings by explicitly adding a break statement instead of just
> letting the code fall through to the next, and by adding a fallthrough
> pseudo-keyword in places whre the code is intended to fall through.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/block/drbd/drbd_receiver.c | 1 +
>  drivers/block/drbd/drbd_req.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index dc333dbe5232..c19bb74ac935 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -5863,6 +5863,7 @@ static int got_NegRSDReply(struct drbd_connection *connection, struct packet_inf
>  		switch (pi->cmd) {
>  		case P_NEG_RS_DREPLY:
>  			drbd_rs_failed_io(device, sector, size);
> +			break;
>  		case P_RS_CANCEL:
>  			break;
>  		default:
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 330f851cb8f0..9f212a923a3c 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -750,6 +750,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>  
>  	case WRITE_ACKED_BY_PEER_AND_SIS:
>  		req->rq_state |= RQ_NET_SIS;
> +		fallthrough;
>  	case WRITE_ACKED_BY_PEER:
>  		/* Normal operation protocol C: successfully written on peer.
>  		 * During resync, even in protocol != C,
> 
