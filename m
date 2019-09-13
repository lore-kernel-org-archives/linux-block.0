Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A2BC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F7208C2
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a2ivpPJa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ryf01V9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbfIMWP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:15:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52220 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390378AbfIMWP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568412960; x=1599948960;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=P9TlBMdXkUd2abIoxkQl7M5VpBrQ828aZOzvAn3zIhw=;
  b=a2ivpPJaUyS6564LU6cqvXBO0oSeLVEtT0hRDV/ukHKo++wxz56mvZWp
   DZWXPNz914Lu7RJpQsbom3DI8IhjgYPmt4h/d3l6g/q9/5hNZ9HyjvgfO
   I6Z1dgCzTiPI8GxE0N612rAOz7WFIAWCvKgJuJXqa9KMahNn9ey3Ly7G+
   ylf2/e6DVSdB8idlHX3mNzGo/9JdN0KKvBEK+nHbuKAR5ILIpTiBaivSD
   uZhxGQgPlN8k4w1Fy163P4gRnExycwFcYIkeOPUdgMCSATdZPOEDvKbz5
   echd2QMxUoX6XC7qQWmQaudOVGAafr67vRxMSCLlIGKIrIrgEKMyHkSug
   w==;
IronPort-SDR: PbKKCCcmf6/qyF60FLsFB6VRMRC1asIZMb9sDLq+39T0za5GCj+PxYFHzVBD/rZfIwPjJ49ugw
 1S0pFfI0AsrKRBfxDH9tbR436pkFOefemnx0wRqPDiR1U8nNNcrVifd8OIkNxDtUKROaBYi+mQ
 1qx0WlJRx4sel/RKoZycv/AhMxor3dqUAdtJpYuuuztwXs1UlEKvULDnq4L+WBasvt7mEYydkO
 hY0DprjulSjyjA2hF6UwtlDxJ18RtnDBmhGl8wgA4RLXIp8vEREyjmS8cL99dt7zHKmNkKblhr
 Baw=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="218951043"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 06:15:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL4DlETN8ffOpImFubDBFKNqYZF/vhz40EE293YGliOD04BPqVOH6SPOPUMfNlAimxDgGOdJ7Vi2Ky7vfRnZ/Prf7xPiLFYdFLMmoIMh2/j5k0xhYFzHQObf1JrbYu7ide2vjun3LZ7jckmOT1KEq7af5EPyW9dnWHE3h5cm0fkBckRpfRaDvwfEz/0p4zjAxUqFTO8KCyPS4a6On11BIuTNehgyVkk9o7IfGheYJpT9rNCeEafPpQsc5OzddkPiRFSP+1ulU/GUIOn6wrnVaNwWU8AtkwOVV7gXXOJTJnZpV5C9qjyplmoo9l4o/rFlmrKX+g81aAqpF74NZZXSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCvESoPe5LZDFO8ALkclRl18MM/xKIwj2+268PuWguY=;
 b=BRx+M7ddoFslJ+r7cmHGo+s8Kre52l0kmkflO1ERZKU0wdR4KiUdIr8R45U6lSgz5Ix5CszUPIrYxq925zTQ3A/SR1qYH75p5Uc2z9QKQGW908neUXz/PCkSLnrP4eDvvo+qwS7ilk2kNF3xmO36THAVoQ+i93Z7tCVm5Y+DU9gLgs0C3BkO4hgH5Clp/WobLkaCjWskX9AbpmLb7BC+M170iMC2lC72imq2GfsdWS5e2ToGsemiSThTIVgTt4BR1mZzMR79qZRoKYXN5Cky1LS3q3rX3pKpOm6zDGoIFX6pKiUHqzrhaWDxSrv45+lIBfMZpgor+CAzIYVe+i+fIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCvESoPe5LZDFO8ALkclRl18MM/xKIwj2+268PuWguY=;
 b=ryf01V9Yitlivlrc3rRIEg2+s0kAHaMb5EfUsBqnN3SduX1kV01qKaW+iob2JIDzhEAmU20Dr4BUUDQh9cXX44IZle20xX4zYbU9gzsd0eeaRPjVRJEu3H6CJF3lwae0etdevxRgLIIMkcjjS1QprKcmqISKC3KQwBOxSCK8jwA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4294.namprd04.prod.outlook.com (52.135.204.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Fri, 13 Sep 2019 22:15:26 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 22:15:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH v2 2/4] null_blk: match the type of parameter nr_devices
