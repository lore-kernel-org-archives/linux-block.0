Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE60C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E159C60240
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbhESI3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 04:29:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51090 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245149AbhESI3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 04:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621412864; x=1652948864;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xd1gaub4Yy56MleL8ejZLdnLUZ4F49OyJqX3BQawkSs=;
  b=mz/W43rhvST38kc73QzGIIuOmiDp8hoXI3eV+SMopkTbd2ypr7hYB9/T
   S857+0bXigtbkSHFn69FMHnGwCK4esr9DLsjPeSWqqjqBix+K26vuv0c4
   FXKe6CP0EWNmOv/YAvP9j4ikSoaPszZui59xzBwBmArnA/PhtwZ9FY72A
   fWIV4uWLxp4OP9/MaI7588FhpBHAlAzcGGJbIDV3Y+BqDa3qidKEGmspu
   JtsXiuefLuEPg2yVKUSSoF0ALo0JWfcGa4Zrbg86BaSg5CG3FVsN2RVrP
   AXTP5aw6TYlDYJBy+ycAiX2anUlzsOiB11QaV3dDtewdOycUH0ifMHTqs
   A==;
IronPort-SDR: Dc8lC+/vKeR3aHLF47efCviR+fMp6Te1+N69+/aLsh1/v00qHZF6nEVo5yb72Jn6xsDK7MCIxq
 iI8+BqjETpsJGeM3ZYE9ikJRkJtqgV00FD3XJljJ4vJ3tgdFkZc5PKlbKPWhnQcMyHoc2POHJI
 I+jG4y/e0nCIPtnQvA+eNFosc1iM2yPpitMKAkgy2lv6gCieuU08Pg5+FRIQBEmnScuJ9AC6Yu
 qAQduNE9ibKLDfnAwBjB+XOD4S5wAh5Y/W3sxCzbdtq1/+w+QO/DM+xTQ1WbU+f9qkYShUnT06
 /pE=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="272623090"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 16:27:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgZwa1vQenxrcjhAHd6IspwriI3nbo44MYKbRZUC3up/IxjP/g/xrc1tNWNxoV5vq/N7jYOm7Fp+6GjcBZgEyfVsIjpJl6k9ePiB8UliwiKtDARxJSFq94mTSDNnwoFZdo7X9SWvfLWJgVdRmBF09HhrWUivmFcx6r0RR1qIqS12997tZoslFw04XJSKsuC3M7vuWzskm9I0Mjlx4DC0x094GDWkvntC4Yo3Jg93eaZhMEN7Yq/iF/a1rwvEyLNm+U7/oJ9rXaeM50O6fXE5i7/sy8ArReEy7cS2aXc1aqvUUnBj7H84suwgNyi4ITy0j3zlfg1hnijWRwv3CQA5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd1gaub4Yy56MleL8ejZLdnLUZ4F49OyJqX3BQawkSs=;
 b=XYHzUiiE2nc0JbCwWTs5v/I3f/NmUUdpHgoop3Cjj37ussqzAp334dU5YVYkx+xRGEWktKDx78lsLXeNMknY+YUoNEPdm+7hdmYAznHjRooN4NulJhFF7nnRFVOoMnUBzY+G0bb87EnxrSsJ5wyNMsdo44OfYDqJbkAfHIuGD+1Uy1AIKyY95Vg/hS2afJZxjdrbZZJN8+vYMwsS965/S44Q1feWMCVnXwaHIZrAZ6J1apTE9rsposSICftts8XJkkCtlbLQQX/v19ZK/vCZdFAZEpX1szMyoX/0q25D3wsWgkrEVdZ1Fy9CjrAba5Q/DqMAOfO3JW1GlhCD6Mgg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd1gaub4Yy56MleL8ejZLdnLUZ4F49OyJqX3BQawkSs=;
 b=sVKf89LDyuYeoRKNU+9T0wN5uZFrjPt6wst+yuACGiyPvoZ0Y3+xEAJ+PQ1zVLEmfLC4nw26CmOCn87b/KwsocSz6gaHAwjpKreSBNjHNNn+SIS/gvxTZdbsvzjqSQ33UWHHVwpaAnMcWLfD5TkkJ9wNriTwKsFRYoMc5ncEXUY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB7082.namprd04.prod.outlook.com (2603:10b6:5:24d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 08:27:39 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 08:27:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/11] block: introduce bio zone helpers
