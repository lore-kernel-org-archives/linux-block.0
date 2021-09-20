Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A104C433FE
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93406117A
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhITNE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 09:04:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11368 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbhITNEY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 09:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632142977; x=1663678977;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DqubwndqYKPfPorUCPP+TrZJkfoTO/uN8MEoS+9/HYk/4vFeda6/Y5uL
   CrI0aZLQJB68ulSTKCTrQBLcKDedHoYIhgBFFKgvECiE7+zQi2eAw3JWU
   ULONDhWod7EeG5Lc6VTUlAMikZQK8anJUn+oNixsfPm5CYAJq3kRzgy1a
   2pHyRq94BdGfdKOAUpFA+d7RN0mvzY8S4QgcXfP2hfovGKVO8nkeFj3Gf
   n/h2A44AteyHfbBOcwoSU/4JPICFqvVgwh/dcZdYA7gkHJk8HWhihTHyu
   FXCnTZ1cPIyq2YtulVLc5IYYnhqTUYeByLzjdybb4/MamK5Tt2Z7jvffK
   w==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="185234946"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 21:02:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjzCxMX+l3PpAFZCXT8zQVXT9qzy8Kk8pLtQTUhCO7/8kDMvVra/ZiN4WL65+xeWRuQjC0X4gbH2j9bOEJl0CN4FJK3gNyXk+Q9rioTGjsRcCcE2Afzm6EnGPJ4P5MyhzG4VsoBBLG4EWRJOShgoyW8c6wf+cwZdQgb1L2BxEqjQJaB6xZNOl6ZzYEkowTFzRIzPjy27kXBfg9Q7JcoxtLiBSbBlU/B5uF+iMlc26MaWF2QFQBljSE4RozeyrZiUJEpJvrDj5ScLC10Y0C3/NipJsiL4Gt6huOoNol/txwaAigORuscgj3+9eI6FdLw/UB3xbsw6nWIVXyrS8mSkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=f8Pe9LUOFz6Do9gLHjAMaRkedgdvOaM1kthpaOYQSjLkSxqDnI9PPgThfK/aet5dM787UP+45GaNIzeG63RVNCj/3tjWEX0RRA+ECg9esiqGWzzlVpA/Qs7M3NE7e7ohhwpYEA1JLhNisLhTTY93mgLrudzaILmgO2B7rYiKHc8xIveBJp1QjAgKMph1MbERd/uRmgPOte3baQV0yMBwBS2CsU7i6jYhCCDYX0RBj8qX19WS4ReX0JG1Q5VioxSPUsmUh+5FIA03ipiTf/VUdTNXG2Spygwx12yT+b4/1MCDehoDeVmA/OjVJSLDFZdCmtWjoS7VOnta9vNqd8wQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WXIU1JvuFYSfkwlKKe1k7MuhZ9jNJIv4PZnHaMPrRO9NohZh6IihIiP1kfa3cPyH0/LBnF7qFU/NHj/kx5FfrFaarecfveqZkFiNmuOWZ1/pIEwNZLMHVTqfJnBDA8d9hLuWbRJ8c4y2O1kh2OLPJaniIVC5Nc51i7vjdMAvx/4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 13:02:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 13:02:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 12/17] block: move elevator.h to block/
