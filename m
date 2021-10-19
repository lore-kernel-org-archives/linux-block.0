Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D7610E5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJSWgU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:36:20 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:32353
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhJSWgT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 18:36:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdesp3wVqzhS5YaaLieJCk90ja6jXVT7nRT2vCE/6PbJP4xVIuYsLMnBCfpmfUWUhq2Q//n8v074egqMyPmyoEJmZ7aq27j9zScQqxHfRJ4jOU5UrvOAuvSLrAiTXDxQT6ed4n65mNmyUlfB2Xf1NRkHKs/aKY/3QmZHvF5759leoDGkygEtGCFeWnr+mebDpGgq0HKqQLGPE+9PVuoXcpfiHmAwXeRy9LasRRIR6mQDJNUKV9IPwzVzcEPyXN+S//vbzHc561CLd7vL2matNVW337rOdpCVJoFjCzKEYK/KIG1XbkWqW5uhx9XxTfGQsL2Xqw5OhrJO5AFUKsbErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77Hq0AqsFXacV6M4QwpB3gU+wDTdMKqXJ8SPhtgq3nk=;
 b=GafYnsPXisLXsqcM13sr2gUBrX7A0TMVogMhEwQQUAsJd1kpVYc5oigzxfFnsHb9VgSQLMMyh6SX6L+4tVbfIFbTzp+k4JC3SfM6A7otInwrRmXo13+MKN3g2dPnLWp9kxdGEM826y15UHYTfAuBsI9wD4+Etfz8j6AIGOv/XZrg3gorClWqVwYwolx2tomfm/WeRqhZ2nAKkw0WPpDfOrJOkis0muzPJzFn5PdkakDLa8M06xwl4wejV/R5v5evMaNfy30gNbohjIO21xe+x73p0vqB7an7sFlKhA1H2UoPIAefRiH+r6GDtNeTUk9UdqbRR10vyz6EavBWSsPIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Hq0AqsFXacV6M4QwpB3gU+wDTdMKqXJ8SPhtgq3nk=;
 b=eDL/Wjg+TAwY6vmqBEiRudHMeKvjVOrcsKneAkZuC5M0sAAkMAEowrjfJCQQytuLqyHdRZ5bKsFVWu+18o9spaTmri7ISABmPSEXGkLHLG2uxf09c/7tXNQTEebW+IFicf3/K2kKPMtSJwtnLPFFqvwaCXS7Bnd2hMMIBXaKaY4HZJf6Dgn4UaFQqGJqAR+qJ+raFANuOrJpuqvFqBAFLouTSPqllL601sZEXbPg+dwdLpuTIj1OrAAV+5Y1u4jbBUe91ISJEgenQyjLT0yV5UtzRG0n0FsnK38sErUGE7PK2otTWJrxjArQeFkhsrV3Vive8otm7x1xUJuMya/uEg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 22:34:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 22:34:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/16] block: convert leftovers to bdev_get_queue
