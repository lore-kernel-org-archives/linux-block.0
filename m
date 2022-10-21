Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1C9C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJUJo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJUJos (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3F17E06
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666345487; x=1697881487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgwdjJKPZPX+hKe4JRhoUMLH+DE6WQ8e4O5Rsh5JLF8=;
  b=UZohTR/vWgKDeMPU85M58FB5ntv6Eyme5pbkqNIf7g1WP/Eyaw501woH
   TJAPPxvbrpGBM7KvqiF23BDiyBGd4kbyMWelLrPDqakkkw7pRKJbqoq3h
   ttmIugLtUWDsG/tnKy3ReuDILPXaYGSlOqZVwuegAuDMCeo019d+akXEe
   Hsi1x9gR0u+We8G/aU2AHIKGqp0AqK/YipEydKJR7hEz4klORsCjL0krJ
   AK6MnQdjtNLpEf/qYDNSkSMt39rISb2as4OeN9QFXOK9wE3DHnsC7GG52
   Av3+TEaYxNWgcH3oetUAz6FbNeUjNFfU8tu93qDWp3f1kxjJEb8HEjYz/
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214423016"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 17:44:45 +0800
IronPort-SDR: stN650Fb5Ew0mV4vFu7XPKecRWs9rB7y1TH9I0Ygjyqxrj6tPSrP0qIYShbJWpokA/3xEi9RHV
 3F3EA/Bs2ApkbKVFf9Kdr2ZjC0aswI7AaFvYi/+ou2gKphSHusnmLzycM5Icq/xIR4cxWAjB0Z
 AH9xFieFrcoMCEKYl3uhmP9cMkZ9vuI1d5x8PX9qekRvz8lU18w8MN3bSOqhcv21/Ol5k0s5jd
 HzvVT2mkJuU/QcbVwh9WJF0TDeP3ozBdevARlyzriKgRsZp8Ry7PeiAaHK5HVZ8MKlT9DvFR+W
 fLF3C0yhzVUVjWsDEV9Y0Bb0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 01:58:32 -0700
IronPort-SDR: TU/IrETOcWbnND/nlJJQI4tQbqzTpCWi3e8tmDagF7LN6g00VN+napLnk9bXOHnGV9KzaWtlbT
 kL5eEYQ6Iz67wIo4ebY6E9amqOrSTHXFWf95mbtWDIAO5WutcnJvZu8xh7OP8QUHevUcwYcnpJ
 YFQGN3zex1oHT9v75/SP9Vg7CyGMANG5yC1sXVhDMbp3k9QtCZrhHbMfRujJC+Q+gtpiRcxACE
 vhDYTZwbuLtT05Ww9Aeh5QRz7qXxg1vLj+oKH6jQnX7IULNzNJSRTostZKNygMv7hjULoaeyeY
 gxI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 02:44:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mv01S2kMgz1Rwtl
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 02:44:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666345483; x=1668937484; bh=CgwdjJKPZPX+hKe4JRhoUMLH+DE6WQ8e4O5
        Rsh5JLF8=; b=tXuDtvmKYPjGFcT2CMA37c8E6tjf6AYAIDO61AGUJGEPvrYYFCK
        +ORp1LW+Pqn1WRuzcU9M2jyuOjL2fnf9bpiJ+DaAl9E83lOzxha1h7CH0r6ewwaV
        2s2wO/5aoa/nxr2Zjl0wlf5bWoSxX4Xwczivzmb+LDvtO60tKqEsDKrX6Y54biVL
        jUG1SmPBgqS5l+AUxul7kaMiRL2MzE0BcjMFg8EyQUVZHBuRdi/izLUiXgc35yIK
        Vrx2I7S30D2OFHum7nSUDFXe3l/SSURdeByPkGnO4FA+XJ4Gd3ZO2LQ2QM2yJOu7
        WOHDUor8Haj3lnIL5GD58TMd9F1FBUG6RlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eNHiCtHVzeBf for <linux-block@vger.kernel.org>;
        Fri, 21 Oct 2022 02:44:43 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mv01P5zHNz1RvLy;
        Fri, 21 Oct 2022 02:44:41 -0700 (PDT)
Message-ID: <e62600da-4a1c-f797-8fdb-2938ca58f25e@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 18:44:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH linux-next] null_blk: use sysfs_emit() to instead of
 scnprintf()
Content-Language: en-US
To:     yexingchen116@gmail.com, axboe@kernel.dk
Cc:     kch@nvidia.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
References: <20221021085446.414696-1-ye.xingchen@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221021085446.414696-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/22 17:54, yexingchen116@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 1f154f92f4c2..5317ef2ba227 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -255,18 +255,18 @@ static inline struct nullb_device *to_nullb_device(struct config_item *item)
>  
>  static inline ssize_t nullb_device_uint_attr_show(unsigned int val, char *page)
>  {
> -	return snprintf(page, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(page, "%u\n", val);
>  }
>  
>  static inline ssize_t nullb_device_ulong_attr_show(unsigned long val,
>  	char *page)
>  {
> -	return snprintf(page, PAGE_SIZE, "%lu\n", val);
> +	return sysfs_emit(page, "%lu\n", val);
>  }
>  
>  static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
>  {
> -	return snprintf(page, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(page, "%u\n", val);
>  }
>  
>  static ssize_t nullb_device_uint_attr_store(unsigned int *val,

-- 
Damien Le Moal
Western Digital Research

