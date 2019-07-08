Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F347C606C7
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2514C2086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 18:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="blDcIdQ0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IbOYPLMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389546AbfGHStm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:49:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51515 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbfGHStm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 14:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562611781; x=1594147781;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bGxz+GIeC1lC4g9qWmQkL3NXCULx1odrFwUfdivG58I=;
  b=blDcIdQ0rC82WP1mYARHYHUzywKMMIpV1ORrBmvxJioXCkPVn9q4xiG+
   EiKRUcJ0Axh4Ey/YEqm702sy0jAcpRVuzOXKqxWrRr1IEH+HVaVQJrnG9
   GMDJgYK9Igvem1jYgTRtKbiqeNOvc+P/HV1JHWZBSxD0hF6UnJaKb4LLx
   4XNxKTkfCbiG2bQCiIK7cjghuRHtIP6JQDRheB5vBoNAUMLhCtZai016T
   qaqsqw5VP358DWqb4U1SQhpjFYBypuco1N612Z/dXr7dr9U/7eL9j3PJV
   wGnlUh/LctCxbdB+v9gaDCTvPCqClADyn06lgFPuFG2C97fBSQ8QqC3kx
   Q==;
IronPort-SDR: FXimr6LjmbyKzEc4dCbcdIHgax76wbC4LdE3PDus98IaVm6TdnQ8ZmJf5eN4Ak256bzl7vL0sF
 8gfRYtSET6XD/+X7+CPAweejX81FVnbbxDaeIUtLyJOqQueqjsOjaYmv5OFldKjXSbVvsxKKag
 vdBlqoAmJAUxsktrkNAvzx5sIbZIRparZ/2XnXjg+bVD7L0mOQIYry4AwHUfrm1XTY+BBk2br6
 ZdrhKPVetLI/5AEkOL4JXlEd5mCmz4xJ3y+xCbfKqfrpFMf8pP402L+oAgXaDssZ8DsdnNnc70
 6qE=
X-IronPort-AV: E=Sophos;i="5.63,466,1557158400"; 
   d="scan'208";a="113649582"
Received: from mail-co1nam03lp2051.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.51])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 02:49:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbjc6Q/mLZtcNW5kLsqIh3rXJYWn5IugFldKMixev70=;
 b=IbOYPLMRH3efE49fsNG+Oqfx9l94ojJ+W61EnSJp9KkwH7KL6YqmTWgdjENDHM9l7jD/Es+7wF50uTYUFImPQDKsb9+ck5HtsjTnUO1eyjylDWlQ2hfG7MGYMruLDe2sB78/O8fZfCDzYJuS0a94RHsoV4ev+4UfiwfG+N6uy1o=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5079.namprd04.prod.outlook.com (52.135.235.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Mon, 8 Jul 2019 18:49:40 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2052.010; Mon, 8 Jul 2019
 18:49:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] mm: update block_dump comment
Thread-Topic: [PATCH 4/5] mm: update block_dump comment
Thread-Index: AQHVMFgQGYk7nYnKN0OmAoIT6JPzqA==
Date:   Mon, 8 Jul 2019 18:49:39 +0000
Message-ID: <BYAPR04MB57491CF4972D9EBA8587A26586F60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
 <20190701215726.27601-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1282512-b037-403e-9b7f-08d703d5085b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5079;
x-ms-traffictypediagnostic: BYAPR04MB5079:
x-microsoft-antispam-prvs: <BYAPR04MB50790F3DF29D7A308C43B5DC86F60@BYAPR04MB5079.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(9686003)(55016002)(66556008)(64756008)(2906002)(66446008)(66476007)(8936002)(76116006)(73956011)(66946007)(71200400001)(53936002)(71190400001)(14444005)(33656002)(229853002)(81156014)(8676002)(81166006)(6246003)(6436002)(446003)(256004)(68736007)(25786009)(52536014)(316002)(72206003)(54906003)(4744005)(110136005)(478600001)(99286004)(486006)(15650500001)(14454004)(26005)(2501003)(476003)(7696005)(7736002)(186003)(5660300002)(305945005)(6116002)(74316002)(102836004)(6506007)(53546011)(86362001)(66066001)(76176011)(4326008)(3846002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5079;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qCSadIyb+r+Ob92jkRmKAVb8Ma7Ti94HpBn+v2liVJ8Ve3/b+fXLgMwDpAMyU5PI/QBKY89btOqSbWwT4pur7A9hgfv8tTW0HdQ3z/xv1B4VzXv4OUDt9UoIgSVbU525eEH4MpJc+ae+eGBvGDVS4iAPa8wGkjqakyF6fjqgwmYY4sZd7l5/hpuQTk+3G8i23kZnIv7XdV10u7pFgFYW+/Vm6S+VrjrvEFY1ZYv/EVmi0Gbab6uNmXs/AN9wZsiwQXJ5pKajzdwS91+lCTc22Sf7V4N14c6MG1e2RAQCegjH9hwuxCQ68nmQyT9jekcavnV1iDkhlDVddmbrk88iATIiFXdSo6mwadcFwx1JlC57QigO0uDt3W6vkzNSQDXS/zHi0MTdBtAj4gIj1JZZJIbXkm3czZld3JOOpwaLY2g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1282512-b037-403e-9b7f-08d703d5085b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 18:49:39.8343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5079
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can someone from linux-mm list please provide a feedback on this ?=0A=
=0A=
On 07/01/2019 02:58 PM, Chaitanya Kulkarni wrote:=0A=
> With respect to the changes in the submit_bio() in the earlier patch=0A=
> now we report all the REQ_OP_XXX associated with bio along with=0A=
> REQ_OP_READ and REQ_OP_WRITE (READ/WRITE). Update the following=0A=
> comment for block_dump variable to reflect the change.=0A=
>=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>   mm/page-writeback.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c=0A=
> index bdbe8b6b1225..ef299f95349f 100644=0A=
> --- a/mm/page-writeback.c=0A=
> +++ b/mm/page-writeback.c=0A=
> @@ -109,7 +109,7 @@ EXPORT_SYMBOL_GPL(dirty_writeback_interval);=0A=
>   unsigned int dirty_expire_interval =3D 30 * 100; /* centiseconds */=0A=
>=0A=
>   /*=0A=
> - * Flag that makes the machine dump writes/reads and block dirtyings.=0A=
> + * Flag that makes the machine dump block layer requests and block dirty=
ings.=0A=
>    */=0A=
>   int block_dump;=0A=
>=0A=
>=0A=
=0A=
