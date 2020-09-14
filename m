Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4E4C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 00:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1286621D1A
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 00:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TU5LRe2r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eB5uSijA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgINArI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Sep 2020 20:47:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20463 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgINArG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Sep 2020 20:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600044427; x=1631580427;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0+AqSqCaAjYh1jTqb8A397OafMUkiynaFYcUl+cIaAA=;
  b=TU5LRe2rg+GZvIVyqpFkrL0mXlHHXWOwLsQ9HY9Haxkg3d9cO4ahojhi
   BS9aYUNEf0eA2ue02kyEswKNauoM0y4fUiXX5WEZ2VISD0v9PFshV2l69
   zELOvIzu8xHiyVqlYleV33jAVgu3nXSpu/+M4khLEHxzcqkBEH2p/zUMT
   UJ2h98GXl4CGOZd2dA4pzZnvIMFpVxKTQxGYLJKHUc7xt+dRwkowW5vuK
   GBoC5JDQMXkdzPgyFQBo0g8QdBw/NPSAvX4uO0n/yM9Yp4rNIc73IwDu8
   f1TkRVi8mmz+0lKvcLmzCazNTM7eDaA3DYUs9oxV9MzRGGPwct4BeJwgr
   Q==;
IronPort-SDR: ONTi9Lixtx+tlFgDUtXHvJu1o72jAVCn8IvzCb6bE0aMPuRKr3xSUABA09u3ziCmDGLOwRRs2D
 jsoTdl40qF++nzRoJ5QxztNd0xbimGCyQBaGhhePTloOfq6gVFbu9B8trAppDog4L8P1Kjvhgv
 pjSmYcATAusD4lri6f5HQOYelJHEbbWV0r8cgSoPaCWTNwBQIo7znAtVq4F2JvZRtCDMGqW4bZ
 Uwh0ssyyS3nq8xRn0piHND/ogArPLzodAMN6rQ+TuColLuEfkUb+yRMTZj/7TgyS6998XuOPQ7
 Obs=
