Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF112C433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 04:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801B123133
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 04:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbhAME6Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 23:58:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22810 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbhAME6X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 23:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610513903; x=1642049903;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4gSmXrDfBO3U3Qrp2EUOdftT0hUEHASKu44qrzxTM3g=;
  b=DFOtIPh6FtQizlNMC/oY2VqId8tRmKkdG5J5ejgzX8DP7PbZcVEhqtaP
   BuhX7BfXGQSNgYRiwIqWlou2J+Q9qJLDHWwTwOHvf0ZY6knnaDDxY45Di
   iMAZjrBuuM86Wtf0Zk8kBsypJokw1XUdvriog57WIcpreEA26uBsq94fK
   AAkHWhhnAGa342+Rjvq01m6KDV8xQiSUnsSsP40qWqy5798Tj+1/lD3y8
   6s1W5H2B7E4hI5JRYyqZ/Ny9emulSFv1weE/hIVl5rCUgozpoyvcip2Yg
   u2RDHXp0nPdSywoNhcFNRpYBbL/yrxfrvnP5nfKNWUxPCTKh2bCYM2NBZ
   g==;
IronPort-SDR: qzdJubowxA+S+maYe9Y8uha0oYcLqoPpNKHaB148P9fV1TuSwyfE4APDIfoj/UMhgAj5Zy9cXs
 kfmY8sLBmGTrtXDgfA3jlR5/5bDiB0OwktxvgIXXZRscIsVo1xkbTh1Y8JtUCtFUuhFc79HYdo
 nZ45cAHACykfFi72R9ds2zciDU8Qr7z8rjVBVbL69fFVWNBiHMPFGOmPX65LJb254Wjcl3nuTL
 0eR7RCFGhYqmukYwqEdKonsLIf4yl7WDHInRGjbtnvGm6OTLiLbwP9MWCvuqlopTpO0r+L/U1h
 LQ0=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="158479144"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 12:57:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za5ClYfXo8VEBt4/N50lEuZRw/6xOeYdN9u8Zd706hEUZSs9VPao2welmVtLJv2lcEry1rNM/WCySaBYh9uN8Seb/RN///PY5P5Yg0AGW7jGQwv1TjrNXV3KMR+OGFaQx645fKW0F0TneuxOgdTH0cvKJjIc0Sw0E0Mez6tHo0Sp1ppOhrHDW8kd2Bq7FZhevTod2h1rc/rhPhDRHzHslRh78Jb7oZSXBn2USM4efrcWx6dL4+TOHQNCSrpEu4VUJIyzuDflCjTZRhRGlhgSlzhDM7vKyspHFn3vkCde+b8kQT+d1r2VuAGeQek5VukO52l+6UCQ194x1YJRzgzfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsCik3a20Svex7ihMxShzEnN3KY31xZQ4ptSi2V5lAw=;
 b=SDa7HihXvY3Q7vPB5FZez/jTTv7f2gJ+rYydVFdU4aTpLO/YXwO7Nxb6hL+l3euoq4OyFhj5JL4a5S0M854jYYgxVvLpWKNPh7/JP9TaF76VCdCc1dHBuXvWWnjjAH2XU47YyeNAAmnjM1RAm5qVlY3axzv7PWFLq88ThbtEL0Hro852UoUoNGl+iJaEFDbxehsJUxiWj5tcDY/4+nWrXUmFWHC5A/htfxBiOpg8NjuimAzvm6uoG+ua0r7HpOj5mSb+oF9WWN3TPg6x0Quk8l5XtwBoMRrGEI+gjk66eUDBJzZZeX2LBU3UGVor3Bnna/eXncoJ57e8mWtcs8JcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsCik3a20Svex7ihMxShzEnN3KY31xZQ4ptSi2V5lAw=;
 b=P8kb2GEm2LZtht5k+EgKv2UpEYP3ZEaxlDo5qtRLK7CjgJr6dS9S5sld2A2lMuubBiF2S7aPAHXEf7RBjc+H5W3amqDe+s39jc8wK63eqphZ9/Cr1OZm2sSSfkVW2kyHPQGg53E/aiYkxoCd9QJ5RxMnWTSJlcvqS9A0Jq/aumE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Wed, 13 Jan
 2021 04:57:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 04:57:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6JszE74B7v3S90G6ql/DwDLtmQ==
