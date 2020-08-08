Return-Path: <SRS0=lwW3=BS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C56AC433E0
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 01:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307542086A
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 01:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dvLEGtSO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D6Px/T61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHHBtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 21:49:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51954 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHHBtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 21:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596851347; x=1628387347;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bAsF1tUyR71IZLrnXbe//w224QdzmEeCYOUF3Vv6g34=;
  b=dvLEGtSOJdmVvHaK1yjqY2WuiVE7ETruvJHrHZmnLK46M1bb5WVmp6wg
   JSySmRZayuWN8qVtQ9VHtiMNlQqVUgvZy1wpAkcGIj5UzCR/BAd3OoY2k
   oe13yzAakFU8Bl2dEH8Bdr4JscmcFUT1IRflAzSR0R6cSaqAK0MVwjEJo
   nZC0kld8Zh5LeQvR5Mv2nYMxbWCznfRfqfrGWmHOnZXa7CPWt8HUussQ7
   LXQs9gEswA3N8wp3MA5bUZcuxNz7ILfSsaO2A0ulopBf3QAENZNLe1lKV
   jkBWV+UiJIzqwpmZqdf5YboF7RB950myApE/6nBkJoByLpK4k1aAvJQLh
   A==;
IronPort-SDR: 5ACDe98eAy1zqWS0n8SLoEszd+IXVFkIH2NRHxXu7zj4gFvmogUVnPPUyI7d3wWMNwo+UrjHE2
 9ubHl71gdeB1smIkBwavRxcApQYlSwUs7S1Phg7uOxOLfc6berKtOKdiA0d6Xj31JgdLuQqtBW
 hRIQJS/e3zVLhagtjlwptYxXSTa6MjdFUMiI0YZC1+3yJx1u3c0LtWuIR2xZ6hex58PDuTN/PH
 QvIGqPOhTXexMngrW5wYYQBsyLYu0swtdwy1Gfgc5ynMvBdIX+kxHn99EThUAQkIrRw6E68r6V
 Ong=
