Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E7CC4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiKGFpJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiKGFpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:45:08 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE9E19;
        Sun,  6 Nov 2022 21:45:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JStjVBn4HNVMx9QkyuE4mvd3zMEqKfkaDXHnBU8fp51cEKRtmUIXnUtJ8RAeVZJ9EybSOJBxTGRjrbo6Ty6x3xyZtk6UQDXInaJSgyTC3FnOhurfBWfgwCNfV5NlV6BNGB7kE32VQF6emjCvW+roPmuCcCRNn1/P3i2DaddKzbf324bH9cP/+0gd0gqPP81Vn2H8sYYb5dFoAh4QFzTj9rogE0NGT9BogB+6p/TjWoipMyPWJLv/9ZMLXLJ6WbO/DqKmVs/q+APM9RBrs0JSvRIlrubrJz/pDffCKZt4FK37f2reMWSuPaJvfPt9ACtQb3I0WdUuUIn9vc/JUnMuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq2BAkSLx1aEMYcV43dCPlKSueQ1rk5sEp6989qX0Ds=;
 b=mNMLcELStjErggVl9bMlez3Ig0DXn8hw7Q1gB3AMk+Jl3iVddnhunFXLijniv8zXsKlUnIdvjg9+jtYCE70WJTkOtdqC4plkQ9TTFDsI56rFb7PiGxCFOqEiVVTtSjF7p8lRjwbBAnkglORLAzVn6DJd3AAvTxiutlcGDj9vYZ4ElY4q6TMx8trK891xTmzE/BsUX985jQcVy3t4yIy9d6MpssVh93FGSqd8BGGM+Co2ni8PLo0b4poJReUeEwazc4/bEuE1Wd27sgxcynnVFeFMx6rsl2igbtcxKrsV2SeWxSTUHozIzy5E8J+kR4ArRbqvrKr5AXMP0e77mgDNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq2BAkSLx1aEMYcV43dCPlKSueQ1rk5sEp6989qX0Ds=;
 b=PjpBPneSMb1+sopjZp4jgfIrMVV3Y0HcDTrOE6ZvoTZimYjWnCj/ZpLY2CtgDG3fBJz4X8SjLQopTwb3B/IfPH7A2JYFeFy+eSFjCtfNRAvHOP6TpoPRwoBTxtNC0LYvvCPzbdn9zCOIqi94t3KXtBDBjnt4C2cG2iCefdoB5hpgJVC/ilUelLTGNyBTRBhzUPoC3O6qbmXVJ++XkPKRQwn8m4dGjPEs/Ep/LDObC1HoiHafQiLlGRSwbW3yk43x/zFMqtak8pvjWdQiuSFJMopvsKbcR64oa5Kr8y5aP76fcwJ5uI5bgl06RMe1tLd1eqd9fyKqM64P9YLCy9uClw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 05:45:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 05:45:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Thread-Topic: [PATCH v5 5/7] ata: libata: Fix FUA handling in
 ata_build_rw_tf()
