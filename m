Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A71FEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 22:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjF1WG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:06:27 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:48737
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230243AbjF1WGZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 18:06:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzwEUpBvnNFIIQJ03VNWJPCf4PF4fc7btPSz2kXEZUzqsv5phEIY9ma0gJnjTBIROepvmHPVvyKMHggOvuQ2ckyeJ5X+FmDVU/ic7toYX5UvEwPpkjLel7Rhq+RVy5+wrWtNDkMNI8zrFYuFjlY7zZqm62iDAiC/ANLkX2SpA6Sdl3dzU20MZhir4ewIUoHHQBi6Ip6Za1GldVnJynsrKH9YP3xXD7Iq1fCtLYTKySdGi9n80gBGWNFwcLUAoQmaIghpdvKJLqSxtEn8DPSr+OBkwXESKVvy/Xqs+BPBFr6BGcqTW08jd9d90BeTHWO7e1i6dJypkDEQucPIyBq2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV6MQLJigDZqVepwWvgqmf+rUTnHC/WJztkoVxm2oqE=;
 b=JXGS+1jiK16GcpICWhS8HlqFuXYx4VDEGlrOX/uJNd4/hj31CzRqWkvHx7v0X1Y44Bnsn0rRTMFrCYdsRSb/S8QfKzi572ebV2a9LjGCrWxJVxOP9+WL76Ea3B3o0YuHQqPbeRJeYqQsszbx8HR+g/cSaKiqMDueq2l01YXSrJAhtAAxeArdzp1OcUm5MxT12JLdzQECz9RraUaD3zDU0KbplTdIbtyqpk9ec/TvKbfxZr57KlvR4sQnU8aItPN6ZjF0G1nNHdVlcE8sZmKk1sQKr6sST6c/kPGnCfWGaet5jsBwz6WpgNcX2QUCUiO6fp1IQVlG+UF4eO02H2bH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV6MQLJigDZqVepwWvgqmf+rUTnHC/WJztkoVxm2oqE=;
 b=l5VcRVnkAg5+Y3IeqS/rBql60oNa9rbvqGFChfzop19Yt/4PnaW+yshlVYOp/33A+2Y0k0q+syDdvzzUi9Tl3jTN/HAta1orI6LK+wLzuYYjdGX4j39zBxytVYxZRCWp9j1e8xfAlU9FT/xVJvu27DFTaz2mnoFQWvxN3e5BVrFvYHIL8QJ0yKQUf7g8gXyqE9qj5KFDpx9fLxRqQw3k1/mwuB6b0VmdRIOM8SciEPLQHwIdmiOCceLdq1Uy7uvO7CRa5rMqkV5VftJRfBa/es7oWYZc8sS1y6/K+/d3hAyJFEApQolfriaBx/aLy66Nrrokke4FaE8L/il1cKI8pQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Wed, 28 Jun
 2023 22:06:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 22:06:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
