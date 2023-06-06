Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A93C7EE24
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 03:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjFFDU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 23:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFDU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 23:20:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1AE118
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 20:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElfYpeFgrj1momrrvz9Y6BzIrj5Hp2vngJPk3FJ0V7OOTddovwmxwKq9Rgv2QYjpHEzYWANlp698hxVEmP5FCSDilRBkvWhs9JaCznaFv7ehDoMs0TSrKFRFL1MY/cPLb6ZZGYleV3Ztvk7gi+MgrAn+mxl6qP75azaWEr8W6z0r3/QryR9k1sjfbeI1peA5XuU/tlvPo5AIu4PX44++KvySP+yfS5zzbH1GNjfwHSwkwD+1F6Wzwdik4g3fTbQgf4SiHyOokVdP2umDribTIO10AnQCmKiSOD+sbz/ZbwhnLQBGAGEMB0+AzbXNO46aWJMZMs1HWsr6G/xgWpnrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKVtVFmYHsjDDwPWBW/5hscSAUeSrSs3mUNY28L9XTo=;
 b=giZNH0Y48oIM/2RWdxVKtmg/w7hrLmreGfbRshOFmb3IcvO0JTELjgnck/LVnBhN3ULBelxnfoCNtokY973DlSwbHHW7ZA4YZdW50MufM0Eywj/NMWqakjUK2HNzBhSGxBUHjBtIVG6zZTmBMfjV63RWum0GrFFb+yb770Y/8wpzpNBqSDXF6nvel0xrHlXNbwx9tF87hFt5Wq9OlDSR+9ftqHmKjrwhSWfN10/zruUYympIkWXtRi4guknaXbqS/nSBssNVD+pHLk1t9ycDD6b0RQu7TbPgSJYxDV9TqCeFj6ahCBrbgVWTW47LFaW6rqkU2omQqNtRI5bQsxgs+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKVtVFmYHsjDDwPWBW/5hscSAUeSrSs3mUNY28L9XTo=;
 b=lT9NWOMNAz5uItmMqRx+yRUZmYYeMUtB9OBVGPclqOLhik2Zf+mDP+ynbGe0VoXp8mmeh9cG1/EUdf2SKuvM07Kb225BSE1iNFDq/2opY2ZGCATemvvYahWqrHN+SmXuoTRbab+Hi3c+I4ys+I0DkZeEyTlchYxf6aIljXERj+LPRYVvV6ny64navXAv4C8Nq2uA8kZkEK1B1b6y/qnVMk362iG4UmNXdpjK5+/yPEKfOiA5766rzml9DldTX5lDm9ZhTO4zxT6Xa9DFguy1+Y6fqITOeYs/oB3IDLHDRFm6cBa/g7nuSVGtfgyZqwjjbSWu5B/cm7Q1Ra9ZUVeL6w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 03:20:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 03:20:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Topic: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Index: AQHZk1xCgGwOwhe6lE2YQ1sHiWuOnq9z3PsAgAkERYCAAEOwgA==
