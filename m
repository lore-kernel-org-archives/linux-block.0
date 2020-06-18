Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6AC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 05:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228E621852
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 05:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WWAr2uFy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MvgJG7xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFRFPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:15:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35660 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgFRFPh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 01:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592457338; x=1623993338;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UE8a02guuVmqcOgEYvs9TRuUJGV2/xOxGEiuNIf/Gj0=;
  b=WWAr2uFyljc/1B6BlOmtW8708dmI0iDtOzbymiaqG2h4e8sZfbvkPgd3
   /jESVD/H7rOcGiqUQA1Dx13o3F3Datqtg3xS4ULyy7XuK/m15kBTuwGRe
   32VcY/nHgvi1D8ooDvQi0hA4EKRwBk+lsK7t/eDml9B5yUbAzSwNPLqP9
   U5zYlCtRsibfKSXOxRASSp1ihxIQyRXcEjWjaOmL5RZrf7EcpirOYCj1g
   av084ff0w1r4Ng+fcs5VEcYd6jzeNzVQRwf0kE/ZgXWZyFnhF/BooCLxP
   8dE8efFAeDEj3Ke9ZEF7X9ycvL5Jx3VAWtm8+laSrC/LYI2K8dlAh9YlF
   g==;
IronPort-SDR: Qfoga3wcKRFDrPscpKAuU4wB9+PWOzg6Q+vl9ZbBInI2FqGoTDZMZ2mTTif9A7kpRDgI7/lwAa
 2M/fg4rhyKcOgx24n0HLhT8NlNXK5Tb9ywo3sZ0LGRbFqmQg6sxo6meEEJOStP0i1Aw76dHTi5
 y/NUvpKm/AlJzXTM4HH0ZnRkoSzLn+gjfH1OtSOlZIm0K5U0Y6XnIvxAOjjqZDJKyfXnlkXxh+
 LutLANfXJMbfvC3pXE8TZe5MHr+Mxjk95NIGzqInAwfZUk62dg8q8xQV/PDzc6tmejovzqWODP
 PH4=
