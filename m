Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE2CC43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 10:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiGRKtt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiGRKts (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 06:49:48 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F941EAEB
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658141386; x=1689677386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OROu4ES56TCFdEXfArhrVDT1PXThr0q71+zm8PxsoWE=;
  b=n/M/Ud+/jZXnbeSDInLHu79rCkrl1jx5oIh8ixWfh7fGTyTJelm47Mcf
   TfWDOSmmzhK1NO7ZYoGh0F/3egrNpHjD8y2EP4a0Bh1xHVTbnfawHqZ4D
   9NVTVYS5HOnMk1A0J/B6ExUii5xN2SmZ8x3vC9qsi2YhtZjKE4KFSeeP1
   lrAHhhpzMCXJj+JilGlMud4HZx6EIQzPKk0JeEU18+nv4tbDcTQcljFEI
   9dv1wIlVSlZe/S18xaIGw3ZWvgKIpXXqN2KZ1flO2qmo6Lb0xRrEkrkVn
   dEMh+QC3MFbOnIj3du8qfwQks/YD4y2se4SrRYYuLwGTYx70KWBr6CSOw
   A==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650902400"; 
   d="scan'208";a="206714154"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2022 18:49:46 +0800
IronPort-SDR: xmHpLutqfN+nu7u0AGQnut6BJqGbX6wCmq/sCSJdtmPSuERqONhN0RP+PXJ/rRRNv+dbqOs7VY
 2RZXtBLnQ3DpoC0kIid3ZxUrXm6pncMdPUwSWDSPFu3w05QRo2jQONz23r+RlmzVr9j0W4Y/kZ
 rWRyPEpb8Xivkfeme8eaHeJr+0O4SxFXUKH+zKBUZ5OhvcdMrG95GC9lLqbO5bDK4eKQb4/Blw
 8ql1UOolBjJdHKGfhsVL6CIPrppXzK0v+aEsN8LoRSDwIJz/n1tsDq2jumHhsmHj/0AXLib04/
 xM9ATZOFXxC4iK2kPXZ1r8Qw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:06:30 -0700
IronPort-SDR: 4XnpAdFtn15VIzjVXtd/KCOlrveogKDG3K6O85G93ihf+krpzAAe1wKNVsuZ31JbWwv2G+BrcF
 4QNfKIBSzIPrPFyyusrGJR1Ygk8gqG34FVy148iQlAx+nTOjaWqBuC894EbXH/KLkDfn0aNUQe
 vbZQ0utlX017ZpIFWyex1jeR9PdfV8YZc4+BMhMFDUedQ37gI0Ll1hxPb9WQaJeKbPDg3UbOlz
 Hmnj968q10Es2ZuWS+qC3ucPiDxAiOEPEGIDJAq7QHa57+kpw5N/KDjNMtGYAJqfa0gamNVDow
 3wo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:49:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LmdyL0X15z1Rwnl
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 03:49:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658141385; x=1660733386; bh=OROu4ES56TCFdEXfArhrVDT1PXThr0q71+z
        m8PxsoWE=; b=nlmi+XI2Yh1I0ElgLnrl5yoHWTy8ohB5uENg2UcfK7bROoOrBw3
        4h/j2J5kde3WPcfXqnGRxSxUn8s0mPBra2H4eVZ1QEIp8m7CVUa1dK4Mz5eybqIX
        MqJzg1jW9LmOTQTH032MS+SAGifI54mrPYtE6bOCU5PjBcn8m6Yc7zMbD5nc/lqf
        n6f9i0I9dI8ZoMTrAxkgvEn8ALGYg9YQdXqweBI36MV9kNhlHFVDkOeuDDk+4XMS
        nU00coxVHnqtbfGqjdw0suj1P4J5sBDIyOXd4B7bnKVcHYd67zwr8sja3HbpJrk1
        lyxcPmBWqP6JasFJ+oRdBg3ocR9f9r36myw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rQRSqppRT0_x for <linux-block@vger.kernel.org>;
        Mon, 18 Jul 2022 03:49:45 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LmdyJ3TLNz1RtVk;
        Mon, 18 Jul 2022 03:49:44 -0700 (PDT)
Message-ID: <756615d9-ca7c-5bfb-76c5-6785b3a75f4d@opensource.wdc.com>
Date:   Mon, 18 Jul 2022 19:49:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 63/63] fs/zonefs: Use the enum req_op type for tracing
 request operations
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-64-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220714180729.1065367-64-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/22 03:07, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for request
> operations.
> 
> Reviewed-by: Johannes Thumshirn <jth@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Bart,

Please change this tag to "Acked-by". Thanks.

> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/zonefs/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
> index 21501da764bd..42edcfd393ed 100644
> --- a/fs/zonefs/trace.h
> +++ b/fs/zonefs/trace.h
> @@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
>  	    TP_STRUCT__entry(
>  			     __field(dev_t, dev)
>  			     __field(ino_t, ino)
> -			     __field(int, op)
> +			     __field(enum req_op, op)
>  			     __field(sector_t, sector)
>  			     __field(sector_t, nr_sectors)
>  	    ),


-- 
Damien Le Moal
Western Digital Research
