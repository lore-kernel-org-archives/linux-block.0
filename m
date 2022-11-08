Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895EDC4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 03:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiKHDrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiKHDrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 22:47:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399C2DA8D
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 19:47:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyPHFUQ1YPy9S9fy77EXpdTNmEa5P6KrWDqWq7CGxa6Dl7yucksuWM13RZfIRQEwN9XB1CsLAU4DPX3IE1X+aub7BRMKUnTEHk3fJ4kj1+TiYWK7pNxJpXixus+SMctaZv4grLs5WiOYIt2F97g+Al49F0ToFVN2IDDpBfRCYc6HP5+3PGb8N8U/UUDDtcDhLExdKlh1ftGfIV1Lp+qJSOiCpu9qtAnuQjvdQDWTNir2vYUWvBCkqy3F8D5f5ZtFoxtBUo3v9BuKn5DdlEPF4ZZQT/zgcszpbkIEe2UswD58p1R40pYgpI1vm5HdOHwedagZhaM2tWxxhk3l2OuICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwIn6aA+WD9mG/LofICI8WQ5b9Bu4qb5Tkp72gAlbDg=;
 b=mjCMznLzdIaOwaJqHvf+SvLN5ibtMivA1uJOOoeHpOj48fM53sxxvhao6S6mNeu9FxLIzMsLn7esJaiTAoDjPOqpCw1au/PZGyPMjGtFhkqWRIhahjYoNue1kFZSQw/BNLY7oJZY2VujbMeAOowrWNT8xFnT88Y8dT19UpaMuU/18xWiyKU02ouuqQu+05gM039ZRR2xhPVm0WnKQRtx0NWOfNyJprO/PAYg4shWBXVIWGvSuK+8oSsSIu5Tb4qDGPBCRNiXI+bwDS6YFE34SNqnzM70MW33CZSGkk1fTdrBeDe8cE+I1lrJXqVGQ5lCcjjKfK6brIutapmoPH0edQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwIn6aA+WD9mG/LofICI8WQ5b9Bu4qb5Tkp72gAlbDg=;
 b=R1EHzlgucCgwP1241mO2WRKTDoeWOLpWV2PFB+8IhT2mGU4NMktNQdWH9g14k2hcomUsRZ3m09wagoJ/AcBNYsiIIwrMtbdR7EErlI3wlPcICpGinOxyuNjpSUhpfXrJD6/2Ou/K5Z3soHE1r0Kdf9xGR2aEHFQEPddntxmzetvs2q3G6nBkVruePhdQ4Zy3fNjOaeBuPuiM18vBiEkTOBn783XbDnNMw7JSerdFQ2XIibz+jYGE/vQBax8uH+TglPo93q/N0g5fE0Zh8XyLJ+/b0+FnVHiabr1z72wQCEumMWIfd0XtaTFAVDnw3qRvwMfOQQiv6zuM8FL0NVQSWQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 8 Nov
 2022 03:47:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 03:47:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: remove blk_mq_alloc_tag_set_tags
