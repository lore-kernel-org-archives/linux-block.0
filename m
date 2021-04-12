Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE12C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D552660C3E
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 15:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhDLPRv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:17:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57499 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbhDLPRv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 11:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618240653; x=1649776653;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CHX+QQNdfG7I//dYYOUlkR7/1fyDANpZ+oU1XbGmIr3UDqMuGqPDwPdL
   FB+b2ruk1Dq5FV/+xAU3ld7qZxQP6Bk2xW0bUEPJYTDuvDs0uJXkJoKGt
   Z6hMy2ZnpWmO9w8SIO5k1duGdBLLkbzvWqY76UyPXYtX6CHVKOq6jw3DL
   PIXfgK0zmYa/M7enghvyoEeCaX9lv4nLnzl5lZlTEPAxyP9AWgOUHR7G7
   gDAyj+8C7shCyWQW8q+otmuSgRMhiXIJRfgiwRhlf2qKkAjqqtsnRRiV7
   i6nOozgUCgLr7iQFunGqS9sQmeokQGFWIG/T2oo1rhXJeSIPP60VNvpzp
   g==;
IronPort-SDR: OqjVdNQQy61gOfZiKKYS8mEJt9Nz6pYtHipEQUvT2ry+PqPvenizWLAv0NXo40M6BCGRToogRU
 Io/VseKfI/02ohRgxS0t1Cc5BchXP94tQr17sGwEa0a5/S4AfL5wqk34WBfZGRSiRMTzH0CYYw
 sKhfbGFwgMsToaGBDiWSAV1JsIhqZh59z4PAlpMZVTaq6Id+tXrmybL3xmhBtJYUUwoAI8K1Fn
 ytATcMxFDYXNZ9Wmb1kvbCtvKkm2QwoWsb8a+d7JTuwppxYZXrs7vVN0+Z3qrlR0Q8BSjwQn5e
 few=
