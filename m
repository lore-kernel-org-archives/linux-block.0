Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761DC5519F
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2A02158C
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n+R7AkjB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yDIyKWDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKTH2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:28:23 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55832 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKTH2W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 02:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605857302; x=1637393302;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=n+R7AkjBvrUrufMXS3cB1ZihGslSBMzYErckl4QXtyAWJa0JRx1rAHIO
   W4h0XpKr6llBW947YfO6kzZxxi5Tr6SOjq6C10DH6SFeo4I7QxifnNSEN
   fefHDO2Ls7YzO70n/CI3csaBA3gZtBCGOZ21tGyO/zbgcTSGsS/ePLmLr
   6aJcDt2cDNYBgvcPjC5pfyeAg3psMpK2U6A4nw5Y/zAbKLFfsCI33EDll
   H8NSDDE3dfEMBMJ+a7gtK4IotcBaiXe6yghKKVVvuQOsZNg7SvBy5A55S
   HjuWSN306BjmdmQcbAZIiS2ulvmmNigrP10PyARKkgEJ6pa/rFGtDIJYB
   g==;
IronPort-SDR: Nw5sf0cSq3hSXtl/7hLr0K4vZ70zQFf6i46s8UWOuAJ1BhrVNYYKWwmDAN2sklj4XHvUQdIGQL
 NFFuXiZVqZlRV/sAJ8+Ql89oJVJkT+/gRzL4QhBf4KgsfNZqfwOSzAgu3CktGMJYia4g2gDyie
 T5N2oq6znH3SlTK2QwfJMILXVjM0aAIhYFqIYsXEdN4MP5ki3GitxyV6phShPb4mKMk1ez+ysI
 XNAuY8CmjaaEZeOzCDa1+SKBEnI+WAmrnU3S3bG4kFZy7SbBVoYwmXw344eigUsWElFGy43erd
 lrY=
X-IronPort-AV: E=Sophos;i="5.78,355,1599494400"; 
   d="scan'208";a="154262903"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 15:28:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE4B65sqeYKKdu93qQM5NzkbFcAA+6lDCsx6w7KoAOEKUIYn7hk7+5haqPDLNQkHrnyc7ynuKq/UnPaTKOv+hQZV60csf0O0wlLEukow6A+TVSDE0UkCX1iVivG2Vzk0CSstozsvU3XKlSZS6mHIn0iRPL0IrkkgceKQMx/R6LM4U7G6aBnRJ3pgf2QSX49pZSAwBWVIToc99qQz/tufGI/Xw44Wi3atnsfohoDoP5BY6/vQWekMvA5FKZYwhLesgI79h3gEhniCo/HkGxdpilA8lPNwqdKfPsyePezB+Wjbb9bqsquRHIatbZ+g2n7p2l9jfc90+HcBV/I7wxfeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=BAAK5BHh41LV96fLle1Fe2pG9f441tbX7mkZVzUUISje1/FfmRqJ1s/Y6+8jYeHs3jbqHx37gQdJV8FPClBi1DkcOnI/9f6olF5YsIwmjcYXFxYaDrXrRsDhnPTCxdd4fvjGT0QdXZekCAEXwE9j0kcn+WamWhEb/3QAkR58NVqyUcq4zUHuFi9pPfdSf5iMaNYT9fFSsuJ3l2G2Z0Za5bIicQOmFg4Tk92sBjDo5dUEvqt6n7gBhbNLriHJfLP1TdkgWTjQAOsCA1k0T3IVUobWew+DNx4cScDk4lPyoGMRoMAO46naDY1c25TXrt+lHoooyHrjT3OwwhPV6xfu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=yDIyKWDvSgLbyP/md9duImoaO/f/KnV27b6PI/ybUSnCYD5xBck56u/3jfVxfCsx+PV6oN9QJ8hypNysv/OkPpKdO8PySeiZG53m8wVFHNNnKtc5XpshDmgWQDTV8QH/r5xBBnpqPjyc+ucV31yPcx62OpDjViJ3fc0YQi+bXDM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5326.namprd04.prod.outlook.com
 (2603:10b6:805:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 07:28:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 07:28:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 3/9] block: Align max_hw_sectors to logical blocksize
