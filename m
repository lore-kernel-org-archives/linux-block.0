Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDFC77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEQKA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 06:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEQKA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 06:00:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964431B3
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684317654; x=1715853654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=jsUF+kvL6t1CvavcWIfrcF1+LkdSmLsv6FKWtYG9G9rANPHmxOhnKQNy
   uRqDizuVZNE4TcMEbktJoAtXpGLfe2fXCBn1Sw9PK6FDHhsxLJJAB8+8N
   meznd7qYt9om+qbphxmuRrBVZ/0CektIksjLpVhhoHxrCD8kFwl8SrDp2
   obvnt+KVONqvbZhZUo70p6XlTA5r2+0iUSWFNkGkxjwMx+ixSvdOSRBrL
   HxZT32IoFynY701DSveWwNJhyvxDI51BkZW7h28OFUxoL1JjACStE3HiC
   knHNfSz5hfabgd8lFR/+NSUJV0Gw01Ea41BqDfy7zX71RTXIceNZozyAT
   A==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677513600"; 
   d="scan'208";a="229166825"
Received: from mail-dm6nam04lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2023 18:00:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoHfduVVajyCEQKZ4kfixsVdHDKWP8woZZIolDAzdLHf1jAMsRMV7ePmS+9Nbvohrk/XoFKQz9TL6ODjHuPLcZRwT4YmxBuqVr6t1/zMu6ECZtUWaT/IzMV2hboJbv9Q6Eknqu0XnjL4tHD3tKZ9cW7jkaHQ8rxwen2XJo6HU6DRbv9TENdUBxckd+HqMBrnIPhRjaqxq4ufYng5moV7Z3JlCi70s6wD05RN8O/lSYrekupcJlZB7lH0kyQuERARHJsi5If9IbVT9DBI5owlHzUi3SXTTcpAeLpzWTR4riI69gOkH7fFafK2bx19zUWsiktsG4LYO1oBofLUER1upA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EHUi+wYV1ve1XSm5eqmTLE/PhudhUKwzMUhoh8Rj5yNyBdFMq0Ae1stM4/v0njuI/ktL7eQZ5a1EsNbnzXQWD7Qzptr/iPhOk599/8zVTM8v7cc5CQuvCX9T4vUy8Mri6ctSeQA0debfHwDRZT/NgY6x/OX6DCAbAPC5FtX7t4HAnZxwwk6AwRIkRtMXlYCG63yLBEmdXCD6l7ralTfkqttPtowJZMiGL47LEkHWcNbsc0NLpk/BkYikLdsRnz9s6fJQKzIy2LCI5cmmVZzMTldQ1hnNMiS03X6HQ1XM+/bQSlH5jIsMKGWVKqF66L1rdDxprH1T/fe2dKrsdeBggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=GFD8FiDmdvh8Cd5X3qdvN8uT0/Iq5UpWN4G9Yf9t/RWVtS70WUc12x6zJqXSZ0orFLDo5cTm7lEFX78ti2V7jCiAnOf/t0zzohE/bzvmA34AR0BsEI6CJXVsyMwLmROF5nudZs1685lAkY4qNBsM/oQB3q+3FUsyq6/b9BssD9Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6851.namprd04.prod.outlook.com (2603:10b6:a03:220::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 10:00:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 10:00:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 01/11] block: Simplify blk_req_needs_zone_write_lock()
Thread-Topic: [PATCH v5 01/11] block: Simplify blk_req_needs_zone_write_lock()
Thread-Index: AQHZiEZ1pGYPfEed30u3HjaGPetTAK9ePFyA
Date:   Wed, 17 May 2023 10:00:50 +0000
Message-ID: <c90adf26-a547-c513-9921-1616ff282dae@wdc.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-2-bvanassche@acm.org>
In-Reply-To: <20230516223323.1383342-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6851:EE_
x-ms-office365-filtering-correlation-id: e5c021d0-8573-414a-0602-08db56bd9807
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1bIN4JCfbPoSYx3UZfflsEaGnf3Hmu3BHcIFQgzOwANAnd65ewz9cwz17b1ykalfmSAQBuXPjQDr1c0ukYlF2U76QK+FqWWPtzl9SuHWXGP7fZw61PW93Am9T9M2qN8Vhlc17/iTsAtBPqDk7wA60MqTWpK4RmCUREUNklq89iz8WRBXrgDXsnfnJ80bxO5did8FBuHtbf3FTukn9GtaYZO+vQuo52VGp8Y0teCVrCaHxZIudNOGKhxIstVA/avSNJ0DMWa1cdyvYwn2yBAdhANXlO83qRasTcrkcAC9+2MiYBaTbxk6yCZ63I+qAD0ePjoD8lPWnclWld96pHWa3zJGoQuycXI1AV7sB226vxvQNfBE0JlOvgI2+6qcYEBWbXaFBRL/zAd9mE0F+SRIeDi+voAY/MDS9cA4gHbJCmVd47JlLk97Q2DRqXiGG1cHhjlLIskz/TvG10N0Vvm8eH7bUTLN0f9OuTS3k7yK4mWoHpCCkCJZsFgQgd1ZeIL/CAnNi1du2iIaOBhNSOmz/48cc3H6D+SzxtoHxMDO0FHEEqw8Fp9LouVynaSxv/NV//hhnOr5zGRh/fmlJFGnBpnWFQfN62EkWBLUrS974UtPtWVMrO9D8NB5Alfacz5tMVg0UWn/dJBa/HkRKW+L5CoOGUFtjqfBbZsWbbx1Zaaq2Tnn3IUikc+fRnODJlE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(31686004)(122000001)(82960400001)(558084003)(41300700001)(8676002)(2906002)(8936002)(36756003)(5660300002)(31696002)(86362001)(316002)(38070700005)(38100700002)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(91956017)(4270600006)(6512007)(6506007)(186003)(19618925003)(478600001)(2616005)(54906003)(6486002)(71200400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3hUYTQ5UkxmaEU4NktodGQwWEZ6VlU1emdvWlJWNlgvRUpaWiswYjdBUXpN?=
 =?utf-8?B?YmZkNTI3N0JVREhxRmVndEFJRmtGRnQyL0hlVlNZMXNZTks2U0R0UUd0WGdo?=
 =?utf-8?B?UngrSC9qVWZJMFZ5ZG42UHZIcUFqMWl6T1RUUUlhSWlrQjRjWGhvS2NuVWM1?=
 =?utf-8?B?bjYwUjd1YjZNalVBTXJtR1BNMDNYS1J5NGVlZFppN3QyNUV6K1lEaFNEQWFZ?=
 =?utf-8?B?RzdIVU1Ud2VaN0JTamF3QThjOHhsejVnUGZPYlM0QmQ4YUt2a2JTVWVCY0ZN?=
 =?utf-8?B?WWhDNWVMUFVlUTFXbkdDVXh2ZDJJSmRQMTNOYW15VUNYRGtzWXQrMVlqejNk?=
 =?utf-8?B?b2JNWWdHYWRKalZyMFRVK0N5ZlkyUjFVaXpvdUxIMGM1TFJMekdWRWhxSVBv?=
 =?utf-8?B?R2d1M2ZIV3NMQ0JGQzRtY2NnV1RIVVZUelV2RXoxb3hBeWs3TFJpaFdxY2FJ?=
 =?utf-8?B?OW1NVkNTdyt6aTBLVS9KRTNwMTBqd2xvWUQ3ZG45ek5uNENlNW44TzRzOWRT?=
 =?utf-8?B?eVZBdlBpdzdhUlZEakE4ZGZ0eWhxblhDbmNVYUVBbUlNWTRtSFhobUU0aXE4?=
 =?utf-8?B?amVGbVdtazdDYnlTT3hsaEh4TjNBUmdHSktJbU9yY3ZsWEM3eHNxaElFejlB?=
 =?utf-8?B?alZkeUVKRHJOS05IYVhoMS8vUWc5NG9LNTUvTnFWQmtSOVlFSFZaaDRlZzY4?=
 =?utf-8?B?RW1rSWxkSkk5WVR4NnBOUkZROVVnQW5zWWNCTlNVTFlId25SY1BuYnl2bExw?=
 =?utf-8?B?bmhGOTYwZ3dyZzU2bXVIMWwvM3k3ZVA3VWZBQlBQbXBHZjQwMFltQzdaQjI0?=
 =?utf-8?B?WjkrT2Z4UDhpZUxjeVM1TmpSSFdwekthS3NkOWRMMzdMRW9uamJYNkZTR3Z4?=
 =?utf-8?B?ZjA1cTc2M1l5cmZMRE9TMTFXR1pZMU0xTnpiaDFsZnovY1Y5bmhsWWJXeGdk?=
 =?utf-8?B?SmliMDJXY0d5TU9VOHhoRWtObkUxNTU3bklGdEc0bUZrbU44eDZ2NHV6QjY5?=
 =?utf-8?B?Q2RIRGYwZWk0LzRZeS9FcndWeHRJVExEMzU1ODJUQ0ZCTDE2RnZTWCtLTzk1?=
 =?utf-8?B?Qm55NTlZc2x4RHFuWWdqUjhKTm4yYVFJN1BvSzZ6Mk9kK2xMU3B0Q1ZKR09T?=
 =?utf-8?B?elpDZlpibFV5KzNoMWlpSXpZdndWRkZVSE1GOEpoTlo4b2V4ZG1xYmdiWVph?=
 =?utf-8?B?YnYxTVRIZWc5TnRWQWtJZ3VSMXF6Rmx5S25xUlExNFM2dUI4c0FxdENCVVBh?=
 =?utf-8?B?SlpqemJFSCtkNEJzdU5WOWc2SjF2UlkyajB2OXdHTzk1S0FralFNZzhrNFpu?=
 =?utf-8?B?VGM5QU50VkcrckJNbHBOU2tPSlJSTHFDRFprZ3p4bUU2RXJZMWRNeVo2Rnkr?=
 =?utf-8?B?aUtFQ3pkcU52UWFoVnY3T2pSTmRlbXpHcUxEYnB6MUNDdklWY29hZ0lreEdY?=
 =?utf-8?B?b0VaaDBQV2NmNGhodytaVTNZc3pMQnFidkZKSzBtMHlxTktkYmpwYW5kbWZu?=
 =?utf-8?B?TkZyQmxiWFdoTGdqTHkyMVFIeXZyWURJQ1djTDJ2bE4xNUhWOWJMMkU4bTlS?=
 =?utf-8?B?V1J0N3o0ZDJhSHA5ZVVWYU5qcGdtMFhWVEFONXp0NW5LYVdFYnlTVXhGMjVi?=
 =?utf-8?B?dGgrQmVjVjJZTnpWT0FQYk9vbHZnS2hGY05hdnlEZzRsKy9qVnlkL3RMVFpm?=
 =?utf-8?B?Zmoxa1NyK00vNUxZQi9wbS9zOXdldzFYYmFMUi96b1hIUzErS3k4UUszbjBk?=
 =?utf-8?B?U2orbkU4RFlRUHdtMVh4SG9JTVBTVGlCVWxYaVgyeEthWTkxMGFpV1pzOVA0?=
 =?utf-8?B?ZG5WNjA0d1c5YzV4bjAvWm1UZnBMZDJYUlJpcUlxVjdnaFZ4MTQrZlBjR3lZ?=
 =?utf-8?B?WEF6VUN0L0VqTnIxSWRWRkpyZ3l0RGpTM1NjSkZrV1BVdkgvVXdWaWVxZ1Iy?=
 =?utf-8?B?R1MvOTdxQnM0dlVBNWNJdUhPQXVyeHBIQzFJb2lPRFNrNmVwUzJGZkU1eHFU?=
 =?utf-8?B?bjQrZldIK2tVOGhVcExqbDROZWhkUFA0UXA5bjQ5anlDd01zVk8rMHEzb0hl?=
 =?utf-8?B?ZVdnODZsLzBLYy9OUlBQN1FHeHFaM0k1bWFhRzhDL3d3VTJGNTlHL2RhTTVI?=
 =?utf-8?B?aEV5MW9rSitRcmZSd2w5UlY5ZmI4di9CRm12TzVFMHhZc3lheGZieGRvWHZS?=
 =?utf-8?B?OXA4MlFDSktYeDBWbEtYMFF4T0xPbkY5c1RndnpJRElxU1lRTllYYmI4Z0tx?=
 =?utf-8?B?dEgxMmhpaUNrNUtETWMzM2t3NDB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <558952EFC18BD442A6A8C64C75245666@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yM6nZJQ1ukSAUxihrrvG8xExBOwsk/r1Ft4JrHK7I639o3YHSL5dLSF3R1hjW8FGAteWtViskuq5Fmu5o/PW2ofqHVC7ukeTeW+m6k5lu8Ck7F3Iccs/6cCVmlQsi04mBUb4+JXhZxwcuhLkT1hgOYxEOTzStSF++WpMy1DKYK0Vehj6dUFVq1O73oxiA2TrtfzWXcx+5gQt/yEquroJECL7Jdcru3MKOP8+0QdPDZ1jZTzakp7lol/qqxA4/nu8OtEg9vx+bQtsOyQENgW+zV46LnmnIRDV44eL7lqIFff09RoX6Hw/S8UwNqATUkXzR1jNnXvWw0mpBu8rs7EmfKXXTRfk2mb18RYyBRDc8rnNeh1gXmUfCPUTQCbhhW0LaXvZyt2mHzVWp+WBqwly2O7a4Bg5kQBNQS4l05m1NktFkQt20RpCZPDAHXLFZJLcj6a0WojYAwTbRJRVC5gKEhkRucqKFdOcITUxyK9afbCb7D7hDaJ2tw2Ha1Nox1kLQWNW+7gl2egUkf0fouucFJ3gJ6TfkP4hu4x7X9mWTT1keoYKFMmN/MQ2rZ9w9XlG2hCHWRTe+4nsMM78brU/0ZV4+FvSN+6f4kBtfgLN5jsWW6MoeZVBPd1jzWeGhAD62aqTV/otg2hm0FouggS1NAJ9YyAMW4+qgw8TxHuJCzRCKP5vNL2DTwkZZe8M1WlM9/XNtA8jv13lwBxSvArox82NnUJJsI7jIOE6l6t1dqEwmwZ6//W3biOgHTl9V6vrQZCCokbCZujVLndfZYBCEAoYzsPNZnBdOFzVd0SIjIVbdsRJhAvkkopbw85QkmYF12JfT2rexihKusX4GUB8xno5X0QFoahHeJgsFw3L8vtMuQWCWz1eAFFLJCN6KKs3mrFdG7314nPevFgG/VReXw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c021d0-8573-414a-0602-08db56bd9807
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 10:00:50.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HRjiewauxVwomDeL6qoRzizbpxOr2YCKEA/dPGa8e0pw8Gf6FcOq9+T0BWlOhnw7v8qqk8OQggWqCYHjdPC5kVQa5/YsB/Ch3oKBnYhhXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6851
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
