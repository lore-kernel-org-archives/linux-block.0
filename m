Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCEC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 07:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjDFHLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjDFHLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 03:11:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2304110D1
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 00:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0avI+Y/mD1nH+UV1dwtCOwUfjgEf17UOZ8OfMWMTNhisX0CpCdytFHkyreod2e8i3G4qvbMRr1oztWtLYY+gh0mFcmjRbFGx17VtwEN9HNstI28GLnmTL8VW+uVvZB37RPn0GEv9BQ7C4g3AbySEcF4VRYtBL+O9sCeFGnurPrvS3bO+eax5vJxq1uJrMwAHvadEYec5nybTUivXGmhZtSZO732tuvkg1vLMQE3Zpcm3uhy2PWchcg0M7/mIsnTJejp/52I1jowmQEYT/FGqsvn9haiL+UgGf76v0o6A3u0YDvIYb9ZIMnHBdQpw2f5c/2s+0JLUaaJD8V+a9zU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qez5LY+GKRYKTfLWIcQSB+fQD3D5FZk9gB9L9HU0214=;
 b=LGQrt22D4PsUTLQLdZSHxaRzFyI5/MjN4RluMNcQkYdf2iYS7H+CLFmuk1GrHJgikENYuxkBQw1X54D6LIo0L0SMT2+lvSHYE4hVxX7zh6A4ZGX+PGVFgTh17YEFYZIubJtEY0yelKBtJg+p5CEExvPHxFK1iB5pwlDXqVq+nTjsvP/DIRTxQGKrTXvzrR4wTOAhE9ob0Fq/GHDitwACXgwSAfWJT4MVj4wBwqn7DUiljRu8A3IJYwfeAXuKy4jmhCBP8Zda4drqNFLOy6p7be/Mp9bveZx3mwDy1v3wDzPcJbSAPi6gtEW8vb8w1spqmcPtCzWIQpd1nmPSCqhXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qez5LY+GKRYKTfLWIcQSB+fQD3D5FZk9gB9L9HU0214=;
 b=RraikHveUrTrqBOMw9Mxt0l+59FpAVcv4sLlv00jsEcfVIPqKe5AnPhPJ/WpQJ62Vw9xVi19Yc+cnRvp6HIS5B0MD7uHZ6gYDkzLWCYtPehrKAXDDE3MiYwiSLGl38atqFxWgnTHsLgI2FilGVUV2zkTg9Compf+I5nKjxS/S8Lj8JhxiDVSrDSia80/Z4p7O2F0qTFY0oZdsr0K48nDHyzwdo4QL4Y58blKeXn7rsAWavIirazLseV8aVA3iXM/3oI0y2Sw6ZlXwng1OkDX72OIdv7tKuplwKSAKJuIcgBu/cslI7i3qs5M9aM3oys0n7VzAISb7CiWBnI3WYir/g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Thu, 6 Apr
 2023 07:04:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 07:04:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Thread-Topic: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Thread-Index: AQHZZ9X5/fquS5aXZUWrqdtzWxsMWq8dEVyAgAC97ICAAA0TAA==
Date:   Thu, 6 Apr 2023 07:04:22 +0000
Message-ID: <8486b43f-768f-a716-b94a-71ac59190ead@nvidia.com>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-5-dwagner@suse.de>
 <b469de5e-0005-b123-8473-6b95661e78d7@nvidia.com>
 <lgqrsky6qbdiyhnzunc453mpbgxvr4fi5fumpi6xrhvd3lfgvf@vakvam7bkerx>