Thread-Topic: [PATCH v4 3/9] block: Align max_hw_sectors to logical blocksize
Thread-Index: AQHWvuCIl8n8KxW1lEunx0Skd9TkKg==
Date:   Fri, 20 Nov 2020 07:28:19 +0000
Message-ID: <SN4PR0401MB3598E1F21CFE58AF6BC964A89BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
 <20201120015519.276820-4-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fc301d4-ec75-425d-1a91-08d88d25dad9
x-ms-traffictypediagnostic: SN6PR04MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5326E930C6AFA6B38F9C7FF49BFF0@SN6PR04MB5326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NCHv3yXWsfHEXvhf0w8co4TitohjmIM+hstoFB96wPcWDYm25zzwQErEQLPKR7RLlwv/pt6SsFxznVLll5Q2LI7WgNBzp3FNLIYjCxXvoKOA45SPlrpyeuG/4AmS1ndJ5ERt/cHvo9i7/Ovq3S0zrKu0BEjk7G60s7xrMmTefibZta1qRt7uI8YJ5Z0sXFEUiylGErq95iubV96DKOJQxX5Bzb2Qi40hMCnrpKYOGtz4vO7w0aRzv98oISozEJKKBzVeIjSB8lfp5npd9HauLxDmxRx2kkfDFbXSfb7p2DSlJDZbOQZ4q6EUaruGL4WF7ZAUhk0O34/ViiaSruc+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(19618925003)(186003)(5660300002)(55016002)(52536014)(110136005)(478600001)(316002)(558084003)(9686003)(8936002)(76116006)(66556008)(8676002)(66946007)(91956017)(2906002)(66476007)(4270600006)(64756008)(7696005)(66446008)(6506007)(33656002)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wdzl2v6cwJU5FrUVVNbuLOJMXAsXD4pauWrMV42PoA6dgjdRg5bhCKo2cQpFfAuFfUNypjMAPfE1I2f83zFYJgAq1jLffoOPdzJeO28lrwloc0lE8nF1g33TssTRUk8DENgaPAraY5BmupJyHZNE7w6RV5bdI9BhHvmMqJRDpdtXT+NWvicz2YUQr0k/GTYmtNjfNpMJhuddk5JXt5yxEianvpOe2P8+3vunRfOjZRvcJIT5HoPHhF+IGG2qR/xkMVOQ0xR2aiVJP3/vLIzF2qRa+6e4qp06D6AmEA65x9ZDymb+HUOSSMPEQ8bzByP2cJmeZTIzObQkH3HmfY9cVlpDjOh9g4CfMR1V0vtUAlcHgvKRSB0EbMttc58+8sjlatkoalHpoQEJlD2WsOyf6xT/EIkzGNpeOHCn5tgUvgTcHBiujuBCjned0Nf+piEg2ET/kOd+oKx/2g6dekmHrtYwYy9IirpjE9U+k5m0YwSHGcXdOGvMICKBvoP+/rVZWBVwYI1TNUYOCgmzYSHbcsmFHYMen8K8CYCba31yHSuvjoymSyfMaQn5dO8+x35Eke1hq7GTRHYG03YC+9vQSxKUkPAwh30Sh9mPsEZwvHGpaHZpGh0I+eoStXrU0G8IDlPpY5u96qXFCZtZbC079si9hVyry3lkgI9g1Ful6nIKuv7LNub9/JmCZDQAoGSMTaSshKIlGAWKycQ53y4mPQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc301d4-ec75-425d-1a91-08d88d25dad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 07:28:19.6493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWJZsTlHW2GQPTCF8vMpRhfiTRzLqtLgBshDNXs8h9Rdt/MsdwAlBcPcMuUEo/ucDumTmxKYSfClA51HNU8oxjyC8ezMG/3c03WMhFnTEB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
