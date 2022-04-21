Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DA7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 21:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349020AbiDUVzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDUVzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 17:55:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D74DF58
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 14:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL4UL5U5SOWLAxEoEGZidvLIwjzt51aLYxN+oB0unwLC7Ff6oqBHczYZ8F0+7m1b4nyIVT+oj1q5UslLhJN02r16dfjHivZHiQoA0mBLmIHBtt/R/yxCdX8qn/DnwvhxCYYI/RdqGBYF322bv7cFFOQyP765mHFni2nKXWVfyNwm3TNCbAhpeR3U6MBgJvfPkiDH1764Hq4AzyrLuwQKZnZEAIURVSNwEoJqRkKciwbC3vBHqY6yW2B0zINj7C/p9YL7avlVG01G0R24S3B19YBJrmekLtwbAnjYfn9C8be/X92DmlLle354tz1cKgZryjBccZcsKK9wZJsNUf0bIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Asng1/Q0LOtzlGFvwazOKq6tWew98cRR4U4utp7Ek40=;
 b=YtBlJcxl6aKpKAxlxvMBGCUGT/x2j7uRvDWOg4C71Zyj+3v7NCq0Mk2QIvFosy3zVFqhrtmskhr5Nz03OVpQ0i0jqL435rAJp3xEiAoLeo/WGjE9FLD/GdvZ2oGYAHkw1QbcxWofrRyqbiWTB/1xTB4/zKT7Rr1WZCk9LSqA9t//oM5uh1JVb+NPrB+4fkGi0R8oIlf/E/zLXJL6Jxu3EtUI8E3YPwOBUqaPlWoCudSd5H6Fg3Dj49vnIB6iBSvV2WrMPx/ypQNajBQQgOCxx5oNH2g5D74AZZnzyVxt0/muHnlyBhXT7tS/6+IS0/WpDPdXbFw1frHykQ/8g2V0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asng1/Q0LOtzlGFvwazOKq6tWew98cRR4U4utp7Ek40=;
 b=Y6oSi3SOxI9vPdT99Wx49J+YfLNRZ9jVRiYX+lqyzDQuIN5/tHnkSqHjo+1UzC1xdj3CYkVKM+E16gTZ53e/co1JkotekHldUzW9FEblJsvCuVv/RaccOlWmyv/9mx8xnNhobKd31KDFPBFlgMPAweTZeVhIwa5jIZ9GSEDyRsqUEoIW4CGeLiwKMnP3Su6jjZfj9F3XZJHnKNszMGD4Bp8JByX5YSJj/oAnfUbDSV5mD1GGly2HdLCvvTZ7V9xcRqNcX03qRzmr3yyg5Nmmhjb8deCaBTE6pVCkuazI4gRzUheJzOrLUhbzL4XIvOqCUHYkZipsXTMONrbiQqtHQQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 21:52:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 21:52:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] virtio-blk: don't add a new line
Thread-Topic: [PATCH 2/4] virtio-blk: don't add a new line
Thread-Index: AQHYVGy4eix1+0x+EkygDJav6BOFGKz45wmAgAIENoA=
Date:   Thu, 21 Apr 2022 21:52:09 +0000
Message-ID: <8fec132d-1803-7e38-8611-f16253554006@nvidia.com>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-3-kch@nvidia.com>
 <YmAhAd3n79nDxNEA@stefanha-x1.localdomain>
