Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F43C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 23:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiF3Xg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiF3Xg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 19:36:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2B59243
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656632177; x=1688168177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oE1CuDjTL7CND0ij2I7tM9c+S6RayPoqRq5qzkyfQwU=;
  b=omTJ7gflAqzuHjtoYv6UMvngbGta066Pw3LZ4GE7muCO4/cud2cAgkTB
   k4aRxSTPmuS7FkHxQT4E8kFR6kLOJOrMWD5AffHAPhZ7wU35sfwZHsOzL
   nnen/HrsgqHaSv8mBasuoqjO0EMKUmiFMvcmQIe9eE/KCHIcCCC0ko/5c
   RXyJxA3umjAXA1+fUK+eZMFOq2TI8tU0aK/8oMIFDvA0aElJdlw42rkb5
   xH8SPtg9onQV0yqPDuQLjFdD211oK/80/mkM/Q3c7lJ7M5JZsxhP2LCjI
   UnubTYflbCwa+GIDXLgCuAVH5PEnI2GjvrsUWlWQdOMdZCrrWWXBb0/BW
   w==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; 
   d="scan'208";a="204534384"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 07:36:13 +0800
IronPort-SDR: sJ/VdvzaWj6eP82Th6xVRo7kzz/Yo/S/6+w3ETO7RnmDV1VWGT+vaZquQMwTHEC4gxgnac7Y/Y
 esTspVEn5wxsounUbe+JTOI2AY4uuJBUrQ1xZOxkrTNcnrH8OPXzvfjhbhkQeixJj+f6TOy0AF
 Go8um/9gnFB1h/H1CKh82Je8DIbCW7dCe5nhokkT15Dpp9cYNeKLsXgK6+sgtDLISd63cC9r/r
 xwj8bcC0HqPn2eIemkGi52Cl41IwRgfvFskJ2ztWY8/myZgFRjfZcYMPZonWAGptO46jbzwrrc
 qCS7TDngbP4KEBLGtjqpcAeS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 15:53:45 -0700
IronPort-SDR: mW+UYEjWGXvh1uQ7ZR80i3vpZZLbHup1EAcL55cHRZ9eY0uZ2U6uv5jGgXqrfzKpEzrhN8Mre0
 EK7XZdHdJ5vKwV7wqBDJYh15VEJ2gaO2D2RvdUmgVQGzK6mth6rUNj5ISvpNczacEyGb5I+94A
 jozNtwgbPAHRYq/Es3MfrqxbtwlpMRaWXTvVEeO0ADsjiK+FqDIma4QRWagM7GgHaU3OYoiXCu
 RtRbLCAEHc2XPUv3HvitJcBcVb6gNJwG8y0XrRFSemqoitSI2asePgIXEspPtVnns0XZcTzsU8
 5hs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 16:36:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYvq00Z7Pz1Rwnx
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:36:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656632171; x=1659224172; bh=oE1CuDjTL7CND0ij2I7tM9c+S6RayPoqRq5
        qzkyfQwU=; b=EbwvPr0p3iD95eo0YArL2oYL0tTSE0FWkWGjuGFZu6Eh/4Se+D9
        P/pVyjuphrgHbo4B1qIILDZu5ZekvUqqBfr6SHAH2ZOYv6ZHxP/6n5hzVA9LWxWP
        tVa/CzhaoRGyKda+SkQdOiGxFtqRfyl+IFsK5qqp+eUlMU/r0QnOgAiO0aMGYNLY
        m1irrQmH1uw96a/eCfN53H1ZebA0Cw66egX9WVI83S17v+1Fsffyns2S14nrBnDR
        PTm2bTCmjLo4kH9el7LtCGmmmcPr6TPSWR/kX8eBg6yJZVMH+V4VeX9yWIdtEhu/
        bRcf8v1IV+BRjLdESEwmZY5aqwiflrnOaIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1cFgYPG1AFWB for <linux-block@vger.kernel.org>;
        Thu, 30 Jun 2022 16:36:11 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYvpz0Xvlz1RtVk;
        Thu, 30 Jun 2022 16:36:10 -0700 (PDT)
Message-ID: <2fb30812-f402-b792-d310-221983524100@opensource.wdc.com>
Date:   Fri, 1 Jul 2022 08:36:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 29/63] dm/zone: Use the enum req_op type
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-30-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629233145.2779494-30-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 08:31, Bart Van Assche wrote:
> Use the enum req_op type for request operations instead of unsigned int.
> This patch fixes a sparse warning that has been introduced by making
> enum req_op __bitwise.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/md/dm-zone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3e7b1fe1580b..2e87237a35a5 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -361,7 +361,7 @@ static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
>  }
>  
>  struct orig_bio_details {
> -	unsigned int op;
> +	enum req_op op;
>  	unsigned int nr_sectors;
>  };
>  

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
