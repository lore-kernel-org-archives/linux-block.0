Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612FAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DF8610E6
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJSWez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:34:55 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:13088
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229723AbhJSWez (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 18:34:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/B0HPxYj7oTtEyIS2yD/XyJfUxcOpTsuWndKieAF0pK4KyjZ72TfAJxqg5B3L/0Ddtzr4OqmuFGIUpdRP1aggQsccA44wuAgtTXYxZ2Nfjs12d346zZ+kul7Z6BpiMmphJFrCwj5Ssz8oakoYev151ANk9mBVT9BChwL0aGq2y6nAt57zaAFPZZ4bfOTSKRJKpYqyGxM9X8XduTYlv1CDnMLZGB3l5diD3HOJtwo5hgfT4UiKw2XdyXkjRupC0lHGvMHENyNUfHAntdfcSTwlDXY07GFmijkqk7S2jMX2GfZWMrf7ggDFls8qZ2q1PPvA8QkXfBBqKekwT+femI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mxqbZiXRzptaIrAr38HxerpxFIh3muNGXWQJIlhix4=;
 b=X5S6XAdLiQd2wE9VfDP5pSTi9iTFCr64s7v2JBMi6aAiH4E2yW8kZiG5xK8WMbpJsThsLkpoF9gH7b/a2EAKGC3ByMjNU41PWWPaXo2PJNn1KDdYvE5En/I2oDzyFWGaS55CgOSHRT+Bjl6NiFq6r45qT/jbC7KKoXMHrqZgs40ifwRWstgMys7G3qqhvkKy7cPSg0F6KXJLoy5bL2qmr9pF+xck8c1G+68lTnyc399hQ+yXyAxnOtwIhKtx3s6S8ixZOnqqSW/WVKhUpisF1MA0XXT3LYgtjbqmJ+CTA6ZoxOuzcMCCzFdExmanL+qfFZpqnK1vWdUII707JugpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mxqbZiXRzptaIrAr38HxerpxFIh3muNGXWQJIlhix4=;
 b=KAi7D8MhCjbJYSjw3tjqLkxo8jJndgx6HfggGhEup0dGX+SK1T9Rv1aCP3IJR9o/tWdyI2ZNbGJUaIfUfT/cd2LA6jut75BwwQixRF2ChRijAx6iHMowegHP4I+1IUit3V/H9vKzdyV/BQg1Jmx7dOdPcWfjhrxpzuxAebHtt25fjVziZ4+fPBUD/0WKxhTJLSEcQFoFILo9EATQSKMfIa8sjN9KogZKUt8Z1nrnvYovtgkOSqPn7HY96i0uhlsk31um8rLuTCvfoRuBRL8oiWUlSUWmWzK6uGUji6xQhfYRTbK1m1Fpn675ZeYVMDJQDV62ZLhgAxV4s2upd2iS9Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1584.namprd12.prod.outlook.com (2603:10b6:301:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 22:32:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 22:32:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/16] block: don't bloat enter_queue with percpu_ref
Thread-Topic: [PATCH 04/16] block: don't bloat enter_queue with percpu_ref
Thread-Index: AQHXxS+6nyCgWvZvqEqb1s4KSPXwdKva6BMA
Date:   Tue, 19 Oct 2021 22:32:40 +0000
Message-ID: <dabe2549-130c-6551-c027-cb96699cf772@nvidia.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <49bff6b10644a6c789414bf72452edb7d54c132f.1634676157.git.asml.silence@gmail.com>
In-Reply-To: <49bff6b10644a6c789414bf72452edb7d54c132f.1634676157.git.asml.silence@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70483ecb-8471-44f6-4b26-08d993505c58
x-ms-traffictypediagnostic: MWHPR12MB1584:
x-microsoft-antispam-prvs: <MWHPR12MB158434E6A26FCA343FFFA5F2A3BD9@MWHPR12MB1584.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03kiscvJNSShTspJYdMZzkJA8VrEWGfmBPtSBgmilBhO7xNg020ON/UBSeRLpd5yzy4FCiSTnk6nkniT10Tg89PZHaTvVjaO5ED6XNOB/YhK0tcuBgV4Gan8oxKTtwfhvVKE05CX9Gzyv/MNYa44IeLj9PKdA7RQ5iUQWQdunVVORiqJsAi++sPqyqGtKy7vK0gbL7dmMI9BVfI23p8MtcoJZflj3UPVWGSdBHvStJ18KU8XwlCh+cVUum8q7c4UZU+syhVyQYu6JRoOVTGEOFUH1c3ysoZurHHoA/rL+v9vL9yjy3KAex1/vmvw0zllVR3uT6D5Yc4r9BzkFjYoVJMr64Ocl3qTPRoip8113NsqnX5FFt5V8OwSQSz4CdkxlGMwqI5fQSiVBXYw5N/RVbNarI1awS7dpuXPspvtpQTZrmrYW9KUekH4PoRcPy6lmsz4WKUAuDPS8MDxam6PUtXEBtrkHjEOSTcRLGSQk9OXq4TbJj2Qg2MrxFn+ywlLabxDT/INmJQGNJuO0oswLWDXgET4GErJomSqmGmh8RytePjOQekhd16mar8gm9A5lQvEBBOo86BB8OYXZBh1LCX1m+2KRuBocQMTApMVOSOxfDtmveoVOdibGTAodS2tvLHlDUb86h2MNlIP8A6kIom/tUjRFdQJORPGFAN02czY5juRn8bvN1wKAONZEgvVrxOPoTgMeFZ48BePSR3Wn4Vj9pgv09BDIPWSV2XCCTGoo1mGh+6y/Bn2O6POwnnId5VdIiVx+bMiA0KnAYOwqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(4744005)(4326008)(186003)(6512007)(110136005)(53546011)(6506007)(86362001)(508600001)(38100700002)(6486002)(122000001)(71200400001)(31686004)(8936002)(31696002)(5660300002)(8676002)(2906002)(66556008)(76116006)(66446008)(64756008)(66476007)(36756003)(38070700005)(66946007)(91956017)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NndDeFZmelJCUjhGcXVaWVZOSG0yL3prN1ZSOEpEdDFDWUVkR3NOWEJsYnBm?=
 =?utf-8?B?NS9PZjRxZ3VaRElkbVhCMFFaQ2k2WFIwWU5LVEt4KzQ5QlVQajV5cWV1SGY5?=
 =?utf-8?B?bEVUOTlSU3Z3Ty9LSkgwZjBvdTBTakRDV3Q5cDVsNWJBZnlaem53Tmt3SzlP?=
 =?utf-8?B?Tmg4ajdoSXhEQUpuWnNjY2p6WVFNOW85YU1IRU85U3htOUJqUHM5Zng0Mity?=
 =?utf-8?B?dGNzRWI4VEpYNkpmNEs0aXVDbzRhMDFJay8rZGU4aWQvUFRVT3c1ejJ1K1U5?=
 =?utf-8?B?SVA0QnJBM24zRDhVM3NsMnhLdjVxUlZTTGZ6OGZpelY2M1V1RndhTGs0aXNI?=
 =?utf-8?B?VnFXcytrdmFHVDdYSm5FZXEwNWtuWlA5d1U2MlE2RzNnSmp4Tm1KQnRta2Ry?=
 =?utf-8?B?REEwVU9aQzNlY2htNGppZ09VUUdFOXpUVERWVWZieGJ3ZFNSNlNhYUlsWjh4?=
 =?utf-8?B?QURUMUJob0VHYklXeUNCTnV6N1JPTzFwUExWdzVKd0JMWll5dU9YNWNsbmNI?=
 =?utf-8?B?eElZaGZiVmVlL21MMUIya0hyNkZLbTJVWG5BYUVCVDFJcTBtUldUSzczeUtO?=
 =?utf-8?B?YVpDd3l0MDFBejFyWElJTGpCSGZpUHFIYkJJMzdmRDNwSFNwcTJOcDZ5MUV2?=
 =?utf-8?B?V1hYOExWcHVnNTIyTnpKWG9nN0c2alY1Sk1WVHNDK004N0lnQzJxaHdmOXIz?=
 =?utf-8?B?YVlWYlhVbHVISXRIK3ltYjZaQy9Id3ozMllSTTc5YzU5YjRDZmtZamc3WWxD?=
 =?utf-8?B?T1hhZzZZa3N0RmtoQkZFQjEvV3d2TEk0czBsRnViOEJTYkpUOERzNi92bjJP?=
 =?utf-8?B?SjZybzdOUzkyVm10Nm9TQmVVSTRtTW42VnlqMk1JRVBFZ1BDQjI1cGFyS29n?=
 =?utf-8?B?QmtNYk5MdUx4Zm9yNTVQL1RJYWUxdmtyOFY2a1Frb3RKTFdnUFV0VWxtd0o1?=
 =?utf-8?B?RWJ5aG5xUkN4SGExSVMraDF4dmhpRW9XcDdTYW1PRnBGb2tEa294Z29yaGp1?=
 =?utf-8?B?c25rME9HRU9xWUtiNTVpZ3FwZTZEMk41Nmg2RGR4amQ5NFpNZllFdDdlakdP?=
 =?utf-8?B?UHpSaHdwc3VvRXhSSUFlYVhJMGVNK3k3ZlZaS3Fha0xwcGxvZE4xeENSVFhN?=
 =?utf-8?B?eEcyaDJXK3ZsaWtxdm1OWDJMVkllWjNna0ZBUlRaWXprU2oxQkQ5WEU2TXJx?=
 =?utf-8?B?TkY1elFpQVJXV0pQc25uTjc0UlVkK3FYeHJVSk8xUElkaVYwNUIyQUlQVjdi?=
 =?utf-8?B?V3BsaGdDZ3ZpY1ppRC9nR2tqQ1RSaUFoZlNpbzJjdll6TEpsenprT1B4YTJH?=
 =?utf-8?B?RHRFcytnYVU4OFE5Qk5tWkpTeFJlNCtYTFlibENBb21oVzRWN0RLMllMZ2V3?=
 =?utf-8?B?Z2M4ajFvQzdrQVhaZUVTSVROdnIvN1FzcDR6ZnBmWGtSUHhNREpYckNqTEpu?=
 =?utf-8?B?M0hGa29CVVBRaVhnOGJQRnhpd2Q1VEFXQXJ1MXk5OWIvRDYvUkl5NnVNeXRQ?=
 =?utf-8?B?RkIyeWE1ZmZUbHkzY3U1UUtoTU9hMFFFY3FjQ2UxSWo2MTczcmRUK091aHdR?=
 =?utf-8?B?VGZuRUFmS04zdDVSeHBMZ2NTeFJvWDNuL0tWZVVyTTZUTjlLUmRuT0VybW1a?=
 =?utf-8?B?T1RNb3ZrTFNLYTNxclU2TXd1emlvV3pMZ2VQeVBNNVJZUDJ5aFJwQkh5d1c1?=
 =?utf-8?B?MVZXVVl0dEV5MjlGSmYrOEpHei8wTnp3WEhCbVhodFJyaWtBTExJek9GaXp2?=
 =?utf-8?B?QUsrdDdhRVZqaGFvT3JMdi93ZXpXaThCK2t5ZitLNUlrUU9LMFdnTFJ1OE9L?=
 =?utf-8?B?K0ZuNCtGQXEzRFJwWS8rdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAE4C3204B055D469BB494849818892E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70483ecb-8471-44f6-4b26-08d993505c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 22:32:40.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chaitanyak@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1584
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTkvMjEgMjoyNCBQTSwgUGF2ZWwgQmVndW5rb3Ygd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
cGVyY3B1X3JlZl9wdXQoKSBhcmUgaW5saW5lZCBmb3IgcGVyZm9ybWFuY2UgYW5kIGJsb2F0IHRo
ZSBiaW5hcnksIHdlDQo+IGRvbid0IGNhcmUgYWJvdXQgdGhlIGZhaWwgY2FzZSBvZiBibGtfdHJ5
X2VudGVyX3F1ZXVlKCksIHNvIHdlIGNhbg0KPiByZXBsYWNlIGl0IHdpdGggYSBjYWxsIHRvIGJs
a19xdWV1ZV9leGl0KCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYXZlbCBCZWd1bmtvdiA8YXNt
bC5zaWxlbmNlQGdtYWlsLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg==
