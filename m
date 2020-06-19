Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44A7C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 00:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836A620771
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 00:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IsONv2ra";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hyX/XIMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgFSA6F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:58:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7179 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgFSA6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 20:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592528283; x=1624064283;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=25WOgNcWNfZt61XyPQyGlYkPAqCBQUGgkGXCuvRZPe0=;
  b=IsONv2radGWWXszQIg+3a/fcMMDkNgVfWq2ycJ6282cwlpbNXGZA/fxS
   ODzDgScX9CiABtltcD+zgYVIwdFhK8WNFZiZrL7dflb+BVGnCIbSJYQ+J
   QVIVfG4DchOpF63SGY35bGTi4AndrH1EmGR1OLUlibEOComwmWTK6FTv0
   FChXUrH20OIk5xJTXMYJQs06FxnxPA444fqpvAJzA8hBHoWkBNSpm7Brv
   YxRojUcAbpf1UrUW9SxF+ATch4PeTb7cyRTnGlVgOuqKbcxELNGYeQ7zm
   hmY3v5kARnH1H1ENyllR0/8gCN36zvMnOalnbe2y8mQjPtLnshJT7U8zo
   g==;
IronPort-SDR: swDUZFVIQ8/l3Op77PMHQ3giCgEyr63UVq7SJUZ2INMBSCdYH5csRYr/5CqLUPNrcrI4vQd9/Z
 nZxobJ1bROxXmiNmqN4lqqrfv9f8CPQR/8/+wOLbwRK6OPap3LoGTVKyk841wP18zdg46iPcbe
 s5WjRUbbQT+k/98+eSG1K3eMnRxHmqCgskcp8Keonpd16QogmUU7KRR+uQBYl8I5x3sAEqe5z9
 zmhn6BaXw/CYI8U4OA1rlAsD40+huEahj9hOt5EuxWEN+S//PoNivlHE9snvdbpi9nyHaJNUc7
 OOk=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; 
   d="scan'208";a="140375929"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 08:57:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqaNTfwm80uXt2HxTsjjjTp9xvWESlCxGGddHdCu7szfVQ+S+nn505/SBXIxSy5pSixh/2oy4as1BS5FOYRdAsRvXJCTPB+Hm4PayW5W5FMfGh4lh5L1P5xVQ+/YM4A4FiRDAyD6CKgX9+XpKL4Pelwdpk5t4q8GmY7pm68YURbueyY/BzdUUNtcB7XbmOnfG1/uu8CIqukZ6jO8wzSE/V+BusKtFSqhPGkn0o7JiRHEh1EYtDj/E9X6c9WZa3qXFbjbzUaf7KQx6cGEA1WntGMzXZH/HQsYuB+aWrCk9ARjP5P5Fa4Nn1SiuYrrRIdmZy8QKHmpMCQ/fQDDJedZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25WOgNcWNfZt61XyPQyGlYkPAqCBQUGgkGXCuvRZPe0=;
 b=ZaVPV4eZ/OnR63r6PnQe8aYnvGbg0rlx4ftP/9EGRErt0trYFGySnlLgxUYhYJtCS3US/0GHk5zwhZT3StVK8u6S0ayRM5aoYqRoB4aPdxIM0KDR7ndSSaWs7sfP0o4YETAb8s2+4fSuCVy4r5D+QJfg8YctSUkP5DitMky6iEWxGuvDB5Ko7a+Aau5STBTEz1MZCd7VbQpvmtR3kgb0mbNyEBF6USG7W/NYXrp7k1qZtsBJTQrdg5UQNJJT+djo8QAt8BFZ6/N2CpgUxBEYG+3t/ik9CSE6bhtsNZvjK/EgJMJwoE2lw7te15vaF0SlNGlReF6YfcwqpD7vvBh2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25WOgNcWNfZt61XyPQyGlYkPAqCBQUGgkGXCuvRZPe0=;
 b=hyX/XIMb8IUjyEwcKN4FhyzAxmyeEcNOgASyziHlUPTZxIZaJkchHXaFs5XU1+tk4+oK3Ec2tXMs/9xCc3kq8kY50MOj/r6CiSayQzuL93hmhPAehc07ZsVScRoObP/XIbQIwPKw/tVCDlqX7tYXQbNhhIdNX6xVz0iKymx8wd8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1049.namprd04.prod.outlook.com (2603:10b6:910:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Fri, 19 Jun
 2020 00:57:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 00:57:47 +0000
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
Date:   Fri, 19 Jun 2020 00:57:47 +0000
Message-ID: <CY4PR04MB37511C5698D3D2EEFD3115BCE7980@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ucsc.edu; dkim=none (message not signed)
 header.d=none;ucsc.edu; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fa2aa9a-557f-4e89-070d-08d813ebc8a0
x-ms-traffictypediagnostic: CY4PR04MB1049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1049F5B25265A83F168B6960E7980@CY4PR04MB1049.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSbYCuaEJ+dGBsee4v+wHBaxpDR7oo3/qSEximRDLrB5Tf6jYH6avOpjr3ufal407sci5erEF8N0yLG71WtVDxGZfDNxByQISugu7+Tm4ydUVCXnvW6L6Ix3g/rp4seCyEouOUIRA+l4wRxnMNfKOvkjWb3Ie7fcrT/E/PTvT0olXXrvzozwmh4YwqxSgpJx5/NMNqnitGC9pbtL+4Cz18B5fwIuui3UYVLXvW4YzJvdqk/Qy9fdTL1kQPqKFNwIR1hMQf/K/EaKSeGBdZ+vjnjR+Ve6do9vLXt4DGNsPFMd7YIjcQlqaP1NAa4d62+rQC09YQMH/eMhDXlqnsSgtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(83380400001)(26005)(4326008)(8676002)(316002)(55016002)(9686003)(2906002)(110136005)(478600001)(33656002)(54906003)(7696005)(8936002)(7416002)(5660300002)(76116006)(64756008)(86362001)(66446008)(71200400001)(53546011)(52536014)(66556008)(6506007)(66476007)(186003)(66946007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RW0OSvu461wkdo8xCZadCuMbtzFB28dNrQp27/ckl9z1RPNv+904kJW4Ql2tMBiHYcqIFiw0d9Qbg4qoYWDUsTC29jcOC/jQPBX70apTWUfxI4A2qNweiKDzojEUVFVruidNa064V2fyPB16t3CkiU6wbXqI2aRLEoomBX1HbGBmEOKrWHo5mdH9/gAwaUCUjzMjJiKEHDGN8HvrLG4OFGgiYv1iCchq0hCY+2qgwQeJ9n8el47IVzkZ/DnDfx9M9IXYaFLijmkb5oB1eWDXRTRmfD2o+BfUXIifxqOmn9+wZcayrhtcWz/2jcRfkaEh3nKC7iJh6OBe1W0HwtNH4KJTmzIASuGRQTei5JMBxWB9wxDk6ucIII80ZP90/cUWGfIDmb9/pWbqNsGRcihnvRnfqYJ0fmmzVygpVAqblZcXIgXHUd5ZZ7EmUYgfMNInqO1M5QytwyPQzB5lITb64iyyD0dVVKwgsPojNPWA8GbokHtkfR+ztBCKArhkPHO0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa2aa9a-557f-4e89-070d-08d813ebc8a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 00:57:47.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiX55sbQnPHBsM+8QsLdktuolRxxU0l/toDaeHZ3CiGMaqnSLpBTDN058/S1aFAgJvlMLMZktoYFxV4uVtB7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1049
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/19 7:05, Heiner Litz wrote:=0A=
> Matias, Keith,=0A=
> thanks, this all sounds good and it makes total sense to hide striping=0A=
> from the user.=0A=
> =0A=
> In the end, the real problem really seems to be that ZNS effectively=0A=
> requires in-order IO delivery which the kernel cannot guarantee. I=0A=
> think fixing this problem in the ZNS specification instead of in the=0A=
> communication substrate (kernel) is problematic, especially as=0A=
> out-of-order delivery absolutely has no benefit in the case of ZNS.=0A=
> But I guess this has been discussed before..=0A=
=0A=
From the device interface perspective, that is from the ZNS specifications =
point=0A=
of view, only regular writes require in order dispatching by the host. Zone=
=0A=
append write commands can be issued in any order and will succeed as long a=
s=0A=
there are enough unwritten blocks in the target zone to fit the append requ=
est.=0A=
And the zone append command processing can happen in any order the drive se=
es=0A=
fit. SO there is indeed no guarantee back to the host that zone append comm=
and=0A=
execution will be done in the same order as issued by the host.=0A=
=0A=
That is from the interface perspective, for the protocol. Now the question =
that=0A=
I think you are after seems to be "does this work for the user" ? The answe=
r is=0A=
a simple "it depends what the use case is". The device user is free to choo=
se=0A=
between issuing regular writes or zone append write. This choice heavily de=
pends=0A=
on the answer to the question: "Can I tolerate out of order writes ?". For =
a=0A=
file system, the answer is yes, since metadata is used to indicate the mapp=
ing=0A=
of file offsets to on-disk locations. It does not matter, functionally spea=
king,=0A=
if the file data blocks for increasing file offsets are out of order. That =
can=0A=
happen with any file system on any regular disk due to block=0A=
allocation/fragmentation today.=0A=
=0A=
For an application using raw block device accesses without a file system, t=
he=0A=
usability of zone append will heavily depend on the structure/format of the=
 data=0A=
being written. A simple logging application where every write to a device s=
tores=0A=
a single independent "record" will likely be fine with zone append. If the=
=0A=
application is writing something like a B-tree with dependency between data=
=0A=
blocks pointing to each other, zone append may not be the best choice as th=
e=0A=
final location on disk of a write is only approximately known (i.e., one ca=
n=0A=
only guarantee that it will land "somewhere" in a zone). That however depen=
d on=0A=
how the application issues IO requests.=0A=
=0A=
Zone append is not a magic command solving all problems. But it certainly d=
oes=0A=
simplify a lot of things in the kernel IO stack (no need for strong orderin=
g)=0A=
and also can simplify file system implementation (no need to control write=
=0A=
issuing order).=0A=
=0A=
> =0A=
> On Thu, Jun 18, 2020 at 2:19 PM Keith Busch <kbusch@kernel.org> wrote:=0A=
>>=0A=
>> On Thu, Jun 18, 2020 at 01:47:20PM -0700, Heiner Litz wrote:=0A=
>>> the striping explanation makes sense. In this case will rephase to: It=
=0A=
>>> is sufficient to support large enough un-splittable writes to achieve=
=0A=
>>> full per-zone bandwidth with a single writer/single QD.=0A=
>>=0A=
>> This is subject to the capabilities of the device and software's memory=
=0A=
>> constraints. The maximum DMA size for a single request an nvme device ca=
n=0A=
>> handle often range anywhere from 64k to 4MB. The pci nvme driver maxes o=
ut at=0A=
>> 4MB anyway because that's the most we can guarantee forward progress rig=
ht now,=0A=
>> otherwise the scatter lists become to big to ensure we'll be able to all=
ocate=0A=
>> one to dispatch a write command.=0A=
>>=0A=
>> We do report the size and the alignment constraints so that it won't get=
 split,=0A=
>> but we still have to work with applications that don't abide by those=0A=
>> constraints.=0A=
>>=0A=
>>> My main point is: There is no fundamental reason for splitting up=0A=
>>> requests intermittently just to re-assemble them in the same form=0A=
>>> later.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
