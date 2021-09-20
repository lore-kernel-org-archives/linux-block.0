Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D252C43217
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2120B610A1
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhITMzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:55:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27891 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhITMzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632142450; x=1663678450;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=XXv9SSvVJyn1eAUdz9PC5YF1o6BNE8crFEIOQPwEy6kh/FzV0pqNNUW6
   MXYzmh0cUvqvphKav9tGnWG+9dEekRPQFPUwbNGvJSpbd2kRLoN+Aa4KN
   dvvglRifBMcn4HtJa1QwC0BVf9HpBDEPGDJTC8k3CU69M3/GlzP3Z1EsS
   HPp8Hp/ta0885sK4v40TGS1ehVDF5vFRINJaDCrOojfyeJjKrDU1+/Tgq
   pZmuT62EyqHqKFFMvQgx9ipdtGBtc2zuaCn7VVa8el3srg3OeQPIBRRB+
   Oz2N9ltDnQuxBA5N38cGmG6tub15l1IP1TYe5pf7iPZN+pI1XpmA1wPsc
   g==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="180961601"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 20:54:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eibsNm2UOaL9B3sHVWm75oAveFTIoQVdLS1ftRu0njl8H+UaSZ0XuzkWKwuYrtcXP4PvotneBfY1Q0OMBj4UdkczvVrlxOE5dRzMW9NrjraYH1Na9FqWXSJoV37VNV6Yl1u51olXYaUTxIyxmzg7drrwk+zKNTpoaKybMf5tP+zKDBJPzSn2cN+8VExp0YnQTR1Dm7F/4ovFPlrYPkupV8dB8qSgP/NvT4U173yq/486WnrvpythVHecjnW/tjGoC7Fh5Wd/nGX0KIJ63R7WiCJRLosGqSrrBtJ/u+vdpTcFdMuAq5JgzQ3tlPT8B4WOwu/M1WGB4sY0TFtFw8UrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=K0AcbTat8a4Iu4P6yd6nxbPwgp0x8C8UFLicNyMQKuZkunFWRgkD/RmOw4ryKK2T0CN7g1qRKTS47vrbiGlIO2KnefLk8YfmioT7otaN4aufws53qyjV6GZ4HGtZwQHk8AzW8JaoXPbV8hyAwqh/5HTCOfd4DKJGeGhxdMH2mCS5eEZX3d4N4DXgRoMarjo/zEIgimi+RVX2T541klsxkRaTgJ62hP5ZAER1WKyDBWsQtjYD27NExtJjSrI2InL1fHOSwf1UINg97J6ZHMgpx5CPLuI4TAjYJarTUAbsncbTN6zRs7nBij/oN8WZzV1klP4kZHKodrvzgWThQOnmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=RtrLSO8q79jInrpdcplggsDVTw6dvF6pzD8Uojdf3wtArSxxeligw/SpaIwiV4y/xIy4NfXCbZ+U6B3EQyCPOqdQURxWydosX8KwCc/oVpkmsaDCOlgDy34vcSLqU6b9nQEw+gatKbPHv35mnHt4JJqvc9h/pBxpKQXSWk7cAr8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7703.namprd04.prod.outlook.com (2603:10b6:510:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 12:54:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:54:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 03/17] mm: don't include <linux/blkdev.h> in
 <linux/backing-dev.h>
Thread-Topic: [PATCH 03/17] mm: don't include <linux/blkdev.h> in
 <linux/backing-dev.h>
