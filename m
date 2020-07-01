Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13EEC433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8828E2073E
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lcBS6CSh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WTteBWe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgGAHwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:52:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58362 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgGAHwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 03:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593589974; x=1625125974;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=he8oKd16NsWDvPvE3JMfLwXM9uss1+LssyOADQO5TH8=;
  b=lcBS6CShRKUXu8PnSl/1SDDYLu5ZYcMgEuFxEbBXj2DxXLicmiUYW+vS
   vsIJNOe1BSgb1zmDuy/scKBqORUncUUcvulYbEVP4pCf7K8QSttbq+Mcw
   9PTRf/zA9Fa8KLU/jL2mUUjQkDC4IN7lATSFM5K5iR0dTzV1EKuDyNtci
   8+F1eo4F+IMb3N6d+rsZa0QCbBl0xE9BieNupT2H5axpBz4VsboAixhrA
   L1XUvtF4w7+RBPu4pixxDYQdBuSkRlWl6WJuMCir5hsAWiZqdgEL6/pwM
   CpB9bgeA7vfkC5enojcGnK6GHHJ5KmtTIwuuiO+1F9oPKihDFd1MGmQCC
   Q==;
IronPort-SDR: YF5d0daSIj7y3n0EG2TUfq0A0uDdm8m86D2GVhsazjoixLV6/UU8Man/namy4l/Qc28LyQ0jWA
 LeTnmYHB+07LikSIUKqq9UwUz6yaEh87N13jlpEJTTRQC2vpuCnKfWoMVyh7P4Snv34wo5YdF6
 8/1f0nYu5MaCD1kVK+Djyu+q7Z0NZomqRXbxsUnajbHyiQIIzKGxncQ831+wWJT4Xx0D5zlzan
 Vz5JLrj8UtYV6vB4yNddnopHsH/X3QlBogBxV77S+BTB7rF0DHmOV1l0XxkzimqhzR6LK6CbSd
 rZY=
