Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3430C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B368F21841
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mvBk7e4n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jh2KhD7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfDKG5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:57:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13023 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKG5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 02:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554965863; x=1586501863;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UAVQz4IYopokjkzrWMepwKQWuXGJ6XrwgYkrP2UP9VA=;
  b=mvBk7e4nkv7aeumDMUZWBnCHzh1dm7lysqCZQOUQ3Fn5rQh/aAr7U8sC
   9bHVm4R+pwIvDBnHc8NhFaeQF1RTwUXhLxPUKp1RXAid3b8n8+zFlBPZW
   S28Dp2J/aFcINGfDl/AsG/gAyKIIQMYVN7iiCJCY6nJOuEKBEb9wv3zFC
   F+Kapw9LG6le3T8Qu/bSOf5SqvuvzW/MHkKbBAx9gCcVxO0y/Tsq1SZfV
   HqFU5qjk+5l4TbxwTN8HN8vWzW6VWexvSY/lTHl/8fmDwjrWn8kaU8W4f
   gWTvORkFq6ptA+om5fCBIAk8tx8ghR2bbw1J9AABxPnXgg4TgoBag6RCR
   A==;
X-IronPort-AV: E=Sophos;i="5.60,336,1549900800"; 
   d="scan'208";a="106871196"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 14:57:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+XORy8DuqF7b4jWFz5M1/qGRt1HiHhui3x3sn03rNw=;
 b=Jh2KhD7oDEQR9BJgCS/PTEgcLDIlbQCp2EPCM+x5deKVvR2jOH3RVWVaS2sH0a0ujsfPlh1qLDHDxPZ4kAWLyg4N8kuc4/9PEuOElFXOj+I5m5+sSOSCPlO/kfrv45PDkOlhdTaxu+iNLic4VGDMj2DFuxRro999yndOjwxPqMU=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5360.namprd04.prod.outlook.com (20.178.6.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Thu, 11 Apr 2019 06:57:39 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1771.019; Thu, 11 Apr 2019
 06:57:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "miaoxie@huawei.com" <miaoxie@huawei.com>,
        "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix the return errno for direct IO
Thread-Topic: [PATCH] block: fix the return errno for direct IO
Thread-Index: AQHU8C/Gia3tkU02o0uutSZ8uUOZVw==
Date:   Thu, 11 Apr 2019 06:57:39 +0000
Message-ID: <SN6PR04MB4527D003C972F9E689E71BE7862F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190411064549.13318-1-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 370a526d-a6c5-4513-42e5-08d6be4afc93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5360;
x-ms-traffictypediagnostic: SN6PR04MB5360:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB53604EBECEA0E8F192C98912862F0@SN6PR04MB5360.namprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(4326008)(68736007)(8936002)(54906003)(478600001)(7696005)(76176011)(72206003)(14454004)(86362001)(2201001)(105586002)(25786009)(106356001)(316002)(2906002)(6506007)(5660300002)(110136005)(52536014)(229853002)(99286004)(186003)(256004)(97736004)(74316002)(9686003)(71200400001)(53936002)(305945005)(476003)(71190400001)(3846002)(53546011)(6116002)(7736002)(66066001)(6246003)(33656002)(8676002)(102836004)(81166006)(81156014)(486006)(446003)(6436002)(55016002)(26005)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5360;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WEhkWUpyyrGe2u2BC+Zap/RC2c+OYp2gZDIJW894OkdTw08owzKW3ZEVzDmuYR7Vr3Eum7AXNvYQEsFX0dGhNY9/Oa61iLBmyjGZniv0cHpsh7+Pn0Zrx4EcfW9EcWCi+KLk/ktFeFtNob0xFUChPckLUAVe2L2ZykVkKPKKBvMqwHpJJ8b2ca1+N5rPQbPjJaI6RYXy14ISiOJGteicUZ3tCp3CujRcYBaOiywFR+UuK3cg5oDdMUEYygDLCJVqLVOgzn/LajZkAF2VPoF8bvSdn94TWtcTnOcQufUznvIFUvRhyeQUM0dSN8Cq6Ll6c8QR6YHmYJhqp6Enc49NtflJydRGJK8DCPRmVfeAyJ1DEgkiALghP4s9VVcX8p8JOf48LMhu1X77nHTNmlakCZXqLNkdEk6d0+8hmMh/D3A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370a526d-a6c5-4513-42e5-08d6be4afc93
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 06:57:39.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5360
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/19 11:28 PM, Jason Yan wrote:=0A=
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
>   fs/block_dev.c | 16 ++++++++--------=0A=
>   1 file changed, 8 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 78d3257435c0..0fead5520a7e 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -84,7 +84,7 @@ void kill_bdev(struct block_device *bdev)=0A=
>   =0A=
>   	invalidate_bh_lrus();=0A=
>   	truncate_inode_pages(mapping, 0);=0A=
> -}	=0A=
> +}=0A=
Didn't understand above change, is it possible to get rid of above line =0A=
change ?=0A=
>   EXPORT_SYMBOL(kill_bdev);=0A=
>   =0A=
>   /* Invalidate clean unused buffers and pagecache. */=0A=
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
> @@ -670,13 +670,13 @@ static loff_t block_llseek(struct file *file, loff_=
t offset, int whence)=0A=
>   	inode_unlock(bd_inode);=0A=
>   	return retval;=0A=
>   }=0A=
> -	=0A=
> +=0A=
Same here.=0A=
>   int blkdev_fsync(struct file *filp, loff_t start, loff_t end, int datas=
ync)=0A=
>   {=0A=
>   	struct inode *bd_inode =3D bdev_file_inode(filp);=0A=
>   	struct block_device *bdev =3D I_BDEV(bd_inode);=0A=
>   	int error;=0A=
> -	=0A=
> +=0A=
Same here.=0A=
>   	error =3D file_write_and_wait_range(filp, start, end);=0A=
>   	if (error)=0A=
>   		return error;=0A=
> @@ -983,7 +983,7 @@ void bdput(struct block_device *bdev)=0A=
>   }=0A=
>   =0A=
>   EXPORT_SYMBOL(bdput);=0A=
> -=0A=
> +=0A=
Same here.=0A=
>   static struct block_device *bd_acquire(struct inode *inode)=0A=
>   {=0A=
>   	struct block_device *bdev;=0A=
> =0A=
=0A=
