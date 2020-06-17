Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD2C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 00:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A702098B
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 00:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WbLatL/b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jtn31mAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFQAil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:38:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33219 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQAij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 20:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592354318; x=1623890318;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PAnA/2hOPcTU3fPjSDFqtsCrAEjKrWdU5W3/SB6EELM=;
  b=WbLatL/bO5DDG0+YAj3NIPpguJ+RdESXT7dFvAGVRI7gz3iQSkJbgl0E
   i05GR3O2BC0im0Lzlz+9SE0yIW3a12tBmGDxCj+26+Dz380h/Hl9VLlZ6
   a0YhhH7cFnb17B3H1ooBqhuWoiIkihJ2gtN3/5syPAvnCsQlMtd5hP4k4
   gBwH14BNbQlJxRms3IHiyX6QUi6+V3FfZapUdkXVNXA4wrYGJEw9JA6iH
   lMHL3jmKVScryAOJmn+1BLJcCpOJDD0sqj83NR9jQ24MxwEi6XAboiD/B
   HhhrGeXHuc1fKUfn2cDBQRUJCBjU+zO7eoGZ/gtsm79Q3MhlA1iFequzb
   Q==;
IronPort-SDR: CvVVRM4M86y3YdGjfRGVkrUxbv6RPd471+6AkxKUgjfNlGYyY7VuMQlcBMSvG4yrgv9DrQ75pr
 o/M5LOfgDt+q7xWbVd3zTwsJO9ADDsZjh05uuzhXQouli5nUaVfdOioiabMOS2d0s0Xlej3msI
 iMzLUoAsd/TdGQSBRTbplFPr7njIa0zaRBLVg5qpFFL5pXQ61jEmld7a96XrjVeBOBmx4xlmSo
 I2aU9HCWZuDvhuZxnCk1Hk2+Qzi+D8BiDVkK8PMB6AxOjQ7PiHpkCtA0LQYFQnOa2ez4WQnWwg
 HOs=
