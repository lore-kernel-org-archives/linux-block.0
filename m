Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0047BC77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjEWJsf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjEWJs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:48:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686621A6
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684835293; x=1716371293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=SJDkYZG1U9bpqQ9PXWukog5tJm2+YHd4JYAnbnZZsgGaTnMw7eY9ied+
   ZIYEyZDG/8pOU8woMtAj5xTzSWHkl4sYB418Zd86YIpuYiJ2iJLAJjDqj
   V9onLDv7/Z3b5YYaDpiLIKAt0Ae9fIe74YL+0ENuFjKfh4afwFIT/xFHS
   1bcONgBdRqE7hPadaXMmBtCdrnrx3Xz3OOxv5xgjTTLK5HMf82imtXU/E
   sQBfvD/ryr5eKdGlCV8qkBQQc6Zf2ZIwUgU/nQ90977Jxk11oRMosi+0g
   liTwlqTHTOVO+4AOycu0oL900KlZ+8DFu5ywvJzbgRqBpIEuqLNA0/PMs
   g==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681142400"; 
   d="scan'208";a="335898156"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2023 17:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwVJ8E63DrYsqqkZFszQVrJ/jD17pbBXMdAg8gTRnLVezeYaPNkVEeVZY6iXE6IpaHu8e36PO6lOk5pzxpncRU7FtSJEcnFnZpccG/WnCIKLohzeDZ3YH530sTQ4N3VX8zD64uolePOWJAr4lM03Oql3AxZxGff7lYtfxHOjAHkffMwD/qK72re02rUXCFpZWasPtIw2YNTD7y+jYjsOeBH+KGinBpX+u+R8KQta/frCtZNogno4bxZByuQaLZUML/84cZOHJ6rB8RIGv55iwdtl+wURQbyIz7Eyxpp5RvQU36d6mC5tR8pNLk2RfBG6nBDvxsfllBXlHF3EfLcljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=TJYLNpJOtEWxntgRiJbxQDex/a1//WCJHushIA0AD/44BUy8OiNEZGmL93K0XwsN+I4HEY1aSbTVGZYc3mJNMYWUgDrXzHO6f88KSwQ+FNZfEv/ZTpcbPfmHRH95fCE+dnl57qQt3oeD8n7etWIMXUpKNIdKr2T/cBdCNXH6xHPI2CqA9iE0zew7cVoLh7LxQNzyi1ut9ljAk/smcBTWy4uDnY6BKgZat9KUxs3qXh3CD3vmPsUBwkueLRkDJK4Q5ignAJOgOPRQ/U6uu2d8C+C+KvLBlFTBD8WOsSNC8hXRSgqHwW3leJTTiIAm7iulM2KxjwPBhx/ihAKd3RvIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=L5l7J9Rnknm7R6KgB/2nXO7lNZ6NyRTMqzfRTzrIvrtj6c8wwuDbRQ6KmAZRtOeXH2DnW6D6GtEPG2hHkhM5cfSm+uDJbtHrnGb26i2sPkLAK31e0A+2BR/WxbXrF3EdZnbcEU+CEUkcbKK2FedpOo+sNbxNb6m7SoC/NLXHYHg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8454.namprd04.prod.outlook.com (2603:10b6:510:2b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 09:48:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 09:48:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 1/7] block: Rename a local variable in
 blk_mq_requeue_work()
Thread-Topic: [PATCH v3 1/7] block: Rename a local variable in
 blk_mq_requeue_work()
