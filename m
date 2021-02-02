Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A0C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAC264E27
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBBJ5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:57:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33637 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBBJ4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612259796; x=1643795796;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=SDau8c3KzGALsOxcjNFH8d6bu1bn4KAkVS7ACT2ex2TBE+/OnTTGUou9
   6jzb40y9k4xf62KIWwWEI/r74EWm5K9TVxQjZzd6k7RZod8qQxkv5FcFD
   ZJBHcRtx10ZdQbzHMAKZlD5Pm4PV+zitS2vVIymtX8M6bhTzcMN9ArB2o
   jEzNv1zr3HXxRwZUpyT2gpsxtqGeojHe29d9nK5ahYdUtVxL6U8WnL1yl
   ZEuEn75DPYeO/RIAJKl6Wxw3cfSQOpS6h0jAOkIo5hs5FozPtZPDGyGLZ
   0iJ8EaJOZcbeHa39BK5JWA9k5vdMkzxFMl1rfre72msgAcXlJYVpf05+B
   g==;
IronPort-SDR: vsFUVRj0Gc8wnFvqyzjM00KixaZ9C37uC4xI1Ksai/M20kbBg6iFJwirf+fSAU/2JtJu/lp+M6
 wxla8tTe7ePlvePQwwaP69hz83GOmIEkL7sV+WKSxIbfiAFdGzA45Jif+eJZdfPtZtZ1Ou/bQB
 znuhZuGnTSOR3sdGyTL0XlsG1vmkJulN1v6vvdUBcxZ49HoHkB0O1WYoXo3MirbPjzxocvS2me
 AiVg6WMG2xvoWJ4J1DtJtKIeiu4gkGUau1QSleBYBFyiWTXEMvTdM+ynyfZn5xl4fJjphEJnN0
 yxQ=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158906182"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBXts2cO3tIh2iODRAwyO4FHz9X+1kRV/HrppEsJ1eM64up2KNkF9nH3iWs4W0wOtsXiZD8l03XOucpftQSyeDspWKuejfP/ap5b3qqIxbVDRLAEj63RPamtjGrZEcVHMpHPrIAx5i2XMC5aWNzcsb7FmUKIOvwZu2GOxKQt3BwfYcHr8axtRTyYYph22aVgehcXhHUJ1fG4rhgxvamze7zuvPG2w+hcVjQMHknKWwCa6ZtLgB72PVyVFHarGDjoe9GcZ+8qkV0I4wmuyVkSXdtP+5U9p0hbBlhAZnBtNRp2CB5BdgTd7PKQQT0PuvVL4bQ5O8bchhCeb1Ez3HG90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UWYm8gfPlTMVuEHysV/fZHvZVcxyh0IuJQMR+Mqmh3/dW/PlmaniE49jImy65rWiKHYNNK9lWefBcMt8QOaO5+PqxcIUWbjcEg0k5I3Th8BGN5fQJhuyrbsdw5YQtxh4Y7+AyDC6iTRRQsdaUrnbdM6V7zUVG2rU9X11lLykwfEFMr2RwZ4tnAPIvrj8F+PTLHCAVI7jy4PQBE/pRDslIvqp9luLWBhvtCbIHgjWo0ZWhGhctxQwJ8I1H1tEtEtt24ZIe5FcHSO2HMcEF8hvDzn7DJv3NoMS1GSOiORF42YXF6cWPm8CcqVvrE4kWETzSRPiv9Yqklh/mhU9OjhBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=yjAVz5xSpX7+qGypNTnftlkhrcCgxoGvwF+7Xsi6vYGCheJ6+tsx7a6mNDhYJTeJtOCTH26dV/Y7iP2+XPOaADtPzMRDNVroUfG+K1uFjGvGKLDIWbPLbp5hdOFpWbVYq4pgteGs+NkZtlrBJl1FfDEb3f2iuvp+nZl3Q0Rqmpc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4319.namprd04.prod.outlook.com
 (2603:10b6:805:31::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 09:55:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:55:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/7] block: remove superfluous param in blk_fill_rwbs()
