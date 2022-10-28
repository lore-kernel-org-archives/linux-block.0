Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B782FA3743
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 08:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ1Ich (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJ1Icd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 04:32:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953541C491C
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666945952; x=1698481952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yGry/pWRS/1GiHAkDYvoBhKHjVKsf3tr/q6GIlXe/Vw=;
  b=EyCVwMx9XtCCnchdQObnXhImCsd2mHpYUsyRRy5n2otU7f6cpAiq1vc+
   OX386yU3Q8H1mEIbSTAyjG6W8umPKEXKbABdxSrvH6XMFJRMN5PAuqZXV
   K5koEWs81c+83ns9FdpPrm+zdxfaCJIIEl/umRaDUbq5qLIZHhFaA3fKd
   5BmXcACGwJr7zxBOQ+TLMRjBEz5+n+O5U5BQhDxOdKykmshyqirZpC9fT
   VT/0R07xxFLCu/ro2m481XTJO5CD0qja4BIeOHoSvtriXhrjYy/QaHois
   LKVCId4VtLEE6gJKoh70NBM/jZxNAXx9Two7n7hU5Hv9LI3hveEh7RL6u
   A==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="215312271"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 16:32:30 +0800
IronPort-SDR: MPjBJbhZEzBUAyRMiaCIB5SXKAVO2ZyzTi6wCO52tlwDYVOZYZyQgGJbDvRmuzIzMe3Bm14jHG
 t6wkTkrYAetGwVR2ISTGFnsiVoFJq1Fz9I749PHp6LkH1jHTzAkUALOQtUS7B2tJMRg7J64EVc
 fSZQdR6ykslwaS6w71i7LeWLJUjqu+z/tb4iPK+NkgNOrUq/MJaqJv6yZWkwi7fTavpKYyOQFg
 AJlt+pHHwGvzC57U7qhfGhfKaTv4Z9Fc+Oe0DRzPjOYzDuI18gZihEeiVLV4/iRZELltGuP1t0
 AoypmD7FRB89yaSNdRrapaOG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 00:51:50 -0700
IronPort-SDR: wZVu52ElysDNB8Lg0AErIjjjnKm0UAPRkNdKG8s5TQQxxkuC/aXQQjHgb2WZdXhVcJkf0pjlH5
 suv1Oxdmur2Z6PWo5ZbrVACHlt1luXxjIyPyiJEOUq3E7ImCtDPCMJeHaQ3ua3pSzOm0mhDLQK
 cV4ETPfxpDsaf1ouh4PDvU1OwHvaCl+NVtZ2H90kN18SgLbrOnKhWWjChJCNe+MFXNVNPnmzy+
 CcMgYKihD2ZgcrloXw1BpUwELgZTfudQBHx5YHi8xSV6ro5nIsFg1sUKfoc41FSp01bIcVis+8
 RkI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 01:26:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzFxx48wvz1RwvL
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 01:26:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666945588; x=1669537589; bh=yGry/pWRS/1GiHAkDYvoBhKHjVKsf3tr/q6
        GIlXe/Vw=; b=q5Sx/LtWSabxkzRGhwH2yAohQhHudeTrjwQgdk6dltsjzS9sU3h
        a6Tg3+16AlYQl+2o9vWTB9MribElyzuensUFfRWBCW16VLO1j72U4XrwTyIFZm0J
        7DWWAPxXiYP2co3w6i7Ci6CAGW3He/l14M7oia7xBpfnymCDpGQ4EJxmt896Q5Wx
        xpnC7xQIeVIHMUZFIDPJClDfbRosOJvpQ2YLJIdfxSyCYWIxiCYtpvQBgGHRtwIC
        A03UIkSEVBX2K/qYjBYtV7Fe1SAvCC5eaj0eTHyFENS11v/S0IrvRrBww3Pp3SVM
        z7JYCHwGZ4lHnjRH0UbcQ6UhDWuA+e8rbJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PChRqyaC2nkh for <linux-block@vger.kernel.org>;
        Fri, 28 Oct 2022 01:26:28 -0700 (PDT)
Received: from [10.225.163.15] (unknown [10.225.163.15])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzFxs52r9z1RvLy;
        Fri, 28 Oct 2022 01:26:25 -0700 (PDT)
Message-ID: <0bb40ab2-2e80-44a5-79c2-fa4bfe2560d1@opensource.wdc.com>
Date:   Fri, 28 Oct 2022 17:26:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <3ef0347f-f3e2-cf08-2b27-f65a7afe82a2@suse.de>
 <ea0be367-a4e0-3cc2-c4c7-04d8db1714cd@huawei.com>
 <07028dac-d6cc-d707-db08-b92c365a6220@opensource.wdc.com>
 <a3fe8284-d002-36b0-7e09-67f132353088@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a3fe8284-d002-36b0-7e09-67f132353088@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 17:14, John Garry wrote:
> On 27/10/2022 23:35, Damien Le Moal wrote:
>>> At what stage do you want to send these commands? The tags for the shost
>>> are not setup until scsi_add_host() -> scsi_mq_setup_tags() is called,
>>> so can't expect blk-mq to manage reserved tags before then.
>>>
>>> If you are required to send commands prior to scsi_add_host(), then I
>>> suppose the low-level driver still needs to manage tags until the shost
>>> is ready. I guess that some very simple scheme can be used, like always
>>> use tag 0, since most probe is done serially per-host. But that's not a
>>> case which I have had to deal with yet.
>> In libata case, ata_dev_configure() will cause a lot of
>> ata_exec_internal_sg() calls for IDENTIFY and various READ LOG commands.
>> That is all done with non-ncq commands, which means that we do not require
>> a hw tag. But given that you are changing ata_exec_internal_sg() to call
>> alloc_request + blk_execute_rq_nowait(), how would these work without a
>> tag, at least a soft one ? Or we would need to keep the current code to
>> use ata_qc_issue() directly for probe time ? That will look very ugly...
>>
> 
> I am not sure if there is really a problem. So libata/libsas allocs the 
> shost quite early, and that is before we try using 
> ata_exec_internal_sg(). Also note that I added patch "ata: libata-scsi: 
> Allocate sdev early in port probe" so that we have ata_device.sdev ready 
> before issuing ata_exec_internal_sg() (sorry if I'm stating the obvious).
> 
> I think Hannes' issue is that some SCSI HBA driver needs to send 
> "internal" commands to probe the HW for info, and this would be before 
> shost is ready. He can tell us more.

OK. Understood.

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

