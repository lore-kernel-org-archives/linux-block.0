Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91290C678D5
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 05:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCHFmf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 00:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCHFme (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 00:42:34 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D199D7C
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 21:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEFdfwr5kzBGzurXdOXdiLp34/glctch+ZNsn2Rcb5QoqMjDL+zekVSlGtJugSbKnnc0TjFcFf7XE4Duo3ajIwIndygdDI1Hwi64Iv45vJCCIrQOnnPfzeVVSVdn+lH4OaUqJUrDDf/1qrwQCX2xSVGMEKTqomLYFXMsoRbnYL3k6n0iHBD2p+OjtINmm7yjfZGMtKRzLaGoyFISeCtn+frq1CtWBYDRsONCpxLLi90L7gYWLH+V3FxMuBjwHM/GVS9Gdw14TnCJPia0114gtq4AjTXeyxgeL31KnHR7dBmu6x7R9nqsu5kaz8TF9aeGx1wFe0S0Fqyh9BSJjjQujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH9BEaoQXO9TuCHy9XPPRehrU5n52a3cxcxxsqucN8k=;
 b=E6quZIh4s25+J+rx8/JRaCwpRBExLH4K9wgOeqoK7cB2MEztLVJcgFKukjDpOG4oXLGHXIryNqdXv4aX/Rn1TRR2I7VqyhDgkHC/zpDymVSPWtq22iUeQ1wBKkvQVPGqG4l2gjWZVEQFBuDstVIet1y3XW4e4WOH00MXs0ARPe98/QKUVfhpEOhWA4UjeusNyDF/0SoqdCm9sxdgVBlpfmzsR5dsEUhC1U933sjmP4A2I8sJsor1s/E1nyko5VgjJQ0zBXp+sav+ltV30waW45Ntt7C5N1KVp27vE4NG56opyClS/yFJe/5FBbW/wJ9vm/nzWyWXAagk/S+fh7EMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH9BEaoQXO9TuCHy9XPPRehrU5n52a3cxcxxsqucN8k=;
 b=dMYftsqTCEl/dIW8lKpUce6srFY+oGCStJogemaUdmBriQooSZTmkX7P4vMaMoi4XvBiIYS9doAXDmajHVw6qXGvoHozqM9nDafl0nSzURGzw7ttIAn0rDo8p7jnVb5raE4X8Z9HgYKQnzDO0ZVwaFhSVWj+IasUIXsM/0htxNiW9TcV3xTNnPFd1uhPydTNBD7ikkHnsBhaxvxn/iAKerEqJcAjmjQjr3gKSXlqeIAbXq3C40Ink3VY+IQp2B4aQ62PHHrlYTUbCxwKkw+r/Ip/TdgL597e1+xSsWA4UF4Rb5P2SHPA+bkFMExurlCwZxnVflAxW5LFSooQyu+JjA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 05:42:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 05:42:31 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] nvme: fix handling single range discard request
Thread-Topic: [PATCH] nvme: fix handling single range discard request
Thread-Index: AQHZTiX2EW8aeGjaO0qLT1SlqfD6u67t0X0AgAB9I4CAAOgFgIAACbCAgAAE8QCAAB+AgIABAHqA
Date:   Wed, 8 Mar 2023 05:42:30 +0000
Message-ID: <136e275b-6cb5-5202-cd29-8c5d40fdfc0f@nvidia.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
 <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
 <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
 <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
 <aeb59707-00ad-bc57-9f91-ef5757de9294@grimberg.me>
 <ZAdJIXT4AxuYB3Do@ovpn-8-16.pek2.redhat.com>
