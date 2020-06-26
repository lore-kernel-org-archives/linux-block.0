Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503BEC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5BB20767
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QmjwAZd/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ar/BQfI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFZBOi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:14:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33552 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgFZBOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 21:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593134076; x=1624670076;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UhkcfXJAjB1uCDx7CpV+tD4xYaIb/7aE0GU6iWYREmc=;
  b=QmjwAZd/5uWJTsmVBdyttoXUPAAX0dzBl4lnLzoZjOrp1v/CiRFtRJOR
   9Cqm0z8P0SkIvngDIzcRevDlIVEIjjbjQrKCQl0scjKvmj8sL8LUwOWej
   X4tNYDfEfRyQRJC/ZRlwdAk1z2DLc7Tn6CKnRATGQdYKKkJ8trghqPpGz
   JpsyKBcqHFuuImEvNFp0IwWi+azZyBPfyKmo0F8D1RiFOZ2bPmBk6KZV2
   03QTqPbePp2XjhQBqoc045hMcoKwciVd5/HfSWWqft40jIQXCKIKDUtlV
   VNOZEvFdurFxuOZ3LUAKCiuw/uCmcFBBwwpW2UmgiB/GU36KHcSLL8ga+
   g==;
IronPort-SDR: 2CwLU7Ixzn5/nrMMHDPtpM2lYSTmni6lWC7N/4MeQjqr0z4grqRKrYAS9sNgAkfHOmycCoqXEx
 sEKWMp2GUfDpwSEdT1w/o6bUgNpKQDTC8drzLRYJoE4R9pij+2PjJ/LA6zvqp2RzadNkZNF310
 ft/m2YYOVTuA9WNpy+O5P+QZkzCQ7Lp0uSujNnTzm8HpyRD0LKcx54FGGnu93tM2Rbmqq1NLc2
 6swWsGcHAUitUoX5HVLkTv69k0fKbjrkaGlOm4m6+fPrxKVKL9NeDFk0Bh8g3ZCLaYdmB1+AXC
 uw4=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="141196190"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:14:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMqUgBjnGY29Aidu1EaFyW6AYcO7+NvNGAARcEbawaVA1AHEOi1iJv2cVSL8/YvDpwE2P3nNPCn+/f5IXu+O5Qx1IIKiRJWHLtKFK8ZCz3rhiznmZxXAkyabKmhPRz3+sCnyGU1LrbMbsrtp/rmk5al9bzae2YsG5N89ILAEE5A2mY5c/dswrsul7w0AcJdU2eX2wp9FTqiQNv6Hof5isYvkzDC/iBNilSUlXoV4RyhKPYyhZgS8qu6bAPnCpOUQGE4mUkfNY762qVOjAgcDaA4J143+6Zh/VbCSxDLAjwVuM6wqjrQA6is8cjYXECW8TBByHz9oHJz0yqgJgnzKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX/Rov5Yniivb5Ca5b86G5bq/pKzYkDJXFdPJp/GtfI=;
 b=UWr2LfItbXuFXTt8bI06zXDVuQGGeM9vBUJTqO/+R8qrX2d3pqgJyoDUzm2kAQLUGlJ89RcmtjeSIp1Vnnq0Y0BEkKc2qBfz+dlFWh8d8On1H5zqxBEXYNMnopxd0M3VRb5Y2nTOxJLJiACc2q5ingvdkJwaF6no4U0G9/pBXFdsJhL08iJiak5CwKVZPiTSenakMHtFVLOZn0Yaymh67JwevpWU0zjWc57VrasFpvhnCECTHXcmiy0q6NS+nBoe95eXoVL7Cw3ElgzURAGX7VXIlQIeTkDngnxaNhA5ovKNI5xsKIuhhfLFkE7r8lAx49w+cTfNXRrkfdqMUlUOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX/Rov5Yniivb5Ca5b86G5bq/pKzYkDJXFdPJp/GtfI=;
 b=ar/BQfI13ZBftZ5+zUt/bLrP+ovIrA+dugTQbGFu3drDkQS5ImByZVjJeMATYcCB3vRqsraG85YEXS5A9aH71n7q99v4QFAFeRCSNRtJ651Ysk6Ff2UsTqbNTFmYGOS4P7oBADZqV+zTZBV28pxly5u63LCAWKItR/W7PtpSqQk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 01:14:31 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:14:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date:   Fri, 26 Jun 2020 01:14:30 +0000