X-IronPort-AV: E=Sophos;i="5.73,525,1583164800"; 
   d="scan'208";a="140546964"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 13:15:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxQ4qu1cCahV30ikbT4zjQsu7lRMVisIOo2SEkGAGyZLGB+5dD4cpDHD5Nr51NydnyHOgUpJRiGu+ydbg+zbDQl0dVkqa2Sq6e3SvD6YArdv1m6lfZgKwkcX7gI4GfzlIQROzlodFsY8UaSLWEAxgyvWHAhkWRSOHE0s9YzYmRrwknLeE2Qpldd9NvOUpdd1Rcxl5KvWPXgzFOcDCX3RZ50PPYXgepTCKas7zbhEC57ye6GqHGr/NLdwgymU+0Yq389OSdg/qqOoho7zcnaO9gb7yQSwtrn/u0SU+RfVG42XIwH2Y3xIsDjYn4NF4X+SqmWShR3CCkVOJZO8Dno8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE8a02guuVmqcOgEYvs9TRuUJGV2/xOxGEiuNIf/Gj0=;
 b=mgR/cGPZC6C/JDNn8hm73B8164BJOkzEquQtMz8mdJphUDIJpenshGeUufgZi4H6XpUF2nPVG7cLv7F6zibe4MJDvNlTBirAecSZU/GiaC56j4/deB7epUaXqWdW5Of5G0FEFJq48QFdi3YRhSn0TBhP7+aTYvevf1ZOWwhiSWY1XW0DYZxIgdEUe6rtSil1QeYzfX93XEXwSrvFaEeTtehRP3i4iq7PLzgjqwhycewPVeZdoNFdy2V99uBfOcUqHsAtGIRDJnkR9C5VuCR0hzj1H/JHXm0rS0bgYOpjmvjqrw1SOPHS2cDTSWQJ+rzbjSZR2IoTiEQu1mIuAae7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE8a02guuVmqcOgEYvs9TRuUJGV2/xOxGEiuNIf/Gj0=;
 b=MvgJG7xTCpRCb8Hj7KbrFsaFPnpAwp1oaZM9EbWncF31dYEg+fY0y/03vUK7zqzqeVZVk5Ilr9KZnD0E3L6TKrUHm2w5tdSIYAllZ/gBfTMh1BZZGNmaJz0SyFiMvJOi0zXD5u/mr07MJPf0LwRvzO+qPdS0NyPPIib+JNwRhpk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1031.namprd04.prod.outlook.com (2603:10b6:910:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.28; Thu, 18 Jun
 2020 05:15:35 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 05:15:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Heiner Litz <hlitz@ucsc.edu>, Keith Busch <kbusch@kernel.org>
CC:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date:   Thu, 18 Jun 2020 05:15:35 +0000
Message-ID: <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ucsc.edu; dkim=none (message not signed)
 header.d=none;ucsc.edu; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a8213a1-8b0d-402f-309b-08d81346a1a9
x-ms-traffictypediagnostic: CY4PR04MB1031:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1031DCB74C6EF0507CCE4094E79B0@CY4PR04MB1031.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0/CTlCbxK6P6A9o3z08oQ9A1f/inLLqgj+LPNXPlgmf9xzO2i3KxP/EQJsC9x/Kz2EBYx1dgqhunVZhsu03ek7A5ADZsQEKf5DC8OfUfJAJC+0leJSc03Dtnkrdp4kVzNvyPfL4/b2gfAsyqYEcOTe5ll6cKY/U7Ms7/HbbUK6L0eN8PVOIA+FvCMFvN1go7krmDoUkanbCOzJhwXIQBq7UfVeW4KGy+HcaAd4raPy/pXHMVlDuCmr9MFJG8ZxCyn/ij/RpcxFYpp7Ep7GD8q9UTVXEkM8tQE5FpQ1V+L1341eyYvOuX+KwnI4F1Ak65BpWv/SmBKFp/sRH1evaMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(2906002)(478600001)(91956017)(66946007)(76116006)(110136005)(86362001)(66476007)(8936002)(7416002)(4326008)(33656002)(64756008)(26005)(54906003)(66446008)(66556008)(186003)(6506007)(316002)(8676002)(53546011)(7696005)(52536014)(71200400001)(83380400001)(5660300002)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Aw/Y0VkmhbQuyhuNSJJXp5q+nMTKjKt6x2vMbmxLzaMZCYYCja/LONAfmV92+w5/ScOQtsNMbVzyqj05X1cgqInmfFs58+KZQ99U6S+6Cl3F0JEg0ekYyiT5qdE86ZgPmfEaX18diguJOlQFgWR2OGfkmzeFSXEwBw0KZizwD0joieVJVLjAXLtAQGqzcBwfrFdmKV48sWEmtUzuZF0FZGvIY1gDf2LD4Z9WuEXhnUunKCy+2J+WtCTZ0zo9NOLURAYo8PhYJuyucb0EtdFsefWecfmrNu0cKZ5rQxja0tPdUBQDLkuAzA132504dKuRnDfhQPB/xIsh7VLLDaa66I5a+hxNmSIEyZ43uAdC2KoZOh6nVahuccrKZQFaRkGK/ZbHpoduLb095g0G9L/v1RVzVmex5VYfQ9IvDe09fHa/w4Q/iNrDK8PkDca7gyJSiTl5ukhS4+sxZbF4Bb60iF8WrDgO08FiuSA8pwEWSeA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8213a1-8b0d-402f-309b-08d81346a1a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 05:15:35.2823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BokyG64MIdQvIYWKRZYqrvdeQoO+HJcbwx90vOOzR/NkXNtsBhnDFMe1I8lqthxmCl3JE4+eogRyvx/UOpLL9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1031
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/18 13:24, Heiner Litz wrote:=0A=
> What is the purpose of making zones larger than the erase block size=0A=
> of flash? And why are large writes fundamentally unreasonable?=0A=
=0A=
It is up to the drive vendor to decide how zones are mapped onto flash medi=
a.=0A=
Different mapping give different properties for different use cases. Zones,=
 in=0A=
many cases, will be much larger than an erase block due to stripping across=
 many=0A=
dies for example. And erase block size also has a tendency to grow over tim=
e=0A=
with new media generations.=0A=
The block layer management of zoned block devices also applies to SMR HDDs,=
=0A=
which can have any zone size they want. This is not all about flash.=0A=
=0A=
As for large writes, they may not be possible due to memory fragmentation a=
nd/or=0A=
limited SGL size of the drive interface. E.g. AHCI max out at 168 segments,=
 most=0A=
HBAs are at best 256, etc.=0A=
=0A=
> I don't see why it should be a fundamental problem for e.g. RocksDB to=0A=
> issue single zone-sized writes (whatever the zone size is because=0A=
> RocksDB needs to cope with it). The write buffer exists as a level in=0A=
> DRAM anyways and increasing write latency will not matter either.=0A=
=0A=
Rocksdb is an application, so of course it is free to issue a single write(=
)=0A=
call with a buffer size equal to the zone size. But due to the buffer mappi=
ng=0A=
limitations stated above, there is a very high probability that this single=
=0A=
zone-sized large write operation will end-up being split into multiple writ=
e=0A=
commands in the kernel.=0A=
=0A=
> =0A=
> On Wed, Jun 17, 2020 at 6:55 PM Keith Busch <kbusch@kernel.org> wrote:=0A=
>>=0A=
>> On Wed, Jun 17, 2020 at 04:44:23PM -0700, Heiner Litz wrote:=0A=
>>> Mandating zone-sized writes would address all problems with ease and=0A=
>>> reduce request rate and overheads in the kernel.=0A=
>>=0A=
>> Yikes, no. Typical zone sizes are much to large for that to be=0A=
>> reasonable.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
