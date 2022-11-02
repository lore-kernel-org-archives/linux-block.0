Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B458C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKBB0Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBB0P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:26:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78EA1F9E6
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVFq4omAo5ApweoB5a89JRBy2iy5jS3EKXx4eGTy+tqqc7Fiq4/KipiSsnx0BZULChzCBvYT4xPnbETsoOIztG4NgRf45c1VeysWzrWXZ1dojnZDuiu6r5B/eHbXr6ZKc22/qBkGBQS7rqVn3KVOVjOmaxcKncV9NZjphM40fYm+uMc1/BHQMRIGk45mTERFksbBC9/T3/mnWCjgBCCQOoy7ALPdiB7z45aG+HEkkoBrHUmjHzO072LQbDJTUsP4pYQJFxslS8jkUXVJQsxgmvdxiY/4aH41yPa3249xsA1pfVlBYofDjFCunN3dN5NCa4hrNnxq1v1dpoGYK5pYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ1L3wM5RGLXnMa/he79GnIRoUX2U47Hb3Vh8mo4J1o=;
 b=Wv7ZLHTgboXsvDsQt0a+Aah+F//1ZvtaxbGXeq/Qdpfddo0zdY2EqBc8vcghDOTBzzThTgngK1rtcISf6v4SFxnRUI7BK1SBQlIgX9M7Dj3IzXhkZQN4Q6xpV1GpgFUA9inv3bl6tHKeV/s7ozW7WK+eqDadEQz2Mh+/6gMXcMNVtkzBYt6MXgsWTM34M9wredpBwzWC6SxK8+tZdrQX+PpCv4yvoaufqtAwMC6QSETMvDUJ+Gh6mOKTxJCicsFphGst8h9/Nr3sdyUdJACHeHbcnFshFiOAPaglRY9d1BVjg3nHXOjKREanacmhcoVfqNAA5aS+E8s1oDetB92szA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ1L3wM5RGLXnMa/he79GnIRoUX2U47Hb3Vh8mo4J1o=;
 b=TJ7llCDsxwMRPgVUE2Ul/yBrse6Hd3wn+cYFU5SafF2I+VhRSSWeLNCwKVYaL8XeT+OgQwJlySiJ4C6p5M2VECJsM9Huv7eSreIfZNqmG3C9/cSqS6oPPfxOuXFOkcN/eY/9wnVx+xbrIYwawvjk4P8pEzaYbeRDuJp6LhfPk3zvPHCbHCpkWGuyNwET3aGPvWUyojErTvKAgDxDmXkb9axOWfL7ayK+3l+ux2Ap989rFwNtoAOt7o0TrPNNc9q/cNZZHfi0q08BEBzrDKryDOziut4sceim/V1mAnpf1riVPf6RD3ZMFSDD/fsWQjNW8FR0qT4maKljOnV5JLQ6lg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:26:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:26:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 08/14] nvme-pci: don't unquiesce the I/O queues in
 nvme_remove_dead_ctrl
Thread-Topic: [PATCH 08/14] nvme-pci: don't unquiesce the I/O queues in
 nvme_remove_dead_ctrl