CC:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Topic: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Index: AQHZqRUohUAWGndmz0KG/cht2rpsB6+fKGkAgAAVbYCAADnfgIAADvWAgAAUnICAACDLgIAACmeAgAAIDoCAAAKQgIAADJyAgADpsIA=
Date:   Wed, 28 Jun 2023 22:06:23 +0000
Message-ID: <0ab5d195-549f-342f-8c92-b7f1a4ca2d26@nvidia.com>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
In-Reply-To: <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB7306:EE_
x-ms-office365-filtering-correlation-id: 0260d336-c76a-453e-51fe-08db7823e8fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MI6VaNS8DDKu7tNy5ReX0qjRRpG+35EJBCMi38XqLlEYSBLRw/RaN/BysJzHPXlqqcuAHE7UvVpF4D1Jo8rV1K4I6UuROsPQ/yLXyjFu4F/y4Ouk/gCXcrIYhvTDVQXsxy+3JyspFFDBLtFnAyKkqD/hsyQmHLvfBFDhLRSg9VsS7MIcDPYQt48U2orVfD4xSlAkV7ABo+mLE2GZ9u6Khlp8SQd6dZlWZj7SSjDWYXqCsfrnHfbyMj67NYIktj1s8Kp2gu160WSPTdYajY78aPnP4q3ULBr6ZLA6So0yUwCVL2tguzDl01LC3jJmAEaxXWjNrTN45Sl1vzmtQwFHE0ibKRsaGlgxgIrW02223kr43huFQFpvBV1A/fMhLfCYny9Vs/HNlTv9NiuBcWTYrgj5qiL9VCiKgG1OBp8kbNXZy1wfaR+ALFDvIPnKkxqq5E0/mScp0UHH7H6TLNDIwUg8y+woVAwgFzeQZ1nXZwmB+ESHtttb5XjjSc8XrfEjsTCKEk5EXPiz/1PhHW67h+H4mG5amzJBPazYjcDIshf2oZKs/LVOmrqrOcDyfbCrMzm5hsRQuKWaGC7fIjLO5uHcuxxA9eAMxEtseqFH+kO6QL6wFCciQbNt30i2BkgTNh/vIAI75oKZTqwAumxF/paC/0C2bOxepAFor5xAamIPinAjwi9al4inyApm93dd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(6486002)(38100700002)(53546011)(71200400001)(2616005)(122000001)(83380400001)(6506007)(186003)(6512007)(54906003)(41300700001)(110136005)(38070700005)(31696002)(86362001)(478600001)(316002)(2906002)(36756003)(66556008)(66476007)(64756008)(91956017)(66946007)(66446008)(76116006)(31686004)(4326008)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGcrNjVaQXdTbitMbFpnRnp0NWgzUEUzSFg2eTV3MXB6RERDakFZalpOQUth?=
 =?utf-8?B?b2VwVFVvTGVqNVZuT0VkYmZtRHN0bnl2ZStpNHdNT0xzdVRzdXFvRlE1YVBn?=
 =?utf-8?B?ais5RXQvK0MvRGppcUNtT041WVNqcmNmTXRYODhpQVE1UG9FQWpCVFVVQ1Vs?=
 =?utf-8?B?ckwzYmpIOVkrS29PMEdGalk1c2dtdEVRZ1ZOampnQThHQ2VOWEcxR2NvN2pm?=
 =?utf-8?B?MXp6Sm90U0ZpdDYwTTJ5d2lvV2dGa3F6VHNua1Q2WGsxeFArdWwxRGF4ZGtV?=
 =?utf-8?B?UEJ3UGt2NllVOGhuUmg1R0pNcG5vL3MxQTMydGRPbG9ERFJiZmJjeXpvdmJO?=
 =?utf-8?B?Yk1QMVBGUTdIenJuMWRzQTc5QlliYlE4aDRERVJ3UzFySUlJek8xb1J2THVR?=
 =?utf-8?B?RXQrQVpsVWxrQXNzSFJMVEw0cUN3Q3lmcEV2RElWaTJtUjllNkIzUS9zR0Zw?=
 =?utf-8?B?V1lvbHpDODZldy9sK3NSREhzTWpqQTFYSFRITlZ2VFVET0FGcTJPbnFHQVRu?=
 =?utf-8?B?TjNCdXJFeDdWa1V3TGlISTBjVGo2d2h2Q2JlcThPSTJOek11d2FnQVEzMHd0?=
 =?utf-8?B?M0YxNXkwNVVkYzRQNitYVVNZVG8zWjl6VWVxTTBVT2l0WnZNYldUMGNSekUw?=
 =?utf-8?B?Z0VJOWw1bFdzejRsYjZRSHQ2ZlFQOTd2MDBUTitrTXMrbzlncVBoSm9RUmoy?=
 =?utf-8?B?dnpZZXc0eHdBWGxLNEtDL3k0cEQzdjdKRFRlcXN0eHAwWXRTdWJQQTRsdHBq?=
 =?utf-8?B?UHNaaldINGNVVDFqMUJrczNnOHc0MzZwR25SdFBkVlptSHY1bWRxRzVIREEy?=
 =?utf-8?B?TjQzQ2xsTmJhWWYrZkdYUnVNaTBYZ0RNMkR5ZGcxbzFXbEFmdDJ0RXNMbWNu?=
 =?utf-8?B?SUMydzRObEQyUVVGQnVDcmoyVXBtcGJneU9uSWMxenBFSENUWncwRENscXVv?=
 =?utf-8?B?SWVTWjgxMGxnMFpzengrRW11NS9qL3Z1R3FZT0tzcU9QTVN0dEhzUHVlTk81?=
 =?utf-8?B?RmVFTjBqTUZmNzIwWmpsakNTU2l1UUxGTkF5c0hUTUFXRzVJMCsxUllFVXBY?=
 =?utf-8?B?eGFBeWJCeHdNeUd6UWF3Wm0zRUxpeFJqQXpIajJYWmlTNE1CMGZvcUxkeEdR?=
 =?utf-8?B?eFM5Z2VxQWVHS1p3b3pjRW9NaFhhamlyS21QbGtCa3BsVVM4SG9ZZGd6TnJL?=
 =?utf-8?B?blpHRlEzaXJMbFhGR2pDRXFUMDNJNG0rek1FamdsbEFjUmxyaVM5RUhHWVlu?=
 =?utf-8?B?dkxqaktLNytsaitPUFNHekEwODVXbEV5cG1WbW5lTTNWRnBwTmltV2xiMUd3?=
 =?utf-8?B?eFNqRmQwbVVRK3B3YUlyWUlPaVE5Um5aYUFBOWtMSXpHbnFxRlFHVGIybFhM?=
 =?utf-8?B?dnlBcVVmY2l0NUhMa3oyMTBSa0FxOUg2dmlqa2M2SnJTeEFQaWhTcUFYU1hN?=
 =?utf-8?B?U0YvZUpoRmtiTHJlYnpaZEc4cERvVzNDT1VPMkZFL0gra1pmTFJyMzVyUXlR?=
 =?utf-8?B?RnI2TnJVSTg4eU9Bb3pNbzV4MzAwcUU1SERzS0lmV0RZSkxab3R4M2FlZkRp?=
 =?utf-8?B?YTFUTWY2c2tFTFdTRnhYMDNFTURxVWJmTGdreFFxRWN5VzkyQzU2RHRkbkpD?=
 =?utf-8?B?TEVPci9DeVo1MXZnK245aGRtOWRlMjNmR0ozTUxCL1QrVVRqRTlRbnhhemgz?=
 =?utf-8?B?U2ljM3MzMzB3RmZzdjF3d3RHaThjTGl5M1IzSVJPTlNGK2hSUlhEbnVVYVRN?=
 =?utf-8?B?TmlQenB3RHZzZzN4bUd0R3dOeUJrOWdtMWE5V3BhaDl6ZjlQNEFtWFdYVDhi?=
 =?utf-8?B?TFBpMjNQR0NCRHJUS1BFSC94MUliRFQ5NzQ2OGNrWVhYZWF3R1JrME11bE5Y?=
 =?utf-8?B?VFJ0ZUQ2K1RNTTZRbFhxREwzYUJBOGw1aXVIS3Y4Rnc5YWxLTTJEN2NTSlMz?=
 =?utf-8?B?Nm1qWDVyYXV3YURWMXU4R1FLa0FWWGJYSU1PK2hlaWZ6K254cGJSRU1iMlZ4?=
 =?utf-8?B?aE9tRENoK2YxQzNqYUVTQ05mazVNTWNkU0RZZUY3aVNMUmJMUFl4VWtSSDh2?=
 =?utf-8?B?OFRVeEZHUXRFUWw5cUlveDUvZyt3QlN3SDY2NDRUZzJ0ZVIzc0lodzQ5eUJO?=
 =?utf-8?B?TWduMlZROFB2d0V1TGJKK244d2hTdEhBblFwOVcvZkRVWnpEaFhRUFZDYnRK?=
 =?utf-8?Q?vZkiKeBv3PFMxoTj8x7T0CXGh849J77NHW7FRUnYYYo3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4573DAFBA96D045B06A7BE590F365B5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0260d336-c76a-453e-51fe-08db7823e8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 22:06:23.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBERrA6+NoASR1DaCihaZfDtEfRla5GFyMRDfJGlFyuhee+a5P5y+AqM4lqvnJcRnm5QDTANSC0atkaUM+EMWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yOC8yMDIzIDE6MDkgQU0sIE1heCBHdXJ0b3ZveSB3cm90ZToNCj4gDQo+IA0KPiBPbiAy
