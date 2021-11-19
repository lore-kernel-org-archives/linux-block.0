Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C063C433F5
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 09:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303DF61AFD
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 09:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhKSJTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:19:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23194 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhKSJTl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 04:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637313400; x=1668849400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y3D35I9P5czGiT0o70Mw92s59/Xm59jZ7aeN84m+MHg=;
  b=BNy8GpHBDdw8KAY0CgntbIfbUGVLglLNW/W6B0KV8dv4YGEhSzqxtwb0
   PvlPZ3p6bDBDUYF+oC1laoImWB5qawtwaJcD5kDlTMA8KSKyIof3VXX1N
   56kZjewirTWDfdbMo4jAOyJH3oHCyLl+x0sMnV0df/Q4VZJhal7bWwwGZ
   iEA0XJHXcU+34eag0c6izp170fktQwm/SIdFPG65iveKyWi1VkZXIHjF+
   h9jfD5743khqUdkkrqn21U8Wj9OrvyHa48Dcz5RsEnhH+iLNTBfq3gSsM
   AK/N2i0w3LxJ7yvNhgwxKVnqG5IzN6zuQjFsep4P/bJQE7zGN/c+/Kzvd
   A==;
IronPort-SDR: SnY4qAMZXdE5LnUI2KwPRMuBLFiBYxXizYanh5PVZpPbgurkQbh+yaJ0cXY4gvLiTX3E2JROWv
 PWx+Ztskdc9VFCUdhEgmfD17XJykWc6VE0ApJSM1N9VgIIBSx/HX3Bm0sjuoKr6H+9ukKZwIvp
 kUkiPFLZvjG8/k4oqg/KmlqmW0O0mm2YNYwpor+aJGxNuu1Ywnc11aCaUOSiW1AJTwGWVTGgu5
 pQ2OR4GrJm6QbyL19RaY2VD+aZIfxUI+PWy6y1wlYiWeSQzbSV/QxRgGVqf1coa64pzDU6/jSZ
 xkov7b/CDli8ABK7nRv2Vk+R
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="139695739"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2021 02:16:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 02:16:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 02:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWclqGuNmcfveuDAHdhNEs6dWtZ3ng+mQBkD6TDwkhu70uwYBWYAS82dPNdVS14Dfg48JcFlH6tSWoOqupnHJklXB1RMRuW0pepVxaF5iK5GuIYf146pAFh1mk1MIlI3QKGQJEu3iNMNEiZWXxkV34mZnLZpKJhDRSFjSH5dfiicoT37UeTwsCghp2H+L1GBSm3J2vOQfPN9LpLIyxljSA86MKYmQ5uTnKH5ebWE9ZNOZgxHXkT6JP7Y/M2KRKuq1Z1DjiSdf+cp1sZZbCsPVZ8ng5HazXYwZTTz4b23UVcsp+dNfbXpLO+qLEV6/F9N582BCUiTZ8YL/GzJ19dhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuNJ1tWfoU8la4apoP2IH7UVD3geASs7fisHtcceB3w=;
 b=NgnpCd6GYPcHtrNORfW0YfheravhRjDHUT8aM9U2+4FFfFR1wNKpxlB4cuvgpksFKTuwNH75rHaCvCrqgKyXulGFBaOR4psnvcy7CJqqh9AGWz+ni+AX8x1VCmXyQOmR/nnfJ7g89BmBojgIAmPvR2TUMIfmZVHY3SFX0IVw/IiT7qIcHpsA5Ia8U62+mgjM2u1mk+ODL/ynHew2kpXhSeNuJs+xhtugTPTIfdgGUSSE4irGZJC7EkwZVayZKStG0XDoCMNMOaTUaAYxH9DO6QO+a6cCI4izHH1iI5bOed663VOJmEpfbAzrvVaiteFu9+12W8xPCJ5gAs3ecLYBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuNJ1tWfoU8la4apoP2IH7UVD3geASs7fisHtcceB3w=;
 b=r/N7XenTMAlgcQMaB+tPXvch3fYyC2CuDEh4JRD6aDxZBDvc3R3jt5ch6tPofpXCIZQ6iB+apbt4ROd6l91F222GhunDHwTklH04HIDV7djN5tuEeiM6W/wpGYTk0v0QlWcKI3lffLbgOVheQ5sZuNeFNrP6hKqq6/tb3BZXuCk=
