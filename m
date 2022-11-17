Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD4C433FE
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 06:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiKQGuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 01:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiKQGus (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 01:50:48 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A4627F0
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 22:50:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=karCtbcf2OxKr9wF6cCLfMTX1M6Apr8ypjhhO2V+6CdBMBBB9NKZISPa5hp2kbBTn6PDdIDk7HOMOo8mRDd/NABz8QhIpMD8vCCn7DYpwLFyrXYDCjEId58NYVngpWIWAPnL3TFBJPSSc9jzEOIjZ2m5/p++iykxbnzVNAXSofmSdoxEaqehN7hAbY7LenFqwCHMzBG/r28Nslqo88Qv1JhmSfBstAnXxdtzZitESn2PmLyhKAHc4ylErFi4nqtdH12d04RC5LuUffg950Qi+o/Nx2mFwkGG+YrRlcR3DFlxJYvDch+52QRiS7MzwT+rP3X1ab+pW7Xxm5r7vOpBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyL2t2d5w8Shc5ofqUZ6b9aMtZPWKJGPIdXB1GPbk/Y=;
 b=XXFALKdP/uzVc0nyAi/YKFHNJ7K9odbnLmIxpt9opB9rfrciaNUzbCw6nUqw68tZDM7VhpnVngV13R4D0H6lMjTbtHDD+GUiPfxK8Wj+wtPvmaYvhqMb3OxLmEqRlGZFJQDjqz1QWrzkQbp1BpOQ/wqubkfqb7uXy6PNuBflP59mtFI3qOZOqmNLv7ye0Z4GcbXKw97D7lMp5y6u64mDYL8q1hGKWSL4QSJ5hacIXETZ6om0WBficqnsWezSLO8P3Z8k7s+TAf4+6fSSxr+jBQVnCZ94Wa52mjR+wRzzPt8HMu061w5bB3cu1mVI8IAx0jOKwS6x1wvM0tHbP73FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyL2t2d5w8Shc5ofqUZ6b9aMtZPWKJGPIdXB1GPbk/Y=;
 b=oBOwdx0OQxOu+nbx6Q1HaCb9cHI8oOXBAHQuWNT7cB63uUn3PsxRsrHJx1B5WQh8klyG8EwsZk+Y1bxX6YSgVN/gfsMUg5JAln0KQZj1rByTNLo3gNViR9RqVHGSidBZ1mJ+7IC3ghIjS7reeiSbqRGm01gPAF8jx2RudtxGikvuP75peZ56ZZA/LhqIuMI6eEVPUO9pU8KCa5e9SpkwDSnQl6s11mJ7KbsSqPR77fnnsarEra1u1AJr3WwkiDwEzyhdM1pRIs+C3cIdaHxiulK1voZ0Q+2fNGZezijh7bXWxrnhxYkMG7z3NF0pdV392K0lVgQRS+n0f4RQpd21+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 06:50:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 06:50:46 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Alan Adamson <alan.adamson@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] tests/nvme/039: Remove passthrough command tests
