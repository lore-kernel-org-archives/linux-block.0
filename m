Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA8AC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7122089F
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LYou0Ty/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oJmt5eUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfBTSQq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:16:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2215 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfBTSQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 13:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550686606; x=1582222606;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=U8ldA4D5gcyD8WbZC/6qOMO1Pj8DDQw4OlM0z8hsMAI=;
  b=LYou0Ty/hKUQcf2d0WM2Kkzo6p5+TmjbzB6bWnm0YjTn9+NMmot07XlY
   U3G3NIhPuy/kSQnw6HELO2dlCxw+iaOjf0TMvvTK49sQ2G7RqwEsxP711
   G3eS6J73d/mi33CPavdY4JRpTDhg9t9bIqqvs0BKH85bEs42EWSI9A4ih
   8cX7tmkS351ypZVbA23H75PEJP8LuN1MK8yV7LMpHNATo/jEtV3Y2/43i
   lf9yB8/MTsFzY67s/BcfEqDd9wAiTwXv6Oz3kHsxyO2HdLU+OUlbXPANP
   cGe/0bODVuuPrxWvDt/J//5WXAngSKQIcKoKgKeopBai04KS1jcIjjEAn
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,392,1544457600"; 
   d="scan'208";a="206959639"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 02:16:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVl3gIvfSX56FzreJrNQrXVTmlXvK4OWcuFeIzN4muc=;
 b=oJmt5eUMXrXEjJwjxoCaf+VEoK72dNRyVmOU81tlC5aBWeeyfNuJ0Uvhn7idmdzVG4CN9P3Lc+OsfXFJtV/rjiJe+JlP+f+O+SySHSDb/+/YPoz+tXGWuxLFa92j1hK37jFcgDRfGA1SAJxuTRxLEtOTGBsQOedcybkrvWL+ClU=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4368.namprd04.prod.outlook.com (52.135.72.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 20 Feb 2019 18:16:28 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 18:16:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Topic: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Index: AQHUyMoAEYk0t39XfkCklw1XmMrTmA==
Date:   Wed, 20 Feb 2019 18:16:27 +0000
Message-ID: <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190220031122.GA17298@ming.t460p>
 <20190220141701.GA26537@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07c39226-5f06-4ec3-deb5-08d6975f8810
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4368;
x-ms-traffictypediagnostic: SN6PR04MB4368:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB4368;23:D/KcTrviIMMqqdcpRdhiHTXGwMNNyKVTP8xPj67m1?=
 =?us-ascii?Q?pc/YSY5HLpQX0eJ0Bd6gTLKQDART93CFn3uBSTyG+/9Y1S4+PIj9gAggy1Pg?=
 =?us-ascii?Q?oDDUxg9yvi7LW+wREhkcs7yi9O/I18uJzWC4DCK2eBi8eZlzIvZs2f8IVVVg?=
 =?us-ascii?Q?VCfcndE6VvJInc7HTWpMiN5tryX8eSsHe4kjbDWPL26JBaEF9Zpl5RIQ9DtP?=
 =?us-ascii?Q?kq62zoCKlE91TPmvnI7pF2RgxoezjR5u+sPWjN3uTvGJhFkwRBkE9SdFSZoy?=
 =?us-ascii?Q?s00twtx3s0qkdr79jmHw2C9W0ConuQKDuH+2JUY0qcay3Qcr208myIsSwps2?=
 =?us-ascii?Q?hwtbzyMdjxqabFHGv9X6YA3PlxIpBlXzUZe/eDi20GqB8KzTPdTIvpRIhUjV?=
 =?us-ascii?Q?0jwuFnLcSgJgyTQPgDtQRQiORFsw1qqaUkvHL/DvQ7SerqQ7JOb3aulzhgfJ?=
 =?us-ascii?Q?YFM6z950STComHTSEOLoHV1t7LRhbOeW1thcI/dAcTxmKbtug+kkEOaktp75?=
 =?us-ascii?Q?lv+y42SXdH3Ew937B4qNiih8ha/A38KvTz4BfHeI+q8hhWDei29N9/HpvbNL?=
 =?us-ascii?Q?aVgCeLW08xFRtPybNO9gCF99v5FCax31oHL3P6EFuod47lUfBZEx04a6Vzlm?=
 =?us-ascii?Q?1x8iMzko0c4IjzbbyX0Xte0//J6a7kwr9vjdK7lYle9mwOp3SzAb5fqTm351?=
 =?us-ascii?Q?a1ELZ825MTv9dqLdnfYS9vO3l0rpR52bpyKVBGTKFNGOX2/eEDBwV8h0PzME?=
 =?us-ascii?Q?rzsEee2bwzu00ISE1+O9PF+N5cEdx0crI7DnEPLfDN1RIkAZOkODaL5xz13o?=
 =?us-ascii?Q?a9dCYDVZwRNuwSDLI6qfPX5Yw2Ub/8mRmhInZRC6yjBtXAYdJu1aWn7SfsQf?=
 =?us-ascii?Q?S7vjWtaHMMpj0lXsnB+nWmEAGoLvovJKg4htjgZcvp/V3RCrt63pmb7ObfhN?=
 =?us-ascii?Q?M4TOdrBdwMGNm3VFBG7Oh1GFPWVdXI9pzfE5l2OwZVK2XledSh3ezi7vjJxc?=
 =?us-ascii?Q?eg+AOg2y428eRmhF7E08sOUkqPUgLLttkzxxm34GAyKR+EiHSsz1LzKeWIBe?=
 =?us-ascii?Q?yTL4T5IQduifx/BduBVEDbk4sHcdO/HCgjBYmtTeekI5MCMNqUY3eCTIQoWY?=
 =?us-ascii?Q?+pYX2iA+4fB0tk8/8LpYojufD+fkl+oPXzmeOWUb4ipCQe2RNUK49tMjMwOL?=
 =?us-ascii?Q?xn7fh+zgSQNiaI97eplrqVeqYIM+u6bcpPe2/mK6OnO+fMuZuwnb8rcEg=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB4368284FAEF092C87CDA82C3867D0@SN6PR04MB4368.namprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(102836004)(256004)(72206003)(305945005)(7736002)(3846002)(74316002)(6116002)(14444005)(14454004)(316002)(476003)(446003)(2906002)(486006)(478600001)(71200400001)(71190400001)(5660300002)(86362001)(26005)(81156014)(8936002)(7696005)(186003)(76176011)(81166006)(229853002)(25786009)(105586002)(33656002)(97736004)(99286004)(66066001)(6506007)(110136005)(68736007)(8676002)(4326008)(9686003)(55016002)(53936002)(106356001)(53546011)(54906003)(6436002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4368;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +IcTiEDtdSyyDvQURuhPVnkUQO/al8Cl2AUa/82dRs/0jp/6cbLz4MaobLOf7qLL5/VSXgAHHBq+tcnTsjINRYnYmuFjJ96QoUP3SmWY4Pa07kNF3EfzOLOrUfcNgnrmVtAn0iaU7PGGQozdN1WiTW3O61je2yeQsShdqXIRamObU0xvXxtwyp5LrWjOLRU6nkPnRapVPaii9Om1621e8PX4c056t3EF0jxAz22/tmGFXCTYRZCMPYPNKc+pP1hBI1x++H8yKPBSvufOiUTZdQEJ7gkNJ91w9SSRgFIemZSriBps0EebYEmNW9L4zQewp9C2+bzDsQC/uabRYSEMS26nqixH/pEJB5vVfXrZmbRAx0ZTiAhRPFNlN3bv0IT3BngKzZgY6DQZZe0OuSdfo1KimDULG+8UnQcIm0ftU/8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c39226-5f06-4ec3-deb5-08d6975f8810
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 18:16:27.8767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4368
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/20/2019 06:17 AM, Christoph Hellwig wrote:=0A=
> We shouldn't be allocating a scatterlist for a command that doesn't=0A=
> have a payload.=0A=
>=0A=
> The blk_rq_payload_bytes check in nvme_rdma_map_data is supposed to=0A=
> prevent that.=0A=
>=0A=
> Chaitanya, can you try to debug why this is not working?  I'm on=0A=
> vacation and don't have much time right now unfortunately.=0A=
>=0A=
=0A=
=0A=
Hi Ming,=0A=
=0A=
Can you please test following patch on your system ?=0A=
=0A=
=0A=
=0A=
 From 79e178a53a9f101d1f5f6a4923298bb1ffe936ef Mon Sep 17 00:00:00 2001=0A=
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Date: Wed, 20 Feb 2019 09:16:58 -0800=0A=
Subject: [PATCH] nvme-rdma: use nr_phys_segments when map rq to sgl=0A=
=0A=
Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to check=0A=
if a command contains data to be mapped.  This fixes the case where=0A=
a struct request contains LBAs, but it has no payload, such as=0A=
Write Zeroes support.=0A=
=0A=
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
---=0A=
  drivers/nvme/host/rdma.c | 4 ++--=0A=
  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c=0A=
index ac365366c2ec..c6a489049fd5 100644=0A=
--- a/drivers/nvme/host/rdma.c=0A=
+++ b/drivers/nvme/host/rdma.c=0A=
@@ -1150,7 +1150,7 @@ static void nvme_rdma_unmap_data(struct =0A=
nvme_rdma_queue *queue,=0A=
  	struct nvme_rdma_device *dev =3D queue->device;=0A=
  	struct ib_device *ibdev =3D dev->dev;=0A=
=0A=
-	if (!blk_rq_payload_bytes(rq))=0A=
+	if (!blk_rq_nr_phys_segments(rq))=0A=
  		return;=0A=
=0A=
  	if (req->mr) {=0A=
@@ -1273,7 +1273,7 @@ static int nvme_rdma_map_data(struct =0A=
nvme_rdma_queue *queue,=0A=
=0A=
  	c->common.flags |=3D NVME_CMD_SGL_METABUF;=0A=
=0A=
-	if (!blk_rq_payload_bytes(rq))=0A=
+	if (!blk_rq_nr_phys_segments(rq))=0A=
  		return nvme_rdma_set_sg_null(c);=0A=
=0A=
  	req->sg_table.sgl =3D req->first_sgl;=0A=
-- =0A=
2.17.0=0A=
=0A=
=0A=
Also can you please share all the QEMU config/setup information that=0A=
you have used to run the tests ? I want to add this test to the blktests =
=0A=
with QEMU platform.=0A=
=0A=
=0A=
=0A=
=0A=
