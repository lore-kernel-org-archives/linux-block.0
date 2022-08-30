Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED82ECAAD4
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 13:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiH3NEJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiH3NEI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 09:04:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB57F0B3
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j94f9a7ZH4yF7vOu+1vRbmYpPPA/O6zRscIgCgmTOfS47lGkXNdyblkTZ2vgDz0ApqzRO9WYr7za0Pq+ypgHXjSMnQH6Dq+Po9Bj1I4eFLi9/GUC8Pw1q82TD1iWrQ5Kr9unRcZWpXKV93kQSvcfvE9m+hRm8KIY2xb4puiTGEBLmMlc/FPe4wOusaMn0otgAOmP6WNMpTcpK8LwcBxYUSE/3BK2ryV3vpR3IzG6IORsoEvaaWt6UhkT3k85I9I5kQUA1vmTceAZ8IV3bhk24xLjvItTd+bvo/3Eqz2C06y1rX0OyI6Qcc0q0Bzw2okuqyajO+RG88Z7tMkliEHoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0H3mvE2pgp5REeqAZQYotBOUwz3x0Dtt439BHBZ29g=;
 b=h+b2vmeHNy5ImwMzel4Kjn42G2Jgf0CJfrjVR5o5IeNStzo1/IfG4bzbkguZB4l2U4LbU6+XMKU/2oIbp4Ov3AtXBxUxcybPUaLgfzG8OLSt9DUVZWCaaN6dcuDZ9U9U3tDR9q8BRKNBr555p07p6Tan81ogMn+4l8xze67l7zg1VKqPcsco1JqrfMjKAyqppIFo3OZXGCrWwg7zB6juLvMJJHueI0xXVPBpAIbLZw0Ikx+pww14gC2FeBN0K7xCIeiYAHNswED1Pz/uL2mLBE6QvC8qAxvQ6MJSL8/tWYViCN4+RP/yO+8DfK0biDoKmoHsfgWUssP8CiuG4UpraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0H3mvE2pgp5REeqAZQYotBOUwz3x0Dtt439BHBZ29g=;
 b=YdWYhv/D8/C89kQkCT0bVPkkmRr/EO5p1NPUi/VWR3/wKMWFlDjUjDEGYjrxIkJfqOm7LSXMfpIycxzsL7uRLIJoKxzGDBKNlxj6grQtAWxOKi3vfuGY4I+RdhwvN+2xr3Ls3Yqu/u9VkVIPW/lrfe5CN3NkdA9+XZNc1MVelJjJWeTBameCaapBNgztKL07LFR5cVrzYb34EDCSDyqZ18j49TMyXwKVZkNFilMYGk3EabRnPDswkBTuvKxYr4e5euqVbtZwDcDCZc3xvRfME2p9xZtAvpyI0Fek4SWm9mQ/QRWO7xNnX9rVGoboG4Psn47DLDJp8X5ewJaUm0Xyjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 13:04:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 13:04:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] rnbd-srv: make process_msg_close returns void
