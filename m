Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B21C56202
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 07:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACFC2466D
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 07:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mo2WLvKj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nD/KE72X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgKRHQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Nov 2020 02:16:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21684 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKRHQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 02:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605683785; x=1637219785;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=liIm8+0LofJoNQtR0SezxWx2YGMwpOKzIqFAmsoJmXo=;
  b=mo2WLvKjaf6TbZ7XaQ+f/8U7xDlFpsccy7Zbqz8+lbja5/FYtJJ0wsIN
   bHAuE++jldZXulxbp2HccyMgdAo6eHc1c5EFqx/mT6KJuw7INAl+EYD9S
   GuIcSyL8nT7ralJkdoQl4NcEuBMiVcuepE+3TocMXi9HwCZLYXAM/5sDD
   7DJtn9SOeCIH534Um280HAG1b1Ih/JBlv4dBgiXoajCN/8kdv467VK7dq
   cHpM/3YqofultYn2XDykWnTSl3EMx1Fvc1f2IWcpORoG7wurUYHqoK5XG
   l3oU+Q5sCzHlaXIA7hAzdr0B1ucNWkeguSxpquAxiHN5pxFBMrs+VPRdD
   Q==;
IronPort-SDR: 4e9RknY+lpDfFd7rlSzHzomFlegau1C7E6q2L6ZBK/97Lwes/ZiKizh5PwZmd4oifO/YhYrqOf
 8LGteanWWwuYNIfReGdEcf6Vz1QIbR/TrD5NmWqTQLwltMEc39ox/20SVBSVnPDPIO0Nw1DRsC
 18vFD/K7v9gSnVWr8TmA8OtpMqdLM2WxFtJbEtVN29fBAGQStQq5B/9ns1p6bl3EJnKmGWWVrQ
 /A8gtjl5c9VGfetUc0pM+xxNQOe7n7cg/3ufSg+KxYIUkmPU+995FFLSPDyfQbogjrQ078v3hh
 558=
X-IronPort-AV: E=Sophos;i="5.77,486,1596470400"; 
   d="scan'208";a="157340786"
