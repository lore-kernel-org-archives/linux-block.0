Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B49C4332B
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B917D64F64
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhBDTaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:30:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16348 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbhBDOya (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 09:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612450469; x=1643986469;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yBqeuEOaAK6UGkjfqHMmdyWSCDmnKcsTWoDHm4IRupc=;
  b=POW9+oZVltc886vhxirjxULXV0qqJT9cDYrIsZPL18s+GFDX6jA943WA
   GcDDOc2MA2zWH41bvbYcAV8ObMScgO226sELHL427wvng9Z7kit6kfYom
   qFlYLe5VfPZ9nog1IXwLKhAHQ4lVING+KsauCnxjZvhKBAiTt3jtQ89vL
   ZOLhTxUS0o2HW7vks8kINvKsUEtTbjcmL+/DPQqJl4E7xQ/CyF71RHozn
   cDnwtKm1+v353ymJRwRbIVS3VIYoJggP7ia3v//Kp77vzuhMTEfSAParR
   QVspgKgRw7M89N5lgyn0OFjeSSmkkts60aBKqtxLHqP8izj3IC+DSCN8+
   Q==;
IronPort-SDR: PrKxj/KUuPwzdqb/+nfE9/I9x/6BiDN260kh0FL72TXyVBsXHRavRajay+Iv7l+Z6/rmigN6Hc
 D20txUJHIoEWhzWQkAeF8Y1O5Ef3Wsq6sopnfbK8u+aKiFvSc7+Ma7g3+Sr4A6IB2QCMjYqk1H
 9/A7efhvwwv/JcvudwY24VzuP/cUk7qUCSHPt7Q4T8jK6jLwSBvUA0EkLSgAsRkqyh7Ep9d55D
 zJufb9SV8S7xkBLACyteZtJE9dmkgqvxLulBvFG5hTCZ++yTd6DUun0bKec98+vno8oJa6DZ4N
 ZSo=
X-IronPort-AV: E=Sophos;i="5.79,401,1602518400"; 
   d="scan'208";a="159128442"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 22:52:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AndPOO6B9Wwi/y8ciVwF9caYqWryQ6NYVM/nk/GDye01RYHpGgC0R+VfqTgwVXqqBVbWb5and7Xr7tZtaugNHPqFORt3f0V56GUB60GCPlLc2opKAEPScp59BSOeddiPsl+RVizBMMdB9pcA745xrMDLggDHZ/pupMfR4LBaQ4lx1MoW8e1E9efiPcndUjk8fWIICq3QU0PJieBUC0H1wjLjHk2zsbZol5qC+8Mgcqos4ppQEHfIKHSSeHwjpbkdSHLj7cFAXGUMZITAUZP0qTgXOxF8PNqB/T1i2yvzDXHHQNbMdb6t9mIlmNgJaJyU70uoHkoUhqiRVPNikCPBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBqeuEOaAK6UGkjfqHMmdyWSCDmnKcsTWoDHm4IRupc=;
 b=XZ2coQtFqrZus2GLjivlxNqRybAdXaOzk65GgKGehz3zjw415tHVWoA0SX7JbkiOrHsJQhVMbi0KsFDLsFtpkw2lAIdoiGDFpl+ogb82Ubbz4fxEeGWkEegULS3W3+J64Q7iNGSQoSVHQQyYNnfZeRNWr2/DGzrlISyEYNE7DirIuPUxD3sZiFPr3EwE/+/QGg7vZmNDuBIC5lmPefMq5JwO1X/OUthsS2jyWXnjIbMQmsy111lF15WknvflTHJbJgu5obh8l3NNMW3r7GSd9TINVTJkNmNe/18YC9PJoFAZb9xYOzBKoRb2J8+Q6nO9iq4LO7vxwOUYt08wlQC7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBqeuEOaAK6UGkjfqHMmdyWSCDmnKcsTWoDHm4IRupc=;
 b=I1GvYmwM88thXxmUaac0XUj1S1jPOnMiVPiQYymWVJl4NgN/UVGQmCYSdAm6fpQ43fM1UbgJz6jDefgUazD1JWdlVGYzy+dh8m3R9wVjUJ4C8lyU3qqJ+JFt+q0zwqHpvlgj7Rn34OOPofOzLWxOu8zYEIQRvTwUboeIe8V88ZE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6531.namprd04.prod.outlook.com (2603:10b6:208:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 4 Feb
 2021 14:52:54 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 14:52:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 0/2] block: Remove skd driver
Thread-Topic: [RFC PATCH 0/2] block: Remove skd driver
Thread-Index: AQHW+tIP657CBmgMn0mo5aToTM0MiQ==
Date:   Thu, 4 Feb 2021 14:52:54 +0000
Message-ID: <BL0PR04MB651463DB539857107251E174E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <3cb4ca54-b916-5793-0632-bd12ff9d0006@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:50f7:ee01:712b:bf92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ecc73db-fd31-43be-251b-08d8c91c8dcb
x-ms-traffictypediagnostic: BL0PR04MB6531:
x-microsoft-antispam-prvs: <BL0PR04MB6531EC8C01381DDB7E47C588E7B39@BL0PR04MB6531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4nfiULPihu0GlFCsZI7YLFCPYJBS8jE5Q4k3ngl4iPwks0Flmd92wWEds1VgCH5JvBZFygI9JgjMwf+vfgB4fv7cOG1GMop5Z2d2bvNB+gbCF+V4EPj2UkjfyIPDFvkSDFAxkTUG+S5FOO1K916xG9fGCl+6YLROEsq5ZsXchlZRMxt2mBZrP4cqhCgrvric8DxrnswswyR5xxG0eKrSUkP7M0knrQMMXCcXBN2qlHSO6x9DVMusfZjxCTgMESoup4sJl6eR0iuWltZUogyaXeRmCLEpb8lWvFy0JzCAR+m/OGT3zkwfh3vMJZL6RqWT7joMO6ebD5OYSETkjU+OffidosCCFvoSu3tISy498bpguwVuGhW9GaayLE+ji+C/XxN0I2ffqLpX2YOR3eHEQT98lB6k856pTy9Rf6OhR+F/47XJByj4Mr/BcqzSM6ZhUdfj6ELcRTvP6/DXvOQti3/La6b2OE6RtZRUFG7eelLKcrFJsPSFMSkHCgBPbfwI5RgEX530JsUMR7k/Gsosw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(478600001)(5660300002)(66946007)(76116006)(55016002)(91956017)(316002)(9686003)(71200400001)(64756008)(7696005)(66556008)(66476007)(8936002)(52536014)(86362001)(8676002)(6506007)(53546011)(33656002)(186003)(83380400001)(4326008)(66446008)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TPvoJGuOYOYlMIvHqTlCAAsQCbZO+TdxkhqGE3Pw3ONqjS8tDbctojSjyD0N?=
 =?us-ascii?Q?cI3cawz8JV+rHX+UkPzYYIPRgik2STfFgxfb+czCaZ1V/wrwTYhBtdJTI8XD?=
 =?us-ascii?Q?jX7ZxTBfEVEzCzslb471RDE6T8rRO0rDYBFFz6zq5lM/IK3KfzsNxYqf02ZW?=
 =?us-ascii?Q?KryDAv4uGOYmVzBgZRGWnYHOVWbj+hQfcdFBZ7bebXtYBk9NyPL+LnWQs8Na?=
 =?us-ascii?Q?+beiN9TRWwLgxQulay1PvFr9HExZYai8tLtp13WTQT6Z1wTkBhZBvrUJzZlm?=
 =?us-ascii?Q?3OtFJ9x1N7JmsSz6nS6jdfvcksg6Bd8DR6wcwANDC0JxW4D+hdseBjYt9d/z?=
 =?us-ascii?Q?V8lIyDI9b/Mq3FsrzEM8ttuY3ddhhhGt+XcwK/8uPd2sHqaPil6LuJCjDWkK?=
 =?us-ascii?Q?q4XkaeFmkQ8dtfSHO67pudXYe6oepuVG1AQrBHqfvhqUoUTlZH3RTcpQSvDH?=
 =?us-ascii?Q?gG+ygsz2d+0FGn94nwsL5tp5K4NYw2KkzFxWuwv/u2/TrKCWC+ybLa24WZi4?=
 =?us-ascii?Q?q9Dgc4PClnUYU921IXIMmOK03A5wv/h+cJ/D3bzItEGNHAficmtPfMEcvEHE?=
 =?us-ascii?Q?lJMEPmzMVt5Ki7OnCOhGlZqgbib0xWDD6rcr0yAdCTVhCK2UoDcOz2vi42GP?=
 =?us-ascii?Q?U5YfA+XP0szTePoXH4WRTwqyNe/F+yEqzBnYDxKaPdgwVpq0xy37ZrPhWXeW?=
 =?us-ascii?Q?d57Bei+B9RurT5N6UbxILiBCpTu0Ip4JjfraNV7BBMsejhVcZIwimbHrASCm?=
 =?us-ascii?Q?QE1fhCT2GwIX2yU1iZbuhOwgNxJn3Sgodjlpgvl/NQ89gxIwim2H9CMxOkl4?=
 =?us-ascii?Q?6aJtM0OET9jcXuJLb8QyLwNtgeaaornhKQqnSYxSbLPnAdc9Nm92UaNj38YT?=
 =?us-ascii?Q?EW3AUbOFSypxpgSAduvOym+GQr39LlXrCgcIVXQRJIvHajsbzFKpFvsz5aJn?=
 =?us-ascii?Q?cu/t/8ffstqGONHgNvIhKpKI0RxH+i1kqhkNjOiLoLWeSRXU1GfrsaJZ1rUg?=
 =?us-ascii?Q?xLJWBNuMifGT9WI8c+xjAu9mKnBjvZ0Osc21THFZi2QY0rVoMCetCe144MSk?=
 =?us-ascii?Q?+92T3kK3k6VEO+7c4RF4bW8Qy+/9PriL25FJB3LWAYfd1pF32bdU/lIFJwa+?=
 =?us-ascii?Q?/uxlQa7zkhtL8IGtIVIta61fxB065fI/HqCvcnFCzGQ6bDdy6lXehb1TO3jk?=
 =?us-ascii?Q?yWmEwytUCxjkWM71YisuQLb3abwv0fOpBblb6DexhAMdD+q3XFTWLxY5UZpb?=
 =?us-ascii?Q?ViWCkaPVbyIUf355+dKWs0Y8k4HGVuZI3i/erbkDkNnB485xVp/7XIUK1IDO?=
 =?us-ascii?Q?AiAdtKTk2EVCb+baD3qgYHOzTwdhJxwx2LbF4wbZWwXl1PmxEaEVUw9Ma/I0?=
 =?us-ascii?Q?3BOfc+MVM4Iw5qgadbaRkdhrbO6defx3nPUyr7tptTJYuWSBQA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecc73db-fd31-43be-251b-08d8c91c8dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 14:52:54.6759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZE0ZzFJ04pRwFDw7vdTovxDykeHV2tq2qCbIOQ6oVp+gRfCU/voEGpcNkBjM14ozWO942+SsYbvRbc0zzQp0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6531
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/04 23:46, Jens Axboe wrote:=0A=
> On 2/4/21 1:43 AM, Damien Le Moal wrote:=0A=
>> Hi Jens,=0A=
>>=0A=
>> Instead of spending time fixing the skd driver to (at the very least)=0A=
>> fix the call to set_capacity() with IRQ disabled, I am proposing to=0A=
>> simply remove this driver. The STEC S1220 cards are EOL since 2014 and=
=0A=
>> not supported by the vendor since several years ago. Given that these=0A=
>> SSDs are very slow by today's NVMe standard, I do not think it is=0A=
>> worthwhile to maintain this driver with newer kernel versions. I will=0A=
>> keep addressing any problem that shows up with LTS versions.=0A=
>>=0A=
>> The first patch removes the skd driver and the second patch reverts=0A=
>> commit 0fe37724f8e7 ("block: fix bd_size_lock use") as the skd driver=0A=
>> was the one driver that needed this (not so nice) fix.=0A=
>>=0A=
>> Please let me know what you think about this.=0A=
> =0A=
> I'm fine with removing it. The 5.12 branch doesn't have the later=0A=
> fix for the bd_size_lock issue, so could you just resend that once=0A=
> the merge window opens and the block bits have gone in? In case I=0A=
> forget...=0A=
=0A=
OK. Will do.=0A=
=0A=
Could you confirm if you received patch #1 ? It looks like the list server =
is=0A=
dropping it likely because it is too big.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
