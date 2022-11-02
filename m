Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6CAC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKBBZh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBZg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:25:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE921F631
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbjbEXdx3u36EgO8/MoB3DhFOwVQbE0NmGS4TBoUUuPN3EXzBiA2DRW4OahBfTWC0//u+JrUKLDkHTHAUst/a2sajH0jaRsqNGytnASZZ1bBY30JuP1GIK4zFqGiGoJPRkVzvf+ldAN6mKoHKRNZntIWL2eygPg/miiJMt9lELXxValxBm0JsExj+r0XLCxxvxoguQuye9BlmgFVAsxDGMQX6iTvEj8RdrL/B9+spsMbn7Dsiy6A0/jeMyJO4ecOMhU0AWZ5b7PflZD2zI+BDAG4KSLKD0uHBK8Uq+VgiAw7Zgx4Jo0Dxc7kRUMasa0fW56GDkoLPgjuj3vmgCIclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPcyxoMab9PjK4jj2oPk35VObcCtr7Ps6UGvMHyTiHI=;
 b=RPyTy5XVn4SAvffWbGa/RX1HESAMuuZgHGfrsniZ8CGj2mhAxJHG6UEiSkrw8ekQAY/maMvX91dMx4jImHFSR5wuxukvZLkKZg6SjS2lciWQTv3b5mdy7ccmzeLr2987WCzwCwvAlyjL5f3o/orFO/OoweD9Xj8Lf4f6cVs8IlODdX7mEoe8VUotR2QzPiCuz/C8N9tsB9UvSheSEkuLMb2zjucsQnGik9AaJeYKrxJpxQGP2PmYLkZenqTV0LNAa6GYotpK6f3CqIHo48tjoWq/8imbyPIlKkSrnWv6TjCWKN2s2hifXEpmBEQCgQSg3q5s99MjB+CP4HjXDJWDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPcyxoMab9PjK4jj2oPk35VObcCtr7Ps6UGvMHyTiHI=;
 b=JKjpRyvjffiufQedNfVFFrta8v1SsTiQ6wj2iBEkQ1Mmmu2g5UtkWKBJ5B8qxNEaU5uTCtDuGgrs/l/C3axqa5j5CU5VheBV8q8WmMktrkF4atFnQbknJizzdJrNsSckj1MPbGitJ2loQjGVN7kAoZa1vBZbo4VXM2/AWo4OVigfsa0jYEIFC+3q7MXdDVhnykQ7ISR0a5Peh+LiIgb9cNLNrXfyBbQXjYqGSkI+LaSUf20VMjwUrOXiNnPtIpXIAVA414/pxCcWIOJJZKiQDXeNqsv6RPj2YU/IPuoS25KklooSRaMDLolkfLMAS+g43xbD1QvXQiwkHfk6KZD2SQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:25:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:25:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 07/14] nvme: split nvme_kill_queues