In-Reply-To: <ZAdJIXT4AxuYB3Do@ovpn-8-16.pek2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7581:EE_
x-ms-office365-filtering-correlation-id: 1221be96-5890-41ba-1ec7-08db1f97e8d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ah+tCjobEwQsocROQj/cXEaDradDy5oOHgSf7kKEj4XYpzgWUICR23hyrDoL4BmcadnRc06EPGqUs1kw4ulfP5LSrjkezZosGboc/5qmt4yDxRKwlOnNNRnZDicVUljge+MnxfKXHh4a1yZJXN6JnuTOttjraOwS9f7qTPjtge2gPXKC9cS0wBeIn7Jgk4csqFIgKRWJiNYnXr7iYlw4vQdXB5ycccMi8ewxVkj/syCa8SNVE3F4gx8OdfNzEK7IFEB+b0CXLrNxyIbPJDLN1LQOox4RSkvcCdhqSGplxBPvqH7rokXJxZcLbnmF1BSeD7BL/fsnxlL4WooW6/Hz7TuxA6DtV+JCiOR7Gbwv+hO6T1zTAa1OEe7x4jbrTkGlxNW+0H8DF/v3i668Uc2Urjs6JN++YZvxWonYfi9haMKDTxzT0of0MXnM4G5itBDEUfZMmbQ6u5UYhOYG3DFf8GVNHHNoxS33IbqZ0qrJgowOo/ZAa0TzxXGDdVzNhYWoUkZEgdWUpAw/bCmjzV5ZMPZvi7OLatfT/io6QU1l+FWoi2IojIRGk9BRv3VmLdKhtxXxjpjp/4AXovYmRERHqiigvRx3oY+GntXqvfhZKU7cg8I9mUw0tS6AjoFNVVWkUU0KIUZzQFSXByelt6VKaRGiy+RuQe5TzV/we9JyQbzflC+kXTfsPIzqNtqF1GrR37gXhVzyOcJJcXxgwpyD1+Bu1zZA6JNefkmB9btOa5Lk29/dRYH9SwfEI5355ED5YutPetUI8F/BjmiBEN5fJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199018)(31686004)(36756003)(66946007)(8676002)(5660300002)(41300700001)(66556008)(64756008)(4326008)(66446008)(8936002)(66476007)(38070700005)(76116006)(86362001)(122000001)(31696002)(38100700002)(2906002)(6486002)(71200400001)(478600001)(54906003)(91956017)(316002)(6506007)(110136005)(83380400001)(6512007)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEZrRkFZSlBVTVhJL3EzdDRCaElxRjduKytxemphdjNQb204VXdXdUxvZXdr?=
 =?utf-8?B?TVpmR3NxRlZZQ3VVc0NBV3ltZVArMVFkTlRqNEptbC9rUFQ1ZWVkbEJ6OWl6?=
 =?utf-8?B?V201RmQyaS9BbWcyN3Q4d1UrS2VNNTRnZkpUWjdVamYrektPeUNKWGhhRFd2?=
 =?utf-8?B?Z0JBVmZVNE8vdkFNbndhRWEvS2tOOUxoWHpUcWFDOTd1NGxGaWIwc0M1aUU4?=
 =?utf-8?B?R2E0ek81K2NJRUtSdDZUM1VHd3RsN2tkcWZGUStlT0NZVjkxejI2TW1Edlk4?=
 =?utf-8?B?L1JDM0tWMHpSWVBrL1luUVpHZHk2QXJTa3RvMWgwUnprbko2K2QxVGFXUmFs?=
 =?utf-8?B?dVpYTE9FQ1Z2ZUVvSjJrT0RTdnc1dHNqR1BWR2VSZ2NWaWtubFI1eStnZUgz?=
 =?utf-8?B?bGtPTlh3Mk1LN2hsbEtBNTNyeVdZS01mZ0ZWanFTM3NzT1dqR08vR1djSkIw?=
 =?utf-8?B?aisvVVJZZEh4OWlXTDBFdXFvS29SRUdGb292RlpkS2FQNVlGc1dYWSt3clJT?=
 =?utf-8?B?NDdSaGc1RzRxY244VVlEMGNBWTNUcitRaXNoNlhvc0JtZ3hGam5QQStiblV6?=
 =?utf-8?B?d1FCd3ROWDg4N1U5VGtMZml0ejhUQzdOenNuQlRHanlyMDNFZm54UEIxYURy?=
 =?utf-8?B?UDNiRG5Xd2ovQmx0N0ZQM2F4REEzbXRPb3hyRUVOL1lWcWxPRzVZcjUvNjR0?=
 =?utf-8?B?bGQ0TW5RcHRNQ21PbXQzU3N0M1pzbHZYK0ZDc0cweS9zcUwxWkxOTHg4K3Jj?=
 =?utf-8?B?QXJubXl0VCswZm15dzE3UUk4SWtSNEhtclo5ME55TmdqM3hralNDWllEQ1V3?=
 =?utf-8?B?ems2dUJESzZoVlQyY3JrTEEzQlZBUTlvWGlLQ0o0MWR4bU5RTUkzbEVwQUpa?=
 =?utf-8?B?SFZmUzBKN1RZRXBwVElJY3pDaTJlcnFBRXM1QzAvTWdUTmRKQXdYai9tNVll?=
 =?utf-8?B?cXVmaVY5NkxjMFV5Um83d0NEMmxKY1U4Zm5KYnU5ZitCeDd3RmRscnVEUFh6?=
 =?utf-8?B?a2owU3JXM1pIYzluc1VBWTMyekZRbEltU1lJTDgya3lIMEREeVltc2Rwck9V?=
 =?utf-8?B?VytybHd0amhKMXRadldsN0kxeVlwRWd5ZmN5UDVMb0ZNUG41SUFubUpQMmkv?=
 =?utf-8?B?aWZsYUxRZFE1YUVqY1UwZ1hQb1VJaU9LeGVyN3RXbGo4RkMzblhyeVB4ZFJS?=
 =?utf-8?B?bU1HTlpNS0s1ODlOSkNOclRhTTZaZ1J6VjFUcjNpZlVVWGVYckNISkJ1Ri8w?=
 =?utf-8?B?SnI4anlGbFd3eENjaVJBS2wxQUVSbHl0NXlJQWx4cFB6dEJUNW11QXA5Rmh3?=
 =?utf-8?B?MEptVW02Q2FBYkNFSXh6STB1Rm9VVE9SZ0lMTE04SmVQMHZaT2JZcC9PSHRx?=
 =?utf-8?B?WDgxdFBkUmpQdFpxck1rWGd4S0EyVzVUQ2tYTEZsb1Zjdlg2NS82UVRjUmY3?=
 =?utf-8?B?ZGdzNlFMZDdIWWVEOHN1ZDB3L1Z0Um9ZRmpFRVpTK1F2ZDJndzVXU3ZramZj?=
 =?utf-8?B?UnJUaWJ0Qm1RR2JKMlMwRUF2dVJLWUQyNUNtSmJPMUxxV0txQXQyUmZNZFBx?=
 =?utf-8?B?RnpsaTI5NUNTK1BOT2d2Q0Rqa25qeVpNYndzSjZQUmkyTGZVQkhZVWhUWWcw?=
 =?utf-8?B?ZDNkM2pjV3Z5d0Q5UmJsNTYzQk1JMzN1K1ZPZ08rbEZKZGNvakZPY3dPYlpX?=
 =?utf-8?B?WjNDc0F2NlVFUWg1dHJyY0Z3dmllaGMxdEk4MTdvdU5uZHVTUGVGOG5jSmNG?=
 =?utf-8?B?YWpwdVhzZzJjb09NZDFHS3d3R1draGQ5QS9pRSsycHdvWWJsekZ1R2t0RWU4?=
 =?utf-8?B?Yzl2ckFBeTNPb0R3TnBUU2ZpRTVEbVhzNFJPeVVaSE0vS28xR3ZZYks2M01G?=
 =?utf-8?B?VTFZdkJWektDZnRpd0l5UHhFVlhza0hwL29KUFZtcWw4ZW12anNvK2hFanlm?=
 =?utf-8?B?WElxYzNyV1B4VmN4ZEpSeU9mNGFpeVVzUVZtRk53czV0U1BqSVowNXBuMWJX?=
 =?utf-8?B?N2Z0V3hCeUk3WndKZlVTdGhRdkQ3UFRrM3h2YW83NzZqOUM2dmQvcnM2b3Fi?=
 =?utf-8?B?bk5EZElQSW8xNTY0UmVKdTMrOWR3VzBsQ2tDWGgrUk84MGN2dTd0OWtKZlBu?=
 =?utf-8?B?NzlZUUZHTFB4V3Ftc0NFemVxRDc2YUZYYmxxU200ZUJFM0ZRVHdsRGo4alNS?=
 =?utf-8?Q?+JWGRseWT9ifh3dWC0ectL7sEkgH9Tdf+1eDjtLQsi2b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00C5F3FE0DD3D142B8FD9A4163442DA1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1221be96-5890-41ba-1ec7-08db1f97e8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 05:42:30.9770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ES6tYUOSNZmhImMM+93X/bFo865xKiQAyayOfrEWIq1c+3+4n+suaBisP6FZA4ZihZAq93oswTina19egt8WPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+Pj4+IFdhcyByZWZlcnJpbmcgdG8gdGhpczoNCj4+Pj4gLS0NCj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4+
