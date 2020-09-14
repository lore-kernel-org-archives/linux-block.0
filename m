Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEEDC433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3721897
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 00:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oAdZY5DC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c0sBVpoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgINAnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Sep 2020 20:43:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20151 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgINAnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Sep 2020 20:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600044190; x=1631580190;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/kO55hRvWTJxwSt9m9RiOxiwiRU4NwmOE6XioX28yX8=;
  b=oAdZY5DCkMsaBMeJse3op1tbhJ68fyiw+AMoucrK57kzABi3Cmp3aOWg
   UAPadTbYvgDddMlANLn5JWK0QoydAQs1J5aw+hvUowvAT+bgMDAmQRr60
   pPiZ0eqjikk3HWjOd9GToF2NCIKhStKM8nqlgtqtoFhff7jNDUNRmgWX7
   XisZY8k+Cr9grkXPNKiAR/Xuf+cUKb4MV8lhIlKL4LtFs330tlsJHpWMf
   eJniOnhPiki0IkwZo0SCIey9vFJUu5j884COFvruIapk7jWwu81I/mQ2E
   6DqJSGStyykj/2kvxmvhWI1ibgY6hVMThs5UnPMBSxC89u4hGfl5N0L4k
   g==;
IronPort-SDR: uQFIIRBR20Suf0po47g6+A8J2FhvpjiWa8QMkLOM83kGujEgivYZ1XqqFz3rKlGZN5N3US3cf3
 43mY776NSVPw+YIYKsocoTYn8ZuXaRIpQyC3HnEcnFsEhDLU8AT0T4+Z0YGuIcG6K9qgPVxBUJ
 PwHHErmY5W0GTZJGhozTfh0J0VBhXy5ciO8VZuHja+8DUhZ+n8qKEqXdBPqZ50FKTogugOUmCb
 AOrozvDfvWyk+FDZmaOJoBE11xOTX9biVzmZiHNZBVxP6abIvpPGw9CJT1Kb0ATulxYD3EmWuF
 bro=
