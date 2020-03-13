Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92ADC2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 05:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E9B206FA
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 05:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bR8qumkS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nxFQ3kEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCMFdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 01:33:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58897 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMFdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 01:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584077595; x=1615613595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S580p/DbvD/utkiP6MfnBX23Rd+2u9UdRjWAFbk0GLo=;
  b=bR8qumkSALTXxRdD9iFG4cd/W9GbtE5EwsVFem/tmMsbzWBkF6yR+vEZ
   gSwjpNsOJDmpAmyu8/8Akv8bhwT2jIH3DvbbSEmKSVZBlB2GNLpkr1tMR
   YfDCE1A+AHnNfBNa+HOAomf4ZZDGHkt6wDYhMxHNCJllrbD2dLAB/E9bv
   vJXu3ivH2HXZ51TNRc0/gHMJTVWD0XPIob/3/sN32/cwFTyrpxw5QoBXN
   8zz6xictTMZKd/FlibmHSDRSn0FdSwCLqYo7PwixWVMsQmK+Ixiyi1fR9
   vndjPRuI2Y6zCG6Rt3ZmHgSV6eA2cXdBXnm9WCYo2K9FAJYQ/Oxjbsfyw
   g==;
IronPort-SDR: qcKW3enmSytiY0tCIys6uwqr9owNoiS7XEKLlzAzT0vVWyMI6CQ76LXV6X6SEXNCx2oMZLtnV6
 PyJLUEKByJpR+OcdE5JoKyEzcyiZxXh7g9yNsg9JmCVUZPhntOjlJ9Asw5oU1RAYac7yiCd1p+
 Blj2h0l71hYly3rMX8uFqj4LZ4dKVJwjMZ0CkVTh3L28TVNtWY5IdUstvGx4ZOgka3Ljnl3TPQ
 0KLNEi/ZnWmUXLQkA6JBlM9R6t/Ms6nv5Gp7Hv4Jvjqpig26k7xGehrXPqS8FWf4sFKoPQracj
 wEQ=
X-IronPort-AV: E=Sophos;i="5.70,547,1574092800"; 
   d="scan'208";a="136727236"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2020 13:33:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAlOG28IAhcUzWKaFbezYPE5+hyv+Hy0cFJ/1w6S5FLtCDiZfPRH6mt4x+3u0qn0D7UCz2JdnvMwd/nWo1OWtRHKzZgfmijRPVS2KeDGgFOCkIdTleEx4Kn6odoObxzogEmbgzxJz26a+x4kLoaIv0Er5ouX1CoIGMR15QsaV/TfK+Jy3ewpQsQxzv9c6XG0T40XNV7T8bWwOE5qOQSDKZY2a+CzCIUTu7KV1rtVqXv7GtEmQooB2jWNyN5RiJtRUoLq6MssNiW3QsY776PgUMQUEOgYHwIhfO8RnWISF9pCkA4exk6fZmbUQm2L6ng/+weHP0CZU9blzJO5RZaWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S580p/DbvD/utkiP6MfnBX23Rd+2u9UdRjWAFbk0GLo=;
 b=AQ6xNAls4SHqauAwuGwIkRzWhSQiBH62kR22Sy2efDaccPuI9Hrnah6FxwytBLcUXtK/IXplNd/nzPBi5tkdGJW0lTR15MTp8JdnuAc9wvifYIGeVFi4YSDFO3B/dvzAJ7+jTMz5l/KDWn8UpB1vGacm+y30MMMpdChyoYz9uyAyhOXwuz799xW4TWlucgQIp21PvqxYIVRceILNqp743hWhmoXyt63KJZdQDntkoM9P7TIV4QwaXUoC7/Z/Fo/CEP+4/os+bSp+ew2WdMCebmzDgUa4D58xJzFELiil1dccN1zVPaogG9pXu1cIMjczXWVTM8U726Z2cvXJm+mPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S580p/DbvD/utkiP6MfnBX23Rd+2u9UdRjWAFbk0GLo=;
 b=nxFQ3kEKTt0go9Hc5UDvLkjF/JQqaDql+UlR8vnKUlze4mZx5Xk5KcTKLQ4gLuKUnSnGrpBEIq2NxK3DLSAUARnocXGzyzKw4On8dIvqeW8CYTMPVWY1Wtk0mEVD5L0ViYUS7O/rtDg21QBpLMAl4OkTtTJvb7i8Y79Wir6CX4Q=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Fri, 13 Mar
 2020 05:33:13 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d%8]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 05:33:13 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blk-mq: insert flush request to the front of dispatch
 queue
