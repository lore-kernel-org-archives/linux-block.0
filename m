Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D1CC433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKGFko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKGFkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:40:42 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5642DFC;
        Sun,  6 Nov 2022 21:40:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E77kOnfu4oje8yKc1Bld3Q6ZaDFA1fqPc5k2D+X98oIW4w1aY5CbbeKWr/ThwU/UtdvhqbGZKadBQhMUL04xNxbSn00aY06sadRuljQa21B6tas7ihmUtxKZu7samPhk/1YyOXn8dHWuhSVw/xfiS8e2lMvUedJhM4wbuevODNl4A7Jq3GbPffO73ApvAyCf9Xbm1N1Fo5uigGWSbhFyRsgXDI5TOBpEOYzUsniowwGvkLV18vDMqOMTCpbkv4CgKSXuUwBJhskV+t/nSG6+wI5bAjJPo7UqDrDQhvHghMVZ24+e5KbamZR/k0T3SJmzxdb84vatt+C5IKD/YsYTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6osW+UkhYWHo/jAF6Zk6Xc5MUxpK2IHZ6X0XCovf4s=;
 b=ROVpkWeZoav3CV8GDU9gZBUINnHuRH+DmS7RYBO7j2wAvnHvwGIEhtACfAAbmqseNzmrSiwjOA8HkMN1ibfZdqNxtOBLRqrMWWOHXE1haDmop6ReYRmqWIOjEKdzQmnileIEHV3gIGOHDxTdHO2Pli/VzgngBPACifsSPtKRghWptGUOS7bUmixnldxl6khjOsGo6+XHNtfmP5+BMy6vZMtLZ6xDoeISxU6mb2qNMXhpZipIFE5/wy+M1874y4N9Uv7Y1xFNrHRS+26WKEfcqaC7Yb5uXyzwn/z5dCHLkOm6w2TUl1T9eK2J+4Nt1Qrmruw3P02ovsDk+WXo494sVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6osW+UkhYWHo/jAF6Zk6Xc5MUxpK2IHZ6X0XCovf4s=;
 b=PAf8SkXTrgL5CvQd8vQklUMHPM07bzIxf8ZQNLOqyWcuHRXy6IKPj4USExCxzywlyCbE24yULriuw9wuC/3YMX5rmUsVI4q3/aflS1GrlaBzRHv4EuB5jIKScQKfdj1xmMem+M08YCkioGXwVJjdwxl9GLY3YV1sIs7UN8rTiXNh800JxjeUeWE1wWg3yf7bi3dQ703Bv3MmRtc16mNIGfKj7TOM3JuVynohLn8S2DrdhTLmwG6iZv8Z1tUV6Yr2Mjlav0dtVDEgiI6iL7bTcVfUxDQW14f4TFVZH2Qxk1kUyLBUWugtXDYUrzsNya/Zu5a4qu8+8ILm2lhUoc6/Og==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 05:40:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 05:40:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Topic: [PATCH v5 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Index: AQHY8kLwFNHzUt5/SkWrzGwE1AN9Zq4y8mmA
Date:   Mon, 7 Nov 2022 05:40:39 +0000
Message-ID: <488d5f41-551a-4e8b-fea5-8342aff0cafe@nvidia.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221107005021.1327692-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4468:EE_
x-ms-office365-filtering-correlation-id: e8ef937f-a91e-4d74-bf4a-08dac0829a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kd2VU9qiNWSqnERyvif4mYNSEZqZVTH5WIJoIKqNFjGD++G9CzoWab87293ygbaB44ej2sh301zMHav7p75xCFkFdJBAFDKcouUPsGbEb7Wl8e9aIPdvpYyI2oAXsr92bWSYg1C5AZpGeUxz8p+kTqgMjyXx6Is3tZAX1xtrp0ifUbZbe0LLA1cFZmI91npuhBn8VPm6FkImli8IJAt0k2SH+bDTXxsi0/cnlok5uHEID2TePeoz3k7qxY4LdDJAp40C1cIETLFGIrrTpyBNyJTCetG9V+X9NtNk4lgRYxQgNO52D4P1vXq8hZL8PStlVnauiiOEHSVTChlNZmU7YhfAMWWTsvh/iHtKqjNgCrRbpb/lHsEpKqS82KKFcDBKPu3dUTVlDl6bfBnE4VVa5eYID9M2NYOEwB4DG4FYfDls4mhPMf2/OR3IaY6gna+NFt9LtuWB/Nu2XxQHgtT1fLXQUrDNQQyf2IS/UMeaxSWch3uF0MzMwA9modxECVDatmHapxsXM9PGMUnHOdb0T+j9f91Q9JZF94zKJ65ZwbgRvJEXczHXi6yujvoN/yoSbXmISKsUEsHPMUJIyU4SRHqCmdSDNs63zxPyMGwthtI3HbPeB+hMC7EigNadg8tdqdOQfZ+vNk8Yst1EUR5ITmUlLpvm5/0S9hEUzsQgvUzb+KP5OXfEvn3qiedABLaBf2SSLW/SeKYgACKrfpMJQXDXBWy0DJQ3D6xO8Ter3dMxpdghYer1LKG6H9JdZB1IMgqKMPYYadBuucwH+gexA2Z963b0Ix72PC/4UKTkZWV8Om6UshTIhkWFtHPMH+UoQ/byGAN/uQQv95KU/LlYFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(2616005)(186003)(6512007)(38100700002)(6506007)(122000001)(53546011)(4744005)(2906002)(110136005)(316002)(54906003)(478600001)(71200400001)(6486002)(41300700001)(5660300002)(8936002)(91956017)(76116006)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(36756003)(38070700005)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkhnTlkxeXVtaitkcEsyeDU0ejUrM3VPdEcvVjZxOWxaTWhUaUhCNzFkNk1p?=
 =?utf-8?B?YjVXamg2V2J4SDhWUEowY0tWd3l6cVVhdHFBTklhMFNSVG0yUGw2ZEh5cmxV?=
 =?utf-8?B?dFJmK1F6Wmcvb0wrY2lQSkZ0bU16TERkRmE5Vi9sQ0RpbFdkNXJTam9WcDFn?=
 =?utf-8?B?L08zRW16WnloalRtWjlvSytoa1ZjZ3BIazFSMzR2bWd2UnowZ210bVJZYmcw?=
 =?utf-8?B?NzliTEtyQnBoWkZ2VVE0K1MvQ2JZUFBWV3VaRWM2VlVweXVHZ0thaThzNWhj?=
 =?utf-8?B?RnlSOFpoQVQvSTlrcW9DU3RwWi8zQjRMaE9RSFpuZUVSOVZLS2Yza3ZRdDU3?=
 =?utf-8?B?ZCtYRnMrZlJYaW1QOFNwdUxLLzI0U2lwNU9LU0dtR2FRVGdjUjFSdVgzdDJu?=
 =?utf-8?B?bS94YUxLYXNxWWNGUnNMMWQ0b3J3SlZDaWNLcTErN3VIS1BPRk5nR3B2SFZo?=
 =?utf-8?B?Z1F4U1pSSC9Fcys3SVQyRmQxdGlIcnV5TnFmU3RCdzlubnB2QmNrYSszRml3?=
 =?utf-8?B?SkVmemtHVnczMlIrcnhmMCttejg5RlBxUzVNZks4VTQxMHNtMVZlMUhsYnBN?=
 =?utf-8?B?Zy9kckRVSU5zS0V0VThldTdiNmFxVU9YSHBUM080Y09NY2VMRU1NT2htTDIv?=
 =?utf-8?B?djExcGh0RnZ1SnJYaXFHWk1uUERETmhMVmNOSzJabzJlM2swMmhrQ2daUkZM?=
 =?utf-8?B?K1NMMnlqc2pwMERtRU1NRm9OVkEzRm8yMStrcDlPTllIOURnVzF2TkxnNUc3?=
 =?utf-8?B?VEFjTjVZYlF0dUFxTzNhN2JiRSsvQlFOc2R3Uzg3Tkt2OTlaNFNtV25qbFIz?=
 =?utf-8?B?azlvQmJKYmlOdDJWSkFUaHkyeGcycFJYaWE2Z0JPOExMQ0ltdmlIYVJ6Q3d6?=
 =?utf-8?B?VVN3S0d4SVFlcUxqYWVNb2lOc0hmVnFiUGUyd0U3Y1ZqYWIrU2pjZS9QSkx2?=
 =?utf-8?B?Y1BrQko0Y2I4R24vMDRqV0lFeG1QelFhNkVWQXkrWmI0MkxydHlNazFyWm5w?=
 =?utf-8?B?RU1pUC92L2VaL3oyQ3AxMmdOWVZqUmhlMVRCMWJ4VEU1a2hNSVBRSFZLMHBU?=
 =?utf-8?B?WXBMaGV4dGR6a05jeU5DMmg5ZTIwc3d2V2tWcVZQMXdaeXJQckkza0lwMG1X?=
 =?utf-8?B?a0V4dWhERkJQbUdtMjRVUUJBUWt1dGQ1UHQreFFBRURta050U213K01SZzNL?=
 =?utf-8?B?MzJpMzV1cFhCNlBNZlhOWDRaQVBjdGFTVzYvd09RQVRxUmhvRVh3cmp6MUd3?=
 =?utf-8?B?S1NiWTh5TGxaWmY4a285c3dLTFV5Zkx6N1VMSWR5ZWg2dDgrRm43ZDFNanhG?=
 =?utf-8?B?UVhhV0pscVU5cHA1VVZpMUxwNjRlR0l4ZTcrYVFMem9uTEFsWURkVmJqdklp?=
 =?utf-8?B?dWJVWnR6R3c5TVp6R0toU2ZiTG1EVEM5UWh2UkdVY2F0bjdFUW00MGo4U1FO?=
 =?utf-8?B?MVVsOWZiQ1E2a0hiWlcvL0JKRnFpNGQvSW5vTFhFcnhKeERXTjZtbGJWWkhG?=
 =?utf-8?B?aHdvMWNBSmFZMGdsamI1R0V5MVEwVzJ1Qjh5djd3YXJxaHlhYzh2SmZYT3lB?=
 =?utf-8?B?RERIVFBVQkp5ZkJhWHprbFJLN1RNZnJtVzl1cnV5blpPUm85emtFRWR2ZEJC?=
 =?utf-8?B?MDVPdE16bnNRREZjZGM0YWdHVTVZOUVKQTJEbVZONGhDVFBTUjhndEZLY1Bn?=
 =?utf-8?B?SEp1NVBZMWNpRG1KVnpZT05EWVFvM3ZEdnNrTjVPK1NZSVpHcXFJcDY0ZVcv?=
 =?utf-8?B?OC9GWW0ydDJpdkw5cEd1aVFUK1lZUjVsdS9qR0ttM3BKKzM1RlBxdkpQZlpN?=
 =?utf-8?B?WHZ2VnY5empDTjVjTlJVTGNaTGNaQWZ1Yml5MTZUbmRuR1pYRSsyMEZwcE5r?=
 =?utf-8?B?THlLS1grUEZZbnFFUThJWHdyalAwQSsrYWJsT09tR1h0enZ6cEpVVXhaRFdP?=
 =?utf-8?B?QkZCR2pER1NBdnpsT2F2MUJqd1lZTDUwdTZaNk5yQWtYOFRja2tzbWlGMTdr?=
 =?utf-8?B?cmZqZ2p5VjRsVlE3blVPa1JESnErMFNRdnJLOFhVQ3lsa3Ayb0ZGSEJpWDdq?=
 =?utf-8?B?RUhFc0RBNHNmUVRBbEQwUGEwTytwQ2RUakpNSzVqWCs5aHpBeTk0NGhsenJV?=
 =?utf-8?B?ZEhCUDIwUzNJWWU2Z2RERTNkRDFVaDRseWE1SHc3QkRNam9pMG55VzBjOEFS?=
 =?utf-8?Q?sCQqEHIAaEIuM33Y+OhSsdyu1IGl/LnxU07oUEhoxaqK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDA3A483B7FF9E4CA38707782C51C24B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ef937f-a91e-4d74-bf4a-08dac0829a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 05:40:39.7704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpYMM0+97hloOeWuyWxB20w5/KsRbDGVI8tjFxbCUQsgIk6S/Z5Vmw7o+uBT9booUvL+TOlC2+z9+/1jo/jT6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMDIyIDQ6NTAgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBGcm9tOiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gDQo+IENoZWNrIHRoYXQgdGhlIFBSRUZVU0gg
YW5kIEZVQSBmbGFncyBhcmUgb25seSBzZXQgb24gd3JpdGUgYmlvcywNCj4gZ2l2ZW4gdGhhdCB0
aGUgZmx1c2ggc3RhdGUgbWFjaGluZSBleHBlY3RzIHRoYXQuDQo+IA0KPiBSZXBvcnRlZC1ieTog
RGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gU2lnbmVkLW9mZi1i
eTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPg0KPiAt
LS0NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCg==