X-IronPort-AV: E=Sophos;i="5.76,424,1592841600"; 
   d="scan'208";a="148497085"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 08:46:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSyDao7/UhbRO4zcCqkFImspqmWHG+esegtulayels1h3qz+0Twxywjfy+BTx+nJZ6IDG/1YRKysLDuowKg2WL8QnCYNCUW21rzLmkJRdgFxx6RJxcYfL3GGMLMpDRCtBSfX9Sz7PSk0J6jxWjFl3UDS4ON0RVYOmxNARjc6tq30x1teIPPbgREAdGD2oWx8uwj2PlDmzUI9q7P3rVguqwxOJ/zXK6PUldBN3+s1f8RkUggE0qnDCzrd0QJitn8T3+0r3lYC0qRNTPtaL5IM1LsrJftJn4wPXi8NA8IpfjflmcSyihiL7P6dqg4He7GiIEIMTO9K/Jb05HI0xOuPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwXjtG2WUXZQl5ioHePeepwtA/BgCLIoZnRz6T0vpP4=;
 b=Bkl35nuMZ/xUme7DTYOq2aIozoojsfvrpfIDYzhqaSCqvAAf8yX9UdoxtuK9DbA9eGAmYkjBvBAw2BV7d6gUwqi3U/ppbLWdpyNhCuk5HcRMsVFS9gWvqzs4Hh0Nfqgx73hdIDvMrmz0fv1sNSo7XrzjDgB12CGXLhipQePqwQO3csELXcAk6Pm+8XBVaBHxkBgw2i+6YL+YiBPNlv7mXLmfrGINI/k1y42XoUy7ZyGV51v1E4iqS6XbOmdVtJ4OhIf/f8JvvRgd70yuFo65dLoKsw//QAKM86cjyfXa1FFvMqxwoqued5p6ZITd5oUfNOf2yenDYbpgU1tM1l1jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwXjtG2WUXZQl5ioHePeepwtA/BgCLIoZnRz6T0vpP4=;
 b=eB5uSijAx2TSPdwWUSgMgreB4kOa/KcGl1sqZ9oAxggiWwjXHt1DffQaA0PxoYnkNfoG7J0dRYJEFBl2dcUIsE7rKIagj1HhVixyFeBNqEolcKrJ5g7HvsSl306TYlXdk2mxl1ikD1Eup242hppekKd8cKkcF8+uwuYalb1IIBA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0374.namprd04.prod.outlook.com (2603:10b6:903:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 00:46:52 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 00:46:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
CC:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Topic: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Index: AQHWiIYMLoBPwOGRnUWZi2d6qpID+A==
Date:   Mon, 14 Sep 2020 00:46:51 +0000
Message-ID: <CY4PR04MB375160D4EFBA9BE0957AC7EDE7230@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c44dae3-0696-453a-8dbc-08d85847abc6
x-ms-traffictypediagnostic: CY4PR04MB0374:
x-microsoft-antispam-prvs: <CY4PR04MB0374E4A67F41516160EEF284E7230@CY4PR04MB0374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: maLa/ZSvDcg97tL0qoMOHYNf3QpO+TAOmjqu+Pz6nDYcfZ3k782PYP+l9U+kQ+55zYdG3QffeU2mPcwRZ9R+v2vwJIfSLJcP/XE+xEE3W3mi8OC9zYdqbzZY447yNX/5Y6p6Tq6WK/S/roMJdDc0brprlOFkzUHuIBryLmTcnsofUCmKszLArs7f27fJYyGZiAAOrrIBJOludSONz1EaNBFnc+s71xIbnLhcAtuZk8BanCfBtyWpfADbeltDoqajuDuO1iPEegqwvrKfNfrBPh6RRTfmJ2/kKVmo3ILCOZySW5qeuj3MQWldoAV8UlbpM9Dk2siZK4VJiHStmdh6RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(66476007)(66556008)(53546011)(64756008)(66946007)(52536014)(6506007)(66446008)(76116006)(91956017)(4326008)(2906002)(8676002)(8936002)(86362001)(316002)(71200400001)(83380400001)(33656002)(7696005)(5660300002)(110136005)(478600001)(55016002)(54906003)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GftqgE90Mr5vzHZ8MclaoYURkPPNBTNWGmSarrXpDv+PrLpCMzUSkfTUABVtNOtfYxVMRpUK/B6pekdN/Kr6lz41MO2yn96xKdOTbKetPxI/8qPXp6xozKTH8FvOfwWD6XiU+3Dvd2Ax/Z9xUZHbTot9ssb5EVy5SK+CrgVtZMLNhVSBOR1PS7cyr5mnMY+snzWkghHbImMgvCIN7TMhmctrfRAUQdFixEHaziDtn7Hj+tItKVM2cwUUbOFg5IB9rEGsW7tXOjbLiJVboA0OqltmB9ZkicAeIzw872V0XFh14lVNx7xjV98nLVJh+VK9YIqQWBktIfdccFoyY641QShEyf5H/5WkWjvCMfZueaTqXBrZz4JurZeodSPE3KcDsaTKmULnqEpWw/e5kBnsv17JWc/cJX7WxKGEJdeude61bx43B/YxnkntaItSeF/6zswNmorhEK+i5FE0s2gCZbubSMM9/2tCxTSlF3LKoycx72Ehzmnqrs3YxaA46ThYGG12MPPhT5bLdScfplJvhvLoHjQWYklZnH4PsgmHPqzzFLi7EtEv7mvYHgHgimRDyMy9kaLthOWR2/BY1XIAdJuX9LlPS5FOn4uM8HGnO6ZguJi5PtjQA3KT6Y3S15Fh1ZitR/dvYewBlJZpWNcDoAaVKSSROVTPditDucF7ekQUDxvo2VzMWUMLYkCgAiWCpGWLkCZ98MYbLw/SWdebiA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c44dae3-0696-453a-8dbc-08d85847abc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 00:46:51.9074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWp6OACGupZ0MBCKenOvTJzGELWPF4QB5Amg4ewBOQK9TYdpGcY0/8C4GQLBta7ZGT8Do4ipSY0D+HjlgP7mdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0374
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/12 6:53, Mike Snitzer wrote:=0A=
> blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and=0A=
> REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for=0A=
> those operations.=0A=
> =0A=
> Also, there is no need to avoid blk_max_size_offset() if=0A=
> 'chunk_sectors' isn't set because it falls back to 'max_sectors'.=0A=
> =0A=
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>=0A=
> ---=0A=
>  include/linux/blkdev.h | 19 +++++++++++++------=0A=
>  1 file changed, 13 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index bb5636cc17b9..453a3d735d66 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_sectors=
(struct request *rq,=0A=
>  						  sector_t offset)=0A=
>  {=0A=
>  	struct request_queue *q =3D rq->q;=0A=
> +	int op;=0A=
> +	unsigned int max_sectors;=0A=
>  =0A=
>  	if (blk_rq_is_passthrough(rq))=0A=
>  		return q->limits.max_hw_sectors;=0A=
>  =0A=
> -	if (!q->limits.chunk_sectors ||=0A=
> -	    req_op(rq) =3D=3D REQ_OP_DISCARD ||=0A=
> -	    req_op(rq) =3D=3D REQ_OP_SECURE_ERASE)=0A=
> -		return blk_queue_get_max_sectors(q, req_op(rq));=0A=
> +	op =3D req_op(rq);=0A=
> +	max_sectors =3D blk_queue_get_max_sectors(q, op);=0A=
>  =0A=
> -	return min(blk_max_size_offset(q, offset),=0A=
> -			blk_queue_get_max_sectors(q, req_op(rq)));=0A=
> +	switch (op) {=0A=
> +	case REQ_OP_DISCARD:=0A=
> +	case REQ_OP_SECURE_ERASE:=0A=
> +	case REQ_OP_WRITE_SAME:=0A=
> +	case REQ_OP_WRITE_ZEROES:=0A=
> +		return max_sectors;=0A=
> +	}=0A=
=0A=
Doesn't this break md devices ? (I think does use chunk_sectors for stride =
size,=0A=
no ?)=0A=
=0A=
As mentioned in my reply to Ming's email, this will allow these commands to=
=0A=
potentially cross over zone boundaries on zoned block devices, which would =
be an=0A=
immediate command failure.=0A=
=0A=
> +=0A=
> +	return min(blk_max_size_offset(q, offset), max_sectors);=0A=
>  }=0A=
>  =0A=
>  static inline unsigned int blk_rq_count_bios(struct request *rq)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