Thread-Topic: [PATCH v2 2/4] null_blk: match the type of parameter nr_devices
Thread-Index: AQHVan853E0yY09HDkewz3OnzXieiw==
Date:   Fri, 13 Sep 2019 22:15:26 +0000
Message-ID: <BYAPR04MB5749FDD5229E814F543E51AF86B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
 <20190913220300.422869-3-andrealmeid@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a787632c-171d-49de-47ad-08d73897e121
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4294;
x-ms-traffictypediagnostic: BYAPR04MB4294:
x-microsoft-antispam-prvs: <BYAPR04MB4294CA0CD8204BA067C2732886B30@BYAPR04MB4294.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(99286004)(478600001)(54906003)(110136005)(3846002)(229853002)(316002)(52536014)(9686003)(4744005)(55016002)(7696005)(76176011)(86362001)(14454004)(6116002)(81166006)(81156014)(8936002)(5660300002)(4326008)(8676002)(33656002)(25786009)(71200400001)(71190400001)(53936002)(76116006)(476003)(6246003)(64756008)(2201001)(6436002)(66446008)(66066001)(2906002)(53546011)(14444005)(256004)(2501003)(102836004)(446003)(486006)(7736002)(66556008)(66946007)(66476007)(305945005)(6506007)(26005)(186003)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4294;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yV800XXqhekS8cKaeBu8su4qe5JPOPaRR7srDdbAmljTpzqH0E3Ui44kk/EtbdljVRfqUVZUmV8TAqEma5FYNNO0SvODtVmQ+Tze0puw9f61Qdzj7h8jCohRcSkIhHUmmOpHxi+Wtak97eFAGKvy+/CnXz6Ida3QPm0aw2u3TEISq70JUkVJAl5zOjnFgYyPmS3l4zH2xhJBDs3eV4gJ8lvVpzdo8TLqXWXJbRQadkMyywhFQyLYXwIbToESkIBHrIAKHN8S+6tleaIEp+JJYyZHnjZoiAqF2V9pwzk0ysR0Hk9NgGX1qh9zPwwbhRZ6TKPeG3bCE4bqE0FTDNLEyYbk/3jgwf1NnZVZ5juZZCa0VyDEXkZlxnrM2GtvIpgqoU8alkNOVVmNVt0oTEh5gVwBsd0rZx1bFHtOqRnTKU0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a787632c-171d-49de-47ad-08d73897e121
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 22:15:26.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XWtFtBYmb183iewONlF/EbGC8MH/Ac27XN/YbcCCxtzw/i8C0awsTev8WMhbH8X5dM7wLJu69wiSbWb3eAJ4/yhUOyWVbVzH/NypDf6ETU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4294
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/13/2019 03:04 PM, Andr=E9 Almeida wrote:=0A=
> Since the variable nr_devices is an unsigned int, the module_param()=0A=
> should also use this type. Change the type so they can match.=0A=
>=0A=
> Signed-off-by: Andr=E9 Almeida <andrealmeid@collabora.com>=0A=
> Fixes: f7c4ce890dd2 ("null_blk: validate the number of devices")=0A=
> ---=0A=
> Changes since v1:=0A=
> - Add "Fixes" tag=0A=
> ---=0A=
>   drivers/block/null_blk_main.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index be32cb5ed339..5d20d65041bd 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -142,7 +142,7 @@ module_param_named(bs, g_bs, int, 0444);=0A=
>   MODULE_PARM_DESC(bs, "Block size (in bytes)");=0A=
>=0A=
>   static unsigned int nr_devices =3D 1;=0A=
> -module_param(nr_devices, int, 0444);=0A=
> +module_param(nr_devices, uint, 0444);=0A=
>   MODULE_PARM_DESC(nr_devices, "Number of devices to register");=0A=
>=0A=
>   static bool g_blocking;=0A=
>=0A=
=0A=
