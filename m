Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C5DC77B61
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 08:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbjD0Imk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbjD0Imj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 04:42:39 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D949F4
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 01:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0yvC/TPqKTahe8l5hhQK4VoQUEHXFUYRcJ9aV2JuqbdfFiMjwZDH7WImBzPfjurDfOdFqaRa+87srWrGze6JZnziimuuSzAFETJs4rnefLcJLLcQDH4VtmVHl7F+8srUHGqn5j4f3btc3jruWi4axvRFkCG7t91MtKcq9SAyISs1cKOp65tzeN9scQr7vwOwbMYuCEmA4oTJZXQFcQlqYsyHc72cCty5qgHkBmB1eHu3h0MAG0eqFPm1runXdRQXfrWD6kysk8TEq1m9ntV8whrLRYeLKARlughwIhFQdOSLAPKggjCIWvplHAf1NZ9Ma/q0Qi2yr5HCJ+r+v7MEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=befy6bx1x5K5a9BnkVQK2nga+0jjBaHbNhoHbMFgA/4=;
 b=QlJZmrqA99Clmqyl+Lsrc5E5X0T63zZ0JbSI0EI1+olCVr9aVgw7zgdW+6P1HSRluk+4OfdQOEACBp+6YLic1cvphtqkjLE76MEY95ZZd2oAYLJz6LxZr0dT/yFRU5OlEyQNhuUl3KbhsPebqiKvY5UV7zRgSiVr5f4AbqZugU/N5g+c06cgsBjuhhRecLyOu69O8SNDiBobrWQjDqFaZE7eL5582ZCA/1tZOfLs1s/Q0H9pd7mRLI9V4CjwJpsrzUDzboVi96tEeBdVxMd6UHwKPSj+vqpOPB00p8vS1hyXyNHIp3rUssvhArvVsZTW8Mb+YTgoAOqqiCkfaZ2bUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=befy6bx1x5K5a9BnkVQK2nga+0jjBaHbNhoHbMFgA/4=;
 b=QXSwi8SsVqxTiKIXDj8YXDlqoBybhcttWgEkYUNRwokCxDG+CCvrl5rQ7OyWzamHALUdQ+OKqhSAxkGfK28s14dM12LPinepGNApTXbQzIMAYPVi52J02+kvBaewe9rl2nqr8QrNwQ0lb5tYEvFx6hNIyN/95pd6boE+1r2hlWfTLT06ZqfaXpk4OBYmHFqIs94q88JWhkOrdu+dkUgZz2PNHaBUrnkelrEIhjcxwnrN8iYmByrWE3MVjsRWuW/T1n0P64pfO37zacktC096omtdRC4sggnO2fEES/vHUlm/uIm3Tq7yRa5tiVJy9fivBF/3wNi+wezAu88TF0ZWlA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 08:42:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 08:42:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] nvme state machine refactoring
