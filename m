Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0057C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848E520786
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S2DowYcx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="muhTa93B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFQHYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:24:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45685 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFQHYV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 03:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592378659; x=1623914659;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pzffFWEFtj+kuHok/NfoUcxc0FUh/Fue9aIz1l2DtX4=;
  b=S2DowYcx2c4qV1FibuGeYrHlb7COjfxcehrJKDJuN47tO7TFEOTR2qqi
   pGffhCjVyOE38pVsiknyXNsOSmSr4bgSz6h+sWyoHtbV/tydWVxwwvSvc
   3QBqtvUOoj9CjIHj+XOXbgBHTlIlXmf1AY7Q+lgddal9iUpq0EIJrhcwx
   bN4YWZOl/5DJZ7oLF6ctIWl5BODljRfoyZlgFU7lGeRCgl3g+0gC+gb/w
   SMgvpZvk9U4wZTIAg2/E0HgMgqz/Yl9ucYYW7BtgVj9tcTs+Nurtb8qnT
   QyCS2vW5wM91BcHnfr0ZaUAJm+sz6av/dMs+bBemqiW2bInfydt/8btOB
   Q==;
IronPort-SDR: Aw3wORuWWuXcxcCh9QxZGLjJTPfeZoc4UpJNSnh8AmPrBXgkzOBjVWafS0ggX3v3taZMPSZu+3
 xzCHvBGzN0WEsHQQPNwLQyAnCERZx26Ln2jzTpOnc/T93Ul7/AnBelOmGYgAd5Y+esZcxTijQ8
 Xd0Lf+2ifnF8GmJ0yx6Ccpw91zSVFZm3TANvmaxCYDBx7oltnjGL67d5r0wEp133Xz21FQN0iL
 Q5qmLD5WVMYyj17dftN2ZGoxs5IoRF1YY4hGOcyZN0T6yOII5bFJumzzzk02FWpvb1y79Z4hhO
 r8k=
