Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6EEC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6CF6100B
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhF3UQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:16:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19068 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhF3UQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 16:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625084014; x=1656620014;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6YIqcGpwsEAJEtrhX+Sz2FZ2mqgiot1pwumZs8PkpX8=;
  b=SdOG0+WkmGAdw2MHLwjLeO/GcQRbo3lgV6YA4P76FKsSbc1D7zFF06oa
   Nzh/OCjZnRw5jwAfcT9VFy9Z42EEb6Uy6QxD6SJuoVau39mpTL86a2rjZ
   JgUi0GZdnxBbQ48VUnzlJ0TNaahSeN++NN4XkF0dlAxWsl14e0Nuxy1Rl
   9i6dGOqYvs6+tcS1YFDJGkePRySuCVb82qBNzHuGUJChv0AE7/AJhvEa2
   klAt6IRWl8M4SMyiA/UJM5JFHBPVxRHHsar5fA+NPPL60etiPjZKZY9wz
   IxnTRO1Gv5EvhGGCckLq3hWXARN0n+wWFCaw9fM8Rj7iRjmPTxivf+q+z
   w==;
IronPort-SDR: wB9LRTXIOLoCfWA3RO/euWoxpvQ/sot/lRb3xZnb73pixJk/lVbOTTvbBV3/Re/SmvIgOPMlh9
 n5DHznPv0JtbWZTicxsfStjxn2WI5E0riWg9q5FzijWhC3dLyTWU1QTczbbhC6W7+mYfvR8vLv
 U8aV0VzX7I/xRsWCFJQR23BD7TkbmbcEP1VKFVcvC9+OKGDX/dqJTIuF+mfrhPomREc+xetsNp
 mTLt4U1cV7A+91InAFeRo/JYjciuVZ0sojIOiIY7x6+Nc92zygX+/pEtLvZG1IXtYMc51ZiseB
 qRw=
X-IronPort-AV: E=Sophos;i="5.83,312,1616428800"; 
   d="scan'208";a="173369581"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 04:13:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT0gwqouLDYVUE3K94jBQtTJ/+6u6eHgISlkEb3zjPmuTJmfRIc+o7pjL2asYOAKNADCQ9jrWRKrtSBjXOIwCbkMvQ2alwkH2OD0biOECTNnfnkKQVt/CXpHTvtWl5zpI+s1rzTX4R9dl/wOd0B4X1vQUz6pyEcETVB89ikdxndpDgMxwwplmMhhw5Lc5Y+SxBbDMCCPlNx/HKU5JkLmUd8ijnsaIV7xXXUfzsZ+Abr5MalFzxZS+8REkw+6ZcUv4uiYxz+uOn6/coyy+r78ceAZWhVDvZm/77SL5rU8BjYN9RNHWrDT2ssQiftY2Dxso5BOCANQ/5EIbEKfwAwT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhgAbhL+bTyEN+0UPUo8bYRDy3Hr9n3cFbB5U/Gye0g=;
 b=gMKjytopFD0F1wcVvl33X3wMC1B8fqmRkAvHXX80IfzhIgx6YWTVLPTYr5bPeWpDqeB8jsLYZrLNExldnZ3DbaEEhhSU8XMRwLg/y6CGzjhqc7G/pDiAY8CE0tsDzKKHktZoY1mOuj509pvD6WgNpQUFADzgkq8MRHRdZaffqu8pTsdBUOHPjOzzyErZQtOLYFhnp6a5fErfvoa/uyh9P7ebM1k27BH+C0u0UfHJX8uNUJCRN2M0dMofV5p7riq43nbjuKPHX16Tua07C2rMkl5EarMzk271+RYmHvky0EGL5/t6Ze7JlLF56VrqVTv7APfVI4SXoSRi8iYiGrgA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhgAbhL+bTyEN+0UPUo8bYRDy3Hr9n3cFbB5U/Gye0g=;
 b=NR1OXAAApdoqnIHCG5JZ0uupJb+pfVFnsTYY/eGuklJ7moasgXd/M1Lsrh4yf4XA9z3iE21QNAuviu8/KEZa4fhEX7zaw83YCij8H/e5jqmZEJqRb/Fk+l7t/FiR5Oz46euoKdrjnI2hZfj+nZzOZxnRcvXx/9oByyR92nhvUrc=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB4585.namprd04.prod.outlook.com (2603:10b6:5:26::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Wed, 30 Jun 2021 20:13:32 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::41ef:9563:8bba:fdf]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::41ef:9563:8bba:fdf%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 20:13:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block driver updates for 5.14-rc1
