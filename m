Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00966C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 20:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E5661053
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 20:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKCUyq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:54:46 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:62881
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229698AbhKCUyq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Nov 2021 16:54:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZafBMYhbrQMTloHeL/QD+UjEZiSrgnaGP04zzuVZ9gZsT92ES2xPDzOCgL0cpoW3iWY5b60/7dw5vAy6/SBE6bACMiniljAlWSki9J9XrWJQmVxzP8vX++C0r6V2qika9H26H6UZTdkfAwLSbY3j4KHgpThSK9fTOIqjTlV2z6b5Njw2fqb7uXE6yq/OT92Onz/Uuw6ejjtYwInmaR+1k1zd1h3CP2JWa0VKPYpn2UK3NtXtZYjCvkV9Mdyn14462pZo7zLicAij4Uk+J4zKl65UROR/9O+QwGzqhIzmppxA8nbqeBKWwVNSQEX8DDudBvFHEWlzjJHs0wKKJ1ysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3Q0IfbPeyJPnjdtFxyjD3f9Y4zeh5ySeV3Ut+Th6fA=;
 b=FRA601i3FSyW4GAQ89BpC9/SzBe+otHcXoxob/29i5B7cYcEq2y9/HPFJuj4yJH83LooFPtrqfAFJYJgNwj01XFiqqxlmfhW0i+X0DEbb42a53deb1o62b2bkTFTUqjvzzA92Cg75269dy2a3sJkHWSHgitW2D6ZGOlTMG7T33qiebaaZTTITv5EuAKhDgS7QhswhEmF6vYmS7+BHQOYELwaixte4CmNozYnDi828hNA/d9qXnzVvDNlXELY39rvPj7Ko8Kqrc6qM3+JhmJscxg8e8b8EFpoOWjf2CNytYed2HEqvuwAaAR+g/Ik4WP4oVKxhZlFborXp9X1TB0N2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3Q0IfbPeyJPnjdtFxyjD3f9Y4zeh5ySeV3Ut+Th6fA=;
 b=I9eqEQiK9VyIZdJUy2A9F3bXNrg40P7rKb66G/ABBFb9hZOD8ILuYkOfsA46jWW9zH/4fTsHWiDGYvWDDYGhdAR6tdZ/DllO+R73UxcdzMQhB+eygdLfBrb81M72rmErq5xIt+D5/5Qs/0qZ5YrgfBaJXMnEXc/RLAzI3laEzt8ZCjAl/8Ch5OhS+Vj98hsJQ+/LZ0UJnrrhw7XX8qhExPxJUoNZ3s10MX+iljXCpIKtZ7rB6yuoJn4f1ZC2glnY1UU9k0spLi2o/oIHCYWqgocZwaUUCPsXvEySQeTa663IXTLp+qJTlnKSlYOULXS7jO/oZI7+8jsjW+8fuPjGyA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 20:52:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 20:52:06 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [nvme] f9c499bbbf: nvme nvme0: Identify Controller failed (16641)
Thread-Topic: [nvme] f9c499bbbf: nvme nvme0: Identify Controller failed
 (16641)
Thread-Index: AQHX0OwuhGR8DxpkrEmhLbnMT6aRxKvyR3iA
Date:   Wed, 3 Nov 2021 20:52:06 +0000
Message-ID: <6a0cce97-2755-3df7-3be4-f66dbf786fe8@nvidia.com>
References: <20211103141454.GA30634@xsang-OptiPlex-9020>
 <e6f09b9b-386a-8a26-7c4b-c528791f7c9a@kernel.dk>
