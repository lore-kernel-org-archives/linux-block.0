Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A2EC433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8E66109D
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhDOXs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:48:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36742 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhDOXs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618530484; x=1650066484;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QK0XeYrxiMiSinri4syoe3hm2Am4tQIP2u4dZP65aUE=;
  b=eI954MmXgEltQHn+en65K1hjUDvUTzICDkiSKrlxTfwPRpvTf1FqD7ek
   PJoPCi2tEWapAjycRCPtC9d568pjroaXTJbSEp1IlB4OUSLfAQQeYUgBP
   zRg1vJkX8RZ5P0ksWrM07jhfYkLMAznps3bi6qsXxUrQII3la61AmDGOs
   tn2WS6n3swDmDM51OPjdEDwrKcJr6oqTMn8uR3H5Ob933T8FwODeBWTON
   qzOgMxlUentACNk+YuKMCgUGvHWubgxcHjDu1+wf0AtwN6GGA6ENYZ/AN
   QqJZT+3ahAj/RXCnSpX7C8uFzPL5BZnkj3ni2f+gE/gmZ8vzu3wTOhFWg
   w==;
IronPort-SDR: vwnR6rezXMXlLArA86Q2Th1XA1FIiw/U3SEz4+S0+rec/NyTiRcGq5TZDCKU9IXQPE4GYoulSk
 saAa+GcTlQ13g9MtcZfXUMRwAZX9D1igetBnNbslRRd3/qEA9Up5Jf8Uvd9KqSrCRjfn34u2Lj
 HkfytgVdSirVjEFCmQjetNUcygXAI/AzBG96dhA0PTY+SM+b3NCUvmamHde59YfyHF0/Qj6ntv
 DXxA5vJ9nEGcMF9fx3uNuVE0Yok/ZBuyAq+JhFtcuPRLFK2Pp4rprnco3WaXZg8WYTVB1/WltR
 Olw=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="164988423"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 07:48:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1CApp3fjNK1fi6tP1ueaxyyZSjIDmxU7fmf7mvvhmQL+m6MGYlok9A9C3mDTF0zOCDlZo4UYAY2K9s1PUuYqJxQBHo5bRfeJyWKj67qBvjJc+dEWdVH9CkWnL8mStQTN72OP44qC3rf3nnd+jG5Lfe+DeGfihr78VXruydwGYd4z8FssHyW+VzMIvNWHuigP6AIq/M5YCvX6D8Fhxg774MjAlo6YEtgMqtC4GOMQWYj5IH0OLYFSfugpA5MNw8X2Lp1jDcWwa1qQ+Bzv59jeAlgIsh5WThsf9VGt8bdZviLKQ4VF+FBcmw45/P8HmLIonwaqu6itIPhFhOQW4ID8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK0XeYrxiMiSinri4syoe3hm2Am4tQIP2u4dZP65aUE=;
 b=l9aHg8/Of2lVYIhloHMfi282Xerh4h4vpFu/ncDekg2/rn+11J2dHaYEm54XOL0qmFbxwnrtbYUNdfpvAg0mGu9bxi7G0O2TtrKbB930ZhZRVHboVcequ0RY/eK25VMgo/wqw9erCz6JOD+/kQhM3HNkzgsrDeTcyrKCTxctnPjCgMbqAFk3+6B0bHiwCjTau5ol2tVWJPvoX5Ide/E5puUK7l2vzoyEZdHsHPne6oJfnWfkoTSklPjtGlnJu/KXm+J4kyTp9KMRfFpxx8TPYWTSzQLq9hEGfTVprp0Bkc5z8taiNlDgRpvhND/pJk7cxj7MB5weRM44/ZPrIq3cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK0XeYrxiMiSinri4syoe3hm2Am4tQIP2u4dZP65aUE=;
 b=rU1r5JC1UnqxATQUMb+R/JkauVQCecdIDz6yUaHL2+U1lnb7x6Am62DovSvduZnQtKmESiR7odCCBKE8L8441ofPU2kXXILGptFC5Z2g/7ovJy4WEABzpcEHMjrY4ZiuymzbqeUA8F5hi5xUc+yczRi7f56UUqZjnC92xMONiCM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4232.namprd04.prod.outlook.com (2603:10b6:a02:fd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 23:48:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.023; Thu, 15 Apr 2021
 23:48:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit
 is set
Thread-Topic: [PATCH v2 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit
 is set
Thread-Index: AQHXMk7X6k16GPe6nE2qzRxrTa/DAw==
Date:   Thu, 15 Apr 2021 23:48:01 +0000
Message-ID: <BYAPR04MB496537773A662383CF1B7BEE864D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-2-snitzer@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8d3a3c3-a8a4-4803-7b59-08d90068e819
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-microsoft-antispam-prvs: <BYAPR04MB4232A70A9C23ABDE9AFB4169864D9@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lwtrp4qj2Y96mDzU7j1bdcxxWdvXWgsXYAPcfBm3Gff+4NHjxwTRn+/EwtShzLx76j3krtGlBPwNO8TWgGY2Q3pgn5RhRuIaU/ZMRPiz9z9qr0sKrXli5YzqC5l+zavXy43/wNfGQJgXP5lQP8EezILQvWmTNT/rC8t0ckLeawm3chlTOiq2RVvIY5tvPR8JgZa5L+AGz6mOSdcQzM4B10nbYxhnAvPWhT8A1UCzI5vnZcVGjkwTPu4JNvQtxLRiwcQqiDd1q1TAalxgXNqHkk4yqt92Qv+aQXNisO5IaxtTTlg9KFPHke47p5LNei4DwnKbiZ8VbY6MW5jMzSNgLY1S9FScP31SHqN9C5l3SFeq/Vt9TBNbu3dBuBPw33Gwc24CKF/C7lyLYWB11WgAURUaizkfU6HOCGaIOhl3hREa3seiydMmUpKquZ7OYw+1LvtCf/ASnqGjrNYAuJiHerl86oJ3/gav/f7VnmdmorzH5GOno9VEP59Vo4aeb4O2e/lmIRlyxAA3vL6YfI97jFUBQr20Oq86QoFgguoEHpzxFdTSrtkrnswM5w3s3jqewmaUXN9EFjWhqtVmMHwso55qAonxrVOdQE6etZ77OTE1W/mYpa3V0nZFGSySGbM/XGJxPCI38SXNetsUABnjO3UPDD7DTalxR3JSHvsRjsIwpu0NgN6DGx/N9TBqsCkE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(9686003)(26005)(76116006)(86362001)(66946007)(53546011)(55016002)(110136005)(122000001)(186003)(478600001)(5660300002)(54906003)(64756008)(4326008)(52536014)(66476007)(4744005)(66446008)(66556008)(7696005)(316002)(8676002)(71200400001)(8936002)(966005)(38100700002)(83380400001)(2906002)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?shNcMjpazFA3jqj1+XxoU2E1Bg15+afozS+Vmyhffq0WRLiIDbiuteGl0N3A?=
 =?us-ascii?Q?jB0wBw0NkSj5YbyzPsiYKsgyUkOf8hF4lc+iGehgR834IzlxR/58s/VphWx0?=
 =?us-ascii?Q?TELq686OXTJxHGcffcEHJMjyVE2HSNezDVeynByZDVqzDSO4v0KJLlmvojNl?=
 =?us-ascii?Q?ssAG/yTPa7yPw5bINykCyN4KdJDx9ge8bFwvlzjA0e0C/bDnwwsG0Br/5Zul?=
 =?us-ascii?Q?3ELezF/pMMOeBsME6/mSAGAJgZlKzZdEdJF7FD4x+FsNUYSyuxA6I9svRCTC?=
 =?us-ascii?Q?NLpVv2jx6xoe+B0SJEBLCUA+MYJCU/RFfC6kciXFZuSZs1I3VV+2fBmyTUks?=
 =?us-ascii?Q?WMujKrzw9y3hOWgWqdLMPyTHeXJsF1G9KacoexovDujb44U4Hq5Bmw8ViSM2?=
 =?us-ascii?Q?tPdUTE12YOAoemYhMMo1FLgVhAB77r4nprerNERiCm5lbGC1ZTu0PrSGVTRJ?=
 =?us-ascii?Q?x8vOnVMEs60RTNYhlQ4Xi9var4fYjlzK1RKeQKkEem6NWajwuHHgujZd3teF?=
 =?us-ascii?Q?lE2lBLxttYhKhBbYGJXSQwmXJNT8YrBSwYYjaP9GB+tFCAJXJSHDnwf5nTDB?=
 =?us-ascii?Q?atE0L/XMPGFUmRQxPyFRmbcKCahfB4TSCDeGaEVFvHDEKumnai1pmahFfyvo?=
 =?us-ascii?Q?OJKAXLoN5yKJOWEWA9VNdpBbO9eoRpPFCSWYOtUx3OigXNgAJdUGKOxYN6eD?=
 =?us-ascii?Q?aEzpJzCxot4l/V6QbX+6By3dAuMC4CtCM+JhG6LCKS6R0ujiN6B2KSB+rgap?=
 =?us-ascii?Q?1BYq8dWEVJScu+OHDkx7TSsC+bYy6hBdLh9zg5AiyltE0U9zQvU8Spsolanw?=
 =?us-ascii?Q?S02OdKmkPiJyFUsmn1pug+CLEM4rCAxfow0gM5KWmpECrWX8gSHXGNs7kLSj?=
 =?us-ascii?Q?0+yTixXD6h7e51NPjhq70yhx6SRyo8meUnzAN253+CxBx1MGm5vCD2LQVYlf?=
 =?us-ascii?Q?lQ2a4a3/h0M40GtLFxHIq0llAL57NFB5CzPxaBM/Pf+dBtX7bMdLpUYVCTqW?=
 =?us-ascii?Q?ZLgyx/aT8xio68A0AfUWar8bLr2tvL4vxhPCamg2awJZ2TLa4DsjZvQYJgSi?=
 =?us-ascii?Q?P7ky0AgQuQ5n0hql1CnfoAQH4HfZZINoWj1usXI8v5mHBRlpUIm0V8hTDHqj?=
 =?us-ascii?Q?Un8nuU6B3FUEWis796sHUGY428DSQFf6F8hHxftsd2QvK9EXRWXLljpCDAH6?=
 =?us-ascii?Q?bopw5S1cYNHy0GXTZQwWfNy5DVOTzPvpMzoMeQhUY3KaDVft3uPXkh+14jDF?=
 =?us-ascii?Q?ro15IMnH+pStKvIpT0scu+uo6ZrXf/7CfPCvOC4Mwkh0F+ZLlWkOsdCNyrf6?=
 =?us-ascii?Q?RcvStvtI6Cx3bSp5mthiwBOk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d3a3c3-a8a4-4803-7b59-08d90068e819
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 23:48:01.8269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R41h1+4oHoTdDS8bRi6iZw8FRvzqIx+1gttR2H99J9O2vRTvbcY3j+sNS0KnaAjsR2XCy9vmoOS0SMB2a88oXOk3rhyXe8dxttziVuV7OaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/21 16:27, Mike Snitzer wrote:=0A=
> If the DNR bit is set we should not retry the command.=0A=
>=0A=
> We care about the retryable vs not retryable distinction at the block=0A=
> layer so propagate the equivalent of the DNR bit by introducing=0A=
> BLK_STS_DO_NOT_RETRY. Update blk_path_error() to _not_ retry if it=0A=
> is set.=0A=
>=0A=
> This change runs with the suggestion made here:=0A=
> https://lore.kernel.org/linux-nvme/20190813170144.GA10269@lst.de/=0A=
>=0A=
> Suggested-by: Christoph Hellwig <hch@lst.de>=0A=
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
