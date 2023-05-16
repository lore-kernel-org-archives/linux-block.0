Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F7CC77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 20:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjEPUdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 16:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEPUdD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 16:33:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A4F97
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 13:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKQrpoGCofa31e9uiMbRB+UiQBdxAAYk7KZA2mf7fjIqmXxZtAWyNowYV0zQADEsJKihu6gtZl6tR3Z99mnNlBQlun+31jNf7Czqt5v74bfVBQaFS8l1ivCMo/lBKHd3Xlg2P+/koMfnExsUBJNHZyxVDUyJEoceU84TxdC9rPZlZYxNqOzOoo/O744RTrxORjfzQlhlfj3Qt3v/wlUMAr0JG3i+v1n745Vma6c44bIO8+N3xLeXXLKoMZEh/zy2lwCF0QSiQW93bD2A+niBPQcwPDg2Tn1VV6fS8ZNg7NnRV295mkXQ6d8rxet8bAt/FR/zN++h3oyUVD5cBBDJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKvwWXTyAkk36+JCh6uEgtDgfOwuUq65EVUSW45hqjE=;
 b=Uh1Sdoukb4g/xasMjcSonpRKGAo25PtuvBGV2YRXZkXGqJZV0YlSNK6mXbYR4QrW4uXP+Bg56u2uieZnoG2BXI6tU8bEXMsZSh6tBIKZw6IQpFo3Z7eAxlU81MM69ObL71lgedTrEGuwvPVhnJK1/gK4jyOTE10JDvOUaR1wDGz+XrqHNcp726ZydTNzgbN+A8af25QRJC37fF1cs3t3k1vEpZlaJJVVWe9l9jM+QkzLox20Pgh4l2/OvEN/4pF+oviHEarhS9V3MH5e9ZLQrQ1aiNphVg62jQG3lf6OX2JCS8yhcZvebYKXu3yQ+a+HYsSNMFYhg/RaZQv/ViW8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKvwWXTyAkk36+JCh6uEgtDgfOwuUq65EVUSW45hqjE=;
 b=dZZBthVs7u82qg747OeSaKaBKuIKRYkiKVh9uvMvuQofq6RmI3mwU5YtoJiDq0QYnzZe18YH6r9yqLbCLCzeYwwGXdEksrhGoB4uM+sGO2QBmaVRNOThII7L092a+PrNonCZlPlQKSljcppdcWrMsQHYdsRc3yaD3TOWbyBVDrhEFXHCEBzdd5lA8Hrmx+IRosAfy7aEgvzTKo7BhNLYuP+68Zq37dOGG8YxIrCFBsmx7Yd/edFPs95r/Ifhy+6eTGRmyPTPFNeHpzWlDp7jEi4xs1ubj2SgGfjGOJd0s2i9YVULC1zg9gh32EsNEnE5kkgCi8p+Es0h1tm+5XRiEw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Tue, 16 May 2023 20:33:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 20:33:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Decode all flag names in the debugfs output
