Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714BC47080
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4E3613F6
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 13:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhEaN6t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 09:58:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40626 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhEaN4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622469305; x=1654005305;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=o7Yt0fVvsU5pE5v66Qp1x5LtL9qknyVNOjPHQ9qC0nk=;
  b=DZmJI4/RavsdKbYC2kxFen9xcoNoQCTtV8pUXpZevwxEZDD4m3wffpaL
   7qcBKIcquPlg8TOh/eCI+ig/mKWm9OXAYC1VwOIN400DJ+7PyuXEOv8xn
   3q9wdBKTCFBcdkv4pe8K9hxTeu6SJmgPY/hQy89LTDdTfWszkLXdKs76N
   zbKo1ql2vSpCn8+9/WSgJiwRHLQXsl2xRhgce90T+pTYUQIjZK/MR/wdE
   QEJO+7g1ZCRrdztXaEGPi5aKDiLcpbVHgVA7PDmb1mkrdTVpxzPlJI8Qv
   wudY3gTr4rGOzj/kjozPYoWYVoQWKNZT/C23h8jjj2o2043xrZyPuCA7u
   w==;
IronPort-SDR: TuSb58fvv5nZCdd72N/ZcCxJHdjNQlkWieZZt7LbTiPko7l/wq7BGmippqE5gqclkCFwg1pMEN
 p8rzJAgVAOJCATScxB5/vVQCKsCxiijKa/yFVlSsZ6V9MwYDvqxpw2cnY9MH27Fzr06tWQSFAF
 j9Dkx/bGC7CjBoXDXIeCE2rqMAt8dO3jVBQeaAMUy/vDrJjsbu6N2p60tpz/3p6ZGT9Sw7gd50
 wFu0R46lbIrvTPTwluxCdNXMzRZkWcv0Iayo3HkUg4kB1FYP5U8EA3WtezZ4F4eYUYs2V05euS
 I7s=
