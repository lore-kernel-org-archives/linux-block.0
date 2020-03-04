Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9F2C3F2C6
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 02:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E482520866
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 02:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NwsXiQa8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NUE0entp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgCDCjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:39:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30931 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgCDCjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 21:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583289591; x=1614825591;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=dWuUqGKkhfvozvLXbcx3Q8pvkDRxS16RsPI41QIO/jA=;
  b=NwsXiQa82GxVD9h5yYp7CgVr5Do7RRqPPR6t8yfWwX4xXeqBz4mSDyLJ
   xKlela6iR8s0Rk59XAOCP58lpooinb07Tyib3WaeOz8hVDgaz8PDlfuBp
   1xEZu8sj642hfhQvQF0MJi+vZvmJY2Ftq7hRTDBP842veyS7PniGOTscb
   em+iqDFkEMho2wZjlagfSahk/k+nlpJyLnisxeM5MfSMcGXIpCt4VIbDT
   kfwwZLsuFZR7DP9k1W2gWn2PbXWJyv3yXNktyCmkCF8hK/3CYARbCLc3e
   8110mljAKiXfJK42zx5BPvD36Z9tfeb7IkCNMCEkPhlF31qOJckAolwFf
   Q==;
IronPort-SDR: 5qmF7QDSKJDC6tbp3G2aj0+Euo5XTVU/iYKfDVVev4bRjTnnobI8Ora63g94k+f8hqNIYQW09v
 1Nwd/hkRuvmZfwdoPNXCmXJYNJpXeGHsMvXU6M5zAbdiDzRKATcge/NHoxWwyPPuZItBF8L3JA
 Gi44cPdqqINOlz3fsO171DtYdwGKJ+4iMQCHAsxRqhAKp68hNQaYXLHe7HhPh+LJG6dRznQv4Y
 pDMZOuAE2gUDo0TUn9DR2o1h+3S4j/iEMBDvMMzETDub5BPEgulgfKzT8VkyxnzhdsIwdC3eKo
 0mk=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; 
   d="scan'208";a="131352919"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 10:38:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tuz1aDzqgYA1m0fbpdiJUvaO/6hV3Dj+X1YcoHDuUYqpv3AhosawETa9z+70xzJD7HkcU0zEQTvSwe53xES3/hd+IeFpz/t0D3hjF03Cmf55YiQQU1aL+pxBiZOxfRBJZ0ibS21Ih0owdUcpJb5y3eWylMOzt23oQ4Wv/U6/xpppoWy7m8Thprial27twzawuSWdo2BD2FBY3HVAmF6Vg+rpwWATDY3Xche+66oFEWT6oqLU+DW1ZDqA3B2tp6fyPmuwDRQ+1K6UHbEhCoHa8EIB+5cyHmV0MoDzK4/rGraQtuVY3hOWxurpXCu6Y/hD2LYzr/hKzJPvIOXRLVb+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWuUqGKkhfvozvLXbcx3Q8pvkDRxS16RsPI41QIO/jA=;
 b=AWXN+WCNye6TF1kaEvFVivm3/tJO4r0Gyp4RBABSMwt++ezlYHNDCaaJDedcIirqEYxIV4cmEBFD14XcX8G6BfNzqHgTfg2exYB/90Cc8v/wF+foNVKBxranGJgGtlWDp/4macfgq2IqlxYd5zjvCr5YnW13kR9g7ldN22h/c7AocU6yxR0B+zNzqvSkgGCcHWAnRAn4FvrPhezqw4APLoaekE5vWz+ukJqgSGPzIEAlf8a78dq2luSV3hYFGOdyi5EWUMPgcbgWr7wCYEp8Y/44OVwR9mvFEoVobNMCn9vQCyHhorHsGna3dwOsyphIOatHBE5Oa/F0D++4dEixow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWuUqGKkhfvozvLXbcx3Q8pvkDRxS16RsPI41QIO/jA=;
 b=NUE0entphpm3o+6LoP7Rn8piuC/Q3cIq+cPtdHRul6uwOyu+fJNUL9aKpxWvEiSrX1oXaif0zUNJ4UYz8eP+YfFx74UdXr7Tfs4SmPf5t/0vLouNzXY8k51ZICI4zFRA1+zrQG/91VV713mI+PpichSRfKWp7i6+4SxIhS6Z14A=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2283.namprd04.prod.outlook.com (2a01:111:e400:c618::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 02:38:43 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2dad:bbd2:9457:ed3e]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2dad:bbd2:9457:ed3e%9]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 02:38:43 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/A==