Thread-Topic: [LSF/MM/BPF TOPIC] nvme state machine refactoring
Thread-Index: AQHZeNnTtoFlyfCYQEyQS7X48Kt18q8+1rgA
Date:   Thu, 27 Apr 2023 08:42:34 +0000
Message-ID: <9adc17de-5159-94bd-abd5-e52a09e9e3d3@nvidia.com>
References: <dkxas4hwmnzknde7csbnuxwtk6odsaptj34hj7ukz4kh54h45n@6aiz7ghuf7ej>
In-Reply-To: <dkxas4hwmnzknde7csbnuxwtk6odsaptj34hj7ukz4kh54h45n@6aiz7ghuf7ej>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7196:EE_
x-ms-office365-filtering-correlation-id: 743c711d-ed63-4e40-2323-08db46fb5912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQ9te4i2cPlHiVLdsWnVIbsu60kEduwmprIqkhXJqGyVtHuW0hh/mHp7FbAiFaFZnYOijXb3srCG+aj41EKYahoyXxOsXB486a8dLbRCc4BwdP4BOUBuEnE4YnZxkiTDTUw8W4Oycy8woue/nNWZwjrIdW9c0kaguFlNWfaky5GC2ceDMMw+ZltLAkMMyvJz3fNoOzWh+OwBojECaQZfMBRIzdRHfRjLx+0gXu4SwbMjCvLWhXWIWPPg3LW9XcZk8xxSf6uWTkESTf64tmhhM4CIjt1vThs5Yp8vKKxU0hZL/d5H1dXDkFu2yPEJ8PMYsYY5dOHq+GWEF941Qc0f2/yEF9cXcOi0X7UdyDqwIUO7Mc9do2JCvGK6KX6iz1Nv7CN3B7AD7dmqfiDwNmyCTssI/i2W2lLsszIUP8i/NVInJGsGh9AWxxjMYYeDlSJ2dKWIAQB/GKjImzurdzSvoA8YrOiRG5N2TGRJQ3yddyobRMCf08zshIkc4X7L9PJfWtPejwSpfvskOdFbDqmN14FQ19HzFAkZVqWPdE+UZDfwZ5VP+xjZFYlagRWCEouLb7s+PnwJmT6SDjZVrsMd3ZLuAZFbRoLR0VGg6uOz6gZ7fJa3lvARnmI7l7081mn5WMzvtrPF4VyZ1+ZiFiB2Isg4L82STy6/cniIUNTm/B5uZukURw5hUqnQH8XNtBYAZMUfzqbvAD2vAoIQuLXTdwH33S1sA/kxi6oCNA3BA8v53NH3j2k2anwxQXREF5Ovmr9hsKa++GM3AyEmoCsBcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(478600001)(5660300002)(38100700002)(6486002)(966005)(122000001)(53546011)(71200400001)(186003)(6512007)(110136005)(91956017)(54906003)(83380400001)(31686004)(6506007)(2616005)(66446008)(8936002)(8676002)(41300700001)(4326008)(2906002)(76116006)(316002)(64756008)(66476007)(66556008)(66946007)(38070700005)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3g0KzMvOWVwWElWZ2NXdllhN0o0MFg0aENEcStaUEQzTjZ1dFJtSXc0czhu?=
 =?utf-8?B?elVNU2VkL2RWc21COGtXR0d5RUpqVGtRVXQ5dkxwQUxxNGQxUGE0TTFQdmhk?=
 =?utf-8?B?d0JudHdzNHZnS1BBOVptVTBJNHRDTTJERTdOTElsc3RuS1BtWUZ2Y2czWTZu?=
 =?utf-8?B?a25udldNRC9UTWNjU1lpSGY3alVKbkZtTTFZZ0I2TDRvbk5aWUdja05vLzI5?=
 =?utf-8?B?ZEZQQmhQN05NQmoyRXFITUF2QU5ZU0Q4b3Z6TFhzc1JSV3ozak96bWlsaTNv?=
 =?utf-8?B?Rm10VmphRElXQktsODZINWJWbUFsYmlRVCtDYm1lQUxJUmVmVVA1ZVNrbjhs?=
 =?utf-8?B?dmRUbTUxa2U2S25Vd09ieDVaV3Z6RUhKcDJ5WEhKL2w0S0xDZk1EdTl0a2xV?=
 =?utf-8?B?czlzbGNmeDUzak5DWHVxVjVoS1ZYaHY2VE9sWC9lOHdpd2ljOGxPRGpFM1ls?=
 =?utf-8?B?bWZuWjd5dSs0U0FQTDVoNEhLK1VKTzlVOWV6Q1kvOExEYjNyUVQzR2UvSDM3?=
 =?utf-8?B?bHorY3c4RVFhV1kxVGo4QWlYNmNJczZ2L1pvOUdrVFJ5YzNnazd5VHZMWXhF?=
 =?utf-8?B?am1rdUM1bXVxUXZOVzBObDE4VktyaVNVZVk2YWl5ZWc4cDhmSW5FTkpBa2xs?=
 =?utf-8?B?NTZBQytQVVh6NWloZjZRRnVteWxIcHJablJGeVRqei9OcGdRQ21YVFUvMnk2?=
 =?utf-8?B?R1pMc2JSQklYMnhIUzlCWWlKY1QwM3NnaGpQaVZKYWoxb2xHUUxIbFo1ayt2?=
 =?utf-8?B?K0VuNVoySzM3M3J4UGI0aUFPb0xMMmpxMjZvK01heERBVFRjUDg5aW1XdS84?=
 =?utf-8?B?dGxBTllRS0x0Y0hZdkFRZlU0aHM5Vi9wTjRISSt6NVRDVG9XYjVKaTlwYmpR?=
 =?utf-8?B?UEhEeEpxdnNGTTFIajk1Y3lJY0VWdmhNS0tSRm84WEZRVHFpUHdDQ1NjRFJ2?=
 =?utf-8?B?WkJlZS91cHRabi9hWi9sUE5xUUx6NE9Ec1RkNkIvanNYRElzYnZLMXpYWnBT?=
 =?utf-8?B?UllJVFVuNWNwT3dVc1ZwTFNVbmh4ak1YcHlEaS9QdU9hbjVsRFpTU1B1SStP?=
 =?utf-8?B?eUVqakdSSTN6ZWptd2xTdW51SStiVXVWYThuMitJWlRHeW82OFhVbnhmdDRp?=
 =?utf-8?B?eGJZZUlMOUNTUE5RY1VDS2puY1JwNDdrV3FvYjliV0VGMFlJamNzZDNXUWZm?=
 =?utf-8?B?Y1RhcS8zd25UVnNJWE1wY1Rucm1qeUcrY25WMjhkQXZueWtET1JSTVRKcEND?=
 =?utf-8?B?TWhLczBsMmpMN0d5aEx2YUQwY210Y2tWYmdySHBCL0o0Y1lXbHZISmViamp1?=
 =?utf-8?B?OVBRaHhUVWZQbUUrL2JIRUtJN1dyNDZ0eTZoSlYwTDlOQUdyNytVbVVMV0hm?=
 =?utf-8?B?SGlGMmhvT2d1YzhxT2YvWEVFOVgyTDVFRVJuUlRBK21jK0RmTE9DcW1NZkJn?=
 =?utf-8?B?Wmw1MS9nM0o5Wk9KRkxWaXhQcnQrQ3ptWXMySldzd3lZeVRCcURqUVdGYm5Y?=
 =?utf-8?B?WlhMdnZZMGgxQnlROTBGeTFpWTlWdWJSRU44TlV0TGZ6dXJWQVN6MFkrK0VF?=
 =?utf-8?B?QzZlanF2MFhaMURqTDJkUTZsWEt4Snd2cTdONkhsSCtqaENRYmxVQlUrUFUy?=
 =?utf-8?B?UGZHdVg3cUxabURYK0E0NmdTeWRPODQvMXlRc1JyNnBSek1lQndpT0w0cS9W?=
 =?utf-8?B?QUgxSUZrMnphQzdEVThxTHJ6YkRtTXErRW1Yenh2Z25iQ1FiUDh3TTVIZlIw?=
 =?utf-8?B?K2NpRUo2emlGMXZWUnlKVzdGdXZQNTVFMWJMRm9ZWVZUQkJwUXJRQTFKQzd5?=
 =?utf-8?B?SXVKbjhwRzV2dU9ERk41RkRqdjBERVRGbWFDVTJNd1drc3R1L0ZqKy8vUHRt?=
 =?utf-8?B?V3Y2Tno0NUdiK2NuV244ekl5SDQ0dzBMMi96T05ja29kcEdMaG1EWlZNYjJH?=
 =?utf-8?B?VmtuMGpyaWZTZDFTQXBHSmUrcTVUSCtmWHlyNHIyWFVFNHNROFhra1psUitF?=
 =?utf-8?B?VVFKcytIRWl5QUErQXFCMVZzVjNyZzk5U1JhYWE3ZU51RHJ5YzJzQ2xLa1pl?=
 =?utf-8?B?SFJqTTBsSVpIMjJXblB4Nm1pdG5aUnE1Qm5FUHNvZSt1a2I2NzJCN01lOXpa?=
 =?utf-8?B?ZXRQa2VWZUx6eHJJRkpJV2JqNjdyOGdKTzRLcmk2RExzU3pmZmpWcGZVd01D?=
 =?utf-8?Q?z5pvbrVwLPcqiWsiZy+PzH11WhlnoeVBbfTa673GQjd9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8FD29E92830084EAD947C21793E51D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743c711d-ed63-4e40-2323-08db46fb5912
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 08:42:34.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1JHDTZp1g54DOtAfRmm/HLUavRja7V0tstUw2MbjqD14wJNTqXuUsSyl0q6oWCIxBj1G51vS/xO7QKl4lgKhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yNy8yMyAwMDoyNywgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gSGksDQo+DQo+IEknZCBs
aWtlIHRvIHVzZSB0aGUgb3Bwb3J0dW5pdHkgdG8gYWxpZ24gYW5kIGRpc2N1c3MgdGhlIG52bWUg
c3RhdGUgbWFjaGluZQ0KPiByZWZhY3RvcmluZyB3b3JrIGluIHBlcnNvbi4gSSBkb24ndCB0aGlu
ayB3ZSBuZWVkIGEgbG90IG9mIHRpbWUgZm9yIHRoaXMgdG9waWMsDQo+IHNvIGlmIHdlIGNvdWxk
IGp1c3QgaGF2ZSB0aGUgdG9waWMgZHVyaW5nIGEgQk9GIGl0IHdvdWxkIGJlIGdyZWF0Lg0KPg0K
PiBTYWdpIHByb3Bvc2VkIGZvbGxvd2luZyBoaWdoIGxldmVsIEFQSToNCj4NCj4gICAgb3BzLnNl
dHVwX3RyYW5zcG9ydChjdHJsKQ0KPiAgICBvcHMuYWxsb2NfYWRtaW5fcXVldWUoY3RybCkNCj4g
ICAgb3BzLnN0YXJ0X2FkbWluX3F1ZXVlKGN0cmwpDQo+ICAgIG9wcy5zdG9wX2FkbWluX3F1ZXVl
KGN0cmwpDQo+ICAgIG9wcy5mcmVlX2FkbWluX3F1ZXVlKGN0cmwpDQo+ICAgIG9wcy5hbGxvY19p
b19xdWV1ZXMoY3RybCkNCj4gICAgb3BzLnN0YXJ0X2lvX3F1ZXVlcyhjdHJsKQ0KPiAgICBvcHMu
c3RvcF9pb19xdWV1ZXMoY3RybCkNCj4gICAgb3BzLmZyZWVfaW9fcXVldWVzKGN0cmwpDQo+DQo+
IEdldHRpbmcgdGhlIHF1ZXVlIGZ1bmN0aW9ucyBkb25lIGlzIGZhaXJseSBzdHJhaWdodCBmb3J3
YXJkIGFuZCBJIGRpZG4ndCBydW4NCj4gaW50byBhbnkgcHJvYmxlbXMgaW4gbXkgZXhwZXJpbWVu
dHMuDQo+DQo+IFRoZSBtb3JlIHRyaWNreSBwYXJ0IGlzIHRoZSBzbGlnaHQgZGlmZmVyZW50IGJl
aGF2aW9yIGhvdyB0aGUgdHJhbnNwb3J0cyBoYW5kbGUNCj4gaG93IG1hbnkgcXVldWVzIGFyZSBh
bGxvY2F0ZWQgZm9yIElPIGFuZCB0aGVpciBwbGFjZW1lbnQuIFRvIGtlZXAgaXQgZXhhY3RseSBh
cw0KPiBpdCBpcyByaWdodCBub3csIEkgaGFkIHRvIGFkZCBhIGNvdXBsZSBvZiBhZGRpdGlvbmFs
IGNhbGxiYWNrcyBhc2lkZSB0bw0KPiBzZXR1cF90cmFuc3BvcnQoKToNCj4NCj4gICAtIG5yX2lv
X3F1ZXVlcygpOiBsaW1pdCB0aGUgbnVtYmVyIG9mIHF1ZXVlcw0KPiAgIC0gc2V0X2lvX3F1ZXVl
cygpOiBtYXAgdGhlIHF1ZXVlcyB0byBjcHUNCj4NCj4gVGhlIGZpcnN0IG9uZSB3YXMgbWFpbmx5
IG5lY2Vzc2FyeSBmb3IgcmRtYSBidXQgSUlSQyBLZWl0aCBoYXMgZG9uZSBzb21lIHdvcmsNCj4g
dGhlcmUgd2hpY2ggY291bGQgbWFrZSB0aGUgY2FsbGJhY2sgdW5uZWNlc3NhcnkuIE15IHF1ZXN0
aW9uIGlzIHNob3VsZCB3ZSB0cnkNCj4gdG8gdW5pZnkgdGhpcyBwYXJ0IGFzIHdlbGw/DQo+DQo+
IEFsc28gSSBoYXZlbid0IHJlYWxseSBjaGVja2VkIHdoYXQgcGNpIGRvZXMgaGVyZS4NCj4NCj4g
VGhlIHNlY29uZCBjYWxsYmFjayBzaG91bGQgcHJvYmFibHkgYmUgcmVwbGFjZWQgd2l0aCBzb21l
dGhpbmcgd2hpY2ggaXMgYWxzbw0KPiBleGVjdXRlZCBkdXJpbmcgcnVudGltZSwgZS5nLiBmb3Ig
Q1BVIGhvdHBsdWcgZXZlbnRzLiBJIGRvbid0IHRoaW5rIGl0IGlzDQo+IHN0cmljdGx5IG5lY2Vz
c2FyeS4gQXQgbGVhc3QgaXQgbG9va3MgYSBiaXQgc3VzcGljaW91cyB0aGF0IHdlIG9ubHkgZG8g
dGhlIHF1ZXVlDQo+IGNwdSBtYXBwaW5nIHdoZW4gKHJlKWNvbm5lY3RpbmcuIEJ1dCBtYXliZSBJ
IGFtIGp1c3QgbWlzc2luZyBzb21ldGhpbmcuDQo+DQo+IFRoZXJlIGlzIGFsc28gdGhlIHF1ZXN0
aW9uIGhvdyB0byBoYW5kbGUgdGhlIGZsYWdzIHNldCBieSB0aGUgY29yZSBhbmQgdGhlIG9uZQ0K
PiBzZXQgdGhlIHRoZSB0cmFuc3BvcnRzLiBUaGVyZSBhcmUgZ2VuZXJpYyBvbmVzIGxpa2UgTlZN
RV9UQ1BfUV9MSVZFLiBUaGVzZSBjYW4NCj4gYmUgdHJhbnNsYXRlZCBpbnRvIGdlbmVyaWMgb25l
cywgc28gZmFpcmx5IHNpbXBsZS4gVGhvdWdoIGhlcmUgaXMgb25lIHRyYW5zcG9ydA0KPiBzcGVj
aWZpYyBvbmUgaW4gcmRtYTogTlZNRV9SRE1BX1FfVFJfUkVBRFkuIFdoYXQgdG8gZG8gaGVyZT8N
Cj4NCj4gSW4gc2hvcnQsIEkgZG9uJ3QgdGhpbmsgdGhlcmUgYXJlIHJlYWwgYmxvY2tlcnMuIFRo
ZSBtYWluIHF1ZXN0aW9uIGZvciBtZSBpcywgZG8NCj4gd2Ugd2FudCB0byB1bmlmeSBhbGwgdHJh
bnNwb3J0IHNvIGZhciB0aGF0IHRoZXkgYWN0IGV4YWN0bHkgdGhlIHNhbWU/DQo+DQo+IFJlcXVp
cmVkIEF0dGVuZGVlczoNCj4gICAgLSBDaGFpdGFueWEgS3Vsa2FybmkNCj4gICAgLSBDaHJpc3Rv
cGggSGVsbHdpZw0KPiAgICAtIEhhbm5lcyBSZWluZWNrZQ0KPiAgICAtIEphbWVzIFNtYXJ0DQo+
ICAgIC0gS2VpdGggQnVzY2gNCj4gICAgLSBTYWdpIEdyaW1iZXJnDQo+DQo+IEFueXdheSwgSSB0
aGluayBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSB0ZXN0cyBpbiBibGt0ZXN0cyB1cCBmcm9udC4g
SGVuY2UgbXkNCj4gY3VycmVudCBlZmZvcnQgd2l0aCBlbmFibGluZyBmYyB0cmFuc3BvcnQgaW4g
YmxrdGVzdHMuDQo+DQo+IFRoYW5rcywNCj4gRGFuaWVsDQo+DQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LW52bWUvMjAyMzAzMDEwODI3MzcuMTAwMjEtMS1kd2FnbmVyQHN1c2UuZGUv
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAyMzAzMDYwOTMyNDQuMjA3
NzUtMS1kd2FnbmVyQHN1c2UuZGUvDQo+DQoNCmdvb2QgaWRlYSwgaW4gb3JkZXIgdG8gbWFrZSB0
aGUgZGlzY3Vzc2lvbiBtb3JlIGludGVyZXN0aW5nIGFuZCBwcm9kdWN0aXZlLg0KQ291bGQgeW91
IHBsZWFzZSBzaGFyZSB0aGUgbGF0ZXN0IGNvZGUgTFNGTU0gc28gdGhhdCBldmVyeW9uZSBjYW4g
Z28gdGhyb3VnaA0KaXQ/DQoNCi1jaw0KDQoNCg==
