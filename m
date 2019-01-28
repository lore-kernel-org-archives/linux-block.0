Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6389C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AEB20881
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 18:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iFOE3T9w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nARAeJzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfA1SkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:40:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65015 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1SkN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 13:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548700813; x=1580236813;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=qQ3Iqs3zo4sCKGP2Je85/mKEXQmCPd6nc1q6w6rpNJg=;
  b=iFOE3T9whI7K4EvZLUFVa5o1o/XiTQD2jZWA+LzEKR8nWsoRIOdNAaij
   Nsiq4KakTwa1MiGxdrzHfkvONmcKCJjolEJqqcfzZfJuPWP+x43Orzptl
   +dG9qC7x3lzmntSjgPnP/WJMkxkmBqBK1WwPZtfa2nxUQA9TsVqufYNfm
   GAaEK3PmM5t9CF2Nw+Ii6LOc/u8xvyQj2eIW9J3OadT6NpgxsXasdtMJ1
   eZ5EgwRSmmyFaKdpMFLVJfhpO1ixXUJaVQEtmnzkdIvOgdqseA1F2YaK7
   F0C0A1MatBPGggcYgoNH0IXSq5zAaPXZbGHt6ZfmTyfF8+7rsMiA8VIvQ
   g==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="104920462"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2019 02:40:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ3Iqs3zo4sCKGP2Je85/mKEXQmCPd6nc1q6w6rpNJg=;
 b=nARAeJzIs7p0Lu8UIOFQlz8ur+Qn83GaYYSsbobiduIvZMn8KuVhK9HmtNalslQXDvXZQdYH5gz9+FHWebylNbhYnhiAQBUHPoXXBB0OaoCAyYx/hkGfRqryijSJ4tB6asONqlgGGW7KqDMChO/bX5GpqkHr0nFQXW3aRMhufZM=