Date:   Tue, 6 Jun 2023 03:20:24 +0000
Message-ID: <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
In-Reply-To: <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5113:EE_
x-ms-office365-filtering-correlation-id: c8fead3a-f79b-4f39-d491-08db663cf7cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5UNMQRC3yFIh5DDCmhnYKnq7J9pOWMH0efvUGyNYjlrNqEzjmHm5PHnNqsWmtzifbSy5F2scHy07v7G9EXPzJKsNjJ/kp4jj+mdRE0J+qWWFRRFdJ9g4NY8wOx75k7AKHBn7LFJSi6PSMlwfTWQWhz1RHUG8V4xuSjgLQAgMW8AEslmZWpkZirZnXb6K2ExVCmUtWRJyNPZhW0rnYrkdWK/lhnCMSmBPhMCHM3AziS6M/QGiFAJ/THWXlbT6NCzSk6iYSIc0GJzKZL7HhrjlETt//RlnflWcwr5aFmq1hZ6ej/BRkrioHHE0Ae5COPqIw3LowtWLXjgW8S2gd4wFDHdFB+im4PRZisdLrfPmjG//4gEImV25U32JuwpFyKKkBH03rVYwnvSHiOn2nDevYIEZ8fF03497h77/xi6zTyxDnBlWy+RxeK4mjcu6Kmwh9HhsFs8gVDa2PhkxbNVxfiKDTIfh5hBwXaTU9XO+7+euzV6vKgtjM5oKYUltqC7+Tr5ldLxHTyoBK4c8AeN508wvGnqJXM706hvZxQ+BDmJtDE3p3ai+h+T9pi9nqi+H0259ql9HdSDjlYMsdjgl0hX8e60OConCUYEU8fuMNix9TQ/e5jAv8e2HlDodl0iUBqtmAM2ErqPLaKUb9QwjXYfRCued9s8pkoHNTzCb8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(86362001)(122000001)(83380400001)(54906003)(110136005)(4326008)(76116006)(91956017)(64756008)(38100700002)(66556008)(66946007)(66476007)(66446008)(6486002)(478600001)(71200400001)(2906002)(36756003)(186003)(2616005)(38070700005)(8936002)(8676002)(41300700001)(316002)(5660300002)(31696002)(31686004)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUxjMGFtM3BkSHBQWm9qa3A1K1NWTlNwMVd5eUhBb1UzYTFSQ2JiKzdKV3V4?=
 =?utf-8?B?YmxTRU13N1VQRENicXJGMzl4ODQ5MUFESG1jT3ROS2N4bWszdnh2ZjdTUzhW?=
 =?utf-8?B?ajlUZDFmaHUyMkpFSDFTV3pxd3c3VjVJUjJybjFOVklsK1M0a3NxVmJDNmxE?=
 =?utf-8?B?djJjOUdPWGxmTGxUSURSdko1QUlHbGNuUHN6RGxzNEVvbVlMWml2elAzTU8z?=
 =?utf-8?B?dTR1UVNINStaVDNROHVIQ3NwenNmK2FHbWU4QWhTNjBYMW5rVjZYL2kySjl2?=
 =?utf-8?B?LzZoTmlEOHBEZWpsWUpsUG5yb3IxMlFhY0NZc0NCcmo4NXgrN3E1cE1ya2tz?=
 =?utf-8?B?eXgwRU5tV241MTNYWmNENVQyd3l2a2RySU1QOFVlNnh1R2FUc3p6S2Vvcm1m?=
 =?utf-8?B?b1k4RWpwdncwMktxKzBTdm4vVkVyTGJqWXdFa0RYTjA1Znl6TXlCQ2VHSHVK?=
 =?utf-8?B?QjFqYk51cURJcDhHWlc0aHRhUkU4Zi9lQU00VXN2Vk1PMUR3SExKbGZDWkxC?=
 =?utf-8?B?K2w4RXpmSzBoaE5JSHZ4Nk94SFE5VHNzNjdhdCtYanBDc0pkenlmN0VtY0ZC?=
 =?utf-8?B?bHJDazE2bml0QU04bENkeHlRcUNlRkhDRWEwczBuU1pvSWNIUk85eWdmYkN0?=
 =?utf-8?B?Q2cvK2ZYR0EyOXhaajBGdmNjMUpEUEVHNGhBZ0UzcFpITklEZlJjVEEybEUx?=
 =?utf-8?B?WWsreVZidkxiS2dKZU10ZFdDQXlLSytUUzA2ck1wL0FiMTI0SDI0SnlKdUJv?=
 =?utf-8?B?MDJPMSt6TnNZaEpXaksyRC80RlZLZVlnUFF1dU1PVVZDQnB4Z2JETjN3empL?=
 =?utf-8?B?cHlidGNFbmhZWVBERUNza3VWNWJ5eWM1RTd2MWdxWXh6VDhDUzhJWjJrTWtO?=
 =?utf-8?B?ZHFaYVJIUHdkVWMybi9oQjJsSXhDcFFVWmxDSUFzb2pXaFdOWEJldkFNMkpH?=
 =?utf-8?B?YkphZnFBRnlGb1c1OUlmd2thbmlHUC92UmVlOFBkbnpLUGpLV0FDeWtQQmxC?=
 =?utf-8?B?VUhqREl3R1MwMkJpdWpBREdtYUo0SHplVUlHdmo3dis1YnlKb2R6Q0s5ZGpr?=
 =?utf-8?B?MVg5SUxFWWhZdkhEcURXSDJNcFRHZ2xvK3VNSk52bE5VSHlnUC9PSmRNM2pV?=
 =?utf-8?B?bkREdk9uRDY5TkNjYWJwOEZ4dDVXamFleTZMbllxZXYxejE5YjU4OElqYXFm?=
 =?utf-8?B?cjJzOTVaY00vUkIzdDZmMGlwZEIxT2NWL0JVOGpyRll6ak13MXJKZHEvVG5t?=
 =?utf-8?B?bURtdFY3TXQxV3doVGtzOSsvakxZRDljdW1XZ0ZTUkVxT050Ukc5WDJ3NXhJ?=
 =?utf-8?B?VFF4RU91THJzMjZ6bDBUTG5GUVdzeHMyck9ha2s4M2VOR2N1TENoZzZvVXUy?=
 =?utf-8?B?VXJhSHJreDNVQW5hU0tlSDUxbk5PWm1NOXBuNVd3ZUJCajlRNFZzMXNkcno5?=
 =?utf-8?B?ZnhrS2RyMDQ5Q0hWYllveldrOVVUVmFpbUF6ZUxzTHdyVWxTRVZKVmgvekJR?=
 =?utf-8?B?OEswZU0zWDBIMGtpV08yWU0raTVCTzd5WFJJL3VxOEY2Ym9qQVVEeDZoMWp2?=
 =?utf-8?B?S0tFWVd1TlhxVG1wczdLQnRkeHkxR1BUNk9UWFNQR1ZzYVIrN1lCMHdoOGMz?=
 =?utf-8?B?WGNlbTNxL1NHMEdkVEcra0pFQ0VPQ2lZMDlLMnRpcXdHdUdBK3hMSlZkV3hL?=
 =?utf-8?B?T29RcXZRbG5PQXNYaFdBL0RsQnpLZ1BBUTgvWUJsbDZYbEt5VWJEbWJtdlJr?=
 =?utf-8?B?RGxBYk9ZSFRMRm9RN2xqbk9rVHJMUU5CRTFBY0Q4UGtIWmtOS2VlN1piOW0v?=
 =?utf-8?B?WFVlQU1FR3l2MWprdkcvd0w2aGYrdWdrSExJZ3hwdjhwRzFMUHRpakF0WVJi?=
 =?utf-8?B?MG5DWTFQSTNOcytiZU02S3BHdWJBM3NhVDNoN1ZCcDlkbEUveng1OW1hMWo5?=
 =?utf-8?B?ZEthQmNXWmlFcGMwTnd2eUNydGpGcWQrOVN3b2F0YVdRQUpPR25KYSs3TElv?=
 =?utf-8?B?RmIweVkzUXV2dGE3dStCMFdHczRnSEVWOUlndHVuV1ZJcHJ2cE16WWtST2d3?=
 =?utf-8?B?NFVCZGk1bWdoYTJsK2YzY3NHR2dBNW8wZG5TMWRaeUhtUGRmQVhNSlFvNk5m?=
 =?utf-8?B?M2R0N0NHRnZHYytUcGQ1NWxtZmN5QllXTS9oNGR6MEN0Z29VeGxhRWtBV3Jp?=
 =?utf-8?Q?PWIFDdoJFjVpjPhMSlnZIbLUcdK41rGR8H4xgV9gItIc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2ACACBBB9768843A3C6CC4F742CDA99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fead3a-f79b-4f39-d491-08db663cf7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 03:20:24.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WioWipe3sK7wC48SLMc/GpLfq6zE1X8BSX4lH6njgf/AzY+HIedYGcnd9hnER83UsrMfZnWFJzDkmXoP91vW2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi81LzIwMjMgNDoxOCBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gDQo+PiBPbiBNYXkg
