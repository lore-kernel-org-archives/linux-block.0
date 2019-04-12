Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F7C10F14
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8B82073F
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Czq+EI4q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c1UsKeHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDLDhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:37:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54935 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDLDhm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 23:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555040311; x=1586576311;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QzHKdcDB3kk9qbXYs8IeX/HqhXl9WowBJlbDusU7M3Q=;
  b=Czq+EI4qUHsu8MDbxQRxEJn43STOA9/gCpXsSu/QfGHr44b2ap9ChGL6
   nUTp9qWmcpIBOipVlDXo7dKYd0VwUUW6H74jioWyqpislGbDAGfYfPLOm
   dnpDMWRM7SR1XSh0grECq1UASHE2AR6GMYVkoQF1PDagYKeXThIXEHmnv
   /O/HkZCtrYHdJm5a0o7svTM3M8MYm6OLua0fpsYzsvDzQilYvwkyivTz3
   bXYYqi+ZrsMO/gH3VhdAnM0zLLelAQf/wLsvcZAbztApkrJnbx8Mp7gQA
   W2AYDM8YeJKmy+Jfh04NOviq5o7I7/u3ZdZAL+iJu7z7kRQ9XUlVLYVWm
   w==;
X-IronPort-AV: E=Sophos;i="5.60,339,1549900800"; 
   d="scan'208";a="204638086"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2019 11:38:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqNzGkStcolC7GJ5Jdiqlz6XTP1Pk0eaFSE2C7uGQMM=;
 b=c1UsKeHfDA0YzelI1z29n/5NCt4cSbhibfrm3kMwg3dC0hZoO6jGTXhV2c9l8koTQH2Ubke27DInJdxKqMuKwLCTKgW3kjn3DCKJPJVPXByhu3sE8A06q74bPtoRj/ICkanZen8+9kc9/jaV77D97QWbDw1vD6EFuV8Js+6asws=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3918.namprd04.prod.outlook.com (52.135.81.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Fri, 12 Apr 2019 03:37:26 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1771.019; Fri, 12 Apr 2019
 03:37:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "miaoxie@huawei.com" <miaoxie@huawei.com>,
        "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: fix the return errno for direct IO
Thread-Topic: [PATCH v2] block: fix the return errno for direct IO
Thread-Index: AQHU8NJVTg06atFFbUS+9Aeb0W3R8A==
Date:   Fri, 12 Apr 2019 03:37:26 +0000
Message-ID: <SN6PR04MB45276A5F93D629088DE810FC86280@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190412020916.1160-1-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0bf03a4-3788-4c57-5581-08d6bef82ec1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3918;
x-ms-traffictypediagnostic: SN6PR04MB3918:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3918FD78838EE1302E6F24DE86280@SN6PR04MB3918.namprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(8676002)(2201001)(54906003)(68736007)(476003)(6246003)(102836004)(99286004)(316002)(4326008)(5660300002)(256004)(8936002)(446003)(2501003)(74316002)(86362001)(25786009)(97736004)(7696005)(6506007)(6436002)(3846002)(9686003)(55016002)(33656002)(2906002)(110136005)(14454004)(486006)(305945005)(478600001)(106356001)(186003)(81166006)(26005)(6116002)(71190400001)(7736002)(81156014)(66066001)(53936002)(105586002)(76176011)(52536014)(72206003)(229853002)(71200400001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3918;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FgNmHGhrUR2BjD5mDCEjgryAdKDKlR9vryRtEIzNt6OVE2//6xkN1HvyhObBKE8j4y+DoWzJzx6oMmtFciHun9WMpKGOh42ngxMAUhjuFzcgdjQQU+uV9HGtY6OTjQrBjepEFQIK4hUvu7+5XXXCy53uajpAXXGp0CRNi+3/ON8ntPiSpyv1lA4U25pIl+zHIzr1hWDym2qo3xs5/jCs0TWYpvbLNEiKd9QySd+DwwWN09uMLBNkkl98mClyk1T5AzWjRAts+mRAnoG911TQP1YvvLJhs9L2F+612bqPnlrYnvH/t8GCS3fRu90NYC6rgKr5sOCXcgPa4lGDDNn3NrD8knMDNRQ8+F38w2DugDwc2ER4so/LXPwZbpuetfSUwXj+4IuYB1aY6xm50+m7IaJbPcH+aqgbd6P7Heqnq/8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bf03a4-3788-4c57-5581-08d6bef82ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 03:37:26.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3918
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/11/19 6:52 PM, Jason Yan wrote:=0A=
> If the last bio returned is not dio->bio, the status of the bio will=0A=
> not assigned to dio->bio if it is error. This will cause the whole IO=0A=
> status wrong.=0A=
> =0A=
>      ksoftirqd/21-117   [021] ..s.  4017.966090:   8,0    C   N 4883648 [=
0]=0A=
>            <idle>-0     [018] ..s.  4017.970888:   8,0    C  WS 4924800 +=
 1024 [0]=0A=
>            <idle>-0     [018] ..s.  4017.970909:   8,0    D  WS 4935424 +=
 1024 [<idle>]=0A=
>            <idle>-0     [018] ..s.  4017.970924:   8,0    D  WS 4936448 +=
 321 [<idle>]=0A=
>      ksoftirqd/21-117   [021] ..s.  4017.995033:   8,0    C   R 4883648 +=
 336 [65475]=0A=
>      ksoftirqd/21-117   [021] d.s.  4018.001988: myprobe1: (blkdev_bio_en=
d_io+0x0/0x168) bi_status=3D7=0A=
>      ksoftirqd/21-117   [021] d.s.  4018.001992: myprobe: (aio_complete_r=
w+0x0/0x148) x0=3D0xffff802f2595ad80 res=3D0x12a000 res2=3D0x0=0A=
> =0A=
> We always have to assign bio->bi_status to dio->bio.bi_status because we=
=0A=
> will only check dio->bio.bi_status when we return the whole IO to=0A=
> the upper layer.=0A=
> =0A=
> Fixes: 542ff7bf18c6 ("block: new direct I/O implementation")=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Jens Axboe <axboe@kernel.dk>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Jason Yan <yanaijie@huawei.com>=0A=
> ---=0A=
> =0A=
> v2: remove white space changes=0A=
> =0A=
>   fs/block_dev.c | 8 ++++----=0A=
>   1 file changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 78d3257435c0..24615c76c1d0 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -307,10 +307,10 @@ static void blkdev_bio_end_io(struct bio *bio)=0A=
>   	struct blkdev_dio *dio =3D bio->bi_private;=0A=
>   	bool should_dirty =3D dio->should_dirty;=0A=
>   =0A=
> -	if (dio->multi_bio && !atomic_dec_and_test(&dio->ref)) {=0A=
> -		if (bio->bi_status && !dio->bio.bi_status)=0A=
> -			dio->bio.bi_status =3D bio->bi_status;=0A=
> -	} else {=0A=
> +	if (bio->bi_status && !dio->bio.bi_status)=0A=
> +		dio->bio.bi_status =3D bio->bi_status;=0A=
> +=0A=
> +	if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {=0A=
>   		if (!dio->is_sync) {=0A=
>   			struct kiocb *iocb =3D dio->iocb;=0A=
>   			ssize_t ret;=0A=
> =0A=
=0A=