Thread-Topic: [PATCH 02/11] block: introduce bio zone helpers
Thread-Index: AQHXTFpxxhi/R314VUOlDqa3DvnpJQ==
Date:   Wed, 19 May 2021 08:27:39 +0000
Message-ID: <DM6PR04MB70815F66C8611016CD579BC6E72B9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-3-damien.lemoal@wdc.com>
 <PH0PR04MB7416EC127D2BB9639E82E1579B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <65441A15-23E1-4C5B-A145-8C1EA9ECB251@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:688d:8185:801b:83a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0308d761-a99d-4677-9483-08d91a9ff721
x-ms-traffictypediagnostic: DM6PR04MB7082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB7082653D08529B916BDA812DE72B9@DM6PR04MB7082.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KInG5gBRN9gTjmgPdzznkrHxpO2BsAJFKxdQ/uvpe3ixt+9RM2wvsIR4geUnEhor1HLH99V4m8RDnhNeovMHAXsPPoXdXXLAY2g1x3ompPkYA/tmYS8O7ngXc32WJR5lbmf+VmynOCQSlbNz0N+rbF+nynngEhXigmFMTF2fGijUeErbrTTmszKZTt51NRpKe738B72MOZ5/fuUpB4I0LNYcwJgASCQSpYM60Qz0xryObrv05GCvaBrn5mSz3YqVjOmBdkEpFw7GdOpW4SVTRlo5qxhn5Vw2hSr4iDT57K5lKsC4OuRqqpJuXCkpJEE5Y7+DHhApCZUstK45SuUexdIPmVvrLsVe/fo3au/1o0oIwWDswOBNWMXug8nSNt7BAS2Wo0lqS5TOoqnN/N5AVz833eZO1OweQn9jNE7czAuEvkRjwKQPGDYpV0Y3LAvhjM8rxmLVAKmZOF6a9k3w00ipwGQxLQ71+Vad2W3739B4Gqfo5aEsgLuLB7T7yZFYdTSHBq4KERshusicnsNxnKHlw3Rgw7B9ZLRqTKQF4jSUp9+p4PEi77nkZbGX7fBCbZXPM6qmJoK+JU9FhMGZYJ6JZ5i2w2gi/DpEehMFlpU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(122000001)(38100700002)(53546011)(83380400001)(86362001)(7696005)(186003)(4744005)(6506007)(33656002)(71200400001)(64756008)(9686003)(6636002)(2906002)(8936002)(55016002)(76116006)(4326008)(478600001)(91956017)(66946007)(66476007)(54906003)(110136005)(52536014)(316002)(5660300002)(66556008)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bzRLanhvbytyYUFkL0V1bWRrc0duRXJZaEhSdUQ0bytmRGFWU3VHL01QRGQ5?=
 =?utf-8?B?MHFRVU5rMFZiVU9Rd0tnK0hmTUoySk9mTmgwVzhRelNCeGdNWTNNMjRmd0NI?=
 =?utf-8?B?aUNCMlpFRmxBb2dMZmhoNkJMbU9FYnYveERPYWxrdzk0c21ic2V6Mk1Nekox?=
 =?utf-8?B?NHNXK3lsN0ZVblZWVmpienNtdGxKRzUvaEJKOFVsVjlaem9uMHk0N2tLbUN5?=
 =?utf-8?B?Y2gvTGowSjhZa1JvVEpCSFBaOEdCUjh4dnVMUC9Xbm9nc25WK1EzbFJDVFpT?=
 =?utf-8?B?bThLamhXYVJpSGRrdVZVMTFNQXJ1SzR0YU8vYzdMM2tLdEdPNkpMcjlpOUtN?=
 =?utf-8?B?anZWZVgwdXpKaG9QaXFzQTR0VDZRZzRITzk2V2kzMFczUzNkZDVuTEdjbm5p?=
 =?utf-8?B?WklmYVZWYzArOXlka0Z0bWtKaXZjNHVZa01PcGE2MG4reVh4a1p5Z3R0bGNO?=
 =?utf-8?B?WjlHaFc3SWJ3TVo5dThYWUc3VzdVUk9OcW1vYm1abysxcVFQYUJJOGozVGtC?=
 =?utf-8?B?UU1KNWJnSE0xd1h5R0FYcmY4Sjd3T01jZGp6b1JzVmlxelp2SlVjWmlEVk1y?=
 =?utf-8?B?S1NRTjBXWHB2SDg2UWF1YkVNN3I3Z2NQUzNUSkVXUnJpVE9VbFIyb1JvaEpl?=
 =?utf-8?B?TnRQM29kT0ZQa2EvRXVsZVNBUHZLSXJMYUxRckgrMmtFN0ZUbFVRUFhqYlBH?=
 =?utf-8?B?djllaUtzM0kzeXVRVXhIOTBLTkM1ajRBV0wrYWswbkU0UE05RGRwQ0hoZlk5?=
 =?utf-8?B?Q01RQnpKU2FCWTRLTEVmN2dwdmlnTDdMRTNNRjd1WG5RbW1XcFZzamRQRU14?=
 =?utf-8?B?b0VHblowMUdlWHovRzNwVTV3UWRCTjRtY0RaRlZvTmNZYm1meHlaMXlqREpk?=
 =?utf-8?B?OEd1cEhWOFBTYTNtZDd0VHR3dzJydlBYMVZyQWVVNGloZEhOcmVVQUluNkc3?=
 =?utf-8?B?Q0dtQUlJNVQyVVQrYk5ZQXU0TFFwMUxPc3Y0c2V1VlNnZzBYa1kxWlZqSUl0?=
 =?utf-8?B?RU1ZdVJBanFlamxQQVJHT1JuQmJzY2twQzMyWGF5Z3JIa1RETVpTTmx6NzBD?=
 =?utf-8?B?Q3Qyek9sM2dVaCtkODlpY09zS2gyQ09TSFE0MVk1Z2FBNXVxb3FZTVBKUE9u?=
 =?utf-8?B?WDJoWUVRQVNjV0pjTGlyTHBZQ2NZZzdHbkNZZzBBT05zS0VDOE5Cb0ptTHp5?=
 =?utf-8?B?NnJhMmFobGFKaU45by8zRjVCYkRSL1VKSjhlcEtGVm5jZ1dndFY3YTZuLzJF?=
 =?utf-8?B?VVdaTFQxVitPYk1DQUFZUmx0Qm9NUnQvNitNekc5TTE0aSs4cjlFL0ZHcVlq?=
 =?utf-8?B?dnNQTGZRMmNlUEhSZHZjNXdWR01mMSttRktVeUhpS1NuTUpPV2JSb21uTkhE?=
 =?utf-8?B?RkhnMEE5M04yQWltekpkaDN1UmhyM0sxZ2FrdmU5aXJwcEtsR2R1Qmx5bDlC?=
 =?utf-8?B?dytPQ1NCS2pOUmIzZkl4N0dqY0ZoRWtMczUyaUQzTzhuaTdvNFJOUi9ERUpk?=
 =?utf-8?B?VkdLRlhKYnZVYmhSYjI3KzZEZTIxWWNVaWNKVEZrMXIyNkd4aUttckU2NnhB?=
 =?utf-8?B?T0lOU09yOVRvQjZaRVRabzJId2VGOFFJdVNERDgxd1pBWUlhMmFDb1lza3Ar?=
 =?utf-8?B?OFpjeGozTEpVc2ZCeXpzNDZ4cTBqeTJaamZpTWgyYlFuUVJueUFxRnB6bzlI?=
 =?utf-8?B?NzFUcTRvbngzWWVzRCtsS2FwSUNRVUNlUUd4cXVHOXNCRmxiR1RFU0hPbHZ0?=
 =?utf-8?B?QkdMWXdPSjgvY3pYekZlSGhzRzYzN29qNjd3NGtZOWk5MTVsWVFqcjk4NDVs?=
 =?utf-8?B?dkUreG9JL1ZzZS9KTXc1MmZ6dGkxbWMvdnBQeFVTeFJGSjBXZk8rRks2SXU2?=
 =?utf-8?B?TGtpVlRFempwUmZUcTM5T1pSUXB5UnM4Vm0yN21NQ0M2VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0308d761-a99d-4677-9483-08d91a9ff721
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 08:27:39.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMvCJc9xoE2cnsPLRqOyrF/CUKCgUMN8t8u/rEbh2M0F/hdZaz4iqq7eB/n3bT/fn5ZIk+L4gY0GfD8BRxgxbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7082
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjAyMS8wNS8xOSAxNjo0MiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+PiBPbiBNYXkg
MTksIDIwMjEsIGF0IDEyOjE3IEFNLCBKb2hhbm5lcyBUaHVtc2hpcm4gPEpvaGFubmVzLlRodW1z
aGlybkB3ZGMuY29tPiB3cm90ZToKPj4KPj4g77u/T24gMTkvMDUvMjAyMSAwNDo1NiwgRGFtaWVu
IExlIE1vYWwgd3JvdGU6Cj4+PiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgYmlvX3pvbmVf
bm8oc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYmlvICpiaW8pCj4+PiArewo+Pj4gKyAgICByZXR1cm4gYmxrX3F1ZXVlX3pvbmVfbm8o
cSwgYmlvLT5iaV9pdGVyLmJpX3NlY3Rvcik7Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyBpbmxp
bmUgdW5zaWduZWQgaW50IGJpb196b25lX2lzX3NlcShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwK
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBiaW8gKmJpbykKPj4+ICt7Cj4+PiAr
ICAgIHJldHVybiBibGtfcXVldWVfem9uZV9pc19zZXEocSwgYmlvLT5iaV9pdGVyLmJpX3NlY3Rv
cik7Cj4+PiArfQo+Pj4gKwo+Pgo+PiBDYW4ndCB3ZSBkZXJpdmUgdGhlIHF1ZXVlIGZyb20gdGhl
IGJpbyB2aWEgYmlvLT5iaV9iZGV2LT5iZF9kaXNrLT5xdWV1ZQo+PiBvciB3b3VsZCB0aGlzIGJl
IHRvbyBtdWNoIHBvaW50ZXIgY2hhc2luZyBmb3IgYSBzbWFsbCBoZWxwZXIgbGlrZSB0aGlzPwo+
IAo+IFdlIGhhdmUgbWFkZSBzdWNoIGNvZGUgY2hhbmdlcyB0byBnZXQgcmlkIG9mIHNlcGFyYXRl
IGFyZ3VtZW50IHEgYW5kIGRlcml2ZSBpdCBmcm9tIGJpbyBmb3IgYmxvY2sgdHJhY2UgY2xlYW51
cC4gVW5sZXNzIHRoZXJlIGlzIGEgc3Ryb25nIHJlYXNvbiAoc3VjaCBhcyBxIGlzIG5vdCBhdmFp
bGFibGUgaW4gdGhpcyBjYWxsIHdoaWNoIEkgaGF2ZSBub3QgbG9va2VkIGludG8pLCB3ZSBzaG91
bGQgYXZvaWQgcGFzc2luZyBxIGFzIHNlcGFyYXRlIGFyZ3VtZW50LiAKCldpbGwgZml4IHRoYXQg
aW4gdjIuCgotLSAKRGFtaWVuIExlIE1vYWwKV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoCg==
