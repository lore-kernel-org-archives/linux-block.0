Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91391C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C4264F60
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhBBJKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:10:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36258 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhBBJGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612256765; x=1643792765;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zbkMi35u9olWwcSTKdN8nDq4/nWDGhHHROyjca5Fcec=;
  b=ql8JtlqdldmDxGIYU88FIm61Qv/mceUSOvTtk47CHCZ8Qv3LpmH6tufh
   igjQ2/wu9p7Kony5DMOuvu3RIJge3t8PBxaNKrWSywBFN7AeO7ddxkulN
   dibaRkzRTisAHftl6W19rGCQPwjqES4ajy+lQjMNXSuWnTzGqbsHIj8DQ
   nLNkJeO0KE9v6B9D2rJ8/lnnIRyRA+rsAO8iQ7rtQT2Qz4ksjwBB+GnxN
   ooM+pGLjr+cNlbV3IEAf5XPMBJofrYULOuziGRzRvkQDbpdde+tRr8w+D
   sVLQ0QgfJX8jgjCQXbJ8UcgXxMzL9Mxf2XCafnfBuvxcnMuKPbv5i5/4C
   Q==;
IronPort-SDR: DVlCW/wfXDZgKZqYEqb9RBbLmAhtx7Gj2U17odTmWmiu0O5HFC50//PPzIJWUEiNtjxeqqShM/
 D+fpHnluf6JUNY/9qla7XN+q9djGWaNeFWyq2rzO2XEi9Gfmdbj2iMuIwbskYv1ZaC01LhtJqf
 TT2NexeFT/P9NLocW3AHO97ybEkP0N43MOeAgyp6FauPAVIBp4dg1qlJHPlnU1YRiDscwLmNdY
 8OfAGNbWhFrZoLpPlzmjbF8ow257q5SI+7RNY5L/MlpthpjmRXPtEs7xv2DpucEC7jE/RUl6os
 n9s=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163350767"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:04:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2LsgaDbLJUi3UYBnrUItFUsEWHJk1CZJ295W9VCKAl974p10+MdZQK2+0z+dVb1T1dluJLxYY9gdrw1+VnQfhbOmngc2OKepK9qrrmflfYmRA5H1AtuEtywx3BQ5xRdz8gipYdr9+VWY2HOCk/WbXyrFB1vB7vNnGGZGZZqS9hyQtQ4ZZRlKAEnIffmw/dHOp3LmyT8jbMCPIQ6RUEejKPWDRIlVA15IVuBK61rvL5GEz/7T/LdLBlFPsowRqFHJU4P22WONhMUBiQs86ivCOyd9spW21d31JI7O01s5tcn6fHL0AQ/ul4aMJbR7+NT+ANJA+VPwUw7M5qZ+SP8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghb2M/MJ6p5+kPqcbpePt8FvLBiJ974g2FD1oHTm7c0=;
 b=iewNh/I3d/bdqjtxhsIDwSwXKaxjkY1phbmKbImZ1O+DiGtcJhJXYOro2+3MSdpItHOU3XTWKEuCrM6az9PwAgqHOYMI1ygAgWexgdIfnf5L0zkzV2ORQBs5j3gCvSf9wPZMWRBA23AK89vT7uBmqeBOf88NPLmEPjza7p6NHB8CNogyxe+3ojyTvuU6DgIe37SzGMqTB3DDisq7Ku9yV5WVx/i1bgu4ALav8ILB3l9Pfa4pYwGcldzK8XgpJ0DArCOM7QImmH2Ts302evQj35g9ieS8cg/crUlxtfrHfd9DpOHcuVZfGEh2PCfCJeh4kGr5MqfTgZZmDzxRFEVlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghb2M/MJ6p5+kPqcbpePt8FvLBiJ974g2FD1oHTm7c0=;
 b=BUPQofy89T14BrR4ZIgLUOAMkamAMbAd1k5qWHG6colJpgccPR1qBQwYGaQ3++qu3DgKsWWCkdPCs1+xl9gY3q07FRQT/LNt2NnZ/R3prLesp93UsHlmnonO26yV331SSlIDmBTOs3TjYj+XQ0T24PTrOgrLOYAzTIE9hG5/js0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4641.namprd04.prod.outlook.com (2603:10b6:208:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:04:28 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:04:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/7] blktrace: fix blk_rq_issue documentation