Thread-Topic: [PATCH] blk-mq: remove blk_mq_alloc_tag_set_tags
Thread-Index: AQHY8nCXH7r07p/oZki6E+Fi8Hvzr640ZMmA
Date:   Tue, 8 Nov 2022 03:47:33 +0000
Message-ID: <dd84fcba-0e2f-cd24-b019-028fe7c1be4e@nvidia.com>
References: <20221107061706.1269999-1-hch@lst.de>
In-Reply-To: <20221107061706.1269999-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5974:EE_
x-ms-office365-filtering-correlation-id: e008b83e-0b2c-4a60-c0a1-08dac13bf804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vVKUj7gv1CfccyvVlyy5nebWWinRyfqzmz2X39R9lLBSt/WLSHX/SPA0GsECWQFBwKTwFG/kK20EpVPOtAyA4kTqFKbtTOF0K2kaxzfRhZ6oouHZ0jyuAW58OD+7O0ySQZPu82djA5ppjpIlFnF8y0JOZkG5wd0przO3E4MtVUQpLyR/ltqzoTWzeAEuWWNARybD8cdn6LTjm7R/qt6jeUJyOSNtTkGGdebmmlUD428t0IvLWP3D5aXdswN+G1SgIJ4n/i/BZD8t41SJEIrAQ5yzHWAmb2/VMVJlmqEtWZE/RKGhw1vErfPjgGcJMXAw3n7sFSdrGs7JstVUO/zW8Gka5zO9K2s3jUfW/xqcf2EWT72nIx+6a/NBoUGQuPe1VDRiiQoz0R1s7fbOt1ogM9eBIUMMBX+N2y0M5w0eUL09TT8sBCPNGCcErqgLI7np3sk0dH11TD0q8Mr697rBGGjWc9OrDq/XArvmGavJYP6AwBBHGOR5BEbB4JyC1f7ZkxSQd8XrSv00nay4J7b9tcWidaKQF9fAbGZB7tRi3QtNyfCeEqXcJGhDvnP08+cdQVDjre4Ukni9S5bvo19nxZfn/Np/bCtpxGEpqT4Htp1QxLP8dMw1w+Ro+CUeDgMDQ+ZBi/vs5DGvG5eq6FiRjHvpoKvpC5bkIq6JnvcbE5FbtDBBBskVSzuxGiHMvLy1VDEyVGXNumx2a7EivP/lux5Z8wg0qQ6oWXopYBqWhsWhCeuoJWSum9q3A8jSfAQo6HgxJnGCbZte5WH6sDxI1DmNYfqtUp0cGWugI8mVi+1G5o/Gfyt8tEKJoCuRPI+LzLyVhhL5+ecc5RYELuqeXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(2616005)(6506007)(64756008)(186003)(4744005)(2906002)(6512007)(5660300002)(91956017)(53546011)(71200400001)(66476007)(76116006)(8936002)(8676002)(6486002)(41300700001)(4326008)(316002)(66446008)(66946007)(110136005)(83380400001)(66556008)(478600001)(86362001)(36756003)(31686004)(31696002)(38100700002)(122000001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWRFa1R1LzZ0QUgvUjhCSjNWVWpQWkx6SXRjVmhiamdsb1Iwc1RQQStpbGE0?=
 =?utf-8?B?QmZZaTI2QUF0TGVVb0F1UkFBUmdKZGI3WmxidkRxS2hYN3dlSGEwbC9pZFZo?=
 =?utf-8?B?SnA3Qzg3dDVVZjhUQ29HdkdVQmlaMzBXOEhrelhNMTBpTVBVZlQwSDlWSy9D?=
 =?utf-8?B?a3dJSG9wQ1NqU1lxcndHODIvL2ptYWU1bllSeXgxa1lpWE9BY0NHNmpxLzVw?=
 =?utf-8?B?TEhYZy82RThEL25QbmprS2lMVGFtdWk5amY2VE5NVmdjNVdHQjU1RCt1TVhr?=
 =?utf-8?B?R05xMGJPNko2UnNzdDIvSU5pTzFSL2VZMG93TUtNTk44cjl6Y0ZJTzFISEZQ?=
 =?utf-8?B?QkRYR2VzSmNJbHlHSFF4UzhLczc3Nyt2a3ZyVmNHSEJUamFBRDk0Q28zek8z?=
 =?utf-8?B?M0NvcTByVGQ3cWUrUGtsdWhCTmxSeHpQU0NzOEtzcXozdUpUOEZ6ZE9JV2lS?=
 =?utf-8?B?a1VoTWJqRzFudUhYZlBaRTlJMDQ5SGJvWlFaWU5ldEhsaFBzM2xvZjUrMzJx?=
 =?utf-8?B?c1h3SUh0dHlHMGxSbFliZFlTTE9KaXhZMnBZeGZEVmRWN1ZhSzBNL2t2WkJM?=
 =?utf-8?B?eHhNLzZydDVyQmNPS3NVaVc1akVlZHFMQzh5bDZGYkpTT09ZK1llZC9Ha0Qy?=
 =?utf-8?B?VE1aUzhoNlBIVVBYR1hqUXFoVnZVWUMrSUdwZFptMHoxNUI1NGFYYzZrd25w?=
 =?utf-8?B?aTVKSDdFTnlodG5nYlRBeUY1VkNhaW5DanFKN3IzYjR4UGVHTDF2ZENCT3JC?=
 =?utf-8?B?TWhYTGdRQUdLR3JpQk5xTzNPZzBERUlyVjFXNXFSU3NzZlM3NWpRWGFYSkdD?=
 =?utf-8?B?WnpJN1dpTXhzTFd2MUlOaGE1SzNtcjIwWjNEZUxNeTBlcmRDTUZPQ1dsY3oy?=
 =?utf-8?B?bmljN1BRNDhleE4xVExsd3hkMzdnUEtqY3F4QVhhSGpoQkVJbTN0SmVZSXJn?=
 =?utf-8?B?Nk5tUjAzZ05MWU40bTFscmZkdkgyQmhYYlJnOHovaGtjQS8vdVgzTGcwNkUw?=
 =?utf-8?B?elBrTWNORHR3eGN3Q0tnTXJpeXMzamZOd3I4b3BKc0YwVjJYQlBPUnVCT244?=
 =?utf-8?B?WlVpS0Y0S2Qya1FJeklrMnJuNlRUYVBkcjJqamhsSGo5VGl1TjBGaDZBOGsx?=
 =?utf-8?B?U2VxYThNNzQzY1JDMFR6ZWNPZTFuQklObVdhZHk4QTM1QVkydjVybjVodlhJ?=
 =?utf-8?B?eW5xVGpiYTBuSzB5OU5VS2dPdXFVeVNhQ0l6ZnY5Nm5CbnByZHB0bzFnQXJG?=
 =?utf-8?B?T0FQcWJ3dUdVRDlnL3dtSGt5cDFsMU9KcmIvWmQ0Z3N4S3QwZzNrSEQ0eC90?=
 =?utf-8?B?YUovU002MUFPR0ZBV3V4ZmR5MkdFM3kvc3ROUUxRakpWNnJrK1d3TTBlWlV4?=
 =?utf-8?B?MEh6TkpZWUVrMUFFaVRPWDkzOTFVM1RZcjltY0N2L1Arek01Z0ZSYm1PWFJ5?=
 =?utf-8?B?NnozYzUvMU51N25xbXAzay9xc1Q5RDExbFZ6QW5OK3NKNHUrSzZnSUI5YTkx?=
 =?utf-8?B?N0dQTFZjTUtNVDc3USt5QWpiMHNWRkZKUXhLSHNaUnVwWjJPMGE3OS96Q3lN?=
 =?utf-8?B?RkZVZFVkWGZKeTRhYWw0MG1zZlo3TDJhaTZWb3gxV3NhQ2g3VWNuZGI3K09Q?=
 =?utf-8?B?cFEySlJLeitpUnpGbGR5N3N1ZFRRWmRKS3FHNlVRS1VqcUdJS1VtYklGSVoz?=
 =?utf-8?B?WUI3YVlscVh1YXBOOUw2WUZqR2VqK1R4Sjl6NTB1YXZ3OEVnNWFnUHFiRHFE?=
 =?utf-8?B?aEF0ajBJK2Y5ZCs3RWJmMkoxeU0yZnM1dTlGdW5CZTlFeG1pVkdZczY5SnFW?=
 =?utf-8?B?ZkZGb1l0ZHlYN1FGMmtKL1liZ1IwajMwLy9jRnFJTDM2NnYxVkdQbHBHM0FF?=
 =?utf-8?B?N1d0aUN0Q1VqVDRnQlNMWHVVMmMvTGdIR2hFY05Pajl2Z3ZZVjNVRmRxYjhy?=
 =?utf-8?B?SUJlNGxnbko1SFQwaE0veEJrQzFlUFJyYzJJby9Ncy9yNE00WEVvWGxMOWVN?=
 =?utf-8?B?bTRjcnZsOUE2Y1lVaEZxTzEvcGo3RmJuSmtUVnMzUkN0RHc5ZlpQWllWOS9o?=
 =?utf-8?B?MzRLemFmQmQvK2FEUmZNSGNvdHptNVRPQzBkVnRrRWcxRTN1SHUrSUZlN2dq?=
 =?utf-8?B?Y3A3TnJkc243RnBsbmFzby9DcXZBT05mWXJGNHJqWUNpVmpQZmVsL01ncGQ1?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E353042F1F5AF54EA8146C445B28FE16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e008b83e-0b2c-4a60-c0a1-08dac13bf804
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 03:47:33.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3Ws24rRARNQoLKfcZ2V/lkqIvayg0MGcDlHfsToqaYb/wmdrBHVuNkmqwRzSxlBZuBklgxoKeAERw2bpeypug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMiAyMjoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoaXMgaXMgYSB0
cml2aWFsIHdyYXBwZXIgd2l0aCBhIHNpbmdsZSBjYWxsZXIsIHNvIHJlbW92ZSBpdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCj4g
ICBibG9jay9ibGstbXEuYyB8IDggKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KDQpJIHRob3VnaHQgb2YgaXQgd2hlbiBkb2lu
ZyBibGtfbXFfaW5pdF9hbGxvY190YWdfc2V0KCkgUkZDIDopLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQo=
