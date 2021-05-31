Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C8C47080
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BC561C9C
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 13:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhEaN6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 09:58:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40624 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhEaN4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622469305; x=1654005305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ub/zs3rbbh5gCoj/vQ/TOqoVyQH9G89ol2nC+aLevfU=;
  b=lRKTDznEAvq48Nl3gTLg5yD1G2XSptD0yl1bFJB/OIvk47sKZE5fEQTv
   siBO0JELfbXZ3+bX8sOimy0kz8b9cPWDNngziy3JXBnjQF/k9gjK1D//6
   F+5ZP1y8+nJCmoR5PHeds9fJPRjMEGNF7I/Fj8mSFEpyFvTkLjUe/L5Jf
   OfRBdOqYRfN8on6AxQbHvYP0OTCFYmpwyhspiAqhywAg63hbquhSSNwBM
   ReUYSB+OH+KYH/uL42uVuWJgNp8Q/WmHxP47FZOnU8dU1pnuM2vUfgHw4
   vmsAWOFlBQ076HBOS7yjDA/lHk+YxH/yeVjjuy7AUpKJvq4hlO4TVb2wY
   g==;
IronPort-SDR: LZV3pIej4MHOL7/4enAsL15oYyHt0/eCnKmQKPV4CUf2L+f7yj+s+eww6J5Ax0s4sqMvTHtRqi
 +5t/D17z3Oznc4A6v4/M8EKPaiyk9MdHZnVpLthH3zC45Vsns39QgeD6rDxR2sHJVfbRX+3ro7
 OlpXdCUB6oDE59Ji3BVY3gWD7rrzvh+n+ikogE28mHMrTw77OqxRhugfgq9SwPEUcuG8bn9fnT
 n/+DCIyoyezkk6lh35LOFNhrMW80b4hwy8Nr7kPjhNqejdFfQCmoixJD6mtGSqPjW/o6cCjyzo
 08I=
X-IronPort-AV: E=Sophos;i="5.83,237,1616428800"; 
   d="scan'208";a="281524501"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2021 21:54:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpgciUH2B9AWCfsy9R9+Ou+/vcBW3MUWS0CMYqsk2f721FWt+z4+ID0VQswbvl7Hyb45s+euBTDarw2Nb7HRCl5CBelZ8T00Q2DjuggI/zqI9RGYmCtciSmuJfnh6jOz7PeX6KfNCYRL529OlB+Qm36dy3xzsWZT9oBhf1MlZgh34hOJGBkRYhSxG9XypPe6WSHYxOWfqaQLfIkIKcbAZWIwwLf0pZIdCZMwmMB+MOKFTK+RanT5NpLc1WG32jTzkf4ydw3BT5blyr2W6+as8I+VSutjNeatsMwkcql3DUjQ5Yk0fMWMNlSapXjU3Zwx4nACLgFngFu2k11aboiiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9KtSpquh5xoU+yTYLVDILyj9kIyNWStOyjb30VGZl4=;
 b=En3JWBf9MiiPUaRhagHswhzKFFAwzI/ExBhvGEb5q53TahKwaDpvvrDVLdxOczk9wnvxsnu2GQ39fpJfZ6RvR4qbGQDYf6gV6N5FdcPG+QpOUvNguYroPNqk8fE2NomDUO9KD4GbNfOWbo58qGPMZtxhBedt36FyDaFq2xll88JlP0Av4B/hRXPMnYtEKpCYrgIyG4luyF1LpqyFnUeqA0Qguzud90m9I6uYgWkffKqeAPDHr6TILCs4jGVnaIQnW2rW/KDKsr6AcSv+mUgsDpMIbfO17rPoLB89cvbdoZlYy0Ct0/RXfolguK+k/CMqHubw6cEOB7JL0efLU9ctZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9KtSpquh5xoU+yTYLVDILyj9kIyNWStOyjb30VGZl4=;
 b=F2K0RNEr/l0M4kTUkH90vidAKGoJjogOD7imL/0g92CDNLSZoD/YDg+RVv//8MUGI0Lb+O6hwGmBWhkYd2NXkKgSjPrV8fmdaHVER+e860K0mhflxfIPjBU5EQ9WzotvFkXQozfYLhHRgHCZNj9nuVaeQHjQnf8popqIJFWNgSA=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7349.namprd04.prod.outlook.com (2603:10b6:510:c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 13:54:52 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 13:54:52 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] blk-zoned: allow zone management send operations without
 CAP_SYS_ADMIN
