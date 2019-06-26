Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60132C4646B
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A262085A
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VLPUpEOK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YdNELCz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfFZGRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:17:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9452 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZGRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 02:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561529872; x=1593065872;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=naUJk5XA3JowXWrBwDpFaT/wq3ZdjuqGOdSXsP22q4s=;
  b=VLPUpEOKc56SjggAmJ7MyekErLWifbYZ/SpPOL5aJwWvcPZXEl58xTrL
   TrvpufqKydD7QFokZKq8BMrIGl3fo4LyhR2BjiuCw6ZOCpc3ZsUH+TKj9
   UC2MvWyrh/RXD86joy4MVhBBS5eYDQEKTvn7IS5FvweLIdwCk0XKTrO2T
   51ceZ6F5BEOs4IVmNJo/7RwxEzaUPeHBl1trZMJ1xrp85keUoIa401GdV
   4n743XKlLJ7HTyh3zwE/vBy/tvZM2bP9CVO8RPnAPnAkclpeki8zVVEK6
   1Twev6ja5Q/MdiNlM3JtYc/i0BD+hTGvCdR+/rPDJks/P2Vcf5F7hKfPE
   g==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="111557366"
Received: from mail-co1nam03lp2056.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.56])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 14:17:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax5QhA+lwtYyngQgclcf0Pz+NuNvJeAME/IE87YkNt8=;
 b=YdNELCz87lUskQfgyGpg/KF/jKr2nIYqQd2VuEvxbmBwDDu13fiCkpv/ddr+In6VQPWs76cvnIl5o9L3eOyVhTyu+yvQG65FnDG0PE6MmTuC580BGTVw+C4zIvZujmMWtakOpumu88sB5RkKQqCE/zkUz7/i7HscFSESnUripFU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4310.namprd04.prod.outlook.com (20.176.251.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Wed, 26 Jun 2019 06:17:49 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 06:17:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH V2 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVK8E2nVt+VM27mEeEHwsQ1inD/w==
Date:   Wed, 26 Jun 2019 06:17:49 +0000
Message-ID: <BYAPR04MB5816472C4547AF67B304CFE2E7E20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190626014759.15285-1-damien.lemoal@wdc.com>
 <20190626014759.15285-2-damien.lemoal@wdc.com>
 <20190626061016.GA23902@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c49c5cf8-91b3-4ff7-a002-08d6f9fe03ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4310;
x-ms-traffictypediagnostic: BYAPR04MB4310:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB431065675F6412C296956B0BE7E20@BYAPR04MB4310.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(66946007)(73956011)(66446008)(53936002)(91956017)(3846002)(76116006)(66556008)(229853002)(8936002)(7736002)(64756008)(52536014)(66066001)(4326008)(186003)(66476007)(86362001)(476003)(54906003)(68736007)(8676002)(486006)(6436002)(305945005)(316002)(2906002)(26005)(74316002)(25786009)(53546011)(6916009)(71200400001)(256004)(71190400001)(102836004)(33656002)(9686003)(14454004)(81166006)(5660300002)(81156014)(446003)(7696005)(6506007)(99286004)(55016002)(6116002)(6246003)(14444005)(76176011)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4310;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RoMqLDKqNxxtLbaHY/XAE55z4gjbiskvz5QYKMYwBMiSdLLwFb7NyTxM7o1tSI+KgGosQqW6BmHQ1qmlf9KVL50QQLz3hDs+cJq25Cw2Grq2Yhh7vmjL4O2s6MuTVrvv0JE4U0imDtOVrFdh+SiZB9VlAQDVj8Q4RZVBNqv7lUe0d+18P5ZMK/Y2+jeJUTWFZvnuV7UBzFf+T81fPtDN5PUmJzu+oVAAXywRDfkugb9HLVRnxosHCmUWAjW7cm8vRhk6fBNpnwJeh2X6WK68UqkcT51MBH2bCDxDsNUdPHUKE6nhxAofd4ViIRJL09g8t3EUraf/ZfgZzMJ3c56EFc4p79etUaS+aO8pz6LlSDRz/MhLN/LxHNxdFGOpPK9ZBphCS9UOAwWnnO7CcH+DIbp1qEiZbZFeamTuzPcsctc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49c5cf8-91b3-4ff7-a002-08d6f9fe03ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 06:17:49.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4310
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph,=0A=
=0A=
On 2019/06/26 15:10, Christoph Hellwig wrote:=0A=
> On Wed, Jun 26, 2019 at 10:47:57AM +0900, Damien Le Moal wrote:=0A=
>> @@ -1501,9 +1502,14 @@ struct bio *bio_map_kern(struct request_queue *q,=
 void *data, unsigned int len,=0A=
>>  	unsigned long end =3D (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;=0A=
>>  	unsigned long start =3D kaddr >> PAGE_SHIFT;=0A=
>>  	const int nr_pages =3D end - start;=0A=
>> +	bool is_vmalloc =3D is_vmalloc_addr(data);=0A=
>> +	struct page *page;=0A=
>>  	int offset, i;=0A=
>>  	struct bio *bio;=0A=
>>  =0A=
>> +	if (is_vmalloc)=0A=
>> +		invalidate_kernel_vmap_range(data, len);=0A=
> =0A=
> That is not correct.=0A=
> =0A=
> The submission path needs an unconditional flush_kernel_vmap_range call,=
=0A=
> and the read completion path will additionally need the=0A=
> invalidate_kernel_vmap_range call.=0A=
> =0A=
=0A=
I mimicked what XFS and DM do with vmalloc-ed buffers. I guess I missed som=
ething.=0A=
=0A=
So in this case, the allocation is in sd_zbc.c, where the completion is too=
. So=0A=
I think it may be better to have flush_kernel_vmap_range() right after the=
=0A=
allocation before scsi_execute_req() is called and do the=0A=
invalidate_kernel_vmap_range() before scanning the report zones output for=
=0A=
transformation into struct blk_zone ? And do not do anything in bio_map_ker=
n=0A=
beside the change from virt_to_page() to vmalloc_to_page() ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
