Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D25C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJJRGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJJRGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:06:54 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FBDE
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF4n6otBm7GTGYKekM4jh87I5SAESBBo42AOHqlXway6ho6zSTyTd7t0I9lpqn2nWTQ8KGA3/iZPuuasxAoCCPGwj6H9fIqbDpE132jRlB3PfHgaiX4UCgY3Ag3YB9FnK8KWQ0j9bMSCh343YLnsBl0F05lS12aQFLLBaOPIwUyVcJ7ioFL801Ufp6lBJ5Z6ywMDF/cH4TbB4rZdm+2Kjn8HtbAeqPM0S3G625hIuWr+KQYpIEXJOemTUEJHHs2G6vIwnXrHQ5YhqyVjLevwdFA3xqW+V00C2b5DoMo3FTA63mbfSbelnb6D1ZbcX0RxJWxtKys/V6he+m8FG5wioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twOz8hjWkITBmIWBASW8FS4w9rIS+iex6FE7Nyw7cfk=;
 b=KUd4DCREScRwyIIGTaMVNmEtPyOYAavuHg9eSne3dk45b/5GOVyypn2wIUgwRZT0lm5qECwinBscmtZ7ItnhQ1rXPCHj3EXBrAGnc3VCGlMpwwmQXhkOL0nbyYLJS2j72bL27qpFlXf0IpLtingxh4i1ZOYb+p+gIh7hr0wrhk0okyHudQ+XxjxwujF2QL0MdZBeD5gsr+ag7OHYuu587wd5CeIfEDvRwt2kX+sJtYMcOaz80X0oWztgzSlYl36R2nHpyND59OI22d9vDmhSloUEC3jAVxGI6cYZeX9DW5PsrWOi+crJ4X4INE4NExWI1Sv+SeP41/ep0WUDEE/pXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twOz8hjWkITBmIWBASW8FS4w9rIS+iex6FE7Nyw7cfk=;
 b=ue+jDPi4CPh61ujwpMGZ1ETLD9TvZtW+x0NDaZ2C/V4aW2kws5wM0Wp5Kg7thln/O1le9HCk8zrsYKzBYl534YdmQo/qwnGB2j/LA0m/8gbiN34BtUKUUhuik1e1ZQvRF1e12YKi9NVOoNCVN0Qwm717jwXE3y6QO56z/Wndx+XZCN1neblsPp43ynrUe9KvBu2ssJp8atihr1gYbn7ZwL2avtVpzLQAzTtod1st5LLJB/Cb62v9Cia4XcUTdXEw29Kc/0rid+v/Dfnpgy/pZOnCwYZX3Au2gTWlEdfJJfzxRILtIoWF5j0QOJZ4kQjjjxthM3IapiwCxW1e01P0mw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Mon, 10 Oct
 2022 17:06:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 17:06:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [RFC PATCH 00/21] block: add and use init tagset helper
Thread-Topic: [RFC PATCH 00/21] block: add and use init tagset helper
Thread-Index: AQHY2GnQylAsnYzxVESweXlteduSVa4DQ7uAgAQGpwCAAJoogA==
Date:   Mon, 10 Oct 2022 17:06:50 +0000
Message-ID: <35a3e4e5-052d-4f96-b79e-5134b4c6cb24@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
 <Y0BvRaVO0iUVmHgB@bombadil.infradead.org> <20221010075504.GA21272@lst.de>
