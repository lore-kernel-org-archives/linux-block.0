Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A34C433EF
	for <linux-block@archiver.kernel.org>; Wed,  4 May 2022 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiEDPii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 11:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiEDPih (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 11:38:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8734507C
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651678500; x=1683214500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=giyUFohtem1W9y1hYAylFfKqyb/SKJ+F1TceGmIyxJQ=;
  b=IeTDWLMJxOXa5rdN50ffQdIadgSku5AVa5JOvTxCNdI3R3X8xkOP1wjK
   WnWEyFbdSQ+TMVZhZNIsNTnAeec98nH9ezksLbYiDsS7osFeZmi2S+ZYn
   TTAuV4tpgCYq3rGZEHcb24VdDD825z9MrPFf29s3EnaXBSH2eXS/oFiGl
   Fcp/Qem/sDa08zwdIwp/ZEV3VO+ZNxSPTWG/6zGlNLr9OLEy/4p9qJslf
   1YlbNGhETuxQ8wjLnvFhW42WGL0KcSP6ztsDAA8Cabw03228YURGfJvyB
   MpqthH04Eo4j2WQziCLnnX0odo1223lTsqw/5hke+4CxgbaCdmLNz1NDP
   g==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647273600"; 
   d="scan'208";a="198349888"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 23:34:55 +0800
IronPort-SDR: xuzA558mzmizg//IFraH0K0jWvNbamGEH7fzpaWRPzsUQq0hnTiKC2cCw4S2p4j0ZPDCs6NWUx
 EG2gOB5ZbW3kQEiWVoXmWDjX3hoh+gQfsEEumNgNoU2TDPpj2dYoXl+oWzWxLoHAew1fIg7pBj
 NwVS5N94JqYEN0G8n8HJiYsB4xF1/Mz9QKafEC1yVGyssQCjpXV3ToEGpCPLv2MvDDaA6HxWtm
 BG+BQ49z8XorDE+klcJddeNe28R+yisaV6xxw7nfhsoYaOiud5QuewzBughggw6tahodTDbkw0
 8Vp2wf8WYEfwGIsgOXATcgY0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2022 08:04:57 -0700
IronPort-SDR: aUy8CBMMovqP4QcFbr44eMCX2gvBL0xdyN4WGkaup2dcnP4zDMmCEjCbzLdRnmLp6qnxm3IATk
 6Kq6ShwZzpESxMSZDDbNwj8hq6r7LKsUmk1BiFZNKZLocEtEMPvF34qGUGv4uUXo5NieW9qGnB
 LX2BBxMinbNJlRQmgVkzd+UPo6Nda2itqlCCviBn0fsOPLkRj7eX7vK/F4aEteOWxqs5/MZkNm
 3/5xBnB7AFeQUbDIfjP3weKOxH7CuWfIBeBey1IpO582SRLG/lQ46dxTAEXG8TZa3wBgRZpS6e
 l4o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2022 08:34:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ktgqz1zMHz1SHwl
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 08:34:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651678494; x=1654270495; bh=giyUFohtem1W9y1hYAylFfKqyb/SKJ+F1Tc
        eGmIyxJQ=; b=MlcJchBGXqn10+U9l+51SGmSxKfSjouNN3ebBCLvmi6PRzwTcnv
        o5Ej6gU1qEglm9TKCM0MqRR4CjCJgPHnZ8OwfsYdsIFMviTCSr91okI27hzigrxw
        +zZmw8ilbkV5wKqopGerLMIxY+ukvuHpAv8ySIDNSoNUqD+hBd0bev2oqA29dm6n
        NzYW6Z+KKgQHjpJDQvS77HbFwdAknIvqP4WPGu64WGwletjaQYebj1BA+/efrCAp
        AD6QElaOtHAFsgUyveYCUYh5bkjwjXxJHJwB0mMvlNmE0n8fGIIk3j0FkPNBinFH
        p5U7UZdtm0RBlWen3asKsvByZBhoWOuk7mQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xdq7An4q_Ipm for <linux-block@vger.kernel.org>;
        Wed,  4 May 2022 08:34:54 -0700 (PDT)
Received: from [10.225.81.200] (unknown [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ktgqy33HKz1Rvlc;
        Wed,  4 May 2022 08:34:54 -0700 (PDT)
Message-ID: <f0dd35ee-a7e6-4a77-0402-2994c563f773@opensource.wdc.com>
Date:   Thu, 5 May 2022 00:34:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] block: improve the error message from bio_check_eod
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20220504143355.568660-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220504143355.568660-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/04 23:33, Christoph Hellwig wrote:
> Print the start sector and length separately instead of the combined
> value to help with debugging.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 937bb6b863317..10b32a1cc42b7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -592,10 +592,9 @@ static inline int bio_check_eod(struct bio *bio)
>  	    (nr_sectors > maxsector ||
>  	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
>  		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
> -				    "%pg: rw=%d, want=%llu, limit=%llu\n",
> -				    current->comm,
> -				    bio->bi_bdev, bio->bi_opf,
> -				    bio_end_sector(bio), maxsector);
> +				    "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
> +				    current->comm, bio->bi_bdev, bio->bi_opf,
> +				    bio->bi_iter.bi_sector, nr_sectors, maxsector);
>  		return -EIO;
>  	}
>  	return 0;

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
