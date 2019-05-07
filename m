Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3982C04A6B
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 01:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB26206BF
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 01:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZgY4ICtj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UhnLTv5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGBiN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 21:38:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7004 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGBiN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 21:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557193094; x=1588729094;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xZXKFsJN+A2NZhUL2JTlxYpWO5cQBuXfYqJq3r/n4JY=;
  b=ZgY4ICtjzZ9lWIXdr+JXdNlVCDpqHg9T7KuEYZBQOHqWnE655MjdJ3WR
   iVE2huTf3owCmR+pM5SOyzIZvCaGyMl78/nzQnSfZZFvdNPZffxY1TFrZ
   1bavCkHi1MPo8rHADvZjxqMm6gAr1csXfY5p0G4niC0QgVo8R2SLqYznw
   yyk58xsjiArKA1Q7w/NgWGoovpKdZhwylE7b4Vy4ZZAsnlGwz4zuGhnv7
   UlznMw4O4/Xt9HxsAw72nwZG9/8uC6SvY3QrQAcwkka7eoal6EFWmLmb2
   y+90dlhXCDuPAuWWt9HPEahcWmD+T4nXQ3jiYvqFATT00J6P9AEK+79zX
   w==;
X-IronPort-AV: E=Sophos;i="5.60,440,1549900800"; 
   d="scan'208";a="107655816"
