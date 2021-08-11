Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B80C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB49460FA0
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhHKLFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:05:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7788 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhHKLFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 07:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628679922; x=1660215922;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FXDf9bKNi+kBVdPmyJ+MbKV9KXfgIElXmOhLzzaWb/I=;
  b=l6PiXZyNcxrWZhlUdbw6UxACPqu0mEIfL2URPqFkWAQFEQXsppzFRnaT
   d0FuLsyEKlj21Ntdaw0FgQkOomGyiiFCusZLnJ0HVxjnQNngc5NeWr2e6
   2RNkMb0LBjD6bjJO+UcpKcnr64/pMpyHK5CVYj/q6ps8JtTbHTAA3BotE
   cqFpN/GcKLhHKC7euSAMYAfAz7+V84kUIbr7gQKNcZuYmunqw5K70qtvf
   pa3tNBWfhq+oIGhX8/iqy3/xkO/IaRf8RVQSpOsQNqlZ/rylYRNCsJ6fi
   Mkk0nApXc0GoZtTxip4XTjvwMgwZwyeojdayk3O4NqLcmkiBd/Bjns0yS
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177488429"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 19:05:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWNYJJOyKnlJy3I02hRFgRC6KgZVGFevu4kTI4rw1THPVisdQyhPYRiznLZsjjerCw33xmVGrtCFL3zCvo5aCzX94xcGIFto+fwuAqp+JoLyyQXTbENr5xMSY0sny55YnK7UFkY7Tf40JgGrb5Vz2ATiW1wo6w4KPDhNjZAmX7sSEX5FM31MSmg2OYKBpcgQqCRTUxit4u4G8wTXjaYylQF5JDTcL7wsDzFr7H3Ti9biBzHH8Lsd9HjWqrRcUV+75Dn8um1LqNrtPY0mUHyvnh10R0ftQan9IK73wZwgiU2DynMQ8BqDOrLDru2gFDLPOHQqMIoiomurUxYKO27BTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpEEYZMGxBW4yojBdeKHPShK451WnW6kIynp1pcme1k=;
 b=aF0gDZkkHk7hhd4UkreS3SKSmUa4HvltRxC/IgdhAe9Ymu6poK78vP6hUaxECO43CkBC3ptrFxTon91euRjvcmhM6wOHLdDnc4rLJAY8kXHf7bqYJT3WAKe7Mne1C+hqYbYoxS1N2ukqYm8sqoWUd2SIfUadBsvLnaJNWVj6fjCdOxqWnkRBkwPZaW96TYt0xmU6fKr/PgKDICsk0JLZbAmDl86PL3HHHBB4To3QRsZMZPKHNbAPpbjQhxzTtQ1eRQylJzI/Y4lHNlquTuypcXehFPIBODYu9XFhY5AeyAXBttx1v07ljcD5zzvpWRqxhJDdxrzyDnmoof2EqVkWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpEEYZMGxBW4yojBdeKHPShK451WnW6kIynp1pcme1k=;
 b=ben6jJwy+w2CwOaT7vJp/hLSm8FviEVLHUxy8Kg121Odr4VuSPBuqgbOfd8+uEDdheSh+LqkK4Jr/8tVy+c+dayuP2dXBASTrFUmZxqR5cLoMVpsUonvxTzVFz0MsuklI1tJkYx5Iaw5T0ZrCp5d4e3Cx0tvMKlgnnLkeKUOEFA=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7719.namprd04.prod.outlook.com (2603:10b6:510:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 11 Aug
 2021 11:05:17 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%9]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 11:05:17 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Shaun Tancheff <shaun@tancheff.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH v5 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXjqDEw26ljMS+L0qmGkbEyTftKg==
