Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25748C0015E
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 10:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjF3KeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjF3KeK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 06:34:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BED35A0
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688121247; x=1719657247;
  h=mime-version:date:from:to:subject:in-reply-to:references:
   message-id:content-transfer-encoding;
  bh=ceBKz4A31miCsZPF9j9ZqKKds3qsGqNNGbiRMwK3xMk=;
  b=c1IdIGlCZgtq7hrd4Fgnp1FZ5XfmhID01zI8tTxI8DBRH4hy5a3TYSoM
   QdkYM1uesBs+/R4btBwBcmii1jjFTo7CweAq6yDnlzO3+Wg/N7i9iMSuw
   mRdI2GKpC+maF9b9Rj7bJVgvZAkpaJ+wJlBqrzf+AdGGvYAUdaS+UXMqy
   YdyeHydqCEiOA52pHw5nCdWLadg7XwKMtC5H3DOHimMxwRKumurZGEpH/
   xAA3gBA4CJramfQEInG+csbBj9J48XAj43XD6L2jPN0t/46+1GvPrZti/
   Oei93bWkt8KBw0XrkumtPl1rsyTVMl/JI7O2Fo4zv+hMk9hkr6gr+loNI
   g==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="241584340"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 18:34:07 +0800
IronPort-SDR: 4ladhVaxXJakM+++ymP/sqN7r5ZgbZI93einVVMAzqynmNK/pDbYJpqJBFqkMxf3AsMh18d293
 S6PBaIo8AkCHXdN6/oluT6bLDW7LjIdxp6EUTSNCnVXXw00CeZMRQoyhxrmVs3cbxEC9VFlhvl
 GfQtOEej7jrCNVzSLGYhF7L8MfVsmnrDTjPP979CkSvkny9Uw5TnRiiONliJLMlpSbZ91cPD7N
 a1FFi4nqAX/NhLwW2GXypo9L9Dpeqiuu5T70pRpvghW1Zj7OrsuLRQilmAlot19EQo3L8eieFJ
 YbU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 02:42:42 -0700
IronPort-SDR: 1EjPAyx1yWUx7MOGO2eqRGnM+oqriYdNzBOBPDmsPrPO0hBlGCNkRcz5L7ne4K7LiGJsbPuBq/
 x1nIiw9Ay2Y9SQaazreNlsJudzAAsOOoS4bNTBUcnhS8oNiA3LWeWw+NCaPXQwtUM3MgOCBuN2
 oOFdsxzij35bphnWs3C+jG0mSex58vHQlDEd1+AIuqD/DOY7LnMAgDoK/TUqo0CV6IS+kOF3W0
 jgAbqw/YR34dxKBC6n+1/JUDCdqdiQn7RoY1dQIG1JdbtmM3tSew6keOsDj5X++V9C2/NeMVoY
 4og=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 03:34:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4QssB70VRqz1RtVp
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 03:34:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :message-id:user-agent:references:in-reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1688121232; x=1690713233; bh=ceBKz
        4A31miCsZPF9j9ZqKKds3qsGqNNGbiRMwK3xMk=; b=maa8O8GQIguT3uhBLbP6u
        F36t6iHtVDrmF2+JaIqv/+7i3ka+G8H2fWjYZArBnpA0FOd58vKzhCpbapY90QZo
        9de7y2wugJBPX8iDBxJ//psz/InvWIHmDF4aoM6e0qzwdFXJuMc5cle0J6geSbwH
        r0+RaaGSg5AQ6i+Sn9uO826UAXyV2eEBwoqr7gAj84cThoDu+gjBFi7mOa558o+7
        ViTZp4gXih4/PNVzCiLkb8voiCJ7TvpKZUscX0UnA4EhpKCm+g0pDzAIGx2P/xYR
        q/TR/I3jsUX9qir1UUHkOPcBN0kF/yxAOOKYZec/15MsdZl9U5WpPjniEuSq3kx+
        Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bMIZTX-WPbre for <linux-block@vger.kernel.org>;
        Fri, 30 Jun 2023 03:33:52 -0700 (PDT)
Received: from localhost (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Qss9k4K3Sz1RtVm;
        Fri, 30 Jun 2023 03:33:46 -0700 (PDT)
MIME-Version: 1.0
Date:   Fri, 30 Jun 2023 16:03:46 +0530
From:   aravind.ramesh@opensource.wdc.com
To:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        hch@infradead.org,
        =?UTF-8?Q?Mat?= =?UTF-8?Q?ias_Bj=C3=B8rling?= 
        <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
In-Reply-To: <83E5C27A-9AEF-4900-9652-78ACFF47E6B0@wdc.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-2-nmi@metaspace.dk>
 <83E5C27A-9AEF-4900-9652-78ACFF47E6B0@wdc.com>
User-Agent: Roundcube Webmail
Message-ID: <a7bb663d522cde468b868e8e77110217@opensource.wdc.com>
X-Sender: aravind.ramesh@opensource.wdc.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> From: Andreas Hindborg <a.hindborg@samsung.com 
> <mailto:a.hindborg@samsung.com>>
> 
> 
> This change is in preparation for zoned storage support.
> 
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com
> <mailto:a.hindborg@samsung.com>>
> ---
> include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/include/uapi/linux/ublk_cmd.h 
> b/include/uapi/linux/ublk_cmd.h
> index 4b8558db90e1..471b3b983045 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
> __u64 reserved2;
> };
> 
> 
> -#define UBLK_IO_OP_READ 0
> -#define UBLK_IO_OP_WRITE 1
> -#define UBLK_IO_OP_FLUSH 2
> -#define UBLK_IO_OP_DISCARD 3
> -#define UBLK_IO_OP_WRITE_SAME 4
> -#define UBLK_IO_OP_WRITE_ZEROES 5
> +enum ublk_op {
> + UBLK_IO_OP_READ = 0,
> + UBLK_IO_OP_WRITE = 1,
> + UBLK_IO_OP_FLUSH = 2,
> + UBLK_IO_OP_DISCARD = 3,
> + UBLK_IO_OP_WRITE_SAME = 4,
> + UBLK_IO_OP_WRITE_ZEROES = 5,
> + UBLK_IO_OP_ZONE_OPEN = 10,
> + UBLK_IO_OP_ZONE_CLOSE = 11,
> + UBLK_IO_OP_ZONE_FINISH = 12,
> + UBLK_IO_OP_ZONE_APPEND = 13,

Curious to know if there is a reason to miss enum 14 here ?
And if UBLK_IO_OP_ZONE_APPEND is defined along with other operations
better to define that in patch 3 itself.

> + UBLK_IO_OP_ZONE_RESET = 15,
> + __UBLK_IO_OP_DRV_IN_START = 32,
> + __UBLK_IO_OP_DRV_IN_END = 96,
> + __UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
> + __UBLK_IO_OP_DRV_OUT_END = 160,
> +};
> 
> 
> #define UBLK_IO_F_FAILFAST_DEV (1U << 8)
> #define UBLK_IO_F_FAILFAST_TRANSPORT (1U << 9)

Regards,
Aravind
