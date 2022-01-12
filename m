Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 17:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348635AbiALRzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:55:22 -0500
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:9473
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356034AbiALRzS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 12:55:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExnELBFkteJQWVHhXW4l5TyrDenUgBlvdodGGRxJ1xniWiX9oHNYSnnlVUGXWfVGzwoNPb5vPIqkIakPnr+B1rJW486m1p3ox1BfH5uMqaIRyJiOA6VEEbB2lgM88SBxitKyV9aQGsSyiRbYN/4F1TJUm2TVjYMswH6IKyumgYcGDhsVzY6xUubMpC7BlnbNLZVCbtO0uPTrZRyqQwP82l9bmFYOlybcNL+BGgfcGbmqUL9txcoUZG98yUUsCMZkUsMBH3LOXJxqBIHuwKogQ4Q+1zaVUDhi0203JCNJMEKSTijaMF2aF2iUtkw0dnhj+FkNc7IgQatPVIspd40KvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHjfednGJaNqYeSQPGwxcfHTueuojiuA0wYN1lMzd4M=;
 b=mug31++jBRAkdMxVnKhKJmOk+qWsJnHGTT5Lie4LhLAE3wgKhuEoLHx62sd/vC5DBkCAYqBj2Xyu0I2BDwHLgJZrxv68D9mlVmfVarYeYJ19k0v8k6J/huMkLYSaKNkUZxe9QFuLPYPjdy2zIkEQRBtahatI3l7DIqQQUg1zI/YYYQvqjHu0XpXPdJUBb5r4lJWxP/glSaQU2X4ZlCdqBaSxJYVxF4FecrAc+VIw7qYV6ZAhqaaowjDdWNaz3pEmo2pZ8smNSNX6UWK/OnpdFZRByN3ajxhaTrRNZpUy1FeHQVQxVIHl9Fnu4e9l88yEW6O6GkQJOSBY1OTnA5rwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHjfednGJaNqYeSQPGwxcfHTueuojiuA0wYN1lMzd4M=;
 b=D4dX9Occeox1airJwL6E6nMtGMn6peTBNI7KL0fdsiXShdMSAi7w/m+jMYDkSUxORp33UsiyOg4K6T2wP5u2PGoK3HyaTGbGOm+mhPj+dZpyZIxi6mZNpzUdVl7v++vMlCzZHiEY+Wr/2pBjSavAwBTkZjQ/Z3o/5BatFr4BdT0D82t9TvuLKIGnfKd2eFXHyk9wXSLgI8QQ5uTSeQiEfk9M9UZR/52ba08vEgpkRALdgdD+8BWg0ZNbSw0RNBGxs3GvLo0P8ZVtwdhm+WtbHz3MdAbsok4p6vcR7QfP9g822aDMjUeZxOqCjJrj7mF39nNwwXmo0uOzoLCVx87VfA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 17:55:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 17:55:16 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     "osandov@fb.com" <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/3] tetss/nvme: fix nvme disc changes
Thread-Topic: [PATCH blktests 0/3] tetss/nvme: fix nvme disc changes
Thread-Index: AQHYB3qLxfY+6AfmrECQGLcazp0YgqxfEKWAgACbgIA=
Date:   Wed, 12 Jan 2022 17:55:15 +0000
Message-ID: <0dfab539-c85b-68da-0a2e-3765d7d3903e@nvidia.com>
References: <20220112060614.73015-1-chaitanyak@nvidia.com>
 <dabc21d2-6431-67e0-8ce5-62c74c76bc99@grimberg.me>