X-IronPort-AV: E=Sophos;i="5.76,424,1592841600"; 
   d="scan'208";a="148496945"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 08:43:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/HeaUfELYKCKb2q4t5mtmXk23DogKoQH0SUAizM67fzb5uUjg8WK1f+jfEg0t++nEkaJP9AO1jXlUVav0mWLs1yjq4Zm9zWtyqQomcNhO/kvcAAx7AEyGx1rDQyoVcpZ9LKX7bCm3UAviWM3ubTo7MxvCj2lzhg1BqiYzkJQ2tQMaRbYrkOnJkW6d74WindRgz/DB5qmM6eCyBwtnYZlOOn1XKFvKVFy3w14QYlpYBPJHAY6Oi/6IS2IXw8+b6lWgRCYgGJBK2XZNyhYAyFb2gsVLR9+TS4MkLZ0vW0yGhSZr419CqrL2GyA4UQh3h5zBhvrn8ukdSUIPb1aNKzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvdyyA/B5+UzEhwcyusRyIGDw/iY5Ehy6RQV9e0M5iA=;
 b=DyHC7MD0MRoPqhv4Fq0zRfpDUbmUdevapoKa4r3dV3DvAfd+rp3WZ/6fEzs5gGQ4fJl9xa9HSzO/qXwNDjUh4YSbS22Py4GsdE6JcrPm/bAgSDWZX4zpdcBoezRYV8GnJ+wdwNY/dw3WgCaz/LfK1t9nYxpq5LkmrQwwCoEwKQhcbBGrSeKztFfDaUkg8c81eo/gh9X62LpfhfBSiPmAyPBArmIZf4tvxDypZIcfDXwHaMWxWKJ7aFeJC2F9imrvq/JaRmcAqXG9nHtOJWtnKnjoVDpH6mpeMsxI0qwpyjEdopasNT8T17IuwD9GTntiJ8evCSzeGO608srtwEhScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvdyyA/B5+UzEhwcyusRyIGDw/iY5Ehy6RQV9e0M5iA=;
 b=c0sBVpoE/8lVlfo3TICkyrhOfNyqX2l+0I07ZxI13L8i6lWoPQjpeZP0aKW+2Nbvf+vyv4uPbG1NlTy4YZg/yNU59Yeeu1Q2H33xLfZy4NeN4WiHvHisuAI8TzBP/Ktcm5FW2wKc7u+gFSpU2Sdvqhcg/ci3a3XXVElinf2G5tA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0374.namprd04.prod.outlook.com (2603:10b6:903:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 00:43:07 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 00:43:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Topic: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Index: AQHWiIYMLoBPwOGRnUWZi2d6qpID+A==
Date:   Mon, 14 Sep 2020 00:43:06 +0000
Message-ID: <CY4PR04MB3751DAB758BAF8EB8A792FD2E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com> <20200912135252.GA210077@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f042f29-efdc-4a03-9058-08d8584725b4
x-ms-traffictypediagnostic: CY4PR04MB0374:
x-microsoft-antispam-prvs: <CY4PR04MB03743F0DEBAF8AA0FEE07FE8E7230@CY4PR04MB0374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2v4IZLy/IFRBCz+rPCOX/Ujoh3qcWDZmeBZ3YWA8LYS/8KH2hBeVTqpPzCA9lXk680pH8rJtXKJgXxer2fm3QWahCjyaLGMUKMCsjdUAKfd8+Kf8xj0q0fk5PANDas4dX2lJyd3QiX0prKr0QC7oCaBmhYk/KuKSrWA2VluP+sNI2/2F1IBwNaSuy+enlw9hcD3AXJ5dCbidr7fCh2MA+rkPbP5hxDWc3IS6Rskjy/mtyteSL4sPxKqde66wlh9okBWn+KreBv6xD7zmOX2uzhgNMgNeVG+3AejghAtB82716Gf/fOjVfZTUxuzw/sFJ6OVNorzzgN5q92hP9uW4JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(5660300002)(110136005)(478600001)(55016002)(83380400001)(71200400001)(33656002)(7696005)(54906003)(186003)(9686003)(66946007)(64756008)(6506007)(66446008)(76116006)(91956017)(52536014)(53546011)(66476007)(66556008)(8936002)(86362001)(316002)(2906002)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: b+RXRtKbOG6cE8+TCcJuZhFJ4tIPDROZLmkOoA1yZeqYfNgS4sPY9L71lahIQakxfyQ8c4OBFuYeSfJP4nvthWshH0xftvuNih2MZlsbdD7q/ffRdS6AR3e4sDC8hgA2bWh1qKXJ2g3dHkXWeP9+17zo585fLI3CFVvIlxZtufuDMDpJEdb24nS+EQA3P6AMTRQxwSKdofpilpG3oeaAbwf/rTcSY/JfxRADHpYmYsifOn1xQBwRJWC2xX5e/ro/bxKULqSrvkWs4zjqh4snFYxKm4bsVnuxaeJ+GYrT8UseviNKwh4x03I9++a4PdS0oZWCyEXn5/SyUAPhgbwSTQZq5bI8D0Iim/9z/60X2KxdprI0uVldit0NA+OuPWMgEdEzx8XpF/jJQEZjU8H/wVLTrcKOCEVR7Agc20s7LNgJKOX7EYDBngWDWYqy8Oe3EOPaX6X4hl3KIWD+ntbEYtW6CGhqC6wnOhUuRuIXuXw8S7zehyPJ873lJFkRNt1rMXvoiy8TYydsb8Cxa4i8uUTDxrDxWjvFY2BsX1l1b/v2BzsYjHYaB3BV5F/aWE8iJEQC+PdEIs92+dWvKXg5rTHcPig0pT0dKlNWCy2Fn6dcg30UJszxMidksHDc3NyzkCgUrrxHdn+DKZW0QOVlcBroLClIgEPVhWRmQaKUVGyvZJ5JUNIkc4tYAqicNSKP8jlMGyVeae8jXZphFj+ibg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f042f29-efdc-4a03-9058-08d8584725b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 00:43:06.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDxpjyaqf1Gt6R7VaJnDJUPD+YbjG3WgIBye4b1iKcol2reY9WJ824XJqXv32PxH+dnloWqySoYYfIP5bU/uXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0374
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/12 22:53, Ming Lei wrote:=0A=
> On Fri, Sep 11, 2020 at 05:53:36PM -0400, Mike Snitzer wrote:=0A=
>> blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and=
=0A=
>> REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for=0A=
>> those operations.=0A=
> =0A=
> Actually WRITE_SAME & WRITE_ZEROS are handled by the following if=0A=
> chunk_sectors is set:=0A=
> =0A=
>         return min(blk_max_size_offset(q, offset),=0A=
>                         blk_queue_get_max_sectors(q, req_op(rq)));=0A=
>  =0A=
>> Also, there is no need to avoid blk_max_size_offset() if=0A=
>> 'chunk_sectors' isn't set because it falls back to 'max_sectors'.=0A=
>>=0A=
>> Signed-off-by: Mike Snitzer <snitzer@redhat.com>=0A=
>> ---=0A=
>>  include/linux/blkdev.h | 19 +++++++++++++------=0A=
>>  1 file changed, 13 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>> index bb5636cc17b9..453a3d735d66 100644=0A=
>> --- a/include/linux/blkdev.h=0A=
>> +++ b/include/linux/blkdev.h=0A=
>> @@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_sector=
s(struct request *rq,=0A=
>>  						  sector_t offset)=0A=
>>  {=0A=
>>  	struct request_queue *q =3D rq->q;=0A=
>> +	int op;=0A=
>> +	unsigned int max_sectors;=0A=
>>  =0A=
>>  	if (blk_rq_is_passthrough(rq))=0A=
>>  		return q->limits.max_hw_sectors;=0A=
>>  =0A=
>> -	if (!q->limits.chunk_sectors ||=0A=
>> -	    req_op(rq) =3D=3D REQ_OP_DISCARD ||=0A=
>> -	    req_op(rq) =3D=3D REQ_OP_SECURE_ERASE)=0A=
>> -		return blk_queue_get_max_sectors(q, req_op(rq));=0A=
>> +	op =3D req_op(rq);=0A=
>> +	max_sectors =3D blk_queue_get_max_sectors(q, op);=0A=
>>  =0A=
>> -	return min(blk_max_size_offset(q, offset),=0A=
>> -			blk_queue_get_max_sectors(q, req_op(rq)));=0A=
>> +	switch (op) {=0A=
>> +	case REQ_OP_DISCARD:=0A=
>> +	case REQ_OP_SECURE_ERASE:=0A=
>> +	case REQ_OP_WRITE_SAME:=0A=
>> +	case REQ_OP_WRITE_ZEROES:=0A=
>> +		return max_sectors;=0A=
>> +	}>> +=0A=
>> +	return min(blk_max_size_offset(q, offset), max_sectors);=0A=
>>  }=0A=
> =0A=
> It depends if offset & chunk_sectors limit for WRITE_SAME & WRITE_ZEROS=
=0A=
> needs to be considered.=0A=
=0A=
That limit is needed for zoned block devices to ensure that *any* write req=
uest,=0A=
no matter the command, do not cross zone boundaries. Otherwise, the write w=
ould=0A=
be immediately failed by the device.=0A=
=0A=
> =0A=
> =0A=
> Thanks,=0A=
> Ming=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
