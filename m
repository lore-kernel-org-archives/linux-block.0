Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA0C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 02:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AD32146E
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 02:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G1iQM99U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bOdqlGLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfBUCVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:21:07 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27628 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBUCVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 21:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550715667; x=1582251667;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2S073oupYqHEF9kVioWFyOQaaBmjUBdPgTnV2T/puKw=;
  b=G1iQM99UGS+ru0h7IQwFRB8MJLnBjVLJH4a/i9H7/jXQlOUTaYkeGnwM
   gQDKK/vJffNjkAI+Em52UO97AXd4LTxtDyr+fnAV7AcnAJwbanGpAvgsG
   ndyd2ESWi+Zl5xJX6SNb4QKw/l1+DZCXOqVYfT0fNouG0Jzjpo2GBDwpm
   oUmFhJtCEGOF2OnPPjeSdVktkBVO9lXwMbHMW0qSrmuq5Awn7gos4w8RI
   9wCeSLMczD4Pp3IPxYo14cq0S4UWvYwPbJlN4Xmnc2iL0ytLux32/YlD8
   QbnvHV88JzjEGL+IHgMXcu0ab+ZsQg2oJdXpGNtej570GU2fsvxwSn/EE
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="103077230"
Received: from mail-bn3nam01lp2052.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.52])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 10:21:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s9vCcGuYHgSqf3UpvehfEmx456+yKGefLb0XnxeNeI=;
 b=bOdqlGLceQG2xryocjWa+wAVv4OAPRWAGq9CDoJXC15efK9wKWSpByiEWPK5kmN26cVOBpqxLDRRhrq7xxwNTFf5Mc6v5AAfSLGzW7w+232ZCW01UI3wDoAPwwh0W+1f/Oq4DkNtUXzZgqZIAA+iGZZrOrOaDfoIGMY8EmRbAoc=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4254.namprd04.prod.outlook.com (52.135.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 02:21:02 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 02:21:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Topic: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Index: AQHUyMoAEYk0t39XfkCklw1XmMrTmA==
Date:   Thu, 21 Feb 2019 02:21:02 +0000
Message-ID: <SN6PR04MB4527C5175E583F989545226B867E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190220031122.GA17298@ming.t460p>
 <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <CACVXFVMkxPJsAKkJ0uopFPCpFiZDxA2qH11Yt8AsuKHEmVqGxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d371ace0-f91e-46cc-d1d6-08d697a33a13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4254;
x-ms-traffictypediagnostic: SN6PR04MB4254:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB4254;23:fI5WP/h+6Qp5XlbH4eiwZsZfh5j6tHyPmsLuW3eq7?=
 =?us-ascii?Q?v466AHId6if4xCPRh5h2B88l8087CSFC1pwyiDLKrAvd51FN3XartV6IWgqy?=
 =?us-ascii?Q?LNtME7Ghs1N9f3R9wSh5RqtUiNngtkXKA2BSVvQA7ju0ZCtBZmmVAZ02THE4?=
 =?us-ascii?Q?v3supWNQRZf2eFwj7+An1aOyrrxDOmBc77LfXgQJxUikyezXNy6BnNdX6c6l?=
 =?us-ascii?Q?6Xbg73l07mAeY1VHbwhzDSjUL17R8xdnOn/xdMtpIv1Qpv1duYeyxlFtNSkB?=
 =?us-ascii?Q?BE1ygSQv3cPW2g6TNfMOldHn0u/TlouTWw/cyeIglUZVUM6hyDuc7h7QOl9U?=
 =?us-ascii?Q?9Qo6fEyRJlLaSA5rclYRl7hl42lfINSBxWrnYS7dafNDRLkJof/zVglAVPZZ?=
 =?us-ascii?Q?3PpyLi42U+mdgbhPe2x6tzD8neGw4gaxKMV0slyegUxUq+F19b7tnpSb4lzW?=
 =?us-ascii?Q?y26ywXYaXAg8AsSSSqE6DI7wwv6HqHusMPyO6xaDtzwMz7aNbgIRcny5O28q?=
 =?us-ascii?Q?xW1L0ZH/j3xxn5INCi7XkX3yiAX6UlR65QVcVXs/SxtvKHfnU+A4k7qqPqpa?=
 =?us-ascii?Q?MXtER+R0X1UwUJXSH+3I9dicMNMAYiwLgk6x7nwzCiM6+uMUu+/dBeG171WS?=
 =?us-ascii?Q?JzISk0b9PnpADx6KfmxVBBuWlGcTQGcZQdVlewofhCWPiuMqhsivM2wUcJ+I?=
 =?us-ascii?Q?PSpII7t4E3YhdF/jYIgq+t8VFK+FJ4uN9Op8uMVGaGedN0G5Yo2ii4OM2WDg?=
 =?us-ascii?Q?iymSP9v4DI2dYHJP0L7eVP6o4GwADr43lJPed1i1u9Z5UuOIFuU+Ebk9nGRv?=
 =?us-ascii?Q?mR7G/lMTuXfVrG83ZJ8V7Lr/gNiBBB4GRKcUgLY05YXd8CeX+V+Y8gJ5oCPV?=
 =?us-ascii?Q?b//1FKQ/g11wlLX/xEZK9BxxQfHDDQL/8JWYrfD6JuQDemv5iq10Ol0v+adl?=
 =?us-ascii?Q?/WDKmW2J5CDzaqk4cXjf7FIk+2C0ZaJCPtsiM33g51P6HgbXHPsMEDbOTjEb?=
 =?us-ascii?Q?USvrwUXgBq5zOIAH33WiEdDpxrlFubhcf2DwaOnGMCF8Ky0iox2KRVBg/O+1?=
 =?us-ascii?Q?mLJonnQovjiJwN2FTb8KwpwPqMoPU55rqwoemc3iqcGO2uuG5HbEEdFdw/d6?=
 =?us-ascii?Q?Eq4enpWv7HeNaKGZWjz5OQKryE+Y66El/U7RK9EKoxEj/3bLvMWvSOP0ONm+?=
 =?us-ascii?Q?o93fgXzKVhW2AQ/Om/2V1Q3lB5ECnBF0qk5hr4rCX+ny6o2isfPrNcg2tgTJ?=
 =?us-ascii?Q?V5ojiBBy+Fag1oyfrWWnuPrIsrf9ZUabsXrnpgl?=
x-microsoft-antispam-prvs: <SN6PR04MB4254860EB4BC983F2CEF78C6867E0@SN6PR04MB4254.namprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(2906002)(9686003)(68736007)(3846002)(99286004)(6116002)(53546011)(86362001)(6506007)(476003)(6346003)(102836004)(53936002)(76176011)(486006)(446003)(305945005)(72206003)(7696005)(6916009)(316002)(26005)(186003)(478600001)(33656002)(14454004)(74316002)(6436002)(106356001)(14444005)(256004)(105586002)(71190400001)(97736004)(6246003)(7736002)(55016002)(5660300002)(229853002)(81156014)(8676002)(71200400001)(93886005)(25786009)(8936002)(81166006)(66066001)(54906003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4254;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QY4srUmyG0jWwbGPTMZat/fLNA+ditTLx8xGICNJs3fU3CTaH8UUwhCtBUtkA7I4LZrcHPar7b8S0SrzP4TCQykSFjm2VU9yYwtfC0BZu8F5zzOgVTXBHVKES0ilt2ykXVK9eg/upFVuOpO6FaP8Gd6BZ911Zl1pRGLA9pko+qNM3KfTwGsjhiPp9B2kcC2HyjD1v2aBfbXv59mCKoAUBDWgIugqEpqU84Owqk44962wJyOYLd39IwKQ6DJEtQ7Gedl7SENdJfwPk3i2netXtlSziHflPARFivWeOr8fphoRk0rC8jsQylfuFJaj8VATUi1hYBt9lvKS8EwlAsaAx211ONN5rYdUSVkaiLram0mTi5rWv12AS5ChVTRdNE5EiBOewTJNMjF4gXUYS6PYtwHgO34sAQoWCoeyMriN1n8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d371ace0-f91e-46cc-d1d6-08d697a33a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 02:21:02.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4254
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/20/2019 06:16 PM, Ming Lei wrote:=0A=
> On Thu, Feb 21, 2019 at 2:16 AM Chaitanya Kulkarni=0A=
> <Chaitanya.Kulkarni@wdc.com> wrote:=0A=
>>=0A=
>> On 02/20/2019 06:17 AM, Christoph Hellwig wrote:=0A=
>>> We shouldn't be allocating a scatterlist for a command that doesn't=0A=
>>> have a payload.=0A=
>>>=0A=
>>> The blk_rq_payload_bytes check in nvme_rdma_map_data is supposed to=0A=
>>> prevent that.=0A=
>>>=0A=
>>> Chaitanya, can you try to debug why this is not working?  I'm on=0A=
>>> vacation and don't have much time right now unfortunately.=0A=
>>>=0A=
>>=0A=
>>=0A=
>> Hi Ming,=0A=
>>=0A=
>> Can you please test following patch on your system ?=0A=
>=0A=
> With this patch, the test can pass.=0A=
>=0A=
> [root@ktest-04 blktests]# ./check nvmeof-mp/002=0A=
> nvmeof-mp/002 (File I/O on top of multipath concurrently with logout=0A=
> and login (mq)) [passed]=0A=
>      runtime  75.478s  ...  54.317s=0A=
>=0A=
>>=0A=
>>=0A=
>>=0A=
>>   From 79e178a53a9f101d1f5f6a4923298bb1ffe936ef Mon Sep 17 00:00:00 2001=
=0A=
>> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> Date: Wed, 20 Feb 2019 09:16:58 -0800=0A=
>> Subject: [PATCH] nvme-rdma: use nr_phys_segments when map rq to sgl=0A=
>>=0A=
>> Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to check=
=0A=
>> if a command contains data to be mapped.  This fixes the case where=0A=
>> a struct request contains LBAs, but it has no payload, such as=0A=
>> Write Zeroes support.=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>    drivers/nvme/host/rdma.c | 4 ++--=0A=
>>    1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c=0A=
>> index ac365366c2ec..c6a489049fd5 100644=0A=
>> --- a/drivers/nvme/host/rdma.c=0A=
>> +++ b/drivers/nvme/host/rdma.c=0A=
>> @@ -1150,7 +1150,7 @@ static void nvme_rdma_unmap_data(struct=0A=
>> nvme_rdma_queue *queue,=0A=
>>          struct nvme_rdma_device *dev =3D queue->device;=0A=
>>          struct ib_device *ibdev =3D dev->dev;=0A=
>>=0A=
>> -       if (!blk_rq_payload_bytes(rq))=0A=
>> +       if (!blk_rq_nr_phys_segments(rq))=0A=
>>                  return;=0A=
>>=0A=
>>          if (req->mr) {=0A=
>> @@ -1273,7 +1273,7 @@ static int nvme_rdma_map_data(struct=0A=
>> nvme_rdma_queue *queue,=0A=
>>=0A=
>>          c->common.flags |=3D NVME_CMD_SGL_METABUF;=0A=
>>=0A=
>> -       if (!blk_rq_payload_bytes(rq))=0A=
>> +       if (!blk_rq_nr_phys_segments(rq))=0A=
>>                  return nvme_rdma_set_sg_null(c);=0A=
>>=0A=
>>          req->sg_table.sgl =3D req->first_sgl;=0A=
>> --=0A=
>> 2.17.0=0A=
>>=0A=
>>=0A=
>> Also can you please share all the QEMU config/setup information that=0A=
>> you have used to run the tests ? I want to add this test to the blktests=
=0A=
>> with QEMU platform.=0A=
>=0A=
> Just enable the required kernel config options and install=0A=
> device-mapper-multipath,=0A=
> then run './check nvmeof-mp/002', it will be started.=0A=
>=0A=
> Thanks,=0A=
> Ming Lei=0A=
>=0A=
=0A=
Thanks Ming for testing, I'll send an official patch to the mailing list.=
=0A=
=0A=
