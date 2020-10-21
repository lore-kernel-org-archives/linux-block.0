Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63593C388F9
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF570223BF
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="AddmeDN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503371AbgJURLC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:11:02 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:27252
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503370AbgJURLC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 13:11:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjKUXSRuv592K8SpypVQ5vELoX+oMHIfBrjbEjBn68atEHVPJjsOr/M42nivlLPuUGtihQ69XUUcfFq0/RELjp5KQtGsV4UBrt1LOre4/tC3EeUqNStpvHmPZsUcu3SShnGe6aKAFCRmyNkoynuel07KJmsjpon5SPMnznK/EbqjS4ocvul5hq/Q2HNahWbf8bAlHXbwIUmr3nTC8C7bl9JcYGKrMj3nc9LdgxxfCJ5YPuyKnsQoBpqey+NlIvy/zjP4iSLPN9e0oDKmSmDylQdn5oEXbSYyx8bim4ezI8062NrIhQ/FgL4Z5LnZuPEdhGq0WVYz2RW0X8TJlikjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxyI2XoagPHTKBx2KnltczpaDlF1lNOItv8QjmzeldI=;
 b=QhgVjA/uhqPDXrvWzUeJ6MRGIJcaU89WkTaCwWCfxcYY/EPqJBS8FdIbDyl8BzypFfy16Y+/BpUtD8/SLX3KP3mjCAQu5D8rOtUzX2Pj6Y1X4Sw74SsANWpukQcCYDANw0SmouzmVChk14iVhGYyPKHAJw0l6Uw1tlhUWqjDxA7ASZJl8G5f2nOYNSj2XHjIsX4wZ2VrL1CDkW3WaXmaGP5/VYX43FPmlOb7yA0m+qMu7/90umf2ljku8zMS5T2H2CrUeUOiw/paqQvDZI/MagxGK0qGWct60edOhXxjH+WGnDPuGJcgkErwg1CLf+uP+WJWAe0g6+7xQw1F7md2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxyI2XoagPHTKBx2KnltczpaDlF1lNOItv8QjmzeldI=;
 b=AddmeDN/Qd0xTefwEXewnG1gQvqOM8REI6M9nNiKIN8eVdIZJ8JXr5KcMtJlcJGcMb3vRJhwRpv7fxCd5SVx92POddJH0Iszm33CckcSRP+uo2/DE1FuBB2kSTvoqCLHc/RUK7BeqO58WMZK40NjkT7ZQaoglrtR5XVrNe78pDo=
