Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B228BC4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 11:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7D06322D
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 11:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhHPLn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 07:43:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26766 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhHPLnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 07:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629114203; x=1660650203;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gFi6zHOzojIsTTDQhlH+xl+THaEvieUajmIEg+QCof4=;
  b=SeauUJO8w+5rwWiyVjISGg/wE1GT18yaRRpJSm9k0SQCwx/UMg6G7VJy
   lJBqxPGX9gMIxGPCr0d04giPxRTtDsga6yvgPOIuMksLvIlD1ZfWjMCw5
   zIVXKjz9SUjNbWpHWKwEYY2yccsMY9tLqAJSVN8GEyY1AVRN+WoTUBNG4
   ZVYCF+g0mUNHaq9giotGTRf/vEfx7HgDdI+PhPh5YZ7yU8h8OsMza0G5s
   Ktl5k3eFGhq0UbiaFSUA/S27kP6K7rErQJNmaNF6P3TVOi/MY0pDXpUkB
   Rsa0vEPGeDwceuk+6YKKe4LkFctcwsXLNyu741ToF5h+ivn6Qx9DxzyY5
   A==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="182172430"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 19:43:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7UWmRvMNLLustvt5PtNpo3lfe2W54XlPiA+fTrl3L4eVp9xrr+haKeHxIJENX2Zo1MSObwandOkMXiIkrY10QJlQt0vWJD/kfsvhZ08UOlomOtjDsgJPfsyRIjE4jVKanEhGv4BOpj3yKTVakJzVprnkFd/zac4HubLgwQT7B2EgavSyB5S93pCKUT40OqTn9gpWt64hlfbSUltxAIrcYDcB+sljYYLruOtNuB6pInKDP0Dmfudxl93VyhIHbPvXBrgxdHS7Lk3Se7DIEqjM3Nmp21YLTdfFyBFan9qXUKyp15VMuxjG5qQeEiUi55NRm6hcxw7FXpoJVMd3VNHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQG/6DYXFQsdQ8mFgo2ZIQSf5DvreE6ljTxmmHX6MKI=;
 b=EdCdUJGojbwqKbKaQpw2iB5lc2Mzl7IiHbq8JlsEnRfmSTPRWN6V6Gchs79rPybREeG0eje1hEEKYxYQBfQxCI89pRGNC0bk3DjQHpMnt/nth2RVDaCMfzlniVUbO5CnH7uquHkW00Fai+R2R7HnrM9ZLNVvQLH0TfQEbcwqDV65C5Qe/xnRY3SA9NCyLYvPCPPmNr3J6ySySpXn4Tzv/xE4BlhjSRxPCw8GHaHU1FAQrY12PcB6rxVHv4cqlMDhUllWBOKo6CG0wUBtNkyksxWb9X3ftLB9qN1PJ5G0MTvI+ygXLrCGaXhYhP7fkIjK01WeT9PZdQJBocwOkP6VMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQG/6DYXFQsdQ8mFgo2ZIQSf5DvreE6ljTxmmHX6MKI=;
 b=SsnwyIItDyBYI2PYfNTGT+IXwuHYY+DAwPE4MFOcqtY7qc/fXPo6CDWT2esQSNgSCFppZASTOrDUNHt0oVewvyKT41jjzfMCfXl8iO5D5Sq3ibHLZCbelEN8awPg5pXszBY8X/HUHbk2iZxYkBjwy/Cgss+bA9GTHyv0HWrcKSE=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0813.namprd04.prod.outlook.com (2603:10b6:3:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 11:43:22 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 11:43:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v7 01/11] libata: fix ata_host_alloc_pinfo()
Thread-Topic: [PATCH v7 01/11] libata: fix ata_host_alloc_pinfo()
Thread-Index: AQHXkkBXssH+8ZiEJ0K5IgKqYwf2lQ==
Date:   Mon, 16 Aug 2021 11:43:22 +0000
Message-ID: <DM6PR04MB708163EABEE9CA6CAF62FAFFE7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
 <20210816014456.2191776-2-damien.lemoal@wdc.com>
 <ca7576c640d2c0bf2d80aef3098849d3c25311ff.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a3e1cba-1082-4a1e-f982-08d960ab0d1c
