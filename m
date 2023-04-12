Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0946DC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 08:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDLIJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDLIJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 04:09:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1561B5
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 01:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR7Su6O+33Nd1WHvGnPGyGWOb3qjsScBQetDOMkAdVlQ1iN77cTBR5dDrlZPvS0DKiYMPAGsp0+mXL4YLhWE5K0qsh+HhJW16PX0hfYVDKZ2MbX832Ew/MAFy5wshpilZIuT8trrVygpSk/QCW13RnLYKLxElHxrgrF7b8MfOGxQ2vMFIUsLewyjqlXqfaY9FFx1CPdjQTCpicA0iVOkd5NGal0sKTEHd8AekljQggUnU1obQ/wN7X5yGIpxhw2oHt5rogmIe9ast3M4jtOpFGcnI7aqeDLWkd5jxR2wIKVqabJwLQtRQHCfuMjFbMGt9QUk/F/WH9wOexVweYVXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzoVXian8pjNPlzp0vhCM+OB48YQTTayBT8YhHMYZ8k=;
 b=jAvrXk6aqr1PALS1QQ3j4Dl42UjJDwItKH3UuEtQc8Zmh1Sl5bUHwe1VmhgvnMZqRcE/zUd8vxLebEBMVtllwhQW8XG+oPnbXirzlQDFbON7MQD6n4n+u2OeA7HA2TzglWvtLiw9rj61oOq9vpQNDkuAtQb9fT27TCzVtA+M3HAfycyIYK1v7Pg+ieuEnrH8kbscemu8k/hSQ2RQB7W/0ekynalBaEKUSWtWHi2aL4GjHI1ennwuo5kpukypVMUAJcs89saPnbyXv85qucL38u+od4s9wcU8i+vCLIF5PShBurjZ96brdFHXYUB5ByAhuscoRAyvZh0lfmruqB2Hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzoVXian8pjNPlzp0vhCM+OB48YQTTayBT8YhHMYZ8k=;
 b=k9bIHIadt5iCz0tgLMuO+r/j09vZxzCoZI9jHXZ4nvjrnqT7B5ytwmpUKstiZ3Sy2wPNPHderSb22JsgIXy9zxsXEDOClduKS2yuytSe879IFOGzmUM28qFIOmJcy2pA1uWLDu03cc+0uFl0jROSGi+ENemGPNQkqyGCos73dAWDPNeLfqtnOqh7hUKELWrN6ZhdE97/cnsoyPuWCxG93YYDuc2pC8NojrWadYwundIU6iQwSogM4iD/PcLuY02ZpAGs2Ms5TPo24zJrPSKuoGhftYR9GsD+V/hcwrj5BM3gfEE5D47JJSyjazC4oFfHdbOWPmROL1px62ZidMFOSQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 08:09:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 08:09:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "error27@gmail.com" <error27@gmail.com>
Subject: Re: [PATCH] null_blk: fix queue mode Oops for membacked
Thread-Topic: [PATCH] null_blk: fix queue mode Oops for membacked
Thread-Index: AQHZbPR8kNoMvVp34Ey+RDJEhoKaG68nTuaAgAADX4A=
Date:   Wed, 12 Apr 2023 08:09:23 +0000
Message-ID: <2c816171-c9ac-7608-56dc-60e4b711841a@nvidia.com>
References: <20230412040827.8082-1-kch@nvidia.com>
 <824e2454-14d8-35b8-bfdb-ae26df255003@kernel.org>
