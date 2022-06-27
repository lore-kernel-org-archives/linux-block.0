Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516EEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 07:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiF0Hfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiF0Hf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 03:35:29 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD475592
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656315329; x=1687851329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0fGrd/tfXnvXvJ4ZIdr9PU7nWgiloKo4AOWS4lPggP0=;
  b=KxQiJBJUefec211UWpL3VnwOdM5XBPG1VTT1oHgLly4SX3TLPwuV9LLn
   jlVScU4FKvKbVOxZl4r1S7reXYwtzXmdGZhRm1YEgOHxiJsIvFszn2Jhc
   G46XC7iDtFAwHK6x39w7CfcOqxwQReVEZRHsff87XSaoPLneGYaHMARVz
   ChVJ5HkeKrKP3uqznMnbNQvy48nGaBK4nIAD/jmY9i5P7LJT/SM7JARKv
   lKiBXBpS+1FP9Y6215rwlMydGPSteLh28rXfBhyqD8JCB5wt69TU+s7+E
   AAyeKsOAwdk1+on7DCXjdVrfyH/1Tax7p/EzsPZVZSHFlWY2/1Rs26quQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="60398140"
X-IronPort-AV: E=Sophos;i="5.92,225,1650898800"; 
   d="scan'208";a="60398140"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 16:35:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gREx763iOf3kO3+YMaj+s4o+dN93lC5bMthvlQusFbyJqdh+ML61QUzprs6SAMqKNVzoHUr0PQtVQRiwZ03Wsn0n1qZqBIIpPE0wCtp29y+HXBarMeodo5/Ch/s1lU3VzHHHNn+WbkAxeVR/XXyjueeqOJSGddaUunmF8r+Qg+1g5K6iGgq1sLV1tp4lsDBNVJEQ4kB2qyJiw0ehb+WgG4umjfSnhl2iW7xHgSmeVd7yGkxfwHYpnllH/Gjz1nJXNDHLg9b+Cpxbu9E3EjMo2GdIrFjKX7Ak73MKafd4jgk2LwuofC3kq74HBcG7pf4OLmtO9+74i/mmLNqOHrEJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fGrd/tfXnvXvJ4ZIdr9PU7nWgiloKo4AOWS4lPggP0=;
 b=bocBNNpCLZ1TjS80M8WV+0yBzsAAZLmhMFQkXy1hApsE+E35mpvYCS2+OEjtFuMbcOm/uKZoRRH2EE6QRm2uKjoMPv/RnLZKXlNyNWXfchbx0wd3qiuYTxfX5jqXfR7Hb5YWuwb+WzAAH+umCaYkvX26koqMaIjXfIKA3raBflr7FOR2YrCQtcFuiX1hrj8yjTzFTzX8TJ+ewf4fx8R18gLYyyVKjM48ess3psAd1tm9gj6KEaUOKqlpYM3YKv6oSu5nEjIsppKBslAZy0FzTtqMVYUD+EfdGLi2QKTKcfAeaOiMo8kIRrxyNf47Y6eQtQnqV2Y+twVzq+c1hlEeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fGrd/tfXnvXvJ4ZIdr9PU7nWgiloKo4AOWS4lPggP0=;
 b=dyxi+Fs9bqftB68fPvHwTmkklK5CCH2ZlSHl5Go3aY0Y65sqDf04iAqGvCZvtfl0gjGNSFdXwQ1jEpXWOKVUZQRo4G2CmGVwaGSvCri1OB/q0O5xjxKlHpyVZgsHQoQeyp83At2qPY+vPvuJpwE8nu7w/35F02N81REXT5ogmmM=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB7239.jpnprd01.prod.outlook.com (2603:1096:604:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 07:35:20 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::64dc:d945:cbcf:6068]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::64dc:d945:cbcf:6068%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 07:35:20 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] blktests: Split _have_kernel_option()
