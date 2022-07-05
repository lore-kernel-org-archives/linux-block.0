Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F7DC433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 16:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGEQUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGEQUG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 12:20:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3D1ADB9
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 09:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gntrN6gIvQsXEHH855ves8uwcUTYZPn+GMer3pbPZDgdZE3l4sz95zggl0HhpKgHkvhbFsYkfWqAUQJyEr9kShNwLWTAaOVsvEqnLktfL4ZZpb65GFhIu4iY029H2ujo3aoXit/5LZBskKKaC9+cUpwaBwcl9HC/muGksDk5k9Ls7zH5Sd0XOOfBTDJO0c0WKDg/VDB6PoapZte1+nnT1yJYH8PvP2lucnNy5vEyGBhumqZMALDLK5ESYSMUuzuwU+MxH4/50jgffTrXkgp3Utwhg6hfrJeXfEcT39mrqE+h6OXepVA2wOkUb+zBXiKJKcsvvnc1QVataF4oIwqpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPNmfRnYPmkIdk+goXkrFBz6xZNCObeqUB4FFxoiSqM=;
 b=lK396i0mCr7aWqRUXRFqt8FMONUJQDD3vDatX0CSlhjgqE/7N9XjhtY69m9Qzhe6GsWT8wX4Z2ar+RSZ/neL2sJff+G73C86yujMJezVpKTUtmQymN5zt8euQPoUZZK3gWV/uritpFx6bN8o7sqveJNbENWSApmzZXnAj7dZq52cPRdPnLieDI+nk2xSIfydhd1dHKbpl2V7qAhPZIxxQcC7T1DzYj+Q/Wtpg+hUM2L1/ZtQqfhCzrnV0CYrKjo8jJXi7dGdtoIFg1onFQaQ1x+B5enSg+R0kqHcgKz9RtHauGoBFhxcHGwd9Zdtsoghfa0quTcWn/aksG1EgtvlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPNmfRnYPmkIdk+goXkrFBz6xZNCObeqUB4FFxoiSqM=;
 b=DfNp0mg5d/EJ4EYFlQLEPPa4yBUVi/kRHsqkjRnZKQg7hCkN3u2+lk3okxTFA56UQGsvgPu932UuR5hGLso/++35MV+9oKwxIgQHIpo0fsIU7GOZsTJ1HgclrQJFKrrfHwbf1784Mv26EVF+tpWGmUTgSP54YQ0PSq6KddU3WmCvl6jYhAk0AbLcR5pFHPn4kaMse7LBWPt0NV7bIT08jRyfgj7A9Dxt1OJ0jb89gqX7N3A/JIpJTvIrdZQPr5ERgNOTsO1a5gPAktnGOm1UTQ5YAbLYtH4BxNANIaVusO4a7yeuxGzUsHfGPVGIJFJRgeT+AZn2ygQ2CchDw+NObQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 16:20:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 16:20:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blktests: print multiple skip reasons