Thread-Topic: [PATCH] block: Decode all flag names in the debugfs output
Thread-Index: AQHZiByxDDOruFwTlEmmJbKbWn+uta9dWvuA
Date:   Tue, 16 May 2023 20:32:59 +0000
Message-ID: <cb7be246-a5e2-563f-5898-d67e48505f56@nvidia.com>
References: <20230516173426.798414-1-bvanassche@acm.org>
In-Reply-To: <20230516173426.798414-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6373:EE_
x-ms-office365-filtering-correlation-id: e012ed21-692a-4e5b-f8b6-08db564cbd87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5qbnD8Epi82Vz20775fpjmd+7KNiblXMNHoK3k4vabMeTIEBVvRVNO4qHoIOvSHVDxt0zrGHYQcpTGZWIjHlD/TVKGyL0xy1x2DGXeUCyEzyV4GH1AvGVFycom66bqbJtxaEqE3GGKAsKiW7E8EpyI1vaM+j3d1TAU7Nc4kuBBojeMaB0nbXvq5yxGvwKBF3yDTUsSsON4zwbKs5zceE3TTTbM/MXTh2UfFnNQlqTe9jjubsYLiGbO5M/1HvsIKgUKm1sf5YwqhCdjltHG1+On93U1Lm3NWrb+1PrcI7dtsTFi8hG0q9IGaG+Nxd4XIln9Qm5JwYka+AzbrSuc1nXjZRc/iN0wEq7lq86j2ru35Dm9w6rWxqHkkeOGiGXqUgWA2Cyuo3G1O3i6VH0K5YgpKZFotyOK8sCArSQ8HRxtaJKcfIN/DKhT/ZAo0L/2q2OkIQiq7OWsWoCWvraTs3YUWBZGA2tCRwKohvn5vaHIcGHaakajjaUyKN595uU3WNQnivr/jMzjzNlyiF2/rwarGj1O3U/PJQ3ibWDKfCJfIkruof/nh3VAyfZwf5LLXhrphOvqoLJ8yHoDI1uZ7C0AfixiVfkjU3eEi1/SVpyMnNRsMTcjOGld7JT3pKreXhXF+MOo1zoLzCq3QUGGBtGvpruMrF9molUoSPmZBRrs5Ek2PWEG1Q0xfdheWKYm0l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(6486002)(38070700005)(36756003)(2616005)(6512007)(122000001)(6506007)(53546011)(38100700002)(86362001)(54906003)(110136005)(31696002)(4744005)(2906002)(41300700001)(91956017)(8676002)(31686004)(5660300002)(8936002)(316002)(4326008)(76116006)(66446008)(66476007)(64756008)(66946007)(186003)(66556008)(71200400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEhaMDB2VWkrekxmcnFEVERpTXZuTXVCYW92a2w0VWttc01iT3puRzdnNHpR?=
 =?utf-8?B?eHhtS3lKWUVNUmRqMzVOcWFFVHpzOFRjVlV5WWluVWZnUEpmTmpoeFFLY0U2?=
 =?utf-8?B?MlBKWWl0RjZJWHQzdWRIT0NIb0xUUGZaRTFlM2tlZzQ5RENVK1dSanE2ekR3?=
 =?utf-8?B?Z0I5dFpPOEUwdm9heEU2c0hqQVgwelROZGZRZlJnWnZTTnJsSGR5bUcxSW01?=
 =?utf-8?B?T05pNGdkSy9KVEV4VWhwTGYzT2oxQ3hhclA0QlpQS3JTMVJHQmlidFgyem8y?=
 =?utf-8?B?aTVSN2o5L3BxR29HYWxUdU9LTkM3cFJPaGpRRmpvVFNVSTIwaGJrOHUzMEND?=
 =?utf-8?B?NjdCcHlyeHBpYkZ1dnlqS3lraFdNNnAvd2lWb0FjZVkvaUtLeFh0am9lWXZH?=
 =?utf-8?B?cUhya1QrRGRTVm5qTWlWTDc5WmFaNWxZSVV6Mk1lSFI0cHBWRzVkSFpwQnNL?=
 =?utf-8?B?ZHE4VnpqMXlUN1htYTBtbTR5TVFlUno0emRTamdVMWEwa2lrSjlQVFNDUGFm?=
 =?utf-8?B?SWpSU2ozRVBYV01ycnBDaGRCd2t5VjVpRFNPU2RudE5TWUlZOG9NZ2hBMFU3?=
 =?utf-8?B?V0grQTY5Vm5oYktmd0trd24vVmNMQnowVnJzMVoyTEJoVWlwZXc1NHg4UmpK?=
 =?utf-8?B?YzRoRW1KSXhaczZ0N0MzT0k2OWRndXY4T2poSmVTQ3pFdFY2aDNGY09ZdFh5?=
 =?utf-8?B?Mlh6WW44bEo2UTZGemF5ZFlRVVV3ZHdCYlBuRWprWmpGaVliQ3dXRGZpRXNh?=
 =?utf-8?B?ZjNMUTc5NEdkZGxHMVBFMFpkTEN5VGw4UWdnelU0WVQzanFOOS94UDB5bTFC?=
 =?utf-8?B?Tk1ybXRPSnpkWlZiSldsSVZRWXNOL2JuSG5abTVnbHNOV1JxdW04ZE1nRUcw?=
 =?utf-8?B?ZVpRT1lmYk5xMEdCV2QyNUJYL3QvOFdaa2xxODZaMGlqYS9raFM4YU5CWkdL?=
 =?utf-8?B?aWFmT1dMcFpWMVhIU0xuRkZtbzI0SndHTnh5TERKTEdEcUxaeW11YllGQVpr?=
 =?utf-8?B?ck9zTXVDNWhLSTJUTGpGOVBLbHF2Z1AvaGpXNEszVVY3K2g3VjhuajJlOE53?=
 =?utf-8?B?dDBpUEJkWHZhS2NNSFZVTWtaV0JmM3U4Q3B0WVFYSDhNU3EvT2JUNDhvMUtx?=
 =?utf-8?B?eDFzUTBrakQvYVZZeGl5b01vaDlFdks5WDlTbXFSZnN6aHE4SW54emtrYnRF?=
 =?utf-8?B?NzJoNnlqWElSS1NaWExMQklnN05valVZZGNLQlVPZkVWSkVaaW4rZTJycDRU?=
 =?utf-8?B?WTh2MWtTUXBQajBmT1diejROb1NZNmY5UzB5ZkpGYVdybllOWkwwRXBXLy9w?=
 =?utf-8?B?UFlvbXJUdTh1eTBQZmdLWkJ5dFJvS3NhcURGa3VxZmIydzA0TUlEMTBWWVhG?=
 =?utf-8?B?WDZGeU0ySDE4NGt5OThQNVc5M3ZyanhLa0s1N2U1bnZJSEhuNGJGSWZ2UENk?=
 =?utf-8?B?R1JTaUMxaWZvU3dXYW5xRkVrZEpzd1haeS96bGNMM09PT0RFNEVYRXh4cUZT?=
 =?utf-8?B?VWZKeENuQlJXNmJzSXhlb0t6dWlKZkU5amdNS2NNNHB6aWpQTjYzU2ZoQWw3?=
 =?utf-8?B?V1cvZ0NvOFhSbnZ2NXJOdWNROXJpdy9ZSTBpQlhOdXI1bHJPaEZ0S29zSC9B?=
 =?utf-8?B?NVo0V3BYdnRCZ2JnVG9Tck1mcmNKM3RveTlEVkFlWEVlN0U4NUZFM2N6L0dQ?=
 =?utf-8?B?dTl5L3FpWis2UDd4OXBhWmxJeG9rOFlNbDhpQnJoVnl4ekNkNWg2WlBWVXdJ?=
 =?utf-8?B?dUgyMVZSU0RoaXJsN3lQZEpwRzNyQ3BNR1pTaEkwZGtKVHhHVVNBSkJqS0JH?=
 =?utf-8?B?QVZRRTRtNFV5SW95RWtvZE1aaHIzUmtreVJtNHR3dkRsamREbXVuT1NhS2w0?=
 =?utf-8?B?SnNiTFM2d0MvL0V5WUNQdkhQblNTNk9yV3ZCRFYwVDIvMVpzSmJIQWV4T0k1?=
 =?utf-8?B?MGk5SWllemRaZUdlNUhoMmVvRUw2U1dsKzJPeTVIbTdMVmZmQVZMZGVmdDhq?=
 =?utf-8?B?U242bzVxSE1qN29QZDR6MmRzT1dJbjg3ZGtpa2drWGdrR0M0VnF0bEF0NjQy?=
 =?utf-8?B?amZWL0N2b3JJb0EzMzdWYk56REt1eTFjM3VwMFhwSVhpTGRZNXJJY3A1VjRT?=
 =?utf-8?B?eWoxUG10RDBVNGNIZnQyeTFXbjFwVDBOTitGQ1k2aVRqeng2c0lQRmh5cFhO?=
 =?utf-8?Q?QMWTVvjnm3PYclhcdLZXCu814TaMwDGK/2o3R9wswFaS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42064DB0ED6C0C44B02D4544F292EFC5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e012ed21-692a-4e5b-f8b6-08db564cbd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 20:32:59.9775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zHnC1xje1OWjv02iyB4TwuU0MMOmNkHyHGo4nc5rVifahGUrxPee5S/SoCoEn9bTznj5+JGTnVLHAQQjYHR0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xNi8yMyAxMDozNCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBTZWUgYWxzbzoNCj4g
KiBDb21taXQgNGQzMzdjZWJjYjFjICgiYmxrLW1xOiBhdm9pZCB0byB0b3VjaCBxLT5lbGV2YXRv
ciB3aXRob3V0IGFueSBwcm90ZWN0aW9uIikuDQo+ICogQ29tbWl0IDQxNGRkNDhlODgyYyAoImJs
ay1tcTogYWRkIHRhZ3NldCBxdWllc2NlIGludGVyZmFjZSIpLg0KPg0KPiBDYzogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IENjOiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9h
bEBvcGVuc291cmNlLndkYy5jb20+DQo+IENjOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+
DQo+IC0tLQ0KPiAgIA0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