Thread-Topic: [PATCH blktests] blktests: Split _have_kernel_option()
Thread-Index: AQHYiWh0KHR4LIrN6UOxexeHWj6Pqa1ioUsAgAA8yQA=
Date:   Mon, 27 Jun 2022 07:35:19 +0000
Message-ID: <fff18cf0-ecd4-b76c-a484-08f7177c3897@fujitsu.com>
References: <20220626142428.32874-1-yangx.jy@fujitsu.com>
 <20220627035744.idl4clbv6fn6fepx@shindev>
In-Reply-To: <20220627035744.idl4clbv6fn6fepx@shindev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9e33ed3-716b-43d4-d50c-08da580f96a8
x-ms-traffictypediagnostic: OS3PR01MB7239:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/QgDpzUPGPppWHXm4NZgkjNCcWdqHtne1RWN+h6Tdpld2VwLLcPEVaN2+u3GqO6YSfMiv+geIlk4VH8ySe7iMVMRNYD4NHdiy+5m4mk88LLa/jEZ47d9N6izkz50dOtN1lQa1N10mzsC0jic7zbYyZjJEPbugbR3r0uGe2QxHnNzkHn7GeKEzMXM4hdR96uk/gn3p64YDBUJ7aOM6ly4w9/m/l1Iq8RwO/SHYrxD8bq10h6jOJ2iIA/hg6FJrBgWypYgYaV4GReHzsXwMdErGmNvXyObAs4WZCK/U7LBezOB9mPpiBI8yVqe3VOQVOmEqnbl5X3gYEcCPOxCSXUGypFbki8yzdfX5d8xVPcXvKf37UXagaIwwvk69LTvPH+wN++dxgTAfaiW2WGSXcenr9aOP6noIfLyzxsYM7DkbZh7n38rNJc7iGla/dLyh+efEbfs/w0wnauRezG+5TEMXjMxdB1/mcIvwBftyMqo0BclpTvDob4RZcCCwwS8ccg+d8RJKQzcJegw3aeU3ritE5bnusD3N+JXAZdnrrhrFQvkzRzmF/NsmI8strxw7Z7+WPVcX8MiBkY7jWHIBFanSdY4Omc1YQdrylxxazp124DIyWIbViqd9NAUqOhZdUCPjkbAKuAlbNV3oXDH/SOqZ2J/pncPLGKb9eTZBuWW1eJdLWV5SSVCvERnOjDzcs/Ssp2MgXT87YRij6iEYgd/P8G88Q/NncV4mxCMXlgfC6uedW5gx3ZxtoLA8nURWBvU5wcJwfMdCl8ejxnlyht54lU/2KY29JqwI0rwVVs5Rqx9U/KwtN7osYCpx5O15B9luZPTc/XAK44UXdzMqvYLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(6506007)(4744005)(66946007)(122000001)(478600001)(66446008)(2616005)(36756003)(85182001)(8676002)(66476007)(186003)(8936002)(5660300002)(6486002)(53546011)(31696002)(86362001)(64756008)(31686004)(26005)(71200400001)(82960400001)(41300700001)(6512007)(38100700002)(38070700005)(66556008)(4326008)(6916009)(2906002)(76116006)(316002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzJCTEwybzZ5VWplcFRiVnpRQmsvNVFsS3NuQXJqZHl0cEd0akRxdHlNWlBw?=
 =?utf-8?B?NG9iUnVFZkhka3ZmQzBsMDM1T0k2RUxpR0k3T0tXcjJCelJiOVBZMjlLVGNy?=
 =?utf-8?B?NzZJNGVnR3ZpdWF3OVNJWWcvdGorTFJzSXRyd3pBRGE4TkR0clowNVF5Mk55?=
 =?utf-8?B?RWc2eG1mTGZaOGVqNVNkR3BlRzRWUU1FTUFJNVgxdkRYVXQvM1cySUhjakJC?=
 =?utf-8?B?aWtPcVRvTkNsVnRrOEhBWmRWQ2dpdXhOOGhQNEhsMEczOVhmSURORkN1TkVy?=
 =?utf-8?B?SHZzNENPcVRsSk54VWFVOGl4SkdiRGExZ1JZZnN3OVlXV3hWMWQ5Q3U1Mi8v?=
 =?utf-8?B?V1FPcUM3MGtJcnlvTktJbURXZ0NsSm1DSTNYdnNPdUJZZ2xmOUluNG1qdFZx?=
 =?utf-8?B?RTc0TllzbGFNdGtJVFVEb0p5dXg3VEZxcHRuN0lOQXh1c2ptRnhUb1NkQTNG?=
 =?utf-8?B?WnRUNXR1aEtyUjA1eWNONzBKdHBpTGFZaU90cmxWYW9WMmZyem1YamVsOW5h?=
 =?utf-8?B?Q2s3TmFHUDVSbGxDZnQ1ZEc1eU9EOWtYWTAzdmk5bUgvTU1lQmJEY2RWUzVS?=
 =?utf-8?B?WEZiTHdIcm54TnJhV0VySzZqVnRGeDZBVGQrd1MrVnZpTWhJYldsRWpSMGZs?=
 =?utf-8?B?WjVSekFYdkRGS2hReWRpNHpQbHl4cVkvMy9TRUVjUkVIenpMRmJ4R1dXbnRa?=
 =?utf-8?B?bm5GeEcxVU1tRmxOZ2JUWGVDQ0NId0tTQ1AvMmlwYWdpWVpxUXAyN3hyeTJU?=
 =?utf-8?B?YmVYbGJtYVRzNmVHUWRTdW9KU2NmdkQxNGdLYVVnTG5TcWtQSkl2MlkrU1J1?=
 =?utf-8?B?SmNRQ2FmKzVrU3ZiRXZndWJub1Y1a0lRWW9GdEpLS1A1NEVJUTlMVjhkTVMz?=
 =?utf-8?B?dnpJRy9qNzlJb3kzSDN2RXRhSmc2a3diM0VVa04vejhZTmNySUtDTWhTZGxy?=
 =?utf-8?B?RkJIdEVzb2NJelZTdUY1eFh3eFBwQjB6VnUxNGpaWHlRSEVWMExZZ2VUaW85?=
 =?utf-8?B?RlJQWVNrRzM5UzB3WVR3eG9OK3hncTg1Vmh0RWU5aUUycXNtZEJNSWk3Nm4v?=
 =?utf-8?B?YWlLTWJFMGlOUXV3RG5PcDliK1VqVUZYV24vSklJeVBPaWRreHZyZElLZFVE?=
 =?utf-8?B?ZVZ6WDNSWjA4RWpaUWtEVyt0QWhRd0Y4VCtSSitDalRhUVFjU1ZEMGJXMFE5?=
 =?utf-8?B?clpUZWtOb2NBaXo4eGxuU0ErSmdESW5Wc09KZjRDN1hXdUdVUVRrQkJDYnFQ?=
 =?utf-8?B?Q0t0NUJmRE11ZTkzclFyVkF1RDVnY2JUVmNNd1Jja0w4ODRXTEJpVDRJTHd3?=
 =?utf-8?B?cGNlTURWK29BTGxEdlFRaG1Cbm04THBFQ0V3dis5TjR6WGxJTFdYWHV1U0g5?=
 =?utf-8?B?Q0IzZ3pmb2orYm1NUmhzbEVpeFdES3ZEWDdDM2xTem1jSENyMCtSdkYzS08y?=
 =?utf-8?B?QWE3c1QvU3JlQVdENXFhTzZkdysrc0FhaWhsa3JmdVRjVWdndEVyUHQvb0hS?=
 =?utf-8?B?VVY2ZDhpQlRzbUh6eVA0OXR2Tkp2eG1sZVVLWjIrbklkdWw1bVhJSjZYbzFT?=
 =?utf-8?B?a1BZaHpyT2ZETHA1dUdGQlZuZGhOZG54SThqSHE0dWc0TmNyZ0JGQnFlTGps?=
 =?utf-8?B?b0ZBUDM3cElISU9iUVZLQkRMZCtTT0VoRnE1MTJnUXRveXFuc1k2RGNtYkRu?=
 =?utf-8?B?MnlXdEZiN3NJa1FJUTM2RDdwQkJhZzVrTWZuUHl4WFZzWkxvdkdlZDFtb1pY?=
 =?utf-8?B?RkVGWTlsTDNzam8xOFhWZDVJMFVnRWNZakg5OVlzd1VIcW9UWDhJWC9vbXE1?=
 =?utf-8?B?NkxzSVhHT21RMEFiSWpCT0lkeVVmSUdSMHpRM2xHUzQ4U3VMd3dsYk51allo?=
 =?utf-8?B?aUllU3lGdEJ5Sy91eDlzZisyaGx4OWM3UlJHS3NEdnZSYXQ5MmdqeEhleUJ6?=
 =?utf-8?B?UXhhZVg1VFNyb0ZHYXdUY3Y3eEQ1RGVvTnNmdjFaa2FiblNvbkhsTFF1MVBJ?=
 =?utf-8?B?TjBLeFJTbTI4MXE5VUN4UXAyUmQ2YVlEdm01SmN1SlZpYi9zemo4TUlTVlFw?=
 =?utf-8?B?K1pnUmtVOGc1Z1c5VVdKV0ltYUxuTjhvZkg5azlpQTN4Uy82ZEhTRzN5MXg1?=
 =?utf-8?B?UTBNODFIUkhxT1ZaTHRQcjR2Ty9pcGtROGZWWk9yb2NuQVNqUytYbjREVU42?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47C860B78281DA43A3491F95FA1B461F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e33ed3-716b-43d4-d50c-08da580f96a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 07:35:19.9872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4IBD3Zc1d5sbEPdbC4PcYsr8JK9jL6AtsB3Gv8M/69lFRE+UC5zskCFeqI8k/AWHuGewCqP762H7Y9n6532Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjAyMi82LzI3IDExOjU3LCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBJdCdzIHRo
ZSBiZXR0ZXIgdG8ga2VlcCBfaGF2ZV9rZXJuZWxfb3B0aW9uKCkgaXNuJ3QgaXQ/ICBJdCB3aWxs
IG1ha2UgdGhpcyBwYXRjaA0KPiBzbWFsbGVyIHNpbmNlIG1hbnkgb2YgZXhpc3RpbmcgX2hhdmVf
a2VybmVsX29wdGlvbigpIGNhbGxzIGNhbiBiZSBsZWZ0IGFzIGlzLg0KPiBfaGF2ZV9rZXJuZWxf
b3B0aW9uKCkgY2FuIGJlIHJld3JpdHRlbiB0byBjYWxsIF9oYXZlX2tlcm5lbF9jb25maWdfZmls
ZSgpIGFuZA0KPiBfY2hlY2tfa2VybmVsX29wdGlvbigpLiBUbyBkaXN0aW5ndWlzaCB1c2FnZXMg
b2YgX2hhdmVfa2VybmVsX29wdGlvbigpIGFuZA0KPiBfY2hlY2tfa2VybmVsX29wdGlvbigpLCBz
aG9ydCBjb21tZW50cyBvbiB0aG9zZSBmdW5jdGlvbnMgd2lsbCBiZSBoZWxwZnVsLg0KDQpTdXJl
LiBJIHdpbGwga2VlcCBfaGF2ZV9rZXJuZWxfb3B0aW9uKCkgaW4gbXkgdjIgcGF0Y2guDQoNCkJl
c3QgUmVnYXJkcywNClhpYW8gWWFuZw==
