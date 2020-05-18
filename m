Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F54FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 02:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C8B20787
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 02:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GvXBt/nV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IMwLnxV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgERCK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 22:10:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12127 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgERCK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 22:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589767857; x=1621303857;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BCi0ttnNORDzUYktETvhKovWVOc0FKTN/0idsWaLQBU=;
  b=GvXBt/nV3RS0DKngGtYwwR8U8YbvLoyErNFw6PoPVm7LqFInHNWHmegy
   SUzh4U+AJEY6hLXvHPXT+ig/oy219qnmQpLO9vnpwZE6eeTct1EJwP+hf
   jYNxa/CMmqVKxS0s49VfXmW7qtteLonWqD5DGLX0Y5DhMS0/b1cmRbmFI
   N2z8OW5rYkASS21fc5nYTiEaylDVhvBhnQ/HOHPET1T8nSlY/AkfXJUpA
   hT+kb3lnd2xj4NYRve/EpcCt4gvDHKABntwLQTuVOlb41RSgtdBPN/a1H
   LXYPn18wIOSEwXXU4qowNP1jbTFnavZA+H4iFiF/1aQWw0euWFPrKANGl
   w==;
IronPort-SDR: xT7j0RCaBEF5F9oYtn4TEL+y0OCcxVyrnxvjHuV05jfP/UPkBOwM0EKDB3pZIGgiGf+TfbK4Me
 2I0cX9Q9QcEEvmvfFrDC7Y9PIyqOsNCfAmaJH/WajGMstqiW37+Q0DJVePbW9vt2ZJa+87hWiM
 6DWhi3PsW065IlKcLFUmKBJfYp+ypaPw4Ae+9eN6IwcieuDzJt0+/n4JHpJMpYMi/KB6XN+0oV
 MRnqhRuMsU88y8ORyEvJNuSOmTvfxuj/su+BiF/Uj5sLHqJzrOuieCH8EzRpHOg3ttKnI9tS5N
 E7E=
