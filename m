Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2AEC6FD1C
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 02:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCYCPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 22:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCYCPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 22:15:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FC8166E7
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 19:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679710543; x=1711246543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UHNadRGvHBsqH/afwcv27EQzesshG1PrRnsqXx7Br0E=;
  b=QoNwn0ryJgEEJWhWu6xe9009THGg/XMYd8xeF2zorfpRKWsKIt9nZANo
   MaE2s3MiQuQT2xXF1qMlJu/Nfv4371+CTi7Yq8xO0417eQP90aKygxIC5
   0WlNd2nPIPwQHRkRTgObyrovZ/R+6CHWaXIcMJM3IybEMzukvc6DbDBi1
   UHA+z3493DfCVW+nfHZ/KJuVlbX443dsyUEDao6t9XR1Xen0ueavpLkDZ
   4bIqBPhX4EDb21AXuBAhCUb/KHL/sTRFuHZ+cESdhVV02kjym/eWzmyiu
   qRK4p/o088Sk6hnW7Bz/p8SE4g8TCLuPv+bjFArNSrUZVYjbXFY+IdKKe
   A==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="226277114"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 10:15:43 +0800
IronPort-SDR: twJy0enozph24WcKDEJy9AW/yAXslDDBpKkJTebAfVI1iq+pU8aBW+n5q6bkiQRZ+UDl0/BQ1H
 4AiysZlFdcdKJIfzOlxbTtPH3GWeLPJa8ZiqWWtK0up0cH5iwUaI45PtJ3uXMQT/dV3zvXb5uh
 4m0KQyMQfNjgmXngsG/I2yEOHy2ZubQbueI9R/Q1CWt56rc7/gchqwJbSns7dlXHh0WBBb+rEy
 Rj7utSaNEWVMvA2GeRYrmJYd0YORLC9um9/6G4T2DQp8osPTUjr5cOkoF1yvwlryfgcoUv0ItU
 cyw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 18:31:58 -0700
IronPort-SDR: b8VQ2DHh8LRKEn2oqwvMqxjF31bvV2JONcOCgDnv42kJ5gTgv4fwsCjcSrwsfe+fX1u5yFzCKe
 DIvbZD5K/67EehbnBISy2FL40gKIN++V4pr8eNaT1XHdmf3PXigrhPItRzx1f3Qk42t0U20aKZ
 vhqf6/j4zUZV1vrrw86/U4Y7EtwCt+9z6qbIzTV6UN9Gcs1fvjvT6dF/sW6X2QDqSK/kz1hnMs
 kzyeroma1dmVFm9e4uh/NDD/ShwnSHr2wHmmKHExgLeDU6A9ePd5OrPob87nBIpZC3mnFjyHnh
 zr4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 19:15:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk2jq19y0z1RtVw
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 19:15:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679710542; x=1682302543; bh=UHNadRGvHBsqH/afwcv27EQzesshG1PrRns
        qXx7Br0E=; b=mFdSkqIHXjHG8fyHqm6uNAnmW3XSsISKwlX5GLT6ArXBEa4yG0e
        j/YfZSB7bYRGfuqFXDMGvUQ9J0t+zXxo7jBIzYFkX6Frt8bA0rrxxMxWStKhdgEq
        1dYsj/NUma6mcK5S6+GaaSTaeAbT2kRLAQjWHl3w0PqjWTEkYzpEmhbGYqdNTiWi
        Hc9xD+f02ZwjNSB0HybdodotqCGfjcjJuaTDc9VyjwuxRLcBFgxVbdnijKUdRnhc
        J3xAFyJca1ADDbveQyP5KRVWnf9OUf3YbhNTMnd5lA8DzFeDZk2z/WLiopLM0OoD
        4YiHmXcq+4h4ki/PRtEq/ZaiDNwKkYmUp3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sLmBaGmw7Dwf for <linux-block@vger.kernel.org>;
        Fri, 24 Mar 2023 19:15:42 -0700 (PDT)
Received: from [10.225.163.103] (unknown [10.225.163.103])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk2jn42v5z1RtVm;
        Fri, 24 Mar 2023 19:15:41 -0700 (PDT)
Message-ID: <4f48b57f-e8bb-4164-355a-95f5887bac36@opensource.wdc.com>
Date:   Sat, 25 Mar 2023 11:15:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230318062909.GB24880@lst.de>
 <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
 <20230323082756.GD21977@lst.de>
 <80988a60-f340-529a-0931-30689599e724@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <80988a60-f340-529a-0931-30689599e724@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/23 02:05, Bart Van Assche wrote:
> On 3/23/23 01:27, Christoph Hellwig wrote:
>> On Mon, Mar 20, 2023 at 10:22:41AM -0700, Bart Van Assche wrote:
>>> * T10 has not yet started with standardizing a zone append operation.
>>
>> Time to get it started then!
> 
> Hi Christoph,
> 
> If someone else wants to work on this that would be great. I do not plan 
> to work on this because I do not expect that a SCSI zone append command 
> would be standardized by the time we need it. Although there are 
> references to T10 drafts in the UFS standard, since a few months JEDEC 
> strongly prefers to refer to finalized external standards in its own 
> standards. Hence, standardizing zoned storage for UFS would have to wait 
> until T10 has published a standard that supports a zone append command. 
> INCITS published ZBC-1 in 2016, two years after the first ZBC-1 draft 
> was uploaded to the T10 servers. INCITS approved ZBC-2 this month, six 
> years after the first ZBC-2 draft was uploaded to the T10 servers. 
> Because of the long time it takes to complete new versions of T10 
> standards we plan not to wait until T10 has standardized a zone append 
> operation.

Such standardization effort is likely to face a lot of headwind because defining
a zone append command for ATA (T13 ACS) is not possible with a single
self-contained command (as one cannot return the written sector using sense data
like with scsi). And when it comes to ZBC, keeping it in sync with ZAC is desired...

-- 
Damien Le Moal
Western Digital Research