X-IronPort-AV: E=Sophos;i="5.83,237,1616428800"; 
   d="scan'208";a="281524502"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2021 21:54:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8Mjh4uOjTCS7t+ifF9lSCabueyhZwEdPrJuoqeOmZYiXe2m70ifEcqTL79CbiP3K4O6Sm/u+nYkoKW5slrpnQ40sbhaS4rs00v5nypEp51U0i1nkm2HLY/WAjO6oe5aHnuOIATpgAO49fuCr33saZm7Y4dXYMjEkudm3Ei3mjLPF0F6QPq757PG6tjX3bjRPzh4tMme4Gh1VAYUvTyTC/Z/qYxhoaKgtpS1A2EFYE2fRG7d0FLNlq2hklKfz/bd+p3Q5XIDRTIZjiKiEK9LFbwJicsqpE+yMUMTvpDsUokC7X5bxF8VN4sDearpvfTZlRco+E+1BTSw+SMS4nUy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7clz0PbtWw0rkqiNSXEQu73jWP6Lo+bYgEDgIWQJdg=;
 b=nY/wPlrjJp8P3KCYS9yhwikyMxeJJrxwAcYy++ghP7rnIGxcGdnqDxehT2SCJjBx9jdxvaUYic5ZiumnkqF473SxDcnGa00qak9QxN5dDnPAhPMbBna9kf9JcHJT6qnNJduOZNNzCjCM1hQ4b0sd3tiUt8YOU4SoPDqqcZSPMZzdeaBW5UpMvtN6vVcUGaf8m6ydFliBuyJZjlYdcog5gU5bK63Bmnos/jIb9p0SP1RnvgY60UXWBpU2pA00YMhF8pV98jPepLfB8AEUOZ3PP89SnF/x+9Yq6eLACJVFGVh7kBMCP5dvVF7nTt//gM8txN1/v0e7U4KnfC0H8tC+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7clz0PbtWw0rkqiNSXEQu73jWP6Lo+bYgEDgIWQJdg=;
 b=AVJ08kI4vPYLDn8/FbDiIL+N71cJXkYpA3Roa2omorKUItHLUEl9n1XtVCAA9Z0YJUfjcBBqWJ72p8V4lIr48/Hef6G35L6zhqyiDqL94x8ASAXJYPywiqV735W5v8B1nl4vxV+E4N4bOuQ0zZQZXGh7r+aV6T6Yl07vhbSisL0=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7349.namprd04.prod.outlook.com (2603:10b6:510:c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 13:54:51 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 13:54:51 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXViSGVuv+G1Vef0ak0MjWhCwkYQ==
Date:   Mon, 31 May 2021 13:54:51 +0000
Message-ID: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52b26bf7-2990-45f9-f820-08d9243ba97f
x-ms-traffictypediagnostic: PH0PR04MB7349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB734940F97E888ADCEC35F875F23F9@PH0PR04MB7349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mD1TDNpelOlA8eHxn92wqkG3UiOVSeSp8gK8TObLO06RO4Yj0Gk7hH0wHKGzdrp87P7r1WKfXDLjrLpYfjujPOyoOZD0p3lmL9b3uzWnykb6b9oGa85oXUnnZ1UYnnui4siu3qyNmXhPAvDiXmKL+n7O5gziFoIya+IwImp8h69tIPDaa8WEXBXBGD2B416s9V9GsVs9+uBM8MJcpn8y+IlA/BGcwwj88NgSjfAHpOS491EpzKTfDmb4nwJZLfNtUTUUkvc0MguIr+EwJ28wVh4CdSZmShGMkudSbGNQh5Dl+3X3zaOez7ygxfwc6GgIms+BeSPOj7DBtSLI7jj1zqZ3rToWuOOeP86NlgdX80qR1A9rxWxYFqvC6z2Y9Q1R2xKXG1GjlCtldRP1AWyP1rr59cfjJ1ZPEZyJ0+S66Rogj5ZL3PVh7auAm9PMdwhs1yBhNuAAe43Rdnh4qqex1wg8TxkbWnen7kSGrNdBlxcJUZou0SxoVh5kTnkNqBqyJSIwHCq2EkX4h1RP1nDygrdUiteXkpOIjMhA+qx+iKIPBfymiF2Hm4jj2PhoNtMHVscAxqGOfCBKGLrUxvMFjPMl0jm7WZF/N+afNR+vFLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(316002)(6916009)(26005)(54906003)(6486002)(66946007)(66476007)(66446008)(66556008)(64756008)(6506007)(36756003)(76116006)(91956017)(71200400001)(6512007)(186003)(8936002)(2906002)(38100700002)(122000001)(478600001)(2616005)(1076003)(4326008)(4744005)(83380400001)(86362001)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?X31KwI+l6tr4n9A4HoNwXBNado58Eh3HqrdJ5FkGTWGbRCdDKb/XdjRJ8G?=
 =?iso-8859-1?Q?HlhSMUIwCridKaLxoJ9oQbgnfoKvRseGJisc5pAz444FfodYVgU47Ph7lK?=
 =?iso-8859-1?Q?PRRTDjRNUc4voqmMnF/kCq3Qk6NLkQr+ulzH1ELB0RcjRoiuNtwaw+A+2m?=
 =?iso-8859-1?Q?Z/X2WL/GXLgQiGlrrAheAPKUZz+Gyds2zgLiZBUCoGJbJaSyXOH8Fl1R4o?=
 =?iso-8859-1?Q?8BIf4P1N3ADGH7zHSxxYqN8ujKQNJ0FM5bOGxSV70o1D/TwarRYXhU2HTJ?=
 =?iso-8859-1?Q?EFT3yI67p+7UBCdtSThuj4YNe0xbp0YG0Etp+Wn3+5XuGlW4Kwig128Mg4?=
 =?iso-8859-1?Q?b22Ipd/AZNqCli31H1QVYsTSTa0jRmmfuDmmZmGMCsiuCbEWFT7Cg3VdAF?=
 =?iso-8859-1?Q?vOQLNrIqiyj74pwVytxNzd25WmEEHqtcMI6HGFot+/BHRkc8dVU4F4A7Iz?=
 =?iso-8859-1?Q?oqcJCMZELOwTubHrbrVqZsfuSSUfnCf5lXe590pIubLeaz/GSCvi9eM+Ad?=
 =?iso-8859-1?Q?78Vv6pmSP+1XkPeDqolUSd+UYhQ87IDNquNAq+Z9RjL/BAHWLvv3PtKQ4x?=
 =?iso-8859-1?Q?tFg0sLvXVHPKxEQPy1buHFB0hoEBwn4WgfC7F0F2Rtfl9+kA1SBmw6PwmI?=
 =?iso-8859-1?Q?qQlgev1X9HcMPeBUAReFOo3tw01ppM9IZ26b3w7vjhIyg9MCqG6R0BpKPC?=
 =?iso-8859-1?Q?CJdHexeHvOUkU7uUDi/1WGnTGCgG46wB22gY05r9qIxL/DfK8WNYkRZc/s?=
 =?iso-8859-1?Q?HrwWxyr1B2f19z7tATSNVwUIhL6jHzqJ3dG/IGvMlr5eGeY95Ch1QAF4Vi?=
 =?iso-8859-1?Q?dqWLC1yXoZVVOYiT678iWCCyXAIYZryCYlcYLhIc8tdgvG+sv+vQX3A3dg?=
 =?iso-8859-1?Q?UKAUvYABeFz/Oltb9gtkQNgFEiUWKh3VbKx4+JKBHi6s3hIbJYr1Luru7x?=
 =?iso-8859-1?Q?iiti1Foq24xYSj2ohjAkmyDznryZslzKg3gVJw63qo2TFv0+6jKzwaqxpK?=
 =?iso-8859-1?Q?4MSfYDDaRYe0maWtyI7U5EdDjeiB38bTNCi7H3771OVqznKUfcq6eBfu1i?=
 =?iso-8859-1?Q?pHZT9u1Tbusy14qQBbMDa7leMoBcJqIGww5j9Maq6tOyLyz52Of50SiFY+?=
 =?iso-8859-1?Q?SA60eQsVI22pDrahHaa5WBC2Dhf1Vxf6se8BXt1bheu6JblbYG9SDILRy4?=
 =?iso-8859-1?Q?rmCHGDGZX7Xc90CXHgvm6g5BYO2FLtfVlNg5WS9dL/5EHMm9+mcbkEV1Yy?=
 =?iso-8859-1?Q?mm0x6xKM6LWjGwoBnMmp3w0cYE2cBRhjSwuR/4VVmfhTaYuJL3M2BmN7s5?=
 =?iso-8859-1?Q?S0yX8ILG8BItI013UUfVIrj2HP5mI6wzNJO5ypf6IarSK+Y31DLU0hWb3F?=
 =?iso-8859-1?Q?9uULAOIIwe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b26bf7-2990-45f9-f820-08d9243ba97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 13:54:51.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbzZ6jJbjV7yeha6FvtgSOaeX5fUD9cup4DQx/5Aeb8y6bkudCrH+x9QoQ3ahVIlnWQEU2UhHCL3z5hcE5znGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7349
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
CAP_SYS_ADMIN.

These ioctls instead only requires that the corresponding R/W access
control flag to be successfully set on the opened file descriptor.

(open()/openat() will fail with -EPERM if you try to open a file with
flags that you lack permission for.)

Niklas Cassel (2):
  blk-zoned: allow zone management send operations without CAP_SYS_ADMIN
  blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN

 block/blk-zoned.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--=20
2.31.1