X-IronPort-AV: E=Sophos;i="5.73,405,1583164800"; 
   d="scan'208";a="139339600"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2020 10:10:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwXF+k3to8cpVISFNWCXlx4nCHJEw7+Sl8NfY4+XUwzV4zIdsVi1qGk9QYh11KEYOzyalT19k18x6UM/m8heYhv2C9LuT3sC87EEzB/OiRtXzkIfOzWKE8zAHp0otP5xkmUU9BnJ75DZp9mR98KDjLlRXuMIEX55Cy22KDMrPPyBjTiRmsCeLzDUpfXISs3HLDMogEuvFpOHeK6s8YR4lp8uvEF9AJLybzvhcL6XH0UHwxk7Fov4UkU+QwRdbNphbycsFSJBkWr6Z9K4hCATG5TpFvNbN9q41RYKvPwYVqMQaFf/fcAEtgNW6A28wtDZ7nqzNx5BnUqf6mkzMQTHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C+Bvh0QdQ+G2QsdIeHAb/K07ZfzKg2pFGp4EzH+bGA=;
 b=F3rmnJehRayI+RHo3kqJfldMFi7jVl9RLrttEzX5jmJzy5diaJQMsZYyjuTDzkyCfUtedi3yxOb6keENYYN/kw660i1emnQwHOk9Lexcyf1/ybePQr+W1X2rvq+lfQWM/ExvGBHukt61JlTDEZYPDcK3xmL7m58+73hglS4Z2tTI2lU1YzmzEfgKbW+HrVETjoqBQa9UxZU8uQiiDkkjgBNkhqPrxvOGN24sAuNTlOR6uOzrFdzz4GkC8IPDJBCk5DbCVq2G0irLJFZ3W94/trOvxTX4/7HDQRtOMOPQxYibuY0pIFhp9NzvTy+ObMHmC+t8/6A6IIONSDvmcLNCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C+Bvh0QdQ+G2QsdIeHAb/K07ZfzKg2pFGp4EzH+bGA=;
 b=IMwLnxV4uiooWYNf3yG1OD8tDVZ6Bs1rdPVg0B4ix3hZnm1iDKnn/J3ghMm8q+Nvbu0ZufHj0GuWziCsGYNXyDT3h0X2kwJ99Cu0w8qWjRIo8MzVvdS/Al2IUqcC5jffX82mG2zTW/XqHGplj5ChuBJFQ+U2Gqyir6Zt62ukwao=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7044.namprd04.prod.outlook.com (2603:10b6:a03:227::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 02:10:45 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 02:10:45 +0000
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
Date:   Mon, 18 May 2020 02:10:45 +0000
Message-ID: <BY5PR04MB690032A546EF80F2B823C984E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-6-bvanassche@acm.org>
 <BY5PR04MB69008A16B82CD028FC01D0A6E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <440743f4-1053-32f3-2edf-3eb0fdd057ef@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b409525-d3b8-4cc4-401d-08d7fad0acd6
x-ms-traffictypediagnostic: BY5PR04MB7044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7044F07B27801F6DB5C5A84CE7B80@BY5PR04MB7044.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSjRK9xQZahS2Dvo8p+Pmu4pIeXcM0ESrc7+9J/scS3urjuUg0M853n7EM6Dl2uJg0hFfFz9E3KF2SFz+YzVr23DKqaMchxx5fVmS3b39FSWelRZq1NsPBS87LoGgzsdOyYOE+15Ceq3Eyxn5golhyZnXRRNN3JtuC0FhQF40TQAWhg+2+iIW+cqnxKmBmRLnhgoDGIm2q+BSWpqRuKg812a9+O/Tkih3EYfVJLoci6jp6urmansgVrhsQlI2D0CNisBXwTWHCehGZmxVa7xUOOJZS3u3wAcf9Lmz8EJt1crz6eTMUCb9EXq8N3K2T5ucO6lM8QHHC4AefmexzqFct2u+Bq4NClyr+/Zb9QYOGVVv7FBu150LTM8hxkcw3xGKS4MuRfIRK7EZab2oN9dCMUNkOgELtJv1JZsrFCxs1f6HkHGczk0szoHzyFqBRfK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(71200400001)(55016002)(53546011)(26005)(6506007)(9686003)(8676002)(76116006)(66476007)(66556008)(66946007)(2906002)(64756008)(66446008)(33656002)(478600001)(4326008)(52536014)(86362001)(5660300002)(316002)(8936002)(54906003)(110136005)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gD0tBJsVFw019ZH3DTu0pDHJ1/k5Ws1qiOzqf0aNTKWjT6l0dXLC4Xkk7LA/Sf1rglCBPqO5uzIE+VaSovDKY4oLqgMH1I2I9o/+PH+vyPIF8/qnmMXSF3Lv2zphROa9NLo1LxagVxjjFDTUqO4U//wKG7PIRZP2rhoAVaZhgGhS8SqAhYB8ZRUyU78/H58Roxie763pQqJfklxUufzbYaqHlFJ0AfupXw1N4UhA4zRpyESqDUe22nKVt433aG/sUgKv6Hiirj460ntfSzpoKy1V8tCvMATWUhCNu4MNBChddHbXM15qavekCDRp5h5CyJ2JanAClgLuzXN0zN4iXjzYaDsuuhV+eSIzLfUDLt5rfk3BR2+pX6gCGdmteKGRxNTCLDcW8DY3gxQzWGpTnXE2ohgwS3pOLl1ylV9U828VM9KF5DeLFopxxsu/p5+oljFjb1MvUWujGccP0ahnT+Jl8Hky9J8rKS4P3gqQbcTYB+m8RPTYAxvRGiQ4cvoM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b409525-d3b8-4cc4-401d-08d7fad0acd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 02:10:45.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nhz4/eqbPNVZtNpIWNeacwgy0rg58mlbNuM4VnnQbsmGgoD0XaP7GLnFEZyEcqisBOqFBIZ267387Xz9es4l+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7044
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/18 10:32, Bart Van Assche wrote:=0A=
> On 2020-05-17 18:12, Damien Le Moal wrote:=0A=
>> On 2020/05/16 9:19, Bart Van Assche wrote:=0A=
>>> +static void nullb_zero_rq_data_buffer(const struct request *rq)=0A=
>>> +{=0A=
>>> +	struct req_iterator iter;=0A=
>>> +	struct bio_vec bvec;=0A=
>>> +=0A=
>>> +	rq_for_each_bvec(bvec, rq, iter)=0A=
>>> +		zero_fill_bvec(&bvec);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)=0A=
>>> +{=0A=
>>> +	struct nullb_device *dev =3D cmd->nq->dev;=0A=
>>> +=0A=
>>> +	if (dev->queue_mode =3D=3D NULL_Q_BIO && bio_op(cmd->bio) =3D=3D REQ_=
OP_READ)=0A=
>>> +		zero_fill_bio(cmd->bio);=0A=
>>> +	else if (req_op(cmd->rq) =3D=3D REQ_OP_READ)=0A=
>>> +		nullb_zero_rq_data_buffer(cmd->rq);=0A=
>>> +}=0A=
>>=0A=
>> Shouldn't the definition of these two functions be under a "#ifdef CONFI=
G_KMSAN" ?=0A=
> =0A=
> Hi Damien,=0A=
> =0A=
> It is on purpose that I used IS_ENABLED(CONFIG_KMSAN) below instead of=0A=
> #ifdef CONFIG_KMSAN. CONFIG_KMSAN is not yet upstream and I want to=0A=
> expose the above code to the build robot.=0A=
=0A=
But then you will get a "defined but unused" build warning, no ?=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