Thread-Topic: [PATCH v2] tests/nvme/039: Remove passthrough command tests
Thread-Index: AQHY+gx8ZHgR4BWYtU+Yn5kl8sTfcK5CrbyA
Date:   Thu, 17 Nov 2022 06:50:46 +0000
Message-ID: <b0db9870-704d-17e0-f06a-34c638e426f2@nvidia.com>
References: <20221116223945.1043785-1-alan.adamson@oracle.com>
In-Reply-To: <20221116223945.1043785-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7364:EE_
x-ms-office365-filtering-correlation-id: 3ce7c7a9-f3e6-485e-4ec9-08dac8680dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +whkVyLFNpkVxRacWvK639H470nD/F9AoSlV0j/2ufHrq7V0B0rbNoKVfSRZAIqF9zaULLjyijBsy/vzBqyONhjZYTz+5gVwC/RgNMB3DhaUCxs9xmraaHrvEF0j8ZJqomsML42bxFcA9uMvue6KVSzodlJlXk9lT/bjlxvAVd9t1GF2KF+iPq5kWZrDzrx3ySZ3hMR+DGDSO5bXOpp62KuAaWJjkXQ1TsBRwQE0D1YfDSPeSN7zWcDHhxWLnDoQ2gb9enPoKymsqm4i0SABq5zYQRRIg0bb3jAhkXLeX75jZuKuO6Nctq8xQ7hhVWi6NDPp0kQBx2gVzCNWLnD4up8CXC4p8+pWfS0FvAf3dFNZsRL75PmTK6fkCqOCmD+uj1SCDzHMHkxp8hDAh7chYBa80M7VlLYt7DR0W56D3TbLIwnEu864cNaiKJDqNF/LqrTjOSDopipB7Qwfo7GDeg+HeePlNmnW6QDW7A71+MMgatGS5+lGEBoGxXoAOJgKl+J3rgPlxhtY1UDT6uzXHjyLojVVOih0Z4z3/EQLWr8wHyfAwCtxccUvB9JD6wXcOcKRhzP6iZPAyL5yABrR4qPwKcwCMlfotL/PDZl2QpJqGqXXSiAcOxgeLzAmFKROUqtOLkumk6wdP0TImI6F78RMwCh5tEcanK7rWZyezfZ2crnnL4wD5roqpDK/MwdYnto8wyrnYhNgvf8MDBD1CynNtub+FWloJhdui9uNsQRakVdYGp6zRjtvq83k0LTnje6mFjcl6gxua39wn+JnUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199015)(2906002)(31686004)(4744005)(8936002)(5660300002)(41300700001)(8676002)(31696002)(83380400001)(64756008)(66556008)(66476007)(66446008)(4326008)(91956017)(86362001)(76116006)(66946007)(110136005)(316002)(71200400001)(54906003)(38070700005)(36756003)(2616005)(122000001)(186003)(6486002)(38100700002)(6512007)(53546011)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVBYS3Y2K3llZlZyMnlnbXd5QUN5Ry96V1YwWnIvdVNsaXE4OERYQWJ5VmJE?=
 =?utf-8?B?bVJkcXJ6MTk4Tm5icXI5b3FCcHFNYjNrZ0I2VVBNczhaMy9hRm5PWUZhbjRk?=
 =?utf-8?B?TUtwdWY0em5FZnk2K1cybTBKNDVkV2VHa2pzVWFuUVB2WmZKaUVqQkZzdW04?=
 =?utf-8?B?VkFiMkhVSlg0cVQvbnBpamNRaXdFZzJZaWFoVGJSMit3U1RqbG01RVJmTFRB?=
 =?utf-8?B?UEUzQTVXWEZRVVJIVlJtSEZzaEhQc0YzVkErbEloVWlobVcrNVcwUS9hdHZE?=
 =?utf-8?B?WUZhMWN2MXBRVUQ1cng4V2xnQ0duUkhRQTVQdzRIQUNyc3JuN3NadENOMDNE?=
 =?utf-8?B?SWIxc240VnB1aXQ4QWlWWTMzV1JqWXM5eENYb0tLczd5ajlKQWo4UFVlcXR0?=
 =?utf-8?B?NVdBZGx2SDA0cFZSRkxucEE4WXBCdC9kdWJ3dXNiMTB5TGczbFRtL3pJVW1E?=
 =?utf-8?B?YVZnNnNuQi91cDVUemg3dzFsK1FCK0prNWpvZHVBZ2FVY3hpY3p2TWwzWFJx?=
 =?utf-8?B?STB2a1lPM3A2aGMyeS90dGlsdkhPQnlpM2YzeHJsOHpTeE1PSEtMMXhPOHox?=
 =?utf-8?B?TnliZi9TbUloMTNpWThpdjhBcTBkUFdWSVN3R3JXY0hZK3lyMXVrY3NqTzZn?=
 =?utf-8?B?TUFud0dSMVlRMDBDT20zNTRYZkFUVjEyREkzTmZKR3RwNlhHektTaHRRNTkw?=
 =?utf-8?B?VGdIRU9Bb09udW1JZkkzMGRseUcyd1MycDFHc2xlSDlYay94eEtFcE10eUZv?=
 =?utf-8?B?akk3VkhhWTkxZU11SzVVS1R3RU80YVZmOWNEeVRxeDlzQUsySDZNRUJ1SWMv?=
 =?utf-8?B?VkYwdDNwU1VCZUJmNFp3amVBd1R3UUJsOUJBbGw5NHlEQzVidFk1Z09DWHpI?=
 =?utf-8?B?R1RoaWFrU2pMdUQrZ09KWFN1NktCcUdENUhocnZqS0hCVit1TlpEbENMSG5J?=
 =?utf-8?B?TnlZcW94ZS9lRnk0Q1Q2dE9tYUhuSFhKajJtM2hYZkZ2enFRYkJ5dllVWE1Q?=
 =?utf-8?B?TGx3ak4yWlF0YUl5ampRQklveTNjK1VvOXkrYzVwUm5SSnpHb0NWMkR5OFhw?=
 =?utf-8?B?OGRNdTZkd2g1dVRUN1RWSXVwMFQ2QU9oVVpVc1Y0TFgzM1VaVm8xT2o4LzFl?=
 =?utf-8?B?TE1zd2kvQ1JFd3d5RktCS2x2R25qTUUxdGtDMWVKUFhIOHhNMEdNb1VsSGEz?=
 =?utf-8?B?Tm00TkdmUmsyQllWT3RJa3NSRUNpZ3JsbndoOEZtVm9KdlYzTlpNMklnc01r?=
 =?utf-8?B?YnVOZzRzTWZ6MFdFSzgvUitSdTllVzRBaFlQVHhUVWtuQmx4Qk55aERLQmZs?=
 =?utf-8?B?dm1hcjF4WGpKTFVCNE9Cc0xqdGx5SXFPVXprK09uMzdsSFhWSUxYNUZhYkU1?=
 =?utf-8?B?eDJ0ZHlwbmVXUlQveWhTVTRHdkgyWE1wRVJaZm84ekxFaFZyNFN6WFgraDJ2?=
 =?utf-8?B?em5rUlkydWhid21YYkJBMEdZbHNXa1drWUxuazRtK0JYRENDVGNRV0FiYjZI?=
 =?utf-8?B?OHp3M3BRNm1OaEdoRlNNNStjNE9BR2REbE5QWWtWTnYwYjJCN2hsYVBuNVd2?=
 =?utf-8?B?RGk1MkJxUnFFL0ptWEhPWElRQVk5MUV0Vis1UFVtUmNDOU1aaURpZE80WVpv?=
 =?utf-8?B?YnZmdGZXOWdjT3VCZS9aRjkva0xtaGZiK1JNdWEzWnpSdVBzUlg1WXVhMmND?=
 =?utf-8?B?TnpjRHZtY3R4OHZYam4yNTNpTjQwZVFaM2YxRnRmWGtiRmt4MEttbGVnUWY5?=
 =?utf-8?B?YUhBTFRnTW9YM1lCdDM1UkFWekc4eG1pMUZReHo4Z1lVb3ZXY01wSDhPWEJi?=
 =?utf-8?B?ZkhGdkJQcmpFWUNkdnVnelBxbnVZWTBRZUpOTkhjWVUxY0dVbzVlUzEzVjlh?=
 =?utf-8?B?Y3FRWGZDUkp3aWVtN1JSU2xnYnpXaGh1UUJHSEFRQU91N2h1ZndwUWhXQjN3?=
 =?utf-8?B?aHQwMlRtVzVVNGtHakVXb1hWem4wSDJuMzlCZlk4WVloVzJhVUFuenc5RktR?=
 =?utf-8?B?Q3dPV3R2WWFZQTJCaWxHTTczOStFS3M5TGVwVHFMZmJDakF1WE9seE9GQXhy?=
 =?utf-8?B?NnYxQmJoc2FTZ0ZzV3hTbmM1Ymk2djFiRWJJUC84cUZaU3RDTlJ5Y2tmY3py?=
 =?utf-8?B?V1hwQXBja0trOFNZaGNmMVo1bk91RHN6TEIzd1lzN3ZkV2pkeDJaUlE4VWZL?=
 =?utf-8?Q?ye6iffBQJRmdhmxbex/l3VFPuQGMV/DhMzamDEblU0DT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D09130E8F4FE1A4AA65F76087D0DCCDA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce7c7a9-f3e6-485e-4ec9-08dac8680dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 06:50:46.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtM3GDWgT3lhMnQsCbeu2mtd6NVyzWjHxNWnUWpH7g2c+hwYsa6W1zCx1NJALL2ezbUvcvdOH5HvQs6nGxBPYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMTYvMjIgMTQ6MzksIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4gQ29tbWl0IGQ3YWM4ZGNh
OTM4YyAoIm52bWU6IHF1aWV0IHVzZXIgcGFzc3Rocm91Z2ggY29tbWFuZCBlcnJvcnMiKQ0KPiBk
aXNhYmxlZCBlcnJvciBsb2dnaW5nIGZvciBwYXNzdGhyb3VnaCBjb21tYW5kcyBzbyB0aGUgYXNz
b2NpYXRlZA0KPiB0ZXN0cyBzaG91bGQgYmUgcmVtb3ZlZC4NCj4gDQo+IFdoZW4gYW4gZXJyb3Ig
bG9nZ2luZyBvcHQtaW4gbWVjaGFuaXNtIGZvciBwYXNzdGhyb3VnaCBjb21tYW5kcyBpcw0KPiBw
cm92aWRlZCwgdGhlIHRlc3RzIGNhbiBiZSBhZGRlZCBiYWNrLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQWxhbiBBZGFtc29uIDxhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbT4NCj4gLS0tDQoNClRoYW5r
cyBmb3IgZG9pbmcgdGhpcywgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
