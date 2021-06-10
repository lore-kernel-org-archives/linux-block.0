Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B69C48BCF
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9963F6136D
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhFJAbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 20:31:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51309 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJAbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 20:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623284959; x=1654820959;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3opGxkwKNTqQ0rqQmlF3br2/d+3MHgSMzQBarqapKPM=;
  b=VAfOuuogMepRKD8r11D0Lj15kuGqLe+q8faDuXMpBdlQohSGEgmHNSAN
   WJuORmB8Z2GC+pQL8UYVyHOFp8t2DfP+VgEraFMr6m3kZwsGUyQTWRv7v
   0uRj+fKBDOZZxmn8YJwHd8RcoiA9aGUoCotFHEczdEE46zC62759Q95oS
   4IhDbd0534AWzYDX1XMNA+PnKVvyuba2W86C5C1EbfRz91qSZgwxf8ffu
   v0EsIUgL8ZGAaIjX+Tf822LzLA8qLR4Id2wP1l2WKqSyDJS29TzFHxJjw
   mRMTryvJ7yjHDQ5GpamwRJkQQaNsmorL54p6nV6EHaUMBxqFxyikuRSr9
   Q==;
IronPort-SDR: lrpzuN4lu8z/5kzxMDijfbYcBcQso9EZ3c41WhXRuHJJ8aGEzapCko9HdKsb6Wka9xi9Fu8VhR
 k7fNM1TXTfOhK2sISatAiRF7WBRGOFk5PkPmgxgkGsAmaHkVb1xoTc10tlHgxVS5RR1GWkRW6r
 sqceboUAp4VKDyxu+akAZbHyxn2mOUlUacgYJ1AwOfB1JQQj7AfTAc3IrFDrz+lBrcUcPy3FMt
 FkghShzGEDI4oTN7OlM9TpCRN2ZM13uGwr6SpGKBDZfzKtzwXboiJi8IeOMhBXMJRPe5i1ak89
 S6I=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="171375750"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 08:29:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsOgYeThLqAfwFzgvRo1lR0b+Bq46OJe//yJIsxgcuo2cy15HRDDhsAa64kIqDl5H1xsXyGH8Gqi2Sa/jh+6rtrROxsRatEtX43A2nDjhmNgTuQVH2thHF/5ayPYtWJloIq0rdywHcweoIlM0AMo+DcDY8bxWivLOUCnmgR1QM7fJ4piCgPrqmPlTNvj8A74QJxcLOON3gGFAwXWUpXs9oEbc+/rtndoJEWHo2jBggItK1f2bBugkd/rjRvn3jjnvEJ2QNjKADgJb/c9xM9pLhq8J72woGJqYqaIHbII4/N/umS2lSh7PGgFnEb+RMmYEQmZKCj6IgeWA1GBW/RS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxtGdNaC1bz89P3g4FuxKHS94qIWldWU5yROQv36E6w=;
 b=eHFajqZNYZDA5fBfy+V5zZee11Nx2+rRmawdI8WA+ZOPnAW/bWyTSCEjs/xzxBjn0/fTxcnBNQ3Q76jp6vzoyu4ykaE6fc7BUYPGIIj6BXx29zm0q+epmSjoLdTPvjedqB+BvGE0iK6rEuuglnIloumg0HxWx8aYWqBoYoLpSE5oDJ01EzMRyW6V/CNgOsx4GbEXWmkEJ17tipIhYf2biFz6r7eoIbInhKXbAnMeoMkI3s/2tfmyYGUJl/XqHuiGdfdrGd4rdkTGRQJnY0kawBkBAwTe8+f9AU1nzq4DWlCDhL6YVmHrJZZ1xOL4+KfdnJ5l77Zo9TtF8gQv7iEMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxtGdNaC1bz89P3g4FuxKHS94qIWldWU5yROQv36E6w=;
 b=hIWezurfYfq2eW2ZxPyv0td3w0fDx2iTtoqw/Anf3AEUO2lD1eiAuQ2wl/jT5jmiDfUDLpo4KAIteMDTpHsbXNqyrYAhetUYjI57o6xIe2Gl3UzHPPU+ZSDYIcrvAlsYKC1/JUkhuNpY2om3Z/qzuxHByF5vdZwPJ0l/hhNm+k4=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4348.namprd04.prod.outlook.com (2603:10b6:5:9a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 00:29:17 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 00:29:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 04/14] block: Introduce the ioprio rq-qos policy
