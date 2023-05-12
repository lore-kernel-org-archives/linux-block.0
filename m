Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B3C7EE22
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 01:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjELBTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 21:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 21:19:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C01D59F1
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 18:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKqTezCyER36xO2KMAUie6JyUgogUwPAvWY4SeXlkK9GNFE8Lnkld8fcnzR8D24r40S6Q7j8EnGp0JdcFzh8xmOhLAKbhJRcyYCcIw3/gXGC5q8NI3VCd7fINfqNqVW6rqsCwIT94Y4lk5MRFn3v1nr8xTboBW8XjYeWLCuchDm9HHirsf2URsF8j/Qh2X+MZy7kiNHyx5303ss5cJuIprRj6iSLD4HRVa1UKOJTGQuG76LMKG4/wEKPkJEciBbEDrk1BTxBEA57yhOdiXO4hv4gnwPaPNGrOwgmwbxLvtEu67+jTBHaTO98+JIDKYTws6zIseL7cGMOfyJZJbqPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DluW6xjprWqr45J77tSDT+PcfNlANsvificjwtuheIo=;
 b=PidYR91e4lfBaqIWI7HvgqKw8bE15QMpd1ycnpRspgLzL2dd6Eem5eVPE3Wzv/vPteVwX8WlyA70xMLlWA/2c0j4NjkJ8lejb9PoP6ry9e/QvqHbSnTWyiV9zm3HWwpGq9uuV+/nkT6cqn9kLornKFsgLfs/brLt4RKG4nNNz/Xora0TFlIJs7DX041AjN8e4u9KdSN+PRIYIDHglVUKFhkuBhU5NIisSJlkQLmmKBtVblipxybUtqMs/j5D4f9JApBZCFm4cy7t/zNLRXjB16jH5Nko0gcYDFHzuCE169TzYuLYBK8VUhTBcKTrmbLmnNCL9IWsvjiNgKdVvdnPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DluW6xjprWqr45J77tSDT+PcfNlANsvificjwtuheIo=;
 b=sxe+ay7FNVZu/AVBWPkUXKWlmnTyZ/sJEReOGKqrYLwYy58MFWJEDVdCCUNLYqZ1Uw8tu/HtiKBM/AO4kS97RupleW25/MPfO4SvzBYUoygfSFHPZKqKrq76rEvQwiuZGWvtTjuc7x3i761TgPnfLZ6Prl+X3nR5ighAB70Ap9ELGMD9zZVR27XFkfay6Ooh3I+t4wtg2iPtKMk5DkDypQvTMmbbrBdzmO0MDnUahZhxzp1OL5SFh+SDf88XUtXeTKMp1c2CbRGX5OwB34P5QWBVVs39gCg/MHI9W7q8JqVAJjP32yozxwS8p7RjdSVvf3Z/OVHrJETzRyuE34Q11g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 01:19:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 01:19:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Thread-Topic: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Thread-Index: AQHZhAM6arOvckiW302hDIuLZU+lkq9V15gA
Date:   Fri, 12 May 2023 01:19:34 +0000
Message-ID: <bf2daf76-ebfd-8ca2-0e40-362bcaecfc3f@nvidia.com>
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
 <20230511121544.111648-1-p.raghav@samsung.com>
