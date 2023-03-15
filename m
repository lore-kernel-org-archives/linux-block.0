Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE9DC6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 08:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCOIyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 04:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjCOIyK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 04:54:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594266E8C
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678870449; x=1710406449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=N2B3+mhuFHoTkdCKy833vDINm/ulRG8d+yqAzwMrkIypQ/LurRvf5L9B
   DwPnTFhxg8dPisF+qdKCM1llGmf/eNCX7rX/50xr7abcWE7URN2co/esg
   iROOYve6tSilYK7e9sKBf5HroZNECpI3rvnALExLfF/jYdonoZJB5pjK/
   2MA8Dn/p4iKHJ5ejuWlGB5sDQuAS63RmO4MnnDzdj62f0vO6FeVFFMjxv
   t65J9GqFcO4v3eZ3YzOttJWyQ3la32MeOL55Bvl/XMqsSd/ovE9vG5WiS
   9eKBEEkI+FW81HfSvM8X/LSfzlQFKrFS26PsniP3wF0gO2+gp5D0y2GIR
   A==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="230627521"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 16:54:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m316CqGChVJ1hSKzdrN4zjozoW0SRrX670wWU+R9moghQFmZE1BIeVCfH+ed1VVSM6nvE30f/n7WugPoSl4yZUXxNqvNqItni5KfdJIOgMBhWgiZb/881bqNmDcn25smuvIp3a32Xd1SzKJ++qQCUq6K3dBXpx5xVtasfPC8NjERERRRfwJC/BcT0HDiarsO7PmM0TTYWrJ4ZiYvMdk3SistX0+YbYmUHxAxoV5I3T8QhL2UrfEGufaHMOritTW1ls0QGrE5Ve6eltLVHlpATbaf/SCXvOKs43krW8NVoyu9aEA3kDQFIg/zPF+4D0QbnImHb+qxEz8GdeTQ6LVDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Mv4vn4415RVCN+EgaoiUanQ5ARcif3yQr/tNQ2LTWsiDd1D3oteKijhhYRcp4FO9EaRtAGAKDyu2vsH4u2VxwpASG49iL4AHUuGQBp4Nl1iWK3rsOjHGh7zOxNy7BseCU4CtPlef71QaKvtQzuY/SmLbp77+rp20oml1eCnh5ROMSPV9Qv7jL0Qidj1NuqGaTxwEKQZiee9W5SYSFXHMma3I6NS5GKo0GTnainchvC3tpTdqttPUhfIHYgf/LonlZe4+LWxlZM+Cw9+3qGVLKtqb8x7u2psr2rbORQAX14Zm41EmgZ33UxlGAXonkFgVA+wIweech60aMYy0xAZ67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=u9Owmx9YBO74yNNTo5GptT6KU9AnBrIZC1KYNIiSmIdq6pISoOnmn/Max6lFtMan1ezlWl+OBK417xKY29O2lmKPKOo3fH+kkSFNoBIJVLmxek0Knupr+EKiPceEfn0nh5+zGm84Y/BvUUV/vTpoo/gTHtVLv03hK5j+zljvzT8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7875.namprd04.prod.outlook.com (2603:10b6:303:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 08:54:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 08:54:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/2] block: null_blk: Fix handling of fake timeout request
Thread-Topic: [PATCH 1/2] block: null_blk: Fix handling of fake timeout
 request