Received: from CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5)
 by CH0PR11MB5521.namprd11.prod.outlook.com (2603:10b6:610:d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 09:16:29 +0000
Received: from CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::9160:91de:807d:1c17]) by CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::9160:91de:807d:1c17%9]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 09:16:29 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <lee.jones@linaro.org>, <Pragash.Mangalapandian@microchip.com>,
        <Sundararaman.H@microchip.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        <LakshmiPraveen.Kopparthi@microchip.com>,
        <Ronnie.Kunin@microchip.com>
Subject: RE: Reg: New MFD Driver for my PCIe Device
Thread-Topic: Reg: New MFD Driver for my PCIe Device
Thread-Index: AdfUin4YS96OXFqCSACYGDyaPGcVfAABemOAAABYXQAAAHdcgAABPKYAAY/rIZAABzT1AACK+Oww
Date:   Fri, 19 Nov 2021 09:16:29 +0000
Message-ID: <CH0PR11MB5380439460BADE102D91C18AE99C9@CH0PR11MB5380.namprd11.prod.outlook.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com> <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com> <YYkR/szsDirtj1FP@kroah.com>
 <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZO+KktO3OhDEtlq@kroah.com>
In-Reply-To: <YZO+KktO3OhDEtlq@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87b174e5-19eb-45e3-5622-08d9ab3d4591
x-ms-traffictypediagnostic: CH0PR11MB5521:
x-microsoft-antispam-prvs: <CH0PR11MB5521F605240284A16037E362E99C9@CH0PR11MB5521.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2e+7NImL8tUeVQ2qEMeHk7M9i1ykhqeyjUOlJNd9A+uTCDg9PfrUApRcSllf6truehdr/weWtjJm1nYjNW597/GhUhP6r3XsDYQlJbNXtNRo10VmMgdeawrjtTPulvMVYu+fNaErDNfCHlcVuy1k1uWAjyHBY7EfBiaWt4VoH7sXj21QCUaKyg1L2uz3qjvn3LqP6ij2zPJnpDQt/eh9ynAAEQSbgFnuY69MEkuHSRZ8PBxHfekRzgZwZ73bC82Mjbwk3K0S+2OwMCWTwiePhB48KjIp6c7nXHJYI8y0FmVdkGHfxatO6wteM2XHeStESPsrEQrwfAhKpPfq9tZ77lzKg3lg5XQ/GYA7HqEg1H+w5+VTLxvUXceXqOxWbsaVQ5WjPEqVVRVprHJoeOaRC/+Gm7RZBVHVFigTx/TV8hhdulf21FE3nMPgWozCLM0CdV6fzhPkCm7MVuGfnp7WrVIlla1tu6z1WKXU2CLT/PMYbAZVmW4X6hf2Euq54E9PP9rSrkgT8XCcPj8Gn6mcLQQWCsO/TKCXLeDNPAicpIIFSUpSDuYcugWSgnwNunolGX/9EZR9TceX4fOm/CASXkmLxxIwLJn6249LDmJVxOjgkjHNXDlSY9YDY2oPnuZldqzegF0fZ0Lhjb9l1GuQ1RZAZ3jR/AbHdluoF7VNnIVORYLUpOYXlcbee2WXqPkdl6EZLM9rcq3uvsDQRCvoCUswes+vyMQr3Tjbeky03cRcnScDOX+MdoIWkQ4DUalL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(66946007)(38100700002)(107886003)(5660300002)(53546011)(71200400001)(66446008)(86362001)(66476007)(7696005)(8936002)(64756008)(66556008)(38070700005)(6506007)(52536014)(508600001)(9686003)(966005)(186003)(122000001)(26005)(2906002)(54906003)(33656002)(316002)(6916009)(83380400001)(76116006)(55016002)(8676002)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hVgMezPvX+j5wz5pwSiwsNVjHOa+/XcnIaysp9InUki/IobtlQ8w7S94JgKP?=
 =?us-ascii?Q?6NzTYcPO4GPN+zAV0wObAn9oJmpIhXTwWlonfNNrY/DNpAmZJpv7fxTuUjpL?=
 =?us-ascii?Q?kwZZMRga60sYwZdqgze8n8D0pw9jCtAAnOzF2kDU4y4frIgUheqbMVxTaB+A?=
 =?us-ascii?Q?GStrvhICVz/rSkEf9jhDowi/Nkf5DoJmga+aljmfFijQHmjVCjdSuxPcBVmj?=
 =?us-ascii?Q?IaLME9gDnKa6fR3FTcXl0puY3soqqcb0egmYRPSah6DNDlKb47oh6ugavDwY?=
 =?us-ascii?Q?TLjyhLfArQNUGP7GX1c16r8zrl8qj052Q8DsTOl5NsmpYoUyhhPNIzy56ds+?=
 =?us-ascii?Q?1apxoIZ3ih/poCYbGCRb75vV/mUJDek5WwiNmbD/NPVIx2zzeNVN7+plOP5W?=
 =?us-ascii?Q?8YqG7O10DcexZNIziL19Y4v6PjNDpkN1/F5svLF+HTte4j+uLRI2oscMThmF?=
 =?us-ascii?Q?7xUWo0oIY/WWNYgpVkhlVZtbowlOKCiiP6W+Wpyj94LKquQnZBJl/ybPTu3r?=
 =?us-ascii?Q?B140bzV07fWJfbU7VQbToiulg7jAmtHHJqYAujujEEYfKVvLzlWeypP56SQY?=
 =?us-ascii?Q?tRKn4DYKCtV1YlFkpOISJOtrCxcOioz+twrcSZ+w9zWSVO7RFMuYJ1zhaPrZ?=
 =?us-ascii?Q?/C2aRRgAo3rb3ZeeyaB/hQMbj1GjpDIve7hgwD1Xh2ZoqCrmdadUfV2saDIM?=
 =?us-ascii?Q?ldugtOVL/4OZVzR5XdtpQ8nsugJEiJ7dTXfdbjpYSnAh1SmM8tEP2rvL+dgJ?=
 =?us-ascii?Q?sP+sHAYgvnfMli7AySLB+q3QSZcUXyoTe6pbMmrDgPmqGOjRyK4Pq4tirxDC?=
 =?us-ascii?Q?1q/J/DBJNrt0BGMbLPKPjM2SqLMLQK593J5AqX6GUzk9YBlY5pa0GcXctX/V?=
 =?us-ascii?Q?RhE4gqjVsdo/b4H2ZT0hVKs+yTLA6ImcWweB4H+piBUWUS9Y+ccDId3+Atxf?=
 =?us-ascii?Q?8XWcMUhhdNU6i61NFssJS7hlHN5hgvcNjhrNcMej2rWyoOhWFx1XAcl1naue?=
 =?us-ascii?Q?+C8382UZXgKi13UY9OqmEULW1avaJacks2VeqT2tPU6yGN4rDfYX9v3e/4vP?=
 =?us-ascii?Q?BZksTcEjrqTl6ODgSncG3QqhT8QlcO0qiY2uuHki/IRIFuZ+u9pfnOp5qkSq?=
 =?us-ascii?Q?0Aw2CWXyg+6SyCQgBeWuphcG4atLWUqDsocT4WmjEbig7ZTiIx7SZVqzp1u6?=
 =?us-ascii?Q?DDhSpQn05GGbnhEIbK7+t5gNvT/AIu/RbLyEAxiVBZXy2DAnOGH3gA7bLuqF?=
 =?us-ascii?Q?vZBt+iCEYNHZi1Dkyvmn2JcUBpDzJCjdIK0c4+erFhqxeLezhy0KzDoafgWr?=
 =?us-ascii?Q?BdxhIzLds+n8M1SjCq/o1x0y4RXa+4NhCidl75lBVZ4inMejJbdwa5jT0Sgs?=
 =?us-ascii?Q?OlFxkUflLimJVu7oMLOpXgpSI10iVIgQyfwdZtpMRjbXLNJC53DOKS0Jfu/S?=
 =?us-ascii?Q?xg4n/Wwn0HJF3qakFG4LXlh0FBbRQLhpvVsqexUt0DQa+RLfJ/w2thfKZJpW?=
 =?us-ascii?Q?fJ34upai8iUzrOTrXa5BTOxk9R5+qlH54tGsG058vWE1g1ZTmDXbGS6p/fJj?=
 =?us-ascii?Q?XvfzHLnxNw81ZptiqeyRLiZKQXYkUg38/reWYZ4I4+k3k4BbVd15QfogfTCl?=
 =?us-ascii?Q?wiFj9WDJP2Gt6W4mGBjeOvDT1JOI0lXo5OGbMaF9t5nlBHGqerb+V2PgiPKI?=
 =?us-ascii?Q?0yrqFFKMa+tc2VhtZg0afu9aEn13HUyvak39K/dnBAkxnCsBZjuCdEJkx/pk?=
 =?us-ascii?Q?7DepVMMZRQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b174e5-19eb-45e3-5622-08d9ab3d4591
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 09:16:29.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbJdnH8gIdjbmzbXLSkkmeR/qYsA/3wqkPEl/0ZjLGkMmPMsGlhyUGbb4dyzR1tR8Wbow7vntIFK/mLfuViS2bXDbW5L3QGtDLER1PJIwqMPT7tbdyoxlZ/H2CP7VLJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5521
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear Greg KH,

