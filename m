Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8172BC43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 09:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CF320671
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZCyxSslK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CF320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeKTUE4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:04:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39813 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKTUE4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 15:04:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id b13so1181687wrx.6
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 01:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YIpszGN6C5oGlO/HzY5CjOhjFuRDU/aYGZDdWlr+01Q=;
        b=ZCyxSslKFcd4u8bQ3Oms32LlXnHbWJ8la3pEvRVRTEb2kCFLSINwoI4Ay1EGJC3zSg
         UN2pEsNZWDdf3VRspGHFlG7YRZrG7Z9auZku0EDfUPVdDPu+0hOuElQQ8JUpyG74Nkzg
         R57UrVASsuAmUlLliK0orIAh4K+8kb7ikabqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YIpszGN6C5oGlO/HzY5CjOhjFuRDU/aYGZDdWlr+01Q=;
        b=jV8CGGeCv6fCBoQ71gQErQaAPYy9wTFIaXTsGubAAwqEis84sP4rduJ7hCKe91z/51
         COUKnvHJz6vlG/MHpHtyO+FxwiXrYn26BGpy94rDBFVyw8IPbXfGnt1rTZHmRgx2kbc6
         dRG5yI15F61QBUQCzMwJWPfY2LAppn8gP6LKJ9FUDxkFUeXe8rgWTpyFUAPH5It5ZW7b
         8qvsS7hlxCKN01zmb0rMK7h87IcN3/MicnIgtXJyVZkavNqQzpswBUla2D+ZW9rJ2g3V
         CkC3tlsh+t4T7NKVXtYHmpSmCfYgJuG+YpObqqBmTVpsBjGOSEaKVLoRvzvau/NwcqWn
         i/Tw==
X-Gm-Message-State: AA+aEWZWtWMKeZ7gBwf6tUVPkq0RsEScREv0WhyZP2FVZ5euAXRCbPUL
        uUGFRL8Igm/NmCHpgG8qGrHyQg==
X-Google-Smtp-Source: AFSGD/X72aD7MOCeYvX98cmT8RPhCr0+m7Q0yW8DC8Ssp0TJCP+s7yscIolxdRuR3GnzyOYgq50D5g==
X-Received: by 2002:adf:8505:: with SMTP id 5-v6mr1291065wrh.224.1542706603311;
        Tue, 20 Nov 2018 01:36:43 -0800 (PST)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id w9sm15529061wme.47.2018.11.20.01.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:36:42 -0800 (PST)
Subject: Re: [PATCH nvme-cli v2 15/14] nvme: Add TCP transport
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-17-sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <e04487c8-a4a8-bd4f-2ec7-8f67f0f1a49e@broadcom.com>
Date:   Tue, 20 Nov 2018 10:36:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181120030019.31738-17-sagi@grimberg.me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/2018 4:00 AM, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi@lightbitslabs.com>
>
> Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
> ---
>  fabrics.c    | 5 ++++-
>  linux/nvme.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fabrics.c b/fabrics.c
> index be6a18cd4787..b4fac97253ba 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -96,6 +96,7 @@ static const char *arg_str(const char * const *strings,
>  static const char * const trtypes[] = {
>  	[NVMF_TRTYPE_RDMA]	= "rdma",
>  	[NVMF_TRTYPE_FC]	= "fibre-channel",
> +	[NVMF_TRTYPE_TCP]	= "tcp",
>  	[NVMF_TRTYPE_LOOP]	= "loop",
>  };
>
> @@ -703,11 +704,13 @@ retry:
>  		/* we can safely ignore the rest of the entries */
>  		break;
>  	case NVMF_TRTYPE_RDMA:
> +	case NVMF_TRTYPE_TCP:
>  		switch (e->adrfam) {
>  		case NVMF_ADDR_FAMILY_IP4:
>  		case NVMF_ADDR_FAMILY_IP6:
>  			/* FALLTHRU */
> -			len = sprintf(p, ",transport=rdma");
> +			len = sprintf(p, ",transport=%s",
> +				e->trtype == NVMF_TRTYPE_RDMA ? "rdma" : "tcp");

So why not just use the trtypes array above?

Regards,
Arend