Thread-Index: AQHZVisNlRwGfNG1B0ym0HbeFosOOK77iw0A
Date:   Wed, 15 Mar 2023 08:54:04 +0000
Message-ID: <7d935e27-0741-2240-1c45-a14e191efabd@wdc.com>
References: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
 <20230314041106.19173-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230314041106.19173-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: 19694d27-86cd-4546-2ec1-08db2532d4ab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9dStu1iNlNMIGjJWYp47w2fGUMmJ5OXYHqk914Ytef7w0f9z3dZKEixEJHUECFpMG906W0rHPXNNyy2qXkEyN5rKbcMc0V5wcHyo4wVf15hv3UYaFmuhkB/ca8C7rIs+mMlao2BZ+H7+Uu8pt+6Q/jcVwLR6gBgKas7yWomlV7lN70JePojnyFBej7MBqYv9GEOiG8/y/VqlGhXg8nPMb8i6ANFBe46uYZIlSswAL8TGHi/IAs0qHo6jnb9DqCvN33F6RY414tMfB8e/6ZdbUo+3R9+APJuzIXmYSguhwQLshULnLW2jxhOlMQyFG7i+NhYwGJ6Ee/APuqQ5JJERBRqJQG1ugGa0NlA4K6/ADzLzr892fHiNQuAAS8o/JHKJnFXe+yxAezOC7QByGFiGDJDno/WKhlme1Q/zP2Ho+niANTDXwMwHzbvfvZ3Gttud4L9FSsN1SlpepZUzEUiYP6J15FAgE0XEMq2iUbBbGwGI6mVHkNHCmjlJsiHkgH2kCCjVRvZwHmv/HTMmyFzA0V1auDnhqSPebiox8R2PTK7L4755Dy9ORLw3xquokyhsB/lnlj543DQ718NlUOz1GWC9F9p8nzaWhKuhDoyFw5Pndhb/vCvrp9Q/y79mW9ANHmnmc91oyBFjcY//dRqDUhriyQl0VSncMMeaFDD8IUjPlcimgeEbo0wHoUs4fkkTaxt337baUdWxDZRVrw2Dam0Xts4Cintl3J4OSge1sJXdJ4vwENEZCncvfOHLfb6jvipuPnd1lpMQDMgbVSTcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199018)(31686004)(6486002)(66946007)(66446008)(66476007)(76116006)(82960400001)(66556008)(64756008)(478600001)(71200400001)(558084003)(26005)(6506007)(6512007)(122000001)(36756003)(8936002)(38070700005)(41300700001)(2616005)(316002)(5660300002)(91956017)(8676002)(4326008)(110136005)(4270600006)(186003)(86362001)(19618925003)(31696002)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE5xaEpLTmNXNXhQTzNyS0JtWXNkWmwxQlhqNkF1VTVNYnVoMnFocWx4Rkxi?=
 =?utf-8?B?ZFNXRTFEK0Q0TVFVU25sNTl2cEZEWWRFb0FBNmFqZFJwdlhrc2NUcGRwM05k?=
 =?utf-8?B?eHNMbzgzVGZQbC9qSkFaNTR0U1VLcWpUWWlvMTFEUzkvdnZvcXBITmdZR2Yx?=
 =?utf-8?B?cFc4cG43cUEzUGZaeXNRWm45bEQ2NWNnblJUSlZGeHpwUVVsM1lCakcxcEJj?=
 =?utf-8?B?dVgxYmNQZ3A1aGpXVGZzNzdEMnVmbzE0eUVKdExiZ3B3Q3RTYU4wTXhUYUpz?=
 =?utf-8?B?ZVVDaUNxMytMSkcvbktUL0FablkyZjVzZEhaT1c1OFFKMjdzd25HRERhWVhC?=
 =?utf-8?B?UWcxSGltWURYN1MyT3JhVnlTNW5qVzFYQi9YdmJWb3lWdWpqd3dZNlVaNEF3?=
 =?utf-8?B?V2k4T1lQQVZSMFc4ei9RZUx2TEF0OVJsUGVlMVpNaCtuSlVDK2JXazVPZG1x?=
 =?utf-8?B?c3lSdUlidmZTUnF5emd3L0VZTnNDM0J1Q0lQeDJ2UklRRU8waXBQOTIwME1w?=
 =?utf-8?B?TWlaNHlJZmJ6dUdZekxPcjIwTXV2TjZDT051b0cxSnFnZ1ZSNVZRYysvT3NL?=
 =?utf-8?B?dTJMbVRhVGNqUzc5QW8yNW41OFpPUFNTN1ZXNDdRWUNqQ0ZTam5OcTJaUTUw?=
 =?utf-8?B?V216T0cvMmxLa0RPc3lHU3RSZkFSRGxIWEhibTh4dkFDNGJpL2ZHQVIxSkhs?=
 =?utf-8?B?eHkrWUd2Ykl6dHV3ZC9jSlhFcFFXZjhVanArbTJFY3p1TWxRZy96aElBSC9i?=
 =?utf-8?B?ZmlxQ1g5aXNUbmtRMmNENmVmVUFTM2pMaE1BQzJveThrSjBJdnZIQ1Q4TTVP?=
 =?utf-8?B?ZHlaU1MwWGozK3VQbE1VK0xXZWJqK04yaXBiaCt6SEViUlRHRi9zbnpZcnNy?=
 =?utf-8?B?RmgrRFlOVnAvTDhOa1ZOc0loTENMZmY3ZW1GaUI5M2p1Q2djMEVTOExoS1hi?=
 =?utf-8?B?ZmpURnduYlpvdFUxb0h5U2NFenZlbllaRjBwNzcrQVZJdEo1dk1WSXJhdFdl?=
 =?utf-8?B?YUkrSDFPa2hYeTRDTzVoT3lVb2F4azN6OC9WM1ArM3ZEQUxCaDUrcjM2RFRW?=
 =?utf-8?B?eTYyaG1hRGgwamYvMmRvMGhkZnpqV0FHdldOTnlLWDdscmk2WDVEUit1Y0dw?=
 =?utf-8?B?SFpjdlU0endKcWlmVkh4cEJUbXF3dDZiQ3JmK3VwRmEvTVBxNmo0OVgzVXNR?=
 =?utf-8?B?WGhUVDVRVnlwY2o0eU9BMzFnVWl5dUxIWGRwN1MvbzBnVlAvcjlEenNhcUpl?=
 =?utf-8?B?SmR6cHBMUlcySWU3UlI2S1RCK2RoY2hSeFp0K3lvNU9wS0xhSStHakR1VzFp?=
 =?utf-8?B?cHBYRFlXeThCNkZzM3R0K0c5eFA1SjhvR0dlRmxSck93Yzc3VjRwOXVIVGJp?=
 =?utf-8?B?S2x2c2I5bjVXdm8xWmlVUldrZFQ4dnVUQmtiZUk0c2U2RENMeGtLcVltSFFn?=
 =?utf-8?B?VzExRHhHYzJmM0R6VVJZVWE5MGhxU1cwT1NRR2JDWk16anZxVy9uWi9Mak9u?=
 =?utf-8?B?bVI0YmVzb0tiVUFJNTNmdUJucC9KTXhDZS93Uy9HYXp6dmt1bzZFWkppVGlD?=
 =?utf-8?B?WE9EU1JHQUpzbzM2VllKQzVhd3BIMXBKOG5MVlRwOWZ1OFhUTWZ4LzdEYjRX?=
 =?utf-8?B?TUVwL25HQXZnZmUvdFFhME5ZTnJQc2o1RDkyYXg0eTlMVXNkeEIyRk00MlRQ?=
 =?utf-8?B?Um1VTUp4UDg4Vmw3ZmpVSzZYaUtyYlVGMTJja3JGejI0NHR2MmpyTHBQY1Rl?=
 =?utf-8?B?V3BWN2NURlQvZWpCV3VzV0V2SmRwNFNlZ2NhVkVSNmIrZ2x1R2d4MzVFSUN1?=
 =?utf-8?B?RElGV2U5Zk94MlZvTmIvaVhDY1BtSW9MQzNrNXpRaHBGY1RESzAvV3ZSR0Rl?=
 =?utf-8?B?ODlubDFMSFI4eU82VE9nUUI4QTg1ZEVaWkNJUVZtWFdqZjYzTFY0bzREdTJj?=
 =?utf-8?B?Z1NpaGVvb0gwbkZHalFhVzdsUGpRd1RVQUJjS2RNMGI0UC92UVVJTjBOckNv?=
 =?utf-8?B?UTlXYWsxcXg5LzRRL0dsRVppWVBVVWRoT1VadDdyQTgwcnZXbjVraXNoYytx?=
 =?utf-8?B?K2hQRUlJWENYTmEvVDVYVmttam1jSVpzNkNKMDd4dWFTNlRiSlJaRjNYazIy?=
 =?utf-8?B?VVBvQzlzY2ozMlNyL2RlSE4va0hTc3MrYVFhbW1PMk5Qdm5UWXpVY0MvWlZK?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C456A3BEDF47C4AB1D71E35483B9731@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m1/cwZrusZUcGUJb/bcBtKtyx3CfwxiI3YddgWUMIoKznf6HFrGHjK0/W+8Xk4MBvu5zmRceRRZhTfT/vQsRm9v35fcnFR+7NfW0yi0dB9M0KOvr2p0HqPyIq0oOJQkMgGd6CO/SK6Y/B+tClN17CNHDN/2TMNKg/SVADsitd8a8DvOu4QIdYJ4K66959Q5+hXXaYfLVmSCYmSd9/Ps5N7rdfZAqgPFyBouzTZkg5EfiWPFy66UK8LygyiEFdk9TTDB42E2Dy4FhJyTrIsNOgWNJaRmSElGwD+YiIKPoYcLsnsMqhh4Wj/xZvPQ4QzEZ8VIqUhbHsnCReu/Pckff/Qo4PnCyUhpYUWfpVOQTPLpVWZmoaD24h7nqc2BRnCLBQ0z7P8Lh+RKWYXYDC9zOFzRjn+bczQRlsgauXKD2zuVCMHM16Rm2bD/8wf9Hhi2ZSrX58ieZ2kohIkK1Ink8vCk5rvmYPH7zSfbuy61BxCGEWlxIKwCq0ASiNG5rZHg3Lcq4BV7KwtXrpA3CSTMlAAwAvcWbdAS0ftEZLSZY/sb2kg9YbIpEjRjnfJmaWa6g/2nRsJSgeGPHpFj/vFdp7oSC5AYxlADghfV42oLVbi4Bf2XbedirE1GWzWd0+TTU6KCvJ4P3NGcZviL/YCeTQYcvQ+LQsVEedW+OGjMUObPK9811eDtxMOZqRxQwwCT5CUwmEpwcE18TWylOBctt74eBP3eRcbSQ7xh4sCLi5nB2+1cRsFVEX6JZ2NumxnplmhM2fVOCqZvHr/PzU6D7xGqLzb6OyuAKGfN2+iTa3lVAdvgMxUbcFVFi5j8zlb8YwkWzc4fSxbeD+hqc/aIPcQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19694d27-86cd-4546-2ec1-08db2532d4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 08:54:04.9169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0jBQTTBnKpva8ur0YK1gHs4vfrl4jhBylZ4h3UgEdIvAJjbdZgh7oFM4l7sVgnbwZTVAG5wiMtGoTrTtNwvaOkUMZSmCe/R6sS6IiJAj9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7875
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
