Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C51DC4708F
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7139161CB6
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhEaOAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 10:00:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40624 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEaN6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 09:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622469425; x=1654005425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4dwEl/6mMsYWwy1whxP/V5HrCitf0wbpPnOFvnLgLDg=;
  b=NYRI7ykZM6RwNx9gj6aI7taVBXDfTuYve0zB5G3SMXCTyjr6/dz+THSH
   C9hUS57FqnJlPSbEMQHTC50S/LHXZt62UgjnEOo/M466SFQRcwMY0Wbqo
   +VlKTe7USRMPTmgQ0P9SgThMVX8h4nYZhYEvJtVbQkKUWC5llDmA7IVvJ
   FfQ0+QEfzt1fwFnCrtgI+1if6z3MgGo0rHo44pOMGLIi85CXA8PJz+YU7
   kWyC2cdhqqZnsfMnaKUGyoyqptRs+yJfPpPQDQneViSmZ5XYTLGsbjh4/
   fD0HR3uvETRWicrOC4X8xJhLTChTpOyDntWOylVxORtGGA0LZSIuETBvN
   w==;
IronPort-SDR: G7MaAz7U9CQjqPfNhCeAy0QrbyVAX4dS/lHBIUCWeQNSGeGfE123NceZVrtFu20rPF/C67pZaR
 M874PjWBUSpA4scsR27+fv5n/KaME+oejwnPfoD6f2qzCXdiBVRXkUQAa7bd2TbRv//bRAfB3D
 iKUb+d+5r5wA9fDItbAhGf2TJd6MPToiqSlkxZxc8HnrWbsaxsc6Bd3ZXTXPA8F0ot3WrmOd3Q
 TZMaWN3eoyXAfuct6YtM9YWbhiJzznXc3cD4BMleY3u1LpkhI4co5NFQwIXsC9m4Ni7XK8uBVv
 Nuo=
