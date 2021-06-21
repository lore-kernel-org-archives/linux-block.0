Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F267C48BC2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF9E61153
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFUUHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:07:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1364 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUUHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 16:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624305928; x=1655841928;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ocBZgRtJd70GZ7WYRBTA0S5O5ORwrgpQRY64fHDuUwM=;
  b=GpcOSRGfPnac7xVYbHO2+rIyEo4jRLgJ2ooIKpVO7v5epd/K4S1E8Vcn
   sfIk97QgoJc1DKjrvV5Pcot0F3YNR2ftfRWgHCklYJAZCxS3xYZV9k9MG
   MwUFH99m2z3OUZ/EYCwOyJwRN8EmO/Sr4fHb9VZ7Zza7fqAN5jLizxYOg
   OHUYupl8TcsRA4TMe/vG7IXxNYRbJ+UQ9mw7v16M8szKbPM27PZ7GEabE
   7KfTIK6CkFfG8qA9ppMEAiZtdY3W21DzTk7TeIWRampA8vwyaMorsUXxk
   OGMf8f/t1fY2/cEtSMlh6uCwpkk9aVMDbNQUnnMjEHkUQSabszHvAnlAu
   A==;
IronPort-SDR: ElEVq72ub4W5SoF8vyx+hZAmPtlHI3yS7XlH0lkIDrDiDU3ZVNPCqXl1wyGX8jNpv7ivjrypci
 xVPnuXGLMB8XF1MesKedSrYv2DcwNMTT1k7B2f4AP7tEIuEP2YQlf286xZSKcyxKoVPS998+v/
 18neH74G6EVX+U7gSCGYN8NDDl/su8fgaYqJyHMwkEx4nra9k6rmM9y7MsaS+un+mdtvytxhIU
 OQLu/5ArQSGSAQNd0bG61I+G8Lp+IJ/AeUAfkwWkHw2BTOnMbTe8Jf8/RsTyUEDxG3rXzOlOEV
 ybY=
X-IronPort-AV: E=Sophos;i="5.83,289,1616428800"; 
   d="scan'208";a="276303919"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2021 04:05:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhR5uGdY5gsQHbX8LViFUCOw6Ar/1dXMDze5E6i7wcZvP28Mb0xnnuiUx73IIbXSmXNfcczwClm/wb2doyOyUcML75CypUrFmUblYzIi7MOS9wwIONlnDAc0nUPfxkAcYdEWTCzUGQVo0iQhKmuYGwVkW+Un80L4Vti3MFwDDZmetXMcadEF8pq17ACdPgOtMeh7fET5b8eEN2YIkChINN0j1bQHRxhMOF9nk5tlZVZYMgLllQARHektvQyJRE+hqy+wI1E3Pm343q0/AzTjKJCcbLDUVvVMzcTtUPVxTFz3Kn+TkTG/tMVpv4Rg2XRzijhMunrZoxcpKnvuLuGWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocBZgRtJd70GZ7WYRBTA0S5O5ORwrgpQRY64fHDuUwM=;
 b=ApTUMiooUNx5kZcRghdcEyX8eZ+20AP/AubAtUbMECjuwW5bI/DNlZRqiKYogoPy8eTBPI/d+p3EISpmwvxWKI3DQmr/tL2rWAMh5MQ/sOx5bwitzVRjXJiPIb6PPy9BE7Lt5iAdN21fgW8BQOqd8OBzoZInX4R5FDYWYqXnb0tQoNkt+I99wQQL2xZRNX4LJWnHWff08t0o+FnbKw2jrKsSDg2JSK0eXdBW5dcdiuw0e5petYvxCBFyLn8XlaVdxOsHPiNvS9OjCa+bxIoVwxNZbERFDCdxWHAVsVuQKB1JhIoaAIb+Z+aV+0JLCAU79A0omEs39+J8H2Nd0p87cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocBZgRtJd70GZ7WYRBTA0S5O5ORwrgpQRY64fHDuUwM=;
 b=qKO48PBkgClmyfaZ8KlRdHOmiKCJeJjHvwev1BjpsA+EYUEUyVGDmT5S87zeuAJQ/8p/Yp13+RybCET1p/LkxhunTaPot3qvryiKEXDMaA4hfWsFsd8xysTMgdfnRUf8y3tqiafApH8h2q/qWQgADQKIRNP/YjJIql3P8BNIyOk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6881.namprd04.prod.outlook.com (2603:10b6:a03:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 20:04:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:04:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/9] loop: reorder loop_exit
Thread-Topic: [PATCH 1/9] loop: reorder loop_exit
Thread-Index: AQHXZoc2jA3g3WjYRkOazcmkss/adg==
Date:   Mon, 21 Jun 2021 20:04:44 +0000
Message-ID: <BYAPR04MB4965EC0F7890B8480B0C3732860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210621101547.3764003-1-hch@lst.de>
 <20210621101547.3764003-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae1085f1-e909-4a87-bc26-08d934efd08a
