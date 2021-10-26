Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD71C433FE
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55B961040
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhJZH0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 03:26:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45355 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhJZH03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 03:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635233046; x=1666769046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ce7iNba4sAaEl326Z7GdxJ3ubdL58Ylx4PiP9KyM4IA=;
  b=GH5vSJ7jOhWnzqoOIni6RNAaW/GpqOHhSER3Qlg5Ql80T4RV43Vx0s1N
   tfkGr7k33Q651MaUzRW9d01eX64gfVjiBVcshZs10KUwSZAa6ZO32FW4s
   AEsyNxwMvK/h7io1AGb2BHqh42NVuqrCCVm9nhDVVTAWVZdTfKzmAiqWy
   gn7w282uPvmJFAxqauHNj4H4e/XEL2nHxSFvZ4b1TuBn0glzIC6s9L1zh
   ZP5l7WUWi/LbcnoiaP2fBBznEy5bQc+9gdtkkLReEi9AcopCH3mq0G4lA
   6kIOCAJdSQWG/6O8+QtnA/VUZ7TRDvJ48+6CX5h1ZcLb0DnqewGoALjk3
   g==;
X-IronPort-AV: E=Sophos;i="5.87,182,1631548800"; 
   d="scan'208";a="295588047"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 15:24:05 +0800
IronPort-SDR: xxD/MNugZYqywV72GRGw7LRExVmtxw9e3KFknNI+TlEwOKuLYbbzgivBpRVtPHF22SEvo4h7lH
 Gm2GwX5caK+Sn/WM7TjR81tnN/M7RwvwkwqP8F6pKFEedX3aT23qsMWG3MSAb3Idb30pKaQ1nt
 SKDzGWI6YhSeEaUy8Xts7tFLggA5yWcga+yYhU3Xaj4ndffL2Vyup7zvyradcf5nrglO6+q6vT
 ODco0eQRrKppoSLVD5dDazlvXf5swHAayyEnPJv3TLmIj82o3C2GOFgUxpKwfUH8Iwzpnv7whF
 SabXLxb4y1f2HTX0Y9WCO5qK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 23:59:36 -0700
IronPort-SDR: Uhkt48X5keFCQZjWbzWGtaVjQG+h6ESsxFkQbMT8VucPWeTOyKt5zXd5yT4qRNPRE72v+OXRjR
 8lZSlHoq/pmG+ITs1EDOB4i7drWVA65Pvo2Qka1t8mpTYTGnAYzXElbeC20fSkr7IOzRddWbvH
 tF6zDF2hJq03ntKPayhNVBI2B5P7fk2++JA6HcPDOlaJMPkCXlyjTLoYkGNYIpnbOrLmMzZqPv
 49CfZxo2lEQYZLm0ax+2uLTTjzlorC5Q4t4QkMOEBcwbieRSS0ewu6fFQC405ig/RYdNEQb58L
 d90=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 00:24:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HdjxK3nPhz1RtVw
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 00:24:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1635233044; x=1637825045; bh=ce7iNba4sAaEl326Z7GdxJ3ubdL58Ylx4Pi
        P9KyM4IA=; b=k+e9GNuuM1HOdRg3sXZ2PozLf3F2qEe/+SCm9VGuevYNjjobDeT
        /oTl31kQ9Kp28A9Sf8Jy4/5TqNPfZ/XH4oy6y59C7bHm/x+t0nSIsnaxegYVngO1
        23i/rWpoCjuM0Ijc34oD2NgLH9kVyPaU1/V1yEU62r9Pxw8w83+IGtWkKBtzeM5l
        oJhk/Bu239HgDbde6LyIUMLBiH6XX+Upfmq3DpmZ3J0nQE4b8CD3tmSDYI5Peqgu
        bYmZfv9iNr/RzeeyVx2Dmcu1dbhhLPRrSnOSY5yy+EbNQCO+NA3QHYn30/md19hQ
        uWFG60Uxw+B5y+YS9XSTJMK9Q8n0hoOf8zA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T3uwsN-_g4rl for <linux-block@vger.kernel.org>;
        Tue, 26 Oct 2021 00:24:04 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HdjxH666Nz1RtVl;
        Tue, 26 Oct 2021 00:24:03 -0700 (PDT)
Message-ID: <3088804d-16f0-8f19-590e-8651bb5ef949@opensource.wdc.com>
Date:   Tue, 26 Oct 2021 16:24:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] scsi: ufs: mark HPB support as BROKEN
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc:     axboe@kernel.dk, alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20211026071204.1709318-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211026071204.1709318-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/26 16:12, Christoph Hellwig wrote:
> The HPB support added this merge window is fundanetally flawed as it
> uses blk_insert_cloned_request to insert a cloned request onto the same
> queue as the one that the original request came from, leading to all
> kinds of issues in blk-mq accounting (in addition to this API being
> a special case for dm-mpath that should not see other users).
> 
> Mark is as BROKEN as the non-intrusive alternative to a last minute

s/Mark is/Mark it

> large scale revert.
> 
> Fixes: f02bc9754a68 ("scsi: ufs: ufshpb: Introduce Host Performance Buffer
> feature")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/ufs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index 432df76e6318a..7835d9082aae4 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -186,7 +186,7 @@ config SCSI_UFS_CRYPTO
>  
>  config SCSI_UFS_HPB
>  	bool "Support UFS Host Performance Booster"
> -	depends on SCSI_UFSHCD
> +	depends on SCSI_UFSHCD && BROKEN
>  	help
>  	  The UFS HPB feature improves random read performance. It caches
>  	  L2P (logical to physical) map of UFS to host DRAM. The driver uses HPB
> 

Otherwise, looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
