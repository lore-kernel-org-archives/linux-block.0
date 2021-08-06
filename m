Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8E4C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD2A611C6
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhHFGwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:52:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20453 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhHFGwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 02:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628232734; x=1659768734;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BELmR6TEk+jUElotJjvlH188G27pxsroD14D3Bqxi/A=;
  b=fC3lEwxG5WvSJZrIWAWAm+tAPgiqGtJym+igjmF0ygoSz/5nmVWHvzys
   vWs2omLVP5O/BkuYKT8SICVuptoa4saLcVM8XV0OUo6Y1PiFQY6hQJrlH
   rMB0i65PYzfzLXwOUPh3liP8UIHnIp7dLb01ty43HVUH2jUKqroVg9V9f
   UQFJ4xQ2WPXWZXSX9GUUfROQOvqtjYFfcIZdjszHfcIW282QAz4xWx/2u
   3r4zepVNIX7ul4QHmlXNBP0VlZOYAjxiuKyMGembpnFaTrIp6l+xgrjI0
   HhhdSTaVKw/efiBrbKIhPCgRpRSOgDjTsfnMcG2kfQDKUMYMRg/JKNoOe
   w==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="181292316"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 14:52:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUpuj3ViylJtkTzFFI2NMOfmiz9wmuaWtf/1QgvjQvamqf4qUvIv/62/PA1J+XNS09fLl0m3PLU0Rn7oE2S+Vgn3rwfZycpOT/gN2K1QpIgnL0zaivUyY0YT9mUs4l7FPscw+k768wHhfFJc6pZP2teAZWfcWmJS+46Rx4Q2br+ATxqm2NEG4p2HuQC282WVeUQAWbwGPYiSXF6Ip0zJEyYikXAbtLNDbYpButb7e8aR79OSrpFP5HoswvwCikfjvt8UaPxgMkOHYDCCNZsrBMPk3KIzjXNtCK8ZP3WBoKxtDtEMojspSTP/ZEKVmrdrixWxavq+xjWx0utKDHcR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W6nAVNRqnF89qsjjN9H7dNgy5UAyh/NKeStVT7aA/k=;
 b=aDc/SzQ9uVScbAtB5r6hKODKKzdNbYVkpHGHWxCVbjkji0claVUeftLzPyqofcMJcDOJlEcZkAsIR3mREyNJdxhLyO00hV0FQLsnbK5a9Rkl35hNHL6jHhpc+fkNWJ9n/Aa6MNns3TJNIlZFHfEqiIM9Lp613HIyfwNvXzIjsSAH13LvrLtKwpFB4t4Q5AFdWXhpHkIO7d6I2IkV7hzaFlMk8JI9OCmgy15n4t5ihXRjmOUAMg5af3ljDx3fovpFVUy3D2x9q1bgZm22cRROHY2wwJ8J3r0hUIEgLovwkDHZxLZPq0qWYV/fNrxMDAOZORAJocTGNOiWWWOmZYY0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W6nAVNRqnF89qsjjN9H7dNgy5UAyh/NKeStVT7aA/k=;
 b=pgspqKiyR7pPUFvSrkEV6X3iWaOI45rwBptGMY397doPuJvJOVFIdCDh/Jv2fB6P2GpxpkR/L8+cIQl9CS3iPxZ73znY0Lp6qf1gXV2eU+rfqQaYYA/bvE5xkJpQLVcyx8hUmOsuq2pPeEOxoSKBahD8nsvm4ipjyzw3yhIv2eA=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6777.namprd04.prod.outlook.com (2603:10b6:5:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 6 Aug
 2021 06:52:13 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%7]) with mapi id 15.20.4394.018; Fri, 6 Aug 2021
 06:52:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 3/4] block: rename IOPRIO_BE_NR