Thread-Topic: [PATCH 07/14] nvme: split nvme_kill_queues
Thread-Index: AQHY7gL1RTYR0Q3J2EKWMQM1VNdkpK4q1/uA
Date:   Wed, 2 Nov 2022 01:25:33 +0000
Message-ID: <0758db3a-689e-3852-54df-caf5334f380f@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-8-hch@lst.de>
In-Reply-To: <20221101150050.3510-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: 084b28ce-998f-44f4-cdb5-08dabc712391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTWq1m+9UsSSEtPhqZf7OkFNmOHejASS3MPRQb+23tJ+1f4O+4W88AC57W8kJp7duPWJeKE7qyJgwSFY08xGY9YsnA/9uHQXhWbK/Yx1myyc7gvGHyhnUO8cRr0n92lNH8cee8WKHZdAq1iYfbPOvE0gYqOrGnPBq6xtGI4TffO+UgdejQaH0kLpC4PpTNoBXu17a+nwge7mEq/knHYzGKpdO8MHoAIi9/yriSO6gjTFv+iT0Z/jYORYg+Y//CHyotOyGqjs5tLdVAeuw51D4nxDGlFahrpjOFN4nGFx03D/uKjyOq9n8FKLXKrk9C+DS6Dsy7gQPJDjs2QC9ZMt0lTFk6R4BKkQmXWRK63Hsc6HLvsnP5akCX4VINVARmBtvKtSJEkxfdNyXDw4yASm6kZWgeBl416St7B4zasACOMbfvGFX4Mz5quJXn8Z4Oy5Z11WYGjZ25mamaz8xgAIqV6wEa//tQTRwVmOT9GWvvwZfoo8C84IdiYaFIzz8Gim53fdlc82qen0tdWzhtmocdFBc7g4vHfjkK9W17XcYO51CNixU50+yvcSuDqp9xvbS7iEBERtMZuaCFI9rcNJdzSMBdlXU9g8O+8lJ7PpSX1Qc6vbvoh2+bQ+UKbvSGWM0dC0sBC+HAAJTM44p+WfsAtss/cOxmIaD3shlgas+1JjQnc6UVmscKDqnTWcJvZoUmhhruiruGTC+9ERHmyzq/XThwUTS40HJiYU/Om2FGtQ8bi2W15beXU15+LRZE1NNxnea+4hlCmfqs8/gm2A0MxwcyBkQ3Zfqai9lkq0tZ5Gu2eljD1StfsQidVqkVtYVSmR9YXSgOS4v/maG+9Cog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(110136005)(316002)(36756003)(54906003)(66446008)(66556008)(2906002)(186003)(122000001)(83380400001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(5660300002)(66476007)(38070700005)(4744005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnBWb3ErNHozbE9sdFliOU14VlZmNG42Vk5uTFQzQTNOWGlaU1QzdE1WVERk?=
 =?utf-8?B?QXdsZWdkbGMwTTFrUlZJb2JxVUxsOUhlUzMzL3I2MUU3TDNoUFpOWVkzOEJj?=
 =?utf-8?B?RFpaaUh4OWVrRzVXUmVDV0tqN0lZT05CRml6eWZuNkl1WkZydGNjcGs0SGNa?=
 =?utf-8?B?amwvandaWHBRNFBBVXZPQnZRV0d3K0pwMHBSTW55dGRjSjNmUk1wcVl0YjJV?=
 =?utf-8?B?S1phSFFqaHhUMGtnMTMvSElZaStyNGFLVVhYQzRJNTZXekpuVmlxODNUbUUr?=
 =?utf-8?B?SXJDZDlTOW9qTGx3ZkdINEIvYzJUbmhGN2NQdmQzSGNNa1B3QmZCRjhUTGtp?=
 =?utf-8?B?NzY3d1EwQUZHUjdmTTJzTlJLNFVSOS9aYjM2cHFzTWxvcW9lUnJVNTBDZVZq?=
 =?utf-8?B?T2VZU0s2SnAwd3dzdElGMzZ0bXZ6ZElCaU1OOHBia2pYUlNPRVdUS1NRZWpF?=
 =?utf-8?B?NlR6dThOY1VLMzR1R3l4aWx5Rm1QUmxZL1ZPWGN1V1pWaWNEbXNOeW1Rckl6?=
 =?utf-8?B?TDlCQ3E4ZlN6Z2tHY0JkWVhoRzNqUHBVTjVUSjVmUVpWbk43OUVKbWtJRE43?=
 =?utf-8?B?Rk5HRk5USHliMWNYSWNMZnFEOEVud01SbVV2ME9qenZrSTJsaFZLR2tScTJa?=
 =?utf-8?B?TkhiYmhycVd6RXg4eWVLOXJIVDZFcTVuTzRpc1lHVC8xdmo5bU9aOUxsSHQ1?=
 =?utf-8?B?eE5zNzQ2KzNNeFVsTk52RENEYTBWY2sya3Vpd0ZjNzl3ZWVGc1puNGFBUEpK?=
 =?utf-8?B?dGRpSzdxZ2VSRmc1TGNUeHJxbmhVVW1iSVp2N1RQdVR2YW9YbTVnUFBnSGFw?=
 =?utf-8?B?SGxTanV1U25VN2hvMUdoUG5vNHpXSlFIL3pOODV3anl1WFh5RXdMeEtKSmpH?=
 =?utf-8?B?cXFvR1g1d0ZDVTArVjhOOEE3ZjRuQWt0SDJwMnN5UDdNeHlJZm5Xajh0blpM?=
 =?utf-8?B?dFk5RUhldmZvSS9XdDR0Z1hRdVl2Syt4KzlrUWE5dm5zS1FpMFhHdndvNUNs?=
 =?utf-8?B?UGZqRDBZSVdNRWRjSHpaQ1JmRjJiVlVaeHM5YWt1UE9FZ0IwbG56ZGtnR2Ju?=
 =?utf-8?B?Y3lFczUzVVRzdjVJWVI3Y3FOMnBCbFprc2x4ditoQlNIWE1hQ09SbTZ2c2JK?=
 =?utf-8?B?ZmxGT3c1cnJDeGJqQitLWTBZU1MwR1VpMlRET0dHbXFaN3ZPdGdSK2hLRktu?=
 =?utf-8?B?bmIxWjdwRjJzK3FpWVB1dTZ2eFdJYkVyendVUGorVGhnYklEY25jVE92RzRV?=
 =?utf-8?B?cmJsNnJRRk9CeU1xb3Q0SXpOcHVCdlBFRExLaWVqc3VRcU9kNk1XVnpaKzFQ?=
 =?utf-8?B?cGpmUnNmOG1wQW9CcVdDVmJTVTMwR0tzYkU3ME9oMmxCVkthaldzeFRaZmZZ?=
 =?utf-8?B?NEJrR29tU290Yjl1Rm5wMkdmR1J4QTBxZEUvL25xMkc3ZTRVTW55N1BITmVJ?=
 =?utf-8?B?VVEwVm40Z2QxZVoxMDNNNUpJVTN2NFlJaHRTU3U4bXlkN2JJVmZDcG9WTjl0?=
 =?utf-8?B?bzZGdUZ0WnZrTEZaUTNxbmIzVjVQR0oxYUVXQ0hNUVlkbU5NS0ZuYVlEWXhF?=
 =?utf-8?B?dGZwaFUzSDlPQkVkUXJRYjhmT2Mvcmx2OEMxSlFvellMbWlPbnhLZG0wZG5I?=
 =?utf-8?B?b3ZBMmhWSGRVTlpsVlRDZHdoQVk2Z2gwd2RzUVA2TTcvSG1VRGREdlFBYUx6?=
 =?utf-8?B?Mlcva2JDOUk4Rk96c2JEdE9rbDY1bGJzRXlVUm9iTjZpdnozMk40VUZqdDNZ?=
 =?utf-8?B?M3V5YklyQlNJMzcwYzlrLzVTMEF3NWwxcW5vYzVETlo5UXNINU5BOC9HbGFI?=
 =?utf-8?B?bHZvTjY4MnJjcWlZK2VHcHZMR1l1NXA3T2sxQnJLaURJL0lnQ3pCVEtKVC96?=
 =?utf-8?B?THFzbzFzeEczK0pIN0VmTDRBSzZ0cFl0VlN5YUFoR0tvTW4vSDhaNTMvd3ha?=
 =?utf-8?B?NFVqWGFzaHMxN0xmamtnaVJCd0NNUk5HUFdpTjdCVEoxczJ2RCs1eDV2QUl6?=
 =?utf-8?B?b2RJMVFpZ2t1aENWQnJickllSTQ0NU1RK1lMdnprLzJ3TkF2L2l4VUVSYTZQ?=
 =?utf-8?B?T3BRRGlWVG5WOUJsVFAwMnhKUllWb0tVOTlkdnNWbDQwZXB5WXB3eVU3NlJs?=
 =?utf-8?B?STZmVGJRQVZTMi9XcFFWK21QeGVWM0g0dnMzOW1OSVBUYVU2ZGxtUnZPTTFT?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66E3D2859648CA43A92369500E805A4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084b28ce-998f-44f4-cdb5-08dabc712391
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:25:34.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnLbaJCcTN2/c9IpqJvoSJ4GOJN9cKGT/gdOqwzJ1NCk2uOB6UM3lidDgcG3ye44NgQhosX5XK9ahJBRXJnNGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IG52bWVfa2lsbF9x
dWV1ZXMgZG9lcyB0d28gdGhpbmdzOg0KPiANCj4gICAxKSBtYXJrIHRoZSBnZW5kaXNrIG9mIGFs
bCBuYW1lc3BhY2VzIGRlYWQNCj4gICAyKSB1bnF1aWVzY2UgYWxsIEkvTyBxdWV1ZXMNCj4gDQo+
IFRoZXNlIHVzZWQgdG8gYmUgYmUgaW50ZXJ0d2luZWQgZHVlIHRvIGJsb2NrIGxheWVyIGlzc3Vl
cywgYnV0IGFyZW4ndA0KPiBhbnkgbW9yZS4gIFNvIG1vdmUgdGhlIHVucXVpc2Npbmcgb2YgdGhl
IEkvTyBxdWV1ZXMgaW50byB0aGUgY2FsbGVycywNCj4gYW5kIHJlbmFtZSB0aGUgcmVzdCBvZiB0
aGUgZnVuY3Rpb24gdG8gdGhlIG5vdyBtb3JlIGRlc2NyaXB0aXZlDQo+IG52bWVfbWFya19uYW1l
c3BhY2VzX2RlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2FwcGxlLmMgfCAgMyArKy0NCj4gICBkcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMgIHwgMzYgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oICB8ICAzICstLQ0KPiAgIGRyaXZl
cnMvbnZtZS9ob3N0L3BjaS5jICAgfCAgNiArKysrLS0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPiANCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0KDQoNCg==
