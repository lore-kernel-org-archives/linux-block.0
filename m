Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B3DC63777
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6575F20644
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgLCJx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:53:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22388 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgLCJx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 04:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606989237; x=1638525237;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ao2KDy0K0dCTl9RXKsZuMyFWMd2r9BoBVZ3NaqoiyGbepMaSDw5/jggA
   3npxXzYaBHCwJgcpJnB3+lrKKKnGXZBi8iK/+HscpLo1PQlnuYnFyTzZl
   gooGNxXXXYt8N81nJ05NTEnUM+PCp4/0ydcVebjs8uFEBlTrMhueo6uJ7
   BMhkDQAOlqNj1kWlmF/hzKc1+RmBf4IGwRMm2FoYKo/4xuT0exoH/0NXS
   ZNclpbSpchrE3i//xoCnCNVK+zLxmmOnKQBbSheFPItVCXxhc2AbYJSx5
   3BwEQQm/eRADWemsvt0qMr+Ra366kWzksFncBjcZpAsDDC8WMfrnQSBGJ
   Q==;
IronPort-SDR: CbFQydc4vgFTnr6r5VaI9LpYqxRZbyhcdte33qRtbtUwbWa0TSsS9AqHiqoUuVPTu0OsEW8Mww
 dpifGenYSEiHEY3TvjWQr9K1Jg58A/MX4ClO0xJ70K72utvfAcK5MxpaxZ71UaJsjHgu0ZJ7Hc
 O7+FDaKvBzMjIRcTzNeciUzAkfH/Tr1Yu5p0X9LGOa2/Ufm7G2hDKrLS5nqwZS/ITHJ4FlXB/m
 LEVrKdmbzUoevV4S1HRoRAVifrNibPaZxsjAFLNDnQ+B3fo6FLc70jP3V7qFo+64r3jb0C4+HZ
 vAY=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="155448544"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 17:52:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwj6FPERVVPICa3GE4vd6t7CUzNByxxvN/0RglcHBSlotKl1YEIXknDBhbQyS9NuJuVhEI2zzjyvtUYuEAFGySm3544VKadUe6poyDtkVLF4NE9EqJar5tBPpAVH9Di/3RaiCQRZERrly0J05f8mhabzvQD9r0ibNTWrW4tB1uc1oAwPbmXDcEA8TsE9EhiaBszFuznOIjGBfN5bQZcxGxHsQryRG0R5g+5gWoh8RZHrjipyFEeQcbstmd6LMIeYj7Q49VkKM0a5BrAEKtO4+FbDYBjoOgkwlwU80RHXS6meUeofhrVUteGPjF0Pi/dXBcebVC5rYcrzpRqsYpKAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=M/04hRfW7ZeN5A7zHCIlAkVPT8/R5FgaZWcfrtSERtYrB4nbG/sEWcJ+oWHmGdXP4JyOmmfq1nmezFFcjCk0EsBgAuEV2b/ZBL34dL1VQIsov4Zmowmzvso4cisCRopNyu6c9DLFW8hzzlxPsjdMHkRRqYvMa1onXqK/bb6lujyRcXp9Ex2ObJwSglvaAkUHVzlwCDaCRQ73i9V40+ernZ20dIz6mGCwYDHF3lLb3R4hiPt2qs3AKsWYDUNIGMLo4osCcDk6BTNLn7AhVS1qexpN4zROu4FUoyRQ/V6B5dsqDwq3f0tBkSByFre6HIYW3X4bl+cm77N8L+zzbvjxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=m9yW4I8VaCPxcBbt/E7DcE/38kpzdz2GNftypHNZS5Xsw3lcfWSUGopQBRPxiRLIKpKgVabkV8UVMY5hRrhwrbtfD7N/dW8Kfx+4u2qNIFHLQryLQJnF469kiCnK9Zh+ymtb93GUJz8HztBeTSpcT+447EecrtbrxEBB5san4qo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5005.namprd04.prod.outlook.com
 (2603:10b6:805:92::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 3 Dec
 2020 09:52:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 09:52:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 2/2] zbd/005: Provide max_active/open_zones limit
 to fio command
Thread-Topic: [PATCH blktests 2/2] zbd/005: Provide max_active/open_zones
 limit to fio command
Thread-Index: AQHWyU2BxDjvVfL00UeoPp/aNeGk6g==
Date:   Thu, 3 Dec 2020 09:52:48 +0000
Message-ID: <SN4PR0401MB359870F8ED70BAC778BED7709BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
 <20201203082244.268632-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:ddc9:a3a2:6218:d6d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5793ac7-c6a0-488c-0511-08d8977131bd
