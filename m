Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A60AC05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 09:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjBBJeF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjBBJeC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 04:34:02 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF713DC2
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 01:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675330423; x=1706866423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=P8ibAEyO8C2jUmiQWxbU2BXif1mmXBgzlHn0LHafli1aEQsO9day6cfG
   rUdheFAYo9sCWiLwHywf1wtom/ZV/yGQ7H2Ci1dScq5E6B8gn+/zanlYf
   Jg/YzpUnmJfAYMdssOszINvOoAwacJJ20p5xBAUSarP9pPNxL4xI5gl9Z
   Pu5CLloQAh+g0u9iE3dQtP4vZGhty/7r1XhmugxIOloDiwW+zWJDO1Boz
   qTSOTlfLa904M6XWJgNWWcLB9wmdZH/lVeiZYI1DQSUG0dAdVQ5UC4KoL
   m6Vb5X808YiQKW7O8tU1vtmTYeGYKRKJBvnZrT8+TK69TA5q5eOBQ56bA
   g==;
X-IronPort-AV: E=Sophos;i="5.97,267,1669046400"; 
   d="scan'208";a="222401150"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2023 17:33:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns44kWEQXjU0aVWXv/tO/o7jJhm5Mh0G5tKo20fDHP8vWiY3FZoin/o8CAZV3Idp3ccewLK/nUYassidu9YM2r1byuFuwN2HEH7UoNem4t8Y648ty9ozekBH8Bdvl7tELEeNWNsNlldJXuxrA9nrKpjTvCPNwGnSEP/DF3y5jfo8EFolIDG4m/7pr0d01w6nryiEPQlx7iG+4z0hpW2WBHnyp4X9d/mz1EV1cxZkyxnOdFI0PtkV3hUn8dNomcPllRBUEblj1VhnLm6WIVaQN0rb9iVrSSxIPA08q5NvJzvAShYsZOZcX2Y3uyKp/ocBSOL/G1Gh7dMk8DWJMcOHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=htg6Bh/BS5nK4m1Z+fY3wKnoQ0ZuqxNBMGAnJE+rB1TM2aGBL9NAKU6ljLs86wrnYaHR7HKf1jn0Cu9LggieehY1ie1P+G/zNadOFUVU2yx11DImMuyXdsc7LH54WAZnslWbq841tpB9SN0ny6/mb2cYS2hzLkZcGKEQxyQYkAs/QON7OJ8J3gD/VTlTECkiB+HYKNh39NCebU/+7zlkIfwN5cnJDfsQccq8+lA2zwUsz5093JZbfklMPbhXGmqQmpyanfWQCILzFiNY1uWKmtjMRuF0+hF7CAZa6kxk6esiNbOCx2QCQyhqEL8USP8otyWF6bRBN679MTH7DiHrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nQ2poQB5K8CAP2MhzL8DaGPv7FcxdrmRo8FT6B1lc2PeAquFbwSuubE8DN6FJhGuqKYn/VJ1Y8eZgd9Akw10LSBkTXiUAh/Z04iSNzGRyQRFfkJw/qiJGrqwisSU53njncI68FJcX3dIrQZCZ2rVVx/ajfYiAZgZOCh70/jXXJU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3511.namprd04.prod.outlook.com (2603:10b6:4:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 09:33:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 09:33:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Juhyung Park <qkrwngud825@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove more NULL checks after bdev_get_queue()
Thread-Topic: [PATCH] block: remove more NULL checks after bdev_get_queue()
Thread-Index: AQHZNubFoeu7W4GODkqVKBUEUcpFzK67ZQsA
Date:   Thu, 2 Feb 2023 09:33:36 +0000
Message-ID: <1226cf9e-ac49-cddb-e44b-fa8f248f7cd9@wdc.com>
References: <20230202091151.855784-1-qkrwngud825@gmail.com>
In-Reply-To: <20230202091151.855784-1-qkrwngud825@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR0401MB3511:EE_
x-ms-office365-filtering-correlation-id: de310d8c-2e9d-45d2-78f1-08db05008f71
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJAQcxH1HGuIVK93vQo0YaLRfHxatyVLIjidhu17KXvl46ZVTIktdoxuLq2/cN/acSHuM+zkbHMYBf+jZnb5J3QLsrrV9fAQHGJOa9LppJ2GXaihXW/uHkMdnqGHeYV/GK4333I9yl6flEZwULOTlRRO2+IZyKVv8Qjw4AdP9LKYM9jPtS470Sft6x/8m3/Q3v9AFum1EIQFJT06DkxdtO5uM9qN/Bzv7XkP/kts2Yss0WyZp9rVZW5AWNKcYYA2O012RKaYO+WAMRW/o4J2IcP5v7C+aDjDVrTWtVrUezOVY9QTAr4qH5yb7TEXpotjURe1x6CqX4KXdzbH1iM4mSpvFrEYyfKh95ZY6CthUMyRNP4CXhfbAaB7HJc/3w7VDhJBS1AfYyieo29WPO6/JCTD3L9bvwPN+JKkFIOJCgRoVomGf7xLhbBNcRFS/nSY5bxGRTOV04qoxgMjjp7LO0MW9/qqElFm+Kv2P8XCgsfCfebai5q/OXItzF/Iw50hG0ZX4QkUZBp0fyEevYdb8UjfNTrgjl9EKqs7351t8ikTYPIN9OdXQ7dS3xpg3+BOJJ3SuwDtpuYlX0RRimGuM1SdcoUCMhV07d2C82TinHfvE7nZwMgR9nfqNa7pRVf7M3zwbCX64ZYTWq1fD2QA02v0Xrxk+Lq+2WKjgGs0Q+Z5CMiae3/mjossWGchFv6Y4v7KAoQGDHFpONLSoXVphkCKDUWKHwfLYvPXL5GzQZA3vPJGvH3KrEMJ/VhcNELGgDZV/vkv05pn2VwqFi1Zyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199018)(91956017)(8676002)(64756008)(66946007)(66446008)(76116006)(66476007)(66556008)(4326008)(8936002)(5660300002)(82960400001)(38100700002)(41300700001)(31686004)(86362001)(6506007)(558084003)(186003)(4270600006)(26005)(6512007)(19618925003)(31696002)(110136005)(38070700005)(316002)(122000001)(36756003)(2616005)(71200400001)(2906002)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3NYVSttanZZekt2a2tPZ0VGOXl3NXdRaUZzbWM0MmEzQksraVd4cmVLYjlF?=
 =?utf-8?B?ek5WR081OVRkN1VEa1JVbjJTTk9tUWN1MkNiUGcxOS9JVW9yc01vYVplMjN3?=
 =?utf-8?B?bGNFd1hYTHgySzR5SlhUVitNRUdqTHh6THdmdC9VbEhQUzFzTmxWeEZVT0dl?=
 =?utf-8?B?aVFHaW5pRXRVY3pjYzBIc2YvM1JLeVFrdWh5ZDFvNlIrSFpyMi93aEpGbWhG?=
 =?utf-8?B?b0JBUjdwSE85NmFCNGx2azJUV3U2S0dwOHBqTWtJY0E3M0dTNEw1YWwyM0th?=
 =?utf-8?B?ektHUlVDU0xDYWxhcVRvV05jWnhZaHRZdjEzWGVyZzhBQm8vc2YwWjNMN3VI?=
 =?utf-8?B?SlNoVlFjVWcrVEJwR25RYTBTMW9aRmZzR29ML1o2UmdTYncyMG40R1dpeHRk?=
 =?utf-8?B?TndZaURuMnVML1FYc3puYUFYUmxQK2NIVE1rRjJrOTI1ZS84SndwMXdwZUpk?=
 =?utf-8?B?WU00SWt3RVRwMURWWFdXTFFoMGljRVZMRlBheGQzNkY5aXl1WmRYQjZDOEJK?=
 =?utf-8?B?ZWJpMGNmeUhiczI1ZUJRUnBrekVBSm9YSE9HY2JncTl2TnJjcFBab09DN0Na?=
 =?utf-8?B?ckJDRVpNN0hlN3lxZ2NOWURoVmFOQ0o3bFR6Z1ZKL2RtV2ZMZThHUjVnY2Q5?=
 =?utf-8?B?UUZJTzZ2T1Jzek1BL2pNVXNZNjI4bnRXQkdmRkF6YS83dmNxQVdnNmY0dVow?=
 =?utf-8?B?SHgzdXBuYzJLWURsOThLZFVyNTFVbDVzdnBOVWx4TlBRUzlHeHp2UnpSamt5?=
 =?utf-8?B?Nkc4YWcyRWVnUlVwY0JPSEoxQkVGbXVqYkw2OXkzOUo3VGhoSlFBaDNzUTZB?=
 =?utf-8?B?c2M4SlBBaDc1a2lUMG9xM1UzRmZGdUFWb09sbTZ5b2NXc2JPMDBVNENxaEg4?=
 =?utf-8?B?NmFXYzYxRURGQW1YN2lWdFo5VEdOMzh2aUJRaWZkVStVWGo1L1QxZzVYeXpn?=
 =?utf-8?B?V1N4aHF5bWlzcFNPME4ybXF3VWpteTgrRFZuNTRnclRoV2R4NU43UXU1NnNr?=
 =?utf-8?B?R2hJM3lmN0x5Z0RYLzIyNWVLWTd1RFM4TFZDSHJxbW1oTnhLTkJLdGZJTW42?=
 =?utf-8?B?MlpDYjgwci9GRWhkRzBycHNTdXlHdTM5Mkh1OEtkdFNaOTE1NDhpSjNmQjBE?=
 =?utf-8?B?Qi9lMmF1NGMrTFQ4eC9RN2FhREJLS2lheFB4TDNWeEZZVFRMWWFINUxGVlI4?=
 =?utf-8?B?VmM5bWQ0L0IwMitITEVoYXN5K2lUN1g2UUVmV1dOb1duRytLMVhnZUduVC9I?=
 =?utf-8?B?VnpPOHJnOUp3Nzh5Z0pYYWU1K2RXMFNaeXQva2ZlMGlmcWpyTDIvZXc4M1hC?=
 =?utf-8?B?SFJXRk02cXF1R3NuUFBocGY3UWZLaG1pNHE3NUxSY1NiZUozcmZuS0VzNXZM?=
 =?utf-8?B?TlIzdnhpUHNMenFVaGVZZ2UwNngwQTdTVEFZSU8vd1BqRE42K0RjV3FURFNk?=
 =?utf-8?B?SURyTTlnZUw2STBXcDA1MHk5ME12N3NzZk1QNE1PUUQxUUx5bXBmdHZFYzNE?=
 =?utf-8?B?N1NlUnpGd0VJUVUwUFdhYXd6b2ZVM3V4blpwc3lvT3RLU1ExRE5pVTYrbHF3?=
 =?utf-8?B?YmNhMzB4bDUzVGZDaUp0bGFDNkwzcDk3SStldWFadXVMRXE2YklwTnMvck9W?=
 =?utf-8?B?L2h4Sm5OTXhFUTZTYUtYNlRNRitUV2J2TXk3K0RrS0FFMUR2WVBIcGlPNlhT?=
 =?utf-8?B?VXZLUFJqYUF3d1FVek40Ull5K2l3S0tBeGY0RDFuVnhZSzdPQkpabnhqcU04?=
 =?utf-8?B?cWw5L0RyNTlKNFhoM1dpUmh5bXdHeXdQMXNnd3lqbVhrNWtaZTFQOGFmOTRM?=
 =?utf-8?B?S1VPcWJJZmRWZFB1Y3JYV0dSNTlJM0VvaGNkUStGaEEwQ2pXTEtPblZSN2x1?=
 =?utf-8?B?cUJYZXRhUm95SzFRU1haVUZMVlhRRm5jaTJBUUJkRDB3Rk1ibXFWTTlYdjls?=
 =?utf-8?B?TFh1anpwYWs0cU5Ha0tKL1NwZU10emhEVUs0M2xRTXBzSWZJNEFSU1dZTDFa?=
 =?utf-8?B?UjdpQ094OS9NcDlCWW8wRUpHM1Z1K01XWlVNc3VydFIvM1REOXUyMEVMKzd3?=
 =?utf-8?B?UUd0Nlh0Y2NKVG9SMmhJbWhRSzVYaGF5UTYzZ04xZ3V6RnVkUVg3Y1FXVDA2?=
 =?utf-8?B?Y05PUFAxMEZLNEMxUVlvcWVEVmF5RkZYT055N2I3RTAwUzQ4Nk1jZnJ6bEVU?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE647F85111D8C4B90D3365154FACC8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DIjVotUGajOSQ6z6Aq0WciO0q0SwFfxWsuTns8VGV6I8+j3mpnm6BE03fRn/aZbO4Dlp+qN8DnP4xkMtf61bG4z1UpYLTXwYAEh7rjGCyrjv6PuANt8zYQyU/dAVYASlrgDhfPuE3OpjHYqTtRwXuhOEZBlwLlMGaom8bdXtFYTrynnOE4V/Pi+Bdymhml/UX0v6DeaphUL294O73D2x2hUDmAdWcnWHdzEELXVZFUjFb6mr5GHaMCFEztQv4VKSU54hHKunaE3qYecWqas/qKU3PoXwMADg3DLJVVO0QCGQE63pIizNfL4avqhhsPZNzAwpi+knisQ8TWef/GZr2hGd7C7iViTIfJ0Cvodi3SQfSNv06TyzXysHBAlnhC+kbY6MlG4PiXwd4aZE57te3vXzSTRciWkv+T1HP7DpoVQ0qubhGx8tUM0Vam2a+pjf0mqDQ354nr8+UHePpYPi+HCpSnuW1VsITNGIjQuZT91teiLmbU0dw82O4ZyQ00Ox1m0Y7fbZMZdbO34bxtLn7s1hYZ+RTwaFUc+HjLNsdV3nCxlSiP9RIH10JtvBYYgHzbJhxE+Z750gg3aD7nAVI1QBr5NUSrlGPoh1b5gN3c2RAwjNlqFVy0orqXS12SBsFyVyIw7nuVWK1oSDdxSutuTeyyffSEvtlFtNwV/6f2F9IXYlp3aRA+Amsy6qWciFibt3t6R7CPIKTSMrg3oI7Y6Nh3xoBQGDIlZtOiz6KKeoEedOMaQ2KCM4ymYA5CPhS1foJOMYs6/wF/sk2crzQiEH642RPkL0VvpNRaI0FKYXKmyDjiERMsELmlaM90qdQZc6BORSaoUTkzL6xkt6OQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de310d8c-2e9d-45d2-78f1-08db05008f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 09:33:36.7149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtEBYSCV1Ir0xK3/xhLsOcvrsHD0/SNLJU5pBWwwrRPpStHZ0QKS+/73WobSa0famKT7JbMf3cD0CHEg7ne0QenCvug8gh3cDOfq+De6UlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3511
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