Thread-Topic: [PATCH 02/16] block: convert leftovers to bdev_get_queue
Thread-Index: AQHXxS+5wQuWrQWqIESChV21SsJzQqva6HcA
Date:   Tue, 19 Oct 2021 22:34:05 +0000
Message-ID: <696ed4af-b677-69d1-b881-8cddee77524c@nvidia.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <654f1cba1fe9c321cb87943ee33a21c7ea3d8e65.1634676157.git.asml.silence@gmail.com>
In-Reply-To: <654f1cba1fe9c321cb87943ee33a21c7ea3d8e65.1634676157.git.asml.silence@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 513561c4-bf28-4999-afd9-08d993508ec2
x-ms-traffictypediagnostic: MW3PR12MB4395:
x-microsoft-antispam-prvs: <MW3PR12MB4395ED5F5D9248E3D4720AAAA3BD9@MW3PR12MB4395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SA04kjygZeEc0KhEauDrFHonjagr+KHgTKrlpy9mdAXVjF/i+Ucb24jO8mLnbSFf6b7JgHGaSsHDHy3VUfP7T+2ELv6SHbLgcAKMGRcjeALYSU7G6sr9UBL+G528+mL95R36485Qd3pnirn3kp9zkbJ/Cv7UDKz41eFkEeNPi3+jy0WjDrT6wL+gaapXYWBC6Jp+7TuGPcNspj3QswjwxnBjiTB60gyN7AyzxRjK8MKA2f+DutAMVOsTzMN3NqVtBapZHAotDyCfFdjy8yGzlhDsK6U7vltiityvXvwsez0YZYPck+VvWCT2gRhVNiqoLif+dtzbSRoe5xjwibvfZnYwF00GUrUrEe2ShPenXo9niz7zqi/4H8tA1vYG2iRUp99crb1FaAzZYaFwGjWtKJHdg8hwj2XUD0DkS+e3q4uLWRjqKb4b+R7EiaVG5k2WqbYSaq7tl9lChWJLK39bsrq79IC8EYBRC1D3mtbEQKjmdkXaAYykkNYxCkR2wCq7tohY3SDrsttQ9KHM1N2HKj4siYTmxEOV7ru3R+MGMo/0RQYeP0p4y/u/GIkzvZ8PBPx784B9PS4P/YkuhYV1iNhtlVHrEg9QfYdDjdJBsAzkleTBiy6gmRDhItaun/MUJfVMwomNmAamnQzQyfVkBmxjC4k9s5YxmR9flQDO2HHHv5u9npUVi/yx8e9yq+p33D5kR3sgUAPswg1X1mbY5P9sM5fZSy/FyprKY3qwqAsja/ehiBtQEtoq7Uj84B5Vgv9MbDOnyMvZMtXafPc2LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(83380400001)(8936002)(508600001)(8676002)(36756003)(4744005)(31686004)(122000001)(186003)(31696002)(6486002)(71200400001)(6506007)(66946007)(38070700005)(53546011)(110136005)(66556008)(66476007)(64756008)(6512007)(4326008)(316002)(66446008)(91956017)(5660300002)(2906002)(38100700002)(76116006)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEhwS0xFd3Q4N0lZQXRvWlpDNUhUbFhUYWtSTEJlYkVDVWlyRlR1SXhmSEhn?=
 =?utf-8?B?STQxNVFoUHdtTms0N29hVVpkRWhkTXFOL0psTXBBRWtuRmFZdWdYVmkvUXg3?=
 =?utf-8?B?K0NoLzRjdWs2bElHNWR0aWh2SmN0ejdETXNwU0E4QWdnUitaaTNyMjhOektD?=
 =?utf-8?B?R3E1UVJoTVBvWDNsVmFtSXhFRnozY3U4d2NDRTBXRGNhZlloTEhVUkwxdnA3?=
 =?utf-8?B?Yk85VTJKa2ROdEp1elAwZnVvaXpKcUZ6V0RpU3ZXaVRaWjNucjlZamxva2NP?=
 =?utf-8?B?Wi92Ui81S0ZKem12VlJGUmdFc0hTZVg5bXJBN2x1emJVWnBjeWlpbE92ejY3?=
 =?utf-8?B?U0UvZ0R5M0VNcVZUZGVYbFQ2L00rQlFIWXR3dkFDd1NyN20xTFdGN1lneUM0?=
 =?utf-8?B?U2R2bkovMWVDMU1QTmJJQWZhN29USThtcTRhVGdYTjg4Z0htWWVIMkovQzFW?=
 =?utf-8?B?Y3ltV3VNS3gySXk0eDNMQzlWSW13akZxTnJUckpuR0NJYXJaU3FRQWhuNkZn?=
 =?utf-8?B?clVJS05tOHMzSDg5ckI3WElpeDZwK3VHbnlJcDBZNlh2RTVkczZxRElZUTFl?=
 =?utf-8?B?N3FhcUlmMGIzYUpFaUZRYkpnNXY5d0lRc01CMTlscTRzazhSVmtOaDBIaG9X?=
 =?utf-8?B?OHVoSWJRaGVEdmNNSzdNR3VoUFdXNEphTUVFajdyelJMZ2NzNDZyWHh0bElO?=
 =?utf-8?B?VHU5ODRESEdyenFhWHF6SHVXR083dVNYbyt4cUNHVW1hVWtLQTJyS215clNp?=
 =?utf-8?B?eXg1OHdzbXRQRTN6aGNwMzRrUkEzRjlRdjRlTkQzMFoyL2s5NHVMcksrQy8w?=
 =?utf-8?B?L0xMUDFlaDB2S2ZaaVduam9UNVdsNXdLeUVNVlRFeFc0TVhLOExXN1dWVlFt?=
 =?utf-8?B?Qk53L1lPY2RYZnBYQUV1cVhIVXNLc0FGaHlxL0tJbUk5RDk1YXBBcFFhK1dk?=
 =?utf-8?B?YlRMem4wMURmYno1N0todDJ6R3RCbGZxMkpFL3BpeVBQMTQrWjMrblczTkN3?=
 =?utf-8?B?OXJvNkp1U0ZjQjd4WUhadlVyNkxTQU56Z0xhZ3pPY2xSQ2NYWm41OWhEQ0Fr?=
 =?utf-8?B?ZDBpSEN1MGdTcXhQNGpVcnJUZ3ozQnJEV3lha2JaaVQycFhpaTVHZlVYdXlZ?=
 =?utf-8?B?dVdVL3lwN3NiTDgvNmJUQVFKMWVtMFhodFYvejUvOVIraDUvMVVvVmRoeE1l?=
 =?utf-8?B?OFA1SnRsb0Q4ZmVzeWtTMzZXMkRUeU9PUWFNZUNhdEtoTkQxREY3UDlWWmdL?=
 =?utf-8?B?UWd4clN4TGxGdXduMmh2TUg1cC9Mb2FOV1JuWVNyWU9yOXFRaGp5MUVXdmM3?=
 =?utf-8?B?eGViSXlPamlER0ViUWhuWjBRTlJwT2R6ejRnRktYZ3VJMG12UlRHUGtyUytZ?=
 =?utf-8?B?QzkvQXpHV2VqaHNnbVJ0d2pkVGhObmlaT0QwL0l5STdHTm4wdSs5VzJXWExj?=
 =?utf-8?B?NkxjaE9YSFZOZW14Slg4WDVMN1JNWlkrMnM2RUJ2RXpCbzJKdDhmQjBjUkx6?=
 =?utf-8?B?Zno2aUFLVnhGRWFIRStNOEdWY3dtOTdHdEJSd01wUW5nRWhtRHJsMjBzMXBa?=
 =?utf-8?B?SUZmM1JFbVZueTdJOGVwWEdKR1hua3RYN3pTTXBvcDZSbVM4ZkhLMXZOcHJ4?=
 =?utf-8?B?ZXU5UnJ1WUNhY2xtZkZhb3BtSnp4L295QStqcUQrTENZalFpSTZ5RE9xSGJQ?=
 =?utf-8?B?OFhlVnNJVFdNVU1XVHd1TjV4eXBvRzV3MWRVYmtuMXhMd2MxdG9DdjM2SWVG?=
 =?utf-8?B?V1dGb1BmSTBINDFleXRycTZ1WjFuY3p5MWNLQ01XaXdoQ1dTbmRqQVhaemNC?=
 =?utf-8?B?OUpqcElhcjlWMTRPR1NNQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7220AD03A017D444BFBF499A3F2E8E4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513561c4-bf28-4999-afd9-08d993508ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 22:34:05.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chaitanyak@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTkvMjEgMjoyNCBQTSwgUGF2ZWwgQmVndW5rb3Ygd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
Q29udmVydCBiZGV2LT5iZF9kaXNrLT5xdWV1ZSB0byBiZGV2X2dldF9xdWV1ZSgpLCB3aGljaCBp
cyBmYXN0ZXIuDQo+IEFwcGFyZW50bHksIHRoZXJlIGFyZSBhIGZldyBzdWNoIHNwb3RzIGluIGJs
b2NrIHRoYXQgZ290IGxvc3QgZHVyaW5nDQo+IHJlYmFzZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdtYWlsLmNvbT4NCj4gLS0tDQo+DQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQoNCg==