Date:   Wed, 13 Jan 2021 04:57:15 +0000
Message-ID: <BYAPR04MB4965CE08B1DE8BC36585991686A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <20210112074805.GA24443@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44e69fc2-daf3-4d6a-983f-08d8b77fb235
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB53335E5B215154392287E70386A90@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2/+/c5umbh91o4mArzT9h59QtPFyYq0Uc5xWTmkZgNMwNaBCsKolCoI6vLj0/kKPOFKsdC4sEZhxj1D66PdFRnDMQ7zin2LNm8r99MSwwUUmFVafS0xEn4JphpSQVtTt8UM5oJ7Vc9+CQpYlAkyi8z7o2Q9OM154Z2ijMDWWc5lVTCFeC6HzkyI7xCprOpE0RAEu5ty9ChwwFgpv/ZNboeufb7T02zNa+L4zN72HkhoR5hYRNBeJphnvkW123/l3Fc5/rTtalhwzehxrndxYY4hhPIDABS9QQ9VRHGFEBk8H3pucNRgPu6fSNnlcnsAdJIQr4ZQKLeIbt9cERx/AClHBBN//75qqkm3vaQ6/W8DDSgeGIYXg/lJzjwoyJnN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(8936002)(71200400001)(478600001)(4326008)(6916009)(55016002)(2906002)(52536014)(6506007)(53546011)(33656002)(5660300002)(64756008)(7696005)(26005)(186003)(66946007)(54906003)(66556008)(316002)(66476007)(76116006)(9686003)(66446008)(83380400001)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YGYlPIS96h1uSjBBVBxuM1YvNVg3oPFQs3VmRUJaDqjApVkXy+xXLx15zDtl?=
 =?us-ascii?Q?ycXDoYJvLinO2m6BIqzgKmkbV7MI/bN1wpZzGZ4WNF+2cSQ1yDGcKEyqEqaI?=
 =?us-ascii?Q?nE1tTjEZW/p+HyaVbl9grazZzt4cElCUDHHGSehJ0JK1xlXaYjqzs700dFn7?=
 =?us-ascii?Q?STN0Nxrk1JlkhDrGzbNoqbAfBGod5+ThJXvyV05/BpOealDUFP+uJYJymBWz?=
 =?us-ascii?Q?9iAc3RTdFSVFCiwOKmU2UCknUJN/NvcEJv9k8a2UTr/vxKGElRkM94tmf6Rf?=
 =?us-ascii?Q?Qv/U1pM07ZjJml6lwxwTTxbpk3L/SpY+C+P1hXAS7NDU6vOyjLtsdaW5x4Jk?=
 =?us-ascii?Q?2C0099jvt4hWet3MCecwQxCMzcysdF1GcwHHmXSU3XkBx9wjUdp2G5j2w91G?=
 =?us-ascii?Q?305dMdbw6iyL2fwvwS1kqoFx2LBsUrT4BWk+g8JRdWQjxwLK7teYZjdAYWcg?=
 =?us-ascii?Q?7Qvk8bMBT7BVXUdzcxwUJCHuo/slMKyieuxgbcl8Dm/Q4gEmm6U1RNjLl8om?=
 =?us-ascii?Q?aV1kCkFoTSesk4L5Alfw10n82fwi2u549ZwVvDo5Z4+kj3z2r2z5oeP3W1gz?=
 =?us-ascii?Q?P8zPAp3PddG6iHfEc6ghbMT2AP2D0YLlHMu4wvSxDvY+CiYk9euuJdS/qupP?=
 =?us-ascii?Q?DfLC9n0cDT5BOkvC51krFj2j1bKbkI5kwrGNyQC3WZgO1V+lQQ5htFMVYYDM?=
 =?us-ascii?Q?qXaHsfihb0z+QHZ2p1CErUS0DrBKtypm2QqvFa75n7PJXdskLBbe2QsTh/dW?=
 =?us-ascii?Q?qaIqsHA4uiS9WpqwaefF9VGYvk5cRRCjVZSyNVXFYC3JW1PY4WYCOCYSQqWx?=
 =?us-ascii?Q?UdsRNSnLlOmke8BomNvsFnIayiu2XK2FQSn/EsvXCHsBjUVgaNJTuST4CB5T?=
 =?us-ascii?Q?l77mybXSOz8RWOOkHkseC0xKZMEWg0boOi1KcHGE47mJNgwVMUvuiYlKT65i?=
 =?us-ascii?Q?+ZEd+bT3EX9TY7/VXUdnqYS+MtHhz4CgCGb5oe+hLVSnzpdKmhRgvbrd+NgQ?=
 =?us-ascii?Q?w2ZF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e69fc2-daf3-4d6a-983f-08d8b77fb235
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 04:57:15.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKlh1KQt/bDaVhh7kToso6goM0NtzMq2iB04xwZ6T+ZOMRJMCEGGNlUoiHQ26YSTVNOkHZ++Gm69YGM7ZcuBEayyfbaLjii9YBraeWuS0k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 23:48, Christoph Hellwig wrote:=0A=
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin=
-cmd.c=0A=
>> index a50b7bcac67a..bdf09d8faa48 100644=0A=
>> --- a/drivers/nvme/target/admin-cmd.c=0A=
>> +++ b/drivers/nvme/target/admin-cmd.c=0A=
>> @@ -191,6 +191,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(st=
ruct nvmet_req *req)=0A=
>>  		log->iocs[nvme_cmd_dsm]			=3D cpu_to_le32(1 << 0);=0A=
>>  		log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);=0A=
>>  		break;=0A=
>> +	case NVME_CSI_ZNS:=0A=
>> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
>> +			u32 *iocs =3D log->iocs;=0A=
>> +=0A=
>> +			iocs[nvme_cmd_zone_append]	=3D cpu_to_le32(1 << 0);=0A=
>> +			iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);=0A=
>> +			iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);=0A=
>> +		}=0A=
>> +		break;=0A=
> We need to return errors if the command set is not actually supported.=0A=
> I also think splitting this into one helper per command set would=0A=
> be nice.=0A=
>=0A=
Okay.=0A=
>> @@ -644,6 +653,17 @@ static void nvmet_execuIt should be te_identify_des=
clist(struct nvmet_req *req)=0A=
>>  	if (status)=0A=
>>  		goto out;=0A=
>>  =0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
>> +		u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
>> +=0A=
>> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)=0A=
>> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
>> +							  NVME_NIDT_CSI_LEN,=0A=
>> +							  &nvme_cis_zns, &off);=0A=
>> +		if (status)=0A=
>> +			goto out;=0A=
>> +	}=0A=
> We need to add the CSI for every namespace, i.e. something like:=0A=
>=0A=
> 	status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LE=
N,=0A=
> 					  &req->ns->csi);		=0A=
> 	if (status)=0A=
> 		goto out;=0A=
>=0A=
> and this hunk needs to go into the CSI patch.=0A=
even better, we can get rid of the local variables...=0A=
>>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off=
,=0A=
>>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)=0A=
>>  		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> @@ -660,8 +680,16 @@ static void nvmet_execute_identify(struct nvmet_req=
 *req)=0A=