In-Reply-To: <824e2454-14d8-35b8-bfdb-ae26df255003@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5885:EE_
x-ms-office365-filtering-correlation-id: 7a689353-314b-4b51-83b4-08db3b2d3a49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dz5ALKKwVtyXjQGNchTSlfENCacW8NZl6wrT2dfZmR+1ueq+CLXxVEJyJinJ899BjaU7DuHKpflv7bWQOla0wlBHFEtPUVOpcseezMYixia/KVt83onDGWISJHqqaNN7nfTmt+596TxFM2HNMtp8CxifE7aFybz0q45vRooxcqwDbNazc6ebo2auy8pnlON7T52Eln+MkmU/YMiNuxi2AxYp0gZuyYGdvEOSZWsobD76463iAP52yp27QJeeYzZ7CdAL071XoBAE4P8LnS+oEvIAL4tCDk9iTYhe1rdOb+m6FgEib4FO1csLSbZFHDeaSSjJOO2wBfCIT/5GdtPiiCZtllO6Uz0I7vLnm/vb38IkRE1D96pO1rJOpdV7oR1kXhxgs43XR4KtSifdB/HxsEDu1yTM5w9kxrKaG881F5xoTe3Ze+Itzzelp2kG0SnzDNMiS4W3AjnKhM7bUu2RCPkmtQALdxJ6bxSXY7bYm5Ot5EHR0c0GuQ97G20TTsGMBBGJG33VThtDJTeb38VUKiMZ3PIeeUWKx/yNW/3fZOb9ltLbNPc+xwBfrKlV/OFYYSFtUctaRCPYcNFajocKlwMmc3b8/cXCqKSn5atcizng3w2At4Odkd6G3ENAl5VlgBZEy3T0hnZA57C0JWisVWe+JS5i+nUO/rbi6cXQEBtGGEyjx1NdlGklWLOa8DGF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(36756003)(38070700005)(2906002)(4744005)(38100700002)(5660300002)(8936002)(8676002)(86362001)(31696002)(6512007)(71200400001)(6486002)(6506007)(83380400001)(110136005)(54906003)(478600001)(122000001)(2616005)(53546011)(186003)(31686004)(66946007)(91956017)(76116006)(41300700001)(66476007)(4326008)(66446008)(316002)(66556008)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckdBWmNOcWlmT0tmTENCTlNhQXR0c3JqNjNCNWQrYXovZXpSdEJUMktjOVpI?=
 =?utf-8?B?M0pPUmJJdVhwdDJYcTlwZFc3TzlFRkxEcVJrUFJzd1VXYUUwR3F5ZUZxbGZE?=
 =?utf-8?B?eGFPUy9vS1FrK0JlNWVGYUQxMmhEb1YrL2VFR0RidnlUbzhSQUxxNCt3b3l3?=
 =?utf-8?B?UDZLZUxCOE9HVTNZeWhRMHh5aGtyWFJicDZjQmYxMUhFdndFbmNKS3pBdWwv?=
 =?utf-8?B?a2dVWitYbWNKRDg5YUs2bG5MTThBUFNmT1VaYkN1OTYzU25UVEJhdVNLYkdQ?=
 =?utf-8?B?KzR5b2xid21hYVF4VS9NOUpmaDNlbWYxSGVUTE9qdlBCQ0p6SHZvcGxIaHB4?=
 =?utf-8?B?Z1BGcHRPczUzYkpWSm85YUliUFdxcmpOMmxUYVpZd3hmQmRqYXMzOFRPMnhj?=
 =?utf-8?B?SS9nUEFvU0VQTkVLemtyanM0RmdoYWdJbGs4c3ZYY1hvMVBOQ0J2UVkrZ2lx?=
 =?utf-8?B?ZFBsMTMzUUh6eXQ0Y3kzZlFDVlFXN0ZCakhzY0NTSndaK3lPN1VaUGpXY0dT?=
 =?utf-8?B?Tlg3Q1VnYUs1eksyUUZGc2RncmRJU2dNNVBIS1plbVp2TVV0a2RJMWhjRmh4?=
 =?utf-8?B?TGRXaHpTZWY3N1FCcEhpUXB6TjVpUnFIQnBtYWV3NVk1SlEwTjVITVBGUHEr?=
 =?utf-8?B?d1V1eGd2TXBRdkhmeThwblNoNVdhV240UExiTllJcGtFbHR4bDl3TFFKc2dZ?=
 =?utf-8?B?c0tvSU9jcFc0N1ZmNmpFdmc1Nmpoek9heWFzakhROVN6NWNnY3V3Q3U2L253?=
 =?utf-8?B?SDZXNVJ3bWw1VmxEOTFwQlR2cEpmaXBwcmhkZE5YYUdjcExvVGV4UllyUzlJ?=
 =?utf-8?B?WUpHaUN1NSt6QVMwWHl0MDJsNlg2d2hZbUVJU0NiMEJ4V0IwMURvMjlCUURX?=
 =?utf-8?B?RUZGRXJ3eVVqMEYxYmhGb1IrNXNGYU5NWS9zVlZCRXA3NlhuaWNDSVJsNG1W?=
 =?utf-8?B?eGlVNGUrMFlSTnFOZ1hKZGJXYXZ1Y2FSQmE2ZHJkSnRrMFp2aUZQOUZFWTJ0?=
 =?utf-8?B?MXczblNRMlBEOVZ1THl5QnpJOGJNVGluNGtzL3RGUStLWGhCb1JJZ09KNUxu?=
 =?utf-8?B?bXRONDB5dGgwY0FZV2p5Zkt2citlZXlwY2labUhMVys3bzVUZ2hGZkU2VSts?=
 =?utf-8?B?aE9KR0l2dU04dHpwWXViVVN1UVp3TFp1TC9wUGxZbnhWRS9aMXU1NU1RajNj?=
 =?utf-8?B?eFg3Z0R6Z25zUFFKRDdUOXBSTFY3ZU0vUDFPUTg1aDROZGgwYkJxcDliYVlz?=
 =?utf-8?B?cno4ZmNrYnRSaUhFeVRhRFcwc1RuMFRoUk8rVUl2MXgrb3dnQXoxU2Z6eFdP?=
 =?utf-8?B?N09wNGhzVC9xT2FsUEkrb2ZTQmZlN3BrUk5XYno5a2pUYTF6TklibkZ4R0Ja?=
 =?utf-8?B?V0UyRFFTTFFVbXQycGU2RTFnbnVaNjhKd0l3RGRvdnZHNXZoQmNOYm1qZHB5?=
 =?utf-8?B?ejM5UFI0U1U1dzJjYW9Pc0NFWnRqMUdjNTZzUVd5WWlLYmVHUWo5emhrZ002?=
 =?utf-8?B?b0ZTSEppRExhc1pTbUlWYVpHRzViTkEvTG80OUdnNFRQaGhMSXR6MjFvUkRq?=
 =?utf-8?B?b3U5V1RzT3dtcDFpUHE3b2hQdVdWUGw5TE9NTjlWVDE1QmVIN1dRWnhIWHJD?=
 =?utf-8?B?UmVMS1BtbE84WG9CNDdleVFrejNGaitoOTl0UllLU1Y2MXpZS21kOTE3ZUR3?=
 =?utf-8?B?dDIvaUxYYk1MdnF6WVRKUVJ4ZjJiMU9Ud3ZHWU4vaXdPOFVWdDlnTWRCWHFW?=
 =?utf-8?B?RXdSZ3NDKy9lcFNUOGFReVlGbk55OEU0QklmMjZRSWxSbGVPZ1l1bVRaa3FH?=
 =?utf-8?B?UXlHNEZvMUJGenhRdWxJWVo0RFlIRlM1dEpHK1V3cXRLc3c0L1MrWnFiS3o0?=
 =?utf-8?B?a2JrczJFM2hXOEFvMmQrd0ZoSGVuMTIzL1lVNHAyY0FTMkx1cEIvblJyNC93?=
 =?utf-8?B?UDRWcFk2eGlkdEJaR2ZCQ2VzbVJkL291MHJTUFIxYlhyUVhZWkhtSFVEa0Mx?=
 =?utf-8?B?KysyNFhrbWk4MytkelNCWkhYK1lEVU10WWUwTHp2R0ZOakZVRXZwSFRmQWVh?=
 =?utf-8?B?Q0NnbExOTjVVZC9mOGdTcmFRdFY3VW5ZKzJnMGZsdTVGM05ITVNPbWd1Uzlx?=
 =?utf-8?B?QzRaajV3QTR0QkkxY0E1amhWbGZ1K25wVlRTU0g1dTV1dUNGYWZVY0tyTkdW?=
 =?utf-8?Q?fbQTF0RAJi6/7ZnppJT2TcqO4LOyT3Kzk2rTpKLeqwKz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AABE983CBA740D43A73FFE63BC8DC771@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a689353-314b-4b51-83b4-08db3b2d3a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 08:09:24.0036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAOO4fDgH/JGe7c2y/7YnwSnSlfv2V1KmONfTMcmCfUPqmcOKZ1ZrUBEMpEvRkdqejpU9i80LPNDxcq3VVy9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xMi8yMyAwMDo1NywgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDQvMTIvMjMgMTM6
MDgsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IE1ha2Ugc3VyZSB0byBjaGVjayBkZXZp
Y2UgcXVldWUgbW9kZSBpbiB0aGUgbnVsbF92YWxpZGF0ZV9jb25mKCkNCj4+IGFuZCByZXR1cm4g
ZXJyb3IgZm9yIE5VTExfUV9SUSBhcyB3ZSBkb24ndCBhbGxvdyBsZWdhY3kgSS9PIHBhdGgsDQo+
PiB3aXRob3V0IHRoaXMgcGF0Y2ggd2UgZ2V0IE9PUHMgd2hlbiBxdWV1ZSBtb2RlIGlzIHNldCB0
byAxIGZyb20NCj4+IGNvbmZpZ2ZzLCBmb2xsb3dpbmcgYXJlIHJlcHJvIHN0ZXBzIDotDQo+IExv
b2tzIE9LIGJ1dCB0aGUgcGF0Y2ggdGl0bGUgaXMgYSBsaXR0bGUgb2RkIGFzIEkgZG8gbm90IHNl
ZSB3aGF0IG1lbW9yeSBiYWNraW5nDQo+IGhhcyB0byBkbyB3aXRoIGNoZWNraW5nIHRoZSBjb3Jy
ZWN0bmVzcyBvZiBxdWV1ZV9tb2RlLiBTbyB3aGF0IGFib3V0IHNvbWV0aGluZyBsaWtlOg0KPg0K
PiBudWxsX2JsazogQWx3YXlzIGNoZWNrIHF1ZXVlIG1vZGUgc2V0dGluZyBmcm9tIGNvbmZpZ2Zz
DQoNCmFncmVlLi4NCg0KPiBmb3IgdGhlIHBhdGNoIHRpdGxlID8NCj4NCj4gV2l0aCB0aGF0IGZp
eGVkLA0KPg0KPiBSZXZpZXdlZC1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9y
Zz4NCj4NCj4NCj4NCg0Kd2lsbCBzZW5kIGEgdjIgd2l0aCB0aGF0IGZpeCB3aXRoIHlvdXIgcmV2
aWV3IHRhZywgdGhhbmtzIGZvciB0aGUNCnJldmlldy4NCg0KLWNrDQoNCg0K