OC8wNi8yMDIzIDEwOjI0LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4NCj4+Pj4gWWksDQo+Pj4+
DQo+Pj4+IERvIHlvdSBoYXZlIGhvc3RucW4gYW5kIGhvc3RpZCBmaWxlcyBpbiB5b3VyIC9ldGMv
bnZtZSBkaXJlY3Rvcnk/DQo+Pj4+DQo+Pj4NCj4+PiBObywgb25seSBvbmUgZGlzY292ZXJ5LmNv
bmYgdGhlcmUuDQo+Pj4NCj4+PiAjIGxzIC9ldGMvbnZtZS8NCj4+PiBkaXNjb3ZlcnkuY29uZg0K
Pj4NCj4+IFNvIHRoZSBob3N0aWQgaXMgZ2VuZXJhdGVkIGV2ZXJ5IHRpbWUgaWYgaXQgaXMgbm90
IHBhc3NlZC4NCj4+IFdlIHNob3VsZCBwcm9iYWJseSByZXZlcnQgdGhlIHBhdGNoIGFuZCBhZGQg
aXQgYmFjayB3aGVuDQo+PiBibGt0ZXN0cyBhcmUgcGFzc2luZy4NCj4gDQo+IFNlZW1zIGxpa2Ug
dGhlIHBhdGNoIGlzIGRvaW5nIGV4YWN0bHkgd2hhdCBpdCBzaG91bGQgZG8gLSBmaXggd3Jvbmcg
DQo+IGJlaGF2aW9yIG9mIHVzZXJzIHRoYXQgb3ZlcnJpZGUgaG9zdGlkLg0KPiBDYW4gd2UgZml4
IHRoZSB0ZXN0cyBpbnN0ZWFkID8NCg0KSSBkaWRuJ3QgZmluZCBhbnl0aGluZyB3cm9uZyB3aXRo
IHRoZSBNYXgncyBwYXRjaCBhbmQgbW9yZSBpbXBvcnRhbnRseQ0KYmxrdGVzdHMgYXJlIHN0aWxs
IHBhc3Npbmcgb24gbXkgc2V0dXAgd2hlcmUgaXQgaGFzIHJlcXVpcmVkIGZpbGVzLCBidXQNCllp
IGRvZXNuJ3QgaGF2ZSB0aG9zZSBmaWxlIGFzIHN0YXRlZCBhYm92ZSA6LQ0KDQpudm1lIChudm1l
LTYuNSkgIyBscyAtbCAvZXRjL252bWUvDQp0b3RhbCAxMg0KLXJ3LXItLXItLS4gMSByb290IHJv
b3QgMTgzIEphbiAyMyAyMzo1OCBkaXNjb3ZlcnkuY29uZg0KLXJ3LXItLXItLS4gMSByb290IHJv
b3QgIDM3IE1hciAxNiAgMjAyMiBob3N0aWQNCi1ydy1yLS1yLS0uIDEgcm9vdCByb290ICAxMiBN
YXIgMTcgIDIwMjIgaG9zdG5xbg0KbnZtZSAobnZtZS02LjUpICMNCg0KTGV0J3Mgbm90IHJldmVy
dCBNYXgncyBwYXRjaCBhbmQgZml4IHRoZSBibGt0ZXN0cy4NCg0KLWNrDQoNCg0K
