Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB1C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 01:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCVBtM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCVBtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 21:49:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6C59801
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 18:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzBTfdk3Lb5rfVtiMk+11LSbTtS8NtQp/7GoE1Lauk+x9hittlXWAfJEqUN3S9ECN3IGMuNhgbgn/EqzQ2vW+hTgS/uSC7ngOYimBStxVx6KUFn2bGHdxVe+fexy0DqxpDH0htyQqzA+xASrwHMaFWACf8s7dYbeq5aeX0/OU5PQJsclDFD4MWNU8kLtvXzQOf8gIExVxxk/yLjvciMJZcMcXX673vxIqc9vHrO5UVdSIWvQpnSRgCZKZKqckzXd45nVyfP+93nGb0C9Cn7UoS2iOtILPjU9EEpxkTelEYiVEdg7D2GjhJcDz4mzHw7fljQGKco89E/80uEd9yXtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyOgoAmA1WWPGPI8GTWe4K2VK0JG50Cp1Bln0xVZdec=;
 b=V5dbb3ZcxtvfZBpbOhaYYE30GatBiitjWlsiCQSxGYvaykH6QfUL53tr1MIUEYramvNkCcnlgE2ydGuBoVJzDuBDrf9ad7+i16KyaTUEfOQi1WOqQipcH+0+KPQ/Em3VIitBjrIL5jCSfy1Q1mEtPWYhQjw/T5kV/Ay3iS9TkfIpU4lsMOHFD1EjofP2tljlWgMLXfzfHnHsbv3r8hdN33wFpq1r3k7R2+wJlU6s72wYatU3pq6uSB/diHmV2/iwSXwYGJNgqfEhkbQYdl2ga4Ulv6cG9e/WMeRJP/mcZQwDHfBvjLmBYPelkztEaex5QYUMQvi5qIoRZ0R3XcQ9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyOgoAmA1WWPGPI8GTWe4K2VK0JG50Cp1Bln0xVZdec=;
 b=UUP90LZqRuyEKtZd2pmShYeUyKZhunzvABUGO0w17VsscT1TZFM9vDTLZOPVHA1wf5nQwF2/UoQEHqYGHHYVCHBtjAEv1/A1hcgaLyuwvATEurEN1hREKJqtoHPTJ4mRuCgyp9zlbW8zzDavTfEx4BpJL8g0yYVGp4416hSp5ibzt2UwDiI33Eg/xoCB0lx5XMrhGCK4QzNo5tWXD3Z8foI4gMHSFQU6Uumt+pOK2Fj1az8x0uQBcuH44uhZu0iNblNttTRLpoF0yaoFBUYDgFEnPGyUaKpU/Tf3GIUsVHzyQ3Cjxab9Tk6L1cgisT4OMLDU6MCu/xJ7xyd/Ds08QQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:49:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:49:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@meta.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: fix forward declaration for rdma mapping
