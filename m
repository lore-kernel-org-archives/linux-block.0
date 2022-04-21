Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20405C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 21:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347325AbiDUV7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDUV7U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 17:59:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F6B4D27D
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 14:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXnRFgIQ1L/p0VuPmuMB3IAfLFpE17tY4lQwSejdgFm6U1cY18LfJrDWzEoV0ecrys03j5aoufezVFUnxUoKUSgNm8hYTOxGBT8djymwRMFLMylz+Z5JZEMhDeOEmSFes0BLCkPVEGlBL871K90wrr1sGLrkHp++ngbSPNefxRQJrfd9odmziMhtYv9jf2PjL9lYj+x5dN/4kD794bkqwDg99cAOyFQoYdoVWdq6Bssl9w7O+lZOCEdWpOiNq4ttr9m4HVr6wzAoy5uNBzoaWueZBzaUsmDQpPTRZgmw+35GINGF8U3Z4BL4UsL/e7MsAHiGzp33ld07Z5XshsELxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxMQ3Fma46v0uudrsRJQ3Chnxr8Udcp6S4YmQ3KJq9A=;
 b=R2KFTFBBjHPnOzcf5myvbdZl2SqaqaRQDV+RZosMvkLw8kYm/4WQTd/Ou1M4tMH8WDY6yLRlYnuYwDJ7sZmRoknPDaqm4ZR5E3zTDm7YuFRQwGWisXK/CyLKRNOjciBYsPw2R+WuuTG8arpvv3lwEVe8+43CHAAWNofQBnpWim2kOiwhfyp7PgEwE8wmInm1nlpbWHIffiOtIE3mA+2iUJg4CPDZZj8OOmPHvhNyw8VsbsG8udqSeljQPRmmgtGccS0UBCXG8fKRsLAhM0dREestPZXPcBgRhNdpMr/HjnMZ2TuSpg8Dn4pDAhD268280uiTTfcGozq/GbZ+gXZ37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxMQ3Fma46v0uudrsRJQ3Chnxr8Udcp6S4YmQ3KJq9A=;
 b=KrVPaIx5+J/rQe6AuSfrd3k8jSvsksXeHjNLKXXWlzFMSb3hO2gjNQ7VWrbTT6qXEqLvo5lkQq4YSv/RZtB9otiffWlt8uEKfUUIhcS6bkZOxVWNSf11e0LXGq7ly3Bcwc+p7XH4WFpV/6H+4dmQtJ9enEewVNba9YcfwiPHynnGCMc0EO1NPnJQMM//w8vGCBXUfY8vXPlPxF/jdwlSET/iXBtnnM+MNP9GFfr28oefEEiN21wdnO6ZOiegzwsSsHaef2ULaqBTE1lFb4HUGYiKfuYVBxEyk5BJGFqH5ZEq0XaJEFofHPBl2kCNGz7ry2pS1Ojdv9ptz4V9rx3D5w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 21:56:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 21:56:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "stefanha@redhat.com" <stefanha@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH 0/4] virtio-blk: small cleanup
