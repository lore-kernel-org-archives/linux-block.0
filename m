Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB84C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7667664E7A
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhBXUeL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:34:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26815 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBXUeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 15:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614198849; x=1645734849;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L6BTMgfo8xixC9Yy7xn4DxkGVxv3sXt/524buTy5B4I=;
  b=nAQu+HZJtDkj+QoIhUjzdnA9J4u/ZC5viUYOoL2IwQO90+qunATbK2oa
   ldHcaPVykA3JakTArC4tLUhzAUQnDEouBb6tIpclkeXNTT3MwFao1bKbT
   H9EJaNohxkZWRvMDm6vodrz7uKbjSIyCtTBc7/DEOH6jODSuYodViTLkC
   JKLHkazlLkt3L6fpBa0zmbpVCmPJJyFoRIqb7jE6A/6mPT88iCDVxp96l
   eZbYrnq6QRhlwOOi7dU0xGtU6KzxXs3UqGpk3yeAvgEqRcHn0NCqV6Ehr
   7x+7o0N3hq0YNuNjC6wMovJQgPAF6BfJkPL34f81nX+DK75s6WdSWZePR
   Q==;
IronPort-SDR: BNXqfYbsifUV5/6mCPvjd5dH/OCEPT/12jOkaNjFnqVrJjWy94BAOSEq29w/HPtKlD99uTJ8jB
 rGjqwMDrgHWRUfqnju4Ww6Cao06rx51M+fpcnqKTk9s1BFBS0Ei3L8mwxaRdDxVGZRAy6fSMVn
 nMzNY2mvqiOavxievQBd3cv8Qubl58GTVKH+bsplEiAiNpNazPTLS9CIbEvtAW9e5sumEk2X9A
 zghnyspO6MkAGVbCXMqdGjGueSU3MGq5X3BnL89MUK/h2Mh5q4oCFkJ+wltnP4ue5qmA9xGcL0
 Duk=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; 
   d="scan'208";a="271277772"
Received: from mail-sn1nam02lp2055.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.55])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 04:33:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqFZ+PMAZWUTGV+V2EydY3ju2ms15mFwUSEnjSwHUFG1H4+n4+98wvUHlJG0XSEOsNzioperTgbPuz2bJRceJXh5FZmVQBZ2ihcDUpqL4a06bdJ4tB3QsK7mr4hNHoQyyZ2ZjTQSzTYOFdHy9AWrHx16Iv9PeEIQKg5R/2yZINbKnaiugx/pkzMBmnEfDUciHFADCFTH5DTTX6xgdkFmSlwJtM5HIW12p8g42J+3ookMjW+LNzokYbJckx9pWtTtcRG/E9cILNqyalydMEEW2gmxyrJ58EaSL5fXQIfDW0kEwQUm2GD6+dtl4ldkUZvJKEnP+Q2/Jl1tuFZINf72WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhYPoedbY22dDH2iuxM9NeUV9rTL5y6BHZncX/fBXFQ=;
 b=K8Wi4L4oeHAtt4NWobcP90eHwzL7FJqhQ1OGkMUx3sphezOK5II7yvH2z4BFj/XNmj4qQB3Eq4J2M0zHt00Y3yOwisFPhV4j/lhZp+glFbkHThADme67hSQAF4CU95RttH02XR5qVOd90/NQyyUqtlbI043/OVgn3huM1z5r/iI0y4fOgkM883ldW2fBwbL3mL5sijEDJdtJxGFhOXYAe36S52ES1Y9yzZzlzpUPWHTTCQ0wuvsc82ZvGYwpRwjtffK+6rVaP++iNlLcVj7IVLr+Wkeryt5x1sgSB9XSHDQ1UlBp6YCZ79X6vcfOyj1pw3lOf2L1YvEGwIo/nj3qNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhYPoedbY22dDH2iuxM9NeUV9rTL5y6BHZncX/fBXFQ=;
 b=izKUYbJ7WHiGLWezatwu+G3g1kMCEYOPfvsdUVHN9MB0VEjXqTp+JyRTfNpMwQTKXruITV/y1tI9hp39a63Y2VCuWRpauxaLFIJjHqenN8civ1ExcapxK5TdMd1lkDjXI4dDIXEHrlXGmHIn1htCXvljxZDoIkwayA5Hj/zhJE4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7632.namprd04.prod.outlook.com (2603:10b6:a03:32d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 20:32:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 20:32:59 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        John Stultz <john.stultz@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/4] block: memory allocations in bounce_clone_bio must
 not fail
