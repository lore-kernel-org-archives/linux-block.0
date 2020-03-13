Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60873C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 19:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060CF206E2
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 19:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=northeastern.edu header.i=@northeastern.edu header.b="qt4vj/M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMT5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:57:10 -0400
Received: from mail-dm6nam12on2122.outbound.protection.outlook.com ([40.107.243.122]:6753
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgCMT5K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 15:57:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDRWqVVYGkp8tf/OolEe7t4amawxL4lM16JmnG+KWmI6jT8mKXQQICOqexQ4K0J2nEzAHYTwqSmPlmdo/P1IiG+WCzeQotfxFHZpIkS8pVorYyYwra0GGRQHNMmPzOU+wsuLTWA5hWJf/IQ5pdZTIziuEctZMD7HoWsAEdSPkGiX+LPq0UwccSHTHkT98bBpjPr8RKQVg6zFu5HdrorORukYgnaDY+JwOY+7Yxut4Co3El5zFUVxd/wkfk2F6d/o59xLmTCpMG6+mUoaxKmRAtCffoFBloGKdnYd8l3cH/p2IJADPTyZtQ/W98ZWcOySTQRlNrKUlhres470M73TBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chwv/Y9zDO5icLi8M0detZTw5CBnRPGqBWpaNnj4khA=;
 b=Lu7psh6TP75GnQOdZKq8/ILPJTUcyUQLTi9Sp8aAGyl6RylsYW3PwpGTyf7A4Hmo8OwuZEOWLAAlmZYj7bLqMp2u3ByxHuSIsuriZuDnmHo+CmZPCeFUjMNEpjj4QK2oLuruef+CBsT2ajcQAX5NYCI26/548kp0E1OwM9y+aCoFl7j391hd0t/AwPyFep30uPnhPztBTWuey9vHI8ZFN14pJt1pb9SQypPsg95lvu7hco6e0x3cqG2T0F5Gz1xopH3AiwZUbFUY6/LeO1pnV2mlTqW3MdX4Bm5upxYlDXKBWn0X4HZSGz+nqAcP1u6puOvb2CUzqtkgfiizBkQWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northeastern.edu; dmarc=pass action=none
 header.from=northeastern.edu; dkim=pass header.d=northeastern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northeastern.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chwv/Y9zDO5icLi8M0detZTw5CBnRPGqBWpaNnj4khA=;
 b=qt4vj/M7TvVs4HlWEYqC1XdYWwJ8Fyfq7idXwIAY+61ba6sNGRIAKNXNoaYxqhjs02jcyncte5ndSmcmkIGAz2ZEcCJK4oDAchtJLuHMi5F4ys9MEENBp5KALCmbOeL4yP1r4dBkZkOz3eVb7UGIWhiFMIXAbgaT2yoVXUdF7po=
Received: from BL0PR06MB4548.namprd06.prod.outlook.com (2603:10b6:208:56::26)
 by BL0PR06MB4338.namprd06.prod.outlook.com (2603:10b6:208:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Fri, 13 Mar
 2020 19:57:07 +0000
Received: from BL0PR06MB4548.namprd06.prod.outlook.com
 ([fe80::20f8:a2f2:5ebc:da2]) by BL0PR06MB4548.namprd06.prod.outlook.com
 ([fe80::20f8:a2f2:5ebc:da2%7]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 19:57:07 +0000
From:   Changming Liu <liu.changm@northeastern.edu>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [Bug Report] block: integer overflow in blk_ioctl_discard
Thread-Topic: [Bug Report] block: integer overflow in blk_ioctl_discard
Thread-Index: AdX0/NoTSdBEELp9Sgu+quzhDuo20wDd9EqAAD7rV2A=
Date:   Fri, 13 Mar 2020 19:57:06 +0000
Message-ID: <BL0PR06MB4548E3C93B45934A06CB7999E5FA0@BL0PR06MB4548.namprd06.prod.outlook.com>
References: <BL0PR06MB454833C4DFF442D4F61C4783E5E10@BL0PR06MB4548.namprd06.prod.outlook.com>
 <be5fb01e-1aa9-415e-6ec6-a4b842b624fd@kernel.dk>
In-Reply-To: <be5fb01e-1aa9-415e-6ec6-a4b842b624fd@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=liu.changm@northeastern.edu; 
x-originating-ip: [2601:197:a7f:5cb0:488f:29a7:ed64:62df]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c56c8fc-1929-4254-325d-08d7c788b591
x-ms-traffictypediagnostic: BL0PR06MB4338:
x-microsoft-antispam-prvs: <BL0PR06MB433871426EB721C29716C9B6E5FA0@BL0PR06MB4338.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(52536014)(4326008)(81166006)(76116006)(8676002)(86362001)(45080400002)(966005)(6506007)(53546011)(478600001)(33656002)(81156014)(66446008)(64756008)(7696005)(66476007)(66556008)(9686003)(5660300002)(55016002)(2906002)(316002)(6916009)(75432002)(186003)(8936002)(71200400001)(786003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR06MB4338;H:BL0PR06MB4548.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: northeastern.edu does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTwna6p8w7J4Gi76M0RjxTVetTWKi4xfO9XDZCbhtdQO/GNhimvZ8tsW9nmSeajiqUcssbH1AfuE7h1vbv3TBZ4PwVkMxe6Iw1qOWVHbzJ/UzYHPpYLTkWmFZqpukl9QPI0buedTDoUHyvSIZQ5ONhAuT5fPMwN+gwDvp/7aMWC46N7YDc2wDBsT/ncuRr04eq5S9kSZpnS84PNx8/zQZmuXvcYgw0dCsRFj2IzpkT7e4H+UUIBidZuq8qkBFHyigxLeRv7mKrEs3GjAlwEcNsi/NASC2VjpVWqHpLZF9gtPa49o1UHcdvrdPHon26v10NdYmbXrmL0WqkXfXmx+YwIwWu0BsB1F1qFgFfXWVgO/MwItMY85UuG1YqhxCbpec4C7LJosm3j+erJ6CTr5zBFmBqNlWpYKs15bTOe47Yd0Cfk7Yky0n8XyLb35jnjOG3d4yraqk5SH6QfbEHhILIcPUqNitpvHbYucKA5/XsdieJcCCUH43T21j/QkJ0moRyZowLSeyENVWqCqJcSvPm7rJWRr2jRtUjofGvAHSOtYjSPnTK2GpO4woqW6jgNuvVcNSteu+K834s6JtSniSQt//a+jLL8UooMd37QL5g21H010jxOFSL98nOrN+dwS
x-ms-exchange-antispam-messagedata: RkfZGghUiI2Im8+r8+aoHsyw8QqfQ/ubuJRE+IBUdJzeKwznj3jlsu/ScscTcnc59IWojTsLlIdqN1DZQYV5HAwCBXgD8diWK370bgVY1JZbyOjgrh7FeqsP8V36wNTuUZ8tK9f1RKKgNnkyaoZZeZNZy/Nvu5coY8ecU6mXsDsFWBF+Zn2X5wURr05F/Ka+2ZoBcvJF9afUN/zO42Fk4A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: northeastern.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c56c8fc-1929-4254-325d-08d7c788b591
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 19:57:06.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8eec281-aaa3-4dae-ac9b-9a398b9215e7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAXBIfsy6YOr4XrdO1HpESs9P3pSY1k89WBUy+5XpqnDcj6jRy50VrGaXmHrToBKtQzWd2vpgTxLjCrLk+zO6nmh/suuTMOGLR/tlpjICgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4338
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTIsIDIwMjAgOTo0NyBBTQ0K
PiBUbzogQ2hhbmdtaW5nIExpdSA8bGl1LmNoYW5nbUBub3J0aGVhc3Rlcm4uZWR1PjsgbGludXgt
DQo+IGJsb2NrQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0J1ZyBSZXBvcnRdIGJs
b2NrOiBpbnRlZ2VyIG92ZXJmbG93IGluIGJsa19pb2N0bF9kaXNjYXJkDQo+IA0KPiBPbiAzLzcv
MjAgODo1MiBQTSwgQ2hhbmdtaW5nIExpdSB3cm90ZToNCj4gPiBIaSBKZW5zLA0KPiA+IEdyZWV0
aW5ncywgSSdtIGEgZmlyc3QteWVhciBQaEQgc3R1ZGVudCB3aG8gaXMgaW50ZXJlc3RlZCBpbiB0
aGUgdXNhZ2UNCj4gPiBvZiBVQlNhbiBpbiBsaW51eCBrZXJuZWwuIFdpdGggc29tZSBleHBlcmlt
ZW50cywgSSBmb3VuZCB0aGF0IGluDQo+ID4gL2Jsb2NrL2lvY3RsLmMgZnVuY3Rpb24gYmxrX2lv
Y3RsX2Rpc2NhcmQuDQo+ID4NCj4gPiBUd28gdWludDY0IGludGVnZXJzLCBuYW1lbHksIHN0YXJ0
IGFuZCBsZW4sIGFyZSBkaXJlY3RseSBmcm9tIHVzZXINCj4gPiBzcGFjZSwgc28gdGhlIHN1bSBv
ZiB0aGVzZSB0d28gY2FuIG92ZXJmbG93IGFuZCB3cmFwIGFyb3VuZC4gQXMgYQ0KPiA+IGNvbnNl
cXVlbmNlLCB0aGUgY2hlY2sgb2YgdGhlIHN1bSBhZ2FpbnN0IGZ1bmN0aW9uIGlfc2l6ZV9yZWFk
IGF0IGlmDQo+ID4gKHN0YXJ0ICsgbGVuID4gaV9zaXplX3JlYWQoYmRldi0+YmRfaW5vZGUpKSBj
YW4gYmUgc2tpcHBlZCBkdWUgdG8gdGhlDQo+ID4gdW5zaWduZWQgd3JhcCBhcm91bmQsIHRoZSBv
dmVyZmxvd24gc3VtIGlzIHBhc3NlZCB0byB0aGUgM3JkIHBhcmFtZXRlcg0KPiA+IG9mIGZ1bmN0
aW9uIHRydW5jYXRlX2lub2RlX3BhZ2VzX3JhbmdlLCB3aGljaCBtaWdodCBjYXVzZSB1bmRlc2ly
ZWQNCj4gPiBpc3N1ZS4gVGhpcyBzdGlsbCBleGlzdHMgaW4gdGhlIGxhdGVzdCB2ZXJzaW9uLCBp
LmUuIGxpbnV4LTUuNS44Lg0KPiA+DQo+ID4gSXQncyB3ZWxsIHdvcnRoIG5vdGluZyB0aGF0LCBh
IHZlcnkgc2ltaWxhciBwYXR0ZXJuIGNhbiBiZSB3aXRuZXNzZWQNCj4gPiBpbiBmdW5jdGlvbiBi
bGtfaW9jdGxfemVyb291dCB3aGVyZSB0aGVyZSBhcmUgYWxzbyB0d28gdWludDY0DQo+ID4gdmFy
aWFibGVzIHdpdGggdGhlIHNhbWUgbmFtZSBmcm9tIHVzZXIgc3BhY2UsIGFuZCB0aGUgc3VtIG9m
IHRoZSB0d28NCj4gPiB2YXJpYWJsZXMgYXJlIHBhc3NlZCB0byBmdW5jdGlvbiB0cnVuY2F0ZV9p
bm9kZV9wYWdlc19yYW5nZSB0b28uDQo+ID4gSG93ZXZlciBpbiB0aGlzIGNhc2UsIHRoZSB3cmFw
IGFyb3VuZCBpcyBjaGVjayBhdCBsaW5lIDI2MiwgdGh1cyB0aGUNCj4gPiB2YWx1ZSBwYXNzZWQg
dG8gdHJ1bmNhdGVfaW5vZGVfcGFnZXNfcmFuZ2UgY2Fubm90IG92ZXJmbG93Lg0KPiA+DQo+ID4g
U28gaXQgbG9va3MgbGlrZSB0aGUgaXNzdWUgaW4gYmxrX2lvY3RsX3plcm9vdXQgd2FzIGRpc2N1
c3NlZCBhbmQNCj4gPiBmaXhlZCBpbg0KPiA+IGh0dHBzOi8vbmFtMDUuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGttbC4NCj4gPg0KPiBpdS5lZHUl
MkZoeXBlcm1haWwlMkZsaW51eCUyRmtlcm5lbCUyRjE1MTEuMSUyRjA0NDAzLmh0bWwmYW1wO2Rh
dGENCj4gPTAyJQ0KPiA+DQo+IDdDMDElN0NsaXUuY2hhbmdtJTQwbm9ydGhlYXN0ZXJuLmVkdSU3
Qzc5NzcyZGY4YWY4ZTQ2OGY0M2M1MDhkN2M2OA0KPiBiY2ZkDQo+ID4NCj4gYiU3Q2E4ZWVjMjgx
YWFhMzRkYWVhYzliOWEzOThiOTIxNWU3JTdDMCU3QzAlN0M2MzcxOTYxNzYxMDczNg0KPiA2NTc3
JmFtcDsNCj4gPg0KPiBzZGF0YT1xazdtdHZ0NUxKQ21IRWJ6OTRZb3J4RHBKNzh6TGlCa3dQWHJh
MnFiVVJFJTNEJmFtcDtyZXNlcnZlZA0KPiA9MA0KPiA+IEJ1dCBzaW5jZSBpbiBibGtfaW9jdGxf
ZGlzY2FyZCBoYXMgdGhlIHNhbWUgaXNzdWUsIEkgd29uZGVyIGlmIGl0J3MNCj4gPiB3b3J0aCBm
aXhpbmcgdGhlIGlzc3VlIGluIGJsa19pb2N0bF9kaXNjYXJkIGFzIHdlbGwuIElmIG5vdCwgSSB3
b3VsZA0KPiA+IGFwcHJlY2lhdGUgaXQgaWYgSSBjYW4ga25vdyB0aGUgcmVhc29uLCB0aGlzIGNh
biBoZWxwIG1lIHVuZGVyc3RhbmQNCj4gPiB0aGUgc3lzdGVtIGEgbG90Lg0KPiA+DQo+ID4gSSBj
YyBteSBjb2xsZWFndWUgb24gdGhlIGV4cGVyaW1lbnQgaGVyZSB0byBrZWVwIGhpbSB1cGRhdGVk
Lg0KPiA+DQo+ID4gSXQncyBhIGdyZWF0IGhvbm9yIHRvIHJlYWNoIG91dCB0byB5b3UgaGFyZGNv
cmUgbGludXgga2VybmVsDQo+ID4gZGV2ZWxvcGVyLCB5b3UgZ3V5cyBoYXZlIGJlZW4gdGhlIGhl
cm8gZXZlciBzaW5jZSBJIHN0YXJ0ZWQgbGVhcm5pbmcNCj4gPiBDUy4gTG9va2luZyBmb3J3YXJk
IHRvIHlvdXIgdmFsdWFibGUgcmVzcG9uc2UhDQo+IA0KPiBMb29rcyBsaWtlIHlvdXIgYW5hbHlz
aXMgaXMgY29ycmVjdCwgY2FyZSB0byBzZW5kIGEgcGF0Y2ggdG8gZml4IGl0IHVwPw0KDQpUaGFu
a3MgZm9yIHlvdXIgcmVjb2duaXRpb24hIFRoaXMgbWVhbnMgYSBsb3QgdG8gbWUhDQpJJ3ZlIHNl
bnQgeW91IGEgcGF0Y2ggdGhhdCBjYW4gZml4IGl0LCBtb3N0bHkgaW4gYWNjb3JkIHdpdGggcGF0
Y2ggDQoyMmRkNmQzNTY2MjhiY2NiMWE4M2UxMjIxMmVjMjkzNGY0NDQ0ZTJjLiANCkZlZWwgZnJl
ZSB0byBtb2RpZnkgYXMgeW91IHdhbnQuDQoNCkJlc3QsDQotLSBDaGFuZ21pbmcgTGl1DQo+IA0K
PiAtLQ0KPiBKZW5zIEF4Ym9lDQoNCg==
