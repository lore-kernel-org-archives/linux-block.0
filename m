Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30334C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 22:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97ABA2220B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 22:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LdjcfMQI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EixCAWvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgLAWfb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:35:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45930 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgLAWfb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 17:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606862129; x=1638398129;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=s8E17gOcecRKuQ9AFAtwlYc8Ab4ykgLsYpL3NqyLevk=;
  b=LdjcfMQInppHCV4SgHCqt4SBe1Ahi5HmO2hept52VIEPDerTedMFf8Uf
   YvR5pazCJ4Evp+8aEkaxfahIyqSxZGUzP546APYuMPCi9PDDtqqefhVQS
   ft26HvcrX7A3HhuDuYvrXJvjAzqgvBh0GIAwmdRzTr8Eht0wXGjxhHbxF
   5uPkaS7NMH5uJym/wGMCD2NdiW+kXmr3J7fwV6dtcQI3CnNdoV9I6z+aw
   6nXftY3w5tUkKyHTf9um4B6un0qmwN4LkFZM1Fg5HFvlW073E18mbTfcT
   F4Ok7A4Hp/5kGmKxPUaAXsRnnPH9pHYVm948rJejRsGg/QxQy7zmqUWD5
   g==;
IronPort-SDR: o+6aU97CdKtWTqASEZy0JNg6svi7eer2O/hQQCHskJVTBq2x2c21x8dD72tU2YqWkGcjvdWZHG
 JTnat9TcjUWLHrMq8L3n84omy7JRWvfWDOgBBNf/SXeOHwmEA+5N9+zH6ybxhAgs5kSGc4Ub+5
 J/+5pUFqDhdEKsmenXPW4MC3+WoNmjzdcckKQ6YV5h3C2Ce0dr9w6QS5iQk/wt80XJuP/d0bHq
 gjpA2O4bFF/fQidLtt6d195hhd8DV6Z42nYfnoska773FDAQTZYek9e26L7iQoq+U9TCtBRTTr
 gO4=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="264092942"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 06:34:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXxyxfawEmTMOsLeCImPAFbY50+kmNr+Adj9h4tn7RtjS85/YWdaP7SqNWJwfUvn5Im1Bwg1hng6H0RVqH9T5q/pziuXLitGmLHzsX74qf/JKV6FQKQK8LMP1KTNWM9eg0JeF1jVzc/kGw4sn5Y/R6KZl3iHbB3xLBwFeTJuenrbJLP5YTLBOEoNfMO3TSFSXNX3WOFUf90JIzcPXbnyn82cXaCVlKkQfUjznJCaQLLcB2SS+KFRJg13JD2XPRrZIqGYIUvXKwG2whoHZ+0pUp0ib0ubUsep7XsF8tgAy73pAH+fxI4vJyjg0FN6R8EOHJgUhSIR2+7YzqwSj8eEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9rMPviZ9W3OG0YnxWWe3Jdk+aXjDZYBv2eiGeGKw5Y=;
 b=RvubwDLJgVfKstJNzuIIsLr/L/hiXRfI76cEq+7GCnZ9xNy0Hj1zmcfe0Q7SGIw/AUlM32BWhb8bUj7ObcSBRBBgXSGkhxaKSTst1hFfFYiSdpt3+V6S6GtaGvmgFP40m9OxueEXcKCFzDfAf4FttBU8ACzQqlV5EV9GUxegPLAF7RCaPJp/D9+SF7xJWLh9wfnvlOD1KfRGifTFVr7YEzxVB8W8X1atRPmTOYBOzTNyEyZxBapjjjcnWCEahBiz6uVsNBZbU+L4qK2jm+rB6zkCEfgr8YhQ/K1uxMYWOTrrrBE9ql23sqnOF8bkWu7l4ovpsREDl+B5nKFA1Rltjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9rMPviZ9W3OG0YnxWWe3Jdk+aXjDZYBv2eiGeGKw5Y=;
 b=EixCAWvpypWrU7MqnW5WV0NI0Vbqcjpll1iuBzl4SEREsLDE5wqJhoy/b8Y5Cg1CRXHdMDjxhC8/WvKnfbIZM3HJpyTy0kbIoqgAkEZy/SdbeY0//cfLESSMylD5tAyP/nDWQBnUU2cLdaGB90e6nNfCPJ6+MLX38SdciKiCe5c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 22:34:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 22:34:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWx5hxEAbfrfG/GUqQyO0qzymqDg==
