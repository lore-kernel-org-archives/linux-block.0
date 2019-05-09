Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74EFC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542AF2173B
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G0q8E1Lj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NVX0snrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEIQOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 12:14:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38718 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfEIQOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 12:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557418464; x=1588954464;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8LZd++GvUtjRxcQDG5mDhFqli3LGkDTDaKrLtwCwMBM=;
  b=G0q8E1LjryDJQz8lA6P/0FrmSe3hoMCx9B/Np/XDQycrNb9FbY4+bCAU
   pidw9kmuvslrGCvwTIwKNNJzXVfk6etw0ORf5x/edA8JBS3lpElBEY1Zd
   f6j4TXiGBQzUrHzzipJpiaRFRV6qDiTrsHUILlfatypD66GzwwJoLbWJT
   yrtqDr2UJdWjIIL7cuJqSvzpZomC5iteeMqfZ6AtrgKuMW0390bySVOXn
   3VqbOJaz/iIKWF+pieKRbL3Mgb5VUbN9hOXxNy3r5iZxRvy7/4zDlplhZ
   FzU6QvpPswIGrWITelVyJAEdep469UCD6/iYfiReP3iAgqHyDEPw0hzJG
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,450,1549900800"; 
   d="scan'208";a="109627200"
Received: from mail-co1nam05lp2054.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.54])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2019 00:14:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gx8MNmYxZSjkPzjBQvzzyyndgHb7KMFFsLGnEkquWM=;
 b=NVX0snrBt6O1mNCYPguAzLl7ZXvgT9QL5XXAvmswu0oGiSDZQL0UK5vguJhNymzw6GacNaffu7A7Kdt+ppFn9uULqo/jMfpE8Oqw1v3mXDSwOTnI0MwQ/lUV1sYFC+Y0hEAbp/iy+1vdXmWjMYk1HtepWwbGMYnaUK4kBDsqSY8=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5054.namprd04.prod.outlook.com (52.135.116.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 16:13:53 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 16:13:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Evan Green <evgreen@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] loop: Report EOPNOTSUPP properly
Thread-Topic: [PATCH v5 1/2] loop: Report EOPNOTSUPP properly
Thread-Index: AQHVBDnP+NEOiOrWR0eHzVHg4XqcIQ==
Date:   Thu, 9 May 2019 16:13:53 +0000
Message-ID: <SN6PR04MB4527AEB53F1CDF938B2E686C86330@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190506182736.21064-1-evgreen@chromium.org>
 <20190506182736.21064-2-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6adc0b94-eb81-4e9c-48ec-08d6d499549c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5054;
x-ms-traffictypediagnostic: SN6PR04MB5054:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB50547451276D2E8953D7C45686330@SN6PR04MB5054.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(72206003)(76176011)(55016002)(2906002)(316002)(7696005)(81166006)(53546011)(6506007)(476003)(81156014)(14454004)(8936002)(52536014)(486006)(8676002)(102836004)(66066001)(68736007)(25786009)(186003)(5660300002)(6246003)(64756008)(66556008)(86362001)(66446008)(73956011)(4326008)(66476007)(66946007)(446003)(76116006)(91956017)(26005)(478600001)(53936002)(71200400001)(71190400001)(9686003)(229853002)(305945005)(54906003)(74316002)(33656002)(256004)(14444005)(99286004)(7736002)(110136005)(6436002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5054;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qsYi5QMqNkjHo6J6AdNr6fj1HsgRKzUAl0thNcWFEIK0G69CBpQuihojlXje+/zurVITpqHmasDCO1ptVKxsHM5R0JMiQc8vgECGtfbntrDIFfC8Mc2R0xJIW1MihqVoNXldeiuHFgxSJx6YsDse2nO6sBx28F/yB05vrl7c0bDvse6XEufaO8RSbVuN6smjy9T3+y4Ni0WZr8UrFsqa5snmyxuNhKby3w7OOgFIZY7wqR5LwZLDfoLVCkxm/CZWZd6G2uNX+05/Yjltmh2BZHB1L7lpStwQ6XFGnBg4pPKYWqBvQqxDnsnLl/O8+7oXFUYss5GI5hUlP43AC0H37RPF3yUxLLalwXCk92soJJnsKB4FpUJyDJvcAcSMH8MJKXeZMiKc8mhZKzMhJIRosa9cvzT0RXEKr7TX2v3y76I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adc0b94-eb81-4e9c-48ec-08d6d499549c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 16:13:53.2726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5054
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 05/06/2019 11:30 AM, Evan Green wrote:=0A=
> Properly plumb out EOPNOTSUPP from loop driver operations, which may=0A=
> get returned when for instance a discard operation is attempted but not=
=0A=
> supported by the underlying block device. Before this change, everything=
=0A=
> was reported in the log as an I/O error, which is scary and not=0A=
> helpful in debugging.=0A=
>=0A=
> Signed-off-by: Evan Green <evgreen@chromium.org>=0A=
> Reviewed-by: Ming Lei <ming.lei@redhat.com>=0A=
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>=0A=
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
> ---=0A=
>=0A=
> Changes in v5: None=0A=
> Changes in v4: None=0A=
> Changes in v3:=0A=
> - Updated tags=0A=
>=0A=
> Changes in v2:=0A=
> - Unnested error if statement (Bart)=0A=
>=0A=
>   drivers/block/loop.c | 9 +++++++--=0A=
>   1 file changed, 7 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c=0A=
> index bf1c61cab8eb..bbf21ebeccd3 100644=0A=
> --- a/drivers/block/loop.c=0A=
> +++ b/drivers/block/loop.c=0A=
> @@ -458,7 +458,9 @@ static void lo_complete_rq(struct request *rq)=0A=
>=0A=
>   	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret =3D=3D blk_rq_bytes(rq) =
||=0A=
>   	    req_op(rq) !=3D REQ_OP_READ) {=0A=
> -		if (cmd->ret < 0)=0A=
> +		if (cmd->ret =3D=3D -EOPNOTSUPP)=0A=
> +			ret =3D BLK_STS_NOTSUPP;=0A=
> +		else if (cmd->ret < 0)=0A=
>   			ret =3D BLK_STS_IOERR;=0A=
>   		goto end_io;=0A=
>   	}=0A=
> @@ -1892,7 +1894,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)=
=0A=
>    failed:=0A=
>   	/* complete non-aio request */=0A=
>   	if (!cmd->use_aio || ret) {=0A=
> -		cmd->ret =3D ret ? -EIO : 0;=0A=
> +		if (ret =3D=3D -EOPNOTSUPP)=0A=
> +			cmd->ret =3D ret;=0A=
> +		else=0A=
> +			cmd->ret =3D ret ? -EIO : 0;=0A=
>   		blk_mq_complete_request(rq);=0A=
>   	}=0A=
>   }=0A=
>=0A=
=0A=
