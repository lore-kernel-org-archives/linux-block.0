Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88686C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 03:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C8A61381
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 03:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJEDkL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 23:40:11 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:11937
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229659AbhJEDkK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Oct 2021 23:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvmTs14nl7d1IKJMfk8TmYxJHd/L7rWQVnPBdNMYqVZ95fgPH+4/6mR7lRHR2FSRHqmMdyWHuPPyh84UnOl5yIi0w7SQDiZp6EEGCsbJArzticfbbDdMWoz2kRtXsF/EYw5zch7yGGlDH92ffJVZS2AvaIbXHGZbMpilHRfJL7Gs9yNg6Io4QswuQU4xHv89ly+DlMvjym7KLvyry1r8iPRPcpaY1eHevpfnyiiooZ0Nt34sAfuCV0VN4y80cgJAsh9JBgqL/QkKgeir/WtIIWs6wnUn5s9xOgmfy0V7EepnuWvXvZIGc+4BEL0scEDFj2VgGOnlHWqWAXx58JH2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/LWTdjbtuGHcGEwjeKSMtfXP+fJdyL1QAwPLQoN/08=;
 b=kmizn1ymXQV+IMnIA7Bo5qQH5/YQ+eOcQ+3Dt1med5UnmQhBEqSUJ368YjQ52FEqLcaI7ergNayJqhL12RcfZkDhne5eUDxyQWbyVDdUL+SISf5dYSFlfjoF6I9BqPaLq+4EoYi/qf33vJ2no9ILaAkB+OlMNrVPVQD8co/9iAYLQzNYo13pN3BrThp21wwahbtmf6QjwlOJwybNQl8pj7evLnAxmwwdxTOlUPkOAdA9PaZXRtyzsRd68x9Fe4zvKvH+gqWikF2A01Su8wMuzYh7W5BER7kIl5cYTAC0nD1VugB88HoDNxkBk51nogFx4x0OrskWYbzzFx2diWFeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/LWTdjbtuGHcGEwjeKSMtfXP+fJdyL1QAwPLQoN/08=;
 b=Frd0s2EpYtY4WoXc/KYcbDBRy0TjWreyA1KlowMZGmnIwo68SVg6aIaE7bWFkzFL6pbqAjW8ns5b9MW15KdigOdOZOkrV6rEmkk0a1pEfZkKbEgODWxC0vn/BLAdxRKXo1W1VcFCuyoe9E+HRgrIGf6kQMK8mJiaL5XKeeuTeIh4164mOXF4qtbEDIeszCLVhEfVPvwoAshoOqZYzngl48qdsYzIm4ATQ1YmSwUksH9rQ7UyelxyrNut/XeAYZ3xJ8uMN72Ji8GJ/YZxKOLq8xbLhPYyAitT9TjGVh/QkWrSyz0KMqEw4lbQAy26FaBJOdgw4n30OwN+N8RzLI9IxQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 5 Oct
 2021 03:38:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 03:38:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Topic: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Index: AQHXtfqjo6XrkhaLxkCH4OgsGNpS36u9phOAgAYN3QCAABT4gA==
Date:   Tue, 5 Oct 2021 03:38:18 +0000
Message-ID: <79efb733-4904-d27f-b336-d5d97d3ca261@nvidia.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
 <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com> <YVu3EjPqT8VME/oY@T590>
