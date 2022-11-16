Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E12C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 03:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiKPDGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 22:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKPDGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 22:06:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C761704C
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 19:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOkJoJiLKKNNhJM9c7+sj3w6oV9lqqcEYfLtwFjimynwvm0c7nwkvVrZBCDTwNQL5XCiun6dAL3PIaLgJF2lVUyWvqnkIY9DYsfoFvrv7Ef6uNgz5htWm2a8SW7UqOxck0tB9DPMKrxaNfCpfDMcOct24XZKUaRDYjk1/7lCE0UO1XaEYmZtYQCMPwF+stiK9nZgdtQb/08XQXgXnrdsX2LG+e6ZuEYZSCitA6AJQbISM4JuHBwmAENDVr848LBd2AINNwri+cAXsv6wKW2OMAnMBNny8tBWsPS4KdyRyiogEKAIAxen4LqmzJbAqQio0WUaj/jWqRoL6DyuvLdTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdFRg7MHRY/5NpDEIx37CE25frDMxntIm4oYk1hXbQM=;
 b=Vi6gP2Z00I7eLs0pyPHbIYgtX4x7AuR6HXZeL+mc9pOM2Je+R8t11T6PF7vgJmwzud5WoRZW7n86kjBlcKuufT7n3oD4I4o2BcLcNl4SbolpBQJaVM+6pCr8A66FgPcyD1bj+rz9SNVGyDwSDlN9MwltJt/wu8S6kTjh4DEXpSHjtUmnOOHRSSnJXMFFVcgh+P+G3RhdVt1+DDj5RKwrAZoDsNQu+gD34xXTczAHhrYvKDm5nQmJhnBmYPFJXw6CglpvwG7yv2Cpvs4h8X07i8gEqqzXvYEIn+kZbih6qe+YKl+63dnqZnaE2Jpb9ZHWKmYp6OJkQhpxzWAXlQG0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdFRg7MHRY/5NpDEIx37CE25frDMxntIm4oYk1hXbQM=;
 b=gUk+STqP7UCkpRLm2uG88ofkRI7KeiK7p8rUSREpofyLyiEB/Fzl2ta3dBsQA0QsqEbhNtk2fDItBujkZ8AyqYMkCqmHJr66i1aDiHLdZLGn7QMottdOxoUvdBqimA+n6eCf1Q2jupttNzN8dc94yywFMSqFeXainJdS9v7JBbD/4mRYZckjg+ng35WZZRo4SIdh/xsO65Sz+78pWisMmeVVMnKfm3t5f7D4G63ktN5zSouBkJaBbRgk/whhAY8dz4pRpF0+gXN2mo4/8RUL2OtUY/FJ0p2UpC/BfmCW8umCR1a4/tgBN0WXBGG5H+4Y9NGX4vdDkd7O2+hma/AlVA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 03:05:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 03:05:57 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V3] null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Topic: [PATCH V3] null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Index: AQHY+KUweTWzuPvzC0ikyAcCie5mAa5AzNyAgAASigA=
Date:   Wed, 16 Nov 2022 03:05:56 +0000
Message-ID: <7a012202-4c58-9bec-6d36-d7d13804cf3c@nvidia.com>
References: <20221115034834.44142-1-kch@nvidia.com>
 <ee9d908b-6516-77ce-65fc-6d45042aafa3@opensource.wdc.com>
