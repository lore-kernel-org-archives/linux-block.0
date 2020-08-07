Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C396AC433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A874B2073B
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YqDHY0lS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RwNEL6q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHGDQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:16:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24914 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHGDQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 23:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596770184; x=1628306184;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dTSQe2+Ej/Biz6iE7FCnqUWzWLf2P5z69L3UY+H4zf4=;
  b=YqDHY0lSX7BMUlEfXc3y6pR25mrWv+aPRkPTVfvEqTRM4Pb1dOOPITNk
   390xdWLu5HPYIro9+CzFR2poiPBYJeVx8enze8QhEcundnK2dOiK3TARr
   vREhIL/NADdZFXB3WZsIVz4T26iRX3qeruqL1MVwKYAaelESdNOLYM3sK
   lneX57xeUdGQLCuqYa0OdQNlcmoMaQGh+9qpA3B+/L6cSCioQmqUqOtrp
   xbREUkFwwiyXRpm4d+sD1++/Pdakhy3Vhdf5UzqktRCujK/6VhfEo/qaE
   BQqFsSU0Pc9400RZu9vw8c0DvfA7Xwtn9FhzKRhJ5xjIzKRhdBIi6ZpCl
   Q==;
IronPort-SDR: l7S8SNAwPIYljkG6n32G6W81BnUdNuL1XZam0T6cAF+ujo4Z71jt3jc7gQtpkd/WVnUfm+2suE
 jC7bXe7OyQWDTjus+oiSBBANj34/FI9tLia3o4/gpPbY0G2ahb7bnxLre93pbBdRayxtK2/CaD
 hrma5UzW7HpcT9rUOpcGFORVMHZT2e5bgzNjvTKYvF9wigbxjPEKYIhH3Ir3W83zDKxAyC95GC
 /6q6DV19eM0SUtStldyuxANP5O3qSyOWGaObNuAJ+hHs/Rxq5gI/uFeZPFxf+v96jEAoD/toKV
 y3o=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; 
   d="scan'208";a="144420262"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 11:16:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXkHEaRRu3QDcB915pZgOaZn4aqxEeS5tnhzm29T0GGLLGW2AKy5oIjuOlRPr0L0AFPpCwsqAetDa6Ryaiy1PSVJniG76XfANjqkzD10Qmv/97+5Pw76N07AcaeD0wN2ekzUDvwJqw6f1Ytt5f6/z4dPy74VnSG2HzbR645yrtdfBqsCtWkhCVAAre3UxM6bGhj4x7fnTxxWQxe4LW6Ms4kwLZhvFG5oQb0HmBXVNzh4e0z3zDiRGUOvStxfXgadsyHRnZPcjlqrZSTUAFibf/EFRUg2mxv5AwUFVKbO23GlxDUDoSqnAD6XmJX+0TdRr3KWCfYvJiEhnKQ60NpJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny59ns9BiWtNuOxFqwReDNeiREiNYGG55TWvy2QdAIo=;
 b=din9irVq0z6VOqhaBrzSy6H6AZlwsyDn/vGFmCELy86eYdg1c6LLwHitJYlZM9jCp9FbxnN4P9kzUB12DgSwNNwcsHUJLjVlPUQADqINcVQOr9l6EyZz+AdRX7I8l7S6Et5nLgSTCwbaOgB5ag2YVNXsVOe8w5m8e1w10bttTmVo+evamTmzAhAP6sWd0UNeWexLP+ofY0EVY2Q6fd+CsX8J0XyWdYMKxBKQRP0bh63WiBsM5weonMG4KUeNunN5RUPWN8Inh6WjqYzkLfrN9+1vXU052v4pm1EDO8nYcFP7JX7YYZUoAF7Z9aCNIwPgUeqs7iAtlfxwVxLyGYqzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny59ns9BiWtNuOxFqwReDNeiREiNYGG55TWvy2QdAIo=;
 b=RwNEL6q1N0GDyJDcvRroAuctCDPzCnAaGhocHkHdsoYReTu68Ian+rpDKDi2OzDHFeu8i+u8GlYOaz/GhODsL8D4WRjJb9w6exjVFT//GV92qO3uoF1RI0WaHi3hz7a3j4nJ4gIndTV5aKjc9A8vCECbzF9V9njc00hsOB0S1o8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4967.namprd04.prod.outlook.com (2603:10b6:a03:4f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 03:16:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:16:22 +0000
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
Date:   Fri, 7 Aug 2020 03:16:21 +0000
Message-ID: <BYAPR04MB496517FF9B9E262ACD555A2686490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-6-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73c96b18-03a7-42a3-850c-08d83a804298
x-ms-traffictypediagnostic: BYAPR04MB4967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4967C1C3DD6C7167E09727F986490@BYAPR04MB4967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUAYru42Xn6OEhnHe04OuxGm8blNA8OaXE7GmmD2QQM+Is9L6WbK9/G7w9oifitYYh1tilxqqMML4KymgBv7oIv0K5YGPneKUsk8Dy8W/WkMDp2EiBpLD699+vcRxRFeLKJvQhPIN7VgWq4ULsboWFGgJsh/uXz3Toi5gfydMO3SCQPG77YAmvtcdboHieO/1O2JY69Aw0xFKyKycpqU2738Ea3nUvJHoqd7Vklcs/decDiJY2NBB8AcKwSVGUl281hdMDCdlN36EtPbXPcZitwmyudhh0x2OpG7CdDa6Xep/aunGbuf6dVCy6jYhkVt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(8936002)(316002)(52536014)(2906002)(66476007)(66556008)(64756008)(66946007)(76116006)(5660300002)(55016002)(66446008)(186003)(9686003)(8676002)(71200400001)(54906003)(110136005)(53546011)(26005)(33656002)(6506007)(7696005)(86362001)(558084003)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Bh1GlJZhHtLbhrrTXvIV7eSAU2fxrbmNp9ABtrlIdTwGIX1G9/RPMmixc36svaHQOF+1ceO6lKxqLUQ/YFHi5/hhMkK7EfJADTaEpy2g2iNbn1RVFKiI/fcZaHut+2sbquVD9IazL79MW/ClMyany0uutGpOsGX+E45TC8YJqjjdIDYmlMJ9OwAcOKWViRuE3776yGcby0nEEozZP6XaBHZ7fTVgwDGSWgqIRQLOJxWe3LwIAyaarcn2Y8xcwi58qmPIq23EpCsZrTI2qMUeeyggJWY0hOYtTluGa1DCjSpXrvxxFShmRDqg9MkDRw/SlhyViIqcPHlv2GjNTvSseMe16L4nlOxvAwpNsek8Jjz9v1vVuchjg0TIJjTKF4jpCO3ktEdWii+yzDu08ntn489iUFmgPRo4R/W/rXu5DUXtQYa9p4KZ0KpNpQMIFRrHkZzzQLBNATGfok3FNlD6KvcFAgUTJ0F/jzsAUTiaIu4T/aXcp+3204NfigUZmLiixfirLFH+6CNWEHADjd+A5wegU/znNB1AWfSV4VaIBiKRdMXltCoIyG8doHCwy7q5YMIJb+oaTe/43JRXhMca99xouxGV9ATBToGcJ82J4S4qHwTegkHN4n+thLYfxJ39lbEXAXpxkQHiv1p5kggiGw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c96b18-03a7-42a3-850c-08d83a804298
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:16:21.8512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Eu/+4DCI0kfmubA4DN0eL4wLWWjwPD/zrs42iM5O3X0T4FaFgoDEZUtwjAXllWS3GclpzB7npwElChNiK16woPrGuOlnapt+5Qr3G9wLhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4967
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/20 12:15, Sagi Grimberg wrote:=0A=
> +	tcp)=0A=
> +		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp=0A=
> +		_have_configfs=0A=
> +		;;=0A=
>   	=0A=
Same as previous nvme-core nvmet configfs can use a helper.=0A=
