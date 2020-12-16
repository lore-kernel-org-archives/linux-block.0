Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3FDC2BBCA
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 03:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB5323381
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 03:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgLPDoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 22:44:39 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16180 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPDoi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 22:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608090277; x=1639626277;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DW4f2fyXiCJELTsA2zBQXQApWxpVEv0M/sZ4CQngVic=;
  b=qMYKMFsDXoUgtVwJZY+qCIn1vScUKDOv0+ar2bW41NDTLmCVQvFnldBo
   Hucs6RcXthT7LCW5EMqSnUptmBUWp/0n3B9v6dSkCOCXcPKcatOWSo4wT
   JeFFljlsi16/FnAgzQns1sXg6Wy07zj/SjW3WuCgtuiJqGxvJenZck+N3
   vGjrSbeT1rYma9i0h6jt6jElV1edWjWseHfndFWrjHLwwhi9whxBMdf5p
   2wydvl9w7QSgu2fEujXP2rofMsLf9P4fdBCXt4GWogEqk30RV/TQEOWAI
   X+icEKjLnJ2FLSIxYybQp07Nl7+7RWPRVFFuCSdhFeSb6E9RPncidTFgR
   g==;
IronPort-SDR: ZNDX7PZdHJZRnLfAssX1mumaSLxxFfDPvLI8s2+KKV8+x2k2LLPNcIZlYzmo6K22YC78EX9P/l
 q39O3YhQbZSythy3Tr/YLeRK0vuFA4tWCk3t+LTTlD4iObPOIloImiNU7n1mCDa4Wedd/W1g45
 XwykwKhZg6F7F8715Ou/Wsj3evP10o9+znZAVkjYcXyX5yQN+YeR6uiRJrHJenGdxQW6r1njdP
 cLav9zUQ3VLl68eLgBRNZ841oh1W8gEnBXE8ckRa2sYy5VWxfuNZ8Yvy+PlzsmUrGjOFW/SDCY
 dzg=
X-IronPort-AV: E=Sophos;i="5.78,423,1599494400"; 
   d="scan'208";a="265449163"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2020 11:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asUwzi/JXngmtcEKZqQH8NhxCDWhfOZedvMbjD3sZ3NX20kigbuKKFgGn0VrbpVUVnBDCtq1mScuBZlFvzaB50sw5QFidwCelQ0Yy1SzskoM9hue4z9G8hi1pbIq59odOg6Dv+vok6CYo06bPppXtqdT34AsXV0eJPbv9YC9fLSaKzreu4UF+NgyZuEYs4SnyXtIgVZwRRmhnAZ0ti0uaCGs7fC7REI8VPE2A9JVtgl1cAYMQtbh4CkIz4XNlw7n05S/4DY4lSox1QPttxlYGa/q3f7YjGPDTX+7mAEPiXGRr1JZ4D3AemzVIOeJWWEj0trJkAvs1OssqyVRyN7EdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYw3XsxCKLSE5GWb8uHzowCArHClkbB44dVY0v57BB8=;
 b=Rkd/JBbAAwejtw4Y/kWPhauJiwz9AVxhuu7LbF+pmhpwyhHMBujFjT36YChKcPZwsJEaq3KRqw6EaY5BaFOJMYjQzaQ1M5ElScx6TamUzXe67chq63iG2CuGE2zczH4hxysTelhDDNe032UiZPYMxloOE/iWleeMXSEpWU+bEShd06Y4zT5v+/CgtjAvS2LcV3CIGfQaTeeaxWir0fkpiUAeZbwyfzNSh4FHt7SHeL2bYMQr559fCHwqPfgHo0TYJRJAr6KVWCkyoo80/W9lG+zrtXHLbJzS4cpp+pPlJlt7BLm18XjIR+E2owWzk+T1KnLvVtNEHTXczSRvoD5Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYw3XsxCKLSE5GWb8uHzowCArHClkbB44dVY0v57BB8=;
 b=mJa1Y8mPxvp210mPiPJ0hL4CLREjWhHc0NdOSpxRJFSreuAc+fcSuIUF3kZzqZ27fTlTuo3nKhpMzTwQqOmcXpGNDmKy/bY565Ai2T7jQ8Dc5Oyl0iscgh1Ccxfp7dezvuewttEow++CS6OAWG7mlA4wSPBEaDn4I84Uwqx+D4c=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6888.namprd04.prod.outlook.com (2603:10b6:610:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 03:43:31 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%6]) with mapi id 15.20.3654.026; Wed, 16 Dec 2020
 03:43:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0qgRFs/FzWenxk2tjrXm7qX1YQ==
