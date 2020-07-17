Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C4C433E6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 02:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB68420578
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 02:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J2148SCZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D/aCJKi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGQCpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:45:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19163 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgGQCpp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 22:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594953944; x=1626489944;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BaxIO+MHxWDV9DSUHoeWM4o8U0Ahts/DHGokzItjrog=;
  b=J2148SCZUp7IfmrPqWG5pYOW3zC/t9CRd1FDyrYg4vQCCvGrTnQHNzOA
   p25Dy47Dhz7YB6txUH/+Nh48XkxvArEhxgkccwRoWdJ9U5EDbPY8GTd1I
   3JQN4ozykX6PZtu/INNm1NVsMaEXY3XYQHZ8evHmbcSV9NCCj6xriGTqN
   PszUemb4puKc7smHk2EUY/35PBF1ChXAsl8ekFtTUaHPnzwLo23vnEMfg
   YYmSr4GUBi7tua5CvxgzDX/ggp6ieWY6b6n7/cXPT1JbqbY28mHocqjsy
   RxgkdP/bwkAPdQ2ny3bc0KqLgLsHQKNxjQ2UX3A6bppOPVgYp5kv8oxQ7
   Q==;
IronPort-SDR: SN4ibL/l1o3Lad5qfEUqjLQtUBqHdhzs2MOfB8oKer6d+Dw6FndGmoSwoOuGMHrgVuZbQY8Aqi
 nvxj/ZhZz1+7rjoSn5SUG1XGa3yHHUWykxQwl9AOfej3RowF0jXDuVsr0xZAw7KKmFP+lO24LZ
 NoUNE1Bzgxfjm1AXHLyKx0kDdo1O0gV4ddosOnuthI3bP5XY81zS458qWlZhNp6ek44b4/+uzR
 R8PGVOfcQAGQxceUlo6U7/4pGf9f1jWwgd4i0XT7vHJK0r6QXYFTNr8MYaGDNFHRh/x+5im902
 Aro=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; 
   d="scan'208";a="251936564"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 10:45:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n17azmljL+KfVWqtQLhwxSSMg5tS/RdLSgqWqkKEGue7tcUe0b1aT+KamulfQ1nv0p5AWb2yXmKXEKMNiFS5RAkbkN/SogH/jkDzoM29SEp8d8m7+ekAJ0bGP6I036mjAJ783Sfa/gGOugeOJuzuOqann0jfW2i/nTcrH6bNg7CA7vk++t0LVAOIESkk9WDbWvm2DP6+Df7C+4o+LuAfOW0wHc0Yrr+25sb5Ivm7JrOXhjVIS7nJtlqlxG4eUTSjtvY0IH5Nn4ZqaP5Nx4gP9BY7gNKdSlLWdB1TJPbP21G+4wq5ngom2ZUL2UjBs9+1Yi8qoiVToE59qHknaswuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKj+2nyrR6NdoAkdH84uFf3Uvm3joFQPVsQHnAV6o2Y=;
 b=FZ9zJdsehT/Sn1Xk39f5PSa5A0uOVtbEhIhAZ4VNNJaeaohJbh0F9JRHrVMFfgWBXnOuSQ1y1zHEyNgu9l9Afcn20xP/iiH+0JGcTJb5kfpEqQs/K86SwL7EdPuMrLQpzQBAO6TsbKcLXRoSVbum/T3GIHBFqxdKK4EbubKqot4bCSbbfY0JFbZgmXYFcxAjMJmLjNITAmBqPwM9+eyJBBgkgB2/1nMPpIY0uNJ/xM+17x8jgOL+civQk9Mt97I2IRPwmex1mo3ZC6ZHh70d4JsD7uQKmLF7ivpj+LZZrA6k6RBzjiu3COu9PgjE9xtnHuxseigcPNi74AvJfYn9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKj+2nyrR6NdoAkdH84uFf3Uvm3joFQPVsQHnAV6o2Y=;
 b=D/aCJKi1fs5jWPcl+2Cs1DEkARWBiMd/ORLvFfNtR0Yl3I1CZk7QrQXBv4XNemtAyUrAnrIU6SLhIt2pIhAIANs9dp0WXdfk/Xy+YumzjLh57xS7sypbeCLtu06tthML59Vgr8P4XWlliOa8XssIWFoDWWFCgv24jHhXPNH/1Pk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0342.namprd04.prod.outlook.com (2603:10b6:903:3f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 02:45:26 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3174.022; Fri, 17 Jul 2020
 02:45:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Thread-Topic: [PATCH] block: align max append sectors to physical block size
Thread-Index: AQHWW1k90KwUXjQMWE23AxcUX8lDNA==
Date:   Fri, 17 Jul 2020 02:45:25 +0000
Message-ID: <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74c482c5-27a3-470f-30c6-08d829fb75a0
x-ms-traffictypediagnostic: CY4PR04MB0342:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0342DEFE2B64CAC93BCCBAFBE77C0@CY4PR04MB0342.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBFxyiclKK/kTL9pKpkExmar/yp8gqAHQ+28U7QmuskZdUXT/vEy2YheMMFo35RpnJY3yPwmlcbVBbw8qTQHlzeElCmRQA/9Ns4X0bzkeDUmqMt1v14Zclzbbw+AR3HjUsScUAQcEQ+sHZWdmejU2IkiVTMqwijcFcqAztWhWacOQWmfo4ibtxOEQ6xxyHGHzzLXva09fn05fVy6czfai0uBJTBKJyY9uZ7J3UqfzVj0LmtZ+eygp+5PP/5f7Rjx/3J71M2+hORcJjtaHEI4/2Xy97XvytN+mH11GxCjolbz9ggtNcYbZSWTERtkrUlPvsUBBZErCvz4Ds5nuSD0Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(186003)(7696005)(4326008)(83380400001)(110136005)(9686003)(76116006)(6636002)(478600001)(26005)(54906003)(86362001)(52536014)(316002)(91956017)(66556008)(8676002)(2906002)(55016002)(6506007)(5660300002)(66446008)(33656002)(8936002)(64756008)(66476007)(66946007)(71200400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: og+s/5mPnuXwHw2ewVseQguSr07vFn8QlGdwKfpLRyeLVyhKk/GSuXPooRXJRe24Ak0d7DvTzJYnnUfbafcX2iIiKqm7Ajwus7o0+NYV604Vg0x8oAKyebJXj/p3SbN8xeQx2hc/qcJz1IBdAD7ceiRloXBRWO5cBEhByUeFGJ7Wn2U2gWviE9G79sLnvrGOlGi+OTe8aCSs0xjN56DFOOg89rVef4rHy1wObHHQf3i8z3LtTmkPiF1aXGCBBzBWj3y04XCZvq5Du8zWVzCau5kqRB0vGK9c6uz8D3VZw51UcAhqr52PFdoQtBOuLXzW76v0E6MaX38m53GnteHF314oGDCKEK0OB2qPk46YsEhBFhy/qRLfBtzcjl3V9ytx3bce22ZGLnmfuFAgQCFmD7sUOgZPZN3qQc3WUvy58u97yL/xGOKLDOXQz1riu4Sh0p+VbHECR/CbkMf/bxa4nSGojaK+rfvAuCPmjlMFszb31ZHmDggz/1LGN7wR1zRa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c482c5-27a3-470f-30c6-08d829fb75a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 02:45:25.8168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUA/vpMVVQY+rNfAE16irQD6R2RfrcAGKJQa0rM7e6uUK/o0tjCESrz7RWwhIlTFOBJyT2TxUZGpSpAfY7KiQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0342
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/16 23:35, Christoph Hellwig wrote:=0A=
> On Thu, Jul 16, 2020 at 07:09:33PM +0900, Johannes Thumshirn wrote:=0A=
>> Max append sectors needs to be aligned to physical block size, otherwise=
=0A=
>> we can end up in a situation where it's off by 1-3 sectors which would=
=0A=
>> cause short writes with asynchronous zone append submissions from an FS.=
=0A=
> =0A=
> Huh? The physical block size is purely a hint.=0A=
=0A=
For ZBC/ZAC SMR drives, all writes must be aligned to the physical sector s=
ize.=0A=
However, sd/sd_zbc does not change max_hw_sectors_kb to ensure alignment to=
 4K=0A=
on 512e disks. There is also nullblk which uses the default max_hw_sectors_=
kb to=0A=
255 x 512B sectors, which is not 4K aligned if the nullb device is created =
with=0A=
4K block size.=0A=
=0A=
So we can fix each driver separately to ensure that we end up with a sensib=
le=0A=
max_hw_sectors_kb and by extension a sensible value for max_zone_append_sec=
tors,=0A=
or we could force this alignment in blk_queue_max_hw_sectors().=0A=
=0A=
Right now, without any fix, there are setups that end up having weird value=
s=0A=
that the user have to sort through and may have a hard time making sense of=
.=0A=
=0A=
> =0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  block/blk-settings.c | 8 ++++++++=0A=
>>  1 file changed, 8 insertions(+)=0A=
>>=0A=
>> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
>> index 9a2c23cd9700..d75c4cc34a7a 100644=0A=
>> --- a/block/blk-settings.c=0A=
>> +++ b/block/blk-settings.c=0A=
>> @@ -231,6 +231,7 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);=
=0A=
>>  void blk_queue_max_zone_append_sectors(struct request_queue *q,=0A=
>>  		unsigned int max_zone_append_sectors)=0A=
>>  {=0A=
>> +	unsigned int phys =3D queue_physical_block_size(q);=0A=
>>  	unsigned int max_sectors;=0A=
>>  =0A=
>>  	if (WARN_ON(!blk_queue_is_zoned(q)))=0A=
>> @@ -246,6 +247,13 @@ void blk_queue_max_zone_append_sectors(struct reque=
st_queue *q,=0A=
>>  	 */=0A=
>>  	WARN_ON(!max_sectors);=0A=
>>  =0A=
>> +	/*=0A=
>> +	 * Max append sectors needs to be aligned to physical block size,=0A=
>> +	 * otherwise we can end up in a situation where it's off by 1-3 sector=
s=0A=
>> +	 * which would cause short writes with asynchronous zone append=0A=
>> +	 * submissions from an FS.=0A=
>> +	 */=0A=
>> +	max_sectors =3D ALIGN_DOWN(max_sectors << 9, phys) >> 9;=0A=
>>  	q->limits.max_zone_append_sectors =3D max_sectors;=0A=
>>  }=0A=
>>  EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);=0A=
>> -- =0A=
>> 2.26.2=0A=
>>=0A=
> ---end quoted text---=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
