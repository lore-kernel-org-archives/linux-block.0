Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F84BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 01:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349897AbiDTBsw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348404AbiDTBsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 21:48:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5632980
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 18:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650419166; x=1681955166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jgql0JhVf1EArdrxBl1dQekIrvIF6G2qWKZPmhb5+QI=;
  b=aLwqfClL3VQR9CpT/1xM4OiF8kZaOYPgxXy5F3iDF2w/9VoOIPYt718s
   M4XeanPJ/Zgmuy2vKOEKORFS04oaw0TJ+bhot8sfYAxY1RwGC/Vyo2mJf
   H2NYYZo0uy7QvSbW4+nTr2QncqtuNlhj7BdZvLbNC4DmzpgOVORGW0Qki
   U+jACtn+bhnpsOSUd13Yq/8s7028XP15D1Sqk9u88aIoPqulX9v6NWhuP
   r3Aorx9aexNKHaSDeoe9zhZIHGn7pAWEXCX7xgE9/TgobnSW6x8lO4SRV
   OnqPjLYBrLrHlYVSfhEYZoUXgRq7C8oQAhdp/ieo06O2xuiC6LKIxkjU4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="264085766"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="264085766"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 18:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="576359526"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2022 18:46:05 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 18:46:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 18:46:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 18:46:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 18:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo5OGEvRc5CaaehS21+ZGzPxYiKfYQxnY6gYy6d0ALq21LShqj9wZbj4t83uQc+B+anBhpC1CkfmRVfXMw3nwVvuCWBM1tmr6Jl8ZMNi1ZKMcx6iFnkF9VYUtrZijnj0zIozHgIkIWFRu4RpRPPPhuw3/RiKc64P1Bzr6Myi1L5QAsKXbNT7rTpMGmoBvEU+aVWnOvj9MaQ7DJa3vGye0j3MSkP4J1FaBLzNW+sXTqTbFGGHtwcokhObtK4QSZSMQMmkcTDteB8iKG3sEze3p9fAov8nVc/UMha4+tpVVqKewZfyhfYgPm6Q1j9XhXNfSuJe5ZnnzYTwP9S2n0Fh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgql0JhVf1EArdrxBl1dQekIrvIF6G2qWKZPmhb5+QI=;
 b=m8EkDhGrAAd1+WfNbo8qdZEbsgn1Ojt10epVVLKzKkDJXSfQjW9OCPtQVSqJSXNFJ7bnNsjantv859vqsMJJyNhZkis9LFODyiOxcrYXLtw8vr9VRRL21LsykkAZfoCbLu4HIt14JEIC9+n7DIVo6OopZleOvB/uMaVxUh5jggcheTRvxwDTWicUnVQvewAYOXVenbSvXweBIHKKxw7SJNS4kC5Gl+ARnSYG08J5ui6nPB7FTf21iNuSY87Y/Q7r6qJt0C+20qAWVeu7teaO/tvRZS3upPVfgLEiKddd0jvfiFDIw1vjvo47DeNOvsLM/qSyayu+Lf57t8BvNSME5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1926.namprd11.prod.outlook.com
 (2603:10b6:903:121::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 01:46:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5%6]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 01:46:03 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@lst.de" <hch@lst.de>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Thread-Topic: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Thread-Index: AQHYVFhlNbn7ePuJW0Kr1xnNN1aQog==
Date:   Wed, 20 Apr 2022 01:46:03 +0000
Message-ID: <eac2af72d9e73f79bbdbe8253f7562d9f17046b3.camel@intel.com>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
         <20220318130144.1066064-3-ming.lei@redhat.com>