Thread-Topic: [PATCH v2 3/4] block: rename IOPRIO_BE_NR
Thread-Index: AQHXioGTkzlnTrsYeUmIRr1Ce5RaVg==
Date:   Fri, 6 Aug 2021 06:52:13 +0000
Message-ID: <DM6PR04MB708197F979647F5D37988D8FE7F39@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
 <20210806051140.301127-4-damien.lemoal@wdc.com>
 <d0bc418e-ddf7-6038-427a-2e9ad2f4ab87@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a727b88-a99c-4602-5008-08d958a6b8b1
x-ms-traffictypediagnostic: DM6PR04MB6777:
x-microsoft-antispam-prvs: <DM6PR04MB67774984CE53EFFBC68C3CBAE7F39@DM6PR04MB6777.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/xZnSlSbi1RYVdcqqg/N6LmvTmC21qWXuzsJP5WaFW2nrhzvoSJfyIFrlbMN9dtp5xQfRjbAuqD/g7IpL5z/DsoxN5MieIFoc2YHHTfrpJVKmrxorqMWgBptKuFypErGyqHGixVQc0ziFPL+JmprgcUHeQHZ81/0UEO8urOsV+Oy2rCcH8i5zw5l1+6+kaQ7sIBFamoPfOZ/RgOGYSvP2RIpggYgvTf8opcQa/ReoeO5wmpsiskrowmvDwA9NXlKOHf1W98eFQSvbdmNqmxLg7omz+5yS6faHVyGse41FVmaOrgNv9z8bYEw2Wt4rntHeEiB4hv3N17nZOchAZFuD5nvMqMuZwKHhy1cL7qlB43FREPEs36AFEY4ywESe7Ms3HDEHHpaZl9FA/9Zks6o1aum7h+wP79+eh2wdLR8rpwL/uxgNGIPnqFlHZiI/rbR7XwKOnUD24hY/BQnSOR8ev0vFjtgJILwCLB9ojE+FME1b2r/LNI9dNSQBgmto0lcLlp7WiBw3tyR5NAY/XMwpujL4fQcs6zlBdrLCijWc2E/vJUqk+dPkdWfXHFRoyQsuHFquZjWgA08hThEd/tmckdPpjUOynGBkFFQaMD4Zg5brX4CcOawdiLsfzR0RfRBqIwe7RPoBch1V/G0hQttoUTekKa5WfHZDeowsO2IcyhelqfBM003vfVYa120ERgRdIBPrpRRQYqIikaoFPISQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(186003)(2906002)(66556008)(5660300002)(316002)(64756008)(66446008)(9686003)(110136005)(71200400001)(66476007)(83380400001)(52536014)(8676002)(38100700002)(91956017)(38070700005)(86362001)(55016002)(76116006)(33656002)(122000001)(66946007)(7696005)(508600001)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ym3lgEtrHA62eYTiVGSE4qsLlnff3rMV2E4+moQZzNN302sM3HD1hlLndCSF?=
 =?us-ascii?Q?kjub6cFPRIWMFu1/ZvfrPUxF5FYV2x1DaGUYv25scxLqD+TFA448KH9PjWRT?=
 =?us-ascii?Q?/yeM9JFd9U18xz9lBf+qOOwhsTby+EkHCiw7S+NFRVit3fmsNcnNabscu5hg?=
 =?us-ascii?Q?29g3kN9qiattxFkO/ZZeH3eI28jaBwiZmx8CJljHR5Z76l8KIzZBO9mbfKPe?=
 =?us-ascii?Q?pJDyKj+LTGd26H367D1eYVe+YfUr0nOMC2bZ1pMIGTX5gp2coeAzvwuYcrqw?=
 =?us-ascii?Q?HD5BKaxbsmcTM2imb7Z2aatZSAf87ujPih6obl+xi/5XrtnF8vrsr9hk7wCe?=
 =?us-ascii?Q?+UQAxMhJSLKqsu834WUUFOvOfUsMoP8D+xht294hSUvNpdjdpuYM7A5GApjf?=
 =?us-ascii?Q?Fh7bAr/brOlzIyFASyv2y68Sf6j/3Ipy1dn/Ijvx+IfV1FOk+nMJWL7w3+Ha?=
 =?us-ascii?Q?R+UuAZbRlvItgv5Usa/xhBDL/Q0m50aUu+CCJ646GwY+3e60EUWqwpdvVI24?=
 =?us-ascii?Q?g787CSeSX3vhaC2emWOv60WDILgOAXXLGLFvb3Ir7QAeI9lOc25CP5HMhKEX?=
 =?us-ascii?Q?lngLIu9dAuoJkqJGieaaSWBGCAl2YBFdoGVO0iWhx1Wt3zIqFdNUNECwUldu?=
 =?us-ascii?Q?2vPpShyBwBehQDuYpNP/i33hpwV60dB5pqIZraOUpqZ3YXd2X0D3lkYJWEeU?=
 =?us-ascii?Q?aXOpyiN3cSkfI7zJ2cAuCyJB1/fHnj7G/gts1aHmOUddxfEOQmfxM/Mw8L+9?=
 =?us-ascii?Q?fprgeiXbp5BnOWgwqjhaoZB3NI4Pl+npVKWYtOOq+jrlSgStHwLrA0xP2toC?=
 =?us-ascii?Q?zidDsn1GUC3c7P4otOzUllnCJstYrHKmXTQa4Y94gnq8/kuQR4wuOEHhLOyO?=
 =?us-ascii?Q?pPVKumPjGUQtsO1SeEJrV+ONJY+6Ba90QQpOYVJYmDh4f/cD8NUlOeDoKyI6?=
 =?us-ascii?Q?Em6XUQiEBjqHR2cG0wASF72plpCT0YvCk1ZajpaljlMxIYwoafOCfMDIZleJ?=
 =?us-ascii?Q?VKux67BLLLF39Eclm9a73OAbEmsywbx1CjrOf8JPVYLTmXH29e1bIm9NwNLu?=
 =?us-ascii?Q?kY3QzWPavjkGBQr1qM2Gsuy+Efv7pPYq0veuNWW95bf0VVbHTnqBc7TVJMS5?=
 =?us-ascii?Q?CILhMeIZvz1+ru/k1S8DGx3a8rIpBDt9FwAHYlgkYOUa9BjBV0sE9m44j9hk?=
 =?us-ascii?Q?rdx4P5aotqER2Bgj/tRwlsX5kTnpkw+1lLQrTSpV9LUyFJhpxM9oGB9MFkBD?=
 =?us-ascii?Q?tvlhqkPbIMo6N3mWu+0AgYD1WpLR2Otj/y225Jou8+FmtLVu8Vm/rrvRz51M?=
 =?us-ascii?Q?WZQ6aXuAhq+xFJ3xYc/3AlDcmKV3MFM9IB+VC1u6hzAYyragFgX0CryB8wwa?=
 =?us-ascii?Q?R4hHYd8Wt/kgnLHQ9vIFOsCqzUWOSLRyb24g/fuK3gas7q8SXw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a727b88-a99c-4602-5008-08d958a6b8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 06:52:13.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQiDZ7bW+faRBzDsbm9Ge9ML5QeVWNm1ytnBVKV+juYwIltfDGz9+eEGThL54qA9zSkLSx2Gp3NhtP4OxpY8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6777
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/06 15:38, Hannes Reinecke wrote:=0A=
> On 8/6/21 7:11 AM, Damien Le Moal wrote:=0A=
>> The BFQ scheduler and ioprio_check_cap() both assume that the RT=0A=
>> priority class (IOPRIO_CLASS_RT) can have up to 8 different priority=0A=
>> levels. This is controlled using the macro IOPRIO_BE_NR, which is badly=
=0A=
>> named as the number of levels applies to the RT class.=0A=
>>=0A=
>> Rename IOPRIO_BE_NR to the class independent IOPRIO_NR_LEVELS to make=0A=
>> things clear.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>   block/bfq-iosched.c         | 8 ++++----=0A=
>>   block/bfq-iosched.h         | 4 ++--=0A=
>>   block/bfq-wf2q.c            | 6 +++---=0A=
>>   block/ioprio.c              | 3 +--=0A=
>>   fs/f2fs/sysfs.c             | 2 +-=0A=
>>   include/uapi/linux/ioprio.h | 4 ++--=0A=
>>   6 files changed, 13 insertions(+), 14 deletions(-)=0A=
>>=0A=
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c=0A=
>> index 1f38d75524ae..d5824cab34d7 100644=0A=
>> --- a/block/bfq-iosched.c=0A=
>> +++ b/block/bfq-iosched.c=0A=
>> @@ -2505,7 +2505,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd=
,=0A=
>>   	int i, j;=0A=
>>   =0A=
>>   	for (i =3D 0; i < 2; i++)=0A=
>> -		for (j =3D 0; j < IOPRIO_BE_NR; j++)=0A=
>> +		for (j =3D 0; j < IOPRIO_NR_LEVELS; j++)=0A=
>>   			if (bfqg->async_bfqq[i][j])=0A=
>>   				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);=0A=
>>   	if (bfqg->async_idle_bfqq)=0A=
>> @@ -5290,10 +5290,10 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq,=
 struct bfq_io_cq *bic)=0A=