Thread-Topic: [PATCH 1/7] block: remove superfluous param in blk_fill_rwbs()
Thread-Index: AQHW+SPmPaztFK05ZEKmVfoOhHbhSA==
Date:   Tue, 2 Feb 2021 09:55:28 +0000
Message-ID: <SN4PR0401MB3598CDB23B187EEAE2D0A61D9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1eca1c4c-0d7c-426f-aef4-08d8c760abf4
x-ms-traffictypediagnostic: SN6PR04MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4319735B6A707611E4BE62ED9BB59@SN6PR04MB4319.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUUH7myF6fzKTDfbhHOYY4UrsgsJTmzP5TTiPWAdlBSiSf57VjEPikqU13DCezWgiQBulDEKa6Vvj2OFQSCmJQUCC9Pqc+0fC3nzGp6Z6Cj6wbxdZWPEMUwjePo7oBB2s42PA/OdZqbuKsEqf26KBEs8piiFd4cQ8pRunfqB/LTc8Mo732yvR1f5qGTCQq7dQLvRRehECPEFQW7nH9e7KAvg8jbdUr8oekP4hxg5qKrnS5oH/coRTyenkkeyckoWpMvBiZwVhjq4MKT588NpqR/DliaVOoo8Bubs1tGWIj3K94oCXXrlSYNrE7o3GfNt0gNXWjiLojyCFtnP8gilv4zZvAJbNHY7Whr4NGv8ytGAwgNPluuTvnA6dHX5XJK27di3ny97zKVlEy1OsSYpHhUoJX/C51pye0mik2k2QbisXGaO2GdqmA8zS81YQ/Ch7GQ4K7uIUbjO+dM32HpS2qmsgIRzcVw3TkzOnFmn1vYNE+1cSWMCrzYyKwrByn6lUimL3CXmDVXR62z1ohCGew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(33656002)(64756008)(71200400001)(9686003)(316002)(54906003)(55016002)(7416002)(4326008)(66446008)(6506007)(4270600006)(7696005)(2906002)(76116006)(478600001)(66476007)(19618925003)(91956017)(186003)(66556008)(8936002)(558084003)(52536014)(8676002)(66946007)(5660300002)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RVIbRTjxtNNLDffhViBSFH2p8DLsdg1+2SSO8gV82v5yOjWl81HDEU0U0wRv?=
 =?us-ascii?Q?2L/APik+7JuyRvtF2mjC9DIdc3kO07Q/S4/vC+VuIcp/lIcJfVQ8RqyU5IWt?=
 =?us-ascii?Q?JKYEmwGHtN+s/KJwrHB+ikn/26mQBD3fbyveeN8F6ipzpNVz6zWboMkldfic?=
 =?us-ascii?Q?BupwFPTC27jbpjWMNv1NP2gEbb2kj2qcKL/oOVtY2dkPQoFzVwOdIXZzm1/2?=
 =?us-ascii?Q?MEGkazSAsfnIWXQcSLzkF60L/aFzLR3P7j7QPYT8EiVl4R/X2clI6zl1QVoD?=
 =?us-ascii?Q?fykQFTCeryhxxh4JkeGueE8VbE3ZQcrzLE8lylqHMC4spdP8zA4SFO/XwmeI?=
 =?us-ascii?Q?pAW68i+s3NV5LFN1s1o8xuxL5LA3fxJjg8InzXpwlL/Cxcr208LsmX6OgqOZ?=
 =?us-ascii?Q?s3w9aySNV44D+QjrwXouNLe0C3+Mg0wgs2eCk5G69u4i+ff4Z79G2Fb9Y8rk?=
 =?us-ascii?Q?wiks7hTNcX1fKq3IV0UU+euZX0VkkiDgMujZZnFvBT2s7LeS7EySmYzLecHM?=
 =?us-ascii?Q?ClnJry9EE6kPL77BLab5JVPuAZ68S8xQOd6Bb+sRSPYR67Phs3D4G5eaYkvS?=
 =?us-ascii?Q?7RLIGL8CavltGb4NUOvpM+/plain0+PkaRd5mOWoo7yu4k/yGs06HP50Bi9p?=
 =?us-ascii?Q?ZJW8tgDLyOS8RQ1+jcFbQOQEfZgeOCxJSQtHB353LegUnNu7cgudhR5Gn2oX?=
 =?us-ascii?Q?fEE4WWgbV0nVhhUhPzm+uzRTLpadQpoXH+2kO9VuAdWhnr+lNyx59T1oHqlW?=
 =?us-ascii?Q?VMKGP9UaJwVl++XwHOXsHa5oeHPWDh4MiJ6ygqTETTcoWT9Na0Rw6roA7MmW?=
 =?us-ascii?Q?6CmvOdp69zaSYd4CUZhTAfaH7a4Ru3q0RbcxkHQCAqjrRFe2G27kpixlmzar?=
 =?us-ascii?Q?xPtkreK/4XZ3wbcW858dN/yVQuS0xJwNx+DaiTmBBF4PiVSUB8WBUKWSKVZe?=
 =?us-ascii?Q?83UYuJSQ2Pt1f4KvTVANYZPzQWa9eCCo0G4kQ+7JNfPFN+SVq28tWBhw6Avu?=
 =?us-ascii?Q?Sx062Xa6lgMr+NqpbL3sS/lNuSMcE17pNw6tlUpcIPbLbcsCyFgc4yafNng4?=
 =?us-ascii?Q?SmrtjrHlazXsQVcMAu8i22mTFmlGIa8maaKJHjhX8Abjfk0dAWFRVyPlSj0P?=
 =?us-ascii?Q?aPOniAHEFUE6x5WlFalBzML77GGku6zhYg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca1c4c-0d7c-426f-aef4-08d8c760abf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:55:28.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3pgpBwVx7jEczZ6MSpHfNfd99iBuCkx3t9oTaaDPEBXWl+gFtK5Z+udKveUFjlKFCZ6IOzAqk4thouQxa/8erC37NaPJmmtW9swToyMhFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4319
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
