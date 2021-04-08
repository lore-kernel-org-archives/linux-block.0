Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C9C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 06:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFAD61132
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 06:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhDHGpN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 02:45:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11670 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDHGpM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 02:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617864302; x=1649400302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LcIYpnBWpr0NXbw9L+uRBlk656gs10x1JjoSkT9Q8gQ=;
  b=fO+HcsmoQsxNmgxSpFu/jMP1uYtczqZDJaFmJjKTmAu/Br9UlQY0KENO
   mgP6EXXwUb4I9q1gDuwmYtcSDP+G+8P+UeOsujXK8ucvFLEAlACnlqL/O
   1HWiZtNq20P1FW2CXnF62Eh9HyEdVgNvJXosU7xUKpe4aChN6uMDD5XBC
   1vr6SyFEJQNW/1Uj3bPmFngVbFSsaCoK2ddyFDfIP8l/3ftkQfdnsu+k6
   XL1weXLej2K6wUU89wIoimRPZFcx+kTWSuEZjbj9fbdl5fKDZgZmQ7p8s
   Wb/XYBTT7np5lpjuE0hO5KnEHNQOqVateiAZPir5OFq8Az0+e7gF9wP2L
   g==;
IronPort-SDR: 38oURI6erDsdH8PCGP+h8aDvTlJrhQjFDpQ0ppd3+hMIrWL1TVzZZX+th6jVhYs+H+LYiaN9GO
 F+I5sLbaVMETY1cMH8WBGhtSaHjt0ied0SsQ4ywANuoRwAWy9eJwXgK9D56oHRcQQwIlkLkydk
 RclhGdFE7vhBsK0RVflbeH1hbyGKUmv+KKa/PvSt3zgBtdRnN9ph8JuYeM90POmiI8lZu174Zt
 g8jE9MjIpEjS6sjFzqsjddMjs+NvIAwqOfxvRZS72uxFQFknFeuxEQRjzxi9yw423O37vDjg2P
 le4=
X-IronPort-AV: E=Sophos;i="5.82,205,1613404800"; 
   d="scan'208";a="275023486"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 14:45:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwNMbTxizSSUDRQhl9qkWSI/LPZKFEA77qxVR9sRqp9L9ukzsuMW8x8yvvFJ983p2zkgB6vQ/KBJL4KIoEAmJw5z7b6w1kvUcfiye87/GKMzYbUXhJpoHwuFs7vrKQlAXidIcUjwhMl9zTMIbMjpRN4LaM/HqBUp7qC/63qZuQ5H1hQ7zsByP91SonSY48ujTycCK8wJlM/sFyu1o/KJUIJQ5fNUUJvTsb0Vah16HN7+eu+LtxZ1wuN3/l1Pg8mzBRa3pdlwq27PoFsH4yXXPo3zylmA5vGj/AQIB+KGheXT9o62B5bqzAcCWC+NKrvRYnb1MuZRWg99HdEbrNNYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wp6pH48UWBn6kjgurkuvJ1rc9K2hqsjWMQy1KIf8KY=;
 b=QGOrQfzGHr8zbJOMJVCou75Y3LonqrVmENfWR/3FTwJvnD1bxyIJhWHP7oLneAziiNgqQQfHG7K4njLtp7XY8arpGuIXMx33ySqS4ypgpQS8fkUnGJemolHgWo5GRabps4QRzRFiJydt0JSuXecb9Ax+EBWyz+M0DfOpEyr6zg4Kh6DtgIHW9vEQQwjj8xNB0GQFVioekBQlhqD1k8tsgXPJx7urhw6ZU2KxA/3/1Lmi53Car8H/13yyLrpUUIoRYQqIZGAjGI4fg8y6EuZoZTXJtqdQ3Ie/GEeeVNBEET1GQQyTn2yI5DFFOzhxrDEMeoHRX4C6mEiZrAGpTUyxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wp6pH48UWBn6kjgurkuvJ1rc9K2hqsjWMQy1KIf8KY=;
 b=qik/6gsupYXvzBplImNoCvy9AIzue2qjIYk+SNxZz9QSUS5kcm3i9MxsaVZhqK3CtscKI/S50jeQAEOsK14TeHsu99lRgy30U+6HoUm3JAY7QMH6MPOr10TA5HaJwkC+IVn122+DiTN6+ZijBJm+leObeHvblUBZd+mW65NKJXc=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by SJ0PR04MB7424.namprd04.prod.outlook.com (2603:10b6:a03:29a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 06:45:00 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972%7]) with mapi id 15.20.3890.042; Thu, 8 Apr 2021
 06:45:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 0/5] blk-mq: Fix a race between iterating over requests
 and freeing requests