X-IronPort-AV: E=Sophos;i="5.75,299,1589212800"; 
   d="scan'208";a="142709619"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 15:52:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4ypkq6GFsE77lp613wuSIbydnhRUR4xkA31xfJZJ1A6SkcpgaHpgukr7R/O4KdUvjfWSWTiI7s8VRo8ir3c8+GL+wAC8jkWIBS72qKUrbMnJJRwAJr5w+UJuI/IMBnOCTn8xz/jPS06w6U01CxgOH5eE+fphtTds6tzPlw52QBVb/L9/oNvsuR6O7cau4WPS4jQ1FJOMW40sXrH8HgN3Pl3mbN7lQzV78g3ifFE8iCanZv+RhXRUHxNN0xmAd1SGuvk6YtwEryU0+DYT/bi03gZ3+PxfQQPbwvn1D1Q4phh5w03fYK1GiSYycFgaK5NoBMgbN8yG0gXwzhr3M7bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9kMYSpc3iICc/agpDzBomOB0AY8dY70uWlYWv3NKyI=;
 b=Jl+BJIJFjFCM1CPnBgRgJ97TDYgfkx3POdWXOlttXpvvOnp5Q0JupgNoLE4XMzQIpiJbgvCesS3kKASIn2KjuTH34jwctRoq+LpRZZ5sQSwEfE5kuEAGNxU17LrB0jmPggOlpLrQ/Ay4it1hecFjK3uP3x35uvCyi+1uNxxKYEt3wq8ez1OK707xH4zJHfOVMT1YpEkCIfeAVc78P09B2kOC6+81o7o+Eti0/ofHfeElqZ7P+9Jus5qmY/iwMIRRteCu8HhggUaAQAi5HrhCYMLn3YAahFwLX9xKplpBtz+gHbibjvhWoLnPsjXjSJc+OOICdSE7hteZz2Tw91BRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9kMYSpc3iICc/agpDzBomOB0AY8dY70uWlYWv3NKyI=;
 b=WTteBWe0uxEorzhLMQSQJS+WA2YDjpeo82/g6pTIY3kJ+8GIxdoIZ/3aik/Da1IHTTgwhTx3cPXqgIOR9jcCngvMlzz1ldP3CTFzf8JmWHsMmHqAHHbLRhEaTlGWEM88NoFzWcKcwxvkMSk6tCkRNkggOlVTGsEBWfHo6Da+IYc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4239.namprd04.prod.outlook.com
 (2603:10b6:805:36::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 07:52:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 07:52:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-iolatency:postpone ktime_get() execution until
 blk_iolatency_enabled() return true
Thread-Topic: [PATCH] blk-iolatency:postpone ktime_get() execution until
 blk_iolatency_enabled() return true
Thread-Index: AQHWT22cn+7v9KB7YEGn59MYBJ9tBA==
Date:   Wed, 1 Jul 2020 07:52:51 +0000
Message-ID: <SN4PR0401MB359850E5F42414D9ACBDE2059B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1593583467-18945-1-git-send-email-hongnan.li@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:115:56a6:c821:2683]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f8bc7b4-d40a-491e-c378-08d81d93c193
x-ms-traffictypediagnostic: SN6PR04MB4239:
x-microsoft-antispam-prvs: <SN6PR04MB42399677C5F79852752E75189B6C0@SN6PR04MB4239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8XH5D+ED+vQ0V1IxrXxBWGO5BxJpLXRCZ34asG9/wJjjd5cgUQbFQtwZHPSM5B3bxqSUpgF+DsR/GAtmpXRj4sZsp0fYM2olKPC4a0G9UmpajM1KDzYvk/7u6c/iXAvuHz+M809xURcQNUJzId2jchBHK0c+c3R4Ay4vp9+aHH3lOagE4czwTCN1yOBbW2xYGK6vRb7x5M+z/XTr1sv7DObr4odixyKZMhNigyZbo54mYbdXpJBs9bHS526UOo8bPnb3PYXlFtn68bw++lspioS0EZW8zejsdz7kiHeWVgIrgE36bqMEqIR38zx5B0o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(5660300002)(7696005)(64756008)(6506007)(91956017)(76116006)(8676002)(53546011)(52536014)(66446008)(186003)(66556008)(66476007)(66946007)(2906002)(86362001)(33656002)(478600001)(83380400001)(110136005)(316002)(4326008)(9686003)(55016002)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zG+Kq6ktLUg96sdQTqGmA195vg4gFna7rkliPCYamRa5wntRXU4N22hjQtTSdpZU/SlRGnIuEDf12Np/hexqjflEYWMXZUJ/xllFAg0kys9EsMwbnIuRWWYgnaDTVtFbgi5WdfAXoLhVRVw1TrMbW+ySeITVeSpS7msUiO1fbPjakbv3L95xTvs/y18/Lt/btu2UeDTL7HpjkJzxbGNePgV8R1WP3QiEEMh62jIKiFv79OOWN2dbTooiWvQ7mBnwCY+X2UZFx1Iu3CwnaRNpmI8W4GzDev7yS3s5uVtgLseYjNIBmUPnh1dzIAc3CJKDcJ1P2V9uw2MOHsjuDlVx7MbzpfLfw70huf6UZ3AoGUw46/LZNzBVE5iDJ6QtEzb9tQQVed2dD1qpz3shdnpc+9BJnKrbieYXPrucflon33Ho/kJYqzzM3h8r+H8LB9nS86o9jb5Lgf4EF1H7m8dRmnPgHjfEu/qQkSYXCVBPeLf99XDe2pk168v9eLU10M+u3+dqxeDExkq4FOBvUPojU2cvJKHZUG7qP41RBl/MKow=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8bc7b4-d40a-491e-c378-08d81d93c193
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:52:51.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5yu6zMWgUlco3yTcyc48YiouLwpUafXQU8nnFZWhmcwRNqXgq9VgIrYtL6EvGEaS/9HaLU+GukkRBoXFx0DNmnD2Wi45HKAHUsio+TY5Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4239
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/07/2020 08:05, Hongnan Li wrote:=0A=
> ktime_to_ns(ktime_get()) which is expensive do not need to be executed if=
=0A=
> blk_iolatency_enabled() return false in blkcg_iolatency_done_bio().=0A=
> Postponing ktime_to_ns(ktime_get()) execution can reduce CPU usage=0A=
> when blk_iolatency was disabled.=0A=
> =0A=
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>=0A=
> ---=0A=
>  block/blk-iolatency.c | 3 ++-=0A=
>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c=0A=
> index c128d50..8c1487e 100644=0A=
> --- a/block/blk-iolatency.c=0A=
> +++ b/block/blk-iolatency.c=0A=
> @@ -591,7 +591,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *r=
qos, struct bio *bio)=0A=
>  	struct rq_wait *rqw;=0A=
>  	struct iolatency_grp *iolat;=0A=
>  	u64 window_start;=0A=
> -	u64 now =3D ktime_to_ns(ktime_get());=0A=
> +=0A=
>  	bool issue_as_root =3D bio_issue_as_root_blkg(bio);=0A=
>  	bool enabled =3D false;=0A=
>  	int inflight =3D 0;=0A=
> @@ -608,6 +608,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *r=
qos, struct bio *bio)=0A=
>  	if (!enabled)=0A=
>  		return;=0A=
>  =0A=
> +	u64 now =3D ktime_to_ns(ktime_get());=0A=
>  	while (blkg && blkg->parent) {=0A=
>  		iolat =3D blkg_to_lat(blkg);=0A=
>  		if (!iolat) {=0A=
> =0A=
=0A=
You're mixing declarations and code.=0A=
=0A=
please do=0A=
-	u64 now =3D ktime_to_ns(ktime_get());=0A=
+	u64 now;=0A=
=0A=
[...]=0A=
+	now =3D ktime_to_ns(ktime_get());=0A=
