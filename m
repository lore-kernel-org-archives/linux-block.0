Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CFC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A583D2070A
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IPn4RqiQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H9DH7MI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgERBMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 21:12:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5974 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgERBMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 21:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589764372; x=1621300372;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0v81CkogqrxJ1yNfQVE4lmLTTumq6AieIkngX0I/P8Q=;
  b=IPn4RqiQd6K0+EwuXRLh+LGqgNY2sccaQbuJYVufM7s7WtHjmkiuyxpQ
   4Xo3GRwON1YEwLOeDwenTlXW2Y9wT/Zp9Roc5JcWayEjnwtZeWtGseJZD
   Bfhz5Aza557dXiNAAcMSI0u+CxW2+hCy+qHnWunGNPOOuykk0Wru6PaqW
   ijmcvAh2RP4EMUcQdXoF87m6ogzQ+OengyeWCHaYphpczX4RzLxPYI6iz
   aOWvsfapYFakOszAnuTZhCaw66Iybvm9sjE0Lyxz2bjI5BvprgdXhL25k
   BgeXQXPlB8Ir1QSmbs4pctPfmG7qiv+0x7EnvKEgXzA7V71+E2UJ/Tbhp
   Q==;
IronPort-SDR: mOeKAtavsJCbIFcV7RXujBm94J9wGEEL7SrQlaBzDB/j6ReYBh33eF0MqQzLCSk48K0wNJETqU
 nnar67WUIetHuTha4a0QQpQFcbiPptDU8bOe92tMGy1n9wxewho2A5QkIRiXAw+U+AXdcqxvuA
 IIUoINdcAQ9Nr7ygggT+N7tKMh3Z7E7Ddz0b4O5cgPZO+Gzxx/w82vvOw3O4UxxU2PWPzwl3E6
 yooEHVUU6oVryPFB+kecY5r3nqRqYIirgd1sJPMTA6rEtW35Khsls0Xcw0FgBkYr012PtE68kT
 U1s=
X-IronPort-AV: E=Sophos;i="5.73,405,1583164800"; 
   d="scan'208";a="138237380"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2020 09:12:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP4JUg7WWKI3+Ab/yKfyrBUvx8QjIJVesqj/nLolnejCE4GONfs61DSYQYlG67/xRDDXmwqXkZQxLd4l/7wxP1BWNxPpOYRmVEYgyeyct9Ab1e+yVRaY6yJdJBNfJcx+a6n/uVlUhYXIruaM/IDgsIOHDO/VkuIfnD3QRsdUyNc5JPMvOYnvNQWiYvZzZD6NZPjkFue7up6PmC5POg804hpCR3zcgZNsBg9I2xCIip1tEP9jxsA/yEY3Nw2KzcbQ1mtKSCMXUEXWPvqrgMAzbLCYlPWV04IpGRm04sIlMWRCc0OOhqEOQ3alli2BC/Co0dy13bJbGFdJxgH+XSG9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVDCosFwqpp5afF8OPRCWX+YsBtBkYywKAhl2QXVTrY=;
 b=cjapZOr5v0tvH8KmiQZjOT96rwxnv8MN08DYdM7SmQD4x7RX444OPcJhTnKv/RGIncgUiV8Qy/6JM2ptSmJEZ80M4uG8JYrp4ZnjUPdZxie/7Y2i288QW9aMZImzci/geqEY2Bk1ocdR+ZMwTTVPF7908E0HnRZqEx7efllPLcL3ZWTCqVTFT0qtQIWyI6952Xzy3LI8XwcsMR3wVUKkFHA7faTD3kq0cFjvjB87BHdM246Z0CJH+tM9m3Oyi4lNXQiRg3zG1s0avXfbYJxLosv0L0XKGij644+Ovt9eji7W+E7O0wZVsRWFXw43Tk6JLb1tq/RAZGw8nTYol8iyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVDCosFwqpp5afF8OPRCWX+YsBtBkYywKAhl2QXVTrY=;
 b=H9DH7MI/Ef9v+i8NhuZF5Tj3shJpZj89m3QNb3sIPqu1kVAStD6Yfjk1QMG7oIe9bcifUvX0+HMOoLkMIouQmt3efGWLCyrqj8H55kJnqqsI1NXUHsjUnsuCTvtOtE1aZGAa/niDW3KXGFaUiohusAQD8mOAhOlFSlYCBdrncfk=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6293.namprd04.prod.outlook.com (2603:10b6:a03:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 01:12:48 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 01:12:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 5/5] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
