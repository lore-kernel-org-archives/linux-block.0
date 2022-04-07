Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F027C433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Apr 2022 19:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiDGTjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 15:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDGTjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 15:39:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0646A3024DC
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 12:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCrvvsO+SSWIy/TDi9qeWDdmdES9F2R6yzkCb1OyYCeOuqg8MEJnvWtauHqajAhAUuw/RnlPaCK4rwNM64WHHsysR+4qNlikOIgrJ9IUKhVMAa6pQbx2oKV+gZl9gyaRDUSkBvXQLjqwh6KF5I5QehMhRyqKLwTYkwyB4X0DztGBihXNuFLBLF8RchKZM4O2BnfGwn7BbTOiSJZOC8CWdAznceQnsrhVP85xxtpxZvvno4wod5fSswVagsZJCFqnfA+1vpwpTE6Rlrepr+Q0945KsDdTjaD0RHCWjua0wRXuQeZ/iNIVVrWzrRcGghal+xx83Li5Swy3p8QgM9iavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GSNjUXN5W20XkJA9R//mJ2OTf7wjsHU9Mqznb4A6e0=;
 b=X9QDvGzQp/yYjxAoZGli5PxXNhnPsrVj7+VaxwvFCgSY/B124HZqJGU+hPnrC4uWEgkXiNujAl4kx3NeM4RvvSNhne647JhluNvlWZbbYOx/N2qD3p+fx2anesICUm62minDtASU+8PDARAGfteqncgZphRgo7/b2RbB0Ui1WGgfscATgCGA8IcxvQiHJlo7xC6Im81SRCUz5nv5RA6Jtoec531bDHxUw7OdILHNUnR3FDJ4TPYNZyYKSvt3HfENrvmqiwE2MotVaetcAMiziYnzDu7aEEU3Kxc5BpHcY6cnoL7GXAcSNayOuCTkgDShVX2vGE02KZxVrZ3xo2DWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GSNjUXN5W20XkJA9R//mJ2OTf7wjsHU9Mqznb4A6e0=;
 b=kS9I7+1kVIw/eE2PVQ9cA5V0KUxMAF4Twm7bJZfT/UImNN8xzdeKsoKELNtlS7pSh4WL71ZeHR4/YMsrQxR3OJoItwpgLKgehhGlmNxHRwM92UudbOhZdf6VpWVSXWy1cnKxIZPIVFhxzS04oUoGMBEyWE98RdULp5ZVdH27+RJ/g9dF/VCj4en67sNXVCF0sqPBBHHtxtOqTzyyaxIGsD/EzDMUA71sHkpGhMlw5Qso9aj/i2TTdjuhwtdgL/IQc4/z/JDe+5vMZP1w/G8iAqjjSNVYnK4ivxK5NKDAUw+6B40P90eLdnWk6sJk89HSyoBhFkqaHbjS0/F2yKRIwQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR1201MB0021.namprd12.prod.outlook.com (2603:10b6:910:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 19:32:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 19:32:06 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Suwan Kim <suwan.kim027@gmail.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "elliott@hpe.com" <elliott@hpe.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 1/2] virtio-blk: support polling I/O
Thread-Topic: [PATCH v6 1/2] virtio-blk: support polling I/O
Thread-Index: AQHYSdxAoHwF16LAV0yWCbmtKva/kazk2JsA
Date:   Thu, 7 Apr 2022 19:32:06 +0000
Message-ID: <407c7563-dc29-f204-79ea-75652c0e3b85@nvidia.com>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
 <20220406153207.163134-2-suwan.kim027@gmail.com>
