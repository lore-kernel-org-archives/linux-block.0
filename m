Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2763C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 16:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiBOQzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:55:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiBOQzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 11:55:00 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D11118626
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 08:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW2pqibWANyXbQHkigSNU2chnV4KwjRWxZJz4VoRB/ZZUbC6iNnJ0DiP3ngr5uB77a+3mgW9afwxVeHwQxenENjajt4Znmq1KMeDnWnyyyKwJRsuJ/qnBK+0gERbEpSBP90G/vyLcWu+ZL3FJyE2kVpn1ZCXAF29aBf/83zoBorPW0r8QmyPEul+hSsTzZXcdlRR3pFD0nZSSe/kc1dOt8wAQyb8lnsA35nXzb81e98JzvH0EP+fSu3CderGz4Jk1CpsrvBc5BRg5kE+Q5VYMkKGmIkjSD1ZE2T3Pl89hzPdNNmoGJxDJ2d0RmHBYVCwaT9gyVueSJG4w9hmLHQYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruXf8xTo/sdirxPrwjcdctV9OClSWCKum3ynQsRhKTk=;
 b=FO32ud+w33RI8b0YpYCP5n1OkP3Pp3BDoNRhJntVjHbOcH4eyRcM8WC+nPFa1TT7qyWhMtcSqyUpXaK+BlWpl3rvtoouTsbDe+HWoMiVYo3MzI1/2Xjo021TbK2IgHKJgS0EACRLKEMBr9Jf5FN8dHpODmaIlCCgqJhfDvRGPWm8OrHNRaNdoYago/i8EF+Oc4hyz5NdTlJVePFVyrqaAnSMtsn5j2N9WrXhXIYr7jc2eIHHMhJ1Oifek52rH53Bxe4N7vArksHWJ6jRjIswdcJMBPxdf9BAp2VY7IVidLDzSJVmxLVTRglIRZYtBP6JE8mj0eE14YfPMiv4HvZz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruXf8xTo/sdirxPrwjcdctV9OClSWCKum3ynQsRhKTk=;
 b=dnZRU41IhZo/qKfRnK+vZXMnvYLAXrPhVUveMwh5YlOeMG8rl5hR9POKtsqIkDpV9/P3fbvxyzKWDz2t6u0ti1rIeAHI1GGb0jbZW7kzigMzb4E6PsQlx/B8BcY7yflQOld+gWHgWmuEnXdLUBQp6AJn6hOaHuqLXLF9SOXiW+UpjOopwuH5L4YXrjaNPGk4xEmYkDyJ/WkD0xmlgQkj3zoRI/AGcFAWH32m3vGe3sQt9/GcDzr/tWW1dzSMG+ZW1+87zry7bCHX751TiRDHgTpTMvHd5x1FwBf5HL9NqamegZHc+iFpQZ5aBSjVAu1UPl46gw9/9nxGfHeLGUrgUA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 16:54:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 16:54:48 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Himanshu Madhani <himanshu.madhani@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH V2 4/4] loop: allow user to set the queue depth
Thread-Topic: [PATCH V2 4/4] loop: allow user to set the queue depth
Thread-Index: AQHYImJ2DbQi0mAJSEChfByGUx7bRqyUsvmAgAAhvQA=
Date:   Tue, 15 Feb 2022 16:54:48 +0000
Message-ID: <70c418ed-dc68-4f67-bc95-d417c77be4d0@nvidia.com>
References: <20220215115104.11429-1-kch@nvidia.com>
 <20220215115104.11429-5-kch@nvidia.com>
 <75d43e3b-e13e-f78c-b120-cb3de5ff0e63@kernel.dk>
