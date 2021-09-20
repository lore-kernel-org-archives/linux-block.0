Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D34C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AD96109D
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhITNBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 09:01:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24551 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhITNBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 09:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632142779; x=1663678779;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=iinIJOQggB3UEkHmfkZUCkjgxjvRTDY1uKW5EhVtlLwPCTb61yemoi2p
   9lPB/bCIljF9d5N5dGWPTPTlGj3rX6tRu9FiSKCBuv/pzzIedq4vIvNJG
   yUjVhPNQqcLjPu1l2f3WF4ydfhplVTchWwdUz9mFJ6i5VOIYzd47jThKw
   AdBNhnl3itVZHui1QBQV6Srt7VEpZ8yRBXm5EKzSJhN+yuRwE6RUlsdSw
   le9NuDTh30p7R6yREo2UUFH6rvjOjAYLbfdwNdqC/23XPWgpNTCTGDDpW
   fRMmcg/h1tyOD+KluG7PZ48lrQU8MELODAl6ttJd1os+hj+SA67oTzoru
   w==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="180456428"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 20:59:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsn4Rlnv5Efpbb4agvkirNlESi2d1Ao8xVlP8W3IZTf1SmL/iFFIp/4BJuMBaJQuZ8edc6xbpPbdm1AX8uKNGD0hVtkoJl7HZ77WBTkajjSpgLwsBlKRmNXBllK9ayfE/S/hHPdk+Xs0iVbbtbxkhFqr2VcUhDZHPR1JwkI87CEYxq3bf8fb87vENkqfvq0WeWJBpFLFM9fa10SqauvOwGrDK+pHybfM1qOYMuHhE+IyjEyhB8IzFcRHaulXPebX+LiKJAw+NVZifEmYmINcuQfOdD92dnrscDJ2ApmT47zRfM0HMhIbmQWAvenTgGRttACMbmOOMy2dhA/39W1CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=ZDHgPqJbCPxxshHoOPXQKkSTnLNsCPrIt+bk2Xshy8gs109Wa+GNSQt3y/4g5HZzGl0tHty1ZBQ4CF3faXshDouXve6TOMNpewCIQBFMuGbG1Alh7V9qX/DASYt1jK2JYHcG00AHyFsvOn5DgdQ131WmgbAeZmXDj8hV065Yu+RlwAfWonxjJt/MJ0FqDV3XqnWqm2lJz0Pw8+B0eEEMZWzD9oYdVp4jUiAiwcZ5TWEzsD5CvelHBCLqy1y5y86nwthKnAyHM26W7wIMgODigBdM24M5expgrQ+/2wrTi6ELWMCzI9zvzTQH7NqkYd7IbwvaYEPBcIRT4o+FJW2k5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=CWrrFPpOIxNBGkcPPptRecm+ALcjru+SXHn02F8xrkY6pXpBroBA5O+CIcDpblI49OGU1DWa2j2Lz0l5nO177VC0Hv2HNcsg8mE2AldBJa5pa5AgsjjrPyWxmek8tUWkOVyBD3niYaZheCbz1PekTyOI3QbmfX+2Z0zBx8f7sIk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7448.namprd04.prod.outlook.com (2603:10b6:510:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 12:59:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:59:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 10/17] block: remove the cmd_size field from struct
 request_queue
Thread-Topic: [PATCH 10/17] block: remove the cmd_size field from struct
 request_queue
