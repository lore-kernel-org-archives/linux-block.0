Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C6C4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 12:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKGMdD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiKGMdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 07:33:02 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814E2668
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 04:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667824380; x=1699360380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CaEWyVkrQu7bNxv5fsYpUFQ28pAMyICWbup2FdM6iZ4=;
  b=n60k852lTBFQFJZxq32IlPqLg/c+yAoL1G4b3TWQo1awR1ecARj+GqNl
   b7zCHPTzFY1t/MBhSWhpkI2/zHLUT25dDGQtx6CzeMeEZxO25pDmGWpdp
   pjiYZAB17BpWd/sM0nNp3lH8mbfUdyCSUX2lj8N6/UaeHsd0wr1vZLrIf
   ZUTZsdm4FCk4nhO8o1irYuNa77asSEAxTuYmmoMNPo9RVun480lUNKT0M
   bCxN3+uCU8ALD44lQJ9JqEIu5iXE+bhQ6PXEMWax1sh8ch4Xr/V0uv4YL
   h2LupCR6+4o+GAs9yClM8c/u0duBqYQq3fFXo/gCfRaRLIDVkWXsaEcrH
   g==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="213948730"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 20:32:59 +0800
IronPort-SDR: UHeXVI1E8hABxex6eBB/OV2UVY+P1myjhIyCxfNCX5SOztICFRBvWeCcOMGCwNNXXxP8gh4avF
 U6CwWzleJsc/FG114OZHDsDDJB93o6TUyHdRs7k1FcL7SDJ50IdO6GuUWh/cmvSkNK+UR6GKj0
 kF4kCSjlp6kdlOyFJUJFCpseq85ewG9aaJvVgv2fSGKpN/t55K4ESUruA9yOzdbtBgy9HtoOHf
 o8Hpqb343rE9MrGLOIVzxFHBrfuCHu3Nq20Ou+pyk7fwnaKGC4LM2PjonKIdMiGA1w6SA2VITX
 q+s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 03:52:06 -0800
IronPort-SDR: +WKHE0kqQGdBthSbleEG1BdIYo9xbEMga6SQozc61Vz2AOY5F38zCtWSganrirnXdufVvTX540
 ZEXBLL/bcOpkbJA5K/oL/knSvtaiN2+Qiv/16fbTf8LzDzYP0vuHDnERzt6BOz8Sc0a7sBRr6v
 cWI4fiOXQsfB68pLODF5h/vKaq6qLf0u5q5mjz25DoCwLgJnNveQJiwZ4iqMY7eEhFHp3PXwEe
 QsK9bjJNMNcdEX/oheMSw0AA6wwwbREHzEPxq+iZIk1ybFst3AElQ91zzaWS7GONrubkzQm3td
 20w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 04:32:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5Vxl0n05z1RwqL
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 04:32:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667824378; x=1670416379; bh=CaEWyVkrQu7bNxv5fsYpUFQ28pAMyICWbup
        2FdM6iZ4=; b=QYY/yZKEHkgbOA93C9mI/xIU8vgHduxLBOlXdtT/ZEQB0Sz/qGc
        GGAmaMUV6GgF6/Oze0sbLi4WDocPstzoDApF+RW4Qcj26lWTrkV6m1m1fqcok2BN
        9gtqq7qazkJmpeht0ymiy2EvNd8PDCOB5/ftie2A+xhfHIZ1254yxXNSqjPGpFeF
        UwAKiq0PC8AStJoNa2OhpAHcyWSxdpTazUv3aJQaHi/Q9uqpvbdxjXhQxGMiPJ6S
        L+moDhXo4mi0w+0E0yASqAvHIs3S94Z7dwThPK55S4NgybkFj5daSS/EfMD5CMJw
        wxPoqyzF/ssm3J6npp6NXD9BnOv6DxiFjFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uXJtWrFEHfZy for <linux-block@vger.kernel.org>;
        Mon,  7 Nov 2022 04:32:58 -0800 (PST)
Received: from [10.225.163.31] (unknown [10.225.163.31])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5Vxj4kjHz1RvLy;
        Mon,  7 Nov 2022 04:32:57 -0800 (PST)
Message-ID: <e4f4f8a6-34e1-428a-7e1f-dc66ded93887@opensource.wdc.com>
Date:   Mon, 7 Nov 2022 21:32:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com>
 <20221107055000.GD28873@lst.de>
 <ca10f501-0d3e-fcae-2b98-d39ca1822a67@opensource.wdc.com>
 <20221107121627.GA17441@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107121627.GA17441@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/7/22 21:16, Christoph Hellwig wrote:
> On Mon, Nov 07, 2022 at 09:12:57PM +0900, Damien Le Moal wrote:
>> On 11/7/22 14:50, Christoph Hellwig wrote:
>>> On Mon, Nov 07, 2022 at 09:50:19AM +0900, Damien Le Moal wrote:
>>>> Finally, since the block layer should never issue a FUA read
>>>> request, warn in ata_build_rw_tf() if we see such request.
>>>
>>> Couldn't this be triggered using SG_IO passthrough with a SCSI 
>>> WRITE* command that has the FUA bit set?
>>
>> Yes indeed. Should I drop the warn ?
> 
> I think the warn needs to go.  But don't we also need to handle the
> non-NCQ fua case if we don't want to break pure passthrough appliations?
> Or do we simply not care?  In the latter case we'll at least need a
> comment documenting that tradeoff.

I am tempted to say "not care" since it has been like this since forever,
silently letting FUA read through that do not do FUA at all...

I am also tempted to say "let's add a check and fail those FUA reads that
are not supported", that is, essentially stop hiding errors to the user.
Bad passthrough applications that were working would stop working. Is that
considered breaking the app if it was bad in the first place ?

-- 
Damien Le Moal
Western Digital Research

