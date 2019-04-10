Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F089C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 22:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0E72133D
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 22:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HAIn7Ykg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ROEYuH8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDJWNR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:13:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10323 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJWNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 18:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554934396; x=1586470396;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=B6nwwFzTD+jXCEqs+0Rr5QhRysxJTVt+R0z07xGKrWI=;
  b=HAIn7YkgzTtl/mnsOtB7P81vj+64h4+UTD50ZoM/BHOmv/HGWBw5kGVH
   zWNmiQKwFbP9ilQwCL+kOek7071EyA3VxTj54LwhS1KEYmkl6B+GECmoF
   bQaYCYyZJLn7w2KY+H7VRmrM7NtyWTbeaWBajD5ctZq1SXwnR/0Dse6pb
   NvJGFSPrgQrjD+yyGxYAj3Kn5Efbe27nfZaHyM3MqFptQK+3SEZQxYzjX
   84qvHoKq6fYL1Sd+qAsS02qAHyqOFZFGZfR+YHQKio4rEcjRLgClRZzmd
   80YVNODTKOMLgj8jkOjCXS/8ZpLb+MlQ6gPY8m0Eyt/6A2q731TIghRV2
   g==;
X-IronPort-AV: E=Sophos;i="5.60,334,1549900800"; 
   d="scan'208";a="211273874"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 06:13:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nL1tJpMdTtw/EQndqCRq3fS6ojGNO51OXUqs2kK+X8=;
 b=ROEYuH8AqW7DVhQWhnLqiLqfyk5TQDgZN/xgWQjJxcNtP8xEdKTKHeXMq3a0fMo6t2dQ6i0JwWUqv33H5u/UjDk5oCzsYpXgXrch1a31AwDHYUB/hZHS9f6Y6iVW+5lDP8HrBpXC8Mq9FYW19n0geezXgjIGhRhB7hKkyQUWa34=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4960.namprd04.prod.outlook.com (52.135.114.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Wed, 10 Apr 2019 22:13:14 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1771.019; Wed, 10 Apr 2019
 22:13:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "jglisse@redhat.com" <jglisse@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: do not leak memory in bio_copy_user_iov()
Thread-Topic: [PATCH] block: do not leak memory in bio_copy_user_iov()
Thread-Index: AQHU79v0dlXVpXNXG0+W9MpU00wO9Q==
Date:   Wed, 10 Apr 2019 22:13:14 +0000
Message-ID: <SN6PR04MB4527191E2EC151609B6F1B23862E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190410202751.20712-1-jglisse@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1939ad45-0d75-4606-1050-08d6be01ba46
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4960;
x-ms-traffictypediagnostic: SN6PR04MB4960:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4960E2B5E4FF03B8283D6CC6862E0@SN6PR04MB4960.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(136003)(346002)(189003)(199004)(66574012)(33656002)(256004)(99286004)(14444005)(4326008)(71190400001)(6436002)(52536014)(68736007)(106356001)(5660300002)(53936002)(105586002)(25786009)(9686003)(110136005)(316002)(54906003)(6246003)(55016002)(71200400001)(6116002)(66066001)(2501003)(14454004)(2906002)(229853002)(26005)(8676002)(4744005)(81156014)(86362001)(3846002)(81166006)(186003)(446003)(486006)(8936002)(476003)(478600001)(7696005)(97736004)(72206003)(6506007)(305945005)(76176011)(7736002)(102836004)(74316002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4960;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p5ZTLPsLQans5DO6C3XXIUPTCP7ynVgfANmJhib/rdR+CCn9+CSOWIF1LUs8caczduWCBbz0RyXB9vRijeR/GIpxlyJXZP00d7C0Qb2R6hQncCfgpW+M9GlnVg6xC2IjCPxPKPhl88IfpJBOW17ySpP+t8quNJK51EUp5+YNxH/vUS1rZL3Das3LaxoUJlKu2idJlUNxwR9icvm3dFFMtLhhEqTtN1bdxzvWLw6MPSt61n2AiVjCjqA3qUaD/2WNwO9h1TmIrnblSJBNcduLB/j/4XEZAIc6ckm7WOh3GCZ8++N9h+HBJpIz8elQx2zt2pjtQerivXBlfDYppMoopTZkLyGYrbjg5lHFsCN4CPMD88Etb5TzvSW515Sq6HcqvZZkAyfS6IC64DZnN38gfLGhTTwDlht2dQqKQCp33tY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1939ad45-0d75-4606-1050-08d6be01ba46
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 22:13:14.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4960
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/10/2019 01:28 PM, jglisse@redhat.com wrote:=0A=
> From: J=E9r=F4me Glisse <jglisse@redhat.com>=0A=
>=0A=
> When bio_add_pc_page() fails in bio_copy_user_iov() we should free=0A=
> the page we just allocated otherwise we are leaking it.=0A=
>=0A=
> Signed-off-by: J=E9r=F4me Glisse <jglisse@redhat.com>=0A=
> Cc: Jens Axboe <axboe@kernel.dk>=0A=
> Cc: linux-block@vger.kernel.org=0A=
> Cc: Linus Torvalds <torvalds@linux-foundation.org>=0A=
> Cc: stable@vger.kernel.org=0A=
> ---=0A=
>   block/bio.c | 5 ++++-=0A=
>   1 file changed, 4 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index b64cedc7f87c..716510ecd7ff 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1298,8 +1298,11 @@ struct bio *bio_copy_user_iov(struct request_queue=
 *q,=0A=
>   			}=0A=
>   		}=0A=
>=0A=
> -		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes)=0A=
> +		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes) {=0A=
> +			if (!map_data)=0A=
> +				__free_page(page);=0A=
>   			break;=0A=
> +		}=0A=
>=0A=
>   		len -=3D bytes;=0A=
>   		offset =3D 0;=0A=
>=0A=
=0A=
