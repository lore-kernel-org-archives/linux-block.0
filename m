Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F307ECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 12:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiH3Mt0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH3MtZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 08:49:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E312F555
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 05:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aus/eQyhrO/y+WfQCzTAYf1JqKEo+pEd3rEqG4bP5Rmczoa8cAaKRMtPDW5xGBv0pF7qU+pNRyZ4kauXXVgfUE8vUefxwIsTg5vrq8pva3zTsMa+9pAS1WQwV2MpLzLXQk1dzU8pjgTbmcr/uGQB9a70nOt9OEKFZSoKtRneHueuw1iJj0faXt5uDAbsstizD/WW4+Z2o1kc6drIyVgSGestCYZFRWzvFSbc8ajN7/LBP9oHj/4yqRUPDKVOm4HfZye1HF9/DXctKqXTlf0SlQDeusav7u52J455ZV884MPshI9iSoXourbQcjAsjrcBh8yAR+thhbS77096/HfV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS3aa3T38DcPmof1+BEXpBNtJRDp3hY1J7LZvpkt4Mc=;
 b=A1+n+xdJkhzrwGt79ZJ7IA+At+9uxt9+uu0Yh4zdrUrYmjKzanphPt9M17b+7PiZiUOdxPt/BE9Ytq7NWTJCziSygkp3W+63Dq3LZm2aNlP+sdFwJvI4u8VBKgzk2zBB6BsmK7i9lEhwm85v/xzAMlVuKjWq1fjXLDd/Kor98TzBthmmRiEQXqqHHqJPNdlyX0ue17AGfYfzfY5NiGkNzMX9wTHQ3E8Wqsdl+f+EEFbzJPvJDJ31aixkDTyDmS3d1Xevl8jpWdVu1rZgDFCAQX9is8YcXV7aT2BlBh5eJApHEGk5QsOYsWjpX9khAFZv1WrR/hRGEk73g9dzvhuTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS3aa3T38DcPmof1+BEXpBNtJRDp3hY1J7LZvpkt4Mc=;
 b=pUwyEH4l1PDsiAMokT9clk7VeEyD2SH+zul2E4iXW3+Nr2Jrpt7WVnKwY5bPxWIpMgbkaFmjXqEzCmWZ9lw1E9HW6t3c+vtfoEF0ceKZS+Cged3ZF+dHDrTF8sql/+W+ET4tgyF2sndIQyRHn/LLpP07ZVipRvSYlKWgm8+r1JhZBU9MMk/xEyfQH0kRddXIg1hHhVbK424hqPYKgvxRYIocNfyF2/vIRTeI0RPMTiNcwmeIYjrt+6iTGxPqM2dqSzE5E6jaTOhGc2iEui6Lsko9BWi4Es+McFrTVoa0F4Dj/7qwjOXsNhAxvZuUMrw4dhuJkRCAAx0w+NqM3ZYI7w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 12:49:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 12:49:16 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] rnbd-srv: fix the return value of rnbd_srv_rdma_ev
Thread-Topic: [PATCH 1/3] rnbd-srv: fix the return value of rnbd_srv_rdma_ev
Thread-Index: AQHYvG2gQR06C3Co+ESynuLOwvxRpq3HZPgA
Date:   Tue, 30 Aug 2022 12:49:16 +0000
Message-ID: <ba887117-36e6-ffec-8e0a-55bb16407dab@nvidia.com>
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
 <20220830123904.26671-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220830123904.26671-2-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 485ced3e-6fe5-412a-c1d9-08da8a860c94
