Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13445C6FD18
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 07:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjCaH5h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCaH5d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 03:57:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F22111
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680249452; x=1711785452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lo3z1L7DUD88aEpxDdKFpEhbrmhUiNWRHcFVhXjAgjs=;
  b=TcERq476de8m/Fhk/ugnrPG66RrhVYloELkckWVxxrVRyNBSPJN90hw2
   D939/vpGTdRx8yS4T6EthyWpEUV4gb0oZx57l5XnncUya+lHAbP8YS+5L
   PoL77Kj+tRtXQr6AdpHM98Zs9nZCpnytHC61R7lw52DuMPkUtMhhvqQGV
   6gWbNqQImIZ7iAOCKDD5sp4AH+XiogAgy7wBHH2MR0VzM2LtjiDUexwje
   t6DQ//dGliz+zwWykHrAl/fulV2M4d/ul/Gs54Od0HprbbblDEwTz425N
   SCvNpxZTakR4c0V7dJ/s9n23+QkXzZbyUE4uY+GAB3lwEkxGSvoJgcKA0
   w==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673884800"; 
   d="scan'208";a="339039071"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 15:57:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHz8HfBqBJFflRgbibkG+z/kNxsA26dE4igfEWLSxqOl8l6w1Sa8LBxKr3oyZ11AZVFDzsnDBsyC/lnxmjEp5JfLSLwWidFfjqIe1mPhZ6VBJDIz88+ttPv+oi549/tRL1yHEBDHWzOxcbgYl3H2vXbZDU/GDD3mEFgDTQD3bWP9YTF6DpO2QxTItPE//vU/DxcfeIaz2qqdFYxsZ11jmalfxv8ZYARh9it92GPSseeghuPrLHRg8RheKkuqKoOQo8G4xU7BTEOdcRISJRAYIyk1TxNq2xrcBucDce/AXx4nXi5EvjT4D2Hu7zcZ/hHnj/cwm3Idy4MVxGPXMoOXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo3z1L7DUD88aEpxDdKFpEhbrmhUiNWRHcFVhXjAgjs=;
 b=nHkohRxTDcQTgUH9bgAVjfv23rbP5nwnIOUlUDUojLBS8uI2HcroDB/kcZbckgVxBYDnC2qxwRX1TGzs3Z2O4iyai8qVjKwxQRO9R8zFeQPdHHPnZLxdUdJucTX2uDXMK4WQf/cpnKviu0pY5cbKqEDNKsnnF3sBEOwB3f6Wd6l6rFsOjkyK9HshP1EZ9VUqpI9JFc4VGuQ9e5F+ERyje2922WlC+pzcrtx+GgyunvVJyrBFmi/mY2ZMNE4sf7ME9EKmFbFQGwjXIJ0bq5gsw3LU5ssXUBx5KX8XXYvsimSivs3VUnM+r2vHJSF0ya6LjXkAEZDRdCue1HpW8iylRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo3z1L7DUD88aEpxDdKFpEhbrmhUiNWRHcFVhXjAgjs=;
 b=oa+h4XQnjBoGUG3MgVKm46tQg678Qvd1GuOxG3aCaJv3SGOoZSW+iAjtPStP4wpF4Xul+SF7Gyj/klqDYNvYM2SDRocm5D96xXS+RHIkPJ0Q8j4sQTToOeMcDxPYtTAjYzSS0cekptH9be3FBA5wm+LfDacyX9VIQCvA1EkkijU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 07:57:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6254.021; Fri, 31 Mar 2023
 07:57:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Keith Busch <kbusch@meta.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Thread-Topic: [PATCH 3/3] blk-mq: directly poll requests
