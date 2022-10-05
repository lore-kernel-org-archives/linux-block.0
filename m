Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB3C4332F
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 19:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiJETB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiJETB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 15:01:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD3E2E9E0
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 12:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAgEsLnBcmCagxqhXF2c3W1YFQnWQgg3HRKTE35GcBoj0gCmdm2D48m3A1wRYpkRH815eaNEw6FcskiY55zb82K9HtwL4VsDCmJg+dAXpYmZmKEOYRHGOlbDtIrdRVTTq29RTLI1aGav+5x2fEvU21OOOcE0Md83UC2QAlzj2NheRjxbEsGj5LcmyJXwMc2jAnr5uNr4X5MfC2VLbUf9bmt0Zuh73v/QAzdFqkZZ0oPxVPCcKhRIZ3drdn3okU3pGYQGmxfproKHdG1uEr+xYPXWd4bBs5Q+RxL2lnLdYbUWvDqqRpklKY7KT0c/cUVtZ29XnMkAYnTNCskrTW0IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXwJ7oQ0dh1M6jhVP5piCoQExwO4JZL8iZj/pAGTz/Y=;
 b=MrjJzLv/Vk0qT6Tnj6N6wbkPpQe2QRIzdTabw1O0li68Kp1WlCfX3IrTjIn/w7tEbdBpyHPl1PAIWGnjTsJpU5zVTXjl/wKkQe/+hzzEhvqtwqpsAjcTm2BhFfyLlSEsfZ8YFgizLh6cv3umKc9mzR921xbSy8MI8S7pG4OlvoBZJDR5HPSAXcZNGAYUEeM7Na8r14HVpEvGAQVBt3f2VFdQRYaO4jh6Dvn4eVV2To1AHyIj1TIsVYDycCSHord1x+vrvI5IdfL7qv5xgSy6O0ZlkoMko+de7n7GAUAMscAq85FQ0KPfi+pTqcOie0DKp5T6Y/PMQbTPAiwKIP9UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXwJ7oQ0dh1M6jhVP5piCoQExwO4JZL8iZj/pAGTz/Y=;
 b=PXTHePwZtDuP6Gr5VdHKC0k4vxF6McU8/SQ01W4E4kzugqLtoWz2osIIQSmkvmug63uoI7uDseMsyF9U5zt+wHOETNd4Vx1KYUKUOsbIWGYTiw3kSJpuiEN6gMiGNc0JcjAju8mrfpsQU2fUn+kbalnic1NIAyp+QH9pp7h5ePYYNcO6L1tySgLgFn6dFSxZ6MRczQgp30mNxywZPcsz8LW7Uc4Xo/eadYFInnRAB0UL6UQtvg4Z51CG9VGpJ7W2pds0312qchAtJT3d1PxRnTxzmOVmU5Q+2Ca4Vm8NbTqDJtKiUHr+5Qjk9HWMJ76pfPCyQ1bgekFw5iq9edESMw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 19:01:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 19:01:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Brian Foster <bfoster@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/6] null_blk: allow write zeores on membacked
Thread-Topic: [PATCH 2/6] null_blk: allow write zeores on membacked
Thread-Index: AQHY2GkFovuCv41QBkqHDwUISksJwK4ADCoAgAAYUQCAAAIvgIAAAmCA
Date:   Wed, 5 Oct 2022 19:01:54 +0000
Message-ID: <a2c2aba3-53db-334b-4997-c45352d2c8d8@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-3-kch@nvidia.com> <Yz28aEOOUqrCUhe2@bfoster>
 <09793b3d-b1f9-9755-f3cc-1f0cfcaeded0@nvidia.com> <Yz3So0+WoFH7e4p3@bfoster>
