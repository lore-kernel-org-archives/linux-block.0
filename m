Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D9C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 00:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDSAD5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 20:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDSAD4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 20:03:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6515FD1
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681862635; x=1713398635;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=qXIy+IkGiE0aw14ykwwljj63970IxlaReQrpdX6QjIk=;
  b=jdXb1F5Cc+FED8IdAcq9JiecMCDGIl5QVXhlxVQOvEkYJTGoHzBVc3CD
   0tKIX2TarOag70AFBiU+p8hsWwdY941t0A5rQdrULYJkWt1XDAzTAX/r4
   RXEO4udqSb29aDW8Hmlxk/KZjYZB022J0kpIljC9aFtZbW6FUKJhNsddY
   OpZTy4rIQx2xl+UC4dso1JxdrSotfRDbVtYAnsnmJK2GuF3d3Cj3uZnt6
   iL21pLp0AEumEVV7ZfjxWFgtg636icQILhv1PjXquaEnp0LKbp7ZbUgRY
   IOcTPPIka37Yo5OtB6s0WOGuuEbbJdFheC6SRyUQGdFCo3pBcr0Pg+jwV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="345309779"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="345309779"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 17:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="684790031"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="684790031"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 18 Apr 2023 17:03:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 17:03:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 17:03:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 17:03:42 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 17:03:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFb8WiziRvaapxZXNrLwIU2jxv2Ek7AJe0a2nQokoLS7jh6CzwCkFIoBgCC8vYR2TlLRLmscD9dh4QJ31/OTGZO8MAquO2ydDGMQFc0sBn7HiWJKI/q22g6Ad4zeWAq4c8jZhkCesT5LCwshTzifUrbXbcZZ9g/QtlffVkoHH2W7Zw3O/Bgk1MURTYl+n846p7HC6xAEGL8NnEYgFKV2tXPAITt4M/1Z8KGqHtBQ4gAGT36Jh2OUW4Mb+wAX7jFDoeCZXtLvaIImFONh9wQ9TKgDQ8q1jCcHGZ3RYiDusQ9RjQiZh0wH/kTZPAgYJcuVQ136fLFV7Kn5fkSaOVZjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXIy+IkGiE0aw14ykwwljj63970IxlaReQrpdX6QjIk=;
 b=VKtxxl643saT+puL9+C7C2wrLTNkNELOsL8+A+ZJWqZsiD9wOktrVf7tVTP8nkGbqkw+Y4KL4lR8QsKswzWiNuG7oHXpEZ5GvvC66KL/q4mGRp3bLD5DMo2I37t1LLcuRYt1eclagU4CBlS1hHtKCTFHAyok3u7Zh6Kuxdsjl/tKMuaivp+29tUIAo7Xb2jkI2naXoAsQnFHpeCYFxBUkB3ylS07AU8vKZ25PRMU1VzDv3LNkGuxQczkl2Y9SXKFcpgPmWG/Kd4ivJzfA65xoAfrac3D+boTBGzSIzq45cJ65A4i0RNr+UNqYr0FvtgXNPIJKVL98hlEvUVGrIOSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3303.namprd11.prod.outlook.com (2603:10b6:a03:18::15)
 by CO6PR11MB5667.namprd11.prod.outlook.com (2603:10b6:5:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 00:03:41 +0000
Received: from BYAPR11MB3303.namprd11.prod.outlook.com
 ([fe80::acb3:9321:3e7a:25d2]) by BYAPR11MB3303.namprd11.prod.outlook.com
 ([fe80::acb3:9321:3e7a:25d2%5]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 00:03:40 +0000
From:   "Harris, James R" <james.r.harris@intel.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Question about ublk and NEED_GET_DATA
Thread-Topic: Question about ublk and NEED_GET_DATA
Thread-Index: AQHZclJlFAloe54viUSVJo35yBMt6A==
Date:   Wed, 19 Apr 2023 00:03:40 +0000
Message-ID: <0D50EEFA-BCFE-4D5F-8653-99656A8C49F8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3303:EE_|CO6PR11MB5667:EE_
x-ms-office365-filtering-correlation-id: 2989aa8e-72bc-443f-640d-08db40698857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOSfoS5DEGQvu+H0gIMZMM9ZEbuTPxCZvgwvXVWdQeUcd4cYupsGD77bbUOMd70uAlxK6HuuH/AOF9XtJ0DF0Ns+kpurvli/W4BwRP5SQbS7p0V3jkkD9Vn7Iwfs0V5zcx2/vghvoZZ1CZJBa+S08jDOGrNtJT1gilO8TqVveiNCXi6PRSLHm+CM1EjVDuzIZc4qORdIITGLUC7FmrteyzlAuApfIxcof8urv8GjtmysOBzhud1fCnJMJQb6ZqIegOj5JjQfLmQTCewA2X+x3tPQANY0FXhdLN8P0Zmmog1cMQo8R7H5l1xJx8m0AnfG/1dHZvJ+sHmySDoKS5kRCtCe4kNm4Rc2VnaLvr9Aj0pU2VZ3ngU8Ibu9mRDjDNEAWOIq0knyd7CgWIZewK2qA0k8u28mJuMuZ1qabzq/KiUMSPgYVNrCuqprOt25jOgV7iUdfx/4vUCTNkBKqws5pkwwAV5KTJMC5WM6RHJApfbTwMaALwYBox6NeniKEpavRWE516MgD04zh51ZvDcIVLLa3u2rY5ZdTBkPaVz0GcB+UzPwGIni6+5/2h5M3kBPkzjBrfVBfyXzawoJHsXTIOWFN61wGQGz7FlkBXn+nhvCgh7vRMrUOO/ESaMuPLa0SNeG6OJ65h4c2f6vMkTiyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3303.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(8936002)(38100700002)(36756003)(8676002)(122000001)(38070700005)(2906002)(33656002)(86362001)(5660300002)(478600001)(6486002)(71200400001)(110136005)(186003)(2616005)(66946007)(6506007)(76116006)(66476007)(66446008)(6512007)(26005)(316002)(82960400001)(83380400001)(64756008)(66556008)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk5hVUM3eURLTkQ5WGNja3BycllEOXJDVEV0SFkxTmwxeWhyLzgzaVZwQ2N3?=
 =?utf-8?B?ZDZCdHBIZG4zbjZqQ3d5bFVnalVvQ2JTT0Z5N3NWN0RJMDRreHlEME4wVStM?=
 =?utf-8?B?NWFsb3dqZTVia2xFb3VGcDNpS0RCTHpFZFQ5VjdZSnZ1ejQ0Qm1pNVdnYXlv?=
 =?utf-8?B?VjEyY3c3NWVFNFVCVmZwZzN0eXY4dUc1MTM1V2lLOVM4KzYyTkphVWNKb3lK?=
 =?utf-8?B?N0FTaVE4eGRVbVMrMnRxUVJ1Tzg0ZVNPdS9pVmkwME80MkF1VFdSTnZSNysv?=
 =?utf-8?B?bi9PeW5aUWNKeTFlVkVNbURuUHQ0YmttSWRKWk1mT2M1Y3lSeFNna0tPbDU1?=
 =?utf-8?B?ZUw4WjBzRDZGRnhQanZtelF6SUJVaGs5anllS1M5NnhNWkpzTFZwSVlWR2RQ?=
 =?utf-8?B?RmVOOU9ZZXpGR09uMzM0M2l5bGgzSEM0UU1FdDNDRUpHaDZ5UUhzRHVlRUFV?=
 =?utf-8?B?aHRpTFFiZnJSNEQzNUI2bm8zTzlUQW44eHEvR2lSVkhQMTF1cUh0N0E3am5q?=
 =?utf-8?B?U2hnYnlkNDYyN1owYk13eFFHKzg3ZVRsbW5uNEJKUkhJSnF4ZFdzOGNvUC9s?=
 =?utf-8?B?eXFiMGFTOEFxdVdnTEVnYWg2QzBGREJkeFM3Q1MvN3BHTUJQWlNXYVJnVXht?=
 =?utf-8?B?N0NaTjg2bXJrVE44ZFM2S3E2UTdrUW5GSDVOMzdlUDJObFlOUkh5V2F4d2Ew?=
 =?utf-8?B?REFPRDJyamRyYW16TnVzcm0rWGdQQXhpdXgvaCtrdFR1QS9vN0ZudllEZjhi?=
 =?utf-8?B?YmxoTXJMVlhGOCt1aFN5cVZOWHkvS0c5ckJiczlNQnVVeU84VGtvNzJFZUhD?=
 =?utf-8?B?U1ZRTmlOWXJzYkxyS2ZPWUczMjBVOStLVU1jNFJCaEhlSVpnMXlzNDJkeHdZ?=
 =?utf-8?B?L2pVZVZXcTBSTHZkWDRYdE9FcWpvY09aY05IK210dEFVbHNZTDhSK0M5UW9s?=
 =?utf-8?B?bkdXVmlqRW40V29ZcXZwa2ZjKzFjK2Z3cXA3THhZbnJLQzdlZWVuLzZDQWFX?=
 =?utf-8?B?KzJuTWllOWNNRytWSUI3b2VsWXowcTZTem5SZmZubnF4QXFWOUtGWHFUZzZm?=
 =?utf-8?B?YXI0MEN3S0dOYzF1cGZLWGFqYTlIejdkNHoyc2JIWFRHcDZseEdWcy83aWI1?=
 =?utf-8?B?Mzc1aFJlQkJyczU5NUVKbE8zRi9FajcvUEphdnBEREhNaWJCWFZkcjBwUVpv?=
 =?utf-8?B?ZXViUGVUb2E3by9ncWRDSUtQZjZPV1dlakdrRjk2bURSTGFFUUFYM3JuR1dt?=
 =?utf-8?B?N1orV3hGWTZUKzhjMmZvaUErZVY5TmhDNXE0c016VVorRStDajczcVBHMVB6?=
 =?utf-8?B?d3QzcXRrWm50QmJjZjJQSXNqbnJ4cGhvOFVZVlFvSnJoZzQxeDN6LzlFbFNZ?=
 =?utf-8?B?dFpzajNFekFzeDFzTGIybFYwZFkzbDYxWEtPajlWQXR4YXcxSUc4N0NSMUFu?=
 =?utf-8?B?MkNHSE5jRW5IMC9jT1dkWjBQTW14UmYvTkU5aUxVRy9CUDBsamJwTmVCbFNW?=
 =?utf-8?B?bzMxajRXSEVWWWpFOWwzWnpDcEY0bklLcFlWaXY5aDdFZmFNUkJ4OFhsU2dE?=
 =?utf-8?B?Rm1zWG4xWmI0cVk5amFHbEpPWEpBQUFOL2J6R0JEbjhOejlNQTdmcUsxZmIz?=
 =?utf-8?B?bWJPYmRPS014MU1yNTRJZTM0cXNpLzVrVHJXUWUxeDcvUDhZNmcxWktITml2?=
 =?utf-8?B?alJ1S2xBdks2N0lDc1BYUHdwajEzNGpFdUZvSFNITkZlcUtkRnB0cDEvdHk5?=
 =?utf-8?B?OUxmYWFJRC9WbkpMNHl5SGpFK3VhK1hlRzd1aGEzV203MEcyaG9uREQ0OVlK?=
 =?utf-8?B?OFpjR1JHeHNlRUNlYWxBTlBQL3FBR1BhNitJSlRLUVh4eTBGM2licVZKdW81?=
 =?utf-8?B?VUJRcTZYb3Jhc29BR2xZOEplZ0tjUXhRUVJMN25BY2MwWU1UalEyZkprSlZV?=
 =?utf-8?B?c1prVWYwTmxzaEZzU2NTRytTYmJhWkp5OXh3S2xLdTlOVloraU9rWVpESUlT?=
 =?utf-8?B?MEl4SUxBakhpMGNVZ0hOMEpjMXdCczRqd3RqOEl2NmQrNm1YZjNCOGpjL2Rm?=
 =?utf-8?B?cisvN2hZME0xNDBEUWhPZU4rVFFaVTJmOXpMRDNpR0U4dXNyNjRCWlRTY1lS?=
 =?utf-8?B?UGp4WWhjOHArMW1ZOTlmY2tlNWVtdm5naDhaZkZoVHdEay92U1lhVnRFTVI0?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC80A83B0A4AA4469C8C2800E1449EDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3303.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2989aa8e-72bc-443f-640d-08db40698857
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 00:03:40.6047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVjpb507NJmuqVAGNj+PzNL64cDSgQQdUFq15kEZI900K2ncysRDhR63QL843g3oVFZuBXMKIa3034AnOuu7mguFKnVtLvi8vIojKNoIq4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5667
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGksDQoNCknigJltIHdvcmtpbmcgb24gYWRkaW5nIE5FRURfR0VUX0RBVEEgc3VwcG9ydCB0byB0
aGUgU1BESyB1YmxrIHNlcnZlciwgdG8gYXZvaWQgYWxsb2NhdGluZyBJL08gYnVmZmVycyB1bnRp
bCB0aGV5IGFyZSBhY3R1YWxseSBuZWVkZWQuDQoNCkl0IGlzIHZlcnkgY2xlYXIgaG93IHRoaXMg
d29ya3MgZm9yIHdyaXRlIGNvbW1hbmRzIHdpdGggTkVFRF9HRVRfREFUQS4gIFdlIHdhaXQgdG8g
YWxsb2NhdGUgdGhlIGJ1ZmZlciB1bnRpbCB3ZSBnZXQgVUJMS19JT19SRVNfTkVFRF9HRVRfREFU
QSBjb21wbGV0aW9uIGFuZCBzdWJtaXQgYWdhaW4gdXNpbmcgVUJMS19JT19ORUVEX0dFVF9EQVRB
LiAgQWZ0ZXIgd2UgZ2V0IHRoZSBVQkxLX0lPX1JFU19PSyBjb21wbGV0aW9uIGZyb20gdWJsaywg
d2Ugc3VibWl0IHRoZSBibG9jayByZXF1ZXN0IHRvIHRoZSBTUERLIGJkZXYgbGF5ZXIuICBBZnRl
ciBpdCBjb21wbGV0ZXMsIHdlIHN1Ym1pdCB1c2luZyBVQkxLX0lPX0NPTU1JVF9BTkRfRkVUQ0hf
UkVRIGFuZCBjYW4gZnJlZSB0aGUgSS9PIGJ1ZmZlciBiZWNhdXNlIHRoZSBkYXRhIGhhcyBiZWVu
IGNvbW1pdHRlZC4NCg0KQnV0IGhvdyBkb2VzIHRoaXMgd29yayBmb3IgdGhlIHJlYWQgcGF0aD8g
IE9uIGEgcmVhZCwgSSBjYW4gd2FpdCB0byBhbGxvY2F0ZSB0aGUgYnVmZmVyIHVudGlsIEkgZ2V0
IHRoZSBVQkxLX0lPX1JFU19PSyBjb21wbGV0aW9uLiAgQnV0IGFmdGVyIHRoZSByZWFkIG9wZXJh
dGlvbiBpcyBjb21wbGV0ZWQgYW5kIFNQREsgc3VibWl0cyB0aGUgVUJMS19JT19DT01NSVRfQU5E
X0ZFVENIX1JFUSwgaG93IGRvIEkga25vdyB3aGVuIHVibGsgaGFzIGZpbmlzaGVkIGNvcHlpbmcg
ZGF0YSBvdXQgb2YgdGhlIGJ1ZmZlciBzbyB0aGF0IEkgY2FuIHJldXNlIHRoYXQgYnVmZmVyPw0K
DQpJ4oCZbSBzdXJlIEnigJltIG1pc3Npbmcgc29tZXRoaW5nIG9idmlvdXMsIGlmIGFueW9uZSBj
YW4gcHJvdmlkZSBhIHBvaW50ZXIgSSB3b3VsZCBhcHByZWNpYXRlIGl0Lg0KDQpUaGFua3MsDQoN
CkppbSBIYXJyaXMNCg0K
