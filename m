Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94D4C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 04:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6548C2071A
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 04:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="njrdGkld";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G97xqXJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKYEBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Nov 2019 23:01:55 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16870 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfKYEBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Nov 2019 23:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574654514; x=1606190514;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DQ+/IlNQro/EUeCsKe/4tB7fRu8BkUTRexyK+JsHJlI=;
  b=njrdGkldO9KH74LcYh4MVrc5ywDsWwngHrVws0/g+N+iXJlnz8CtTfeQ
   2pMGyeF3nmlDiSnSWEuzsjfMrI1+ep7aMVjqp7RBd8BARzwWDeKnCu+Tb
   4mDQ/Tj55WJ1nnK+wr2sc48FzHHRoBiBUCqcoAEuqIeZFBcC3REe+sTGC
   LKMqErnseFCLVry/fpxtD9olFWDtF2aKVeRUIb79enyPbQBgZHrSXCxcm
   eJbwZrjykQQYe1C71ETyniJawhbXX14KmcGosJdMaSI2lOXH/LSlNFK7u
   g2iy+BEeVSfd6HWcGybFcQe6DOAO1vRel34bEqQS84dGWjpaNa5c5zsVn
   w==;
IronPort-SDR: Md5WeNzZiSXdKywRG01ZL2UVf+JjKh7iJNlyQPWKoLyUb6NILx98ZRbTmGq1WStAQgRCr8iU7e
 a3MBNB/87X8l8wAfn0HzEDa8//XPrw/xD2fXqXog0n7XZSr6YPT9JoC921SNdAu2Jp7SjLMmJ3
 vLila9O64CbR7Hx1tf7ZDbxpbgyLkGLuzQs7SooEPV/CKQKBkQ8CNEI6qE7utlPokdlYrQ4C0J
 0H1sFxMQ0KqTJioJ31SMCq7rB5rZw/SdUsACgjboOnE/s0MaXvDKHG0naTRQzom/tK6LJEd4bP
 Ecg=
X-IronPort-AV: E=Sophos;i="5.69,240,1571673600"; 
   d="scan'208";a="231330911"