Thread-Topic: [PATCH 12/17] block: move elevator.h to block/
Thread-Index: AQHXrhzwibXrX9ydYE64NJDqIv/atg==
Date:   Mon, 20 Sep 2021 13:02:56 +0000
Message-ID: <PH0PR04MB74169A7F434E88368199609F9BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23f05d88-d037-4aa5-49e9-08d97c36f73a
x-ms-traffictypediagnostic: PH0PR04MB7653:
x-microsoft-antispam-prvs: <PH0PR04MB7653578E0F95265CFC8ED7179BA09@PH0PR04MB7653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7fE94gWoKF84zYi5u9hv5ioClSuV+HRiQf/sA2cDFEtR3KA1ASPCH4hgPaFaieu2HDhLX+duPlGx5cswDxHdJwQcQxCHp0pO5skaozuV9na9sdG+e1VYOuz5NX0LOg+srC74Nc2r7Vqj6Pkc2wCqjOWAEdCnTAS7szPFxAqxEdPJBn048EanCHIoxq4U2jDo51x8uNStncuUBvJetwMtscdGCih7f4o63zdvbJzg+hlrVm4nkwp5fruLH4ZBleHSxVKAAjN/VuSG0zZXk96n1K0BI634CBS2/FeeKpHbqm4LNiJqBIxNYHhMhXcMw/FwrB+D7Z1f9jIK9NaC4HYRumIwHBlKkLlQRNpuWRCxrXwveBc0Wnt2YrIvJWwwolBM51QLOSGFNmI/iJ1DcStb7c4jyqo1BNboK+8PqimBh+QTbROpW0TqDI6Qp5AKLh5XchFJpfjRaqQDT3naTgd8ecRnPH7k9KbWTP+oxujGKRyofhVmdD0BcT06x4Dj/Yr5BFiEa8eOoguD7MJJq1vXc5RzkjeWf7vbI8HdSwI4mPeA31zNb/WU5Tj4EprElcYw8dA+2TgFbcbFcsd3n8FRr5HgALnfy7fH5+fD+FSZ1dWk5Qd7WhGsEiG++4gvG5QtJpOAApsewRzg908fxpgIQerrzcGq2MZaVOlgx/kgkogp8G8I5VAm/Fj5wVD7pViC+ryVpDTBKDvbzuPNhRxiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(19618925003)(558084003)(66476007)(91956017)(66946007)(71200400001)(76116006)(4326008)(9686003)(66446008)(508600001)(66556008)(64756008)(4270600006)(8676002)(33656002)(6506007)(5660300002)(2906002)(54906003)(7696005)(316002)(38100700002)(55016002)(86362001)(186003)(8936002)(52536014)(110136005)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6chHzotWtRa+LjP7POa04sKsZLeU1wYXDJ1QZ4mhe/d9otFl6yY9lg26T+Uu?=
 =?us-ascii?Q?k+jn1hE8p5Zus70N2ZRFXBLr6rQZSdihlpsQKriOCS/4wAj2XOT7XFbDl8IL?=
 =?us-ascii?Q?5PshSMxCBpq4FhiAHkYkITP6uq+6Vh7hLronJf+Rdl6XNiSDpl7g41O6FWv6?=
 =?us-ascii?Q?7ofWS7bukURu5BdeiKrJeuRoILvepoMUkpnp4fl33V9HLsNtKcgScHYkKmVR?=
 =?us-ascii?Q?MLi5Dx7+bDIiaDsHUCWqlRzUWPny3MCxWqTJFWnuseAcM3bg8pm0tYN/8ZUj?=
 =?us-ascii?Q?6YsLV30V7f7jTTyHfjdkEGTSnl+1G01AKPdCKVeOo2DaA7so6yR9dG+nawAR?=
 =?us-ascii?Q?nmlVBkv+2bI1lhFAZycEtifFyY+b6Kt9HcuVs98L6pUbqgONcev1yx49qxPd?=
 =?us-ascii?Q?2FHt/0YFACtSdtrrICwR3aZgIesW43nJ8ospQBJZYdBaEJ2UaeK58D0hOHJg?=
 =?us-ascii?Q?odJfGlCew4HIDNPa/Zh7YPk9cf5T2t+sEjhblaDVgvj2ii+OJPdp6SgPo4MZ?=
 =?us-ascii?Q?oYoGVLoA4PBHhHivJbySQK5YlCdymgcw1FUAaprFphWiKtO97FbgD83OmZfJ?=
 =?us-ascii?Q?KXOv1tyMj5owRFBpTp2NIzSMak1lmXOFlAw1hsKKckVEvkgLETvT5YVEsDWl?=
 =?us-ascii?Q?LrTZ3gFPWtBBKCsyfQpRPJUSHfO8xhgLbQDJN8rcvgqiZEFw1Pva6LnqOVNx?=
 =?us-ascii?Q?mvukJofFj1OsM/iYaABlZKv9rAx5OZLQ0cE1E1cmQwZ3qOstgB0OXZQBeDYL?=
 =?us-ascii?Q?jAbt6Di415sM8jExBOAem3qYpXFxqMz4ufyniHSObDanwm70AjlVtzJkjyF2?=
 =?us-ascii?Q?yeWbAMWgdd+1ixogDqUE5o5TvliqOEQVOxPI/2xUCmlO24sQkw7no0hK6weQ?=
 =?us-ascii?Q?HffW7JlccapShLrwh7lGSN7h1vdhUR3dZ6PgiAaFcq58SmJN9N0lO2XRWMah?=
 =?us-ascii?Q?1zjI/yp0CmcUK/1FitbNW5RWZ+swT912yB6ljNjd6khWgLFy86IqqJ057FGH?=
 =?us-ascii?Q?NicDwKofed93sOZtPaLxDarE20ovOGPuEMQDpLHhd39n8v26dEIutoB2HEn/?=
 =?us-ascii?Q?cRe4eDVJd0IS9ANrM+qdOIZFSNTrRZNi9S/Qbc3mRDxUTpgAFaMNcoUWAAFM?=
 =?us-ascii?Q?qzMpo26ZXq5q68t2YxoiI0qN7D8rS4H3Lkpq0s6IbwqZsPIqJBb4ZmasRKM2?=
 =?us-ascii?Q?zD05tTR2HkSs1RdFYgtW4M+beLtMDixOz7t05oWFZwhgaXs+Gh7NhHmhIDGB?=
 =?us-ascii?Q?f6WJWem9xHOHsKJf0G2ZqvEiv4rJtVAcBc8SSTglau4TTZLQ2rYSL4qEviXY?=
 =?us-ascii?Q?SJKBWRAXz3HRBAxSO9hcCGA68rlh25GxNq6/GlJJeKv/Lx+D8SPCCIoMXy6Y?=
 =?us-ascii?Q?Vr8lV+xHsxP+xJ0peEAShzbsX8riRn9gK0F43Yh8MRBJPTzrKQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f05d88-d037-4aa5-49e9-08d97c36f73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 13:02:56.6032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wb1/wWa0eBMWezafSZjXBZqWlwSuTJBWNSmpTfycsD9V8GhHtJBPEAZyB8NqH22xFR3OlXzPB3obwYjOz0gvGZeRhGxwDphwuQYZPpPw7V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