X-IronPort-AV: E=Sophos;i="5.73,520,1583164800"; 
   d="scan'208";a="140174193"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 08:38:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrIs0vWQw5+Y1dpAVry7ev5feTJDTHCTRt/n/8PTQj4Kav4i54ZB7nCwfgzf9GLskRcVaCO+AIfofpQdq03PwtJfMHhIiVHaYgdrKOxmKJBVM7kSa+58UDnaDgTBI0+KI3cMYdtSOOqniaEUQSQxOIsBKignCEjiImu7IV97MY0IqEnKmxgyy2TWVykBtK/F3f3QayX1kDiNti5OThTwxvagY08It8b0RUaIZ3FiuPz6MTEhB8qG50I/KEHxUXUtTGu8kWa4tY1e8jH7vHCcKj4NlrAmVPVcZqDaOO2rC8/vo5qSX/KXjBPNkuNrdhalsbYeRMGzyP1MUtFriOPzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAnA/2hOPcTU3fPjSDFqtsCrAEjKrWdU5W3/SB6EELM=;
 b=AqRzw3AaA/CXBurztzzJFSFLAvdMg8xnqn4/Lz6FEYEWu60O89dzO57BP1FNUwAEe8CjJXagB+MSGuk+Wyu4r+oVjLB+pBU+D3zXVkWwu04kZ/fszqQCMWTjtXxNLr2bRaczvW5nWszzfLtgIw+vkpJcszTD9eMtLjcbEIfNQgumzjQp1TKHkTr0b22bztV8Gx85l8/qYtq8Cu1WVMXVXjJ3RkIOChlTVXIE6BwCMgDFbemGQDJRbstwz2yeUJT58jbbXixW1szvfgZ8rlokTGl6gaQyssz+wfLcUtcMUsa4bbcgX3fHy24C3V0o+Hf9pu8KGdOzlbiFhND1tyg30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAnA/2hOPcTU3fPjSDFqtsCrAEjKrWdU5W3/SB6EELM=;
 b=jtn31mAwKqamGkh/o/Ngv2vtH8PTCxid2B0FC2btyVdrwsln984lryK2d/AQ2HvDxR9UqUb2tcNi4hn6PqEbLQH28EMYCU4sq6axsiHrj1t/hJeyIrb4GDsrxQq4u5/yS8xuW8yjQkd1uqnSTfulW+a5Tuaz815F3rRhvuP18Pk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1206.namprd04.prod.outlook.com (2603:10b6:903:b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Wed, 17 Jun
 2020 00:38:35 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 00:38:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Keith Busch <kbusch@kernel.org>
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
Date:   Wed, 17 Jun 2020 00:38:35 +0000
Message-ID: <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e741d6f-a515-4612-1575-08d81256c511
x-ms-traffictypediagnostic: CY4PR04MB1206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1206CE69B8331794D1625A0DE79A0@CY4PR04MB1206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbAbWkGl7peXTlbtz81bOFJhT8dMWI04FhTJry/KhomfdS0muMIwaDPXutKo1vxw1azoHe8oL0qoGJqdG8IN2Wvv8ljEOUDIs7OgZJlDe888NFIO5MNsnlo8vd7MgB9MejdfRvYKFV3qMD2RDCM9XNTlre2CVp3qlpFTAx/I0FIvTvi5l9wusDf3g/8SqBuMkWP+y2x7zKmZIF5z/SbuEk8sLpRTUfs5cIceecTOlgsg52N9y6t1qzerGcxAy7hbs7wudNnX4iXo7DialH3EOaCzswFK8hQxxo1tFstsNWRz6D2lNkXNQKfpYhUX/UaVzn3V1vfkfr4UpUzuYA7MISzeq5xjA4IGyH/gZD/FPbTU0zYVvaTvJn9UOmf8h0MmY4ZXo9qyckZHn3WVx6lqZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(9686003)(7696005)(110136005)(86362001)(6506007)(53546011)(71200400001)(66574015)(54906003)(52536014)(478600001)(8936002)(66556008)(316002)(66446008)(2906002)(76116006)(64756008)(91956017)(5660300002)(66476007)(66946007)(966005)(33656002)(26005)(83380400001)(55016002)(186003)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YdXKCJV5ghBsH0IToyPULkpCuE9pIKeBtxlMsNQ6l9OPqS9KV6KdrDtiZ4JnFUwyVIm8GZrTuO+F/UFZc7KiOSSltkwf84+Tbz4wz3MzxD/H0LYejoarq0pSw0ZGskRbWVBmFtukRNDi7c0z64I/XIOH6nfhkBeMvm8kdA1kxDti0dUfXXcchbnktkzLOe+gmRaT06eDY+TVxmYGYxCGJh8JG5aVMHjKVy+7/3LWJfkyfPGcaHBKRpMGcLevSlRkShMXh5dK+O3qnhM/S9ztDamm3Hw2/YDigeys/cZy79RmlwJq4LUK/uNmRVNL4YWfB7m4+2mNksSE4GAaQ0Bhdku/0LNAVSdWY+e60ogMg2Vy0B81oR19xyX3alTeZ6IHntuRqDywjUdltEBhhO9DAb2W3YwwTiQxakbdChks6v4rbAJmMDTjr1CYJCuUi9Rc16/ejaNPfsPKfgwOmZsAk3jc+Sm156rjmJz6HNtxrP2jd8yWDo49Ti97NSAPydVx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e741d6f-a515-4612-1575-08d81256c511
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 00:38:35.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYX5i5iNWJhaF9GOxpgkl6LPfYuNItck5POLm2GvRQvTj7jNdmrJt862G+8tb2o4II8Rf2ULiQRXLfqUdlyCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1206
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/17 1:13, Javier Gonz=E1lez wrote:=0A=
> On 16.06.2020 09:07, Keith Busch wrote:=0A=
>> On Tue, Jun 16, 2020 at 05:55:26PM +0200, Javier Gonz=E1lez wrote:=0A=
>>> On 16.06.2020 08:48, Keith Busch wrote:=0A=
>>>> On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier Gonz=E1lez wrote:=0A=
>>>>> This depends very much on how the FS / application is managing=0A=
>>>>> stripping. At the moment our main use case is enabling user-space=0A=
>>>>> applications submitting I/Os to raw ZNS devices through the kernel.=
=0A=
>>>>>=0A=
>>>>> Can we enable this use case to start with?=0A=
>>>>=0A=
>>>> I think this already provides that. You can set the nsid value to=0A=
>>>> whatever you want in the passthrough interface, so a namespace block=
=0A=
>>>> device is not required to issue I/O to a ZNS namespace from user space=
.=0A=
>>>=0A=
>>> Mmmmm. Problem now is that the check on the nvme driver prevents the ZN=
S=0A=
>>> namespace from being initialized. Am I missing something?=0A=
>>=0A=
>> Hm, okay, it may not work for you. We need the driver to create at least=
=0A=
>> one namespace so that we have tags and request_queue. If you have that,=
=0A=
>> you can issue IO to any other attached namespace through the passthrough=
=0A=
>> interface, but we can't assume there is an available namespace.=0A=
> =0A=
> That makes sense for now.=0A=
> =0A=
> The next step for us is to enable a passthrough on uring, making sure=0A=
> that I/Os do not split.=0A=
=0A=
Passthrough as in "application issues directly NVMe commands" like for SG_I=
O=0A=
with SCSI ? Or do you mean raw block device file accesses by the applicatio=
n,=0A=
meaning that the IO goes through the block IO stack as opposed to directly =
going=0A=
to the driver ?=0A=
=0A=
For the latter case, I do not think it is possible to guarantee that an IO =
will=0A=
not get split unless we are talking about single page IOs (e.g. 4K on X86).=
 See=0A=
a somewhat similar request here and comments about it.=0A=
=0A=
https://www.spinics.net/lists/linux-block/msg55079.html=0A=
=0A=
> =0A=
> Does this make sense to you?=0A=
> =0A=
> Thanks,=0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