In-Reply-To: <YVu3EjPqT8VME/oY@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f092334-a013-4fbf-209a-08d987b1922a
x-ms-traffictypediagnostic: MWHPR12MB1726:
x-microsoft-antispam-prvs: <MWHPR12MB1726063C9F666DDBFE07C41BA3AF9@MWHPR12MB1726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECprFV25M5l5ZznUtyAFiZWmdnKL3oZkCjvNVsAK/uyYpsXzDSBum92MRBEk7qZHzTSS+Kj2dd9hYEDmkwglA7C4gPL/gRpVG58BZIzAOv5A76tBVloFlquIeXv3rNlBtHCBs0qIdKRuyqAjxYpMro+uTwJcIPyZchcA6HEn3mr3kVhOqFLPkceviWv4I1Z3fJTu2h1wk8x0pk5anpTMxx+vJIJWU/OeCdtu44uHsFvNrN6M7ogfglCy56AdX7f5qcbCPRp6HpvPb7FTQslJJYHiWxLMRD86s4Smgv1WSn05ZY3tJj46eE8R+ywy8H86fb/jGWJcJtW3WE3sKC+6JUlEzp3OhWQM9SwqmpdBlyDu3dKoZD0X17MqgS/eRj/UVoatzEqRPkqrKJrdNkrYGjeDgyPwpExYxG+N8zu4hDEiWAvX1hralAd1hsUiaJPfaGrlWRv2ZEugFRRW8TXJS8Yvfnh7aozlxkZiPxD1qbw51t4sPLYWKRb14sZr/mVqBXTbcL+iKXd8edMUCQEZPs07jNKpLR8ISmu7dhYj86a3pPa3gSOw4iSSXmKc9r17CUs/AtYPk3ULfhadtLA0JZ2iwG2iJ20wHn7dGdYel3Ox4XDVi7GcoDuAkGkOOzyrCiPHFq0Gp7OhBP3a880hrqcvRxVKU84KEcn8sZ4l9ig/oZ3XhntaNJfPZ8Uw+eQRs+pDwVG1ssHraG7rr0gWEfTfJDOkP4bYPUdeZ/+rxiVV1lBcggwlH9cA/90qcKT5p8P9KtDWJqMQwi1TK2/wWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6916009)(66946007)(91956017)(66446008)(186003)(8936002)(76116006)(4326008)(508600001)(66476007)(66556008)(2906002)(36756003)(6512007)(2616005)(64756008)(31696002)(8676002)(38100700002)(31686004)(71200400001)(86362001)(54906003)(5660300002)(53546011)(316002)(38070700005)(122000001)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHlPdW9oV3ZIeGdYNVZ1N1p2bjRTVitSWTh2MFN2aW1lbG8xQUFiK1B5Mm5j?=
 =?utf-8?B?azNEVzJuSEx4L1M0Z1IveVFBZlJxTjArcWpneG01TGh2MU5jeERUZWVrcVNq?=
 =?utf-8?B?UndsTzFRMTVrdjQyV0tjMUM2ZEwrK0VHTE9UcWVJOWpaNUNSYUUrMzk2ZkxI?=
 =?utf-8?B?TEdjU3FIUnFJekppTEM0Y2NiVE9GVGFxM1V6bWFENm5NMWkyUUpaN0xicjIz?=
 =?utf-8?B?VVNJQkwwa21IcjUrVGJaWkxnSndqSUpWSTMrSUhENE9qSHZNYjQ0bE5rK0M2?=
 =?utf-8?B?SVpsWW9zbksvVjJRaVhHQmY5QnZhdnNPb3hldmRDR1U1ZVdZckRKM01ONHVh?=
 =?utf-8?B?aTdZWkRFUVV0dFZTWlVvUmNlaHRzcFBJNWlxYzdveDNtWldnOU9Hd3BLQkhO?=
 =?utf-8?B?b0RVd1FUMXozVHZaZzR3Qk15b0R3MU9NTjBWUkkvSlMrUS93eVNvL0h4c3RM?=
 =?utf-8?B?VFN4ZVM4MmpTUFhodXp1S09BZlc0LzZEYnUvU3FVR3A4aHhndndTYWtjUnU0?=
 =?utf-8?B?RzUxRCtsL2JtNENjRFpuWExwWWg0T1VUYjVxRUUxemJMZWJKazg0dWY1Yll4?=
 =?utf-8?B?aDcvU3lXTWVKREh0bXFSL3c5aDZ6SlBGa3M0SmR2YmUwSkdsSkExSE9FYTBo?=
 =?utf-8?B?ZkhvZit5em9wRzJhWEZDTUZFTTh4Nk55UFUxa1JQVlE0OEcyR1hOcysxS0VT?=
 =?utf-8?B?Tm5tTkNzckgvMmhqVXgvZFpNSitzc2pNOVErVWRsNnlDb1pLZUdmc3ZYRUQ1?=
 =?utf-8?B?UVA0alhDeDZRM3RtOU16MFQzcXFBWWNWdi9wc2RjRFVSMmhiSWpQN2ZMcTRj?=
 =?utf-8?B?djNKalQzeGs0cXpiTS9oWU5sK2FvN0dZdGx2K3ZqLzZwZGxTa2UwdXo1ZWVy?=
 =?utf-8?B?QUxDOTFLQnptY1hFMVp5ZmkrNlBldGVBWTFDaUNZMzBoNElRUHZtTnd6RjMx?=
 =?utf-8?B?V3VmTnRYMnVnMzRSOXZxSHVKWVBPMUJUWm5HOVNPWk4vWWx3VXZvL0V1NHZq?=
 =?utf-8?B?akJZL3grSCtVZGNUdTZsU1JNV0lOY1N3ZlBPRUVKN0FjcFhtbVN6MkllN2Jm?=
 =?utf-8?B?TGxmS296M2c5SFhaNWdWaitxWDV3TW1OaW9jcGNuLzBDNDhvbGJ6dEdZNHkz?=
 =?utf-8?B?T1pRczF1ckljdFZ3VDZXQmlEUlNsQkJxWkpnZmtLM2VVWW1xd1l3UjNzcFNE?=
 =?utf-8?B?NlliZEIzeERaTnpXM1Rwakh5VTNnT1lNYmVlSmtUbDlSMU4vK3o0SHl2L1Fj?=
 =?utf-8?B?dkt6dXJheWt4RitKVHRuei9EcUlOR1k3a3BYK2R6UnE3LzcwUzNQcHJvWGNU?=
 =?utf-8?B?eXpUSGRNSEFzdDNWN0hVQjROT0EyQWhINThOSllqYlNaSlVrUjg3QUl0NjBS?=
 =?utf-8?B?MEo5SVhmV2VoclBpUlhQSlBuUVRuRlBsc2tGVmliZ2s1VXpOclI0aXcvQWNl?=
 =?utf-8?B?eEVqNDUvTzVMRmxpU2syK2IrbTNmc2wzV1BYZ2ZLckRmOEFvYlVXbG9kRGtp?=
 =?utf-8?B?SVFyNjlUNG9mUytERzlnVE5WR3FBR25xSVdWRVdXSU1vR2NZajBPc1UrdUF5?=
 =?utf-8?B?Y2s1V1NqT0RtazhZTFhMWXlpVzFzYXZEdkxWcnpMZzA2Z216RmRkWThkb3hK?=
 =?utf-8?B?OS85M3NKU0h2blJzRFQ4Wi9ER1JDV055S3hYaTQzeUVKVHlCZkdCb2FhUnZy?=
 =?utf-8?B?NmZ0enZQMkFNUnlFbDgyTW5HQVlNay9RQjkwZ25LWWljZ3lVR21NRWFWdHVi?=
 =?utf-8?B?ZTBqQy9FRFJSNTkxc25KdXRZaTZpc1dWY1p6cGdxeHV6UWtocitnenZxUWNl?=
 =?utf-8?B?UzV6SkVZT0dLc3JhTmxWUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <407AA98FAEE64548A03BB218B09C599D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f092334-a013-4fbf-209a-08d987b1922a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 03:38:18.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGdMpGkK71vdvo/A7KLSlV5hw9MpAdW3b2hJUE0499GIYRNqpYTX2QCzTfGR5+8Bp8MR1S5I9X6hT+afQwbEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvNC8yMSAxOToyMywgTWluZyBMZWkgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBVc2Ug
