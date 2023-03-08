Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771BC64EC4
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 05:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCHFgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 00:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCHFgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 00:36:09 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B20A17D9
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 21:36:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmhd84cYbfPY9fmHoOGeiNQcEwKxBiIE0R5tzvQAIr7on8cSZXuT2lFX1QOOSAmkje4O7n1hDiKNeljKN8FGMlMmGlqv7kIwf5xufn/DYDXnq/EtbVuEInP7inf+kwHRytWnK9SnoV6t9pcKElCG+j4N+5iBJrsE37XdMm/xj8atqMgeEg6ZDGkzyvxosPa+q7dKCewqoKY/V3k1v6WunVTVVnyIY1caE9dTxmxqHnFVIrYbFombPb6yuWPvmxqSO7fQehkBVQAfOj7a72HYdBN7tU9t7F2bsdd+JIDaRfaBiJXqzhXCXzgyXG06BuST81MI5t5BcXRUf39GkNFTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqJtkPA/3DR+RlPpWVcmXOZjU51VxXd9JxgY4xYCYGs=;
 b=VWG2AXRd8hixMj36mpLjccuvqXWQb2tDjYn2WEIniiEkLnduR+FHcqdZabxH94SvcGJiUI9aO1WAnByGc4GGu08IDBPyAFTtZ9RHXITvAgSLJ+9mb2NMLpQ7vO3z05DbTtT9WaQQBzLyJ01bpoaFTUORVGEjxcan6DHcpl4uUVBMh+dlwfFcIR4fCq5+BsJTUTmzpMmDYWwX4HCdHasLkUlMLvv8mFMhXaf8mVbpcKjhAzqSMNTZmA/296FZuUmX5bNKtNfuIXDKqtTSCnzAeFJP0D9UFD3RmNRWqg23mUjUnX1ymNaMjlqO32SnqBcjVSgMJHvSwEiSItK49WqEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqJtkPA/3DR+RlPpWVcmXOZjU51VxXd9JxgY4xYCYGs=;
 b=ZiZWbcryQVu2hk2mJIrqiyNnRan7t07APkMzX00qqWsWCWOcEt5aKXjsjkPB5zNeVc8ymzJNfxRH4IAAdBJVSd+6KzbC97qo5REiHvjhROr0heA4IFSsfVZ5pkVBWHlHkrIgxyrRiVWPPIvr0fF74IuzUhUzf4w+T5WVs0YSeysVi/rj7fjlbSE+6Z3b6ToWP+YB8/2a7BW5HQXSuoQ8GR80HKa5IUrXw5+pDADXFRXFnfpS/UMZ1VcjYPry7wm4ugzohYf+UPzLpyWALQXfE+mQjNuidYRheoVfleUaE4dnFb9RJJprbPDgA8TUTqFmhfQ/XQ91MRXEgBERDL8uug==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 05:36:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 05:36:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] nvme: fix handling single range discard request
Thread-Topic: [PATCH] nvme: fix handling single range discard request
Thread-Index: AQHZTiX2EW8aeGjaO0qLT1SlqfD6u67t0X0AgAB9I4CAAOgFgIAACbCAgAAE8QCAAR4rAA==
Date:   Wed, 8 Mar 2023 05:36:02 +0000
Message-ID: <04670825-1bc9-34dc-153b-435aff685851@nvidia.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
 <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
 <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
 <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
 <aeb59707-00ad-bc57-9f91-ef5757de9294@grimberg.me>