In-Reply-To: <20221010075504.GA21272@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6166:EE_
x-ms-office365-filtering-correlation-id: 30b1888e-2690-4917-2ecf-08daaae1d282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rx/ZskD75IneWMaAQH6pMSAdcCmc/rGNrOsqnlVZCtRbryCRnP/4VSBcx9k8BF4EShwJHMnIFPReMqvjVWr2OmMTZ09WVRJ/8rCf+HUEEpFvyLFr9opxBaxYRASW9DrCyJFWHZw3lH1SPWoSo8bsu/99hRNlBgnvFIL0DA90j8XoPl93j2numyq/IU4XSGyeJ9bSWuP+aipkaY0sVYbLsxDzwCZ+3oJbOjVbU6ld2+U9x5HDafhIx7dCiE3SjyCHGV5GcWo/oWleu1ztf4enYQ6d6Z1y+616Q5m6ERn9YGUeVYU0wtgSsbZ0m9NpJv9atUhjs8Bb/95HV3USVf8khpd0zhaIFtR03TYXlqVc+o4HarsAmcNqBiSRGLYczKHORo1oHcUdRbb4v1OqR/L+sGohHGcZAg4VSPXIX/XcPGAdp8f0iai9+TV2wK5fHtzOQY0eoh/2TqdZbqQArAKoznjrKzEcyIXzndwhRrpBWlXRrz8GNf2HEuavGUo0B1Wc7lcdgLx9hcFrYpSyQJdikIs3pb/SmAx3Luc6uVSQFzBVb5/RkEVz1JeEFczGLTOzcGDI7LOmeiT1ncu7dn7eYH8QUKGyCLsN4UGSiR2U/aTMehazFAJkwIsIL7lXpzAi4ZO1jL59ufY/UhRmOso5hEQFLmaRAXifJ3VxyMwaP/5G2fBnxUV/AYTYgganjSQsz/9JykcNGtZL5+jloVI9JB88+4/jAvIcc4D59vypfOxLl6iQt3M7AXeRRvBx2aJh21JfpoTJrczBDGRacuROGbpnAXODjIYnRGjlCbJQ2ZNPdQtQzO18Eeijgouq/LjSyF9LglkT/ptN/1DbA71WeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(86362001)(31696002)(36756003)(31686004)(2616005)(316002)(4326008)(122000001)(2906002)(38070700005)(38100700002)(186003)(6512007)(41300700001)(478600001)(54906003)(6506007)(110136005)(6486002)(53546011)(71200400001)(26005)(66946007)(8936002)(66556008)(91956017)(64756008)(5660300002)(66446008)(8676002)(66476007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVAzbk1sNnk4Z0U4RjVJVUFnb2o0eTNtekFtTmZvZG55S3hXL0s4cWd2VS9W?=
 =?utf-8?B?RCtkQTBBRVk2MWM0L09kQWhac2Q4MGYzRlNQVGVYeU5aV0NyTWNGOGY4Q2pL?=
 =?utf-8?B?bDhNN01BSWxTenFoQ0hrV2hYWjAxOGZwUGxnTjIxRVJndXBsRnA2ZlNzMmJJ?=
 =?utf-8?B?d0duWUwxZE1Ea0toUGMwNDRKUUFIOTRGQ1NHQWl4MjUvdHQ2bWN0MzFGSkdv?=
 =?utf-8?B?RVR4SE4zT0gxaFh6WFRsS2srN0pOTERNbmlrNEJwWFBEd0taWngvZzMrRzZz?=
 =?utf-8?B?bFh6dWp0WjFGVWhHd1Jkemt5MTVyaDRSZzExaytIYzgyYlc2UDluYWxrTlVp?=
 =?utf-8?B?em9URXlYNzhkcUUyNFZkQkR5Q3lrc2JoSHdVbWpnU0lQdHNXUFNuVDRSRVhS?=
 =?utf-8?B?WmVrVlBHc2dOWVRTRjlKb0grT1p5emJTSHpaZFRTLzRpakRtRlk5QmZVVEo5?=
 =?utf-8?B?TFFHSGF4cmY5TWs3aHhGWG8zK3poVnJselNPMnVuaWpjV0JvMVFCWHY0Rk1J?=
 =?utf-8?B?azhUdXhYVVpVd3lPMkV2a2E5UFZRak9RNmlPelVTSEwzcTZjQ0ZPamhTZ0xY?=
 =?utf-8?B?b0pRSnRTN2pZME00UUZwTGpwVCtSbXpRYndRTlkzM3FJNzF5cERzZTJGTUg3?=
 =?utf-8?B?WXhhdllOSkhPZFVGbkgvc2R5cU1ld0dCZmhKOFhQSUc3c1o2cVNNM0J4SnFM?=
 =?utf-8?B?MjJUaCtrRXlKakdDUDJhUVJFcFBveUE3TjRXUzFZSmxteE05OFRzTTF1ci9D?=
 =?utf-8?B?S3Y3TWFQcVVZRDN5VlhhbTBHTnVQbXBsRHpyYU9ZV2kyM0NtU2ZKRGVTMEw4?=
 =?utf-8?B?cnR2cHFIei9rZFk4cmZDRkR3TTdXUmREQXZaUWd4cUJXWmphY3AyOGF6OWsy?=
 =?utf-8?B?Zm53akxEMXlnWTl4Ty9sczExSEptOW5wb2lOWjYxZnhkSlR5bm5aV0ZoemRW?=
 =?utf-8?B?RGxxekU2eEtLT2U0QjgvSTNIZVNJeHN0WDRWZzNzZklQQXB0SHNmSDR0eC9m?=
 =?utf-8?B?Mm9HckQrN2hoYWNmNW9uc2NsYlRQVVp4SWt4ZXFlRnU5cWtjbHdaOWF0QS9E?=
 =?utf-8?B?em8yK2lJaTlFNytHdXBHYzczbHdBZnJUUGtaUitVY2pZT3lJT3Z4cnZhK0pB?=
 =?utf-8?B?K0ZCMHZDejJWa1pDMjYxVCt1c3V3WExTZmR5NFZ4UCtvL0huSzVuSys2QkQx?=
 =?utf-8?B?b0ZRNkxzZFV4R1IzSnJOYXdKTmFMUkxVRHYveitqN0UxRTdlemYwbkRrZzEy?=
 =?utf-8?B?dVNVRENuU21SU2xUcnlQNnQrOEZGZHI3Wlc0V0xuby9EWSswYWtoMVg0RnBZ?=
 =?utf-8?B?MnZqTWtOSnN2b2loV1NXZE92SlNBWk9yOFpwOWlLMEg2aVZzeFNQWnhxb0Er?=
 =?utf-8?B?NWdvanRZS3BPV0tvaWwrbkk0RzJTRmduK1JhMGVpTk94NW15a2xFSDR0NXNU?=
 =?utf-8?B?WGl6MWNGNTB1U25DRGgwWVFnK3hvcVRmeXYxa2ZFdno2aDhIVVB5aHUzMk9Z?=
 =?utf-8?B?aHdzdmJlUmlPNnhkTCt0bW1Ua2FONG4xQ0wxekZ4RTM0ckp6RGxiOXdWdEZI?=
 =?utf-8?B?SzlmdEpqMmM2ZktXQ09oYnRlNGsvZm5DUVNzQy9ROU41Y2RoU0RiVzJHZXFw?=
 =?utf-8?B?U2p2QUtOZnlEQmRMK3lEWjJ1R1RZekY0OERVZ3lQNU5QZlVkNHRnQlJrdFNx?=
 =?utf-8?B?TDJnWmhQRlRuNzVpRlBJZm9Sck1iZXhvSlh5c284QWNBMWtxTmFreVljN3VU?=
 =?utf-8?B?dHFxc0dHQWN1eURnZFdCczlyU1JsQWFOb2RDcGZ2WHFnUmdmN3h0dDhkT0ZQ?=
 =?utf-8?B?bUxpYnFzMDJ1SVYvWWMyT3crSWJZK1VvYisvUWw3ZVdHVlIxblNERENVb0F0?=
 =?utf-8?B?NXcyWEY5VUJ0WkYrR2UxblFCMm9YNnZ3bllodG9NZ1ZPTWdzcUEyRG5Kc2tR?=
 =?utf-8?B?T3Q2VWZ2QXl4UGFON01wWXhjN2ZUQ0RrY3F2K1huaUtSQVVrUnJrNnFOcUJH?=
 =?utf-8?B?M3hmM0w4QlppRTJUVVMrU2kxNzZVTmprNHg4M3k5SU5sc0JuVEhZcUxGMVhP?=
 =?utf-8?B?ZU1hcXZ3OXNkMThRdnB0clRMOHB0dk1TalpTSlAvVTBYOWtaSUdtd0VhNDhL?=
 =?utf-8?Q?K4Ekqo4GNMlQuSa3SSx8I1msE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <850D9518326AD1439E12BB6DDC86CEA4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b1888e-2690-4917-2ecf-08daaae1d282
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 17:06:50.1988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wY2wSodH0dnEBp+FCycYzHkG15e38KQcXQ5wf5ld8WzLq0qCh7hoefu66L3l4VEgxiJRaw1flgZqpljt8XlGlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTAvMjIgMDA6NTUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBGcmksIE9j
dCAwNywgMjAyMiBhdCAxMToyNjoxM0FNIC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOg0K
Pj4gKklmKiB0aGVyZSB3ZXJlIGNvbW1vbmFsaXRpZXMgYXQgaW5pdCBhbmQgdGhlc2UgY291bGQg
YmUgYnJva2VuIHVwIGludG8NCj4+IGNvbW1vbiBncm91cHMsIGVhY2ggaGF2aW5nIHRoZWlyIG93
biBzZXQgb2YgY2FsbHMsIHRoZW4gd2Ugc2ltcGxpZnkgYW5kDQo+PiBjYW4gYWJzdHJhY3QgdGhl
c2UuIEkgc2F5IHRoaXMgd2l0aG91dCBkb2luZyBhIGNvbXBsZXRlIHJldmlldyBvZiB0aGUNCj4+
IHJlbW92YWxzLCBidXQgaWYgdGhlcmUgcmVhbGx5IGlzbid0IG11Y2ggb2YgY29tbW9uYWxpdGll
cyBJIHRlbmQgdG8NCj4+IGFncmVlIHdpdGggQmFydCB0aGF0IG9wZW4gY29kaW5nIHRoaXMgaXMg
YmV0dGVyLg0KPiANCj4gVGhlIGNvbW1vbmFsaXR5IGlzIHRoYXQgdGhlcmUgYXJlIHZhcmlvdXMg
cmVxdWlyZWQgb3Igb3B0aW9uYWwNCj4gZmllbGRzIHRvIGZpbGwgb3V0LiAgSSBhY3R1YWxseSBo
YXZlIGEgV0lQIHNlcmllcyB0byBtYWtlIHRoZSB0YWdfc2V0DQo+IGR5bmFtaWNhbGx5IGFsbG9j
YXRlZCBhbmQgcmVmY291bnRlZCB0byBmaXggc29tZSBsb25nIHN0YW5kaW5nIGxpZmUgdGltZQ0K
PiBpc3N1ZXMuICBUaGF0IGNyZWF0ZXMgYSBuZXcgYWxsb2MgaGVscGVyIHRoYXQgd2lsbCB0YWtl
IGEgZmV3IG1hbmRhdG9yeQ0KPiBhcmd1bWVudHMgYW5kIHdvdWxkIGhlYXZpbHkgY2xhc2ggd2l0
aCB0aGlzIHNlcmllcy4NCg0KSSBzZW50IG91dCBhIHNlcmllcyBiYXNlZCBvbiB0aGUgZmVlZGJh
Y2sgSSBnb3Qgb24gdGhpcyBSRkMNCnRoYXQgY29tcGxpZXMgdG8gdGhlIHdvcmsgd2UgaGF2ZSBk
b25lIHNvIGZhciwgaXQgZG9lcyBub3QgYWRkIG1vcmUgdGhhbg0KNSBhcmdzIGFuZCByZW1vdmUg
dGhlIGR1cGxpY2F0ZSBjb2RlIGluIHRoZSB0cmVlLCBwbGVhc2UgaGF2ZSBhIGxvb2suDQoNCi1j
aw0KDQo=
