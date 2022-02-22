Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB90C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 14:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiBVOTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBVOTY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 09:19:24 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C658160419;
        Tue, 22 Feb 2022 06:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNX3BttzccKoQt8a7A+T5LcT9FFYGcfD4N4jFDJAgOIm4Jd2rgh/KFo22MIMOvb+sV8bf0j4dVaLx/F2iCwRIHBuxNaIHzM4sg56S1buTV7AeFChTPk2uC8i9Yh0PzL7YRsCZtFpgkTD2To6NFIFXeR2yhd5Nscgi7fg0yvYdY+CguOZDkQmHZAkGM42BU2nwQS+h0ygwpdRuKEEb0MdNQKj9wZyy3H0vLPpHFPQr5XB2EAu5COe8WEqOi+3vMWFFrmyA21iySiCSDC7vxCNaYwcb3Ffk4RL0FiYWRIOA3Va3RUj3jAJNJb7AUf+FUljporpG0/i+rmTBdVZPLfORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzymPiwnkUCWvvO0hl8ILA5fevfOvjw54NssyttKY6s=;
 b=QX9uKuYELIxyGvlk6Ht9gwpGQpKFHx006xTPH2zgwG+gWNeMaRXV7qIFNVgn+UGMtKCkfXDaQPJWcg9NEm1Yli6NJvuuX9dki7nrdOHmlNHhk/c5ZQ4IdzZlhyWxcXWZcq5utpgR+xaIHYUk0nmUmnrfyVqw4xydSghAzyh1xzBfuErDQqrAWZ47GflERDRPbbvEQ8AGzOT/j2hC5rzG2BSp21wphYyBXN1RAMcmzxlDZWbKHoX6bxLc9mVMpJk5UrUi13eRrH1DHOEDSROi/UiG+bHLExy5eGq5pLUZWztZL70qv2HPWA+PHBFPo4Pv+TOveYYo8FNOFdmBC4jjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzymPiwnkUCWvvO0hl8ILA5fevfOvjw54NssyttKY6s=;
 b=HFWhbATfIm+G7YbWMvLpPxZ/mnKZ19b1bQ6aplIaRzSoa3wJX51UXHISUUw1YLWKR4ksIAUIgC8LvAYnldT+rk3f+BNyVgoLfSTvKRGLn6dutA/vAEKiO+sJ32/cn+z23g0xcz7AYScyY/UU2Ua0T0eFHNBDRxHJiP7orErgUFHrRd7z7gDW9xcOR1srDO01y3DKdKwgOUjgfnxahPDGhdVjw33zEhNV+EqtYidzoAgeX9L9X878nNxjD2ANRrlBd/xKBicBFeIQXeQbPMvPFyV4JeUWwaKRG8t4vaXV3qTmfhTnOJViVtcxzq6dV6Us+pJdUs/NGT7ke60uueIaOA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 14:18:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 14:18:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] Documentation: block/diskstats: update function names
