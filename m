Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128E5C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9E02146E
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 16:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nJCkyo2Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cIgpagtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbfBTQ7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:59:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52113 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTQ7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 11:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550681986; x=1582217986;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9vfHO3rakMzjLuExqwkp/L+RQFXVs9e7nQ94nrcenW8=;
  b=nJCkyo2YTOOAZp6RBKO65eAUiTRSJBtKVwMCmfecfUbASMhuWU+IGLuU
   i+fhJw5riQY5v/dDYctYA0xGv5crea31dWyuBWbeYSmEkdqYJXS+mKW6e
   2g7zouRwfTn7wLEK/eUowytlQI5NwUQ9YMFJQP7xeUHHGHHKhtkFLQTVy
   f8AWpF0qgTFH8dQyzxUTkaHhYsusbBbyqubgzbhp3IwRCJNxhcfm4TDCw
   +1N4jpWazWSAoul7yrutVtKDePYBcpnkrOnRc+e6YZAmfS6uzIspIb8cj
   Y4wE8yPOAbJAso6+0QXAVeOxDL4DdMP2Bk9wiwH3/+l8V9b7Wj0nx2wYs
   A==;
X-IronPort-AV: E=Sophos;i="5.58,391,1544457600"; 
   d="scan'208";a="101749926"
Received: from mail-sn1nam01lp2054.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.54])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 00:59:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TL0nihoaao88MYeIqg3Y2zZ2Oa3PqWjUQqldjDB+Mk=;
 b=cIgpagttOKAU2ZIKV+zKKLOxOCzqs29J6DCKCOeM2iD9WrvXwOxGbDiMpzWyZQfmEIHVskUF7dlmUmRcyrSnSETIY5NZ6zA5MICu1lLtHMPT5TmDGZBY3/sIcsVbjBOkCMRsdfcroLejLmppujoA0GqXj6cw2eY2Y2FKbIpiRII=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4063.namprd04.prod.outlook.com (52.135.82.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 20 Feb 2019 16:59:26 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 16:59:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Topic: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Index: AQHUyMoAEYk0t39XfkCklw1XmMrTmA==
Date:   Wed, 20 Feb 2019 16:59:26 +0000
Message-ID: <SN6PR04MB452781E01A0B353574B55FDE867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190220031122.GA17298@ming.t460p>
 <20190220141701.GA26537@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e049752d-7882-4d4c-a392-08d69754c582
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4063;
x-ms-traffictypediagnostic: SN6PR04MB4063:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB4063;23:4IZJ6QkRdB2vZAPysG2wpV5JDxlyeWGz38InWTweM?=
 =?us-ascii?Q?p1du1TTxVzIkdPkokCA6uxVtLVEvXwO/tDzHB/LHs5rFTCKqPJYUWihl0n5q?=
 =?us-ascii?Q?aX2lwjcvNQWreDRYPcbsOK7O3Bz8PrDu/ziUUABMKL+IPTueWjHtNui4J9hz?=
 =?us-ascii?Q?0wnbZhLg+OCww9EesBAqDWCsGLqe2eOx3QUGhWAQK4y1JAZIzLdvLaHIo7bS?=
 =?us-ascii?Q?M5Eez9CrtrVSZSOmjD5SOoPIM9dDbmBdhvMllHQzBII9vvPvWC8jN/1mTURl?=
 =?us-ascii?Q?wLDGOAl+GbTYp/RrKY2hj20iaz7m3h4eYkwAKnYbK4ANkE7WTgWFVUJlOpE4?=
 =?us-ascii?Q?akxRlE/P9+JDjcsc8bd/TMDyGkPXNmQQDkCzj2WjdhaztRwoAwf9N9DR5yeu?=
 =?us-ascii?Q?k2/l39LVTCAFCpjwpNwuzkzKoah2t+myrpMO4GxFAEkUBlVZMAoRjR5d3F9P?=
 =?us-ascii?Q?IUVnalO+Www+db+S0cYWgbPyQKqgoMLS3smwtW/fSxchTz0IATPkRT/5KqvO?=
 =?us-ascii?Q?7wkUmCrMaXohuZVeB/ZtgAy+a9+1aruZIO+b9K7rZaxkzmyu7NVZKj0UGFZq?=
 =?us-ascii?Q?TA6djcYrxhTSpoKhhY9dHa4nB0EmDGE+8P7ltSLs4MEMYzBzMMuW7rV2UWUy?=
 =?us-ascii?Q?beHerCPZsczFv0ZlEKP4sGZ4bKWl9zUZ4VltqrGMoCY0Fr7+F3esMD7VlYyW?=
 =?us-ascii?Q?zz8m+GW6jI9qY13nzCALMK148N8U6kS4dChXe/iRJcm0BFgC/NNFI/bM2jRJ?=
 =?us-ascii?Q?RlBmeBC1o1Nh1BrCFB+E7QqoB654bYr1bYCa9EvpsGqlKNBsqf3ETHSIG9/m?=
 =?us-ascii?Q?bVuHFs2Os1e4rDlL6d/pNBfP6CPTrhbOtz1D6+x/35hCwkZz6bxVFPINkCcY?=
 =?us-ascii?Q?+FBwVKCKhBoU18ONKhP12ocYAM+f1HYnVeqqc8cEfJ1R0nXw5Zy22NeH5wUo?=
 =?us-ascii?Q?Zet0mahZ4FV2vQsghVhqK3leBKCglPAHoOfkKEspKcKqcVYiJ/RT8TbtmaZP?=
 =?us-ascii?Q?YesFLJyGlOKPl9Nwk7t41yMuyNPPVKrZE4W5kzc7TwEyBbj7grrGutCaDF0R?=
 =?us-ascii?Q?Q9/CjCv1pP18D+xQqVWEUNb+9KgfDD8FsIcPk/rpffDaeTN7mZXo2rwyL1W8?=
 =?us-ascii?Q?4kyShIxB4G07rjsA/6i0c1+EYSUgxqrJHbAGwjstmqDB+04my00EmEM3HdPC?=
 =?us-ascii?Q?ABeRBqQG/GdSg550cEcJcrMw+z6NklZ4PA1eARh3OBLkkWJoeC+diAGZg=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB40630B147A20CB71910FCF95867D0@SN6PR04MB4063.namprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(86362001)(7696005)(68736007)(5660300002)(8676002)(6246003)(7736002)(305945005)(33656002)(486006)(76176011)(446003)(106356001)(105586002)(476003)(99286004)(8936002)(2906002)(81156014)(97736004)(81166006)(3846002)(6116002)(74316002)(4744005)(316002)(6436002)(4326008)(55016002)(9686003)(14454004)(53936002)(66066001)(256004)(72206003)(478600001)(26005)(186003)(71190400001)(71200400001)(229853002)(25786009)(6506007)(102836004)(53546011)(110136005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4063;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ImAqHvaXsfeNcmxNWl8SEvdjpBddil1etnpesUNpuWTidIWWsx5TceafzML5fGlx1mHtFe1tnUoj2X8F0j9Jwk8CPTvJrZBk3z129aIQMRIshiLSynY0GZAsxqOzrwpaE3WLEsKDrB51dnjZn2WwTL0Zrs+jxrX2dfu6XCkVBQDRfFgiftkUFxyqzHS17wnhJRZptMr1/qXK3/uVuJ0aFq0p5GO4vyOPuGRSfh4r464pML5kQBhDIxFt3fhR8olrKz2vtR20vKBNxvpMMBD67WrpFdCKPJl6sRpTcPZMCCmdXLVrsD+pfQNCkXfY77nW9DM+wHHUaH0B6LiQsmsvpvu2r6lbbzsuU4cr6Vqd1LdCcTWDzHeaAzLiBzvVWjxa9HVIwCtDy5iJOwznIZOxCk8GcfxK0UE2fecb32cx7oM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e049752d-7882-4d4c-a392-08d69754c582
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 16:59:26.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4063
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
Yes, already working it.=0A=