>>  	switch (req->cmd->identify.cns) {=0A=
>>  	case NVME_ID_CNS_NS:=0A=
>>  		return nvmet_execute_identify_ns(req);=0A=
>> +	case NVME_ID_CNS_CS_NS:=0A=
>> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
>> +			return nvmet_execute_identify_cns_cs_ns(req);=0A=
>> +		break;=0A=
>>  	case NVME_ID_CNS_CTRL:=0A=
>>  		return nvmet_execute_identify_ctrl(req);=0A=
>> +	case NVME_ID_CNS_CS_CTRL:=0A=
>> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
>> +			return nvmet_execute_identify_cns_cs_ctrl(req);=0A=
>> +		break;=0A=
> How does the CSI get mirrored into the cns field?=0A=
>=0A=
There is only one cns and one csi value we set from host/zns.c=0A=
This is just to reject req if we receive anything else or there is=0A=
any change on the host we fail.=0A=
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
>> index 672e4009f8d6..17d5da062a5a 100644=0A=
>> --- a/drivers/nvme/target/core.c=0A=
>> +++ b/drivers/nvme/target/core.c=0A=
>> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)=0A=
>>  static inline bool nvmet_cc_css_check(u8 cc_css)=0A=
>>  {=0A=
>>  	switch (cc_css <<=3D NVME_CC_CSS_SHIFT) {=0A=
>> +	case NVME_CC_CSS_CSI:=0A=
>>  	case NVME_CC_CSS_NVM:=0A=
>>  		return true;=0A=
>>  	default:=0A=
>> @@ -1173,6 +1174,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl=
)=0A=
>>  {=0A=
>>  	/* command sets supported: NVMe command set: */=0A=
>>  	ctrl->cap =3D (1ULL << 37);=0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))=0A=
>> +		ctrl->cap |=3D (1ULL << 43);=0A=
>>  	/* CC.EN timeout in 500msec units: */=0A=
>>  	ctrl->cap |=3D (15ULL << 24);=0A=
>>  	/* maximum queue entries supported: */=0A=
> This needs to go into a separate patch for multiple command set support.=
=0A=
> We can probably merge the CAP and CC bits with the CSI support, though.=
=0A=
Do you mean previous patch ? but we don't add handlers non-default I/O=0A=
command set until this patch..=0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {=0A=
> bdev_is_zoned should be probably stubbed out for !CONFIG_BLK_DEV_ZONED=0A=
> these days.=0A=
Are you saying something like following in the prep patch ?or should=0A=
just remove=0A=
theIS_ENABLED(CONFIG_BLK_DEV_ZONED)part in above if?=0A=
=0A=
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
index 028ccc9bdf8d..124086c1a0ba 100644=0A=
--- a/include/linux/blkdev.h=0A=
+++ b/include/linux/blkdev.h=0A=
@@ -1570,6 +1570,9 @@ static inline bool bdev_is_zoned(struct=0A=
block_device *bdev)=0A=
 {=0A=
        struct request_queue *q =3D bdev_get_queue(bdev);=0A=
 =0A=
+       if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))=0A=
+               return false;=0A=
+=0A=
        if (q)=0A=
                return blk_queue_is_zoned(q);=0A=
>> +/*=0A=
>> + *  ZNS related command implementation and helpers.=0A=
>> + */=0A=
> Well, that is the description of the whole file, isn't it?  I don't think=
=0A=
> this comment adds much value.=0A=
Stupid comment, will remove it.=0A=
>> +	/*=0A=
>> +	 * For ZBC and ZAC devices, writes into sequential zones must be align=
ed=0A=
>> +	 * to the device physical block size. So use this value as the logical=
=0A=
>> +	 * block size to avoid errors.=0A=
>> +	 */=0A=
> I do not understand the logic here, given that NVMe does not have=0A=
> conventional zones.=0A=
>=0A=
It should be :-=0A=
=0A=
	/*=0A=
	 * For ZBC and ZAC devices, writes into sequential zones must be aligned=
=0A=
	 * to the device physical block size. So use this value as the *physical*=
=0A=
	 * block size to avoid errors.=0A=
	 */=0A=
=0A=
=0A=