Thread-Topic: [PATCH 3/7] blktrace: fix blk_rq_issue documentation
Thread-Index: AQHW+SP0HbhG7BTwjU2mEFf7ZOQUfw==
Date:   Tue, 2 Feb 2021 09:04:27 +0000
Message-ID: <BL0PR04MB6514D1A9835613B1B733F4E7E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b71e5bcf-11f7-471c-f991-08d8c7598b96
x-ms-traffictypediagnostic: BL0PR04MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB46411CE1C1DD29AE113447FEE7B59@BL0PR04MB4641.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZayJW7jUNUX4HW/t1KDBT0wjcjHIdzwMFE5+/VbMsTkwMVedajoh+UCxGkLbIGMjvzG/eB/XywOIL71/JPbMoAjnwDJ8L9MN7oyl+zyC3+YnK1z5JpIxEvg9lvUnRT+fu0XU/C+esVQnDdq854OI+bbPO8XrD8IqSatZgO+72ZGPAM7N95hqT9ptgdvYhr/XgCqcGX7ed5I8Ky1qufk68/3zFfwJhgV8noQZZKeizpvEgCGGZIUG5IaNNGiw9wLoUR3iEAuVJqIZKiT1BXPfN6FHrAdzJ5Hqz90gv8TLNt7U1ksmHuC3dYqiCf+Y6THN0ehn1OVnYUqVyUvvSvdTGtJ9f1dsEq150mRWGf7Zh4CtwWf1D0mKdkWdJUfL5ymbk+m5AaGOjfKjN8ejM/0jEHgALIXZBUZaidkYCGb3wHNlKxtX++wn3wErCYaIq29qS8rvKtlKBWT1RE3nYSTRd6yxLc54ysPqG5YkebAeRPvmNM5esFC1+uKZddex/cax/v8jzma1ZI5pZEZLPrunQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(2906002)(53546011)(6506007)(4326008)(55016002)(186003)(76116006)(478600001)(64756008)(86362001)(8676002)(66446008)(66556008)(66946007)(52536014)(66476007)(91956017)(54906003)(71200400001)(5660300002)(7696005)(8936002)(316002)(7416002)(110136005)(83380400001)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iMctjEUcejTlrWobJgdoxbCwQJIm3w0N3G4176jcg3MU067mpqTbzr6LT/kg?=
 =?us-ascii?Q?OmsOo5BAdcpEvjDZIG8mPRWkj2XroSsBW1M3EdM/Iqm3wE60fnhc2eeyQWKn?=
 =?us-ascii?Q?sAZjIZW7YUk0uxG9xmtqnDR/yoBZsnVACzQofGmWwl42nNcQqcdg8NvcjcZZ?=
 =?us-ascii?Q?46TQUfjEMlkYBdhbF3A2sFJfsek5j56YgVdnlHEZUFzBHv1JNapWXW+klhr6?=
 =?us-ascii?Q?3gjZcDcc8baMSG6aO394GVO5I/r4dG3SKL+dS3NVtWBNx5PdXYd3K6dN+Ob4?=
 =?us-ascii?Q?PLkSd5l8vc43yzZ7qkwYJq4Ml50RDWczvTpopEm0TQZlHMMO/r0KC3agQtDV?=
 =?us-ascii?Q?wzEg2ojyBh2u0skVQX8vQSKeOsGLK6lR429EPzh1CXrekBpZfeyKzKddCZt6?=
 =?us-ascii?Q?yX8qUR1NLRDBy4O+t3/eyWUICG9lt+QKhe2a7rsNSP5Rf21BYizqcBJGjGk6?=
 =?us-ascii?Q?mY8MDmzWgIY8fnGrVoBdoMGkKiPE5oJ2HCjnh3drwAnXt2dI6HKz8FIgmNql?=
 =?us-ascii?Q?fUmqsivWQalHWZJJBQhXqlGAw5QMnz3RwJ+LD0FKJwvEaFOaQULXcHsHCuMK?=
 =?us-ascii?Q?wjdaPWh3klaEjM79iiUEWK+IQnRaUIKwvMccloH6I3bw693RcI/m7HQJc241?=
 =?us-ascii?Q?bMj5eSmR7SFE3/U+kQY80ydcjFavqSsDAfvrJsFmeGjiv0HQBLDnRXUMpxuL?=
 =?us-ascii?Q?baB84EwjKR0nceW8r2eQTILcKbvb6q6TI0tT+deaP5JYuKlgEWXp4wdm1m/x?=
 =?us-ascii?Q?Q6NbQKN+pGZDyhE5dMkOnD4TcZ7931Nh/nJq/JDL82wnSwXPqNzcYtOG3QKp?=
 =?us-ascii?Q?w/FKmObXOZtS+9r+YNwsDCf1JOIE7ClxgM5EcNP6GbilUlaCa/r3F+MMYa70?=
 =?us-ascii?Q?qqKzyo0cU2PB7VnAfsXGjxoocMCM6qLkdON/XLtkp/hrIM9NgYdQGyj2kn4Q?=
 =?us-ascii?Q?JZ3Pt0Az2Tb2sSNYQC6jBsyD6iux7pYP1/yjvHxC1LwKPtybjqT2ajhzsL4I?=
 =?us-ascii?Q?N4KyroKDmCu+RJByWQOp6Mq9U+I5XT+lWgb47DrbA7C2Meg93xOvJ6glW5Lo?=
 =?us-ascii?Q?mSPJNl2i6R7dTV7lnQTV+BvIorxk+U5xeTW7WDH2yqcj5babgxPK7tBuMEUv?=
 =?us-ascii?Q?FL9lend7R8dORoSRkmgPuuFmMMXReXYG6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71e5bcf-11f7-471c-f991-08d8c7598b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:04:27.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7bUT8P0UMa/TJu5oIbAPI0Y5ieFig1VVbCy30elyVYYpXVImQFL1GsfCbZtsME2EMU/apQc9scFUEOebWIryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4641
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> The commit 881245dcff29 ("Add DocBook documentation for the block tracepo=
ints.")=0A=
> added the comment for blk_rq_issue() tracepoint. Remove the duplicate=0A=
> word from the tracepoint documentation.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Fixes tag ?=0A=
=0A=
> ---=0A=
>  include/trace/events/block.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h=
=0A=
> index 879cba8bdfca..004cfe34ef37 100644=0A=
> --- a/include/trace/events/block.h=0A=
> +++ b/include/trace/events/block.h=0A=
> @@ -196,7 +196,7 @@ DEFINE_EVENT(block_rq, block_rq_insert,=0A=
>  =0A=
>  /**=0A=
>   * block_rq_issue - issue pending block IO request operation to device d=
river=0A=
> - * @rq: block IO operation operation request=0A=
> + * @rq: block IO operation request=0A=
>   *=0A=
>   * Called when block operation request @rq from queue @q is sent to a=0A=
>   * device driver for processing.=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