X-IronPort-AV: E=Sophos;i="5.75,447,1589212800"; 
   d="scan'208";a="247555470"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 09:49:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyWWhyMnIFpMCJt/0/3u8UKFZards2qIgbyvx7mqf1zI0hcEslaURTn871iJQKNNeraRlMx94U1QXdXwFhUZL+V6CvUS4TA0PaAm7ZNpF+Ny9t9aX7CI4w4p9eStoaegIE+3ukCs2od28evlKcuVB6YoE+vQMqSoWLd9ayWbmrsJNP8BDgo2aYwJWh93azGEl9mG+gZPqlRYtvFiXy4Z15YkxGdqewENHppSKG35gC9MvBhU38ipysI7bKMB42RSVpnKlZV+TJlgs0/chyLP2DmHC1VVYYQcWUqeaeqRObfQQqGftGg7MykCu1jXuvinJMhs1QLuLuE2qpoBxYbQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQmkHBv3FoTFIF2CiTnPpsGPOo31ElrB2XW1H8a2f70=;
 b=imsaxoAcGD0o/qExrjlwMjCB7u35e0bP24UIspZy+036MB8skPY+Jsd0IWvB+EwXM+p6kz/R2Iy4V+49KS75aJG3MkzqAd3PSCVHW6xGD8tjdl8iGMLvDtQjvv6DBM86Cv/7MeH28AEVwzv74DuIeTplJ2TtV1PsmWSwpRFdc27tUT/KNNdPj/5N63whJBrt5UDJzcnfxjUr+lfm5slwgm6zhg5Jf1S25dGxdukRqB9UWwuU84PzqbS7YcY3HTRAarXaH7QRykYXPuOVGeJESboAgElGu1GkSil39VmGIuFSnAz89LEEKqNYBZXX0Psk87GNNCpIqV/iSQA8naW8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQmkHBv3FoTFIF2CiTnPpsGPOo31ElrB2XW1H8a2f70=;
 b=D6Px/T61zuxLSoKSGP5DYyclUaRTXMLJEwqJMcqcMFfAKQs2ajWd+OnBJiWf9YnzzdrBvQe2Ydz+5S2AAqDnEY/ArbV+xFGkFM7pMKBV3f3XKeuZ6gNuhL4bS21nJf9h8ws6QcoribJmc+J1IM6vUGXfTP7yEJqZs4CYga6Qcbk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3957.namprd04.prod.outlook.com (2603:10b6:a02:af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Sat, 8 Aug
 2020 01:49:01 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Sat, 8 Aug 2020
 01:49:01 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
Thread-Topic: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
Thread-Index: AQHWbCXzMCiS9keU9U2ab5EhLdM5pQ==
Date:   Sat, 8 Aug 2020 01:49:01 +0000
Message-ID: <BYAPR04MB4965E3F982A3B72F493D291486460@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-6-sagi@grimberg.me>
 <BYAPR04MB496517FF9B9E262ACD555A2686490@BYAPR04MB4965.namprd04.prod.outlook.com>
 <bd794263-02d2-a723-44de-3a9f63723275@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d37486bc-a38c-4c7d-9935-08d83b3d3958
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB395716779DAB2F7E5E24551F86460@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLLWTlnvG0XmigbdhKZlseyiFOOQucfg5siq9Gr+/zRlotQMiy+h1wMXNMK2FHgBWLldbG9+Yku06w8vtM5kLRov3jb8G1HR7+c3jFSniA3MhQK6NaJSfpOM3GJGOT9xeJuRm4T9H8wijKMpJ5TQfsbLUIHrKnjD9GVD/MeBRPcYaXk0xTzw53z3In6D+E2mIa5Q4VcMvdc+SLjpgyKtg8/a1IJTVhyY1Ux9MaAqb3ytXrsgsaryFkKdBUAu5u4bBxxIMxm/mW54xnbdwoxsqRnxCAUIks0/an420quNtjiINAGqm1NeSB09mVgNXFfP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(71200400001)(52536014)(4326008)(5660300002)(2906002)(7696005)(55016002)(558084003)(53546011)(9686003)(6506007)(86362001)(8936002)(186003)(64756008)(76116006)(66556008)(54906003)(110136005)(478600001)(33656002)(8676002)(26005)(316002)(66476007)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zOuxOG80kQRMEC6MujPONx2qI2e/EPD+u0UMcwuNwk7fWXX0bnC583kXx+VXrgqeKxsoEf5gKpXDn+hsKEHee7zRhESFTQcluk4LH+TKy3oOM63P3gkl/uoDdoELW9YO5W9v9kpbPzKGmmEZ6BLfXRMwczajabzveVyFa8XER3wm77E2FTIdmbTebTbCKkSyAah2GI/0A6bq2GvGxWgzXdKTnwEDhD+z/brQXQzp8zF9v+h6sCFlgsjNnuUVNQvTbQjaUjOVSoHfzqEEqOdM564WC+/OshevP3WX8cmg+RLIjmVtIZxs0uf3eCcCAjes3YIjVbMXDt3hbWfNg6wgh3w1rLswn0ohzGPF1iy2rX/RhjPeA5DZmP8xihGBn+IMS5H0zJg3jFTSAazNSSlGDN5nhVpOnOYkqGo+v6vk9zbptl64fknGfFOtyx8oRfi50JqRa7bn6HgiVbIJBUFm20BR9i5zXnLV0JMGY6NuW1i4KLROpgolHBasLQ8yIZGl7uURwS3SheBbvvioyTPQe0QjRGt3idbr1Ohb6+O9hP8IR2W02W0GG5EOCHXS9iGXY8lKe+ogIYRl/mdmwvUJz0LY7Cm4H1Thvoi/je+VlRVrFElvqFjaoMSvRvBTsgxHm/2/wnf1hc2xQneMzjDEFA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37486bc-a38c-4c7d-9935-08d83b3d3958
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 01:49:01.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7iCGXD3nWkagkqjwR7aS/ytTaWAP19MA3TkqwFSUPFjurcqhHCzFozlD1klk+DJr8efkMc8rHhRGd5x5byyh5RNbgHSxIr1LrSluMOroy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/20 16:46, Sagi Grimberg wrote:=0A=
> So for every trtype instead of having:=0A=
> =0A=
> 	_have_modules nvmet nvme-core <trtype specific>=0A=
> 	_have_configfs=0A=
> =0A=
> You will have:=0A=
> 	_have_nvme_fabrics_common=0A=
> 	_have_modules <trtype specific>=0A=
> =0A=
> Don't see it as an improvement...=0A=
=0A=
Okay, we can ignore this.=0A=
