Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C84C761A6
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjDDScU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjDDScG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 14:32:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52583E2
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 11:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOQYcpoeVNHjCiuHISTYb5ld4ZlcPQ2DroZEjrwSWeB6oGJ2byjgbbBLvwuBsGr108PkJ/3BKRBh2yh2Q8A8eBZLVtmKJ+WDWsoGU6+YRXEIYacfyIAOssu7wTVqvDVkFZ86g5/Z56+6kSHQHrFEWXeJaS3GY17xN72Ci6HI7zgfd7RVtj2El/V+UNXAk0NR9T9FkE2vJBK63MMMfevNgsesHPM2a+KNTaGEawNK5QnlQOOMjdPyUyYHeV/jHLhShFp4Zc9ddbVsGGRFhRZImgVSVwKBk+oZcrVEHJneo+W5hleQGrm+9GKasoVqrAt1/3AsNwFUP24wjdtx766xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGP2dVwAyq/cbNZ0owGygvyHc6wRDGNqLjcmeDjvVC0=;
 b=BEUhSkhDdcJlFEsOojdjoseXi8bGiLt9Jg3vF7/7RXUjpc8Q7Fp6iU35tmLDCL2i5RDhibFdkFIa08prxhegbNTnQhv9b+5MGgGuQ/k854L9dRgnqwv3/94MGBGFUCHsC2HoG2HivqHj0NTNTleELkgW5F94VHVSQEZL/tgUIm16OXiGHs0ravkfEnqFOEkVoZOrpCOlKUNemxK3Bz6SlGtJkZhVs/u+/ojoJmzP6/12E4dg5qd5KeK3R7KxJILwBlP8s+jzQx/iuQjoG7XrXUgGHKhioLvki2SBDqdRzS6J/0euExFX0Mhwc1dexeTKZGgCCuTUDkR61QgId8jGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGP2dVwAyq/cbNZ0owGygvyHc6wRDGNqLjcmeDjvVC0=;
 b=WQjsp57PGPg4QxgSzQ2KY8/NKJO9p+/hpYETBYXEOL1He/kOEAGeNUYW11US0zQGSN+GFIYUSbYDxCGbZdKEtEpHXWwIMzqlhUCmxEyX6IT/E3MbzYDzW1qUzsTovxapyQBUF6DGmcg9zo4bgf+m3na1mFpN4bv2BovT+n2kz2dUWF61vAtZisf8JJcFfblMnFgysgYupoNzCrbSzh0qt0fVcuXbhU9M8Yt3lbkaX/0BO2/Po8JrwMc7GdCZ/dZXwY0qb557Smivigh279a3KIX2aIBYvqFl6XMOh/+MtxRl11448jFflnCm9FaJDWnU+OnUQYAqQjHo+HVxJ1oyoA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:29:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 18:29:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Alyssa Ross <hi@alyssa.is>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] loop/009: add test for loop partition uvents
Thread-Topic: [PATCH blktests] loop/009: add test for loop partition uvents
Thread-Index: AQHZYyGPFP4Za0bZWkK9bgonlouwP68bgGMA
Date:   Tue, 4 Apr 2023 18:29:00 +0000
Message-ID: <517f4449-ffef-f1e8-78cf-bae8c2cdf665@nvidia.com>
References: <21c2861f-9b7d-636e-74e1-27bd7bbb1a4f@nvidia.com>
 <20230330160247.16030-1-hi@alyssa.is>
