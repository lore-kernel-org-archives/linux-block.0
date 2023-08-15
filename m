Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FF3C001E0
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 10:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjHOKBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjHOKBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 06:01:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997EDE5F
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692093692; x=1723629692;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=lQgGs3VYxsJik/IvJdeVGChc0h9ntN/YBWKI0lBVDGxyEutUN3i7+cdU
   X5KWD15QtG1A3K0kkEmibibaHQQVGJQsuwKUmU4OUYst1K4zmT9fxzzJm
   kn127m208worfr6PlaMhWbAQAEksgXI4I/e/nAwPXFf38NSD+IE8BSIU4
   uDCHltnpph9o2S0DwTnrFPpohLsA7kBd+ChMsrnVVu7LGoUHIDo/RYQgv
   PusIPqbqX8Vc36kvoxf5yehGhgPhKFws1aZ2/VqjsI7LcKgI7S8WodP84
   2bngEJY3Xl1eSjCoJ4W8z4l0G7kKNmBWwVX5NoeOxM8lO1Z9rB4z9fOjc
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,174,1684771200"; 
   d="scan'208";a="353143597"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2023 18:01:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJPB0eGXAWH+YAwerYKO0E91isVFEQeZr6E7OWJkGUgtYZMTWVbpZIml/k0Mhw2/Z3KCCC0ZRi7QpkiRtBhpptLw47iyVBQCGCeDIGswry0G93IGgJFRQa1sNuLAgi7LOEphy810wGIapYekSkfLwVNqx2GWLlOWISr4k9Rxy7qYmzcl+9STZcc85vzvfqKc7pY9b0OMEjUTlM3Tn/jly2Ak6GZT5ypY82J8GTf65d0OopWE6av0Mk1S1tY33ScvIeTYAoIfeaAWlTRvXQUcncb0WLNKCQsYvFPAhFssNr/JOsC7nuM/GI9dE9ul5SkY4HkhrWfkckjAM1aEnD3xoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=h3lA1IbjjqsRG2pV/psxiFmBY0/ii8bNh2TnYyK9CHEcuKKvXpw8Xc3lvDrG36T9b6cVSqqniBtJ03cVatdRvT1fRPjtGcrV0mw0VE7ajaga1ix0yP8KJ0qcgPy0TnYxAaFhzJ5ifks7GVWHjRV9omy1IYPf5oeqE6T03Co0Xw8+thre8HJfTRQe8PwnffyUHYk0y7xDtH9qtGV8tpYTlAOMLBjKkb7SMkREYgfnXGXEBft0NZpaAlbObg/qL5YMh6qDXZ7zqJEH7oClzYXeoec8mR+ahii7sYhw3fgImGEXR5sumPsoZxQ/aymFaDR8CPb46VlrpRqhI+fzQortFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=TMoiTHcFJyLS4ov89soWfE+YBDnlQaRNgVprsu4SPNUN2tVg7nHa3ydQ3U4t3mpOlNou9s6YFUuVv3kt/6gjT5BPaUNTSNsUmaeL8rk/lQZfaDxJcfkYZ8WjHUhvdnosp8oKIvzHHrpkojlmzGKcesRn5JsXyQWZHyMFFqcRjHk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6284.namprd04.prod.outlook.com (2603:10b6:5:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:01:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:01:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/5] block: use pr_xxx() instead of printk()