MzEsIDIwMjMgLyAwOTowNywgWWFuZyBYdSB3cm90ZToNCj4+PiBTaW5jZSBjb21taXQgMzI4OTQz
ZTMgKCJVcGRhdGUgdGVzdHMgZm9yIGRpc2NvdmVyeSBsb2cgcGFnZSBjaGFuZ2VzIiksDQo+Pj4g
YmxrdGVzdHMgYWxzbyBpbmNsdWRlIHRoZSBkaXNjb3Zlcnkgc3Vic3lzdGVtIGl0c2VsZi4gQnV0
IGl0DQo+Pj4gd2lsbCBsZWFkIHRoZXNlIGNhc2VzIGZhaWxzIG9uIG9sZGVyIG52bWUtY2xpIHN5
c3RlbS4NCj4+DQo+PiBUaGFua3MgZm9yIHRoaXMgcmVwb3J0LiBXaGF0IGlzIHRoZSBudm1lLWNs
aSB2ZXJzaW9uIHdpdGggdGhlIGlzc3VlPw0KPj4NCj4+Pg0KPj4+IFRvIGF2b2lkIHRoaXMsIGxp
a2UgbnZtZS8wMDIsIHVzZSBfY2hlY2tfZ2VuY3RyIHRvIGNoZWNrIGluc3RlYWQgb2YNCj4+PiBj
b21wYXJpbmcgbWFueSBkaXNjb3ZlcnkgTG9nIEVudHJ5IG91dHB1dC4NCj4+Pg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+Pg0KPj4gVGhl
IGNoYW5nZSBsb29rcyBmaW5lIHRvIG1lLCBidXQgSSdkIHdhaXQgZm9yIGNvbW1lbnRzIGJ5IG52
bWUgDQo+PiBkZXZlbG9wZXJzLg0KPiANCj4gSSdtIG9rIHdpdGggdGhpcyBjaGFuZ2UsIGJ1dCBJ
SVJDIENoYWl0YW55YSB3YW50ZWQgdGhhdCB3ZSBrZWVwIGNoZWNraW5nDQo+IHRoZSBmdWxsIGxv
Zy1wYWdlIG91dHB1dC4uLg0KDQp0aGUgb3JpZ2luYWwgdGVzdGNhc2Ugd2FzIGRlc2lnbmVkIHRv
IHZhbGlkYXRlIHRoZSBsb2cgcGFnZSBpbnRlcm5hbHMNCmFuZCAgdGhhdCBjb3JyZWN0bmVzcyBj
YW5ub3QgYmUgZXN0YWJsaXNoZWQgd2l0aG91dCBsb29raW5nIGludG8gdGhlIGxvZw0KcGFnZS4N
Cg0KYnV0IGdpdmVuIHRoYXQgaG93IG11Y2ggY2h1cm4gdGhpcyBpcyBnZW5lcmF0aW5nIGV2ZXl0
aW1lIHNvbWV0aGluZyANCmNoYW5nZXMgaW4gbnZtZS1jbGkgb3IgaW4ga2VybmVsIGltcGxlbWVu
dGF0aW9uIEknbSByZWFsbHkgd29uZGVyaW5nIGlzDQp0aGF0IHdvcnRoIGV2ZXJ5b25lJ3MgdGlt
ZSA/DQoNClNhZ2kvU2hpbmljaGlybyBhbnkgdGhvdWdodHMgPw0KDQotY2sNCg0KDQo=
