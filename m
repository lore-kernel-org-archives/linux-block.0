Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6904C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjAaVnH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 16:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjAaVnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 16:43:06 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A650525E3C
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 13:43:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV1/rfA6ELxUz+yRnlw/sfJ0saQsNF+3vAWxJIexwGVXZtIrc3eenv4yjJVRP6SLwKX5CKgSismHlb7PJvZOz+d945l5nqx4kGBPDgfIPkjV1l8G2i/PzH7v4NVz8QQ7ZkMvwMsUw5mzEUMuMwPRtC6jGsTEqMxevST2hT67+HdnISVESk5Yu6Iobe8meCGG6vbbAWhNMGBhsx1cuSE+Gv2/bLGXUyn9YufPnZ2EZksvAYZAT8HD3QRU6HFKk/Wt3U7/CxlGyLSE2772WDOIxLTiSy4Uzifs/Lls9JViN9DrgUw1FlACn7YQfzJurwxTrFYZUQi4hc0HltfgEfVUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7vYI3ltp1PsdNfVdRD2LJDjbaG34jNmLV0UeHVN6IM=;
 b=Gm8Q2Wz7uBTYEm3T28JrwmStIZaPgEworw+7Zmucz+/p11Drda1HR2iCjEpvOtdrlDG5Nm6+PJBVBZSwnLS5aYBrHddi+oSRJC1/HRRBB8LtgLOwf/K9EWUBeJsdnWdmg2Rk6nqLARX2EowENZVHBEnDMkQdRMl+vvZlNZl7q57hUxsJDMyH5m8cScUeA9/9tZS16JEmte+z7kQmSHIfcAJ8xTsqJzsHRrcbAaTAlUgNypCHERWHRB2T9azgT613DGZ1piP512sj1Mk+ettR/3JLBtEFGcKXCpDaOJCZWbaHn3MgUU3rjcXKmDhtNfydDdbEG249bhI+Eb1Te5t1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7vYI3ltp1PsdNfVdRD2LJDjbaG34jNmLV0UeHVN6IM=;
 b=QjX4FZOPsuqCPNG/OoyfO2k3pdI4VbBw9fi+9bJPpRSDT7FQTQyBZ7Jf0+vXoK3Ku8DpyRRA+Kzc2IVnDamWfSRlkn+glaH8t+c+jvH22YECBmLhLHVhWQxnZ8wQ5uRSGxNsrrLEbdyyCi60jvq03PyV3EdYqrI5Xm9gPTLhuXxReBhindghTM/vP/KUxxSjTo5GIjnN4G8lH67aW3B7cibiPDCxoO5Ftm4cDDkQ5MXqQSfJrwtbLfF4B09y/PN0pGOEVvYFrahy2omSFeOE0suQK+NtDZjeRL5EGn0eXBkE1zO6WZTTLMczVESAxg7tgYpeqjPhTjAef5TKLvnAvA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 21:43:03 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 21:43:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Thread-Topic: [PATCH] null_blk: Support configuring the maximum segment size
