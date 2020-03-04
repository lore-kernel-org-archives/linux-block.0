Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0095C3F2CD
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FD720866
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A7vourHw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mSeSO+QC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgCDGLk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 01:11:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54097 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgCDGLk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 01:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583302299; x=1614838299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rsp1vB9RPa6DrPmTZeLn6ws+D+7tBWYZntgpfxJioTA=;
  b=A7vourHwMh6uNiqwzIBWx1k4Rt5+U6ahPPords15PSt2HS7eshEtFBev
   O9jHmV64Eio148FkH3Oul4ln3bp/eKF5RnGgGNmGQkcA8ibiwrYpyR3KD
   Sf2VVbiyr3VeDwbOV3zzJFnU99tMW+2bcMV8eSXqfoy4LBi7jUnIRVaQt
   23ORs99olgWd8+wtewZfzYY8RGN71ingiQEOnmNFDxj18Bdrua7xA00fS
   GQf47ojKTY3C/QgqWoRGpfRwW6wkiHUQClKrOsh7AuHdPcNk+H7B9KzAY
   V+kInsbmr9vDkSK4OHTOHIFio65Na2SIt03uPY01Kg5guyGoVI/8XafP6
   g==;
IronPort-SDR: GgBOZYoDz44fFfqPFdMuZZGQ5SHHaCAIJGl3c8TCBp7kDWhPAG/BDWZU0MBd02yzLIpYcqtiQQ
 ot4tOeyl2fIcypFvswV18OS3QBYQm2y86v6BM7IdBZGBv13/6Kyrgt/+/71sxDdHgODePtBVv2
 xb7kWDpX0KNcC+hWZixF9k+hjXMlEkcOHyKCc7fZXmijK4aI16kobwSR8DpW8gsT8Dq5H5+ra8
 2ohg6RIKmXDu2hqg4mmtRgSZ9h/EUzFQ7sHsrk7gOlCfKv5joGXXjGT9Ysf0sVe0Kt9pZbc0ut
 AlE=
X-IronPort-AV: E=Sophos;i="5.70,513,1574092800"; 
   d="scan'208";a="239612152"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 14:11:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr4P9OZeIBbOu4uWYdLqOhPx4tC+kAQ/7WbFsvUorgDpTTc5gTzz68TMcYBa8PTD9SLnNJaONSPIDCK4lW6DHK/pV3TKtQkQ3y4N35jF++bFhPyqN9nb5/VVqVB7llQwuj9abzM97qMjZiswYytUOF7FdZNgY+/u1QgQ2KiVW8ZGKcOStQ7ejBmUazvKShTIXjRR04Fz9i8Crd9cyTnIRleJ027dtDDzh3yXzMSARZd9L74d0TiBwmy4BSfbwudYhFtsFOtlW/e54xXDAFuZOrZMuU8YhVwXSwzmg6TwzHaa29d5YKa98EkPmycCzVb2xD1bO94bPjPccSIDZrhl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsp1vB9RPa6DrPmTZeLn6ws+D+7tBWYZntgpfxJioTA=;
 b=lIOD3G71HcLB8VMjjQUWLnLcuZA52BiAhvasEt09imjsVNoQhAGiZVQ9oWJa2vXq6Io7CLjr/hhJfxYT+4JjalpQ5Mi3wgSJ+wEoE5iBPuyhFk2PVR9RVW6Cbbk2yud4OjxKZwsn8XJbGv9HikVRnNpdXXjtJ0XSJ7MDWK++0DQOs+/Kzhy+jqD0kqNvJzlD6Ge5Iqetsx3CcmCZH2Od5tQePOZiJOzL3DSdDMBG6L4vFr/GLZiwWMGBLrMETJ6GBhDTu/NmxhvCf6mx+3BFxclzBZvzhxlbJ/zRtnvdeDdkDWY+jty6rz3Fno17PKfzf4xYL02NiOrFfS0s75PQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsp1vB9RPa6DrPmTZeLn6ws+D+7tBWYZntgpfxJioTA=;
 b=mSeSO+QCQxv6Bx0raMliRBAsbJtVF/sSCfC1K88fme/lv+zjI2eUhZW8iVAFCVxftTWoiHjBcwd/fy1wMi8p28EbfwTWEu2lem82jxdZHJ9JqrRCPKORzyukJVdcW6Tchha70Vl5WsG3iDlhpxaxlDdtyTW0MlOxi6AJj9K9n7g=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2155.namprd04.prod.outlook.com (2a01:111:e400:c618::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 06:11:38 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2dad:bbd2:9457:ed3e]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2dad:bbd2:9457:ed3e%9]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 06:11:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/Kg3y28AgAAoe4A=