Date:   Wed, 16 Dec 2020 03:43:31 +0000
Message-ID: <CH2PR04MB65223C252505792FEC4B8734E7C50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
 <20201215060305.28141-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522AC040C900B2574125884E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49659C0D80D3D3EA2F2D24E886C60@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CH2PR04MB6522763AB222AD6F6CBD3321E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49655C8106D1B958D12CBF5886C50@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:a1c8:1127:b41f:9459]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b3a947a-ec73-496b-4f4c-08d8a174c220
x-ms-traffictypediagnostic: CH2PR04MB6888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB688829F0150C20E42CBA50F4E7C50@CH2PR04MB6888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPeX1Tfeb3lK2ZA+KqAFR3eXQn142qKaqCeUnMK6bARpamRoCsJ21x7MufLdc1yb0PiK07g/zCLVNgaHFIeo7Qiwv968ia/zJfFEGQmhaisv8IbzNDMUt+7RqfgkvekhJOBozszkCnphMmeijwbfIZMCzYyCQIju07ecYXMaRmkLjX2uOymuj5W8HODU0ful5749+N6prYgMgXsGhx0cy9ssnsrt7yn8E3WFu2ZNnQ0SKI47EE7skZdctoLZX9qSr/xHG1O6vx3do3BglV9muLyMA909zGEMT0ktcaxb1l6fOsGDUYGIHVnyRpUtmV5vKF1XZxcFt7WJJfHJMzwNZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(8936002)(110136005)(54906003)(8676002)(5660300002)(55016002)(2906002)(66476007)(66446008)(64756008)(316002)(66556008)(33656002)(86362001)(4326008)(7696005)(9686003)(186003)(6506007)(71200400001)(52536014)(91956017)(53546011)(76116006)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bMA7iC7PQ1TS4d+7sCmY/mFk6Vrk1DwcFPNQPj0RiQks4JiNuuy6Kak03giE?=
 =?us-ascii?Q?R+QugyOma0vTEnIB6Ccdhe1rEpugw5pX7QY5CiXIQYhUmo1jQM4be0xukO74?=
 =?us-ascii?Q?nyOq1zVdDoTqj18qeuseENYXZR/eLk2EENV+0XHi+iodEkodw7YXsksmEkCz?=
 =?us-ascii?Q?ur6tGxJ+hHpm/xdmHMy4xrccDVVciTNrAMjKcoZoxr2cLmAd+52DXf/aMk5K?=
 =?us-ascii?Q?fsNBIYB287VqDa6m1IwNj4pKlTmBZsXVjqFCX0FGB7CRylv8PM8cNQmGCihq?=
 =?us-ascii?Q?/XiGT5nEJn/hJpHNHA+k5fxy9dWqg0niiFqbGIFU9kljG3nvQ2710k6Ej4Ns?=
 =?us-ascii?Q?z6snmvhjbAkr+70BKsDCOyRENJ4B945Yrb64wm308dq4BetenYIM95d9dSto?=
 =?us-ascii?Q?jmH5p0UkwnhpErnLwVkdQmWEUO2kUOaprA7We0kCpEaug5JoiFPP/32lJuTI?=
 =?us-ascii?Q?DvNJ8pqkG/VLm2cmkSfifzrF+3wvHnvL2pTIDTgFxIa6rtIDB0WbREYAJ/e6?=
 =?us-ascii?Q?29k03rUoR1KukI1lfR4oYMOFJUMqQN045sWu6nyVT+jfid07S17opwEsVctc?=
 =?us-ascii?Q?+k/wqmRv6WzltmuSz8sAWYj3sOs7QHZLWzzthBqhABp9BNE2eLuYUzh1o4Pu?=
 =?us-ascii?Q?ciIBU11vNFSmQPdatpJ3HBgU4U2zmYe28KCG5fl0sr3lYG3K9VR903rysXt8?=
 =?us-ascii?Q?ijc43gbuNCtoy6Aid7E7EA7Nbjj49FBLx9Eaxc8481ecwqW4wp7mYJaoNEVM?=
 =?us-ascii?Q?yLrJHRLziMbeala+c78lIxBChR9GYxOrKYvqQtve5CG6f6xGAe6vXzkY44XU?=
 =?us-ascii?Q?0EG5tdq1Ae+XnvGD/ikJv7FCIx0qJ1JBoM29IjLkhBlQpFC1t2EiRg/b38H3?=
 =?us-ascii?Q?MR/2zJHU7BJ2kNwesVKb0dD/V0Xa4uWExJ5UQGBfktJkHwlVkJ05QDEmzhQN?=
 =?us-ascii?Q?Ne0ctbmz8dgghNCMTEdR2hVzY6Q+RYKh1qYiCBD2Kon5Kgn+vCkk25QgvO9o?=
 =?us-ascii?Q?T8VcV5JnhxkL6LW6RJ27c3WD/XoD9XG893x0R+i65fPVrWhWssLO/KKA0WdP?=
 =?us-ascii?Q?QwOQs69H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3a947a-ec73-496b-4f4c-08d8a174c220
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 03:43:31.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DP0LipDKdvlJlEKPoQZnRpSEYFYLLwD1zj/k6R3k2xMdNO6V7P381Emg/RPVWsMExdbg5UDQmXG4ImSzcyY1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6888
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/16 12:13, Chaitanya Kulkarni wrote:=0A=
> On 12/15/20 15:13, Damien Le Moal wrote:=0A=
>> On 2020/12/16 8:06, Chaitanya Kulkarni wrote:=0A=
>> [...]=0A=
>>>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>>>>> +{=0A=
>>>>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);=
=0A=
>>>>> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
>>>>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
>>>>> +	unsigned int nr_zones;=0A=
>>>>> +	int reported_zones;=0A=
>>>>> +	u16 status;=0A=
>>>>> +=0A=
>>>>> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
>>>>> +			sizeof(struct nvme_zone_descriptor);=0A=
>>>> You could move this right before the vmalloc call since it is first us=
ed there.=0A=
>>> There are only three lines between the this and the vmalloc, does that=
=0A=
>>> really=0A=
>>> going to make any difference ?=0A=
>> It makes the code far easier to read and understand at a quick glance wi=
thout=0A=
>> having to go up and down reading to be reminded what nr_zones was. That =
also=0A=
>> would avoid changes to sneak in between these related statements, making=
 things=0A=
