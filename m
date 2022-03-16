Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351605AbiCPABs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiCPABr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 20:01:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCD55750
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647388834; x=1678924834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cY2zSS6SY31l7qOoS4GxN9w8wfcb+Vj7eGbXytsbn2U=;
  b=YKzARkVx+GaWszz0jxJu0RCYXdMk/ct+HRPkYZP+7fzGd9XTnpW1anDF
   AgtS+XXtHIOPvxnjg+bYkPYwjlr5HftmxO40VaFEz0TRWcMrtbiM5shcs
   3snyL3HkfEqtFWEVMVp/RDNzvsPQtIPieYeDh5qISdltiWKFR5jkXs3gB
   xjiQ45PICxa7gdRcqwTQTMJIAvxnJi8ncUOJEntC6fZGmAJZCtRodmhqk
   5sGN8b9/iTVAjQuNqn7X2J3JA1/cSoFa6w7XmBrHiTUmG3DXtzynaOQex
   eY+1G51Sa5Yx62HBdtuo4pCnDT4GQ7e8oYCLV4BQB6DR5zHv4xPW0xQ7n
   g==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="194369423"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 08:00:32 +0800
IronPort-SDR: Tw98bJGCZ+uBw2h9V0/dV4UacyfHooo8qife2/f8XAE3s11SnjR31yeGdNZj/O1v+GqSnF0My4
 9hoS0L+4R/nUEEojuGW1HPq9DmTLt1RYEy6oriOSfCisCkLFxVkJkm4wRJiHYsWquhqMsX22qs
 y3Xrt9P/lOO2LyQc+ZfVWbF1YG+P9nRxwks8iK0zXcDTK6hVi21zyMdWTN5ArRM2AvAHGWmwks
 CWkrslvXLfILvJWE7zrLZRkirHewl1kM6z/ooFrp+IxLuX/KEf/kUJIyrprvpsSe7Od6F1B2Nb
 UldNYvYDP204OS8ykEJRceo5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 16:31:39 -0700
IronPort-SDR: kEMIE/8mx+LhxzzzA336hrpalgTWSe2tz5T7UUz6a69TMvQiqgIcGC029ioHQzImIhUg0b/mtH
 kTb+d0faxT6pmzPbcBc4ypdPj5ljLbvBI84FTYE2bheo0LiRjarPMOMvNw/8MYcqzb94YWAMzG
 u9asNumr0OQcKbDcTrvCsSuXU22vzhy7NVwnOqNOf5b9NWO/UXNhXpVAW1EmRkFLrdUdWrTdYt
 N3gaclh4Ov1tA5lUjor3DvPvV4gCSTYrhIyysSg82is9PI+ZXvbZLpvIE3Ff1BezcK2LGAlTWC
 sYg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:00:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJ9QS3tvnz1SVp5
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:00:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647388831; x=1649980832; bh=cY2zSS6SY31l7qOoS4GxN9w8wfcb+Vj7eGb
        Xytsbn2U=; b=FNJ2VS2y9+0vbf8V4oUOeQmu2B3zV+Sv24+C5188Rmpk6g3uZME
        2w+eHQKdRgHHQBeAICkrhh55XEAuPch65VLvmqUWEZU3nLVGW/9HXl6exa4JyVop
        P98rhyYpBnAtLs55lA8aKofja7072ILSOFwYDMR0tMM3DNXKCS81C4+Z0P6nRBqg
        PrjbmkFQtvZLOlwf92mGqStNEjkS5leq8Gh1LYilstIdkRpbvNf9s1JlKyT6dn7c
        QAQlAMjkv0Bc1NYGYxYUSHB7ve8pZSExznaptA46XSbbC/NHOsufwk+qFkOYuNPq
        q4Z4IfsneoR0u4Vf261/PYxnjWs0RoUH4tg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ipeutmj9GwH4 for <linux-block@vger.kernel.org>;
        Tue, 15 Mar 2022 17:00:31 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJ9QN5kJyz1Rvlx;
        Tue, 15 Mar 2022 17:00:28 -0700 (PDT)
Message-ID: <fcb4f608-970c-56d3-fe3d-b344fab8baf7@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 09:00:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
References: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/22 22:05, Javier Gonz=C3=A1lez wrote:
>>> The main constraint for (1) PO2 is removed in the block layer, we
>>> have (2) Linux hosts stating that unmapped LBAs are a problem,
>>> and we have (3) HW supporting size=3Dcapacity.
>>>=20
>>> I would be happy to hear what else you would like to see for this
>>> to be of use to the kernel community.
>>=20
>> (Added numbers to your paragraph above)
>>=20
>> 1. The sysfs chunksize attribute was "misused" to also represent
>> zone size. What has changed is that RAID controllers now can use a
>> NPO2 chunk size. This wasn't meant to naturally extend to zones,
>> which as shown in the current posted patchset, is a lot more work.
>=20
> True. But this was the main constraint for PO2.

And as I said, users asked for it.

>> 2. Bo mentioned that the software already manages holes. It took a
>> bit of time to get right, but now it works. Thus, the software in
>> question is already capable of working with holes. Thus, fixing
>> this, would present itself as a minor optimization overall. I'm not
>> convinced the work to do this in the kernel is proportional to the
>> change it'll make to the applications.
>=20
> I will let Bo response himself to this.
>=20
>> 3. I'm happy to hear that. However, I'll like to reiterate the
>> point that the PO2 requirement have been known for years. That
>> there's a drive doing NPO2 zones is great, but a decision was made
>> by the SSD implementors to not support the Linux kernel given its
>> current implementation.
>=20
> Zone devices has been supported for years in SMR, and I this is a
> strong argument. However, ZNS is still very new and customers have
> several requirements. I do not believe that a HDD stack should have
> such an impact in NVMe.
>=20
> Also, we will see new interfaces adding support for zoned devices in
> the future.
>=20
> We should think about the future and not the past.

Backward compatibility ? We must not break userspace...

>>=20
>> All that said - if there are people willing to do the work and it
>> doesn't have a negative impact on performance, code quality,
>> maintenance complexity, etc. then there isn't anything saying
>> support can't be added - but it does seem like it=E2=80=99s a lot of w=
ork,
>> for little overall benefits to applications and the host users.
>=20
> Exactly.
>=20
> Patches in the block layer are trivial. This is running in
> production loads without issues. I have tried to highlight the
> benefits in previous benefits and I believe you understand them.

The block layer is not the issue here. We all understand that one is easy=
.

> Support for ZoneFS seems easy too. We have an early POC for btrfs and
> it seems it can be done. We sign up for these 2.

zonefs can trivially support non power of 2 zone sizes, but as zonefs
creates a discrete view of the device capacity with its one file per
zone interface, an application accesses to a zone are forcibly limited
to that zone, as they should. With zonefs, pow2 and nonpow2 devices will
show the *same* interface to the application. Non power of 2 zone size
then have absolutely no benefits at all.

> As for F2FS and dm-zoned, I do not think these are targets at the=20
> moment. If this is the path we follow, these will bail out at mkfs
> time.

And what makes you think that this is acceptable ? What guarantees do
you have that this will not be a problem for users out there ?



--=20
Damien Le Moal
Western Digital Research
