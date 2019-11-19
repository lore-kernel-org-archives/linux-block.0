Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1052C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 02:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928A922315
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 02:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j6bQBcJG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BvAL0n5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKSClt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:41:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22586 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKSCls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 21:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574131408; x=1605667408;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DNXnRXh5afb4nr2fxEGY+W3RbaPMVl3aMNe+oCa9/Zk=;
  b=j6bQBcJGtenLgAv/7H+gScrGHW8n+boZVa3xSbW9Ee2IeOGUmZpMj7N9
   RqEz3nXyaFmXTYlT/fzuYjl4cWoWjNh/dO5LqTHFZwwrnbDYUleph6tY9
   oe+G4JnWeuNoisFveXCR1pW9dE+rGwgAVdgWPc/77CRwRRSwgh+d2YAT5
   Fmg3rbLGdoXcjAO1rEaXdKXVbAxylUtIWvOOxWWrEUJ3Z7z9oFY1fdfa8
   LPTnQhmv0N7aRe33dRQg892BqKipgclREmo46QUzVxST6/He3t6z+h7Xd
   YDllxSv5lLbcIVRLIm9BXyaIx0gAh69HsdE0P2+tTh2O21u1hyvIGpFY9
   w==;
IronPort-SDR: xR7lgUhMSpERuSe128jC0zs1TpWohLNDXJKxEQHOShh2u3nJbNf6JbnxnqTHU7jbX3aF3+fVzH
 zrs5UasF7Q2gWnSgyK34NrKpiRafb9GWBtyZW35tIwx2T+9uckx/tJGUT92hSVWTlduPXJh17q
 Y44tAEIwZQnysP1wvf8B57oPPd+BaR39ISVZ5HA2qAWdqM2SCccydBxan4azjq+vvVsDxN9o7h
 eT3cBa7pdk4OMrdp31PM56jqte6YHKySfnpXGMQV4gPqWEyJDUCO2G22lSN6vPCREk7UV4DU/s
 ulg=
X-IronPort-AV: E=Sophos;i="5.68,322,1569254400"; 
   d="scan'208";a="224724013"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2019 10:43:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEjzxJfQFRLPFG7EaKhimWk1lPsk54Zq9IHGW4eEwRhGPDqF65y3DhbAi504dF9L/dgFIEI7bWZs8daVCWAV3iH2B/BGsF6e9x2Y2Q2Z/0lfrydwJ3V8txT7qaldOXwPu+Vj+1tegCr0bsBoiRoAVDRg5mKQzuS2EsEGtnJSbQjIMeGsouf58LjzSuWMn0k8FEcMxvonNIpTs7YNn8BFIqsYNSpYKYQ5AjVRUmDUu27uH/JpHOj96QzfKfVsRGcCzK8IiE/NGXo/1v3B6vNSAtM/ZnxTEYEZXW6OPajUQp7ZF9zuA9vFRp5GZK61ybBdH+p0cz/IzAG0feLKAhuVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gajo8PQviDOEIFHyO8n/CQCP12ll5ntwb7WJH2llYtM=;
 b=CdOijqsqkofku2+e055bhzNyCvbGxGmeBarhq+Y15Ii5usMFGhPcUny+vKa1eWCmsNeupb/liyl0sdBa5sCS1agVt4XnPlHJnaEaSQrVIBldsI6YxCDoN0S3KJgSJcYDj51aDRmC2maMqGxfRPmOyIZjgdfvJ7xKcpCwesmcujmuQS/C6rNcsKfmnx86/HWtHfsyjjDioVDClYcJ9ih/RXXlRyUGSu6WggaXovPXFagn75kvff+HWSq7BjngOnnaxWFDupn+Ex6AOmhfvgBL4zZ7aJf+Vgh3shxxmhAQjJxGIsBHJTU8uUgXxmz5Alut1ogClMgKm60lQT3md394gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gajo8PQviDOEIFHyO8n/CQCP12ll5ntwb7WJH2llYtM=;
 b=BvAL0n5EqLzX7GLAtmXnkDw/yq6s5tO7YI51XZ4kwa/hzt67uNfTtGOCqpstOgYtsF10u2w4008KweRoLCa1/cuZIHhiQ8kGBqYZnAyBYrCRWBArTBkTy/FGqDXy6YwutOwE7NbUrurR3oedXfjR8DDiXED2H/gVmeTddpbHBi0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB6199.namprd04.prod.outlook.com (20.178.235.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Tue, 19 Nov 2019 02:41:45 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 02:41:45 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Frederick Lawler <fred@fredlawl.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH v2 1/4] skd: Prefer pcie_capability_read_word()
Thread-Topic: [PATCH v2 1/4] skd: Prefer pcie_capability_read_word()
Thread-Index: AQHVnaYWjyRplcnjK0O+FGDAzAO+yA==
Date:   Tue, 19 Nov 2019 02:41:45 +0000
Message-ID: <BYAPR04MB5816CB66A3C71BD9A8B0297FE74C0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
 <20191118002057.9596-2-fred@fredlawl.com>
 <BYAPR04MB5816EDC3676A964C2D1D874BE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <653fa44d-7edc-8440-b778-79c127c0aa3b@fredlawl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbf56f34-26d7-49ac-4555-08d76c9a04ed