>>   		break;=0A=
>>   	}=0A=
>>   =0A=
>> -	if (bfqq->new_ioprio >=3D IOPRIO_BE_NR) {=0A=
>> +	if (bfqq->new_ioprio >=3D IOPRIO_NR_LEVELS) {=0A=
>>   		pr_crit("bfq_set_next_ioprio_data: new_ioprio %d\n",=0A=
>>   			bfqq->new_ioprio);=0A=
>> -		bfqq->new_ioprio =3D IOPRIO_BE_NR - 1;=0A=
>> +		bfqq->new_ioprio =3D IOPRIO_NR_LEVELS - 1;=0A=
>>   	}=0A=
>>   =0A=
>>   	bfqq->entity.new_weight =3D bfq_ioprio_to_weight(bfqq->new_ioprio);=
=0A=
>> @@ -6822,7 +6822,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, s=
truct bfq_group *bfqg)=0A=
>>   	int i, j;=0A=
>>   =0A=
>>   	for (i =3D 0; i < 2; i++)=0A=
>> -		for (j =3D 0; j < IOPRIO_BE_NR; j++)=0A=
>> +		for (j =3D 0; j < IOPRIO_NR_LEVELS; j++)=0A=
>>   			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);=0A=
>>   =0A=
>>   	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);=0A=
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h=0A=
>> index 99c2a3cb081e..385e28a843d1 100644=0A=
>> --- a/block/bfq-iosched.h=0A=
>> +++ b/block/bfq-iosched.h=0A=
>> @@ -931,7 +931,7 @@ struct bfq_group {=0A=
>>   =0A=
>>   	void *bfqd;=0A=
>>   =0A=
>> -	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];=0A=
>> +	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];=0A=
>>   	struct bfq_queue *async_idle_bfqq;=0A=
>>   =0A=
>>   	struct bfq_entity *my_entity;=0A=
>> @@ -948,7 +948,7 @@ struct bfq_group {=0A=
>>   	struct bfq_entity entity;=0A=
>>   	struct bfq_sched_data sched_data;=0A=
>>   =0A=
>> -	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];=0A=
>> +	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];=0A=
>>   	struct bfq_queue *async_idle_bfqq;=0A=
>>   =0A=
>>   	struct rb_root rq_pos_tree;=0A=
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c=0A=
>> index 7a462df71f68..b74cc0da118e 100644=0A=
>> --- a/block/bfq-wf2q.c=0A=
>> +++ b/block/bfq-wf2q.c=0A=
>> @@ -505,7 +505,7 @@ static void bfq_active_insert(struct bfq_service_tre=
e *st,=0A=
>>    */=0A=
>>   unsigned short bfq_ioprio_to_weight(int ioprio)=0A=
>>   {=0A=
>> -	return (IOPRIO_BE_NR - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;=0A=
>> +	return (IOPRIO_NR_LEVELS - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;=0A=
>>   }=0A=
>>   =0A=
>>   /**=0A=
>> @@ -514,12 +514,12 @@ unsigned short bfq_ioprio_to_weight(int ioprio)=0A=
>>    *=0A=
>>    * To preserve as much as possible the old only-ioprio user interface,=
=0A=
>>    * 0 is used as an escape ioprio value for weights (numerically) equal=
 or=0A=
>> - * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.=0A=
>> + * larger than IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF.=0A=
>>    */=0A=
>>   static unsigned short bfq_weight_to_ioprio(int weight)=0A=
>>   {=0A=
>>   	return max_t(int, 0,=0A=
>> -		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);=0A=
>> +		     IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF - weight);=0A=
>>   }=0A=
>>   =0A=
>>   static void bfq_get_entity(struct bfq_entity *entity)=0A=
>> diff --git a/block/ioprio.c b/block/ioprio.c=0A=
>> index bee628f9f1b2..ca6b136c5586 100644=0A=
>> --- a/block/ioprio.c=0A=
>> +++ b/block/ioprio.c=0A=
>> @@ -74,9 +74,8 @@ int ioprio_check_cap(int ioprio)=0A=
>>   			fallthrough;=0A=
>>   			/* rt has prio field too */=0A=
>>   		case IOPRIO_CLASS_BE:=0A=
>> -			if (data >=3D IOPRIO_BE_NR || data < 0)=0A=
>> +			if (data >=3D IOPRIO_NR_LEVELS || data < 0)=0A=
>>   				return -EINVAL;=0A=
>> -=0A=
>>   			break;=0A=
>>   		case IOPRIO_CLASS_IDLE:=0A=
>>   			break;=0A=
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c=0A=
>> index 6642246206bd..daad532a4e2b 100644=0A=
>> --- a/fs/f2fs/sysfs.c=0A=
>> +++ b/fs/f2fs/sysfs.c=0A=
>> @@ -378,7 +378,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,=0A=
>>   		ret =3D kstrtol(name, 10, &data);=0A=
>>   		if (ret)=0A=
>>   			return ret;=0A=
>> -		if (data >=3D IOPRIO_BE_NR || data < 0)=0A=
>> +		if (data >=3D IOPRIO_NR_LEVELS || data < 0)=0A=
>>   			return -EINVAL;=0A=
>>   =0A=
>>   		cprc->ckpt_thread_ioprio =3D IOPRIO_PRIO_VALUE(class, data);=0A=
>> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h=
=0A=
>> index abc40965aa96..b9d48744dacb 100644=0A=
>> --- a/include/uapi/linux/ioprio.h=0A=
>> +++ b/include/uapi/linux/ioprio.h=0A=
>> @@ -31,9 +31,9 @@ enum {=0A=
>>   };=0A=
>>   =0A=
>>   /*=0A=
>> - * 8 best effort priority levels are supported=0A=
>> + * The RT an BE priority classes support up to 8 priority levels.=0A=
> =0A=
> This sentence no verb :-)=0A=
=0A=
Hu ? "support" is a verb (to support). It is a noun too, but here, I use th=
e verb :)=0A=
=0A=
There is a typo though: s/an/and=0A=
=0A=
"The RT and BE priority classes support up to 8 priority levels."=0A=
=0A=
Arg... Sending v3 :)=0A=
=0A=
> (maybe 'The RT class is an BE priority ...'?)=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
