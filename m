Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B6C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 05:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B80623A6A
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 05:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgLIFSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 00:18:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53674 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgLIFSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 00:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607491117; x=1639027117;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uZxynK3HUpBwmklxm+ERTg/Ufcl9gEjKp1A5wLL7qVY=;
  b=FZsKSNii3ccEx6CGfN4fq50e4c8UgABJhHCbxPrMScUn/XMvVExgEwiw
   B4JXT4xckJ1OxUBXNUn6kJENd2UNFk74gepKJ56uGGSVoqsmbX7CGRyDA
   gZVRtJwbzuMWPQEF3nWqM3x2MRmdS6+Lk/Gr3+k+rZ+l2+fan4lZOkaPF
   g+yHf1OgJv6Y+UmLByGtlbSoQJp+3/zjykj9fpGo2LjNc6A0pyoJkrSOj
   /P+mtAyZc/E5Zy8TVEug3NJmNij533u3NkU5GLwOJseWrSfnovwoIKDUQ
   ARzYsc7ZvVIOinHaHJCa9bo7Xl07ziLjfRXpK2vMeYxIdoUfQVIqp8hP1
   Q==;
IronPort-SDR: lm7l5Okh1QRrWb3hvPP7BWHY3EGIJ4+c4Itw5t6xaFT/KpPeRglctQXSHV6nS0KFqv6++QLuCZ
 MQCYv8jJTUJ/rPdx/iNBGY+/jJ8VPn7FhZwKOXcZoYJBGlpnPPSYjH8OV0Wtb8wErwHfV9N0JA
 Bew5B4j2tiuT1zWp0pYeB5kwBUUQ012nXpqqbHvTrsMMYYQkkRC/Nn25oQx4lm+U4739W3RbL2
 ZE0VnLSvjXuJRLuU3XiKnXRQLLG35w8MSP2Le+UlEhPin2chDyqrll+dCj0b7clFljXrQEJwRS
 9Bw=
X-IronPort-AV: E=Sophos;i="5.78,404,1599494400"; 
   d="scan'208";a="159205031"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2020 13:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzpI4wjOGfjVHe9uJd1dYhpsf+Oh8AMk5qJ1UocDJooqC8xNut6prj6Mw0drRJEsorbSvIbHVsIyK9m4OzJ1RMQ1PafDLyS3rZHRNFbu3YlYr4C+9dhQhMbLM+u3iDIT6u/6NxRKOSZI1ZKGsAptLo35GES11zBozMxRMFNOx7LPSy5oykR1aMvG9gAtlh6XiNk6KcLMtmJaw3ghP2N9heBlqQgSDOl3FJZ858I2p3AXGUNZQh1pUOcUUNv8uLiqd6Ve2Nl5ZrdHRowHr8WvJ4g03ZxuPARSb+Fj0bAQqdkjZzmpLfd4sgPmMcaLmZCIb8u0NbPkpAYHiWBUum14Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZxynK3HUpBwmklxm+ERTg/Ufcl9gEjKp1A5wLL7qVY=;
 b=DGTNl2lK913Xl1lo0N0VpjFCBTMgS/W6rrTnJyH9miACkzd03CFo5wWB4xCKbCNyueWHoldsQaafmNYdBnBJ0+NY6WgTQBTtXOKJbaM7YO3xe3WrolIOgdjAj4w4S4fDaCm6U4DtN2MA98kty0cLAj51xaGLE4D6uzas0ZeInulHpHunBabLNQ/FqcMNuMzvUuDOT8u9bB0sOmGPSZvDveCEarU6EyQrB4oWuT3bivUpQ2gnUau5ZDZOizRgYWAPwIy87PSF9XP4R3X8DGg+3nJGRLNFOLMfVwK87090mAbpiSAImrFznwK38GjqWE6ELSJvbx2ZC2Vl0WlUkIwhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZxynK3HUpBwmklxm+ERTg/Ufcl9gEjKp1A5wLL7qVY=;
 b=iHf/ZmlZnNWj55FtlAZAyskAkZ+/Wp/kOnAAvYDSxxsdoFCmZNpF0Y5nSg4NhPNV4I0Ohml9nQf5OG2eUWMTyRPxNgOWa5r23epnNkbuPTMPVw13Sp/tZll5rnL3rCqwoe+7EyJ5IhQy5HqVXXfqfOlf59sgz9Q2td/Td4vzsBk=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6791.namprd04.prod.outlook.com (2603:10b6:610:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 05:17:29 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 05:17:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>
Subject: Re: [dm-devel] [RFC PATCH v2 1/2] block: add simple copy support
Thread-Topic: [dm-devel] [RFC PATCH v2 1/2] block: add simple copy support
Thread-Index: AQHWyiz5N0MxrRzynkmTc7uhJBTBYQ==
Date:   Wed, 9 Dec 2020 05:17:28 +0000
Message-ID: <CH2PR04MB6522D7423BC3165B784AF61FE7CC0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CGME20201204094731epcas5p307fe5a0b9360c5057cd48e42c9300053@epcas5p3.samsung.com>
 <20201204094659.12732-2-selvakuma.s1@samsung.com>
 <yq1blf3smcl.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf3:4043:c21d:e871]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: effca5b4-68b8-42b8-70c7-08d89c01b941
