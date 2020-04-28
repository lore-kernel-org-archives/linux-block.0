Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6F6C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B419B206D6
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fv3Ukl7Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MjoXY8RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgD1OQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:16:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51211 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgD1OQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588083399; x=1619619399;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tuPe3iuao9qN/8OOewTcMFHteREj8kFnSM57JdVpxc0=;
  b=fv3Ukl7YY3Ky+Jk31ggiw8/7ygwPW4prrAu/v+YwzvvrDfw6GatulEp2
   mdnmUdKh1t6DccAD/wDgUzpk2FeaRlpQGkSuM37hhPdGHYzEhmpgbz010
   nBXflMCnx8X4unESZkxUWSL11SKs9Z5VwA/kfUUClEnh2PeSqFwB/PgUx
   Tt/Xq6NEkLj18utYycESoMwxdie7GJl+r9UjfsiJcicp1nwEgF/8ttISz
   uxRy3DXf4SMNf1gygvKBdGzvvZrRTf/te8K3C+Ak+GUqlasV5SA1aKqa6
   z6e+3th631+MqRcRJVLicF6pXI2iImRpm9iu68hwzcrKLU71MYCCkb5t4
   Q==;
IronPort-SDR: zPllw2vXoqPvcY+Jl5smshJDs8PzASLHMN3FrOYd70ISzMMUJ9oGNUzU9jouUXcNFfJVFR7jis
 umxJXd2Po6dBNJZN+4ZvGuiiAGnvNxLzqyHZ+zCQFVADHkeW5njQ1DZDzsGAnjTDhb9+2tp7am
 nmSOQp8H9pOnq0pKEUVN27eMDhQDkmIhQ1WuMJuoEErSxXsOzvUR8tww7ag8lY4eshP8bFMgKg
 n0wywJWch4hNM3lOkZggSqls1E4dYCemxW6slIOtciwspdh2IehHb77W9GxmAjLME/T/UN7b8M
 FSw=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="238909197"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 22:16:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx0X9IhaFGlZb9Vp8eRTp628dvkpI3iXrRUzD/KxRKFPt8G9xiUSa9ayamKqlnbsnKVgC9ljIiyLqJm72zUN063VGVyrI6bA4XpKw/4xnaecYENvy1As88h9Sn299xZspgXFmBtI9etBq8cCBWD+w89z974tbILpXziqSMyYnP2X91w4qlx3SSZ/WFgNtUTUqCVMg8QzMMIybO9toVMZCoSJThj5OhdM9hGMSHKxlFHxy3wjLsHi/5EPBAd9eo9ZvJTd1pUdTjdVXJ5uS+rSom5mUXJWK2aJ4BCrkQYHwqMUhX0P/a/nhieG+w2Azj9cn948zqG5bVxAmqOBb/pQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuPe3iuao9qN/8OOewTcMFHteREj8kFnSM57JdVpxc0=;
 b=CciaQhbWAaYiTKl6yw7R8B9CJqDQ/BlpcKxF9ZaPIR3Hb8/BLHFZq7YuABvPccOjgiR6pYHrbBSb89asEYLAwlNi+RtPhoGtxTYgn1uUtg+G+JyChzBUT/4mukzIagQyUw+kIjopJAeykeUV5o1yXAC/jKoSaCo/P2gJjdd+6iimEWyFr3rHn33Xs1SebVVn5yTy/3Fm9kHxh78nMalzAbACP+A3qZdfWnMQlZm4A43OxSlZNliAFMUVQ1Qbc6yemB685mUDRLDGjvLaXv4WppaDohkvrKuwH2gZv4FpCUaT6oPx7nIsDWuEKd5bdnk9g9UV6QnM+ndktGXLvI1EXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuPe3iuao9qN/8OOewTcMFHteREj8kFnSM57JdVpxc0=;
 b=MjoXY8RNXz89TBy/wUsb5ZnKsOCLJ2BNjM+GEtx58NqYUgP9aD/fIRpQ2ZBr1CR6i6a4mbJz6msjgm2n7HmrSs6BMyWMNG81fcB6xsKGAkR4ld+n1ZXHBi64+fH8REbR8TpYB0ehItfkDziXgtBKlfT/AFURC+6KeEpn2uIbdFE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3645.namprd04.prod.outlook.com
 (2603:10b6:803:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 14:16:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:16:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/4] block: improve the submit_bio and
 generic_make_request documentation
Thread-Topic: [PATCH 1/4] block: improve the submit_bio and
 generic_make_request documentation
