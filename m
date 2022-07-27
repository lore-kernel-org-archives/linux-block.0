Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE519C04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 06:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiG0GeJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0GeI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 02:34:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1040BF0
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 23:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658903648; x=1690439648;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
  b=VrI+rGTzVTMGPspDJVCyYY0YYXrwyZh+56sIZGeFbWE2bvorbbON+TH2
   4/0Ytaa5qdk1qcmOgXeBwX2VYnDghLMjEnePurR57NHYb2ohVgd19yI8O
   t8ohyByI03rORKx3kKCfRJ8q7Nhh7+EMhz5cmMp02DbnsDuhjyC5+4qbD
   7xSKhMBNROGTV7fv7McdAoy2sgzVEbZYPVxKUq9LuRNlvL/QsXPUKLzl1
   AN//0INku8Vpd6zSotZ9KtU90Wd2lxcDUaCTzrVtpmN3NPSu2XXNGuoCB
   WS7KNQAvwJQHn9FBIQWU1s642OZ0EezTHJBQSX3el+SB1tozP56sozkcd
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="311333316"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 14:34:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG/ojZqFQM3Xt6cy0PAw6WlQcNx9oArholwcB7fv6mfeqV2B5gaiSYgtRbpik039UudGbeclSDb8Aokymwyer1kjNFadqCp0xvhvgwp0ofSXU2vwuA60/HWWrNwAGgYB3fS/MyL1hpdaP3I6eh+UaOtCJw50+CtNcuKRC1z2GVCsyd3+ZmebTUwgeEY0bkUj+cKPJakvMMzq0d0knyANoTo/4ojiSxq5X/ohXTTstJkmJT+zHzE0Shj8PgwHAHAeSsLGJmrqSa51UPeIzNJqQDPPgKHxbvXRwofOqkpi5R8VX7tMg0xDeGa2FpNrwmtDuD+5xELyclJgTHdtCqEM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=HUPeMnl07WrO2gu8E7TdQmqEb7jp1nhUi6D3Chd1UWpAWRgvdrvtRGqC16Pl4+3UtSdenge9vQzekxE+uFL1QtWlZdo4BsouOZVvXBUVeClvxjuNlCqXp0f41CPulltI02UUR+Gs21UI0mcvCduN7Mb4ZHxZcpfNh7BUEpI8tLRR4Xb5PlkWFYO4/ebEnrlr6B+CC49S2v0+Yja+jCjP9+6X1pSiwlp/GnjbQm0mzP/kQDhCXQZfdAHhiJgEcp3gMRmaIDS2z6kNu6y9qGqxqEoqTCnbqaNC732my0btwHrqZIwvUfv/F10N5d1sTka8fH7va9f6ndFCSNUY/uSoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=ctmJInKp0U/5vQKbPCarSJoWrj9XSiUZfS/elyWk5X/Yb2OP5zJhFQbRLDxirW5DUDNhpoYD5xEFDmi+vGOIh4OWcToA8o6wgOIUR6dcZSe9gVlN/J7kxMDY9mYM2fG/zDND+vt2uDQoXVHroi5YOc662hBK3jYWWCtH3Ec1UgE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4932.namprd04.prod.outlook.com (2603:10b6:208:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 06:34:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%9]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 06:34:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/6] block: change the blk_queue_bounce calling convention
Thread-Topic: [PATCH 2/6] block: change the blk_queue_bounce calling
 convention
Thread-Index: AQHYoR3QdpM06AjUn0CErgfhZs5jBg==
Date:   Wed, 27 Jul 2022 06:34:04 +0000
Message-ID: <PH0PR04MB7416102CBA2A3F9DCE9A1C0E9B979@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220726183029.2950008-1-hch@lst.de>
 <20220726183029.2950008-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e04346f-378e-4f59-81d5-08da6f9a0076