In-Reply-To: <dabc21d2-6431-67e0-8ce5-62c74c76bc99@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb37319d-1263-4b56-3074-08d9d5f4b08b
x-ms-traffictypediagnostic: MW2PR12MB2569:EE_
x-microsoft-antispam-prvs: <MW2PR12MB25694FA3D516C16831BFD7FEA3529@MW2PR12MB2569.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XyW+khxNl8xYT8t4eYsmKkhFusTfdH3e3tNR3qeT3w99k+y93vxP4sl4NiyD0IUG8ucxJAEBwhMNTc2BfCkQ2VRgzK65dcYNyTsE0F0XZr2kPPaPRmI5lf/ZTanJqr85zh1+lxhIls9U6Z4gRR6Gcfd++50748c/AFPbB8QGi1V4hKpiLezMG0mBi/MXJrT+/4DIKr6TdteGdqaQo0TS2nP2hJRfZC7ATuaUcV5aAn/Fx90y1sagvOnSOb30rS+/gC+YfGm+VWSyRAls7RJy5W7o1R1jtPf7v9r1wmLmMta9P7YT8zYRk5nRG/qaNb6xWX0uBHuO+5zcs/4/QnNdLHsmSlEAZ6+acq3a9XCewHhuypkfHvbFGG35RwxaiYf4bL7FHpXL+BXJPOmrGHR2FE+kWEz2WZL54s5x1qPzxFLIahRd3VNCJzNpjBbMgM3V6I+qFjDahxObnyFYTDKPpjjuBlfjfTDi3d6WBL6f5SFyOTwNPkXfYbQDNYNO7p+V2v9p/OYTrKkiTJi+BGemxjQzn6VU0dhfVEJs9NHWIQaBcjP2/wwwyjG3roTzDoYRXKtx3an4CkAJ+WkXXYRMROniG5s5/G+A2b5J3NJVNldkdb93f2eVCRtWvhMqqnaVLRZqsQUCHE0xIDs7kIMv3p+HORxkCly7hbxWF0JPRZkndHSVt+8VEXyMN7bDVTh8eR9HanXzsfnkQNZkoW4c3Kd/ExFVnF3jXpPc6gs7MIZbgI1+JHyJ4LmhkuAplkHd3e9qALX9/nF6LLW6htwL4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(86362001)(2616005)(4326008)(54906003)(71200400001)(38100700002)(4744005)(316002)(122000001)(91956017)(8936002)(66946007)(31686004)(31696002)(6506007)(8676002)(66446008)(2906002)(36756003)(66556008)(66476007)(6486002)(64756008)(186003)(6916009)(508600001)(6512007)(76116006)(5660300002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDhpRHpkUFNLTElZVTNZd0JQc1YzNHAxaEtEd0xvMWY1dkhROTUzM1lRU2hR?=
 =?utf-8?B?d1RIUURQV1VoWGZQMEMzZmpxZGN3Wmc3R1lqNS9ZTHJ2RktZTVVGWlo3MGp6?=
 =?utf-8?B?UW1yS1RUZkdBVEx5OFl6K1p4UTMrcjdDQWd2elRUSzFGNmtVNG9lb3ZuZnYr?=
 =?utf-8?B?UXdxd2ZrT0JOQmR6azJZdHNsRU5YRThFN0FvTjRkYTBONFJjQkxjMU43dE1x?=
 =?utf-8?B?Mm93bi9Ca3YyZG9zTk1ER3N6UldLaTg5Zy8rbWJEMnpwNnBjdnZqTzN0SFdh?=
 =?utf-8?B?SEJySnB2WGYwSnFJTkgwbVJ5a3VBRElLRHRHOFFocGp4WGNpTm1vWnpUSytE?=
 =?utf-8?B?SStabjBmYXFSeU1JUEMwd0pkUW1zL05YQmtjQWwzWjZiN3lUbUY1QmJxZ1BB?=
 =?utf-8?B?UDZxT2tKbVhweFdTSWFuWmIwUG1uaUN3Q3ZocnZjMHNoSjRmYzVhemFlOERL?=
 =?utf-8?B?KzlOTFpiNGFWT1YyZXlEaG1HMDZWWlRoQkttbzBBb0tJS1BCVGZxYms0L2l1?=
 =?utf-8?B?YXo0TklHL1ZubnZVanV2V1dHRmREdzlpNGREMHBqRUdNYmVKRkJCUllkUjBp?=
 =?utf-8?B?cUQ0V0JwZC9vMFVXNHpZWThZU215NE9GdEhKdmplRC9mQWJmNXdmMlRLMk9J?=
 =?utf-8?B?QzlBcmd1NG4rMHQ3b0lOQUdudytZUjBaeUMxTlp1VlVxZi9HNWtPeWRDZm82?=
 =?utf-8?B?WG5NNEliOXNwejFnRUdhTHAzTDREbEEvbVExYTNFV2hrMGVoeCtBWldqYVRm?=
 =?utf-8?B?TStUQ1NxMDBEYnpZU1dxZmswT3o1V2Z3Q2dzTUp4NVFlUk9kemFvTnRKM2tC?=
 =?utf-8?B?UmJDR0NPbTI2OXRQNWdwVllyVFVLekFTUDFrQzNYN3NoRUNRY2QybEVSblU2?=
 =?utf-8?B?bVdSY2RTVkZzY2xrWUZhYnc0V3lzUUtBN0pDUW90eWRoQ0U4aTdrY0xLaFQ0?=
 =?utf-8?B?cGx4aVc0V3pweWRaSUR4a2Y3Y011cEhyZnNYZ3JLTCt2QVFiNzRQKzNjSHVR?=
 =?utf-8?B?OFlud1dxYW9CNU5LMi8zMzlIbnV4cnptNHdMMU8zWjN0VjA0S0dMVEZ0amNs?=
 =?utf-8?B?OUVWL3RWYVVVaUVCSDVQNXh6azdCZ1NPTzJCVkhUaHc0bGN5NXlLeXBSQTAr?=
 =?utf-8?B?NE1aUGwrWmlYUVo4TFFjckFsYjByTUZVMXMrdnRCcThMZHBBaFE5UkJvemlL?=
 =?utf-8?B?a1Iza3gySFZSWk4zeDI2RUp1V2xwbk5nMjhtTDhLNlJURTNZcnErRENhMHZw?=
 =?utf-8?B?VUM3UTNQWC80MmQvMmt6dVcvenB2c21yc0tFUkxuZ0pSamU2dzVhcFhqSHUv?=
 =?utf-8?B?SmtlL2ZlcUFPUlRjVnZlc2dCVGtHMFA4V1ZKSU9ZQ05EMTVwY3NHYldpaFFo?=
 =?utf-8?B?dVhEUFQ1UzhKSDI0VWp1TDNxMHlBN0txVWh2dmhRczJuN0kyYnM5ZjRqclhi?=
 =?utf-8?B?YXJoNkE1UlloVGZQTGVEK3A4a0NvL3RNaEtZc1RtcEg2Y3luN1hBU2tvUTBx?=
 =?utf-8?B?NHVybmNZNTUvbnU1SWFMam5WQTNhNmV3ZGNGWXFzazZTenY4TXZjZUdUbm94?=
 =?utf-8?B?ZndBaSt4VkdUZG1wNkVwaXRYYzRDZ1BuN01kWGVvSm9LU1l5NGl0NDM4UEVB?=
 =?utf-8?B?dnFQUDljcFloTm9VeVZQNU1EY3dEek9qSmpSOWdqdVRUSmNjdkZlbmoyRitl?=
 =?utf-8?B?VjNGM2pTbVJHUW5xMUFtd0tUM1NLWVNhZnZ5L0pLZmlFcjlKMG0zUWVvcFlh?=
 =?utf-8?B?Z0ljU0pkWEV5L0xhcFl1M2tyblQrSWNoNGUxWEVrR3U3L2tsOW9sSndGUzc4?=
 =?utf-8?B?V241OWhoNWo0T2VMcExVSjZRTE9CYStTNzVSUUpKUGtyb0tPN1hJTlRMc2NS?=
 =?utf-8?B?cmpPUFMwd2lkdjdvRll3L0J4RVdUcDg2ZDJTQzBaUlZUR0FRb2F6QVpQVmVj?=
 =?utf-8?B?dWhRdjFjZ0h0UjRSb1h4TzNOVm8zc3lQOEhSMkx4WWhBRGpVWHo4MVZXZjdv?=
 =?utf-8?B?NUxzeGRTZGt2VlNMK29KL1YyaWVwQ0xpS2xOTHdxbG45czBXNm9OSWZ5NE1l?=
 =?utf-8?B?OFYrSW42ejdlZXJIdkErMjlnSGFEdDdoSmNPRkdJV1JwOTRsKzdac0ZKRkZr?=
 =?utf-8?B?ZkVqaDdTNExSSzZsc1NlU2N0WTFMTW44cVk3ZUdtenhabzFLc3VvWHpXNk5Q?=
 =?utf-8?Q?WBtItg6cw3ToMZqrbfeuim7a0vkyMVGk2x2jpt5Mv3NF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AE202A26223F449B28E68261D5BBC61@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb37319d-1263-4b56-3074-08d9d5f4b08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 17:55:15.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVHcMZrxxYxTV4tKR96xbvto/mKK3JKFI/2cVoLxE7i+skI3J8A/gZglWwBuXszom5HEwk0a2VRaoLSDynvrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

U2FnaSwNCg0KT24gMS8xMi8yMiAxMjozOCBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBXaGF0IGlzIHByZXZlbnRpbmcgdGhpcyB0byBicmVhayBhZ2Fpbj8NCj4gDQo+IENh
biB3ZSBtb2RpZnkgdGhlIHRlc3RzIHRvIG5vdCByZWx5IG9uIGEgY29uc2lzdGVudA0KPiBvdXRw
dXQgaGVyZS4gUGVyaGFwcyBqdXN0IHNlYXJjaC9tYXRjaCB0aGUgZXhwZWN0ZWQgbnZtIHN1YnN5
c3RlbXMNCj4gaW4gdGhlIGxvZyBwYWdlPw0KDQpEbyB3ZSBleHBlY3QgdG8gY2hhbmdlIHRoZSBv
dXRwdXQgb2YgdGhlIGxvZyBwYWdlIGFnYWluID8NCg0KSXQgaXMgaW1wb3J0YW50IHRvIG1hdGNo
IHRoZSBkaXNjIHN1YnN5c25xbiBpLmUuDQoibnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3MuZGlz
Y292ZXJ5IiBhbmQgZ2VuY291bnRlciwNCm9ubHkgbWF0Y2hpbmcgdGhlIG52bSBzdWJzeXN0ZW1z
IG5vdCBnb2luZyB0byBnZXQgdXMgZ29vZA0KY292ZXJhZ2UuDQoNCi1jaw0KDQo=