In-Reply-To: <20220406153207.163134-2-suwan.kim027@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4528bc6-ebf1-4d4f-fee9-08da18cd4d1c
x-ms-traffictypediagnostic: CY4PR1201MB0021:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB002153B7EA9C0011BEA6BC8FA3E69@CY4PR1201MB0021.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9yvUIKauItZcvZUaD/8SfRQkW+xzY57XYS+usodP7WiQi86OErcqsZUIadMBuVkv99+JYK/Q/5OnDRldOX9WVlphdgK4R9jaBMbzyUbKQ7nqHCY7thOHiWIWA3P0VlGYNFz63v4Q9POOVA7JGR7mMQpaW+Hyk24bvMj9umMQNZB1vkRstRAkqF9S+ay+ieWZGRbnV+woTUSNSMHVBMXf4HEL1Su9hYXtENC7HnWtw6jbbXKG6POcC9+0sPfQQtPgXyAxEdbSpwqDa0wcOtkzLzpFyMejCOmFD6tPFzqLOWCyTQtES5qVWSlKibLNS/R29eSEEqi2OXziuUiGgqvEltFhaS4NW/f6gpixmbw8BJQf1L0p/2O+KUqMnzxFoEJtbrMLCrzioUDHWmuljb5QQTMw5fexIM/Lkv0NGlIw5PPmKunvNKxxI4/HYI0TCMY1+/FBX8dMgu8NwatJ9VDFjmzQNgGhSzm3GZ1Am2BXZ5yYwBA76RoFbt+EwYxJDxuDikjSqGxqgHr+fzvkAjDgO1AMbnkEcNhw0Qe6Jpe9kgl13AV0CkN64qKlqOa6BZNEgyiZuPJcWZEsBdjwU3QWzs6ujZsmfhUl0yDUvW7qsTvmjZdvgYCZaNl8R0gb37eaCMkxHN/bbRjmoBJ0rlvw7AdQDsub5wX+Ts26DStyhTOydWcJVNa6uYEcPApma9q+HoOg6vxxyDiiv1ARX9rtF2YbzSSyquysZTMXTot11dh9qaxqEK1i7PdAdRO8l3fKH48dLsrLauQ5gP65cSunA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38070700005)(316002)(110136005)(8676002)(71200400001)(6506007)(66446008)(76116006)(64756008)(66476007)(66556008)(31696002)(66946007)(6486002)(54906003)(91956017)(508600001)(186003)(6512007)(8936002)(5660300002)(83380400001)(122000001)(7416002)(53546011)(38100700002)(86362001)(36756003)(2616005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFQSCtQSWZsWndEUjEyOTQyaXVCc250WW40Q2dzQURRN2ZwTmRWUjFzZlBy?=
 =?utf-8?B?UVhIRXVSd2E3bExJTisxdEZmS3pxeGJGSFByZWRUT3YvdWV4NFJvSkd4eTBQ?=
 =?utf-8?B?NGN4dy9HYWduTEcyVlhUbXAreUkwK0J2OUVaR0I5dWZQMi85dGxyMERiQ3Vs?=
 =?utf-8?B?eitaeE4zTXo1UUJQUG1XbnR0dEU3N3BwVExuWG5mZDlTUVFVaWd1YTJyY2ZB?=
 =?utf-8?B?d2J5cHVPZmxGejVueGJENVdTc1VveXZQbDhuSkpWamdGN0ZoM25Wdk12MnVv?=
 =?utf-8?B?UzMzYlFYUW11aG5nSmFmYnVkUUFtdVl4eWJVMmRSSGtoNmhhR0M1a0hoUVhV?=
 =?utf-8?B?SDJZaGh1T1BmQjZPdkZZdTNrc01ZMUoyRjJ2ejJtVzRoOHpvWnNCTFQvRGZ3?=
 =?utf-8?B?bXFxbjZjNWxDMlVXR1JSRmppcENQaWlZMTQvdTBpL1UyMDJmcFFJL1JCSHp5?=
 =?utf-8?B?M0hjZjhsUWVJWDF6OWZiU1NTcjduSkhnQlBqelRHSVBCYnBPV0FPc001VEhk?=
 =?utf-8?B?NWc1cklBUUJsdnRtL1d2aEptaXNSeEhuM1RkNXN0MmpMb200bkYzMThmUGo2?=
 =?utf-8?B?anhRaitYNTFkQldmZnowTkVCNzErR2VDZnJONmUveGFLSDBsbWZMOFQwRVNu?=
 =?utf-8?B?NkhtLyswbFFvYS9Rb2c1YnJoN21DVDArZDd6NFAyK2xBaUJQdzQ2V3ZoOGU0?=
 =?utf-8?B?RGRDNnBnL3l5bVRVYmcrYlc4WDdpR0s3NWpobzRuUEw4SnZWcVJ2c1JmazM4?=
 =?utf-8?B?REtYdzNSL0RNeHRrLzduSEhwdHRNeGEwVkxzMG1WbzNJWnlDVjVSQnViY1RE?=
 =?utf-8?B?UnJySHppcDhiZUJsMjRpaE1mZ3lOUnFUSDZTZytZM2lzWngvVVp3U3A2cG9p?=
 =?utf-8?B?UnptWkFxTUVlcDFtZExLS003aUg1bkREOFpwNEhaa3k1R0hNOWUrMVdHVGFH?=
 =?utf-8?B?UjZ6cjhwY2lWRU05eldEUHhSb1hhTUpmY3d4R0hybk1KUzMxRHBQSVMraGJN?=
 =?utf-8?B?TmtQanJjd1A3bmRxNEU3eVhGNlNSUlA3aStaeVEyRHdhbURvQTRPOHEyalQ1?=
 =?utf-8?B?WDN1M2hnbEU4S1hTdFovc2Y5VHRkQkE4NlJ6TkdqOU9JamM2WS8yOGRmNWQ5?=
 =?utf-8?B?U01aN0RyVlkwQ3pwNG1pRlhaNUFOQ1RnZ0toeWRqMm1mSnVwOThZM2RmNHkz?=
 =?utf-8?B?WUFZdGJUU21rZ1RBTk81T3FmSkhsMnlwMkg3SWhjKzZiNWtLV1kzWUs0dHFy?=
 =?utf-8?B?SFZoSk9VOW9pUVlOK0gyWW5ROVNOSDluWUVKMDdGbVJlaGYzQ0hqRUZYWDRk?=
 =?utf-8?B?YktEcHpFdFIvTElhLy9YaG9kbjg5OGRSRHBLYzBWQS9QdzJDMVVFanVoeVh0?=
 =?utf-8?B?T2dTNW9VVVg3Ri9uYjdqOUZCUndoNTZZbVdmTWxwY28xRWh5RFByUkl4c0FO?=
 =?utf-8?B?K1J6akRuQ2hLaHRia2hGVGpKRFZTL0RjV3VPaDMxaldIRTZ3UXVNZnU0alli?=
 =?utf-8?B?V3YyUEEydXA2bTBZN2l6VEpLdTFPeC92S2J6M1NMK3pLSlE0eGZZdjVndU1E?=
 =?utf-8?B?R2FYZXIwbXRVdDhWelBCejRPYlN1VXlHbWFBQmZwNjZXenRuQW50R1JGV1NB?=
 =?utf-8?B?SzIzMTVXem5FajZiRmNHOHB2VTF1M1BvSDRxTGZaRmlqUWxwamh4ZjJwRU9B?=
 =?utf-8?B?bFpNOWMrc0x6YS9lNExUdDVDYStrQjhZZEJKZEJabTdFR2VlcVFrNVdzL3dT?=
 =?utf-8?B?eWljRXlPTkpmZmZaQjlaY092d2djRmxiczhjM0dhMTVaMmJMZDVha0dYQlY1?=
 =?utf-8?B?bEQ4SmlDcUZCMnA3RXVFRm85ZEpyeVpWZi9IUXYrT24vM3JZaWlmQ1BvcjZ2?=
 =?utf-8?B?cmVTdllrVi9xYW8zb1YydWtLaDhiUGZsVEdMd29FV3hMRFpSZ0thQmhLMEpr?=
 =?utf-8?B?R0FFRWJPbElYOUluVmZycFhlbFRYM20yUThrRExsUXh1bHdCQk1JTW5GcXFM?=
 =?utf-8?B?bUk5dk4vNU1vV1JQUlNDYjBEWERtV2V1QXN1RG82K28wR29LY0tBS09vaU1i?=
 =?utf-8?B?Rm15Rk1tTFAwTXFoQWVoMWxCNXhHNEVOUElqcE9WbFg0OVJ4OXpRVE1mNWdN?=
 =?utf-8?B?eXBIdUVvdHdkZ2FaQmp2ZnNaaDlYbERIUFpzaWtIVnNZRFQ5VGJ1c2gyT1RL?=
 =?utf-8?B?MVJha1U4cUhvSmUvRFBxRU5UVmR6YjlNYVF4eXpqZGxGaGtzT0xheUYzeWlH?=
 =?utf-8?B?b2VCUDZpYStFVmJpQ2ZXbmdjSXdQMmVXcXZxQVF1VHFqSzhHQVFMd3B0S3kv?=
 =?utf-8?B?U3ZObkowUGJEdzBySTlEMzQrK0hqNEZDRUlXYlQ1bTZYZU13K0wySSs2Vjdu?=
 =?utf-8?Q?iKBK69x7PdJ7c7EBC0QQZq5yS5TzT9PEmaRICojZtwugL?=
x-ms-exchange-antispam-messagedata-1: ROadZRTY0zn5GQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E2E248C7156E4AA3B4F298C5009BCD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4528bc6-ebf1-4d4f-fee9-08da18cd4d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 19:32:06.6361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NwYcxQx0pV/8y9YeWbCZza9yyOJlPtADdKr6Z6QgP/t62u6BDCRWMuqjl/q66Dst0KZ6CbE9nyywVUVd9+IVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC82LzIyIDA4OjMyLCBTdXdhbiBLaW0gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggc3VwcG9ydHMg
cG9sbGluZyBJL08gdmlhIHZpcnRpby1ibGsgZHJpdmVyLiBQb2xsaW5nDQo+IGZlYXR1cmUgaXMg
ZW5hYmxlZCBieSBtb2R1bGUgcGFyYW1ldGVyICJwb2xsX3F1ZXVlcyIgYW5kIGl0IHNldHMNCj4g
ZGVkaWNhdGVkIHBvbGxpbmcgcXVldWVzIGZvciB2aXJ0aW8tYmxrLiBUaGlzIHBhdGNoIGltcHJv
dmVzIHRoZQ0KPiBwb2xsaW5nIEkvTyB0aHJvdWdocHV0IGFuZCBsYXRlbmN5Lg0KPiANCj4gVGhl
IHZpcnRpby1ibGsgZHJpdmVyIGRvZXNuJ3Qgbm90IGhhdmUgYSBwb2xsIGZ1bmN0aW9uIGFuZCBh
IHBvbGwNCj4gcXVldWUgYW5kIGl0IGhhcyBiZWVuIG9wZXJhdGluZyBpbiBpbnRlcnJ1cHQgZHJp
dmVuIG1ldGhvZCBldmVuIGlmDQo+IHRoZSBwb2xsaW5nIGZ1bmN0aW9uIGlzIGNhbGxlZCBpbiB0
aGUgdXBwZXIgbGF5ZXIuDQo+IA0KPiB2aXJ0aW8tYmxrIHBvbGxpbmcgaXMgaW1wbGVtZW50ZWQg
dXBvbiAnYmF0Y2hlZCBjb21wbGV0aW9uJyBvZiBibG9jaw0KPiBsYXllci4gdmlydGJsa19wb2xs
KCkgcXVldWVzIGNvbXBsZXRlZCByZXF1ZXN0IHRvIGlvX2NvbXBfYmF0Y2gtPnJlcV9saXN0DQo+
IGFuZCBsYXRlciwgdmlydGJsa19jb21wbGV0ZV9iYXRjaCgpIGNhbGxzIHVubWFwIGZ1bmN0aW9u
IGFuZCBlbmRzDQo+IHRoZSByZXF1ZXN0cyBpbiBiYXRjaC4NCj4gDQo+IHZpcnRpby1ibGsgcmVh
ZHMgdGhlIG51bWJlciBvZiBwb2xsIHF1ZXVlcyBmcm9tIG1vZHVsZSBwYXJhbWV0ZXINCj4gInBv
bGxfcXVldWVzIi4gSWYgVk0gc2V0cyBxdWV1ZSBwYXJhbWV0ZXIgYXMgYmVsb3csDQo+ICgibnVt
LXF1ZXVlcz1OIiBbUUVNVSBwcm9wZXJ0eV0sICJwb2xsX3F1ZXVlcz1NIiBbbW9kdWxlIHBhcmFt
ZXRlcl0pDQo+IEl0IGFsbG9jYXRlcyBOIHZpcnRxdWV1ZXMgdG8gdmlydGlvX2Jsay0+dnFzW05d
IGFuZCBpdCB1c2VzIFswLi4oTi1NLTEpXQ0KPiBhcyBkZWZhdWx0IHF1ZXVlcyBhbmQgWyhOLU0p
Li4oTi0xKV0gYXMgcG9sbCBxdWV1ZXMuIFVubGlrZSB0aGUgZGVmYXVsdA0KPiBxdWV1ZXMsIHRo
ZSBwb2xsIHF1ZXVlcyBoYXZlIG5vIGNhbGxiYWNrIGZ1bmN0aW9uLg0KPiANCj4gUmVnYXJkaW5n
IEhXLVNXIHF1ZXVlIG1hcHBpbmcsIHRoZSBkZWZhdWx0IHF1ZXVlIG1hcHBpbmcgdXNlcyB0aGUN
Cj4gZXhpc3RpbmcgbWV0aG9kIHRoYXQgY29uZHNpZGVycyBNU0kgaXJxIHZlY3Rvci4gQnV0IHRo
ZSBwb2xsIHF1ZXVlDQo+IGRvZXNuJ3QgaGF2ZSBhbiBpcnEsIHNvIGl0IHVzZXMgdGhlIHJlZ3Vs
YXIgYmxrLW1xIGNwdSBtYXBwaW5nLg0KPiANCj4gRm9yIHZlcmlmeWluZyB0aGUgaW1wcm92ZW1l
bnQsIEkgZGlkIEZpbyBwb2xsaW5nIEkvTyBwZXJmb3JtYW5jZSB0ZXN0DQo+IHdpdGggaW9fdXJp
bmcgZW5naW5lIHdpdGggdGhlIG9wdGlvbnMgYmVsb3cuDQo+IChpb191cmluZywgaGlwcmksIHJh
bmRyZWFkLCBkaXJlY3Q9MSwgYnM9NTEyLCBpb2RlcHRoPTY0IG51bWpvYnM9TikNCj4gSSBzZXQg
NCB2Y3B1IGFuZCA0IHZpcnRpby1ibGsgcXVldWVzIC0gMiBkZWZhdWx0IHF1ZXVlcyBhbmQgMiBw
b2xsDQo+IHF1ZXVlcyBmb3IgVk0uDQo+IA0KPiBBcyBhIHJlc3VsdCwgSU9QUyBhbmQgYXZlcmFn
ZSBsYXRlbmN5IGltcHJvdmVkIGFib3V0IDEwJS4NCj4gDQo+IFRlc3QgcmVzdWx0Og0KPiANCj4g
LSBGaW8gaW9fdXJpbmcgcG9sbCB3aXRob3V0IHZpcnRpby1ibGsgcG9sbCBzdXBwb3J0DQo+IAkt
LSBudW1qb2JzPTEgOiBJT1BTID0gMzM5SywgYXZnIGxhdGVuY3kgPSAxODguMzN1cw0KPiAJLS0g
bnVtam9icz0yIDogSU9QUyA9IDM2N0ssIGF2ZyBsYXRlbmN5ID0gMzQ3LjMzdXMNCj4gCS0tIG51
bWpvYnM9NCA6IElPUFMgPSAzODNLLCBhdmcgbGF0ZW5jeSA9IDY4Mi4wNnVzDQo+IA0KPiAtIEZp
byBpb191cmluZyBwb2xsIHdpdGggdmlydGlvLWJsayBwb2xsIHN1cHBvcnQNCj4gCS0tIG51bWpv
YnM9MSA6IElPUFMgPSAzODVLLCBhdmcgbGF0ZW5jeSA9IDE2NS45NHVzDQo+IAktLSBudW1qb2Jz
PTIgOiBJT1BTID0gNDA4SywgYXZnIGxhdGVuY3kgPSAzMTMuMjh1cw0KPiAJLS0gbnVtam9icz00
IDogSU9QUyA9IDQyNEssIGF2ZyBsYXRlbmN5ID0gNjEzLjA1dXMNCj4gDQo+IFJldmlld2VkLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IE1heCBHdXJ0b3Zv
eSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFN1d2FuIEtpbSA8c3V3
YW4ua2ltMDI3QGdtYWlsLmNvbT4NCj4gLS0tDQo+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
