Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FFC433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 22:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiEQW6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 18:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiEQW6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 18:58:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1FF50469
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 15:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZeAhMcdkJSq1lEig1ua1dyLZ2UXi8c/sfMQiAFM+Ef31LERgruiVRpG+KSbhCMj6pYHki0ckrI+n/Jpmfa7EH2NReKjonXqkGJcixGPzK/Wol6WIpRIUz+t6YUCIczSBm/fCFPWTMMOgFLlzi5jRaN35Pj6TfDw370zyNFhZuL9heV0kZ4g5rh09CJfUgiseJQ2xeQFVU6r5c4fb4Xw90ZnFqd9HhdLymGqalNIc76vSdxYVxLwuqezTFkCo4lxPWCkMDKIkxDKO4oYnM2x78tnY1CYLrCfxtXs/1rommD0SxrytifrzLyCg4AnFoQGr9Epa1m11MrRWfwmd4E5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD1NgMheOmEKJQtjKqohrRDszZANbMEb3HOwYcVtFv4=;
 b=MPnMCQdt5O1EK0mS0rTCRoc1EclvjkDDbz45Dcj0DxFi4fawVGhXu9C3UQjYDXnOShWAgluTRegBzOn0lJX3EpMnmBPPbzJAtUA7V/lxYjb7ecY0GrAAIWOB45Xbfp7c9tEKzmzaZgh2jk0zouhb3wm+TPTrLfEvO59MjKNOCDesXwi1TxAWvurkFyM5Nr2OL2crikx2yQ4OaNLyu+dA7O4gwCAPMpApgatJF5wd52Xl8Cn3ojv+ZZtQ4SfPjEdI2eb+TaCIc2Yb8mdzzLUs2Vl1qDTiIzDHa4QPzK4IPNjQbFuRX5KDdTvYT6bzG/KeUi8TLn9Vg5cchd6T/iGt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD1NgMheOmEKJQtjKqohrRDszZANbMEb3HOwYcVtFv4=;
 b=m8jmGyC3+a+FxgsHMNd5EqENiZIMJHWJFHyEJuSgKhc8/GEbWtYpwfAAbyuCAUTB/PLPPFWAZ2cMIw0dk0bPLEdd0eu89TuTUK3esNj88ZJuKCx8dyEX0K+ks03mwH4bihWhVBXS92dHp5EVONp4Nrj3B79V9JK4bLBEK0HNhvDtOSbaMQxVX8FcXXLFq2I2l8GdtsfrlZ0BCLyitDuxRll+1EgGEQR+9sd3wAT2GdUmwQ9krth1Twpa8PPVFL0Tso5LqPAduocycFLmzYQL3ZmcSzC4eMaCrD56q3e9LeE63szG0TzGZT3Hq8vwMiLFAXsU4Tvo1X9Be9uCJ25IUg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 22:58:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 22:58:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "osandov@fb.com" <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Alan Adamson <alan.adamson@oracle.com>
Subject: Re: blktests v4 tests/nvme: add tests for error logging
Thread-Topic: blktests v4 tests/nvme: add tests for error logging
Thread-Index: AQHYaXio2DB+205LuEyFrWaeWinlf60imloAgAEV0QA=
Date:   Tue, 17 May 2022 22:58:00 +0000
Message-ID: <7527361f-b499-c068-dac4-3cef68e9da89@nvidia.com>
References: <20220516225539.81588-1-alan.adamson@oracle.com>
 <20220517062339.krjab3yfex5fvnes@shindev>