Received: from mail-co1nam03lp2050.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.50])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2019 12:01:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVVbCCZp46qHnkLycAyKlwx5i3vDmvNZG5GicL6P/D4RwwjLMYldMQZ5aac92wHNon0nO347e5jEWGsbou4BW3siFogb8Vx3xOYAigTJCBeHYwLw+tOBNcQxsLjdx0T78/W/WcFjqY9M88tju+nin2J48s4YkSaY0bLNo8AEPHOLCe3hbjY9qX6LGqJvzejusovML9wqBER9boXyI3UZcHE8wyS0NazHMhjlgi5Mh29mf4tPAQtbXgYxlKoZUgYRF91Y2X4kvCwZtr+hbX2WNkRw2eyuZRyAxtxvu07izSLndPd458u34dLsA4bJUwAy/NIuA4JfcK0Bux1oB/Z3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKt3jVz1r2RiHUUM8m8eFgqL4CT4pCC9aQuVEp702eA=;
 b=ZVYUODR/W5x/2IswLVRDrBdAhSe8oPqimBGa1jK61aOh24TFPVf/wE96/dvPibyMEjZZkWGLyXcqKzK4rP07I7siFmGsWzhpJEIqGx/dz9CFfgjgeHcdtflLv5ztVOU4xofRn1+gTjET755Rw9KDdBr880n8kpo5hzN5H3Smvm0nD/mZ9lO8i/GxyhWkhVUFds+aB1N2KshBilAXwr4UmVY2JlxFY4pwWA5V+L3Kl6OMQmUX5B4mKBmMGzZmT5DGpkigovTAJ+0XAM3B3Dc5Qr8UsmB5IhZrWrG1rm7RKoVomAGYFnicJi3y9OC5f7Oou/O7G9KjlFXkVSGJo/tUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKt3jVz1r2RiHUUM8m8eFgqL4CT4pCC9aQuVEp702eA=;
 b=G97xqXJCkHzivcWBS2gUyhS7n3Yc0wzvI7+3o5/vLfAQypoMyZM6cp25GknuDEKVAsIJBwV4pV+ZtY7f6QzSRv5hOvynEsHxLBYek9Un/wABVKkpEBGy+9SwC8mgTIFgWgoXasKks5FgjeR/xin7isejnj2+Mx+skVsDFG8zIKI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5991.namprd04.prod.outlook.com (20.178.233.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Mon, 25 Nov 2019 04:01:53 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 04:01:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Alexander Potapenko <glider@google.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
Thread-Topic: null_handle_cmd() doesn't initialize data when reading
Thread-Index: AQHVm53Gadti/EFzl0asu9nRh/Dj+g==
Date:   Mon, 25 Nov 2019 04:01:52 +0000
Message-ID: <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
 <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3fe642e-19ef-4af2-33a9-08d7715c347d
x-ms-traffictypediagnostic: BYAPR04MB5991:
x-microsoft-antispam-prvs: <BYAPR04MB599178FE531F0CE39C0FA8DB864A0@BYAPR04MB5991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(316002)(53546011)(99286004)(102836004)(6506007)(26005)(86362001)(7696005)(8936002)(81166006)(81156014)(8676002)(446003)(110136005)(76176011)(186003)(33656002)(6116002)(3846002)(7736002)(305945005)(256004)(74316002)(14444005)(4326008)(55016002)(52536014)(9686003)(6246003)(25786009)(6436002)(478600001)(54906003)(14454004)(66066001)(64756008)(66556008)(66476007)(71190400001)(66946007)(66446008)(71200400001)(76116006)(229853002)(2906002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5991;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p8rQncc6gG43jUAZ6PLsr8id/Vk1EBXEwsIOwlnIQ8cTWqMQqE3QEiPCA62RhgGV4rFgT4s1tKHtHtHaX//poAgbQkY/ZC/Jb6UMvt6v+CMtyN5Ypi/7yraFG65cQ+7j8nZLUn4SAdXCQN4XmuZ7A1Nqf3Uo1Pl2H03NFZw8aYOwXZLAv9wPoWJXPrzlQFo8PAmI6ixfaY3mja2+ZkpDAI6K6lMJzVuHlGznbbnOMNcB5kz0dUqxR3EBiM31+YSFnduvZnLTZypYcLF/Nt/S5uTDPOjgfA2MnwUWLa1NS6TbvzOeyC4EiKUhyPtrDK+tDcw5KrsfBLPO6sIpWyQbIvwSHXI+kDBDHHLo/NcHEfV+A/OXF9jYUJ75AbDiEyRQqpn2NQZcWIRCJrbLlsfo83hYcrVk9WYzwhh3nPbtVIlZE2G80jI3WTacl91W6lt1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fe642e-19ef-4af2-33a9-08d7715c347d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 04:01:52.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6p9rHa+l57Ru/Y36HVnhW1tyg+48JEbihUKfRIE7t7N8gSbJasxNrKY7AQl8KVB+ov1EhtYBGHVxRPLsDvETRXToMFw2DsPYf/FRaS0du6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5991
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/2019 03:58 AM, Alexander Potapenko wrote:=0A=
> I'm using the following patch in KMSAN tree to suppress these bugs:=0A=
>=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 0e7da5015ccd5..9e8e99bdc0db3 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1235,8 +1235,16 @@ static blk_status_t null_handle_cmd(struct=0A=
> nullb_cmd *cmd, sector_t sector,=0A=
>          if (dev->memory_backed)=0A=
>                  cmd->error =3D null_handle_memory_backed(cmd, op);=0A=
>=0A=
> -       if (!cmd->error && dev->zoned)=0A=
> +       if (!cmd->error && dev->zoned) {=0A=
>                  cmd->error =3D null_handle_zoned(cmd, op, sector, nr_sec=
tors);=0A=
> +       } else if (dev->queue_mode !=3D NULL_Q_BIO) {=0A=
> +               /*=0A=
> +                * TODO(glider): this is a hack to suppress bugs in nullb=
=0A=
> +                * driver. I have no idea what I'm doing, better wait for=
 a=0A=
> +                * proper fix from Jens Axboe.=0A=
> +                */=0A=
> +               cmd->error =3D null_handle_rq(cmd);=0A=
> +       }=0A=
=0A=
This is just based on what I read in the code, I don't have=0A=
the kmsan support.=0A=
=0A=
null_handle_rq() should not be called without checking the=0A=
dev->memory_backed value since it handles memory backed operation,=0A=
(it may be working because of the correct error handling done=0A=
in the copy_from_nullb() when t_page =3D=3D NULL).=0A=
=0A=
Possible explanation could be for the above code fixing the problem=0A=
is:-=0A=
=0A=
null_handle_cmd()=0A=
	None of the ifs are handled (since it is default behavior)=0A=
	calls null_handle_rq()=0A=
		Processes each bvec in this request :-=0A=
		rq_for_each_segment()=0A=
			calls null_transfer()=0A=
				calls copy_from_null()=0A=
=0A=
Now here in copy_from_null(), null_lookup_page() returns=0A=
NULL since it is not present in the radix tree(dev and cache=0A=
since its !membacked && !cache_size I assume since I don't have=0A=
the command line of modprobe null_blk),=0A=
=0A=
and then does the dest memset():-=0A=
=0A=
(from linux-block for-next)=0A=
1009                 if (!t_page) {=0A=
1010                         memset(dst + off + count, 0, temp);=0A=
1011                         goto next;=0A=
1012                 }=0A=
=0A=
which initializes the destination page to 0. This is what Jens=0A=
is referring to I guess that we need to memset() it for the=0A=
read when !membacked.=0A=
=0A=
It will be great if you can verify the above code path on your=0A=
setup with above memset().=0A=
=0A=
The above patch does fix the problem but it is very confusing.=0A=
=0A=
What we need is to traverse the rq bvec and actually initialize=0A=
the bvec.page and repeat the pattern present in the copy_from_null()=0A=
in such a way this common code is shared between membacked and =0A=
non-membacked mode for REQ_OP_READ.=0A=
=0A=
Jens can correct me if I'm wrong.=0A=
=0A=
I'll be happy to look into this if Jens is okay.=0A=
=0A=
>=0A=
> It appears to fix the problem, but I'm not really sure this is the=0A=
> right thing to do (e.g. whether it covers all invocations of=0A=
> null_handle_cmd(), probably not)=0A=
> I don't see an easy way to memset() the pages being read, as there're=0A=
> no pages at this point.=0A=
>=0A=
=0A=
=0A=
>> >--=0A=
=0A=