In-Reply-To: <Yz3So0+WoFH7e4p3@bfoster>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5736:EE_
x-ms-office365-filtering-correlation-id: 73aefc61-18ee-4e61-a773-08daa704119b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9z3DFwKXJPS6ucR49NdeSyjPO53+uRz6MkF8oPQyhKSDBxPHhVqBzjCUD95bHxRcUALDj5eDcKsAuWruq4aPllOtVTwqv8b2AnogSHwgmOwfupcQckiQ+efAtsl8cjW9F+xdscNnT0AfPG14fmcDbduIV7nQJ1Un9o9J7J9AoR3cCYfVJtzW4dLB99K7R8LLB7jwqwdFJWI9J0uzTOAAesBHPGN1XA3VrEw0OX7kLnIzCsJ66ET9WelzErfgNKWLkpDKCh+Th7DU+1gKm0ewgUYOi7vjj5kYN69Sl+gwBhnTJKbr0sf2B09x9h/JTRUNlE2dIPgZFpJBRHWGENCsiId9tPbYm1BRhege/HxZEOnaAapVpPedx8X+ax0XR+nhPd0mizABMcEr8vhzQAecp6nFDUvNU3AxnAjiI2EgNBiSHnlRBgOOwTbs6ghtSnz0ndpn/uC9ko5c7RoVn8Npo+898aPGMgmfZuP+N0the6ZGnLCfeZqaUyBXxufd/K38WbF/+C0qw4QIWPKz267dCdQJKZb8DZDSZGnQmTwdE5FsDX4vmDz08LwjL8OH6e+AIuHOf/0Tza+PR5JcLaR9pw0EbBsRVnb++H6BQHfjAkhBZUUDYmk16g2J2+5VR4LcUhvswLjNe+0euVQ0IfMpekn3CdT0dlvrLZ0Zs4LsyRxhXbyLWT6xYBACN5dLunMpA7+1btzYX8BMg2lVL9qhmXnGLsIEPsotyKoJ+lP1z/ZFeDcRKa4Bs3PhhJDxxefCyCu3NMJYbScVftMNjDUW5JCXnJPR9jEThuJ+3pZIbDBFtbC7LMPQeAqvxJdkkSLe+0JA0CdLMHN+uMNvXUb1Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(66899015)(86362001)(31696002)(7416002)(6512007)(71200400001)(31686004)(5660300002)(6506007)(38070700005)(478600001)(36756003)(6486002)(38100700002)(64756008)(122000001)(66476007)(66556008)(66446008)(2906002)(2616005)(41300700001)(4744005)(8936002)(6916009)(66946007)(186003)(316002)(4326008)(54906003)(76116006)(91956017)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5TVGU1ekZBUEdYZzZPTGg2VTZPdlc5TVNYWklnTjBaU3FQZXFJelFuamlY?=
 =?utf-8?B?VnNXby9IWkpyMG82NkhpYWVibzRZcXJvS2NmaDJrcUNCOExaUjA2QlIva2Ix?=
 =?utf-8?B?VFcxSHl4cFNuclpWNTFSbFBMaHZQUVdZK3NGSHJWMnp5R2RRV3cwcXAzK2JJ?=
 =?utf-8?B?MDVWR3N2bHA2czk2MTVlSVJBMG9qNDk1cU9iZDB3cnB2dC9aWXVMKy8yellv?=
 =?utf-8?B?OFExUzY5cGJJMU5zMTZKSWQzQ1c4RVoweFlZbndTMjhPeEZwT1VwenptT1dH?=
 =?utf-8?B?U2xoQTJOY1FacDFZUGgrTmwrVU0rOUM4dDdzaG50YXNtSlJTTkd6TndaaFhX?=
 =?utf-8?B?L1NhcmV1d1BkbnNCWWQxRVM4OGtQcVpLYy9IUDlpSDNieUkwNjlTeGd1THRC?=
 =?utf-8?B?a2piUFRrY1prcWRmUlVZemN1R1RuY0xiN1AvbVk0ZFhKSjg3ajRHdkhQY2NN?=
 =?utf-8?B?ckZ5ZTIzb1ZCRWZ0Mk5lTXh4cHREeUlPMzJKWVYvVDRicWxrZTV3RkhGRFkw?=
 =?utf-8?B?WGZJeWE4NUI4YTRUZndVL2N6c0k2dG1VSTRTcWpjTEJQelNMY29LWVhmTWlK?=
 =?utf-8?B?S2RVTWZ1Y01vMHhINTEvZ3RJRmRDTmdzYlBQWS96WER3RGh6UVY2dkI0Zmp2?=
 =?utf-8?B?MnkzNmtkOUdGbkNYdFVSNFducGorNkEzUnBsejY4VWplclNPaU1PdUtKTStz?=
 =?utf-8?B?K1pmSEhlaE0rMjdZVnNoaHFCeElZK2hZTGplOFBlMnE1U011dldzVFYzYU1a?=
 =?utf-8?B?WHlIbzJpcEJSUkl4QjVaenhoNEMvQnFzTXhNYUtaWWVxSTh0OW1vRkZTQ3N5?=
 =?utf-8?B?b1BRb3ZZcFdGMDNYdVJyL005RzBQTWJDbUhQbXpzbEdZMzNza0RTcDZiSUVr?=
 =?utf-8?B?WjhMY3VRR1JINnlla0VSZVJ2L3AzTFpxaXV0OWd3aDBwa0lqakRhNjZkdk83?=
 =?utf-8?B?b0Q2dVl1RURWWXBHekFDQkZ5OFNQMU5taG5YMmFZV09TdGVRVURYUWpGak1r?=
 =?utf-8?B?am1DWHFpdTJtL3pjM1Z5a2xVek8vcUFFZlgvRWdYWmtCdUo2L2VmeUJIbWVD?=
 =?utf-8?B?TTZrYWZtdkVnclRRamw0bVo3eGVoNDhnSm12bU1FajMvL0d3eE9NZmd1NDdx?=
 =?utf-8?B?M1lNOE82SkVoN1NPNUJKNlR4TW1RR2FUdmE4L09SUWpKNzM2MXhNdFdvUHJn?=
 =?utf-8?B?RjkzMXJSZEFwQzZjQ2x1c2dVRlN2QUlkcEtieFdNbnpud2xyZzNGK1puSisx?=
 =?utf-8?B?UUpDdG9JMldHUzBmdCtNU0dYWGhHOVZLZXFaTlQ5VzZOVHBlaEg4TndJdUcr?=
 =?utf-8?B?a1Zwd3NJZ2RtcVVnbm1NckMzd2NpUEk1dGRTWVA4bkJ4ZkpMOTlJVG1hd1dL?=
 =?utf-8?B?Y25tclFBYUFoSHhjbnNFNFVpL3Roak40V2FXY0NyN2lkeUJDMnJKaHdZallo?=
 =?utf-8?B?bjFxYlQwMFVlMlBYemgzZ0x5VFRkQWZLLzVjUWRXZUovTjdBTFFDRzFTWU1O?=
 =?utf-8?B?RGtNcDNJRlNRNUF1ZjArRk5GYXBqU29UOUFDb0VSTVBwZGRLTzNZS1RpcU55?=
 =?utf-8?B?dmhOZ1RUSURGdDZ3VDlDS0szZ1pvUFVVcUJqdHVodSt6blRNQlhURFRkTVY2?=
 =?utf-8?B?MlRNTnRsQUpHb2pBdWZRYTJ3VXkxdjVjMk11bERHc0ljN3F3QzFlL1ViNVY4?=
 =?utf-8?B?Sm42OGFYeXJPYzBqK0lzMmZQMXU1WUFsUHhZNUhBY2crcis1VHBzT1RrdHhw?=
 =?utf-8?B?UWpxdnhTQmlnLzRLYXorTUY4R3c3TWl0STJrR1RVMGZtS0pZK2pwQnBIcjhW?=
 =?utf-8?B?ajNOc2x0K2M1cGdFSXNLODk1aGVhWWd0SUd3SVdoU1J3WjQzK2ZEWmt0QWRS?=
 =?utf-8?B?eWx3Rk5LamYrRTlvY0VsQlo1YjE5Z2dPdkd5SDRQVkhMRm5QWjg1azNkWGVl?=
 =?utf-8?B?djN5WjR1ZkJ4bHl5d3B6aUZUMW1pYnFRcnJlRUJRaElSZUVLbzJmcFhyYUFi?=
 =?utf-8?B?LzRLcm1kbUtkdGF2NVFMRjlGc2w0b2JRWDRxdWNuVE51MzU5Rkp4eGJ1eHJV?=
 =?utf-8?B?UmZyT1JBMWZFVnNmTVlVeEFOREdCNk9PLzErVHB1ZVRheTJHdUNYWGh0R3RQ?=
 =?utf-8?B?eS9kMlNqOW1GVU4wNFZURytuSndSOHdjWVZvK0kyNFNzWUx4WW1GNmFSdlNG?=
 =?utf-8?Q?dYytDxNB1JqYC5kebguJTI03C0ELz1UmeZPOEVJt/gYh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B8022EBBB1A8D4093D22EEA9DFD7383@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73aefc61-18ee-4e61-a773-08daa704119b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 19:01:54.3155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EicV00Taz00GG3XMJ5X2wouTrdVDPb3FL6w23jUcdL1e/dQ29s0XaJIhy7bd4nwav0N06k2iaNX2kvJF3Txd6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+Pg0KPj4gSSBrZXB0IHRoZSBzdHlsZSBzaW1pbGFyIHRvIG51bGxfZnJlZV9zZWN0b3IoKSB3