x-ms-traffictypediagnostic: BL0PR04MB4932:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlrGXU6en5lPr3jq1NyymbWRjAv5nWgRNCuWzksdCURqtO/kAIPQKoU4uSCFm5Nj5KGsgNIPFYnR49W+AI8MMsVEGDaJbhpQ14LfjBaQGcoOhD0yrsZszdF0dv8mHmoMmUV6TB7r6dIazsebT9k1583waCacTO/ISnq/lBeYWpNHoXKWIBOK/k8KaCm+eJmCYz+27aisOJvqs+5acaGBDiH+dITs6tssmWtDdcKwi7O9C4r6qoKTJ3wKco1PH1v6wyCcMqgV37t4vI+fniGwY2KVnCH6+YCKwJ3RkHf+fvfv22Q6RAuZ3/+ZS2QNfswYc1jLzGooOmmPvRWXVuf2aEsszEzd9JyxBF9bmHSrP5y7Lenrq6j2baVmdH9dmCQv83Y8JKK+6N3o6VpAMihVEfDoisiD95PAypN0vkLOSYcHD+TJBLflyDReLPq6srOAGpEsZsg7GIhZf2YM0iecd27SQUcLrja5zi/gqTpWTchXRceN7UF5DKVn0wyz81iz4HdI7JCivYIma5uSj79t7R6uAf8yJ9KlkzIiVT1rMnPP8d46RYckkQcZNBYdX4NheP+x8wvXgWP3nIBjF++l5i5txX8X2CheIzDy983oeGECoMijS3YVZXVmbThlk1/BQVLEGF3ypuV96NbbFeVNyrpt5unJf0Gj0J9vLCrroymtR/EUA9tN4Syd7y4ExnrV41LNj0T2sViszC1QvvAbaLWKnOF56uD0ikSX7lskjzShWQXDZYXInDQlALygTru4qkUeBn5ZvXwvgE2rWiyifKSv5u2RWIKHfK5LJLOGvcSIWmV7AdNciZtbtzs+8sgG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(110136005)(71200400001)(4270600006)(41300700001)(8936002)(6506007)(316002)(55016003)(478600001)(5660300002)(91956017)(4326008)(66476007)(52536014)(7696005)(2906002)(19618925003)(9686003)(8676002)(66446008)(76116006)(66946007)(64756008)(66556008)(122000001)(86362001)(558084003)(82960400001)(38070700005)(33656002)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Hlrk6NvA2yFmVi570DBZBDhUj9punteGPBzeSFs0OVkCAN+HjLWAgVOzohu?=
 =?us-ascii?Q?wTLffQ5kUREVXxMwdSi4d6VIwTMHtV7cMwBfcoAIFdFOeJrlPJwgL6rNAxwp?=
 =?us-ascii?Q?EshmFV7+D9fTwTiLM9YWtCAT4xsGTL9mM33g5sjr6w3MK6oaqkHrjsO9A5pc?=
 =?us-ascii?Q?zfjQf5dU6CO/23PeQbOeXbf8dp/ZKxwLWdNu1wl92cGxielLKLZpGMzCXEjF?=
 =?us-ascii?Q?SZ20b4wJgHICX2w9MERiXyh4vfvPqyaCIxVRc9oUo0PapybfCd2WDVTk0Wow?=
 =?us-ascii?Q?QPf1ibOMebmWECrJ9yB2FUKCodDKkP1VlwWa0KTHacwZ5mKRJOV/oG2PDXUG?=
 =?us-ascii?Q?V/NX3m/7xzkukHfiOg/WzTIqwt6ylPpZ6SzXy52IMlG2ohBWgm2rSssnSd0C?=
 =?us-ascii?Q?/F1nh64yCzwDhMW/bDxTqNe3J+GtZ+Aa0P2nj4NcZiQ1GzJP1U0mVdTyzirE?=
 =?us-ascii?Q?pPia4v3qGaZGrgenX22/OtRGNdErKhstZhXqW1tSMA97L+CfL7BfIyM+93mR?=
 =?us-ascii?Q?Qe8rO3xHtpLTryAK8wPIkfWCFwc0jcEXrD5bkRXIqko3DxJfCXUcORx51/5m?=
 =?us-ascii?Q?791Eorg9PqC/M02xDbbcI1ni9ab2UoWvbgvoWW+YUa2JIc14s1gP0RmjHAqo?=
 =?us-ascii?Q?7jarMPsz/qnr/SwMRJo3csTQfzG3hJDZJ8Gkb8TACut672aKbwB6KJYacyNw?=
 =?us-ascii?Q?VucHXCPpNMZJ+t7annWV1yUE/STTkh2rfL05+TQwQ9S+gmF3lNA3OskDZxP7?=
 =?us-ascii?Q?92zmZYoB4mEUR+wbBwSekeQNW1f0ZGi+wO5GbG4o5Utnu1sJ9UujEzQgqV7Q?=
 =?us-ascii?Q?/jpOrRss6kW24V5Ul8IXUH+k99ena94JQlTaq/szfjV9IITOCGmPjC9CGzL4?=
 =?us-ascii?Q?McFbv6kv2lG61C6yby0XLdMVba2tAWzmsGDwF3mcVQOxzS+0fV/SNAsnVAzH?=
 =?us-ascii?Q?RROQShB1yheblO2fOO6M/+KPcFCAVG7dosKMJVyJupF+EbbH9xgP9sNzZthI?=
 =?us-ascii?Q?SYEZA2FR9vO6uFygcvvgI++RkpQ5lTalzIHx+kMJZw3ENXIm9y+d1FjY3hph?=
 =?us-ascii?Q?8ZnqPIwEOziatEXTnxcVREOdLQafPOf2eR8F2fHSZ0t8VWbhCigqNIGi6tgc?=
 =?us-ascii?Q?GX2zGyWer2s6WYWsf4bz489bOBtjY/xHe5PEiHJno6CQbP1KcTdFrdK655Ae?=
 =?us-ascii?Q?YxIrXRNjrFjsu4/ZhWju2zMR5uSMyaLKoK7IDmfSoWERqfwzMOrcRiFACceZ?=
 =?us-ascii?Q?nEHiObzTU6cdsBbJJo40mkDbdnPuOkS/otWB95PdOs9ypVptu3EuRoar79WM?=
 =?us-ascii?Q?KM1FtYaS/4XkBOBquLGYd9Cc8K4styzrE7qizSuL2vyOAgRLvZcjYSCp/K6T?=
 =?us-ascii?Q?Mv5Jk/o2pPodc0cpqwLnao/V2ODsj0xAhvYzOHIcwzgcvcHWnHwIELINGuEa?=
 =?us-ascii?Q?BFJs8+jeDDo/NFMkeEYLv19BUKSUOOaDcor+xMad62uHPSyIiK89SmbK2qvw?=
 =?us-ascii?Q?LryoDYDaR1B2DA3tsRxON004M4oJzSfYR4ZXQvMyxkc6jTcKESo2am24ItaG?=
 =?us-ascii?Q?zK0WNzSCgrYRzyJruRPJ7irBcizzW9z+1EH4chda9ZCQfLFq1x0B1Zd+HU+4?=
 =?us-ascii?Q?PsI5KXLxnwwW/pE+8RKHVsRpLGLZq3j8+u/kMpGMksw+TQOT2WTdO5nyg/v/?=
 =?us-ascii?Q?8tRM+7otzVpcdx5rh958BdcLKJU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e04346f-378e-4f59-81d5-08da6f9a0076
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 06:34:04.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkdJeOoFzeZ5ALFC3j82P8EEjpQ2bLsMKrHSu1Jofaa4pLFxfhzQeAPCq7DTrRZx69qsGMyHiv4AMpkiSGuf4z503j9UiLfCFHXoMUE3YBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4932
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