X-IronPort-AV: E=Sophos;i="5.83,237,1616428800"; 
   d="scan'208";a="281524503"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2021 21:54:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgmcXgdEhi1YnL8w7P5m7ziM9PgZ5FdBBQLq8rsuoAOa05zfhk5T+IOLyJw6GOFZihlUddM4bw+YIZzaN0ezGSMO/uj2j7TUvHy0kpUNHUK1qjNbVnKhhqzQRdcFRT48MrSMKtx3tg0i3AsEgdVt5eYHclmGLHnMt0M4ghLI9AR8KkoKkWTYqndYq7SiKK6b+3sKCcpdmattEvCsG0dWL6vjKTJT0PefsbI1Seky3APG2vUSc7bxTjc5/vuoBYiltk9nd3dedjI3NP6Rf4fr4TRYS/7QH99NXKAOFzyHr1MWdCFwotnaiHfTURI40+jv8H+CIL+RP1Ykh7GzLrOGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF32Gx3G/ziyesuY6Q48tAJ758Y3jf4Zfs3Y/1RHiKk=;
 b=dpmDVUcS0zVH2fxxGeWYn+/xZj1gOD+fUevxnEIJ41vT+alXdVjjsDQOtiuJje5umnZwZtXcerXRwLCZ226wmOePBEUzNXvyRZIDnkF4r9UTALGCX+gvBwNYsaj9XxASJxl8DEoDgAWbcuihgOanaUfHAkZ96sgyKSaOK6LiP1/Pf70IhSKL4/5hAlIMX/JPFgg2GLHHG1cUMXzrP5P1R+EC2z+ZNzjaS9CXi/D6N7GhPNd1ueT05fxc6cz9YoZ4259BBPRqfeLA0TYeOlOZYCynQfZkLWgtAt0CNg5YDjQbWndfz8V/bRoLNBCKYTLy0otI7sPIZmdR0lkOKe05fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF32Gx3G/ziyesuY6Q48tAJ758Y3jf4Zfs3Y/1RHiKk=;
 b=o08NuYw9eUhziVu6DeoRd/kw6D/r6DLn0IU8DZulS8CZGroCaJj1W0zkm3P6FQeq7J7I+BRcwZQ/aQLMPq7DQoCEGwrTiRnTfYhFzHtp8EjvtvPDqxqoN3UvY9tFBNLxaExXwPeL/Yy8waL2ciSpPctkg1buOd4y92l14j65bxE=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7349.namprd04.prod.outlook.com (2603:10b6:510:c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 13:54:53 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 13:54:53 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Topic: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Index: AQHXViSH/N9K56jFnkyIxAVcrCvP9Q==
Date:   Mon, 31 May 2021 13:54:53 +0000
Message-ID: <20210531135444.122018-3-Niklas.Cassel@wdc.com>
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
x-ms-office365-filtering-correlation-id: e6e6cd9f-f0ef-42ab-72e5-08d9243baa8f
x-ms-traffictypediagnostic: PH0PR04MB7349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7349A9809000E93B6BF59463F23F9@PH0PR04MB7349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QPVyp778zQ/x6Ry79JNia4lwwTkDRhGy+M/LcnmKZ3epKsI6mvhXN+Y/z7wYdJyO6DM8ksX81+wEW3CrK/GHrQciJxCOnJZEiA48sJS6dw8YUxeNZeMptz1EF81k1/++wyyAxIuSY4Vb0nz7X2FFA4Ix9KvKlJK0UD+f+ZpUk6YXV3pQ82dNjv3cEAYQCkwZsYI5UzWJmmkBeOBwVkuUgdzeGukVwQ+OrPC5DUcRngn5mvaS+UrHvZt4Ak6y5t0dqP0siDL+Xx4h/EwLOSVx+dZaChOmzwtHHz+0iywzl/AJOAJQvyvSGlZS7bBNumCPmsOn83qLHVdHJAQXT5c/BysSNJ/wA0OpLj0WyzNifjdVXWJ23JL2W7D9qcxiFhJCJlG5rrhmAwBDJuRCzKNhx9f+7Nzs24kniJ+5k9ohM5yeNtVdQuRviJF6MOMcLreUOsFt/7B53GSSS+v2MvA9+0o+XGeTaoWRrUvEgyT7e4O8hSkmRWU+hEyQGOUiZNlm6D1q+6dDMCAzIl2WIndRwnzlHKEseW7262RKyJK5Im8fvkk49vN+6k7rRpg1+zTBd2BcxbiXDkiCIAidR80fjJfOZjzrONrs2ya2b4FswuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(316002)(6916009)(26005)(54906003)(6486002)(66946007)(66476007)(66446008)(66556008)(64756008)(6506007)(36756003)(76116006)(91956017)(71200400001)(6512007)(186003)(8936002)(2906002)(38100700002)(122000001)(478600001)(2616005)(1076003)(4326008)(4744005)(83380400001)(86362001)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?pLc4Orkz26FQB7RxUXbLb2cxleTMrtoPrfHTo1F+nj4aKHgSdy1Z2SXhtI?=
 =?iso-8859-1?Q?6WRF0z/VBcJH7/ZCgjZbfSMaWNjjmYK7UXMV4/tCof1WzMLfOzCd9FZMqW?=
 =?iso-8859-1?Q?NTfmP7n/aEdHOwdkzN7iWkDKR3mQPyyl5xFb4jnAXDhL5OT3gmUz5P9WDd?=
 =?iso-8859-1?Q?n/SS7BSYHeDPSc0P9XSwGwaIPyz4PS4kpl5d5IZXvbvp22lw+WZG9m1Npk?=
 =?iso-8859-1?Q?LI7s/yV+ZWcfM5f4ATF2ZnSF5A9K/neyB4J7ub9qgWm66PldT8Yf14KsQb?=
 =?iso-8859-1?Q?3jVzpspsjtJ5eHgbPTizxIIJTQgOjPcWMQHVP1cwHl0ABz6kk7cFJQQwt6?=
 =?iso-8859-1?Q?xvb5fknwmmqtpW0g95LnZdmtMwAiOr8mEEXtO4uk0aArmcFOZ0ZnCl2HpG?=
 =?iso-8859-1?Q?FqUJG3BzV8v9a9rRem7oIz8hQ7Z8HfS1KIqWGSVl7HazR6tpTyK2OP434F?=
 =?iso-8859-1?Q?YPihYXXX57gnnfzp486obgazXr/I2M1P0RSDqejxh/lWv4XxwrHLh11yBy?=
 =?iso-8859-1?Q?WgEyzbJaEl9a6hcSg43l14WzaIz3ogWrPd73zQd1bkDr3GVTarI6soyRul?=
 =?iso-8859-1?Q?EDUajmgLe91M49i5EchpqV2FebYTIRLnIF5m7iLb5WqndeQmiVOuMbcW8o?=
 =?iso-8859-1?Q?cRBZRzvqxAbxx940RiI4P7XnYdkTDEqcjRw6tTIhiB5M5hT8nPgFqCb9p5?=
 =?iso-8859-1?Q?mwkQe2hT2SGTyZHDBfm3RwQ4FCR7HiS7nvL2TeyA1BvClN+3JGx4YUcAvP?=
 =?iso-8859-1?Q?lvForbMcwyhS3xP1wR7JZSa8n5oHkklZd+D3UF6GhfLjrfovmb0aKCbGRM?=
 =?iso-8859-1?Q?yuFHfSkql7gdtujmC5VyPqyBN5m7sh+4GgtSVEfcphEnHRT/8x/O/lSMVB?=
 =?iso-8859-1?Q?/xVUYnMYGRZwNgekAJIUmI0ssXWlh9xhTlrTI8N3SLUYh6A/l3PL0cn120?=
 =?iso-8859-1?Q?o1Lam75lRJpR8Rjb6VJ7GAq0ii6SrRBoPBgB5ew3Od9fVQmnrRRvwmHkoZ?=
 =?iso-8859-1?Q?8NML/kBg7ppX+Pks9jcGndhc1hDFjkEoFK0AT4JG0T3Ft7JXWO+Ap8F/x2?=
 =?iso-8859-1?Q?BD2Wzw4B8nxNbVxIDSZm5cPsnu1Xb9F/X4ag3TA9E+CW4m7RByrvIMLdlK?=
 =?iso-8859-1?Q?HeltW13ktxfhlvTC4dWA7qXP06uhMFf5yYyrDT2OprLKas8m0HpfsGO3cx?=
 =?iso-8859-1?Q?U6aSSmuDF5vljgCYxLmePLCIDfBIeOkIF0vjxjJXu2iZDEZwS/tHlCWlKQ?=
 =?iso-8859-1?Q?p3UIRQiLCiB2/Cp98hQA0aPGq3aGf9B17RlbOrJUZUIswwqhi6d7+EyGMg?=
 =?iso-8859-1?Q?xqeViViItDkMrPOMv7N4fWQzUTctD6UelxffpFDDJeJHqxSzUaY1j3qxcU?=
 =?iso-8859-1?Q?2+qVLy3x+3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e6cd9f-f0ef-42ab-72e5-08d9243baa8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 13:54:53.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yj1xYxyhnlFEs1TQO6XkgCzPahLrR1Ftxd8HmYhJh4nLDrYOLg8L0Yt4dVTd8ceiyatCf+b5xBZq/E1TyFLZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7349
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Performing a BLKREPORTZONE operation should be allowed under the same
permissions as read(). (read() does not require CAP_SYS_ADMIN).

Remove the CAP_SYS_ADMIN requirement, and instead check that the fd was
successfully opened with FMODE_READ. This way BLKREPORTZONE will match
the access control requirement of read().

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 block/blk-zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0789e6e9f7db..e05fe8dbb06d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -288,8 +288,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev=
, fmode_t mode,
 	if (!blk_queue_is_zoned(q))
 		return -ENOTTY;
=20
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
+	if (!(mode & FMODE_READ))
+		return -EBADF;
=20
 	if (copy_from_user(&rep, argp, sizeof(struct blk_zone_report)))
 		return -EFAULT;
--=20
2.31.1
