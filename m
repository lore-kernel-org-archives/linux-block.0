Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A9C28D13
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 01:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiHWBIz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHWBIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 21:08:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0913D54
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 18:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4aHYZ2n0IICakUcxxH3jJHcSb2e3m9KwdpC8Xs+7RKcOoaybPcfUgkkgHBYIFmVnTlB5j/GPTZpuG9oMEXxBdw0sOGPe1hYG3yJzPoBb+kvxxmU5rNnt/rjxD2WUi9Yr48U4IahLGKp6E4gGDacHr4u7hD3dSEZnK552j2uVbSy43MGkm1bgJh9N+UWbzJLcAVxPSGNV8N+cUsebKwV42nAILETCAbAtoJCq+Jr0SgvjPp96hwIW19aTrcMcJuNwcLqg+2UVYMhcekjZyiEqvdvKESXc0EghnbmwbvNb2mQ3ifLsUwBcSGTZzVj7fMaAUR7QruIagtMavaoaxmVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aZwlkLbd7WimkcadVFD1Av9GU34jFEkpjJ0ir8/pfc=;
 b=mVbSJ/vbTW3ODrx4UumwfH3dvU5W7v/fhtHojAWOnu8RqQicDoyb7TvppNf6HqvAsZDcKrZ+YeYVRePKXR7XWTpeF2G+K86x7wTo+BtY9w/2CRFozu3hIrXbTX+z4+4kaczvHiLbN5SI6mC4+qIkq2AZcNEF5CDnZcWlkIJq1iuzfC+gcZuosDUGSUrIdiGsjIgHq1+7AwIsGt2cDHWxZP5z0+HKraLDEZ8ZO7YZxguZXADl8kDXs70vN8N6mrSkW9kl74Z5TxQl4ulmdQm3sExdr2ja3YRmNso1xYP4rZBOQF9XfGkLL+fZ3+uTPzjMj2AnWVTO7VyHC5bMC0BZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aZwlkLbd7WimkcadVFD1Av9GU34jFEkpjJ0ir8/pfc=;
 b=uMb5YyzJpZNyjDTwFWDzhv8sIH25OrT85vK2onEJ1NN7pT9bMIg5/xT7yxNV3SxjJ4Qi+iAUMYUpgoK1uwEeLHLY1gMaUPo7GDJRSNOdHTWhhBN1PeLxjqjw0uFv5mWovtWYpOs7i0lDvnLY9qnquy2IT6JSMACdOMSIg5hL7FKhtYsTJ3qQ+owFN0BgL+0W91JxSqXFpkVEfG1frtXXq8YYhLgA9bo3lU20NPjK+huezL2sV3wEOFUWWOBg4cUYPeUG2IMcdlwQ93prGzQv72gpDfTRIY8ShjndNVWkVTXe3/SmmgfzC00VmOVgwSj7reqgsBtmZeJrPryonfcbjw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 01:08:43 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5525.019; Tue, 23 Aug 2022
 01:08:43 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/4] rnbd-srv: simplify rnbd_srv_fill_msg_open_rsp
Thread-Topic: [PATCH 1/4] rnbd-srv: simplify rnbd_srv_fill_msg_open_rsp
Thread-Index: AQHYte8crtDQD/D9rkepQZY1gsUVqK27reYA
Date:   Tue, 23 Aug 2022 01:08:43 +0000
Message-ID: <f068d9d9-bab0-bfee-22b8-86baea5307ce@nvidia.com>
References: <20220822061745.152010-1-hch@lst.de>
 <20220822061745.152010-2-hch@lst.de>