Thread-Index: AQHWHVAcUROf2kPPqEaau+V4Y6nUoA==
Date:   Tue, 28 Apr 2020 14:16:20 +0000
Message-ID: <SN4PR0401MB359852E2AC69EF156253AB2C9BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428112756.1892137-1-hch@lst.de>
 <20200428112756.1892137-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f93f88c-08e2-473c-e8d3-08d7eb7eb9ad
x-ms-traffictypediagnostic: SN4PR0401MB3645:
x-microsoft-antispam-prvs: <SN4PR0401MB36457D143653D90E0002CD329BAC0@SN4PR0401MB3645.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(2906002)(7696005)(19618925003)(6506007)(33656002)(54906003)(316002)(186003)(81156014)(26005)(558084003)(4270600006)(110136005)(8676002)(71200400001)(4326008)(9686003)(66446008)(66946007)(5660300002)(8936002)(55016002)(66476007)(52536014)(91956017)(64756008)(76116006)(86362001)(66556008)(478600001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4XjIwWr8/B3829n3p9ceXLRVMSM7kOfcaUGSqALwNdGRtf32qfocDe8XXRXS6lyBLeNBGNPbavI7DBKB/mIOuamf6989Jxig1enfthtGH4GNeAAYw/DC4SBulOj+J7iqsRCLodLemtaXrEK4ulrukKmuz5JyngiN1Us/2JSFc36/91ZxSHv2C7SMvmhGNlDfTd8QreYkwgpRR9Mx6LHtL19VYBj8hdfhB1RVc47FDT4ekEKI4jCynmzvwXjQlmp8RsHYZHhmTlocl1xnQBViZ51BOsOcn4oN9MxpkI9RIFHp04PFj4g7kqB5LvnVwzWBnjHxzO5REWkTo4vUvDzVMkGaSURE8ub29qkxYEKQVNWmi+7ZrxgYgDT8LgPBHz3iu5nT0Z2DQoS09W44AOmjOT8uJqJ17cxtDYwWdC7inXUjJSU7W7N/Zi8gzPKkNXZrveITuqGZtOkZzvnPiyAAfT3eUHA4pr94sGmKOJAeqldRbPWnHSlNUniO/ec8e7R
x-ms-exchange-antispam-messagedata: F+nrh1Xqiwxi75EJS0DKXTo5D9YYX8xaHAxel4UQ8L8e8h0mCncplg3THvo6uM4kwEZ/YRQRd7hZFIlnQllar21/BPIYXRdhsHkPTJVhoEz6TR3QCMThF3lkyPAgg53W/P5ArB4VoTZQodCYkr22mGgh7ynDyaPooPpIscfKq3GPN1MnmahGwBlgcFC8iBD/xkIpSP5Kg6BauocNbPJ58tBqaeJtXx7yk9mms9xDrgYIHdDzNMfNlTvnyLyoJ3wYFt5OoF1Jtz5TfjZvIlVBmF68YjrmW5k6044PgHD6h7g717dU7sN6gWcbIcOznZD5o9g/8wzaB1e6/YLl7JBAkeNLKcplp05ffkOzZTulA2bF/iH3v0/dQUSDsWKBZqajrofoYTOTdJmQBU0pw361X9Y+PfRYUHU4fCGyt2nKZwNqU5qybUBsxN0/3M9Yy7ZLmJIw0O98wb/K9GtmQgru3m8Zb0NLNBCbU1+UTRMDZqh4K+pehCuJhpg+tfwWNxr60tornppITeyQT+gwQLRt3PZYbKKtSLPwgmRYOEMa5FWUTZLXd68BgMKalKJvUo1wvzjTMirVgFXGxLrOxYgvsRIANmd8zY6/JQfEf2Yq0HMR5alS5k0ukdmoYhzcB5MoWqXBoOb2j6mXEi2eBcZ3kBmbkmSugKefviBca9+INsgAWPnLiFCCQ2FlJVEWqho+bcGPDn7n5ox2K6YDUmZa+wOOmDavA9/eM0Rj5lR27ny5NKBtz/nwrnA006pB5BWBp4PRK8qT1Rhcvq/dqkeCH2tEwK8/AaeQ1Klh+r959d4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f93f88c-08e2-473c-e8d3-08d7eb7eb9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 14:16:20.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGLPHAYUF+7kEJ3uIIBPRdzrpzfOii4KM05evpJiGkjvN+ZeBqPAZvXNuuwuykYJPPR5Mh9nbCLXQzMLXE8lt3CkMJUPSiEhMVz7RS95M5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3645
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

OK for me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
