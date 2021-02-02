Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D3C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B4864F5D
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBBJHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:07:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36189 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhBBJE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612256695; x=1643792695;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iF0DZ9rnXG9IAXXpL4dZhJNZwOQ+Fqx27n/QdabahYo=;
  b=QiGj2Yv7QymUMscVXDgfqqvLVRMMqCpU/u7mKrnXe4RneH18/rMvFbOY
   pXyTl4WexGCSKp97jaNLhGRqZfSytvt91k1aHU5PqdOBj7u6tPqWwJBy2
   wxa+aPRUFSLmupe10kMC1u/hJOB2oqhyPQrjFfcPcKrYbRbx/BjTPvXPn
   h9Eb2u5b6qt5SoaQv4wTAhdPIA6wgQ4DRPa0ffoH7sOHZmHdSxatiLK5l
   PVm8xwDD3IUHXtMqSGGW17+CcLXs2lFDKFWS0s0dIGRBgd9vZmWT8IRgy
   aKBs2dxwNHI7yCy8dg1vS4GsvMP0+uYe/3RRB87WZBn7a67W5fKyU8KUA
   A==;
IronPort-SDR: SyOxf425DDYyJjQfvdz4m0+Vx88GonJogG6Ojgr+xZWePiUHAzXMYuh1hPO/m8qhL9Jokg0HF2
 j/bTgEcyv5+b5VJX161rA534hCkZ85exQF/i+2V66hWIP5W8i6BAwnHNNcnzx8b+VF+oBWomn7
 iP1l6nhkwfwTgnZvfvia+pY+gX9LnvLdgDVHcXVtMwWTZsTMsu8TLZkMJ/k0LExC0uWORP4r7Q
 IYuddDxu+F9EgJGVo61dhxfQt7tD8pmme65x6nO94eHpRRRXyuR/xKCs1u/EGybZ3yy6yu8DjN
 tTk=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163350608"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:03:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4MAew7/Q62DfjiudB6CKcx2SlwPJzEIx4rnw+249t3s03QlXTFrnX0onaLL3pEQYsdQlYZRrS49eI3xNO9X0ePSP8U6VXGRpbwHdJ0EMgJU2iSrnowg6NpIMXhje87e5WjV9CUTSzqjwgRbsus4DQYrz4PI6uMqVdMM+b4nEAUePXLgaYfJTWAD6/aG18SZWk09BGN9YHDOTpXfxknd/3GwmJvAsMcWUrHIxAZrYRaptuIjbqmbarXkQKmXyPrRMo2rvXNqfyrtS80gLIEi52iiCQKJ8WBEuneQvSpEvjymO/G1itG1nB5bIq7qdWLnC5wz9MuW6oLLMTxc/H5hTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRTATr+M3j9nDa9Ozq8bgOxlslv2veDyKP/VO6L/j8E=;
 b=TrtDQ7EPxHOXubY9p33V3OwO90pM/yWVa/7blqx/ayLK8ubU3pGtPUeVpf0WTNzxj2jWXOdJw4KddwpFYKSuA8OR2C9Se1pYUCC4xUkn7As8RH8/5ZV0L+WIFTDkU1OTb1mSwzk7skkNaPErkZa7FdivQ2tFJyg6Pf7AfEs2jcqbxR1lvBknYaIvMF/UlY9s9krnSP+fx84KN7BXPbPMGy8F2/W6HBxDbi4TqBln8GiW/71xEZDvLGnYB4FU4fktDa5Kj85Lu4Hog/ST6tg6jgtDkK9ehSRD+lwZiYrS6UAC/7RzTfUMBVUhCeCHH0ut66rRAiwmP+eoy4N8mMmjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRTATr+M3j9nDa9Ozq8bgOxlslv2veDyKP/VO6L/j8E=;
 b=YJkrQph4Ln2+rYE5E8VZjD+Qm8MQVU21n+NsAIFQA0VQWvM2PmmtCQ5MRhCGW/AasNsNMHuuw1Ul917611pVGFBFX4Af04UvI5kkIT9m87ZfkRQeD5DHIjJhL/Rx+1WNd3pgV4OEiz9VcyH/taloC7lm4foxKEtAbvJZ2vmWuCk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4641.namprd04.prod.outlook.com (2603:10b6:208:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:03:42 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:03:42 +0000
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
Subject: Re: [PATCH 2/7] blktrace: add blk_fill_rwbs documentation comment
Thread-Topic: [PATCH 2/7] blktrace: add blk_fill_rwbs documentation comment
Thread-Index: AQHW+SPvWpJMsNU5wkOov45PKqDEWA==
Date:   Tue, 2 Feb 2021 09:03:41 +0000
Message-ID: <BL0PR04MB65144506A6D60F88D0840B59E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 951375b4-ec31-4f23-3511-08d8c759702e
x-ms-traffictypediagnostic: BL0PR04MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4641AC426D1CD00601A62025E7B59@BL0PR04MB4641.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRbifr1YJLAEMVQrG/cZaXzBRw1DZfoMwelFRSUMjxlXTpxzbm7tFNN/ZDP0ku4TDB17WmsNUHZro/OsRUA9LwpkNIh4hzNGcdPdNerHH44EhtA9FN7kP1+BxO/8vO5XVagFWoZCLFKUftEQMJKg3UXpGdg0aFa5a/GNS4EdeQTqITnxnZJ+IY3QKg10fwbDupXy/IcTy8yF2fxURoPNBhyUg5mzlGrgdPJdc+hExlK567x2J3oj3aiQq4WkL60Nvd1AXgv4vzefE+guiFoAcECVrl2gWjd4Z9afVBgBV7SbZGPfGksmIi/aiqTs8nMIDFWA8o3SK3E4wyztEcda6Sdcv9lawhGBPm9EqJ1yDubrYgGOaTsU0N9LZtU4mbYqqbKFkBJbgs0xmM6ke2/0BdWb8JkslJrm09Rc+Dql0FmmpxfzofmHO9IyAv+ej+IGkNo2n7T9t5+MBkX18v1klFBt8GDJYoHfmGj9DZewhA3lEWEKlNeGw3V6DSD7cbZJSChNiZ3vAk7y1KlwyZEisJPiGp1XN8j5+qvfrbyCF/Hm+jneA5pECBPkfirav8+7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(2906002)(53546011)(6506007)(4326008)(55016002)(186003)(76116006)(478600001)(64756008)(86362001)(8676002)(66446008)(66556008)(66946007)(52536014)(66476007)(91956017)(54906003)(71200400001)(5660300002)(7696005)(8936002)(316002)(7416002)(110136005)(9686003)(33656002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qZgNKdyiAzZfywCC25UqfYJadsytiXSSKamt0apU0jMronOjJlWAlLqOs3AV?=
 =?us-ascii?Q?4ly+guNUwWTT9SOWICgOA2v8wq+u0yZkl4Sj2n5cjhXgAzweq5CsrVkcdwW+?=
 =?us-ascii?Q?P/EWTYfY1KMFdOSrgEkDggydxHSnk7xOp53+zB+zFpI75KwaEFVIMvAX2COP?=
 =?us-ascii?Q?e0LM3t5S5KSmsbBgGSCVZcekf7HPU3iSPZI21RUiPM1i50Wj6jfYEKDKK1ou?=
 =?us-ascii?Q?KZ6KjxLcLIj8k+0zoq4iuUwq+ZadfKrQjCqrDpfh10mXV4mBQDxn9j2pxnpW?=
 =?us-ascii?Q?npyg/qETBk9MzWqLsXjsMgC78YBANatMuih+gkZ+3z/pxvGdFyGMJtaYchTk?=
 =?us-ascii?Q?gzYQcsMSfqKTHQNm+5iWcOrghVzbaSOVGn/uQtIQLgMTIUFlki7beae6OXWi?=
 =?us-ascii?Q?k+lQcrlKtGp5twoy2cYRm/JuqFs3OkaXQH1paZjZQtn49tVwKdhm7Sv6CgOR?=
 =?us-ascii?Q?RMcaJfg8XeUs7SItIFuu2dPZ2hM9neX5aVzdqFDZjnO6ICjWD42LSl9IaAXc?=
 =?us-ascii?Q?rz+99DV7sWpI3kYgtkMTpWjpF/z4Oa62om1/jErQNqEbc061Wq1q6y5oKZG0?=
 =?us-ascii?Q?WKe/RnEAiz8gtExguNXlojaCn7sEPSy52TLyLDE+oqqSdKn6EJciRZu3CDAo?=
 =?us-ascii?Q?vQDp9Y6XuNZ9cK2sG8BK3DxYqZ88mwDrhPx416hw9ixp8iphuJfYAMRnlL+0?=
 =?us-ascii?Q?exUQNL73JjDvkbif75+54VwNzFE9+oLSVxQDzPpT6PjJqC92j70pOAsQnQ8w?=
 =?us-ascii?Q?z++dWrIAZ+aKwUwarQYSW7ZgWYoETeWMZARthLIZbAssEbl/RXIdwxafziaO?=
 =?us-ascii?Q?GhCN8abuj2wkG4/KP+dFdg+fStXzqXo74z1oIEBUcPLrYbfmf3I5e6NJUAV+?=
 =?us-ascii?Q?XBbOjhLr6/kFxzCZXNDXWT1ut7BME5hFTrKIx5FwwXibvhgIoeyLRyawE0nD?=
 =?us-ascii?Q?gE3yE97RE5u/sCBsY/cRUc2HmwkHjjOKjpV/Z2XVWBwEefFIAj3nHaDp9Nda?=
 =?us-ascii?Q?ePaaK6ty3vRrDr1MaF7AW7OuhS6/HAPOeIYbgU7ybvDRlvFMQxYF2jAiizOF?=
 =?us-ascii?Q?u4JEkeoh+CsW25AI7MqVP69Lqwv0Ed3PRiXSHxJiMBt5QSNH0DIPuWIiVWEB?=
 =?us-ascii?Q?pxGDJJkFyHmimvWnmc+jWpkyKpBaSP/c3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951375b4-ec31-4f23-3511-08d8c759702e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:03:41.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTbZ6cRvqz2jH7m2ZltaABu0LKQMy2R7NQr/TFTCki7x9BXGq6R1mLB3vVf+EaMCNJWUi+JNRQEypji5c4I5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4641
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> blk_fill_rwbs() is an expoted function, add kernel style documentation=0A=
> comment.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 10 ++++++++++=0A=
>  1 file changed, 10 insertions(+)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 8a2591c7aa41..1a931afcf5c4 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1867,6 +1867,16 @@ void blk_trace_remove_sysfs(struct device *dev)=0A=
>  =0A=
>  #ifdef CONFIG_EVENT_TRACING=0A=
>  =0A=
> +/**=0A=
> + * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character strin=
g.=0A=
> + * @rwbs	buffer to be filled=0A=
> + * @op:		REQ_OP_XXX for the tracepoint=0A=
> + *=0A=
> + * Description:=0A=
> + *     Maps the REQ_OP_XXX to character and fills the buffer provided by=
 the=0A=
> + *     caller with resulting string.=0A=
> + *=0A=
> + **/=0A=
>  void blk_fill_rwbs(char *rwbs, unsigned int op)=0A=
>  {=0A=
>  	int i =3D 0;=0A=
> =0A=
=0A=
The description is a little redundant: the short description is enough I th=
ink.=0A=
But OK.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