Received: from CO2PR04MB2168.namprd04.prod.outlook.com (10.166.93.150) by
 CO2PR04MB2248.namprd04.prod.outlook.com (10.166.94.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 18:40:10 +0000
Received: from CO2PR04MB2168.namprd04.prod.outlook.com
 ([fe80::21ea:a5ae:4c3a:6ee7]) by CO2PR04MB2168.namprd04.prod.outlook.com
 ([fe80::21ea:a5ae:4c3a:6ee7%10]) with mapi id 15.20.1558.021; Mon, 28 Jan
 2019 18:40:10 +0000
From:   Matias Bjorling <Matias.Bjorling@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [LSF/MM TOPIC] Zoned Block Devices
Thread-Topic: [LSF/MM TOPIC] Zoned Block Devices
Thread-Index: AQHUtwjgWFMy4WfT6kmXggT+3sfHB6XEyGMAgAA7SgA=
Date:   Mon, 28 Jan 2019 18:40:10 +0000
Message-ID: <cc9308c4-d480-1135-7656-b7c7d6c921a5@wdc.com>
References: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
 <4adb1038-246a-530a-5265-1d16d0cd5014@acm.org>
In-Reply-To: <4adb1038-246a-530a-5265-1d16d0cd5014@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:206:1::14) To CO2PR04MB2168.namprd04.prod.outlook.com
 (2603:10b6:102:c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matias.Bjorling@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR04MB2248;6:8viAy0WJHjalzKR2Z02b/rF0CI/Ff3JXktg9UqCpEIdRavKytWRWhsrFbPowiIV5PEfrwPAPvHtjMBCgEZW1RRUE5d7N+RexYvV7QrZVtaDLu45P6tLX0uSeG6QcMJak9LVpWnclq1mxU6Sd7Zt57bC2BL6SjRd2kC/N3LjYT7TkdTVyhxy/feQW2aYSchebJaFYZB6q5Aogu0ZALIkAmlC6a0Lj9sfwV0LGtBE8uEW4FzI7Sm52n1YosOSzNs9ERhI2xl+kSRN/s2mcOhvledVZChG45dpkhJ3alwOmPCtnbaNpq2KH31mLh9qusKGYJ9Simc/bLj5+LG9w3KQZKbMqCGE2MIdFLW3n+aPo/U5fZlkQzWibT1dOPi7wfwWdLmwPNQhhegLKMZ3n0YUBABWPmrPEpzv0MspdN4kPfevWRQKhNRSy0e04kfUcGaySUSWxT1y18RUXtyg8WwqbxQ==;5:7ECYnvnw+aOsbnmZuUrexNi/+BuhWnZyfw4TLdWH9aXjv1ZyBr8QwUaJzr8Qvie4hV1JkN77TuGqHJfrrQxFREbDF/B8qiBeNJXyBHT6fFM3UzmGma7vdFXDaV4+tQ7lPiGpbanbEuAEvB4/mHFro7timOcsUGWbSUCoY8eHHqMs9dbU+ZWAMgLBkbXIZk//tgQLHQMimSClPQn8X5S7eA==;7:a6P2od3p0ToMMOE7fW3uc4SU75o5hY7SsGM/ugLBP2MX5rH3WYFG/2fVJWZ0JSPyPadZzpgwtGOiw8cUB9tlTqR8S48xYTP/d/AsFD3cq/s7eF9y/aFrI95U3Y8Q7mbNTazormsUMn0d70wYzqqB9Q==
x-ms-office365-filtering-correlation-id: 3d93aab7-dbe4-415f-070a-08d685500867
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:CO2PR04MB2248;
x-ms-traffictypediagnostic: CO2PR04MB2248:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CO2PR04MB2248EA891A76E76BCDA6560DF1960@CO2PR04MB2248.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(136003)(189003)(199004)(105586002)(229853002)(31686004)(26005)(2201001)(478600001)(71200400001)(97736004)(186003)(14454004)(386003)(486006)(106356001)(6116002)(3846002)(72206003)(6506007)(476003)(11346002)(2501003)(53546011)(86362001)(71190400001)(446003)(2616005)(102836004)(31696002)(99286004)(561944003)(2906002)(8936002)(81166006)(7736002)(81156014)(6512007)(316002)(44832011)(68736007)(52116002)(25786009)(6246003)(6436002)(14444005)(256004)(36756003)(110136005)(305945005)(6486002)(66066001)(53936002)(76176011)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2248;H:CO2PR04MB2168.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KiZ6nyJ5FTYPYGyR4Z741qez6ar3mMXXDloUCtFDIIO+aZbCThFcW3ArKkzjx9LeVKG1sZfbm0LIe7BJaeqiruLbQVgggnMFEh8YioH+Pp5pJyQCxtNHVrhfU7FQaVARL0lMc44HiTjYmTwjrMoj7/le4Py8ooBihyfV3T+hBePTtLe4tgMdcrYsFA++d/4ynt/WpKKuNmm4982TbqFjdp2NyYabCi4k4av4U6qFdaAgytf0U3AR+9OX5SakexQDXYGYJtNS4Z6ou1l626C1PTDUNR2dImS9uhb/VXcUIp/uO9zUKo8AkbEA78jhBXNenx610wwJCauBRzCsPGlIszusqtp+SQ5sCp3sk4DtVrqtG1w6xA8cl6NPlgNswMNcmYtkLQo0+RMyAzQt22jFuisphnW/kmoNXmDNLaQEbeA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22DCD12408624B4E885C729F75EE719B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d93aab7-dbe4-415f-070a-08d685500867
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 18:40:06.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2248
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yOC8xOSA0OjA3IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IE9uIDEvMjgvMTkg
NDo1NiBBTSwgTWF0aWFzIEJqb3JsaW5nIHdyb3RlOg0KPj4gRGFtaWVuIGFuZCBJIHdvdWxkIGxp
a2UgdG8gcHJvcG9zZSBhIGNvdXBsZSBvZiB0b3BpY3MgY2VudGVyaW5nIGFyb3VuZA0KPj4gem9u
ZWQgYmxvY2sgZGV2aWNlczoNCj4+DQo+PiAxKSBab25lZCBibG9jayBkZXZpY2VzIHJlcXVpcmUg
dGhhdCB3cml0ZXMgdG8gYSB6b25lIGFyZSBzZXF1ZW50aWFsLiBJZg0KPj4gdGhlIHdyaXRlcyBh
cmUgZGlzcGF0Y2hlZCB0byB0aGUgZGV2aWNlIG91dCBvZiBvcmRlciwgdGhlIGRyaXZlIHJlamVj
dHMNCj4+IHRoZSB3cml0ZSB3aXRoIGEgd3JpdGUgZmFpbHVyZS4NCj4+DQo+PiBTbyBmYXIgaXQg
aGFzIGJlZW4gdGhlIHJlc3BvbnNpYmlsaXR5IHRoZSBkZWFkbGluZSBJL08gc2NoZWR1bGVyIHRv
DQo+PiBzZXJpYWxpemUgd3JpdGVzIHRvIHpvbmVzIHRvIGF2b2lkIGludHJhLXpvbmUgd3JpdGUg
Y29tbWFuZCByZW9yZGVyaW5nLg0KPj4gVGhpcyBJL08gc2NoZWR1bGVyIGJhc2VkIGFwcHJvYWNo
IGhhcyB3b3JrZWQgc28gZmFyIGZvciBIRERzLCBidXQgd2UgY2FuDQo+PiBkbyBiZXR0ZXIgZm9y
IG11bHRpLXF1ZXVlIGRldmljZXMuIE5WTWUgaGFzIHN1cHBvcnQgZm9yIG11bHRpcGxlIHF1ZXVl
cywNCj4+IGFuZCBvbmUgY291bGQgZGVkaWNhdGUgYSBzaW5nbGUgcXVldWUgdG8gd3JpdGVzIGFs
b25lLiBGdXJ0aGVybW9yZSwgdGhlDQo+PiBxdWV1ZSBpcyBwcm9jZXNzZWQgaW4tb3JkZXIsIGVu
YWJsaW5nIHRoZSBob3N0IHRvIHNlcmlhbGl6ZSB3cml0ZXMgb24NCj4+IHRoZSBxdWV1ZSwgaW5z
dGVhZCBvZiBpc3N1aW5nIHRoZW0gb25lIGJ5IG9uZS4gV2UgbGlrZSB0byBnYXRoZXINCj4+IGZl
ZWRiYWNrIG9uIHRoaXMgYXBwcm9hY2ggKG5ldyBIQ1RYX1RZUEVfV1JJVEUpLg0KPj4NCj4+IDIp
IEFkb3B0aW9uIG9mIFpvbmUgQXBwZW5kIGluIGZpbGUtc3lzdGVtcyBhbmQgdXNlci1zcGFjZSBh
cHBsaWNhdGlvbnMuDQo+Pg0KPj4gQSBab25lIEFwcGVuZCBjb21tYW5kLCB0b2dldGhlciB3aXRo
IFpvbmVkIE5hbWVzcGFjZXMsIGlzIGJlaW5nIGRlZmluZWQNCj4+IGluIHRoZSBOVk1lIHdvcmtn
cm91cC4gVGhlIG5ldyBjb21tYW5kIGFsbG93cyBvbmUgdG8gYXV0b21hdGljYWxseQ0KPj4gZGly
ZWN0IHdyaXRlcyB0byBhIHpvbmUgd3JpdGUgcG9pbnRlciBwb3NpdGlvbiwgc2ltaWxhcmx5IHRv
IHdyaXRpbmcgdG8NCj4+IGEgZmlsZSBvcGVuIHdpdGggT19BUFBFTkQuIFdpdGggdGhpcyB3cml0
ZSBhcHBlbmQgY29tbWFuZCwgdGhlIGRyaXZlDQo+PiByZXR1cm5zIHdoZXJlIGRhdGEgd2FzIHdy
aXR0ZW4gaW4gdGhlIHpvbmUuIFByb3ZpZGluZyB0d28gYmVuZWZpdHM6DQo+Pg0KPj4gKEEpIEl0
IG1vdmVzIHRoZSBmaW5lLWdyYWluZWQgbG9naWNhbCBibG9jayBhbGxvY2F0aW9uIGluIGZpbGUt
c3lzdGVtcw0KPj4gdG8gdGhlIGRldmljZSBzaWRlLiBBIGZpbGUtc3lzdGVtIGNvbnRpbnVlcyB0
byBkbyBjb2Fyc2UtZ3JhaW5lZCBsb2dpY2FsDQo+PiBibG9jayBhbGxvY2F0aW9uLCBidXQgdGhl
IHNwZWNpZmljIExCQXMgd2hlcmUgZGF0YSBpcyB3cml0dGVuIGFuZA0KPj4gcmVwb3J0ZWQgZnJv
bSB0aGUgZGV2aWNlLiBUaHVzIGltcHJvdmluZyBmaWxlLXN5c3RlbSBwZXJmb3JtYW5jZS4gVGhl
DQo+PiBjdXJyZW50IHRhcmdldCBpcyBYRlMgYnV0IHdlIHdvdWxkIGxpa2UgdG8gaGVhciB0aGUg
ZmVhc2liaWxpdHkgb2YgaXQNCj4+IGJlaW5nIHVzZWQgaW4gb3RoZXIgZmlsZS1zeXN0ZW1zLg0K
Pj4NCj4+IChCKSBJdCBsZXRzIGhvc3QgaXNzdWUgbXVsdGlwbGUgb3V0c3RhbmRpbmcgd3JpdGUg
SS9PcyB0byBhIHpvbmUsDQo+PiB3aXRob3V0IGhhdmluZyB0byBtYWludGFpbiBJL08gb3JkZXIu
IFRodXMsIGltcHJvdmluZyB0aGUgcGVyZm9ybWFuY2Ugb2YNCj4+IHRoZSBkcml2ZSwgYnV0IGFs
c28gcmVkdWNpbmcgdGhlIG5lZWQgZm9yIHpvbmUgbG9ja2luZyBvbiB0aGUgaG9zdCBzaWRlLg0K
Pj4NCj4+IElzIHRoZXJlIG90aGVyIHVzZS1jYXNlcyBmb3IgdGhpcywgYW5kIHdpbGwgYW4gaW50
ZXJmYWNlIGxpa2UgdGhpcyBiZQ0KPj4gdmFsdWFibGUgaW4gdGhlIGtlcm5lbD8gSWYgdGhlIGlu
dGVyZmFjZSBpcyBzdWNjZXNzZnVsLCB3ZSB3b3VsZCBleHBlY3QNCj4+IHRoZSBpbnRlcmZhY2Ug
dG8gbW92ZSB0byBBVEEvU0NTSSBmb3Igc3RhbmRhcmRpemF0aW9uIGFzIHdlbGwuDQo+DQo+IEhp
IE1hdGlhcywNCj4NCj4gVGhpcyB0b3BpYyBwcm9wb3NhbCBzb3VuZHMgaW50ZXJlc3RpbmcgdG8g
bWUsIGJ1dCBJIHRoaW5rIGl0IGlzIA0KPiBpbmNvbXBsZXRlLiBTaG91bGRuJ3QgaXQgYWxzbyBi
ZSBkaXNjdXNzZWQgaG93IHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIA0KPiBhcmUgZXhwZWN0ZWQg
dG8gc3VibWl0ICJ6b25lIGFwcGVuZCIgd3JpdGVzPyBXaGljaCBzeXN0ZW0gY2FsbCBzaG91bGQg
DQo+IGUuZy4gZmlvIHVzZSB0byBzdWJtaXQgdGhpcyBuZXcgdHlwZSBvZiB3cml0ZSByZXF1ZXN0
PyBIb3cgd2lsbCB0aGUgDQo+IG9mZnNldCBhdCB3aGljaCBkYXRhIGhhcyBiZWVuIHdyaXR0ZW4g
YmUgY29tbXVuaWNhdGVkIGJhY2sgdG8gdXNlciBzcGFjZT8NCj4NCj4gVGhhbmtzLA0KPg0KPiBC
YXJ0Lg0KDQpIaSBCYXJ0LA0KDQpUaGF0J3MgYSBnb29kIHBvaW50LiBPcmlnaW5hbGx5LCB3ZSBv
bmx5IGxvb2tlZCBpbnRvIHN1cHBvcnQgZm9yIA0KZmlsZS1zeXN0ZW1zIGR1ZSB0byB0aGUgY29t
cGxleGl0eSBvZiBleHBvc2luZyBpdCB0byB1c2VyLXNwYWNlIChlLmcuLCANCndlIGRvIG5vdCBo
YXZlIGFuIGVhc3kgd2F5IHRvIHN1cHBvcnQgcHN5bmMvbGliYWlvIHdvcmtsb2FkcykuIEkgd291
bGQgDQpsb3ZlIGZvciB1cyB0byBiZSBhYmxlIHRvIGNvbWJpbmUgdGhpcyB3aXRoIGxpYnVyaW5n
LCBzdWNoIHRoYXQgYW4gTEJBIA0KY2FuIGJlIHJldHVybmVkIG9uIEkvTyBjb21wbGV0aW9uLiBI
b3dldmVyLCBJJ20gbm90IHN1cmUgd2UgaGF2ZSBlbm91Z2ggDQpiaXRzIGF2YWlsYWJsZSBvbiB0
aGUgY29tcGxldGlvbiBlbnRyeS4NCg0KLU1hdGlhcw0KDQo=
