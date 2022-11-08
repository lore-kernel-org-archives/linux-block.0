Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B83C43217
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiKHHh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiKHHhE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:37:04 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA872F672;
        Mon,  7 Nov 2022 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893023; x=1699429023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Sm7KN92W8CMpl3CsoAV/Zekha1WCmHpC5Y00xhXTJDYaVSAZkQ+ToFVN
   FkAH2wc45nSlACUeVaaGj7InwL/vMmF3pNWwGf0If7veqntfeQN4Zf3NA
   XK5ZR8Ws8i4cJs5O+bLvP0gwcLfj3AQ1qIlMpfH9DILMX9OJ8eZR8wm9M
   LOAb7DJQHogR1zObgIOMfSfBISOnvlHI2hRKKYZjfSY/XDtNTNLnd7zwP
   OUL7nwAhmHlyzHibfo5LkFlGTyb9+7scQaGT9WOghu3EaUhHptEuAkMgI
   kXxibLJQlwCVTqO9ecpIY/8/RpninD4tOWeYqc56JVoD6d0gGPy8NJYBV
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="215738439"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:37:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHydFaVvWzVOxNZqTRXRAro6yeLlChuuVcwNX78TYuBK/wczMpR80Tk2Hh522W1vJkZTgros8xFdPVfkoIXRfFWhA083R4fnyTMVyTxZYrssA0EMs2Q/8Py65Zh/CdQR/Zcvzjbpfj201H5sVXg2sqTKtYKgdMNtjwFrbFCPowpqIihI+egcqAGfEdX1Pypoz95eQiTV/CcWPBrSOfsHoFu6mq3vwGy3aLfmr/y1LmvqV0I6GPfnSGirc9VqoGmFBKYoEAGqe+5LYe1MDIuA9ulZ0/Fqd8O4HzC6wf5X0oPCiTk654hzqHu66Qwignhw4Rr/ST5WkJreSV6CzyjLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nb40/AibUtY5EqyibNAK6/9IR3SeVKIltMF8OZ/74FKWJHcaLLAOIJUlbzhu23HHbsmG/+Bh4ouw1XoK6l6Cn6Y6xhxtuoAURhc2+d3PO0V1qDgZMEA2SPRETOEfWQUPKpa3Z3k1Z5/YylqB0/XqaiuwflOspECWbSBRDEpbFfvB61hM41VQ1kV3ommVfzxrjUnSkNzGpjiCTqmxFlq3jD3IqyWPK/UNqCPrr7VU1gZxONoU3Lzhe0W15pOZhircPrtf4CxhkH0G1v1CP+dAOIGM4OiOpkW/BKgGGPsfYIGh+zWUvZfT5mJv4TmHPsZechZ2iz5jjAYBpyTtT/Cxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QJ0srgcbr0KMRkvIqZtRHQCnTOBOCgGBXWYwLxnX5PSl7dACktLEuZwRr7VtRVOQp/M2/iI96NuLoEmuXgXS7jxgZXmPCNvLhBTcYNJrZXsDyFRA/yUg54L+j5eS9SYk+13HF0eoKIrt2jR3p5v3AvKgbhh7SISrDOz8F2uwRAk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1113.namprd04.prod.outlook.com (2603:10b6:903:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:37:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:37:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Topic: [PATCH v6 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Index: AQHY8zbHti/dmKoWqkCXh0QSmvEs9640o1eA
Date:   Tue, 8 Nov 2022 07:37:00 +0000
Message-ID: <b5aae5f4-9473-9943-bc86-4378270688d8@wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB1113:EE_
x-ms-office365-filtering-correlation-id: 654df979-40fa-4e49-19e9-08dac15c05d7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8s5FvzEAjgS1tsWPy8iZmJPTm/jvgypDAKQJxHuFX7m1hAxZ5xjHRZEew7BjH8EuhaBnyzWVU3GS9MGrSDYugACfJ3mcQxZOUUPg8xljHXx6DuGWKVNjq282Jd+lj9zLv/FbHhiNDgo5UEmaefLwIO7PDJYWC8uoIXV/dLtgHLdQypBy85ocav3eFaMO1Avqo93LPVtDjA/IP/tpE1C7yMHTB+pHZ9ntuB55sFQZ7bPxFK6+2ARpBgrr15k48Adp3xOM2DIoarfmkUm+vMhZGm+e4V22IOE5dLZ5aWBTienLg+gy+qsoGbLRHqdJuUdLie/GypBPe6R6ygZS/F8C3IsW9XNUnUONqwwbAivvTZzh7iY/mZ6i2FV7NSI9TJXZBJXSTnOoC58CABIwUfiu0xrpaecNoukDG/P522tT4eJlpq/QDbZAn6zyuIbBj0NXaw19b7NihwEEuIcOLqlaor6SY8G5WdU5zeb06ZngqbJmpl8c/Yrcp7Z0urqqd6i4O40OrM64IjkI6OY06YU9Bra9vFesCXwNrS6K16VsnxEmS1GuDk+suno6dBFQkCMr2REqHeaZyFRHjAwbKVjAodgZTqdHQClJrLjVpfT4wM/y67Ge5CEgh4ZuQDtvAz7Do8qlj2uUdiNHAFBcWr7eQdoMui+MI1gmpIhQk5p5XtWsYEKc1Ph12n0dVCW2Jmo4W9qxFO1G7IcKMxxEpYrbV1JBbgt2au7D1DuD2Prugy8w96XchUHww4wFjvHDcdVw/57Xg2vWhnzW1EG4/+rJk4l//z2JLiSTThdT3t768LZH6CBeNcnI0fA9eRG86K0I3NqgX2o4Huwk9dlDMWHxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(2616005)(558084003)(122000001)(38100700002)(38070700005)(66476007)(186003)(2906002)(82960400001)(19618925003)(8936002)(5660300002)(86362001)(478600001)(6486002)(6506007)(6512007)(91956017)(4270600006)(66446008)(64756008)(66556008)(31696002)(8676002)(316002)(71200400001)(41300700001)(76116006)(4326008)(66946007)(54906003)(110136005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjlZb0c2Z2d3VEN2cWxhZG5jSkRxczg1TlJVTW5TV0tXYUFrU1lrSDUvZW9s?=
 =?utf-8?B?WWZIRXo0dmxvbDdRazJsaGtFbFNtVkJzR0w5NWNBZ3VDL1o4TDVzYW4zUnNT?=
 =?utf-8?B?WVkremdDSnhhRmRoT3ZzWkpNVGk1cTRRbEhWRGlVb3FOWXZkdXNKYVhWMDRr?=
 =?utf-8?B?OWNEOEVQdlU1cVhRZCttaFlOYjJVZXZEYXJFZVVZcTJ3bXNEQVRaVnlWaDA4?=
 =?utf-8?B?KzgwZkp5bzZhb1hnSk5iMUFOWTh4SHA2UGNaQzVMUUZiQWo3WUlNYU1maVdM?=
 =?utf-8?B?c2pVcUpJdFJlTW9NK1NvODJyancvOVAxbjZ2YkpmNmtXQ1NPcUZRRFc1Y2x5?=
 =?utf-8?B?MWRiQ2lnbG9uWXhOVWZrdG9ueVlQNEVuS3g4b2FScVNtRE5mdzB3RzNoQnpP?=
 =?utf-8?B?eU94UWxSNnlueDY4TjZFRGVZMWk2SGNlSUdzd21SaU5ERk1MT2RzdzhJc3Vj?=
 =?utf-8?B?bHpIakdQazdwZjNnUnBxZ0lscFFKaG9HcnBDbWplUTFwVEdjenRhREhGUVc5?=
 =?utf-8?B?SnI1RSs1TlYzdXBjRHI4TWFwTE16R1dtNFlORWJlbDBZQzhsNUN0cDZKRXV5?=
 =?utf-8?B?SDdPWUdqUWJzNFB0dis1aWhLRS96UmhNWDVhNmNGY1o3MldKS0JOT3AwK1NQ?=
 =?utf-8?B?Qkt2OVNqcjVnNW9WbzR6cDYxbDlGVEtmT2JzRk96T0ZWSDRmM3MzaEhSR0xV?=
 =?utf-8?B?clNua0FtZ2k1N3RWUHRMUUZDaXc3MVU0OFVVN3VQVjc5VzNFOXhTWStpdzVu?=
 =?utf-8?B?a3U4dll0eGRVWW9TOWV6NlhIYW5IUFd1Si9wYk1ibGhvNmpBWDlhQ0tNYnNU?=
 =?utf-8?B?eTBUK3F4UTJBc0xJWGgrd2xTUEhYSlVUb005WitKWjZWaGZVYmpkTENYcDND?=
 =?utf-8?B?RUVBeHVUNzdrbDZMZGZhcGFyQWIzeEt1Rlc0VGpVQ29wdjJkMk8wQ0lhVWta?=
 =?utf-8?B?WVROVE4rMVEzL1gwd2V5SkR3Q3FRcXFSNTZLalMrTFQ2eXdLalViQkpOL3Y4?=
 =?utf-8?B?Z2NBMG8zQ2l4NnA1NFQrZWIvd1FybVk2S1l4eC80MW9aT2lZVWNueWd2NFdK?=
 =?utf-8?B?S0RaTFdjU3pJeW9kQ3FTYVpRdGtsNk10RjhMdk9zSEVrSXhxNzAvUkdjaFJj?=
 =?utf-8?B?NHNTWk8vN1h0Sm9UdDRsWHV3NDFvZ1VFbW1HaEpDTTZpUUliYnNEeE8yVHF2?=
 =?utf-8?B?UXpMZkdVOWFkeHo4c0FGaDBOd09IQTdDQ0ZIemF3KzNheDZsekE1dEN1OXUx?=
 =?utf-8?B?RTNOam9oR0Q4WkpOaXY2OEEyZWtkQXdxUnBvam9rZCsxNFZpenE1aWx5Y3ZG?=
 =?utf-8?B?UmZ5RVI2ZTdTM0JMNytvNXB5b0liaGZkN0lVK2hINzJLd1FLUGxWRXlvMWZz?=
 =?utf-8?B?a0VHK21FYkhSalVVbmxyZGxHTXpQZ2ltUXRRS1Z3SUg2eWxTcElJeXZSdm5u?=
 =?utf-8?B?MzB3R1BqcnY4QjhFSnNjT0JBb0ZwTXB5c1FVTlF3M1BhdTZUZ01LTHNQZ2JB?=
 =?utf-8?B?eGZIdyt2WE5hQkxFRFJ0OXNBd3VSSUVremZCS0VjTldVRHEyd043c1pIOVMz?=
 =?utf-8?B?dmFISGFBZVVia3RFU1dhakVkaGVrUXNQd2VwRUUwQWxHMEdiaFFoczNnY1Vz?=
 =?utf-8?B?dDZJcCtaeEFrbDFuYjYxSUgvSGpoMWVWVHg2QmxRanhiNEVtUGtIcE9IOUxu?=
 =?utf-8?B?a3gza1orQkxQT3BnQ1JQTzRqeTVBSUZBTlhzTGRTUTFUV2M2MytMMXllb3Z3?=
 =?utf-8?B?WFlTZE5SQmUyb2sybGErRENOcTd0OUhIVXVxdWxKUFhIRWRGc3ZtM0s5THdW?=
 =?utf-8?B?MG42b0lkUENmR0lzNnQ0NnpPYkZ1Z0ZhV3RZUzdrVXMzWUdPMzgwSEJVNkxQ?=
 =?utf-8?B?VmlsZXpkdFNZZW9waWNxQzk3dGVNa3JZYXJHNkhLL25FSzdCOC9BSEhEVnJC?=
 =?utf-8?B?enNlOHV3clUvaThhMUsxTmtucWdLUlFhNGZMWWh2YXVaUG11a25xUStsUHFn?=
 =?utf-8?B?T0pNN3J6eTl6Q1ZpdTNWQ3g1U2hrYlBVMDRNOW1IM1M2UHBBNzVHWnV1TzFm?=
 =?utf-8?B?bTRYVllQcERCKzZCZUFkRjQzcXptWlBaSkRlK2psRG85TjFtTkM4a29ZTUQw?=
 =?utf-8?B?RFNaNnFZSUVEc3habUFGRnJyNjlSVGRpdWFFSy92K08zT1RiZWVGd0xudUtR?=
 =?utf-8?B?S0ttQUhKZWlJeXpRbnprNThZQjU4SmxBZ3NBbDdMRFJuUXBSdU9ZbmZETmxL?=
 =?utf-8?B?VlhuTkNnNG1jTkorZXo4MHFGWWZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6263139F94AC840A8CB90D4714AAB8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654df979-40fa-4e49-19e9-08dac15c05d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:37:00.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2pNhgOrVKS5lTiNunSjRGNpY4SUZqBN/LR1oR14ppTmnC7At1lPod6SOUIsLIjKl430EuyMsRqpkDy1wUeFO4uCx6dFAFAXQEY9S2IqA78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1113
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