x-ms-traffictypediagnostic: BYAPR04MB6199:
x-microsoft-antispam-prvs: <BYAPR04MB6199BB6F1F08B6DAB49E6929E74C0@BYAPR04MB6199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(55016002)(66476007)(446003)(66446008)(64756008)(66556008)(81166006)(81156014)(66946007)(76116006)(91956017)(4326008)(486006)(52536014)(9686003)(8676002)(8936002)(229853002)(53546011)(25786009)(256004)(66066001)(305945005)(6506007)(186003)(71200400001)(478600001)(99286004)(71190400001)(6436002)(26005)(102836004)(316002)(14454004)(476003)(2906002)(33656002)(54906003)(6116002)(3846002)(86362001)(5660300002)(74316002)(6246003)(76176011)(7696005)(7736002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6199;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Rvt+qRnqi8P44zJNJkskjzuOMD5YOWFCkFm16zSJEyi+pZ9ygCmpahb/0mWOdTyqDGe4F0Do1xn6pn1LN+GbkvnvshTuKPJyMoNlLEW3LzRNuxUL+tQ9g3Qm7S6E3tp5OLWZJ3NyDG8L7RAFhvuwjhcc5LkLjZ68DCc5Dv6u1MMu+5n0ntJTFSlfn65w2aTcA5ch+vw/At/gKx0Vk0HA356E8fMg3DzT9h8rJ600WPRBTZFBjuxzJai0D1em4NzBW4R/3Zu33xo4HXKaE7oHJR9FVnN3kUeH7Ju7T5D11y1DKePveQDRn9YTdb+uf+DCpSnkDrGPeIpRFS+6vMm8wbyCMCAPt9bKUK3zam6KChuJTRfFFuTEY7wxM3fsD92AYSXtfd6Aij3AloAZB6lRZPp1nlAeZLyiAJYYJHZrCQtHySyaezOBw10tfbDeJig
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf56f34-26d7-49ac-4555-08d76c9a04ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 02:41:45.8637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/R94DoaZ9ZZNhOIEIPpRnwH5Y9mvFUoiPN4PpnMIw0nPC/OUQE9S8EkahQ5VQXYwRRD5r9GLOKNCi57Ooq4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6199
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/19 10:20, Frederick Lawler wrote:=0A=
> Damien Le Moal wrote on 11/17/19 7:45 PM:=0A=
>> On 2019/11/18 9:21, Frederick Lawler wrote:=0A=
>>> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")=
=0A=
>>> added accessors for the PCI Express Capability so that drivers didn't=
=0A=
>>> need to be aware of differences between v1 and v2 of the PCI=0A=
>>> Express Capability.=0A=
>>>=0A=
>>> Replace pci_read_config_word() and pci_write_config_word() calls with=
=0A=
>>> pcie_capability_read_word() and pcie_capability_write_word().=0A=
>>>=0A=
>>> Signed-off-by: Frederick Lawler <fred@fredlawl.com>=0A=
>>> ---=0A=
>>>   drivers/block/skd_main.c | 8 ++------=0A=
>>>   1 file changed, 2 insertions(+), 6 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
>>> index 51569c199a6c..f25f6ef6b4c7 100644=0A=
>>> --- a/drivers/block/skd_main.c=0A=
>>> +++ b/drivers/block/skd_main.c=0A=
>>> @@ -3134,18 +3134,14 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);=0A=
>>>   =0A=
>>>   static char *skd_pci_info(struct skd_device *skdev, char *str)=0A=
>>>   {=0A=
>>> -	int pcie_reg;=0A=
>>> -=0A=
>>>   	strcpy(str, "PCIe (");=0A=
>>> -	pcie_reg =3D pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);=0A=
>>>   =0A=
>>> -	if (pcie_reg) {=0A=
>>> +	if (pci_is_pcie(skdev->pdev)) {=0A=
>>=0A=
>> Maybe return early here ? The reason is that if pci_is_pcie() is false,=
=0A=
>> then the string "PCIe (" is not terminated with a closing parenthesis.=
=0A=
>> So something like:=0A=
>>=0A=
>> 	if (!pci_is_pcie(skdev->pdev)) {=0A=
>> 		strcat(str, ")");=0A=
>> 		return str;=0A=
>> 	}=0A=
>>=0A=
>> May be better. Note that the "return str" is also rather pointless since=
=0A=
>> it is not used by the caller of skd_pci_info().=0A=
>>=0A=
> =0A=
> I agree, but it might be better to include a note that this is not a =0A=
> PCIe device. Reading "PCIe ()" seems weird to me.=0A=
=0A=
Yes indeed. But since this device is PCIe only, if=0A=
pci_is_pcie(skdev->pdev) =3D=3D false, we should probably fail the driver=
=0A=
initialization.=0A=
=0A=
> =0A=
>>>   =0A=
>>>   		char lwstr[6];=0A=
>>>   		uint16_t pcie_lstat, lspeed, lwidth;=0A=
>>>   =0A=
>>> -		pcie_reg +=3D 0x12;=0A=
>>> -		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);=0A=
>>> +		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);=0A=
>>>   		lspeed =3D pcie_lstat & (0xF);=0A=
>>>   		lwidth =3D (pcie_lstat & 0x3F0) >> 4;=0A=
>>>   =0A=
>>>=0A=
>>=0A=
>>=0A=
> =0A=
> Thanks,=0A=
> Frederick Lawler=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
