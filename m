Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9EC48BE4
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 00:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHYAPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiHYAPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 20:15:33 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3E6C75F
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661386532; x=1692922532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NQ6YMt/Gh3taRCiJQmF6o9X3VadrlfeoDwP2+Ym6YvI=;
  b=hcFtx2RS41kUYL7B0Pc4f21k766wGl+ithFnBZylk82eHPJ9sIL6lRNI
   qyAAhxp6B0FJKXVJfs/pEXDO2BlXwD6sUUPmEb/nhaQ459vv4HJiKTx9V
   94cFhMP07Kvf2f2yxe7tMrdi4k/cGJyDIw52l0DaGMFsK8G73M2jfPHNg
   pTHli5cQlfQgHDwwf37sLP13l7YSejMGRFYdrECFxoiE5eecPZOBXrHep
   JWXZ4s3/pueoTB51PYH8JKl6Jhxk4W2u9o4zpIPffjHEDOURSa4FYHpdN
   qMsJj1hL7oZWjhA3M+3RnnsHu5X/ikVtauzMCEKrZqUpg0+QIr/Ox4nJ5
   A==;
X-IronPort-AV: E=Sophos;i="5.93,261,1654531200"; 
   d="scan'208";a="214736281"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 08:15:32 +0800
IronPort-SDR: 1iXfuDrxOVf8GGrCbsz0En1GZhVB2SkUJTGZKHbtAYwbUmHkt+lZj02nLRq0nOla3sAVQLJfxG
 GrDG6PZn9IxWmzqINTHGUI7kz955kLCOPwTEWptoV43z6Rf2IzOWe+6IT5qAJGxfmvs72k0n4L
 Y94ss7S2VNVt5zR+YI5cl+gU5a2A3vJLTAob9SmTUCgKXJ5D36XZi1MI61tzqvrpiaPOuPFTkI
 1C7uFPgFsClfo/MzYXlfefM+UA2bncc93ZNXy4D+cL+8fJ0JIS8kSO2BFoMdb8/qb9SGj7RQN7
 FNdoywLyjk1b9L0E9nuEiR3r
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 16:30:47 -0700
IronPort-SDR: 5uTRo3jANB7M8tKNIfDa7qkUw28aU3KA2pyQvQDn0ix21rLKxhUb05R+NOLNsRs1okYE/WKeiV
 ekxiDhq9q+xYxreTjwdc9XPUvVc+bCtHldYe/2EgvW/2cwY3zaFixiJ4XlF3r0444TDiOPxEJf
 /U6F9JQ/EDtLxhgZXcfaIQiXgUScvHNSvPF/K6w+R26PGaeZxg5mmv038s0LnitThjdYb+s7bw
 VI2O8D0w0z5ME/J2pyEa2KOqHW7vNN9KtyNHa8ptPXLQ15zLlTS/jbQcHuy8/9+LmO732qYcsJ
 3jg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 17:15:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MCk500GnMz1Rwnl
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 17:15:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661386531; x=1663978532; bh=NQ6YMt/Gh3taRCiJQmF6o9X3VadrlfeoDwP
        2+Ym6YvI=; b=f5MKhf91jeWoqx69eVdOIig+38dZxi+8cPTnEjrYiTHKWYrPk+B
        a5kmyUfMwt6cEXwxmhQk4QvPfXUcoAUSAWGQloBjtsLUEqN8ktQppXAD8ZtClzdE
        NE1uwE3jShdZDkNxMS0jTSHBnqYOpDEen6hEuUVxAvdlHgFio2LzxtyYeZLBnwvo
        irB64osQy9PBKQZ/YmKia3WZ18mfysJO5HX2a/s290hL2x5c1bSWYO+t6n9JDRD1
        oihFUUTCk+/B6eKFKrb96lGnlP3DXrLv14Qmu8tvqBSHNlJ6HxAyKEd8Nt1lte5Y
        cWcNGao12pCCDQMmnzINr/JEXDp25pWqshQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XBdyZmkfvogo for <linux-block@vger.kernel.org>;
        Wed, 24 Aug 2022 17:15:31 -0700 (PDT)
Received: from [10.89.82.240] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.240])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MCk4x5QNsz1RtVk;
        Wed, 24 Aug 2022 17:15:29 -0700 (PDT)
Message-ID: <589cb29e-d2aa-085f-db83-fa718f4fbef2@opensource.wdc.com>
Date:   Wed, 24 Aug 2022 17:15:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ANNOUNCE] CFP: Zoned Storage Microconference - Linux Plumbers
 Conference 2022
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <CGME20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2@uscas1p1.samsung.com>
 <20220522220128.GA347919@bgt-140510-bm01>
 <89b2bb4b-1848-22cc-9814-6cb6726afc18@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <89b2bb4b-1848-22cc-9814-6cb6726afc18@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/24 16:43, Bart Van Assche wrote:
> On 5/22/22 15:01, Adam Manzanares wrote:
>> Zoned Storage Devices (SMR HDDs and ZNS SSDs) have demonstrated that they can
>> improve storage capacity, throughput, and latency over conventional storage
>> devices for many workloads. Zoned storage technology is deployed at scale in
>> some of the largest data centers in the world. There's already a
>> well-established set of storage vendors with increasing device availability and
>> a mature software foundation for interacting with zoned storage devices is
>> available. Zoned storage software support is evolving and their is room for
>> increased file-system support and additional userspace applications.
>>
>> The Zoned Storage microconference focuses on evolving the Linux zoned
>> storage ecosystem by improving kernel support, file systems, and applications.
>> In addition, the forum allows us to open the discussion to incorporate and grow
>> the zoned storage community making sure to meet everyone's needs and
>> expectations. Finally, it is an excellent opportunity for anyone interested in
>> zoned storage devices to meet and discuss how we can move the ecosystem forward
>> together.
> 
> Hi Adam,
> 
> On https://lpc.events/event/16/contributions/1147/ I see four speakers 
> but no agenda? Will an agenda be added before the microconference starts?

And the speaker list is not up-to-date either. I am a speaker too :)

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
