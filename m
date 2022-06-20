Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 23:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbiFTXpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiFTXpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 19:45:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4513E28
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655768747; x=1687304747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y6tM8XCp0NMNLM8k0kuJ4OfaHAUS9OfXGe/dBDVE6ZQ=;
  b=aeiTC9xghO16yozwHSW/qEvPfmE9a+1MHLIEmDPww7Hd8TIo2cV4sQE4
   Z+p+tCzJTMpWUIXF8d+g7HpFchjE8QxX70I0fL4nBHdG3Ko82D3Rxb2Zt
   Uiy1Z5K1S8yS+riBWG5I39XiAXS4U3umPcsRKMla8Bk3nUUF9/jUerU4p
   Ptsv2OTyVUa3Yu6Gwh7ySvIzKjw0XziDDTjfG740ZqBokqIB4bU6c1e/3
   83cTQglsJsy14vtgJRE8JJ/sDW1Z4XN8oOit9cqVBP1uBX0u4HTh/mo7E
   39cwrG/ppDQyJFNU5S677t4LMfJdB2Es1D41Y76LUl4XqW31W4ftxLQk+
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="203663101"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 07:45:46 +0800
IronPort-SDR: v+/c/slp4PCPf/+ArItjUCZXqCkl6KHWdy3EIREEJban0GPKtsh1YpgPymrqbiwHuj+b4UpGrb
 7A3q9KEdljsbl0/gE9F3bvYiNdprF5rDFkCh4AR8xVXTBBYmW2smCVIA+/ZAU+Ah5lKgU5VTf4
 sz14XuG29hFDiBFT6vohj5MtB2gOhlOVPELpeLw8PsJXL0rj7f/9RkQgncyrMTTfRs+Ih0W1Pb
 TgJbPBxybFKZywejH4LFrogUrMR6YgtVgCHGcalgO4DvfutK+HSwa/+/Rxpxe+GRpgBVYzzAWD
 G78/btZBeXudUWBhZM5MLLXE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:08:19 -0700
IronPort-SDR: YEiRts0+gpDEkwmNAMO2FWSqmH6FQEzkuFMTT4dXhVA8/yHQnSuKaOET3Ki6jU/t4ErAym1HM0
 hFlfFqDiTnoEy+3xiufThoH/WQkJY+J4u4xReriLeqP5bQooQUnIaKuqHh/Dv+unwv69KUR7cz
 CDQZ+SYu6t2xlF8UCvKTkYerEWZeKJbd7Uj4YD1eSNxghLoXHFH4VTzMdC2avTitxEiYbCjJXD
 qLCjczePPhXuxFo/DFUFbgNDklYSLEImNoQsRLZ8YgXNegi64Qtq9Y2/emXodt2UAkeW9ugmYz
 eGs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:45:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmVg5LSCz1SVny
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:45:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655768747; x=1658360748; bh=Y6tM8XCp0NMNLM8k0kuJ4OfaHAUS9OfXGe/
        dBDVE6ZQ=; b=gHi3KVSnQNgrzEUR1z32jVo7MU0Fa7nzRaCT5eSlIENie/6Myt+
        LnVWr/7UqXNiRM7f9+ctSvreUjpUGTtrCCRsk3uc7fG4QfNnpP+OErDjb5fUDnem
        0MCN40CineLrUCbyfv8tH1cLFiP1Ge9viN88z1MVM+J8NTSEtfN5Do4/C776U8ia
        Q5av0HrH9SrCjDwmIPF5wAonen9Qod9yaSq155mpMtDAIbAxyQnVmMget5moYr8U
        I/v+16nzoihzxSndjdiYn2v8jCaXXAilY7JIho91tr9ZVn6s1ZVP5e7lDeCGNvCU
        Oz5Gc7Q/gS8CFyLm6GR0462qphsEuDS8iMg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FV8M_Y7qmhsw for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 16:45:47 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmVf3rs5z1Rvlc;
        Mon, 20 Jun 2022 16:45:46 -0700 (PDT)
Message-ID: <c9fa7f6e-e197-71a7-28e5-8e9321c411a3@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 08:45:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/8] block: Return effective IO priority from
 get_current_ioprio()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-2-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> get_current_ioprio() is used to initialize IO priority of various
> requests. As such it should be returning the effective IO priority of
> the task (i.e., reflecting the fact that unset IO priority should get
> set based on task's CPU priority) so that the conversion is concentrated
> in one place.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/ioprio.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 3d088a88f832..61ed6bb4998e 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -53,10 +53,17 @@ static inline int task_nice_ioclass(struct task_struct *task)
>  static inline int get_current_ioprio(void)
>  {
>  	struct io_context *ioc = current->io_context;
> +	int prio;
>  
>  	if (ioc)
> -		return ioc->ioprio;
> -	return IOPRIO_DEFAULT;
> +		prio = ioc->ioprio;
> +	else
> +		prio = IOPRIO_DEFAULT;
> +
> +	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> +		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> +					 task_nice_ioprio(current));
> +	return prio;
>  }
>  
>  /*

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
