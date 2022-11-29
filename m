Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332DFC4332F
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 19:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiK2TYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbiK2TYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 14:24:06 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905C373BBD
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 11:21:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuMGVuvS7gb5AtrDVlQYcAyC5EbCZyN0cxDkEr3Tp6GEoHjrHgFCSHQEOQujw1EcGOOH4kwD7Rv797NoUVUyMZGnboM21SeLFDbBvpRCdWLYXbIWkoJOEMvocdwclzzLS6HZN8OXjy8pH5dIv0DXlUY8zptQTXV4xGmp+1zNqgu+i7jrDvadEh7mYDGD2HMnrBspA//criyd49QPE6FcxvlbpIDcEvjhtIeE6mIwUv3ni/lCa+OIckjL/Bp2perZ9HN+rr5SZ1CPuAtZ6KKYFMakfjIsDw5vKiKYI6Ao4UFPhrkV4pbWpqVX9FV+TV6oAkFoC5nQ3IC3R75eioH/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Am5gv8H+Xjhp+TcBmfF0Hw5/GUasHKSBfqHvOn1XY8=;
 b=NDrCo0aqg5M9AsuxGDPJnBmFaEoXglXM5aM3JOI0Qwno3R6jjE4ZTEEfWMyrqyJ9kQlBQDWhk5I7xdEdzrRXjsynYJj5ZedeY9kyGNNnO+VQNLvSamPV0sPrA0SF6lPmp/GAdXqJ6bD8FDs0d7RFmtdw2O4RMUmoEdxPykNytlUloOvFK6RCZ2T+CnNKOdA3AnEikOYOta3SbOzSBLz+TNhGh5fdq7kyERN89xc4Vs6ER1C7unlQFsgYPlurkTZHXunh1yHbpqXceYUbGLyGIoBDw4KRub/6W9rqBqnkuiSjUjOwasZ0IXbu0uijJxjm55e9Y8lDMmBTlUNMvaN1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Am5gv8H+Xjhp+TcBmfF0Hw5/GUasHKSBfqHvOn1XY8=;
 b=mipgoHXcIn3IZZxLHH40L3EmZia1nY+Av+KU8L5yDixhfk5kREvqz9iWi+pnjekO1oU4sC9cgHFLy8bzjeazy7LiIxGxeoZjpD0y0FFosVKVD1Epi9JHDnElHpVRpN7ZFm5I+UsS834ia9s5uBcXKdI31YYcEsi9CiXRNA8RUU6s6eB9eG1AK/Tf9iNZsQ1K62aB7Jta8clzZ3F/uonmUSJASwcbSIGneBGFE/VCn9X/mOJdcQk52M7VfpRKeY5yVnS4pOtQxicT6go2/k2zhWUufyFFgrX8JB92pqTnKCppXDWT7huU6Gu7LzfpgD0yAR1gn1osgula5CPrbivzLw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 19:21:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 19:21:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "longman@redhat.com" <longman@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blktests: block/027 failing consistently
Thread-Topic: blktests: block/027 failing consistently
Thread-Index: AQHZBCNV/72W+/d/ZU6F5rUUgMyWk65WRSoAgAACMQA=
Date:   Tue, 29 Nov 2022 19:21:45 +0000
Message-ID: <270267dc-0313-c047-97e7-9ecca036be10@nvidia.com>
References: <f9490310-11e2-fdc9-db3f-2b4a51170c85@nvidia.com>
 <b1efe64c-7b8d-b10f-a041-bae26aa3e637@acm.org>
