Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4060DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1188160FD9
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJSWiU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:38:20 -0400
Received: from mail-dm6nam08on2064.outbound.protection.outlook.com ([40.107.102.64]:28513
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhJSWiT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 18:38:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ7H+0dBcp1UJBZ/8PSFWVAT5QMgbXlJIdvipA5pdEM8H4o+x+64EdaMKvQbqxcSXFTVTTAC6H+7Idc26a58Y4kre4K5jItJJDy1yOtrThczoYPeslTDMpAN5bKp3mqYK7rQWiFc65yZoBxLegPS/ZLec5iAXqcuv+W5ytnK/FvqKtW5UJq/s64mfCGTBKycRgVKa9afvK/DuY/7xXEeWGnwi4YL8YeSLsH0TN17+dY/+eixIe0LyKzK78FoBFsy7v8cf7XZRlmEBAy4xxZKS4a8V32yyD7XIAMfbXL/UbNNXB0FMNvvfcTLnnyZaP+8+CXEn7rRYTkiJdQOGjfE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK6/VztV5CKoZEgHx8K2Vp/63TMBJrvvf2s4VE7o1RM=;
 b=e/zaOGYpXi2V6Woq9FwJ/twbni8ad4d1Ag+13MfY+imMLiMoh6ZUIjHTCV4bXDx0C3GHhupKlrMt9nzK063939cYPsPOmGvra2VNQEDLZr80suc8SVR4gp3Qml0qT2bIDsUnDGZLVit4V2vX6x5NMNHEYG8aswKW8VPxZkCRe9SZ++cpKQONOQKC03cgf5iuO6iYmo+0UZflM3yYl09KlmWfrh0hkQT70CMifCOgTzhyfqwRG5+6PdEC5mfmBy45Rsl8kLwZP7moZqlKch876IOJZnqa4/nBLAIA1wE97LVUmwb5wr6XM4MnvzEtf9/dXhUk/L4PCowFCfhaJvR8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK6/VztV5CKoZEgHx8K2Vp/63TMBJrvvf2s4VE7o1RM=;
 b=DQl/h54d09FE1z5EEDzT4zUemZmu9NfcDWV6V49kcFMYggtXyaC+w58c1/yu6XItSkd3TUyvTUqL8bcEu8pQba4/IjjWPtk53T2qrd/G0PQ32u2SSTUAAc1RXRisPasZAUOeWbg0HR1sMRIeXlAZYFg9kwOO1kK1KY4C7ZXllG9IXx8Nr/42ObR2hdBucwsbtuk8AM+9l/M7nL7p4w3XvhNV+tet3CpvlMglJO++BRCAL4MK8NcjKFVoFlwSPoXtE5mHjslTpv0ZHa4IMJsIVJxA9dvI2wb4Hkj2do/SVYwx3xlEt6oxjPdMVdHEE4dM2/JaCHD+Et6L1A5Xug8eMg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1824.namprd12.prod.outlook.com (2603:10b6:300:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 22:36:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 22:36:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 11/16] block: add optimised version bio_set_dev()
Thread-Topic: [PATCH 11/16] block: add optimised version bio_set_dev()
Thread-Index: AQHXxS++ki64I4fTLE+CxhzNf0Oicava6QYA
Date:   Tue, 19 Oct 2021 22:36:04 +0000
Message-ID: <7f2f49ea-9810-4347-3f9b-913bb5c52af4@nvidia.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <3c908cb74959c631995341111a7ce116487da5c5.1634676157.git.asml.silence@gmail.com>
In-Reply-To: <3c908cb74959c631995341111a7ce116487da5c5.1634676157.git.asml.silence@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1ee2f17-4208-4763-f6d9-08d99350d5eb
x-ms-traffictypediagnostic: MWHPR12MB1824:
x-microsoft-antispam-prvs: <MWHPR12MB18247C9562CC39DF37454947A3BD9@MWHPR12MB1824.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPIBAvrTosxMSkib7Tkp0SclT/u+qaSKb0znD11SmgeyTLZ2M6RPyN+MKBszyUPhmxYiZCFNqHfdBbu038wz1+yl6k8ukvRlGaQzED6YEqEy2d40257w6J3JSUAQLanVX1ApJWzdQmUSmPmmoL9VozDw4SI2PuYUMOSjRhfEcc0+PJqNtF61zVIZLIRbUsu/AKPOhDnOxmC09a/2cjIWxsL04SQRmBV7Nf9dRFxCgLp2vW/Xh+8m/4fLcb55+Fa6FEmr13SHjb8YNyDXmY6Ikjw9JWKaMXvGNAuOagVHFl/DR96Sy0RryZ2YhRqyu+jjT93iHr1vmZOqFMhXzMNhYg6+qsAz/WQ8jXYlrhpTk6vcCUmcgSGQSjgwdrpmh0p2BJHdVPtX7HJ+eZWYIGLLhBCn+XA7Hroi+89O6Sv2Vk6zIkQ5QYP7tNpZUnazR0X4SLHJjd8F14FXwqDiyYolKrOyorFb9g2dFGQs5fq4AfhhywjhGzumgeTnzpKtbnRdya7N12LsICB7rSIS0LVCmVbCcfwoARDFALeq8M/VCAzDqSHn+zC58VAlVCKIGaBqUrgn9AY4XxCdc6NnsCqWwAb/4nnBNwOF3L4uJ5ZjOiEVpDHtRSKrlfAGCIP7Zpda9U7/QIY8J89JdGltPZpeY/d8kpYk2+ZnyYJ2705YTR4ax1dR+/T9Hq9bx4p71/xGxjC+Aw2d/nH4jwsuRKNarpuC9XKwkoVByQclNqZ89e4j9lT2/q3nnKQmkdxVGA9IzOSDstqEnWuNWZnbxo7uiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(4326008)(36756003)(2616005)(508600001)(6512007)(31686004)(6486002)(316002)(2906002)(122000001)(8676002)(71200400001)(76116006)(64756008)(38070700005)(38100700002)(66446008)(66556008)(8936002)(66476007)(4744005)(110136005)(186003)(66946007)(6506007)(91956017)(86362001)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDhKOTE0ZWdPaHRuWlhwRzUzaVVkY0RGOHYrdEdNTU1JL25oVE80b1ZSM1pz?=
 =?utf-8?B?eUpDSWN3dUVSbVJBSnRiTHAwa0hrRFRudEZWbU1PdG05aDMxcmlMTmxWWE1k?=
 =?utf-8?B?c2thQTdDUVZBc0k1dEIwbmg0V1BpRXAxQklJaFZUQzBVajlIMTRaVWliVDI1?=
 =?utf-8?B?U3FJcWQ2MmlnRUVQN0VDUFJON0V2ZEZBaG9EVlZ5TFZjSlhWbUtFTll6YXkr?=
 =?utf-8?B?SFI5bUxETkVsWFhLRjQvUXNBeS9vNlNrUEV6MHRsa2w4cHp3Ny9pTjF5emtx?=
 =?utf-8?B?MWNNbzBHbGtRYURhNURRYW9EcGpJb0orMUp6NzB5SzBVRHRoQVAyNjRXUThx?=
 =?utf-8?B?SkxSZE1jbVZsZlczS1dwSDZlWnZnejFvVEtXZHBoY0JRR0xDc2J0NGp2Q2gw?=
 =?utf-8?B?WktxMXdQeUFGY2FwajZxSFZha1lySkRWN3JOditLc3llSlZYdTR1WXliT0RX?=
 =?utf-8?B?S0FVTGdTVzFKcW9TYzNhMk5vMTRoM2lmTjBwcmF6VnZKenh0SmszNlVQUlFM?=
 =?utf-8?B?R2F3dUQ5UXNQbCtaZENyNXJ5QkU3OEtwQURpMXNvK0t3eHpvOGdKeDBrNHRj?=
 =?utf-8?B?RFdyRFJ3YUx3dzZHUC95WUxHdEJodXlseXJrcUxITk1COGw1MVQ1YVRKVm1L?=
 =?utf-8?B?N3dSTERabWVBRkhXTUVudHBmblNyTWk2Rk9VdlpIaVNYcXJDUzNYT1BTOVli?=
 =?utf-8?B?NUZzUS9BY1loNHRoWms1bVVlRURRcVdQTEEvdVdidi9xNUhqdWo3OEZSM1Nq?=
 =?utf-8?B?MjNCVnd5NS9ySVg2TUJwcmxKZ2hGY1dPUW02SmtrVmErRXRJbUczQlczRVdx?=
 =?utf-8?B?Lzg3WGpOVzhJSVZBSm54RCtOZGhvbVVsNGVEY3lhTkcyTWk5dzNpMXlLVTlR?=
 =?utf-8?B?MkFJdDdsaVBxRGdqZEkySWhXQWI5UGFaL3lxS1JKRGJ2WkRvUUpwM3N6Q25K?=
 =?utf-8?B?VllIMlJtUmFqaHJKQVpyalhvdmJObERvTlRyZWRROUdTcWhXWWtjTnROTUVv?=
 =?utf-8?B?UFU0YW1RbWd6cXBiWGhIL3lYRWRDSnZ5cEhNcFFKUFpNQTNsVGRPOEwrSmEy?=
 =?utf-8?B?Y0Y5WmRPdkFWYkxLTXdPODZyUEZWSFdvaEZZb3pqMW5HbkJ4M2FtZnlJNXFB?=
 =?utf-8?B?RlZKZEhlVldTeDhrcElrVko1UkJQZWVxbGZ0ZDh1bkQ5Wk5OUHQ1K1Nkaktt?=
 =?utf-8?B?TkNPVkpnK0xTdDFxUDVXNGNTM1o5WnNRbUd1MkNRYXhCR1lXZG9SWldDVlUx?=
 =?utf-8?B?NEszZEtYT3oyN1cvdlRNYjVOdk5iaGlQUWVSTndlenJSdm5ISHZxOEtRK3dq?=
 =?utf-8?B?bnp4MmdxbndMUlJWQzJXZ3pXN05qaGJuSHJ1U01NUzkzS05wUVVZZXlkVkwx?=
 =?utf-8?B?Nzl5RnlPRTJIOE9HanY4S056UGhVbUw1MDkwSW5Ja0xSMEZ5S2RNalQyN3Ri?=
 =?utf-8?B?SlY0ZjVmSHc3alBuVDNZWm54cHN0N3JBV0F5eURZcFNaem1aVGhKbmNSUkNx?=
 =?utf-8?B?R1o4cUxFYnA1eHNvamJpZ0hadjJadFpLQXJEWlZFZmhLRjRDN1NtY0dxZE5z?=
 =?utf-8?B?TnZRRGZ3RjB1cXJHUmt0MWxLbnJCcmV0ZW90UUt3UEJUZFdkUFNobkJNZnZh?=
 =?utf-8?B?RHBGVWVvUDlDS2ZabU1rM3ZhNEdpSU96WG81S1V1b3V2ajdNUVNURldBSjJw?=
 =?utf-8?B?elU0NHpiTGJiVW9id29RY1BRSWI4ZjRXUnUxQjBwRW1LdStNand1KzFvT2xL?=
 =?utf-8?B?REFLUmUreHFqM2pWSDBNUk9McmpQSWh5WWpEUGM0NmZwZVhxYUMwY2IxR0ZH?=
 =?utf-8?B?UGEvVVFlM2xta055OWh4QT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F9A38B2EE43C34DABD178A6D2001C1F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ee2f17-4208-4763-f6d9-08d99350d5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 22:36:04.4794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chaitanyak@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1824
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTkvMjEgMjoyNCBQTSwgUGF2ZWwgQmVndW5rb3Ygd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
SWYgYSBiaW8gd2FzIGp1c3QgYWxsb2NhdGVkIGl0cyBmbGFncyBzaG91bGQgYmUgemVybyBhbmQg
dGhlcmUgaXMgbm8NCj4gbmVlZCB0byBjbGVhciB0aGVtLiBBZGQgX19iaW9fc2V0X2RldigpLCB3
aGljaCBpcyBmYXN0ZXIgYW5kIGRvZXNuJ3QNCj4gY2FyZSBhYm91dCBjbGVyaW5nIGZsYWdzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUGF2ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5jZUBnbWFpbC5j
b20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQoNCg0K