Thread-Index: AQHZjNzGuOFNWgirs0O286jxIKpwS69nnaEA
Date:   Tue, 23 May 2023 09:48:09 +0000
Message-ID: <7a16cdc4-e83f-2ee5-fd1c-11b86de7cc09@wdc.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-2-bvanassche@acm.org>
In-Reply-To: <20230522183845.354920-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8454:EE_
x-ms-office365-filtering-correlation-id: 651c8b54-33d2-426c-b0c3-08db5b72d0f9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qmGO/OoCPcS7TkaBJpoScUuM59812J9WKrliuUNsTG7ZbJe9lc6XrbTbzRPROjrHfTrnPQmK9ToKdbH+ytFRWEigG2xNUWwAr+9i7pze6FkRaUb4yJMq/5SNUDwddUF7c30NVVp/vhGPLP+lBYDVBgKyyti3fyk18fRqBAcWmvTP6+r6Uo7oRVya6R3hhn0GyNwdL+OfSKlSzs+RDzM5oDGEthAPEmC6bA8R/bujCpUFeRI95ptTZStT4JytXH/MaQk+XJCoxI1hFvSO136WUMwXT9k8qGzVWhFurkdUhObttyBs8aa1S5TZ0wClXeoMXyAxoYxPj3ShWrZD+xJm4TkJ7HAUN7LmKWYflOzWO9s0SH6BBnJo2C2Iw7RbDEO2pr81uuPuKPrD4m7kn5aOx1D9iUKLnow7wU0aQ+ROmjwMxUJEz+k2sfu5MUYLpArC2t7+FZwhDR+18009/TrrkfAHvO5/qPoKTW7LweJ7zWXRjROzWo7Zn+Om7U0sMam+OFWdtkyO/ioEtO44Wk3OJBFQWn918uWfkvBZbVxqR8qyhP2AuHXi7ruM0wHqACbKX4QOzKBaa1gpnvsguKYthU1yLtGLeFwbpzi2HPbBR3kDx+Ebo8UXOHzHU2/W92kFMyxKKYuKjyJcii65GMczIFFYME9NKiVizP0GOGwISwvERe6kFfjYdJUGas53kRFo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(122000001)(186003)(558084003)(6512007)(6506007)(82960400001)(38100700002)(19618925003)(2616005)(36756003)(2906002)(4270600006)(41300700001)(6486002)(71200400001)(316002)(54906003)(110136005)(31686004)(478600001)(31696002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(4326008)(38070700005)(86362001)(8936002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEtCRG5wd01FTW5RdWd4T3FkUE92UXAzaVQyS2JQSmt5TSt0bjNDcWRsd3lO?=
 =?utf-8?B?QW8wS3Z0V0Q2UktKaFhyb05zSzVNazFQZytEdysxK1hkbElHQ1ZlL1RZaUJt?=
 =?utf-8?B?YWJRYnl1aHJHNjFNeXB4UWF3bm1SYjFLL1huYVdiUTZRWmV3cStiZ3VDMGV0?=
 =?utf-8?B?ZmFPNy8zWnBHS0o2K3lyNmQrNlROUkdlb2VnK0hRRHBCL21HdVplUUNIYnJ2?=
 =?utf-8?B?NTdhbjNGRVZNVGVTRDFnM1Z3cjRCcC9ySDJMa08rM1VzZVpxM2plQWwxc2E3?=
 =?utf-8?B?cGhFbk01WWM2djY4RE1pNCs3SkowU3JyQ1BpcnZWUXpDaEkrYWZ4T05PaGNR?=
 =?utf-8?B?aHFtVjhMcFRNUjYzQld6V2pzaHZvMWFZc1R3cDUyOE9MMEcxa3RKZVF6R2NX?=
 =?utf-8?B?eVFqWEFCUTlhaVhqUElCS3lIb2xDdkZLc09yU01PRXRqODhZSkNCa0hTSTVw?=
 =?utf-8?B?SER0WURrd0pKNXFNbmk1Q1JtS0J3S05QUUExUURQc00yTWZha2FYQmZTdC9y?=
 =?utf-8?B?UTM3di9SSmJacHJKOTZLekZhZnF2MUxQRDlDa0JLVDVDempsaU1YT0dQbDE3?=
 =?utf-8?B?VDBKSUR5aEtsdzU0R3JrU2lmWHh4NlRTUmNuOVd6Qjd3UVpFTFM5TVRtQXBQ?=
 =?utf-8?B?alllWUZ4dktzMEZ1NjNLVjVUdUJNZUNuRGhhZHAvaENjSFVRL01Yci92NWRt?=
 =?utf-8?B?NUNLZzZiUmNrbTNQOS95MW1CbGUxS2d6WGhBeGUwZmdDdVJraExNcFFWZmkz?=
 =?utf-8?B?ZjdwaDJuSmRqU3VvOHByS2tCNU9vRnFxTHlVVXlKTGtpSTlBZitUK2NTMkpY?=
 =?utf-8?B?Y1Z2a0FweVhkQWRLQWp2V0VpVmxLM1ZaWllSR1B3L3RFRHIvZlRKZlZtQThH?=
 =?utf-8?B?Tko5WDhRSG55UjBDY05wL2E5Z0tUWDMyNFBaTmVTUzk5M0Y3dFB2cGJ5V2VW?=
 =?utf-8?B?RnAyK3oydU4yeFVhdldXUjUwemE5cHZDRy9jTnRIV2ZYSVkxb0FwQ1AwVVhO?=
 =?utf-8?B?OVowTWp6NFBRc2JqeTNscGRiZm43ZEpxb1pDUmdkYjdsbGJVNE9nNjVTdGl5?=
 =?utf-8?B?TUdSVGprVHJ4akIwM0w3Vm9JUnFUcHRiL3lLbVZyVG5kU1Z3Tko4N042WDhP?=
 =?utf-8?B?THUwaFhYZFUydjZITGdFTXRhR1pHRTFhS1lRY0V0Q3NOenNINndPcGR5ZTV1?=
 =?utf-8?B?aTk0VldsbUhrTHJmOEZLejNySGVGT3NsNkJhS21GWkJtRTNESDVlaEhnUlVQ?=
 =?utf-8?B?SE5UUkp2V3BGUm00azFnM1N3Q0xnS0YyYWl3cWFwOU9Oa202L1paYTlXWlM5?=
 =?utf-8?B?RGlLZ1hTeWpUV1l3c0xrSU1RTUVtSmVrMHZFMjAvYVQ3UnoxeWZvVWRjY0tS?=
 =?utf-8?B?VlBnNlQ3Szc5Y1VRekpCWFJPSTYrckIyamx2eFhQMGdHU0krTkErbi9td3Ja?=
 =?utf-8?B?c3IrSXowWkpnQ1BrV1dEVnNvUGYzMEY0YVdKZ0Vhd0piWGdCL25FYWtGdjdm?=
 =?utf-8?B?bnBWRDRtRG00RDR2RFlST1J6Q3NrMWNFMUE3OTJRc1p4aDVJWkxVeDlabTlC?=
 =?utf-8?B?b1FLMTU3L1c5cmFKQ2U0ZTBEZ3B3ZGp4K2RGcVV0RW9Kc1daWkEzMHdzaGRW?=
 =?utf-8?B?MkdRRm5tcDhYS2xIbWdoQXdEZEt1Y2lpOVVLbzVBb1dyL2JMcXNid2c5czQ3?=
 =?utf-8?B?b2g4RkpDTWk0RGtHbzRlTDRQaDRlUk9uNjcveGpEcVZNdWJ6MjcybGsyUEJs?=
 =?utf-8?B?UUpyRS8xbWh6ZERRN2lQZjhkMUZDMGZyanEyK2RtRGM3UnFQcWNaZjVVQU94?=
 =?utf-8?B?SWNTYlJ2N1ZZOGlsSlBuUkdzemlzdjJyRDdNVFhDUDNEOWZMREFjMCtDWEZF?=
 =?utf-8?B?bFFreGpheFZjUy9SRTRRTldLTzFMUlk4bTF4WkNadDZzQWpmSjdHc0tOR2tT?=
 =?utf-8?B?Rmg1eUp3a2VoOWRMZjNyTHIzRXExMmU2OHZJdGdxa2RrNzRJUjh2RWRuVHRV?=
 =?utf-8?B?NFhyQkVvdUhXLzlPTEg5YmJML3diNytTbkc5MWhGbEhzOWpQdGZBelhrUTky?=
 =?utf-8?B?TzlpM2NtbWpadDJWaW1DWXF0SXNOcCtmbUIrL1A0b0VmSlI5alAyYnNpdjJv?=
 =?utf-8?B?OVAvalhtVkd1UFdjSFRkREdBNStUYk0rMFdSejMvbVJ1a2ZMQUVkL3d5am9E?=
 =?utf-8?B?b292eERWR2Fmd2RMNUNZT2NiUmp5MEYrQm5EOWhTN2FjZEFvQVFCRXJpMFdG?=
 =?utf-8?B?bjBwN2p5MFloRUtBRkpESnU1cmtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97CA2DBA79093646AD6148E6919AEE3A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BFoW5eX+QUiDHQmIyNd7MEUqx2adS2Fqc8TSIRUHCfETVCGSBbMzUF2gRHME1DePYlGfzVq7Jw8ytuMLTpRSRIpJkxyFgzGwnoqoJ4QuHJc+k07YtYwcdkP40Q1AEzVWpVgBzYS1nROZDWpahG6zWbZi5s/i0eFj6JPbPp5SrY7s/SCnpvmiPLG+riyaFCK+S2xQGK8ZZ3ZQ17sNQsBzapCA85Ku8YQ1T54wkRm3wgQBcrYgnsOEatkMIkuLfpv3vCjtOicfQHJkMO+6hAWugIvXn38gO8CkMl1zIQxcStQ2PjEzIEtkCbg1haQG8PHxorpUZphVoJXji3KcoVX+s+Lth3FRQPNC23rXIMT5UpCO1IlqFfhC48wsNQ+7Dr0GPuHrLDo18FW9CDibKZhNSxjE6A7qksUzAONvfY1ujUOPWeZ86JMjwKglKbll1d0bLh0zlgbFu856BVZNsZAa3B8BcKRDQ67ppQyOInXKlEggd+W3M1rWHoaJpWhmEpgFhVio92XvwAP6qt35BWGcANuZhUh0XxiEvJ2pF1hGaSZs/0L2ApgxcvJM12xKuBOVBCbERwneOiGM1npsGLLrANw25zFrwXT7UuT2TE2+fw5/WzekOAhmhTptVyC7YDdkgaWPrrtFhrPbwT6LsKf9Kh31Zx3AJ0xPijjWVp2thMwrWnnv9oR3QNKCSXVzcYVNlVJ22O2TqcPcn4ZnP1Qw64qfadLiJ2+4r8EXaUgU8Esiy/PTC9FW2E5F7fIdQRYyxjr2xsFAMZSBgAd2Wy1aCIZlxp/bWvLsv9ZlAMm12FHt1POci17IDTkZlcAdxpd3uj/3Dv/hD31YYYk8rdLI3QLLtgwDwplbKZjlw7sPo/pwGU/VXNpOiA93EBc7y9Xo9Yf1ifJe41P842sgcFetPw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651c8b54-33d2-426c-b0c3-08db5b72d0f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 09:48:09.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7aF5CW4Y8NDTnBss7rMJS7yG22aXyCtpCVhks/lXp2/O/a6ObweHarJiWqMx0Z3mSI+g9HRh8b/mTJxuVtH5/ZHr7v71QJsuCpObcArDVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8454
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
