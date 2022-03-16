Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB13C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 01:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiCPBqR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 21:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiCPBqR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 21:46:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1955366AE
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 18:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647395101; x=1678931101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BUDKqmZbcVaCzgnu+xxYVNx0j3TydSNyBEHMbCgsSwY=;
  b=Rdk8LclVHNu6oBJQx2T8tWbM/jLPJGAK1CTDKb7yaj6yJwXM2cG0lCPL
   umvZfD4S4y0NOiZDvNNk9Rip9x2Au1OUMGV9XbI+p2fzTSYPUbc8HsRHb
   7D7EaE/kHTRNoHTVzOOezYe6wtl0iB+aim6Cy/DXSrFXZwGw9dNnZay6k
   eUmL7keFYWByii2R+aX/WtCu2yweMDehZWukjZqqGhCyDiIouqER2Mys8
   45rqqqfUMv7+BPArISlRyo4PFhz9YqiRPRw8E8gWBn16DxXcJaQtUSLQ1
   hKHzN8YEtYwf6uIglNWwhyBAdWuSn6X2y0F5g7FIR1IFRtbFALtC5yc3W
   w==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="195461087"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 09:45:00 +0800
IronPort-SDR: Ls1Azk9A0avm+G8kfUfUPy4/ZiRWZelsWuvVci/W/4vA1+gR4CV4KX6cqBLVTTK+gOuMKu0ayP
 omEFMXrNZfbBQbjpkwH77JgXRa5uVOlxxZp5WdNpWX7URBvo3PsZss4eYIEw8NyaCHimC/6pDn
 jqL3nmKIm2Zf5A1Rq9gm7pR3c6kR5JqBFanCHS+wAi0ak8mXK3NQQ8UW6r2ukSyn/kwrS1XBBo
 TI4xHJHZcBqifYnBCeg0cenheZPBNjfQrHM+OZKj+GudegOaBGLok/sna3ezC6q6oHkGfVq1EQ
 KQMo6nGDQF7wetOdSPzuK0v9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 18:16:08 -0700
IronPort-SDR: GFfRBFgdLTWyhJd1V0wxi5GkpnRpSqzL06xYPOs1LtGr7oxZzaYOX3rJ8ACyEdCdY5ISis86jg
 6JYD6tkeMaqHd06nkrJrqEVahQmZvPVZZm10KifDnciUeOu/Y/r3ISMBBYSCXH/V7D4VOBTJFZ
 pqFFjqwtoX9knb9yp4H+p9Uu2+i5vJ+jWOrbBRZujDDG4PmTIVexcxy0FEtYlAiYFN+/SbnDC5
 MdWW3HIBavx5RQGgM8pJzGMWwpGVG8ORKW52UjkpWdWQ+VrpYhghNMlQed5CmYlB0lIFmORN5T
 U5c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 18:45:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJCl12nFsz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 18:45:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647395100; x=1649987101; bh=BUDKqmZbcVaCzgnu+xxYVNx0j3TydSNyBEH
        MbCgsSwY=; b=QHDXUtUXGlmTo36w7FxWaBnZ/RDjmxvoQtkuIiHF8r6HJvmUhlo
        rHiSUeRVbzI05Ki//9Zh8AXfSsKGnTJLQAxdqNkv9nOMUb8ywXBfLYY4pvMnGvOG
        gyoF0fvgEPh4j0WhM936WpX8A3QDq7Wh3sR14kaJqwqDVlGD/ZcXLj9itu72jw8h
        jmTztNzibijkjP/ux/C0hkDrYQCLXcRk55/Eeumdgp+9FMhhVgbtKNAA5fKbo+c5
        8vIHLZvW9HQdw7ObHpg2ut2hcB5AbeIvdV45JvFNj+cLmSD1qinaqGEs++X7y67m
        egaolzX00URHM32l8WU/gBS6cijAACMZj6A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mr8a6PXRP1Ft for <linux-block@vger.kernel.org>;
        Tue, 15 Mar 2022 18:45:00 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJCkx5c4Hz1Rvlx;
        Tue, 15 Mar 2022 18:44:57 -0700 (PDT)
Message-ID: <8e842ca0-1885-4738-0099-24409c108b2a@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 10:44:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
 <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 10:24, Luis Chamberlain wrote:
> On Wed, Mar 16, 2022 at 09:46:44AM +0900, Damien Le Moal wrote:
>> On 3/16/22 09:23, Luis Chamberlain wrote:
>>> What applications? ZNS does not incur a PO2 requirement. So I really
>>> want to know what applications make this assumption and would break
>>> because all of a sudden say NPO2 is supported.
>>
>> Exactly. What applications ? For ZNS, I cannot say as devices have not
>> been available for long. But neither can you.
> 
> I can tell you we there is an existing NPO2 ZNS customer which chimed on
> the discussion and they described having to carry a delta to support
> NPO2 ZNS. So if you cannot tell me of a ZNS application which is going to
> break to add NPO2 support then your original point is not valid of
> suggesting that there would be a break.
> 
>>> Why would that break those ZNS applications?
>>
>> Please keep in mind that there are power of 2 zone sized ZNS devices out
>> there.
> 
> No one is saying otherwise.
> 
>> Applications designed for these devices and optimized to do bit
>> shift arithmetic using the power of 2 size property will break.
> 
> They must not be ZNS. So they can continue to chug on.
> 
>> What the
>> plan for that case ? How will you address these users complaints ?
> 
> They are not ZNS so they don't have to worry about ZNS.
> 
> ZNS applications must be aware of that fact that NPO2 can exist.
> ZNS applications must be aware of that fact that any vendor may one day
> sell NPO2 devices.
> 
>>>> Allowing non power of 2 zone size may prevent applications running today
>>>> to run properly on these non power of 2 zone size devices. *not* nice.
>>>
>>> Applications which want to support ZNS have to take into consideration
>>> that NPO2 is posisble and there existing users of that world today.
>>
>> Which is really an ugly approach.
> 
> Ugly is relative and subjective. NAND does not force PO2.
> 
>> The kernel
> 
> <etc> And back you go to kernel talk. I thought you wanted to
> focus on applications.
> 
>> Applications correctly designed for SMR can thus also run on ZNS too.
> 
> That seems to be an incorrect assumption given ZNS drives exist
> with NPO2. So you can probably say that some SMR applications can work
> with PO2 ZNS drives. That is a more correct statement.
> 
>> With this in mind, the spectrum of applications that would break on non
>> power of 2 ZNS devices is suddenly much larger.
> 
> We already determined you cannot identify any ZNS specific application
> which would break.
> 
> SMR != ZNS

Not for the block layer nor for any in-kernel users above it today. We
should not drive toward differentiating device types but unify them
under a common interface that works for everything, including
applications. That is why we have zone append emulation in the scsi disk
driver.

Considering the zone size requirement problem in the context of ZNS only
is thus far from ideal in my opinion, to say the least.


-- 
Damien Le Moal
Western Digital Research