Date:   Wed, 4 Mar 2020 02:38:43 +0000
Message-ID: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24c6aa78-b063-42b1-0ca8-08d7bfe527f4
x-ms-traffictypediagnostic: CY1PR04MB2283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB22838304DCFC3744CE5A43F8EDE50@CY1PR04MB2283.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(189003)(199004)(66556008)(81156014)(71200400001)(9686003)(6512007)(81166006)(86362001)(66476007)(5660300002)(64756008)(6486002)(4326008)(91956017)(8676002)(76116006)(1076003)(66946007)(66446008)(6506007)(4744005)(316002)(110136005)(44832011)(26005)(186003)(8936002)(2906002)(478600001)(148743002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2283;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/Tnn0mg0jb7TaIz+URgmTCzAjm0TvZt1BNy/AwAffWILsMx65ErCJ+H0aw3q+az0JOAX93h9D6SH3pNeGzNlnJYXKFWwn6MiXTipjZy5h3G6ARzIor95EDsjuq2m9gAkdX6+4K2U1muJc072VBSwXOtVc6ntdSidXHNBBDE302XcRAQpqgn837F+eB5JPuls65xYQSo8N6i/iM+sXQx4P73GC/LaDkdtOrxqisQoGUwMaidUOH+o96foD6U0xRn/RS57625Wj3H4I65fLBLv52FZIYyREq8Heswpjf4t5tCCfnN4YxHA1GwzCuX1I8GdNjhptUt17UJBoZzFB2jFCzxHwU2Bh0+I9lkR0DjIvkyxGaQIyW6yiHNczKvWKUv+viNu3o+Zki0A9B40ykQN1VSJaMdFA6QC9QclxSpBE/iJNqrfo/OxbKFgp0FVdqGNukB3qWPNyOwBzrSdLMeurCe2XaBILSBVvV/iQzC4aX3S98YEdABC6hZANKq0cYO
x-ms-exchange-antispam-messagedata: itsbSgUvj9iqdrIXxh7wsg8u+k6tguVFWQRv/LvHHL1q/LlgzU6K8xE0KTXTFCrm/G92zZG61/L5sYCoT306OBArDPoL95extFNydT9C//e+p1HAvPO/rDDY1qs38ZDphrpchA/xKZq75M73ySdbrQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EF166F4FDFAC349ABCAAA4FA0A950C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c6aa78-b063-42b1-0ca8-08d7bfe527f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 02:38:43.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFL8kn9kJeM0Z/5vp3WoZnhNVBfKcdpa7t8gTDIuwXGdj+qizfPrPZT0lmrg62B8CZ6UCXHXD/lLo4BgSMev9LKVLHkrAKW5ULNIcn9e0fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2283
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I noticed that blktests block/004 takes longer runtime with 5.6-rc4 than
5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: insert passthroug=
h
request into hctx->dispatch directly") triggers it.

The longer runtime was observed with dm-linear device which maps SATA SMR H=
DD
connected via AHCI. It was not observed with dm-linear on SAS/SATA SMR HDDs
connected via SAS-HBA. Not observed with dm-linear on non-SMR HDDs either.

Before the commit, block/004 took around 130 seconds. After the commit, it =
takes
around 300 seconds. I need to dig in further details to understand why the
commit makes the test case longer.

The test case block/004 does "flush intensive workload". Is this longer run=
time
expected?

--=20
Best Regards,
Shin'ichiro Kawasaki=
