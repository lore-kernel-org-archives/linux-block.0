Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA8EC4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 22:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE33260C41
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 22:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhHBWut (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:50:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37726 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWus (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 18:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627944638; x=1659480638;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eAECxEoj/Vo0YHFA03RAmRRMKGeyNqeOV7IpRUsZFmE=;
  b=gGDX61BBqWLWQq4lnPD7vnMdVHyaF+BPraignmZOOfdSlwoCukQHUVs1
   v1Usa78yVcStbRzQVLZ+D+VN9SGQfnk/AwRWJaVNcolw4Gsvl1aGKUmj4
   1IDov90omPSLWPHmsbLYQqDs9qxDG+j2ot+i8BnL5d6Ew35Cua7fMmvfM
   T9k7I5opxNS2sQWD6CUZv0m067bujYSLJk/FRuGAEC3Wnxug4ROX/aqNp
   8Pae8UfUCioXbE0YivMyqMmvNm8PM3VKjJEP2wtj1BF8VP2bXBp7C8nti
   QmRaS093IZS0mmqG7qjwI0ElFpCPckGP3IElcmd/HARjmIBdOB/hz8RO9
   g==;
X-IronPort-AV: E=Sophos;i="5.84,290,1620662400"; 
   d="scan'208";a="287699691"
Received: from mail-bn8nam08lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2021 06:50:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbRS3thWc6/vaLiV0z2FzM+9kq+4HwvmO5hofIe2PLM65+sZbbaikHZsTxztxzirzLGHGLUiaCV6F0ZFYNXstpRKdQZnoSaxDEt7VTS6ejWOABGiFjdRvYBEXi5uQu6wqIGoihNR2eAIbqIHc825g/cD1MQEqNlrvtdYZFPue+UMrRS4tA5PLitxST7dGP3np72+A1uHxExOwanFm6IeOFooZ3h11wlTEVxziaLK266hwnYIMNL+9dQb0abju8sFyHGdBsS7RgX5K9lFdUoiM1BVhz0jcOqP4X1MgcDRgexQRwZdxZ2cdDOb/1I0ECrpgKp+JGe17f9Xg1W78mH/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbE1ZYnaS/dUSD/tvQf+GooVMAdffaVMeez3Isk+GC8=;
 b=mWT2OafyWvzLsWYknhUZPboJR97wQshed4kmrTlrcgM1sR6gA2o+M3fnVsgPO+ySBdpXdfdMi4LUsxykLGbvlkgvQgkgMYo8ZRppw22BhyntUWEdAeRce0hvIu+I5Vq8IF7vL49IN3vRf+SPRGGIEOpaHZKV8uUJ9QjayZWSEBC6UfEs7SgGBOL463Zc0O52tPUvx4FU4okWb/AxEUBSlUh2xtf3ElFa4c3+gisTNKmSK1J9tFSDuRLy+G8Gp9sxxMuqgIPi1OjUR20TMnGsEBc1XqfsG3T90JsCOAlfYgfXT/3Svd5TLIldFwuW2M05a285Yllh+leVc/SGnuCimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbE1ZYnaS/dUSD/tvQf+GooVMAdffaVMeez3Isk+GC8=;
 b=NTyHlaxDibJgMQsC41I0tFbPu87JlvB0hdkA6seGx5A3cUOIAZda9+TzNFwR5i9ClK0I9rnK6XzqZdMDL6zWZ1Nr+UZmJ4BNfa2yRveJ5Y3e1HM4AZnvB07i3QMA7ZhzOtxTqV1Tqa7om4VA0MfbszxJvJtEUgyMIFiCZ1QSI/0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1244.namprd04.prod.outlook.com (2603:10b6:4:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 2 Aug
 2021 22:50:33 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%9]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 22:50:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 3/3] block: rename IOPRIO_BE_NR
Thread-Topic: [PATCH 3/3] block: rename IOPRIO_BE_NR
Thread-Index: AQHXh3/cLKlup6J7Lk6qGqisveHrrw==
Date:   Mon, 2 Aug 2021 22:50:32 +0000
Message-ID: <DM6PR04MB70811665FE53CA699CA331CDE7EF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210802092157.1260445-1-damien.lemoal@wdc.com>
 <20210802092157.1260445-4-damien.lemoal@wdc.com>
 <3a204840-d398-18da-7444-a7f0c2fb1ab2@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e513b722-1e34-4fe2-d3fd-08d95607ef69
x-ms-traffictypediagnostic: DM5PR04MB1244:
x-microsoft-antispam-prvs: <DM5PR04MB1244BE8D46764FCCAE3BF364E7EF9@DM5PR04MB1244.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZE13JsQ1jMZqqKnTWB041Hl6CCKXw1icuDcAg0y5Jm1/tVOwDSUEHcTzbNzVPDXoJ489ivMW9WC0F1FruzjG4bzXGeryIVGMITFvL/1PpLieknBAXCja+ytEG342K+L/oqmufxfkzBsv2haJR6xrTOClV7rGCMfIrW8246P4fuLp52+BSBgkDISe/ZXSWBSiZBXPCnedkBkNfDbNArdmIU8dqbzpGikz/v6DpECTDAtCJW23bbxXQQ5GLb5RWvZbEJPlAAe03/bmWctdbrdE8Pxf2RR1Wcy+mDEPCAn9DRcnJ28M4tp+LYoWYhDcqzyyaqGHjqt1du9RvSzxaoLDAOwtVJyKawrtzA1aElPxH9NNf+CfDFiUD+gzdhNAhktPrgWc2zN5FtBx1qiIuK0WUWjNBh95KnyuaXCXK0ckhPiBF6xRmdo4t2+lRJHwPLjD/5XMK5stlx1TgKAfYHP5PoUxtDRai6l6Gbg1ElyyrDIYdCHGuSqgxUtjJmIKI3rkAGEKaVxdmsqJgfiVrHMr5MR/DTR7gm/DUpKIXuq+2aFjP634wima6TIy+Sn0SmzvFpPMJN9r0zIIcGetwqu8W8tyhcobYl214SEkAnEmkNFL5x8I5+H10yLwe8QoglRbTRbpI35f0Qux/5PaINLy16m296FTfl3wg8fvds6naeVXmeXfdDpJSmdRELIjQJ+E7gGkGjq2abgEMUuEDNo5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(110136005)(52536014)(83380400001)(9686003)(26005)(64756008)(2906002)(7696005)(38070700005)(66946007)(186003)(66446008)(5660300002)(8676002)(71200400001)(53546011)(6506007)(508600001)(38100700002)(66556008)(76116006)(66476007)(33656002)(122000001)(91956017)(8936002)(55016002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dpJPZ0Owsp+OA0d/5nAzV/hnB8bztFCNp8cwSQ5VPjkcmLjsU7yNs5Jm1jMp?=
 =?us-ascii?Q?P9iSSOFSO4uLY5MAVmCJdDAyhq1PtcMv3M36twXlQSF7GH3P8B7U9iD5ak/+?=
 =?us-ascii?Q?CWzKzglA5Qv45bxyfR+6pJHcO+73tSY49UjPGecDRogv3AkTEDkNjLe7iMxT?=
 =?us-ascii?Q?J5nFB1fDpf18fp86h+P9sslYmiONA4/bpsLclJk4pVRUkzPZujjGQYQe/eMJ?=
 =?us-ascii?Q?QAGKykjLNIrT3EyRaK8lpf03fPSazuORBtXcBC7qwPYRJLF5qU81RVK6Y0YW?=
 =?us-ascii?Q?qLKcVhRO0bVojW6kfXwRpzKknI57WRSN+v32QkJ8STEQJ5M8p0yJ88RgAbTd?=
 =?us-ascii?Q?HXWSZYntAyrnIVzRMqEDovCOMAN5QdNZ+dgzA+Uk+yzAsBUWo49SlfjpCXfQ?=
 =?us-ascii?Q?NYnvqN50HN3IAndBgjX0KLQsUndttlBJq72t3vVx/lLvuRvntBJWSSPPKcY1?=
 =?us-ascii?Q?EUaKIASL9f368eQTWZvk1YIzeJ6m5aWa+VPl14pKOimDm6wCBWdfv1AP/a+D?=
 =?us-ascii?Q?GTQyLqfrba3UnudrCKo40RvfHRyABfxZPyDsAUPXpYitaw0nJLsoHwfoLe4y?=
 =?us-ascii?Q?0Oo5WA27CrltPE7z0XDe6WjORMoUCIbGRSd6TdbUlFqDQSfZiOasOOx87q4N?=
 =?us-ascii?Q?JJJ5JPnS/PSJ3H/xa/xjSZkPCY57oNG7NV5wpJ9cL3sdjb51Bs+nec75IOl6?=
 =?us-ascii?Q?8LS6ylRSOlIt+xeQzm9ChINmeIL7xaG6IDi+hUPsqV4eynoc2STrWJ9G6awj?=
 =?us-ascii?Q?4kAL38aiOZOwbkDhS7d4CMAnieJdb+vOy31Po81u8ix5v9jLDVx7678FZw4a?=
 =?us-ascii?Q?E5/MYi2+yMN8geXxr4NU48ALWEVxp+S4nufMXuLWQflt/K9Ke5GQ3aVkzgVp?=
 =?us-ascii?Q?tALHFMIkBmrleISX/pC1kD73S//WLD2C1zCkkO9dY5jEIBgLR+mIBWLSzFer?=
 =?us-ascii?Q?2U7i0MjqsaG8pXKisHk2uAOf+mAeGIxQknX74F0S9fQX0lvrla0A5BXMUhff?=
 =?us-ascii?Q?ymDKScHgZUeItMd0/69nYeT9XVMGaQLvLi6k/6pdI9Uq7af8kbKv/1bTlRmT?=
 =?us-ascii?Q?0XH4+rPBJOi6J4Hrv1VFW8GllWUmxAI+QyvpG6nAKHEw8hhXR1drTal6rTaw?=
 =?us-ascii?Q?zAQhBXOZuUMyxLwvahGtElwqX1Uk5mny1Gx43Oiu0eVMjzGQ+1aTxXQygloo?=
 =?us-ascii?Q?8f57MA8xJcHCiESvI6uyUM6/s3km57E/GAlMvQ4DSHX1IAKnY1rQO3oRu1RW?=
 =?us-ascii?Q?Mq1SSkUT69RfR9QqOShnTm9uVLX3TStEaw6BlUaz5qDmwWzueCBRqvgLJxX1?=
 =?us-ascii?Q?xYMn5pBLkaW3FRgghYJ1k4DyonNJuUo2JfiX5pUV2HK4XA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e513b722-1e34-4fe2-d3fd-08d95607ef69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 22:50:32.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +A03/2hYFmCbeBMnMGl/AvQ2i1m9qTQq22/TmbVRqgCop8b9oxNZWzd8lDXBOzjRNtxbeBJE36ihC2/gIBdGcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1244
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/03 0:56, Bart Van Assche wrote:=0A=
> On 8/2/21 2:21 AM, Damien Le Moal wrote:=0A=
>>   /*=0A=
>> - * 8 best effort priority levels are supported=0A=
>> + * The RT an BE priority classes support up to 8 priority levels.=0A=
>>    */=0A=
>> -#define IOPRIO_BE_NR	(8)=0A=
>> +#define IOPRIO_NR_LEVELS	(8)=0A=
> =0A=
> Is this kind of change acceptable in a UAPI header? Can this change =0A=
> break the build of user space applications?=0A=
=0A=
These definitions moving to a uapi header is new in 5.15. So they are not=
=0A=
currently in an uapi header. This is our chance to clean things up.=0A=
=0A=
> =0A=
> If this change is acceptable, how about the name IOPRIO_NR_BE_LEVELS? =0A=
> Additionally, please leave out the parentheses since these are not =0A=
> necessary.=0A=
=0A=
As the commit message mentions, the 8 possible priority levels are used for=
 the=0A=
RT class too. So it is not just about the BE class. That is why I would pre=
fer=0A=
removing "BE" from the macro name. Or, we need 2 macro: IOPRIO_NR_BE_LEVELS=
 and=0A=
IOPRIO_NR_RT_LEVELS. But that will only force adding duplicated checks in=
=0A=
functions like ioprio_check_cap().=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