In-Reply-To: <YmAhAd3n79nDxNEA@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3429b10-9727-423e-5051-08da23e12f8f
x-ms-traffictypediagnostic: MN2PR12MB3661:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3661AE91C8F1F1513B1E8030A3F49@MN2PR12MB3661.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsqBsmd2nDi3BXgRaCm8GQJ9V81j/aPqz9bsE01KI3X3IoLofERGJHUAhtQ13u2rSdSaJWqIdCMRjQYB48fmfzJ3U6hlzGN2MPuzhG7A7NeVt88KAFPp8Rrn33wEoenbimCWFofELEVK7Arq0FntvFdO6l+F9BIH9yIwJMLLU2Gk7A7P6zHO+ZY3qFpZr4pnoGXYJ/MVyAW4raFICWOhm36XvwEjCtRzoJfGZrCnkZhNMI2U7EiQYsJaFKj0AYgGEusGcT8ANG0tZ4AmooWEGcXbY6AhGB/OnqhsRV7KlaLjtqVBcsPDqrSOUZcMjf/VlL450Wdq0EbMuvhxL9JmDbX/XmmycTE+qvlv3txefVb/O8oVg/7cnLFDtm7N4V3fj1HGDZX0cl6GwysVUiHL022APmAsTr13jGmkGmZWQf67LqVBQrwM5RO6eLePqdlRmLNpuNfJ5zPYEfQL2RpFOBgARM+PMA+qNZvoiA+WA4XUx1T1uKWSzdVvor4tm5IDnjAmbWoHOxi4cfWmyLAJBU+wBHmPHzqV38D+yqa1GXpM0Dgg+lmTuKfn7POUM/NoNIs+IzFBCwRWDZLdRamazYpEftkfdwXrydqfbFVc4xYChXs7xFY5WcEKfe8f4waBviYaRkNDImhLNmLJuvM45cpDREeVyrSEP3Tzfo+mbLbbbnwQFmX/HFsPAhYZOdxTTAwLZIopghqnvacfhWwIT6hodXIS/5H/PdYiT4fnweJLK6ZEPD0k/Kl+HmePW51E5He28NVy2Hb5529VE4kxjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(508600001)(4744005)(31696002)(54906003)(5660300002)(6512007)(110136005)(8936002)(53546011)(2616005)(36756003)(186003)(91956017)(6486002)(316002)(26005)(122000001)(2906002)(83380400001)(66446008)(66946007)(38100700002)(38070700005)(86362001)(66476007)(76116006)(66556008)(8676002)(64756008)(4326008)(71200400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkpOZ3ZjZXVVMzVGV2dPbE9yaTB2akN5QUlKWjkrK21lOWIxbUw4R2o5VlJo?=
 =?utf-8?B?K2lpYzJKU3R5THo5L2k2aFJFWG12bXRWSDhqVElqTWtmM29rYUgwMWY5d1M4?=
 =?utf-8?B?bFVRY0o3MW41MGVFZXQ0SXN5d1pmT3MyYUVnaXZBN3N0SnRBdWI3aWhLV2hm?=
 =?utf-8?B?c080NjBtTmw2emlCUHRvQnNZVXhvOWErQktaUEw3ZzBTcUtVckRGbU5wUGJn?=
 =?utf-8?B?Mng3N3VQYW93VEhXeXRtZ2ZzdnpNVzNLdzdONnNuL1ZPMjROckpMR0FCLzF3?=
 =?utf-8?B?MVV2UGtBcXY1MmlQNHBpRFFueFdNYTlyWjBEeXowZEp3TlJ1T21pK3dzVnYz?=
 =?utf-8?B?dmVFdVh5QVNSclh6QW1tbGJnaHFJMDlyZlZTTVRnWTdrcTV3TEIxWXBBZ3VI?=
 =?utf-8?B?dU9zTTFJNlhtWGI3OUFEdmFLVWdyRmd5Nkh4Rmd2RDBWR3JHRTlsQlJJSlJN?=
 =?utf-8?B?RGcrTSs2RFVXbUxtSFE3cUpFSWhKVTZGTE9WNk1HWjlsdUsrUnRSMDF5UnZO?=
 =?utf-8?B?MXFEMCt0eVNxUEpJZm5kdXlNT0JjcTlDTmRrd0lwaGRrUWd4eWtxeFRhaEgz?=
 =?utf-8?B?ZVMvUnpWdGtUdGVWL01pWFpBaFd5N2pzdndJMVZ1UW52cnhLTlpBSmt1eDM5?=
 =?utf-8?B?ZlZncG55U3M0TjVhRS9HdEU5Nk5ESDNvQWNqMFMrTi8wak1yTG0zcFdVWi9q?=
 =?utf-8?B?aWFWeER2TnVVY1N4UXplZkppdndYMkZqOU56VzBhT1VZc0ZpanJpUXIydnpN?=
 =?utf-8?B?UEFDNVJkSTRhNE05SUtQMkUwREZ2aEpDTHJYam5PaFFOcXZZYVVjaENPQzVR?=
 =?utf-8?B?ZnZ2NWZRUmdkR3hRZjE5TDEyeUxBcWF0bmJRT0ZOaU1rcmVlL2JHQkkyVDNQ?=
 =?utf-8?B?UysxVlpubE82OGZFNVdqYlcwRC9sRUVuNlJnWDRYRTdnSHdEd1hsYmNmWVpa?=
 =?utf-8?B?TTRlVVFUdy9meG4yY1MwSmJxYnRTRmlFYU45bzNjQnl2NGxzQnZQWkNiQ0lo?=
 =?utf-8?B?MWNaM0o2bkZKWnpFblJNRFp1ZGNJWnNUWTdhZW5jVHhUR2JHVC9adlhHNnYr?=
 =?utf-8?B?MWJ4d1BqWk1wZDkwOXc1S1h5ZnZTRnd6NDUvdXVMaUJ4endXamVvcmVCQTlx?=
 =?utf-8?B?UjdZbzFleldxK2tLYkxxa1JEc3RRelFTWnlOR0t3R2c1cUU2WGIwOVpNMVFE?=
 =?utf-8?B?VVZ5TUI2cmkvYkxHUWFlaTBRMXpacS9KMFB1cUY5V1dwc2NKTDI5V282MVFT?=
 =?utf-8?B?Mjh2V0FQZkhaOTdiWi9mcUphNkswd2NnVU5tVi9NZFNncGxUaTdIMG1WSU42?=
 =?utf-8?B?MWphRit4bWNGU1NjVTBVS1dmYkdTVkhQblZGWXhNa200VUdYa3Jma1VZakhp?=
 =?utf-8?B?YlVRbzJQb1FUZ0MzZFFlanloOFJya1ArOTdqcGxFQThzby9wQXNlWUFHakh2?=
 =?utf-8?B?QnBqN2R3aUxsL2pRd3ZzSXhGQy9KKzV6Tk1MUzhTV3NseGdFZFk2SzFxVjVv?=
 =?utf-8?B?VnU0WkNuNjlvb25lQTJ0Z2VWclZnK2xsbmtIMy9mSURaTVpXd0RFYXNrR3Iz?=
 =?utf-8?B?cXpyQnZZMHdHQUUwSkVhdHRqNnJJS3dXT0ttNkF3dDJxVUFiK1hFRkJ1WUpn?=
 =?utf-8?B?WG9Ia3piOWlYenFDZXpPS1V4a01PdVkxRWZoVFBaUlE1S2IxWmxUVEJzejVq?=
 =?utf-8?B?NjNlbVFreDMyL256K0ZPZFhGZDNNZHFXbEVQNVhjQ1B6SkhIV045cWYxWXVW?=
 =?utf-8?B?bk5PT3BtamtkUnl6SnZCWGgycWNNUDR5ellRd28zZmcxTDVjZDlZMU1VdmNy?=
 =?utf-8?B?dXRwaTVxRnJPOTJ6b2lhRW92TDh0VDNqZG11K1JtcmRCVENrTFB4Tm9uNmwy?=
 =?utf-8?B?eVFyQTZoejNhM0JPYlZ5TnRzQk1teXNYekdiRXduODNIR0w1STZJZnE2K3Jt?=
 =?utf-8?B?SjZWQTVHTWVKbUEzSDNnMkd0Z2hRcDZ5d0lXVW5zbHNGOWJ0Q0w2K0c4ZmU0?=
 =?utf-8?B?R3NPWnV4bk1ubXFSOHN6T2Zwd055VUszMWZkYTFMU1Nod1dRU2JzakhVcGNt?=
 =?utf-8?B?amcrbU5xWFFjYzA5RWwrVlQxcm9QcVVpRFpZSDN4WUE0MVlvY01WYlpKSDdK?=
 =?utf-8?B?WlowSWVkTDBFZ0tSZzNxTHVOZWQvcnArM0oyMDdWdy9qcGttSU1CWjEzMExt?=
 =?utf-8?B?T0lheVE5dnhjQ3BhSnpzaUwzZktsMWtpWFo4d1pTcXhNMERJcERRK2I2b3Fi?=
 =?utf-8?B?bUxtRHBiYUxOanFSakVvM1dnWnZSTURKaDJUZlhxVU5ySlM3U0FrYksvVU1n?=
 =?utf-8?B?SU5BOVk0amdKWnJMcFI1U3VVYllSWVFaMXVGcC82TkF2T0t4ck91QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF19BEC64976D4BA38FE7E8F3672817@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3429b10-9727-423e-5051-08da23e12f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 21:52:09.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4U9+SU1Q/LhCNlfOtpBYcGczD4Cedf9ybGsVPbj5HJuuFUvnr1ZqJV3QjB9SDJxADTCCu8pheFYrP+hrZ4xJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3661
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yMC8yMiAwODowNCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAx
OSwgMjAyMiBhdCAwOToxMDo1MVBNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+
PiBEb24ndCBzcGxpdCBzZWN0b3IgYXNzaWdubWVudCBsaW5lIGZvciBSRVFfT1BfUkVBRCBhbmQg
UkVRX09QX1dSSVRFIGluDQo+PiB0aGUgdmlydGJsa19zZXR1cF9jbWQoKSB3aGljaCBmaXRzIGlu
IG9uZSBsaW5lIHBlcmZlY3RseS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmxvY2svdmlydGlv
X2Jsay5jIHwgNiArKy0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IFRoZXJlIGlzIGEgY29zdCB0byBwYXRjaGVzOiBodW1hbnMg
c3BlbmQgdGltZSByZXZpZXdpbmcgdGhlbSwgQ0kgc3lzdGVtcw0KPiBjb25zdW1lIGVuZXJneSBy
dW5uaW5nIHRlc3RzLCBkb3duc3RyZWFtIG1haW50YWluZXJzIGRlYWwgd2l0aA0KPiBiYWNrcG9y
dHMsIGFuZCBnaXQtYmxhbWUoMSkgYmVjb21lcyBoYXJkZXIgdG8gdXNlIHdoZW4gY29kZSBjaGFu
Z2VzLg0KPiANCj4gV2hhdCBjb25zdGl0dXRlcyBjb2RlIGNodXJuIGlzIHN1YmplY3RpdmUuIEZv
ciBtZSBwZXJzb25hbGx5IEkgcHJlZmVyIGl0DQo+IHdoZW4gcGF0Y2hlcyBoYXZlIGEgY2xlYXIg
YmVuZWZpdCB0aGF0IG91dHdlaWdocyB0aGUgY29zdHMuDQo+IE5ldmVydGhlbGVzczoNCj4gDQo+
IFJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+IA0K
DQptYXliZSB3ZSBjYW4ganVzdCBkcm9wIGl0IHRoZW4sIGZvciBuYWtlZCBleWUgaXQgbG9va2Vk
IGEgYml0IG9kZA0KdG8gYWRkIGEgbmV3IGxpbmUuLg0KDQotY2sNCg0KDQo=
