Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE2C2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 12:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A9A611EE
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 12:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhFNMZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:25:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24750 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhFNMZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 08:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623673406; x=1655209406;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GPH0mH+lSD+9s2b9ZkHVuXOz0YoAIP/8k78TsRzNQFw=;
  b=EljkuWL/C6RlOR92x7+PGtHAV2Cn70tg3tR68fYjj/Y9kx31d+2fP2A3
   BTChzmvsj/ohY2bAy9a1VvySXclXu5XfEg4sSdqQkRqD7T79+1qe3S+Ye
   thBgzGmnDX3/MtQAjQH4hsp/wmsTPjqUw43pnBvvJUb/dis0DuvyE+yt/
   S1+0ImLmPAT+16qo1YfuWLJMICJoyVv56YfEolUN+pzgc5+KTu101jwI8
   r39ieCgVEfqNFdjsHcFSSEXd+QQJEfwa58QAn08+lhhDkzIs3LzdeiXtp
   GhGDvw1oeOah9nlhwcTR+DeUpCpKPuq0ha9aHABt1sFD7Y9W/zSnvMrUW
   Q==;
IronPort-SDR: aEgaU6e307KoXPakJYhIWAW3YYjDfBh1rkIMjSR2t3QpMXEmteo+wiXHahGwmmyjQuI9ad5IWW
 z/vCLaCvX8ONo73tO1pCFobVkdFULOzbplMuW+1NzRcjp9O4zcCML34JksOrQ3nkHD0pAHyXL2
 3aMxsliUscPtlADuC1+NvKkT2bNdiWVhi9AiCijqOzsfxrLFwhTOZAwc+zpFj2LQwFH7yB7bqR
 /bxL2fvuIM0g/hAraDh9nmmIcKjLpFP6pDZtByS+m7I2um2PN4z8XcVnGOv73Emsm6kYyVjpQa
 NYA=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; 
   d="scan'208";a="172386405"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 20:23:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcFxZqjSfDIKg704Sr6HH0XqeoDNE0myLLeGhiwL/Ue+Nu5QZC56n5Z4sArFHDBVOl6V2XqNQbEA2+/+w51Hg9Crt1gr7Nn3SLgaW76J4MTb5cs9YlkR1UYKvquX+AktAQh42W+OsROBVkuXixuh9+TqxXmUuubExG3U+VrnFrAY6kJavvD6YQeJ/I8J3oZu1GlOPE8f4RMgG8wP59qM+gvS1KuNxg5CAsf4UzxFA0lI5C9CywDpe9VhNg/bampobGT8th5o9AzdXS0tC5jxaas58iAZpxVmSPPhI6y3sKRGxatPBalc4MRCB5GYelpGF9kRlfv03kvDlCl0iq9Z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWlg8yWOm2vg4oL57EtI2J6dLlR/cNATbKwPT9gTJYY=;
 b=oeKsieG2/Z66tjp8Jez5U4QUPppB66XLcqf8R6HV5l4C8MOCepcJdXJphn2bVXhamdXCVeKEQLXdJEB/G/P6WlHpLVX2sLeKcy8oGKMgwptaiCEpP1gc5nSiHj7dO4Oc4Qh5A6jrx3u5PYmtE5aE93F1sSO9qf16ceAYPWhdeCeDopMonSTFbr9yCPvtEXaY+/38LwY3JOpOvPZUERjGkWsq/rJQVpfi8jQ1Rwped390JjmbWAITm8d/SdIlXAfB993IHj4vEufOvMzdzdmZSMrBg+uidimhxylnvfDF0aBQUSKexbvfbYdrDLIx97MkjvA9J89D2Xb4Xwe/8EFgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWlg8yWOm2vg4oL57EtI2J6dLlR/cNATbKwPT9gTJYY=;
 b=wRAkJWP84XQOLfV9NLmtrPBMTxbzId0zXHRSYQG2q7mH44nH67HN0+ql8mAYU5SuK1gDDA3qEaBRtNZ6OYEgfw8wQBIV5h9Okf+6Cb/YVSR02CBju9vqsSnBx+kL6nSOSLDupeL02BQPKGO8KWlg5Sk/WYk11vJhZZiRCyWcSYU=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7365.namprd04.prod.outlook.com (2603:10b6:510:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 12:23:20 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 12:23:19 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Shaun Tancheff <shaun@tancheff.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH v3 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXYRgPtP8+uBs1gU68gsGoV+YyFg==
Date:   Mon, 14 Jun 2021 12:23:19 +0000
Message-ID: <20210614122303.154378-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a01d0de-5c87-4c7e-de40-08d92f2f3213
x-ms-traffictypediagnostic: PH0PR04MB7365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7365D48A7E0208DA7E830DBAF2319@PH0PR04MB7365.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjlS6ylekz+/anG6qdkDyfylY4vm8GplTi0SkgTkydYJDLdYsraEJzSxJkkyheeJMS7M/MfvKhTn2cJe3c6bi/GUclvEyMCEF+Vc373/Q0PuAlgt305hCRHPRpXeK8FM6ISGNzXLSQcHEQHj1TFes53iMkOw4GoA8DVNqJwdKazqT7tCHnLuY1w23Ho2zdA0n6Xh41oMs0mRDDduLf2ENzX9UtcKY2ywSTqC6DSqjN0we4nl9G0HSWHNSKNWe/AL1/TbVSoCxCi79tA1qmWX8jBWHVH3IgbK9Ual35VFzB/MqQFFjDV6oLd50MTeyx47tmVoj8GuupYdM/RztntW68QzpApMgGKS0xWZkBiB0WzxJBf1EmnkWzYMAyrb+xMq5/NEAZw+8LcFcgVY70aMI7BN1EHX8Y93dm3gMm59I1y7Z/G9deP4fwVF5+ibdZU+oYkiMi6ji86mTPhONrEOAifzee3/X0YHAKlvS5uumi0zlnYQBQJbyDEHF+XKkVELqOueC2adGqB3NEQVdENOsByNtzYwEBxhhMH/Vl2dspJ3ItQ5ZJemGBjeBNXLto/W88/7JI4rJeuz1yjZ2zdIn/6fV+4st6F+8MwQzPHCif0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(2616005)(5660300002)(6486002)(1076003)(86362001)(66446008)(122000001)(186003)(66476007)(8676002)(4744005)(64756008)(66556008)(26005)(8936002)(6506007)(6636002)(71200400001)(38100700002)(2906002)(76116006)(316002)(6512007)(54906003)(66946007)(36756003)(110136005)(83380400001)(4326008)(478600001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JzkNMFI63WW7+HucuZ5mw+CBJ8ynx3Agmxhlx5BmQTVEeedQ6sdteP9DrN?=
 =?iso-8859-1?Q?i1Jf7dt5v2JuW7cVKc+MbiGYlVB20enuv9duJeBO5egnuyj+recQUiT+qx?=
 =?iso-8859-1?Q?xGeHwLwCWYWYVHcr8kfg7ObEj2TQIH7qzvZ3l0jaP2HjixsXgrN5mmr+Ep?=
 =?iso-8859-1?Q?9m//37P//E1MdFZN1sWgJCfqrP+4Ik7Fk7eo2I8JS/3muXwIi9IrIo7xNP?=
 =?iso-8859-1?Q?WVrhRazDQUSY9cjwqimNaHicdmz2diIEYMl9OT8nEKTNi+L/qszTFr9Rhi?=
 =?iso-8859-1?Q?a5sN9iW4lvaulVcdI8WKDjl/EfaVbIpZX8smv8yh/i8pL+bwonk5ZWAKQh?=
 =?iso-8859-1?Q?mzB1jxWRybNuNM+Q9jo7ZpMwPT0eYAjCxg+M1y6dmT4wcjEq18Mg9D/u2/?=
 =?iso-8859-1?Q?fW8aJv74WNGMlciuo63J2EYd9lRGZEkox+T/OUJOQRMwjZRH2c69m46G3f?=
 =?iso-8859-1?Q?Icbxcv51ppnAvAk2Vaa0YES1uG60bn9VhtxQcDUp1T+u0HJNysEDb/EI+x?=
 =?iso-8859-1?Q?1VZFt6mJj8KMXK9sHNoVDNRHH27lFJuv1OrxtHI5rj88mxpV/bAeA0jFOe?=
 =?iso-8859-1?Q?2L/y0DZH3hgBUhGpG14ht6XOiE9fC3dpfii5Ij6WvDBoM0mIjHNhnMyObN?=
 =?iso-8859-1?Q?vHgpDc0EWzVYqZcNChBS3/eLihstjhx4fAW+08BTWmjxREfkXN/Hy7HHP5?=
 =?iso-8859-1?Q?q5QkiVPBY+lJ0+lLnBkssaUfU4ByB+Bysr1ief/Ic1/R83oqgl6WFmm/eJ?=
 =?iso-8859-1?Q?D0bGCAPXOmziBOUTH4WynaO+WnTTgL626h8V/gugm4K+fnL3MgW/jgk8go?=
 =?iso-8859-1?Q?V8ONenuf6vGYvzGthdyUj0fHt1EPNWmvr8PwAkyMU+UIK7ziMHnrl2PNMR?=
 =?iso-8859-1?Q?9K2BBLIqJfYelpYnYVur3XQjA7EnLKWZCsQpgm7IYcbUSXhgkUgpwdawsB?=
 =?iso-8859-1?Q?WP/ggmQc8UI4z83vMdCtvC8C+xXt5l03CJyn2PvbpM/lZg6n2iOTCBnAfL?=
 =?iso-8859-1?Q?ZvZTCH91DpzosYHWvNUSwOzxoHaOLw79P9kfQmqSUOovSoY7G2kq2VX7bg?=
 =?iso-8859-1?Q?XR1JI/9x0lhjTKhhytZz5RNNFZThSEHCAL/iRfYmDCn1ZHRJmiyHxj5k4k?=
 =?iso-8859-1?Q?/aUO5jfMc5hNf2lYlD5xLaOB2tEtPEF6qMdmHg0vNFrN3wF1ampBn0XtGV?=
 =?iso-8859-1?Q?PnGjoc/DcDWOj42dplWvJgEitShTDJDkdTO/n8bWCaE3QKnsDDtb+syZ9S?=
 =?iso-8859-1?Q?aSJE0TPLhLUjsLf+v+7MTM3n4cRCGyLiJc15/bkpjwX0kKWUXSV1xTUGHK?=
 =?iso-8859-1?Q?NAawapH5F7bihwibgj9z8c/GoKdQ+UqsLAOob9IWSx1eo9Z+vKoImkQ21H?=
 =?iso-8859-1?Q?M1V+Vh2CtO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a01d0de-5c87-4c7e-de40-08d92f2f3213
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 12:23:19.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xcm0WeufLpYvmlMMyqwvC8xId5+dcyx9KT7XSCg+K+lNnNi/yEuF6OrbzduIr6ACkITKEL2u6kNzvXrK2dxMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7365
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
CAP_SYS_ADMIN.

Neither read() nor write() requires CAP_SYS_ADMIN, and considering
the close relationship between read()/write() and these ioctls, there
is no reason to require CAP_SYS_ADMIN for these ioctls either.

Changes since v2:
-Drop the FMODE_READ check from patch 2/2.
Right now it is possible to open() the device with O_WRONLY
and get the zone report from that fd. Therefore adding a
FMODE_READ check on BLKREPORTZONE would break existing applications.
Instead, just remove the existing CAP_SYS_ADMIN check.


Niklas Cassel (2):
  blk-zoned: allow zone management send operations without CAP_SYS_ADMIN
  blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN

 block/blk-zoned.c | 6 ------
 1 file changed, 6 deletions(-)

--=20
2.31.1