Thread-Topic: [PATCH v6 0/5] blk-mq: Fix a race between iterating over
 requests and freeing requests
Thread-Index: AQHXKy6ybj1V2FVjnUa5KCgCS4Jm96qqLwQA
Date:   Thu, 8 Apr 2021 06:45:00 +0000
Message-ID: <20210408064458.vx4t3tpfnrvrd52a@shindev.dhcp.fujisawa.hgst.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
In-Reply-To: <20210406214905.21622-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3cdf4ec-c889-4e44-4dcc-08d8fa59d4ce
x-ms-traffictypediagnostic: SJ0PR04MB7424:
x-microsoft-antispam-prvs: <SJ0PR04MB7424BAA9BEC0E8F896D8044BED749@SJ0PR04MB7424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVb30yzl922PlcOd18o1Qhi35D+IwqjDJBxhpAZE2ltN+IrfAmfjYhRbhM+xNEXUQ2YY1Atb4lnc0AHdfTMWaNjaddH1aeiP2UhanCyJNEQrnjYafabVBIxiWlkv7qxO54PB1zgtK6kKaI1umHPGhlX/2bSZhunV5iUhnGb65+bwknuU1JaJSdGCQeT/pA50VvXfxYuTjfCPlJQfFxvqGFV0cVU6sk2gaQ+nnC/Q6Rxn9bHh9MD+FJQKomFYrCm5ySIDGlAQ735kvCy2geOODvry+LyXl1y4+/NVvaUreXQaBUq1yEVryaqWh0Pv4lyAxypFPD/iKZ0aCyke3hxSjnn/W44UmIvmrI0gdDoaD+HGAb1NY9vMbvla/gRX384YvVL4tv/Dww7BpzGWuPAwrP9/dx9H151GICAElC254wqlIPL65kAWXS5dIgzrdmsYY6Mm1r/ZdtOZ+ZNmUJwZUAydE1Ytril3hjjil9AlKksISdgMD+tZp9tlJk9c5HSOzSWfXiYv3qW5yRs9VaXgncGGmUkSEt4xmqLDIM8rg6Ds58jWwv7GXGrwK9uAvFDBjQE44i+rNyIm2y124ODSm4vbKQFKJtFd6b/ct9I2cJuJ5JVlSxym7y3p5grNb/l3hq8FtFtTtGUuG6CYlkABWJPshwGOcBnBzMUVe6UwTNxaV5TaKVgeDPEbomrsL/E/FsRcinTAbvjdNUq8Wqzh48hNeSZsQH48RGux3rjDAz3eLomWy1AcGjl/w4xM/DydgU8TkF6MGoDfAoF1kExyZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(6916009)(83380400001)(86362001)(5660300002)(1076003)(6512007)(186003)(26005)(478600001)(2906002)(9686003)(6486002)(66556008)(64756008)(66446008)(66476007)(66946007)(54906003)(76116006)(91956017)(316002)(8936002)(8676002)(966005)(4326008)(44832011)(71200400001)(6506007)(38100700001)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F8vFGzgrJeCdnotGuq1OrFFBUacpqzgXGxXfowLZBIiXe5s3y961Tn422ZxX?=
 =?us-ascii?Q?ifaqU833mvZ5pCPllAINpFWVcCA+/JADllycl4O9X78Kfi9Z4Z4im7FDKQa5?=
 =?us-ascii?Q?d9wgbhLvW9vGH31vLOmvqnX6r4HU1AZSwMyfdAuyOg2AHULQAQYVBw/0C1do?=
 =?us-ascii?Q?k37hwccfLB1vIKvXn7MC7h86baf6tXmf1bspzfeXxLG2XZnb2r/bXvLwdfRb?=
 =?us-ascii?Q?B5JMnDxO340VwIJr2oQmAo9HGWUvGLElVgradDn6uZq6ozpsFZXUiYknBDRX?=
 =?us-ascii?Q?aRl7xTfBiSAcaZWuu/I7FWdYKdZLqMbeJ8Ua/YoqDQDsMz/dvdl0mm/CUFad?=
 =?us-ascii?Q?pLamxpNg7rv8mD0edXZybztI2uhSNDMYK/mzxnvYPkyr/VgJ2a7R/OrDvs85?=
 =?us-ascii?Q?cVDUgpjXqTlB1Ys6RQsFDdKGHahm+cIljoMlVxmHwZj8M7Rme6jeUR5M0W9u?=
 =?us-ascii?Q?t4WVt4YnLd5tUL7RUwulp0MJB1f3cFfe7/v+y4RdhIZjm/ENxI579uA1q4an?=
 =?us-ascii?Q?hGaLVuiAHBe9198ZM7ioV4P1KE4FPkH8ftqT8N6Da5ebTK1optMhOV9NALve?=
 =?us-ascii?Q?/M8JqO5h0UUOU3agrLkw3Np6voLG0jdPkdotASAs4x0uILyT7merMcrNxI/r?=
 =?us-ascii?Q?oX8YQul4/wGocSeNNe6CQVi8RwxV+N0wbS3WLlgfWXMQxBy6HXZddPkWJy8Y?=
 =?us-ascii?Q?+CQse1dzq8yXmA7blXosVHgL5OsQd4gWomch+Zd9OEiNPHdI8rqNcdrIwTJk?=
 =?us-ascii?Q?JHpvRmD65rciGza3J3CN8o3olQxQSxSbm12Xg8fJBfZMrRKuKoGmaGzaoQdf?=
 =?us-ascii?Q?2tXrMvqwGKXlbu9857v9Q5FCwx2Kxj2VBQqjzgZ8DiKlGfxmSjjya03+k4JE?=
 =?us-ascii?Q?mrY8gyltzCWn22rV9/y0qphgsBv0cC1n3SqPl8t8Yh0BE9k4aRbYdlqKRkOR?=
 =?us-ascii?Q?o13RK4BHOF4KRr6RFA/JovO5k7YFOYbMlK0dVlKdaJaCcq0zELDnAX8u5UDx?=
 =?us-ascii?Q?HHTE/+dE32Lvt2TXqGnnCCtX0zjn06pu4o/oX9R8rI6Cjzg8UOvfuADDhOkN?=
 =?us-ascii?Q?pJFhsJrJWBIFcPuP77MDxEKsfmmSQJPoUF4KMhDWK8epF2AYLX1YngFMI4To?=
 =?us-ascii?Q?csaHdqReUTbWENFCPEDfZnVatKOJgNWVcNw7c48RIi4mpD3xYbxNUiBCiA+a?=
 =?us-ascii?Q?3AlF78vazxG1WxjOtw2AoBoxwgMvp1VdSjmo6KSL4QNRhCL2GYjJiRhXI+/Z?=
 =?us-ascii?Q?cw5so6Ze03q7MIpmvetB5OlaaBayOL8rqzbVUJQcSD8JSZUOW5ssITJsZ9Bc?=
 =?us-ascii?Q?A3eo+ok82puJ0s5u/Xryl8J0KNaBi4J4FT1Atv9YatSNCQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <776DD8FA66119040825723BC7A31B2BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cdf4ec-c889-4e44-4dcc-08d8fa59d4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 06:45:00.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPF8+8Imj2CrWlJX5KJlF11ZuX5Yt//8w2svcv1qmBjW+um4YBA8XBuIi9H7OYJwk6qben+D2tTHvvtv15f57iDMrMmVtTpiBwZ1THxGKgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7424
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 06, 2021 / 14:49, Bart Van Assche wrote:
> Hi Jens,
>=20
> This patch series fixes the race between iterating over requests and
> freeing requests that has been reported by multiple different users over
> the past two years. Please consider this patch series for kernel v5.13.
>=20
> Thanks,
>=20
> Bart.
>=20
> Changes between v5 and v6:
> - Fixed an additional race between iterating over tags and freeing schedu=
ler
>   requests that was spotted by Khazhy.
> - Added two patches to fix the race conditions between updating the numbe=
r of
>   hardware queues and iterating over a tag set.
>=20
> Changes between v4 and v5:
> - Addressed Khazhy's review comments. Note: the changes that have been ma=
de
>   in v5 only change behavior in case CONFIG_PROVE_RCU=3Dy.
>=20
> Changes between v3 and v4:
> - Fixed support for tag sets shared across hardware queues.
> - Renamed blk_mq_wait_for_tag_readers() into blk_mq_wait_for_tag_iter().
> - Removed the fourth argument of blk_mq_queue_tag_busy_iter() again.
>=20
> Changes between v2 and v3:
> - Converted the single v2 patch into a series of three patches.
> - Switched from SRCU to a combination of RCU and semaphores.
>=20
> Changes between v1 and v2:
> - Reformatted patch description.
> - Added Tested-by/Reviewed-by tags.
> - Changed srcu_barrier() calls into synchronize_srcu() calls.

I applied this v6 series on top of the kernel v5.12-rc6 and tested again.
I needed to apply another dependent fix patch [1] also to avoid conflict.

[1] https://marc.info/?l=3Dlinux-block&m=3D161545067909064&w=3D2

I confirmed this series fixes the use-after-free issue, and observed no
regression in my test set. For the series, especially for the patches #3-5,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