X-IronPort-AV: E=Sophos;i="5.73,521,1583164800"; 
   d="scan'208";a="140200088"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 15:24:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpemu46OBvCBSmjzvo5kWQVpPimAVK6s7nWyVndbQI/bz9c2UytS48q8ai2z253Mjs3623WVaDu2a9814nkbY5w8icR6Ee1ZYq7rESIhXZdo+7wphZg5u+RvCUlBAoZ4YgnSUYf6HGRLZ3eStD2nRIRGscH2NFMlLwOBTK0V8PryfnPH4qI5Drh2WLqBZ+jM3MkCNkFpDz6w+KpsOtGbCxn99mLk0NlL6nPUSuUW1PFcMY+psXpqVMHKUEl4ATSFnLp0WEKJyVckqYRZ5tLDzVNPH+14i9wJdHsbRFKaHaFR/2MYR7ackTFNG5mcRbddy6GfiV1WNN6ugwTQ/iN5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUE9nwnpwwBXhxZJxXi+dnYvntRTTl9Nq9xP3ErS9C8=;
 b=Tc3xgxDuO8RXVpnle3XhxMjBCjFn+ovD2dFsthoYmE/mygBM9bwRM5g18X++bJ7OvalgCCM0NT4yAxFEdKyQ3K2PbF2R3woc0gBfeDLRjDVJj8W4njLqv3Irlbk3Oh2E8Wm/yhzUCD+0q0fM882X8Y40IgOtCl0Hsabok2dUmqpz9WyWtfa8TYgG7w/Q9PYVUJrvEN+iioRBQ1VH9dKoDBI601jqxD6Pu5SOqkFCz1D/aGLfQjyTTmsE5xbEFAVfyCSP6DZgooJzDefzEDZ1HqxsV9sGnhfMgrXcm58RAnyQqWxbar9c+8cZR7/jLWnXJ1OCwfG9CKqUYg/MZs1QYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUE9nwnpwwBXhxZJxXi+dnYvntRTTl9Nq9xP3ErS9C8=;
 b=muhTa93B6F1JuLnuUgXGQkes4mc0kn9iJNgMMGYgu1y7IZTqUUu6Av86IRw+MjwD2xCV/d9A8ZC1w9Gp9M6/KpTOYQo88E12gR4iBfkOR9tIuKCYs34ACFY8J5hsalzMIZep/XQtp4yNuZijeXenM26EA+T7L1w9+VZXKno7jsw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0761.namprd04.prod.outlook.com (2603:10b6:903:e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 17 Jun
 2020 07:24:18 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 07:24:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
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
Date:   Wed, 17 Jun 2020 07:24:17 +0000
Message-ID: <CY4PR04MB3751827E66EDECCE9268F8C9E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <CY4PR04MB37513B2D2B7AAE343ABF14C1E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617060953.ypviiz75cua4bt25@mpHalley.localdomain>
 <CY4PR04MB375154B897296A3A4C82503DE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617070234.jbeex2i7hs5urbqt@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 134d96d8-365d-4880-4afe-08d8128f7257
x-ms-traffictypediagnostic: CY4PR04MB0761:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0761E5EC671340F718B8D647E79A0@CY4PR04MB0761.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1txJnA/OpC8tUYLZv0rWGZYF7KgV4AtaEp3j1DnRhIl3ul95GrABT4Wrd5AsdpTwdJG3T8fQ/mtvDn0TxmQwdOO1TIkcEfAXl28wNnS657Uo0VZKSeUi49b+iv7LQk+1kX1VUre8tVocqUA7jgbA8GzLMGCGL7HrJMwFwKZtkCS2ihDuhgFwOdVnusRwrkTiPX4olHGAV8W8mMV+J6TkckGw9erulFi93jRnZ8+uP7mz6desCrt3v6e50DkJ1utOFlKXXQzWLcbIJD6w6oQ0kJyBB0gQVKdQCf23GErFK0aY5JamoxtoNHoClwB7cWvdsh2XFpL0Qd30pvLnjkirjBBF89R/om93fiDyg8Ew9cnxwhRAczDHd4jfcqxCyM0iuxlLQ3vDbkR8LkDcq+BIVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(52536014)(5660300002)(6916009)(71200400001)(66574015)(33656002)(26005)(6506007)(7696005)(53546011)(54906003)(316002)(186003)(478600001)(966005)(91956017)(86362001)(4326008)(76116006)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(8936002)(8676002)(83380400001)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OiuVzpRX01IBkbU/5daT9G5ML3j++OTmojQQd7BXSX7fm0AVaZxng7zBACNTU8JYFX/RHHQQSBEhFmFhRghtfQkJuwptOqfv8XhFg8MetUTrfqJi3fRljkhwi2fMJ4IjGDD6QOWlN8DjQL/nx8nNXucjYfLv5kkhAQJHJip8K3ya6X6ZPsVYiNjmeCidnjGZX1sms7qiCbPeWNcIvkG0CnE4Ww+56tRtZzuETCvdZhkESUyyUIBSyKYWYxVpo6gxAuOsmtTnRavnv3Sb4ggU+jALT4NaGpk/t6r0Xh17pced3md2QZh4VXrcolocEpr7CwF+apQ3zM319rSFShR3op/VMVCe47nlQE4TIq/dh4ybaVp9WEaI3URcJTMEGMaH/iPk8tmMiQdRtGb5zq6oPH4L5EEGllvQ2noT156HIsmED17PCr4vtCpEQCq3llzqZtYZlsMLlV+9/0Puewfq6eRasl/tvqNttatJHjmyxxdYS9v2uGRAtMQCEKz0cLMH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134d96d8-365d-4880-4afe-08d8128f7257
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 07:24:18.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mJ9mjCCtzDeiu/ca4c3IUwz1InrPA9OsNizAkPSM03Q87xXijiN9EwYF+wLJfebeQgtQ/i8bKH3CdTAiQszxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0761
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/17 16:02, Javier Gonz=E1lez wrote:=0A=
> On 17.06.2020 06:47, Damien Le Moal wrote:=0A=
>> On 2020/06/17 15:10, Javier Gonz=E1lez wrote:=0A=
>>> On 17.06.2020 00:14, Damien Le Moal wrote:=0A=
>>>> On 2020/06/17 0:02, Javier Gonz=E1lez wrote:=0A=
>>>>> On 16.06.2020 14:42, Damien Le Moal wrote:=0A=
>>>>>> On 2020/06/16 23:16, Javier Gonz=E1lez wrote:=0A=
>>>>>>> On 16.06.2020 12:35, Damien Le Moal wrote:=0A=
>>>>>>>> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:=0A=
>>>>>>>>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:=0A=
>>>>>>>>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:=0A=
>>>>>>>>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:=0A=
>>>>>>>>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:=0A=
>>>>>>>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:=0A=
>>>>>>>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command S=
et defined=0A=
>>>>>>>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based=
 on their=0A=
>>>>>>>>>>>>>> Command Set Identifier reported in the namespaces Namespace=
=0A=
>>>>>>>>>>>>>> Identification Descriptor list. A successfully discovered Zo=
ned=0A=
>>>>>>>>>>>>>> Namespace will be registered with the block layer as a host =
managed=0A=
>>>>>>>>>>>>>> zoned block device with Zone Append command support. A names=
pace that=0A=
>>>>>>>>>>>>>> does not support append is not supported by the driver.=0A=
>>>>>>>>>>>>>=0A=
>>>>>>>>>>>>> Why are we enforcing the append command? Append is optional o=
n the=0A=
>>>>>>>>>>>>> current ZNS specification, so we should not make this mandato=
ry in the=0A=
>>>>>>>>>>>>> implementation. See specifics below.=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>>>=0A=
>>>>>>>>>>>> There is already general support in the kernel for the zone ap=
pend=0A=
>>>>>>>>>>>> command. Feel free to submit patches to emulate the support. I=
t is=0A=
>>>>>>>>>>>> outside the scope of this patchset.=0A=
>>>>>>>>>>>>=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> It is fine that the kernel supports append, but the ZNS specifi=
cation=0A=
>>>>>>>>>>> does not impose the implementation for append, so the driver sh=
ould not=0A=
>>>>>>>>>>> do that either.=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> ZNS SSDs that choose to leave append as a non-implemented optio=
nal=0A=
>>>>>>>>>>> command should not rely on emulated SW support, specially when=
=0A=
>>>>>>>>>>> traditional writes work very fine for a large part of current Z=
NS use=0A=
>>>>>>>>>>> cases.=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> Please, remove this virtual constraint.=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> The Zone Append command is mandatory for zoned block devices. Pl=
ease=0A=
>>>>>>>>>> see https://lwn.net/Articles/818709/ for the background.=0A=
>>>>>>>>>=0A=
>>>>>>>>> I do not see anywhere in the block layer that append is mandatory=
 for=0A=
>>>>>>>>> zoned devices. Append is emulated on ZBC, but beyond that there i=
s no=0A=
>>>>>>>>> mandatory bits. Please explain.=0A=
>>>>>>>>=0A=
>>>>>>>> This is to allow a single write IO path for all types of zoned blo=
ck device for=0A=
>>>>>>>> higher layers, e.g file systems. The on-going re-work of btrfs zon=
e support for=0A=
>>>>>>>> instance now relies 100% on zone append being supported. That sign=
ificantly=0A=
>>>>>>>> simplifies the file system support and more importantly remove the=
 need for=0A=
>>>>>>>> locking around block allocation and BIO issuing, allowing to prese=
rve a fully=0A=
>>>>>>>> asynchronous write path that can include workqueues for efficient =
CPU usage of=0A=
>>>>>>>> things like encryption and compression. Without zone append, file =
system would=0A=
>>>>>>>> either (1) have to reject these drives that do not support zone ap=
pend, or (2)=0A=
>>>>>>>> implement 2 different write IO path (slower regular write and zone=
 append). None=0A=
>>>>>>>> of these options are ideal, to say the least.=0A=
>>>>>>>>=0A=
>>>>>>>> So the approach is: mandate zone append support for ZNS devices. T=
o allow other=0A=
>>>>>>>> ZNS drives, an emulation similar to SCSI can be implemented, with =
that emulation=0A=
>>>>>>>> ideally combined to work for both types of drives if possible.=0A=
>>>>>>>=0A=
>>>>>>> Enforcing QD=3D1 becomes a problem on devices with large zones. In=
=0A=
>>>>>>> a ZNS device that has smaller zones this should not be a problem.=
=0A=
>>>>>>=0A=
>>>>>> Let's be precise: this is not running the drive at QD=3D1, it is "at=
 most one=0A=
>>>>>> write *request* per zone". If the FS is simultaneously using multipl=
e block=0A=
>>>>>> groups mapped to different zones, you will get a total write QD > 1,=
 and as many=0A=
>>>>>> reads as you want.=0A=
>>>>>>=0A=
>>>>>>> Would you agree that it is possible to have a write path that relie=
s on=0A=
>>>>>>> QD=3D1, where the FS / application has the responsibility for enfor=
cing=0A=
>>>>>>> this? Down the road this QD can be increased if the device is able =
to=0A=
>>>>>>> buffer the writes.=0A=
>>>>>>=0A=
>>>>>> Doing QD=3D1 per zone for writes at the FS layer, that is, at the BI=
O layer does=0A=
>>>>>> not work. This is because BIOs can be as large as the FS wants them =
to be. Such=0A=
>>>>>> large BIO will be split into multiple requests in the block layer, r=
esulting in=0A=
>>>>>> more than one write per zone. That is why the zone write locking is =
at the=0A=
>>>>>> scheduler level, between BIO split and request dispatch. That avoids=
 the=0A=
>>>>>> multiple requests fragments of a large BIO to be reordered and fail.=
 That is=0A=
>>>>>> mandatory as the block layer itself can occasionally reorder request=
s and lower=0A=
>>>>>> levels such as AHCI HW is also notoriously good at reversing sequent=
ial=0A=
>>>>>> requests. For NVMe with multi-queue, the IO issuing process getting =
rescheduled=0A=
>>>>>> on a different CPU can result in sequential IOs being in different q=
ueues, with=0A=
>>>>>> the likely result of an out-of-order execution. All cases are avoide=
d with zone=0A=
>>>>>> write locking and at most one write request dispatch per zone as rec=
ommended by=0A=
>>>>>> the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silen=
t on this).=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> I understand. I agree that the current FSs supporting ZNS follow this=
=0A=
>>>>> approach and it makes sense that there is a common interface that=0A=
>>>>> simplifies the FS implementation. See the comment below on the part I=
=0A=
>>>>> believe we see things differently.=0A=
>>>>>=0A=
>>>>>=0A=
>>>>>>> I would be OK with some FS implementations to rely on append and im=
pose=0A=
>>>>>>> the constraint that append has to be supported (and it would be our=
 job=0A=
>>>>>>> to change that), but I would like to avoid the driver rejecting=0A=
>>>>>>> initializing the device because current FS implementations have=0A=
>>>>>>> implemented this logic.=0A=
>>>>>>=0A=
>>>>>> What is the difference between the driver rejecting drives and the F=
S rejecting=0A=
>>>>>> the same drives ? That has the same end result to me: an entire clas=
s of devices=0A=
>>>>>> cannot be used as desired by the user. Implementing zone append emul=
ation avoids=0A=
>>>>>> the rejection entirely while still allowing the FS to have a single =
write IO=0A=
>>>>>> path, thus simplifying the code.=0A=
>>>>>=0A=
>>>>> The difference is that users that use a raw ZNS device submitting I/O=
=0A=
>>>>> through the kernel would still be able to use these devices. The resu=
lt=0A=
>>>>> would be that the ZNS SSD is recognized and initialized, but the FS=
=0A=
>>>>> format fails.=0A=
>>>>=0A=
>>>> I understand your point of view. Raw ZNS block device access by an app=
lication=0A=
>>>> is of course a fine use case. SMR also has plenty of these.=0A=
>>>>=0A=
>>>> My point is that enabling this regular write/raw device use case shoul=
d not=0A=
>>>> prevent using btrfs or other kernel components that require zone appen=
d.=0A=
>>>> Implementing zone append emulation in the NVMe/ZNS driver for devices =
without=0A=
>>>> native support for the command enables *all* use cases without impacti=
ng the use=0A=
>>>> case you are interested in.=0A=
>>>>=0A=
>>>> This approach is, in my opinion, far better. No one is left out and th=
e user=0A=
>>>> gains a flexible system with different setup capabilities. The user wi=
ns here.=0A=
>>>=0A=
>>> So, do you see a path where we enable the following:=0A=
>>>=0A=
>>>     1. We add the emulation layer to the NVMe driver for enabling FSs=
=0A=
>>>        that currently support zoned devices=0A=
>>>     2. We add a path from user-space (e.g., uring) to enable passthru=
=0A=
>>>        commands to the NVMe driver to enable a raw ZNS path from the=0A=
>>>        application. This path does not require the device to support=0A=
>>>        append. An initial limitation is that I/Os must be of < 127 bio=
=0A=
>>>        segments (same as append) to avod bio splits=0A=
>>>     3. As per above, the NVMe driver allows ZNS drives without append=
=0A=
>>>        support to be initialized and the check moves to the FS=0A=
>>>        formatting.=0A=
>>>=0A=
>>> 2 and 3. is something we have on our end. We need to rebase on top of=
=0A=
>>> the patches you guys submitted. 1. is something we can help with after=
=0A=
>>> that.=0A=
>>>=0A=
>>> Does the above make sense to you?=0A=
>>=0A=
>> Doing (1) first will give you a regular nvme namespace block device that=
 you can=0A=