In-Reply-To: <20220318130144.1066064-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-3.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e981645-b3e3-43c5-362c-08da226f87a5
x-ms-traffictypediagnostic: CY4PR11MB1926:EE_
x-microsoft-antispam-prvs: <CY4PR11MB19260B96CC33931A2CA85F00C6F59@CY4PR11MB1926.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l17pJmjcS7LWQDHbQ7HW9+egfpFL59v5tMWc8DCJ6ETDP+ZO0Eky90fIPxAhjdZRcTifFr40ieeYRMsQJoNyTs7IJrMFRoYDcHeedB9oGEzJpPgAT231shYRrW7t47Rqywo5qFpVAcPB99EJKfancX16H4LfsGm1uqk6udGyAqZzHcaJ1QKdft41i2t3zvJkqaoljpb01ZXHD+m2AH3fwOw0uPSkr/7BO5VfRPIYD+Dra0+JzWLlIrmy46lpON7vDAWT4eqcg0U/O5v0CdX6ccjU+Xy7GmrwyBSVeUdpYD135IS/k49JA2TEpeKdNdSsZd/7tjVMkUM6pgi+n4uWt0KRwnd/3jWqRZMDD5gJo3P4K07aYnuaBARhsd9mR8NWZw2PivPsY7C/nCywu066xzJpzxTDmLi5w3G+2RdmNv0edSg7+gzWaLHVWKQE36vvEfSEKdMmWrFW62YbgjbwGz3bbCksOfEy3mD0JknMwvUipyQcX+XQGC/eD4q2yHUOMK+1uoNbaHuQeGWCj2BSt3uOJ64IBr4ppBm1fEuVbHTsH6nqfeZRxWmn6HuORiuecS5QQ/wZV26X/wNrcUmZu8/iT8OHfxvPKcm/kzybATTabixBCtSN+tYNrcH8ZRLVmEP3xne7/hGcf2y6mLrMRLxEprikUFvBRxQKPg1PgRq7X27EcGoXz5A6JoSZT+sX8V8KLSJ1F9AuCSBGHGHOLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(71200400001)(2906002)(6486002)(508600001)(91956017)(86362001)(66476007)(26005)(64756008)(66446008)(66556008)(66946007)(76116006)(6512007)(6506007)(4326008)(8676002)(186003)(122000001)(38070700005)(38100700002)(110136005)(316002)(54906003)(36756003)(83380400001)(82960400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FnZ3lOWDFCc1RSa0lFVmo0WXBZR0JJRWJzeVJaaUg0TkRZQTJLRFFUWHRI?=
 =?utf-8?B?TzZhSnM4SEpDeXJUT2Y2WEMrcEN6OG10blIwL0hNdDNXRHFLbklGRWhtMTRv?=
 =?utf-8?B?eGtteUNhTG16QWJQcDMvTkhuaGVxN1hKd1hGM21NNHVIeVVMKzZLZVFtNkRL?=
 =?utf-8?B?NmkrNk1saEhxWW5RN2Q3RzNsTVpqbmcxVmJ6TTNyMUJxU1BVRWI3RmVreFZB?=
 =?utf-8?B?cjR4K3pXL2dPL2FaSi82UWdTQlZaYjR2QVdSaGhCYnFoYXc5d05yN0d1cUNY?=
 =?utf-8?B?cEZ1aldSZzNhdWJaUmVGMnAwMkZOVEl0MXRwQ2M0U1F0QmpMemFmMkVJNE1v?=
 =?utf-8?B?YVAwUlZqQ1NYSWpRUm41U1JQR1kwR1huK3p6Yk1NUUdkSnNsQ0VFYytxZmtQ?=
 =?utf-8?B?bDltSEUvLzRwWitNejh3U1BnQ3A2blNnUXpxUzVlb091YitWUXY3RXdVQ3NH?=
 =?utf-8?B?czFEa2o2aGtRM1ZGdkh4ZkJ2QzA1TlZqRzVYNU1wRm9mY0szZit0c2ZVZWNB?=
 =?utf-8?B?amdOSTYzenlXa1E5QVJMdC80VkZ5TGlDQ1AwdlRRQlhpTXc4aE8rZ0U5OVdD?=
 =?utf-8?B?MjFlTklsRGRZVmpGS3RKcXZ4NFR5aFUrNDUvWFJ5a0ZrY2FjYlF0TW9mOHA2?=
 =?utf-8?B?eVlXY0U5UjA4S3Q1WGRBQ2drNGJpd3YvMWFOVUJGbExVMkNKTXJLK1hQb1Np?=
 =?utf-8?B?Rm1QeDdoemtSR2sxUlJCc0tGRkRGTjR4bHloaGVuZjMrV3N5Vmhlclh3MkR1?=
 =?utf-8?B?UGdTMHgwVFFtVWFaS0tIQXJtK1c3QUViV0NCQ2ZKR3pDVGMyOHlvb1lTU1FW?=
 =?utf-8?B?TzA4QU9HMzVBb2p1a0FScUlHdU1hV3JlbU8rRi84dFBqMGxpakxwSkFUSVdG?=
 =?utf-8?B?aVp0bUEwQS9XOFowRnIybzZCSllyc0lhd0hKTkJBaFg3OENXUVAvNlA5ZStN?=
 =?utf-8?B?WExVd3JoeEtIcDZTYlJmcXBDbERaZHpPWmNRcE8xRHkyV3JuYy9QZkthL29j?=
 =?utf-8?B?RlNTdWhuSFRCWXdqSFVqb1BLQ2w0SE9sb2JobzBSS1RqbjRQOTV2N1k0elk2?=
 =?utf-8?B?SWxpMFJ1dnhQaGdjWGdDc3pWME5FQ0s4VFVRNnIxcFhWNDB3cklhRHMwQ2Z5?=
 =?utf-8?B?K3czQ0p0K3MzekRKbktHaTcxUlhCQSs2M0Zxc3g5OGlMd2tSME5Xa0k3VldU?=
 =?utf-8?B?VVFTWmpBN3I2aEplZkk4K2xiTzFQczdlWSt4aktERjdyYXpqY1ZqcGdwR2wx?=
 =?utf-8?B?MlRiYWtGSkR6TGUyODQ1Z1NwWCtlK1piRUppckR2NW1nVzk5cEdOUCtMRWFh?=
 =?utf-8?B?T2MvMlJVNFRZNnhtdFRuc21lZ2hsNkdtQklPQi96ZWR4WUxTWlR3U0hMVEpD?=
 =?utf-8?B?anNwSVBKb29vZldoK3ZKVjlXVDd5NnhIdlNpelpHUWwzdkhIU01kcmlmZWY5?=
 =?utf-8?B?eEE3NUkzMVY0ZWpjSlJzTndSRXowbnRzWU5SdndBYlU3Z1VlS05TazdjdFZn?=
 =?utf-8?B?VHhpM3NpRzdQNXpUVllFYmtBL1NjVDBuVXh4Si90eVcwdGZCcUdQdGxKRmVt?=
 =?utf-8?B?VXpLN0V1dm5ibERDU3ZjcnhudHVNT2hDK1RWcUZOL2ZXMkVLU3FveG9LMk1p?=
 =?utf-8?B?alowSU5FQ3lXeU5BZkdoUm1tQU9QaGxGQlhJbzJZOWRCaDM1TzFvcGpkRUZi?=
 =?utf-8?B?cUdVVTFEQVlyTTROdVpPSU1EV1NycmZCYmRrQVhvMEZGQW81eUJvOWswZ0Zm?=
 =?utf-8?B?bUFoRUNodnNnOGpGTnd5TzUvQXlZeW4rMm1uTFJxOWZ3S1YrMUd3OGs5NUE5?=
 =?utf-8?B?RE1hNEpFVmZjaFpBOEtJam42VEJ0ZDVHWk90WWVBSWlqaGt0bzVpTDBxRGt4?=
 =?utf-8?B?TXpndnRDWUhDeE1OUWwwbXJLVnVuSG9FN3RMK3hPc1NKbFROeStOeWthL1c2?=
 =?utf-8?B?ME9ZNnBTL2JyczlwUTRxb2tnc2RWMXFKRFRuQkkwV0hFdkJYQlhPSmM2Qzc5?=
 =?utf-8?B?UlZyUlRzODNKM256c3VIaEhoRGRCR25kSTNvVEtsZUczVE43WVFJbStiZnhU?=
 =?utf-8?B?WEZqMlVwYkZiQzdRTGQ4WnFTQmFEbEhIM2JzcVZEaDBTaTAyaG4yQnpBemJE?=
 =?utf-8?B?eEQ2RVJJYVdRdzh1VWdQR1pzeDZKOFZReTRNZU1zclUrMjhwU2JvNzVyUVZ4?=
 =?utf-8?B?R2o2MmJJaENUOXp5c0s1N3R4cE5KWTQzT0Q4WEFWRFhUdHJmUWphK1NwN2pG?=
 =?utf-8?B?NTM1YnRsRGJGSVFHWTd6Rk1jTWFuYXVsQnhGN21iTW5DQ0tvRjMwaHFMTHdw?=
 =?utf-8?B?MWJBVU9aL1REQUNpWjdPaXRzRnRLaHNkSFA0Y1oxelhHa3Myb2ZSREtqMU5V?=
 =?utf-8?Q?x9kQZztpOAZ+a/aQVOEMhTJNk01nEExmaQzSk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32E09AFDA4907945A77E8837DF32F52A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e981645-b3e3-43c5-362c-08da226f87a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 01:46:03.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alazQ2UIsplpAH9Aglmu+QJELojKO95oJqrKv+0dIKp7nBQFSq7AJjCoNpSv9xZeOrdh3qopC9MVBO8Kzadt7Kj1Z3ekKlor6bRr31YoJUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1926
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTE4IGF0IDIxOjAxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gSW4g
dGhlIHdob2xlIGxpZmV0aW1lIG9mIGJsa2NnX2dxIGluc3RhbmNlLCAtPnEgd2lsbCBiZSByZWZl
cnJlZCwgc3VjaA0KPiBhcywgLT5wZF9mcmVlX2ZuKCkgaXMgY2FsbGVkIGluIGJsa2dfZnJlZSwg
YW5kIHRocm90bF9wZF9mcmVlKCkgc3RpbGwNCj4gbWF5IHRvdWNoIHRoZSByZXF1ZXN0IHF1ZXVl
IHZpYSAmdGctPnNlcnZpY2VfcXVldWUucGVuZGluZ190aW1lciB3aGljaA0KPiBpcyBoYW5kbGVk
IGJ5IHRocm90bF9wZW5kaW5nX3RpbWVyX2ZuKCksIHNvIGl0IGlzIHJlYXNvbmFibGUgdG8gZ3Jh
Yg0KPiByZXF1ZXN0IHF1ZXVlJ3MgcmVmY250IGJ5IGJsa2NnX2dxIGluc3RhbmNlLg0KPiANCj4g
UHJldmlvdXNseSBibGtjZ19leGl0X3F1ZXVlKCkgaXMgY2FsbGVkIGZyb20gYmxrX3JlbGVhc2Vf
cXVldWUsIGFuZCBpdA0KPiBpcyBoYXJkIHRvIGF2b2lkIHRoZSB1c2UtYWZ0ZXItZnJlZS4gQnV0
IHJlY2VudGx5IGNvbW1pdCAxMDU5Njk5Zjg3ZWIgKCJibG9jazoNCj4gbW92ZSBibGtjZyBpbml0
aWFsaXphdGlvbi9kZXN0cm95IGludG8gZGlzayBhbGxvY2F0aW9uL3JlbGVhc2UgaGFuZGxlciIp
DQo+IGlzIG1lcmdlZCB0byBmb3ItNS4xOC9ibG9jaywgaXQgYmVjb21lcyBzaW1wbGUgdG8gZml4
IHRoZSBpc3N1ZSBieSBzaW1wbHkNCj4gZ3JhYmJpbmcgcmVxdWVzdCBxdWV1ZSdzIHJlZmNudC4N
Cg0KVGhpcyBwYXRjaCwgdXBzdHJlYW0gYXMgY29tbWl0IDBhOWEyNWNhNzg0MyAoImJsb2NrOiBs
ZXQgYmxrY2dfZ3EgZ3JhYg0KcmVxdWVzdCBxdWV1ZSdzIHJlZmNudCIpIGNhdXNlcyB0aGUgbnZk
aW1tIHVuaXQgdGVzdHMgdG8gc3BhbSBtZXNzYWdlcw0KbGlrZToNCg0KWyAgIDUxLjQzOTEzM10g
ZGVidWdmczogRGlyZWN0b3J5ICdwbWVtMicgd2l0aCBwYXJlbnQgJ2Jsb2NrJyBhbHJlYWR5IHBy
ZXNlbnQhDQpbICAgNTIuMDk1Njc5XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3BtZW0zJyB3aXRoIHBh
cmVudCAnYmxvY2snIGFscmVhZHkgcHJlc2VudCENClsgICA1Mi41MDU2MTNdIGJsb2NrIGRldmlj
ZSBhdXRvbG9hZGluZyBpcyBkZXByZWNhdGVkIGFuZCB3aWxsIGJlIHJlbW92ZWQuDQpbICAgNTIu
NzkxNjkzXSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3BtZW0yJyB3aXRoIHBhcmVudCAnYmxvY2snIGFs
cmVhZHkgcHJlc2VudCENClsgICA1My4yNDAzMTRdIGRlYnVnZnM6IERpcmVjdG9yeSAncG1lbTMn
IHdpdGggcGFyZW50ICdibG9jaycgYWxyZWFkeSBwcmVzZW50IQ0KWyAgIDUzLjM3MzQ3Ml0gZGVi
dWdmczogRGlyZWN0b3J5ICdwbWVtMycgd2l0aCBwYXJlbnQgJ2Jsb2NrJyBhbHJlYWR5IHByZXNl
bnQhDQpbICAgNTMuNjg4ODc2XSBuZF9wbWVtIGJ0dDIuMDogTm8gZXhpc3RpbmcgYXJlbmFzDQpb
ICAgNTMuNzczMDk3XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3BtZW0ycycgd2l0aCBwYXJlbnQgJ2Js
b2NrJyBhbHJlYWR5IHByZXNlbnQhDQpbICAgNTMuODg0NDkzXSBkZWJ1Z2ZzOiBEaXJlY3Rvcnkg
J3BtZW0ycycgd2l0aCBwYXJlbnQgJ2Jsb2NrJyBhbHJlYWR5IHByZXNlbnQhDQpbICAgNTQuMDQy
OTQ2XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3BtZW0ycycgd2l0aCBwYXJlbnQgJ2Jsb2NrJyBhbHJl
YWR5IHByZXNlbnQhDQpbICAgNTQuMTk1OTU0XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3BtZW0ycycg
d2l0aCBwYXJlbnQgJ2Jsb2NrJyBhbHJlYWR5IHByZXNlbnQhDQpbICAgNTQuMzgzOTg5XSBkZWJ1
Z2ZzOiBEaXJlY3RvcnkgJ3BtZW0yJyB3aXRoIHBhcmVudCAnYmxvY2snIGFscmVhZHkgcHJlc2Vu
dCENClsgICA1NC41NzcyMDZdIG5kX3BtZW0gYnR0My4wOiBObyBleGlzdGluZyBhcmVuYXMNCg0K
Li4ub24gYSB0ZXN0IGRvaW5nIGJsb2NrIGRldmljZSBzZXR1cC90ZWFyZG93bi4NCg0KSXQgaXMg
c3RpbGwgcmVwcm9kdWNpYmxlIGluIHY1LjE4LXJjMyBhbmQgSSBiaXNlY3RlZCBtYW51YWxseSBh
cHBseWluZw0KY29tbWl0IGQ1NzhjNzcwYzg1MiAoImJsb2NrOiBhdm9pZCBjYWxsaW5nIGJsa2df
ZnJlZSgpIGluIGF0b21pYw0KY29udGV4dCIpIHRvIGF2b2lkIHRoZSBvdGhlciBpZGVudGlmaWVk
IHJlZ3Jlc3Npb24gd2l0aCB0aGlzIGNoYW5nZS4NCg0KSSdsbCB0YWtlIGEgZGVlcGVyIGxvb2sg
dG9tb3Jyb3cuIEl0IGNvdWxkIGJlIHRoaXMgaXMgdHJpZ2dlcmluZyBhDQpsYXRlbnQgYnVnIGlu
IHRoZSBwbWVtIGRyaXZlciwgYnV0IHdhbnRlZCB0byBzZW5kIHRoaXMgaW4gY2FzZSBzb21lb25l
DQpzYXcgYW4gaW1tZWRpYXRlIG9yZGVyaW5nIHByb2JsZW0gY2F1c2VkIGJ5IHRoaXMgY2hhbmdl
IGJlc2lkZXMgdGhlIG9uZQ0KZml4ZWQgYnkgZDU3OGM3NzBjODUyLg0KDQo+IA0KPiBSZXBvcnRl
ZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IE1p
bmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPg0KPiAtLS0NCj4gwqBibG9jay9ibGstY2dyb3Vw
LmMgfCA1ICsrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1jZ3JvdXAuYyBiL2Jsb2NrL2Jsay1jZ3JvdXAuYw0KPiBp
bmRleCBmYTA2M2M2YzAzMzguLmQ1M2IwZDY5ZGQ3MyAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxr
LWNncm91cC5jDQo+ICsrKyBiL2Jsb2NrL2Jsay1jZ3JvdXAuYw0KPiBAQCAtODIsNiArODIsOCBA
QCBzdGF0aWMgdm9pZCBibGtnX2ZyZWUoc3RydWN0IGJsa2NnX2dxICpibGtnKQ0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChibGtnLT5wZFtpXSkNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYmxrY2dfcG9saWN5W2ldLT5wZF9m
cmVlX2ZuKGJsa2ctPnBkW2ldKTsNCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGJsa2ctPnEp
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBibGtfcHV0X3F1ZXVlKGJsa2ctPnEp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgZnJlZV9wZXJjcHUoYmxrZy0+aW9zdGF0X2NwdSk7DQo+IMKg
wqDCoMKgwqDCoMKgwqBwZXJjcHVfcmVmX2V4aXQoJmJsa2ctPnJlZmNudCk7DQo+IMKgwqDCoMKg
wqDCoMKgwqBrZnJlZShibGtnKTsNCj4gQEAgLTE2Nyw2ICsxNjksOSBAQCBzdGF0aWMgc3RydWN0
IGJsa2NnX2dxICpibGtnX2FsbG9jKHN0cnVjdCBibGtjZyAqYmxrY2csIHN0cnVjdCByZXF1ZXN0
X3F1ZXVlICpxLA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFibGtnLT5pb3N0YXRfY3B1KQ0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyX2ZyZWU7DQo+IMKgDQo+ICvC
oMKgwqDCoMKgwqDCoGlmICghYmxrX2dldF9xdWV1ZShxKSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdvdG8gZXJyX2ZyZWU7DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDCoGJsa2ct
PnEgPSBxOw0KPiDCoMKgwqDCoMKgwqDCoMKgSU5JVF9MSVNUX0hFQUQoJmJsa2ctPnFfbm9kZSk7
DQo+IMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2tfaW5pdCgmYmxrZy0+YXN5bmNfYmlvX2xvY2sp
Ow0KDQo=