Thread-Topic: [PATCH 04/14] block: Introduce the ioprio rq-qos policy
Thread-Index: AQHXXLsKSREg/Ans2U2BHuooV0bmLg==
Date:   Thu, 10 Jun 2021 00:29:17 +0000
Message-ID: <DM6PR04MB7081960D31CBB02438C29D27E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-5-bvanassche@acm.org>
 <DM6PR04MB708135D0C71D2042E6674E23E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
 <98dbb3dc-d925-f2a8-7f34-94f9c56bb257@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 137713d2-f708-4da5-1064-08d92ba6c88c
x-ms-traffictypediagnostic: DM6PR04MB4348:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4348F6A71B8D53E4D3508D9FE7359@DM6PR04MB4348.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w15tV1CfqtKI7lTtNQN6ki9UiVgBQW1IdBgkUCrkWA+9bsjNXP1chP6vFnDonrkupYIgpYwVbxYEZiRQa0k7OMH0Ynk4Gx71yjUWqYHhTrkJ7CCPGxLIfk0xNGYHQCzMrfdXZOXiHn/F1YY1px5Tba0xcc3VuzgzzxdfcGhmy1VK5y/xHVxQGDCRDChT/QL3DyFzNCDMdoJQ7xRIhuq0d/K7dhNpP8MLpMiL3Yyh0qDHHu8hA6wd3re+OzVAX7ZEdQiTY8A/iVe2ufVH+c6LGksRPTp7Y45ImDi2Al/1mPL/ThpLye8mXfDd6Tb2CBynWG1+Orvznb2svtBypCv6plt/kxsmzMYSkrRHivEg/IB7NuI9Q+QFtYFTnOJOpngRCJi1MDPKo3wvqWIWUTDZI8MgpvFMqmBUWV7PkHrx+KLivSRxJwmh1NOivU6sLys0xO3HdgCBMlgeAzivDL5uBRt8S+iqR5KfMxP3hxJGc2pHdSc03nUk2IKiijuzh+CERt/IwHIn02PtPLfB5Yig+EhfMQLq/IM5JEpUyk4q2Lcx2SQADQn7udfFwlXvqSSco89klS9wYeswny2+y0RMdy6nBGiNQEEJzLJeRmmR4QI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(26005)(55016002)(53546011)(6506007)(54906003)(110136005)(83380400001)(122000001)(8676002)(38100700002)(7696005)(71200400001)(316002)(186003)(66556008)(91956017)(64756008)(66446008)(66946007)(66476007)(76116006)(86362001)(52536014)(33656002)(478600001)(5660300002)(8936002)(9686003)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b3VCTdVXGoR3jwKFpoS/J9y1Zx59pbn7QcikPWtHldWWewTmYx0/hRqELeA1?=
 =?us-ascii?Q?r2/G3YnAYxXxuKYY3dZXpVogXzDG7PVMj0/F9b4smy6DHS9PHlQE+XTzjqvd?=
 =?us-ascii?Q?40Tr8OtpblVHALjTYoOerZ9gS+ul78pOjPqaOXj3fiNPp+ayOPJq73DYg4wi?=
 =?us-ascii?Q?DxNuYRTNmFrfn/ESfHTLeYDe8v5puyeCK2+Hvd6JWXqBCAejnZtQhvEqGLSu?=
 =?us-ascii?Q?H/Da2gOrIXS9Jnhflo2VOkV3UE/03Frs9t9+7SqgVip34lRCLuBjfssevStH?=
 =?us-ascii?Q?HNAeCs/C75mAEpWWyBThbMwm4YZFcBRAJ2JBZZh7Y7twtHY7iuPzkCtjeJG7?=
 =?us-ascii?Q?E9EN0LPA345ofv297sOeSOviPm6kZD4BGK2AzMQrfXnKkKfQyuh8lN/9SvrH?=
 =?us-ascii?Q?L6741hzpAC6g8yFuDQ4YTBMoNwB9yFHeOh0qa0b50FHZz6a5oJbOrkXVuQg5?=
 =?us-ascii?Q?VHjvUlEiuzqfCEyDBkqZ3WWjrsSjM4GxCDIW+c55RVzNGplnz8sewpqTstEo?=
 =?us-ascii?Q?2b+fGNGYNnHTyuhBkMU4HapXrqDZz0RcYq07Gh/zaHBNx/athCdwkEp2tA5Z?=
 =?us-ascii?Q?Nfph8JK/x7cPMogBXz1tuQLrKbhgQB/YfjvmPduAKBU8CVxYYmTEtJxoe9du?=
 =?us-ascii?Q?AlWTBOXbOjBDbO4SDClBmjdEu74o43goXrewxajU2uaBsAovNPkwX+ZIUWji?=
 =?us-ascii?Q?wRbx6s6eHctDvogL3A8ofphHCrJZIGYPEVVTbyurjEJn/4LTaQLtd0jmQwzv?=
 =?us-ascii?Q?K28pkaD+e21wY/xwrz09tj0PujioE2PoQ9cunIsIDjDmbApq/Xe1x6sk9cJa?=
 =?us-ascii?Q?p27xLzR2o6qSDZ7hki584PebaDwt9smeK1UD1Co1QmomjhMowtoaM5TRPUp4?=
 =?us-ascii?Q?M6yEQ1N4S11iWhltUGfJKbCGFha9RbqnYvv7xHqZNQyMfh0x9CBwc58vxJja?=
 =?us-ascii?Q?DvHJWd5Lb/T/vW0bHNbf+ac4wrmpTcbekozCbMNLVGuq9xMJynTHWbmompBe?=
 =?us-ascii?Q?4K128H0ehEUCrkCGuk3TWnL8cozJ9l5yPHau94mkSvVcPxaFrlbYsc7q58Cf?=
 =?us-ascii?Q?HuGOiQ8KRjDgL/dliNlVBJ6gGXvcRwOqOUgxAlPe4AngAzvhuhh9ObLh+1AK?=
 =?us-ascii?Q?JG/ejvZ1HJBpoL+3Nq0ajQt8Ui4pncqzrL48kdEhP1+0e1QFwhmxfxqRpnQV?=
 =?us-ascii?Q?YrMn3SFLq1IVRMJ8JEGEwDCriVSwV3GpT+54z6EzEhQbDisG97eYeH2n0xuz?=
 =?us-ascii?Q?HOBWxF1Zu9v0OOdWsaCbSfizPElseRGyyoD5Ok1G8gJ2xll5KZzyPgvo0t0N?=
 =?us-ascii?Q?TwvH9GMZ+S6XAHL5zRHqr8no99t1J3S4pEOitAeynCZKLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137713d2-f708-4da5-1064-08d92ba6c88c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 00:29:17.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLsfw/9LJ22sP8yiQiC44jOUk04MY6ljnbAXoGEUGJYRy+iaY+FGmLOz8RuHAcuh2AFc8rqsSPBaCcSKszukeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4348
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/10 1:49, Bart Van Assche wrote:=0A=
> On 6/8/21 9:40 PM, Damien Le Moal wrote:=0A=
>> On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> =0A=
> [ ... ]=0A=
> =0A=
>>> +/*=0A=
>>> + * The accepted I/O priority values are 0..IOPRIO_CLASS_MAX(3). 0 (def=
ault)=0A=
>>> + * means do not modify the I/O priority. Values 1..3 are used to restr=
ict the=0A=
>>> + * I/O priority for a cgroup to the specified priority. See also=0A=
>>> + * <linux/ioprio.h>.=0A=
>>> + */=0A=
>>> +#define IOPRIO_CLASS_MAX IOPRIO_CLASS_IDLE=0A=
> =0A=
> [ ... ]=0A=
> =0A=
>>> +static int ioprio_set_prio_class(struct cgroup_subsys_state *css,=0A=
>>> +				 struct cftype *cft, u64 val)=0A=
>>> +{=0A=
>>> +	struct ioprio_blkcg *blkcg =3D ioprio_blkcg_from_css(css);=0A=
>>> +=0A=
>>> +	if (val > IOPRIO_CLASS_MAX)=0A=
>>> +		return -EINVAL;=0A=
>>=0A=
>> Where is IOPRIO_CLASS_MAX defined ? I do not see it.=0A=
> =0A=
> Near the start of the new block/blk-ioprio.c file.=0A=
=0A=
OK. I missed that. Shouldn't this definition be moved to include/linux/iopr=
io.h=0A=
? It can be added as the last entry of the class enum.=0A=
=0A=
> =0A=
>> Why not use ioprio_valid() ?=0A=
> =0A=
> The definition of that macro is as follows:=0A=
> =0A=
> #define ioprio_valid(mask)	\=0A=
> 	(IOPRIO_PRIO_CLASS((mask)) !=3D IOPRIO_CLASS_NONE)=0A=
> =0A=
> So that macro accepts I/O priority classes 1..7 while the above code=0A=
> accepts I/O priority classes 0..3. I think that ioprio_set_prio_class()=
=0A=
> should only accept I/O priority class values 0..3.=0A=
=0A=
Yes. I misread this macro definition. The name is actually confusing. It do=
es=0A=
not check that the ioprio is valid, it only check that it is not NONE, mean=
ing=0A=
that something is set, but that something may not be valid. We could probab=
ly=0A=
turn this macro into an inline function that does a better job at checking =
that=0A=
valid values are in the "mask" argument, which by the way is also badly nam=
ed,=0A=
since that is not a mask at all, but an ioprio.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