Thread-Index: AQHXrhv67HEH/C0uZkyPusnYU0/fOQ==
Date:   Mon, 20 Sep 2021 12:54:07 +0000
Message-ID: <PH0PR04MB741618073F35AE483D555BAF9BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a303e30b-08c4-4060-739e-08d97c35bbac
x-ms-traffictypediagnostic: PH0PR04MB7703:
x-microsoft-antispam-prvs: <PH0PR04MB7703BA5AAFA2C28CF515075F9BA09@PH0PR04MB7703.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvKILOJCDdqUkUx80232h72HuH7c8GF3tSysqIjL2OL/67/202Kcv5wciwmoB8LooXu+HVR8nVnXcgySUeHC5pxAKQ1ELgXXogh77l6c3kDMy3o5b7YfXlb259Wo6v89nz1Wou+fFddAAdyYMBMM7vUZysnGDZHwwkhFGUhQVWGR3GGnf3j0D34S7495NmRj6egbmyW3N+2qW8o55QlC1cor44sr8NwE3BqCV90HZ8y41H1ULzRge4OozNDFEwX+WD6cvwB5+AqRVi9SHKa/RYNuTQL+nBTcw8aY/qUVFS6nmBwR8h4e9Yq/suYb6mUfqTbSDyURFIe+pka6RJnmlj/r9P7b1OP3hKr2XOHnBTMTeBDovTFznxSSWAYh9nv64tATkgte+gSOit4dmsoNkWfDeyb9XtLKgVd/4NsGyM4M1EbQ5wZ0BZXo41l5O1SBi+tyN1EZLXVQFbyvcGiYrUmTYWVc76CqwpRO+riejxDV8Syh1Ojkvn5nEUbjReI5f/6252jRUFH5IlKtECa9oOrg+QW+8t80rH/tGAA8gDIBbCGuOhkiovN1rVH1AVHhYInsS9ZB8n8opgYXz72qpMRJvu/d3gs+ubCBIthfhbjUab8F+IReAoxLwdnmr0ZGpPo+YsiMdWRDuFFZvZ9TVoH7Wq5/a/eV9C9v3gzlwHn2kAowQLsVCTbLDNQuElZZyJP/30gb1XaUaC2cNCt6ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66476007)(64756008)(66556008)(7696005)(71200400001)(66446008)(33656002)(19618925003)(8676002)(54906003)(76116006)(2906002)(9686003)(122000001)(52536014)(4326008)(66946007)(110136005)(91956017)(38070700005)(316002)(86362001)(558084003)(508600001)(5660300002)(8936002)(38100700002)(186003)(4270600006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cqDctO9G8HpUtepjEmiQcz4DqBZWKJE5zKRdFCB4FyjtHl8Bh3Oq/ijYtOcw?=
 =?us-ascii?Q?zdSgksmdY/6NLB5m/fggTz+65jq9KuAdFmtbCHCOH3habNnLDT1QqoDYld7L?=
 =?us-ascii?Q?shf9XCV9i226dTSATSY+4RUSvHM9Xk6CKjqpydaNnMMpLLOxP3u3u7fYl5l8?=
 =?us-ascii?Q?oOxNyL+4sOBzWi2mZDAHE0jxeKnUPsV6hc5gLdUpq7xXKpgdXDHnFgZNU0++?=
 =?us-ascii?Q?Vvs+KYQv87uHxCdmQ+0wcO54H/HehcOaSXLLEdHt5GEg9MR5VNzu6czZyRha?=
 =?us-ascii?Q?zbzbGYKCEwepEw0Oo7rGPNjW6aJfycNs1I0O9blZp2ua+QgoHukz49MQoAir?=
 =?us-ascii?Q?MLgFFadRAQJMcNBNIIQzL3xX8Mowq99d62wtV/M+L5N+F1PvuEXDyQ9oPIpe?=
 =?us-ascii?Q?jtepH8+4LK/U3f4R0PbicSYIvwHvRHrEQOZIuzzxnwYkomPIH8XST6BWhp4L?=
 =?us-ascii?Q?AVx/BW2E9Wxlwi1dxOx39lk8zBQ8OmKUsn1tR/MZYV82N6Dpsc0LZRkKu6Fc?=
 =?us-ascii?Q?sAFNTU9Gxenp48vtQ7L/7XbbQKFggC3Zs4LqbizyEv1mqxIf197KCBAGXxBk?=
 =?us-ascii?Q?cDc0sdrn3bmf9I//OJ0L+IKrrFdxMlCR8zH2rH1YmIOqxOffpNXjOUteyQRY?=
 =?us-ascii?Q?yi7564DfBCmZlu9KgfQjMU0iGlW+zMTZLfM251wv73QGe+n6fCKgc4gDUS04?=
 =?us-ascii?Q?Wla/MAm9NCO+lhLjMxsKjPSklqWhWGIQrBJbyCSp5KnmluQEjUYUBv6h97vP?=
 =?us-ascii?Q?8gZQAGuV7CT2Lv5VR0OFcGlmEY8yBJKKv+BahQ3RByhI5Y0F33hSB5UMgT6z?=
 =?us-ascii?Q?wBY9BmnhCc6jdiNHLQNPtRbAHiDpTuMSM3TcQvOWrUMoPSPJ0Sg8roNVSPjm?=
 =?us-ascii?Q?kNe+iATiGKtLmp1u7M7rG+AUL5/ilWmWxViH9WyYNI9YRJCf0x9nobOc/M8I?=
 =?us-ascii?Q?i5AYFCyfaQinV7LhBqIBkYefutpuzECaQJQrXkYm3XCu9KIQIv42gMtif7uH?=
 =?us-ascii?Q?d+HNL6XUZLOFQuJG6rPhQ5Gt8/a2udP0CILqDJuH56IKvhVZb0g3V9DUo+hG?=
 =?us-ascii?Q?x7YUWTminAy3E+c+gpQV72HSwAWB1Sx6bEzvYl6Vku8xKgOrS641dSuBpXCY?=
 =?us-ascii?Q?AnxeIq8sl5lQdoT2GzYERY27Pd2bLJak0g6SgT/cCK0EqXqR6hGZzWv3m9+m?=
 =?us-ascii?Q?eZiOTN/u38Gcj8lGLacY25sSelN6lwX49JQjKIdCel26uZXiQR9DQCEGzGy3?=
 =?us-ascii?Q?z1yn5rrPPknFdk4FqJvK3ByevOBdjcxGacbY60WVGMtLk+OFJ+m23/0EH2ym?=
 =?us-ascii?Q?INIOEvBVMhOzFPzE5WG7fSZ/4Qe7kW/DXeTd/2fk4c3sEmGFNN6fkarU0c9Q?=
 =?us-ascii?Q?nr+Gsa/YKi45u9kSgs2JXSi5qx7448e6QjrRocchMf3mLQhsZg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a303e30b-08c4-4060-739e-08d97c35bbac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 12:54:07.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kv0v3eVJFfCGG9s2RVOAQRZTAHivJgUjhn/xANi1xQ4nVpKlwVcK/vzxk333N5L8dPkqe9rGP8F4Den5qh8oc6DUDc6IN9NfwG9hBzY4zzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7703
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
