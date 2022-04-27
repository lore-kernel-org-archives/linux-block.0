Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2731DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiD0WAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiD0WAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 18:00:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81F3114E
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651096660; x=1682632660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AUyIcwobFfV5SoYGzqqBamGFyyqRQJh2j8T40K6gwpo=;
  b=PVNPF51lLCaI5gKrEIaXmna3tBLBvrBJEUaNgNy1nw4ajCjnN4ABGISf
   T/WuJXZbX0ethSR4LS8xKJ4pqgZRatb58z+PjBz0zlxXCdowbkDiQBY9k
   A9hCE/inkOFTl0kmnI+87mB4rnqY0waVo2dVxFOD1TqxGajeEcFjEm4as
   Pp2kl6RQevl8WQesjOIgBBgunXLSyrm3TsgmYPSgN6MM5acePUfNjNGZj
   y5qab6AaZfBa32rk1oolXUpLTZQQHc7aSnYbyn+TjVFxmOUx6oDA6Dhn9
   pUmyj9jFPNL0BIEcXuPMAbTSY+jbQDAxgNWMcDfR0S0s6lYo67Ul4sJzK
   A==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="303207116"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 05:57:38 +0800
IronPort-SDR: tMzufcXe7GzenmHCAlW4sqOLxxDE0oNJrzMcGcc6l6Ppzy4qrPMOzcGkdhJzzWdqUJgXhZasGa
 ydzuzNSkX/7Odl+JW24KwtW+FLz4SGKPbo0RlmtWl9azJhLxi0A+QRWmpFJGZeZ4qRY4xMKc/M
 HyonnJqff/0QBJg+pupfkXp42aqOIiBMViqXlPTW1IMEioWcrrX9icbsaqoFhIzCny0q6fPMcO
 7B+iFAfBEIYBLHIUaCXu/aU5vPM4bRizd7ZMMoq3SEONqLmxR0P66KCZPnk9asvd0bYgP7t4rG
 RdqLHQpAqt5eUJk0/5j76kBL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:28:31 -0700
IronPort-SDR: malUrFwo1ThTcX2RjJwKa5PypwZzTg23BU/1BNdTt1IfQv4mvjoMtVoZs8B+D1ik4takn6axfN
 aj5cQGBVqV72AXGn0FYDcSW8HhrQR0Hc3XqCyv25rTHrKE4VXgqScUk2WSBN//bJdurZRgNSJc
 qZNT14x1Y8pLnaWTDlXua2YuDfXfvOd9gs8fdx5I3oEY7fMB9KrXQYc51cDncX/4EYxojb+tzJ
 NMnssPvVjB2QiJJHdzt6QUY8aKhnoVcTv3SXtViYXg5OrQAupcjHtTg2Co7ZbXeV+LqrdlSUWb
 Ib0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:57:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXfp2JPDz1SVnx
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:57:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651096657; x=1653688658; bh=AUyIcwobFfV5SoYGzqqBamGFyyqRQJh2j8T
        40K6gwpo=; b=PSstadGp5ulB2J+BWMxkaXnwwaZ8yjM0p23ACWCmqaNxmGu2kGS
        C8l6BvptPaomaiRYSqAyEpBwVAZubeO6rdS2iadrzki/hkGC2m6LaHJas2Yo0byY
        b9/2e33a44eeqtMNBaFgpcrEk472ygG6lllz6Td6b0v/IC3Xb6COAp8AGPgaIUvG
        DA37YPM7cc2BTrg4NKQT0+sj6QcAEOlIpxkKWtjy6UKghsbkrYOsdezEtdxNTpY1
        lZjeKqdK16ZbuRaO/nwXFLCpv4KwgJcUyGUvM7/EhO6RzVJtcVZ8NbXkoF2BZzMF
        oWpLBf6y7Wn2PVIlOH20Sd65u7CYkD88S2w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OptcjvB9JcV5 for <linux-block@vger.kernel.org>;
        Wed, 27 Apr 2022 14:57:37 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXfm4bP3z1Rvlc;
        Wed, 27 Apr 2022 14:57:36 -0700 (PDT)
Message-ID: <ae18fae1-c914-7bea-7c7b-861962b10c2c@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 06:57:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 01/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        inux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5@epcas5p4.samsung.com>
 <20220426101241.30100-2-nj.shetty@samsung.com>
 <0d52ad34-ab75-9672-321f-34053421c0c4@opensource.wdc.com>
 <20220427153053.GD9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427153053.GD9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/22 00:30, Nitesh Shetty wrote:
>>> +/**
>>> + * blk_queue_max_copy_sectors - set max sectors for a single copy payload
>>> + * @q:  the request queue for the device
>>> + * @max_copy_sectors: maximum number of sectors to copy
>>> + **/
>>> +void blk_queue_max_copy_sectors(struct request_queue *q,
>>
>> This should be blk_queue_max_copy_hw_sectors().
>>
> 
> acked. Reasoning being, this function is used only by driver once for setting hw
> limits ?

function name points at what limit field it sets.

-- 
Damien Le Moal
Western Digital Research