I went through the documentation of aux bus and felt that it would be the c=
orrect way to go as you said.
I will migrate from MFD to aux bus.=20

I have one more architectural question as below.
I have written the driver such that it enumerates the OTP memory and EEPROM=
 memory as two separate block devices or disks each of size 8KB and this en=
ables me to use the linux dd command with "direct" option to dump the confi=
guration binary onto OTP or EEPROM devices.
Also, this enables me to use the application like hexedit to view the OTP o=
r EEPROM devices in raw binary format.
These devices are not based on mtd (memory technology device) architecture =
as we don't have any erase functionality here.
Can you please let me know a suitable location in kernel source tree for my=
 block or disk device driver?

Thank You.

Regards,
Kumaravel Thiagarajan

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Tuesday, November 16, 2021 7:50 PM
To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
Cc: lee.jones@linaro.org; Pragash Mangalapandian - I21326 <Pragash.Mangalap=
andian@microchip.com>; Sundararaman Hariharaputran - I21286 <Sundararaman.H=
@microchip.com>; axboe@kernel.dk; linux-block@vger.kernel.org; miquel.rayna=
l@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-mtd@lists.infradead.o=
rg; Lakshmi Praveen Kopparthi - I17972 <LakshmiPraveen.Kopparthi@microchip.=
com>
Subject: Re: Reg: New MFD Driver for my PCIe Device

