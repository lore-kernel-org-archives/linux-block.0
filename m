Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0EFC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518C62064A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NutgVEZI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yS2iVI8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF1Haw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:30:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23481 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1Haw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 03:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561707052; x=1593243052;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WRQVLAOiX7elU34X49oG12nEIKoHyNngyxp5Errp4E4=;
  b=NutgVEZI12deuSSwcbcULqUH1miBxO8lTc6pgrPFVrbJy1Z7KhZHhufH
   h3POJE91BXd6iblhlzP42uuWVmVdljuXqGlXZzdPHq1MVUO5P1h31MpTm
   e092h50le9v8R984/OLp8S/qj+rHrII1qUFP1YlUwQ6/EBrGfMXL5dtYV
   HUxx/ISVozZMKLKhuYKvOCKvZoC8jzq3/BEf4BHosie/NSpeXErNTS+2Q
   I7AZkqFOfGnOnUy0AJHkPJaiuNpLOifJdKUQ33VK0H4sWlI+dMSocgcQg
   eD26fOPtEesuErujiNc3VFj9anbt96yut5idoJMyTLH6fLYbvVAMTGhhY
   w==;
X-IronPort-AV: E=Sophos;i="5.63,426,1557158400"; 
   d="scan'208";a="112971250"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 15:30:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XTM+IajLvR8XWir+1H2be8ZtrMqhASfu1xf2vFVjHI=;
 b=yS2iVI8ES6wrvkHjdmvyfYAN4iprviJfrvdF/WpLjSb3nZUZcOM7rQpTtiKltYHCF5CRsD6wD7xNnqkUz2TL883WNgKdmtdLfaINPf4p4bo+VRmyl505bZIVfnwNePGO0M0/2xgs4E/YIPQOTigKhNSwTjMVby46iNNJmLO5P8A=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3893.namprd04.prod.outlook.com (52.135.214.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Fri, 28 Jun 2019 07:30:49 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 07:30:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Thread-Topic: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Thread-Index: AQHVLMrihbEnR+8IoE+An7DqTf8gCA==
Date:   Fri, 28 Jun 2019 07:30:49 +0000
Message-ID: <BYAPR04MB581641F8E665ECD324B6C397E7FC0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190627092944.20957-1-damien.lemoal@wdc.com>
 <20190627092944.20957-3-damien.lemoal@wdc.com> <20190627140900.GB6209@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8e7d498-3016-452c-227e-08d6fb9a8b0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3893;
x-ms-traffictypediagnostic: BYAPR04MB3893:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3893D4DC358B386A404EC442E7FC0@BYAPR04MB3893.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(55016002)(53936002)(5660300002)(7696005)(316002)(256004)(9686003)(54906003)(6246003)(14444005)(33656002)(478600001)(2906002)(186003)(76176011)(53546011)(6506007)(102836004)(26005)(52536014)(86362001)(3846002)(74316002)(25786009)(81156014)(99286004)(7736002)(72206003)(476003)(6116002)(71190400001)(6916009)(71200400001)(4326008)(305945005)(66946007)(66556008)(73956011)(64756008)(66476007)(486006)(66066001)(76116006)(91956017)(229853002)(68736007)(6436002)(14454004)(8936002)(66446008)(81166006)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3893;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O4eBZ/dCVa14bZ7w4jjHXrA7zhTg9s4KybPGb9GsTWuCuSq9OrgKODt7gZZ/uCb5ZCun1QExIjWOIqfIDqs8SzQI2O4mF/LRLSkYdjFSwlrwwIcCKTWpzNaP5KzcRs66k7p6jdoh4Hgm0NL1qbfggpoYTRedB5paBgWfG2ul8OmgihLSco6TXP880tqb/PM7eHtbvuJ0YK9WH6qkBWsTOqQoph/Z1gYRM9b8/KEG3Dx4qMZNvfmet/X4M+gS4NVcx5Oyg67JztoUVDRphVBvuxngU4W/EGo2XilW3r0YNIx9SEzV1unbqgqMZhkbgeP4zwC8kl3pXNr+s3eiKrZT6EXPmmBlPdx086bM/hkchLr4kxbz0swjTPr4JC058FRIxEBisA75f2NpfERTzCmQL6mIds4mMMyHYNYGssQYqdM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e7d498-3016-452c-227e-08d6fb9a8b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 07:30:49.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3893
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/19 11:09 PM, Christoph Hellwig wrote:=0A=
>> @@ -79,6 +80,7 @@ static int sd_zbc_do_report_zones(struct scsi_disk *sd=
kp, unsigned char *buf,=0A=
>>  	put_unaligned_be32(buflen, &cmd[10]);=0A=
>>  	if (partial)=0A=
>>  		cmd[14] =3D ZBC_REPORT_ZONE_PARTIAL;=0A=
>> +=0A=
>>  	memset(buf, 0, buflen);=0A=
>>  =0A=
>>  	result =3D scsi_execute_req(sdp, cmd, DMA_FROM_DEVICE,=0A=
> =0A=
> Spurious whitespace change.=0A=
=0A=
Fixed.=0A=
=0A=
>> +static void *sd_zbc_alloc_report_buffer(struct request_queue *q,=0A=
>> +					unsigned int nr_zones, size_t *buflen,=0A=
>> +					gfp_t gfp_mask)=0A=
>> +{=0A=
>> +	size_t bufsize;=0A=
>> +	void *buf;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Report zone buffer size should be at most 64B times the number of=
=0A=
>> +	 * zones requested plus the 64B reply header, but should be at least=
=0A=
>> +	 * SECTOR_SIZE for ATA devices.=0A=
>> +	 * Make sure that this size does not exceed the hardware capabilities.=
=0A=
>> +	 * Furthermore, since the report zone command cannot be split, make=0A=
>> +	 * sure that the allocated buffer can always be mapped by limiting the=
=0A=
>> +	 * number of pages allocated to the HBA max segments limit.=0A=
>> +	 */=0A=
>> +	nr_zones =3D min(nr_zones, SD_ZBC_REPORT_MAX_ZONES);=0A=
>> +	bufsize =3D roundup((nr_zones + 1) * 64, 512);=0A=
>> +	bufsize =3D min_t(size_t, bufsize,=0A=
>> +			queue_max_hw_sectors(q) << SECTOR_SHIFT);=0A=
>> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT=
);=0A=
>> +=0A=
>> +	buf =3D __vmalloc(bufsize, gfp_mask, PAGE_KERNEL);=0A=
> =0A=
> __vmalloc is odd in that it takes a gfp parameter, but can't actually=0A=
> use it for the page table allocations.  So you'll need to do=0A=
> memalloc_noio_save here, or even better do that in the block layer and=0A=
> remove the gfp_t parameter from ->report_zones.=0A=
=0A=
Yes, indeed. However, removing the gfp_flags from report_zones method=0A=
would limit possibilities to only GFP_NOIO or GFP_KERNEL (default=0A=
vmalloc). What if the caller is an FS and needs GFP_NOFS, or any other=0A=
reclaim flags ? Handling all possibilities does not seem reasonable.=0A=
Handling only GFP_KERNEL and GFP_IO is easy, but that would mean that=0A=
the caller of blkdev_report_zones would need to do itself calls to=0A=
whatever  memalloc_noXX_save/restore() it needs. Is that OK ?=0A=
=0A=
Currently, blkdev_report_zones() uses only either GFP_KERNEL (general=0A=
case, fs, dm and user ioctl), or GFP_NOIO for revalidate, disk scan and=0A=
dm-zoned error path. So removing the flag from the report zones method=0A=
while keeping it in the block layer API to distinguished these cases is=0A=
simple, but I am not sure if that will not pause problems for some=0A=
users. Thoughts ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