Received: from SN6PR08MB4208.namprd08.prod.outlook.com (2603:10b6:805:3b::21)
 by SN2PR0801MB2141.namprd08.prod.outlook.com (2603:10b6:804:13::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 17:10:59 +0000
Received: from SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa]) by SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 17:10:59 +0000
From:   "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Subject: RE: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Topic: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Index: AQHWoLSk7QDKlgB4AkWtKLxj5k5RI6mYUcIAgAJzT5CAAAw0AIAEt6vwgAGHlACAAUVw0A==
Date:   Wed, 21 Oct 2020 17:10:59 +0000
Message-ID: <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
In-Reply-To: <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [104.129.198.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c158595-1703-43fd-121d-08d875e447df
x-ms-traffictypediagnostic: SN2PR0801MB2141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR0801MB214155D3A37C9068C60AEB6AB31C0@SN2PR0801MB2141.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxqQaAfUjrC4vZvBaf7lRXr1S6URp6rbYbMtPCE0YiuXVu5WZz83/Hfj63Zp28CZB38VcHeycnoRUzYHpKB19Fe+ScQq5556WyrX6j1tFEFt+JEN8Lmu8kxzSdjXMsISzKONiH4kp4iRVxlPAdrLUI69Wo+gigO4RJFbfqzYLHnXt96VSaNfwR5x0P0nHqRG71ScrPoX1BO100XwvVnPe28Rl/9DMb3/Ks9UOdmeE6r648ULhvaIY0jPhhKtQadbulSUrvLBYBeJ+aq7QsFy6lGQyC3aZeIvNpFzU7DnDxapPx5Z/1hQuDts3rrnl0sdJxWLctfaxzGbGbIo/rtVnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4208.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(64756008)(2906002)(478600001)(7696005)(83380400001)(316002)(54906003)(66446008)(186003)(9686003)(53546011)(33656002)(6506007)(5660300002)(4326008)(55236004)(26005)(66556008)(66476007)(76116006)(66946007)(52536014)(6916009)(107886003)(86362001)(8936002)(8676002)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c2CiAab1wO9f4cNS2Q/PnaimLxSggtKOtX8RgjsBSA2ptkYrM/I2Cu6DOC7kMpcM/seFnrF5Gk/lG9sY4xc97d+wrrH3OQoh0vSOvNJ2BdZcB/nmLTTIjuGbAzozKRMeMKY+7meVR6gcXo/cTh9WN5vK3QKll2kO2626IVYRJSpYrnWE8aXC5XmAthV43IQUW1hNtP6ZIogZlBIiovTM3vBx59bTZAiTa0RnqGQH6MGK9OsguCSnjm2DybWwQ+4S6bE3F83ybl6NvYpgkUJMCGfnwjWlV6J0aNfeKXQo9wYnAQBMhTiFvUoUWTMiZu57CdWNXKuv04MoQbeI8BGu3J51Jod3ga4SGVQ+GpMHTt1LzZpDJm2AKfJQAo6J5JfbETOKv+gPDvjVoCda6PIatfw1U96ctv5gnrOy+aOu0E3oAR+UffsRTrkcjAxLxT2gbPhi1RKlNb4aJwBwjJ49p/H5TbmUz60A7dPPLY0iMc8LfkZdJhR809Km8XKDnzbwbk/xR06qeqSBTD+vz1pWLVLu0/qZJ/BILWoT/Ia6pDOHLqwA27WGcMooJ9T7oZ1czV87jPM4h9pTSWn9Aey5A+VGjDLAKIl+o+z7VcWFW3CsakkG3j4hmbjpoWIB9mbfHzvdMcKE2igq2heXrFQYbw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4208.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c158595-1703-43fd-121d-08d875e447df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 17:10:59.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWsZ0v3nkIwdFndjN7I5yHNBK1K1Nf4s4ETpIchNgpBoVWePmyUFHB/05y4DlzTj+WcsIlPLnpuwFiC+PYxOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB2141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVHVlc2RheSwgT2N0b2JlciAyMCwgMjAyMCAzOjM2IFBNLCBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiAgICAgV2hhdCBkb2VzIExpbnV4IGdl
dCBmcm9tIG1lcmdpbmcgbXBvb2w/DQo+IA0KDQpXaGF0IExpbnV4IGdldHMgZnJvbSBtZXJnaW5n
IG1wb29sIGlzIGEgZ2VuZXJpYyBvYmplY3Qgc3RvcmUgdGFyZ2V0IHdpdGggc29tZQ0KdW5pcXVl
IGFuZCBiZW5lZmljaWFsIGZlYXR1cmVzOg0KDQotIHRoZSBhYmlsaXR5IHRvIGFsbG9jYXRlIG9i
amVjdHMgZnJvbSBtdWx0aXBsZSBjbGFzc2VzIG9mIG1lZGlhDQotIGZhY2lsaXRpZXMgdG8gbWVt
b3J5LW1hcCAoYW5kIHVubWFwKSBjb2xsZWN0aW9ucyBvZiByZWxhdGVkIG9iamVjdHMgd2l0aCBz
aW1pbGFyDQpsaWZldGltZXMgaW4gYSBzaW5nbGUgY2FsbA0KLSBwcm9hY3RpdmUgZXZpY3Rpb24g
b2Ygb2JqZWN0IGRhdGEgZnJvbSB0aGUgcGFnZSBjYWNoZSB3aGljaCB0YWtlcyBpbnRvIGFjY291
bnQNCnRoZXNlIG9iamVjdCByZWxhdGlvbnNoaXBzIGFuZCBsaWZldGltZXMNCi0gY29uY3VycmVu
dCBhY2Nlc3MgdG8gb2JqZWN0IGRhdGEgZGlyZWN0bHkgYW5kIG1lbW9yeSBtYXBwZWQgdG8gZWxp
bWluYXRlDQpwYWdlIGNhY2hlIHBvbGx1dGlvbiBmcm9tIGJhY2tncm91bmQgb3BlcmF0aW9ucw0K
LSBhIG1hbmFnZW1lbnQgbW9kZWwgdGhhdCBpcyBpbnRlbnRpb25hbGx5IHBhdHRlcm5lZCBhZnRl
ciBMVk0gc28gYXMgdG8gZmVlbA0KZmFtaWxpYXIgdG8gTGludXggdXNlcnMNCg0KVGhlIEhTRSBz
dG9yYWdlIGVuZ2luZSwgd2hpY2ggaXMgYnVpbHQgb24gbXBvb2wsIGNvbnNpc3RlbnRseSBkZW1v
bnN0cmF0ZXMNCnRocm91Z2hwdXRzIGFuZCBsYXRlbmNpZXMgaW4gcmVhbC13b3JsZCBhcHBsaWNh
dGlvbnMgdGhhdCBhcmUgbXVsdGlwbGVzIGJldHRlcg0KdGhhbiBjb21tb24gYWx0ZXJuYXRpdmVz
LiAgV2UgYmVsaWV2ZSB0aGlzIHJlcHJlc2VudHMgYSBjb25jcmV0ZSBleGFtcGxlIG9mDQp0aGUg
YmVuZWZpdHMgb2YgdGhlIG1wb29sIG9iamVjdCBzdG9yZS4NCg0KVGhhdCBzYWlkLCB3ZSBhcmUg
dmVyeSBvcGVuIHRvIGlkZWFzIG9uIGhvdyB3ZSBjYW4gaW1wcm92ZSB0aGUgbXBvb2wNCmltcGxl
bWVudGF0aW9uIHRvIGJlIGJldHRlciBhbGlnbmVkIHdpdGggZXhpc3RpbmcgTGludXggSS9PIG1l
Y2hhbmlzbXMuDQoNClRoYW5rcywNCk5hYmVlbA0K