Thread-Topic: [PATCH 4/4] block: memory allocations in bounce_clone_bio must
 not fail
Thread-Index: AQHXCn7XVa9Hi+GuI0SrhWd9mtudHw==
Date:   Wed, 24 Feb 2021 20:32:59 +0000
Message-ID: <BYAPR04MB4965717FB9F5EE97FF20A475869F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210224072407.46363-1-hch@lst.de>
 <20210224072407.46363-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37c21ceb-993f-4735-c55f-08d8d9036050
x-ms-traffictypediagnostic: SJ0PR04MB7632:
x-microsoft-antispam-prvs: <SJ0PR04MB763284A59BBFADC94FC818B4869F9@SJ0PR04MB7632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCVbezUwQVlRFw3Ay83rAOPwegQG+/hDG8aub+GFKQ/85y6RhAHEm7TrT6jrgBRnlqJGp/w9S7RJzblC3EoScqZVjyxsKDGJKgcRFlIw+hr9JI84QampcyT7mIWj6gWlvlC+J+gVLBxs8CjeLWoIrHZC4h7/JsQCllKwgG+wndJ5vYmXyVNgcN2ZNy0S64fwg+weSQCwHQf51nqLiHDvjvLbbkYvq9FsWoiFotpsoAOG32jWq68dUtJlm3WtPWm+fnulPw6Cz/urPn7Gl6PU7FTFQWaRTN1yXaTvF5M8RnIXHnz5CG53lYT2bJQfqTkgwuBFP66d2k/BLtem3/p/e70eRhZp+jPWW/WyfqjDj5larWLmPOGk8f7RHUj6zlM1EgjYkQi158UgOpga8wydTvZcLZa2uRMTyMd/ndiwpvyQOzlG8EhHBH7q41xGlp2pyUZ0nxiy7Qqr9TXPnVrxjOuCkfHauvMKDQgU12DYKHXAhcTu24FBninXW7nQm5oTVuoH/0MZeeGF19tSavXKnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(26005)(186003)(4326008)(71200400001)(54906003)(66446008)(52536014)(64756008)(76116006)(6916009)(4744005)(8936002)(53546011)(478600001)(5660300002)(66556008)(33656002)(66946007)(66476007)(86362001)(6506007)(7696005)(83380400001)(55016002)(9686003)(8676002)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XLExRRyi/j6rSeYbP6VwKTup1aU5lJ1tOl9xCRFKZLbzHAN76SZnGPGrVxIz?=
 =?us-ascii?Q?CK27IJF5tjYb0EUI+gAWUoAJR8BoCTFZ1UulE4f7vWM7F0ufCdUrn10NU/mr?=
 =?us-ascii?Q?tZhs6XT2Lmq3I0ok1WWu4hMZ8AZ1VHwIaHGCrmIjBRw8h9bM98PKuE0cHBMM?=
 =?us-ascii?Q?X+bj3dKA06rF/gKL5dhKS/LHhqkAIfyZQxEqsS0kB+5v0ZnmLuvYf8w4GfAc?=
 =?us-ascii?Q?OTjmd4D8ebz3osN6nF0atNiIA2M96HupNJHvdyf631oA1NjWIZlK33OVT54w?=
 =?us-ascii?Q?kr35zPgJUTtZFoEET4MgkRzMHG057XYIJ75QxyHQRSr1O+zVAo3jiFW+kOWT?=
 =?us-ascii?Q?XNlZEVhRtYZNscrBVOaAzhbBG6Mmar1mMH3pAlWURwRZ2IIhgNY5r4o9kSMI?=
 =?us-ascii?Q?rrSCndz4Lv6HN7ES/KFHzPPiZfA+V1KVJsSDdcK0eK0hiaTodwRu6s7/HNcR?=
 =?us-ascii?Q?+5p7LWNmxGE00ugBoDEifjzA2yoTw+r9Sd5YIodazdp8SjpQVQgrZGwvIKtE?=
 =?us-ascii?Q?AVxJ4g/i0nuHeYwQ2vrrcM02SICRgplTmKeYAWlztEa1RU2PtldC9ij+HWAL?=
 =?us-ascii?Q?Wnk+Ur/N0rQqsGOk7bLIz2SAbD7sjQ+Wr7Ff8zt2d5OWd1PlCZBDMilbTug+?=
 =?us-ascii?Q?wgNg2nJk57O0pH85P0bSNCoLmf+07N5QdJrNKjOnqcgpmMMMgPoduTcwpqi2?=
 =?us-ascii?Q?Os+mECWejSYQ82N+Ll98NlpWG3gjfxzGKma+E9FeZbcimg183RK7dmUHAi0Y?=
 =?us-ascii?Q?m0oesaS1nW8qNSiHl32gXJoNi0OoIUfK6dltv3r+XOxuGBDk2Lj7VSXPqByA?=
 =?us-ascii?Q?y31/2ITG+gFWB+WsIpWtPQ73FH4OKRV6/o/kHm2R1NYkvW/anMPsFDBcObnr?=
 =?us-ascii?Q?AAWzf4mUGp5u/xwy7HvG40Rp2InJQMOMN0cZXlCQ0vhmM5OdD4C3sgeFAAs3?=
 =?us-ascii?Q?q4/l0LNAeck124emjUIczOepklZWsBXjBM02w7aEEByuaYyadDgBMLEst0LN?=
 =?us-ascii?Q?xjTTnHNh1x0OS5+El51/nhQFYVwRZqtOopZpLrDLcsN2rS0RI8K8mag/kK8f?=
 =?us-ascii?Q?mnFj6CdGGy999SvuS0cs0ehwbDOByDbR7pwhLYEy4rtAvVawNFApalqIXQmp?=
 =?us-ascii?Q?ceALc7ksapIkfXd4aziS9Kw+tOj9pYbdsfPzjBXTqE3/I8Ro/K342ce8hn1n?=
 =?us-ascii?Q?yEryP/zcx+0++gB/Y1K/3bflfiD4HfKvPSKGpmoHbEFIx2LERM4BEwYU7v3u?=
 =?us-ascii?Q?bOx2DeRdb9SAiBJnMamlW8fgp47NItHrc4CsvKuTIce7aZVTVW/qOMnImCGf?=
 =?us-ascii?Q?qhmBuu+ivGbH4hPa5bmEn9/n?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c21ceb-993f-4735-c55f-08d8d9036050
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 20:32:59.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXu8wgJHx0zWgHpwk6QFeBvPFO47NXYUhQIjA81Qk3BF/BJE/PwgdjdWbEQ/8YplkNNXiTMD6+qG10XNySQuTFHmeOyNr1y2JmoHOLc2EtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7632
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 23:29, Christoph Hellwig wrote:=0A=
> The caller can't cope with a failure from bounce_clone_bio, so=0A=
> use __GFP_NOFAIL for the passthrough case.  bio_alloc_bioset already=0A=
> won't fail due to the use of mempools.=0A=
>=0A=
> And yes, we need to get rid of this bock layer bouncing code entirely=0A=
> sooner or later..=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