x-ms-traffictypediagnostic: SN6PR04MB5005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB50053C4C89FFD3DDA1223D649BF20@SN6PR04MB5005.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGKLldeSLNgrh1bYWsQlMzfC/By1ANZNbj9XShD6p/BbKrDY5MYchsf3umwYEcUT8I9E/OzNGqt1GzGb+oPD2pJeFHTmRx4Ga9E54j/1ZvUhIHXtpCMCZmthDXeOVrSot9Puq8nbCwR81KE0i5Efb2h1sBnkSqv5MrEUivwU8RN4bnh4A4jo19rFAKTiNRnlwKD43iuADJWKsPNdP4mhkKt240cfIuIlzPa56KHh/uFY47mVrTclmiX+nRiV0DWgWXQjDdIVmEBlXcB6MeaCZqOU36xVabE/5pIjPAMvzJt+ip91xP4dJHP/ncNg/G+sGUvUO8Zv3DuImGt7XjurPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(71200400001)(86362001)(52536014)(478600001)(8936002)(4270600006)(2906002)(8676002)(558084003)(19618925003)(186003)(76116006)(5660300002)(110136005)(33656002)(7696005)(4326008)(316002)(6506007)(66556008)(91956017)(9686003)(66946007)(66476007)(66446008)(54906003)(64756008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2+hqkajVmC2OTi4j6Y3GaLUGu6csAO69OYha6CgdnrxyKucOEGahplfL/ZdW?=
 =?us-ascii?Q?cTnDMFOFIXx1UbtMeyDKSCTjAS1fRGgkk84se9UKSXFwJG5muRfL4mBuNqtW?=
 =?us-ascii?Q?BA1M8A2Mfe1QQhPWgWxABuUp6S9VSQo94le73haRunS/idqHVryWpm3Z4olX?=
 =?us-ascii?Q?hpQPxTAsQ6az46PsJAW+PSHi1zmfviVIQU3d2YtdmKs3PPjlMtAltW9ejyV5?=
 =?us-ascii?Q?+bBRkYheOpc9hZ3FtYYUT5Ep6Hg38ALIzWlhaXGzAU9Ewza1GX5wrCuyA4S0?=
 =?us-ascii?Q?obCpu7UxOro6DO6I3KfCrvIdBXGI/cxmTEZ6C3l5JrejH3SzYlrw8qk2IdYm?=
 =?us-ascii?Q?xEsLqmeNZsVNhplEURbZzYIm8qJobQCj+aZQIXpkrIgIB7egEyqUiSR8nvv1?=
 =?us-ascii?Q?RQxLxy2oF6K6lHtccfoGvVSzJqcZsdV5HWkG4Cu5N3hOm0TcGUzkhRcqyAdY?=
 =?us-ascii?Q?KADPiThOBqRHVcVrLgGX3e2uZfdbq3SAR2MoAeVJk10gquuGdPdQB699T4BA?=
 =?us-ascii?Q?BiJI33bE8kkOE5/DbV5uSpuqZp098A9wXIbjVUTZaNtdHgLBUHPiy/5vdA4p?=
 =?us-ascii?Q?BmgFGmx4hTqTJt9XbMzWY9H3vBQx9/cd2hOOIQ1Kzb66K2CM7gnOvUxCcKMc?=
 =?us-ascii?Q?pm102JSx9g0QxG0mrJgw3+IIVuWQJ3JxMWagAKhHJr769xH2c51ayb43Lfvp?=
 =?us-ascii?Q?IqzCkvQGOTgWxRPvjWphbhLW7hZHQKBTMfs7wo6oZKjtM6f6yaHxcj9IsDyh?=
 =?us-ascii?Q?73oaFafeGbN4OUsB/qj269GMOcU/1CZ/hiercauODeWHIYNK1UqEHBS4apcE?=
 =?us-ascii?Q?bodHIDUg0NBCkwgL33G6JLIYw/Jmv5XHqGm11JPXYXURuljB5dGOZCdujz9p?=
 =?us-ascii?Q?l2q6FH5GJo7aarkCdlba1FYS8rXTAAgxNe/RoEGM2YvFGU7oyt1Cuwk7ICKy?=
 =?us-ascii?Q?rWljcCIIO8SHs891ov1brHOZv3YXR6lLNuPQ3BHeZNdebrjBWv9fgcXykpp4?=
 =?us-ascii?Q?a0F6siWxomiajUKBe15d5OeMxPNqprdgZn/DF4Jcs4noO4reC1IlnpmijxKz?=
 =?us-ascii?Q?VG16UiCF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5793ac7-c6a0-488c-0511-08d8977131bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 09:52:48.8218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAhGuKn/0VsSj/BhdUXiek9NcgiKGrxrgsWAwFMeAtVeOAwd48x0TcNDy+sFazwi9jXnsdIX5ijlk2rUIPNZOQm3Zcf54Lkb8+w3l8/U5YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5005
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