Date:   Wed, 4 Mar 2020 06:11:37 +0000
Message-ID: <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
References: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
 <20200304034644.GA23012@ming.t460p>
In-Reply-To: <20200304034644.GA23012@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49468923-a881-409d-b413-08d7c002e60c
x-ms-traffictypediagnostic: CY1PR04MB2155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2155377C2347846DB42C9344EDE50@CY1PR04MB2155.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(186003)(66446008)(64756008)(316002)(66476007)(966005)(478600001)(66556008)(26005)(54906003)(6486002)(44832011)(4326008)(9686003)(6512007)(86362001)(6916009)(1076003)(6506007)(91956017)(66946007)(76116006)(71200400001)(8936002)(81166006)(8676002)(5660300002)(2906002)(81156014)(148743002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2155;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2E4v//6YeunIJ66qDd8h4In6kvjdLPERMBDIUzVnJilvg6YQ+aT8xifVE1znzisqDTtxqbKCYCwjGmEQjEVGUdCMeWBZMX1fv1Owlqfb1TC/T3qPV7NJfCFoCSIMy8+k/W6Wj6PXAVSYmBEueGSU11Paqcq2b9+YbgcIotbY2JBbB+bXJkefk62m8h5esuNJmS0MjIceNLpJs9aXZxsMbEHeMw4sGcfdD5v6DHygevBKTaJc0V/rax18htAh628TafqnoN4tiqbwzksXxvTMGncJ9icQkplzJXHeNZV6LtqEmidmRlQpAiKVQbS1rgNG2rrQJMpa3GP7c1R2p8v9jsi09GHaC/iLqeBFoikRLpgdtns81AJdFzBGkdSzsWGp5L9n4KuWVPtFIgdAE2Zqy31lrWoCs9I1CHQdefWkASfeXI3q+UOxyVEyzCcag6PiLooOUwSEEaiKuhx3vPmpPdKd2Xxo+D2FC6L2HwyNpqtPmo0yPevKGKB42IltHo6wyRiLfwYVhuTiDOzjutfWRyzUXxpNulnXrX5AbUF1D10q0StcAr2VkHs5bx4WkJe
x-ms-exchange-antispam-messagedata: p2P+ilJd79ANHzIero1CuxGdUXVkI61s3edZM9uIxGj6qb6dq46xIW74VmIvR5cozWoKkttCBD2FjXLLEjo45QG05WklB4AXUQW+f4ckq4hHZvf5dMLTWH0tKxLRqO55GYOaSYweYT8INBHHg8i8mA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0F27E7C3AAF9C45B029F76FB9360CDE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49468923-a881-409d-b413-08d7c002e60c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 06:11:37.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WBJjTtoBnS9zG0r36w4NydvaoXg8GDeEmRqvxwj+bzkhAjRxKShNpTP4i539PBTmB3i2ywfj2gBl/GEZKIURjickyOQJzzYNGTFb/shnrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2155
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 04, 2020 / 11:46, Ming Lei wrote:
> On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki wrote:
> > I noticed that blktests block/004 takes longer runtime with 5.6-rc4 tha=
n
> > 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: insert passth=
rough
> > request into hctx->dispatch directly") triggers it.
> >=20
> > The longer runtime was observed with dm-linear device which maps SATA S=
MR HDD
> > connected via AHCI. It was not observed with dm-linear on SAS/SATA SMR =
HDDs
> > connected via SAS-HBA. Not observed with dm-linear on non-SMR HDDs eith=
er.
> >=20
> > Before the commit, block/004 took around 130 seconds. After the commit,=
 it takes
> > around 300 seconds. I need to dig in further details to understand why =
the
> > commit makes the test case longer.
> >=20
> > The test case block/004 does "flush intensive workload". Is this longer=
 runtime
> > expected?
>=20
> The following patch might address this issue:
>=20
> https://lore.kernel.org/linux-block/20200207190416.99928-1-sqazi@google.c=
om/#t
>=20
> Please test and provide us the result.
>=20
> thanks,
> Ming
>

Hi Ming,

I applied the patch to 5.6-rc4 but I observed the longer runtime of block/0=
04.
Still it takes around 300 seconds.

--=20
Best Regards,
Shin'ichiro Kawasaki=