Thread-Index: AQHY7gL1jSMvk/eX4ESM+jk+owLSE64q2CkA
Date:   Wed, 2 Nov 2022 01:26:13 +0000
Message-ID: <953d3a09-c999-45d7-a65f-e6dba7721d8e@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-9-hch@lst.de>
In-Reply-To: <20221101150050.3510-9-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 2d8d9a58-b3b9-494f-e404-08dabc713ad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziEk36Kl3kHndSEyvbYR7/ls+0AYDyhqFh1QutSIrs+emq1MHqDXOOpWZUApOiO4v4/K4HXrp2Puy1wood72ix8iqDoMBkqZ0cW5mU0EBJrIbcGXZwxOc4UwfBRHhkyZ/LXG/iCPNOB7YSFuOHMNTJ0yq5+KR0YeEW3z0Q94GhFBx9QbWSql7MtTp5k6lgEz7ivVI2aCGa1Ps9/yIHfTfTl4Yre0X/0yCz493GAEPj897wIwkYWUL3SUIsTlKeswgOq0h2JtTOdJQznZK3Y+Ge8UPBNoWcHeWVGXQYGqBo47CWpFDxQl1YpT49gb6Tug5KW7Re8yy3xH9hYucEgkLvi6SndwxXx61QlcfG+9UOqzrTKCq3oR5oML7AWkdQlus4yC6m2HaDiFNWuBVgnq17jbfWMTWWk/m75GgtXVBacd/oChFrLTGkEh61FcXrpg2ceR6HyZN9HhjM3ISIUZFtoiEq7QklZwyHHleKZQnaTC8qG3wZCvM/BBpb10a22HbBhbbNSGS5/T7d1zGCCBd49po0N9uWZVkz6paXo1LMgMSHkcqJe1xHkYU3zG8Ooxw04uDixidj3MGpGOp4KRd2/t/UT9GmscHK7OmiGmbk40NXkbNuaYht8wIQakYafC7OhXkRlrEzejdYwFz+i7tkM/hrab2ws1+hU+TqY+i7r5U/JjVmyUfv/zq31q53Bse3AivqYPL06ituFbvGrZRIP0nEflzYJtktVW9wxmZKV3HaP9IM7rlgXXPW7boODYw3V70bqhtqgedX2ExdZz69aHud4U4G6v0/pWjgQ3WpH1oxrs7A+6JU5ayH4HpeLs+J6xaHNWMNCEPc7YRmdZYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(110136005)(316002)(36756003)(54906003)(66446008)(66556008)(2906002)(186003)(122000001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(558084003)(5660300002)(66476007)(38070700005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hqSXQ5YnlIY0VkenJ4MEg3UTFMT1pHQVVFc0dqbHJMRXN3dE1qVGg2cGRE?=
 =?utf-8?B?VTdVamVXY0tseTM2NTA0OHlXM3dXbURZZUx1SGszcGJmZDB0Z1RGNEZTOGtm?=
 =?utf-8?B?UkVJdVZHOUdvcmVFNG41bTdkOEJGdHhmTUszOVpCZlRvME5wcDhmN0FaMU9s?=
 =?utf-8?B?c2JGRm9ZTmNqWkE4Wk9PTEllTERJM0FrRFIxcXJORjlWZlR1L3U2dVBFVWtQ?=
 =?utf-8?B?aGNHNXRnL1drYUUrWDM2bnJjeGNBTWRLVUp5VWNWNTJxV1Z0SUtrcHZXY3FY?=
 =?utf-8?B?RFo0dEQ0TUwrMXA1d0JRSWxzVGRHYTJTN3ZseHcrUm10RnNWSGtrVTBpWlNV?=
 =?utf-8?B?YXZBWlc1dGpEeTRrS2lxOEJBSVZHMlNtNUpZMFNQQnlaYm1RVmRMbmlPaTZY?=
 =?utf-8?B?RVN6emdJNHNMdnNlekdkTjFidVJmbjRpSXFMT1pjaU5PcjJLam9XVnRzNEFS?=
 =?utf-8?B?SjI5QWRFSUNDNjkxV1dSUEVuaE5XZFd3Z0VGeFh5OUhSL1VnR3ZGcWQ3YVYy?=
 =?utf-8?B?TXgyWm1wRldCUmJQQjYzdzQ4ZXhrMVVFK1ZSdTE5OWdrMi9paS9NSWQzaHBV?=
 =?utf-8?B?Q2l5TGJ4Z2N5Y2NUVHZENTZndG15U0V4STBjazBlekkrQXB0QnpEbEhtb21T?=
 =?utf-8?B?N2RkeDVON05JMTFRWWlwSmlUSVFEbG94UmtuS2JmQWlONHVjaTRyQ3M2eXRs?=
 =?utf-8?B?TWRPa0xidVV0emZLSHBWZVFmNDZrR21yYTBReTNKV1RFN2VLNm9wZkJHRk5r?=
 =?utf-8?B?MnVoUGlCaWs3SkhydENjV2s4UDlMV0FuUEkwbGFIRVBlSTNWbElEdllQenZk?=
 =?utf-8?B?OU8xbmh0dldteHJBSXpRT212RlkzWTlZMFRiRGlyODhtcDFqMTBEbXZaOXhO?=
 =?utf-8?B?dUo5MVR6d3hBMEJWWEk5Q2lOVTBwUUVqYmlyMnRhb2U0RitObkExQnRVYk9k?=
 =?utf-8?B?S0tZdlNCNEg1MDNGbW8xY0h1MDRKcjFaNUgyNUlkUFFtOU9VTlJpN2lGZXNu?=
 =?utf-8?B?STRpL3hrTXlWdmk5MGtqNzVYeVErRXlPOXRhYXByY0JzZzZIMkJZVlc4RWNS?=
 =?utf-8?B?MjdXN2JJUVNNV01ra3JjRHlGUURlT0FveHJwSVZlMys4eVo5ZEFRT0ZhNTdZ?=
 =?utf-8?B?ZWw0bmgyM280SFY5akVEM2FOa1lYeDIwVCtLWUJ1ZnRNdTMwZGJ4ZTV1Y2tz?=
 =?utf-8?B?Y21RM3liVDZPTlZVNWtQM3NlTmNaajUvd040WkYvN0F4VmNUU3pnb1dLMytS?=
 =?utf-8?B?dFZXT3VkU0VtakNBZ3o4OVJaWFA0ZUpDNzQxWnB5bmdGc2NqdjYwR3c3aEpN?=
 =?utf-8?B?aWc4U09vVVVZN0Z1TWIweDZWaXp0WnJTRDlxYVVLaFFqL2NIMVAwNHJpWjZK?=
 =?utf-8?B?UDVWdHpzd1IzU2MydXFVUVA3L3FOVWRRV0d5dmN2VXFyVkxFbU9URWlmVEky?=
 =?utf-8?B?aG9vdEtNK2lid3AraTdtcFNKRlVtZmgvc2dzZ25zZVVXOGR1TGVWbVZNd0lq?=
 =?utf-8?B?SHAxd0Y1cHFLN2VDNHZmOTRhaXN6ekdiWlp5VC85am9RVUFjclJXeXNaaTBl?=
 =?utf-8?B?ZmlreXdQZDZBRGFwVXo3TFlHVWFmWmpzNlV0dm9LZUVNZjNBOUwydE55K3ZX?=
 =?utf-8?B?ZWFjMElkaTQyNXJxNmRVSGx4RjJzZ0xBK1pXWGlhaTFDOFB2S0VjbUtWUktq?=
 =?utf-8?B?NVAybUR5cHF5b2VjdldyUTkzM0twek9nQS9obGxrZjdlelU2S01NNWJjYzNC?=
 =?utf-8?B?VTRvOFFHVEpzSE5GUGlGOUcrN2J4eFZJYm84U3AxWk4zSk1hekFhT2Jma0h2?=
 =?utf-8?B?N21aZUVXTlBmRFJINzBLazFYNU91NkN0bXdYelYzRVlCdVVDUitqT1I0bnMr?=
 =?utf-8?B?M3FtMVdaMnoxSDluYmlzUTByV0U5U1A1cXV4R0lhTUR3eks3UEdPNzlDK1F3?=
 =?utf-8?B?ZmJMSzhFbHE0RFMwVXkzUXpuWVo1ZnFWSy9yOXp6TzkrWGpnYTB2WVY4QmYv?=
 =?utf-8?B?MUFVbEt3d2FNMm5yZ2QxZ1Y2cDJyYXBja3NCUjcwUjJaZ1JWVjdDMVRUQVpQ?=
 =?utf-8?B?LzdtR0xSNFV3K3BMZzNTYk1yVFQzT1NzQytrNlVHWTZURTJYMWQ2VVUrbElT?=
 =?utf-8?B?V0xUVWNrNGh2c2syYURBT054ejc5L2IxSTVZUjhwTGhzNnJJaG1tYno2aXpF?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60235D42AE196C429041A51BB029F5CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8d9a58-b3b9-494f-e404-08dabc713ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:26:13.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNTLJNFSlFZMp9RxjXRQItazqFFWhCNFcZmOWTyRHAKZ0f/7Str7W6ep1EvLL/5/6XSh92ZXrq2ehza9Gsz2xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IG52bWVfcmVtb3Zl
X2RlYWRfY3RybCBzY2hlZHVsZXMgbnZtZV9yZW1vdmUgdG8gYmUgY2FsbGVkLCB3aGljaCB3aWxs
DQo+IGNhbGwgbnZtZV9kZXZfZGlzYWJsZSBhbmQgdW5xdWllc2NlIHRoZSBJL08gcXVldWVzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0t
LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
