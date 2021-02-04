Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC3C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A0164E07
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhBDJGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:06:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31507 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhBDJFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 04:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612429508; x=1643965508;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ilwuiL9zi7ChOgZlOerzsSDmtNtE7IqdBFFwUwxLHvM=;
  b=UsLTL0Qk99RySaTfLcSNnWdOenDjuOXPTXEdc+iCFTdyQ5ZGKxVkvOgL
   kTlX3r8eWw66lIF4DDYnSkS267+yhFfAuZZHzZvs78R8Hlq33LbMXaM98
   QUxvEOWficnyfJkHjbKugmXn+MxMQc1m7ebFjheAUVHMlsnOTETwdYXl0
   5XsJHRejanxZ/QQzFLXy3Fo9Bc8JBUcW1uoXNSAtdAScLTrcgUojFgInt
   6wjDHRMxEaRytp39ONsCn9C3N0mRSb8P8cqwg75+IcD58QiZ+z99ncnWc
   FcXwWCmP1ap59yipEtym+CL18yIjiYzyE/ALmeprqAKZS0JVAD6BLF+hY
   A==;
IronPort-SDR: N0NCKmqr32+vmYTjNrLDgzdIC+8nH4xytEul0BKq6X/X6j+wrTZg+liP2R5zUSyETl9jKmpO4T
 n2FLyTwdZK4E56hEZ+gPFQbcMmo1GZW1v8yp5LhJnvsVAcKnyYYacXRWQPLEyv6Hhq4osRD1e3
 xbQz+rurFNUrmDAyyY0T/Mwj1orjMGRb+KKMaDKHmK5gIPCCQ5OBlcDNAVgtn948e7E+JPjobz
 UN8eVrQSkqd6iXvF18uVt4orP877/mzRggpt4IArU19I8kD3gYwabkSrTXPcQR54NKJS+1NRi4
 9Ys=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159101937"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 17:03:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gic6ZhrQp3Eg9yUOb6BxM9QMeIToC9XfKJyscTdL99vSaIzhnDj/FRHQnX/jW//6hxl6ddUFdWoGrwptcynEfZ5KVZH142hBMfbX07xVY7+C7Oevb4En2/tWA5hqULD9M8uJCUUzCznUhiBd9Y5K2V36veq8fpxoF8CvWUD7JdggPTM3kWSDm6iUMtrIRpv+0nEf424yjlOBsQ5VOYOuT/dRpcTir1WXt3bltK/tMB3h50PZ/m0MnoNeOmBeFR6wOQSmdRTrktNKxQOtlBg7JaC2dxXLqJojDZnCF4aibcGhllkYj8NeZjnJN6e+wDEqEuD1tXGOYQdpWfQ0TKUGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilwuiL9zi7ChOgZlOerzsSDmtNtE7IqdBFFwUwxLHvM=;
 b=RyjgTdG0y4+s6FLVFuRZhVOtnQD7fI/HF0YSmau+E0s1KL4uN69mungl2FNF4hYMnRF+BQ87oxCR//+e9M+CVzFkz5oDyKYIYYYszJVcV8PolUN6hLucs3oucHAAMZsxk7/rdHLX7c4un/X0J1ih2KC6oYc+/YwZ+j3GzG3NoCYdvsbVpm65IvYXOIqMqViROmPLkinInBqGlTpzp73fPVkqPbehTk9N934GQ6gx3fBIchplzzA3uslWIWnk53chBN39hjvUgzYRP057VRcBPUjB0SC/u0WgCC0Vd8wXELNYniWSfPadsm2HlGh4zv8vp8RSc9I7tNcb6gLT25yiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilwuiL9zi7ChOgZlOerzsSDmtNtE7IqdBFFwUwxLHvM=;
 b=wNxti0YYL0J973KwI1XiWNsqLZ1qWAHv2kfKCoaJnGQEbxDPOlOhguusllZNFXaAs0MaZSsDP+ZzosHkwt3oAnM+usCfyqsZVloH1XY733ovTKnXFkoSBrXLIllpZjNlc4DHfk3owb6SwxfXCIE/V+1CDfJVs8hgCMmEpSh/9bw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (52.135.46.87) by
 BL0PR04MB4851.namprd04.prod.outlook.com (52.132.0.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Thu, 4 Feb 2021 09:03:40 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 09:03:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Topic: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Index: AQHW+tJcQ7YrsFFCzEqcRekM9SFuAg==
Date:   Thu, 4 Feb 2021 09:03:40 +0000
Message-ID: <BL0PR04MB6514F0C5971F11B5BC548202E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <20210204084343.207847-3-damien.lemoal@wdc.com>
 <SN4PR0401MB359853B6F1875CF1233A495D9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61dd:3796:e34d:42c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a39b0f0d-7840-4b33-c861-08d8c8ebc40f
x-ms-traffictypediagnostic: BL0PR04MB4851:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4851DB8FC73F10E524053A57E7B39@BL0PR04MB4851.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2K8HoRSZNogzYnGOCko8Ntv0k11JThW1IzDYpXghjXjrzOpsukOWwK7pfkZHwYKp5ATqByq9gUQlyJtedG5k0gSa2aCmIKcT4k3qORqKtf5knwP3xsASTBtf9ylu32NxiPnwvULvF6RxFTEHuerC5c7TFNs/bu6kgHSKlg5GKCtpV8s/dYRz3VWxLeF/z2R+wtPwiZtBV07i/F0JrjTM75+vJEKJ9zIGLXP2wVYQ3yqkvCfpvmx/tQWD/soRgeD+NMnFh3ZssEUPuGPMf8whD8ASkH+dCCKIl482qTcu1XA55A9N0w4uCDnA/NpLI04zRncXx9AHMAebtLR37SXVg4cJJ2ZrK3UF1PiXhLdRBbkaOaip6G4Srgz8SY5XVqAZKW4mirX2ArAuIyHAvP/bpOPD71FymEDqi+/yVWMA4ckmRIh5wRF42YWMDOysIUAC9yDIrKVY2jfm6N1UHDkKnrs809PuoLt7O5uHYCsX+XRKNDEQATEwh9JmHxqNGAS2jrOPAbpdSXQVAeoEvX46sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(186003)(4326008)(9686003)(91956017)(53546011)(558084003)(66476007)(52536014)(66446008)(110136005)(66556008)(76116006)(316002)(478600001)(64756008)(71200400001)(7696005)(5660300002)(66946007)(8676002)(6506007)(55016002)(8936002)(2906002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HmY2mSberRAmVpcz/GcGmkfI/MA/mZNpxu4pjs9hjAlKyF5APXYt5QjGvJWU?=
 =?us-ascii?Q?EstIObd0H60YvLsRWJFm9z0g/VkybJvZdt/8hyOd7qECNNMT5hFPOHaBYhnQ?=
 =?us-ascii?Q?Y0ObtwToVaOhu+sCY142wUsjVHwhtK3Ac6nWoftuxAYHO0lBp06P7m/s4cH7?=
 =?us-ascii?Q?vL+j+isH9K7NCttyEkGBixoHnVoWMCbTweE4bcjStE2I+XXpIXfslRO25jkq?=
 =?us-ascii?Q?bEhezicnkvYsHxOWwYk9Sc6aWnmnZRopCVywpomCWgD1JaR0FdJBnBOYiSkz?=
 =?us-ascii?Q?ozNt5vGkWv4/m4JwU/wkEQ7ep/N0hv7Gw9ynH1W6eODdkZC0L/RQV7ekiY7n?=
 =?us-ascii?Q?HBDtoudij66dZY8B4uir0q/OwFesZjVjG6EUk/8p5VoCNbm8Gzgzz+Lx84cY?=
 =?us-ascii?Q?+8Yp+ykrAOsKuOFfJ8W8245o2TxYH7oLvCUv1/WSHsiXlqFay/r0q6d44xKz?=
 =?us-ascii?Q?qvgh3V0QZXqB7sYEJWZ12E7wRwGvUwwVys2U0qN3kH5IM/zNyIjh3k/m6WAX?=
 =?us-ascii?Q?odstaRSnsGqrxO4NCvpBUx165LU1L09SrjXUmR+KyIEBsqoP+GCTbxH0fPas?=
 =?us-ascii?Q?iaSNuJ8zKtrPv08PfJjB637KPUAgsUeh1OvJyrucM83L7HYEhu5BmWv9egA8?=
 =?us-ascii?Q?Nh4uatE5s6w1zACYY5ggieIRccgCl+2AGsP6PhsW/4pisWrqClr4xlxMW1pJ?=
 =?us-ascii?Q?mFUQGQP+lU3Y+cLa7GDKkkHYqzi9UnqsLFZBrdU1/QywVTjb4+gFkCeiN2a3?=
 =?us-ascii?Q?LJBEbYaIF8lTDuCKSi84ygnm0MXmWEgJ/mAM1JSqJPsutAs1A6QMOc8/HYFP?=
 =?us-ascii?Q?q1p5smU9ASNNP4RAVCZfbgO9yea+C2+3mYfh+0lYLPKvgAeQw0Eg1a+u71ne?=
 =?us-ascii?Q?pdmQdTkv7aEmviyVg5xmIgBTvI3Jq8qDQ2kHbUQ4EPC6BBzJtnUv05t1oXYx?=
 =?us-ascii?Q?zi9mmCqp8AH4gzBDYEkrgxZqHE6sQM+aqOQ/m75TV0ipPmWZTGmFtbjSEdVs?=
 =?us-ascii?Q?Xefmq9GRTcleCcD4+Gc52+mnUPESftMEYfPGSohG4aLfV+fifIq2AWx5j7iw?=
 =?us-ascii?Q?qRIp9GQTg7zkAe1/kJpUw9xDKk8soKc/C+Hr3f70kDwMcfiNDt4uKieqIZER?=
 =?us-ascii?Q?DwVRkTkXuR1oX6sBfg1KbVVX/4UL7S+qCJrGuxwXX/7AnbpgNL7yGVfy0WkM?=
 =?us-ascii?Q?eF00j0uxiR0psiEZPqOSGvSix+iTbDit91qzCSxMNjzBL6AhmwfwlJJkADpi?=
 =?us-ascii?Q?8K6Axt0yXrPP8OezvcgJIZZUueHKQdJgPoOqZTfHB7gIxIeFOOhmdX4mk64j?=
 =?us-ascii?Q?kBF4CvULqlKBm7dWAiZ0cbWYLKmcUKJdCWPcHdP5fOMERJjASQW+uJW6Kh3G?=
 =?us-ascii?Q?5xkmBDB0FuGKNbOatDJTXV4y9W/tm9WZJiyKuxtM+tuVAldNhQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39b0f0d-7840-4b33-c861-08d8c8ebc40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:03:40.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFLP/X99eHznB5lA8xQHRZvJW44MOmguIEnIFg0Uw2mvDhDwLFyEHgSpJzvTgs3PDe6ctR87xzqgHvySmfts5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4851
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/04 18:01, Johannes Thumshirn wrote:=0A=
> Given that #1 in this series is accepted,=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
=0A=
Do you mean "if #1 in this series is accepted" ?=0A=
I have not received patch #1... I wonder if it hit the list ? Did you get i=
t ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