Thread-Index: AQHXrhzEhjUFEiZvPkqRtoigNQffIg==
Date:   Mon, 20 Sep 2021 12:59:37 +0000
Message-ID: <PH0PR04MB741698C71F88B6A0C287A2D69BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cca43ec3-ab0e-4f8e-4a08-08d97c368072
x-ms-traffictypediagnostic: PH0PR04MB7448:
x-microsoft-antispam-prvs: <PH0PR04MB744894ECCFEF76AAB17E13619BA09@PH0PR04MB7448.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9yOxuG1m6A4kVJ1868YZjTyEeJsDIm6crz5bIgjQT9HjIRUVsHZcvIdzLt8zWN8FnYOPxktKPD/JlhR6fSXSFlcPExvs+cGJB6Jhxf6hKCJh7NMELu1aMUOX9zXL+ItNQWF3kuWWAr51z9fsFxqCJ6t0pWAW9t7ANMOlDhMXZiAfyHa3hpHrVtp+qV3sRmlt/wSeVBKhhCRemoethM/qdKmPrp5xsb0LbvIGyOldd9zLUE1PAauSJ1GmtuGo1HcV+hGI27G5QHxt7hp1naLlRbCwoD6t2kgM0qawns3qv3GTKfBOiOL3l/LtfeCC96M3u6C2vs9Bt+ZovXVpslwMkwSElZQN36FXn+pfWKkOjf3vazNn1VXxIm8SSP6EFE/1DdJ0F2jj847q175jJFeKEUKoEMRp2wUMacnsCD0fQr4FpjBu+2F+J03eR890mP7a6yJ5FLwgAYR4fWdEvUjBk3YTA19CSEe7eNqziVZ52Tg9hqkr5HMLM0ByhaQ+UPsKzjRgBN3LFawyIvhI+6uWZuYoIeGnEhLZSLTeBGbZQVfU7DKZxCVwohoLtAO97HMxi+VoYr3KC3rOc6UUzXx5LKMBm4VngTvtjGBWGp5oajDBtX2T2wVRUFPd2dzytsokPupC0p8nN9th6o4YS9Rl4Qta1QeQkRV5j7dUzIIN8BciHkD1CxYBNr5VUseR8fzzAjdC/mjVqgfcex3t4wGpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(478600001)(38070700005)(8676002)(8936002)(66946007)(38100700002)(7696005)(66556008)(316002)(76116006)(66446008)(122000001)(86362001)(71200400001)(4270600006)(66476007)(6506007)(4326008)(558084003)(52536014)(33656002)(110136005)(186003)(64756008)(9686003)(54906003)(2906002)(19618925003)(5660300002)(91956017)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hp5JcmNaU+dIo4a5z7AHP79c4/8YGwmIBW/yAd+v+yoWiIAgGeF5H41o+N/I?=
 =?us-ascii?Q?5BgBIjDLBpDtCPdd6Wb10DSgHZBrMGKszdM2JxJOBFyD4eOhu/OFxFzygZu8?=
 =?us-ascii?Q?aU99tyj4qXNE0MnGdu/dY7OXtm0Nti5bOBcwELOGRbfhXf2lv5xXVxG/8H4h?=
 =?us-ascii?Q?nvDAGLD3MtuBZYjNXifPU38T3hWN/Ez6ooudVKk83NS7UMxZQOl8XIrGUPJB?=
 =?us-ascii?Q?xOoSKE3pM2r4VTGcMs1yaIy+57vU5L+LQ8WDlXbVUlShvT81olIBxBPggamA?=
 =?us-ascii?Q?UnLIvBvEqU4JQIMDEU3RTycsxvOKlXvDiLc88Ii0sv6ilgnIg0zq/a6JYN2P?=
 =?us-ascii?Q?BonhC7GRdttz9yXjrOOL4CzYhGa5HjSx3qKdBLOeZUrXdCCyFQ/0Zx0y3/Vn?=
 =?us-ascii?Q?sicDhcWqrK78/C3WaBxhJqQSxu+bJ6s4Pe3QmsgFnSEOQ0uMgbuFvE7+HHZn?=
 =?us-ascii?Q?iODFzy7qY2A23BKGpV6w3bYRfVUf7Wmf0tW4qH1jA3H+zP7Yde15ldedntPh?=
 =?us-ascii?Q?JEY1+5amTNZ+rDZVhi6HVWjtDaF+DGoX+T16qhZh+14kvgB8+TA7yGKIIiP5?=
 =?us-ascii?Q?GJ7rC8Pci++fn/RnvQt35/+nuBp9crUdYbz8Lz+IlAXjCDwvmbOsGTC/tH7f?=
 =?us-ascii?Q?kS9Q39FiCEnBDJIn5HFuKqN82/48dJWKkrFs4nBitrjhSK4kOmxV0qnN7xWs?=
 =?us-ascii?Q?BYNZtmWqOfYQt8Bmfgeym8AWlhxmeK1xu3v1sRzWpIES8YMdFOhgyzhPqQ6C?=
 =?us-ascii?Q?U+wertJ58lrlbPPqIB00vSGzgLNcChn7pcweu1H4hlauu1sCdsyNi72lGRJx?=
 =?us-ascii?Q?KHqJ4uRtWeyXv+UZExuZKcrvcnvpyS0nPRL+q9vD78aHQTqsBcWdxA7eFEKg?=
 =?us-ascii?Q?5E19wHHswqT0uaAWbHt7vdNbld8nk+8f7cTh5StIbwdWUolosdU3weUodMde?=
 =?us-ascii?Q?Zr/n+DZqoCuw/6arMVqgivZ8hye1IdCRUh+VeeNMmH+ZsWY+BCPzYfJ4tNEc?=
 =?us-ascii?Q?/dRVvfuep55sIi6fauKfarq99Cr6+i8rZOIkf1sirC4isST2x6a6XX5GNHT6?=
 =?us-ascii?Q?mvN5aKH3PnNKa+HykEWiuqfEL4OxYCEe1gJdoEgWq5ARtb1dEi8+mMhV+pZS?=
 =?us-ascii?Q?xxclB/+mKGpoD7BoLj07vvhDCnJd7B63aRnvcSV8pJe7jRDQpjUMspFxmiok?=
 =?us-ascii?Q?GaHDWkaNwXwQ6Wod/+rs8O/FPy5y4HqF/boC3yMuLt7UUFCklh+H47/JWQ8y?=
 =?us-ascii?Q?uiteUAgWOAsrpMq0/llhYmahN6QEb4OGDcWS3D6cTxGqd6ark/NPWP5Fn+4L?=
 =?us-ascii?Q?mZ1BJRIaTsojjueS0IyPU1I2EEKxwwHgApX3qAYwB1LDEqthzjgDsMeYYfuW?=
 =?us-ascii?Q?nsU6Ecu72clH7ziEX6SJQ/3gQZ7wsySInbNQqPZo3HPfoLVauQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca43ec3-ab0e-4f8e-4a08-08d97c368072
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 12:59:37.2308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ul3XXt2KKtdSySKoQxWdv+alewZ1xZTgMNXabtFT2rk33420fmtKq1zanRsmJHZ3wudLWnT/fLvQPyOdtU5XnOQ+6T6EKsFEnRowUf5FKUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7448
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
