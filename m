Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9D9C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 03:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiG1D2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiG1D2T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 23:28:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A39313B8
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978896; x=1690514896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=02fS6kchwHqmWpcjqgwh7Tp2AzoaPQbPCdZwujO0Kqg=;
  b=TxQQChHs6Tmqq/zmUf2bAyyueFbLQAr+MMb2S2DKzdghVwf0yhm6+6Tn
   wjlntMLns73t2abtRlgvtfe7nontMvCJHafODF1T1xG8gngYv4ZZ71bJ5
   Iwvh11PHeNkHzLTTjJ52rATACTehTsbtMV3+i3UhwxWd6GzmgFnujgDs8
   6VIWKIU8UG7q+6TcXJDST+DPSdXHDz0d21QYQ36Kks7ze+5h9bVYMJUgN
   sp71/Npca6YXckGy1ExiFxxnnWWIpvK0CNQuyqH2ICIuw7y5W4ooO9MPx
   385MB7Lg0V2yM/r6OsYXW86vRS3dYO3909nvdE437phFIXiUt1Vq35ftz
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212068005"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:28:16 +0800
IronPort-SDR: Rul4J9/XbXIkwc+Brh2DfELNMOMkFc004gGafTiWb6SgjTh4oE1NUVH7SFxSC+HpZpqLaKuv5P
 bZXFXV+R16juLI+6+RupDtOTa07TgBP9F3iWYlX8udzWN7BaYVN1Lq/uH4irsLXCRVbsWUYG2i
 z05nzLD2kYtzPdg6QmN2tvLM+0wa/UV0yb98jkuYPFQwdxzhPXkqS9zbNmxdnFbTNw5cE2regA
 A8rj7qjvZakivz6dT5FPWWW2b5IoL/z9zVpivm16NihpStY/TRnfy2UpGBFlOTazkjUnb53N8T
 BLz5QpD3W8JkfaFybEs0Pg1I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:49:28 -0700
IronPort-SDR: 87V3iEMR7LoZdgKyX6G5i2JP8ooBWLO1/GFyv/GSTzLOwXAc3rWm+7+HiYb/82EIkkXYx8XGu7
 5MKjUXUj4xLy6BiiTJZqv6uPMmll7vH5FtQI+ubAZf/2IfQXf/agpMafsSQyyVVmXfzWfqHoMB
 KlpxGf1fwBHxn1aTQ+Zj23IXzynGAtxKIp9HcPgBy+brz/7oXfBBr7laCafHC4JlRhiZ+jLcBH
 iXyNpwDkSI+KMZsXwoTAPhIzhKOv9KOgUzZ34khF2WKOCOqwxzDzqBpGQGFvbXqMPJ5lFJggi8
 l4k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:28:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbhJ6GLpz1Rws4
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:28:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978895; x=1661570896; bh=02fS6kchwHqmWpcjqgwh7Tp2AzoaPQbPCdZ
        wujO0Kqg=; b=pwP6pPfblchpLMkHzst7OZ+ckc2HERcruP6/ItgxMCODYN1iw37
        k7DT/+5kHu7ZFcANjJKgGuG/7JtaHJIKhSderfun2gvmvDBxO7MVGyNIyLOhCvEr
        gynTZJDHthJSXW//7ZOUzNJ+VUqP9/8xaTu4BZNsqiOtvayGu7XyFrLI6U2lhG18
        JeQw5xvbs1u1yIbUBweDuXhIFBPtWbQduMQ/X5KaA+1jn0KmxXnAGTDYQi3jmrAr
        J6ttYbvWdSyCqmzmUgJ4yjGtYH/cZ2ZGKEtpZ+DrfA/EnRR2ZsR+frt9KVuCmT+p
        ekmw+0cWF9tbKmeRGsUkArbeRnVg0xhQq+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2HTEPZom88FF for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 20:28:15 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbhF2DLPz1RtVk;
        Wed, 27 Jul 2022 20:28:13 -0700 (PDT)
Message-ID: <14108b56-10c9-8760-39b1-ffa56220e5a3@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:28:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        axboe@kernel.dk, snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
 <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
 <024d16ac-d685-0fcf-1ad3-e99946852b03@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <024d16ac-d685-0fcf-1ad3-e99946852b03@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 11:58, Bart Van Assche wrote:
> On 7/27/22 18:52, Damien Le Moal wrote:
>> On 7/28/22 08:19, Bart Van Assche wrote:
>>> On 7/27/22 09:22, Pankaj Raghav wrote:
>>>> This series adds support to npo2 zoned devices in the block and nvme
>>>> layer and a new **dm target** is added: dm-po2z-target. This new
>>>> target will be initially used for filesystems such as btrfs and
>>>> f2fs that does not have native npo2 zone support.
>>>
>>> Should any SCSI changes be included in this patch series? From sd_zbc.c:
>>>
>>> 	if (!is_power_of_2(zone_blocks)) {
>>> 		sd_printk(KERN_ERR, sdkp,
>>> 			  "Zone size %llu is not a power of two.\n",
>>> 			  zone_blocks);
>>> 		return -EINVAL;
>>> 	}
>>
>> There are no non-power of 2 SMR drives on the market and no plans to have
>> any as far as I know. Users want power of 2 zone size. So I think it is
>> better to leave sd_zbc & scsi_debug as is for now.
> 
> Zoned UFS devices will support ZBC and may have a zone size that is not 
> a power of two.

OK. So the check needs to be removed then and the entire zone append
emulation checked carefully. The divisions for zone no etc on non power of
2 zone size devices in zone append emulation hot path are really not
welcome though.


> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