Thread-Topic: [PATCH 5/5] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
Thread-Index: AQHWKxeutW6PgxRL9Ea9BZV4XxYt6g==
Date:   Mon, 18 May 2020 01:12:48 +0000
Message-ID: <BY5PR04MB69008A16B82CD028FC01D0A6E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d24a8ab-f53d-43fb-2b44-08d7fac8947e
x-ms-traffictypediagnostic: BY5PR04MB6293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB62937B6A842231494E834F3AE7B80@BY5PR04MB6293.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhtBGKMLAbzOSQboNsx7DIFCedn3LLvmT2/ySWNFDCUcv52fHvMi2UjaXLdG2qial75KxKd6P9MAI14WVBUhg/7yQ0sDHTtKLRfNpZhtLG1zFjg9SS+B19EYL1RjV4eknk4lDurCq5zDBXWaldX0xLQ2XIRxYIQbEVH92d5ES9SF1nnelo2FxqRvews2Db/S2wzbvz18KAhKdfwSUeflBGkjTuWgRnSBhZ1xX14UsEBmrS9HcHEOTEagfC27J/y3xZMWsdkjIXyCHIszLKhpBvUq/byEe8wqYBzXHxnnVJGkrhFiECq9N0HopNAdxoZExYrOfpGnNdrLRhIfok8YLqc0eCyHupSZ5YuhX3G/pDgZjCorblA3vkbmQqHOMISELO4VLAGm8kv0bJ0tFlW5DST+ABFP9WeGfIYVQKKbbU7JqEl3rfDkt/feUJqEy3f8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(71200400001)(110136005)(53546011)(7696005)(33656002)(54906003)(76116006)(316002)(66476007)(4326008)(66556008)(66446008)(52536014)(64756008)(5660300002)(66946007)(2906002)(186003)(26005)(6506007)(86362001)(8676002)(55016002)(8936002)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: o8/oSyVbI06vlWjq8hfwB2Gjye4JJq7t71ObzwdMDPDHsG84qEkOzu1+AmJjBY9uJM7sNAskBEO/YgEL+Qzc1VqKu7jLFPa691p/OFoso/iqZPgNHsle47E6v0irgegeRYLEQVQYV5gU6NTbV3MzxxUPQxzNruWqSNs5+cI2RWTpKECMAjaqdQmHRFLiU0c4JoQii23Fgrt7pVJIa50tjitNpO3da+diOfGjAnAaqD+NQD+0cR08BePPWGMtz9/2W1M75kCYMBJrtFUzHOZiUWkn44ZWj3z0bbLynm22dt5/0IJ2LaBXuYQWCdbQX6eNNiBb7oYOjUBajfnzEQdd0WR6CJPbVU6kw0R39TNnev/TUaDef7RKbWfy3bpFGenwCAop0adEynj42Ahmx7/J8v2veZU/w7hAANSJL2HSgp2nhZYymc6k14sA4iXaXB8e8dYLWisLyGbhPEYj9+Ll223ukFr+Y0uqtQlaUYLf9Da7loPME1yLeS0yEPZ+Ei5f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d24a8ab-f53d-43fb-2b44-08d7fac8947e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 01:12:48.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qieD2e/fYNF2B6SASHPjfN6UXrGYgbaEg+NLG+8l6F8UE/j/z/LQZ5UD+bW3l9l4OOFcN1c+oB2wjLu0Fr8gXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6293
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/16 9:19, Bart Van Assche wrote:=0A=
> This patch suppresses an uninteresting KMSAN complaint without affecting=
=0A=
> performance of the null_blk driver if CONFIG_KMSAN is disabled.=0A=
> =0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> Cc: Alexander Potapenko <glider@google.com>=0A=
> Reported-by: Alexander Potapenko <glider@google.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  drivers/block/null_blk_main.c | 30 ++++++++++++++++++++++++++++++=0A=
>  1 file changed, 30 insertions(+)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 06f5761fccb6..df1e144eeaa4 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -1250,8 +1250,38 @@ static inline blk_status_t null_handle_memory_back=
ed(struct nullb_cmd *cmd,=0A=
>  	return errno_to_blk_status(err);=0A=
>  }=0A=
>  =0A=
> +static void nullb_zero_rq_data_buffer(const struct request *rq)=0A=
> +{=0A=
> +	struct req_iterator iter;=0A=
> +	struct bio_vec bvec;=0A=
> +=0A=
> +	rq_for_each_bvec(bvec, rq, iter)=0A=
> +		zero_fill_bvec(&bvec);=0A=
> +}=0A=
> +=0A=
> +static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)=0A=
> +{=0A=
> +	struct nullb_device *dev =3D cmd->nq->dev;=0A=
> +=0A=
> +	if (dev->queue_mode =3D=3D NULL_Q_BIO && bio_op(cmd->bio) =3D=3D REQ_OP=
_READ)=0A=
> +		zero_fill_bio(cmd->bio);=0A=
> +	else if (req_op(cmd->rq) =3D=3D REQ_OP_READ)=0A=
> +		nullb_zero_rq_data_buffer(cmd->rq);=0A=
> +}=0A=
=0A=
Shouldn't the definition of these two functions be under a "#ifdef CONFIG_K=
MSAN" ?=0A=
=0A=
> +=0A=
> +/* Complete a request. Only called if dev->memory_backed =3D=3D 0. */=0A=
>  static inline void nullb_complete_cmd(struct nullb_cmd *cmd)=0A=
>  {=0A=
> +	/*=0A=
> +	 * Since root privileges are required to configure the null_blk=0A=
> +	 * driver, it is fine that this driver does not initialize the=0A=
> +	 * data buffers of read commands. Zero-initialize these buffers=0A=
> +	 * anyway if KMSAN is enabled to prevent that KMSAN complains=0A=
> +	 * about null_blk not initializing read data buffers.=0A=
> +	 */=0A=
> +	if (IS_ENABLED(CONFIG_KMSAN))=0A=
> +		nullb_zero_read_cmd_buffer(cmd);=0A=
> +=0A=
>  	/* Complete IO by inline, softirq or timer */=0A=
>  	switch (cmd->nq->dev->irqmode) {=0A=
>  	case NULL_IRQ_SOFTIRQ:=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
