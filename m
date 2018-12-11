Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C86C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4A2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 22:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Be4gaUNa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l423XIYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE4A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKWz0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:55:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30469 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKWzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 17:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544568926; x=1576104926;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hr220HegiC/Zbg1RQ/dhAFd2H/EnP1XZpfMUYzXrMgY=;
  b=Be4gaUNaXWn4Y08xAZm3sUSC1rYVJYPwvvO8K/1tVMy90txPIZITu29u
   MO+rP8KR4ZmTB2kn77aqyrXcA0LAlI5FNXybiVNqYcfC01/gVg7pZBfOp
   0uZX3fIs/wb0QXHREux+66u7oJOSugTaG68yyYWJT53f/2w5g9zqBv6q6
   AIZ/ZCvoFK2TWyQ/o7WbN57puAul3tCRTIifP3lAIkXlrMoy2pRtb+Zpn
   Aq2tV97SIxp/NmWzjs0Bzo6nlQ8JJ6y7c9aJMu0zVpYHfSSiV9ccM3fAG
   nrwywG1Y6afYp2NYOt6IG8gVjkZMIxA0apy8SGVA0Rw2AgpzPvXfpIGan
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,343,1539619200"; 
   d="scan'208";a="96358157"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2018 06:55:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr220HegiC/Zbg1RQ/dhAFd2H/EnP1XZpfMUYzXrMgY=;
 b=l423XIYRC9jlVEaMibDSDOyCNZ205xGpoHK0r8X+GZV/4MDjapypFqME0ZdKgSlkMidG8sUSDpn7+WLd4tj00p+C8huS6UI3M3bd6V5pP0Z10VzhtDYpdCqFJoUyyVfiql+PDstvYts+bLNL+43n5l3h+DzSJRkeo0VjdDnTIfo=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3957.namprd04.prod.outlook.com (52.135.215.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 22:55:23 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 22:55:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
Thread-Topic: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
Thread-Index: AQHUkUo+tJKkBfZhpECElV5qbdGoRQ==
Date:   Tue, 11 Dec 2018 22:55:23 +0000
Message-ID: <BYAPR04MB58169F997AEC920DE8E3D022E7A60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20181211120826.28852-1-shinichiro.kawasaki@wdc.com>
 <35b326a9-e428-7195-06ea-fc6c5d201ef1@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB3957;6:5n9G+FmNm51f/vKp/jKcQj/GDVdbvqS+jio1trV3FwFNk09s+b7s/CxvcB0gG+KIi2OntDrGtzmC6iLzKP37LeZD2HfgGO1x4bycLuW6KcNkLWwK5C0EVJ9mWNbN5Qw/cUB4OGUXjm9Z5yi8a2PrfTJJ5nbUJjjOXIGM0AhwLfPldK1x8tAqFe5Ff+NjXhUheGGN/mYpFFoaM603Dj1GKamP02nLpTM8sDa6R2ueMVobBDkRyTvTqYoujYEfDNWMUXuojQt5MspNFBK90Jbh2w6P1aSVHcmdYOpx3MCuDWGM9rPKb7uB5/NaokdOYPoz6w6aH2GbdA/RH7w9NeEyXpMlAJ4s/YybTTLDFX+ajdLfqbJCx0BwFGyGT3+GI3SFUZufAUoAp1+vcRCIXTj0DKGvTk4nXx137NvpyzXZZEuSniAOF89XrXFGZToo0RqxsQTzgI/OLgRgQ37ycVJ9ow==;5:1LayjMdZ9nxEVCX0WwuDdeE4SMuX6t5nfWfLklBdGOG451c99FXN9laFFldzRL6FTGbeDIiARzImu1BQpZz4y1Ukci8smiu9oqQhGcuZg8tqQK9wZop+4G00HVw1kqVYk94wg1Zz2u14amhP1UsmXWeRX+oylRgPkR6toFggUa4=;7:YboFrHtRLj9H89EYsVtq/d7xazvEMpdh52LMcxKngHDlsscL37DyN052OsE+Ps1+rupvw+x1s21gGqTDhROhH4bbnqImnJt390JRioUfaBUq/2vt3IzN6WREpoYNRlvsvZpQioQn3kf17+QMRo/QQA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a58433da-279a-4396-4496-08d65fbbbbc6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB3957;
x-ms-traffictypediagnostic: BYAPR04MB3957:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB39578E29AC2A4748632E32D4E7A60@BYAPR04MB3957.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB3957;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB3957;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(99286004)(8936002)(186003)(110136005)(2501003)(486006)(7736002)(86362001)(55016002)(7696005)(5660300001)(102836004)(26005)(9686003)(6246003)(4326008)(14444005)(81156014)(81166006)(305945005)(76176011)(256004)(53936002)(105586002)(25786009)(3846002)(476003)(6116002)(2906002)(106356001)(6506007)(53546011)(71190400001)(229853002)(71200400001)(68736007)(8676002)(6436002)(446003)(33656002)(14454004)(72206003)(97736004)(74316002)(316002)(478600001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3957;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: t4klDIMXX9+gsI3lf0k+Pj51r0Rb3ffBY3f+BuppNySJhX8SOLfJt5DeG2Nvdg+azxAYa4XG4CEtPrBV1QlCzW/o5kRddgebcSQ3N2GK0lyoAxRk8hS2flDOZZ3zEG8WO30Momo1OauzkRP/gJcQNFcca496O7C6H/9/m0VmtSmJmysp0zinwa26pIBZdysF9n3zbsvM1akdTJa6E/SbC95/GIF13i732BWPVV0VZmLbcs/1lXCMr1zyLxr9+U8iuQZt4VYFoYiavR72oJZlqWTLAQtPDURSWXgZ0gV4rjNEDX2ZF7aptjlKiA6RcSad
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58433da-279a-4396-4496-08d65fbbbbc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 22:55:23.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/12/11 22:44, Jens Axboe wrote:=0A=
> On 12/11/18 5:08 AM, Shin'ichiro Kawasaki wrote:=0A=
>> null_blk_zoned creation fails if the number of zones specified is equal =
to or is=0A=
>> smaller than 64 due to a memory allocation failure in blk_alloc_zones().=
 With=0A=
>> such a small number of zones, the required memory size for all zones des=
criptors=0A=
>> fits in a single page, and the page order for alloc_pages_node() is zero=
. Allow=0A=
>> this value in blk_alloc_zones() for the allocation to succeed.=0A=
> =0A=
> Looks good to me, this looks like 4.20 material.=0A=
=0A=
Yes, this is a fix for commit bf5054569653 "block: Introduce=0A=
blk_revalidate_disk_zones()" that was included in 4.20 merge window.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
