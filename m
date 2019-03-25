Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596FC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82EE2087F
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qb7xoJHu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gHHL3WgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfCYFHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:07:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45174 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCYFHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553490468; x=1585026468;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=17FNiN5cR1MgmfId4kf/yLLJenKGxeSRHUvo9YvafZM=;
  b=qb7xoJHuuo2bsrBjFFzsT8Yqtoov35lpdOwOY8+tDy0TL+dwtJCbiZgC
   yz2HP7cns6uUbdDo4h30zL8TQsQdVVl4+EI1bRClr3B6kix4OfW0pWnEA
   J9BUGe6ND8jCOuwOUvVpiqtM580lIAyV+9ApIjD9/GuNGr36268TVNJeL
   +QerAjXQMFIeXT8xrxFA+4OK4ITGNiVr154ASIoKUqQPW1htCABT2J3i0
   JWkVOSiluQDxDQQ4glaPpNW+Gdp9mTmH1JXNkTbtkDjMjH8fJ1f0PMfyz
   rK0MEVJASHnW1Z8uR8cRM2HR17AaRUI2LyNwxLhBkcEJ8eoQMEvOq6SuV
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105485351"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 13:07:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlIah/sPcMUU2JNGswr7dbqqxwh1md9cBfqFlIkzSkk=;
 b=gHHL3WgYW7/kCkEc+jFLYBgZIG+hmp0XQHkjb6x3/wnCs+E4oRpQcW4lV5pixb/H4GyOdRUMJazJe/8ZnQGIibfkHZfgmjOahApKJGDLtAvKHAqo80Fzd/P/731ytUWY4yErF0GCqGi1gKw0kjj8oLQ50sZ93nry7zeyhHwTLjE=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4685.namprd04.prod.outlook.com (52.135.122.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 05:07:44 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 05:07:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/15] block: add a req_bvec helper
Thread-Topic: [PATCH 01/15] block: add a req_bvec helper
Thread-Index: AQHU4DtfP/kzM9tipU6tpnsCPYbRqQ==
Date:   Mon, 25 Mar 2019 05:07:44 +0000
Message-ID: <SN6PR04MB4527D352D115DFAB042B18D2865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d73424e-e772-4cc3-322c-08d6b0dfd0ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4685;
x-ms-traffictypediagnostic: SN6PR04MB4685:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB468526252C1D907A3596BFD3865E0@SN6PR04MB4685.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(6436002)(106356001)(14444005)(81166006)(256004)(102836004)(76176011)(26005)(316002)(53546011)(6506007)(97736004)(186003)(7696005)(54906003)(110136005)(68736007)(66066001)(8676002)(81156014)(5660300002)(105586002)(8936002)(229853002)(6116002)(2906002)(3846002)(86362001)(52536014)(9686003)(71200400001)(25786009)(14454004)(74316002)(71190400001)(478600001)(55016002)(446003)(305945005)(6246003)(72206003)(486006)(7736002)(476003)(33656002)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4685;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oWA48TY+aGRgU1PqF7lgeLbRxgDYJK8LIQMhqveZ04vv6MjlLKNvx6Qpl9Ba4Ab8/g2M+j6PhvKOP9i8b0rufD351OOagklCpeWD7rpCBQ9irBR7+DLuM1iHyWkRGQh1TZatCKnsxJJIPY52xWEdHzFWH1A2fABUbr92+jj1hcpiW7FBpBstSGiBKyHxk4NnovldE1dKeixnKN5PPYlQ6YBQx3JzEZcbRYTrs+LmVYOcuiQIJtEzbZDsd1XN4reeubZ433TB+IHrAqDLh8QNCo+Q9k+8/+XptQr29LTpuACE8izfJQGnj0yKdT9S+UmRCCzsPcEkfdZNPj6tKPDoepAhTeRh6S2e9YTQJiE+jIZFxEQHTUykfi3/iXBfngHKPP6ZSqPBbEs1LV8O2Vn0ePenL0n2qafagM6ACequc3E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d73424e-e772-4cc3-322c-08d6b0dfd0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 05:07:44.7337
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
> Return the currently active bvec segment, potentially spanning multiple=
=0A=
> pages.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   include/linux/blkdev.h | 7 +++++++=0A=
>   1 file changed, 7 insertions(+)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 0de92b29f589..255e20313cde 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -929,6 +929,13 @@ static inline unsigned int blk_rq_payload_bytes(stru=
ct request *rq)=0A=
>   	return blk_rq_bytes(rq);=0A=
>   }=0A=
>   =0A=
> +static inline struct bio_vec req_bvec(struct request *rq)=0A=
> +{=0A=
> +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)=0A=
> +		return rq->special_vec;=0A=
Quick question here mostly for my understanding, do we also have to =0A=
check here for nr_phys_segments for the operations such as write-zeroes ? O=
R=0A=
=0A=
this may never get called in write-zeroes context ? OR=0A=
not applicable ?=0A=
=0A=
> +	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);=0A=
> +}=0A=
> +=0A=
>   static inline unsigned int blk_queue_get_max_sectors(struct request_que=
ue *q,=0A=
>   						     int op)=0A=
>   {=0A=
> =0A=
=0A=
Otherwise, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
