Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A09C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 09:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiF1JAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiF1JAi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 05:00:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0821EB3
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 02:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9psxE1gNRcVxeoiT0FfmvDGWagEO0ykYjWlNZca6aJVLQChH0x3wJOuWpdmVP0IO8wwkK1C1PhcwnJ4BVopMjW/8UwySLAJuWfsQBZIKMYunbIvWOqLjUKdWE93UOkVxXpu5nXnGFLKmO+NHgzbN9I0q6rIE65uT098GMe8WlN2k0xUyNuSZiuibxl3k5J2oJqVpVJvypDdKnAWpix6JRPrgJ/m0MikLdEHgo2oAJpUyDDpmmAmSAzUr3n1ooejWIVaCZUPxbaBSlYE4HlxRmtQpLUmlumV9dlKeFC6XsEoED8LUiuWkfiZ1RBkrlK/cbxLLBPabLa6+eB/pq0UwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUJ5u78gZaXD6yogzgpLczcXkZ4U231s0Pvh0FCIR/A=;
 b=OFeFkQM0muIBJ/tmIyBKNm43cXKSLOPAw/ye20ZikQNP17a7V3c7XPx0O0FMCalINry+UbQrXs7d8Bkt6f1PFU01jEVV9IHcg8nSCATYaHQbZpOVb+653Xv3vSbDjddvGkXz+2xvkXTgkTH5vNbQ5vYYms/NLmiDhg9Ox7mnLiFl7rsAfkneFS36v2UT34Lf/0imb3BVY7EiX1f9WLbIa2f5uVthaKeH1eJOdjZdghxpI4hAaUoTtpPYdcQ93XqgJiZze9EXtmttAArpWDNl3ZqmqXFSSvCOByohIOIS6EplmJzhp25KSZNO8P4MDmb3aGapnY4gOl6H0OtQZS6l8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUJ5u78gZaXD6yogzgpLczcXkZ4U231s0Pvh0FCIR/A=;
 b=RVNbXA/3NTgSWmwsIbaH7KOmXp8H9V/BRzSm3UIXF7yz8DwKuYs6+ka9JdInNr/9fVpJsHIY2inVbRYFmgjAOTDaK7i5gJ+Ujtixgw8qcobgGFG1Flps2OA0sfgnvsvNi/pak6WpB50BWo+3QaNZ25lu4pG95aE6gDD3giIykJ5+uKTMsf7QlqXAh7tLgpAr4DjITWECFvcBlaOfXf4hS32NQl/0/YK/MAc+x85hOMFsEVIsQ/Fpg1I9+1MuqRm7VMWScMFtzUEqHfTNbSvBKeGkOiOEp4HinxqIoQmqW/JREDMdIyi1Nj2ndlmYP3GN85Svz00TWAGE5ILLg393pA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 09:00:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 09:00:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Thread-Topic: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Thread-Index: AQHYin/I2Yt0q+Xa5kSOpLwwzkSPsK1kJdOAgABgOgA=
Date:   Tue, 28 Jun 2022 09:00:34 +0000
Message-ID: <cfb8452f-d362-84df-76cc-ad3d9b46a784@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-9-bvanassche@acm.org>
 <YrpyeemonjF3Lv/z@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YrpyeemonjF3Lv/z@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 464afd13-b188-4bb8-b67e-08da58e4a992