In-Reply-To: <ee9d908b-6516-77ce-65fc-6d45042aafa3@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6471:EE_
x-ms-office365-filtering-correlation-id: 4a66176c-0a89-4d71-653d-08dac77f7b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wG7rKyxjCmI8Em4CucmRR8S5aSykmSNDLL8Cp/mRKye98qXKSOIcUZAaMEoRRFkgHIk87PIb7jN5oyLZOCrLlVkgKy+nj9ymKiwurxbT95Dc6tUtoudvGqSlS1SIoCtrqCPW5vdSahXfdvuKSzkE2fIgobuwP0JSaIHXacOrpnJSI7D4hC7WtDLeHCmPe1iAcN1qF8GB/PWDVdRC/iXraKENDWuK7rxVf2QZIEkXcnUITM+Dzz7ce0SJVXVmOsLp0CbfkgOeBX6TqrRVeAhNkPLdB8V8rCpsKVycBfe4AVZ/07+qoV441YJ9+fjRHCNhveSspCxy+d8+wQy6LTnPzLHKf/rqfEF9am1N3B+hkWG+eth7ESXhk0tFH1TK9F5bFgysNqY4G1FxVJualrPfMPq/TeeUZEfe23zhJWRll3pEhYJnI3hI626Z6mp81KtDhFssuVCIvMg7pCpO8yhu3jrdiEuR7ULw5sKF8mJSUeanroHg4RcK4xV+x6ndjdtB7LQzVSzmuP5zDXnrqLXgJ0LgSHPNE40ZydOxoQDw7Yk8GFdEU2jv89yCcreMmU/+4XM3lAgBK6BiQ7cboseV9UsQ+h0Q7ClKVYmWsjgDtS/X7Xj9omY+HLLJB6wAr6Yw64CG/lhCF5BFcfoxZQsALKd8mUwL7Qk94+BUOvjdjxvvNWorK08Cxt2u0U81n8v614vvxdh5lc6B0YBh3H8krvjNIjKFgygYBWEztKfEsSRlWKYlEKZqLO5heniEZJZxr1YLxA/CeHxDOzD8kXvxMcDuWoaKn+pwLTgr3gegqxnxmLb/yiYgdroQMEp/adKb6XKjtHbDo8gwtRSNthTJKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(36756003)(71200400001)(110136005)(54906003)(38100700002)(122000001)(2906002)(41300700001)(83380400001)(6506007)(316002)(5660300002)(4326008)(31696002)(64756008)(66556008)(66946007)(76116006)(8676002)(66446008)(91956017)(186003)(86362001)(66476007)(38070700005)(6512007)(4744005)(2616005)(8936002)(31686004)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnlMMWxLUWhwWHRzMzRTdkROeXNKREpvRE5QQlZ1TUtGZzdpS0YrMlhBVEJM?=
 =?utf-8?B?dTJxWjdTNXlCTWhzdkUzNUpJU1JQaEI5Nm82NFdYaTFBU2xUT2xQOHc1NmFV?=
 =?utf-8?B?THNJaE8vSFhYdGZLVGd1NWlkaVVhclIxSHFuWXVBSWtsZUMzV09SM1doaXVk?=
 =?utf-8?B?a3pBUGMyZzlvKzNTNDdPWUtzL1dZNlY3MVVJQndwLzhMRzAvM0RicUpFT1p1?=
 =?utf-8?B?UVF3Y1hIT3djQzVQeG1tdElITWRZQWQ0QjNkWlVJYXpkaWsxR1J6SENYQVFy?=
 =?utf-8?B?UUlLZG8zaHo4eTUvdlVaenlrU3pIb0MzM1JVMy96VUE5bWhjcTI4UVIzcmNi?=
 =?utf-8?B?S21RNmRSU0FLdlQzZ0hRS09DeklpVVFOZ0xubFFjZ0hVaGk0eUNLQzBQdXdj?=
 =?utf-8?B?Ym5ETXU4dHkrTmVDTjlOQ2pTYkFOQllJUDV5cmdTZVpiOGoxbVdNT2tBOVUr?=
 =?utf-8?B?SkxXL3RxZDJiUWhKaGlUZXVpbkZkZ2lDSytCdHdMaVVSeDRLT09aZTJZT1lz?=
 =?utf-8?B?TjN6bm16T0FzcndtbEJEZlJuOExlanR0dThxS1RrdlJ5dDRkd2VPUzhjSm83?=
 =?utf-8?B?NE5ldGZDeEo2Wk9iMU5Xc1kvMTZYUEhrY3dvS3JMQmFJWFVKNWJweE4ya2Jq?=
 =?utf-8?B?L3pIbUQ1dHpRNzJsc3dCSjJqTnJzcG1VenJuQjlmRi8zM29QWjR4N1lnQ0g3?=
 =?utf-8?B?K1VzYzhRa3hNVnNGWWhYNVJMMzg1MndxaG04Nko2Uy9HdnB6K0MyM0FCcnlt?=
 =?utf-8?B?U2VOVTVwbjRmSkdIT0ozOE9rb3Jhc3hMOTRTWmd6SVVOUVN6ZWYxWVVxTjNv?=
 =?utf-8?B?SlhoNXREOFF4UkFXbGY0SS9wNVBuV3R5ajhHRElraVNsb1hoWVFobEE3TGMv?=
 =?utf-8?B?SnIvSjBvdi82WkhPYTFrczVhbFNPM1ZwVE9IbFZqaVpkTnh5SVZ4QmhlV013?=
 =?utf-8?B?MUd5bWN3WnJxVFZXd2ZBSnNLRC96WWhtYWZDSlNhcVh6elFHbUpOREZRdkds?=
 =?utf-8?B?K2k0M3FtVXpPdjFzUElKY0RBaTJhNUk0UGQrenVZdkNoYkZYOW1xNW9mV1g5?=
 =?utf-8?B?ajhjd1A0bU93ajBIVkhNNEErMEtUSUZkQmVDdnpyek5HdHVTVG9QSzVMcmhs?=
 =?utf-8?B?SzZqeU1GVGhiS0lPWmMrZFlmY3BpeTFRakNja2xEWDU5R1hITFRmajUvRmF5?=
 =?utf-8?B?YVNPQmhkb0RKMjVOdFdrVThOMDNHNldJT0JMd0h4K2FqZi9NUzJPWVJBeksy?=
 =?utf-8?B?U3BjVjMvSzdMTndoQUhST3hFMlVYZUM0MFZHMFgrMUlpSHFRNXB2b1FwNUlP?=
 =?utf-8?B?UDV6d2JOL05WbUhncnUvVk9QNVkyMnM0S2NwM0FQbWx6a3VCRHNiMWxadGhH?=
 =?utf-8?B?eW42NkgxRitDeW1tNVVUWE83bFhSRmF6b1VQekZFMG5hRzBERzJaQkpJa2Vp?=
 =?utf-8?B?QlJxUkw5RWFNYmVNanlJek1SYWlYZmNwd2FjbllhS0tYUEF0Zmo1TUJOdzFi?=
 =?utf-8?B?ZjRObHdMYXpjNEpybjA3S2x5QjRxQVI3QXNuNldTUGhQc2R2SG9ZNFNaMkZN?=
 =?utf-8?B?bmtIZzcrQWMrcnIzTkNMTkladmhCQ0pXakxldGowMkJ4VWpOTHdXQ3FoeXhW?=
 =?utf-8?B?amRicjVGaDRtcXJSOUZuWUF0T0J5M3Z3eTVHcnVSYnhSbVRKSUpMU0VISkNG?=
 =?utf-8?B?T0kvNzZ4TUh2Q0tTaDBjOGxmWDZRajJDd1RrTE80WUdUL1BIRjB4dzFtNXp6?=
 =?utf-8?B?Slk2YUZBZGRIWXBvb2E4Y1gyRmxYeTdmMUZ4TXY3alJXYnhsemRUanBmRzdi?=
 =?utf-8?B?V2I3Q2FHZ0dOL0JZVTZqUTVZUWNYNHRJd29mL3h3S3QyODdVRXdCdDRNMUZW?=
 =?utf-8?B?Uitud04yZmUrejROYVNUQ0tTUlU3WkxNK1VGckxyMnhYanM2SWFOSUxncXhO?=
 =?utf-8?B?d0h5aG9TSUxYbm5yTmhKM01SWnBXdzBoNjZHVHFXT2hDNE02VFVLZDlhRGlu?=
 =?utf-8?B?dnlBdjdneU55MlFvS2JjZzF5aXMvMmN1ejhiUk1iYmRHM2IrL2NiZDNZTEdZ?=
 =?utf-8?B?SUFnNmQ3NTdwUmZEQ1ZLY2RKdW04aFM0ZmVxdkFzeXVma1hjZHVHbVRCVERv?=
 =?utf-8?B?R0xjbHRsSmVTb2t5czF1Rm5kZHkwbm40MlZlUHFNaGNlNUlMTkZhZkdHMllv?=
 =?utf-8?Q?rdNedhuc+5sRBZuNLpkk44prI1AW6hMXTPx+2xY2wA/6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D41808EA94B9E4FA72E6913842817C8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a66176c-0a89-4d71-653d-08dac77f7b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:05:56.9976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNabdZjDI8iEpZ4I3kg9fl26uEAYW4g4WbEbHprIeEYd5taQgGb/BZWdWPsS1ks1Kro+SItE8vSUled0tybeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+PiBAQCAtNjM5LDcgKzY0NSw3IEBAIHN0YXRpYyBzc2l6ZV90IG1lbWJfZ3JvdXBfZmVhdHVy