Thread-Topic: [PATCH 0/4] virtio-blk: small cleanup
Thread-Index: AQHYVGyptnVZeDje0Ee2zKGOBbl9aaz67HOA
Date:   Thu, 21 Apr 2022 21:56:28 +0000
Message-ID: <6c21dd2d-830a-8842-428e-6fc60966b73e@nvidia.com>
References: <20220420041053.7927-1-kch@nvidia.com>
In-Reply-To: <20220420041053.7927-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aed7e947-f1d0-4553-62e1-08da23e1c978
x-ms-traffictypediagnostic: MWHPR12MB1280:EE_
x-microsoft-antispam-prvs: <MWHPR12MB12807F950B9958A970F862E3A3F49@MWHPR12MB1280.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0BqsRfPnaEjZPS1vpL0NMk/ITPS5tsPSuLRSsmr+BkKb+/m2JpmnP4TcpAoyHM3sbH2yzM5A4tO5VQgusEG3gGWppKViLqH/jWiXcVCMnC5qKpikGAc3InL58XW4o3TmZBbXjzfcUrSdldWm1zHXBS7vP3M0fSiVSjArYS2aYTbDZjgii3EctWYh9cn2jNfftFg8dmyJwoZJ1rlEjAJrmGNSvujru2SPbo8iGL6h3x2SoAGsoJgE2o73MsANSyQSEsgzykpC8CjV7YCuBGZ0tx7Z7WsKtfRXis4Yykhj/EX4wTUzXbNPraDXFr8q/D+AZpoluHPgs6+s8T1ekwvGHpq+Dp3b3WU1qT2LMg6bj4QI2EuTeaK7qKuufl6ehbJg/FImcvLBBTrC1+94O28oEtgIR1SJCaMOG3as2rr06MFFBW/zBDffRV3e6dcK4FdBajBn7JnE1rzyqvrnrbtJRLPiGjEONFUIy6GVEqju1HdYwlJo6qWFxbjzbj3Y6QVZ8352QPg6tEMnkB+7g30ar+GxUnFWDEcJP3uU/P0JNfW6gEimnkj3DagqIqefrHN73S92UlhEmmZwuLya0XRVFb0ZRI7On2tcCn/EL62CNU1hvUpa8VzvRa66JrwnnmpkYiKR1tOZ4SStUAu2WXzmfVl1reMFAMr+BU9uwYTELqnRSkKtpcWtIWrfzluqi9+jdGwovAiFId9GBuB3oJ2g84RjmyqXkKdhS5Y35K/JdvzFuzyEjX8pxQ/HRsaHxPEZMRLLth3LmgR5BOEvQLeZRci1X99Vd0dLvTWybr+4rUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2616005)(508600001)(6512007)(6486002)(71200400001)(26005)(4326008)(53546011)(2906002)(6506007)(83380400001)(122000001)(38070700005)(38100700002)(76116006)(66556008)(64756008)(66476007)(31686004)(66946007)(66446008)(8676002)(91956017)(86362001)(54906003)(4744005)(5660300002)(31696002)(316002)(36756003)(8936002)(6916009)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NQWmpzMHE0Z1daWUlGZ3Jqckg0MTVrbmdFenpkTk52OU5ZK1dQWldZcjNv?=
 =?utf-8?B?cG9aTUZoYXRINVI4UkRqZmt4VEtLcjZlUDJVcXlQRXlKS1NFTVR2RURjMmVZ?=
 =?utf-8?B?OHg5RXJsaDUyTlA1QWhDcHZTTE13NWtBcXByM29WdFNQd09HRm5TektrdUNO?=
 =?utf-8?B?aXUxN3BiSzR4emNublp5QkdSYzVGSS9DOEE0aVVpY3Q0aFhDTmtpa0tVMm1m?=
 =?utf-8?B?ZTBJL0xQMXNNa3ZyZldNY2JSS1JOK3ZDcStwaGp0NlNrWCtVN3ljZ1NJU1Qx?=
 =?utf-8?B?ZWplNFZ4R2NVVWJhcTJqL3ZoNXgxNmlHdEhjcG0rVmxtREpBZWNQL2FuNGNG?=
 =?utf-8?B?L1R4Y2J1THNDMFYwbTMraTNyVTVUT2M3Y0JtSkFZWEg0RTV4U3dUQlZTbCsx?=
 =?utf-8?B?MFM4Qk51UVpUREh0UFcrK0drV2tkTXdxUHFyV2Nqekt5NlFTMm9WU0wxNEtN?=
 =?utf-8?B?U2FheVNxdDRWUjgyVlVpR3pza1BVN200WFNZTFZMRDRQWEx3MG44S2lrbkVa?=
 =?utf-8?B?MkhLeGJxSTJlMFRPOGkwOTF2Wm5BMUlIekxURGUwSC96VWt6K0ZCSTNXd3l2?=
 =?utf-8?B?eDVXLzNyQUdleGtIakRmYmFkV1VXZXB4U1UzY2YwSHJWUFQwS0dmZEZNRGV1?=
 =?utf-8?B?cm5xYktGaUg5U2lLeEtDdXlOaGFwRjljTGFXcW9SS2xxV2I2WmZtak5TOE5y?=
 =?utf-8?B?ZjBZS1dWU1d5dXBhSFAzMUN6aTZwWGI2MlZPUEdpWTd4ZUp6QVB5ZlU2RjVv?=
 =?utf-8?B?VlZWakNvZXRTeXdZWksrRkUvcUlCWlpsTWlUSVJ5Y1lIZnlkMCtxeUNBMGEv?=
 =?utf-8?B?Qmp3UXJMV1VEV2thK2VVbW1oSWFPU01kUG9CYWtod2JtUlduQmt0cFNqS28r?=
 =?utf-8?B?WkEveXREZktZQURXQjJiMTFJbzhObEs0eUoyd0NtS2p6UmVJR2ZGWG04YThp?=
 =?utf-8?B?dlF3NGZ6ZVorWHl0cnJSdXo5U2lHS0N5MlN1SnBsdVYzdFBqQkdDZmN6STVp?=
 =?utf-8?B?bkJWQzdsVWV3MUZac3pBMmNVVTZHRHhHKytoV3M0WjlwNFdZMS94SlIxMHZN?=
 =?utf-8?B?UmN4Tm0wWVduQk5qV2cxK0RDSlFoMmdvckRhR3pVTXhxc2swZGsxWFRwTHNM?=
 =?utf-8?B?L2QxRFd2NXk1MDZ6UzBjb1NHNUtNSytGRVYwcm9TOWZlSnpjeGVqN01oanMx?=
 =?utf-8?B?UkRYNGc5UW9jRnVkT2MzNU52Ulh2R2Y0VWxqdkFUQ3ZEWjdOTDJ1U0lRVlRK?=
 =?utf-8?B?TzFDaDlPVFdOY0JJUG1sL1NJbXNHeGc0R1htUmdlZzN4V282TklrT3pWcUcv?=
 =?utf-8?B?Sm92aktabWxWYUZsakRReEk4Rm9EZjUwSW5Qa0dFbW9jbVNpUUlMTk1nMEs2?=
 =?utf-8?B?Zi9TN3hydVJLMmJGWlRhZ2lNVkZJTTVQeDZkZVNHdWFMOGJqa3Z1a0Uxd2lO?=
 =?utf-8?B?T0lReUdTMVQzMHhGT2J0VGJDelRVaVcxelhSZ0xwN0tpTS9WaUR1cHZXRkla?=
 =?utf-8?B?WDFqQjYyYVBQQVFUZWMyRE1Da2VmREdrSmRFMk9YWG5GUS9lMktOY0l1ckxw?=
 =?utf-8?B?QkJ5bkswUXNqWi9RN2cwc29CVTM0VDB1RzZQL3gvcDljNVdsalJuTFhGOVFk?=
 =?utf-8?B?WjBnamhrY043UEIyOFdTNUtEZllYaXo5UmV5OFRDZlVvdEpGZW1PVWxpZS9a?=
 =?utf-8?B?NWhJMVQzTmIwRk8xbUh3MlJlZCtva2oya0twL1R1QTdHWkh3Tkl5MTRidXN5?=
 =?utf-8?B?eGVxWktDMTgwZlEwa1l3c1krL3ZPVzFiS3Zpei9EdzBUbDFleTE2VEhnMUpN?=
 =?utf-8?B?cjArcVc4UVlJaWZ6RE1BV1FxVDZoOWgreXJabUpOcmdacEtUWlR3SGY5OFNy?=
 =?utf-8?B?RG0xL1hZVnE1c1B5Rm00b3lwM0wxVEVyazMvRDNtWStKcm1uV2VTdUdzMmk4?=
 =?utf-8?B?L05kV09paDBGWnJYamhMdmNBemJodVFONjVLZi9WZXhLNEtua0pZWVlBbDZv?=
 =?utf-8?B?dktxeXZ4M3dNc1RzOEZaQjM5WCs3eWYyR1BvTWRkbkNwckhOUWxEM25OTmRX?=
 =?utf-8?B?RFRTMlBtaHo3NDluMjFTSXplWDkxQzlrYmVGWEZIOTN0MHdqamV3R01McFZX?=
 =?utf-8?B?SkVVQXRUeU9QTGVjY3MwR0R6enc0QWt4Wjd4TGxGb2hTL2EvNkdEVUdkY3lk?=
 =?utf-8?B?cFdKcjcwTy9vN0s4bDF0cUZScGV1YVFzU1VoNnMxTG5BZG8zejV2UkhIM3NC?=
 =?utf-8?B?RVBoODJlakgrRFNSNFZ2b1NHb0IrbERPNEszNFJtMENzdlNSSWdrcnF0R2Jk?=
 =?utf-8?B?R3dZeWkxQlA3NWtQWlVkdmxTVExsanlLNlhyeENKVGxvN2hRcHZzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B26BC06AC45BE4693F047165E82F64D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed7e947-f1d0-4553-62e1-08da23e1c978
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 21:56:28.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUx+EjTsojcNQIGUO9RKxk2y25Fnb4s/OQR5BaKrPIeXjj66mYPHvaWlP2tCngoC1pvrQsyeuxBwmpA0tL2YOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOS8yMiAyMToxMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IFRoaXMgaGFzIHNvbWUgbml0IGZpeGVzIGFuZCBjb2RlIGNsZWFudXBzIGFsb25nIHdpdGggcmVt
b3ZpbmcNCj4gZGVwcmVjYXRlZCBBUEkgZmlyIGlkYV9zaW1wbGVfWFhYKCkuDQo+IA0KPiAtY2sN
Cj4gDQo+IENoYWl0YW55YSBLdWxrYXJuaSAoNCk6DQo+ICAgIHZpcnRpby1ibGs6IHJlbW92ZSBh
ZGRpdGlvbmFsIGNoZWNrIGluIGZhc3QgcGF0aA0KPiAgICB2aXJ0aW8tYmxrOiBkb24ndCBhZGQg
YSBuZXcgbGluZQ0KPiAgICB2aXJ0aW8tYmxrOiBhdm9pZCBmdW5jdGlvbiBjYWxsIGluIHRoZSBm
YXN0IHBhdGgNCj4gICAgdmlydGlvLWJsazogcmVtb3ZlIGRlcHJlY2F0ZWQgaWRhX3NpbXBsZV9Y
WFgoKQ0KPiANCj4gICBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDM4ICsrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBJ
J2xsIHNlbmQgb3V0IGEgVjIgYW5kIGRyb3AgcGF0Y2hlcyB0aGF0DQpsYWNrcyB0aGUgcXVhbnRp
dGF0aXZlIGRhdGEuLg0KDQotY2sNCg0KDQo=