x-ms-traffictypediagnostic: DM5PR04MB0813:
x-microsoft-antispam-prvs: <DM5PR04MB0813868E0A96FBE92B9F1AC7E7FD9@DM5PR04MB0813.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59wesIac5xdaNxRXQh649XgcZ7BwrBTFzflVYSzggu1HVo/DG8NmCrQS/pYNG4fA++vKIo/Y+vUlDxrHbHYvDr68duyrQtiDPnR9vA3RaeG1EkWENlymU1OdJ0XBM1KcGS+ZBHqqxvCLCEaScQKSwLGLdfA28s7NU80ZtlLqeRJkUywswJoPQhR423MwQsqR/7kgDz0OnEOmNSWfTAnRK1+7RBXhcHb5UTBowxIecuCSA451vNiqk874NIlulEgC5/GU2pdNpbLNq+mY/Q1JKJwokIZKo7P79A30cz9XYRwxfRbm60MYquzptF+PSjKyJfIRquPy9br9D+qg6wW8g3rIm947XLOsCXcfZhNS81pqnlu7XhvMbzMGNH/GZOiIu8DlHsXSG5D09aFLip3uTjZ1woyuf58ibERkoUbh7YBL/C/UQ2x0e8k/+G2gF6peWlcjyFbX12yLMXtGQv4k/dewYlrDlihE/5CurgdE/HgEG2UjT1vZlwbeS9icfTn8ZaEbLAlKBsuEEpalvxN1mV+9VKFBzLS2o80PRDfwE7KgkhMaQFrLN7RQtQu/KU01p7oQyACXNLW89tNgcNSq6pJc+RADH/hBTRW7As5fxQlXTv+IHvZ2o3F8HD9U9wZL/N5N89XCOtGl5iOuEoLmb24xnTlNLaCoDg6HFjLWm/RvqjkYeBkaV5m4zXyswTdPUS23JxLpzIfKJmYZIs98hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8936002)(7696005)(2906002)(83380400001)(66476007)(52536014)(110136005)(86362001)(8676002)(53546011)(55016002)(76116006)(91956017)(38070700005)(508600001)(38100700002)(122000001)(64756008)(66556008)(9686003)(33656002)(6506007)(66446008)(186003)(4326008)(5660300002)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EIITvVeowuuCmZN4feF+epQVSqD9EQU3QIy1ZYUtPahkxF7FSI3rQ3wmON4c?=
 =?us-ascii?Q?vuAF5eWeaTCe6d0ApUTGCwEl7FvTMZWuN/KMKYYfWWbKqcVY/sGQqzORw+QF?=
 =?us-ascii?Q?edQCWo/HXEQ4fI3N6Ql4ErNfhwKRkdUG+CJ51dXY/EN103l1cnnf/tWgcup0?=
 =?us-ascii?Q?YyZpwNZjBjL3H5/Mz8DdihBqueY5nf1wkR6Jef18DxoGpO+aYFKQgyrV6pjE?=
 =?us-ascii?Q?xjBhHaYBU/X1vOE1c3Pd64yybza4hvgXHZXhBVjTZUvraMKz8iQrhquGj5o8?=
 =?us-ascii?Q?QrJ7wjsN0xlZLIIgOqE9/Zah3y0SW4kjb2TLdQT6Rq6ZNKBCpXfVhQp6yPuZ?=
 =?us-ascii?Q?0HUyIoYKJXG7Q+e8CktjANC9yzBlJVZkbzB6UWTq+s/Cvou+jnG2HdmRpjF2?=
 =?us-ascii?Q?kSv1R1iBe3L4yOPNK0RazR0pBBOZlW/BWskor673hsjqvhJqsP/1AdRQDE73?=
 =?us-ascii?Q?aW4XfoSaOYStWm4vujSi5HUhjEQsJI9VfSAaFuG/mMpJlWBTpBvF01JlC8aF?=
 =?us-ascii?Q?DxhuvBsOyG5FYa3RoynSymjH9Sqwxe7ptO/jHqFk2NNMU6FVXxdq3qqPTRf/?=
 =?us-ascii?Q?uwuF3c48Jt9sWK4Ayhmt6fymg3hWbxisfJkjUbp/EL1eJZ213UC3HZUg6PzG?=
 =?us-ascii?Q?wqTphGUaJd8Hc09slj59Vdhlws02SL1iDt+xNtgNKj1m+gDhEDfDz27V9NDn?=
 =?us-ascii?Q?yZJFKfwDiUbZnU0n5d823dfO+AFMAvEhT+TtRARJWwFF4/7zGXDD1IB6AefV?=
 =?us-ascii?Q?twBLGWhw/7r3wSqkBuZb5mrmgULO33W6aonmM6AlGbnWMTitUeBYMmv4p+Dj?=
 =?us-ascii?Q?G6EkFfBhUFSMghk/jCxmZwxUA5nG2lhqKDdkLBPXlenYH+z71bNDDkx47Eco?=
 =?us-ascii?Q?PDqiaTWhwEQ8af4TKI6j1Wt1Y3QnNdjkxrGbsPf61xHbabvVTE84/h1yOlxm?=
 =?us-ascii?Q?l37BxNx+otKy1vmdI+NcX7CCkG7w5FUQL5HaYVhw/jqV69LYqE3JuoyljOSG?=
 =?us-ascii?Q?eCgxF4CjciedPpuo9ZwdwE9s2AkvmqlXeM0RWtabF7u8WZVE7e8LuVZhl34I?=
 =?us-ascii?Q?3tHZXW/HhwWlsJKJTzbwQMKA/E/yt/Qa5Qvy68RMxcoWBkdTvhzO5IIv6DyJ?=
 =?us-ascii?Q?2eQ4Bn9Bl7j8406G/jicxIhGzwpXht9QWFYwS7bj7sV1GwIRJ0m1YcJCyvIE?=
 =?us-ascii?Q?CS57pmiZeZVtXyo/GBX7ZS8I1y/hmhRsTo6BR8nrAamHAZFw3NXXC1qnIm+U?=
 =?us-ascii?Q?FPv5JiFj+R6K3xhpI9PXRRUr7tTQ/t+CBrWh61PZ9v8zuWDGs124AyL1vvNN?=
 =?us-ascii?Q?SpSHQZsgWylnaPZPCKkYC6vmxjlgqzU0BbmklqMlJN36KH98MTF1QzRTicqG?=
 =?us-ascii?Q?psi4stRA80JQug22wW3BXfRc+Y5Ce6Os+E0/aro3M65OD6ohGg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3e1cba-1082-4a1e-f982-08d960ab0d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 11:43:22.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiY2Z8DLIiJtlHu12kcLKGVC2ZK85fiuB+4B/xbc8NblMznKxt9TqsnrltzaxcV2Z7WcS4oX3kRiDBMe1gCh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0813
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/16 20:29, James Bottomley wrote:=0A=
> On Mon, 2021-08-16 at 10:44 +0900, Damien Le Moal wrote:=0A=
>> Avoid static checkers warnings about a potential NULL pointer=0A=
>> dereference for the port info variable pi. To do so, test that at=0A=
>> least=0A=
>> one port info is available on entry to ata_host_alloc_pinfo() and=0A=
>> start=0A=
>> the ata port initialization for() loop with pi initialized to the=0A=
>> first=0A=
>> port info passed as argument (which is already checked to be non=0A=
>> NULL).=0A=
>> Within the for() loop, get the next port info, if it is not NULL,=0A=
>> after initializing the ata port using the previous port info.=0A=
>>=0A=
>> Reported-by: kernel test robot <lkp@intel.com>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  drivers/ata/libata-core.c | 18 ++++++++++++++----=0A=
>>  1 file changed, 14 insertions(+), 4 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c=0A=
>> index 61c762961ca8..b237a718ea0f 100644=0A=
>> --- a/drivers/ata/libata-core.c=0A=
>> +++ b/drivers/ata/libata-core.c=0A=
>> @@ -5441,16 +5441,17 @@ struct ata_host *ata_host_alloc_pinfo(struct=0A=
>> device *dev,=0A=
>>  	struct ata_host *host;=0A=
>>  	int i, j;=0A=
>>  =0A=
>> +	/* We must have at least one port info */=0A=
>> +	if (!ppi[0])=0A=
>> +		return NULL;=0A=
> =0A=
> I've got to ask why on this one: most libata drivers use a static array=
=0A=
> for the port info.  If the first element is NULL that's a coding=0A=
> failure inside the driver, so WARN_ON would probably be more helpful to=
=0A=
> the driver writer.=0A=
> =0A=
> What makes the static checker think ppi isn't NULL?=0A=
> =0A=
>> +=0A=
>>  	host =3D ata_host_alloc(dev, n_ports);=0A=
>>  	if (!host)=0A=
>>  		return NULL;=0A=
>>  =0A=
>> -	for (i =3D 0, j =3D 0, pi =3D NULL; i < host->n_ports; i++) {=0A=
>> +	for (i =3D 0, j =3D 0, pi =3D ppi[0]; i < host->n_ports; i++) {=0A=
>>  		struct ata_port *ap =3D host->ports[i];=0A=
>>  =0A=
>> -		if (ppi[j])=0A=
>> -			pi =3D ppi[j++];=0A=
>> -=0A=
>>  		ap->pio_mask =3D pi->pio_mask;=0A=
>>  		ap->mwdma_mask =3D pi->mwdma_mask;=0A=
>>  		ap->udma_mask =3D pi->udma_mask;=0A=
>> @@ -5460,6 +5461,15 @@ struct ata_host *ata_host_alloc_pinfo(struct=0A=
>> device *dev,=0A=
>>  =0A=
>>  		if (!host->ops && (pi->port_ops !=3D=0A=
>> &ata_dummy_port_ops))=0A=
>>  			host->ops =3D pi->port_ops;=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Check that the next port info is not NULL.=0A=
>> +		 * If it is, keep using the current one.=0A=
>> +		 */=0A=
>> +		if (j < n_ports - 1 && ppi[j + 1]) {=0A=
>> +			j++;=0A=
>> +			pi =3D ppi[j];=0A=
>> +		}=0A=
> =0A=
> This looks completely pointless: once you've verified ppi[0] is not=0A=
> NULL above, there's no possible NULL deref in that loop and the static=0A=
> checker should see it.  If it doesn't we need a new static checker=0A=
> because we shouldn't be perturbing code for broken tools.=0A=
=0A=
I do not know how to run that static checker which sent the warnings initia=
lly.=0A=
I changed the code to avoid all the "dumb" cases it thinks are possible and=
=0A=
leading to the NULL deref signaled.=0A=
=0A=
I think we should drop this patch. If the checker complains again, then I c=
an=0A=
revisit in a different series.=0A=
=0A=
Jens, can you drop this one when you apply the series (if you think it is g=
ood=0A=
to apply). Or should I resend a v8 without this patch ?=0A=
=0A=
> =0A=
> James=0A=
> =0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