In-Reply-To: <75d43e3b-e13e-f78c-b120-cb3de5ff0e63@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f7ac6c9-9f81-4360-95c8-08d9f0a3e08d
x-ms-traffictypediagnostic: BY5PR12MB4115:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4115F3C4C5A5DF9006EE52BCA3349@BY5PR12MB4115.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JN5DCa1yyavQAtRKvAdGWB+SEKPsCunhEsQ7oIQJHWIlpwVvixdYEeAM6Br8oRDoBlOozyDoUr3ZjaUbYnz9E40nhNi9fMy50AZdpHOU7FsJr248xypvPAyzblSQG3wcp95T7XiPwr5UvcuiKpAeSZbXj9MK29Ci/+4qfNJfjWlY3B5clcX2m6ML7VZilyWZLxW/T6A4Uxk2eFlVTrns9qxNzp/COCJjTlxzNRktQG0t8Rh3mJ11VY+ggyf3aRAodYt+y8XI/t8qn6GbcB5NwpM5ILunF9CBZ3ZLa6gE/Zli1rRvttPsU9pWbOfTikiQ0Ef2OAayYGO1GRulJDhdkQjaKDEHH7ELc4cMoon38f+2vLEzjxxvgCzLWba9SI3pGtOVquvCu6pYFbAv47eO7FdL6Z+PXrnqGqPg25UoDusl/tzYBEd6b4oGHZIuE+X8BZHJC3QmZtOZ9iTS3BvzsQXARRNR0Vf6p4oxkF+v7tdhmbhMeH6qsuBk2rMaIT6QfOAo3CGMRB/kQGAhTKsqfzmC/7OTweUN6Gm0i3BEJErfQypFlLXDhSI1r8OMewUaB3pCKdkucnbvUOakKAVLZIGggh8cSG20VNPBa362Q7JzBLBb9NIhB4PmlCU54BXBbSBbr88rDqHRPosdfQJJmIq/+ZlyKlo9kJZIKYkEobsf8xnqeUbPUXp4i92h5RvSssi9jZkMFh55KHmiXCyaoOc3EnFQ7aK9AHz8pj+UHBd2otikCl8E35bO9feqwey5cB39j7RN2g72fbqCGEs74g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6512007)(2906002)(38070700005)(2616005)(31686004)(36756003)(6916009)(38100700002)(122000001)(107886003)(186003)(6506007)(31696002)(53546011)(5660300002)(76116006)(66946007)(66446008)(64756008)(66476007)(4326008)(8676002)(66556008)(91956017)(316002)(6486002)(8936002)(508600001)(83380400001)(86362001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck1vYTRTcFNjTDZINFRwdkRWSkdhNEN6aHZyaWVvT2Z0VE1CU0F1SDhwTWV2?=
 =?utf-8?B?WUxWM0tOWjZQZzFZWGtQVW1yWEI5eUFFV21YT2pmTmcxUi80WHJKNDZ2Qk51?=
 =?utf-8?B?SDcwZm1oK2g5OG96aHV3SWNDQWhYYkNDaXdRdWVwbDJXOWE4bHk2eERObmRm?=
 =?utf-8?B?MUVIVnRXSHNvUUp2d3pNQ3RvSmVLUWR4WGJ2cEZtMHFmL25IM0g5UWRxSSt4?=
 =?utf-8?B?bjA3SldVc1M5dmh6ODQva0VPN0plNUwyTC8zMmlrK3VMMEtiRHBkaWVWZ0hy?=
 =?utf-8?B?Ni9uUUZGWGY1MHF3K1kzZ3FoQVlBcFZWTCtORGMzakNWeGc1VGVHTHNGRzR6?=
 =?utf-8?B?dkNnbEs4T2tZNkVuQzZyRXhkQldQZnJ2Y2dDVkM0N3E2aGdsYktBc0pVRkFE?=
 =?utf-8?B?OHI0S1NoU281a1VwVVpCSDh2NjVYSG00Z1JTdEJ6TGtGTk10aVVUbldXVExo?=
 =?utf-8?B?b1RtZThoT1dBQm5zYzlJWUIwTGtMRjMrR0x3bEFEZm9RcFozN2ZlaHJraWk5?=
 =?utf-8?B?Ym9mSE95cTcvV0tJMU4wbk1jL1Q2M05ZNTVNVTJxVm1KZUZpYmMwc0JjQm1k?=
 =?utf-8?B?VjZRRHQzMlNXR2pxa1p3V29nVnM4YWxGTmdzYTdjZ3daWVRvNkdTR0o3Zk5M?=
 =?utf-8?B?OEtkVjV1S1M1NDVua05wRDhTM0ZieW9XQjBjVzJaNkZ1U0J5WTJneks5eEFP?=
 =?utf-8?B?UTFLY01GNGtoUjY5TVY5RXpDeUpCUnVHNW5jOE1YUEJUSXR6RkVQYXQ1L29o?=
 =?utf-8?B?MDFtalE4VjhWL0lieHJNYTVhS3JHRzJ4cWlxdHZ3SVVqU3doQm1BYmZiSjh5?=
 =?utf-8?B?ek9hdVpWV3NjOU0wNjYvTHYrZkpCa0FFV05OZklYNmE1NzJBejd1WHk2dlFh?=
 =?utf-8?B?bm1kcEVTb2FHVDJCVlVJaXJyU2VQMFJ1Q2F1UEhKSm5tNjlrek9WaFBybzRv?=
 =?utf-8?B?NWtzYVFSTUpiNVlLWXpEU1A5MGREc0E0M0xNWFlhRElMUkpuNkgzRlNoWld0?=
 =?utf-8?B?UDVLbWxUTzlCMUgxcUIzWUdYaTdCSG9GbGw2aTc5YU1FWnkvOEVKeVZFUmVZ?=
 =?utf-8?B?YXg2OWRrbGM5MW1nN0I2dTNyZzYxWnNRUkxnaUZJeU5tc3IvVGFRRXNrSHNj?=
 =?utf-8?B?OXM1V0twQTVzUzJTVkNXY0VxR3RidWVNMkdSeTh0NnJSWE9PdTBtZGVtWERm?=
 =?utf-8?B?YUZMYS83R1RFMUpWTVk2ajNheDNpc3h3emNIK3lkRnEwZzFPTVE4cFprdTBk?=
 =?utf-8?B?WXEyMldhbmJFZ2drQ0dGY2ZBMTNnNjZ5Q3RkcEV1NDJTYU96YWk5cE5jQ0l0?=
 =?utf-8?B?eTZHK0hqaC9ZQktHbk1GcWRwMkUrMno1UmszQWtrSDgwK1NodGFaaGNzbncw?=
 =?utf-8?B?bkp2dzY0Q0dVY3lLUzFsTUR6S3pYUGZ3OHBmdkZkeit2RW9rVStFY0x3emUv?=
 =?utf-8?B?T2UySVhLK0pkUFdEaFh5cnlzYmhQSEx2VVV3TEoreWJZUFJUb0RPbmdVL0Z0?=
 =?utf-8?B?WVhHZysxcWxzOC83ZklQZTUxb0Y0Mm5GS3hzemRoUnhOT3pqTzFUeWNCdmZH?=
 =?utf-8?B?UDlVU1JKY1ZmSU1nMVFxTDV6Q0k1L0w2WElZU0Uvbzl5ZjlZbkcrREdacGlX?=
 =?utf-8?B?M1FoalpmVXRTRzFlSXNoQnFEcFhydzNsWS9aWi9VbDdMV0c2RzlPMW5rWW9S?=
 =?utf-8?B?S1hXTTdkbUh3UlAwZVZ6UTZvOUJTaFYyQ3cwbHZBNjBUYjVTNFg5UUthMDNy?=
 =?utf-8?B?N1dCazdUVE9LSWJ0RWRvUEcrdW43TExxZXVDQldPWkpaclV3WGhTUlZQREIw?=
 =?utf-8?B?b0N1Rk4vQ2hiWXVocmoxNmF0YlRsUjljVU14T2lxWlZmSG9pakpmUGllMzVL?=
 =?utf-8?B?YTVOTm1EWmQyaTVmSjNPV2l3RVZZK01Vak9uV1RieGxVbDJHby9JVjdoVDV2?=
 =?utf-8?B?b1VtdW1xbDk1d3ZWN0MxdDFGQ1VacjV1Tzc4WVozeFphV1g2TVowM3ZURWpS?=
 =?utf-8?B?RXdYa0JrVElSRk5kRGtkTXUyVm81R2l1NHJzN0RGYnpMK1VxN1ByVDJYUTRt?=
 =?utf-8?B?eEo0UlhJNStTSFZwaFhWampCQW9iclk2Y3dsdXNoNUlBdGJEYWs1b2dNeTEx?=
 =?utf-8?B?SWZjY3lTTkp1REtxdDFSdjdBREg1U2p6cjQvd2RVTmZaalMxaUxxOVFPYmp3?=
 =?utf-8?B?ZGpiYm1Ddk9oMGdsbW8wbXU3K0NaZ2VYOHBlV1lISzlzOElDUjI3MjUyMHky?=
 =?utf-8?B?RCtDMnV5a0lMd3luNzE1eTlZcHFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A296DDA07470CA49A4E4D0F556C62DC1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7ac6c9-9f81-4360-95c8-08d9f0a3e08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 16:54:48.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86e4dzPJ6SCB3nkz7qMSDsLyTLlxqQ8rba7O89UP3Qvdio+DZcmA1hsi6zO0NGD/P7l82Y2YXhRZI+J202VBBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNS8yMiAwNjo1NCwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gMi8xNS8yMiA0OjUxIEFN
LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBJbnN0ZWFkIG9mIGhhcmRjb2RpbmcgcXVl
dWUgZGVwdGggYWxsb3cgdXNlciB0byBzZXQgdGhlIGh3IHF1ZXVlIGRlcHRoDQo+PiB1c2luZyBt
b2R1bGUgcGFyYW1ldGVyLiBTZXQgZGVmYXVsdCB2YWx1ZSB0byAxMjggdG8gcmV0YWluIHRoZSBl
eGlzdGluZw0KPj4gYmVoYXZpb3IuDQo+IA0KPiBEbyB3ZSB3YW50IHRvIGVuc3VyZSB0aGF0IHRo
ZSBkZXB0aCBmYWxscyB3aXRoaW4gYSByZWFzb25hYmxlIHJhbmdlPyBJDQo+IGd1ZXNzIHdlIGRv
bid0IGlmIHdlIGp1c3QgZW5zdXJlIHRoYXQgaXQgZmFpbHMgZ3JhY2VmdWxseS4gRWcgaGF2ZSB5
b3UNCj4gdHJpZWQgdGhlIHVzdWFsIHNhbml0eSBjaGVja3Mgb2YgLTEsIDAsIDEsIGh1Z2U/DQo+
DQoNClllcyB3ZSBzaG91bGQsIHdlIGNhbiBlcnJvciBvdXQgZm9yIHZhbHVlcyA8IDEgc2VlIFsx
XSwgYnV0IHdoYXQgc2hvdWxkDQpiZSB0aGUgcmVhc29uYWJsZSByYW5nZSBmb3IgYW55IHBvc2l0
aXZlIG9yIGh1Z2UgdmFsdWVzID8gc2luY2UgYmxvY2sNCmxheWVyIHdpbGwgcmVkdWNlIHRoZSBk
ZXB0aCBpZiBpdCBjYW5ub3QgaW5jb3Jwb3JhdGUgaHVnZSB2YWx1ZXMgdG8gdGhlDQpvbmVzIHdo
aWNoIGl0IGNhbiBpbiBibGtfbXFfYWxsb2Nfc2V0X21hcF9hbmRfcnFzKCkuDQoNClsxXSBsb29w
IGh3X3F1ZXVlX2RlcHRoIHBhcmFtZXRlciB2YWxpZGF0aW9uIGluY3JlbWVudGFsIHBhdGNoDQog
ICAgIHVudGVzdGVkIDotDQoNCnJvb3RAZGV2IGxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIyBnaXQg
ZGlmZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbG9vcC5jIGIvZHJpdmVycy9ibG9jay9s
b29wLmMNCmluZGV4IGZkMjE4NGQ2M2MxMS4uYzlhNzMyYTIyNzY3IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9ibG9jay9sb29wLmMNCisrKyBiL2RyaXZlcnMvYmxvY2svbG9vcC5jDQpAQCAtODUsNiAr
ODUsNyBAQA0KICAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KDQogICNkZWZpbmUgTE9PUF9J
RExFX1dPUktFUl9USU1FT1VUICg2MCAqIEhaKQ0KKyNkZWZpbmUgTE9PUF9ERUZBVUxUX0hXX1Ff
REVQVEggKDEyOCkNCg0KICBzdGF0aWMgREVGSU5FX0lEUihsb29wX2luZGV4X2lkcik7DQogIHN0
YXRpYyBERUZJTkVfTVVURVgobG9vcF9jdGxfbXV0ZXgpOw0KQEAgLTE3ODUsOSArMTc4NiwyNCBA
QCBtb2R1bGVfcGFyYW0obWF4X2xvb3AsIGludCwgMDQ0NCk7DQogIE1PRFVMRV9QQVJNX0RFU0Mo
bWF4X2xvb3AsICJNYXhpbXVtIG51bWJlciBvZiBsb29wIGRldmljZXMiKTsNCiAgbW9kdWxlX3Bh
cmFtKG1heF9wYXJ0LCBpbnQsIDA0NDQpOw0KICBNT0RVTEVfUEFSTV9ERVNDKG1heF9wYXJ0LCAi
TWF4aW11bSBudW1iZXIgb2YgcGFydGl0aW9ucyBwZXIgbG9vcCANCmRldmljZSIpOw0KLXN0YXRp
YyBpbnQgaHdfcXVldWVfZGVwdGggPSAxMjg7DQotbW9kdWxlX3BhcmFtX25hbWVkKGh3X3F1ZXVl
X2RlcHRoLCBod19xdWV1ZV9kZXB0aCwgaW50LCAwNDQ0KTsNCisNCitzdGF0aWMgaW50IGh3X3F1
ZXVlX2RlcHRoID0gTE9PUF9ERUZBVUxUX0hXX1FfREVQVEg7DQorDQorc3RhdGljIGludCBsb29w
X3NldF9od19xdWV1ZV9kZXB0aChjb25zdCBjaGFyICpzLCBjb25zdCBzdHJ1Y3QgDQprZXJuZWxf
cGFyYW0gKnApDQorew0KKyAgICAgICBpbnQgcmV0ID0ga3N0cnRvaW50KHMsIDEwLCAmaHdfcXVl
dWVfZGVwdGgpOw0KKw0KKyAgICAgICByZXR1cm4gKHJldCB8fCAoaHdfcXVldWVfZGVwdGggPCAx
KSA/IC1FSU5WQUwgOiAwOw0KK30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJh
bV9vcHMgbG9vcF9od19xZGVwdGhfcGFyYW1fb3BzID0gew0KKyAgICAgICAuc2V0ICAgID0gbG9v
cF9zZXRfaHdfcXVldWVfZGVwdGgsDQorICAgICAgIC5nZXQgICAgPSBwYXJhbV9nZXRfaW50LA0K
K307DQorDQorZGV2aWNlX3BhcmFtX2NiKGh3X3F1ZXVlX2RlcHRoLCAmbG9vcF9od19xZGVwdGhf
cGFyYW1fb3BzLCANCiZod19xdWV1ZV9kZXB0aCwgMDQ0NCk7DQogIE1PRFVMRV9QQVJNX0RFU0Mo
aHdfcXVldWVfZGVwdGgsICJRdWV1ZSBkZXB0aCBmb3IgZWFjaCBoYXJkd2FyZSBxdWV1ZS4gDQpE
ZWZhdWx0OiAxMjgiKTsNCisNCg0KLWNrDQoNCg0K
