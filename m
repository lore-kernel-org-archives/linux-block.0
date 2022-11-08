Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F4C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 23:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKHXH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKHXH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 18:07:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA763147
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 15:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7YV0pu7/XHSROO9uOt3Ft7JsKPXNouPhD9TY5rnzSDtNYyu8VY9QWZFmhDGgDTPS11cAMky/d+nd6W9jsbpHPNLjO2fid+NS1HetpOnkyFvSE7nwXxMyGdQ3WIzfqx6+5puP/8kbw3bxwuKjieDX5hZC2ekWEo0R2dPeOjaiFzIZEe+/jsMje+LFd0CJxS2yOTPa3coj2CH6myWgbqYatTa2GenDuB0KXuTswuPqERB6Xm67DBfObzl6F3RC21zQaVNEp3KMyK6TmxwZFP/KfSEex0W+h9HAJyEHfLivmBv9+oTZG6x40XyBoi97M85a+IIQQ0b/XjIm1uCv0mOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPgC290GuvPrDcJbM1aOzq4Afrx3XuiP9GOxaBFG2Sk=;
 b=WVvkaBJsUjifkQZ3jV6n5V7YtdA5KrKe4ZZN5YS47tmYtWks6cHbeqetioDm3RWzDGwJGJTvi4pN1s+UMsNvYRZoy4a3UI0fpxupTiLBejAOId4WFGVvDEs2FLVFT+FXuss9pGpmhDCJXDf+CBa9dDSG3ooWuG+edj8h4ERJbUX5sN24qXmY4p6taKzjQWuLKzUXvTD/k7SJxwcG76bIH1HttYXm9kigZ/W2kDzJL9w5jlXrnK02pCN/ZROWm7BhCheGJ0OAcZ7JlsRtlv7IY8nAPcI6lckVD7kZJyFUueV5/76VSqhLQVWUnju8icCpdCHDHLcvFx0T87TLRwciWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPgC290GuvPrDcJbM1aOzq4Afrx3XuiP9GOxaBFG2Sk=;
 b=smcn7afMn44iGGyfu8hnLs8+bDBfqlnDiWCfDZDJjh4hHieJPQ5J72bhWKjiswgdsimvqzGRY0m97B99UREol8EhVKZX808Oi+wAFgSD0oucin5aSAdQRZtSLEuXh1em7nwHCOQ4gfy9adJwmUwgBveUljURetoH4dV7O5lqe+DodiOYPcATgMXkeTmoL23zcPZ1rtY2Igb1IqRL+ZipfxQ00+8O1YUQ5meF8ApMHsXByt7pMVCMlcLHEy1yQiAlvsrAQWQYKELK5wwdtoSZ3FGpIz0FCo7w0S1wNpzOfZBvyPNlAAAIjd2TQoZT9rdz2GCu5FM3fQOdpgybdfCHjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 23:07:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 23:07:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Subject: Re: [PATCH v5 1/2] virtio-blk: use a helper to handle request queuing
 errors
Thread-Topic: [PATCH v5 1/2] virtio-blk: use a helper to handle request
 queuing errors
Thread-Index: AQHY8yedo6DzMKGcfUqimoisWGUJv641p2mA
Date:   Tue, 8 Nov 2022 23:07:24 +0000
Message-ID: <10d78b31-fbbc-9d2a-6ab3-7c8e7426eb90@nvidia.com>
References: <20221108040718.2785649-1-dmitry.fomichev@wdc.com>
 <20221108040718.2785649-2-dmitry.fomichev@wdc.com>
