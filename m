Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9AC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 02:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIUCeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 22:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUCeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 22:34:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D4740E19
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663727636; x=1695263636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4n0pvaGjkHkSt+WpFtHbQeNNgY/VKESzwqxwIkbjvWQ=;
  b=KzX0wFPvW79p5fgGlbBv9n/iuXA+xZBuJ73gE028rvQzskRVATu21arU
   C8PXx3ydCCbZUw9+NksatqP5Gy76VILgMZOiblC76fyI/5zVbNUq4yyJH
   gVhUat6HjAzmJr7Olo1sbXDLkweuWyPFb7Fa+EcVzYfXNGn+/o1Blw3rN
   L1VyWgBxPEU5wspl5r0gX/CdmyjPGkTAtUDpxL5t6oir5VyXG5qhnmHAk
   N2NcYstgUJ8tWuHl2yioknUs9LMHMRvQ1FvaCZKQaTxIwOwO7bqHwhTD2
   HBNu7FTQEP8bKWl0U3UdVDNt0KIsQYk2UunLi+ElQrV89eADP2Z75Eyk/
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="210254416"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 10:33:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmyWE0AvuX461BVTnPi4hqlkbZOaEluboY38014A+73l1gezV7m7pFkQOB7IoDCFTvUwzng3G6cSNXhRIIrs7qukmTHqBAgKmFIN2qr/GB7Lwylf9R6qqlNOiRKBIzPXT7WA0LxDgYn66ZYk6hJ6MgUBvadQZm876Kk2x2Jh494k/68/WfJ803aidS4uwQGPUXnPrElLsFoB8/CIxsIedKn/lAm85tKhM8zCh+vJDbkrPJdjB4I1Esg5mfkr5+rtDK+oNuFIwbfOz77Y2senEt/vxvQnt9iq4i4qH7/bLMRBC8kgO63MtbdxLs2quxeSKOmiEqljyfwkewz+tBlClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n0pvaGjkHkSt+WpFtHbQeNNgY/VKESzwqxwIkbjvWQ=;
 b=T2iyMYvCfQQXl4FEWFa4WWOr2sjN8M19RXBCpc/l9AMcyM8dWHx09VGQKF5jV92r6bpJ0l/UTP6KZ7AnIuJMCg5/xpWcgB4TWORN7BcGLvhQvcnXqwDGCPdx1+/Ku09SA5Xx6RNQ3D8dB6+8CjAw24k+Yh4z+fHLTvf57Khh1j3n7Ot0d9ZLDPcPbKTcTA39WLMhk+V+TziyIZpOb9+HEHtBbJNmAxJcxKm2xLLRfXwF2Xm0vGBleL7/VHHdU/71Z3Wi+2+jQQak1oJv+JK9LxjuTXc4m5FhmH9CK4XeFM+zKnmIuF+WbwFGUwIhLA6GMqsb+X1rkhNJfu3urxVgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n0pvaGjkHkSt+WpFtHbQeNNgY/VKESzwqxwIkbjvWQ=;
 b=m7VXR23amQ8XVw89rJs52BqCKiUtXMezB1lWAJtgacQlyXcpBXtLU2UlGUxQC3vYB975hKGQ11oAaBrJaFC6q7MrpMP0g1WLrsu8DUwLIVHOCl2ztMSJv60u83u9tae2KHxFUcqlSuQQJNwM4/p8vUaHT9LArqd6BpQisfSI4cg=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by BY5PR04MB6311.namprd04.prod.outlook.com (2603:10b6:a03:1f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 02:33:50 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::8d4f:d410:fac7:cc9b]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::8d4f:d410:fac7:cc9b%5]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 02:33:50 +0000
