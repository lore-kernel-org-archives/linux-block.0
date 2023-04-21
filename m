Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9CDC7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 07:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDUHE5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 03:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjDUHE4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 03:04:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51C30D5
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 00:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnIJIfGvk4FuXCSh5Kq91DASkx/TAXvbekNGU59bERW1jPsBFX3kQh5148Qt8eVGUsenZvU1gQww2kfBeXZEnxr+WaBBYDhgAUAWzpWD8QvZOPuS7EGOYuj5wlxa0br1yZ8l4IWON4uRjbohuzI/ynMpvk9hn9guDZBrNeckssp7qQ59ipLtSW7nnE/oJ68dtkMtYCOtEqIASu5so4qtndPe7gTan2t5N998zwgZIpYSKjnRUiVJ3NcBH95k9KgUClRbbBfpbEjkMLKXgsKYm2JOAunw6KJr2EJtf2ztnLEA9JetQdFvDgickarx/9tIbbxndI0562GSJN8JxgopoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9eC75tqA3getuVCETHO8PJi+5X3vBjWDywWhu4CH4M=;
 b=kzzSB0MY6EsL1rbbseILxTCfrmVwCXIKFPwGoBAU1F0kx8q/IU+BlPJXzvdix3eLtvCP7MVaEpMkvhNdRYMGne+X+jXVfDXeszAAW6S6xB9NgrRUG5e+FJGG9QPUc2I4iEUfYXp7InmN5EvhZY41lH7nFOPedGjAVeyrzvx8q6tqKuvLsZnoA1UyKLvHXj7KZBvjvhAaG+bDBcKpsZrByXL4NtYiLpyGwMYhhS/osUQtHBRGLra17dr2Uxn7PfHIk03wYJvO+zfao6xIUIlCzCPvYwmO4SvheaE4pfKHJORqfFUXZGpQh/sqFN8quZjFtA5aR60ziIasP08uBUIdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9eC75tqA3getuVCETHO8PJi+5X3vBjWDywWhu4CH4M=;
 b=FLk4BKq02g75LtHRLr/xtzBEaPRKTZg+qgl0nxzzqyFf2OubyFVx6h4jgpn30dEt0Ubj5LAAiHtlfrKRgrmVLQlQEQbqHTdFQ3xeyleruv8UX0n3FXd7KiODtMZcodSdqDQZFtx+o+aPrwXnc6Yq6ag9IM/Lgi8n8+F28VsfsH8D25r7b3Jlue1gFi8O9Qn0vV84HceQStmdWkvIz9DXGrXDKQ0L+nDBRdiw5E1B5JZFhWLM293Q60FntsRdW3CAdp/4GGbDNebpoBgu+sVC/pOvlxAmRQ09yXaj9JzvgoX9TU1+R02BVTh582ZH50Or9bYJu3xfxAQ8J8B6pGhzzQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 07:04:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 07:04:53 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Cleanup set_capacity()/bdev_set_nr_sectors()