ZXNfc2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNoYXIgKnBhZ2UpDQo+PiAgIAkJCSJw
b2xsX3F1ZXVlcyxwb3dlcixxdWV1ZV9tb2RlLHNoYXJlZF90YWdfYml0bWFwLHNpemUsIg0KPj4g
ICAJCQkic3VibWl0X3F1ZXVlcyx1c2VfcGVyX25vZGVfaGN0eCx2aXJ0X2JvdW5kYXJ5LHpvbmVk
LCINCj4+ICAgCQkJInpvbmVfY2FwYWNpdHksem9uZV9tYXhfYWN0aXZlLHpvbmVfbWF4X29wZW4s
Ig0KPj4gLQkJCSJ6b25lX25yX2NvbnYsem9uZV9zaXplLHdyaXRlX3plcm9lc1xuIik7DQo+PiAr
CQkJInpvbmVfbnJfY29udix6b25lX3NpemUsem9uZV9yZXNldF9hbGwsd3JpdGVfemVyb2VzXG4i
KTsNCj4gDQo+IExvb2tzIGxpa2UgdGhpcyBwYXRjaCBnb2VzIG9uIHRvcCBvZiB5b3VyIG90aGVy
IHNlcmllcyBmb3Igd3JpdGUgemVyZW9zLCBubyA/DQo+IEFzIGlzLCBpdCBkb2VzIG5vIGFwcGx5
IHRvIGN1cnJlbnQgTGludXMgdHJlZSBub3IgdG8gSmVucyBmb3ItNi4yL2Jsb2NrIGJyYW5jaC4N
Cj4gDQoNClllcywgSSBmb3Jnb3QgdG8gbWVudGlvbiB0aGF0IGluIHRoZSBjb21taXQgbG9nLCB0
aGFua3MgZm9yIG1lbnRpb25pbmcNCnRoYXQuDQoNCj4gQW55d2F5LCB3aXRoIHRoYXQgcHJvYmxl
bSBzb3J0ZWQsIGl0IGxvb2tzIG9rIHRvIG1lLg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhbWllbiBM
ZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbT4NCj4gDQoNCi1jaw0KDQo=