Thread-Topic: [PATCH] Documentation: block/diskstats: update function names
Thread-Index: AQHYJ4vHs113Rrgv+k+HUS1+A2Tx1KyfnyeA
Date:   Tue, 22 Feb 2022 14:18:55 +0000
Message-ID: <ca2671cb-35a2-7946-90af-38cbdc8484c3@nvidia.com>
References: <20220222012751.1933194-1-naohiro.aota@wdc.com>
In-Reply-To: <20220222012751.1933194-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b82defdf-508b-48f3-dac8-08d9f60e42b6
x-ms-traffictypediagnostic: DM6PR12MB4281:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4281F82B9129CA7BEC1CB879A33B9@DM6PR12MB4281.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cTN0a/ZtWLDDzzSCRMRSWlYOyPKk14JzHFt5fqT35YEBs5e2z7WXB5y3BA+1Na6KCKe7Bh6no6SrGcj8Gff33PZndYGO4KZb/iXN+2SpYTMJvCpukxa7ciCQupf5fOyuYcDcxQxc9aiJm+fqJF6rNkbVwGUP0mc3Bf9YU3raG0iBL75MTKD5rnNEbNAXp5PbIuyCxMwFp1RtIcn8JajAa83Ii7Wnq010catPvXRDy8Nj9Qz+7WGYMECDugqY9dtjEGT92IkPdpU3wVjepLe5j6N3EnDg+RK4n8dLvYVQQruHyM+urdV/atPupGPknLKuYROJkz9GHoljrVl4PS3fNw/BKhsMHgiaionYeolIevhpEnEq+DbdE6i956KGM4dyVlkVNHOCxprt06gZfxjDrXX2XvD4r9JzZbljTyQsEBRIswZ69OSUQnnS+xpR2kLdNONscnST08f1ns4tiSVyCREh3UapzZOHXxNO27cJmbEFGMoE6JC4fRAuQCXqIGDStvxD5gwEyHt3VrLa7/5rSPWI9tXzwJ51IZwaP/GTSAH71K/5jxFzqWbQOOnqoiUo4RB42Ueu81EToIjpCOIvKr//jk8Y81kXnpKkb5Q4epJ2UOeOXlkRYaok7/JrI69YFmMVNzNpC915WepR97g2CcJZScqFzjFKYI4+bdvosFRwB6f0xuS+eTPNzcMnkoPl26Wx7pATsRuekBybJ+G3qJKyUu/ylpYGUYofttSNCYWZQKFoVPaLXRueZOn1bvfzxyTvWqdFvGbzgx0wS0ly5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(71200400001)(6506007)(31686004)(2616005)(6486002)(38070700005)(6512007)(508600001)(53546011)(2906002)(38100700002)(186003)(66476007)(66556008)(5660300002)(66946007)(64756008)(54906003)(8936002)(6916009)(558084003)(316002)(122000001)(31696002)(91956017)(76116006)(83380400001)(8676002)(66446008)(4326008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTkyVW5Yd3hhcUJnWkVQb01mTTQzTmhheG9qcFdQTkJlQmlGN0RwSEQ0L1Yw?=
 =?utf-8?B?UDMyZTBkN1ZBZytLdkxYb28ySGVPbGl3T0NRQktKSi9FZlhNTHVyd0ZWTzBX?=
 =?utf-8?B?cUI5Z0JzTWoxMVUwYmVSMzhOaTVlQmNFcERxZ1dPajZJNVlIZ2dUZTUrUHdn?=
 =?utf-8?B?cERUcXNFVzBEZHQ5TGhDWHlZQVFRQ3FsdGNUU09MYTFyL3JwUGVpYUpEOW5E?=
 =?utf-8?B?dzRkTDRjWVVyUTI4VHN2M3lGKzVUK2c3ZnNnRFpxam5oa3lRbk9iZ0MvbTV2?=
 =?utf-8?B?K0tyUkRnV1d5OWc2VGVEc2ppT2x5b29Nb0ZacVdhUkNycWNvdWUrSjdKM1B3?=
 =?utf-8?B?L3NxTlNZN3krb043OG9jb1lKWGk0MlpUaEYxTXZxOVR0emg4bUE3eEdyTldH?=
 =?utf-8?B?cDNlOThEU08wWUpjZWRsWUM3QkZmZlcvclBWTkJ2SGNtSTFrZ0dUVm5ZZG1o?=
 =?utf-8?B?S0FiMjFBV1JTK1Z0Ym9QczQ4U0pBNGxhUmFaNXovZHlXQ1dPSTFvVndLblp1?=
 =?utf-8?B?Vll3VndVUXREYldpQ2xzYUc0SW1zV09EVk9hRE44NUxsc0tRYmNuVnN2RXE5?=
 =?utf-8?B?eVRFN1AyemlBa2pJQnhnL2M3dHlKaW5JVklzQUZRU0I5SS9nWjBrb1hjYjVG?=
 =?utf-8?B?aXlMSFI4akkvUmZYc2czbFVwNG16QjA3MjZxb0VjR25MMXp1TnN1MzlRUW4w?=
 =?utf-8?B?TGFUa0tmWVM1QzFyMTFDTnRFY2dGNCtqNUdMQUhKcFpaOVNET3g1UWg3cHpP?=
 =?utf-8?B?cnVzYlNVbnR1bElWQWEzMDh4ZDZ6UkhQRGpyd2xBMjZrNmhXelJpS2pYY2Mx?=
 =?utf-8?B?bFlNQm5jSVpYcXBmRVhwZjNTVnN3Q0VSODYySHYvRUVJTjQ4VUNMYTQrZFl0?=
 =?utf-8?B?QlROell4eXkxVnY4NjRqa2U5VnRBMUFvWHY4c2N5dE1samQ5V0dGd1pmeFJi?=
 =?utf-8?B?MDVJcURZWDN3Z3VNS3VzcmpxaVJmOXY3ZXkvUjJKZzdVNnRadVd3eUlUYU1h?=
 =?utf-8?B?eEIydkJmR20rTEgrREE5YVFhUHpOY2JhWFI5S1dITFFKbDNnQ0o0bHRyRVZz?=
 =?utf-8?B?Sk9GMG5YM015ZkpqNVR3bWJZSmFGa3NSd09RUjMzYXVma01WeHRMYnlLbUhz?=
 =?utf-8?B?d2doZXcwYTFnVlFmaFJRWG8rYWJxYnhYRllnUThIYnVMYnIvWXJzYmo1ZmdT?=
 =?utf-8?B?aExrbzZKMlRJbC9KWENxeHVRYk5KeHo2NFZZcHB5S3NkUGUzbHAyQXJqdStX?=
 =?utf-8?B?VnBSdTNMbUNQd040VzgwdVZOYjJOb2VLMDdSZkdJclVpWHJlQ08vT0JWZTlV?=
 =?utf-8?B?YTBLN3Y5WXZRc0RCcDBTQUo1c0ZFR1VQc01HSFY4UHd4MXF5VklGM3ZFTVZw?=
 =?utf-8?B?SFdzc1NnclFneWpFMk9kNDlWRzVCdURHSWlINTNBSzRMdGluWkZmL1RCOWRv?=
 =?utf-8?B?Vk9ON3B1aUh0Q1RwWkh3bmJhYUw3VlgyS05PTWFKU0RKSUJOMVZPTUtlSFY3?=
 =?utf-8?B?eEpIaG1PSC92LzlpMXJhbTkvdTBEbjB3bUw4MHpzSU5xb0hJMFFmcWhwbXJI?=
 =?utf-8?B?WTdkd0hvY3l1cTJtOFNxQ0liSng2NVVwd3NzSXFpV0kzb1NNbHYyTU5kQStx?=
 =?utf-8?B?NGNXR09QR2tyMGdrOUg0d3VSN0ZRaTdGbkozcWQyMGJvYUg1LzFOTlRrbkhl?=
 =?utf-8?B?TGRNdmd2Y1ZONzJiaXdvWkdmYnhXUWN0b3dueVRIam9aNEl6bGhpVWh4Ryt6?=
 =?utf-8?B?NExIQitnN0FJTWcyVkRTS2cwb0xxVVkzcVVUSEpyek5XWFB6cnY0UlIvblhP?=
 =?utf-8?B?QklLbW8wSXdNa3k5VkVYa3Z1UktlRFJxeENMc0FwbjF0T01wMEtrNHVjZEQ3?=
 =?utf-8?B?VjltWVFkdEw0YnVsQ1ZLWGpkWCtFWDJyR0F0K2FYV0hIcTVPOGtsWTM0Qm10?=
 =?utf-8?B?QkpQSS9raVluREFKZkJzWmMxd2ZxR0JiT1pvdE1jUWhrUFZ1ZVpEUmtYNEM2?=
 =?utf-8?B?QXo4T2VPRkhGTU1DVHdFbzg1L2hMeWxwRko2ZFRPcEhNTWJzK3FndVByUENl?=
 =?utf-8?B?WDZQMzRLUjZCYXRBRGpyVXVQYlVFdkYzaEdvcTN1eEdxMGh0d01JM0lBU3Rt?=
 =?utf-8?B?cDRSMGxUaDdrSjRzVTVGKzk2QjNHc1BQazJYSTBEbWRjVnIxOHZ5M2FhWnRM?=
 =?utf-8?B?dlBiUkJ1bFpDQ3JuTFJnWEJoVy9Dcll1YUFld05MS1o1RXhRT1VqU1RqaXA4?=
 =?utf-8?B?VndsNjNSRFZnWjc3a2IxNHZsRExBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C7170740550C468FDE79ADB1AAB1F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82defdf-508b-48f3-dac8-08d9f60e42b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 14:18:55.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4d+cuGRNR/W5zNeX0tlHhj8iThPIQBmbLPw/lotbPvfQvjlBgb7Fvd6PriI4BXg+VQI+sMRSNGeKyNHZ/a6fnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yMS8yMiAxNzoyNywgTmFvaGlybyBBb3RhIHdyb3RlOg0KPiBfX21ha2VfcmVxdWVzdCgp
IGFuZCBlbmRfdGhhdF9yZXF1ZXN0X2xhc3QoKSBkbyBubyBsb25nZXIgZXhpc3QuIFJlcGxhY2UN
Cj4gdGhlbSB3aXRoIHRoZSBjdXJyZW50IGNhbGwtc2l0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
DQo=
