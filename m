Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E5C433F5
	for <linux-block@archiver.kernel.org>; Sat, 12 Mar 2022 08:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiCLILE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Mar 2022 03:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiCLILD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Mar 2022 03:11:03 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD85268C29
        for <linux-block@vger.kernel.org>; Sat, 12 Mar 2022 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647072599; x=1678608599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xg8uSEFC4VVSOLUzy8XVH2UP2EqFKRvXohpU2kfNqDs=;
  b=SAskeFm7Wr/n/osjy+UC0CVab3d+vVmBRfmOCtSeOYdugIGgGTIGTOeQ
   O/hAkBWK1XFs9KE2Z8KnAD5GF8MUjrXOWVXLi1P1hm1XmAWfHhl/zGPYK
   NtTVRSO5fosoIsGNnM6skfiXJaDSAavrxmCYGZhyfhq8btPbl6oBgQ6Kl
   eYXTPh3vv0tcqySY5LQKPDosoAyCuzJCiAgNi5eiLbTA/sJ88aQ++AKFA
   RxAK19t86OGDqaRvalPhRL/gF25OWP1hFtneiXFdrYr1/taesmeG4UBQd
   rTOocnbkjRyta8VMxStKF6pPGpyzivel1ZLhqLc6fdUfoLIEu0LO2fSiZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,175,1643644800"; 
   d="scan'208";a="196114690"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2022 16:09:59 +0800
IronPort-SDR: Mv90GjG83RqjSHuaDSw+/7fEV129TOY+StTILdqnT6G/TaYjxngTqSbzI+gViJ9UIlxnpwF6k0
 40y/1t3pBf2PBpFhXge6dLzPz3RTjZ8OJxXawwo5QffuHv5okSak8KtE/jed4DydiMeP8otpOh
 jAMKgjk3ceNfwWTWyFjGU2b7A6BYvWn6a+MYUOSy7Ev86zd3XlM/lFHrauDK6kc7aT1/CA7TWB
 9Bn0rJmqqxcFPiTaAG/+09N9o6A3R7JLJmMD+ZO/AaZBgpM3O6RxwukmPpNTfNgqgsPEmHJS+/
 sL4gc/kp8AhzJbdtme58d9x7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:42:09 -0800
IronPort-SDR: fE8u2e+MHr7jsLXay+zE08XZ8C/+5b0zkCRbxEqYAoCD8j+QYFC+RL3Q7Uy4qeK20S2oSkrVnH
 wSaPYRubAwCKBZ01ZQhxnc32uBTyOblW3QUjKxU7ocMfgNLzRMjXZnjcFFJEm3HqBa7NrJFkM0
 /SYGBlgwPAtP/Eb+xyt1KdrkeFigm6oVJTjJkB4J0GGSVDTkYSiTY/+rolRFwDZ0m4DYPgsloL
 tKd76NZaOlodrawyr23rNmd3FRbWAVIXy3R+gSJRJdYYU8EKpjiJai6GZDQZW2oNDm1XOyBfdo
 GkE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 00:09:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFwT20GQqz1SVp0
        for <linux-block@vger.kernel.org>; Sat, 12 Mar 2022 00:09:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647072597; x=1649664598; bh=Xg8uSEFC4VVSOLUzy8XVH2UP2EqFKRvXohp
        U2kfNqDs=; b=bUlxQEyf5YNOaXAIzafgjDdDEvysiik5N/qu/BWRFppOCOKl54g
        U0to5GEf8ZHhN/O+D9vLzG0mfgJjKR9bXWbb3rFYrP6Q0SBrL5N25lX+XXAhefjQ
        fvj52z2ylKne9ODgq1zmVb4OS6U4UNzP7nQ+oF0R5kWYnMl98vIxC7gk/GqUMkrQ
        T6EVQ51rDK9YEdWD4PwFbh1tOW3ipP9QGiM/uBGGyELwIP3enFYIZ6kqLYg7Oms8
        iqS4wznT2Y+keszTIPRf3h6BkRgIxpYkrLtWEynlc8jk/4QxZZj4tiUGyk85Ihf8
        qTEroOPLy/xsAr2DKxjkWfYfiqDBGhnxeJQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Npr2XWRg78LY for <linux-block@vger.kernel.org>;
        Sat, 12 Mar 2022 00:09:57 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFwSz5gRXz1Rvlx;
        Sat, 12 Mar 2022 00:09:55 -0800 (PST)