Date:   Wed, 11 Aug 2021 11:05:17 +0000
Message-ID: <20210811110505.29649-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b03f6c41-5f2d-4366-a565-08d95cb7e725
x-ms-traffictypediagnostic: PH0PR04MB7719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7719EA064036F1493B678FD1F2F89@PH0PR04MB7719.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NwI84Qu95zUsHQIdVNEu6Rue3p1YM1LYNCu1GCSo0iEhvO5DYu01blZtTCinj+RdUEzyG4HbXUnHjXVxBJnofYQNsBQnIWS95+LvXFu2ay35CVsQT9BGFAAe3gMnLS/PO4i3Y9+JIFUsOVe2zfQul/Z02lyroYOY4tBjvzNShGRPmounBxFVVHZx/RwjD+ylYftPL3aDFHcbZL0voTfD//NTAf3S7Dryo+ZxX5g4N7850OccOoN7XYF1CYSskikjBclcSBTaxzK+cPrB0a32mJ2J+kgqJVrkemZQcxVRD80JPbj0sEjjtxwvPXmiD8e5YqcGYxOBXwO4rZkTKQFyQNMdSAgGGJv7gNuveA3TNi+QlxmnKP268luQOujK2iWX9dFl1wPhDf0EK6KVOBNEhwQh86+vIijo0Z0+9ajhhA6E5xHqXxdt/LDc37o6eVWu4oAvHuzwhcKeTWIX3lwA/5Xu0h0tJaWPt7Ci70lulJKpARD4sIKgLlRMewgtqkGeOUdMqsSow9YMcg3CAYG+Ex12nR101VeWXj/Xl0yadF1+h0LQEnFbDz2p8J05aczGJuE2t7M33MVy5G3M/mFuy8QDjQzJGMA5nEHIqjnYeAF3iYIXF60f3VVXncaxg91F5/JDcmWglH5KzHC2w8ZNN09ZmmxlegvgetGyLxUSRZ13TBHEqQIW0o1YKTwZGKJmik2t6AGChW+IRLL3EbYl8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(86362001)(2906002)(5660300002)(6506007)(316002)(4326008)(6636002)(83380400001)(6512007)(38070700005)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(91956017)(26005)(2616005)(122000001)(38100700002)(478600001)(54906003)(1076003)(6486002)(8676002)(8936002)(71200400001)(110136005)(186003)(36756003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3n3wORHis9F/wZ42l6qkS3lw/pZwU9s2ao04kOJDo0xwRS6Cs6qwwHwWHv?=
 =?iso-8859-1?Q?H3J9BSyJ6xVVUkHwrBxmV14e5xB5hiwu9vHbAHsAib+u2DDPUg7a/EmJ3g?=
 =?iso-8859-1?Q?AZ9b5w7YO6ppSWkJ8hWaijfZ/V9Td6QtBMV4lh7E4LeBC2b0ZS01tC4hi/?=
 =?iso-8859-1?Q?pKCn1F7ZLV2sgZkxuqTo4u7IvqQlsjUuHMDMFM99sxFhwljK7Dse697X0Y?=
 =?iso-8859-1?Q?uvVtppmBBOFwuvP0OG25piZ9S6N7ay4vpJiDcoM4JpN95GGsTXf1Wi4QEX?=
 =?iso-8859-1?Q?2k3kjJGFQKmYKkHvAfhA+HhXuwXNlDRVmheoxYzRmq5ngFD2Q5fXeES4i7?=
 =?iso-8859-1?Q?l0e+0tinMiXKNIhuScfzBlcszc1GuZjbKk3dhYfYK/BiY25u1zVhVGlV0Q?=
 =?iso-8859-1?Q?r2Bjqqzb6orYnmDX9ybHpcFDSgMgMQ6WzdE9X6cNuYIX511ZlflPrO+qbE?=
 =?iso-8859-1?Q?nXao1piTBJowKxhqWGlqzRzi+pjzuBciLnVR5s7FkJr8InvhV4F6qmKLfU?=
 =?iso-8859-1?Q?ZGG4OVziSDILnbrnpPGEbruCBG2P5g5HlhaIMyFQZf8nmxMnfQUQeDHvRS?=
 =?iso-8859-1?Q?iHA6CVz11I9KrEZUf97OFYv8K2nJWF4/eZAXNu2ETtPAt4mzgHUiufrqE2?=
 =?iso-8859-1?Q?w+eVLzlqFzd3JKY6VSgO8pVbQ5U88kUo+ngxYFL8qKMOvgZhTJ5HTMRrEB?=
 =?iso-8859-1?Q?qSGZjJb9MhAfgFzN8fBWi5s9ZwFsLFruKB1FXxEJU8sW2Obph4Fo7Xk7qx?=
 =?iso-8859-1?Q?mMBQV+RJUVfjoMQ4uTortcehZQFeQG9mnCGxdettSG7+JeKgPJDjlDBhes?=
 =?iso-8859-1?Q?Onv9Y+xA7qsXvhev4YtDNilL4UgZU+YuHyDjcPl0AuWPzjJjE7Rxh5NQZm?=
 =?iso-8859-1?Q?cUQWYHiQgOkNhBKgQNycf/ldYg66lTJIJEIHSyw9PukBLlIgyFwtM1Ay0r?=
 =?iso-8859-1?Q?P6d8HNLi3BT0ZhUrdaUP60a/L6W/vxDeNPYb8+wzO+/ECGqojtrQdmXRbA?=
 =?iso-8859-1?Q?wfYvw4OZPvZ4MfLwPfirEUolbu3FCt5dEpGSebF3OSlaFfUAs11n16spmw?=
 =?iso-8859-1?Q?b2aGhasM/fjb2e2d6E4+U3dsnZ+UGjjB/8c/iFCWefTs00PFE/UPIse7NN?=
 =?iso-8859-1?Q?KloFLIeGpySONtLWOlz1npO+gAqZ0ELFwWf6mlN3Bt2RRZEF5eX4aS02dC?=
 =?iso-8859-1?Q?bd5UJDfLBJAtx94uAZYAQnwSmh7jK9X1NCXvbRwf2PqqRbSKkySDBWin43?=
 =?iso-8859-1?Q?Km+Vx72WnMh8mWzaVoqDT3UnvxYHkDpT0oocrtVzS85Vt6X7gb1j6HCQQ0?=
 =?iso-8859-1?Q?rKOr+IJpH2UqiXCdrmXxW7vhK8LKeCnnP4lh79drL7G7AZNn/HQVJyh8vU?=
 =?iso-8859-1?Q?RisEqcD0q/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03f6c41-5f2d-4366-a565-08d95cb7e725
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:05:17.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuhjpX8M8D9rueKFaNkgqy3tBnvPjtSyZU40CoOMJvsO634fIPxTcY6JSQa2WLmlu+4J+4BVbMVHGIzw/TB5PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7719
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

Changes since v4:
-Picked up additional Reviewed-by tags.
-Corrected Damien's email in patch 2/2.

Changes since v3:
-Picked up additional Reviewed-by tags.

Changes since v2:
-Dropped the FMODE_READ check from patch 2/2.

Changes since v1:
-Picked up tags from Damien.
-Added fixes tags.


Niklas Cassel (2):
  blk-zoned: allow zone management send operations without CAP_SYS_ADMIN
  blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN

 block/blk-zoned.c | 6 ------
 1 file changed, 6 deletions(-)

--=20
2.31.1
