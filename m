Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7BC636D7
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 02:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjAaCFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 21:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjAaCFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 21:05:41 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263ED227BD
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 18:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675130740; x=1706666740;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AcsiuLuDwWfVsTzWwmYa8LChhoDmQwERu0vhn8YNug0=;
  b=ZEpXBRfTiE/K3Bbv6dTAVLdwtX1Czj8qUCmNQ/rwJwpy82HW9pbOtnq9
   CO1DZKPmO7sbDSGEkMUAgUWIm49e03SrYKKUp7HMugrxO+uI/bIuSnVqR
   J2STfxx2EX9c3STrWnXDtVrtLphh6o34l1ORixYQCsTMC0ScgmMcenJfC
   YPvgMSqGGQRp6aWupAIyfZVdALx1qD/3uyGKleUlbP7V94Xi9FQUNGGGx
   y4jGbaYiBBjnCx5SgdRnayAvex2fCzUjKRzJU/PBacrGZkAuX5ZdasEr9
   YWMs+d2ITNpPDDUoygB4kNI07Ux/vIAdsCGfw3tGS7y5+r/LxJFSNCLpi
   w==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="334094199"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 10:05:39 +0800
IronPort-SDR: ZC0FkpHat4iDl9By1MeqWfcf9ZGp0EijF/DhGQ+QMhRLMvW+MFO3Alvj9UAr7iDjz2e56pP8I+
 IqKKeRIzACX3VJXhzXHTmfN6AlSSzN7F4rdJwX0nNTomyW6B0ULz97dMq2SByF0tTk6t99MJTk
 nLl7Ief9hhI9eMCjIwyTw+mB7EQvINOBSl6mMEk5WGts7En2g2lqB4w7Kl8qCSEm++19br1pJ0
 HgPoF+17+0e2ebRU2kfXQyixW7ao9kSwS+ERPzz1SvFXWtaDitunQ5DXgbelwVZldrsgtRF3gq
 uZg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 17:17:20 -0800
IronPort-SDR: 0jv9RaXUUJYgR5A3CSNrKYyKe9k9KzhCGDPdfKHabrXyAgdQPVCD2mKZIlAlJpZpmy9o9+TJRA
 7e+IVbQmZdVM4+K4FPwSV6r1Ey6ZKFAdXFAd/6195UIgXVUONIHNtzyOFa5/mXPWevjC95T4eV
 3ryvMoCaE3uaE48kd7kwqf7MTgMU3Tyka4vSmnaQ5Nejc4FQOHmrOTBJFu6nvXFZdKY26al9JD
 JGxuRKVvomrEcEuRyVBIvaCOlJHfu0TCb8erSdb+3NmYjZNbl/Nhmj707FRpfp0zgzZKPNYBU9
 hXM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 18:05:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5T0g09xhz1RvTr
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 18:05:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675130738; x=1677722739; bh=AcsiuLuDwWfVsTzWwmYa8LChhoDmQwERu0v
        hn8YNug0=; b=If7in8ACFpGd9feMG2WQjqjiESkIbI/SSsPJRd0A/fqdyxaPLLO
        EIxXz42KfGgFXxlNtGWxobMWwIx3Ni5oYuYwu7RN2HtB4O4ljNyxJNwXkB5+tV7k
        NEzMfXo2NsMs+OpIbM7l5jcczl1eRMXYCTqqgCwbN/7lbtUeKYf/3taHuZzV4Xqp
        /yPBdjIVEqp5Ho/eckNcS9LedHOrNigrM1Oh93W9pQyaFlwNP/N83Ss6tzsEgaeY
        +egN+bJGJSuAinpgS1jThyxyYxRs3/6c8tU9+qOytZie+44COimoUgdD3sdTccN8
        QvaKLMoxgwPZZE/5mPNdaNMsfPoC0t9U4fg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gh1RRxkws2_a for <linux-block@vger.kernel.org>;
        Mon, 30 Jan 2023 18:05:38 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5T0d0H6Dz1RvLy;
        Mon, 30 Jan 2023 18:05:36 -0800 (PST)
Message-ID: <e6041145-7336-2534-8449-7b9b6a842466@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 11:05:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] drivers/block: Move PARIDE protocol modules to
 drivers/ata/pata_parport
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <20230130211050.16753-1-linux@zary.sk> <20230130211050.16753-2-linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230130211050.16753-2-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 06:10, Ondrej Zary wrote:
> diff --git a/drivers/Makefile b/drivers/Makefile
> index f1365608bc8c..de8aa561c95c 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
>  obj-$(CONFIG_SBUS)		+= sbus/
>  obj-$(CONFIG_ZORRO)		+= zorro/
>  obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
> -obj-y		 		+= block/paride/
> +obj-$(CONFIG_PATA_PARPORT)	+= ata/pata_parport/

It would be better to have this in drivers/ata/Makefile, not here, so that doing
something like:

make -j64 M=drivers/ata W=1
or
make -j64 M=drivers/ata C=1

actually also checks the parport protocol modules too.

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 23588738cff0..2f85812e16ef 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)       += pata_samsung_cf.o

 obj-$(CONFIG_PATA_PXA)         += pata_pxa.o

+obj-$(CONFIG_PATA_PARPORT)     += pata_parport/
 obj-$(CONFIG_PATA_PARPORT)     += pata_parport.o

And then we could also have drivers/ata/pata_parport.c moved under
drivers/ata/pata_parport/ to tidy things up.

If you agree, I can fix that up, that is easy to do.

-- 
Damien Le Moal
Western Digital Research