Message-ID: <c0a6065c-3e89-a4be-e257-ce25711e4368@opensource.wdc.com>
Date:   Sat, 12 Mar 2022 17:09:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v0] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310212812.13944-1-linux@zary.sk>
 <e41b526d-18d4-ae05-976d-3021e739cd8e@opensource.wdc.com>
 <202203111955.15743.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202203111955.15743.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/22 03:55, Ondrej Zary wrote:
> On Friday 11 March 2022 00:59:20 Damien Le Moal wrote:
>> On 3/11/22 06:28, Ondrej Zary wrote:
>>> Add pata_parport (PARIDE replacement) core libata driver.
>>>
>>> The original paride protocol modules are used for now so allow them to
>>> be compiled without old PARIDE core.
>>>
>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>> ---
>>>  drivers/Makefile                   |   2 +-
>>>  drivers/ata/Kconfig                |  22 +
>>>  drivers/ata/Makefile               |   2 +
>>>  drivers/ata/parport/Makefile       |   3 +
>>>  drivers/ata/parport/pata_parport.c | 805 +++++++++++++++++++++++++++++
>>>  drivers/ata/parport/pata_parport.h | 108 ++++
>>>  drivers/block/paride/Kconfig       |  32 +-
>>>  drivers/block/paride/paride.h      |   5 +
>>>  8 files changed, 962 insertions(+), 17 deletions(-)
>>>  create mode 100644 drivers/ata/parport/Makefile
>>>  create mode 100644 drivers/ata/parport/pata_parport.c
>>>  create mode 100644 drivers/ata/parport/pata_parport.h
>>>
>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>> index a110338c860c..8ec515f3614e 100644
>>> --- a/drivers/Makefile
>>> +++ b/drivers/Makefile
>>> @@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
>>>  obj-$(CONFIG_SBUS)		+= sbus/
>>>  obj-$(CONFIG_ZORRO)		+= zorro/
>>>  obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
>>> -obj-$(CONFIG_PARIDE) 		+= block/paride/
>>> +obj-y		 		+= block/paride/
>>>  obj-$(CONFIG_TC)		+= tc/
>>>  obj-$(CONFIG_USB_PHY)		+= usb/
>>>  obj-$(CONFIG_USB)		+= usb/
>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>> index e5641e6c52ee..671c27b77a48 100644
>>> --- a/drivers/ata/Kconfig
>>> +++ b/drivers/ata/Kconfig
>>> @@ -1161,6 +1161,28 @@ config PATA_WINBOND_VLB
>>>  	  Support for the Winbond W83759A controller on Vesa Local Bus
>>>  	  systems.
>>>  
>>> +config PATA_PARPORT
>>> +	tristate "Parallel port IDE device support"
>>> +	depends on PARPORT_PC && PARIDE=n
>>
>> This is very confusing. The change above this one switch paride
>> compilation to be unconditional, regardless of CONFIG_PARIDE value, but
>> here, you have the dependency to PARIDE=n. I do not understand... Please
>> clarify.
> 
> pata_parport will use existing paride protocol modules. So the paride/ directory must be processed to compile the protocol modules (if they're enabled) even if paride is not enabled.
> 
> pata_parport and paride are mutually exclusive because the binary protocol modules are incompatible (the struct pi_adapter is different).

So if both CONFIG_PARIDE and CONFIG_PATA_PARPORT are disabled, there
should be no need to compile the core PARIDE code under block/. You
should have something like:

In drivers/Makefile:

-obj-$(CONFIG_PARIDE) 		+= block/paride/
+obj-$(CONFIG_PARIDE_CORE) 	+= block/paride/

And then have CONFIG_PARIDE and CONFIG_PATA_PARPORT select PARIDE_CORE,
with CONFIG_PARIDE and CONFIG_PATA_PARPORT being mutually exclusive
(using "depends on" as you did).

Here, I am assuming that block/paride is the core code used by both
PARIDE and PATA_PARPORT. Not sure what PARPORT_PC does nor what its
dependency on block/paride code is.


-- 
Damien Le Moal
Western Digital Research