In-Reply-To: <20220822061745.152010-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd241ba7-15a8-42c0-658f-08da84a405b9
x-ms-traffictypediagnostic: BN7PR12MB2708:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AMXD+UvdpBYYGdISwuPLktxBLHRPHwjzb0MKWXN/NKxRicvAJYEv/vjWhZH3X0VQhoK+ozAaDuc0qGPnHI5qajsnbaWjd6eBg7+LExbGTLaYdqCSwP4vePSCTqZlimq5KLc7jrjOo2LQ0g72E8zIAEtRyNeZrF5b3tfjGo1DLshmI4+0Mkk07tv5/NSw/BGgDfzFpp+bjztIfYm9Y4OrnXhxtj3Z9pajRNTdztvehqqHjA6Xo/a1ozAs5GMkhEmghKNC49jp6CtqqR8bGhMALJ1s7cVTfCZGIiLfWNlAo1c+spajjB0rXba83ks4hqyvL4VZfmdxiCqPWvav6eb6iXwqvwQZIyhPzicnzXllLgPtQ8FZpktGJNtOJwW4zkKwgbXlNn8mLy43RfehrhIuWKxFdXfh5uuQBvB/Ln8OVD0zWPXBEnD1rDL6zhUH7Zxzf3RA0hnv8JwolUcVoXChZmVs40y3uTZzToxrI05/giROAxQeVQwwQ7oUzjLNjhr/G6BbREHm28sot3MPq8LhPRbiYSuyy0WE9x5txnIiA/Sx3P86NWP/IB1SDQZg2aqGFGSm1Mf2h1AMHhudajtpbvTV0TR2+393CRp6WreC34dD3zoQIkPtHlO5oQ0HCUutD8n+uCbcsQuV1a56+x3MPHJMsGZZBTInBpy6FitORdOGwEvBGw4pGk/z+AsSLy3t9PLIozC9pG8k+8LiGoO3xcmX0Gby2qp8ezaB16LefxDD62kjEsSWfiBJehzJtaGPgUU0ck+1BfwVpYL8EXqlH0oRT1JcxM5jiVumBEGE5wESqUszB4Zdedas0Hs4tH/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(66556008)(66446008)(66476007)(64756008)(6512007)(4326008)(5660300002)(41300700001)(6486002)(66946007)(6506007)(186003)(86362001)(2616005)(558084003)(91956017)(478600001)(8676002)(2906002)(8936002)(83380400001)(38100700002)(38070700005)(53546011)(122000001)(110136005)(76116006)(71200400001)(316002)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mnd6allVUXJXQWxkZEJ0bllrR3VPL29wK01YZDJkUVhKNWRDcFpaL2x4SnlC?=
 =?utf-8?B?MVVqTmZYUlp6b1dXbnJUZit0T0haejMyekhydzJMK2ZZay93anZMdWw3b2ZR?=
 =?utf-8?B?YnFZbk85OUJFMVROakxyeEtDV2l5WHp0RkRWVW9YVzBCOE4wMk9WWlRoV1hi?=
 =?utf-8?B?OFhsaEdYSC9XQUEwajVHOHV2M0t3bWEvTGxVUEphZWZCcGN0REVqUGdxaFcw?=
 =?utf-8?B?aC9XdlZNVGxrVkNiYThJUWtZL2UwSzRra2JocUMzaFdLVHEwbDhUditISDR4?=
 =?utf-8?B?bUJIenRDdFZkM2Irdk1RVlhlcTdNenVoeHFoVUMva1hOZThlMUFKek1LSGtL?=
 =?utf-8?B?aEsvY05ZNDE1V0loTVFaN3ZWOGorMHp1cEVIUmY1TzhiaHVKQU1XMHFpUTJK?=
 =?utf-8?B?L1lMVi9BdjRxK3U0L0NlcWlmRWI0QWJaZllBS2NjeGZOdFA2aU5XOEo3MkNI?=
 =?utf-8?B?aXdPdlE5RVlMcWhNc2hxQXJXSGZyaEFrRlpUc2JrdnJYZ0NiTVFSb241MFdG?=
 =?utf-8?B?Y09mMFVJaHdCVGZzcS9weENreko2ZWp2Tyt5Slp2WWt4WUltTG11SnJsb0NZ?=
 =?utf-8?B?cHRTQjUzaTlGeXhlYnhuNWI5bjhjN2VqYnpiL0ZuRXMvbGJjUmdRZU5ycDYz?=
 =?utf-8?B?OUl0NFI5Z2h3a0xzY3BlQ2JLV3VJRGVMclFsNnB6akt4MWhzcG90TjRKOFRj?=
 =?utf-8?B?a05ka1F1R0pLblNTbkhLWm5PVWZCRGNTdThmdEdjNmNVUXVtNUhSMVdHeU9E?=
 =?utf-8?B?Umt0QkQ5a0s0NnhvNGhlTEo5c1VLVSt2UGVUa2xVK040cXFhckM1RENwVExH?=
 =?utf-8?B?K0tvZFZhTnNMcEN3RUtrUUdRVjZjZmRBTndSNE9YaEFEeTdDanZvNFZDZDQ3?=
 =?utf-8?B?WnRwL1d3YXIycmxNZVBjTXNUWmV2eVYvcG1yTXZBVGdKNWhFSWkxSWgzcE04?=
 =?utf-8?B?dGsrS0dleHk5WFZ3Qnl4WVcvOWx4MFd1bkRCVWNHWXBQRkVWbkFIaFlGamY1?=
 =?utf-8?B?MzlqMHQyejhDSEptV21ndlVTeVpvbFRkR1V5NjF2MmlxTVNyd2IybVRYcWNL?=
 =?utf-8?B?WVFnYzNXUkdMSlNRZS80c3VIaE5mbk5mZ0JvOTEzYXpKTXdYOFd5NDkwSjla?=
 =?utf-8?B?bm1TWlJlaFBYNVcvNDlyTWU4VjZ0b01WeDhFWnFRSlN5K2UyRjFuckRzUmgx?=
 =?utf-8?B?N2Y1RUwwWENNSElTY1lhbVkyTXZVQ205dWpScUxZak5DWTBzcjI1U21YUFBZ?=
 =?utf-8?B?OHRMZFk2aW9lVzVZM082UmtyVGNmbzVzcTVXU0ZOVjNIQ05NV2hUZXNleXdr?=
 =?utf-8?B?RHh2VDdZK0NlL2xjaVlkNWo1OWhMblBZUzZHcGJ4NGJTQ1pKYmtneXl2bG5p?=
 =?utf-8?B?cXhIWndYV3F0bk1RZlFLZ1dmVDZsMUN0TmgzY3pjQVZYcG8wdmJKcFN2WFdK?=
 =?utf-8?B?NFBnWEY5ZGhjYkhlVEdlQXpSVEJYUDdoZEVsc1o1cDEvY09UWWI4ejUvbkVs?=
 =?utf-8?B?WXBxM1h1QVJTSE1QcmdBRzlSZjhSb3Z1bnJSekxwVmpNRGRGRkhDSVRJOEta?=
 =?utf-8?B?WXRkLzZWU09QMUJ5V1ZlZ3lJcDZPcXJUbXo1dHlZMEQxWkh5ajJGYm95U01W?=
 =?utf-8?B?QWlLcTFBd2pVM29VbEkwRVdJK0NDZ1pSa3ppY0NDV29zNVBWZ2VpN0dBSXda?=
 =?utf-8?B?NUJQN0hoNTBYdTNwM2pVUlpTRG1OS1ZMS3R6N3MyU0hzS2hDTkpobE1NUC9q?=
 =?utf-8?B?ekdUemlNZzZTRzdRcDlNV3N2N3EzaktVVUJsZkFBRnBXaWtyemhDM0RTSzFr?=
 =?utf-8?B?L0lubExkOHFsYmJXVU5KbThidDd4VUF1eVpoNVk0Um1OMnphMHM4Y2JEQ2dB?=
 =?utf-8?B?aFBzWGtGRk40ZFJDbnJGWXh1RDdlcWhsRDlwZkdFRDVnTW1sTWMwRm10TUNU?=
 =?utf-8?B?UnNIQloveTBKRlNwb0FvZThxS2k0WFpnQmtKTWpScmJWRWQ3L0tydS9JV1NP?=
 =?utf-8?B?UmdyWXNGSlhieUhqUWFYckdGa24wb1FmZDhybjJDazNNT095elhwNG5aeGZU?=
 =?utf-8?B?Ky91TFpCOTdRWE5Ob2dNQlJxbjRGbUVQSXJqWVNNWWVPcFVXZWlKOGpOKzB2?=
 =?utf-8?B?eWgxajBhNlpuOXk5emlwVkZ5dWJQdjhrT0oxQVMxZmU2RjM1cnZpWHlhK3lm?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <442DE7159AB20C42910267B09E7EF082@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd241ba7-15a8-42c0-658f-08da84a405b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:08:43.1416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVglkdiDW94T7WZ8ZcnGzl4Gm3Qn0ARSpgeCKUzaMPghnr+AbtV8OF3PXC1U7WP7cR+cg5NcGyMMsERg0IT84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8yMS8yMiAyMzoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFJlbW92ZSBhbGwg
dGhlIHdyYXBwZXJzIGFuZCBqdXN0IGdldCB0aGUgaW5mb3JtYXRpb24gZGlyZWN0bHkgZnJvbQ0K
PiB0aGUgYmxvY2sgZGV2aWNlLCBvciB3aGVyZSBubyBzdWNoIGhlbHBlcnMgZXhpc3QgdGhlIHJl
cXVlc3RfcXVldWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
