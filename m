Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8F0C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 23:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3920855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 23:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BO2Mrbl3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TlmuGX2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAQXq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:46:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37423 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAQXq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 18:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547768789; x=1579304789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=msfv+9HdCByARxEA6cTAdqaNKeUJT7wTtxfETU0b878=;
  b=BO2Mrbl3M8F1U+f5ChW/s4RRA+42WgBfdK0x3gYAK7HCd0BA4yxdA8Gs
   Duql2H9ihF0I4+RDFN178U7KjVOINudtjMxsg2C10MWyBJAb88fe/LHRS
   jeEoZcuZRgwpEKfiBXNApzPcw0Ew6d2W5K2ogMpMbuxJFKhDLRuPlfxdW
   E74+1IHlTvhQNfJHPA8KGLajZ2baFWTqVagXuxG9Hi2uu0wMUcgcNh4JE
   bNdcTz1cTQ35WYDnUW4krH7+xd9BmgJGgUxaOuaqfAWaFtw6SjK/EfkCj
   3EH0mdYTxmMa3UJy/SqagA9DsR0ofpyKL6a3ecsJpMnjbznObBieG21fi
   A==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="99123379"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 07:46:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vK/I9l8MvZPZ0rkDEdxg76hxbRxrI7msc6Kxsi7I7w=;
 b=TlmuGX2L232EGm+BiYLQ91c9NZQuTUHvZLIo28lrAp3G2hFMAgAHI+633JYW+jesUB8RABchXJbhSqLDKZN2fCGD5wYe8XGZIYWYftlaJXUACYB2ds/Vrh3w+KnvIbl1PIigr1/we/ZQtlDKdVsn5B2+4I0HymL1Y1iUIiwaxFQ=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4727.namprd04.prod.outlook.com (52.135.240.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Thu, 17 Jan 2019 23:46:26 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 23:46:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Omar Sandoval <osandov@osandov.com>
CC:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed
 namespaces
Thread-Topic: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed
 namespaces
Thread-Index: AQHUrmR4qRT1ezDLmE2OtZRZp8tpgKW0H7tw
Date:   Thu, 17 Jan 2019 23:46:26 +0000
Message-ID: <BYAPR04MB45024AB8410374A9B1AD81A186830@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190117125906.15479-1-jthumshirn@suse.de>
In-Reply-To: <20190117125906.15479-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4727;6:UBUIEdKKcIwTq8GgrV3f9rIsuTVrMqBUmpQaMgxeBoa1qyVC25EM5fYUSob53PiKZDUBSU1lKD6nGP5o38TMsl1d/bqiCPqJ2MPDGR7FesZtxLdHeWKbzytj28Y/WT2dmnLHtnMCG43iNbtxYRmv40Ma73wDDQqPnSB61SBnVMgYMFng7lu6pJnW3OPDPv3rBheTD6JM9cjgktJo+R3BuL3XGOyPwZ8wTJDLOU8h7sLnx6SXd6SE99nDyJEX2JZMg3N/NHbVmAF4/drnfMBoj/cfrI2QOuEbUaZPNnvSBQ0T02K/frJ3zbk95olOjiz27sJYfdiSWhkhBX2JHyLf5idlGSVN6Ad0jEw2gfE15WbX5Uw1eIuBuG8EcWjQXtQ4X1FU11XWt3M3x5Xarpy+iESUSsIwY3UIeBxcQyKt4CH6s22G9r7oGR+SAnXs/xlG4Dga+Daa7CoTryx2g4PaMA==;5:b2PwZKcBz64p1BWYzBsXqsUBmTHcjn6BarlFc/2sL3Xnq8BUo+LX/GXtw3qCIuAyZ5OT4qPBKD2On3vxcytpmmhLHkZpbB6xbRniSLbRQFp5kVkXR/V2Jl4SkclzAniJ0p3EdjbL/HrjcYmIYFg5zvYZkxvVpMk3p74+QqjpZ/dLmykOctChUjE7+c/g07cY3TRU8pK4Z5JrF5/4z1MSPg==;7:qVmtRf8PXLAoG59mDo94ebXn4Dg00WIMkLhTJHSUaohUMlKg6rhDB8A8Q0eI5ZqI3I09YoMcF5MeUG9rzu1B54L32tnWQ5prPivvzEKv7st1i6sroiGdAyzYtVMroUXNalJxq85sZ/tRAzo1UMrREg==
x-ms-office365-filtering-correlation-id: 87aadf34-6eea-4374-5238-08d67cd5fedc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4727;
x-ms-traffictypediagnostic: BYAPR04MB4727:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4727FB08EC79807E4F4F4F4086830@BYAPR04MB4727.namprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(6116002)(86362001)(33656002)(8936002)(72206003)(7696005)(74316002)(76176011)(53546011)(66066001)(2906002)(3846002)(102836004)(9686003)(476003)(4326008)(6246003)(6436002)(256004)(25786009)(97736004)(53936002)(6506007)(5660300001)(316002)(186003)(54906003)(110136005)(26005)(229853002)(55016002)(486006)(305945005)(7736002)(11346002)(8676002)(105586002)(81156014)(71190400001)(71200400001)(81166006)(14454004)(446003)(99286004)(68736007)(106356001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4727;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rtkGI/97HoQ8capg9Wo6tbwDcUgdhY35w5TMyBaxmAyAHR/cS7BM/Vjt+/meo3vqHPfYUe6eh9uo8bT6nWq3spFE3/Bs3l5K6jroCJh4UBoLF+TIwCM8Xj9Yb37Uj07PfuSQHSECjE+0SKn5MntAEjupfWq360LiJUVuNR+3QRVbgp3AUWdaRiNA9rp46yKiaLkKBvNRlfxz+F1yngJ3w3uCDm1agSgGC7FMv5wkHRn2GTfvpVh6GTkzZR9sMSi93vqn9ib0Y4Hx5x+CaBNsEr7ZTis6GKqPTZBCJpBQ/J89vWXXGZREZuf4sVGhAPSbdgFZiZQS8R5CoWy/JrjniU4f6fiysHC8NbvZqS6OqQvgiTeyxgwDoL2XYBCXsK3skKXL9eb8qp4Q3tupnpf+h3l6dyotlQ8tcLDVw+mrkvo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87aadf34-6eea-4374-5238-08d67cd5fedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 23:46:26.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4727
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This will force the user to run all tests in the buffered_io mode.

What we really need is a config for the nvme category option which user can=
 set and decide
whether to run buffered_io or direct_io, you can set by default to the buff=
ered_io mode.


From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Johannes Thumshirn <jthumshirn@suse.de>
Sent: Thursday, January 17, 2019 4:59 AM
To: Omar Sandoval
Cc: Linux Block Layer Mailinglist; Linux NVMe Mailinglist; Anthony Iliopoul=
os; Johannes Thumshirn
Subject: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed name=
spaces
=A0=20
=20
All file-based NVMe over Fabrics tests fail in my test environment as I'm
running these tests form within an initramfs. It turns out the file backing
store of the NVMe target defaults to using direct I/O which is not
available on tmpfs for obvious reasons.

If the backing store of an nvme target is file-based enable the use of
buffered I/O.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
=A0tests/nvme/rc | 7 +++++--
=A01 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index eff1dd992460..ec92e41396be 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -48,7 +48,7 @@ _remove_nvmet_port() {
=A0_create_nvmet_ns() {
=A0=A0=A0=A0=A0=A0=A0=A0 local nvmet_subsystem=3D"$1"
=A0=A0=A0=A0=A0=A0=A0=A0 local nsid=3D"$2"
-=A0=A0=A0=A0=A0=A0 local blkdev=3D"$3"
+=A0=A0=A0=A0=A0=A0 local backstore=3D"$3"
=A0=A0=A0=A0=A0=A0=A0=A0 local uuid=3D"00000000-0000-0000-0000-000000000000=
"
=A0=A0=A0=A0=A0=A0=A0=A0 local subsys_path=3D"${NVMET_CFS}/subsystems/${nvm=
et_subsystem}"
=A0=A0=A0=A0=A0=A0=A0=A0 local ns_path=3D"${subsys_path}/namespaces/${nsid}=
"
@@ -58,8 +58,11 @@ _create_nvmet_ns() {
=A0=A0=A0=A0=A0=A0=A0=A0 fi
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 mkdir "${ns_path}"
-=A0=A0=A0=A0=A0=A0 printf "%s" "${blkdev}" > "${ns_path}/device_path"
+=A0=A0=A0=A0=A0=A0 printf "%s" "${backstore}" > "${ns_path}/device_path"
=A0=A0=A0=A0=A0=A0=A0=A0 printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+=A0=A0=A0=A0=A0=A0 if [[ -f ${backstore} ]]; then
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf 1 > "${ns_path}/buffered=
_io"
+=A0=A0=A0=A0=A0=A0 fi
=A0=A0=A0=A0=A0=A0=A0=A0 printf 1 > "${ns_path}/enable"
=A0}
=A0
--=20
2.16.4

    =