Received: from mail-dm3nam05lp2056.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.56])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 09:38:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar/GNBRm99Wm/fmwJ+HEYaTuLGhaMcgWPRLwzywG0Jk=;
 b=UhnLTv5UzAetweUX2CGuVunVnPysqOGlgRoNN0spdKm/z2Q8Q5U5TS9Icg639BSikqNdeBSW0XioJY0wDo/CggMepROIrs4TaGRbpk/1x3uGaU+/Wzou9+A1I+EjLgjvz5rmB3KIJf6CTh5OuOmk1CNtB3znmD2kEPNE/3G/q5Q=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4879.namprd04.prod.outlook.com (52.135.114.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 01:38:11 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 01:38:11 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Topic: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Index: AQHVA1Q6zH4CttIufkWRxlafayMhPw==
Date:   Tue, 7 May 2019 01:38:10 +0000
Message-ID: <SN6PR04MB45270A2BD1C3695F4528CD9286310@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
 <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com>
 <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <CAA7jztfU+AdUHp5xo8ssjgvXiBFBXJt0PyQTNA8VQU-T-SpKQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [76.89.205.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b77f8baa-3007-4ecb-963f-08d6d28caa23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4879;
x-ms-traffictypediagnostic: SN6PR04MB4879:
x-ms-exchange-purlcount: 2
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB48797757A23041CE6D79D4DD86310@SN6PR04MB4879.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(346002)(39860400002)(52314003)(199004)(189003)(486006)(66066001)(14444005)(256004)(71200400001)(476003)(71190400001)(8676002)(5660300002)(8936002)(33656002)(72206003)(81166006)(81156014)(68736007)(54906003)(99286004)(53936002)(478600001)(7736002)(966005)(229853002)(25786009)(3846002)(6116002)(73956011)(66946007)(64756008)(66556008)(14454004)(6916009)(76116006)(91956017)(66446008)(6246003)(66476007)(52536014)(4326008)(446003)(26005)(186003)(102836004)(53546011)(6506007)(76176011)(7696005)(316002)(86362001)(305945005)(6306002)(55016002)(9686003)(2906002)(6436002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4879;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X+8Qt1mezOXFf0+iP0y7TMp0TJTEgBt8ipzJ5tWfOSrwLIczjYOIUfLy1o+uC4KkSd/Kcx7W93zNWB1Po5u3vxM6YNu3Q0VDkTtM4/Q7ob1lchIDnhwY+QcuqGuKQPESFB+PNC958F0lxcamaqZZOVUh7sdBQpEqLg0YVx0RafwwiNLl3atJstmVjUzimhY9nhDAFbJ2bo71J4WRfxsvjAkI2M6vTI5Hrc7TImSZ+NlyKxTB6wkBsVEeQuGgNEzF7eAy+OuOdaZD3cdqh2YxS818ZI3MJ6NR+sL6cEpYJ3zs8I0FyrAVYk8ja415WJDd9iSG53hZpqdQ0kztfzZtIKdyQxViT0QkXmZ3gXy5X0AHT93Vt3yMqIV/doFOVTRk07j6SRfGmgdbNQqtxWXbOg5rRYgtwp6dTkp8bBLopq4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f8baa-3007-4ecb-963f-08d6d28caa23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 01:38:10.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4879
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/19 4:24 PM, Minwoo Im wrote:=0A=
>>>> I wasn't clear enough.=0A=
>>>>=0A=
>>>> It doesn't check for the return value for now. What needs to happen is=
 :-=0A=
>>>>=0A=
>>>> 1. Get rid of the variable strings which are not part of the discovery=
=0A=
>>>>       log page entries such as Generation counter.=0A=
>>>> 2. Validate each log page entry content.=0A=
>>> Question again here.=0A=
>>> Do you mean that log page entry contents validation should be in bash=
=0A=
>>> level instead of *.out comparison?=0A=
>> It has *out level comparison.=0A=
Give me sometime I'll get back to you on this.=0A=
> I'm not sure I have got what you really meant.  Please correct me if I'm =
wrong=0A=
> here ;)=0A=
>=0A=
> First of all, removal of variable values in the result of the=0A=
> discovery get log page=0A=
> looks great to me also.  Maybe those variable values are able to be repla=
ced=0A=
> a fixed value like port does (replace port value via sed command to X).=
=0A=
>=0A=
> But, it also depends on the outout of the nvme-cli, not return value.=0A=
> Anyway, let's discuss about it with Keith also because he discussed it wi=
th me=0A=
> few weeks ago,I think.=0A=
>=0A=
>>>> 3. Check the return value.=0A=
>>> nvme-cli is currently returning value like:=0A=
>>>     > 0 :   failed with nvme status code (but the actual value may not =
be=0A=
>>> the same with status)=0A=
>>>     =3D=3D 0 : done successfully=0A=
>>>     < 0 :   failed with -errno=0A=
>>>=0A=
>>> But, ( > 0) case may be removed from nvme-cli soon due to [1] discuss.=
=0A=
>>> Anyway, if nvme-cli is going to return 0 for both cases: success, error=
=0A=
>>> with nvme status, then test case is going to be hard to check the error=
=0A=
>>> status by a return value.=0A=
>> This should not happen as it will break existing scripts which are=0A=
>> written on the top the nvme-cli in past few years.=0A=
> Agreed.  But, please refer the following comment below ;)=0A=
>=0A=
>>    It should be with output string parsing which=0A=
>>> would be great if it's going to be commonized.=0A=
>>>=0A=
>> No, we cannot rely on the output string as this problem is a good exampl=
e.=0A=
>>=0A=
>> I'm not sure returning =3D=3D 0 for error case is a good idea. Checking=
=0A=
>> return value prevents us from writing unstable testcases which are bases=
=0A=
>> on the text output and allow us to modify tools as specification moves=
=0A=
>> forward.=0A=
> Please refer a discussion on https://github.com/linux-nvme/nvme-cli/pull/=
489=0A=
> Keith and I had a discussion about the return value of the program itself=
.=0A=
> The nvme status value is composed of 16 bits value, by the way, the actua=
l=0A=
> return value of the program is in 8bits(signed) which means it's not=0A=
> able to carry=0A=
> the actual nvme status value out of the program.=0A=
>=0A=
> If you have any idea about it, Please let me know.  By the way, I really =
do=0A=
> agree with what you mentioned about the return value.  If it's possible,=
=0A=
> I would like to too :)=0A=
>=0A=
>>> [1] https://github.com/linux-nvme/nvme-cli/pull/492=0A=
>>>=0A=
=0A=
