Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6535C77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjEPMAn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjEPMAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 08:00:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8630FE
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684238440; x=1715774440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=lP1Z1pJO8k7/ViSGmJJY3i73jv60YdsEwAkUzUFhrguPD2dDmX6+Fwbm
   XfKcGwe4rl/jFxrDbBFy683fOomJWCCtBvigYS0MtZnIAUJQFp0K17xdd
   MHaRnrFp7QaO9OItTMKaFiynrwdanJEYv8EX7DODLEWeiQU82eqF3lerp
   MSGzhQyaAIHAKArZA/bJVjKLnaXT/oRbKf55V1nFGAqPpjwwun9rS2kJE
   EMFSxyuEUjz7sojrie+dysVKh35QRuL2ZOLmlLqMxscQkomUs3AF1JbsF
   mQ3cgMrhNT+62pPRL4iz84BFuQKSVKHTFvnxpbKeX+WU4laRpvTBbZaHY
   A==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677513600"; 
   d="scan'208";a="229084878"
Received: from mail-sn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2023 20:00:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADBhT+kahC5wqfm2b5F43YQ1j47/5DtmfJBM6MdajBm+GSANyCe298u19+J1fWCXUEw4CeL7SB6jlB2pUc6+CS433YwJUtFBK/AQnJp2tNjexzfB8traSP0c0ofjNzV1MqDQmecae+ytpUw/BrSVGfkrc19X6JShvCQl49GLjstNMYDVskhq0hk1zpUKFtyDSdvJyoq27zBaVP8TqKvhu8QUYQoMd66AhwsDM6rA3i8sIaN/t52+V9d3RJQBkSjIO/fxJ68DshhXt/rIJHCewaG4GHoS8b05/ClbhA0K5kSrJzkS42rtxgcRpDo0HfomZZL3R+Cqy/sVYjhsSUzlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KH+hBvujrOm2W0bsXYL8YfuwdXYjwvQkwplJjRN/iJNwBHTswFDZNG2lxBtNNKitLpGji1J+f49kMcoosWc8ikbEiLErABEGUMwlf+01Qy/lmDhZJRfushgcP7b2kRXYX842ggOtpSAdftpXz+UvQRCgDfstYLFMOyrw84wYVhVspVrRNmDXaesmbsJDjqQ4foCXi/6mjpHBTlejbrqWFn6RvGJ7dvKGxngcZxFz6HTvaO3tMAYMngD2zvYBHoJRpeKKVIIWJOeairyq0CwWuqvHebvZAfqgzam4kx0B+fVyjHMt7msI3NHoL5rCpxkr4FqR4OPYcsNXTEyeav7T3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=e6twDwmM5Ex/wdhwRrkpErzuG15hNHhvp6FQgzGBFTNz7bQWpBQIJnsio7+gmibnl2VmDCelzVc3wijr4Kq4HqRpSj1t25Tdvy30AqiLpmywiUzjyWOlZxbGy5M+moietJUajpJQHU6k0ygCfntNSxBYF6vYyOcTmz+fL8vM34I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8889.namprd04.prod.outlook.com (2603:10b6:208:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 12:00:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:00:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Jinyoung Choi <j-young.choi@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/8] block: use SECTOR_SHIFT bio_add_hw_page
Thread-Topic: [PATCH 2/8] block: use SECTOR_SHIFT bio_add_hw_page
Thread-Index: AQHZhNcwuZtzMt7XU0O1nRIM1cmL4q9c0lyA
Date:   Tue, 16 May 2023 12:00:36 +0000
Message-ID: <0b98ed92-e262-cd82-d73b-d7d13b593f2f@wdc.com>
References: <20230512133901.1053543-1-hch@lst.de>
 <20230512133901.1053543-3-hch@lst.de>