Date:   Tue, 1 Dec 2020 22:34:15 +0000
Message-ID: <BYAPR04MB49651C09824B2C82E44DB79C86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522A2943EFDF118FEBA264EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b73b2d1-22c3-43cb-28ad-08d896493c2c
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7261D47A043113D1F9D9309786F40@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mlZcalB3ByeO6COqZxQ5si11iejm8RgvGUu1nEflSF15S9iWahVfmt87Pa4nWImNu3FeereTWXhpg57skTLAeA6juvg3llc1KxItg6hs91QxrzdYtct6xf5B8jznBSFenBO+qg8/bq+/7RiCNQ9xgMFFv7byd8VbZluXTe8ssaU1jj2zN3RuOBChD/7WuWoJ+4fOYDI8PTtYs8fsAjTBOVxl0+dY9MJPVCdcQCRCiFiy+dK72NUuL+WSrGYRD9MWq2vGQSm+iHN93WxXpWvhDEnVX5J5BYc7UiKPi7g8h7Uhc0aKdVQrzQtDTJLmDSQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(66946007)(7696005)(6506007)(186003)(4744005)(5660300002)(53546011)(478600001)(71200400001)(316002)(55016002)(64756008)(66476007)(26005)(8936002)(83380400001)(4326008)(52536014)(8676002)(76116006)(2906002)(110136005)(54906003)(9686003)(66556008)(33656002)(86362001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tijbzTgXg7P01iM/tjNCLg9SWCb8UNQqVk4TlH3nscWtuvEoTatTETznF6aW?=
 =?us-ascii?Q?KeXkx/qmHX6NTBwV6trdPHmuwJl3LUzJtqKx0wHy6c0WwrUas23mr43aIakN?=
 =?us-ascii?Q?pIf339vmzTAUp2w7LAZlXwdU8CiJZgRyrnEETzkiQFbDqNhCt/fPrEinEvLd?=
 =?us-ascii?Q?IttntnLmkJ6v3w+imkamcuImhxTfmdA+h47gH8LUupJ0+Uz0qoDIYGQiOT9W?=
 =?us-ascii?Q?a4AGcZUmpcv/E8EhQ+Q6eHQy1dV18kl7ivxWRtfODy91Fs71c3YSm3Y9uYM+?=
 =?us-ascii?Q?F2iOY8BGJO1C3CRIAwNeXiQkqFJek7+/K4Zb9E812eVihIgCmm+UK3YCKS20?=
 =?us-ascii?Q?oxzHTfYhHvYMw/GU+qkZJYR5AqVfREAWIpja9+o5i3OEU44GrSQdMUDgyVPn?=
 =?us-ascii?Q?kqdFoa9nN25ZLrT2am29VLT4+KDYN+GH02jkaHcenwRggAoT+zf6tgnjss7j?=
 =?us-ascii?Q?M7Q4w8NQt8R1zgcJO1sea9jNvLhjVejbd8tZ3L57WUHVnYUN2Ng2AjUThSnz?=
 =?us-ascii?Q?pF5uVCqrieFitcnjG7roo/YPHpBWdWKIcTvk2XqpOTyZqI9lQcAs/yEAZ2nM?=
 =?us-ascii?Q?4Rek2ZFNxflMFkSeYMfLsI7yZm0qRGzuVxrr6x6xAVp5s9rLzpcn/0iaAPVS?=
 =?us-ascii?Q?2SMpSOcDzRRkSV6/YPghvSe3Vm8eanxSgyTHvqohvK54dErIUaZmUIElCPXt?=
 =?us-ascii?Q?Ol/uzCK24GP3M2EeKM5H64PqZcVrxMJpBY7alQVrIb5LQSZcRdR0ZfFiYOG2?=
 =?us-ascii?Q?4wuNV4OV3BOBalJ2191aOGxwc6IkGi5OyNnHCT1gCBmswSLZePuxIkBK3W10?=
 =?us-ascii?Q?Qm+fIfSJ1LpDApmHQEs7jicQamiS2mYU/L99qes6CgFvJVbNjFjme+n+miMA?=
 =?us-ascii?Q?uAWmkIN46wlEyKUEKWvwWEvZ98JNFV6RiXKrGR4q2SwXEHP3FsOkn2alp4EX?=
 =?us-ascii?Q?YXf9MspnrLjqk6SAe4Y2bDDxFVGiT3obK8Eo3EDPA1BV9DvqrEzNtRa/TX5A?=
 =?us-ascii?Q?IW+l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b73b2d1-22c3-43cb-28ad-08d896493c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 22:34:15.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+6XyRVVm3cOmEGY84A3JG1Na+BmwXLP9ih9Bbp7NKM+3/afBdmKqGQZg5XmsRpZouDAAAwb5Voz6FXFZzN1aFQGM6Z+drmZv8rS1MpAqC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 22:47, Damien Le Moal wrote:=0A=
> This passes for me:=0A=
>=0A=
> ./zonefs-tests.sh -t 0012 /dev/nullb0=0A=
> Gathering information on /dev/nullb0...=0A=
> zonefs-tests on /dev/nullb0:=0A=
>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>   524288 512B sectors zone size (256 MiB)=0A=
>   1 max open zones=0A=
> Running tests=0A=
>   Test 0012:  mkzonefs (invalid device)                            ... PA=
SS=0A=
>=0A=
> 1 / 1 tests passed=0A=
>=0A=
> This test create a a regular nullb device and tries mkzonefs on it, which=
 should=0A=
> fail since the block device is not zoned. In your case, it looks like the=
 test=0A=
> endup using an existing zoned nullb device, which should not happen (null=
b4 and=0A=
> nullb5). How many nullb devices do you have on that system ?=0A=
=0A=
True, my test script creates random number nvmet namespaces and nullblk=0A=
devices.=0A=
=0A=
I think testcase is reading the wrong device, let me finish the V4 with=0A=
removing=0A=
=0A=
bio checks as per your comments and I'll look into this.=0A=
=0A=