>> use to send passthrough commands with ioctl(). So (1) gives you (2).=0A=
>>=0A=
>> However, I do not understand what io-uring has to do with passthrough. i=
o-uring=0A=
>> being a block layer functionality, I do not think you can use it to send=
=0A=
>> passthrough commands to the driver. I amy be wrong though, but my unders=
tanding=0A=
>> is that for NVMe, passthrough is either ioctl() to device file or the en=
tire=0A=
>> driver in user space with SPDK.=0A=
> =0A=
> We would like to have an async() passthru I/O path and it seems possible=
=0A=
> to do through uring. As mentioned on the other email, the goal is to=0A=
> have the I/O go through the block layer for better integration, but this=
=0A=
> work is still ongoing. See other thread.=0A=
=0A=
Indeed. I do not think that is special to ZNS at all.=0A=
=0A=
>> As for (3), I do not understand your point. If you have (1), then an FS=
=0A=
>> requiring zone append will work.=0A=
> =0A=
> In order to enable (2), we need the device to come up first. At the=0A=
> moment the NVMe driver rejects ZNS devices without append support, so=0A=
> either ioctl() or the uring path will not work.=0A=
=0A=
I repeat again here: if you implement zone append emulation, there is no re=
ason=0A=
to reject devices that do not have zone append native support. Zone append=
=0A=
emulation gives you the block device, you can do ioctl(), implement the new=
=0A=
async passthrough and file systems requiring zone append work too. All prob=
lems=0A=
solved.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