In-Reply-To: <20230511121544.111648-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB8256:EE_
x-ms-office365-filtering-correlation-id: 1bb8c577-36c1-4d2d-352c-08db5286f25e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nGB3nd5VoTvrDgGUvIvdwZQSyjmibUIHp41BauRQoJlmX/Dwq45d1WNv4Soslx0ZA96xgefX4bNnXXcAzdmia0dj3x/uVM/Ai0Jev/pA+RK9iHiCUB60WwqJjFap56pasD6HZaytpwbuoQA9XwUWo929AGkqur1v0wgxeqTrg1sLn7ykezAQQ2bszUFf7FzfD1AvHDwrQlwIL/SCs1TlgIKUhWrJjkMNk8O/HPHDcwnuNQJEPUXSVAvLYFOjmZ3KEDL3IIIevTIaH+vhWIGiFbW47MfDTvQ/5lsYf0XkBy5NRb2glvqsipGhoNuwT30IERo6wmrsu8acv7NLZ+TQywHn6e5kqlafP5N3S2Ipfwk5dluodia5O6eZQF/qEWCj0viJnlE/m5TAI4Wa9Y1RYRec2EtZIthxFlObmMqcSa5dJtZJT2z9ba/uqXfoLwHOqJR+XMSrs4862Sc+JTUfMQjiHFTaFQ/KfW583RyCpvnutlbqMNBfK3SxgslFgF1vtTzD6laZH90AHsDpIRqulI7t6JFUIbcmMx3tx9WzWmHluam94oSmRBHwc5FNxTC3AqY6/qyeb6rPD211LgTf5PWae9mGeMk5cyEO5cPVui+gpd2pznPLHSXdL3jnJY+L5hyic4+bNzKvw2u5ga6Iyas/WNzva6leH4xt/lSEDn6SfdSiStNDGNNN54i6sYZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(4326008)(66476007)(66556008)(66446008)(76116006)(66946007)(91956017)(6486002)(54906003)(110136005)(478600001)(8936002)(8676002)(316002)(41300700001)(38070700005)(31686004)(31696002)(64756008)(86362001)(36756003)(38100700002)(122000001)(2616005)(6512007)(6506007)(186003)(83380400001)(53546011)(5660300002)(71200400001)(4744005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b09GUUkzaEhaanZJeTN1Sldlc1QrUFppY0dIK1J5VWhQcGRhR3h0bytKQnpk?=
 =?utf-8?B?c2xnWThwQWlWTVVLUWRVKy9BdzdsNS9zbFpxWExKaVJSTDhva29JcUI3SzFo?=
 =?utf-8?B?WG13M1ZmdnIzNDFqbGdRa0JKUUNBcWplblg5eTJoNXUrS2VhMnBVQ3d3ekVp?=
 =?utf-8?B?TUpONy9KR0ZZYjFEVkVENEZzTGVBWlhHTjB3YjFQL21sL2F1NHgrUUsyaVQ4?=
 =?utf-8?B?SW9RemJmbk0rRHVLVTRrdFJvMWpPaTZod3Z1TTFRaU9nZ05oYTJDZVJ5bjhJ?=
 =?utf-8?B?WTZQTEJQei9hNVZtaFVsTWdBWFVuQTVHNGE1dWpNOE4vRlZGQ0xmZ1hzQmxw?=
 =?utf-8?B?aUw0a1U3ZllWRFZ2cjlNQWU5KzI3QkFWOTd3MmJwUS9HdVNxcENPVm9hT2pS?=
 =?utf-8?B?R1JySCtsbEcyaGZwMlJ0MGpwVXdPdE1PWlVqT1VubnpGTmovWnMrd1pmbE9R?=
 =?utf-8?B?MXV2UzBXV0lleEJoclQzbzNScHFDVEdvVzFkcklhSnhnU01uNkVxUkJBVEZx?=
 =?utf-8?B?bXd5M2JtNFZvZ255cEUvK2xhWkhOdzlUZVdBZlgrdHd2L3B6cTZicmtycGto?=
 =?utf-8?B?UjJCRThQNXRzNjJFalR3QUhTcjVNMnVSYW9tMXhCSkw1RERua1g5RGQvSUJW?=
 =?utf-8?B?ZmthZTlKd2N1cWp5eE16SmV5N0ZDVmJCbTRva0xiRjdHRmN1TnAxWkJ3MVYw?=
 =?utf-8?B?TGppV2lGMWlNTHgrYVdqRCs1dnZJUWJIdTB5RHV1b09NTW9nQWpYNTFnRnNi?=
 =?utf-8?B?bkdXMmJYSitnNElxN0NJTklaNFZpV1dFdkRsT0N6a21OSHA3UnBVVjZ5R1lj?=
 =?utf-8?B?KzFPK1NBc0duUXdiN3Jvd1pzaHF6d3JBTlhQOHpUdlNJdGdNbk8zbkdHc3kr?=
 =?utf-8?B?bkJKU0YzeDBnK29IS2ZwOVJYSUFMSzV4eWh4c3JRbGs2VHlvSWRPMTdqM3cz?=
 =?utf-8?B?RUNmVUxISGVnSGNsUWlHcFBiTzh3VVdHVFJhNXdweWIrbjRPNm1YMXE1Nm50?=
 =?utf-8?B?bE42dlBudWFORXpDMUVOWk55SEs5akd2aGVTZ2VzcFQ0NzVLOEI0cmNwdkxx?=
 =?utf-8?B?M3ljdm9rbmRkbldDWjIrZEZjbkQ4SS9rQzU0ZEIrYXIvNnh3MnpkU2dBNWJv?=
 =?utf-8?B?MklyVlc4RkU1T1NSSC8yR0cwVVF5Und5UXI2SDNtbEd5Wk5nVzZHbCtDS2lY?=
 =?utf-8?B?cnN6QmhNcWxQdGtSSUdUbVovUUk0eWljWXZxWnFEYVJoQjNLSy9iTzJPVFlQ?=
 =?utf-8?B?a1FVSFNqbGFaNHM1RVpnWWYxVCtnN3Q0anpoSStrZEZRNXRFQjYzNXI1U1hM?=
 =?utf-8?B?c3NmYTVwR1BRQmdVZjBSRFZvZE5jZzVYSDFBaU94aWd2RVZicUhYZkVuM1Ja?=
 =?utf-8?B?bkp5Y3ZFMFEwYjFxakpkaDdBRFpMdWE3V0VUSCtXaEFMa05iWUk0YlJhZzQ2?=
 =?utf-8?B?KzljV0RPd0dYb2lYb0pnTnhEUVRjT04wOXBjcTA5VkM4S0J5bUo5UG1EYXBB?=
 =?utf-8?B?SUxxQXducWloSWxjNkY2KzFIT1VsRlZKVVNqanovYkhhbnZuczNQM0UveTF1?=
 =?utf-8?B?QUhPY2NlQ09naEp3aTZwME9oK1F4TEEyUHVFTUpsMWRlOFJSWVJPamFyZDE5?=
 =?utf-8?B?N00yL2JkRGNpS3hJT01XSEpLVE4rU0pzRWpMdDFqdFJWS0R2aWxleHlGMnJp?=
 =?utf-8?B?b243V1hleU4rRXZjMUpuUzZYcnE5NDZtNG1XUy9icmQ2dlZpMkVIUVlRTUFV?=
 =?utf-8?B?VXlOQ1hLU1A3N1AzeHUwWDFWMnJtaThuOVdYbUxadE03Q0RyS1pQdnJMSllC?=
 =?utf-8?B?VUhrYjMwWks0dFZSNXhmeGs3SXd2UmdubzdlWEpieFBVeFNHSkpMMnZkNnVI?=
 =?utf-8?B?cnRsR25QSkFSdzhpSXI0UGVJZlBCb1FYTDYrMzRZNXF1V2hqWXZPSWQrU1NM?=
 =?utf-8?B?L2o0LzNTekR0MVFOTU1xNG82QUdaK3VRWFI5ZDNMdWExUkZyVzR4Z2g4dTVx?=
 =?utf-8?B?SGZmcnNGNEsxSGkzRVNNWmhWclh0WlRMTEVMUXRwajRrUEtmZUZkRW91a2Nn?=
 =?utf-8?B?Q2pxVDRzVk0rNSt6YmJWUDdSMFVlSmxHclZmMEdPekRiamc0YTJrZ3ZMc0Ni?=
 =?utf-8?B?b2llWk00cXQ0Z1ViVytJS1lDM0RSd29ITmI3dmFrclNIajh4M01mTHdFaUJN?=
 =?utf-8?Q?EWQdHNiEe6PTxpIMnYk6GWGoPkTxZ2d9gnCYv4DP+TcK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09D1901836C2B640AAE97518153B4B61@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb8c577-36c1-4d2d-352c-08db5286f25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 01:19:34.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUf2/F1p7Y9u7/q7tZV2yre6aENR70X/obce/5hHJLQdVcgzI73r5F7+/YIvS5W/iL5pmy3AWRd0s03R+Ye49w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMS8yMyAwNToxNSwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4gWEFycmF5IHdhcyBpbnRy
b2R1Y2VkIHRvIGhvbGQgbGFyZ2UgYXJyYXkgb2YgcG9pbnRlcnMgd2l0aCBhIHNpbXBsZSBBUEku
DQo+IFhBcnJheSBBUEkgYWxzbyBwcm92aWRlcyBhcnJheSBzZW1hbnRpY3Mgd2hpY2ggc2ltcGxp
ZmllcyB0aGUgd2F5IHdlIHN0b3JlDQo+IGFuZCBhY2Nlc3MgdGhlIGJhY2tpbmcgcGFnZXMsIGFu
ZCB0aGUgY29kZSBiZWNvbWVzIHNpZ25pZmljYW50bHkgZWFzaWVyDQo+IHRvIHVuZGVyc3RhbmQu
DQo+DQo+IE5vIHBlcmZvcm1hbmNlIGRpZmZlcmVuY2Ugd2FzIG5vdGljZWQgYmV0d2VlbiB0aGUg
dHdvIGltcGxlbWVudGF0aW9uDQo+IHVzaW5nIGZpbyB3aXRoIGRpcmVjdD0xIFsxXS4NCj4NCj4g
WzFdIFBlcmZvcm1hbmNlIGluIEtJT1BTOg0KPg0KPiAgICAgICAgICAgIHwgIHJhZGl4LXRyZWUg
fCAgICBYQXJyYXkgIHwgICBEaWZmDQo+ICAgICAgICAgICAgfCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgfA0KPiB3cml0ZSAgICAgfCAgICAzMTUgICAgICB8ICAgICAzMTMgICAgfCAgIC0wLjYl
DQo+IHJhbmR3cml0ZSB8ICAgIDI4NiAgICAgIHwgICAgIDI5MCAgICB8ICAgKzEuMyUNCj4gcmVh
ZCAgICAgIHwgICAgMzMwICAgICAgfCAgICAgMzM1ICAgIHwgICArMS41JQ0KPiByYW5kcmVhZCAg
fCAgICAzMDkgICAgICB8ICAgICAzMTIgICAgfCAgICswLjklDQo+DQoNCkkndmUgZmV3IGNvbmNl
cm5zLCBjYW4geW91IHBsZWFzZSBzaGFyZSB0aGUgZmlvIGpvYnMgdGhhdA0KaGF2ZSB1c2VkIHRv
IGdhdGhlciB0aGlzIGRhdGEgPyBJIHdhbnQgdG8gdGVzdCBpdCBvbiBteQ0Kc2V0dXAgaW4gb3Jk
ZXIgdG8gcHJvdmlkZSB0ZXN0ZWQtYnkgdGFnLg0KDQphbHNvLCBwbGVhc2Ugd2FpdCB1bnRpbCBJ
IGZpbmlzaCBteSB0ZXN0aW5nIHRvIGFwcGx5IHRoaXMNCnBhdGNoIC4uDQoNCi1jaw0KDQoNCg==