Thread-Topic: [PATCH 2/5] block: use pr_xxx() instead of printk()
Thread-Index: AQHZyiHW3ulrxEM7qEKHgE0epB0l3K/rKqiA
Date:   Tue, 15 Aug 2023 10:01:30 +0000
Message-ID: <b6fb8ea1-bd59-41e1-a817-ba49021d2603@wdc.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-3-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6284:EE_
x-ms-office365-filtering-correlation-id: db2b7a47-59a7-4b73-80dc-08db9d76990c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xHCnE+UH81VVvoNy4zxSE17oFF1WHQpYdmyhtaEejaXqau1HQnISpbZR6NXq424Bq7y9Fd612DhP5AXfPwd1uUCQF2lCdN3qInMqWCO86RSWytMQeeyD7tBkmnVKka7B8DLuuZLopSdfHzZjOF7Lq0TqyoIrfKKwde7/l0dIInHmBD5LkCzC9oHImgwxCDMMgnOVdW6eLgSpMaMPvEJrZ6hbeervaLoBbWvIkF3eEq/M9lsLNsd9Sjbqx/xM179QnhXKv22ohlvhRbPh5r2vTUEnE0UVjc1gIiUyfkD72qnI728qXiXKti/kDzpOn5tHzdBd24lKwpQQxJNIgp/nupP9fW6FLlAwoTAv34qHw/vTIa0yqGuRVD1r7Q0VTl22btzELg/eVKpUhttHLLG9zPDzgWiESoOyrm6wpQx2Y8omPMHKr7LHe5e03B4Bx70d9IKOXUZS04lNHpJv2J0yBgumk09sFsn6FmO4W5MHMRsr+8mGsIT6MQClW2QVfdYs0/Z6vvy2QSCovDICM+FaWjxZd3dPj35BrG9FcZYvjea5oOSLSMfrYc1q358o5oTjE5JACo/aTtZP/FoAzJsTExxboIDGYfH0v17oPwdj5bvWwOoklLwHiBgoPjKWquLKrmxI0RuK6oSoVqtlWDrvSSuqiW6HZalgetX2nGe3WAncsO9dMnesZDTIUfUhhmq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(186006)(1800799006)(19618925003)(4270600006)(2906002)(6506007)(2616005)(38070700005)(478600001)(41300700001)(5660300002)(8936002)(6486002)(8676002)(71200400001)(558084003)(31696002)(31686004)(86362001)(110136005)(316002)(91956017)(66946007)(66556008)(66446008)(76116006)(66476007)(122000001)(38100700002)(64756008)(36756003)(82960400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE1rUkV2c29MZHdMMXdKc2JZUHF0MGp2RzBCc0pyQlA4N1BWSnNZZW1qbzFk?=
 =?utf-8?B?T0VGczUydUREWFlrazM5bWZsVU5EVmVKNFA3dkY1ZjZjTlR5UjhEWlVPTzZ4?=
 =?utf-8?B?Qm9mYjI3QjhTNDBwTU5scnc0QTlxRHdpQk9wcUEvV2g4VUJVdThrWGw3eWcv?=
 =?utf-8?B?cTdsY0VwZUdYK2tzOHFTcUs4dEMxKyswUnJkVVhGbTY5anlEbENOU3BpUmFW?=
 =?utf-8?B?bW5TcUVKQVg3OS9PME9MWVY2R1RaSy9sRytPWHl2UFVCclgwanpEa3FrTDFW?=
 =?utf-8?B?T2RjT3NkNUZscXhZWVhHZHlEWnVYdkUwb0gwbkxSNGVYb3QzQzF5K2Q4UmFi?=
 =?utf-8?B?MmFlbVl4eUY3eit6TDUwOXRzRnc5b0FGNHVoclE0QXlZb053ZTJxQWJjeDJS?=
 =?utf-8?B?a3hqeldhdXJoZGYzRE9qYVN6bDN6b0FzNHMzREJTdno2cXN0OXR4WXNJTUFn?=
 =?utf-8?B?bHBCMzJ0ZkpkRWVXZTFJOVhqa0tNN0tXVDFDZ1VyMkZORThIdXJUTHllODdV?=
 =?utf-8?B?TDhlUGYrTHZQOFVjTUc4Y1NJTFM5NitGZmlwbis3VmEyL0dEekVqcVdKMHI3?=
 =?utf-8?B?Nm9zYVpvN2c2RmxEdUpZcVlyLzZuWGVYZlhiT2F2MjhPUExBZEZvR1p5Rk95?=
 =?utf-8?B?cTlBRlMrWnJ5UElQTW9IRFFVcUNJZm5tVjhFQkR1WGUwRkVEQ2REbGhNeEhr?=
 =?utf-8?B?RzZnZmZteUczN1M0dmhQUDlyT1BkVkVIek9GeXNpWDB5ZERBNHRLcDJRY0dr?=
 =?utf-8?B?NlVHeWxidCs0RXgrVERlVXJpeENzb0RVKzZKK1U4NEExNHFLcWwraVczVHJl?=
 =?utf-8?B?N3V4c2kxWnJFY0xVd0QwNFRCUFRvY2VEY3ppRndiVVZYbTVvVkNqNngrZVhu?=
 =?utf-8?B?eEpYRzRCR2dUU0lrSGpUNm9GKzVud3Bka2dPTGw3dGc1R3hNL3U3NFNyMjVy?=
 =?utf-8?B?bWY1cU9uTmVQU2xEVm5EWlRiM1JIbGxKU0FjenFJbHZEVkdWVmpXQlJMRUhh?=
 =?utf-8?B?eFZiZlBmeGgrMTBKaDliUHBETlJyR1REdWFvQ0t6M0FoemFhQWNBZG8xYUg4?=
 =?utf-8?B?RUxIVVZON3F1ckNMOWpOTWYxOTNBWHpobEV2WWx4TlphUU1vWEVkMWQ0eS9H?=
 =?utf-8?B?NFBJYk91LzhUa0MwRFNrMSs5c2lKVy9aYTZDNnVoTmVOTHQ5SkVqSk0weEV1?=
 =?utf-8?B?T0c1d2NBTGRmT3QvdU91RGpKWENkanVuNjJtbVBXZkNFSDYzeFduUU1vaEt4?=
 =?utf-8?B?RVFUdU1pTTc5bXM2YUNsSjU5aloweUxqbTJpR2FxREFHT0xkNUszVndRbDNh?=
 =?utf-8?B?aXF0cmlIYzdUOE1QV050QXJDY09sR3JjOEZoeFY5ODNHc2tQL0J4VThVb3k1?=
 =?utf-8?B?OUxvWnNGWmtOUlVXNzN4N2I0cWEzaXZKZHZYQjh2TnhQaysxc3ZOTVpOU3A5?=
 =?utf-8?B?TmFiOVhjOUVpQUhITHhQN3l3dXBGdFZwZUZYekJiYlI4TVpNRTZucG13RDhY?=
 =?utf-8?B?K2QxMktJM1VHVEN1RWpnU1dGNWlKUm5WRDdoaHA1Z1FkdWNZRlhFOFNYWUV3?=
 =?utf-8?B?V0FLcFp0L0NhdXFwUjhkLzBtVGhZV1ZLVHdXcWY4RjNkbnVVZUZmYkJoVVQz?=
 =?utf-8?B?SlNPVnR2N202MFRKZGROV3hIczNHZ1A5REZZTHhQbnVnU3JtU0N2M3ZBL3FD?=
 =?utf-8?B?UFJoZ09QcWRVZGJsQWJmVmFrcG1hVW51QVI2enh6S1NhalRXM0J3dGU2K29y?=
 =?utf-8?B?WnV4U0RSN1lDYTlQeE5WM2xEWmxmSnQzV2I1OEVxWlpKenY5OHZ1L0FqQ2Jq?=
 =?utf-8?B?dEpER2RXMWoydm1QSE95NHgyN2ZNN1lDZ0g3MHpsUUloUDk3N3hWWSswY1Jw?=
 =?utf-8?B?aWpTZjkrNkk1c2ttTmQvdU4rSWRoWGRCQmpVTDlPSkJmM3FxbWtIeTh1ZnBX?=
 =?utf-8?B?WmVCU1ZQTFJ6YncvSVdaN2NhN3RKeEc1c0Z5YmlIRDZ4UkgvVWE0dzlncHV1?=
 =?utf-8?B?TWpNNUdnMVNBZUpFUzZVY1Q3Q0hOZUJUOVhkSmwzN0dUUU9DYjBwb0g0NWk5?=
 =?utf-8?B?c0RKNVFHTWhQZktHV2czeUdKVUFNbXdwN2g2d3JMRXZrZXF5Tk9CYStVQnNv?=
 =?utf-8?B?dGd6SHAvK1ZIYzZ4STJTcVI2MTNRSkNvS3hNTk1xSlRPaWl4dXZKVnk5amZS?=
 =?utf-8?B?U2VjRVdWVHRRK2xLYmhvZ2QxTzVNK3dhd3oyYWxJbkNqaTY5QTFtOFdTNXVh?=
 =?utf-8?B?Tmx3QzBiT3Bqanp1Zi9GMXlvOUdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CDA2E6F448BBC4589C539F27BF6C787@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YSWTTnb8YN29fX33c8n3GNGGvfeUONqbNEz9JxWoHrVwJquHZlHw8I1tLViOctAcF20TT32NEZWopSNUBBBS8WFmzAr/3+xsOjVK7jfdVzYm6F3pvcXuou+sKEL8PqkSHlT1vuCIx36vZqZSxo300S8N5hmOwKK5LB5XDt/LVjr7u9Wi/p5scZTzANXUcNm05Q8fzpmLUfX9I+4cw8cfWpHTGUxFRb+mQLpdFvfQS/MVOMa5S+LEtQnJJCe3+/pe5cTTWKbAmyfSdT9lTl2sMoAcsHXqYGBNwqIRaWylUkUX/pCEjT3XqFYtPA++VBEWM7rsk6Lg1g71pcH/hWpfHGeH489Kf7d1jny8hFA1aeClvU2bEhSf3kf86QGEfn5BwqwG8td8hHgBtrA0ldfc87DhXUU0me2uyE0Qtyrgg7Mc1z4UIYti7ek3LgbHkZSovwOg4sAFMZXCcQD6RR1W8MD8IeLHa3kqIcjjoZp3NZhTCewGJxpXYOXJ1fa+U5DqJJxPbFswGMFt/6WIcjPAzu/QnruVOizEVqIQ8NmcOV/JAzU/kX5Q7lwDq1GrrXIUa5n3vYNiERzlC466UN+4Yu1t2ZOVsyK3fTSH5b7UkFVDX+wIgFVGol4PmubStzU1p5t+1ajy8p9s0z9XtsMvq2J3IvA5B83S36R4bM8hVd9Ybkv0sEq8lQEXTYL7lj3wpGm9qYLFVq1+gQn4Vyg/pP7OBnzJl0hXIxHUeueOlDMN8+Zm+CRU4B7HdgJetY+IEFqdKWkJafAlWsV9IJF9Izh1s0QramrF9wTqMu+pjtTXqyrbyk1Vo2q52bwn/T92UZwlts4IJSQO7CR7mEFqOQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2b7a47-59a7-4b73-80dc-08db9d76990c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 10:01:30.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hR9I2vg3DgJr7sMxhp75/T0La0zuNFpj7B3hCW2Jx7oW/gjECHZ7e1h9uTRAWABehtZ0311SZp7Qu5NGDk8Cbh+q7JktIEzC+RDIoFfyM5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6284
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