Thread-Topic: [PATCH] block: Cleanup set_capacity()/bdev_set_nr_sectors()
Thread-Index: AQHZdAobpiZ6hSlQo0ayIqItzE7DFa81Vw8A
Date:   Fri, 21 Apr 2023 07:04:52 +0000
Message-ID: <1d4c2210-b35b-1f62-cfa5-aac7d176f573@nvidia.com>
References: <20230421043101.3079-1-dlemoal@kernel.org>
In-Reply-To: <20230421043101.3079-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6625:EE_
x-ms-office365-filtering-correlation-id: 1b503874-eca7-42f2-2c5b-08db4236b4bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnOn2RLKrgNqBJ+trFu160vOkgRZviSn9ZzjORc58Hy2q0nIrydDpqhdW8JkEHDTVZ1p5BBtQwka3TzpiHyDTlQl5kXbNxTtt71tJov1lDO8gm9uBXKAn9zQdxqTUQxm5ZbTLlsZ2HZB7zdxbLXJI1/rwyeWmL/zY1kxjbKCGzWFTt0wNvCoFdWKJZN82Yb8A9hlqxaBciGL1tNHiakA6xG3VUmAejZXaFhL+ZIxsFbuNRfe+cZZcHx7qrG6vPmjS38Jave7gWvAWGV1nOyWTM/MQ4ZJvkOdkQ/uHB+SK+FrFLW92+DRIntXo+1yBnmYNjCg/N6lGnchOAKyel+E9H+E8ZijJ8LgOHi8Uq2BO0SHeI3bGqa8uhEQQ5lv294Fo40keHxEfYr4+2QXy8sTm8zUaDEzOwtLhG34zEKHsmsI35wk3S6Gil9o7vl+8HRYoDlftxhQoNiZGfRTBdOKp7y/UuJSkpx/ZhMtAaOqp/i8HT8xuyDKLW2xxkrAVrjhJYzXccvcQPAimLly3ojQfLU2NRmdLG/ACWHr2bKb7otqFqZtBJT62ek8jLqukZmVcP6ZAPHneYxlYNKerlJTGV0Y3H/XkKPMI/mpv/9Wgc6ZmAgye2h7PohdYUDyRL+TVKzc7sYiCKzBe8EVd7I41A8QnPD943R2/0MmL0GTcPFJlWN2pdAykkxkFnYi0GBo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(91956017)(110136005)(6486002)(86362001)(71200400001)(31696002)(478600001)(5660300002)(36756003)(2616005)(8936002)(8676002)(122000001)(2906002)(4744005)(83380400001)(38100700002)(31686004)(41300700001)(38070700005)(186003)(6506007)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXQ2N0hTNHBrd3RuL2NlNUFUTTVFQlN3cXQwd1pEbFpHQzdWMElIZEhPV3FC?=
 =?utf-8?B?SC9tK3dpWVpNYm1BUzZTZWF2SmVwSnArK2V3NVI1cjFJTVFhZ3JCMURlc1NY?=
 =?utf-8?B?ZTdaTVIrbWhiWG93d0o5RUVNdzBvOGV3WXBBeGZ2N29vbGpCQSt5VEVUNllU?=
 =?utf-8?B?RCtDQ01nNnVoeTU4RXlpelg0L0hhVEZZMHEwWU1UNmZZemFpUUFRR3BhU2c1?=
 =?utf-8?B?SWRWM1Z1U3hVWWxMUVRPeCtOaHhaS05OaG11YUw5cDVtU212T1pOVFZNM3ow?=
 =?utf-8?B?UWFVM0Y5cmgraCtIS0ZCK0ZQbjR5YjBGWXdHZlRDNzV5TlNWLzVkSlN4bG4w?=
 =?utf-8?B?Tnh2L0NzSU9GdnBqM09Nb2s2Y0lRZzJSYlhmNitXZXhGVTZTQWxJN0RzdUl5?=
 =?utf-8?B?RS9teXJYU2JpMktkU3VOUmROZmRKZU5MOWZ4dVo1bHo3VWdjMnZhWXFaTEFl?=
 =?utf-8?B?VnhER0g2bVNhUndzdno0ODZZNXNMVlQySHQ0cFk1eXdKeWllVUloVW4rWkgx?=
 =?utf-8?B?MmtRZzNIaFV3bzk3NXE5dnpuTzNpcE5pY3djRXkyVDk0dkszYW9ZV3k5Wmhs?=
 =?utf-8?B?MGI0WlNqUEZYN0FkVEpDeEg3SUtpK3FsZ0l5MWtQZGp0am05aERaL212bWNt?=
 =?utf-8?B?cHV3M0Z6NWJVemNkQjZnV1RTanRBYUlsRG9YZHJGaWZtRmwrRjBIQkNzQnFz?=
 =?utf-8?B?cXRBT09Ra0VHcHJqODV4ZHB1OWZoWCtwaXd5ZmoyU29iWkc2Mm1ZVmVjTXZk?=
 =?utf-8?B?cklDNVdpOU4rUkVmUVl3aHRHMm1WenlWQlpLWnR2OWNjVXlwSTk0alhIS245?=
 =?utf-8?B?OFdiWW1nOWtsQzhhL0p2NkRLTDk2NjVoNzZWUGZndDdoT0RkT09nZ2dMMDRF?=
 =?utf-8?B?R29EQmx1SFdjSXZNbjNjZzl0OVJLcFFlQWw5RjNkYWt2NFlENmFSUWdLZExF?=
 =?utf-8?B?bFV0Ynh1dGIxMXMycjRWQVN0V09GZ1MyQ2I0ejNYL3cyKzc3Tkh6ZVczbXBY?=
 =?utf-8?B?T0tTN0pEeHZLbWcxYUF1WjZaZmF6VDVEcWIzZm1BV05FWFJmM1hJUm9wbHRt?=
 =?utf-8?B?QzJ5N3NFcDZUSk9TNFhwaW1TSFBXUFdBblAzVmdWZU9mUjJiRml3Nm45cVFR?=
 =?utf-8?B?M25DemJ5VEM4SVlqbFBpa0trZjZWM1JZbzlNeW5LUzY1My81M0VBby83VWhm?=
 =?utf-8?B?ZFV4VTViU2FFNmZvcEx1MjViTmgxU1lnZXdiWVlGeGcwMENlNGtNaHN0d3VT?=
 =?utf-8?B?cWcyL0xsTGlVU0xxakZCTjBmNGMrNVRwVGFmemhrR0hMYmJKaUJtbk0yeGpV?=
 =?utf-8?B?RWk0TDA5SWxBZnQxOVdudzYvYkJlUHNSMGN2MXB4NGQrMmYwZzBYNHdWMTVX?=
 =?utf-8?B?M09teHlDTzRuOHZGYzE3RmlRU1NqSWJwaFRHS0k2TjlJcXlHT21jWUxNRnNz?=
 =?utf-8?B?WmMrdGl6czJ5a25KY1hXNjFVZUVpbVZrdWdRcUpPcmo3bTVMbDJjb0k2SzNN?=
 =?utf-8?B?dE00VkZQOStSTHZjQyt1QUhJR3VQc2NCWm1ja1IzY0ZyMmZHSnAwSjJBVzU5?=
 =?utf-8?B?Mm1qU2lPU2MxZjdwZkVteEczZ2JwNnY5ZVZzbG5MdDRTcEFKMkRCbXlUditk?=
 =?utf-8?B?a0MrQXFXdHIwaGloZko0cUpWNG1rTDQvS3czcmNTZ2hNMERaR0Qvbk9XQmZq?=
 =?utf-8?B?RUFVZnJQMFNnVzRYdFVBUEFGRDFqN3lMMmRQT05UUjdoTDdOZjBDKzJvM2I4?=
 =?utf-8?B?ZFRaaHZqRE1EZFd1L0lKZE51MHY1Qzg1dW0xY1Y4R3docmdhUEVRY2dibU1G?=
 =?utf-8?B?MDYxYVFvMmdUYWJvcmxBbS9JbGxzSHFZS0RPYngzVWdwQkhSMlRaL05Bd2Ry?=
 =?utf-8?B?VjM4SkRPM21Nd0R0dDdtejlNWG5WQWJOYWdrTXRxMmhPeHVPQzF4T2Zhayta?=
 =?utf-8?B?VnBwTVlUZHE0UWVQckk5dmJJUGgyRFV6UitlMnpXYkU2cmpReEwwb2F4Y1ox?=
 =?utf-8?B?R2hhVy9yaitzdS9LaHIyeWN5aHhvUGhJbVBpeXdIYTNKdk9KOXNDaXpZekQv?=
 =?utf-8?B?VkovNkpDVXo3RE9rSEtCR01nRUFoei9ZbjBXNU1WMHJPMjdwOEcxbVBFTVZP?=
 =?utf-8?B?YjB4NTVzbUxxQnhnVDRxck5DbXNCRkFEWExVSTQxRFdKSU4wYmJpQkRDc0tN?=
 =?utf-8?Q?utK8+Cf5J91T0K1HCMYUm0tgRJj8kBmrkX73RlKu3Av2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93A3618642C88E43A81032357D4B6CC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b503874-eca7-42f2-2c5b-08db4236b4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 07:04:53.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yvw44l3/jOW0FQQ6InkAcc5iHwyuF8IiihKjeiNDsnXjJRa1QsVcaWCm38zFn4Q3wUseKKrskH7AzTI0xh0Qcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yMC8yMyAyMTozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFRoZSBjb2RlIGZvciBz
ZXR0aW5nIGEgYmxvY2sgZGV2aWNlIGNhcGFjaXR5IChiZF9ucl9zZWN0b3JzIGZpZWxkIG9mDQo+
IHN0cnVjdCBibG9ja19kZXZpY2UpIGlzIGR1cGxpY2F0ZWQgaW4gc2V0X2NhcGFjaXR5KCkgYW5k
DQo+IGJkZXZfc2V0X25yX3NlY3RvcnMoKS4gQ2xlYW4gdGhpcyB1cCBieSB0dXJuaW5nIHNldF9j
YXBhY2l0eSgpIGludG8gYW4NCj4gaW5saW5lIGZ1bmN0aW9uIGNhbGxpbmcgYmRldl9zZXRfbnJf
c2VjdG9ycygpIGFuZCBtb3ZlDQo+IGJkZXZfc2V0X25yX3NlY3RvcnMoKSBjb2RlIHRvIGJsb2Nr
L2JkZXYuYyBpbnN0ZWFkIG9mIGhhdmluZyB0aGlzDQo+IGZ1bmN0aW9uIGluIGJsb2NrL3BhcnRp
dGlvbnMvY29yZS5jLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9h
bEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gICANCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