x-ms-traffictypediagnostic: CH2PR04MB6791:
x-microsoft-antispam-prvs: <CH2PR04MB67910378347E469B017CA39DE7CC0@CH2PR04MB6791.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWd06oyuE2GOy2NzyUwzNlg7yuT4ggpElhwRPN6jMC5h778IEGFtDurQPb+TbjbmPGxduKkzKuC4TnuGZ5PiLML9ddA28WSZ9aTyXdNDvRSemqvNYqBzJs9OBcnP/jMPS1lALNFrrxN8Bj311I40dKuaD0TlLUlwKrkxbjvWbKRLdmowR/kE93TWnod6eXFaMCzfdZyI4K6VqdlVyKHqaWA2aO1qheCMeQ++uq+7lBjmSN/u3lMC/ywhjH+6o+vuYQBas+6EtQ3B3Xq7/ydqFOXSfgWD5r9z7JfwG3s4w5SG1dADhOVc+R5f34NIcZqrOITFHFmwweMQ4HKfiMhdbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(76116006)(66476007)(66946007)(83380400001)(2906002)(54906003)(6506007)(66556008)(66446008)(186003)(9686003)(64756008)(33656002)(4326008)(110136005)(5660300002)(91956017)(52536014)(7416002)(8676002)(53546011)(8936002)(71200400001)(86362001)(508600001)(7696005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gbIC8/jzf5kF72EfpuhGpJadTLpIfZiy8/70yW7aMs8wQ3lDZnKl3j92UZvQ?=
 =?us-ascii?Q?jtRUSnutW+ClMC9e94lKHgwHA7+/+j896TPh6u9MCJ6MLi41Sbc8bn3KD4Ym?=
 =?us-ascii?Q?omy6FPqzxVtFs0nkzjfEoa08dqzQNzYmto0AB6az+e5RJO5lJEdjoPeWFUU+?=
 =?us-ascii?Q?xi1YCnIM8/YSUc6pt9z5ZJXbi4/aOPKCstBtJJgJDsskkISxBq16QlZ1lhvh?=
 =?us-ascii?Q?cBqJEGxR1uUsW7PxJM5kSiS6xrki45GPvNDcbZ+WFiqxFVuHof3j2XFXDGUo?=
 =?us-ascii?Q?H1HwM7B+XVPamdQy1kH8lhLgbecXcIvn3YwDQ5NWGruxBz49Qcr4uAQLpEes?=
 =?us-ascii?Q?hgXJWWPdzHurDo/0xCP3J1YyWhQuXvKkgRKUBTwI6iFTptqgJUNQIR1KNVjm?=
 =?us-ascii?Q?up5CwN5akEwHnONDdUQCNqhTvY2gV1CM049MT4e0dHPOdYn1qNmBgVsgKiP7?=
 =?us-ascii?Q?rXkOe9AzP02z7EX2Xcq3trrXFegyXa3WF6MBeQ6Mt/RKdqWWcNInfDbL3kUJ?=
 =?us-ascii?Q?BKMrn25zg5obSbZ70lrQWWI7Tx7NyP9gG/LXx4KRkYMf6//kwfAk8NssDo3v?=
 =?us-ascii?Q?ZwZUEG+pROGnO7/YsNbIKAdyQIju75LeMxHT4KOKypdvaorq8hyAfTcUyds9?=
 =?us-ascii?Q?MJ1a/SAT14w2AM5hEEKV6MCep5qtX5lL/pyHMiBJSrfYJ0TJx5z9ZnQiuQhv?=
 =?us-ascii?Q?RXL2nHO5I/PnwmUUaHRBXIWtSVdsk55eTmNAk3ShYRsMQC8d7RINknYrytoo?=
 =?us-ascii?Q?TXDSRm8orR9grlNWFBZCHbzblt6NRG0R06QWdriLceL3yP33fXdo2X+37hQT?=
 =?us-ascii?Q?t0mgFVV4ueDkPH1Cj0axXNcMWC4adXV/atmzN9m6u6KwHj6YqLfCrNZ22PoP?=
 =?us-ascii?Q?U+dUM4O29swDXcmC9O/5mWs4k5+xQv4T026sgfGC4OT5SkTbPnZ8HE+XLx0Z?=
 =?us-ascii?Q?WBW1PbGKVY39a77wzQjbQ8G1ZooXGZryqwX+RMYO76s/77tKOM5Fhjr+cgDy?=
 =?us-ascii?Q?IpVd//wpzU1+HcvVPabQdy2yJ2MVBYwQpaNDtkgn5nZ1up6SF5RvSvsygAVH?=
 =?us-ascii?Q?7wPzG+UY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effca5b4-68b8-42b8-70c7-08d89c01b941
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 05:17:28.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KA2WanAbrGVs2+t94kFiqM13Y5mDpdJekYRz3XZMv5eEm45UeYQTyKApNLKHOiBOWhzXz2rqyGJX4vJ+evwNcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6791
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/09 13:20, Martin K. Petersen wrote:=0A=
> =0A=
> SelvaKumar,=0A=
> =0A=
>> Add new BLKCOPY ioctl that offloads copying of multiple sources=0A=
>> to a destination to the device.=0A=
> =0A=
> Your patches are limited in scope to what is currently possible with=0A=
> NVMe. I.e. multiple source ranges to a single destination within the=0A=
> same device. That's fine, I think the garbage collection use case is=0A=
> valid and worth pursuing.=0A=
> =0A=
> I just wanted to go over what the pain points were for the various=0A=
> attempts in SCSI over the years.=0A=
> =0A=
> The main headache was due the stacking situation with DM and MD.=0A=
> Restricting offload to raw SCSI disks would have been simple but not=0A=
> really a good fit for most real world developments that often use DM or=
=0A=
> MD to provision the storage.=0A=
> =0A=
> Things are simple for DM/MD with reads and writes because you have one=0A=
> bio as parent that may get split into many clones that complete=0A=
> individually prior to the parent being marked as completed.=0A=
> =0A=
> In the copy offload scenario things quickly become complex once both=0A=
> source and destination ranges have to be split into multiple commands=0A=
> for potentially multiple devices. And these clones then need to be=0A=
> correctly paired at the bottom of the stack. There's also no guarantee=0A=
> that a 1MB source range maps to a single 1MB destination range. So you=0A=
> could end up with an M:N relationship to resolve.=0A=
> =0A=
> After a few failed attempts we focused on single source range/single=0A=
> destination range. Just to simplify the slicing and dicing. That worked=
=0A=
> reasonably well. However, then came along the token-based commands in=0A=
> SCSI and those threw a wrench in the gears. Now the block layer plumbing=
=0A=
> had to support two completely different semantic approaches.=0A=
> =0A=
> Inspired by a combination of Mikulas' efforts with pointer matching and=
=0A=
> the token-based approach in SCSI I switched the block layer=0A=
> implementation from a single operation (REQ_COPY) to something similar=0A=
> to the SCSI token approach with a REQ_COPY_IN and a REQ_COPY_OUT.=0A=
> =0A=
> The premise being that you would send a command to the source device and=
=0A=
> "get" the data. In the EXTENDED COPY scenario, the data wasn't really=0A=
> anything but a confirmation from the SCSI disk driver that the I/O had=0A=
> reached the bottom of the stack without being split by DM/MD. And once=0A=
> completion of the REQ_COPY_IN reached blk-lib, a REQ_COPY_OUT would be=0A=
> issued and, if that arrived unchanged in the disk driver, get turned=0A=
> into an EXTENDED COPY sent to the destination.=0A=
> =0A=
> In the token-based scenario the same thing happened except POPULATE=0A=
> TOKEN was sent all the way out to the device to receive a cookie=0A=
> representing the source block ranges. Upon completion, that cookie was=0A=
> used by blk-lib to issue a REQ_COPY_OUT command which was then sent to=0A=
> the destination device. Again only if the REQ_COPY_OUT I/O hadn't been=0A=
> split traversing the stack.=0A=
> =0A=
> The idea was to subsequently leverage the separation of REQ_COPY_IN and=
=0A=
> REQ_COPY_OUT to permit a DM/MD iterative approach to both stages of the=
=0A=
> operation. That seemed to me like the only reasonable way to approach=0A=
> the M:N splitting problem (if at all)...=0A=
=0A=
Another simple approach, at least initially for the first drop, would be to=
=0A=
disable any sort of native hardware-based copy for stacked devices. These=
=0A=
devices would simply not advertise copy support in their request queue flag=
s,=0A=
forcing the block layer generic copy API to do read-writes, very similar to=
=0A=
dm-kcopyd. Use cases where a drive with native copy support is used directl=
y=0A=
would still be able to benefit from the hardware native function, dependent=
=0A=
eventually on a sysfs switch (which by default would be off maybe).=0A=
=0A=
Integrating nvme simple copy in such initial support would I think be quite=
=0A=
simple and scsi xcopy can follow. From there, adding stack device support c=
an be=0A=
worked on with little, if any, impact on the existing users of the block co=
py=0A=
API (mostly FSes such as f2fs and btrfs).=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