Thread-Topic: [PATCH] blk-mq: fix forward declaration for rdma mapping
Thread-Index: AQHZXD8toywL5eZpYkSyPUouJgC8vq8GCHmA
Date:   Wed, 22 Mar 2023 01:49:05 +0000
Message-ID: <2d5fe4e3-fdd0-b58c-c5ef-0a4ebbba2647@nvidia.com>
References: <20230321215001.2655451-1-kbusch@meta.com>
In-Reply-To: <20230321215001.2655451-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6047:EE_
x-ms-office365-filtering-correlation-id: c8bd74e5-01f0-4ce5-fa10-08db2a779edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MiiV+r05qXmvGcMBJf9Z7rDMzm0vVQG1TAUn88TOctVWuo9zUIQvEmELchl3EvivQaAi7gxoVG83fwM3TxPFN89g0FwRHSCYJTK59OvQlMOJKXrd/MlP8Pipml+Ihp+ht7fvNWYOb3fWlnqoRwhZMi8xcJOdPl1OL7uBXEnahoQ8Xlryz8egR20kZqo/O6B7XpIWHQ2u6Ww2OdV5UP5ZzhNOxISXyFOb6/TtIyW7IDA45jzlcmDO4QP1g6eIukU8AMiz2SlYErizBso9V6ONnBEg8XrB/Z5cM5HR0Xs4I9N7gN3aVWCry3zt3buMiVEErwSf3JIkeFqtpC7rN16/r+VTicg47tIYVksH3twq3tA0nUzyfrB4iJuI6uvjp/XdnUOq9RB4aQerG+eV3U1psfyxFAeOTjEtOssXzvs01rj2xduEFD5SjjYveuWP9L/boP1NPOwjqDCIDJo4WGgKdsY/WUF1/0/TwOyhDsyfuqe5jw9XsgYyXxZTLS1MqiZH6ozr1VmTnkcup17P09QWUfeegOkpiZ82MLqGm6AzBaF7pjW9GTCCRUE88ZT8BxCBYC+12qqRWtHPEWQ5A7SRlbHwW04N/Li44Jn0X5un7chX7oY6FasSv+btxL1p07EFhCBTE9xjLKHC0GJxhLq9DQ2yIcG134aJOiMAuGyxjd31wyoELkDSoP4kDdUFUoVSnzxBF+dktVlAPXKTVyplITbBMgEpxrmWZhJUzBTzgxSUFWp56EvMUW1j60o2qm3SoN2efb39fMdJ0cxLi0fJOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(41300700001)(8936002)(83380400001)(6486002)(91956017)(478600001)(71200400001)(36756003)(54906003)(4326008)(316002)(31696002)(86362001)(8676002)(110136005)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(2616005)(2906002)(4744005)(122000001)(186003)(38070700005)(38100700002)(31686004)(53546011)(5660300002)(26005)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGowOEZPUVR2UHdVTlJEbi9qRERDMHJsRkNmenQyMjVqZUJCbDBvL2w1bDQ0?=
 =?utf-8?B?OTlmWnZHalNTbDhrcG1SNDhUUVZzNElVSWVDUUQwR0ozWTJwZ09CZTdZOXRE?=
 =?utf-8?B?bkFZRUJvU2lKckJqaTFndGRuelozM1ZSZUsvZ3I3am5iLytiTVJ1Y0QxNHBB?=
 =?utf-8?B?UHZsZGxaUFFXVzRaNlV6K3F2a3lBWjdrR1VpWjIrT0cwWG5ZdWozaEgza1Zt?=
 =?utf-8?B?eXZZc0RvZG9rRmFIeTJnSHczMzA5dlJxeTdVTzdia3JYdzZrNGZ0Tk8zWlNN?=
 =?utf-8?B?NTZvaGtBYTFkZHJQNml0MkpmU0dDbURqUVZoRzRncXZxZExGQmlBUVFrTFhR?=
 =?utf-8?B?OFoxZnpSTldybU5PVjVIYmx6bSt0ZGZ0SjAwc2RURktjQU5FSjlBYzhhZEh0?=
 =?utf-8?B?QlppNlBidG1CL3VmMUhOVUpGdWhaQnBNTDM1dkpIS2tYeGM1bUJ2TGpIK3NQ?=
 =?utf-8?B?SUtEWFpaS3VmRUhIL3RSUnJSWXhEVEdhaDBnSnA0aVJONVVsaWZ3aE9lditu?=
 =?utf-8?B?eThZM2RCaldlWGlaNGxhRkdYVTNqeVJzd0h3cHJXT3BvcDJONHU0b1NnUDJJ?=
 =?utf-8?B?bnZiSEtFK2QzT2lXaS9UQi9ZWTF3QnZLRWpHU1pjRm05TlduQW1tMmI1Szh1?=
 =?utf-8?B?ajJKOU51VkhaclkxUDh1amZBVVp3ZEYxaG9jKzFBOXdNYmgvUjN0YndCdHI4?=
 =?utf-8?B?Q09UWi81QTErcGRiQ2ZwWHZlR2wzUnNPRHZZcWtZakUrcytjRlVJN2hpOThD?=
 =?utf-8?B?c0Q2SkQ3b0grWjMxcVY0MFNyaHF0UndieFJ4eWNXaERTRm9hMXNOUCtFeDNN?=
 =?utf-8?B?dUd5bWt0OU1FdzFaQVg5TzA1MVpQWjFqQS9xSTJKNmtqRnpLSW85Q2RHMzIv?=
 =?utf-8?B?QVpvS3RIZjZYUUVKNU13eExIM09rWHpqUk1FaDNhck42YmZ3bTd2V1JxVSt5?=
 =?utf-8?B?TVJMMVlHckJxTDRNcFlOSnBzZmt2MHdwYWtPczhwMlJscEZqeFRuNmExTGFH?=
 =?utf-8?B?MWdSTDFBTjN1VXZTYUZQcjUxR3V4ajJxZ1ptRWF0ZzNoa2dUZERDeXArL1Vs?=
 =?utf-8?B?STQwSHYvNTVMcFhXWVo0ak5LK0JGS21zUWU0Z09HUHc5VTh1cXdVWmRHM0Q4?=
 =?utf-8?B?QzhISDNYejkvQ2pVNklYWC9XV1BxZlRhMWpoYVp2QkMvU0xkakhqcmpXbGFE?=
 =?utf-8?B?dHhXbHI2d05uMjAvRFdwTGNGTzRPNGhCTWpQaW1XaW42VlF2Vlk4TUdDRWNp?=
 =?utf-8?B?b1M2UlJiVXl5MExpWTgyVUQ5VWNRcno2cG9Ecno4VmRkWEJmNVBMTUUrbEYw?=
 =?utf-8?B?QXp2V2dQdFBDazRnZkQxTG40QlVMbnRZZjRkWmxKWkk3Q0tWNm81aDNnVHl1?=
 =?utf-8?B?cTJpN2NIdWswRjBicjJlYzZPTDNTdnYxWHpkbTZyRnRWNmxueUk5d3pJZ3ZN?=
 =?utf-8?B?azM2djFVUHhwR0RuTUlDQnRyaTZWZldleDBlNUdLeXZ5MjJBYnE1ek9rRXQ3?=
 =?utf-8?B?eWF4eHJkRnpzOE1pR2lwVGpIN0JjNFprbTFxRVgzYXBUbVltTlcvTm1hZVUx?=
 =?utf-8?B?amg2aFI2TlRkdmRvSStQOUgzNzU2NlUwYzZHVXJlbGdiUlBuSURtUndVNUZJ?=
 =?utf-8?B?OGZ1Rm4vbGpsWUtrT01PVzZZMW5LODJYNXhWSzNEZ2c2MDY2VjU0MERjY21x?=
 =?utf-8?B?UU1HWGRqVW83ZUtmbzlKT3FJOVlxelVwSXlvTXdJWTI4bGJzKzRrMTk2YWli?=
 =?utf-8?B?Slh0K2JyRjlNMzlibUdlbWcyQTk2Vm55ajRNVTZPSDJPb2ZJNFYybUd3eThC?=
 =?utf-8?B?TXExSEtxN0UzWXdaMzBrd2VmaGFENlgzSklHU0NBOUFGd3RvbkxFQTNVcVlQ?=
 =?utf-8?B?MG5Nek5QZHZOVVBteXpZbGE3RTJJeTBXYmp5RXJMNmEwcTlmWDhXWlB2RThY?=
 =?utf-8?B?VGUzeElCalFTRkRKN3ZiV2pidUdLMHkwV25maFE1Q2Q4K3JXazlVSXNVR1hW?=
 =?utf-8?B?cEFhajdCVG1YMHUxZ0QxU3ZXZXU0ZitQdWc2VGkxN25aT250TzJPQ1RyT2Y5?=
 =?utf-8?B?aUhKWUY5ZmJabnN5TDJEUGFuaW1rZ21sci9iOUUrQmoxVHZyMndkWSt0R2Jv?=
 =?utf-8?Q?femp5wUVhjRkoh0CUR8AC+/wK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD106CBE8148CD4CA893E96C7792C291@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bd74e5-01f0-4ce5-fa10-08db2a779edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:49:05.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QI37Yf+bwW4l4VHLG3QYrAsNZMF5mbd8Bs42KEvGl2v+uUGVF0G4zes9Q7/+chLjXfXykwOwkf3QBXUiU7HX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMS8yMDIzIDI6NTAgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBC
dXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IA0KPiBibGtfbXFfcmRtYV9tYXBfcXVldWVzKCkg
dXNlZCB0byB0YWtlIGEgJ2Jsa19tcV90YWdfc2V0IConIHBhcmFtZXRlciwNCj4gYnV0IHdhcyBj
aGFuZ2VkIHRvICdibGtfbXFfcXVldWVfbWFwIConLiBUaGUgZm9yd2FyZCBkZWNsYXJhdGlvbiBu
ZWVkcw0KPiB0byBiZSB1cGRhdGVkIHNvIC5jIGZpbGVzIHdvbid0IGhhdmUgdG8gaW5jbHVkZSBo
ZWFkZXJzIGluIGEgc3BlY2lmaWMNCj4gb3JkZXIuDQo+IA0KPiBGaXhlczogZTQyYjM4NjdkZTRi
ZDVlICgiYmxrLW1xLXJkbWE6IHBhc3MgaW4gcXVldWUgbWFwIHRvIGJsa19tcV9yZG1hX21hcF9x
dWV1ZXMiKQ0KPiBDYzogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gU2lnbmVk
LW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiAtLS0NCg0KTEdUTS4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
