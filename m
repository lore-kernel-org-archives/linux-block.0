Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A3C10F13
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 20:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF72084D
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 20:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ahx3p9m2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EmZAHZpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfDNU4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:56:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11458 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNU4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 16:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555275407; x=1586811407;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cd5ub4Pp6zbWDpqzYwWqsjd7M6n6iiMUdXyEfj2J58I=;
  b=ahx3p9m25YO/iVt5fwjBuhAmoqQi2sqh7MrHladRHgthcIqSeurlTb6f
   p9wfpaooCa3Tr/FUt4N8wW6Yd6UTIg89v/J2vIrB+bDCjYsKe8qGSvIgl
   /Wj2MywKykcHdGdvak/Fr37+DQ8XDBviTSfrR8lKATw7Oo90xdfimHq1B
   pt41/q2yzMmXl1YA1hWWpRnvV7CW+RKITHjpkJvEQd6X4EsLNgPsrAwKX
   EahunawbWtqlW1TIWUReNOnSyYpiyzNywtUf4NB6mU6fpPuwzBQntyW+w
   em2WZGJ4xaNDc9/DFftqsDFI7NhNCx/tKw+Fq+AoE5emuf9ukoJ1Dx3kI
   g==;
X-IronPort-AV: E=Sophos;i="5.60,350,1549900800"; 
   d="scan'208";a="110901532"
Received: from mail-dm3nam03lp2054.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.54])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 04:56:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGchLinfSRdWp3k3HGTclM56zaX7tPOwZvjBx6Q5bp0=;
 b=EmZAHZpvIyaOhdC4Z7tA5jkGSpGfDxY3jyhL8vAlpfl4Tuu7bjSZtnxeAs8pg6KN/aDWX8WV1/iRknd+rrM1mnjiKV35KX1GPw87xbvhWCm7hJ49+TLgk9KkLaGF8D8mF/8FNV5FEsTitRxD+V51cMCErpa7CMjINtPwlWHJ3iU=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4957.namprd04.prod.outlook.com (52.135.114.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Sun, 14 Apr 2019 20:56:39 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019
 20:56:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] blk-mq.c: Add documention of function
 blk_mq_init_queue
Thread-Topic: [PATCH 1/3] blk-mq.c: Add documention of function
 blk_mq_init_queue
Thread-Index: AQHU8m/HLdPDeAf/P0uPICQqO5JEvg==
Date:   Sun, 14 Apr 2019 20:56:39 +0000
Message-ID: <SN6PR04MB45273134A4D981D4BCBB391C862A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190414031055.26350-1-marcos.souza.org@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4518c6c1-6764-4fd1-b4fd-08d6c11bb0fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4957;
x-ms-traffictypediagnostic: SN6PR04MB4957:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4957B6D90B8D8F269126C9B2862A0@SN6PR04MB4957.namprd04.prod.outlook.com>
x-forefront-prvs: 00073DB75F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(7736002)(305945005)(476003)(7696005)(99286004)(486006)(446003)(74316002)(2501003)(102836004)(53546011)(76176011)(25786009)(2906002)(6116002)(4744005)(316002)(52536014)(6506007)(3846002)(256004)(97736004)(14444005)(26005)(68736007)(14454004)(186003)(106356001)(86362001)(229853002)(54906003)(55016002)(478600001)(8676002)(53936002)(33656002)(6436002)(81166006)(4326008)(71200400001)(71190400001)(9686003)(5660300002)(8936002)(66066001)(81156014)(110136005)(105586002)(6246003)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4957;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YbOVWUW9O8dsNgKgetqzt4LVyxFanvl6RZSjM6ZFbAIoReOl1gXUUs+29hcLEaRR+MFtwU33lzj6f2prggWWDknGNPZeyiRnwpJNYwz+51yFldK/8DMSbIIUb3fBWK+gJhJ3tAtDo/JxePfltSvJhz1sDm/PUSnWpb86ZBuWjIkCNnqhcGlugF3UCh6CVoRpESd9eyFYrcnumQK9sf13OO6VkQhxzwsQtw/9GBeaDeGdWItUserYP05TMt6XrDeibo30fFQejrljpfOL5D3GExauOGMaVJ0EyXx7lWlBBOe+4oBasWpR5ELknanyk94hkeFiKChUFZFA+gm/H7GUCo8WtNPZaPXAx/N9NW1DZmlDs+PySfub/mKuBRxjGimwD5AbBb6pkjIIMZaM8hf4LkgnPL5d+haVufYM9wdyquo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4518c6c1-6764-4fd1-b4fd-08d6c11bb0fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2019 20:56:39.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4957
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/13/19 8:11 PM, Marcos Paulo de Souza wrote:=0A=
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>=0A=
> ---=0A=
>   block/blk-mq.c | 9 +++++++++=0A=
>   1 file changed, 9 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 9516304a38ee..4a8277a54c03 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -2650,6 +2650,15 @@ void blk_mq_release(struct request_queue *q)=0A=
>   	blk_mq_sysfs_deinit(q);=0A=
>   }=0A=
>   =0A=
> +/**=0A=
> + * blk_mq_init_queue - Create a new request queue associating a blk_mq_t=
ag_set=0A=
> + * @set: tag_set to be associated with the request queue=0A=
> + *=0A=
> + * Description:=0A=
> + * This function creates a new request queue, associating @set with it.=
=0A=
> + *=0A=
> + * Returns a new request queue on success, or ERR_PTR() on failure.=0A=
> + */=0A=
>   struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)=0A=
>   {=0A=
>   	struct request_queue *uninit_q, *q;=0A=
> =0A=
=0A=