Message-ID: <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ffcdf2f-b9c5-4c63-b5a9-08d8196e4792
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-microsoft-antispam-prvs: <CY4PR04MB072662A5073BD8EBAEDC08FCE7930@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SUs4eGm45AGQXtk+bCgei8iiZyxSR9wNL8nFG/0qML1wUAgAfFwitxNfLUlhbdPP0gdQcnscL0BdODKmCVaeSFCJseBKXUXfz2fItD3OcmDgi9JVisUUb+5qTUVc5tJRlBoToPiYHGL3VjFERvGGh3wcbQbzEsnF5vkCA5iqonXEEs8m9IaQPOYriwdL0tbls60rw6JTNZ+qA0uHtrHtFVuYUpDgFbsZ1BIU7Cyw6iz/gVMcRLLGkIzboNpTQf17XvOXa+nardQM1xqqi05xOBWQM7fOP0YM32FMCCAU86bXCIOfvH/o86vn2GXlS43
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(53546011)(52536014)(33656002)(83380400001)(54906003)(110136005)(71200400001)(316002)(478600001)(66446008)(8936002)(66946007)(26005)(86362001)(64756008)(7416002)(66556008)(9686003)(6506007)(5660300002)(8676002)(186003)(66476007)(91956017)(7696005)(66574015)(76116006)(4326008)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZUSzMntiBVwnTfg4TKD3xcxoFTKxkNKyHI3jCwTUdqDDdkvQRW9XUvehyJ87Uzr9K8vZBu6P39b0K7S0kkuXnUSm3RX8iQ2ltqTc8Gsof/y/1hdXxAVpg+h69pQ/gorpkNjnGZydy2iTeW53cZSr4jw67oZEFKqX5b+9n02U+ZLVAe0/TZOm4iCtVQMHeQ+9u1rDQw8QK+4jbFhuNEU1ZwbvSuOQ15QjgqVpZpG5EiGlRRnpG6xdesst3jTPHRAADBGlGT/djKcTFJrQD8S8QGzibMZ84mtjR2ldPcn6D4/VCgD6gV3mQuFfaFvY5BsaaMg2LcsAl2YaNdEAn/z+jVLoJKwCsnz/yk32lkkL1mKpd8bNUPJhM8SymEl0fU/WSVR0EoWF1SnS90LzIuFPApTAOGnkrV0FZJx+tZfgFAldr8besrhyQQCUA5Kl6D6UXZHRcCICWTavS5xNsDMlSchXbDdxCSUuOeLa20LQ9RXM3sgCk7IHqInUCkkn8J3A
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffcdf2f-b9c5-4c63-b5a9-08d8196e4792
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:14:30.9100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBH9RG24flRytJYFEaMC83t2x40Pk79mcnNiFdKGOjNA5STkz9ShE2q2d8NAeKhwIlfji3G+yt8Ti8CBEG+m8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 4:48, Javier Gonz=E1lez wrote:=0A=
> On 25.06.2020 16:12, Matias Bj=F8rling wrote:=0A=
>> On 25/06/2020 14.21, Javier Gonz=E1lez wrote:=0A=
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>=0A=
>>> Add support for offline transition on the zoned block device using the=
=0A=
>>> new zone management IOCTL=0A=
>>>=0A=
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>> ---=0A=
>>>  block/blk-core.c              | 2 ++=0A=
>>>  block/blk-zoned.c             | 3 +++=0A=
>>>  drivers/nvme/host/core.c      | 3 +++=0A=
>>>  include/linux/blk_types.h     | 3 +++=0A=
>>>  include/linux/blkdev.h        | 1 -=0A=
>>>  include/uapi/linux/blkzoned.h | 1 +=0A=
>>>  6 files changed, 12 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>>> index 03252af8c82c..589cbdacc5ec 100644=0A=
>>> --- a/block/blk-core.c=0A=
>>> +++ b/block/blk-core.c=0A=
>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {=0A=
>>>  	REQ_OP_NAME(ZONE_CLOSE),=0A=
>>>  	REQ_OP_NAME(ZONE_FINISH),=0A=
>>>  	REQ_OP_NAME(ZONE_APPEND),=0A=
>>> +	REQ_OP_NAME(ZONE_OFFLINE),=0A=
>>>  	REQ_OP_NAME(WRITE_SAME),=0A=
>>>  	REQ_OP_NAME(WRITE_ZEROES),=0A=
>>>  	REQ_OP_NAME(SCSI_IN),=0A=
>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)=0A=
>>>  	case REQ_OP_ZONE_OPEN:=0A=
>>>  	case REQ_OP_ZONE_CLOSE:=0A=
>>>  	case REQ_OP_ZONE_FINISH:=0A=
>>> +	case REQ_OP_ZONE_OFFLINE:=0A=
>>>  		if (!blk_queue_is_zoned(q))=0A=
>>>  			goto not_supported;=0A=
>>>  		break;=0A=
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>> index 29194388a1bb..704fc15813d1 100644=0A=
>>> --- a/block/blk-zoned.c=0A=
>>> +++ b/block/blk-zoned.c=0A=
>>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bde=
v, fmode_t mode,=0A=
>>>  	case BLK_ZONE_MGMT_RESET:=0A=
>>>  		op =3D REQ_OP_ZONE_RESET;=0A=
>>>  		break;=0A=
>>> +	case BLK_ZONE_MGMT_OFFLINE:=0A=
>>> +		op =3D REQ_OP_ZONE_OFFLINE;=0A=
>>> +		break;=0A=
>>>  	default:=0A=
>>>  		return -ENOTTY;=0A=
>>>  	}=0A=
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
>>> index f1215523792b..5b95c81d2a2d 100644=0A=
>>> --- a/drivers/nvme/host/core.c=0A=
>>> +++ b/drivers/nvme/host/core.c=0A=
>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req,=0A=
>>>  	case REQ_OP_ZONE_FINISH:=0A=
>>>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);=
=0A=
>>>  		break;=0A=
>>> +	case REQ_OP_ZONE_OFFLINE:=0A=
>>> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);=
=0A=
>>> +		break;=0A=
>>>  	case REQ_OP_WRITE_ZEROES:=0A=
>>>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);=0A=
>>>  		break;=0A=
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
>>> index 16b57fb2b99c..b3921263c3dd 100644=0A=
>>> --- a/include/linux/blk_types.h=0A=
>>> +++ b/include/linux/blk_types.h=0A=
>>> @@ -316,6 +316,8 @@ enum req_opf {=0A=
>>>  	REQ_OP_ZONE_FINISH	=3D 12,=0A=
>>>  	/* write data at the current zone write pointer */=0A=
>>>  	REQ_OP_ZONE_APPEND	=3D 13,=0A=
>>> +	/* Transition a zone to offline */=0A=
>>> +	REQ_OP_ZONE_OFFLINE	=3D 14,=0A=
>>>  	/* SCSI passthrough using struct scsi_request */=0A=
>>>  	REQ_OP_SCSI_IN		=3D 32,=0A=
>>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)=
=0A=
>>>  	case REQ_OP_ZONE_OPEN:=0A=
>>>  	case REQ_OP_ZONE_CLOSE:=0A=
>>>  	case REQ_OP_ZONE_FINISH:=0A=
>>> +	case REQ_OP_ZONE_OFFLINE:=0A=
>>>  		return true;=0A=
>>>  	default:=0A=
>>>  		return false;=0A=
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>> index bd8521f94dc4..8308d8a3720b 100644=0A=
>>> --- a/include/linux/blkdev.h=0A=
>>> +++ b/include/linux/blkdev.h=0A=
>>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_devic=
e *bdev, fmode_t mode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,=0A=
>>>  				  unsigned int cmd, unsigned long arg);=0A=
>>> -=0A=
>>>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h=0A=
>>> index a8c89fe58f97..d0978ee10fc7 100644=0A=
>>> --- a/include/uapi/linux/blkzoned.h=0A=
>>> +++ b/include/uapi/linux/blkzoned.h=0A=
>>> @@ -155,6 +155,7 @@ enum blk_zone_action {=0A=
>>>  	BLK_ZONE_MGMT_FINISH	=3D 0x2,=0A=
>>>  	BLK_ZONE_MGMT_OPEN	=3D 0x3,=0A=
>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
>>> +	BLK_ZONE_MGMT_OFFLINE	=3D 0x5,=0A=
>>>  };=0A=
>>>  /**=0A=
>>=0A=
>> I am not sure this makes sense to expose through the kernel zone api. =
=0A=
>> One of the goals of the kernel zone API is to be a layer that provides =
=0A=
>> an unified zone model across SMR HDDs and ZNS SSDs. The offline zone =0A=
>> operation, as defined in the ZNS specification, does not have an =0A=
>> equivalent in SMR HDDs (ZAC/ZBC).=0A=
>>=0A=
>> This is different from the Zone Capacity change, where the zone =0A=
>> capacity simply was zone size for SMR HDDs. Making it easy to support. =
=0A=
>> That is not the same for ZAC/ZBC, that does not offer the offline =0A=
>> operation to transition zones in read only state to offline state.=0A=
> =0A=
> I agree that an unified interface is desirable. However, the truth is=0A=
> that ZAC/ZBC are different, and will differ more and more and time goes=
=0A=
> by. We can deal with the differences at the driver level or with checks=
=0A=
> at the API level, but limiting ZNS with ZAC/ZBC is a hard constraint.=0A=
=0A=
As long as you keep ZNS namespace report itself as being "host-managed" lik=
e=0A=
ZBC/ZAC disks, we need the consistency and common interface. If you break t=
hat,=0A=
the meaning of the zoned model queue attribute disappears and an applicatio=
n or=0A=
in-kernel user cannot rely on this model anymore to know how the drive will=
 behave.=0A=
=0A=
> Note too that I chose to only support this particular transition on the=
=0A=
> new management IOCTL to avoid confusion for existing ZAC/ZBC users.=0A=
> =0A=
> It would be good to clarify what is the plan for kernel APIs moving=0A=
> forward, as I believe there is a general desire to support new ZNS=0A=
> features, which will not necessarily be replicated in SMR drives.=0A=
=0A=
What the drive is supposed to support and its behavior is determined by the=
=0A=
zoned model. ZNS standard was written so that most things have an equivalen=
t=0A=
with ZBC/ZAC, e.g. the zone state machine is nearly identical. Differences =
are=0A=
either emulated (e.g. zone append scsi emulation), or not supported (e.g. z=
one=0A=
capacity change) so that the kernel follows the same pattern and maintains =
a=0A=
coherent behavior between device protocols for the host-managed model.=0A=
=0A=
Think of a file system, or any other in-kernel user. If they have to change=
=0A=
their code based on the device type (NVMe vs SCSI), then the zoned block de=
vice=0A=
interface is broken. Right now, that is not the case, everything works equa=
lly=0A=
well on ZNS and SCSI, modulo the need by a user for conventional zones that=
 ZNS=0A=
do not define. But that is still consistent with the host-managed model sin=
ce=0A=
conventional zones are optional.=0A=
=0A=
For this particular patch, there is currently no in-kernel user, and it is =
not=0A=
clear how this will be useful to applications. At least please clarify this=
. And=0A=
most likely, similarly to discard etc operations that are optional, having =
a=0A=
sysfs attribute and in-kernel API indicating if the drive supports offlinin=
g=0A=
zones will be needed. Otherwise, the caller will have to play with error co=
des=0A=
to understand if the drive does not support the command or if it is support=
ed=0A=
but the command failed. Not nice. Better to know before issuing the command=
.=0A=
=0A=
=0A=
> =0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