Thread-Topic: [PATCH 1/2] blk-zoned: allow zone management send operations
 without CAP_SYS_ADMIN
Thread-Index: AQHXViSHoqrmKcnFs0emlJmdZPJZxw==
Date:   Mon, 31 May 2021 13:54:52 +0000
Message-ID: <20210531135444.122018-2-Niklas.Cassel@wdc.com>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
In-Reply-To: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33ffd291-7a29-4e88-2dcf-08d9243baa13
x-ms-traffictypediagnostic: PH0PR04MB7349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73491AE51801570F0AEDAE3FF23F9@PH0PR04MB7349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/gQI3XQUXJqkGIHpcVPd5BWGkltco+C4ELF0pmjPW5O9VEMP5fnkTn+lIX7uwBZNXLo9DkfIqT3VRHkk7vfAsmA02GIdWIU6fuuk5TBNy9BWWQwC8I0VwYJPbVbvUq22k0Nl+tC9OumIKbTEMd+4920KB87XbwP93sm2rcBhn6H6MXfF+s/HY5IjdrZoujuwPw6V8uCnSS8uxLCmSdIN4nYpwbJMvz3j3jhxD0z3KstPJl8+8K+OlrmpXQLXLlIlGT1tmwy6X5xiE++WCZ/P5w+9gG0RuSthQIimx+KuXN/KRd3ZM/6IzMLqnfRCM7OWO2VSlRnVV4EJw+NH4xnqP2PkeJGXR0U86QWbSVsjravp30Qy1qpATGZt+kNdB/D+O/QnShSUO49hKmnKTtbi+7AXU6GIPoGdLMHQNs2MBvTjHFGgOcfHmI9GCzCLtQS1F/KbOQFhjkB0wrQy+/2hFI430jsSIi8KHFmWfyJ8fGzMmp/AR+A/bai0+hmY+tpGlutHebDx4kVRC52zKJVA2Q+Whp3Vl6Rrek+/wL6skRkFTDfbbyk4R5PdQ1AIEM4Ot5MaC58LWE4O2C3I53Ownw2K4Iztr9guQ1vgDUcJac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(316002)(6916009)(26005)(54906003)(6486002)(66946007)(66476007)(66446008)(66556008)(64756008)(6506007)(36756003)(76116006)(91956017)(71200400001)(6512007)(186003)(8936002)(2906002)(38100700002)(122000001)(478600001)(2616005)(1076003)(4326008)(83380400001)(86362001)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?p0hF9BOW7po+xxfovrMzTVgQtcIukRsBmkS8MH0elHn7Y8gt9yqp/zmMO/?=
 =?iso-8859-1?Q?4pR/KUH1B+FPh+aRVmjqt43r7p9Zx+vs8vYHr2G/L+8+MLgVBLLra8RPdW?=
 =?iso-8859-1?Q?HycDFXx84MIDFboFfjVI/CXfMP4uwPjXYlcE+76xZ/SvaN5o0tmIW2i7eK?=
 =?iso-8859-1?Q?SJZABLLjkkVfiz4eORDXc7sC5uTFrgs6EBU+Qdi0bOTJ6/XiS6TjdYBgWf?=
 =?iso-8859-1?Q?LNLTTdsG60ytP18FXqHQZ10cS2A07p9WkLvkgdFvJUAXkJ3tDuFICeV+IF?=
 =?iso-8859-1?Q?76ENcf9AlWkfdlH+OkGAXUkbi6Z0OW5Z2bwkPVl+RaOdVBVLxSkguhXs21?=
 =?iso-8859-1?Q?oKw2aQ9afyEkRiJg6OS1oplIAQt5LHi9rxEzIzqXfOcEKaQJK9zjdR4h7G?=
 =?iso-8859-1?Q?mA/kD+k0L/C2Eg5zi9DmsM868rpkp5ben5nfd0sF667M52AeAymOpdf8sF?=
 =?iso-8859-1?Q?Lo8LdMnU6A9x5a5zZrWrWSeKg0vbTSq3IZUp4I111MJY5Jm20U2tNjdkBo?=
 =?iso-8859-1?Q?xSQObWvSPV73W/iEmyFlXe3DiifvAskwy5wvitgtBstV2T48HqzYoX2uGv?=
 =?iso-8859-1?Q?GtpleoVkWCwjAWN+azjkLbPw11JJbFt6qhhr62HgIxf/g1rCQP4aOC6Tc1?=
 =?iso-8859-1?Q?6iR3s8impLErvr11yuEJ7YZY62OvSVl52L45ZGSuvjmVVJTcTgCZ0U00Mq?=
 =?iso-8859-1?Q?ROt7/0oD4Ds9XPEp8KeVfZvfGpkdLnLocTnPQW6NyEIKl2JyxXHwGXc/Ii?=
 =?iso-8859-1?Q?lLyuFk0q2TA2i3/M3Xs10/VkNdvne2gzGMSKHgKVEGqFaqr5QN/0WZSfDr?=
 =?iso-8859-1?Q?mzHmAuZRoAJv6RNw6w1lkhBNYTwYUdEFaDvYQ5ygn0Y2d5+G1o2fVlBCL+?=
 =?iso-8859-1?Q?lAkAwKXxxsftHzyHvtUdnrs00UF1GlkoFJAY/hTUNsbzW4KhhF13zQ2mn5?=
 =?iso-8859-1?Q?pD3oRiGqDyeXKGx1snI9gGWYC8jcIL00KkZ/oDcQHOZW57XXN+Hnahx4V4?=
 =?iso-8859-1?Q?ATiZwYfC+Kfm8EGDUyh37v44kl+/d3GOAI35p5JgszTPvTFYj7ateLDyZt?=
 =?iso-8859-1?Q?o9ZgXWKB8UTGh450O0OCPX14jatlvEJu9vSbe9cH99sMev//RI1J2D1Eds?=
 =?iso-8859-1?Q?9i4t8vZavvBz2Ietrx7YR2Ixa59OOtvZCrvL/vQsCQRMozHoaMGYS7vEV+?=
 =?iso-8859-1?Q?d6quDPs7ruk8odRp4k4Wgmuj5SDBbPp4DXjQ4eJeWIixJM/tRBfDQXS/Lx?=
 =?iso-8859-1?Q?Ls6pLD1DvTHtlpR23fM1qyD0plY8fykftnkZ7Rn0gUjE8HpX6imN1bfPud?=
 =?iso-8859-1?Q?C3aqPRTonyhs3ujjTi9Kx4hfGlWEO/tTg3uQEftJYOFTmZ/YkDFesrhkWP?=
 =?iso-8859-1?Q?iEZ7fXcWd8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ffd291-7a29-4e88-2dcf-08d9243baa13
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 13:54:52.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IwRjap4hcqK8lapKxZHYggalFguGIscVyZEGtCzpDNWngtNJam2ML3Re2gqEk6tostCzeOrrBwqyVxSdAMroA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7349
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Zone management send operations (BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE
and BLKFINISHZONE) should be allowed under the same permissions as write().
(write() does not require CAP_SYS_ADMIN).

Additionally, other ioctls like BLKSECDISCARD and BLKZEROOUT only check if
the fd was successfully opened with FMODE_WRITE.
(They do not require CAP_SYS_ADMIN).

Currently, zone management send operations require both CAP_SYS_ADMIN
and that the fd was successfully opened with FMODE_WRITE.

Remove the CAP_SYS_ADMIN requirement, so that zone management send
operations match the access control requirement of write(), BLKSECDISCARD
and BLKZEROOUT.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 block/blk-zoned.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 250cb76ee615..0789e6e9f7db 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -349,9 +349,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, f=
mode_t mode,
 	if (!blk_queue_is_zoned(q))
 		return -ENOTTY;
=20
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
=20
--=20
2.31.1
