Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BBEC4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDD822517
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLDDPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:15:32 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42664 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgLDDPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 22:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607052112; x=1638588112;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Y9QiQngOR8kZRufODE5nFNoX8dEwjY12gXLYXZxv+ok=;
  b=i8gz5UN7JHGMG+ZRyxDDf2jPY0X1qHwSrBrX8QTMGwVB+xn/AGo94YqT
   E5JnY4kgSxrnZZI7HCOdL1+f6qd6YVvDyA8Bo6wS4Upa6fDAE3UEoBhCJ
   Bdb8NQxGEJnC/If2fmLDlVwzyNvS0cO02kmkSuDyFsv0YigoiKqmsRexj
   1rNFYsmnEXOpMxhMOi5bQcdTByigO9q4GoYSWLOn2nKEpDaPI4miswWj/
   J8kudNC/mzjrIo0SAD1DV9UaNAlcL9KAZvGip8nX5W/ehvlddV4lTp/3o
   JmLevyi6nKWXw8QXk3yKptX6IxeQZnMeKLzCfDK5U888Feb8gWUUhyWYq
   Q==;
IronPort-SDR: 0JAU/DtBLueN++XOU2xXSTppye/hHvCWx8xbslBZMcaPwN43gBtvFMwqH1zsvrLmT79L3hDjkF
 YFi5yf6h/W3tZh7TZWveWnSo/KixX4iGGBBSU7ozpM6TpiQ2D7FJTtDoX6kEOf++yjL8uCp+Dn
 ggFd9t8yqUoxGaiYzKLM9ZhPqlrPiNbEWr3FTElOI2aWFS8rPuoYLIg9cWQFWVFI/sHPyQgENe
 FMZv6BmllHcZKx7JiJstakdc6cOrdNUJUtOG956WkEUK4yUh+JqZNZptgeGWJ4UTrpFSNBlOYV
 UoM=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="258108086"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:20:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsC5XaXYAjREeM7I68ff61qKqoze74vrBGJ0uLkA8cNYEjZN4MitOkIxia7HA4rsGTOjDkePdfkLIGsw5M64wApffxQmitLM1T8KixXLoIAbaKAsreUq9OllvNwRSfQ1tOBQ3LNh6T4nygpE2P0YKSNnpX6fa4dY3MFl7fbUXTXYW5p3p/nXj4qKuF2mHOEG5vW4CDm2yPeuNi1LHsK3hmazOpG4W88f5ranKk1ZkVVjc89Ju50AvrcYF8wKGpUcU67PYv0ZmRzYjZvAKnhqRxRiV2LnBnibbVqk4fwiR2KdQ1fehCS51JwMLnLYo3nsEBmCKgck//YSXh156/sVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9QiQngOR8kZRufODE5nFNoX8dEwjY12gXLYXZxv+ok=;
 b=BdHey/Gpv6kHlRP7X09peD+8eFHq0QA1sQfyVVzV+I2pQcRlfV3c5KhjJkmK1imYRgzU/GDm6t98eUyrq3GOeUzBRe9MMCexXmFiPLvEx1JJVWV+xF4Pw5xUxlx3M6FutisU2FaQ5Wc7lTdBwD92HOf2PdLssbc9H72EbYDkoH4IkDyF1hCVnaO/MvFwQC043Q5m4AG90s/tNlandEUQuWXzPQiM2AWXIXymve0NRigxd9XPe4a9WlPz7ZkH88pt7rncqP+L3PQrjzgMc1IzqPqdG2RtPOeIuvAd7Dr58DXeFht6/SnJwF77LLyMlt99rFj27EyNHgpMUQhALlg0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9QiQngOR8kZRufODE5nFNoX8dEwjY12gXLYXZxv+ok=;
 b=MAS3Qyn/MkZ97AVzkSni0/oi0pIW6JMTtYPGTWaQzAKJpB+NWLnyRHGeZJeBkIXB/o4Ojhf8xNQbpO0nWMaQPr1TCYNpZ5MBbo1H/jwnoPRpZs7gKnWcMcDfsRmxB7p5QgnlxGso1w6M0FCWqJ4stK2QHXgdzNOvor+9Ds0X8bA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5030.namprd04.prod.outlook.com (2603:10b6:a03:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Fri, 4 Dec
 2020 03:14:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:14:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Thread-Topic: [PATCH V4 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Thread-Index: AQHWyHOl/uqfdSVM2kqpYnXGo7vd7Q==
Date:   Fri, 4 Dec 2020 03:14:20 +0000
Message-ID: <BYAPR04MB49652C7A660E27E2943F27F086F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-5-chaitanya.kulkarni@wdc.com>
 <20201202090926.GC2952@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 269a07f5-0a8d-4b8c-67cd-08d89802b158
x-ms-traffictypediagnostic: BYAPR04MB5030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5030CE98623877FF02F0CD4786F10@BYAPR04MB5030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbsVygKeTzwNySbSHw4cSNxegRQtYVKALjPFlyOTgI1LLN+Hr58mlowj9JDwMo25GtTYRCx3e6gdbuxQ9LWGDLc3v4VD+01BRrZ13qG52RXQSEF2smL+UCGbwgYTs3G9O+jbkSEiydDrS/cY9tNBqw8jtcsQb3zIGNE0n0BK+3l/teUoSldp2Pn9y1xsLwk724lfq/WhJJ90ZiK4seBLgbzRzaj1D+8Lj94H3ouFUuQq93zGfuapnYYE6N83kfoYVoOu4UB9G5ZaZjVwVd4TJA0G+VJZqfUkyYUDMjea7hRyBzW8ElGcLKH5g6yP/j9NFo0cCv4Jk6Nclcyc/uWhpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(76116006)(4326008)(53546011)(86362001)(9686003)(52536014)(7696005)(5660300002)(66946007)(54906003)(6506007)(316002)(26005)(66446008)(8936002)(55016002)(71200400001)(66556008)(64756008)(66476007)(558084003)(6916009)(2906002)(186003)(478600001)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P42aMbiozceP6L20i+zrEiTtlHOWh+j4Pz4FUkaaalClUaLMBax63DwOrPuS?=
 =?us-ascii?Q?Ii1q7ZnoXzMsiYEfWG7dXAoK7m7qo4572GLeTldiK34URiubJ8OwGmIEirwW?=
 =?us-ascii?Q?QFlL5Bzq0ld4nLGxmWFVdyHdLfPCxtf7y6WgTgzGxvgHQq0aVHVErylgL/EY?=
 =?us-ascii?Q?MpzumtN9SY+/la/5sAhswywrr2nmlUhdLqjenG81n72Pth3Qui//Um6uzOJa?=
 =?us-ascii?Q?jPbm0F16GxYEYUg+q9HUy0/YyfAfqVwQFujW8wg4QliziwV1eXTH/dcS1ClF?=
 =?us-ascii?Q?JFT4O1b4W7p400cv1iApKAoOktiCn8YjYNrGkJvqYNwdy2gaf8K+7yeeDzKa?=
 =?us-ascii?Q?dPiCFaM7wvH1gZowIR5154dlECBuQiaxOyhxFQw1UqOeSfp9o7MhyrQtax/X?=
 =?us-ascii?Q?05Uu/DwI8Sds46Oo/pKvxoUTV/78+QsWcqm9NrgQQ8UKm8UklPINbqor1e5p?=
 =?us-ascii?Q?5oe/D0bz9jQ6hODMbVcwYyjSY5zymOcLNJ8y0YUNnRCEPF4wU9JcV0a71gNj?=
 =?us-ascii?Q?dCQTQS6noofkk4dmt9rwg79ga0/HcVQ5twjubVS7sLkAsOLTMOeenBb0umNN?=
 =?us-ascii?Q?N/W5SVtWy9fA8IET5E17CqOdef8gyda0Y/NJtHYzsB2Tvw79Sr4fdZX5PNBX?=
 =?us-ascii?Q?4GIr1iD2sUQ+Xm5MGRPK+keuzLrKGQVsLKwlJlSCTlO9mP//KtRMl6YKJvNW?=
 =?us-ascii?Q?3bVsLTsss3IOVUAfjCsRwBXjw3v4eY+jzVRKRN+yiQ1LqWXoxESHlV8InS9R?=
 =?us-ascii?Q?6jJLAMPmeJidNOUt0sfXQmq7nwoQFUMQjXfYu1Yq6KSfX5Grbz0Yg3A0OpPD?=
 =?us-ascii?Q?m1D9i5YhmpRBITEKPWGx7eVT3P7druA4mSrn49fKM73kBUrXTvBXqIvGDQga?=
 =?us-ascii?Q?SWLPLZHqEkxxbyIqsnMHLe/9gdAhti65lE57/BnW5idH1sth72pC6tS7A4xa?=
 =?us-ascii?Q?DGleBh/CH4mk3WSOd/rjIU5ZSThthy7NjRh6KaxaRYS55yAg25kUc6RItlxP?=
 =?us-ascii?Q?QXKr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269a07f5-0a8d-4b8c-67cd-08d89802b158
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:14:20.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQfFm0GGhcPq/TmkRadWii11LYltEHR9y1IGccZlcFBHvgzgPAf0xih3otWK52wtflEQV9z5I0iw4xDQ+YD86eNQDOKQCUnDUDYIb6qpkoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5030
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/20 01:09, Christoph Hellwig wrote:=0A=
> As mentioned before CSI support is a feature independen of ZNS and should=
=0A=
> be supported on all controllers, and in a separate prep patch.=0A=
>=0A=
Okay.=0A=
=0A=
=0A=