Thread-Topic: [GIT PULL] Block driver updates for 5.14-rc1
Thread-Index: AQHXbSDCOg4NVKlsXkesSIz9BSKp5A==
Date:   Wed, 30 Jun 2021 20:13:32 +0000
Message-ID: <DM6PR04MB4972FE9C2C53DB0A2D76057B86019@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
 <CAHk-=wg6axLJQuFQBNa+nMHkEdx4X75LF7_P=eC=rzKj0x2h2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a929e37b-8d68-417c-845c-08d93c0388a0
x-ms-traffictypediagnostic: DM6PR04MB4585:
x-microsoft-antispam-prvs: <DM6PR04MB4585177594EBE2C1CFD611FB86019@DM6PR04MB4585.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJrzRN99cwTg5E+UfXtXvKgIVBb6zKnboKXW3f955Yd3s+KSRPgvBgKq9hS+81zDmR1PwHGsi1IE3ZbRCMyJlvn6FrRO2mlQGMWx/DdA6e0wINfvpInKo5if1/FL/bY+FUHyqnexQhzgM7jKsBLKYW5t6Ma0vrJ9tACssyVgzpkeiao213UZ1nir1IbSxAXa7lHBCdx1V10J+DW5873hqJugMgClUHLca+IjrWe7TKdoQ+knyMSNxYEfy0obo6Cz1wvYlsXppv5IveX4l/JukHDG4rodyCm9J3/5R6SSV6xk9bo0Wlnu19mpslZEtwHBjLc48/FfxtORVPEumsyP4y+dYahwHqeuRmmQn8VTDJd/KFLjaDHM38CABeltiIknRtN+v9ebn0WdKbiAzDedO3hYzkfQU9O0CGQmFWTMGHTucAPtpXngxRfkgohbNv3etRNlVA4hwKR+4nOE2GlfuQY5lgNWuD1ZincafWWWy/bZkl4u/Ltd+nCN3NvYCClA6FUBLpyfj1DDh/lgLJRaPDRireTIwD+riqmf/PtiZsJZOQmw6emvrNwY+Ij6SwF1xGsiftNWop4yS9oX/eHzrzpKWNyL9YqYEx3g36aCKqd/XdyOyrmovHrBJVvkt2uh9BPUfG/57PXVTlCXaxVrQRPrwmxKKTfY+LJXaGO0cu4f1PkePmhxYhEXzDZoLE0kielEvoCzmDTpNcJzB6YGKXegaJ8Q045Q1Pv2Xy84VqH+dxgiMpbfgbycihGysqb9vhwnM2uNNJyPRc/i3NhPhgiShGIBMPb428wUsBT0RgEdkd1YtQ2f5h/8mNKKDmJ8LClk8s3bX3q/pLxGrGFVHlCNP6dSNCq9u7eEeyW0Pic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(52536014)(9686003)(316002)(5660300002)(55016002)(4326008)(110136005)(71200400001)(478600001)(66946007)(66446008)(66556008)(966005)(91956017)(76116006)(64756008)(66476007)(6506007)(53546011)(38100700002)(122000001)(7696005)(2906002)(86362001)(8676002)(15650500001)(8936002)(33656002)(26005)(83380400001)(186003)(533714002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ju3sAX04kOxjWU/9sOgZd5KJy1HNjY2bbQVpSVAlDqvqIXMrHwcbjzIRUTgT?=
 =?us-ascii?Q?OYrLJTZfIVFRk4DHAbTa99aDzDgKka1wr8fNGDcJPZ4hUq/ElHURZFctTtV6?=
 =?us-ascii?Q?kWA7KVeL1uC9QU3tY+47bw/jQ+a7/hEMt+MhxxzVzPR/Ac/na3CAkIz+MelT?=
 =?us-ascii?Q?NUHuQk8n7MZH3k6ibIftPTlgYXpV2by5h8uPkpMSws00Awocw5j4uWfZC0Fh?=
 =?us-ascii?Q?K6jmjLk0inuR0VdD9pTkRz2Ua7r+v9qpaZrqhPXEPVpYv6RnT71QDWXAHA7c?=
 =?us-ascii?Q?JC5bO+2UfpJRU1LXnCue9+ZMiHxsHb+nfkYkr5d4GXxMTjiPC0U8f2hlGd1r?=
 =?us-ascii?Q?3jl/cHQtHsBfocRcSmMI9H8VNMcpu/BNjaq08M658ZCZztbUBuOa8W6LLeO5?=
 =?us-ascii?Q?pgV1FRkftgoLwUO4I0g4BFt5AkA8xSwxpV285JfpHoaoSIW/4q3BSkioRfeJ?=
 =?us-ascii?Q?97+NlY9poh35bGKPMLSgU3vC0a+wWRmlTe1Bp4iO846tf1nvh1JqigqQpE0U?=
 =?us-ascii?Q?XHe49BEGyXoQeEbTckw8eaGBex9WSlZxCKlwIgkxcTEriNraTaPIU1d3iQP/?=
 =?us-ascii?Q?rOqEy0uu067UPY6+xU7mRWUVGlsr8Pvc9fa63u9aK8hSQN7JeL4YW3nCu3F9?=
 =?us-ascii?Q?FlmqTBSLTf5rYKz08TSUVlA57YP908qTLFsOU9HkqPRKioB270UkmHR0vlMv?=
 =?us-ascii?Q?m6WMzQH8+pB0joicFCVk1PyeQmiTGzaR7Hb3CoS8mu1D6PnnWqU2zGz7Bykk?=
 =?us-ascii?Q?eDvdmDsU5InceuzFS7rJ0lTYspm+KaP8cK7Bhws3dxoCMlN+JDWtLE224KxF?=
 =?us-ascii?Q?+28Fv3lm2wkjhwKJgb2uUf6Th1+AxRJ93cGQEoxRTZEQkG8bG6QRzrjGq+Vk?=
 =?us-ascii?Q?bAVsZ1XaYvYTl2HSOiP5uVOI2tzQwAUA2hq+BtyEY6AXMY+7I5nn5u/zj0ij?=
 =?us-ascii?Q?NPcF7mtFQxJ4Vv0yxWYgewybnckJLN4k4EHdO61dt5qlFw/bLGUX5aymD1V7?=
 =?us-ascii?Q?sYDU/E02F/S71kfZJ3pV0yo8cOUfeCQSnX28wTb/w5djNlAfAqXf49CbfxEM?=
 =?us-ascii?Q?JiSggBqHl1a5vaMGzvJnMd5F+F7UQ3kTnk+fplj9eLRKbUkg2Tp6eEXIx2Bp?=
 =?us-ascii?Q?yyBzlF/ajXI74M2OGfnTAVT7BMAdT2EI68meq3yggITx88n8MnHrCYo/WCMJ?=
 =?us-ascii?Q?sfZF6/gy8/DeFNSr8+DbTlV+bMKWtk27MkIBYjU2UE9LXtWo1ebQ344yi6Z5?=
 =?us-ascii?Q?gRRzW9tyVGLWDNJOMROK/no9rYoCXIEAGZikq75ClhMmMhW/3vi9YiaW7gbW?=
 =?us-ascii?Q?KAe0qk6Td4tgf6neRlVqWSae?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a929e37b-8d68-417c-845c-08d93c0388a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 20:13:32.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPFP5xEq5Ydt1Oeld5iBoI6CYYk4XyAKkgRLsYRtzgFrYOX9XF4/7z02gF1HmSZ0jV06WLPnVK1NI+L/ELba3ziHBZEbETCjXDxnVafZDvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4585
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/21 12:29, Linus Torvalds wrote:=0A=
> On Tue, Jun 29, 2021 at 12:55 PM Jens Axboe <axboe@kernel.dk> wrote:=0A=
>> Note that this will throw a trivial merge conflict in=0A=
>> drivers/nvme/host/fabrics.c due to the NVME_SC_HOST_PATH_ERROR addition.=
=0A=
> Grr.=0A=
>=0A=
> I don't mind the conflict. It's trivial, as you say.=0A=
>=0A=
> I *do* mind what the conflict unearthed: commit 63d20f54a3d0=0A=
> ("nvme-fabrics: remove extra new lines in the switch").=0A=
>=0A=
> That commit claims to remove new-lines. In fact, the full commit=0A=
> message explicitly says "No functionality change in this patch".=0A=
>=0A=
> Except what it does is not just non-functional whitespace cleanup. No,=0A=
> it adds that=0A=
>=0A=
>         case NVME_SC_HOST_PATH_ERROR:=0A=
>=0A=
> thing that was added in mainline too by commit 4d9442bf263a=0A=
> ("nvme-fabrics: decode host pathing error for connect").=0A=
>=0A=
> THAT is not ok. Commit messages that explicitly say one thing, and=0A=
> then do something completely different are very bad.=0A=
>=0A=
>                  Linus=0A=
=0A=
Indeed it can be misleading based on [1] 63d20f54a3d0and [2]4d9442bf263a.=
=0A=
=0A=
Please let me know how I can help to fix this.=0A=
=0A=
=0A=
[1] http://lists.infradead.org/pipermail/linux-nvme/2021-May/025449.html=0A=
[2] http://lists.infradead.org/pipermail/linux-nvme/2021-May/025407.html=0A=
