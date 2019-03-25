Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43303C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0761A2087F
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qFNwiXYm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M498cil5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCYFLl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:11:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64798 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCYFLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553490867; x=1585026867;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=I59yGgaXoR89E4vdVGW1kPWL8GolEv98TFFEyS0pjFA=;
  b=qFNwiXYmNaPNvWoaryVgU/vqQA/9E9UyUsNHXT3wIRiIrmQHhTL/hdSG
   bBtHonRbu1J14DdiuVCQR7lXzgjZArWNrKhce4JtuBUVXuuKiFGvvzs9R
   dCFhnVkZMgoZH609gQF6YWq4vtJVto9w8zpbgoRG3qyt8xYorgDIPV80N
   UNz8fICrnCzsAR0Zm+nscwMbbMaUnyxqQgks9FYOOiY/EagyvqcoDOAUC
   d1VOdNZ19bYLjoR37f9dVEfgy9NWKtO1K8nePHviJ7GARl6bVm9wh5Fxt
   mOp4aPDsa6Dh6/mNojns1M18MMHhDkHyVg7mQJcoLFDZOmM1CP4IycPe3
   w==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="202866276"
Received: from mail-dm3nam05lp2058.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.58])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:14:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st7idudlP8ZQmIOyMgTAi+jABDH45NMeoPE3CUEHnVI=;
 b=M498cil5B8Ebg0TJKrsyq5xnxMcLcguYcH4XOJiDOoLPZ/6LdqmcOi42HzQ2HKCxolakvprl9NQj+RAxKeWSgxREbZYUk3Drtoc8NHSQriApZNQjQlMjG94LnFlh7w3vvpBfjgFlGVo8Me5d3HHThIr5f19b29Fs5V3nHW11eFg=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4685.namprd04.prod.outlook.com (52.135.122.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 05:11:39 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:11:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 03/15] block: add a rq_dma_dir helper
Thread-Topic: [PATCH 03/15] block: add a rq_dma_dir helper
Thread-Index: AQHU4DtloU1UsATjpkq41bxm0n3hMQ==
Date:   Mon, 25 Mar 2019 05:11:38 +0000
Message-ID: <SN6PR04MB4527A8C93426D5C2364FDE68865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [65.123.219.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff65278-8406-431a-44b2-08d6b0e05c81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4685;
x-ms-traffictypediagnostic: SN6PR04MB4685:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4685FA3DBCFF3865B91C67B0865E0@SN6PR04MB4685.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(71200400001)(52536014)(4744005)(9686003)(74316002)(478600001)(55016002)(71190400001)(14454004)(25786009)(6116002)(86362001)(3846002)(2906002)(53936002)(4326008)(99286004)(6246003)(72206003)(305945005)(446003)(33656002)(7736002)(486006)(476003)(186003)(6506007)(316002)(53546011)(97736004)(68736007)(66066001)(7696005)(110136005)(54906003)(106356001)(6436002)(102836004)(26005)(256004)(76176011)(81166006)(14444005)(105586002)(229853002)(8936002)(8676002)(81156014)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4685;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HJeoZ/HBhw7V12py+A5iYJnVNMjUaKIHmfMboYkHzlAL0UQyeN0dxh1xKKm6U9uVuCS20bNF+fEnyklLafElffaew6BdU9mLqoDTjpxHSH2hKBIWa5JDCMTFHn3rSstfseMxxpfliwAcRmFrlExgh1pHishxP54cln3QavDohECYr6cu4HolGD3uVnWybcGi8x3El/CLoTUzpWJ5Z2DmF+E4VQHQ46B+++tky/INXKpQNcN33SvGY0Ba/38LOlchkBRAb2XDdyW9Gomadv0JAKVUoRwwvPSLi/yFk6xCfu+UsCZcKuwVe3gjhi/6wNyZltyDL3KuAGrJt0ar2xPZH7JOESg0xMnxaUsql4bF+8ULHmPkrmM77v6L4VVXDs7fdhvEFltiKzKSa9PfhEeaA0Yd64LnW8rejAVRtO1rnQA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff65278-8406-431a-44b2-08d6b0e05c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:11:38.0615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4685
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 4:11 PM, Christoph Hellwig wrote:=0A=
> In a lot of places we want to know the DMA direction for a given=0A=
> struct request.  Add a little helper to make it a littler easier.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   include/linux/blkdev.h | 3 +++=0A=
>   1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index f9a072610d28..5279104527ad 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -638,6 +638,9 @@ static inline bool blk_account_rq(struct request *rq)=
=0A=
>   =0A=
>   #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)=0A=
>   =0A=
> +#define rq_dma_dir(rq) \=0A=
> +	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)=0A=
> +=0A=
>   static inline bool queue_is_mq(struct request_queue *q)=0A=
>   {=0A=
>   	return q->mq_ops;=0A=
> =0A=
=0A=
Apart from Johannes's comment looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
