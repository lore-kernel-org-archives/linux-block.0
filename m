Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 03:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359225AbiDTDyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 23:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbiDTDyD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 23:54:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2079.outbound.protection.outlook.com [40.107.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF292612E
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 20:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHnsfho7gFIKyxJUwgMuVdJ3l1YoofEZ9uCeXiixrQIw6g+b847X+cqVWzworrVedMHiV6By9fYLO5z4wpOUPJM46aUUC9pM+jZQ0Fe5WBRsE6rzgHp+pwPRVocHIqyuUC6HXqogwN5RRmXVo6q4QTNc8ieK3ZqMbvcAWlKUxfGUuaRBa6Ay8Q/CwTkJZoicR7pjtwhbWCJOjSRqW5gUAh4um4osJ1egrYkU9c1zXf7Os1VJ58y/wk1bC21MPKM+I2y8NOE7pBwz6QmrYMspUFiILkzd04lFVhJGZwLCHZ6yIMN5FbJJgJs7dg6XNmXFnynYjLc9G6IeGTBkFrPWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAKhWui5IdGbqNziTRExzWNjHZHTnSakwymXZ6J9rYo=;
 b=UjViP+jTT/WSws/8qlhnrskjENFSB5Km5nmOiUmw+dSMtKl2bF7tQhwzMh2P8g6MtwlFL5iPeRCG2/eEGjAqxkPvIHJkllYVgEzhez8JEUqrF+A40HFl31NR0henhv2PSRYPe368z04G+0fSeZxN68Gt+VT+tRvcZIpDHaMPe2v8kQzSfQoYP+9CTQx/iXR7dygwzaYMaF7KWWEYCMCTMikhT8j9wNI30vkyXnEEsQzfZIYv2GY9s/o6J20YrDj7LcggFuCsYPClHYiV942/ASL5nPITlwE+CAPPtNadNP3NmbxmLfC+GFIiZcecvOtjY5MdCtc3i+y/3mZ7mis8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAKhWui5IdGbqNziTRExzWNjHZHTnSakwymXZ6J9rYo=;
 b=Dxz+GE9xdFcAd013q7q5EjWVGkSbNhN0Q4fympIFRUSi0daTz07sFUndNhYdyvcBZY8qDQ4NUrIXdBmnU8c6Du4rbQV12IaRrJ7BjsDU/RTi4/00yc+WL+tM+DRflDyUtXx7HZYDnG9jI86WV9/dhJCt7XaZs9LkENtmRYaeMJ78zqMkib3jXAcjVSZilHzNMwgcM2zxVLx6Gs1dCbePuNDuA1I/895jiimPXj3UfR62ZQi2gF6VI9BadJdj9ejHkmCMH6+/7E9mPxDG5aJU48MFa0n7FzHUSL99ynFjaqnD0yFSWmR8nUy5reiKFrZchrhlBs4uorl0G4gkIw1Xlw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3942.namprd12.prod.outlook.com (2603:10b6:610:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:51:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 03:51:16 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/4] block: null_blk: Fix code style issues
Thread-Topic: [PATCH v2 1/4] block: null_blk: Fix code style issues
Thread-Index: AQHYVFHQXD2/f8W/GkGeNgMEBHTsgaz4KyCA
Date:   Wed, 20 Apr 2022 03:51:16 +0000
Message-ID: <929e4d66-8c07-6fea-256b-1864bd37b3f7@nvidia.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
 <20220420005718.3780004-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420005718.3780004-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fad67698-db6e-4333-665a-08da22810565
x-ms-traffictypediagnostic: CH2PR12MB3942:EE_
x-microsoft-antispam-prvs: <CH2PR12MB3942B3AE87113263A3634FADA3F59@CH2PR12MB3942.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8R79dHJC0hZUlucjkgQ3tlxdWMGX7TTRxqJyApbbb3IOnH4m/KtnHTFJxPfrOS0kqmXpyr0ZLW/K5vNMxfh1RADgShUXi6DHxDa0XsjLS1qSrBO+ifbn3b8ZmGc+oWCdfVoYPbvQ/mHFPaef78aHynefSFP+AnEHluKpFIfxvYP5Au5eV5nQMj1fNle6uAzlkRqnzbVfLZVpFJu2AIS+gUsGe2llSKWJjb9bSVVRiE02Yl7i37f1uQCNl4k22u+t+EGn2BX8fq6WRgE3YoJW+R0/6XIeJraL/gF15Ym/ywyfGjCJKtauohUBN14G52uWXFk80tWTKB102jHTng7uy6rIdiZ01eYLSGExupkujfXSw/QhZUKc+vPqsKRUHpoer7pUetJDz5On+WM2QDcB5wHAtcs33MscGW2tbX6wFgFXiiNb1eiTVGu+u70EYZrokLac1a6an1yHacqZUX7guNDZYMd8zPQNi/VZIpRs6pF0KGIUyH2hBxGSpTl18wrR29uHVh/EHwFzKUMKYlnpu0EneiP5YgUaXLqlxFAbXo4iiuRoJ8hBNvpItpqE9WSF4Ke1pzIO870e8vkGzF21VLbe24krHw6dZckQ/C98A+mdd+vmh6c2uo2iQXxzPHPG3sy9sVM93wjAyanGhTd3bITriaMflT3KXWbvMDsqu0G7wGLW0SpjGVoOoN9J2kdSyatnOe7fTe6abkfps5N0jCQgFtxIgTqHdDRck7bsq14vADNQd4r/540X4rcImfxcUt+EzE4GEAR1tHrJhzcVBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(2616005)(122000001)(186003)(31696002)(38100700002)(86362001)(91956017)(66446008)(558084003)(508600001)(76116006)(8676002)(64756008)(38070700005)(83380400001)(66476007)(66946007)(66556008)(5660300002)(31686004)(316002)(6512007)(6486002)(6506007)(53546011)(110136005)(36756003)(4326008)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1jeUxUaHpveVlzeU5NY2x3Sm9JVmdlSjJRMlkrUC9Pbys5WGRjNGp4VnVz?=
 =?utf-8?B?cGUwcGx1ZzAwaFhUME1NbVRsS29zQ1IrRUhpV3BWOUFFMHhtQ3VCVU13c0dh?=
 =?utf-8?B?K0FSaHpGb21sbFIxMnRSa0diOTJXbGgwSGVDQm9STGc3WkRGMU1YQWFVVmZt?=
 =?utf-8?B?dzR6eS95NXd4RTJTNDVWRVQ1ZmZ1WmJxOE5UcUkvd1o3cVNxTlZjR2NDZm53?=
 =?utf-8?B?YUtzRGdOYmN0ay9veHpwOXM2WWpUU1FWNmd4UHJwRlVWZW52QTdnWGlvbVJs?=
 =?utf-8?B?Y2RQRHlmN0tvbGpwRkhCSjNRY0FhK3cyV3YxU2ZDNVh6dDNRS01DemhoN09I?=
 =?utf-8?B?THZvVDZjMFFTWVZtbE1qbTZDL2ZyM3ZmbHRodzRBcXlTZ1JNalhtSlFxZWVI?=
 =?utf-8?B?d01DSG5kR3prVDZxdnJwckhEVWhDa1JCaGhDWXFrT0txenRxL1YyV1JjNlJN?=
 =?utf-8?B?aHUrM0EycHRFVlZtaHdTZEJzY0l3TmhjcEIvUHlwWkRVc1k2bHNWRXVaQUJW?=
 =?utf-8?B?RW5GU1pzVmNDa3hKOVZ4b0FnT3pEN2pBRXZIa1lVb1EwblA3N1VYUXdhQzI5?=
 =?utf-8?B?MlBpaHEzQ2p6aXd0MlFmTEpiVDYzcUNsT1ptYnJSTzB3SVk3ZU9MajNZRHgr?=
 =?utf-8?B?ZGszRStNQ0NBOVpWMk1yZGJnaGpwOUY5Y3dsZ2VVenZNeE1hZ1JaZndkckxj?=
 =?utf-8?B?ZlcxRWtReXdCUHR5WkwrWjUwZzRwY1lRblp2ZXhtNnlsNkZRSFNIc1c4SkFr?=
 =?utf-8?B?WHB2QjhtcnAwV1RnU09Sbm56Q2paNzBNUG11bkdsYzBibnFwZGVzMEIvWks0?=
 =?utf-8?B?c1hyQnlOL1VIYmIyNnBNSERURW9lQ0psUGZMcnhuVEMvSkRPczF4TCsvSnRC?=
 =?utf-8?B?dWVNamNSdCs2Rm5TK29yR2NCZ2t3UU5xeFQ0amZJVjhpZXc1ZzE4MEtiaXZn?=
 =?utf-8?B?SE5pQm85cmpmYjMyYmR2cGdoYlkrb1NlOE9TL2RuQXFGQXk3aUJSdmlEMkRq?=
 =?utf-8?B?S3JMSjVFVVArRWc0T2RvckdsYUIwK2p5ZFdqTjMyTjUrNFJaVk0xd0JleER6?=
 =?utf-8?B?RUh5ZUhYVU1wL0RxL1VOZlUrd1hlT0tHekR2VmN2WlZnNGFobEU0dDlqWU1L?=
 =?utf-8?B?dXN2TkpaSWw1dC8xWFZ2dWVyMDBFZWRvOVJzZVV4UWs5NWdTckc0T3RrMjY0?=
 =?utf-8?B?NU84amNzVXhFeTVScUNSd2s1aGlzL21OcGNhUG9WNDdKa2dLOXZKdVJFbE9J?=
 =?utf-8?B?Y2pNa0RqTGFTQXE1LzI2RDBBQmhXMVI1MnVYV1ptbncvWlZYTWx3VjgyUmph?=
 =?utf-8?B?Z2JNanZKNVdCRzdZQ3RweU9iZGF0MHBSc2M1UVA4ODRkT1Z5WnZoQW5lcXp2?=
 =?utf-8?B?ZVRiYUU1WmwzV0tPcHlQNlBtd1dkWEYvV3lzQzRObFlPMlQ4aEt6eGlma1Fs?=
 =?utf-8?B?RnBaTEVmRitlZWg5RTlTN1hTZDlrdUhLY3BPcFVsWTRWZWEySUJHRm1PL0hL?=
 =?utf-8?B?R3FOTVg4YjFVd2twQ1RveUlxSDB6ZGJhcngvTTlkWWJycFp3M0tDTms2cW1k?=
 =?utf-8?B?T3NuOXFLL2c5OEY3WE1RWnZYREdzWHFCQmVXTDBSSEp1UHlXdFZGTkhTbWlU?=
 =?utf-8?B?eVlsamIvejdiOWg4RFZWTWM5Zk5uem5saEpBd1I2aUFnZUlmeXRjbzFBenBN?=
 =?utf-8?B?UE0yVDVPakk5dDcrRFIwZktjWERmTTh1cTZRV0VJSVZoanRHUzBseVBMbjF5?=
 =?utf-8?B?emtzT1FRelN1S3BUMzNVODFxamM4SnY0QTBUZWlOclRpUTRmUklmbEtvQ040?=
 =?utf-8?B?eTV2QXdWVGROZzJBZlZBSVowcmVrSUF1a0tseHlWdkV2Q09saWh3NUdFSTRr?=
 =?utf-8?B?MWI3ckI2QlcyY2NySkJreDdHTzlMRTBRMC83Tmt1aElCdEVCMldxQ2RXVG40?=
 =?utf-8?B?dFBWMDhYUzA5T1kreHpwNnRRYVNSOXNPUEo2cVF0alJlVTFWOEUxYkVNTHJS?=
 =?utf-8?B?N21xeVRKUjNpVG9weVBKUjF4Nk1XREFxeVI3RzNjeStjdFBrakkzV2VQWlFU?=
 =?utf-8?B?YlgxV1pPZHVFRE9XM0svdXFYMkdiTi9VOEdacmhVbnZpemhCSkJoSEhFbThU?=
 =?utf-8?B?ZVRFdmFZRG5aMUs3VzdlajVZcDhyS0c5RzBDSFk5MXJlSktkbEpid2JGTDd6?=
 =?utf-8?B?dXZxS1EvTmZZSkY0UkhBN0Z1SzQ4ZlBIY1FIUzhlMHRMS0syM2FnZTIzdTVE?=
 =?utf-8?B?ZEwrWDYrMjViMmJjU0l4V2lNdlVYUmNIQU5Ka29lM1IzTGJ4QUE0dU04djVx?=
 =?utf-8?B?MFVCZGNLdDIyWFRuZ3NzYXpvYVo4ViszbFlWRmsrTzY1VmpjZXhuTVJBa2Fz?=
 =?utf-8?Q?xYHor99N6t5mBatmQNo4Jyv714nubCg/iBLECiYq/4b4O?=
x-ms-exchange-antispam-messagedata-1: 7sBZ+vT5SyTMEQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <734723D7ECB05843B7E0DE83491536AD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad67698-db6e-4333-665a-08da22810565
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 03:51:16.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aee1B1vLrNDtIdIWDYRHmwqSI/3o3UpKtVohS6UtIS5C5AeM/tf0n/ADoMiCS4NumHxu7a520ltK5i6DG+OgDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3942
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOS8yMiAxNzo1NywgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEZpeCBtZXNzYWdlIGdy
YW1tYXIgYW5kIGNvZGUgc3R5bGUgaXNzdWVzIChicmFja2V0cyBhbmQgaW5kZW50YXRpb24pIGlu
DQo+IG51bGxfaW5pdCgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWwgPGRh
bWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==