>> even harder to read.=0A=
>>=0A=
>> I personally like to think of code as a natural language text: if statem=
ents=0A=
>> related to each other are not grouped in a single paragraph, the text is=
 really=0A=
>> hard to understand...=0A=
>>=0A=
> hmmm, why can't we use a macro and like everywhere else in zns.c=0A=
> we can declare-init the nr_zones which will make nr_zones initialization=
=0A=
> uniform withall the code with a meaningful name.=0A=
> =0A=
> How about following (untested) ?=0A=
> =0A=
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
> index 149bc8ce7010..6c497b60cd98 100644=0A=
> --- a/drivers/nvme/target/zns.c=0A=
> +++ b/drivers/nvme/target/zns.c=0A=
> @@ -201,18 +201,19 @@ static int nvmet_bdev_report_zone_cb(struct=0A=
> blk_zone *z, unsigned int idx,=0A=
>         return 0;=0A=
>  }=0A=
>  =0A=
> +#define NVMET_NR_ZONES_FROM_BUFSIZE(bufsize) \=0A=
> +       ((bufsize - sizeof(struct nvme_zone_report)) / \=0A=
> +                       sizeof(struct nvme_zone_descriptor))=0A=
> +=0A=
>  void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>  {=0A=
>         sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);=
=0A=
>         u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
>         struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
> -       unsigned int nr_zones;=0A=
> +       unsigned int nr_zones =3D NVMET_NR_ZONES_FROM_BUFSIZE(bufsize);=
=0A=
=0A=
Hiding calculations in a macro does not help readability. And I do not see =
the=0A=
point since this is used in one place only. If you want to isolate the repo=
rt=0A=
buffer allocation & nr zones calculation, then something like what scsi doe=
s in=0A=
sd_zbc_alloc_report_buffer() (in drivers/scsi/sd_zbc.c) is in my opinion mu=
ch=0A=
cleaner.=0A=
=0A=
>         int reported_zones;=0A=
>         u16 status;=0A=
>  =0A=
> -       nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
> -                       sizeof(struct nvme_zone_descriptor);=0A=
> -=0A=
>         status =3D nvmet_bdev_zns_checks(req);=0A=
>         if (status)=0A=
>                 goto out;=0A=
> =0A=
>> -- Damien Le Moal Western Digital Research=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
