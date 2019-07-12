Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E564CC742A2
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC552208E4
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dvN+mRfn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CgOdBMzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfGLCue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:50:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65005 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfGLCud (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562899833; x=1594435833;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7R8In/4F777ie8jq47YXBU7Zra0vZkjPnM2LOwltLWU=;
  b=dvN+mRfn8wMoWdmQ8KRkI444YmNi9r3IF+mQgV3/z9I+qpUjD0cuAHb0
   /b6nexelfaX7KPl9oaLQAMmvvOeL+s8uecwPw2nao3aLLZCk+VPypznZD
   xFMCee2rT+Zp6/ESwVqWz1bxuDiIoZRDAI59Iv2gGgo6hE7Q/BL6Hbtod
   FYTOnA5A4BhfV0iPGN59Stwqtcf5hwNVOfScZd674puBJWo/hrVijpC7q
   ofrBVh0h5oSPLkgflDfKN+l0GdYkh/qFBoDIx2mZ4pNoHZ3SZv0gN2phG
   wi4b/XMdSNJAeHRNPPStSsLG/Em754mFOBqb7VhKAzADP7hIZ2HiLEV2j
   A==;
IronPort-SDR: T/YSXhNFfb0mUWnK/aH7lGkeFpmcuWqTQznI4sQfgOdF4u1qSBPC6BYxbFKRhylVH0QBanHPfk
 WBtUTs01xPVH6GTSX4KbsVpWxEhba+PvwBxgHm6avoCniUd3SDw3VNsoHy45zQNWI0ruFC0ab0
 r+4UXLhsJFqpY2WF0k6czJ/7MDMhIq3xx8YwBmG9z5ZFvG/2hDPn0EL42UQAp0k/qOtPQNYFPE
 W6cGJTJSuKAew/SGSmX6G80SeVrHhuCEmqDW+qI50Mt6jcaaH5VkH+OKnWXVmIaJl6HfYdb3Wt
 1CU=
X-IronPort-AV: E=Sophos;i="5.63,480,1557158400"; 
   d="scan'208";a="117638372"
Received: from mail-co1nam05lp2054.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.54])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 10:50:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r61vwOalJ7YeLIH/ocZe+B4l/+PLBK/CGqOEqjtiKKo=;
 b=CgOdBMzxu9gjVrJ00DYlgxomQCKyf5xFgnwX2GI610VCPyfLYic2XhUTKNO6XN67BV/yNo7KA5+8lOa7N2fB65/tR09hO6mckili9+Nqm78Q9zOh9DmYDKNOdO/hq44fbq+bS7MW82RBap0AXJy6ZMaSS+5N31CKFyvfErDUbAY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4950.namprd04.prod.outlook.com (52.135.232.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 02:50:31 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 02:50:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: tidy up blk_mq_plug
Thread-Topic: [PATCH] block: tidy up blk_mq_plug
Thread-Index: AQHVN9o+sndcsfGM/ka+J11i8GzIeg==
Date:   Fri, 12 Jul 2019 02:50:30 +0000
Message-ID: <BYAPR04MB5816CEFFB1AB14A14D6A03D7E7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190711111714.4802-1-hch@lst.de>
 <53c09d04-3f29-2cea-ede4-cdf443539a17@kernel.dk>
 <BYAPR04MB5816B7867433C3A946E7411DE7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
 <ff1df7c2-93a8-5233-3873-005817356c27@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3d53f9a-1bd9-49af-b188-08d70673b447
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4950;
x-ms-traffictypediagnostic: BYAPR04MB4950:
x-microsoft-antispam-prvs: <BYAPR04MB49503F2B994BF66B59194709E7F20@BYAPR04MB4950.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(9686003)(74316002)(186003)(8936002)(305945005)(66066001)(26005)(486006)(53936002)(6506007)(71190400001)(71200400001)(53546011)(102836004)(478600001)(6436002)(55016002)(99286004)(2906002)(68736007)(229853002)(316002)(256004)(33656002)(14454004)(14444005)(5660300002)(52536014)(110136005)(6246003)(7736002)(6116002)(446003)(81166006)(66446008)(66946007)(76116006)(91956017)(25786009)(64756008)(66556008)(81156014)(66476007)(86362001)(8676002)(4326008)(3846002)(476003)(7696005)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4950;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ehuBePKKbAmpFbvZMK2Gm9zy48ZGBpmzjsBIVhjxlmHW9Qm4eoGBJw2X5EIMNmTUweWaB9JsOlqfhq4ixODUr+O6YBuaTp8x/WBpfUvHES/JSnFyOLTolPDETcip9aSRla2EqSbMdu2LxJ87VRZMou8qu4tLUwOLmVxu54Zw1fSUrB4Abh2vUG9wVpMZWXFGHbyJhzUajmeFP/T4ICAT+yQ9Xd5h9+FjUz8xUBo6HUprKSb/4KDinqt2BUePbTBL/cT8ht+Xy2p6t3B7xTG7S4HN2ywcsJa/cH2bhyMVGoYIsptyw95ef4VTH1Q0UoYBO/uc0dLxj+jjAfYF9XGq1GB1VAxqdfoYr+Ea4mVGk2sYao7Tk7ct1+HuWRRNIvJoQsJmWqiNz2L+q5/kkXJh3TSkcCMYOZsGVaArXvjYi2M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d53f9a-1bd9-49af-b188-08d70673b447
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 02:50:30.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4950
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/12 11:44, Jens Axboe wrote:=0A=
> On 7/11/19 8:37 PM, Damien Le Moal wrote:=0A=
>> On 2019/07/12 3:09, Jens Axboe wrote:=0A=
>>> On 7/11/19 5:17 AM, Christoph Hellwig wrote:=0A=
>>>> Make the zoned device write path the special case and just fall=0A=
>>>> though to the defaul case to make the code easier to read.  Also=0A=
>>>> update the top of function comment to use the proper kdoc format=0A=
>>>> and remove the extra in-function comments that just duplicate it.=0A=
>>>>=0A=
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
>>>> ---=0A=
>>>>    block/blk-mq.h | 14 ++++----------=0A=
>>>>    1 file changed, 4 insertions(+), 10 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/block/blk-mq.h b/block/blk-mq.h=0A=
>>>> index 32c62c64e6c2..ab80fd2b3803 100644=0A=
>>>> --- a/block/blk-mq.h=0A=
>>>> +++ b/block/blk-mq.h=0A=
>>>> @@ -233,7 +233,7 @@ static inline void blk_mq_clear_mq_map(struct blk_=
mq_queue_map *qmap)=0A=
>>>>    		qmap->mq_map[cpu] =3D 0;=0A=
>>>>    }=0A=
>>>>    =0A=
>>>> -/*=0A=
>>>> +/**=0A=
>>>>     * blk_mq_plug() - Get caller context plug=0A=
>>>>     * @q: request queue=0A=
>>>>     * @bio : the bio being submitted by the caller context=0A=
>>>> @@ -254,15 +254,9 @@ static inline void blk_mq_clear_mq_map(struct blk=
_mq_queue_map *qmap)=0A=
>>>>    static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=
=0A=
>>>>    					   struct bio *bio)=0A=
>>>>    {=0A=
>>>> -	/*=0A=
>>>> -	 * For regular block devices or read operations, use the context plu=
g=0A=
>>>> -	 * which may be NULL if blk_start_plug() was not executed.=0A=
>>>> -	 */=0A=
>>>> -	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))=0A=
>>>> -		return current->plug;=0A=
>>>> -=0A=
>>>> -	/* Zoned block device write operation case: do not plug the BIO */=
=0A=
>>>> -	return NULL;=0A=
>>>> +	if (blk_queue_is_zoned(q) && op_is_write(bio_op(bio)))=0A=
>>>> +		return NULL;=0A=
>>>> +	return current->plug;=0A=
>>>>    }=0A=
>>>>    =0A=
>>>>    #endif=0A=
>>>=0A=
>>> I agree it's more readable, but probably also means that the path that =
we=0A=
>>> care the least about (zoned+write) is now the inline one.=0A=
>>=0A=
>> What about an additional inline function ?=0A=
>> So something like this is very readable I think and blk_mq_plug() can al=
so be=0A=
>> optimized with #ifdef for the !CONFIG_BLK_DEV_ZONED case.=0A=
>>=0A=
>> #ifndef CONFIG_BLK_DEV_ZONED=0A=
>> static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=0A=
>>    					   struct bio *bio)=0A=
>> {=0A=
>> 	return current->plug;=0A=
>> }=0A=
>> #else=0A=
>> static inline struct blk_plug *blk_zoned_get_plug(struct request_queue *=
q,=0A=
>>    						  struct bio *bio)=0A=
>> {=0A=
>> 	if (op_is_write(bio_op(bio)))=0A=
>> 		return NULL;=0A=
>>=0A=
>> 	return current->plug;=0A=
>> }=0A=
>>=0A=
>> static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=0A=
>>    					   struct bio *bio)=0A=
>> {=0A=
>> 	if (!blk_queue_is_zoned(q))=0A=
>> 		return current->plug;=0A=
>>=0A=
>> 	return blk_zoned_get_plug(q, bio);=0A=
>> }=0A=
>> #endif=0A=
> =0A=
> Let's not go that far into ifdef'ery, please... Besides, that usually=0A=
> solves nothing, as most/all kernels will have zoned support enabled.=0A=
> =0A=
> I'm actually fine with the existing setup. Yes, the other variant is=0A=
> easier to read, but I bet the existing one inlines better.=0A=
> =0A=
=0A=
OK. Thanks.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
