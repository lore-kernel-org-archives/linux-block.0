Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31133C001DB
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 02:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjHICGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 22:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHICGH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 22:06:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE271BD4
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 19:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYgbn8kPlI8azCuGcjyh6A7B8ryqthx0lEx1CWk8Vywhdp/ZF7Y9rB5cyl53ss8WNmAiBKuvfvHpS+0pFYkJ9zaYLjvYbSdXLvv4n5cWdXqTM/BJqo4QgUYVID4Ie4LspyTrQkeGbDDnaFhGNeGQKNmJCKJI7fHqDqLFqHHg9UT1YmFjeszpXCgB8PGCt26qAep20iwzEQxffUGszMEC4Nm2ajdEYz3kjk3itMgktfljWw+0SzoE6hfopvgwyllLDg4MdIjcOQisrMC3FXZrIzR/+gaXshV3YsJw2mp1AMVs5vXmdHGiJyGckNqrNh2CQt3qEA2MeUXgROG+qBpGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZjLRKtiWAMahC0eaKMtGC3GjTWsBmaTmZW7P1WPKZk=;
 b=oGAO6DdrLlgjr9aVfumTQKFg6Lp/qEehzJwvuZC4vbPu6/muWUqAev0GGYDLmxPgacKzO2ekORIkUzAnCRrlsL8KE/YBfi2N0R95xtWrM+RCKQx79olqkCEU2bYvOr40xIHNiGpRUz5uv9dlqh5tc+yNTb1nayqw3747G1eEsjXYiG2MCGPBd83dCbU2EvjQoX/EhEO1fh8NgTkUV43GO9UDE9U04YkXjWwy+N9At4JKRBHIMRHpFpdgWr8GwfvZe8QRuPXP/RBW+Xa4vPN78x1H/r2l9/ICRrWl3skYgjwhjQPH2cxpFx7qEP004lKNrOr2iZwtV8FNqixAdZbDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZjLRKtiWAMahC0eaKMtGC3GjTWsBmaTmZW7P1WPKZk=;
 b=rpiVwr3GK1ybH4J3FSpqNUIzc7GRj5ZMDE0+svliGObLFzqNb6y694b/vYAFBk3b/miH3plbyAKYCjMDYCWHrP2iqojli2yAp5xD+hmxuxb8ZvrJirwcgZNUz1bKN/4Y4c7h6qePVrs2I9af7jjYpp4kwZoi/mHxMAjElJDXB06a9tL4oQDezouw5vWA6cEfuxOgh17KlaYQQPhysrbH7vr/XiDxw3b9MqvZgBsn0v0aohGF+2sEZeafAiD+M638RfVjUgXanRKL+VEtLqCPT0vjHor1dWiyM0vModMIpl78CKuvw+g675qmPUaubKs6xlRAmdEpaREWNfFLWkfE3g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 02:06:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:06:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/5] block: use pr_xxx() instead of printk()