In-Reply-To: <20230330160247.16030-1-hi@alyssa.is>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5926:EE_
x-ms-office365-filtering-correlation-id: aeb63254-06b8-4c8a-5a55-08db353a7617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbQDXK2v/xMKKKcOWMgC2qWpu7EaQUOeVDlTUljfo0TBKdcwb831pn+L+AzSmdDyIRXMvCYDmUsCLUritr0Qm+nK+jz9ttyeaLIsEcv6iAlioK24WlDSyd5n+6DlpJkETXCxNtCS7nFpDCDRd/ISldpbvOvyu9/QlIuFovfOVHvRiOHf9Boky+EMeOmLN8YsW7wc6XJioMnspOiOyzJ9fjd+9HE4gnYirgE++efZ62XGIGG6efd3Dle36+V++AFUS/JVNZIT4V0UkFqKtOjs3hRHWHCYdv3tCNXc/2Dtve/VK0eoPslAyaqwiZH5gRpPFB8YTcATWKnDKGwzG0iAmMpQW4TuwtbJOlCAxZQcCsGd4WjBJBU5Xd5oGWbuWNe8XDKc04Py3LcDXwoKQiRB4ss2++74yjjEQ70jcU/8xTciktG5+E6AHyfVd0sbfb6iaXvfXpIiMnX8K0HSrPK6pxoXAKkcM76tow8JcCUG2HGlQTroVfpZeVb4NGwIVTAGAz/fGJu8OGItHrvx6PzC0PzTojwG3kGI1byAFqwm+B7/qJWNteqcQgyJEhpNtXQUjpe5WUFu+zgCpFGWUGf6omnpqBCYDxsppq1PfmQoRL01GXfN0K5nR1Z1/Q+brZNhyo0LQy8eUCHuP7qpoHtyPtmeCWqvqgf3hG1cHhWU6kKvwSJY00/MpMl6hsDS/MIbEemdFPP8h7M3lLVl9kBGoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(122000001)(4326008)(66946007)(316002)(8676002)(76116006)(66556008)(91956017)(66446008)(66476007)(64756008)(54906003)(478600001)(4744005)(110136005)(8936002)(38100700002)(5660300002)(41300700001)(53546011)(186003)(966005)(6486002)(71200400001)(2616005)(6512007)(6506007)(86362001)(31696002)(2906002)(36756003)(38070700005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3ZXN3JVLzJHMlJUMnZldG85VWRzSzBGbmYzZHkyLzhFQ2xzanJLNFZRdlJ6?=
 =?utf-8?B?ZUtEWjhkRERYUnZnZ0NTKzdEY0UyTHpnUWJRcEo2Zm9HOVBrTjhyWkhLOWcz?=
 =?utf-8?B?eUFlb20vTEFUS3BiWUNnTmlXbEg5ZVN1bHRUSlVITitISE9DNVliUjQvV0Nr?=
 =?utf-8?B?N1ZnK1VzcGxDZnBhUHNEQWZKa25laFFXcUVjOGxQSW9LNzFRVll6ZXhzMG5K?=
 =?utf-8?B?Y3NtekxQNkRad2x6UVNEd056cDJONHVCN3hzSUZYYkdvYlVhSkRJNUlEdGxo?=
 =?utf-8?B?YzJXYjg5eEJiWU91ZUVoaDNCSzRHeXhkMXFaRzVacVJTRzl1UWVvU3djYnYx?=
 =?utf-8?B?bFhvQWZUeTE3YUM5TVF1WFpCNlVRTzBQcURmMHlnMDBQa1pQbXhOQTFRS0NP?=
 =?utf-8?B?VGE2U0wrdWN2Q3pRRFNJQVU5OXJoKzVZMXBTcHpqaDFKWGlxTlFlQjlNelUw?=
 =?utf-8?B?Uithc2xDd0VBMFhjZWpaMWwwc1ovUDhSR25OdTBLRkxzSjZ4WXloT3Jmdm41?=
 =?utf-8?B?bGVRS1ZJOFA0T2RhY21LVHJGcFA2WUhjSmgvRGZCQVpCOGhSczI3Nk5FVTlW?=
 =?utf-8?B?K2d6aHIyYTRURElHRlZ0cjF2N01PdTFrT05ycVJsQmpKeGZ3YW4yS3lDTFV2?=
 =?utf-8?B?VitnM0xOM28wT0NxZkdpRTZ0T0JFdDRzWnAvOGdValpiTDdqYUY4bXB4K3Z2?=
 =?utf-8?B?WDZ4Y3lBOUYzZytXZ1p3elNuSWg3NzVrQm1GWWpMbHRQMHFlNzEvTDJxYnpq?=
 =?utf-8?B?VmJ1NzVrQkdCZmlWeG5XbFg2RlJrSmhJYi84WmE0SnVkbnlweEY2czZaMlRS?=
 =?utf-8?B?WmRCQS8xVUdzd0M5ejVacFc5SDh3cmYvbjVwL2JuaTR3OS9xek8vUzlNV002?=
 =?utf-8?B?djc5Z0VDU0thOGJha1E4aVpva2RaUlRwWnN6Vk1memEyeFZrb0pRVWN5QTZF?=
 =?utf-8?B?QkZ2RlcrYVpQQVh2V1gyUnNYSnZUR21tbmhuY2JET3hBZXpta3Vnc2E0Sjd0?=
 =?utf-8?B?eVZkRTRkUTB6VzVKOUpkY2V2SEJaWFFTU3FVV2NwSGhlMXRWYS9xcmhNU2Qr?=
 =?utf-8?B?a2k2cW9wMlUxN1FDNnFqMXkxNGFHdjdvNkh3REtYK0hCY0FKU01OT0xzZGJC?=
 =?utf-8?B?c2JQakloWTFtK1lhZUducWxmUDRVd0t5TkFPandHVS9DZFd4R01xSERSeEZG?=
 =?utf-8?B?V0puSlNOM1N2SG5wVzVmdG82TG9reE1PcDhzNGZKZW0zUVlMc2VnYWdDdzF5?=
 =?utf-8?B?WHRiMXJkcVFKZ0x2dUxURytja1BGaStmbWVMK05PYVYzUnF0b2tEbWI0MFBG?=
 =?utf-8?B?ckEwTGZxbXh5R1pPa0h0T1N4UzZJNm91dVZuTjhJQVBDeXpmMTVDWXpUZUVh?=
 =?utf-8?B?MjJ6OFhYT0VDNjZDQldlaUNrZlp3Y01xVFdKNU5TNy8rOFNwOWlMb0RnSFJk?=
 =?utf-8?B?c3J2VEY2UUtHeFdRZzFxYzVIZXdLbVMrY3AyV0NrdlJKTEM1VXplb1paRW9p?=
 =?utf-8?B?R29YWnRQRGRmZ0RrbjlPY204a05qM0hkTWFaTk40bDdWVnlqTnJhOWRYT0ZJ?=
 =?utf-8?B?bnh3NTVnaUZNb3hiQ2RlVHUyZHFaWXNPT1pUc1ZXRFJDWXBVU1daemhodjBy?=
 =?utf-8?B?TExrd0NoZEM3YlNZTGJwUGpabm0rU3FKODgwVXpudXBtZmkzaWUveVg3MUJa?=
 =?utf-8?B?YmdUOWZ1akhySHZSZzE3QVpvQ0s3WUd3Y0lPTW5xaUE2d1E0ajIrWWgzVW4x?=
 =?utf-8?B?dVZPYWxJUnkzLzY5OVk0cUoyL3JXbUM4UHRZQXljWlNKeGdHZUpxdFhiOEdk?=
 =?utf-8?B?ZGlQUjZvZEgzWERPeEJISHh3aG1idjZibTdjU2hLVHRsRU15c1d3REF0RXFQ?=
 =?utf-8?B?cUkvbUsvRFV2UlV6RTFhdE1vL3lPNUdnVVpGN1RML1RHaEd4bWFGbmMrb2Jq?=
 =?utf-8?B?eStyU2Y0TEhRSTNCVXQ0cWtXVjkyWWVWUTllZmpBRkNRWGszekMvS0s0Rnp3?=
 =?utf-8?B?MXl4U1pabllmMVloeDgyUU4wMXVwSWUycEQ5UUoxMDhLL250cHFYV2JQWGdN?=
 =?utf-8?B?VG8vdzYxcFdZSk9FQjFnNlRZUUYzencrdFRVajJCOTZEeTRPRGpMOWYxTTJx?=
 =?utf-8?B?Tko5MVN6aVhaZlEveDlOT2s3RXdxaEltbjNPRDY4cFUzUExRa1IwdXZIM1ll?=
 =?utf-8?Q?2cuM74TGxLew18bTyStZ9/qs5sNA97OYo4ry+KQGLmzQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71E8FD752F1A84B9D0FBD8065845388@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb63254-06b8-4c8a-5a55-08db353a7617
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 18:29:00.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuWAHBDDQS0DoLsvrH16mZMde5iKdtBWeVeM6U+9wl4nahv4wC4cc1jNNan69BWCy/AEe98OD2xN6n65a/136g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8zMC8yMDIzIDk6MDIgQU0sIEFseXNzYSBSb3NzIHdyb3RlOg0KPiBMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjMwMzIwMTI1NDMwLjU1MzY3LTEtaGNoQGxzdC5kZS8NCj4g
U3VnZ2VzdGVkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YWtAbnZpZGlhLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogQWx5c3NhIFJvc3MgPGhpQGFseXNzYS5pcz4NCg0KVGhhbmtzIGEg
bG90IGZvciB0aGlzLCBvdmVyYWxsIHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCg0KVGhpcyBkb2Vz
IGV4YWN0bHkgdGhlIHRlc3RpbmcgZm9yIGxvb3AgY29uZmlndXJlIHRoYXQgeW91ciBwYXRjaA0K
aXMgZm9yLCBsZXQncyBqdXN0IG1ha2Ugc3VyZSB0byBhcHBseSB0aGlzIHBhdGNoIG9uY2UgeW91
ciBrZXJuZWwNCnBhdGNoIGlzIG1lcmdlZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