Thread-Topic: [PATCH 2/3] rnbd-srv: make process_msg_close returns void
Thread-Index: AQHYvG2ehGxjP46ID0qVa35/1WeLeK3HaRmA
Date:   Tue, 30 Aug 2022 13:04:03 +0000
Message-ID: <15af8597-a81d-f1db-6d79-ab07f7b3b2e6@nvidia.com>
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
 <20220830123904.26671-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220830123904.26671-3-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d606d802-6dd3-4739-8f88-08da8a881d40
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4KZpqGur3Ig7k7MYo+mZOnHW4C++5zye7yY5Y3GcZ8ZTch/bUERPWscV+PR8qOcc1mGDv5NZCmPGSoKze2pMEPgcSZCmnmqgKcZlih3O8+/IB5AKiTVnozpUPlfp+B1v1J8VAaaX+Wsa/QfjyWksauY4JToICkxsNlH/Wv5q2xVfEgku/sGzihp+hAfgBIEFJ+0JxkoNgAc+WMy/e9ijHbbzCMEvCMz7xROLBF579NYrLoj0iHDvK3Yg7fSud2CRy8+aOHz0gp5V6eGCfqhGBF0d0vGRjuMxROVTSBrqEMhyw241hlz3NiQFmMh5MZyxvPAXaU2oC1McQmpoggWiM80Qgis6jO+AhdqORhlKkCDxKgvyhgElMkuDyb5P3kJJ5DLPwPYtme1Jasr6H6v5lKkUjNJ2kJDSnWWIwAp3JaMzlShsGSWV0OLW30/2EJKiWpZr+xNFHiL4Myse5+Ydb+wKSlMOj3xmRP1FDbyX9l1eSzfu4wnu2U7b0Uos3k7wOGO4JI5F/HYViqNUfbd0xNVmkeROqUDWyP+ELS0CUnNK7TX259pyurV+ZVr8XsrcnlWVliSg4YZsfL9xW4odMFIwX5PALcuMtt55T9+0JVvzEO2Wjo1pgmtEo4iMUpOY/oWQgiIiyGi3+mG0Vk+Lokbh9uq2P6uiM3wJMSezhQru1yj7n9CoQfsYEN8mbwu37UXgnZQXrdKohnRbl0o98SlDfTZ5PGpLOQRPTBUipCVKCXcUjRQXLDIlVdv8ehBb/e6wmy8cTpFPCbQzAcyc/ofnqaeT3wdsOiFjHlYctMDQi891+aDcHUdRG4ekwsJJq8/4zAPWCMwEjJscpfgX5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(186003)(316002)(8676002)(6486002)(31686004)(110136005)(71200400001)(86362001)(66946007)(66476007)(4326008)(91956017)(31696002)(66556008)(76116006)(64756008)(66446008)(5660300002)(478600001)(36756003)(8936002)(38070700005)(41300700001)(2616005)(6506007)(122000001)(2906002)(38100700002)(558084003)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekZSRFYxR1hEa1NxT3NhR0xaZmt4d0JndEpmTXg0VWRNYzFYWFJNMWNndFZx?=
 =?utf-8?B?VkxUa0NZMS9YeTdCNDl5cFptVml1Z1p3NVlOalRCS3huaC9JL3plRnNxWkhO?=
 =?utf-8?B?UnJuZDBRRTJMSjNuMUtXR1ZWSU9RNUtJaklkSlozV2l0ZjVaUFlYb3lOR01n?=
 =?utf-8?B?OWs3cVkvZDBOcUNyNkFLOUUvbFBnY3hXMlVjS0V5NjJqMm5pUmZWNHozb0lw?=
 =?utf-8?B?TTdrWlpWL0NMbkpwY1hnbTNYTGhzM3JRdlZSWVRWTjVKNitzSUVxdTRSTEVS?=
 =?utf-8?B?ZXZQbzQyd0pJa29HS1ZDa3UrWlFSYmhSYWRWN05icWRXWnFFa1JEU05yMUxW?=
 =?utf-8?B?dytpc0padmREM2FUbUdEVkl4Y204a2psMlF6MkRpaGlpVkwxVmo2eE4yT3lN?=
 =?utf-8?B?TU5tbjRtUXhzUmt3Tlo0aE1YUDFkZFVtRDFrRzZCMHQ2bU5XaStxL2pCL3l6?=
 =?utf-8?B?aUE3V1MyWjI1aitJbVlmMnJHMU5qNjdXRmg5YlZwdi9vdnIwV20razk4VnV3?=
 =?utf-8?B?djBGV2l1NlpkR21KWlFST3ZoZHM4dHRUZ2Y5VU8rdllXbVRXbzE0VFFhZnM2?=
 =?utf-8?B?Z2x2Q1ovcHBvM1l6U1NIdks2QUlFUUw5YzBaMUZZc081SkcrUFIrbGh4c2tz?=
 =?utf-8?B?eCt2S094N3FHOXFvbTBpWG5EdWFCYzdpYUF4cEJuOEttVG80dTdjWnY5NXVp?=
 =?utf-8?B?UGlGZU9MU2tGMkkyNUorN1ZzQUI0MVBGK1BCa0dha3Zid2c3a3BKRmNub1Bq?=
 =?utf-8?B?NFVZNXZyamM0WVc0aGs5Nng4Q3g2ZGVPU0Y0cWd1em8zM21DcURvcGtBdUUr?=
 =?utf-8?B?MHc4OC9QUGVDd1Npb2tZcmk2M2tnS2lETC9XT2tyNThLMUU0TjRmU3NlMGNN?=
 =?utf-8?B?dHora3hucXFTUEN6M3doSXVUTnIrK2lZZ0IyQWYwOUNtMXR4SjBiYUtxeGRa?=
 =?utf-8?B?OTZNbUlTNzVyUm1BbE5DTWI4bkliMC9BMEtWWlJ1N0MyanVMK2VTWUJRcFRy?=
 =?utf-8?B?bjFDNGVkb3RwaG51Wk5hUEIraDkvbnArSFlDWTNCKzMxeDNXRWc4V0RiNUlY?=
 =?utf-8?B?OE5kdXhVNWhKZEQ4WURreEhZM2dMZ05uZjl1eWRMUCs0SURyWEg5ZzBkb1hV?=
 =?utf-8?B?T3RHOU0vVTFldm1DWTBZT1djZXVqcXZFWUI4amRLTEhSc2V1SDJyd3lkcXRh?=
 =?utf-8?B?VHk0MlVEMnlhQWs2aEhKdGxZZ1Vzd0c2R0YreHp5bVhNTklOQi9pKzFXbGNr?=
 =?utf-8?B?dFprZ0wvTmhReDhFT3VIZWVONXRDcmxDNnIwSHBGa3J1MXpKbWVaNVlERVox?=
 =?utf-8?B?Qlg4ektnL1VpSE81bDVrVlZvWWRGY0VNekhYSm02QjhtWkl1WnltaUJQMGhn?=
 =?utf-8?B?d0doK0xKbTJncVNPS1NRWjV3Zm93OHE2R2s1SnV0UnN5M3c3dEpvdXBqYkVS?=
 =?utf-8?B?UTM3cnFiYjZ4S3djMXRST2RML3Q5dXdXeFA1K0QyYU5qUTJNdmFVc1VMcHF4?=
 =?utf-8?B?WXc3ekZmRlNSUEk5S0FYdGl0MWE3Tm1iajRTRGVhbFRnNVo5dUlzL21mNXd3?=
 =?utf-8?B?ZWduQU5VOXVZdWFZY1ozd3M1ZFVsTFFlanVjS2tTeGhUVDlMZ1lwWVVmOE5M?=
 =?utf-8?B?Nmxpek1HM3NScFE0RkV2Q095czZVT3MrWGo4d1d1ZWVNa21hb3RWT3Z5WnFp?=
 =?utf-8?B?OU5saW5BSHdlK2JrdmpEN0NraEh0d1AvbnNad0hqSDErOTNWOElIbGIvaE1S?=
 =?utf-8?B?OXVQblhVU05aUFlMNGg4YjVFYXN3a3JFYTdsaDUwcnpRWWR1b1VTVk1GU250?=
 =?utf-8?B?SS8yR2c0QWpkR2dab1BkdFI3NW9OMHNRcG9ranpLYTFEVU03Zi9zNERGZTI0?=
 =?utf-8?B?cmtNRUtxWWhpQ0hlR3RtNTBIbWhCZVA0R1F4SkhOVW0zM1RrbnJUTEZPcFJJ?=
 =?utf-8?B?TnQ5czVEb2J3Y0llRW1wNWVIeDk0TzNIZHF0UUE2Rjh1d2VicC8vQWxyOE41?=
 =?utf-8?B?ZUI2aWV2YkEzTytRTHdIVmNZZnc4ZVdURk1XNm9OWEs2blJyRnMwZXdQWGdH?=
 =?utf-8?B?cEtMVUFvaUFDbjl1bmwyUkJEdWRPcHlKZmRybFFaM2ZPNkk4d1FVMUcrQ3hs?=
 =?utf-8?B?UHZtYXVhRXZSaEYyckNtMmhndS9mbnVqYzFzeG5CYzhLUUNmTHFRMDNtWDFh?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EEA92781A5A1F49BADC451BEF6C4E57@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d606d802-6dd3-4739-8f88-08da8a881d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 13:04:03.6989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6CvWvggIZLy+n3mXXinfSx960CPgVTahuuS4BqT5p+tNTgiG4l98+E5kRECTTDeIYkwqwKvclHhA2CxoBM/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8zMC8yMiAwNTozOSwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4gQ2hhbmdlIHRoZSByZXR1
cm4gdHlwZSB0byB2b2lkIGdpdmVuIGl0IGFsd2F5cyByZXR1cm5zIDAuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQoN
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCg0K