Received: from mail-bn8nam08lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2020 15:16:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD7Tx/s3JrUotLhLNPIcWigcrVSkr7qGTA5yvv6TsLbLIYSmKRWa8QqAqqR9TKYCWcvMen5jIEwDEgO/p0ufJp/E6SEesxz1jQZFSy8JTApEqHxHv5GsS7ehBbv1wjnAY4X98zjGmd+3vi2dbqFLdfYmr9x/cuJ40K999sUdFxzWpRytU+d9el7dCzHr85fcnDsDNOuy6dBGuhY7I4Eq4igHf2m2tvOhUvEmxbi4EdpG/assXkqvCgXVD7RkzfM7Mx9NcAQpcdunnPwPXgaPU6HZH3WsB8FRqVwh8za4hV4WRqZTfOQgAbfXUUR89Ok+mKcEgiid5mC7DBWq8BTFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA/usmLBGGH+VucD5SQQy2sHkWxIEVLFnMuyoSPDUUA=;
 b=Hx0N8DGXKEdJJIJbNXIG1KYE7rNATzmpksIvAv3WIYjfMjwvKDNQudI996Xzz2oWj6bhY2fz/ftMgAwU9jfxmQ9UZicJGdLpPoSoc1ttG7kWPezUagEda/AJQb7n/L49qCUJcF7fh5E9Bl6QpSyg3jsucqwFHAgt6nupLdPZhshYh8ZCET+7QoFnuJs5qZpe5V4xCeiWr50vMpldkCcYN0Mrtl/hH14h6c6ftyJ9B18ZMaQ3X/ruk4qaXhCTIf9mt9sCjvmgCft4jqqJR9gOvXo1yTGBqAuQpvv9kv+6D7d9jBLLvALan6PIVkUShbweVevS8Xf1RCuHE51oHZ6SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA/usmLBGGH+VucD5SQQy2sHkWxIEVLFnMuyoSPDUUA=;
 b=nD/KE72X2EIBNdvy/5ErQ2BL+WqLOHLvmQVXMVH14O4StEw4/mE4IQbUJzmtYDnZTJ1HRMWjijBxGR5FH8Y0jvxhbKQN6kIFKIuddR7BcnEYbhvu8gK9feeBfT4YM7T5BmsAdlnhAUJq4ozPp+fUJBFcL6ZxPpQaLQCXLpKkJ8o=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4850.namprd04.prod.outlook.com (2603:10b6:208:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Wed, 18 Nov
 2020 07:16:23 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.034; Wed, 18 Nov 2020
 07:16:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Dongjoo Seo <commisori28@gmail.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbates@raithlin.com" <sbates@raithlin.com>
Subject: Re: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Thread-Topic: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Thread-Index: AQHWvUS9kz33/BmsMkSSoPzrA5Ut5g==
Date:   Wed, 18 Nov 2020 07:16:23 +0000
Message-ID: <BL0PR04MB65144A3EE2C24C430347AEBCE7E10@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201118004746.GA29180@dongjoo-desktop>
 <20201118070714.GA3786@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b96a:a84f:2aa:fc65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 060de223-848e-4574-b29a-08d88b91db03
x-ms-traffictypediagnostic: BL0PR04MB4850:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BL0PR04MB4850F040E5EFC83E298A9F80E7E10@BL0PR04MB4850.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWHwK37andLZges4JCvt7ADzzBSn6i+GuL8GqtIx1e03W1lxK3zFcovx54zMf/xHeHqPVXCEkHKKnVa39GkO0ax4/oo7wu2XAwrZ16m4NMnleABIj89AV/GyssXa3cW5mHHzF7ZfXjDeAEx5nrLOEpGOIRtTtOWQv/5dumP4fIs9rCXAc0YepzMqs2eBe9ZCZ9hA3eFrfjL4LtEOPfKcj5qSKxTosqo+4f/6OtaNpwg0mOR+EMjtHACcElkkV7uWSmg7TZvbJjts/CeYsvpTwlbJcnKjaGBTQjiwYsaZ6RdB5zNpeuEEX7dhr3+qZR5r8FX2jWc+4lDWhapAsFHT8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(186003)(316002)(5660300002)(6506007)(52536014)(8676002)(54906003)(53546011)(86362001)(7696005)(2906002)(110136005)(8936002)(83380400001)(66946007)(4326008)(66446008)(66476007)(9686003)(76116006)(478600001)(33656002)(66556008)(71200400001)(64756008)(91956017)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t+A7yitiW0vdwqUQ7oET0GXuogf49sCtmIZkRmvnXOsDi+5itWoMB4Qi9oMyAuADB1iMHSVu97RYTFT+++PW4dT/0DLhAwVqZT0Zdv/YLchNYXCOmZi7luxCBsf4OWlC040BPtMyXWXnWe8AKA//F0i50ZPsjJzeKXh+IZUl8rcaU2/b1p1ber1lWbYKpQrSxzkBmV1tzpIqW81f3I/RAhP9iJKvyZ1PM2YMJXVZ4DKhdLn9UEuPCX0CEMe7Ou2iFr9qwLA+0/igkFGGTwaCw3h7J2Bpch4kyRyw/b9BSnqA863KPKWk4L8WZQe5rB+RmnT6EMo1efkwNS/0ktF28mSUaj/z6LOCS/Xd8KcgCpPhlTteDO6WGTCwYY2gIOZ8hhTPVxjRwo/iR8cDyecm269V4JiV1T2L6iHgMrpsrvX8dq/4QobyiRXKihGLTqCl55X6kJEJ6+KOe0a2hs6JbRzISrVdT+0rifQEErPVkJvhz3xNVBxpqml/opY8aAIfe7WzmdgjNnkE/iUizQOBITExoBGwMHpjaKdzcVx6lS4rm1svOdB6eC07PeJXEaxJIwK3lOCnP9D+hdDxHd6OQJKdDNGSka4YV6183dqxPBb9T7majEiEqv/hP87MUjrHOHRgIkGiUOq/Gd1flhkoiHSJvCmW+EdwGtyRUIWXEt4sumQsqFvnThFBFfN/HBEC2Y69UnaN6VLDawwbqiwL2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060de223-848e-4574-b29a-08d88b91db03
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 07:16:23.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ca7pam1KbFDTzArwWKBMR9I7fAFcQaV3C8iyZ1YoL+ztVnJRdKgUe92IwaFNWMl7k0we1EkbyoC1Kh4rF5MNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4850
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/18 16:07, Christoph Hellwig wrote:=0A=
> Adding Damien who wrote this code.=0A=
=0A=
Nope. It wasn't me. I think it was Stephen Bates:=0A=
=0A=
commit 720b8ccc4500 ("blk-mq: Add a polling specific stats function")=0A=
=0A=
So +Stephen.=0A=
=0A=
=0A=
> =0A=
> On Wed, Nov 18, 2020 at 09:47:46AM +0900, Dongjoo Seo wrote:=0A=
>> Current sleep time for hybrid polling is half of mean time.=0A=
>> The 'half' sleep time is good for minimizing the cpu utilization.=0A=
>> But, the problem is that its cpu utilization is still high.=0A=
>> this patch can help to minimize the cpu utilization side.=0A=
>>=0A=
>> Below 1,2 is my test hardware sets.=0A=
>>=0A=
>> 1. Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz + Samsung 970 pro 1Tb=0A=
>> 2. Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz + INTEL SSDPED1D480GA 480G=
=0A=
>>=0A=
>>         |  Classic Polling | Hybrid Polling  | this Patch=0A=
>> -----------------------------------------------------------------=0A=
>>         cpu util | IOPS(k) | cpu util | IOPS | cpu util | IOPS  |=0A=
>> -----------------------------------------------------------------=0A=
>> 1.       99.96   |   491   |  56.98   | 467  | 35.98    | 442   |=0A=
>> -----------------------------------------------------------------=0A=
>> 2.       99.94   |   582   |  56.3    | 582  | 35.28    | 582   |=0A=
>>=0A=
>> cpu util means that sum of sys and user util.=0A=
>>=0A=
>> I used 4k rand read for this test.=0A=
>> because that case is worst case of I/O performance side.=0A=
>> below one is my fio setup.=0A=
>>=0A=
>> name=3DpollTest=0A=
>> ioengine=3Dpvsync2=0A=
>> hipri=0A=
>> direct=3D1=0A=
>> size=3D100%=0A=
>> randrepeat=3D0=0A=
>> time_based=0A=
>> ramp_time=3D0=0A=
>> norandommap=0A=
>> refill_buffers=0A=
>> log_avg_msec=3D1000=0A=
>> log_max_value=3D1=0A=
>> group_reporting=0A=
>> filename=3D/dev/nvme0n1=0A=
>> [rd_rnd_qd_1_4k_1w]=0A=
>> bs=3D4k=0A=
>> iodepth=3D32=0A=
>> numjobs=3D[num of cpus]=0A=
>> rw=3Drandread=0A=
>> runtime=3D60=0A=
>> write_bw_log=3Dbw_rd_rnd_qd_1_4k_1w=0A=
>> write_iops_log=3Diops_rd_rnd_qd_1_4k_1w=0A=
>> write_lat_log=3Dlat_rd_rnd_qd_1_4k_1w=0A=
>>=0A=
>> Thanks=0A=
>>=0A=
>> Signed-off-by: Dongjoo Seo <commisori28@gmail.com>=0A=
>> ---=0A=
>>  block/blk-mq.c | 3 +--=0A=
>>  1 file changed, 1 insertion(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
>> index 1b25ec2fe9be..c3d578416899 100644=0A=
>> --- a/block/blk-mq.c=0A=
>> +++ b/block/blk-mq.c=0A=
>> @@ -3749,8 +3749,7 @@ static unsigned long blk_mq_poll_nsecs(struct requ=
est_queue *q,=0A=
>>  		return ret;=0A=
>>  =0A=
>>  	if (q->poll_stat[bucket].nr_samples)=0A=
>> -		ret =3D (q->poll_stat[bucket].mean + 1) / 2;=0A=
>> -=0A=
>> +		ret =3D (q->poll_stat[bucket].mean + 1) * 3 / 4;=0A=
>>  	return ret;=0A=
>>  }=0A=
>>  =0A=
>> -- =0A=
>> 2.17.1=0A=
>>=0A=
> ---end quoted text---=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