In-Reply-To: <20220517062339.krjab3yfex5fvnes@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0da6c69-8265-4e29-57b6-08da3858b13d
x-ms-traffictypediagnostic: MW2PR12MB2442:EE_
x-microsoft-antispam-prvs: <MW2PR12MB24424A881EA0F0EDBF767617A3CE9@MW2PR12MB2442.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rT/QZEkiWm9f7RR8S2JCjSYdWXYnq6kaBcQQztq6gzoikBRh6bty21T5OqlDXbo8FFIvVz9q+bWVnRQRtKMytf48slB3rFZQa0djgzqsCY+SFeGtL3cbde0YfoNFubFdlbEAWgoo+0/JEG4hemmHhTSyveRsxtBMLlIsjRkzkseuTLfZ+7ScmSU6Ido3oDu+ZGrp4dE+LQe8T1Z+Qd9lIq2pGgIxGRHR+PsxTsUvrwBJ+x2NZjJf7LU5KYqhHTMvMu/dUuvcFbSJeVvLyol+jXr+iFJw5HByqYyBoQpLDHEnG+0B9ZbFAyhkuqi9+kadd3U0QV0EsboAs7SosXh+VGxzjIMnEJufINCmg3wavm6IudpvX2lf//GY/4/f5lS6kuiySyYYgNri1pnA0ULMF1hkHzmzWKPleqBecpR8W8l1Et/nDlZFkMrf9obRKJ3qM9bZECZGzKoV2h3mHcXljFR6vYk6E9gSod95GMbkFoAosQYovcvI/O3qvdOr8Jmjskm+s1poaHtjxEDNbNxRjYsYsdfQIgmKQu+Rpf6SmEKPaR48+VgA9wrtVBOBwixKkMRIPY19c2DqL/FVgq3mw/6bzskpGYpP8CoWepa5GKmWtv3CSyfGEmWiEdc2N25sJzxUEg3HXYL/RC0rX0BQCZBzXGop+hqDwO2a5gl3jek9zkB+xkp+/FOEJr/XAuWe0RRYcHLrqaftkdpCtMIY3sEpLyS8S/IQWYnxEUk+o4Y6gAAR+vV6tVNQEBakfESA5DxR0PPjDYzWaJDT3UA1Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(86362001)(508600001)(31696002)(2906002)(91956017)(5660300002)(122000001)(66946007)(8676002)(4326008)(66446008)(64756008)(71200400001)(66476007)(76116006)(8936002)(316002)(38100700002)(38070700005)(54906003)(31686004)(36756003)(6506007)(53546011)(2616005)(6512007)(4744005)(66556008)(6916009)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmE2eXU4V2lXbTFxSlJhZW5DNTRPMUJCdXRHL0Y2c2FKdlIwMkNEcGUvaFpF?=
 =?utf-8?B?NXlQalN0TTdsRnI3cS9jMjhYVDVBS1Vsc3J4TEI5QWRYWWw0MjVySHdMTE8w?=
 =?utf-8?B?QmJ1blp0Nk1taDJ1QTBDL21yNHA5allQN0JsNDBpc0d3RzZtbnhtbDhlek54?=
 =?utf-8?B?VTRqU3N3TVFpd2JOMGJHTUI2SC9LTW5PVzdVRngwWnhBMFY1ODV3ZGJDa2dn?=
 =?utf-8?B?bGdRdTAybXJQSTcrbWVneCtzaksrdEdhL2NHVDhTZW93QUlUbVNmUGVZTHVY?=
 =?utf-8?B?bTZHNzFFSFZZY3pDM2toSE1xWjkvUlJCOXo2ckFIODB5Y0xKd0J0QVAwNG1q?=
 =?utf-8?B?bVROQVRxZUJadzFxSlk1QlFQV2VtNXVoQk9DTFJ5SlVsK2dhNlhIS1dRaHYr?=
 =?utf-8?B?NVlpZCtGR0tzT09rKytvSllzOWs5cFBBc2RUT3AzMkcvVWhUWVI5THhrMCtV?=
 =?utf-8?B?TTRyTjVMdkErMzVtK3ZoZEdUWmY1dHdEKzNoMGlWc1Uxem8vbzhXSnRsZEtG?=
 =?utf-8?B?TU9EQ1dvQmhXQU5PenJBZlZYT3RaU0k5TFNwVHdtNWtENnFJVzV2Q2JJQ25Z?=
 =?utf-8?B?WVV1WTRxVW1vV3BUak45R3daUWxseDR1dEJITGJobGlWeko1MFhqUmhwQ3BD?=
 =?utf-8?B?cDJEMlJ0anZnenpCcTVJYVdOVW1IV0RHOTBTckIxZGFmRVAvekt4Z2YweFBQ?=
 =?utf-8?B?Ull1RFoxN25FYTI2a0hJT1kxN0VEN1NoNUpZMk9MWFRnOW9ObW10ZVo3QWht?=
 =?utf-8?B?QktmZXNrZ1dWRDhTS1lKd084aFlZME1WamNFc0NFVHdEdkJHUnUyM3lyd0pZ?=
 =?utf-8?B?ZUR6N0xIc3duRFBQSlFRbHNqeU41aGx0MWJvTWNhTUF2UW15UHkzN1crblcv?=
 =?utf-8?B?U2RFVWh0MU1neGwxQmE1bEh6L2NkOVNqanBJSCt1UjEwVzh6NU5HSHhKZkpT?=
 =?utf-8?B?Q3dRWUg1aitNZGFaNEduTnNMT2FwRXZxeFVsQTJybk5sL2VLdFltZld3OXRw?=
 =?utf-8?B?dkZNdER6MVE2SDNaOUNaaDBhdEpHSUlYWjdqQndUWk9XWEQzS25uT3BPYnJ3?=
 =?utf-8?B?TDlMd3BIV1ZjaE0yY0RqMzFKMnE4SVpMNUpGTzB4RnBkZ2VpU3UzMlk1UXBJ?=
 =?utf-8?B?UlFNSlhiRHBZLzhvNFlEOGJnSllOQXVJR1RVVEhyU0E4U3RWZFgxZXhwZ1FY?=
 =?utf-8?B?RElQRHg5MmEwUGZwY1NHSWxBdGhqR09lL1dJeWtianBlcmVPdHdZbjZyQUlR?=
 =?utf-8?B?RW1hRmg5T1ZRV1NTaGxIellvY0toeittNG9RZDc2M0JDeHRoMkYvNUJvQ01h?=
 =?utf-8?B?QWdoYXdRZC9HRElwQWZnNWIxbjFNTDBmSzVud2xYNkl3MkZ4SUZCOHM4UEc1?=
 =?utf-8?B?ZmdGbkJwanRqM2ZGRjRGamtUWXlpVFZGK0xlWmtOQU5OdTNab0JkOWZ3WjF5?=
 =?utf-8?B?MzM3Q0liM1NqQ1JXVWE0a2VKaHBoMjBxV0wvbENuaXdpV0MrczR1ekR4T0Ra?=
 =?utf-8?B?UGpwTWF4VFpRTExIdFN0R3ZKaGlkVG1sdGRvZFJGYVRwd2cvd3RKYnVQY083?=
 =?utf-8?B?N1kvS1hyQ3ZMOC95V3JUZ2VERGtRdExPaVAzdWNUTzVjMnZFN3ZGeE9UNVJs?=
 =?utf-8?B?SURLb1Rpd2pSVkxPenpvOE91NCtPb0lGSEFySUI0YlhodTRvclhta2Y3M2Zy?=
 =?utf-8?B?eVhQSWdyKzF4eXV5ekdmMi9pN01GclJOcEZFRGo3RlRweTRrVUhhQjRHOHNq?=
 =?utf-8?B?MFUvWlVZR3htOHhvY1pqTERtK0ZvYmkrNERwTFVjbjFzMlNqaUdlRUxnTGt0?=
 =?utf-8?B?Y20yWWVRYWRyQm1wKzArSVVWYUtWOHdVTHpyWjczZU1UNXAvQXU3d0JRcnNy?=
 =?utf-8?B?NWI0YTlkM0R1V1J3LzdTc3hKQ1VyVWZNQWgrVFNqTmY4Mk1pUjlUVmZ2cXFl?=
 =?utf-8?B?MXFPdHlHMEhyZVZZY3dEbWh4d280ZmNiYStSdHFRWElZMDhPK0RsWTE3Lytr?=
 =?utf-8?B?TVM2QjZVMmpNZVFrT096YXJzbzJrV2ZDcENQUG9ub0lnZ2hENEwwM1VUaGNx?=
 =?utf-8?B?cEVRZmphMFA0UFpYQ2IycUpheHBTOW5JMmFTbENqaWVPQ09nYjd5SUVVcFRH?=
 =?utf-8?B?NzM0RzBabWhuektaYkt5NmkxTjAzZ0NvT2tKOHpwNzFndWhWc3lzK09Rc3k2?=
 =?utf-8?B?VDJ3M2FFMWNya1Irb3Z5dTN3K2R5T0hMd3VyZEcvMmdJRkw0TWZWdE9xVDBL?=
 =?utf-8?B?dmxWNDM2NFpTSVhOT2dEVVY3c2Zpa1FId0piRnI5NWlMb3pEamgrUXpWRzli?=
 =?utf-8?B?eWZkRytvcm9jUis1bVZNMWVSelhwVmdVYjFwV2h4UmZRS3ZVaGlqVUZ4V2Ru?=
 =?utf-8?Q?wzi23zVASiI5h6Q9tHrjy/M9M5n7NH0D9fdv1mRlFG3Li?=