Thread-Topic: [PATCH] blk-mq: insert flush request to the front of dispatch
 queue
Thread-Index: AQHV+E7fmiuIDUlwdEeD12FUhWairqhE8wsAgAEOG4A=
Date:   Fri, 13 Mar 2020 05:33:12 +0000
Message-ID: <20200313053311.rzwwhy37bxj2ho2v@shindev.dhcp.fujisawa.hgst.com>
References: <20200312091548.25237-1-ming.lei@redhat.com>
 <7fd41813-0491-4cce-d3a3-d13e37ad2e69@kernel.dk>
In-Reply-To: <7fd41813-0491-4cce-d3a3-d13e37ad2e69@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc2b00c1-8da8-484d-fa03-08d7c7100627
x-ms-traffictypediagnostic: CY1PR04MB2268:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2268CA84451A24DD47A0F7C2EDFA0@CY1PR04MB2268.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(54906003)(86362001)(2906002)(1076003)(8936002)(9686003)(478600001)(6512007)(71200400001)(26005)(44832011)(6916009)(186003)(66446008)(8676002)(81156014)(76116006)(81166006)(64756008)(66556008)(6486002)(91956017)(66946007)(66476007)(6506007)(316002)(4326008)(5660300002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2268;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2mOss95r3mZSfITTN2Ce3DEl+DjkOQAcJDm64KK+nuwDC1Y2qXUXGsd4eHLx10KttunsuxM946wA/mwc9p9eS3bjv8Yo21m0O1L3mU7/tQn6EqwVub8/prxV2lqzYhnDiy1eQ1A6Kbdf/ldtH6o5A2XSU2vTIlZJ69TorBW3IggtB/c9kibVGHuV0mmT4kLHsvr96sydvJ3tn5yRR94qtQdWMuuOepeCpIbpSkBWnbI1cR6qrgy96muoYvtln5hk/jRcqstfaJmEDFxmW2rqP2BivVOIh8Pd3vKzipC3dl7afXR7WLKDlRlLeNSBkIFr3xyBwJer+Ym1BwkHXU2753WNbY61riqMaIUysb+UHIn8YUja1lA/edKH94Et77z0Cii3lgbteiXXEgCFIOwSW/NbIBAKg/nyQ/b+QoVjmBZrNSRFHG9XhkjgMZXzkFa
x-ms-exchange-antispam-messagedata: on8eM835JYHiX9EwK72mIjophHQ6H78kD6VE9lIrf38vWBU/6KBNnNO9ziMxVF1GLYMfDwIPIouz2L3Oz8KlBjCj3iNOwEqcc/42IxfQtsAoYuFe3pqq09HhYgphs1vbdbLPFdPOHXL13jPOAueHVg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0C81CC27486674AA450F0D1B689FC5D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2b00c1-8da8-484d-fa03-08d7c7100627
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 05:33:13.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKs1jQpqu2lHGl/514WMedEB1TxBkwEZD7hwzFgfci72MUyIxzLm3G0ptyBtkUoLHwnHITWML0i193+a0mIudcK1gDZEq47yNdYkt8Wmhro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2268
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 12, 2020 / 07:26, Jens Axboe wrote:
> On 3/12/20 3:15 AM, Ming Lei wrote:
> > commit 01e99aeca397 ("blk-mq: insert passthrough request into
> > hctx->dispatch directly") may change to add flush request to the tail
> > of dispatch by applying the 'add_head' parameter of
> > blk_mq_sched_insert_request.
> >=20
> > Turns out this way causes performance regression on NCQ controller beca=
use
> > flush is non-NCQ command, which can't be queued when there is any in-fl=
ight
> > NCQ command. When adding flush rq to the front of hctx->dispatch, it is
> > easier to introduce extra time to flush rq's latency compared with addi=
ng
> > to the tail of dispatch queue because of S_SCHED_RESTART, then chance o=
f
> > flush merge is increased, and less flush requests may be issued to
> > controller.
> >=20
> > So always insert flush request to the front of dispatch queue just like
> > before applying commit 01e99aeca397 ("blk-mq: insert passthrough reques=
t
> > into hctx->dispatch directly").
>=20
> Applied, thanks.

Ming, thank you so much for the patch. Using my SMR SATA drive I confirmed =
it
reduces blktests block/004 runtime as expected. With this patch, the runtim=
e is
like before the commit 01e99aeca397. Good.

--=20
Best Regards,
Shin'ichiro Kawasaki=