In-Reply-To: <20230512133901.1053543-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8889:EE_
x-ms-office365-filtering-correlation-id: eb8bea8c-05b7-40fa-6a41-08db560528f5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxQGYCZk7Cr2gnMwOLOh95hOOo63JVF7Kh5vNfenL3/x+FrTWO3rqj/pb8IMdQbYelgW6v/Bk73zAIVCuc4Uk+MIeq/3czi2hRtI8QES/s9E9zWQ7bLVpKvLfa+V+a0oQZZJXq9C6G8angUn0A7NsQwaA2X+AawqsvyW4daAyGgs7GkAA0FN5z5OFFb2u2WWbV01R4+Evk/iQgwB8YEibG8LC4mnldr9qRWMkgZpduAWMYldDbIkRLqJecBZzjQXNertqlIKRG2yYJXaIEmm72b6FojZNgT/eO0sCDJ3RVmFxUbNeY5GluZjsLm42wBnnqH6HqlbZnlYkbJM4QNNqFFCepBw3lmCUJnXQgJc4pEDKN8R6hsNhNb//xm/qOVqK125boNEDqexb4dCOXaRUq19+T4YLUbvCfgBfZJEfcrlZKSTPSuZnn884qeuLt1W5/JvPwEXeF2N/DP19Y1TAVP86rOsVQhcWhas8Zb6O7iFoMVl9cDmQPWOcyCX20UxbS9O346OUg3lW7wGmoLy/+4FHKk8jUHBTRd6UVQoPKO7PeHIoRssIadgB4P36y/vipovhEQdvKCpoJcQE0TtlN6CBEvicjhdwSRow6ILSGslRD5QIiKUmh83/1Ch/VsHNAX4UmKK5JHNlzudSz5y5f1EmIpfc6UEWZocHebIAYAFBkhz4J1MZo6pctcNKyuf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(36756003)(38070700005)(558084003)(86362001)(31696002)(6486002)(110136005)(54906003)(316002)(91956017)(76116006)(66556008)(66476007)(66446008)(66946007)(4326008)(64756008)(478600001)(71200400001)(19618925003)(8936002)(8676002)(5660300002)(41300700001)(2906002)(38100700002)(122000001)(82960400001)(4270600006)(2616005)(6506007)(186003)(6512007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzBQTEhZMHJRYkRCVVdxajVIRkFiSGJaUVJ5OEVLYldLR05pOXJoTnFYTjVV?=
 =?utf-8?B?R3RMUnFkUHJNMkxCU2thUVBPWXJ6Q0gxR2JJQVNwV2lFSlNxVmtsbGhrMXFT?=
 =?utf-8?B?RmwrT3dobTBwWjIyTEprbEowZ0V6RUhYOVYwRkpPcGJCU2tDSjVoblBVNEE0?=
 =?utf-8?B?N25HajY5Z0NmSkJMbFlkS2FBNWw0T0RGNFcxUlI2RFlPb1pUd1hWa0RTaXBQ?=
 =?utf-8?B?RzB3T0doUGhHQm40Mko2ejRxdlNNR2ZjSU9HdG9PZkxaN0dTZys1U1VPcWtq?=
 =?utf-8?B?UmR4VHpXQmJLMTFVSGsva08vdDFSdzNGWUpLR0Nrc1A2Tm5kSEdSd21sRmNi?=
 =?utf-8?B?MWJ4cElsZEptVitWelFzd0xCR01YRjJHeGZwTm5Gc2EzdDE4TFd0REkrb0Fn?=
 =?utf-8?B?Y05JQU9HeEpIZ1ZDY0NFSGFNL2VSajFrVUFzT3A0allHeml3U0tiQ205eEpY?=
 =?utf-8?B?TzA0MFJVcjdHQisweHNKWSsvbEtsdE5iMnBmOGtJbmpvTXZaTGVXQVg5U0dI?=
 =?utf-8?B?NGdtMm8xQnM1d2pXT3BZQnB6MVlsaDdhbU9zL1BzU0sramVnekNTVDNjcnEv?=
 =?utf-8?B?T1hacmxGMDF5Qk53WEtIT1dOTjVKQjIxWG45aEhQdVVwOEJQL1BUTVlYTFNj?=
 =?utf-8?B?OEVFUlBjNy9uWTJVVTZ4R1lWNEpMcjZJdTh3OUtvaFZlT084ejZlQXoxQXhF?=
 =?utf-8?B?UHA3Ly9ubmgrQS9uZFNEd05iL2dVbElPZStlbTk5WW1WOWZXd1FBbjVLRSsr?=
 =?utf-8?B?MmxwTlNLSndmWnpabnBWQjJ4TkFiOUJVU2xONGMrQVZuWTgrQno4dXVnNkxQ?=
 =?utf-8?B?WGFBY2JYV3NDaEZmdE9DK2FBUG1MSTJxZzVKeTA4ZjVmZzB1aXZnbWIzQzJ0?=
 =?utf-8?B?ejQwSzZSU1RiSmRQU0tvVW9LN0Z1K0QvNU9vZys2endTYlpDZGNscTBGcXFR?=
 =?utf-8?B?enpFRDRPQzlUZUNXR3BRa0dSbmh4bnpRNUIzYkZmbXBmaFZBeDlsNE4xMExt?=
 =?utf-8?B?MmRad3JUZUkva0EvayswQnpKejlVS0lLSTVuWTJxNFBaTFoza1gzaVlha241?=
 =?utf-8?B?K3hJMWlmZ2pLS3lXanVrMllISXJpaU9ldmRzb1phRnNpNlV5d3RkSFhFelB1?=
 =?utf-8?B?NGpuTE5ncGJ1T0pqRnNUN2Y2UllhejQ5T0t3clRidmhNR1daY2xJSmE3Ukor?=
 =?utf-8?B?ZTNMb3R6WWpmQW9BZy80OGNNam1mTlpCOHNnR1Jxc25nTGYwNm5pNkpVUXRZ?=
 =?utf-8?B?MmhVckxuemFuY3BhUWhqMWVzVlBFTTNPcDZrYW5ld2tTNjlTelpQQnZlaHFO?=
 =?utf-8?B?YzUzdGRNS29PdFVWaWxhUkRCQlFRSzM1OGE3ZFN5Q2ZuQUVDUmh0TTQyeGR2?=
 =?utf-8?B?VGJ0TkUvK2tuL0JUL3pCM1RkRDRLRm5Gd0tTRnpYTWE3N1JlcEFFWEV2TW9v?=
 =?utf-8?B?RGV2b2FEZEtvTWEzZW1lRWVhaHZRYzV6VFc5N3lZMlhPWkcvQkYyMktvSGpV?=
 =?utf-8?B?WDJMbGRjem92SUIyTG9yMXozUjhnejNWZWR0TlhoeVZBUkF1M3NaR2c2cVl1?=
 =?utf-8?B?VUdDaWhXbmNWc3RPYmNIRS9lQnFXSE1vaEJSZWQxQ1ZhWjhmbS9ETGJCUU9X?=
 =?utf-8?B?VWRNNEtaSVFBdURBZElCTFIwZExnWTZoY0sxWmZ6SCtvZ3dHM29mNk4wMERM?=
 =?utf-8?B?d1NuTzViT094QWJzSXlMZEhaMWZOY29LVFBSS2NGM2loeEJaQXhJTWJ6bmYr?=
 =?utf-8?B?UGQxUSs4L2xic2JzRmJqcS82aDA3ckY4Tm1MUHR6UEZtZEZoS29peFAzYStC?=
 =?utf-8?B?ejNOKzdtZUZiU2ZyR1J6QkVkYmttS21LWEQvOFRlOUxLZVZkNG9wcjQrYkMy?=
 =?utf-8?B?Ylh2V0xoSklSaG9uc2JwcE9CMlk4S1B4Vy9sTmRXVXRxeEJLcjBFZDdJdUNI?=
 =?utf-8?B?ZCtCdHU5MmpSdXd0OXp3QVRmcUtOMVBPU05tcndIUVJDaFcrczJiekg0RnhF?=
 =?utf-8?B?dWZIL2xTbkVxTjBUSkR3cW5hYjAwa3o0Ynl3L1BrTjJyQm5TU040eENRT2E1?=
 =?utf-8?B?ekZ5Vmk0UEtQaDZFRHNkaFNKb0M2VGZueWlRRjZyQkttVEhxVGNzUXhnVmN0?=
 =?utf-8?B?dXhvTFBvRkFZdkJSOW1ieW5Fd1R0cDBvTkRqenlOQkY5S1g0cCt0UVpiQzlO?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63AEC5A4121952409B5A3FCB86F6B4AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qITA3blMgtNFYi7qT0CdwWmQ5ASsQf2Rdtm9koxqmwOlZ/X7lLSlOqSm4tLBgXs1bB+cDWvQthvyCvTQko4313r1mKaRxNRiG8xko1TPhDmreDl+6oD5y7B1KBrYTlWXhjAmo7n7g3Byc9/4v4YZTiUYn0F12qaY1gp84gpc4lgwSBeJQnMqFlJUqwm7R1SLE7ME2nbZQa5OjBZogEeK30giM1D0/Z/oKwWThJRjjykRAmAPJJI+KcjysId70mhBP4gahNeayPRiYHDh5Hu5iR4dVLuMVmXdAyQx+D27ICCoeFhDVCgPLz/LgWO6nUs8cnafM+3eaGP1gUFui4rx5enNTL4SsbD6SkwhHNq6LFiWNzQClf6B8GST3JkbljMn4lbttOm1O/KLZQ0SBrbtB25WGLXvLL3yOXwI9opAzkl3/6j5m7v9YZBboQGf9RF96+5Uftvtw0kRed4tmkZpB6VC3Bi1pqJJ4Ghj4V7UNlbIsrc4VIBeCmUGhlv4bzhs5aeYL2tlBuwv4OXj0xwBX+2+96Ak2TTHigeLJ++eDza9b8VojSrZw6KQfYlw+MutIhGnWW8tkm5pb+o0LTfYaWGE+VFSEaDTb9rJAanPdZbD9MqDbZ5HIy0aYwBhWVx58pKT4p1qoLIFBsmwmYgCqqmiMQUvcnmuer3P3cnkn8K3UrXAOlHCuYUOZWbJh0cJzXByOb7cdvTgu8XVOd19Wn1uZVaaO0dWY4CgWiAIBesEpm/5fCdRGL+/Lj4lX9ai6fQhrcDdlbL+0FaI5C+Uay4tYTrzm54V+shOE33/tzmBYZl3S5LNaeOugRNQihZ0TzC7SN127YWjZ1hvx09wjOHd6yVJU/NzM0Cb0BP8xVU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8bea8c-05b7-40fa-6a41-08db560528f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 12:00:36.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqjbENFWBEn1O5AVhQPEXwYHc0eTfnhCnuQ2sE3za0JSLDeMutE0MXRRg1tuUszys9IhvT79uM5lCp7YlfvY5/8QT00h0PrH05WJ80guWEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8889
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