[You don't often get email from gregkh@linuxfoundation.org. Learn why this =
is important at http://aka.ms/LearnAboutSenderIdentification.]

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Tue, Nov 16, 2021 at 11:34:24AM +0000, Kumaravel.Thiagarajan@microchip.c=
om wrote:
> Dear Greg K-H & Lee Jones,
>
> Thanks for your inputs and I need more of your help to understand things =
better.
>
> I took this MFD route not just based on the recommendation from Linus Wal=
leij but also based on the kernel documentation @ /Documentation/driver-api=
/driver-model/platform.rst which states as below.
>
> "Rarely, a platform_device will be connected through a segment of some ot=
her kind of bus; but its registers will still be directly addressable."
>
> I visualized these two (GPIO controller & OTP/EEPROM controller) devices =
as platform devices present on the same PCI function and these two devices =
are not detectable unless the base PCI function driver enumerates them and =
anyway their registers are directly addressable.
> Hence, I thought that the platform driver architecture is inclusive of de=
vices like this.

Sorry, but no.  Again, platform devices are ONLY for actual platform device=
s, not "things on a device that happens to be on another bus device".  Like=
 PCI devices.

That is what the auxiliary bus code was written for, please read Documentat=
ion/driver-api/auxiliary_bus.rst for how to use it.

> Please let me know your comments.
>
> Also please let me know if I can talk to any of you over a webex call to =
get clarifications on my further doubts.

Email works best, video chats for every patch review does not scale at all =
:)

thanks,

greg k-h
