Return-Path: <SRS0=3zrn=Z6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B4FC43603
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 17:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387C12054F
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 17:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="opmYfujz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLHRfk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:35:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLHRfk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Dec 2019 12:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ljVwhs1wUnQm/pzAJ67WBiI42QxXGjVUOsHzns6TOO8=; b=opmYfujzqK/WQ3iAOs8hPeCtr
        GMVkcGXGqEA348bgdYIObZ93FjK+3jNRSNg9swTBCVYbQ0cHqyc24aZULNrhx8zb7Ux9C1RnE4ie3
        cjRJpTVOhw0uXGx6DnUIYf2pnOEk+uPS83+frEi6W6TXGxd8QcZKuak4tzVDN2cAI70PKyoWLg/W4
        cTSAeF80TlszDi5nFFZKKE4ZVorUl+2Dm69zwqdCo5vlZyj7Ah2dMCLTe/yLvv1RqAQDDJVgOKt7e
        9VmI2Cec8WrSxPgvfknpL38GI9N8ata/itykme5tHwAD0S0X9PhFO6jz6+UcxVsy+Asp+/PYLayJt
        qcDKptXGg==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ie0Sy-0002CH-QM; Sun, 08 Dec 2019 17:35:32 +0000
Subject: Re: [PATCH] floppy: hide invalid floppy disk types
To:     =?UTF-8?Q?Moritz_M=c3=bcller?= <moritzm.mueller@posteo.de>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Cc:     "Philip K ." <philip@warpmail.net>
References: <20191208165900.25588-1-moritzm.mueller@posteo.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <debf1513-7b56-2ad7-a6c7-3069e73efac6@infradead.org>
Date:   Sun, 8 Dec 2019 09:35:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191208165900.25588-1-moritzm.mueller@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

one small typo:

On 12/8/19 8:59 AM, Moritz Müller wrote:
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 1bb8ec575352..9e6b32c50b67 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -72,6 +72,16 @@ config AMIGA_Z2RAM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called z2ram.
>  
> +config FLOPPY_ALLOW_UNKNOWN_TYPES
> +	bool "Allow floppy disks of unknown type to be registered."
> +	default n
> +	help
> +	  Select this option if you want the Kernel to register floppy
> +	  disks of an unknown type.
> +
> +	  This should usually not be enabled, because of cases where the
> +	  system falsely recongizes a non-existent floppy disk as mountable.

	                 recognizes

> +
>  config CDROM
>  	tristate
>  	select BLK_SCSI_REQUEST


-- 
~Randy