x-ms-exchange-antispam-messagedata-1: a35s0EnT1UuIiQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FF1A949A15E654EBB8448DFED0FB5EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0da6c69-8265-4e29-57b6-08da3858b13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 22:58:00.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azGpYqu/AZVDmWZExPfiVNxqc06o2TzC/nSLL1kqUjZNlJnKDDUfOduATcbpFZJUr9awncjqNV/035I+83rdNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T21hciwNCg0KT24gNS8xNi8yMiAyMzoyMywgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4g
T24gTWF5IDE2LCAyMDIyIC8gMTU6NTUsIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4+IFRlc3QgbnZt
ZSBlcnJvciBsb2dnaW5nIGJ5IGluamVjdGluZyBlcnJvcnMuIEtlcm5lbCBtdXN0IGhhdmUgRkFV
TFRfSU5KRUNUSU9ODQo+PiBhbmQgRkFVTFRfSU5KRUNUSU9OX0RFQlVHX0ZTIGNvbmZpZ3VyZWQg
dG8gdXNlIGVycm9yIGluamVjdG9yLiBUZXN0cyBjYW4gYmUNCj4+IHJ1biB3aXRoIG9yIHdpdGhv
dXQgTlZNRV9WRVJCT1NFX0VSUk9SUyBjb25maWd1cmVkLg0KPj4NCj4+IFRoZXNlIHRlc3QgdmVy
aWZ5IHRoZSBmdW5jdGlvbmFsaXR5IGRlbGl2ZXJlZCBieSB0aGUgZm9sbG93Og0KPj4gICAgICAg
ICAgY29tbWl0IGJkODNmZTZmMmNkMiAoIm52bWU6IGFkZCB2ZXJib3NlIGVycm9yIGxvZ2dpbmci
KQ0KPj4NCj4+IFYyIC0gVXBkYXRlIGZyb20gc3VnZ2VzdGlvbnMgZnJvbSBzaGluaWNoaXJvLmth
d2FzYWtpQHdkYy5jb20NCj4+IFYzIC0gQWRkIGVycm9yIGluamVjdG9yIGhlbHBlciBmdW5jdGlv
bnMgdG8gbnZtZS9yYw0KPj4gVjQgLSBDb21tZW50cyBmcm9tIHNoaW5pY2hpcm8ua2F3YXNha2lA
d2RjLmNvbQ0KPj4NCj4+IEFsYW4gQWRhbXNvbiAoMik6DQo+PiAgICB0ZXN0cy9udm1lOiBhZGQg
aGVscGVyIHJvdXRpbmUgdG8gdXNlIGVycm9yIGluamVjdG9yDQo+PiAgICB0ZXN0cy9udm1lOiBh
ZGQgdGVzdHMgZm9yIGVycm9yIGxvZ2dpbmcNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZXMu
IEZvciB0aGUgc2VyaWVzLA0KPiANCj4gUmV2aWV3ZWQtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtp
IDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IA0KDQpXaGVuZXZlciB5b3UgZ2V0IHNv
bWUgZnJlZSB0aW1lIGl0IHdpbGwgYmUgZ3JlYXQgdG8gaGF2ZSB0aGlzIGluDQp0aGUgcmVwbyBz
byBvdGhlciBkaXN0cm9zIGNhbiBwdWxsIHRoZXNlIGNoYW5nZXMuDQoNCi1jaw0KDQoNCg==