Thread-Topic: blktests: print multiple skip reasons
Thread-Index: AQHYkF3CbIn6+UHqqUaQcGpiq+iSva1v9W2A
Date:   Tue, 5 Jul 2022 16:20:03 +0000
Message-ID: <d5c0ac21-47fd-6aa6-43bd-0ac8052094ef@nvidia.com>
References: <20220705105537.hdjmbq3dcok3srmj@shindev>
In-Reply-To: <20220705105537.hdjmbq3dcok3srmj@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b18e546-0fca-4856-8488-08da5ea237bb
x-ms-traffictypediagnostic: BL1PR12MB5828:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?aUJTVjloTlhWcTh4TnpDOFZlRU5MdjM0V1VuK1BPMG8yNG9mTnpqT0MzN2Rr?=
 =?utf-8?B?TCsrVTVjeHhKN2dWRVJQVFh0MjdQNThnNlduOVkrcDFPWWZ4QlE3YlhwdUFG?=
 =?utf-8?B?eEJhTkthWEtRd1ZPNW5CMGtsYW9PcWZWZFhVcUNCQmN4emhrRmVXMG9nNlVZ?=
 =?utf-8?B?M1RuOWEweTZHaHRlaFhNOFE5eS9KNDcycE51SlJGMlNqbDlSOEpLTFA5SExt?=
 =?utf-8?B?c2hGdHowRWwxSjB1b0NELzBnMFhka3B1QWlvQVJQT0lmV3NtSWlGRFlDUldx?=
 =?utf-8?B?TU4xRDRwZnA1d1Fya051dU9JbkJ3a3BJVXV0L1Nyeis5WklsM1lNdGJIMlpS?=
 =?utf-8?B?RDZYbjA0WUphVkFIRllpUWVtcURjMEI1MHVraDAyMGt2Z1RGaCtQbTVkV2sr?=
 =?utf-8?B?TGc5T1ZxdGJIRmxoL2wwdDVvSDRmTUtyUitTRStweGl1NFd5YlU2QlJsK21R?=
 =?utf-8?B?UW1ndCt5N0k1VGlzanJBc0hsTVlrSlVHSnQ2aDhUWldjMDhtMDVMT1NUL3Jv?=
 =?utf-8?B?VHEyejV2Yjkwb002Rk9YYmFDZUNwSVdSMEx1NUxzMG5ZZHdwWS8raXFzN01a?=
 =?utf-8?B?K25lVGkxTlEvdElBZ1kxRTJiY1MvZFlCbkhmT2RsL2tGTjdtVm9XaGRCdW1n?=
 =?utf-8?B?SVR3VmRqeW0zbzdNQVhJcnVwUktaSVBBUDVnWldqeFV6VmhOVkxvME53Y21I?=
 =?utf-8?B?WU9hNGdhbmtzcEhvYnIzcWcxWGNmTGFJNmhDeGxJNGxOWkVaQk1lYmU4ZUg1?=
 =?utf-8?B?bWh0bmZlZ3hSYkdpcGJFWjd3QUlXTmJnSFYxMlFRSmRVK0FNcjZISU5uM0o2?=
 =?utf-8?B?TVpDczV4QVpaa3NNa25oUEQ1S05iZTAvQm5ueUVPd1RrQVBOUGVVb1Q1ZmRX?=
 =?utf-8?B?WC80OEFxMStXdm52cXRkZnlMdnRCbUJTTmh3Wk9VeEpxUW5oOUkzcmYrajNv?=
 =?utf-8?B?dm82NmgrQVhQWXFTblQvL3dWaklweVpCYThXdENIYk02M0t0NlBkOVNqelBX?=
 =?utf-8?B?WVFtOFJuNlVtOHg2TmZrV2dKN09uVVUra2daeGFkeVY4bURYWlRuWnRMQWI3?=
 =?utf-8?B?bVl0aGZGWklVLy9ERmZwc3FTZUI5SXJtckc5d04zdjE1WTFVeWlqZWJjSUVi?=
 =?utf-8?B?L1QyaHV6UEd4SlFHOGZ4SFgvRmNmYWpRanRSUFMvb0xGOHlwOVZZWkxLK0VI?=
 =?utf-8?B?cytwMjVhTlZ5WnBoU2luc1VicnJVY2lSamc1T0k4SlNIYU9EY20zR2NTekZI?=
 =?utf-8?B?TU5SZnZuL0ppbUJwTEJDZi8yakRhTm9RTGVFVVV4dU00TVBHUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(4326008)(2906002)(6512007)(8676002)(64756008)(83380400001)(41300700001)(91956017)(6916009)(66476007)(86362001)(26005)(6486002)(71200400001)(53546011)(6506007)(66556008)(76116006)(31696002)(66446008)(38070700005)(66946007)(2616005)(966005)(36756003)(122000001)(186003)(5660300002)(478600001)(8936002)(38100700002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDNoNjZmMkk4NjNBdS9mWmJmTmIzeXh6ZGthNmxJdmE1OEEwLzdrR1lrTlFB?=
 =?utf-8?B?YVhnTDJiMHd4bTlwdTBlbzlnTHlveWUrNkVFWVZXMWpNa0xMUmlXWWZ2Y0dw?=
 =?utf-8?B?eHd6cHdpTmhMWDBSakhCS1A1eVNpOGc3OUljNS9qVWJrb3REYnJaRVBpSTBK?=
 =?utf-8?B?MTlhNG5PRkVocncvamMxSXRJQnVNdFNnRUV1TjhpWHltc3A4L1NSYmJSelcy?=
 =?utf-8?B?U1JNa3R2ZU9KM0xNZ1YwMC9Td0g0NnhOeEJTTVBCZ04vekdmS1hudlVQZkJY?=
 =?utf-8?B?TGZuL3Qza1pydmJ5SUVMdDl2Z0twOEhxdXdrY05QMmErTnRkQlpIaFlqUU9v?=
 =?utf-8?B?MkZVS0p6Zy82UVowUThmV29WditSaHhPWlo1Nkk4dTIwOFNzWE1ZZTlseVh1?=
 =?utf-8?B?bkFSazNWZVBWMzJmNEZjT1MyWEJkN0RrSFVUZGc3b1VtbG1wUUJzdnp2dVFG?=
 =?utf-8?B?RFZlOXJSNlFjTm5NV0QzMGZ4dk5pWW5zVXdzV003bEg5ekgvV1BaVy9yeFg0?=
 =?utf-8?B?eENuTm84WEx1YnAyK1hYZUh3STAwbUhjdkFYR2R1bmxSSkJIYzMyNVVKZFJp?=
 =?utf-8?B?TjFZTkRUd2VxTTNkd0F2UndUQzVEWG9aenE5M0c5eWo1NkU2UHdTSUMreEQ5?=
 =?utf-8?B?YTMvQWNCSXJ0RmJPbWVnZktSSnc5SGlGNHpDOW9mazZKMEUyZysreXFFc2F3?=
 =?utf-8?B?OGM3dG5UOW8vdmFWOU5aV0Z0dzdjSWJ3SW9jMGxtZnRFTnd4aFVqZ1F4NkV6?=
 =?utf-8?B?c1pWYVlRNnpKSDY4UERVOVR3d3A1enRpc3JVNVkvK0xNY3Y0WHhVSEwvNDIw?=
 =?utf-8?B?QnVyWnF5S05NUXA2anlnRm1NTDNQNzJaRWZTRzUzNnVmTURhL3g4NXYwdjNh?=
 =?utf-8?B?TWRldy9FS3dzZFFuRHFKNkVCVWkzelEvc3dpbTlMOUM0L2d6d1Q2NWFPRmZo?=
 =?utf-8?B?WUR6Q0JOaE9VOUJ4ZE83UXdGK3pCYUdHbkc3WGRMRjJnaG5uaFFJbzg4dkpC?=
 =?utf-8?B?VWFtenM0N1RKR3UrQ2V4eXJjc1h2dUNHRlBPZHhSNVVIR05HMVhjUGxNekRQ?=
 =?utf-8?B?VllldEpWaDdHQjc1RXZLZ1dWQU4xMGdpTHd3UHk2Z3Vzam5RWmFndHN6UCtm?=
 =?utf-8?B?cmtoaExYT0JLZFZsV0hGN3d4WjRwR3NtcXV1VmwwMkxpODRDQnFRR0p6N1Fv?=
 =?utf-8?B?aGRZbHIwOXZYOFZHV0pLalI1N2FqTTN6TTYzaG5lQkFRSXFkb0RQV3BobWxN?=
 =?utf-8?B?UE9yR2ZlT3M1ZFZDYmNvVDJpbzQ2OE9tNzJHajFLYkdtVHRrZzNER3UvU0F5?=
 =?utf-8?B?UUVGZllGeGI0ZElKM0FwUHZxRGlscitQK0V4NTU2NTVERFVCVFlYeFRrTjZO?=
 =?utf-8?B?N0N4OE1COTFXY2ZCSm5mSi9NTVVtRXZ5OUlBRGRFNkE1RGFXSjErYmFDQWh2?=
 =?utf-8?B?RWdialRJcjd3RVhEWTdWTmpTb0VPMkJJQTFTUUJpbXFxQ2hNcGZUdW8xQlp3?=
 =?utf-8?B?enJURjIrWXcrd29QYlFXaVY4blRMVStnMUdMNzhJOGhiSWxBMGVRVGZqb3JZ?=
 =?utf-8?B?aGIwL2NvbTRhdVE3UzVHRjZCUUV5Rzl0cVhqSzlaSE5OYlJWdndIczVPdHd0?=
 =?utf-8?B?b21rMWZ0SkdJdEo5bWxvemV4T1J4OEg1bW5LMWFDanFva0hidUlwN2R5RGdO?=
 =?utf-8?B?WkVOenc0VUdnUWNjcGZaSC9YVFZIOGpXcEFNa2hoTWNRVTZFdEtsOUkxR1ZX?=
 =?utf-8?B?WjQ4cmFXMlhhNmNKK2k3T3VNdUZ6Q1hMVVZweDJjajkrSGFNRWx4bUxOeGhP?=
 =?utf-8?B?eVZMY2JSR21PVUEydFpSUURHbEp2d1BaZ0lPd0hLNmI3eTU4Y2JDelNlRWNa?=
 =?utf-8?B?WnBuT0pLeWdNZnNaUHFuNFVJck00UHNiVWVJSW1leGpYcWxJZFV0T2o4VE5J?=
 =?utf-8?B?TzdUTmhFZ2Rrc3E4SVFseTgvb1ljaTJMY1JWUDBxaVFhbHpZTVBNcVpheXpZ?=
 =?utf-8?B?QnozVS9rNFgrRXBrSmVaR1FnRktPL1ZiWVBlc251L2tUL0pFbFYyMlI3cGhl?=
 =?utf-8?B?S29RSkJvSDgyenFvT0hDUjFRaHJuYWowNGFpUFlLNXJ3L0c4Z2h0RnVMeW5L?=
 =?utf-8?Q?gTNNRJPpYl4wmriwrb2Wg8T0P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F561972ED0EF3E4DA18653EAC641F4A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b18e546-0fca-4856-8488-08da5ea237bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 16:20:03.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFxktEnfjoR2sVRLfcMuH3l2CmMiGLt9MkvMJ1dYVfPkIw/AtcgiA9ths6rzfNYtc0odoyyvJXWdtNIcjfOCrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQpIaSBTaGluaWNoaXJvLA0KDQpPbiA3LzUvMjIgMDM6NTUsIFNoaW5pY2hpcm8gS2F3YXNha2kg
d3JvdGU6DQo+IEZvciB0aG9zZSB3aG8gaW50ZXJlc3RlZCBpbiBibGt0ZXN0czoNCj4gDQo+IEEg
cHVsbCByZXF1ZXN0IGlzIG5vdyB1bmRlciByZXZpZXcgWzFdIHdoaWNoIHN1Z2dlc3RzIHRvIGlt
cHJvdmUgU0tJUF9SRUFTT04NCj4gaGFuZGxpbmcuIFNvbWUgdGVzdCBjYXNlcyBvciB0ZXN0IGdy
b3VwcyBoYXZlIHJhdGhlciBsYXJnZSBudW1iZXIgb2YgdGVzdA0KPiBydW4gcmVxdWlyZW1lbnRz
IGFuZCB0aGVuIHRoZXkgbWF5IGhhdmUgbXVsdGlwbGUgc2tpcCByZWFzb25zLiBIb3dldmVyLCBi
bGt0ZXN0cw0KPiBjYW4gcmVwb3J0IG9ubHkgc2luZ2xlIHNraXAgcmVhc29uLiBUbyBrbm93IGFs
bCBvZiB0aGUgc2tpcCByZWFzb25zLCB3ZSBuZWVkIHRvDQo+IHJlcGVhdCBza2lwIHJlYXNvbiBy
ZXNvbHV0aW9uIGFuZCBibGt0ZXN0cyBydW4uIFRoaXMgaXMgYSB0cm91Ymxlc29tZSB3b3JrLg0K
PiANCj4gV2l0aCB0aGUgc3VnZ2VzdGVkIGNvZGUgY2hhbmdlLCBhbGwgb2YgdGhlIHNraXAgcmVh
c29ucyB3aWxsIGJlIHByaW50ZWQgYXQgb25lDQo+IHNob3QgcnVuLiBIYW5keS4gT24gdGhlIG90
aGVyIGhhbmQsIGl0IHdpbGwgY2hhbmdlIHRoZSB3YXkgdG8gc2V0IFNLSVBfUkVBU09OIGluDQo+
IHJlcXVpcmVtZW50IGNoZWNrIGZ1bmN0aW9ucy4gQSBuZXcgaGVscGVyIGZ1bmN0aW9uIHdpbGwg
YmUgdXNlZCBpbiBwbGFjZSBvZg0KPiBzdWJzdGl0dGlvbiB0byB0aGUgU0tJUF9SRUFTT04gdmFy
aWFibGUuDQo+IA0KPiBKdXN0IGluIGNhc2UgeW91IGFyZSBpbnRlcmVzdGVkIGluLCB0YWtlIGEg
bG9vayBpbiB0aGUgcHVsbCByZXF1ZXN0Lg0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9v
c2FuZG92L2Jsa3Rlc3RzL3B1bGwvOTYNCj4gDQoNCklzIGlzIHBvc3NpYmxlIHRvIG1ha2UgcHVs
bCByZXF1ZXN0IGF2YWlsYWJsZSBvbiB0aGUgbWFpbGluZyBsaXN0DQphcyBhIHBhdGNoLXNlcmll
cz8gYXMgZmFyIGFzIEkga25vdyBub3QgZXZlcnkgZGV2ZWxvcGVyIGluIHRoZQ0KYmxvY2svbnZt
ZS9zY3NpL2RtIGxvb2tlZCBhdCB0aGUgZ2l0aHViIGV4cGxpY2l0bHkgPw0KDQotY2sNCg0KDQo=