aGVyZSByb290IGlzIGNhbGN1bGF0ZWQNCj4+IGluc2lkZSB0aGUgaGVscGVyIGFjdGluZyBvbiB0
aGUgc2VjdG9yLCBpZiB3ZSBjaGFuZ2UgdGhhdCBmb3INCj4+IG51bGxfemVyb19zZWN0b3IoKSB0
aGVuIEkgdGhpbmsgd2UgbmVlZCB0byBjaGFuZ2UgZm9yIG51bGxfZnJlZV9zZWN0b3IoKQ0KPj4g
Zm9yIGNvbnNpc3RlbmN5LCB1bmxlc3MgeW91IHN0cm9uZ2x5IG9iamVjdCBpdCBmb3Igc29tZSBy
ZWFzb24uDQo+Pg0KPiANCj4gTm9wZSwganVzdCBhIG5pdCB0aGF0IHN0b29kIG91dCB0byBtZSB3
aGVuIHNraW1taW5nIHRoZSBwYXRjaGVzLiBOb3QgYQ0KPiBiaWcgZGVhbCBhdCBhbGwuDQo+IA0K
DQpJdCBpcyBhIHJlYWxseSBnb29kIHBvaW50LCBJJ2xsIHNlbmQgYSBjbGVhbnVwIG9uIHRoZSB0
b3Agb2YgdGhpcyB3aWxsIA0KQ0MgeW91Lg0KDQotY2sNCg0K