Thread-Index: AQHY8kL4t/tF6eBmnUq4+NmI33As764y86SA
Date:   Mon, 7 Nov 2022 05:45:03 +0000
Message-ID: <2d924281-5deb-3f68-846c-26aff763c58c@nvidia.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA0PR12MB4494:EE_
x-ms-office365-filtering-correlation-id: ab29a5cb-0849-45fd-34f5-08dac08337a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AxUBlafQt2uUS7kyOCez0u34FRDzE5IjCoWnzN6zKlrWqYKmnOMtu6237QsQFo4uc/10N9P+6ZeAv5Vjp40uMhToyGx6SqhCn9/6w+CVtxvbNVW3MAAY/sHS1FNnhx4esXCe6yOXfV5g7S2DtoFAZB8qMC1H7Iwk/HabYvB9LORPIqA9GrCroGUm+1f3HP13Dw1L6/UwRJrFbXBdS2cfkVQd4VbO38kIa3t6xM6j5vQPSUX/B3+uux1S9QcSYyu5PSiaBnY5sToB4MJ/y6ve2/6hpSeyvitdfk7Q6Au0S+vWqOoy+c+MCFu225FnPPPgh2i4IcvNt0cafYKVpzAlxksVl8zWwK6g5R9l3R4zYsYpeQn9PjruKj9ppoSAlDeDDDUy1nYYGbPz9HG8nL/wzxqgbnf+6ejEq0qM1d+1xhNN4i5f6k+x3t8HDeC3zUHJj4Hhr2zXQm7sCrpclj8Jk6jzAY4oK9zr/598ycGvaCEpFBQtz28ziO+3lYi42HDUMmIIHV0LQn7Cwe6W11x+5DSONsvPkORzPrbM905qA8AcceqziIjMHCIllWlU95TVpXZsDtsG0NE+TwaVwMl3Qzctm0euTze6KdyElL0VPZlcPcPGH3BkOU3ntqQvZXlE/O8b2Rds35hiqD9EJpHAZDlraDeFnoEuZhcX8ykdISe8+vxQioP1uxAuKf1zYa2OFdRMNFVdWi3bhfeXIUXlUYJO51kvuIrdDmpybWqhOfWv1iy8JQg6+OzkHa+SyuZkCuBjUD2DoG5toMR1POst5kZ40E1Hk10LYU+Kxw8Q6NMFBhZOX2kHBigUzWua/3+EFqTJShaSK4uknajuaYI5cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(83380400001)(38070700005)(38100700002)(122000001)(31696002)(86362001)(4744005)(5660300002)(2906002)(66446008)(41300700001)(8936002)(64756008)(66556008)(6506007)(66476007)(53546011)(478600001)(2616005)(186003)(6512007)(54906003)(110136005)(91956017)(76116006)(66946007)(316002)(4326008)(8676002)(6486002)(71200400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnZqdVZ5a05iNmZnTGZCczVtVXhSTEhhSmdNMU95ZkJCQkJXNVZRUXJyd2Z2?=
 =?utf-8?B?cll2czRjNTQ2Nlp1SkVxOXRSQjYvU29uK1VlR01mdjlLNmpxaHh3aVMzaTZk?=
 =?utf-8?B?dFNuRkFRd0gyQldhdmI1dDQzS2ZscEpYTktSbm43dmtubC9uaUh2TUh2YjBo?=
 =?utf-8?B?MXJlZHQ1OHY1S3NaM3JRd25oZkluanByTHB6TjdDMTg3RVVDZmlxZDZrdjdx?=
 =?utf-8?B?VDUvTmdDcDU3UHRma2I3cVhmYnRQREhEakUwSkt2QXA5Z0NMZkpyOTVFb2Ew?=
 =?utf-8?B?TWthUE52N0RkNTVVeW5GSEJ6UkowTnI1YWg0dDB4MzZrY3VsbWVzcTUvcG1l?=
 =?utf-8?B?NGczMDgvMVNmU1dIWDEraWdrbnoyVklYeEdqLy9iRThvdzhSUmt4Yk1oRTM3?=
 =?utf-8?B?Y1dlUDVjN21SNXNhWFRPQWQwYmVmd0pBYzlVUkxQVldxSTFWYy9IN1FLVktN?=
 =?utf-8?B?SlhoMmM4SGZJK0krWWdxTVExTUZVcnJBaEV0OVptdkhIa0tKYnhPaVFGZ0h0?=
 =?utf-8?B?TXh5M3MyazhzOGpRMTdmaUJ4RHlrMkpXcG51a2IyUG1HdDFXSXdOSU1EYngv?=
 =?utf-8?B?VkpLUXhvQ0RJeXFpM1A0OUhRTmRIelZDa2NqRUNaVGRFL0ttMlY0Z2dXdGI5?=
 =?utf-8?B?aEMwb21kOW94YjN3TDYyUlhucG1qNml0Qm4vTmNSODV0cnhXTGV2NU4vSWY3?=
 =?utf-8?B?K2ZVMVZvbzBudk9adGNVYlg5aUxFSndCZGdQMUVJL1RTT3o1bU1JV3VYNmg5?=
 =?utf-8?B?bHZseG50TzRjU21DRFFNLzdHT09yNGhVcWxiUTR3SzhUaEJ1ZVUvaHF4SjNr?=
 =?utf-8?B?UzhSenFwZDAycUpDTjN6VFJHZHFFM21FMEhVczg4STZBVkwwb21kUFZLTmox?=
 =?utf-8?B?azF5dzljSmJsVmdPMGlia2JVa2h1UDV5RkdKWitHdkNCVVdiQ2NkM1AwU0RZ?=
 =?utf-8?B?dkJQbnFHTmFTVHZkVm9PcXZBdThlWHRMQ25zdWIzY2psRmtzV0dWK0taa2Rv?=
 =?utf-8?B?TXJHSk13dHpqNC9kOFVSSWxYaGVlMWhpOGRlU2cybXk5T2pSTVJaOXlyWGl6?=
 =?utf-8?B?TldEcUxVbjZhcWd4aDNFWXY0Z08zSm9GRzkzTWZuY1pkZnRPcEgxTmpvTGlO?=
 =?utf-8?B?V2NXL0ExMDZZTlVNM1JwVVZzR1EwN3IzbWUzb1grc1N2ZGZQbVlNbmdPSmZ5?=
 =?utf-8?B?NjY4OGJsNWVPS1U2eHJ6Y255NUdTL2hRVzgxeklpUXFxT1RvTHhXRXFtUWFR?=
 =?utf-8?B?bGV0bW9GZ2hwa3dyczMzVzNPaDBnUVNLdXA2clRxTkNTd2xFdlJ6TWY3R3cw?=
 =?utf-8?B?WDNIVzRzKzdMUTVwbDc1aC9VNDl4VUpKMnFwTWtaZ2xMWUNBUU5FaWNRNFhm?=
 =?utf-8?B?M1hKMmY1eldOTlJzSlpVUSsvTEVBa2VHVHdlK3hzV3hsckd0SVlCeTRieGha?=
 =?utf-8?B?cSt4QzhoWXVzMVVXT0oyamlqRXZwNUlwbkZoR0VRRGdXUFlXaTViQUduNTFq?=
 =?utf-8?B?UFNHaWxHS1NpUG54R3hTQjJYbWpvNXQwU0dVNUtPLzR3MzhVbFp0U0pVV2hB?=
 =?utf-8?B?SjdZL2ZxNEdxNzdRc0E0R2hHNFJMQ1k3bTBiUU1OQ0tONDE4YmVVQU1RQUFa?=
 =?utf-8?B?aVdvWmcyRitXaEtOQmpScGtnUDl1U0owK3U1UXgyV3VQellyOExlMTBNNUdh?=
 =?utf-8?B?cWNWUTNGbTViVDNvM1d3UnA3QTJzQm5oZzBKNm5SMnRzNm16YXJkWWk2VFFn?=
 =?utf-8?B?UWVlZXdmU0FqdkkvM2JWNVR0Q0YvaHArRmtpeUZOL0FteHJxcTNEL0pZU2pW?=
 =?utf-8?B?MC9QU3dnRG9lTmVOSDhISkYreUpsRTQ0UmhhejlTSlVkOFE1bEVqaEM3cHBV?=
 =?utf-8?B?VEE5YklhUytTaFJOYTBnZUVkbHNYRGdrNU1odC9TRmJRdHkvT1JsOEF0clNx?=
 =?utf-8?B?aFFqSDBNYzNpcTRLMzZUVlRPWlJlbEh4S0ZOa25XdUlCanlYeXhZNkhWQXdy?=
 =?utf-8?B?eWpQUHEvNE93b1YvNWk0am90eFFsV3ZYVDdjKzR4cG9OL0paSGNIK3l3d2xl?=
 =?utf-8?B?RExyWGxnQlQ2MEFBN3VBMyswb1RvdGoyS0lzSHgrUzAyQXNhK3hZYjFQRURx?=
 =?utf-8?B?MFdWRXJ4UitsVGZKQjE1MXgyTzFkWi9VVXU1QnNSdHVzNXBsZmV6UDNaQ1BM?=
 =?utf-8?Q?3F9VAd7JadndGIIYaWLIdAYzJxrWPPQquIl/ilanz2so?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <373D1FCA2C27BD41B7F585F6B5A51FF8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab29a5cb-0849-45fd-34f5-08dac08337a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 05:45:03.3012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijqX1/Ww9iYqXC7nvaB6XimJZritZsYiG7mcMZ/2VcXWabcuu7KBRL5J8TpopeY1U971b1dRp/K137qpFxN3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMDIyIDQ6NTAgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBJZiBhIHVzZXIg
aXNzdWVzIGEgd3JpdGUgY29tbWFuZCB3aXRoIHRoZSBGVUEgYml0IHNldCBmb3IgYSBkZXZpY2Ug
d2l0aA0KPiBOQ1Egc3VwcG9ydCBkaXNhYmxlZCAodGhhdCBpcywgdGhlIGRldmljZSBxdWV1ZSBk
ZXB0aCB3YXMgc2V0IHRvIDEpLCB0aGUNCj4gTEJBIDQ4IGNvbW1hbmQgV1JJVEUgRE1BIEZVQSBF
WFQgbXVzdCBiZSB1c2VkLiBIb3dldmVyLA0KPiBhdGFfYnVpbGRfcndfdGYoKSBpZ25vcmVzIHRo
aXMgYW5kIGZpcnN0IHRlc3RzIGlmIExCQSAyOCBjYW4gYmUgdXNlZA0KPiBiYXNlZCBvbiB0aGUg
d3JpdGUgY29tbWFuZCBzZWN0b3IgYW5kIG51bWJlciBvZiBibG9ja3MuIFRoYXQgaXMsIGZvcg0K
PiBzbWFsbCBGVUEgd3JpdGVzIGF0IGxvdyBMQkFzLCBhdGFfcndjbWRfcHJvdG9jb2woKSB3aWxs
IGNhdXNlIHRoZSB3cml0ZQ0KPiB0byBmYWlsLg0KPiANCj4gRml4IHRoaXMgYnkgcHJldmVudGlu
ZyB0aGUgdXNlIG9mIExCQSAyOCBmb3IgYW55IEZVQSB3cml0ZSByZXF1ZXN0Lg0KPiANCj4gR2l2
ZW4gdGhhdCB0aGUgV1JJVEUgTVVMVEkgRlVBIEVYVCBjb21tYW5kIGlzIG1hcmtlZCBhcyBvYnNv
bGV0ZSBpaW4gdGhlDQo+IEFUQSBzcGVjaWZpY2F0aW9uIHNpbmNlIEFDUy0zIChwdWJsaXNoZWQg
aW4gMjAxMyksIHJlbW92ZSB0aGUNCj4gQVRBX0NNRF9XUklURV9NVUxUSV9GVUFfRVhUIGNvbW1h
bmQgZnJvbSB0aGUgYXRhX3J3X2NtZHMgYXJyYXkuDQo+IA0KPiBGaW5hbGx5LCBzaW5jZSB0aGUg
YmxvY2sgbGF5ZXIgc2hvdWxkIG5ldmVyIGlzc3VlIGEgRlVBIHJlYWQNCj4gcmVxdWVzdCwgd2Fy
biBpbiBhdGFfYnVpbGRfcndfdGYoKSBpZiB3ZSBzZWUgc3VjaCByZXF1ZXN0Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMu
Y29tPg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0t
LQ0KDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