Thread-Index: AQHZY6Zw0hzR3mEdNESYHYQRUI+wfg==
Date:   Fri, 31 Mar 2023 07:57:29 +0000
Message-ID: <20230331075327.3hdnri5ajcg2ckx4@shindev>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com>
In-Reply-To: <20230322002350.4038048-4-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: 435ee014-c871-4521-0d72-08db31bd934e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwcM+tMPz/cOiZPmFIKuvy39XqaMFB+ctCMmv/q/J70MPRJDR5PYs9NpUlsU5k44gKt4lzgZsUMqjYkbwjHRrSftWSNoT4At+Mt0ecU50R7RvhLJqUtYPg1fYfoQA9Ve2r1Eq8lGWH2GBXvN9rjRfL4DtHjH6j3r10wA1+ZT+Jq4nnmTFqzOiHbOAwMqqyegYdo87cWVCHQdIIA3p9KjJLhyphHtys62qJs9ZdEwSsbrg8/useeIqL2hNE4A9VITH7amRkUMAhsNokWDTCQbgwXV0RN0tF/B9ali6WFqYaH2jvJj7TfwhSlAILa3LhKJeM9BXrHD0iEqCtPOKV3h0xSB42bYI3R2SDFdqu9RFYvWBOHEowuoo26wfYE5ZSHXtgWZCYoMpSefNAzNcJe40Z7ZMLcQBqnS1DM2XBN+dauLYWST7dcTdYoPpYB3XEyzZhMP/Mz/wZLMA+FQat9PBCvdea18QLJEGmMQ7fap1YxM1VrpIx/xG5ezSUZS4j982MhNBxez1Z73nfesUmuWE/3UrtZbC8jRzAcplYTZUkYTn7wZ1EU0phYyn0S9kkH019XUdgn/K5NkPNdnRghyOaWGrOKhXf6aOwJ831SWmjM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(83380400001)(82960400001)(1076003)(122000001)(6506007)(26005)(76116006)(316002)(33716001)(38070700005)(478600001)(8676002)(91956017)(66556008)(6512007)(54906003)(4326008)(66446008)(6916009)(66946007)(64756008)(66476007)(9686003)(86362001)(41300700001)(71200400001)(38100700002)(6486002)(966005)(2906002)(5660300002)(8936002)(44832011)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j3QuHk/XIJuGFz9fjX0T28sdqqzo9n895GgSm3l3XkoWVGEWRzqz81JSEXYA?=
 =?us-ascii?Q?jQHN1NOv3kIrSfTNPqrXSl1tVrQW9sPsEkGjxslO98cnjIJH8Ch891iK73fW?=
 =?us-ascii?Q?ipakjj47vMXwIebUMh9ZDJTvv0CpP3riyoqF+/F0ByIJLqFjUimmTM60YmGM?=
 =?us-ascii?Q?rc4gjSyJXSh2HoTT5sbtWGKsZN6HFIQ+yzbj+d8G3n/PpVHiwWsWUfFgQTTh?=
 =?us-ascii?Q?dSoJDglvtkgsfhinM7RK95CezF/YzxG2a4glouzshppPxqwhsh+6TRcKE+Pz?=
 =?us-ascii?Q?uFKPqzt9/PrsdITFjsH0kdBWMtrooYuoWEhT3kmubAOx0Jn0Cg9XetJr1AFK?=
 =?us-ascii?Q?lasNFfDX9Zvgdiy59XYtoF9XXpx0pqjBH2jWXbIZbdz8u8fiPJsX9bvvIf9d?=
 =?us-ascii?Q?BmDnXwA36etnG8nn5nT3s/fHdtWnFquoCV8jaBXBUB3Nuj5Mw20BNxJZVN/N?=
 =?us-ascii?Q?vdkDT+Ii0ajYt+krIocZaFKxMP4oRQj56a/4vfFfbGYnGts8Ym+H/zHlRAZh?=
 =?us-ascii?Q?qDJTDV5oNdDZ45OIY1idUfpiuDQJfWSIN6xPMv3BVHmnQ3FHrVBE6izpM9oo?=
 =?us-ascii?Q?hLKX8WDZ1eRBRnt3BRC75wIJfyZKHFl8l+pAudpLSvFt5ZLJahsOn5vHtMpY?=
 =?us-ascii?Q?QgudV61hTp1EEpukjjOq3wdo/CBEI7CKKNJYB0Wtu2NgO56+1TXxfgZxTHi4?=
 =?us-ascii?Q?EKK5KpanbCPoq+ekm1HOxqhT9eXTFK3zI1AtEyt4ShvDQ4PhYfldin7FVyJb?=
 =?us-ascii?Q?Yw9QfXFqDX8mjQfLd61kcCf19V74M/2HFrLYH2xHObinvtx8oaw4gdhcqxhg?=
 =?us-ascii?Q?fZ+E4veFTunBI2q+NBQ7WETU6My4L2T1ZEfF88ETIxQo9VU/yXnoPJPV44eV?=
 =?us-ascii?Q?IMyIMwdvyPW7iCpAeiGFfjh/Yc6MPVsB+uW87pGS7U94F4/PKLWkZiQwbXvL?=
 =?us-ascii?Q?8kX2eJl3x4Uw7ScGl5JmwS7P6jALSuv49Dq0CAvtcoNBaDxwCMwJhaXq0bCR?=
 =?us-ascii?Q?clCJPQbHBOSXwYxvwIxVLEfq69wY1QBOPKBMKjY5IA7y2t4+yhsM2fEdmu88?=
 =?us-ascii?Q?qqbVgRrSIM+N/AMlzUZ7vOs8ST4l80pqmXFUIr2pwpQUIkt7BqR9BxxrejaQ?=
 =?us-ascii?Q?aMtxkuwkYhVDl3GxqabFCP31o8JMaNKTwQmoggeDvdc7/XHkjdb/38vfdZe6?=
 =?us-ascii?Q?4uTFc0e5y7jKNDvOdIITjM1PKcmkDJ2cXblcwg6Xu1WgVNSI9RQAE5GDXyGb?=
 =?us-ascii?Q?8J2yMFfoPlMvZCpxcVj9h/Ngwhs5TdM+HEfn2AMl66wwnwu8DM5akjHmUZRa?=
 =?us-ascii?Q?V9YypAFxB+KxvK8IFOyVvpG6tRwRJixXdfGhmMIZs7FwSJNc6AgFrPYLlPZi?=
 =?us-ascii?Q?tb81ySlb5hhpkdmgTXJCmTFjocS3wDEtPttSXXVW2YNqWDZn2/J2KQFsLrZF?=
 =?us-ascii?Q?kqrRAG6nsr2ipBMSecbE8B7s/JXyFJ+tl2X/lZ2evQiED3MeFGPiWFWFlAta?=
 =?us-ascii?Q?ISSIA5Wgx3OEjZDOOajCYhvrEz+KQY20OGOkeMtrKPIsl+9sKzpUnvAPJp7k?=
 =?us-ascii?Q?YcIWjjsDW8gbRYhEKgYmBxidpOgLFkovdQMEZd+bak4YLFGreb5DypwNHqLD?=
 =?us-ascii?Q?BUOGj5qphTLJavB06xmAJw4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E823D6D129F9954499CC7AFB07F08940@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4BiBjR+h4GJPr6s4kiSXp1oqSTWPkwBD7Xx2JfRW8zAyoI8H69RSwvnGuj8V?=
 =?us-ascii?Q?z9WbQjaVvyEZtst1MV0f4O+/jg4XszPDbvDSrlBEX5j8qChxfN80CQAnbmYZ?=
 =?us-ascii?Q?3ZjpgTrY7H05VLjEqSAl8ICwJUUMlUaQjDuTfWpZrOstqpeHpfPxRE9pmwdo?=
 =?us-ascii?Q?EyjIfne179Aauz6+dIA8669pxn1n15BlHKVdATD8SYN98Dc2Vm1xWp2iV82p?=
 =?us-ascii?Q?V5/TIZNus7XUcPGc+K6DBOsmHZaIK+82RiVABM6mDOCJd7xeyg9sjodqc7lu?=
 =?us-ascii?Q?H+nV/pS1t0Wmrxd5ESYKXCLJX/3lchIvtQwHE+wxbFvsKMk/1zeD7GyYWK8W?=
 =?us-ascii?Q?Dr1h2nZ5aaSSjShb/LtMHKrFBrwDsAvMhWMJfsvhlOJsXygsgNrYcdJAfGk4?=
 =?us-ascii?Q?w+Qtacj5GrqriEEgP4Qb74Mx2yWSR2L0fNNDtm+2/1XAjeA95SFkz20H9TkD?=
 =?us-ascii?Q?8rLYyni05TrJuHm7ZbF6Crlcojknupr6un8AfWFRr1bDtOFoxmv79H+s8sj3?=
 =?us-ascii?Q?FE7kOkCRRAJAlO+ZyNB9Oco+rVdXbKGh43b49CfaCQa0W/Xe1S3Zh4CQqcHl?=
 =?us-ascii?Q?dEaL3OQCnMeJCpq4fFGYIYQuXwjNI5yFiEl0H8UzFIodFfF7lOhOcnW2ssqa?=
 =?us-ascii?Q?YwGQ/DaHYsTGJLKduBW6QGkpMPyyhsJzjVO8WbUID5WBT99us5YsiXYKbQ3g?=
 =?us-ascii?Q?dQZCo+2nCc+oNWlsIiLtC8QDgxdtUWPt+Dg0dV+EWlJDeBPc5mxzWPHdLDT5?=
 =?us-ascii?Q?sYKpgE4roz9v2gxjfPPnqRZcUSC37aimdTj3sXpHVVR75URBWza5jay1vc8O?=
 =?us-ascii?Q?Idz6duiybnLcltoC7W1lkvDoPgOExjGiEdfdh5D2ayc50craf2BwggIymUma?=
 =?us-ascii?Q?t0/mt82qLR4n6WNEEFhGPaiElO9CFeoCtr+y1m0/kJa4r0SnCcPy8w/2/wIm?=
 =?us-ascii?Q?BCiZ7abRyNgGBm3aT3clGUESSbuDbZU2IK5GLe0emhPVrkN5OGfvM6rzK4Zr?=
 =?us-ascii?Q?2Sg5?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435ee014-c871-4521-0d72-08db31bd934e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 07:57:29.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nA6sDrU5falvnGBnAwcJG8m/NACNzfTYEE7mzXV8/yIkI4l779V7VSLyP5F9thE/+8eReQEt2WAq6iWJrv+jZPD+bsyIuneyc5u3Z/k4jdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 21, 2023 / 17:23, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> Polling needs a bio with a valid bi_bdev, but neither of those are
> guaranteed for polled driver requests. Make request based polling use
> directly use blk-mq's polling function.
>=20
> When executing a request from a polled hctx, we know the request's
> cookie, and that it's from a live multi-queue that supports polling, so
> we can safely skip everything that bio_poll provides.
>=20
> Link: http://lists.infradead.org/pipermail/linux-nvme/2023-March/038340.h=
tml
> Reported-by: Martin Belanger <Martin.Belanger@dell.com>
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I also tested this patch with rdma and tcp transports using the blktests pa=
tches
by Daniel [1]. It fixes the failure, and I did not observe test hangs. Good=
.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I suggest to add the "Cc: stable@kernel.org" tag also. Without this fix pat=
ch,
the new blktests test case causes test process hang or test system hang on
stable kernel versions 6.1.0 and 6.2.0. I confirmed the fix patch avoids th=
e
hangs on those stable kernel versions (This patch can not be applied the ke=
rnel
to v5.15.105 due to conflicts).

[1] https://lore.kernel.org/linux-block/20230329090202.8351-1-dwagner@suse.=
de/

--=20
Shin'ichiro Kawasaki=
