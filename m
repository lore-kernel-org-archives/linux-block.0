Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4716BC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A765A20679
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oWsF9a5p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tOSk0DVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgKKPTT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:19:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54726 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKKPTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 10:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605107958; x=1636643958;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=oWsF9a5pxXBlpcVI8c/atCARreMdADTniJGlJfo8I/4O9In8FlYj9ty+
   BS10Otp6bNbLlZZCdpNE0VNeozB5Xzjb7MLTX4/wa9SFxXG0VOB3+ljTt
   jYS0iPWmWO+RPIkBYxIKHIAIdz2ULmYGfWCTtpbXmmJrOCj0eBQDYlfgq
   r4qJfO99voC58Jlv66Pnx4sB/+Q0RpUMgNGP2JBU3WbO3lBnfAQNtEUqA
   9gEKzMFdvSNXjTH6rm4LlRH4yyO7HsEl0pT6r8QC1rS6YxlgaeAkuBy1i
   6bzBJk5IpyuqJqntZ5Uu5QLagfrqXkZxWu9cYATmjJZqC6Sxde+M4uFfl
   A==;
IronPort-SDR: cuOFluJfjg2y/7lPjfkSbkWq9V4IiH17g9lOwfX/6HjHL4UwQWFavlB7phOd513Hh1PSc/2Awo
 64IqZiVC5eDApevFG1Un3+kRTfcbdqFuLDP7mrF+23Moc7ixKhyKbsxINLMr+2f7kUrw9Y1Gwo
 /cJKf0zrSy0PhJfLedGDWV0nBvPf8Q4mHpIpeGygbQR0iPup7Z6llh6dKIgBCE6rVTTA2xzfja
 BfK/mWSBZur3Brz7icWnaXkNKsYEfWs3G9H/eLUMhPYaZao4I1DPEa77DnuxWgKzaOtEr+lJj9
 sqY=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="262400165"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 23:19:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6oqk/8HisUO4NZUQ6/USs86sJbmOLGtJKbqJR1dfQBlZ5x9Tgv7Y8v3pt5VNSlJ5EM1XVOD/owBsb4w7wh5dYHZ0rFEEiBIRRTkBRghyNm6M4ebdt/a8MEoZLg5K139vbghAkA3qXcYfdtp00AGuDfGjwkmNFgMdDK4ENTxjO9Dw0ob6DjJkmr1ZceNrX97uUnhE9uMX87wjJwdWsvhxWoDa7I9H6jcYIjW0sbQ/v+M7zaHczvGJp4VBoRZAcpoauBzTsZjmUnBto/qQZhol5Q+Dw2Pa+CbY7WFAY3aKZy8oADNnGzib7oKXhWlGk7DVYcn0oCZf5ohIFGktlt7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=jCSFPPpWlFadvJco+xJKNqeg6WC5+8+UCY6WKkM9KaV+OMQmeUvmQDZZ4OcRC2uFCyZdPkHvYvh647d2u72tCKxFcir3EQeus/3mtPznrcpo/DWMIkkqs5oQj4M/srfJvWVyOORQb6ZwvLVk+5Q35cB+7oSvH9C+CHe/5cMf15WObBrOWI0YZsa1R6C6dSEqfW+wT7UFL5lFbEHaFRQfjvolZtAlTSzWt6x9iQ8opuFL7pd1RwK9Ncf93V67/gn1aomwGGIIAD/RD5p2H4AwUdWbpXbyRdTU8iW7/qCgsu/QVOJzV08XOM30g2xAZNkAoDQbheNt6+vZ+eWdJ0Ys1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=tOSk0DVpiV36T9qffuCLtF3SUHm/TQpT43i0/A4UmwivkaqwAL6Mqfbls6SVU9xU3WE9WXTD2MuJvYtT82nKbBWxPjmxR6lCOwjSgfJsLDWaaYETx6RMjNivxUV7J7U5Era4CxGPU6GXyOYPPFc3WwhNfjKIi4lWm3v1nsmARdA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3888.namprd04.prod.outlook.com
 (2603:10b6:805:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 15:19:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 15:19:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Topic: [PATCH v3 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Index: AQHWuCq89BMn0ZMUPEu2mpEo8wO6Ug==
Date:   Wed, 11 Nov 2020 15:19:15 +0000
Message-ID: <SN4PR0401MB35989FEC8811BB4E0B5E0D269BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-9-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3b4976f-75ef-4b2e-86a2-08d8865526f4
x-ms-traffictypediagnostic: SN6PR04MB3888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB38889DE52AF2F2BF6438D1479BE80@SN6PR04MB3888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aawbQ87cTP4h2crJjtkTWSBPnmB48VyqWNutCHiWD0YFR6ybZ4wDooH6vs0Ml2cUgVu8QGwP0udqqNLk3ylWyH5wOI12l4hWgcrd8GGUzT1mC2L9xIHiOHfRlRk2l6txMLfubqmBzrTyA6nuWPBNegTAMAqxBp+rEcp7dEEHlBUiIwWIHIREn2bhL5/gskZ9OsgiV07yYsduXHED5uDF3UK2hnZO1CJV1Ocyezug4xwh7m3FKgLOXFesY8SetFM+FepLErkc/LgH6ZFfR49aYM1/CeR/5Ip/nCNjYqWayPUR+OK3aM28Dm5NrNMU50ZbHeckMqiv/npDv0DWbyM6Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(2906002)(66946007)(9686003)(8676002)(91956017)(76116006)(5660300002)(7696005)(110136005)(316002)(55016002)(186003)(52536014)(8936002)(26005)(6506007)(33656002)(19618925003)(64756008)(66556008)(66446008)(71200400001)(66476007)(86362001)(4270600006)(558084003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /iKAnRw4JONKtg9XULS0bybQ3tukxna+2fI0sTOHe571AvEasL5bnG7KflssY+C9VtaVyhGnOritqlW/4VMX0Sbbolbvu5S2JjBGPNmh2aHROnlATPG+s/NSaqT+Jwp8BHeBlUtySh7hCNSL1PbL6QG3sBT9OhwfGbXOnAORv5AAqdgylVAB1zS8VxHzmMPXmSjhxkFAAxgigJD1Mzq6aZF5mG9H0B50DmI16oSlNfXqPJRBsyT4I9+MsH5EZsHfxlwJrriurBadQuMq1eo6pi3nxxZkCSozKkSkhqzexFtSVaG7CYMSOJpSwsfVvXquNwkcucNn8TwozGQ6s0yeqKUfHeprqG66fBZYifUICHyQWIvDtP9Jd4fhoT9rVyawvKiraIMeQiC/Wm+4HfHKbGGoLVevZj5JU5Hgev5ahbirkL3jSUWAtXR6U+rKz267xdyFp8JmEee4b+3c7mxNQc/WIcRyNJt0dn0vrL/mMikRleMygAP/4Ywsx9FvihK3j29QAbZ3B5x0Tj2e9CYskYUuzLEVn06N0ElYuIRqyiBUFp92kIywHMMKY55KtP+YVpDtaTLrdWf6iDZegPzWBufFqFlEB2OH9bgPYBFEOvZA/r361KsJWadgo8oz/N5lEefLP6uAUVohuAmc8T0oAA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b4976f-75ef-4b2e-86a2-08d8865526f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 15:19:15.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sz6sisLnv8pfEEQbrAYQX5VWyfb3/h7pKbnr81rI9S/kZrdt63kfXrzFsmmDHN4wd3gdl+X8Uj/82CjJJGkmmDCtmYEB9SGafdJ36GYK9v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3888
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