Thread-Index: AQHZMrPK2gDTbmCbwU2CQVjx2fYr/K65FJaA
Date:   Tue, 31 Jan 2023 21:43:03 +0000
Message-ID: <8bd89413-bdef-7fe0-9e19-4419e9280f4e@nvidia.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
In-Reply-To: <20230128005926.79336-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|PH7PR12MB7162:EE_
x-ms-office365-filtering-correlation-id: b8ec17c2-002a-4e07-ec4a-08db03d421a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QeKpGfM0lhB0/+GpFNFTBcMWWdTN0TDDA6s2ZJRSJvdUkGotk/UAE0jGe+nrzEvKx8dl+DFBxQqljyMrt2/cr+vs8PGL0RTNMmP1099CsOBGXPvgPDZwS/9/MosJLZ2O2VzJUnWz226dpB/HeB4x1vKT850+qdtT+xshlK5AAa6WhNJL97VjEl7rqlJi9KjIcz1ChDnOgYte/ObnEmikCav2bC1Tfn1Uo76hFTz3bIo407+i9bswx+IQmB8bFP9DNnJ75J/DDR0TWHzxReI4S3bR/YdkiNqJlDEKcEy3cbA0hmQdnt/pt/54Nm4VGyGgnLMCnWGBFFDmj9CydEQaA8rTRKIZt+53PmewtwRr0DjLcM4G7afVD+GIKZMKF+F+cVrElo830vvALpISDpQ7SJrKibZcFBjPOwUOVxQSkysmYpuLXq+zwDOHZQrJkv7yyq80gxMnQy3Vc8RXKdXmmbdrtnupsw3sj33X61KKcTn5nfiOO/CbK52jxdh/YuKjJUqNdY1UQ6kwg76guW58Mou5af/OJTDK/1uLLr5xIpyQaKIWgYl31nUxT7L1yi1WiXo6KUVRdncoP3S8kZj68XUllD/sygBAaJ0TCjt5mdUnwspeIbLS8AScAiSj4RwP8GFEHrK31kue1kD7n5zdD6hzEhvBtvpLibhdrESPsc6Is87TtM2sKMTVqnmnIByceaC5J9uCNb/U7eVkCweTHpBlPmncFytifkYzQtGflq6zGarHoEV2feckkVOz3FP4M0JnNgxQRjJuEeu5ObWiSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199018)(31696002)(71200400001)(31686004)(66556008)(66446008)(66476007)(64756008)(76116006)(41300700001)(66946007)(8936002)(91956017)(8676002)(86362001)(4326008)(478600001)(122000001)(2906002)(38100700002)(316002)(6486002)(6506007)(186003)(53546011)(4744005)(6512007)(107886003)(5660300002)(38070700005)(110136005)(54906003)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnlrVTlpMW9iN2o0QzFaMW42dDZMUDA0UStpLy9sTTQ1cjVTWlA3NjNOdzVk?=
 =?utf-8?B?aCtHZlpubHNCSEFCMEJIODlNMDN3aFBOVWZIY3hrdUgwMDNSc1JSOWVXVXg1?=
 =?utf-8?B?OEs5aURJY1IvY0dHMjlYSVFNN09CTllvMmNSSVFBZytaRUZBRzFySHdzMmps?=
 =?utf-8?B?N0dEQnd4SEo4SFo0UDNPMWpBUm93NExtZEJaUWF6b0VicTloeitPMmQzU1NB?=
 =?utf-8?B?Q3NncjJNaFoyRTloaGRtalJYUVJrdlRZUXpWeWRJRDIrSWNXQnI5NmRickFU?=
 =?utf-8?B?T1dHRm4ybHYrYzlTK05MbmNRSGc4bzZwYnNNMVBzSWp4UWRJV2RZdTRyQzdx?=
 =?utf-8?B?SGZZcmJHVnE2MmJFcVVzQnVWMHNBbkxjSGhvenRkTGg2aXpOWXRUaGxZODc4?=
 =?utf-8?B?ZFpzeE1QbVNKMEV6RTVkV3dOQk84MFRHRElQR2VVVEdwbk5jL2xzTzExdS9C?=
 =?utf-8?B?cklheUQ4bWp5S2VPQXZuT2h3Uk44cjNJcDJPeUhuRldZZVd5Y041QXhDWndK?=
 =?utf-8?B?NHFjczdlZ29veXZmZk5FSXVnZGs5MjlDc1dqSGIxbElHREgwNzcvY1R2UDA4?=
 =?utf-8?B?VzVVa2UvK0dhbGJCcGRNUXNZNElCZEhHUE56dEp5NWRxQTlLQ3k0bTBUb2I5?=
 =?utf-8?B?aVJIQzNvWEg3a2EvTTZ0YmhxcWVmOTlob3cycE9hL1pTVDUrelhpMXQ0NlRS?=
 =?utf-8?B?aGI2WTQweHpYRWVWaVowbFZKb0puVXk2a1Y5Y0ZpdzgvUTZEUGMwZnpQY0lK?=
 =?utf-8?B?ZGN3bHMyM01Vd2dxWFpzTjFHZEFmV1g2RXhYTURua0EyN2gyUExueGtYdGY4?=
 =?utf-8?B?bHptSTQ1NzVWdzZMb3dlNjJJQXpITTJ0ZVJJOFJKanlpNmUxNmJNMmJpb3h2?=
 =?utf-8?B?T3FMVWp4a0dycmoxQkJTcm51T0pYcVQ2TlA2ckVwRkpDRm5QUVhmeGRZVGNr?=
 =?utf-8?B?TnFkRnU2azJGLzMxVjVtRVYzMVBBb2JUNFpFbFpBdzhpWEhheHRKWXBkRFVq?=
 =?utf-8?B?SWxLZVptSWJ3NXdsQXhCWWNBOVFHdGloWmFYVTRlOURCeUZyL09NRDA0SUcv?=
 =?utf-8?B?aDduQnpRL3pmVmhxQzBnVXlBVytRQWx6Y2dLT0N3d1VvcW95RjcyYXZOYzlR?=
 =?utf-8?B?MkxnS0M1R2hSR1FTU1lkY1gzMnc4a1MrSEVyQjBUSnZtUUlCRjVjcVRlUUxk?=
 =?utf-8?B?Y1ArVUkwai9DcTVlUi9nTUY4MGhURHVBNkpEUG1xOEFtUTJsYk1qVUZ5bWNx?=
 =?utf-8?B?TzBKU0Rpd3ZGdSt4cGU5TFRRQkhlMk4rb3dtVlZHZS9vNHV1OUo0Q1RLMkRN?=
 =?utf-8?B?MkJ4WjB1Z2VvVVNRcHhNVmxTYlV0N1B1TElEWlBaSGd0QmdGMmFTOG9ydFZD?=
 =?utf-8?B?K3JtcHBxcHo2UHhMenJXRzJLN05wNFh2M1pDN1RueE5oc2dCV0pyRlovRzZs?=
 =?utf-8?B?di90UThQNHJBZThWaVdXSm0yMW42dE13dTlyWGVDNlgwRHFRUDV4WmlDK04y?=
 =?utf-8?B?Y0RPYlUrb1RQQURpaEYxWFZWYjRHT1pmbEhibnRvNURPQ1lGN1ZGSUw4MklF?=
 =?utf-8?B?Z0FTNngzMUZ5dHF2NXZFS3NyZWY5c2NDaDRGL2ZiZFRvMFpEaGY3OHY2emll?=
 =?utf-8?B?eG5hQUhYWHUycXhqOG1XdDVTYVR1eWtHQ1RKSjVtYTV2a09WYTgwV1JDK0xJ?=
 =?utf-8?B?Y0haaUpqM2dDdVNxMVNHRjY3VXhVcThseURUTU45M1lGaXp6bEtveHFwRmpY?=
 =?utf-8?B?cHRubTBKM2RvZmFpTTVMZUtGQm0rKzNmcDJJNHdwMTA0ODROQ09YbWs3THVt?=
 =?utf-8?B?MGtBb01BSkIrUlRzejl3aENYeU43cUMzM1pweHdSM3l4V3NMVHZXNGk5TmFF?=
 =?utf-8?B?L2NjY0k1RlU4cDBJbS9nV0NIakRJKzIxT1RPbDA0cGNkRDZwZkVVTzh1b29j?=
 =?utf-8?B?MG50b2xSY0hTSkE4dG9lUENWVXFSUlVnL2U0OVBlRnV0TVdQbnNRRTVDZHBo?=
 =?utf-8?B?Z1BGbTFrRjh3TUtGUHJBMGJPMWFiN1lDOHRnKy8vSWVsUUNBaHByYVU4Ui9H?=
 =?utf-8?B?Vlh2dzA5WVhzK3lRRE1neE1zcDRmRzBHd1VwQWEweEJhZHhBY0FsSmp5ZE5L?=
 =?utf-8?B?dHJXWFQ1SEw4Q3RWNG9GQ3dQR3Q2MzQvazg3dFVRbU1HVjAzZ1NKZU9YQS9M?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A5FCC14AD5DC24286B550E24783E3D6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ec17c2-002a-4e07-ec4a-08db03d421a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:43:03.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4ZAP2khis0835g5HfWrl6/iHTgo5XaSRy8qnpYqnEbL2glo5kKby97AQ7FNPbDAQSKaaSSM1sJMTMCQkNHGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yNy8yMyAxNjo1OSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBBZGQgc3VwcG9ydCBm
b3IgY29uZmlndXJpbmcgdGhlIG1heGltdW0gc2VnbWVudCBzaXplLg0KPiANCj4gQWRkIHN1cHBv
cnQgZm9yIHNlZ21lbnRzIHNtYWxsZXIgdGhhbiB0aGUgcGFnZSBzaXplLg0KPiANCj4gVGhpcyBw
YXRjaCBlbmFibGVzIHRlc3Rpbmcgc2VnbWVudHMgc21hbGxlciB0aGFuIHRoZSBwYWdlIHNpemUg
d2l0aCBhDQo+IGRyaXZlciB0aGF0IGRvZXMgbm90IGNhbGwgYmxrX3JxX21hcF9zZygpLg0KPiAN
Cj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBDYzogTWluZyBMZWkgPG1p
bmcubGVpQHJlZGhhdC5jb20+DQo+IENjOiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBv
cGVuc291cmNlLndkYy5jb20+DQo+IENjOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9y
Zz4NCg0KQmFydCwgaWYgeW91IGNhbiBzZW5kIGEgYmxrdGVzdCBmb3IgdGhpcyBpdCB3aWxsIGJl
IGdyZWF0Lg0KDQotY2sNCg0KDQo=