In-Reply-To: <e6f09b9b-386a-8a26-7c4b-c528791f7c9a@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 335018c4-add8-48f0-af66-08d99f0bcbcb
x-ms-traffictypediagnostic: MWHPR1201MB0158:
x-microsoft-antispam-prvs: <MWHPR1201MB0158761A0F4A11AEB00E97CEA38C9@MWHPR1201MB0158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPPPapovMuXepQA023lAe4N0MdRTkMl7TtkY5naN976INYnKldON8lcSE9RVTidGNmIQqc9Stv28lzKuMHfX9CReQStcPe3hCzbc3mpkUbgv02dYI1XPgnPbG5P1aOVJIg85U6CkaBHRf7L76JA1H6oHrz5LkELHM2IaI32Ofgb7dWdAmWNkE7lbwdSy5k61yR/EOVNs71K/tfBeDwTb+Thvidj/ELlRDdJeBQtdxvtD/5ru6bJnlxCyhksL0jnZiM1NAJIvBVh3+Jt1X0Q07nUU8JAglM6YOVHlzmitsuXW3bbC2YH2hIVC+qRiPGKzDU8u1OpxoZoJ6k7HBzGHn3CaYip71rGbT7WwdECUfC/QzoNYK9p+wC2Ab3vOheCXQtVHW72U4MNhnLBoFopiLJKyL8dfPg+IEdKzTO7L0SY59F7IfL7cQpiBS0jGAt2P42DLvRXuf8DN+W/O5U3Mdewp75zKtvSG1zx8XoJ8kZuQmEnSz7c0ZbwjacW4maK1zEGNgniItqQ5yc+IpCCjqhdAAqBRMQOSg3SKU/tf49rF7Dux2i5dO3IkDYod08ztshWP5AvGkdmsmTu4vVJtP5o7j/PQ6yFPV8pGf56eK0zDhkORhNoNHBS1yf416HsPhYzw+WNjiYOSPuKqQw/nmwm89Upp7MF0k6lzuWKYbVdr4dkpneki2sJzx37LbJ0Up1jLdIdV+y2sqqkLj+uF5d7ddgAaXm5cXKuJPLnFc/y8oJ0DgJ27ALqlEjySqxR3c8UN/kIuAotMbml4yNL/JV9Duv3GIIM9wbQjkrq0AXVtOyLzBM26gX66BGCxLr9i1bytBqBlZsoko7CK+UwplHtyYIWwgwrkDFRtx/m2Kn6RBGpkVt25TzHZ/17Czz3srZepPrBD0V4VeezhCOILoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(31686004)(76116006)(6916009)(38100700002)(38070700005)(508600001)(83380400001)(8936002)(2906002)(6486002)(4326008)(66946007)(91956017)(66446008)(6512007)(71200400001)(2616005)(54906003)(6506007)(53546011)(122000001)(86362001)(5660300002)(36756003)(66476007)(8676002)(64756008)(66556008)(31696002)(966005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUlvN0lxMW1CL1FZNjBoYnJTTDlxeWN5aGxxRjJVVVBscmZ3K21rWFhMcXlB?=
 =?utf-8?B?NGloV3dnMUxoZDNHZjkxVVFVZVFod3JLY2lVd3I1d2JqeTFmUCt3OVlKT3NW?=
 =?utf-8?B?ajFibnJrYWFRTTdEZnBNK2VwRXVIL25WMHg5UU9mMUxOSTllTTR4SWdJUktG?=
 =?utf-8?B?UDI0ZVpJYkJPTUoySWVzNk1iUkNCUG16M3Fudm8rNkczTGpJSlZaeVAxQTU4?=
 =?utf-8?B?Z0tVODF3YnlHOXBuc1crOHg4UmVRZUVyNlhMMld0b2RVZEoxa0hSekZmNHky?=
 =?utf-8?B?UXVhZVArVlNZekJxcndOZ002WUVRSU0vN3MrNkJrRDZtdVZndElrTC9KSkI1?=
 =?utf-8?B?ZW1kbkEzeTZmOVZLenFJdkpDRE9lU2NVR2N1eFc3c3JYMmNrR2cwTjk0RU50?=
 =?utf-8?B?UGRvd3BKdklkcjIrbFZCR3d5bFlxNUM1eENJNitxelI3SmRTemxtUUVvZXFF?=
 =?utf-8?B?OHBnbzEwaURnUXNYOGt2YmlKSENETXVvZUZVUExyYmUzSVVGRGRDNDBycytY?=
 =?utf-8?B?TXdtWWtlTW9iMUtGWHVnTUdXdGg3NkRUdUhQTkRKSGNzWVBEdHh3bGNUbWg1?=
 =?utf-8?B?cEMwZGZxQktkTXpwN3NoZE15cDNxQVluRGhESFVDaU14VXVsT2YzSmlkdlYz?=
 =?utf-8?B?eHNIK3VrWWdsNEJpUFlhRHR1MlRXUUJSdS9lRUNaQ2g2dXNxZW5PR3p3b09H?=
 =?utf-8?B?dzhrZ2VNUGVrZ0F5S3JkZW15SGM4eUlpUnBYU3RzeVB2WHU3U1BoSWRoRmNO?=
 =?utf-8?B?ZWtNVzhhSDVYeEg0WldKeDJmOWFFa2doWXd6ZStwWUg5YnNwNTdmZ1ZVYzUv?=
 =?utf-8?B?Q3pwRDY5Q0NOcTJVd0tscklSdWRHQ2ZoTVlXRWZXd2FwdU9UU2g1cVhLRGJy?=
 =?utf-8?B?SEZnSHR6ckxHcWsrQTdld1RFeVR0aWdvZHlzT29CWUdSbWx5cDNsUndxV3Zt?=
 =?utf-8?B?aks0eGM2cDBxUGkwUlZWOWtRTDMrWGl1TEhPVjd2NXNwZUwxNHRSN25Dam10?=
 =?utf-8?B?eERaWm0wcS9BUjhFcWxwcUNyYTVld0ZGTWxsWjdaZjFCWEhKNXpad1RHeTEz?=
 =?utf-8?B?SEt1WkZ3YWNwY1RleFpQa3NBN3RWVk5uSmQyOWtXOWxsT3h2d2poSnQxTEsr?=
 =?utf-8?B?ZDNMajV1a01SMm80dlVKSDQ0b1Z5c1pocjZ1T0g5ajI0Y25zRE10RVdpdVY1?=
 =?utf-8?B?SHl2QTdjSHdSNGFaeVJGUjl6VDVUcjNGWUNmV0ttUElFdnVVOFFyK2JwM1JL?=
 =?utf-8?B?L0tXdTdVYXdBYnB1RHBTV1Axd2FpdFdjN24yTm02d0JhRnRTUnpxKzhicnVC?=
 =?utf-8?B?d0doRVBqSm5TVlJ3UHNCcUU1Qlh4aGxlcFJsclhqNUgxaENiMEdUYjc2cGk5?=
 =?utf-8?B?ZWp1V1Y1MGk2LzhTQjNoOFJ2T0RTNkVKYVVnekhoNnVjT1A1QU53UWRObjNF?=
 =?utf-8?B?VTlZT1BaUU5mN012Yjh5WDJ1dDlhQjl5MExnNFh6ZDB3TVdwTUVzUzN1RWFR?=
 =?utf-8?B?akJHeEpGMVVQZENOZEVWQ29IUUUxVGZGTUF3U1FwU010QktRTmFYU2tneURo?=
 =?utf-8?B?TjJObHJxWlczWVZhejJoaEN4NkdNeVc4T2JRaWxpbG1xeW5jNnRtakZpQ3pX?=
 =?utf-8?B?d0xQS2Rqd0RmUmxTOGVVTGRWd2NQbTIvZUNlcFZDTy9qY3VieEs1cHYzazNT?=
 =?utf-8?B?b0x6MUhUeGkxSHR6UW9NZHBiUTA0UDhqZSsxSE5xOHhLRHdvaFlDYllRU3Z2?=
 =?utf-8?B?MTk3TTcrTHpGeWI5OFd3UWU2aFU1WlVFcHBpdnZrS2R0TUFzdGJiYWovU2Zm?=
 =?utf-8?B?dldwV1hvODAzY2ZKOHlYY1BReEhQUktZOEMzSkZzOXNaUTRIRVJkcEh1R1Vu?=
 =?utf-8?B?TmFSNEM2dSt0WDRDNUppZWtuV3FOc0huT1RZK0tQRStJRENKNDd4MGxTeE45?=
 =?utf-8?B?RHNpU3lkQmNTL1poQ0gzbWxDMEVvU0VtR2N3WG1xai9CSGR1N01HKzhDYXN0?=
 =?utf-8?B?UmcwUFNNd0pDTmlJSWRIUkhZUjZaTXVpTG9zVzc2NWZObXJsa1JsTVprV1hN?=
 =?utf-8?B?S2czSGlycGxteU82KzZ6aHZRYkY2YmVHUjlOa1QzWnBWUU9VcjRZVnNQaklC?=
 =?utf-8?B?dG9tTXNqdTRzUEpSQkpaZGw1T2FmV3ZvM2NEaXNhZDk2NnFBTGRCQXVJeE9W?=
 =?utf-8?B?NU5KNHNCaEU0eEVUZ0JaeGRMblhHcm00UXRRSXBEblhNRWZDMEJMYnBwNFVm?=
 =?utf-8?B?c2xMQk1aamxLc0cxcU9RK2krU1JnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F6D87088E38AC47B004F114FB2E14F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335018c4-add8-48f0-af66-08d99f0bcbcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 20:52:06.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXDZv1AHyo0ZfVTslhgzzAhdNE9glcVxDlSQYS7Rs1nTbtrwgyU76w8JBP1XJOpg3KQHswAuJL9MOBLcpgEC5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMy8yMSAxMjo1MSwgSmVucyBBeGJvZSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAxMS8z
LzIxIDg6MTQgQU0sIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KPj4NCj4+DQo+PiBHcmVldGlu
ZywNCj4+DQo+PiBGWUksIHdlIG5vdGljZWQgdGhlIGZvbGxvd2luZyBjb21taXQgKGJ1aWx0IHdp
dGggZ2NjLTkpOg0KPj4NCj4+IGNvbW1pdDogZjljNDk5YmJiZjYwMzM4OWFiYWQ2MGQxOTMxYzE2
YjJmOTZkZWUwNiAoIltQQVRDSCAxLzJdIG52bWU6IG1vdmUgY29tbWFuZCBjbGVhciBpbnRvIHRo
ZSB2YXJpb3VzIHNldHVwIGhlbHBlcnMiKQ0KPj4gdXJsOiBodHRwczovL2dpdGh1Yi5jb20vMGRh
eS1jaS9saW51eC9jb21taXRzL0plbnMtQXhib2UvbnZtZS1tb3ZlLWNvbW1hbmQtY2xlYXItaW50
by10aGUtdmFyaW91cy1zZXR1cC1oZWxwZXJzLzIwMjExMDE4LTIxNDk1Ng0KPj4gYmFzZTogaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0IDUxOWQ4MTk1NmVlMjc3YjQ0MTljNzIzYWRmYjE1NDYwM2MyNTY1YmENCj4+IHBhdGNoIGxp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzIwMjExMDE4MTI0OTM0LjIz
NTY1OC0yLWF4Ym9lQGtlcm5lbC5kaw0KPj4NCj4+IGluIHRlc3RjYXNlOiB3aWxsLWl0LXNjYWxl
DQo+PiB2ZXJzaW9uOiB3aWxsLWl0LXNjYWxlLXg4Nl82NC1hMzRhODVjLTFfMjAyMTEwMjkNCj4+
IHdpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6DQo+Pg0KPj4gICAgICAgIG5yX3Rhc2s6IDUwJQ0K
Pj4gICAgICAgIG1vZGU6IHByb2Nlc3MNCj4+ICAgICAgICB0ZXN0OiByZWFkc2VlazENCj4+ICAg
ICAgICBjcHVmcmVxX2dvdmVybm9yOiBwZXJmb3JtYW5jZQ0KPj4gICAgICAgIHVjb2RlOiAweDcw
MDAwMWUNCj4+DQo+PiB0ZXN0LWRlc2NyaXB0aW9uOiBXaWxsIEl0IFNjYWxlIHRha2VzIGEgdGVz
dGNhc2UgYW5kIHJ1bnMgaXQgZnJvbSAxIHRocm91Z2ggdG8gbiBwYXJhbGxlbCBjb3BpZXMgdG8g
c2VlIGlmIHRoZSB0ZXN0Y2FzZSB3aWxsIHNjYWxlLiBJdCBidWlsZHMgYm90aCBhIHByb2Nlc3Mg
YW5kIHRocmVhZHMgYmFzZWQgdGVzdCBpbiBvcmRlciB0byBzZWUgYW55IGRpZmZlcmVuY2VzIGJl
dHdlZW4gdGhlIHR3by4NCj4+IHRlc3QtdXJsOiBodHRwczovL2dpdGh1Yi5jb20vYW50b25ibGFu
Y2hhcmQvd2lsbC1pdC1zY2FsZQ0KPj4NCj4+DQo+PiBvbiB0ZXN0IG1hY2hpbmU6IDE0NCB0aHJl
YWRzIDQgc29ja2V0cyBJbnRlbChSKSBYZW9uKFIpIEdvbGQgNTMxOEggQ1BVIEAgMi41MEdIeiB3
aXRoIDEyOEcgbWVtb3J5DQo+Pg0KPj4gY2F1c2VkIGJlbG93IGNoYW5nZXMgKHBsZWFzZSByZWZl
ciB0byBhdHRhY2hlZCBkbWVzZy9rbXNnIGZvciBlbnRpcmUgbG9nL2JhY2t0cmFjZSk6DQo+Pg0K
Pj4NCj4+DQo+Pg0KPj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5n
IHRhZw0KPj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRl
bC5jb20+DQo+Pg0KPj4NCj4+IFsgICAzOC45MDcyNzRdWyAgVDg2OF0gbnZtZSBudm1lMDogcGNp
IGZ1bmN0aW9uIDAwMDA6MjQ6MDAuMA0KPj4gWyAgIDM4LjkyNDYyN11bIFQxMTAzXSBzY3NpIGhv
c3QwOiBhaGNpDQo+PiAwbS4NCj4+IFsgICAzOC45NDgwMTBdWyAgVDc3M10gbnZtZSBudm1lMDog
SWRlbnRpZnkgQ29udHJvbGxlciBmYWlsZWQgKDE2NjQxKQ0KPj4gWyAgIDM4Ljk1MTIyMF1bIFQx
MTAzXSBzY3NpIGhvc3QxOiBhaGNpDQo+PiBbICAgMzguOTU0MTkzXVsgIFQ3NzNdIG52bWUgbnZt
ZTA6IFJlbW92aW5nIGFmdGVyIHByb2JlIGZhaWx1cmUgc3RhdHVzOiAtNQ0KPiANCg0KRm9yIFBD
SWUgY29udHJvbGxlciwgSSBkb24ndCBzZWUgYW55IHJlYXNvbiB0byBmYWlsIHRoZSBpZGVudGlm
eQ0KY29udHJvbGxlciBjb21tYW5kIGV4Y2VwdCB0aGlzIG1pZ2h0IGJlIGEgY29udHJvbGxlciBp
c3N1ZS4NCg0KQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSB3aGF0IHR5cGUgb2YgY29udHJvbGxlciB5
b3UgYXJlIHVzaW5nID8NCg0KQWxzbywgY2FuIHRoaXMgYmUgcmVwcm9kdWNlZCBvbiB0aGUgZGlm
ZmVyZW50IGNvbnRyb2xsZXJzID8NCg0KDQo=