PiBpbmRleCAzMzQ1Zjg2NjE3OGUuLmRiYzQwMjU4NzQzMSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KPj4+PiBAQCAtNzgxLDYgKzc4MSw3IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9zZXR1
cF9kaXNjYXJkKHN0cnVjdCBudm1lX25zDQo+Pj4+ICpucywgc3RydWN0IHJlcXVlc3QgKnJlcSwN
Cj4+Pj4gICAgICAgICAgICAgICAgICAgcmFuZ2UgPSBwYWdlX2FkZHJlc3MobnMtPmN0cmwtPmRp
c2NhcmRfcGFnZSk7DQo+Pj4+ICAgICAgICAgICB9DQo+Pj4+DQo+Pj4+ICsgICAgICAgc2VnbWVu
dHMgPSBtaW4oc2VnbWVudHMsIHF1ZXVlX21heF9kaXNjYXJkX3NlZ21lbnRzKHJlcS0+cSkpOw0K
Pj4+DQo+Pj4gVGhhdCBjYW4ndCB3b3JrLg0KPj4+DQo+Pj4gSW4gY2FzZSBvZiBxdWV1ZV9tYXhf
ZGlzY2FyZF9zZWdtZW50cyhyZXEtPnEpID09IDEsIHRoZSByZXF1ZXN0IHN0aWxsDQo+Pj4gY2Fu
IGhhdmUgbW9yZSB0aGFuIG9uZSBiaW9zIHNpbmNlIHRoZSBub3JtYWwgbWVyZ2UgaXMgdGFrZW4g
Zm9yIGRpc2NhcmQNCj4+PiBJT3MuDQo+Pg0KPj4gQWgsIEkgc2VlLCB0aGUgYmlvcyBhcmUgY29u
dGlndW91cyB0aG91Z2ggcmlnaHQ/DQo+IA0KPiBZZXMsIHRoZSBtZXJnZSBpcyBqdXN0IGxpa2Ug
bm9ybWFsIFJXLg0KPiANCj4+IFdlIGNvdWxkIGFkZCBhIGNvbnRpZ3VpdHkgY2hlY2sgaW4gdGhl
IGxvb3AgYW5kIGNvbmRpdGlvbmFsbHkNCj4+IGluY3JlbWVudCBuLCBidXQgbWF5YmUgdGhhdCB3
b3VsZCBwcm9iYWJseSBiZSBtb3JlIGNvbXBsaWNhdGVkLi4uDQo+IA0KPiBUaGF0IGlzIG1vcmUg
Y29tcGxpY2F0ZWQgdGhhbiB0aGlzIHBhdGNoLCBhbmQgdGhlIHNhbWUgcGF0dGVybg0KPiBoYXMg
YmVlbiBhcHBsaWVkIG9uIHZpcnRpby1ibGsuDQo+DQoNCkknZCB2ZXJ5IG11Y2gga2VlcCB0aGUg
cGF0dGVybiBpbiB2aXJpby1ibGsgaW4gbnZtZSB0aGF0IGlzIGVhc2llcg0KdG8gcmVhZCBhbmQg
c2ltcGxlIHRoYW4gY29uZGl0aW9uYWwgaW5jcmVtZW50IG9mIHRoZSBuLCB1bmxlc3MgdGhlcmUN
CmlzIGEgc3Ryb25nIHJlYXNvbiBmb3Igbm90IGRvaW5nIHRoYXQsIHdoaWNoIEkgZmFpbGVkIHRv
DQp1bmRlcnN0YW5kIC4uLg0KDQotY2sNCg0KDQo=