In-Reply-To: <aeb59707-00ad-bc57-9f91-ef5757de9294@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7581:EE_
x-ms-office365-filtering-correlation-id: 6f774027-aab5-4a36-9611-08db1f970144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klmV9EW7DQj3N3GJpaDmOu3R94+sndbKwrmhco50YYlbO97Ux5rvM9Ae/1qXz1l26viFuDxw1jnWLM4DLiDpQQjGrVikJemLenILlWw59KSYPwct0An0aGgbXZMn6gSiPgMAJQlQb/VPT5D7dYWsqJDNentmu07+WbLG3gY44V6Rh7Zy14sh58M7J+m31qSrp8jDYr6Y1t4ME1mhTggCGse1xMGHW6Ggt5Or07aMeizDqEL36JMBinje6GRfc76p/u022Q4HEcCJNLThqJDtaA1zUbNOcRVIMhHvew8TOgY6PGe3tlMk0dH64CTV5sIHbzP5EMrc1bszVqWJ3Cd8hqw1CAuubc2oFRiDYYv588Ba3IP4aygMOpTHePUG7YQLwst8Lx3MlC0ppVf8OvBY2bruC34SANgXunvtOhbLXgEjJrHTIdu6b/4BRuBwjrBXkPjmWk+lER546TNwqB18TCCrlHATnZG68CKAdYEP78jlET5uA5Z4sDPcY+UlS71xOMnOvgUaXScfe4gzPpfoeY0ntP5jGhKflhakXlPj8iOmdUrWff7J271Ckdr27Qlr71/+efblSGo9tJmOJgFUrfnBCW+tA390YbLBtxrqSNnvZOt0G+Y1DibcNd6gUMG4IoqW7vNe8ZZEC0CeJOtXWQciuc3QFCqJXkrWvDQ8aMNfoz/t9WMU0a7YqhsCA/iQhqDzSgJKbj+6PZ9D2aWGwd1EGF+tRxPyfMjFrcd+PS4PcC/7K6/JR3yyHB99DJVMNnLXEMkkQ8YKJ2D5FGLRWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199018)(31686004)(36756003)(66946007)(8676002)(5660300002)(41300700001)(66556008)(64756008)(4326008)(66446008)(8936002)(66476007)(4744005)(38070700005)(76116006)(86362001)(122000001)(31696002)(38100700002)(2906002)(6486002)(71200400001)(478600001)(54906003)(91956017)(316002)(6506007)(110136005)(83380400001)(6512007)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlBhTWgydzR0VjNyRnNQWVNtSGNCWDMwSWxOcFRQN05XVGNUSTlWRWJBcGhG?=
 =?utf-8?B?cWhqWWF2QjBiVFpKYW5TT2pQTTlZeXZJQ2ZlYTJ2UXJLL0UvV0xjUEltaWls?=
 =?utf-8?B?NGhlaDdNeUd3UUlMTWRZcFhXUE1vejJYTFNxK1JGSlBRM2c1NW4raTZrL2Nt?=
 =?utf-8?B?YVVpU1p5d2pWcWFsRE1wcFdYYlVidFdueVZ5L2hqQzh0R2RhZnhoUnkvbHZW?=
 =?utf-8?B?R0JZODFSS2FLRXB1bTl2Z2E5cktiREZINFowbm5VNXAzSWRET2hwYm82TjVE?=
 =?utf-8?B?NXZ5YTVHRW1Mc1pWYlpPOFNUME1Bc1ZHU1ZPMnh0ekxrVkpEcHh0YlM5SVdF?=
 =?utf-8?B?bjFOU1lJK1pPLzhSVVNKbitMM1hseXErTmFXM3NVa2F3MmJSK0JUNFlTbDgw?=
 =?utf-8?B?blFnMHJkWXVZSTZ5cndRelNxc055M3ordFU3bTM1R29wR3NiTEs0YW5GVnJs?=
 =?utf-8?B?ZjRBVUxvbndaY2FJNExKV1JxU0w1U05FWjdKNHFTN1N0YTh0Rm96VTFIaEww?=
 =?utf-8?B?NkU5emdwSVJ5aGZ4eExZK00ybGlFekhxd0pxaUtwdHpRMzZ5U09ZRWFlWkhF?=
 =?utf-8?B?YmwvK2krTkV4NDhZSWxJWVZYbjNQeVpUcGdFNlhsS0VRaFNjeDhHVmhOSTRx?=
 =?utf-8?B?azVibGxTRU0xZVJnMGprYjBqQ1J2SlN5YmVIbmcyTzl2ZnBxWHQ0VE4wQzQ5?=
 =?utf-8?B?dEsrcG9SOTBGN1d6akNTRU4wc1M4MU5FdmlJZ3NxMnRmQmFDamRvaTd4THFy?=
 =?utf-8?B?eUtaYmpsZXdmMng1Z0JTNTFaTTdjMEhuYVc5dE5KaVA3MkdXTnEzenVwMGtE?=
 =?utf-8?B?MEhnL0kyRzRnR215SXlnVUN5T1N4Z3RYV1A1ZnNQdUJrelBhZG92a0swcDI3?=
 =?utf-8?B?L1I2aDJjOTFhUmh4OUxjSmc1RWt1cVZaWFZZcTRzc2p0UjV5UlJUbUZERFRC?=
 =?utf-8?B?S2RWUmloMW9RdDQyVWpCcmYyVEJxY0VaUWlpcUNNKzcvcVZLRlBGVnR3bFF3?=
 =?utf-8?B?cmxaUzE1RGZ0TU9sMG5mVGFGK1JmbnJna2oxL0Y3dERIMHp5M01wM3RYWE5y?=
 =?utf-8?B?bFo0Z29wNlZZL3RvQWRtYWVqWXhucXNGbXUzT3E1bEpWcFVjYUZEcDFua1ZJ?=
 =?utf-8?B?Q01JbFJpVzgxcjN3R3pkRzJId3Z2ZXBwS0pXRHdNekRpZDdvcVZvRWlWcWEw?=
 =?utf-8?B?MVgwLzRtK3VvclhKVVloVnAvRmx6S0kxaFNjakxkUUxUK3BZZGZpTFJBL0lm?=
 =?utf-8?B?RkUyakFkUm1uNlAxaWZCREJzTDUzdlQxVU1hRnRZNzRkSFhlK2Y3QjlsUlZC?=
 =?utf-8?B?VjZ6Z3VWVE5vTGxqbGIzZXNLL2hoZjRXU2tuUFh0OEpPZEcyT0RSYXZmdW9q?=
 =?utf-8?B?NW1XemVTWVdtVTNtZHBqUWFKNHpKdXltWi9JZ2JhWm1BMlVmeFQ4ZnZvc2Rp?=
 =?utf-8?B?NHJVeHRkVmhWcm5xR21lSHRXMzlmRlBRV3ZQNkt4YURTUHFGTHU1RGlHUXlJ?=
 =?utf-8?B?MmhFQXkzRmQwKzh1L0luRENJSE1GR3V3UlgxZm82cmU4UGMwSnpnSlZHbXRU?=
 =?utf-8?B?MHRKOVViQ3p4dTBWeWFaL3hOcyt1WkRTb1dEUzJ1UHRnVUJPOCttK25iSk1S?=
 =?utf-8?B?QTlDSkNqWVRRQ2hXWkppOE0wcnhhOFZoeDRvTml6L1RKOWNvc25VbHE0Y09l?=
 =?utf-8?B?RzlQYVhONVN2Nnc3ejJJcmlxSDZsTERGc2VJZlVwaGFBdjVpY09NTHFHQ01B?=
 =?utf-8?B?WFJQd2JHM1EwbW9UeUo5R1QySURzcU8ySVQ1SmJIRXpaVW9FdVl4aVRNaEh6?=
 =?utf-8?B?Tm5oVXVYVWhsLzJJWVlWc3FLZytsNjBiMW11cUUrUjAzNUVSbEFkMUkrdUR5?=
 =?utf-8?B?Nk9DYklTTGE4SzNqQVg3MWNZSkxTeC9Peko0anhWM2pGNnNnakZYd0JmRUxG?=
 =?utf-8?B?Z0dPU3B0MkhMVGlGb1lpVGRLZGkvRU9LZGtrQWxjMWRkaWczVWlDMm5yTElZ?=
 =?utf-8?B?bUF1TjVKQ0pZZEdSaS9ENjdrY2NPWmN1TERtL0VoNDdDbExZbmVaWUxRanI3?=
 =?utf-8?B?bmVnNFBzc0pUZytTZnh3bEN6VXJ0RHQrTUJSTHFHR2dmeXhIckxPR2FMdFU1?=
 =?utf-8?B?bWNEem8vWlh4OTN6RzY0R0ttMVF1aFhiSDI4ZUxtOHBFR21aazloaE1qYlJm?=
 =?utf-8?Q?MQzLFlYKmRZSmKcbM9JljuFUA3/cC0mcVthIKszgVTnN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A0A24FBE08D72438C511C9845ADD8A0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f774027-aab5-4a36-9611-08db1f970144
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 05:36:02.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siwuHDZfg1/gAj7KX6CbQazpIceex1BhreDrj2hEqKvDRdYCpM7VVE2Op2T9pbwCk2StZc/jdfgueGDidTeokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+Pj4gV2FzIHJlZmVycmluZyB0byB0aGlzOg0KPj4+IC0tIA0KPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+PiBp
bmRleCAzMzQ1Zjg2NjE3OGUuLmRiYzQwMjU4NzQzMSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMNCj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+
PiBAQCAtNzgxLDYgKzc4MSw3IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9zZXR1cF9kaXNj
YXJkKHN0cnVjdCANCj4+PiBudm1lX25zDQo+Pj4gKm5zLCBzdHJ1Y3QgcmVxdWVzdCAqcmVxLA0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhbmdlID0gcGFnZV9hZGRyZXNz
KG5zLT5jdHJsLT5kaXNjYXJkX3BhZ2UpOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+DQo+
Pj4gK8KgwqDCoMKgwqDCoCBzZWdtZW50cyA9IG1pbihzZWdtZW50cywgcXVldWVfbWF4X2Rpc2Nh
cmRfc2VnbWVudHMocmVxLT5xKSk7DQo+Pg0KPj4gVGhhdCBjYW4ndCB3b3JrLg0KPj4NCj4+IElu
IGNhc2Ugb2YgcXVldWVfbWF4X2Rpc2NhcmRfc2VnbWVudHMocmVxLT5xKSA9PSAxLCB0aGUgcmVx
dWVzdCBzdGlsbA0KPj4gY2FuIGhhdmUgbW9yZSB0aGFuIG9uZSBiaW9zIHNpbmNlIHRoZSBub3Jt
YWwgbWVyZ2UgaXMgdGFrZW4gZm9yIGRpc2NhcmQNCj4+IElPcy4NCj4gDQo+IEFoLCBJIHNlZSwg
dGhlIGJpb3MgYXJlIGNvbnRpZ3VvdXMgdGhvdWdoIHJpZ2h0Pw0KPiBXZSBjb3VsZCBhZGQgYSBj
b250aWd1aXR5IGNoZWNrIGluIHRoZSBsb29wIGFuZCBjb25kaXRpb25hbGx5DQo+IGluY3JlbWVu
dCBuLCBidXQgbWF5YmUgdGhhdCB3b3VsZCBwcm9iYWJseSBiZSBtb3JlIGNvbXBsaWNhdGVkLi4u
DQoNCkl0IHdpbGwgYmUgZ3JlYXQgaWYgd2UgY2FuIGF2b2lkIGFib3ZlIG1lbnRpb25lZCBjb21w
bGljYXRlZCBwYXR0ZXJuLi4uDQoNCi1jaw0KDQoNCg==
