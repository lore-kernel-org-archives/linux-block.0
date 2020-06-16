Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98952C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1552071A
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UN6jXfr7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vSmDlZ0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPMhn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:37:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54010 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPMhl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 08:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592311061; x=1623847061;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iwVY+DNrK9A/KvNa9HS6zEYi3Um4/JkwS7O7QvVnH1o=;
  b=UN6jXfr7JLBAmPTr8N47v2YBfThHJmsgsx84nCjjQYxmXjlYZzWPLX8J
   ib3Aw/j/iARoV5VCaxQtU/l0/e6msluC8juzohYY7p2pjqX30krTcwE9D
   vcVIY6z73D5NCWUGGnI3N4Hv4MUKvfa3w4VqTTtGdhJiZXFjdaT3JZOag
   ckND4qjGH3cbjxdylhdilPe+gQuvSpgfHb+jPJ5BDxdUdT82cyiH/WKJk
   pTWprVpNwv5bzf+wHIyivYzwDE7gEMhXbmqahWkKCW7+xAr7cC8e7ztwG
   /rXSO+ZngIiWmh2htdVN7w0ywc6xywEtDYxCIeV3O4v4dttmCa8czIU+K
   A==;
IronPort-SDR: 4PhkMe/uHvbHwtZpd3J9B2/xUJBYSpLnq6nCbbpVle048cwvhu7pu0lcs2AwEk0J/+S+R2Vmr6
 6BDzYGbqezjFj0QfMlWMasON1KzN8aufZSU3RrVdvJGEdzWhKCEGbAIAJp078hptVfP3OXh4pJ
 HJpX6NEQ7I02aE4wVsnpB3RkShkGb1KP9OVmBSFKVVpTSerTHkeSdH6QTH4dEzeNGDl+3hOSyw
 aq0OdsGjUesunVheX7KP3Ar2EMZ6yn7GiaYWSLTgHuDtrD1v0Y8njIUYbnU3fXHjpOuSVPIDXC
 XT8=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; 
   d="scan'208";a="144443693"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 20:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIfKQVttKycwLgTi468CG/s7uzJHqPkhdJwbAud/gQMPXgbDRTi9TUhUVUiihpIl5WC226ZPMMfoySvHTgBti0kBdqGD34hxaVMw/9vQdwyqN1Gzc3vExCzmJD4mU8C/FznNYWEGKc1TY2CwzEivOXy55GsEfQ6zheBRQW6zOAi28CRgzM6JHRpCQcDEU53UV6wl3NBlVq30RL5KOAVyw3nX6JesGWXs23k9fPO6vf8TCom0353UjoKeXi6Ru68HNi4sdwjg7wigJ6cSunR3kOecpnuItdZPVfO2w8BuImaVxuYvK8xlmdZB1lPztHHZJNbWJI7QVjK1IOKxpEpu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUYW1G1U7nBoMSiNG6wBBnj/nYwRU2n3scfU0Jom9w4=;
 b=XEcSwnOoWwfdqZiGHXcZ0hbc91oGJmmCWthgLsHdJspjbvlCEzNMJr8rjaHQBaEXpAuYIcOc6zQWnlzyTpwiwb+If//T4qmH5r56JaUk3cDB1oPxLvCFWk9jjDQqWGdPlaPfEWBOAATAgCCUZN5TbgBGkxVI6I+U9aEl9CenBW5w5KKqib0gyn9dv9VHB2HraiQ0NyCwN6ZoZNnEgJcuAzxEu/AffT0i0e7n3oE+x5YS4VoHbWr+CZc/4ua14secJhcOAZXiG6Y3JI9AsUMiMq4D/ZrT9aiIsa6XJ+F7YUKkRhIhh/bw3LWheIdyo5B/ljKK5HNiiXs5LJpQm6tbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUYW1G1U7nBoMSiNG6wBBnj/nYwRU2n3scfU0Jom9w4=;
 b=vSmDlZ0r4wtqihYWX+wsNdz1ccVoPkoYscMNrHg6hBwLPV6wYdxycHkkPOaf65wrkEEr54Q5dKTSqKKjJVzsPNRyEwMagPVc82vbnFDf4OziEV0x4uDx2Fjg5pEMzDaus7GBmEqq+5fXn1c5XVE6CwuCc1qYim3KNN8qE/5vmb0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1049.namprd04.prod.outlook.com (2603:10b6:910:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 12:37:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 12:37:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Judy Brock <judy.brock@samsung.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>
CC:     Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date:   Tue, 16 Jun 2020 12:37:38 +0000
Message-ID: <CY4PR04MB375103860D44AB2DF9040655E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <CGME20200616123503uscas1p22ce22054a1b4152a20437b5abdd55119@uscas1p2.samsung.com>
 <3ab4032c18a8411389d3879026cde2a2@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdd6a7ef-ff62-470f-b8cb-08d811f20dfd
x-ms-traffictypediagnostic: CY4PR04MB1049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB104981B80BA7E13EBF4AA261E79D0@CY4PR04MB1049.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DADuAE4hIgRAKyKRA00MmM44MiktK1WPVcky3lf8JzRMPpOiX9HENedWAXUu/F+lfeOjcvT0bvgKRrCoxA4MgCaoEGH7ga2b9wD1X5rMlz3YHp0fDM0eZkQ3kKW11pWZYCQBnyD62bQReYHNOzAU4zmOz2q6T6EoFLIVdKRnxpJX0CzESOHuRuvKaxfpyTAkHVUdrY1A+EV2xuUgJP0R0lCHRiCJ4616sKqutxgNy4gEqMkliNFx8liO+PeY1SEHJtiJxcZ+t0NzWNMBDxyr4GXGFm5G2qmLCT4RG0JSpKZgMfJACDrzTgDlqSL6UMqLP3/rSu/cf+33EczL7LbVxkjrLph2ajCRsAwAZuSl+d5R+c59rWIcfHXRiFtQrjGfvj65t0Z3w3Y3YppKqZkfKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(83380400001)(4326008)(8676002)(26005)(55016002)(966005)(9686003)(110136005)(2906002)(498600001)(33656002)(54906003)(7696005)(8936002)(5660300002)(30864003)(64756008)(86362001)(66446008)(71200400001)(53546011)(66574015)(6506007)(66556008)(66476007)(186003)(91956017)(66946007)(76116006)(52536014)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LopKZqabxm75YW8tssTYn3trIEKwKDu5aSwaVqH1KEhjA8Rb95fv2spbb+0hMfr3vDOBfbC04Syoc8P08gNaFS8COLu7e5IyHGZdXnJ2xnXm1AbhBsprL/xrnIotO69H1Cd3YEp4pKilcR2GlcS3mDMUzLftKGrFGsgxFMt+ZCDI2wLax3Gj6JU+DW9USkrD5AyiF1nj6HNfgp/nHQZvFW0CC1gL9hirsE88n076DKOFX7jCj4FUM7sROE/osxZwHDrnbmwtpwrH5I7cCcn6aABVk2RGTnhFu/EVUz+V7eIn5yxEa/PD1XhMfVWUejmx3JGHlWKDfdzfAgIdrzIhKadzOgupv8zWs1R1rg8swNq+AkSOuinQ6XMEgJQ02Oi9lpv4qGL4VA3xOqkdNX3maq2j04/l/bHs4CHDG9Mb4k1wfrBOSnggYtRCjUNpGkfOOpwKMkjIX6YKmj63I2a0lyOIrmmWzuIFw5fkpLdSNbv5L1yfWc311ZRf+Yrbgt6D
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd6a7ef-ff62-470f-b8cb-08d811f20dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 12:37:38.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Wt5DHn9D/duup9tM0qjvsm/gOMjqMbS5cvLFWGwro0CPU63fz4e+GpIlvtqazG1en2w9S85ydU2UZrA7dSxcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1049
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/16 21:35, Judy Brock wrote:=0A=
> >>> A namespace that does not support append is not supported by the driv=
er.=0A=
> =0A=
> I am not that knowledgeable about Linux kernel drivers so maybe this is a=
=0A=
> dumb question but won't the driver in question be the default kernel driv=
er=0A=
> for ZNS devices? If so, why would that driver deliberately reject a devic=
e=0A=
> which is 100% compliant with the ZNS spec? That would seem to favor speci=
fic=0A=
> implementations which seems like an inappropriate thing for a community=
=0A=
> driver to do unless there is an actual technical reason the driver is una=
ble=0A=
> to function w/o append. Is there any such reason and if so what is it? Th=
anks=0A=
> and sorry if I've misunderstood.=0A=
=0A=
Judy,=0A=
=0A=
please see my answer to Javier for the rational behind this software design=
=0A=
decision.=0A=
=0A=
> =0A=
> =0A=
> Judy=0A=
> =0A=
> -----Original Message----- From: linux-nvme=0A=
> [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Javier Gonz=
=E1lez =0A=
> Sent: Tuesday, June 16, 2020 5:00 AM To: Matias Bj=F8rling Cc: Jens Axboe=
;=0A=
> Niklas Cassel; Damien Le Moal; Ajay Joshi; Sagi Grimberg; Keith Busch; Dm=
itry=0A=
> Fomichev; Aravind Ramesh; linux-nvme@lists.infradead.org;=0A=
> linux-block@vger.kernel.org; Hans Holmberg; Christoph Hellwig; Matias=0A=
> Bj=F8rling Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces=0A=
> =0A=
> On 16.06.2020 13:18, Matias Bj=F8rling wrote:=0A=
>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:=0A=
>>> On 16.06.2020 08:34, Keith Busch wrote:=0A=
>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined=
 =0A=
>>>> in NVM Express TP4053. Zoned namespaces are discovered based on their =
=0A=
>>>> Command Set Identifier reported in the namespaces Namespace =0A=
>>>> Identification Descriptor list. A successfully discovered Zoned =0A=
>>>> Namespace will be registered with the block layer as a host managed =
=0A=
>>>> zoned block device with Zone Append command support. A namespace that =
=0A=
>>>> does not support append is not supported by the driver.=0A=
>>> =0A=
>>> Why are we enforcing the append command? Append is optional on the =0A=
>>> current ZNS specification, so we should not make this mandatory in the =
=0A=
>>> implementation. See specifics below.=0A=
> =0A=
>> =0A=
>> There is already general support in the kernel for the zone append comma=
nd.=0A=
>> Feel free to submit patches to emulate the support. It is outside the sc=
ope=0A=
>> of this patchset.=0A=
>> =0A=
> =0A=
> It is fine that the kernel supports append, but the ZNS specification doe=
s=0A=
> not impose the implementation for append, so the driver should not do tha=
t=0A=
> either.=0A=
> =0A=
> ZNS SSDs that choose to leave append as a non-implemented optional comman=
d=0A=
> should not rely on emulated SW support, specially when traditional writes=
=0A=
> work very fine for a large part of current ZNS use cases.=0A=
> =0A=
> Please, remove this virtual constraint.=0A=
> =0A=
>>> =0A=
>>>> =0A=
>>>> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com> Signed-off-by:=0A=
>>>> Dmitry Fomichev <dmitry.fomichev@wdc.com> Signed-off-by: Ajay Joshi=0A=
>>>> <ajay.joshi@wdc.com> Signed-off-by: Aravind Ramesh=0A=
>>>> <aravind.ramesh@wdc.com> Signed-off-by: Niklas Cassel=0A=
>>>> <niklas.cassel@wdc.com> Signed-off-by: Matias Bj=F8rling=0A=
>>>> <matias.bjorling@wdc.com> Signed-off-by: Damien Le Moal=0A=
>>>> <damien.lemoal@wdc.com> Signed-off-by: Keith Busch=0A=
>>>> <keith.busch@wdc.com> --- drivers/nvme/host/Makefile |   1 + =0A=
>>>> drivers/nvme/host/core.c   |  91 ++++++++++++-- =0A=
>>>> drivers/nvme/host/nvme.h   |  39 ++++++ drivers/nvme/host/zns.c    |=
=0A=
>>>> 238 +++++++++++++++++++++++++++++++++++++ include/linux/nvme.h       |=
=0A=
>>>> 111 +++++++++++++++++ 5 files changed, 468 insertions(+), 12=0A=
>>>> deletions(-) create mode 100644 drivers/nvme/host/zns.c=0A=
>>>> =0A=
>>>> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile =
=0A=
>>>> index fc7b26be692d..d7f6a87687b8 100644 ---=0A=
>>>> a/drivers/nvme/host/Makefile +++ b/drivers/nvme/host/Makefile @@ -13,6=
=0A=
>>>> +13,7 @@ nvme-core-y                :=3D core.o =0A=
>>>> nvme-core-$(CONFIG_TRACING)        +=3D trace.o =0A=
>>>> nvme-core-$(CONFIG_NVME_MULTIPATH)    +=3D multipath.o =0A=
>>>> nvme-core-$(CONFIG_NVM)            +=3D lightnvm.o =0A=
>>>> +nvme-core-$(CONFIG_BLK_DEV_ZONED)    +=3D zns.o =0A=
>>>> nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)    +=3D fault_inject.o =
=0A=
>>>> nvme-core-$(CONFIG_NVME_HWMON)        +=3D hwmon.o=0A=
>>>> =0A=
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index=
=0A=
>>>> 58f137b9f2c5..e961910da4ac 100644 --- a/drivers/nvme/host/core.c +++=
=0A=
>>>> b/drivers/nvme/host/core.c @@ -89,7 +89,7 @@ static dev_t=0A=
>>>> nvme_chr_devt; static struct class *nvme_class; static struct class=0A=
>>>> *nvme_subsys_class;=0A=
>>>> =0A=
>>>> -static int nvme_revalidate_disk(struct gendisk *disk); +static int=0A=
>>>> _nvme_revalidate_disk(struct gendisk *disk); static void=0A=
>>>> nvme_put_subsystem(struct nvme_subsystem *subsys); static void=0A=
>>>> nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl, unsigned nsid);=
 =0A=