x-ms-traffictypediagnostic: DM5PR1201MB0122:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVtBI1H3NQ0oh3vGnG4pme0EOSwZDBSFnlfQUP909S/M5AHhhhGxP6gLdreQZliUxzyntNkcwA3jLcO9OeP8bXtJ+h+ZL2vL43fq7kEshHBfvdJLPgjxQmQej9ODwbZWaGuY3/xo04XzJOBoV5hsaor8RyUCHDbrCaaz/vuo5s7j/1oJBsfuRkWDM13PRrIrkdCDcgX1DoK1RY5CZd8UWtbvgzUvzz5LZ/rBQGcRzuDYwlo17gm4FF3/iAnc/0EYvmSFyLfp3U6rgeI3vVmOrguzZcGNu96SC+MRPdJYSZKBJOqXOeFGfwVXyd6mGLU4BpZkPPCcyln2BZyMCcc4f0HZtmfCGt4jCtIuc882cfMDYz9oG/vTGha2v5Ocujdy/M5RoJAoQK+1UprkYgoYZZA52TAdkpb4VuuA02LazfK/+4HqYYjS8yjMpIXrVdlpoVUYtLUeMqWrE0NUFL5jCB3bpmIZiYJfdcfQ2mvEuF7Y5s4r93rAjshr+bwLzIRCYuuLUOXlSIfKIK7cFGrcf6FusIniXraII9hTsBqG6oF133Qr3/Y+NOp8HBPV+3vIQt81POKJcE854VJweQH3YcvRsyvhuRSWh+R0bpi+1yNSHc1xWwgdEFpwsiY+zqJf5YnNoJp+mzBNiJ6lTb/czDMmZvU68S9fq8Pvl29W9RpXFjZPGjY5ym4CIkgMY6jAEeC3dftF0VY6jccXr8Ch4HxwHPCFvFr3BbPk/GTe8YFcG6bEupLxMFnhazlGtE8suveNPb35YeWuQ536cNbDxaAb9015OJ1ws80X8JUkJKhSbGJfaJ1jxgNhKiMY5hISISyK7fdXY0edCejom7q0+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(316002)(91956017)(66946007)(76116006)(71200400001)(66476007)(66556008)(122000001)(38100700002)(31686004)(6506007)(110136005)(41300700001)(8676002)(66446008)(4326008)(64756008)(6486002)(36756003)(5660300002)(478600001)(8936002)(6512007)(2616005)(2906002)(53546011)(186003)(83380400001)(38070700005)(86362001)(558084003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHdZRFk4czQyZjFRWmZXVlRGTWFuNldMRjYrRFUxYXMrcGpPU0wwM3YwSGlk?=
 =?utf-8?B?NnlnQzhlRUNxMGF5ZHpQUC90aHZYUGtsY1hPZmpJK25vWFk4VTAvMzJzaTNh?=
 =?utf-8?B?NFZwUjBYckNSbTF0bytQOCtLODJqN3VVR3Q5QkRkQ3YxVEhFR0VZMkNFOGpK?=
 =?utf-8?B?bWg3OGltMUZxeDdGOVVnc3lFRktNS29vZi9tb3RDa21OQTlGZzJnSnRzbk5u?=
 =?utf-8?B?SGw1bkpzdXk0R3JQTHZFV3BScFdFbXE0RCtiRjh4Q0FjRTZGNVBUdEdBajhm?=
 =?utf-8?B?YzFpVW1kdWdhditjZ0t6aWlRUmNyeTBLelNMRjBkM3JINVFQbFpGYWZMZ0pz?=
 =?utf-8?B?ckxOZGN0NWVacXZZTkpNUnIvM0JLL3ZWV1VCS2pzMkdaOGRCYlc3eERUcnh4?=
 =?utf-8?B?WW5uRE1FSmtXNEFxb1IxU2h0WmVXbVNUSHBqcWpLcEovNDNZaXJCMjkwNnZq?=
 =?utf-8?B?ODFWZDdUSDVaT0oySkY4UnRQNnIxV2Y4OUZBeUFlTW9IeGV0UE9TSVQ5NEI2?=
 =?utf-8?B?a0FhQSttMXU1TlIyZFd6Y1FqRWFBOHVidzRocWxSM2VLVUFnYTRvaDhnYXB2?=
 =?utf-8?B?T2xjV1htNWZGT1hSMzJNNXc1L2g2WUhZZDJOTlVIZndKNVc4Q1ByQTRJYW9L?=
 =?utf-8?B?MWJDQkpZaUdsYTAxWGwrWmYyY2JEOTdKNC83MU80OFFyU2FNR1A5c0x6U3Br?=
 =?utf-8?B?SmtWSG5QTlNoZXkrRmEvV0JHZ080TGZ5SzhxRUZ3a0M2WW1xWEMrR2doSGVB?=
 =?utf-8?B?Q2IzZGlOeVE5MERyOUZjWkhpR0dMcXRQM2dOemNWOTlUa3lDOGRCbjFYM2VX?=
 =?utf-8?B?bTlPT2s4OHEzU3VBbENqbVFXV3Frc1lXRW10ZVZqRHRRaEZQbzM5bVc3R0N4?=
 =?utf-8?B?TGdsMUFNVU9sYTdka2FnUFZNb3UyRnB3YnhjaDNUNnlnM1krcjJOVnM5UXJ2?=
 =?utf-8?B?SFM2VU54TGNLYk43NS9GZ2VUNjg3ZzJpLzJqcWpVQmtvTC96U012eG5ac2I0?=
 =?utf-8?B?NENiaDJreVZFRmpVbitnS0xFemUrakZsbzVQdTJEUzRiS1owN1NaMERJbmND?=
 =?utf-8?B?NTRUSE1oQXJEbi83UG9QYUE3WHBkMGpFQ2IrYXRjMmFTbEgwbEtkbFljWWxF?=
 =?utf-8?B?SzQwWGh5QkpZb2JMRS9wSVFrZVllVGgwVCtPQ2RzK3hEZ2F2UFBnRjRsOUxy?=
 =?utf-8?B?UGZsRUJQc1FHZW4rNU5yaHFId2kwOWozaHdMSDNPcG1lQnNydDNNL1AycGtn?=
 =?utf-8?B?NTJqeXF3OFZiUW9VeDN5VEk1TUlOVjFBSW9YbHZSb3dBQU9VbkhjWFREeVpF?=
 =?utf-8?B?dUpxcUhCd0pvWHNsNmphckh4SlpBcHhaV2RJd3IxQ1BMUk45NzRqZjVjRDUx?=
 =?utf-8?B?c3NyQTh2YzZmQ2NJeTV6eFo4RytOU21nUXV1VW84bWhhM2tNcGl6M0pEL1Rx?=
 =?utf-8?B?bWs5RjRmOVlYTWlsQkxqUjBJa1RKY20wb2gyWHVKeFBJck9aWnBia051QzB3?=
 =?utf-8?B?ZTRkMnQzSlp1T2dKZWNXbU9QQ1RCemZkOW43b2hLT1ZzcjlQN2tURCtscGVB?=
 =?utf-8?B?b2RKZnZ3ZlRkdG1RZkdtaW1ZeThlMkN0RmhGOWRrRU5KaVBwR1dnVVh2TUo3?=
 =?utf-8?B?WE9ycGRBOGF4ZWcrZGE1aGkrNXdWMXZPNmEyWUZCMlNCL2tIOFl1ZUhLUFE3?=
 =?utf-8?B?Mm5XT2hoNXkzZjRqKzdMYkNOaC9xUXNZbXRHR0M5UkJ4L2NHZXlwekUybGZC?=
 =?utf-8?B?Z29TN2hEYlRMcVAySDYyeTZ1UE9tUmQyOXVYamNIYkdHdC85cmhob2E2ZHcx?=
 =?utf-8?B?djJmbFlZUFRjclo5TldwNGUwM3R5NnM1akc4WkdjQ2F5OWV4N0cwajJPZjMr?=
 =?utf-8?B?L0FYZyt3RnUxR2tsS0N1c3pOS0Vxc0JYNzRGYlI0RkxKK01XbkozQkhXWFZi?=
 =?utf-8?B?SkFXa1FBM3RQSVJTay9JZFVPZEFzU0NYakJGcWFMMENBWkZ3cURXRXdxbGNX?=
 =?utf-8?B?eHJvV2h6SnhuVEFDVGNoRzg1ZHdNVVpISVhJeFFFcHRISUlLZmxjaUNiM2Iz?=
 =?utf-8?B?eXQyUVZIMUZzTUVxaWtESlhsYWF2YkNGMTZYZUpyNU5vbC83NGU4Q1ZNNTFR?=
 =?utf-8?B?NVVldU5ubjZwcUNEY0MzdFZJSFpMbWdvRTdoZmF2VTlpRnArM1BBSHBtdTFV?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43479DD3FDDC7A4DB34EC6A5BE3CB413@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ced3e-6fe5-412a-c1d9-08da8a860c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 12:49:16.7204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RA1J7+hcpyI3976iwOZIgrOlqFc/bgz99zkEzbHmkuyMjI++YSJd3fLDmI09IEzS7xXqg9I59BJtyfORa4IP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8zMC8yMiAwNTozOSwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4gU2luY2UgcHJvY2Vzc19t
c2dfb3BlbiBjb3VsZCBmYWlsLCB3ZSBzaG91bGQgcmV0dXJuICdyZXQnDQo+IGluc3RlYWQgb2Yg
JzAnIGF0IHRoZSBlbmQgb2YgZnVuY3Rpb24uDQo+IA0KPiBGaXhlczogMmRlNmM4ZGUxOTJiICgi
YmxvY2svcm5iZDogc2VydmVyOiBtYWluIGZ1bmN0aW9uYWxpdHkiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=