x-ms-traffictypediagnostic: BY5PR04MB6881:
x-microsoft-antispam-prvs: <BY5PR04MB68819BD8FBEB57743BAA0CD6860A9@BY5PR04MB6881.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IKbSIoyp5KNZRyO18CsL81Q6tf/tHWAhd7n2O5uTf0aBqeGB/akL/XJd0lkr8V2c+YxEPKSGTifmi1LvoRmGGjYWotNVZaVWMMS+nKjtZQXnGrWY8Z9ip5xyy5hiLuDQK39XNs7b5Sfw/gUYgUVxsKqZ7uOW4U/ADrbQG2dsFkCg23TUMJsge6+k3Jqxh630db0Evb0EjYVEIKNsCZlCi8QGqv2nAhFPQZonYwJ8t5PSqov0W/a+Cnn0jw2T3jJo6+bl/0D1egAxsaawmkPELfVrfjQTNcY3HDsxgQyIxt3WiNtm2tKBj4b34JjjR+cFkGcZwoSEdS9NvuO0vMIMD89mHCGD1mILtbzY4eUX6SHfrbvKXz/Z9nsz1DFYa682lkxSIXdqdi6XTxTC3VxXprUAGJj3/TYjBb2JDTQKhPTkgD3cYTndh57S9mrO/Pr2ILhrV+nuSXt6ty8lYQBgHinmbrhCJKWBNQn4R24zEOYb7BvWIJQMq7aolQQmAyVIpeJmz9VKhK4gUii5swdPiutSpu++C2cXIM6FhWnWJnrbM0nMftLWg70NhthBpBFZVwbDAHW6OI6SuTWdK4EidI2JZLIxzaUKsrb7V3Fdr84=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(66446008)(66476007)(66556008)(64756008)(66946007)(9686003)(83380400001)(71200400001)(55016002)(8936002)(4326008)(558084003)(52536014)(5660300002)(76116006)(26005)(186003)(6506007)(316002)(86362001)(122000001)(7696005)(53546011)(2906002)(33656002)(478600001)(38100700002)(8676002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JdNOyAGgZBkma+Ym3kKVeVQuTpKwrdM3wmwtrpa3VxoopzbpomqT7iDONYem?=
 =?us-ascii?Q?tDXfdmpkvg0aHklQD/fCLTT+7+vhDVwxiRBd6d4JBLOlN89pwXjchS061dYV?=
 =?us-ascii?Q?jbrW/hDlF73m00fBb/kRZ9LXQUEgVwudyU+hTU2aoiLCexwwmkvhllpLzN7i?=
 =?us-ascii?Q?SYQXAyrYhIj6m7saad5SQT+j/24/OoQxYTkrWr4+MMUPHmrl/rc7Tv7NKAia?=
 =?us-ascii?Q?Da/5i5hRqf4tBCJBiy0l8jfO3VvqNdPQ9iEhaJMk+u6QdRBwx+25M5PVYLnn?=
 =?us-ascii?Q?/LX3A9XgD01XtFaozecehLsq5vR5H0K73mhwZYjtO56s9UIwGlya9PU/HCDh?=
 =?us-ascii?Q?vh2VA/HF09nOiIofrnUNAdbJj8CUywtRpmF+AbdBDEg0cwUw1WqGJaCrjHR6?=
 =?us-ascii?Q?rkxnyY4yOxb8CIwmNTPd149Fm3ACc1U95wIHUp1HU28cInv3pGLnc5eOVeKY?=
 =?us-ascii?Q?c31mRZlfeL0JOAgg1KIFKVAnU4BjyYvMawKC/KcFnUzVyZDsUT1LOw1KMFaB?=
 =?us-ascii?Q?g2ZIGK4Ei6JdJDQtXSntos/dWCze2XJ+FCWx9XSFCiVrlRDwsGIJSaEc6SqS?=
 =?us-ascii?Q?6/x1Z4LxFbKK9j7H3ToffZZJw8znL65dctPOjDRUDiYqHqbJsidxMfdZA7Aa?=
 =?us-ascii?Q?MZC1tWXvath7WBoQacj2rTkAVU/h+ox2UdTI1q62cOBmPoy6USPWpa5turBX?=
 =?us-ascii?Q?Xe6DNxT2ADJLbzRFU30uRuoHGlRrDDb0ve1/IUsnl3yqxYw9ueVuINRYWWhj?=
 =?us-ascii?Q?gwK1fie50uWpaUOqAvnoaULUnTrXL9qHPnxH4mGLKKmzVk04VAVNbEBJMesy?=
 =?us-ascii?Q?AXYPPEA+cCZ+3YT8glAZxRax+OXrWWSl7k0MeubB9+Vw6kKDFPnA2t4x4gHV?=
 =?us-ascii?Q?32YQMaaJLmi86810OP+TqLaZDCWAeEzX9WXPDP8XrylLqWNNUS1VnWCk4eQI?=
 =?us-ascii?Q?ThbnT/vvm91giRXBEMMk+VGO89sCRE0yedhGAsK0tlAoK8JpY2Hr6e9ppPxn?=
 =?us-ascii?Q?CHugFOryAtk+ybEk0G9ac47yoLixa+sFSfDMMyyqSWxtr75AhGUFjX3TqZs6?=
 =?us-ascii?Q?a2reVIpn5rYnMPJRVfOkU40Ax2qnA6TYNSgNEDR/VYanCqd2o/Vgfkn65nsD?=
 =?us-ascii?Q?eV0lBFjAz9klKoCG5zLPMVLcgZDsbcDtPIbkBsvT6kV3CMKPF48N1+IFjd8z?=
 =?us-ascii?Q?RsjPcksR5wiuueEAoxjUdWMuTuW4Y8HhhF1YTZg4UAPXimydNNz/NSmcVwfh?=
 =?us-ascii?Q?gGy0IoT9js2GfMN5/PyPTIM7Y1R72D6L1UUWcl6DibC6sXUyVOElAWNcn5vt?=
 =?us-ascii?Q?v3FtaHDqgcGYtlIS0R8AMCDi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1085f1-e909-4a87-bc26-08d934efd08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 20:04:44.9377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4xf5UAgBaA7sm3qK+b6fdUpv0T6aInlWnYw/Nlp+9/xYz6DLD8Nu6cep0io1vYi9toD4wF0GEc3Wpc7zFrOcI2YHOK7LqKFrtDjAlru1hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6881
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 03:21, Christoph Hellwig wrote:=0A=
> Unregister the misc and blockdevice first to prevent further access,=0A=
> and only then iterate to remove the devices.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