>>>> @@ -287,6 +287,10 @@ void nvme_complete_rq(struct request *req) =0A=
>>>> nvme_retry_req(req); return; } +    } else if=0A=
>>>> (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && +           req_op(req) =3D=3D=0A=
>>>> REQ_OP_ZONE_APPEND) { +        req->__sector =3D=0A=
>>>> nvme_lba_to_sect(req->q->queuedata, +=0A=
>>>> le64_to_cpu(nvme_req(req)->result.u64)); }=0A=
>>>> =0A=
>>>> nvme_trace_bio_complete(req, status); @@ -673,7 +677,8 @@ static inlin=
e=0A=
>>>> blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns, }=0A=
>>>> =0A=
>>>> static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns, -=0A=
>>>> struct request *req, struct nvme_command *cmnd) +        struct reques=
t=0A=
>>>> *req, struct nvme_command *cmnd, +        enum nvme_opcode op) { struc=
t=0A=
>>>> nvme_ctrl *ctrl =3D ns->ctrl; u16 control =3D 0; @@ -687,7 +692,7 @@ s=
tatic=0A=
>>>> inline blk_status_t nvme_setup_rw(struct nvme_ns *ns, if=0A=
>>>> (req->cmd_flags & REQ_RAHEAD) dsmgmt |=3D NVME_RW_DSM_FREQ_PREFETCH;=
=0A=
>>>> =0A=
>>>> -    cmnd->rw.opcode =3D (rq_data_dir(req) ? nvme_cmd_write : =0A=
>>>> nvme_cmd_read); +    cmnd->rw.opcode =3D op; cmnd->rw.nsid =3D=0A=
>>>> cpu_to_le32(ns->head->ns_id); cmnd->rw.slba =3D=0A=
>>>> cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req))); cmnd->rw.length =
=3D=0A=
>>>> cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1); @@ -716,6 +721,=
8=0A=
>>>> @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns, case=
=0A=
>>>> NVME_NS_DPS_PI_TYPE2: control |=3D NVME_RW_PRINFO_PRCHK_GUARD | =0A=
>>>> NVME_RW_PRINFO_PRCHK_REF; +            if (op =3D=3D nvme_cmd_zone_app=
end) =0A=
>>>> +                control |=3D NVME_RW_APPEND_PIREMAP; cmnd->rw.reftag =
=3D=0A=
>>>> cpu_to_le32(t10_pi_ref_tag(req)); break; } @@ -756,6 +763,19 @@=0A=
>>>> blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req, =
=0A=
>>>> case REQ_OP_FLUSH: nvme_setup_flush(ns, cmd); break; +    case=0A=
>>>> REQ_OP_ZONE_RESET_ALL: +    case REQ_OP_ZONE_RESET: +        ret =3D=
=0A=
>>>> nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_RESET); +=0A=
>>>> break; +    case REQ_OP_ZONE_OPEN: +        ret =3D=0A=
>>>> nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OPEN); +=0A=
>>>> break; +    case REQ_OP_ZONE_CLOSE: +        ret =3D=0A=
>>>> nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_CLOSE); +=0A=
>>>> break; +    case REQ_OP_ZONE_FINISH: +        ret =3D=0A=
>>>> nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH); +=0A=
>>>> break; case REQ_OP_WRITE_ZEROES: ret =3D nvme_setup_write_zeroes(ns, r=
eq,=0A=
>>>> cmd); break; @@ -763,8 +783,13 @@ blk_status_t nvme_setup_cmd(struct=
=0A=
>>>> nvme_ns *ns, struct request *req, ret =3D nvme_setup_discard(ns, req,=
=0A=
>>>> cmd); break; case REQ_OP_READ: +        ret =3D nvme_setup_rw(ns, req,=
=0A=
>>>> cmd, nvme_cmd_read); +        break; case REQ_OP_WRITE: -        ret =
=3D=0A=
>>>> nvme_setup_rw(ns, req, cmd); +        ret =3D nvme_setup_rw(ns, req, c=
md,=0A=
>>>> nvme_cmd_write); +        break; +    case REQ_OP_ZONE_APPEND: +=0A=
>>>> ret =3D nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append); break; =0A=
>>>> default: WARN_ON_ONCE(1); @@ -1392,14 +1417,23 @@ static u32=0A=
>>>> nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, return=
=0A=
>>>> effects; }=0A=
>>>> =0A=
>>>> -static void nvme_update_formats(struct nvme_ctrl *ctrl) +static void=
=0A=
>>>> nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects) { struct=0A=
>>>> nvme_ns *ns;=0A=
>>>> =0A=
>>>> down_read(&ctrl->namespaces_rwsem); list_for_each_entry(ns,=0A=
>>>> &ctrl->namespaces, list) -        if (ns->disk &&=0A=
>>>> nvme_revalidate_disk(ns->disk)) +        if (ns->disk &&=0A=
>>>> _nvme_revalidate_disk(ns->disk)) nvme_set_queue_dying(ns); +=0A=
>>>> else if (blk_queue_is_zoned(ns->disk->queue)) { +            /* +=0A=
>>>> * IO commands are required to fully revalidate a zoned +             *=
=0A=
>>>> device. Force the command effects to trigger rescan +             *=0A=
>>>> work so report zones can run in a context with +             * unfroze=
n=0A=
>>>> IO queues. +             */ +            *effects |=3D=0A=
>>>> NVME_CMD_EFFECTS_NCC; +        } up_read(&ctrl->namespaces_rwsem); }=
=0A=
>>>> =0A=
>>>> @@ -1411,7 +1445,7 @@ static void nvme_passthru_end(struct nvme_ctrl=
=0A=
>>>> *ctrl, u32 effects) * this command. */ if (effects &=0A=
>>>> NVME_CMD_EFFECTS_LBCC) -        nvme_update_formats(ctrl); +=0A=
>>>> nvme_update_formats(ctrl, &effects); if (effects &=0A=
>>>> (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) { =0A=
>>>> nvme_unfreeze(ctrl); nvme_mpath_unfreeze(ctrl->subsys); @@ -1526,7=0A=
>>>> +1560,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct=
=0A=
>>>> nvme_ns *ns, * Issue ioctl requests on the first available path.  Note=
=0A=
>>>> that unlike normal * block layer requests we will not retry failed=0A=
>>>> request on another controller. */ -static struct nvme_ns=0A=
>>>> *nvme_get_ns_from_disk(struct gendisk *disk, +struct nvme_ns=0A=
>>>> *nvme_get_ns_from_disk(struct gendisk *disk, struct nvme_ns_head=0A=
>>>> **head, int *srcu_idx) { #ifdef CONFIG_NVME_MULTIPATH @@ -1546,7=0A=
>>>> +1580,7 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk=
=0A=
>>>> *disk, return disk->private_data; }=0A=
>>>> =0A=
>>>> -static void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)=
 =0A=
>>>> +void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx) { if=
=0A=
>>>> (head) srcu_read_unlock(&head->srcu, idx); @@ -1939,21 +1973,28 @@=0A=
>>>> static void nvme_update_disk_info(struct gendisk *disk,=0A=
>>>> =0A=
>>>> static int __nvme_revalidate_disk(struct gendisk *disk, struct =0A=
>>>> nvme_id_ns *id) { +    unsigned lbaf =3D id->flbas &=0A=
>>>> NVME_NS_FLBAS_LBA_MASK; struct nvme_ns *ns =3D disk->private_data; str=
uct=0A=
>>>> nvme_ctrl *ctrl =3D ns->ctrl; +    int ret; u32 iob;=0A=
>>>> =0A=
>>>> /* * If identify namespace failed, use default 512 byte block size so =
*=0A=
>>>> block layer can use before failing read/write for 0 capacity. */ -=0A=
>>>> ns->lba_shift =3D id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds; +=
=0A=
>>>> ns->lba_shift =3D id->lbaf[lbaf].ds; if (ns->lba_shift =3D=3D 0) =0A=
>>>> ns->lba_shift =3D 9;=0A=
>>>> =0A=
>>>> switch (ns->head->ids.csi) { case NVME_CSI_NVM: break; +    case=0A=
>>>> NVME_CSI_ZNS: +        ret =3D nvme_update_zone_info(disk, ns, lbaf); =
+=0A=
>>>> if (ret) +            return ret; +        break; default: =0A=
>>>> dev_warn(ctrl->device, "unknown csi:%d ns:%d\n", ns->head->ids.csi,=0A=
>>>> ns->head->ns_id); @@ -1967,7 +2008,7 @@ static int=0A=
>>>> __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id) io=
b=0A=
>>>> =3D nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));=0A=
>>>> =0A=
>>>> ns->features =3D 0; -    ns->ms =3D le16_to_cpu(id->lbaf[id->flbas & =
=0A=
>>>> NVME_NS_FLBAS_LBA_MASK].ms); +    ns->ms =3D=0A=
>>>> le16_to_cpu(id->lbaf[lbaf].ms); /* the PI implementation requires=0A=
>>>> metadata equal t10 pi tuple size */ if (ns->ms =3D=3D sizeof(struct=0A=
>>>> t10_pi_tuple)) ns->pi_type =3D id->dps & NVME_NS_DPS_PI_MASK; @@ -2010=
,7=0A=
>>>> +2051,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk,=0A=
>>>> struct nvme_id_ns *id) return 0; }=0A=
>>>> =0A=
>>>> -static int nvme_revalidate_disk(struct gendisk *disk) +static int=0A=
>>>> _nvme_revalidate_disk(struct gendisk *disk) { struct nvme_ns *ns =3D=
=0A=
>>>> disk->private_data; struct nvme_ctrl *ctrl =3D ns->ctrl; @@ -2058,6=0A=
>>>> +2099,28 @@ static int nvme_revalidate_disk(struct gendisk *disk) =0A=
>>>> return ret; }=0A=
>>>> =0A=
>>>> +static int nvme_revalidate_disk(struct gendisk *disk) +{ +    int=0A=
>>>> ret; + +    ret =3D _nvme_revalidate_disk(disk); +    if (ret) +=0A=
>>>> return ret; + +#ifdef CONFIG_BLK_DEV_ZONED +    if=0A=
>>>> (blk_queue_is_zoned(disk->queue)) { +        struct nvme_ns *ns =3D=0A=
>>>> disk->private_data; +        struct nvme_ctrl *ctrl =3D ns->ctrl; + +=
=0A=
>>>> ret =3D blk_revalidate_disk_zones(disk, NULL); +        if (!ret) +=0A=
>>>> blk_queue_max_zone_append_sectors(disk->queue, +=0A=
>>>> ctrl->max_zone_append); +    } +#endif +    return ret; +} + static=0A=
>>>> char nvme_pr_type(enum pr_type type) { switch (type) { @@ -2188,6=0A=
>>>> +2251,7 @@ static const struct block_device_operations nvme_fops =3D {=
 =0A=
>>>> .release    =3D nvme_release, .getgeo        =3D nvme_getgeo, =0A=
>>>> .revalidate_disk=3D nvme_revalidate_disk, +    .report_zones    =3D=0A=
>>>> nvme_report_zones, .pr_ops        =3D &nvme_pr_ops, };=0A=
>>>> =0A=
>>>> @@ -2213,6 +2277,7 @@ const struct block_device_operations =0A=
>>>> nvme_ns_head_ops =3D { .ioctl        =3D nvme_ioctl, .compat_ioctl    =
=3D=0A=
>>>> nvme_compat_ioctl, .getgeo        =3D nvme_getgeo, +    .report_zones=
=0A=
>>>> =3D nvme_report_zones, .pr_ops        =3D &nvme_pr_ops, }; #endif /*=
=0A=
>>>> CONFIG_NVME_MULTIPATH */ @@ -4439,6 +4504,8 @@ static inline void=0A=
>>>> _nvme_check_size(void) BUILD_BUG_ON(sizeof(struct nvme_command) !=3D=
=0A=
>>>> 64); BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) !=3D =0A=
>>>> NVME_IDENTIFY_DATA_SIZE); BUILD_BUG_ON(sizeof(struct nvme_id_ns) !=3D=
=0A=
>>>> NVME_IDENTIFY_DATA_SIZE); +    BUILD_BUG_ON(sizeof(struct=0A=
>>>> nvme_id_ns_zns) !=3D NVME_IDENTIFY_DATA_SIZE); +=0A=
>>>> BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) !=3D =0A=
>>>> NVME_IDENTIFY_DATA_SIZE); BUILD_BUG_ON(sizeof(struct=0A=
>>>> nvme_lba_range_type) !=3D 64); BUILD_BUG_ON(sizeof(struct nvme_smart_l=
og)=0A=
>>>> !=3D 512); BUILD_BUG_ON(sizeof(struct nvme_dbbuf) !=3D 64); diff --git=
=0A=
>>>> a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h index=0A=
>>>> 58428e3a590e..662f95fbd909 100644 --- a/drivers/nvme/host/nvme.h +++=
=0A=
>>>> b/drivers/nvme/host/nvme.h @@ -239,6 +239,9 @@ struct nvme_ctrl { u32=
=0A=
>>>> max_hw_sectors; u32 max_segments; u32 max_integrity_segments; +#ifdef=
=0A=
>>>> CONFIG_BLK_DEV_ZONED +    u32 max_zone_append; +#endif u16 crdt[3]; u1=
6=0A=
>>>> oncs; u16 oacs; @@ -403,6 +406,9 @@ struct nvme_ns { u16 sgs; u32 sws;=
 =0A=
>>>> u8 pi_type; +#ifdef CONFIG_BLK_DEV_ZONED +    u64 zsze; +#endif =0A=
>>>> unsigned long features; unsigned long flags; #define NVME_NS_REMOVING=
=0A=
>>>> 0 @@ -568,6 +574,9 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);=0A=
>>>> =0A=
>>>> int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp=
,=0A=
>>>> u8 csi, void *log, size_t size, u64 offset); +struct nvme_ns=0A=
>>>> *nvme_get_ns_from_disk(struct gendisk *disk, +        struct=0A=
>>>> nvme_ns_head **head, int *srcu_idx); +void nvme_put_ns_from_disk(struc=
t=0A=
>>>> nvme_ns_head *head, int idx);=0A=
>>>> =0A=
>>>> extern const struct attribute_group *nvme_ns_id_attr_groups[]; extern=
=0A=
>>>> const struct block_device_operations nvme_ns_head_ops; @@ -689,6=0A=
>>>> +698,36 @@ static inline void nvme_mpath_start_freeze(struct=0A=
>>>> nvme_subsystem *subsys) } #endif /* CONFIG_NVME_MULTIPATH */=0A=
>>>> =0A=
>>>> +#ifdef CONFIG_BLK_DEV_ZONED +int nvme_update_zone_info(struct gendisk=
=0A=
>>>> *disk, struct nvme_ns *ns, +              unsigned lbaf); + +int=0A=
>>>> nvme_report_zones(struct gendisk *disk, sector_t sector, +=0A=
>>>> unsigned int nr_zones, report_zones_cb cb, void *data); + +blk_status_=
t=0A=
>>>> nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req, +=
=0A=
>>>> struct nvme_command *cmnd, +                       enum=0A=
>>>> nvme_zone_mgmt_action action); +#else +#define nvme_report_zones NULL =
=0A=
>>>> + +static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns=
=0A=
>>>> *ns, +        struct request *req, struct nvme_command *cmnd, +=0A=
>>>> enum nvme_zone_mgmt_action action) +{ +    return BLK_STS_NOTSUPP; +} =
=0A=
>>>> + +static inline int nvme_update_zone_info(struct gendisk *disk, +=0A=
>>>> struct nvme_ns *ns, +                    unsigned lbaf) +{ +=0A=
>>>> dev_warn(ns->ctrl->device, +         "Please enable=0A=
>>>> CONFIG_BLK_DEV_ZONED to support ZNS devices\n"); +    return=0A=
>>>> -EPROTONOSUPPORT; +} +#endif + #ifdef CONFIG_NVM int=0A=
>>>> nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node); void=
=0A=
>>>> nvme_nvm_unregister(struct nvme_ns *ns); diff --git=0A=
>>>> a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c new file mode=0A=
>>>> 100644 index 000000000000..c08f6281b614 --- /dev/null +++=0A=
>>>> b/drivers/nvme/host/zns.c @@ -0,0 +1,238 @@ +//=0A=
>>>> SPDX-License-Identifier: GPL-2.0 +/* + * Copyright (C) 2020 Western=0A=
>>>> Digital Corporation or its affiliates. + */ + +#include=0A=
>>>> <linux/blkdev.h> +#include <linux/vmalloc.h> +#include "nvme.h" + =0A=
>>>> +static int nvme_set_max_append(struct nvme_ctrl *ctrl) +{ +    struct=
=0A=
>>>> nvme_command c =3D { }; +    struct nvme_id_ctrl_zns *id; +    int=0A=
>>>> status; + +    id =3D kzalloc(sizeof(*id), GFP_KERNEL); +    if (!id) =
+=0A=
>>>> return -ENOMEM; + +    c.identify.opcode =3D nvme_admin_identify; +=0A=
>>>> c.identify.cns =3D NVME_ID_CNS_CS_CTRL; +    c.identify.csi =3D=0A=
>>>> NVME_CSI_ZNS; + +    status =3D nvme_submit_sync_cmd(ctrl->admin_q, &c=
,=0A=
>>>> id, sizeof(*id)); +    if (status) { +        kfree(id); +=0A=
>>>> return status; +    } + +    ctrl->max_zone_append =3D 1 << (id->zamds=
 +=0A=
>>>> 3); +    kfree(id); +    return 0; +} + +int=0A=
>>>> nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns, +=0A=
>>>> unsigned lbaf) +{ +    struct nvme_effects_log *log =3D=0A=
>>>> ns->head->effects; +    struct request_queue *q =3D disk->queue; +=0A=
>>>> struct nvme_command c =3D { }; +    struct nvme_id_ns_zns *id; +    in=
t=0A=
>>>> status; + +    /* Driver requires zone append support */ +    if=0A=
>>>> (!(log->iocs[nvme_cmd_zone_append] & NVME_CMD_EFFECTS_CSUPP)) +=0A=
>>>> return -ENODEV;=0A=
>>> =0A=
>>> Following up on the initial comment, this check should go.=0A=
>> =0A=
>> See first comment.=0A=
> =0A=
> See above and please remove.=0A=
> =0A=
>> =0A=
>>> =0A=
>>>> + +    /* Lazily query controller append limit for the first zoned =0A=
>>>> namespace */ +    if (!ns->ctrl->max_zone_append) { +        status =
=3D=0A=
>>>> nvme_set_max_append(ns->ctrl); +        if (status) +            retur=
n=0A=
>>>> status; +    }=0A=
>>> =0A=
>>> This should only be applied if append is supported.=0A=
>> =0A=
>> See first comment.=0A=
>> =0A=
>>> =0A=
>>>> + +    id =3D kzalloc(sizeof(*id), GFP_KERNEL); +    if (!id) +=0A=
>>>> return -ENOMEM; + +    c.identify.opcode =3D nvme_admin_identify; +=0A=
>>>> c.identify.nsid =3D cpu_to_le32(ns->head->ns_id); +    c.identify.cns =
=3D=0A=
>>>> NVME_ID_CNS_CS_NS; +    c.identify.csi =3D NVME_CSI_ZNS; + +    status=
 =3D=0A=
>>>> nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*id)); +    if=
=0A=
>>>> (status) +        goto free_data; + +    /* +     * We currently do no=
t=0A=
>>>> handle devices requiring any of the zoned +     * operation=0A=
>>>> characteristics. +     */ +    if (id->zoc) { +        status =3D=0A=
>>>> -EINVAL; +        goto free_data; +    }=0A=
>>> =0A=
>>> I understand that "Variable Zone Capacity" is not supported as it =0A=
>>> requires major changes at this moment, but we should support controller=
s =0A=
>>> that enable "Zone Active Excursions", even when the AER event is not =
=0A=
>>> implemented in this patchset.=0A=
>> =0A=
>> =0A=
>> NAK. Similarly to VZC, this allows an unsuspecting user to have major da=
ta=0A=
>> loss when a zone is suddenly moved to Full.=0A=
> =0A=
> I buy that.=0A=
> =0A=
>> =0A=
>> =0A=
>>> =0A=
>>>> + +    ns->zsze =3D nvme_lba_to_sect(ns,=0A=
>>>> le64_to_cpu(id->lbafe[lbaf].zsze)); +    if (!ns->zsze) { +=0A=
>>>> status =3D -EINVAL; +        goto free_data; +    } + +=0A=
>>>> q->limits.zoned =3D BLK_ZONED_HM; +=0A=
>>>> blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q); +free_data: +=0A=
>>>> kfree(id); +    return status; +} + +static void=0A=
>>>> *nvme_zns_alloc_report_buffer(struct nvme_ns *ns, +=0A=
>>>> unsigned int nr_zones, size_t *buflen) +{ +    struct request_queue *q=
=0A=
>>>> =3D ns->disk->queue; +    size_t bufsize; +    void *buf; + +    const=
=0A=
>>>> size_t min_bufsize =3D sizeof(struct nvme_zone_report) + +=0A=
>>>> sizeof(struct nvme_zone_descriptor); + +    nr_zones =3D min_t(unsigne=
d=0A=
>>>> int, nr_zones, +             get_capacity(ns->disk) >>=0A=
>>>> ilog2(ns->zsze)); + +    bufsize =3D sizeof(struct nvme_zone_report) +=
 +=0A=
>>>> nr_zones * sizeof(struct nvme_zone_descriptor); +    bufsize =3D=0A=
>>>> min_t(size_t, bufsize, +            queue_max_hw_sectors(q) <<=0A=
>>>> SECTOR_SHIFT); +    bufsize =3D min_t(size_t, bufsize,=0A=
>>>> queue_max_segments(q) << PAGE_SHIFT); + +    while (bufsize >=3D=0A=
>>>> min_bufsize) { +        buf =3D __vmalloc(bufsize, +=0A=
>>>> GFP_KERNEL | __GFP_ZERO | __GFP_NORETRY); +        if (buf) { +=0A=
>>>> *buflen =3D bufsize; +            return buf; +        } +        bufs=
ize=0A=
>>>> >>=3D 1; +    } +    return NULL; +} + +static int=0A=
>>>> __nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector, +=0A=
>>>> struct nvme_zone_report *report, +                  size_t buflen) +{ =
+=0A=
>>>> struct nvme_command c =3D { }; +    int ret; + +    c.zmr.opcode =3D=
=0A=
>>>> nvme_cmd_zone_mgmt_recv; +    c.zmr.nsid =3D=0A=
>>>> cpu_to_le32(ns->head->ns_id); +    c.zmr.slba =3D=0A=
>>>> cpu_to_le64(nvme_sect_to_lba(ns, sector)); +    c.zmr.numd =3D=0A=
>>>> cpu_to_le32(nvme_bytes_to_numd(buflen)); +    c.zmr.zra =3D=0A=
>>>> NVME_ZRA_ZONE_REPORT; +    c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;=
 +=0A=
>>>> c.zmr.pr =3D NVME_REPORT_ZONE_PARTIAL; + +    ret =3D=0A=
>>>> nvme_submit_sync_cmd(ns->queue, &c, report, buflen); +    if (ret) +=
=0A=
>>>> return ret; + +    return le64_to_cpu(report->nr_zones); +} + +static=
=0A=
>>>> int nvme_zone_parse_entry(struct nvme_ns *ns, +                 struct=
=0A=
>>>> nvme_zone_descriptor *entry, +                 unsigned int idx,=0A=
>>>> report_zones_cb cb, +                 void *data) +{ +    struct=0A=
>>>> blk_zone zone =3D { }; + +    if ((entry->zt & 0xf) !=3D=0A=
>>>> NVME_ZONE_TYPE_SEQWRITE_REQ) { +        dev_err(ns->ctrl->device,=0A=
>>>> "invalid zone type %#x\n", +                entry->zt); +        retur=
n=0A=
>>>> -EINVAL; +    } + +    zone.type =3D BLK_ZONE_TYPE_SEQWRITE_REQ; +=0A=
>>>> zone.cond =3D entry->zs >> 4; +    zone.len =3D ns->zsze; +=0A=
>>>> zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap)); +=0A=
>>>> zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba)); +=0A=
>>>> zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp)); + +    retur=
n=0A=
>>>> cb(&zone, idx, data); +} + +static int nvme_ns_report_zones(struct=0A=
>>>> nvme_ns *ns, sector_t sector, +            unsigned int nr_zones,=0A=
>>>> report_zones_cb cb, void *data) +{ +    struct nvme_zone_report=0A=
>>>> *report; +    int ret, zone_idx =3D 0; +    unsigned int nz, i; +=0A=
>>>> size_t buflen; + +    report =3D nvme_zns_alloc_report_buffer(ns,=0A=
>>>> nr_zones, &buflen); +    if (!report) +        return -ENOMEM; + +=0A=
>>>> sector &=3D ~(ns->zsze - 1); +    while (zone_idx < nr_zones && sector=
 <=0A=
>>>> get_capacity(ns->disk)) { +        memset(report, 0, buflen); +=0A=
>>>> ret =3D __nvme_ns_report_zones(ns, sector, report, buflen); +        i=
f=0A=
>>>> (ret < 0) +            goto out_free; + +        nz =3D min_t(unsigned=
=0A=
>>>> int, ret, nr_zones); +        if (!nz) +            break; + +=0A=
>>>> for (i =3D 0; i < nz && zone_idx < nr_zones; i++) { +            ret =
=3D=0A=
>>>> nvme_zone_parse_entry(ns, &report->entries[i], +=0A=
>>>> zone_idx, cb, data); +            if (ret) +                goto=0A=
>>>> out_free; +            zone_idx++; +        } + +        sector +=3D=
=0A=
>>>> ns->zsze * nz; +    } + +    ret =3D zone_idx; +out_free: +=0A=
>>>> kvfree(report); +    return ret; +} + +int nvme_report_zones(struct=0A=
>>>> gendisk *disk, sector_t sector, +              unsigned int nr_zones,=
=0A=
>>>> report_zones_cb cb, void *data) +{ +    struct nvme_ns_head *head =3D=
=0A=
>>>> NULL; +    struct nvme_ns *ns; +    int srcu_idx, ret; + +    ns =3D=
=0A=
>>>> nvme_get_ns_from_disk(disk, &head, &srcu_idx); +    if (unlikely(!ns))=
 =0A=
>>>> +        return -EWOULDBLOCK; + +    if (ns->head->ids.csi =3D=3D=0A=
>>>> NVME_CSI_ZNS) +        ret =3D nvme_ns_report_zones(ns, sector, nr_zon=
es,=0A=
>>>> cb, data); +    else +        ret =3D -EINVAL; +=0A=
>>>> nvme_put_ns_from_disk(head, srcu_idx); + +    return ret; +} + =0A=
>>>> +blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct =0A=
>>>> request *req, +        struct nvme_command *c, enum=0A=
>>>> nvme_zone_mgmt_action action) +{ +    c->zms.opcode =3D=0A=
>>>> nvme_cmd_zone_mgmt_send; +    c->zms.nsid =3D=0A=
>>>> cpu_to_le32(ns->head->ns_id); +    c->zms.slba =3D=0A=
>>>> cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req))); +    c->zms.action=
=0A=
>>>> =3D action; + +    if (req_op(req) =3D=3D REQ_OP_ZONE_RESET_ALL) +=0A=
>>>> c->zms.select =3D 1; + +    return BLK_STS_OK; +} diff --git=0A=
>>>> a/include/linux/nvme.h b/include/linux/nvme.h index=0A=
>>>> ea25da572eed..7b3fa7de07bd 100644 --- a/include/linux/nvme.h +++=0A=
>>>> b/include/linux/nvme.h @@ -374,6 +374,30 @@ struct nvme_id_ns { __u8=
=0A=
>>>> vs[3712]; };=0A=
>>>> =0A=
>>>> +struct nvme_zns_lbafe { +    __le64            zsze; +    __u8=0A=
>>>> zdes; +    __u8            rsvd9[7]; +}; + +struct nvme_id_ns_zns { +=
=0A=
>>>> __le16            zoc; +    __le16            ozcs; +    __le32=0A=
>>>> mar; +    __le32            mor; +    __le32            rrl; +=0A=
>>>> __le32            frl; +    __u8            rsvd20[2796]; +    struct=
=0A=
>>>> nvme_zns_lbafe    lbafe[16]; +    __u8            rsvd3072[768]; +=0A=
>>>> __u8            vs[256]; +}; + +struct nvme_id_ctrl_zns { +    __u8=0A=
>>>> zamds; +    __u8    rsvd1[4095]; +}; + enum { NVME_ID_CNS_NS=0A=
>>>> =3D 0x00, NVME_ID_CNS_CTRL        =3D 0x01, @@ -392,6 +416,7 @@ enum {=
=0A=
>>>> =0A=
>>>> enum { NVME_CSI_NVM            =3D 0, +    NVME_CSI_ZNS            =3D=
 2, =0A=
>>>> };=0A=
>>>> =0A=
>>>> enum { @@ -532,6 +557,27 @@ struct nvme_ana_rsp_hdr { __le16=0A=
>>>> rsvd10[3]; };=0A=
>>>> =0A=
>>>> +struct nvme_zone_descriptor { +    __u8        zt; +    __u8=0A=
>>>> zs; +    __u8        za; +    __u8        rsvd3[5]; +    __le64=0A=
>>>> zcap; +    __le64        zslba; +    __le64        wp; +    __u8=0A=
>>>> rsvd32[32]; +}; + +enum { +    NVME_ZONE_TYPE_SEQWRITE_REQ    =3D 0x2,=
 =0A=
>>>> +}; + +struct nvme_zone_report { +    __le64        nr_zones; +    __u=
8=0A=
>>>> resv8[56]; +    struct nvme_zone_descriptor entries[]; +}; + enum { =
=0A=
>>>> NVME_SMART_CRIT_SPARE        =3D 1 << 0, NVME_SMART_CRIT_TEMPERATURE  =
  =3D=0A=
>>>> 1 << 1, @@ -626,6 +672,9 @@ enum nvme_opcode { nvme_cmd_resv_report=0A=
>>>> =3D 0x0e, nvme_cmd_resv_acquire    =3D 0x11, nvme_cmd_resv_release    =
=3D=0A=
>>>> 0x15, +    nvme_cmd_zone_mgmt_send    =3D 0x79, +=0A=
>>>> nvme_cmd_zone_mgmt_recv    =3D 0x7a, +    nvme_cmd_zone_append    =3D=
=0A=
>>>> 0x7d, };=0A=
>>>> =0A=
>>>> #define nvme_opcode_name(opcode)    { opcode, #opcode } @@ -764,6=0A=
>>>> +813,7 @@ struct nvme_rw_command { enum { NVME_RW_LR            =3D 1 =
<<=0A=
>>>> 15, NVME_RW_FUA            =3D 1 << 14, +    NVME_RW_APPEND_PIREMAP=0A=
>>>> =3D 1 << 9, NVME_RW_DSM_FREQ_UNSPEC        =3D 0, NVME_RW_DSM_FREQ_TYP=
ICAL=0A=
>>>> =3D 1, NVME_RW_DSM_FREQ_RARE        =3D 2, @@ -829,6 +879,53 @@ struct=
=0A=
>>>> nvme_write_zeroes_cmd { __le16            appmask; };=0A=
>>>> =0A=
>>>> +enum nvme_zone_mgmt_action { +    NVME_ZONE_CLOSE        =3D 0x1, +=
=0A=
>>>> NVME_ZONE_FINISH    =3D 0x2, +    NVME_ZONE_OPEN        =3D 0x3, +=0A=
>>>> NVME_ZONE_RESET        =3D 0x4, +    NVME_ZONE_OFFLINE    =3D 0x5, +=
=0A=
>>>> NVME_ZONE_SET_DESC_EXT    =3D 0x10, +}; + +struct nvme_zone_mgmt_send_=
cmd=0A=
>>>> { +    __u8            opcode; +    __u8            flags; +    __u16=
=0A=
>>>> command_id; +    __le32            nsid; +    __le32=0A=
>>>> cdw2[2]; +    __le64            metadata; +    union nvme_data_ptr=0A=
>>>> dptr; +    __le64            slba; +    __le32            cdw12; +=0A=
>>>> __u8            action;=0A=
>>> =0A=
>>> Why not zsa to make it easier to match to the spec=0A=
>>> =0A=
>>> =0A=
>>>> +    __u8            select;=0A=
>>> =0A=
>>> sel_all?=0A=
>>> =0A=
>>>> +    __u8            rsvd13[2]; +    __le32            cdw14[2]; +}; +=
 =0A=
>>>> +struct nvme_zone_mgmt_recv_cmd { +    __u8            opcode; +=0A=
>>>> __u8            flags; +    __u16            command_id; +    __le32=
=0A=
>>>> nsid; +    __le64            rsvd2[2]; +    union nvme_data_ptr=0A=
>>>> dptr; +    __le64            slba; +    __le32            numd; +=0A=
>>>> __u8            zra; +    __u8            zrasf; +    __u8=0A=
>>>> pr;=0A=
>>> =0A=
>>> Partial Report is just one bit in the "Zone Receive Action Specific =0A=
>>> Features". What about zrasfe?=0A=
>> =0A=
>> There currently no users of pr, and bit 1-7 are reserved in the spec. Us=
ers=0A=
>> of the pr variable should shift and mask as necessary.=0A=
>> =0A=
>> zrasf looks good to me. It is defined as a byte in the spec.=0A=
> =0A=
> I meant for the pr variable name. Agree with the rest.=0A=
> =0A=
>> =0A=
>>> =0A=
>>>> +    __u8            rsvd13; +    __le32            cdw14[2]; +}; + =
=0A=
>>>> +enum { +    NVME_ZRA_ZONE_REPORT        =3D 0, +=0A=
>>>> NVME_ZRASF_ZONE_REPORT_ALL    =3D 0, +    NVME_REPORT_ZONE_PARTIAL    =
=3D=0A=
>>>> 1, +}; + /* Features */=0A=
>>>> =0A=
>>>> enum { @@ -1300,6 +1397,8 @@ struct nvme_command { struct=0A=
>>>> nvme_format_cmd format; struct nvme_dsm_cmd dsm; struct=0A=
>>>> nvme_write_zeroes_cmd write_zeroes; +        struct=0A=
>>>> nvme_zone_mgmt_send_cmd zms; +        struct nvme_zone_mgmt_recv_cmd=
=0A=
>>>> zmr; struct nvme_abort_cmd abort; struct nvme_get_log_page_command=0A=
>>>> get_log_page; struct nvmf_common_command fabrics; @@ -1433,6 +1532,18=
=0A=
>>>> @@ enum { NVME_SC_DISCOVERY_RESTART    =3D 0x190, NVME_SC_AUTH_REQUIRE=
D=0A=
>>>> =3D 0x191,=0A=
>>>> =0A=
>>>> +    /* +     * I/O Command Set Specific - Zoned commands: +     */ +=
=0A=
>>>> NVME_SC_ZONE_BOUNDARY_ERROR    =3D 0x1b8, +    NVME_SC_ZONE_FULL      =
  =3D=0A=
>>>> 0x1b9, +    NVME_SC_ZONE_READ_ONLY        =3D 0x1ba, +=0A=
>>>> NVME_SC_ZONE_OFFLINE        =3D 0x1bb, +    NVME_SC_ZONE_INVALID_WRITE=
=0A=
>>>> =3D 0x1bc, +    NVME_SC_ZONE_TOO_MANY_ACTIVE    =3D 0x1bd, +=0A=
>>>> NVME_SC_ZONE_TOO_MANY_OPEN    =3D 0x1be, +=0A=
>>>> NVME_SC_ZONE_INVALID_TRANSITION    =3D 0x1bf, + /* * Media and Data=0A=
>>>> Integrity Errors: */ -- 2.24.1=0A=
>>>> =0A=
>> =0A=
> =0A=
> _______________________________________________ linux-nvme mailing list =
=0A=
> linux-nvme@lists.infradead.org =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org=
_mailman_listinfo_linux-2Dnvme&d=3DDwIGaQ&c=3DJfeWlBa6VbDyTXraMENjy_b_0yKWu=
qQ4qY-FPhxK4x8w-TfgRBDyeV4hVQQBEgL2&r=3DYJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iTR=
s6chBf6s&m=3DvuAxizG1aX1Dc1Tj0NPWUbhwmZIe1Y12kNIbJHLIdBU&s=3DuCIVhY22an8jd0=
FJv1lizpv_vA0tpe37xpz4af6KA10&e=3D=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