X-IronPort-AV: E=Sophos;i="5.82,216,1613404800"; 
   d="scan'208";a="164149977"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 23:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOYj1jqofatmw/M/bv+AjGLFX1Yk38X8dfrg0ERmnBeoJ3/S8E0/6xYbFCjUtzWmSroKCFsbm9rfAS5Gsu7zwkCwmplnNpOGeJjfMza+g97koCp03u1Um2k2jO66rmUlkK5OssCEKIi4Xc7RcyHj+VOfr21sww0pq4OiH3+4xxcUHdHOg38acBEwsjQFvQWFkerb9IiDy3jVRvIiv2sdlrnEd2Q4DiwtGvLW8bDiRHwaixkSAu7DcoweAB6eGCamdNwrv9ebcSUupD5g3SSlRxa0tzm0pO2qqyao7bCnLs5sIJSMvDDfernbgcBgbCC0eMBqWIrPSgSy/AaqIWGNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mKUUo+2IgQ/Dkv2Cc2IBrSyDsUEreQeU2eqhR/1F/hDDLcnlb7CbaldyRxN+gNQchOOzvM5NbVS1jNVsI0w7bz0k59BpsBTO+UpPhV6fHhsWjfUBgWoyQLxNWpZhxw7dmsgN5UJ+jTdunkO7LH0yGAzKh0eoj4cOUzdgI4BhBLCrHa9TTmCJkaDCCAX9rPy28lPBwiZyXTVoXvF7EolzhzHxFATQCHJVZ7b5eE4qoHU8o6IE7aLrlSjYIR78qPo2z1Dux2ESoeQDOhqUOWGTzNclJtn6Db7v+Dp8PTI04QZXs3gpae5JjKKnjqaihvq2LoKnMV4F0+YXpKW5Up13KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CF/PiHyyA85MZsrMtR9MJ6YZ6hI7juUSDR1/5G8O4F0ksB1QZesjD1VgEofr7cOIGsGmvVOtP1QkZCT8jWw4nbcPsXxyyvuiHHtxSAyK8rlvfkrfEf+09XTeBWhvEX3N4YALCjubsd+WmMppAn5XoDhoR2sOBPPNWx1HaWrini8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7494.namprd04.prod.outlook.com (2603:10b6:510:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 15:17:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 15:17:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: move bio_list_copy_data to pktcdvd
Thread-Topic: [PATCH 2/2] block: move bio_list_copy_data to pktcdvd
Thread-Index: AQHXL6JUp15MqIsaLkqtnxeIM6EXbg==
Date:   Mon, 12 Apr 2021 15:17:21 +0000
Message-ID: <PH0PR04MB7416836C6C44F25659B216159B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210412134658.2623190-1-hch@lst.de>
 <20210412134658.2623190-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db47e631-8a61-45e6-f70f-08d8fdc611ae
x-ms-traffictypediagnostic: PH0PR04MB7494:
x-microsoft-antispam-prvs: <PH0PR04MB7494EF48875A87A3B55002CB9B709@PH0PR04MB7494.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(26005)(66446008)(64756008)(86362001)(186003)(66556008)(38100700002)(19618925003)(478600001)(66946007)(55016002)(5660300002)(4326008)(9686003)(76116006)(52536014)(2906002)(66476007)(316002)(8936002)(7696005)(8676002)(6506007)(4270600006)(33656002)(71200400001)(110136005)(558084003)(3593001)(17423001)(156123004);DIR:OUT;SFP:1501;
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?F6hCj8FmWIdcNn89tpc54EDE6EfQSkU8RsYknaml00v0IdKs9hRZRm23DQEO?=
 =?us-ascii?Q?qH3UWG+8PDkgvhXW05EgJMnyq5ah/zJkz0mgnKYokHORJWYW49LDENsRxKH4?=
 =?us-ascii?Q?vthOWUEOBFYPBPUtSZcqI8MR5klE0W4W55xFI+vDUpIpfvGTpV147b3W5ay+?=
 =?us-ascii?Q?H9OukZdSE+seuz1fRzjxl3kUIQe/fcw/fLcXa3zl6k0djDByJlLpxR7wYLsO?=
 =?us-ascii?Q?kjSoHg/La1ZORWhbpdGvfFJbZmJqdWRuFivxzYdJbZqIFXt1w4yv0qqiOtSv?=
 =?us-ascii?Q?kIoYCdvPzp61xOAJfaebft8EwM5ce5u6xn50WqXlGUCo3nxodyxBCUbkvfiA?=
 =?us-ascii?Q?ukltoBtaSNmm9UzuvCbHoX5le1XajbpYt3ttwsaDzUhX+yqb7naLiIeQtgwH?=
 =?us-ascii?Q?pbIl8sHrxcpTf866722ms0u1mnqQulFqPB+ktq3nlxgvVO6JAmM2OE7eHhBP?=
 =?us-ascii?Q?j815Wt4sR7CEZrPWlUN0dJnbg2D7oaGt5bUOMzjQcpnDtGmScCznbfE7Kr2N?=
 =?us-ascii?Q?nrno54/kqatTMOJp1Gy/jLN5GG+RVqkqOHbCRf+kukyywQUeWoi0iWqkdt3R?=
 =?us-ascii?Q?P7bvtmtUNvzeIINziL1SNPaYbRlbaS3TLvHT4twxEgIKXgoTkgdP+onjrUQx?=
 =?us-ascii?Q?pN3Sp/DQFghJJWPZ9C7kwAuR+q4UWC3N0XanKcqC8ZmO+beY9CIs7N64vKCK?=
 =?us-ascii?Q?pRM/OR36eN60K8Qyn8IfaIoTw1PFqdy4XGs1kG9NytDNVpWzh/JLM6OdUhzH?=
 =?us-ascii?Q?Rb2jht0wXeEwwHo/JHOMagRAr15kCQ/j04yTlPaNF2lkDrLsrbqv44RPGTTN?=
 =?us-ascii?Q?PYPTvq8GraQUQb7uV3w2ZL6cDoGUQJxKB7jLeO4jb2iMploHkGxrv2ZwTaKD?=
 =?us-ascii?Q?wQy/nhXtnv57MNQkNyqeZBUJLtX9Ap44bLoGd9ibIJu/kyWuCWuCLQADnwgJ?=
 =?us-ascii?Q?BYOYdlFDplrsWOVEFUU/gQf68LnQ4t5oH/sTVI+IvThQwh92P2Q4jKLLhjSQ?=
 =?us-ascii?Q?jUTr?=
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5KX3SryfE8RYG/yILZjJGuHUAB6616tJMzs3I2Hg5KN4TNHuD1BR751Isipz?=
 =?us-ascii?Q?laXztniur1IXXh1b6tPyTk32UB+H3X+Nc03fkmA8oJsz762qnspoMQPZbTgc?=
 =?us-ascii?Q?zxbXLSuZR79ZZlgsAMtMkOYEPimKrAL+xMqpMKz0u0A2luKzWD+MkznZ9fU3?=
 =?us-ascii?Q?NFuDteGbSX44NfcnoTO0NgTYvKrnIAR6K90rEXZAi3tEB8ttNPboAKP//Uyj?=
 =?us-ascii?Q?KW1YR0L3gMY0e1l77OROd4NinwHk6ngECi71lllLq+XlMYb5TIRNGYlSYL+i?=
 =?us-ascii?Q?wykNnn1ZgsvHBk/p9OIEBeDFnNtuA1+oLAs7aQINeQyMbgHa/aZl2bpmj0lD?=
 =?us-ascii?Q?9i8aP85p8fm60PFSHmKxWijolpztpyrOwlpauw2osC58P7qCQ9vVJ3n2SiFq?=
 =?us-ascii?Q?ONkWPlcBGRQRboEyF9OsDFox0pnzRMV7SrVVZnqjZZdPWPGlmVWOQSls7pw9?=
 =?us-ascii?Q?/9PeJRKwXP+Iyok3iA1Nakn2dmEXd8+D7qZH3vrK0bbpIU8W4o83C3TGUVf7?=
 =?us-ascii?Q?6ymIywUrcmvDV6xabtceOCi9mMDQLEhOhFTQ/jkP0g09YLSmh0i335kIWt86?=
 =?us-ascii?Q?ASpu3HBu3EFu546FIEYqfxxypmHdgXfQ7IgOml7qXh2NB2WbTrl+1Ks0WEDp?=
 =?us-ascii?Q?vJv/CXgvRDCS1n+aajP5gNPYCwgl8+n6wbM1NSwjCDMnYyJPt4HX0dhIJ1RF?=
 =?us-ascii?Q?W1kbD6rEFnr6u+5KPP7R7ZjYhroQ21OHnkUBIUaoaBgT0YxQPd2aq9hibQlV?=
 =?us-ascii?Q?0ggirO0Zx01MA34+GWyiKVOFJXxl4xDggSu1sXjVFQQ8lv9JMWtmjhZtbttW?=
 =?us-ascii?Q?U7jtk0juAxNNAW6kWCROxxpYSnfQ+4jJwUAUrKObko/3lDtekS+TmQCtY0vG?=
 =?us-ascii?Q?nzrvTx3SANC6xwAPpokpuN4UxZyoEJOGUr0OWZDaQ76bOmlOk3bVAt4A+LV2?=
 =?us-ascii?Q?WxgL7/7SkiM4FKWdZcyEVruzOnhryTJGV9N7V0ULWUvyjFV4hiyIqkBwx4FW?=
 =?us-ascii?Q?W/20s+EdYcvgtg7P8s9Fx1O80yWP1U94tnHz/QnlYmLRDMkMyWaN9Gvk4rCM?=
 =?us-ascii?Q?d2wvevNg6L+YfRO62/J+PKOH49j58pG4i0hGINtx0q201igB66z6ZH3qJo2y?=
 =?us-ascii?Q?uEIM8B6NbJqjyiIlzNIvcBFbpL+HhOaidSjnA53Vk9yODfaje8HmvW4c2CrE?=
 =?us-ascii?Q?g4sISTH45r3BgEFPdw6OhmEQNbNw8c6bBe3OhpBuEUArtrgCePx1OqgGxQCD?=
 =?us-ascii?Q?e2MNXdmKETxFnoHIh8GbLEgqcAosu98w7C8spZsnf2Kn6iOuuDvL7iphT50W?=
 =?us-ascii?Q?3dNT2e8nHihqqCDFDCSX4qEehguSH3v01v77j2Y/zkFgJQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db47e631-8a61-45e6-f70f-08d8fdc611ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 15:17:21.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5VNrZI3CyHfG0v+Ofy4nLonCMJkdqLWNybwBx2wpFSemAeIAEISw+QL2OnP7l7tB2pNtETZ+ga0BA+i0pUAjuRRyt8zvKh25B8I3/0zmbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7494
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