In-Reply-To: <b1efe64c-7b8d-b10f-a041-bae26aa3e637@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA0PR12MB4592:EE_
x-ms-office365-filtering-correlation-id: 58e7f96a-d7e1-4720-7bf8-08dad23ef40b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pBU2Uui5j7o9X4nBYKFqJN5eBVXGNkaPSUauBva9zeYldxicBoAvM4wniKAgD5UPosdPzfPb7XCuKXxMB49NvxC70+GB1XzWMeHrv5tXraw4G/J47gqAbIeAZ2gJbVjbbcEAwXoZjoc4gI4ynupoYabGxt2Q9La9irclSSlRLYlZf8Wn2oxKd36lFADLFFzKi01LPG4YvHAeXDMfwgJHdwmRzOqZ8Cyrs1X3c2T0FQYYmWgTxNgagsWpxPtMPM3PgnJHYVAy5h6GpC/Dy9dBfLYGeq3iCMJ3/ODRfk1tnysQjuNyXzzntH+WzX3UWML7sc7TBd7nmknkxLRPy6y/ZjmnN3gChZf3+18a1ZDgHH8caMwYs4PfTxv+Thc9D94eQX2gN+eVk3FPrWqoH+txnJCP+DMnP/Wf7WxFnEq/KOhlDE5ul5YG31omwSwbYXPQHi1n2mGRte2wQkvDyYjyzmQVXJ/ILUd/0USSdZ+Od4A9l+d/H1GIf9tWnCRe6Y7CKkTyKsP7x+iSsKWf3uPwsosyIy3hgYiKk2ZsGu3IrzcSia858++LoemJinGeShBd5lNmIQYVf/gTVAJBiZZtXmimT/9HV518TYfLBXdyq2HES+/oNsUQfjDGp034Hw3fjAcZ46AeYLxPuZMhvPCZpxpJICnJOEvwAj2UOTMUI5LCkpF6DzT6shOzg7UK9y/h/lUW06ITJ6UMLvKXr22al9ZSzuaQSfnJAIA1Xd6UGyMxh66JM6mxJSlssfvC1yh8Q1UlycVBRKzVTkaNl9EQ/Ur9A3YGnvLzvjIY096Y8TFK4YtSBMZQosfZ8mvWAY23FTgW+7T4Htimb/dhpub/ZjsAJAKlxAFBEcfUtqlNXM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(478600001)(316002)(2906002)(76116006)(91956017)(6486002)(110136005)(966005)(36756003)(71200400001)(66946007)(83380400001)(122000001)(38100700002)(6506007)(86362001)(6512007)(53546011)(31696002)(38070700005)(2616005)(186003)(4744005)(5660300002)(41300700001)(8936002)(66556008)(31686004)(66476007)(66446008)(64756008)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekdCZlhRQ284QkpuQldDQUoreW5mc2lpc2JPd0h4TW9MMklGazNua21leTNl?=
 =?utf-8?B?N2VTNkZEY01JVVBrSEVkZGdHeDVpelQzb3JvMklIcS9rN1FxRkNVSlEzSzJE?=
 =?utf-8?B?YkV3ME1jYkZqMGxwTGpseUJ6YXVJbStXaWlyQkE3dVQ0aW1lTG42TS9qTTB6?=
 =?utf-8?B?L1drcTRkcmxJZ09tWUE4WmdnR1BVT0J6YnlTdEZlVTcweXdSSGNVV25qNW9k?=
 =?utf-8?B?RmIwYVRNUlZsM05Ed3RTL3BZeTVsRTYrTGV4Ynd5bXBEUUR4ZG1RS0Q0THJE?=
 =?utf-8?B?Z3ZDOFptdldSOFYvMWFTR1ZuZFFBdzF4QXg2TVdjaWxpcnM4dHUrZnNIemZK?=
 =?utf-8?B?Vnk4WTFvUjFma3NOb2VrenlTRUk3a1U1YzMrRUdVQUU4K2tBZHA0bDZRVHRK?=
 =?utf-8?B?RkpjSEtzK2doTzJnQUhsWEFITS9vajN3Y3BhQWNPSWpMTUJXd21DMHZuMHpU?=
 =?utf-8?B?RWJRb2hIbnlVVTF3aHp0YndKNDBUb3FVV1dUOWU5TTB1c29BSDNWUk1DSlM1?=
 =?utf-8?B?TzZwZklCc3luMWEyN2lvYk1vUTBlZlBheGVzYnAxZFpybHNyZEpzVHROZW1M?=
 =?utf-8?B?SGNRQU14b2VnY1dacVZHMXBUZEk4UmJhNDNsT0FzUWd0bVNKNktKNklBZ0h1?=
 =?utf-8?B?ZEhWdzROTFBIY0ZWMG1jZEZaMlplUktZbmZPcEFWTUtrZEllTUswVGZhYVAv?=
 =?utf-8?B?aDR3ZHJEYjBaNzhBdnNmdVRsVEFKYlhlYmJxVmJpQlliQUlBRjY5MThJdG1B?=
 =?utf-8?B?cHM0aVloSzFRY1ZEdzFNSExHZndQempMK0hkNDJ5QUxmbWxjWWVqcXlWSDl6?=
 =?utf-8?B?TUQwNWp2Rno0UzhjUlZkeVRIV0J1WTF4OWNyN0RWaEdXUHF3MXVyS29vZmlN?=
 =?utf-8?B?cG40S3k3K0RveTRwaG14Vk1KSnNsbVFFU2RiS1ZMRlF5aWJXYW5seGVSWExW?=
 =?utf-8?B?VnZ0SWRMemZVYUtmVzBZMzRsZ2lJVXJYbTA2R2V6TE9FYmZId2pST3N0N2Q2?=
 =?utf-8?B?N2M1UVp3NmwrdSs3cVhFVmRzc1o3T2NLT1g1STFOVVlHdHJSb2FHeVJhditt?=
 =?utf-8?B?cXpMOEVjSjJXMlRzRmlTMzgwakhIU2VuMHNmbUVqWFJUN2txYjZmbjJwVjcr?=
 =?utf-8?B?Zy8vSFZyOTRjSFd1OFNvMTR2UEM2RVRzb0c0djZSZDlUck5PNjdOZHZDTWV0?=
 =?utf-8?B?MTVtcHhhQUR2VjUyKzA0UTMrRVZkU3hvdC8wODlRZ3BkYkxlb20yOGwrRXZE?=
 =?utf-8?B?QjRBR0NJeGFDajBFVzlQN09rN1JaNndmYlFyTXBkUjR2MWtxbG50eUZReGxw?=
 =?utf-8?B?Z2pmWXFLQzVjdVkyTWtMLzZSWGdjU3NNaTFRVXdhdm82RVlXbmtKYm1HRFNT?=
 =?utf-8?B?MlUvbFprWnM2REhoOXNGN2w1NkJ2RFZ4QkRBelB2dGlQbENvL0dMY3pESEIz?=
 =?utf-8?B?NGQzMWVDODNRc1dQTThyUHQ3cUI3UEpLZnV1M0pCb0RiNEdVaWsydEtCeC9s?=
 =?utf-8?B?ZmV0T0NGSVBkYkRydHhyOWE0UDA2MWJ6aEd0eTdzaHpNWi9aaVVhcWc1Wm84?=
 =?utf-8?B?VTMvZFZ6bzFkbk9paWllRFQyS1VHWkFaMHZHV1ZETnYxYnVLV1VaeEVnMVJR?=
 =?utf-8?B?OVBERE1WR3JscmpSdC9nSkd2K1N3RDJnQ2d3OGpSQVQzWDVob0trTnFaUGR6?=
 =?utf-8?B?WSt5L2x5cTIzeVU3WkQyQmNMNkYyK2dERC8wNTJFRmVIekw2Z3E2UHZQY2xT?=
 =?utf-8?B?SktEc2VoVmVxckFlUStwSEdxK0tHU3A2S2hMekRuLzdJemNZRkRzZWg1WTd1?=
 =?utf-8?B?Zjk3bU9Rc0FOU2hFQW1FUU5NRkNTS2drcXFDU1l1dFpkY0Y2Q2tYUG5yNERB?=
 =?utf-8?B?aTFScFNQTnVjelNUZW9kbjIwcHVhZ1p4YkRjSXcvY0laTEgvdlFkY2NaVHhi?=
 =?utf-8?B?V0g5cTZEakFoWEdlbng0dG9oOTVxUlVvamc1VnhXOEUzMTFoZFh1SE1xcDNy?=
 =?utf-8?B?NTljWDkvTnlYUDhFYkc2MlpHYkNGRWUyeW82MEgxbzBqTFFYdjgxWWJPOFZG?=
 =?utf-8?B?UFNOdDZsRFVoZlVYeDBqK1M4WlVObkNsbHFZeVowVmt5WCt0cXRRQnp3WXo1?=
 =?utf-8?B?bTl4WFFyczEzSnNYQnQyelE3bVBydU83bFBnOXJ5MjE3RTdSdG1RMXFHNFVq?=
 =?utf-8?Q?/1GQOua4hSBJgbqdGmk42N7agSVEFm75I2u70Kxc/KvW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76CB9D65C7970C4096D9E48D8F38555B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e7f96a-d7e1-4720-7bf8-08dad23ef40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 19:21:45.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4jdKzKw24IWHEEEQMZQ1hlMJpWkVntoNZfR6TNa9X5bjnMFwYI4VXOY89M71aOWpfMfBNb8GUaqnOy3QToFBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjkvMjIgMTE6MTMsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTEvMjkvMjIg
MTA6NDksIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IGJsa3Rlc3Q6YmxvY2svMDI3IGZh
aWxpbmcgY29uc2lzdGVudGx5IG9uIGxhdGVzdCBsaW51eC1ibG9jay9mb3ItbmV4dA0KPiANCj4g
SGkgQ2hhaXRhbnlhLA0KPiANCj4gSXMgdGhpcyByZXBvcnQgcGVyaGFwcyBhIGR1cGxpY2F0ZSBv
ZiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svNjlhZjdjY2ItNjkwMS1j
ODRjLTBlOTUtNTY4MmNjZmI3NTBjQGFjbS5vcmcvIA0KPiA/DQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBCYXJ0Lg0KDQpJbmRlZWQgYXMgSmVucyBwb2ludGVkIG91dC4NCg0KV2FpbWFuIHBsZWFzZSBy
dW4gdGhlIGJsa3Rlc3RzIGJsb2NrLzAyNyB3aGVuIHlvdSBmaXggaXQgc28gd2UgYWxsDQprbm93
Li4uDQoNCi1jaw0KDQo=