Y2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGVsbG8gQ2hh
aXRhbnlhLA0KPiANCj4gT24gRnJpLCBPY3QgMDEsIDIwMjEgYXQgMDU6NTY6MDRBTSArMDAwMCwg
Q2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gT24gOS8zMC8yMDIxIDU6NTYgQU0sIE1pbmcg
TGVpIHdyb3RlOg0KPj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQo+Pj4NCj4+Pg0KPj4+IEFkZCB0d28gQVBJcyBmb3Igc3RvcHBpbmcg
YW5kIHN0YXJ0aW5nIGFkbWluIHF1ZXVlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWluZyBM
ZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQo+Pg0KPj4NCj4+IHRoaXMgcGF0Y2ggbG9va3MgZ29v
ZCB0byBtZSwgYnV0IGZyb20gdGhlIGZlZWRiYWNrIEkndmUgcmVjZWl2ZWQgaW4gcGFzdA0KPj4g
d2UgbmVlZCB0byBhZGQgdGhlIG5ldyBmdW5jdGlvbnMgaW4gdGhlIHBhdGNoIHdoZXJlIHRoZXkg
YXJlIGFjdHVhbGx5DQo+PiB1c2VkIHRoYW4gYWRkaW5nIGl0IGluIGEgc2VwYXJhdGUgcGF0Y2gu
DQo+IA0KPiBUaGUgYWRkZWQgdHdvIEFQSXMgYXJlIGV4cG9ydGVkIHZpYSBFWFBPUlRfU1lNQk9M
X0dQTCgpLCBzbyBpdCB3b24ndA0KPiBjYXVzZSBhbnkgYnVpbGQgd2FybmluZy4gSSBzZWUgbG90
cyBvZiBzdWNoIHByYWN0aXNlIHRvby4NCj4gDQoNCnRoZSBjb21tZW50IHdhcyBub3QgcmVsYXRl
ZCB0byBhbnkgYnVpbGQgb3Igd2FybmluZy4NCg0KPiBJdCBpcyBlYXNpZXIgZm9yIHJldmlld2lu
ZyBpbiB0aGlzIHdheSBzaW5jZSB0aGUgMXN0IHBhdGNoIGZvY3VzZXMgb24NCj4gQVBJIGltcGxl
bWVudGF0aW9uLCBhbmQgdGhlIDJuZCBwYXRjaCBmb2N1c2VzIG9uIHVzaW5nIHRoZSBBUEksDQo+
IGVzcGVjaWFsbHkgdGhlcmUgYXJlIGxvdHMgb2YgdXNlcnMgaW4gcGF0Y2ggMi4NCj4gDQoNCkkg
YW0gYXdhcmUgb2YgdGhhdCwganVzdCBzaGFyaW5nIHdoYXQgSSBnb3QgdGhlIGNvbW1lbnRzIGlu
IHRoZSBwYXN0Lg0KDQo+IEJ1dCBpZiB5b3UgcmVhbGx5IGRvbid0IGxpa2UgdGhpcyB3YXksIEkg
YW0gZmluZSB0byBtZXJnZSB0aGUgdHdvIHNpbmNlDQo+IG1lcmdpbmcgaXMgYWx3YXlzIGVhc2ll
ciB0aGFuIHNwbGl0dGluZywgOi0pDQo+IA0KDQppdCB3aWxsIGJlIGdvb2QgaWYgd2UgY2FuIGtl
ZXAgdGhlIGNvbnNpc3RlbmN5IC4uLiBub3RoaW5nIGVsc2UgLi4NCg0KPiANCj4gVGhhbmtzLA0K
PiBNaW5nDQo+IA0K