x-ms-traffictypediagnostic: MWHPR12MB1725:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XIBRy5usBKvn9xez+9sRZPtnfdsv8IKFQ5ayBq95h9xRydB6iXhA4Mz7QKB56RfEewLiMtRzz4H79xhPpSjQUtGsLkfWtH9h7O5d5OHYH6Kk2d+xnOgXF0J7hyPGWhfYvMVKmwsMGreCZ/Ct1XZTFBOdassGVea9lrvGoKb+e+Ua5dHnIfA2GjJ8FLoadto+rGy21h0lcVtChjJEr4VJEdUVHVHpfJbFSBTz97ookHledtLnjRpxv/5mGMd8d4n6LOioMWl3ohaFlGAF7aNqGRzlulGbbJKWk3Cs9sE8Q8Ui9O/13PFKU00AoPRX2+kyWbaFMXf2kAAiB+19ugtAqKX4daVIDNPq5AmuXbAx5DtHoFfGJGIAe5SJKE+a+qw/ASFu0WsY7R05auWuPvqgA61dUwBojMhEaGt+UYfwguAEUZF9cXoXNJDD2GlcJk3Gn7S9rGN8hD8lBp4CtUg8LR38+S6svmzAsx5D/gDBrsPX0UG4HlfFWwsqkF71xQ0WMJTQIgQKgg9BAVJfaICtyLac1c+qA7jAtxYgNMVzK3b9Bnw/VYKg44EqDDNoP8o95hBxm2FTVHPimejwc8nm4ocUSIAApsetCOCRF/y7trD6F4Ar3gaOmsf5nkSBZMsSExXjFK2jUxxFXicTqDwnMYTdguoGw09M5CnXM++fAJpbSzZ5gL/6dwcsBzWBGvDxB2MXCtyH3KqzC5COmSalbbrpGzN+xjy9JTr6TBNh2Wv09AhXC5h+oTS+8hePD2oBvHeB4FK2eHkZhBve+DGScwDcizL7WqLU5stFv1EeE9ezfBrB17K6wPRzY2VGam+D78M1LSq0LCEv/gKttP0UGBYgNzzIXF8Nyx4mOqP+0rI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(8676002)(31686004)(38100700002)(110136005)(8936002)(83380400001)(4326008)(36756003)(66476007)(71200400001)(76116006)(91956017)(316002)(66446008)(54906003)(122000001)(64756008)(2906002)(4744005)(66946007)(41300700001)(53546011)(6506007)(478600001)(6486002)(107886003)(86362001)(186003)(2616005)(5660300002)(66556008)(6512007)(31696002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWR3MDl0YlR5TzZNSDZqb0RQek8wYjlmOGFDdDJrWnphd0Y3cmcvb0tVUzEv?=
 =?utf-8?B?c2lURUlvdFJnbHVpWFJSUy9ycFUvNHRQU1IrckwyeWtRM2M2V0lXNzhUY2lU?=
 =?utf-8?B?MTVjOE8vK3BrYkVQNVZTaTlQVy94QlBwL1dwWjhBRFVKUjF5NFpCbWxwN2NS?=
 =?utf-8?B?L0JTdE5KaElEWjlnQmRBOHNGbE5GYU9GU1E1SEluQjdJeVF3MWpvUDFsbm5X?=
 =?utf-8?B?bkRyMnF4bWVxSDZlVWZLWUhyZzlQaTdmclF2b1lJdVRFY3JKckFMUkhMZDdk?=
 =?utf-8?B?blRuU0ovRnFLa0NlVVJiNHR1cXdsTEU2eHJNNWxrdmI2VnR1MGFpZ0ErL1VU?=
 =?utf-8?B?Tzh5dkVwTDdkY2RuWnFEYmZGcXNvZjl1eGhwQm1FNk4wRTJBY085ZnB1eE5n?=
 =?utf-8?B?dmV0MEo0YUxrZ0JjNkg3a2ZrNVk5NXhnSVVtclU0ejE2dmRNekM4RlF1Q1hR?=
 =?utf-8?B?T2lXMUdoRzR1ZFgwNTVhT2xLdGxsMThaRlE1K2kzdm43WkQ4bms5WWRVZlVI?=
 =?utf-8?B?QlBzTjBGZC9MT2VmVUtFc25MRlFYbkpGZjEvWlh4UzRXNFZzWWVFQm9LVUJP?=
 =?utf-8?B?VTlnZFY3UlFOY1RoSTMrV3ZCV2w5TXJ3VlpEUldWWG5taHdhOWFndU9HTjJv?=
 =?utf-8?B?Szk3cWVFWnRlT3Q1QVJBV2Z2ekZtQXNXaFdaL1pUci9QeFBZQzIxSzNsK2tP?=
 =?utf-8?B?SlBRQ2Q2TTNiWE1jSUJYU2p1ekVCa01NWjdJMmpUdERCZEpITk0xRFpCemVO?=
 =?utf-8?B?b2QwOE1WVGVpQiszRmtEWjhNMkF6TE9WVFBSVk9rNEdETEdGUW5JeHdvNW5M?=
 =?utf-8?B?Z21nZWpQY0FXTk5yamhJSW5wWGlpY0JsOTZoNUtyMDBMT0ovWlFLaDhqY0NI?=
 =?utf-8?B?NWU5RVRXcW9CM0JoVmJVbjR6bno1RExJb3JXQ2JZdG1qSlR0N1hrUTdPSFIr?=
 =?utf-8?B?TjU3Z05LYVYyVnpRZmF6MEVDZTZBSVI5UjUveEZKR1pFWThKbFlhQWx3OHhF?=
 =?utf-8?B?VWZkWURjMHVRaUFiK3JxZjZOMVZQMTNMRmFZSWxoUG5uallIR0tXZkE3OGdi?=
 =?utf-8?B?YlJtVVpDbXNXY0M3UG5qWWlqR21DblJxK2Jyd3o3UHlvWmM2T3MrdFRQWW4w?=
 =?utf-8?B?QUltT3ovSEtGY2NsUStYWFZ5YUtVQnZHRWZYdEdRUldQTGdSc0JQZVJja3lk?=
 =?utf-8?B?VmxiTisreEJkaWV4TEEwaUpiN0l2WmJWOHhBcWhENm93T3R5VFJTNjFxR2tm?=
 =?utf-8?B?d1BiUUs3NlFicU0zSmNqK0YwdnBpU0tBNTRSU0M0bDZ0a25IQWhUSTE0VGM4?=
 =?utf-8?B?UmRZYWE4eVFNa1plbG9lMGRFRndZajkzUUw2K3FoVFRleStpeVB5L2JNdVNC?=
 =?utf-8?B?OFRiZjdWc1IycFY5MkdxT0R2WUhTeHN2TEovc3Jjb01HaVlxZ2NSeUF5VnVC?=
 =?utf-8?B?NWNwYVQvTzkvVlFlUFZYdllDN0V0a3p6cXdyL09ocUd5dUc5aTdtU3dxbEJM?=
 =?utf-8?B?ckIyNWJuSjlRVkpQblM4Z2srOCtvWXgwdXpkV2U1d0cva0FsRDRBajRxd2VT?=
 =?utf-8?B?cnR6Smk2Y2hyN0kweHplUDlkVWg2b3BUYzlMOEpEeXlvK1d1cG1aSXV4Ymtn?=
 =?utf-8?B?dEFoMlI4Yyt6YmhKOWlHUFFUOVRSNjRvSmpZb3NyemlvWi9XVHpmQ05sZ1V0?=
 =?utf-8?B?S1F2Ty9MY2RzYzZqbFdTVmYyaS9VbUtlM1BDdVVQZmJsT1MxZ3hIUko2MEVJ?=
 =?utf-8?B?V1NQSVlXMThhQXUwNmN3UnZYL01COUZVbWdZazlWdFR0Tmp0RlRkVzNqRUEx?=
 =?utf-8?B?djBReFA3Z3hGa25kdzdVYnRHVGtzTENpZFF0WjByQXRHMnF1WWFZL0xuY1Js?=
 =?utf-8?B?N3Z0a0NTM1BEMlFkYXUrMXZTTGU1M1lYaWZkcWJVc0tEd0ZkNzhNMHNMSmo1?=
 =?utf-8?B?RVZhZlJtdldHVkxFZUlpb3NLanN2RkQ2NU5LTGRUSXh6bFh5ZzJVNFJVK0dE?=
 =?utf-8?B?dkcwc3BqK3BhVU5jc2IyRFRhaUtVMjdpVFNMVWFnRkxqODVDODZrWGRxUUh3?=
 =?utf-8?B?M2RRcTl1UDhxbjZYWUc1WDNOeEF0dmlYSVh1TDQyUmViYjNLTXNlRldoYlkv?=
 =?utf-8?B?b1R4b0V6SU5kaFRFdHRIVkN4MFdOV0ZreXZ4K2Z2TXZ3elBMdW44am56NHhZ?=
 =?utf-8?Q?9Nvxcuv6YA28DeXncVkLv8UqWA8+NW+zyDXwnocPFsw4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08D0B51E4EFC9244B20B73EA7560A55F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464afd13-b188-4bb8-b67e-08da58e4a992
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 09:00:34.6630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFmOWoaeschOuJDgYBtKyaw+iEX2xP6Rus7zhNBXdMzxJsrVPYMIpbFKfhgJ6khmsrn9ZS6lfnQ4pL6NVtDrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yNy8yMDIyIDg6MTYgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBNb24sIEp1biAy
NywgMjAyMiBhdCAwNDo0MzozNVBNIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+PiBA
QCAtODU0LDYgKzg1NCwxMiBAQCBzdGF0aWMgaW5saW5lIGJsa19zdGF0dXNfdCBudm1lX3NldHVw
X3J3KHN0cnVjdCBudm1lX25zICpucywNCj4+ICAgCWlmIChyZXEtPmNtZF9mbGFncyAmIFJFUV9S
QUhFQUQpDQo+PiAgIAkJZHNtZ210IHw9IE5WTUVfUldfRFNNX0ZSRVFfUFJFRkVUQ0g7DQo+PiAg
IA0KPj4gKwlpZiAoYmxrX3F1ZXVlX3BpcGVsaW5lX3pvbmVkX3dyaXRlcyhyZXEtPnEpICYmDQo+
PiArCSAgICBibGtfcnFfaXNfc2VxX3pvbmVfd3JpdGUocmVxKSkNCj4+ICsJCW52bWVfcmVxKHJl
cSktPm1heF9yZXRyaWVzID0NCj4+ICsJCQltaW4oMFVMICsgdHlwZV9tYXgodHlwZW9mKG52bWVf
cmVxKHJlcSktPm1heF9yZXRyaWVzKSksDQo+PiArCQkJICAgIG52bWVfcmVxKHJlcSktPm1heF9y
ZXRyaWVzICsgcmVxLT5xLT5ucl9yZXF1ZXN0cyk7DQo+IA0KPiBJIGNhbid0IG1ha2UgbXVjaCBz
ZW5zZSBvZiB3aGF0IHRoZSBhYm92ZSBpcyB0cnlpbmcgdG8gYWNjb21wbGlzaC4gVGhpcw0KPiBy
ZWV2YWx1YXRlcyBtYXhfcmV0cmllcyBldmVyeSB0aW1lIHRoZSByZXF1ZXN0IGlzIHJldHJpZWQs
IGFuZCB0aGUgbmV3DQo+IG1heF9yZXRyaWVzIGlzIGJhc2VkIG9uIHRoZSBwcmV2aW91cyBtYXhf
cmV0cmllcz8NCg0KSSBhbHNvIGhhZCBhIGhhcmQgdGltZSBxdWlja2x5IHJlYWRpbmcgdGhlIGNv
ZGUgYnV0IHRoYXQgbWF5YmUganVzdCBtZS4NCg0KUGVyaGFwcyBhIHdlbGwgZG9jdW1lbnRlZCBj
b21tZW50IG9yIGEgaGVscGVyIHdpdGggY29tbWVudCBleHBsYWluaW5nIA0KdGhlIGxvZ2ljIHdp
bGwgYmUgaGVscGZ1bCBoZXJlID8NCg0KLWNrDQoNCg0K