In-Reply-To: <20221108040718.2785649-2-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5125:EE_
x-ms-office365-filtering-correlation-id: 3a6f2f3f-c7af-46b8-a7c9-08dac1ddff4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1VvIGHW+HPmPJ/JdjYABfozm0ZXJBTjwslh/OVHYfnAd9jbRt2tU5uGTUWVf/5Rar8srjHV2PvLo42ZOIHF8mvn1+6oMTlqJ+ck/ZJT2IuCMvjSgmwm9+t5fzGsVf9e0VJ49pG/TKvDlWLDxETZjqbmKbE9DR/yO3P3hnAXQsIP11gQk8Xc5fp2mB3hW9dbRveNPe5d4k64bKfNp9kiTvv1htXUdFdC9c+yiyCdULtR1IqGxzOt7VyxqNvCAkFyQljG7+RXnx91kg6OXQCCjR3Qq7gXbSEfanEuw+92ajt2DF/zvAIn3kb1YpUNASD5ghL0Q3gb7lW2bPCz8Rkbb3IdPHLESJQhQfcy6bGW5QYTl4bWS8Cd5/IVGBNRx5tRf0Eq6vVxWYoRKPUWYpMT4C3E9whjoVWDdk7qmD42yYLvbxhCAA4VMmN3xosOqppd2lA0a9c1w2RVOV6O1vNW0FS1DfTfROzFcb0Gxv/B8OaPDrl2vX3UrcsCoP7fPdcmqA2E6phJnlYN9AVCfeaoPZrjnjvb3R1LGbNVcC7ZJRgjRRJblSDKCN9T0Ota/j3z7pe0tzJaK+h+ugbn+R48QN05OibcQJdHTsnggIoJx1iyiAOM3lCKqs4hsnij1UiUn+ISJ88PMihAxG85R89kzBgP8r9ruEL7gJSVMHQJKYPdjPahgnKerDWibTv5iguV7vX7btS6ADrqvBvjwIDEdVcaUd7Dg82+VrC1y1AmqD1YdgetVhEJevH/vBbj19lGQK0HwyB2AJs14Jr3anWpMrQnB4bdkGpP2nTBTOuF9n06DIkvj7XNwNdbsKnQI5L83Zu6jx2YIpym2ZzBF55q9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(86362001)(31696002)(36756003)(38070700005)(4326008)(4744005)(186003)(5660300002)(2906002)(2616005)(53546011)(6512007)(83380400001)(6506007)(38100700002)(122000001)(91956017)(66446008)(64756008)(66476007)(66946007)(76116006)(66556008)(316002)(31686004)(6486002)(71200400001)(41300700001)(110136005)(478600001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1h3ZkNQaDBTT1cyOWtpZG9ua01QUC9OeG9wT21meUh2MWJ6V3M0eUV1RU5C?=
 =?utf-8?B?YWx6RzBRRlBjdmlGWlNZNXdYd2tZYmFmWFV2NzFEYUpPeSsxT3ZvNStFYWFw?=
 =?utf-8?B?MGpjdFREVEdXR1EzZDYrTHlBcGY0NHVkaEJoYjlyYzdwVzRCbVkzbGlmc3dM?=
 =?utf-8?B?Tis4bnA0T3poOVBqR0RzTFU1TlNKbXVCQldjNWIxcFA0U0dmd2p1UmpXOFZr?=
 =?utf-8?B?MXFCVFFHWks5enY0RnErbXJEYk5NaTVHT0NrOGpyRkh4UlVybEdrQ0RhWWkr?=
 =?utf-8?B?M2ZOSmE4cldFdUd6TkJFdWIrZmlBRUt2WGgxaEh2RmwvZVhJaHA4cVpZK2hY?=
 =?utf-8?B?aU9xWUdjcEJWSlBpNUJ6aFZzcG1lcXNMVXdFNjlvUXV0QWxUbjZoOTAzdGpl?=
 =?utf-8?B?VXJnK1Z6TlJNMDhqVUcwR1M4MFNKSFhtWHNzTUZGOFpUNlFtNSt2cGNQZXMz?=
 =?utf-8?B?ZVZZeko2MUh3YmtrYTFtWDRrQkl0YlN5ckxibXdJbWZWZDM5QVBIRFNnQ0pP?=
 =?utf-8?B?Y3d1WDlSMWE5SFBiZHF5K1lKaTdQREtYdTFpSWFaSmZZQlEyQ0IvRUNkVzdY?=
 =?utf-8?B?N3lJQmxqZGU3SGhrYmpGczFxbmdkTzJUSWdXMjVtM29HMnhWMmc4WThmU2VL?=
 =?utf-8?B?RDR4Y0dEN1RteXhnYzgwOWRDeTlKMWVqM2JPeDE4alVZdk9Nbk9seTVUa0dh?=
 =?utf-8?B?dUNFVC9QeWVaWmdvU1RhaHpmWXBMMEtWRkZiYlB3VURFNGNnS3RETXN6Qnhr?=
 =?utf-8?B?SXpVK1hFNFRScjQ0bmVLajZOd1ZqYmJuNjhBdm1DZnJmNnl1SE9VVlBWTmtW?=
 =?utf-8?B?Qi90NW94QUpwMk9IUCthWXdXcVFKTVdFRDFkLzl3MWZrK1M2S2ZMaWVaUjdV?=
 =?utf-8?B?SFlEMWszckloS2RienEvMjIydEgvRTc5MnV4NUFBdkEzZ0JMV08zczJVRzNO?=
 =?utf-8?B?WHQ0bmcyTk9uS0wvamJ5SnRqc3Z0Mm9WZ0pMUlZaQ2FXb0p0emV0OW94anY1?=
 =?utf-8?B?Z05KSmpGak1EdlJ4MmtLZTRMSjhHNDE2Q3ZvOGZVK2JtRGFYR0p5c2szKzln?=
 =?utf-8?B?WGg5R09FVy9iRFNpYklrUHZIeXduaU1PS0V3c21KelJPaHhTMUh4WXRXMzdQ?=
 =?utf-8?B?OE1xVFMxV0NHSWhnaG9DMDFNQXptUkUyTWM1c1E5cWZ4OEcwdmNNYVQ5bUNv?=
 =?utf-8?B?NERpam02SG0wRmFrYWhhRmVEMjUvL2JxZ1lRV0Zpek5BaTFEVDd0bTVLWUdR?=
 =?utf-8?B?bkpHR3g4a3llM1MvMkZETjhkd01vaS9GRlA3NnpTS0JPckRLUnNSbjI1d3dK?=
 =?utf-8?B?VURVN0xRWUNpWXh3UDVWYklVVndWQW5teWRHQ2pFMDVsYTQwTlg4YUNNYzBr?=
 =?utf-8?B?cjVLblVCSXdLQ2MzSml5cTdGRDV0OFZwZlk4ZjhaeTlrN2MwemdVOEM0Tjcv?=
 =?utf-8?B?QTNUZ1QrOVFjYTNJM1ZtbklCcEdqclVSaVFyL1ZhMnpMUWkvWVh1Mk0xTXp6?=
 =?utf-8?B?cDdXQjYwaEplanV3TUtObHJ3QTUvc0kyMFJMN2YxajRvRlhsQnFERy91dm1t?=
 =?utf-8?B?YWRCS0ZhVUVYM3VJaS9yTlY3Tk81OGMrVVBTOFFlWlphQWNaZmdFUms5Rjkz?=
 =?utf-8?B?SWQxSnlJT3RXekxyS2NORXQxU2VTd2k5c3lpbkRreGZWc0Vvd0lHYVpWNjNU?=
 =?utf-8?B?WUlwQkpoSGM0bkhNNGZ5ZDdKNkIzYVpOeDJxZlZqN25CSFZJalJlTEpId3Ba?=
 =?utf-8?B?YVB6eEJTZjZ1RnRGeTB3Qit1ZzVLeWlXcE91ZnRrRXpuZHExVWN6eUd5elRV?=
 =?utf-8?B?bWh3aWMwS1ltdkF6djN4cmt6QjVmdDF4YzlUd2RKYjU3cnpKSmpkbmlnWkFI?=
 =?utf-8?B?bkpUNzl5aUw2clZrT1hUZzdxMkExWm9iVFlES1IreUU5NnQ3SzFvNHpjeVU3?=
 =?utf-8?B?dXpOdllMc0t5ZmdNOEJsT0k1d3R0TGR0RExldThZUGF0V0tjWU0rYlBlZ0F3?=
 =?utf-8?B?R3poSnRZR1RrZGlvaitIb3dBNitRK3pyMW9VNlBNNHQxV04vS2pkTkZlUUpF?=
 =?utf-8?B?TGg4SldSRGpuQXZPSEpVdXZFZUR2bHBDWmZ6eEx2enlFMTdHUGhTRlFUM04z?=
 =?utf-8?B?UXo5a1VpQ2JzanJNSE9zb3EvL1dzNGpvQmNMU3FJOXA5K3puTGxUcTdPMkVB?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCC937CAB73FCD4DBA1823BC00DB7547@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6f2f3f-c7af-46b8-a7c9-08dac1ddff4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 23:07:24.0802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: af44OosY4UJbhEKkTyzXOgxA7XSSXegzY6fQz8hzl0arKmgNgRqxUIz7mhdiSk+g6M6WmrQ33QHqGz/mOak5Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNy8yMiAyMDowNywgRG1pdHJ5IEZvbWljaGV2IHdyb3RlOg0KPiBEZWZpbmUgYSBuZXcg
aGVscGVyIGZ1bmN0aW9uLCB2aXJ0YmxrX2ZhaWxfdG9fcXVldWUoKSwgdG8NCj4gY2xlYW4gdXAg
dGhlIGVycm9yIGhhbmRsaW5nIGNvZGUgaW4gdmlydGlvX3F1ZXVlX3JxKCkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEbWl0cnkgRm9taWNoZXYgPGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0KPiBS
ZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDI5ICsrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0
aW9ucygtKQ0KPiANCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==