From:   Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To:     "stefanha@gmail.com" <stefanha@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "faithilikerun@gmail.com" <faithilikerun@gmail.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hare@suse.de" <hare@suse.de>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/3] virtio-blk: support zoned block devices
Thread-Topic: [PATCH 0/3] virtio-blk: support zoned block devices
Thread-Index: AQHYy8+lyTQUFv023kCJgVkLD+AM8K3n8Z4AgAAx1YCAAQoWgA==
Date:   Wed, 21 Sep 2022 02:33:50 +0000
Message-ID: <0bc06659385bdcb94151065d2d652616453b1587.camel@wdc.com>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
         <YylvChyEpFUiAuu8@infradead.org>
         <CAJSP0QWbLizQDTkPC74-DMm_fBR6w5ZboPWOqCx+T1KJGbcTPg@mail.gmail.com>
In-Reply-To: <CAJSP0QWbLizQDTkPC74-DMm_fBR6w5ZboPWOqCx+T1KJGbcTPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.1-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB5951:EE_|BY5PR04MB6311:EE_
x-ms-office365-filtering-correlation-id: 7b2fbc31-dc23-4013-d78f-08da9b79b7e4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgDwKUOiT/nsuq9cjhAm9ab0NrBKKJHyVS5wJdzCQvoOcWS1pl8qoRwmvDSB9Yahk718GvezpOXw4gl+AbU++pNNmrfUrTKK/4fqjkoCUQP/UxvezGX+0OUS/29UT2yaWEnHXLlDATux+IQtU8iiQPiePSqhb604YL7VdJwXzsnRQuRl7qLY01x/tQawuEbiU6F7RukFV6lOHSW1Ll2T+pmGlsy4dKR2xuIYnnGuLrK7qOIVLsKOCLTVGZnclIU+ZC92MPNLG5aiHCXLe5HdoPOQ/ads5yQbwDHLoz8nUch8m0B+HOi8DqESsOjCp2JSAvgsoCWXTMd/96GjGWGDzKgod9CcQGNlLnrsZMNNusrbRA5YZiB6OOpt3m5lUzCBfPo+4hyrqKW2lNIaoB6tUJj9kjNHIxlvPH9P0PuKz4c1XMvRsPGU5kTBsQ/VaQ6HRLzvKBB9b2pWjoRisfy1YSSZLyp5kxC/uE5euJ9BSQXXzjN7dFnfB+aJHQh2AU/tuLHN8IpqhItxqqVEvRmyX5CG/LEWFwYT99ehlDvAxc4t2ripitdRnC5tuWupZGsYxrK48U41Ybj3RXAY0j1qeNXejr3j5EeB7bVru/MlMjTcMuv6lNnp205XOf1Jb9yjZiw19RhoTLRHO/vON+CZTcnEHO6aWhR3GMocmNAT7UVoa5cmigDPvnkFLFNwVPUTolrRSw4RgbtkemiMuhpZp/tZ6pcqmevRqg/eW2Dujgh211wLeBXlTh2uXukXx5IE8qipTcYPZIKwQC7BnTBIgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB5951.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(38100700002)(2906002)(186003)(6512007)(6506007)(86362001)(54906003)(2616005)(82960400001)(71200400001)(26005)(6486002)(316002)(4326008)(8676002)(41300700001)(38070700005)(66946007)(66556008)(66476007)(478600001)(91956017)(64756008)(36756003)(66446008)(76116006)(110136005)(8936002)(5660300002)(122000001)(66899012)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0tpZTcxWXhydThLU0J2bk1EbjRVQ2FtOFRqY0JNdUlQS0k1SFhoWm1yU21n?=
 =?utf-8?B?UnpuTG8yQ1pVNUZUSnY4aWJaK3FBeElmUVpqaTJJTWlCd01xWFozMUZzcmZI?=
 =?utf-8?B?R2N4VmlzWjVKNEVlUjlkcXh0bm9jd3RBZmJCUUl2UElRMm9wR1dDOHlhZHg1?=
 =?utf-8?B?QnEyOWdoU0dYOVh3Z0hCanlmSllKZ2ZyaUlBellMVUZyYWJ5Rm5LUlBNay90?=
 =?utf-8?B?NC94Q3krMWZ0NGx5eC9mQVN4cWxpZHBMU0lqWWRlb0piY3NyNUNoL1hwK3VE?=
 =?utf-8?B?NGVmZGNmNlJOeFVVdldNUyttbFpDdllIUU43d2ZUVE9wQUlSRkc3R3pDVG1H?=
 =?utf-8?B?cDBSVDdrOHpDdzZXNndyV1QraUhyRU9BUmR4Q2Nzbzc0dkVpcysvYjVTMEhT?=
 =?utf-8?B?YVVnN1BkanYvNHdmSCtBOHQ4YlJNWmkyMFVCR0lNbXdvMnpLVmgrdGkzL2V5?=
 =?utf-8?B?czVycE5GNVFiVGpwcTU4TE9WQTNyOFkrdnBBc1M1enQ4Vk1kVFdPdVI4WkZw?=
 =?utf-8?B?NS9sWDMzem5CRklZRVpUV2NMWFRwRVlTU3FMbzFVZWpPWWthVWI1T054S3V2?=
 =?utf-8?B?YVNVV1pLL1NhVStWQVBLZ2l0QmhQZlZNWjFrVHo4bzgyVFkwR3ZWRWwvWjEv?=
 =?utf-8?B?aDNQTWRuOHVtLzVNbzdHN1BKMDRZNWxVZEhFQ3NSSGVOUmFCQVVKZytzSSt6?=
 =?utf-8?B?UlU5WW1wcXVXRlljU3cyL3JHZkRQRytmMmlya0Zhdm4zSHdmMVQyQUdDRWIz?=
 =?utf-8?B?RG04bXdrbFBNQkNmTnpZV3ljeDlaZ1dMRTNEc081QWU4Z1lGdTRqSXFNL0NY?=
 =?utf-8?B?MlljdXlDQUl2Lzk2WThtRGVZeVRYZEFGS0NjYTZLNnhKWDVzc0pKeWUwRkMx?=
 =?utf-8?B?RFNrQU9yTmRObXU4d3RUQWxXbVRYQlV5amtaaGxDWCsrNThOdFBXUThXYlJI?=
 =?utf-8?B?VHZ6eE90c3F2cytGbGRxNE1JRzRpREIrTkMvcU5WVzNMTS9kb3djR0ZUbkUz?=
 =?utf-8?B?ZGR5cmZia1RXQmtQT0k0am9wZHAxdnBGVWJtMU1PQkl1R2RmWW5uaER4RXN1?=
 =?utf-8?B?eThITmVON0NtMkVvOSttZXJFOTh1V2h2NjZOTTE3aHFta1daSitjdGx0Wnhi?=
 =?utf-8?B?NjJ4b0Q5Rm9ITlZEQmt5dDNod05oZkRvV1NCSXpzV1ZUY0MxeG1OZnZ0QmRW?=
 =?utf-8?B?YXJWaW5kS2txaDY2WndtZ0VLTFg4alhYcUxoNGp5WkVlRzFMQkIzRWZvcE1T?=
 =?utf-8?B?N1JmbFdCZWR1SjE5dTQ3RERDb3BQb1RUWDlUNXI5ajdYN2d2SENGT2lUSEFa?=
 =?utf-8?B?bDQwMWtwZUNMa1N5MFJjeXpjM3BGMENLdkpqNUh0SFBkRVRNTXhLamVWekY2?=
 =?utf-8?B?SHpCWjJmdWw0Z0MwM2ZJYkhJSVZMeUExYys4dmw4YjVaTVU2bUlwOGc3SzdK?=
 =?utf-8?B?dmR1UjBJanBKdHZRQlN5OVUzZmFSbS8xWmNmOHprQUxJQlJJWEhpVDhIQ2FV?=
 =?utf-8?B?dkZrRUNLWTJiK1pyT2V5V1psTzNoc1MvaDAzTkFTZGdISnRJTUFNdnIzWmtt?=
 =?utf-8?B?SjA0TU1kSWdxeUJDc0ZFYzZKZm55M2lidDRnT1JjTG9JUUZhLytMamlFUEhW?=
 =?utf-8?B?UzZUbDA0TXA4eC9idVByZmJ4ZFZBTVFJOVQ0bkFMbEc0S215amJuYXMzSHc5?=
 =?utf-8?B?U0g3MEd5dmIvamkyN0lxYWZNY1c5ZWc3YjA0YmtiWEJkWFRIOTFIVjBUbjNr?=
 =?utf-8?B?b3kwcllsSXNKWmdQQlR3K1RINlUzZ09sNWZlTkQrRGRHNnU1TjdwdS8yN0o5?=
 =?utf-8?B?RGkvN0tPRjZUV3NZbkhpSUg4VG5GQlpyc0w1ay9MbnZzNjZMZkhxc0c4Um1w?=
 =?utf-8?B?Q3piRmI0R1k5R1oxOUtBb1NtZGRiZDg5OEVTUlVCQk9nNDF6TU1TOGQ4V1Fv?=
 =?utf-8?B?dFI0UkpQZG95dVF6RkltRjgva1lHb2twTDBCZGw4dHdtTDV1WU9SYlVZM0I0?=
 =?utf-8?B?NHJIMlF0YXBrSjlFdHVSYUhjMFJIMFpyd1NoSnNqbVJ6NFhoVzlLeG8reDhX?=
 =?utf-8?B?SHFRWjQxUTgrUk5FRi9TaHNQbGFQalRpc2xneWwxMlRqYnJpRlF6VFd3ZXRW?=
 =?utf-8?B?Sjd1TnNmRHA3ZjMybjg3dk1kNkJOVTB1bzIvWmFSTzhyVWpiSWc5UGhUTHhQ?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10DACD12B73D0D4AA788A76D9AA2C755@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2fbc31-dc23-4013-d78f-08da9b79b7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 02:33:50.4766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1rcKDgm/TT0oVBz7IdsUuR6c5o9qIxBYY0Hguw0KTtTcUQUEG/ZnJWPAeZyWyRA1CZ515K92Nk0YdMVlmO1EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6311
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTIwIGF0IDA2OjQxIC0wNDAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAgU2VwdCAyMDIyIGF0IDAzOjQzLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFN1biwgU2VwIDE4LCAyMDIyIGF0
IDEwOjI5OjE4UE0gLTA0MDAsIERtaXRyeSBGb21pY2hldiB3cm90ZToNCj4gPiA+IEluIGl0cyBj
dXJyZW50IGZvcm0sIHRoZSB2aXJ0aW8gcHJvdG9jb2wgZm9yIGJsb2NrIGRldmljZXMgKHZpcnRp
by1ibGspDQo+ID4gPiBpcyBub3QgYXdhcmUgb2Ygem9uZWQgYmxvY2sgZGV2aWNlcyAoWkJEcykg
YnV0IGl0IGFsbG93cyB0aGUgZHJpdmVyIHRvDQo+ID4gPiBzdWNjZXNzZnVsbHkgc2NhbiBhIGhv
c3QtbWFuYWdlZCBkcml2ZSBwcm92aWRlZCBieSB0aGUgdmlydGlvIGJsb2NrDQo+ID4gPiBkZXZp
Y2UuIEFzIHRoZSByZXN1bHQsIHRoZSBob3N0LW1hbmFnZWQgZHJpdmUgaXMgcmVjb2duaXplZCBi
eSB0aGUNCj4gPiA+IHZpcnRpbyBkcml2ZXIgYXMgYSByZWd1bGFyLCBub24tem9uZWQgZHJpdmUg
dGhhdCB3aWxsIG9wZXJhdGUNCj4gPiA+IGVycm9uZW91c2x5IHVuZGVyIHRoZSBtb3N0IGNvbW1v
biB3cml0ZSB3b3JrbG9hZHMuIEhvc3QtYXdhcmUgWkJEcyBhcmUNCj4gPiA+IGN1cnJlbnRseSB1
c2FibGUsIGJ1dCB0aGVpciBwZXJmb3JtYW5jZSBtYXkgbm90IGJlIG9wdGltYWwgYmVjYXVzZSB0
aGUNCj4gPiA+IGRyaXZlciBjYW4gb25seSBzZWUgdGhlbSBhcyBub24tem9uZWQgYmxvY2sgZGV2
aWNlcy4NCj4gPiANCj4gPiBXaGF0IGlzIHRoZSBhZHZhbnRhZ2UgaW4gZXh0ZW5kaW5nIHZpcnRp
by1ibGsgdnMganVzdCB1c2luZyB2aXJ0aW8tc2NzaQ0KPiA+IG9yIG52bWUgd2l0aCBzaGFkb3cg
ZG9vcmJlbGxzIHRoYXQganVzdCB3b3JrPw0KPiANCj4gdmlydGlvLWJsayBpcyB3aWRlbHkgdXNl
ZCBhbmQgbmV3IHJlcXVlc3QgdHlwZXMgYXJlIGFkZGVkIGFzIG5lZWRlZC4NCj4gDQo+IFFFTVUn
cyBOVk1lIGVtdWxhdGlvbiBtYXkgc3VwcG9ydCBwYXNzaW5nIHRocm91Z2ggem9uZWQgc3RvcmFn
ZQ0KPiBkZXZpY2VzIGluIHRoZSBmdXR1cmUgYnV0IGl0IGRvZXNuJ3QgdG9kYXkuIFN1cHBvcnQg
d2FzIGltcGxlbWVudGVkIGluDQo+IHZpcnRpby1ibGsgZmlyc3QgYmVjYXVzZSBOVk1lIGVtdWxh
dGlvbiBpc24ndCB3aWRlbHkgdXNlZCBpbg0KPiBwcm9kdWN0aW9uIFFFTVUgVk1zLg0KPiANCj4g
U3RlZmFuDQogDQpBIGxhcmdlIHNoYXJlIG9mIGh5cGVyc2NhbGVyIGd1ZXN0IFZNIGltYWdlcyBv
bmx5IHN1cHBvcnRzIHZpcnRpbyBmb3INCnN0b3JhZ2UgYW5kIGRvZXNuJ3QgZGVmaW5lIENPTkZJ
R19TQ1NJLCBDT1BORklHX0FUQSwgZXRjLiBhdCBhbGwgaW4gdGhlaXINCmtlcm5lbCBjb25maWcu
IFRoaXMgaXMgZXNwZWNpYWxseSBjb21tb24gaW4gaHlwZXJzY2FsZSBlbnZpcm9ubWVudHMgdGhh
dA0KYXJlIGRlZGljYXRlZCB0byBzZXJ2ZXJsZXNzIGNvbXB1dGluZy4NCg0KSW4gc3VjaCBlbnZp
cm9ubWVudHMsIHRoZXJlIGlzIGN1cnJlbnRseSBubyB3YXkgdG8gcHJlc2VudCBhIHpvbmVkIGRl
dmljZQ0KdG8gdGhlIGd1ZXN0IHVzZXIgYmVjYXVzZSB0aGUgdmlydGlvLWJsayBkcml2ZXIgaXMg
bm90IFpCRC1hd2FyZS4gQW4gYXR0ZW1wdA0KdG8gdmlydHVhbGl6ZSBhIGhvc3QtbWFuYWdlZCBk
cml2ZSBpbiB0aGlzIHNldHVwIGNhdXNlcyB0aGUgZHJpdmUgdG8gc2hvdyB1cA0KYXQgdGhlIGd1
ZXN0IGFzIGEgcmVndWxhciBibG9jayBkZXZpY2UgLSBjZXJ0YWlubHkgbm90IGFuIGlkZWFsIHNp
dHVhdGlvbi4NCg0KRG1pdHJ5DQo=