In-Reply-To: <lgqrsky6qbdiyhnzunc453mpbgxvr4fi5fumpi6xrhvd3lfgvf@vakvam7bkerx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB8689:EE_
x-ms-office365-filtering-correlation-id: 4cb33aec-a8b3-40b0-e0aa-08db366d2675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhBFzlbnFz86R86BnlScmJFHdrIoJFy0X+11sLIwckF6UER0/+yyYIJaxMVLvVaceqxUzLpOsehcfkBN4rscIdoFfN/kcF37LbZoZ4mvINpQemqppY8aP6TR+rXzi29gcgIqHgJQ759eAD405hfYWsXv75AyPAHWVlI+vJw0rNTzqPhBlIfkcQKVM2YC46oWarfgo2SHm+moObuNOGLRwDbmXDV4m3RgsQxQy6t81EdGiB5UFXs4TjZJZmg0VskowJ/2MpjYmio+FI+ryjGBxNmeyuQOjVQ0fGRJ8ksQYHPV4wIhmboj7JvQ4MPkfrsMQCDEj7cm/gxKbmFXNTdSENX4yj7xKaFPyN0M0or5+VhuAm4bDCNxpc2Wt2Cp0OhA7q5+fMDw2/iSTBbaoKnL+wtBdXkGVwZzr9XumXwV5pqkB7y7I1i7VM1onsw71c+QRvTOvoVVNceL6X3Sg+vn+mUqA30nO7alW6U14MFfZH4y12ipI7gFWI2Nh7agLIVjYg9klL8SCCq+5XepmjBAIwSAOB3hKH7aN5S7IsoljZfNA4FCpLDtxCNlG0Lj/RdBLtafJVXhSJYud7c/G7vw0dWXGTOnRxYmLZK1x3JTwZv0a7BlM+qrEjAGppWRMzSQOYxJhRlaFCLT5/1THjdFOUH6WmwZbRTFs0zXsRqJCrdBhxWlCQ+pebGWdFQWTYKd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(36756003)(2906002)(83380400001)(5660300002)(6512007)(86362001)(6486002)(54906003)(186003)(478600001)(53546011)(6506007)(91956017)(2616005)(316002)(8676002)(66476007)(64756008)(66446008)(38100700002)(122000001)(76116006)(8936002)(4326008)(38070700005)(66946007)(66556008)(41300700001)(6916009)(31696002)(71200400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFJZQUlpRVhNNjk2OG5vWmdob0ZHTDJ6MXJsYUxsQWp6a2kyWWN0SG1tMXIz?=
 =?utf-8?B?UHRqSTROT2hvUWZRWFd5L0ZLVEdwOVlwd1ZrQzhIQjc2dlNqcFdrUDJjcXFT?=
 =?utf-8?B?dzNpU0ZwRUU0STVYdEo0R0tHeXoyNks4U01yKzE5YndwZXduanBlNzdpY0k3?=
 =?utf-8?B?U1I1aDRVSW92V2ZsWWd4V251T3VSR1FlSURJK3lPU1AwY3BIaFNaZFNUQW13?=
 =?utf-8?B?eUZ1eEQycWFJdW1vdVRFNnJqOGpjOUhRVnpBa0tjcmhGakRhZ2EvMEduMHJi?=
 =?utf-8?B?bG5mSXlQMmcwaGdBbiswMWRsaXA2d2E1c09JOVlFdWhLRGNXZ1dIdUtrT3NT?=
 =?utf-8?B?NFBUa3RuTUxGcm1iNGswUmNkSVU0WDZkeHVPMGlVbXdlUVY0aUZOS2YzZWpm?=
 =?utf-8?B?RGNxNjJacVBGcVU5MURpK24vTWl0NmNzT0lyNkh5K0VyN0daVGlEYWdyblJZ?=
 =?utf-8?B?VlNhR0NkSjkxN2F6WUlNRlJEMHVDODhxZ0VaYWlTMmE1OG51OEYvVXB0U3ln?=
 =?utf-8?B?K2E2cTBPSm1pZU9wUU1MRHBSTXE2bHgvKzQ3Ri9acHlIZHpaWEh3U1dsQ2Mv?=
 =?utf-8?B?TTNHSXEzdE1TM1FVcXhsZUxPa2VaTEs3UUg5alVxZFYzWkRhclErdzBTKzNX?=
 =?utf-8?B?MEFvaUN2amJBYmwwUEo0b20vZm1kTTQwbk0yWWEybDBaTnNMUlUwc2F1KzVj?=
 =?utf-8?B?Q2l0anpQTktDVk1MR25RTEVEei9BYlhkTTlEYUpGVEpxWEh2QnIxampNMklw?=
 =?utf-8?B?eFlTdXlOUUVLd1p6NlF0cnlNNDlMUkxINWpkUExFTkF4VVdLMXN3YnorTkd4?=
 =?utf-8?B?ejNvT0lQbGdsU0Z2MVkwdVFpNkptTjdnYllaTksvRWxsZ3hTdUwveXNtQ1JI?=
 =?utf-8?B?bU03RXhZRFRGSTRWQVZ4WGh6Ums4enB6K1NlSHppMzNZWjhrcjRrckRIRDNG?=
 =?utf-8?B?NU0xY0ROZ3pUMlJlMURkbVQ2dU9uSFZjazRleWJUS2FvWUNPTG1oanVjWWo3?=
 =?utf-8?B?cU9uYmZYZlJqemFvVmg2dkNpVG9sZ0hlYXF1TWlBczhaWnc3TVFWQ2RudDVp?=
 =?utf-8?B?WFZhMnlDZjBsd2ZaOGNqYStNT2NLajAweFJhamcxd2pCL3lNa0c0cFphbWp3?=
 =?utf-8?B?ZTRHdCtFdGV2bFlZUnEzZll2VFllWGZYS3QxeGdMZVV6M01td3UvWUFKS0Z2?=
 =?utf-8?B?WFJjMHpRblpRWE5EVFk1NHlFWlBGdEs0M0dGRG9jNEZpTFp4eUpBTnVlUldN?=
 =?utf-8?B?M0Z5RnFqb1d1b0pGanlRQ094RFhwMW91SWdIRVpzdm9XZ05vdHRCNlVIbjdq?=
 =?utf-8?B?RjdKeHNxWUkwUUsrYzhVU1lIcWVMK3RqTmVtM0crNnZzVTlubTdlbWhvcnBr?=
 =?utf-8?B?allZelZBb2VWeVVSaW1TSDAxdjV1aTlBR3N3SXRpZmQ4MUtBaVd6VnQweVQ2?=
 =?utf-8?B?RExWbk9sS1lhNEFCeXJyWFBvQ0kwZS83bm55NkJyZHVWT2NvT00yY24xSDVX?=
 =?utf-8?B?RXpMWWJ2RnB0RGExbmlxNkFQK2dIVzZSN3V0TDI5cjdna2xlOUd4QmlXZ0Ur?=
 =?utf-8?B?VGJGY2tHeVozbHJDYk5TUi9lVWlEaTFZcGZMS2tFM200SE93bzFmTVN0OHZ5?=
 =?utf-8?B?QStZcXhUdTZrTmZHUU05MzJHVXVIdHpkZkgrcnc2Vk9JWXZQemVvRkRzWFFB?=
 =?utf-8?B?R2kydVlCUTB1dXNCajRTOW5YWXgya2oxZ0JoS2VCMk1tVTR2K05lcnhzUURX?=
 =?utf-8?B?YURlc0tPSEVrbVhIOFN5THhqTHRPMGdjMUl1anM2YzlVZ25VTTZVbHh4bnpS?=
 =?utf-8?B?NEtMeVplZWZ2QzlHbjkvQzF2OHUwUm02d0ZSQlpvdXdVUjMybnhDRnlvQmQx?=
 =?utf-8?B?N2t4TUFlZEFpQzAyTTZaMTE2TElOd0R0ZzUxNXRlTEpoWU1YcWJ2TG1kLzNI?=
 =?utf-8?B?S0FoN0p3TXJSWllaakRDQUZaNmJna0VSM3R4UUlKZHNLZ3RDQXdGV1p0cm5J?=
 =?utf-8?B?aFNRdXV2cE0vU1VIYjlzMVBORkU1Tzc5M2NCdmJESk1IYUdWcHpJWXNWVnlE?=
 =?utf-8?B?aUd6N0x6OHRXUEZCd3RqeWRweGI3M0M4dXRCNEdYbG9XZUVEYnpWaEpGS1No?=
 =?utf-8?B?OVUzSlBBUXROMGl1YWV1YVUwNEVJaEFTY2l6RGFaMjkydm9IMmRrcjNCVE96?=
 =?utf-8?Q?YzWRxiEpdDC1ap/J+dNc1JW4vm0eOzn5an1jHW9p4MiG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F02948C63A8E4290C9BADEB85335E0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb33aec-a8b3-40b0-e0aa-08db366d2675
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 07:04:22.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHDygUWLhIGJAIBVZM2Yv4zd0GgWTukFauteIfbpG/QdHITVZjiFtITK/dyEfCeTI6FdwnSSrbUAHdmRoV1wSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC81LzIzIDIzOjE3LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBPbiBXZWQsIEFwciAwNSwg
MjAyMyBhdCAwNjo1Nzo0OVBNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pj4g
KwlpZiAhIF9kZXRlY3RfbnZtZXRfc3Vic3lzX2F0dHIgImF0dHJfcWlkX21heCI7IHRoZW4NCj4+
PiArCQlTS0lQX1JFQVNPTlMrPSgibWlzc2luZyBhdHRyX3FpZF9tYXggZmVhdHVyZSIpDQo+Pj4g
KwkJcmV0dXJuIDENCj4+PiArCWZpDQo+Pj4gKw0KPj4+ICsJdHJ1bmNhdGUgLXMgNTEyTSAiJHtm
aWxlX3BhdGh9Ig0KPj4+ICsNCj4+PiArCV9jcmVhdGVfbnZtZXRfc3Vic3lzdGVtICIke3N1YnN5
c19uYW1lfSIgIiR7ZmlsZV9wYXRofSIgXA0KPj4+ICsJCSJiOTI4NDJkZi1hMzk0LTQ0YjEtODRh
NC05MmFlN2QxMTI4NjEiDQo+PiBieSBjaGVja2luZyBmb2xsb3dpbmcgYWZ0ZXIgY3JlYXRlIHN1
YnN5c3RlbSBpbiB0ZXN0Y2FzZSBpdHNlbGYNCj4+IHdlIGF2b2lkIHdob2xlIHByb2Nlc3Mgb2Yg
Y3JlYXRpbmcgYW5kIGRlbGV0aW5nIHN1YnN5c3RlbSBhbmQNCj4+IGFkZGl0aW9uYWwgZnVuY3Rp
b24gaW4gdGhlIHJjIGZpbGUsIGJlY2F1c2Ugd2UgYXJlIGFscmVhZHkgY3JlYXRpbmcNCj4+IHN1
YnN5c3RlbSBhcyBhIHBhcnQgb2YgdGhlIHRlc3RjYXNlIDotDQo+Pg0KPj4gbG9jYWwgYXR0cj0i
JHtOVk1FVF9DRlN9L3N1YnN5c3RlbXMvJHtzdWJzeXNfbmFtZX0vYXR0cl9xaWRfbWF4Ig0KPj4N
Cj4+ICNhYm92ZSB0b3cgdmFycyBnbyB0b3Agb2YgdGhpcyBmdW5jdGlvbg0KPj4NCj4+IGlmIFsg
LWYgIiR7YXR0cn0iIF07dGhlbg0KPj4gICDCoMKgwqAgU0tJUF9SRUFTT05TKz0oIm1pc3Npbmcg
YXR0cl9xaWRfbWF4IGZlYXR1cmUiKQ0KPj4gICDCoMKgwqAgI2RvIGFwcHJvcHJpYXRlIGVycm9y
IGhhbmRsaW5nIGFuZCBqdW1wIHRvIHVud2luZCBjb2RlDQo+PiBmaQ0KPj4NCj4+IGFnYWluIHBs
ZWFzZSBpZ25vcmUgdGhpcyBjb21tZW50IGlmIGRlY2lzaW9uIGhhcyBiZWVuIG1hZGUgdG8NCj4+
IGtlZXAgaXQgdGhpcyB3YXkgZm9yIHNvbWUgcmVhc29uLi4uDQo+IEFnYWluLCBubyBkZWNpc2lv
biBoZXJlLiBJIHRoaW5rIEkgb3ZlcmVuZ2luZWVyZWQgdGhpcyBwYXJ0IHNsaWdodGx5LiBJbmRl
ZWQgaWYNCj4gd2UgYXJlIGdvaW50IHRvIHNldHVwIGEgY29udHJvbGxlciBhbnl3YXkgd2Ugc2hv
dWxkIHRyeSB0byBhdm9pZCBkb3VibGUgd29yay4NCj4gVGhpcyBzaG91bGQgYWxzbyBzcGVlZCB1
cCB0aGUgdGVzdCBzbGlnaHRseS4NCj4NCj4gVGFsa2luZyBhYm91dCBleGVjdXRpb24gdGltZSwg
SSB3YXMgdGhpbmtpbmcgb24gcmVkdWNpbmcgdGhlIHRpbWVvdXQgdmFsdWUNCj4gdG8gcmVkdWNl
IHRoZSBvdmVyYWxsIHJ1bnRpbWUuDQoNCm9rYXkgbGV0J3MgZ28gd2l0aCB0aGUgYWJvdmUgc3Vn
Z2VzdGlvbiB0aGFuID8gYW5kIG92ZXJhbGwgbGV0J3Mgb25seQ0KYWRkIHRvIHJjIHdoZW4gdGhl
cmUgYXJlIG11bHRpcGxlIHVzZXJzIHRvIHRoZSBmdW5jdGlvbiB3aXRoIHByZXANCnBhdGNoZXMg
bW92aW5nIHRoZSBjb2RlLCBvdGhlcndpc2UgaXQgZ2V0cyBibG9hdGVkIGZvciBubyByZWFzb24u
Lg0KDQpvdmVyYWxsIHNwZWVkIG9mIHRoZSB0ZXN0Y2FzZSBpcyBhbHNvIHZlcnkgaW1wb3J0YW50
IHNpbmNlIHRoaXMgZ2V0cw0KcnVuIHdpdGggYnVuY2ggb2Ygb3RoZXIgdGVzdGNhc2VzL3Rlc3Rz
dWl0ZShzKSBzbyBrZWVwaW5nIHRoZSB0ZXN0Y2FzZSBzcGVlZA0KbWluaW11bSBpcyBhbHdheXMg
ZGVzaXJhYmxlIC4uLg0KDQotY2sNCg0KDQo=