Thread-Topic: [PATCH 2/5] block: use pr_xxx() instead of printk()
Thread-Index: AQHZyiHRCSN53GWmLUucaP0UsQL5U6/hN9WA
Date:   Wed, 9 Aug 2023 02:06:03 +0000
Message-ID: <26165261-88ad-eaa6-09cb-916b67853ff6@nvidia.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-3-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5744:EE_
x-ms-office365-filtering-correlation-id: 0dca42d7-babb-449c-feb5-08db987d2f9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBwjRadzYsHiD5lDSniC/KJZQxVCr+qparDj80dpgRpaFHI7r/0PaSu4A17d4A3hMSVkZgAtPOQSJKvl+U76IwaN8lMgsQrY1lyPRfEcKaVieAc9NFR7+QaRA3WPvgxseOSLpGYYj3XFsieKMJ26eX1NSH9K2Q0zC5jc97rTp7dQYMRIk9VmHLgkzUvLfPkm3L7GP1bpMVNAA7sMTqIJyHQgQgPs5W6BzIo0boFEQWyYm2PHIy56F+t0GziiIgOF7uP5+UoxBJLWwREqmYhhAODoSwSpaQNy4r2d0RYDZix7rjraDO7s3bSKd6aU6C37Txn2Aaple4GoxlOrDHFZyRAIOFRGxyWl6+XoZ7vqiyIqDq8vkF99hDqnt6tY1VFsMchDn3kVpucJx6uqWJFYwe54WFQEbOKomySwMlql69pDhM4W1OxgbIbARLu/4bnxPEAm8vk6h5TaDhQ1YSk3j8bckCQlupPBx7jhw7d1yvmLnIaVHxnnAtUInXts4dzfHqE1cDQQq0uSaEaKzvAjlbxdd2uqv4XUKX58q9WzmupGLY1+Mdj9dIsGkBP2GlDwDNV7+dKSq74Mt4BFHa5WcX/tP6Qpz34XOTJUSoFjsB/VamL5qZHAa5KCHeAEXlmwUgylcQvVRiuX9ExNhI4ocDE/pueb09Wv4QkSNvCsI+LCSEf1px9TOWYfpvNI+2fi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(1800799006)(186006)(451199021)(8936002)(53546011)(26005)(6506007)(8676002)(38070700005)(5660300002)(66446008)(64756008)(66476007)(66556008)(122000001)(66946007)(478600001)(38100700002)(36756003)(110136005)(91956017)(76116006)(6486002)(6512007)(316002)(41300700001)(71200400001)(2616005)(4744005)(31696002)(83380400001)(31686004)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVlQZ251VURjSzhIVGRoNHVjaHBFUkxGdVh3clVIOWZHSDVidDY4ek9pcmdR?=
 =?utf-8?B?RVNsQnU0YkVrL1ZramNkaFF5U01FVytkTjJUc2tOZVpuS3BEbnFGcDdUR0tV?=
 =?utf-8?B?eHBucTc0ZkY1RDVGYU9ONXpUV0RCWXNtbFNNOVFxNGxXeXhVRFd0bENhdHZ0?=
 =?utf-8?B?clZTR2IrdjhPcnRIekpLMmR0VlBJeGNIUm05OFFDMjNmSzc1d1JiTlVqa0ZV?=
 =?utf-8?B?N0o4cVpFN2lNOGl3RS9iWHg1YmZWZC9DUlRxM3cxODBBMWFVL3llVmFXWFln?=
 =?utf-8?B?bzdkUm0xanhUWEJTL1BQcTNKVHlIbGpJbkI2NW5rMU5VQTgvdG9kTktwTHd4?=
 =?utf-8?B?SjVlbWdBNzhhUG1OL29HU3NqL1ZVcTlzWm5nMmN6ODg5K2FxVlB5ZDRObTRL?=
 =?utf-8?B?TUNzVFNTbHFuTlFBY0N2RWVFdHMxT2hyU0RVTGF5N0JvbWF2Y3pKNUpVRnFJ?=
 =?utf-8?B?N083OWppSUlzZE1Fa3FjZi9UK3JGRHI5WG1IdWRLdHV4UHNKcERtdGx2dDRp?=
 =?utf-8?B?dTVhcitFTmsybXpCMEZoMUV1WHFCcUJJUm5jSFhPcnFZb3Ztb2VoRm9zck1R?=
 =?utf-8?B?MEhQdHZiZ0FvTXkzNHcyV1o0ZXFUTUgwSzluV0M4WE05UXhjZ2F4NFI3T0Zx?=
 =?utf-8?B?SHBjMnNoZDNWT3YzM0xwRXZXbWZ3VkxBNWJLUk82TnpBTGIybGdZSnJSTzdz?=
 =?utf-8?B?bmZCWGxuRm9hYVYzL3ByZ2lQaHI3UnZ5aTNTQUJZQklUUVFnc3hvQkM2aHhu?=
 =?utf-8?B?b0U0L1dISFFmQ1A0dzJ2ZHdNSjRUZVV5bDczQzhMRXI0OU42VmJZdzZzUERl?=
 =?utf-8?B?Y1lTM3RSRE1DUFBzamltem9NTEdyZVE3bUZwOFoyNnhLRkhDWUpwemxzMGVt?=
 =?utf-8?B?THZXYUN0cUM3bnQ4a29BMU11S1R3bjNIb3RKcnY0ektnSW8yNS93eTIwQ3Fz?=
 =?utf-8?B?V3RtTVljbTJ6MStSL1hxbTlLQVBwemdDUjB6L2QrTCs5d3VyR3NLd0JOdHNj?=
 =?utf-8?B?MzBVQU95a2ZRUmJPcjZuVG5DL1VYTzY3NEwrL2ErdGozV1p2bzlPVUhIOW5Q?=
 =?utf-8?B?Z2hXTm4xSkYxclU5NytxN2xEODRqZFBPd0JrNEp5S0cvN2UzeTRVdkNvWU9R?=
 =?utf-8?B?RmJvNmo3N0U0NDYvWEJxbmdIamtNWU01MFQ2Zm1ZK2ZGM2R0bGpyTkFGYlBi?=
 =?utf-8?B?ZkVpVjJ5REFQTFBoVDBOMWZ3VkdVTXM2RFVsbFlUa1hFY0ltSGhEVlZjdVov?=
 =?utf-8?B?aTFwYWdUNElNd2x0NW9KZDVQQlA3cjNtcmcxRlZjb05UaFdWUFNkbW85dWM3?=
 =?utf-8?B?T1o5TkVHdjBhYyt4aDRab2pkMjV3VDlsVlkzL2lZeW9sWXREa0xxSEpJVFpW?=
 =?utf-8?B?Ujl1eU9TN2taM1kxMDA4UC9qUXdiYWZySzhPZjFCcS9Tcy9CYmJjS01ORmtQ?=
 =?utf-8?B?WUEvcWljd2dYWEVlUS9XZEd4Y28wbkZweXlrd2tvL1BuTW02cE16eXlYUUhr?=
 =?utf-8?B?UzRNM1Q0MnVuQVM0Q1U0Z1l0TUl5WjN3SFVjaDY3N1pGTWRMT2J2MW43a09I?=
 =?utf-8?B?S3JEaEJqSHQwOVdYalJaRER1UTNyNlpkTVoyTDVnb3BKTE0wVmM5Vk91ZWpU?=
 =?utf-8?B?cENyMHVYWGIwSjdQUkh2V3g0MEtjcXVjM0NDcldJT095UVQrdUhiVTNxWDVi?=
 =?utf-8?B?WW5qZTBtYWxsMXU2Z1Bzb3lDM1BycWpuWWhyaUxTVHVJeE9sTUs2MkIvUW81?=
 =?utf-8?B?dzg3SEQzUnRYdmJNQkJKbm15aCtaNW11cUdvSUZ2ampBSXFnM0NYaDgxRG53?=
 =?utf-8?B?ZG5FOFRLR1hRS1hkei9zdGlMYk16VXNLSlhnOFZXRWFJZkszTERBT1dLMG1h?=
 =?utf-8?B?NlVCVmNVblZPdkU3VjNHQ0dKUGlrVVliNWhtT0JtSEloRGN2MjFYZkl1UExr?=
 =?utf-8?B?RGpZdWh5d0owNllnK0RBTGE1NU1mUHc1VjRUVk85ZEZFaE1nY2xNN2tYZjNW?=
 =?utf-8?B?aG4ydDdyc2N5RHdvSU5nTDRMU3VDVDh5UitwRDcvNXV6SDRaeHcrdEE3NW1y?=
 =?utf-8?B?UExKMnhNb09pL0NvcUhYS29OWHNsTTd0S0FXY2JFRWw3bGJDU3FaRWZwUWJR?=
 =?utf-8?Q?SyO7l16j3GaclEBwB2IHNUHxC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9FBFB037D70EB47BDB735808EB3D3C8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dca42d7-babb-449c-feb5-08db987d2f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:06:03.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H96j2N6jSnfRC2Yw35/Rob/nyDEefS8aI9kLVIhQDCUCq+dzqXnMOIvgw2j+SkfKS+Yem/kpSxTNwmASkymuzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC84LzIwMjMgNjo1NiBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFJlcGxhY2UgdGhl
IHJlbWFpbmluZyBjYWxscyB0byBwcmludGsoKSBpbiB0aGUgYmxvY2sgbGF5ZXIgY29yZSBjb2Rl
DQo+IHdpdGggdGhlIGVxdWl2YWxlbnQgcHJfaW5mbygpLCBwcl9lcnIoKSBldGMgY2FsbHMuIFRo
ZSBlYXJseSBibG9jaw0KPiBkZXZpY2UgbG9va3VwIGNvZGUgaW4gZWFybHktbG9va3VwLmMgaXMg
bGVmdCB1bnRvdWNoZWQgYW5kIGNvbnRpbnVlcw0KPiB1c2luZyByYXcgcHJpbnRrKCkgY2FsbHMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3Jn
Pg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==
