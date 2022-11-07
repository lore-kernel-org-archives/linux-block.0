Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D56C43219
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKGFnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGFnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:43:14 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C05F7E;
        Sun,  6 Nov 2022 21:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1IcF/olY5+6VJGkchxNfhP75YbD4T6byFbP/YKA4CXQ6Fx5sHwxeitt0JUHsyTi9zIG8x5Q/ibPGjJl3di+at56OKH8dC1Bf9crlq4IB9Bc7CMnBDI+3VkOJyCByy1VylTzwjnUPakKGpTXPa7Ix/Lp0PpP7rPw7lP38jhWv/Cobew1GfBsCRK6GiqR0/mM91b347WEvLHUYT13pOo1XTetDyAK7bSH/SvFp5TB3czf8OCwx7ZMXvl2WDCZzMEa+jTk8qmx0T56DJfYDMwOSOWVnqYWVzfoXO4Ydtpb40jA8ok/OgiZTULWDf0pPadz7nNeJ6w0Yio5L7Nw9bioHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGAijPqsOg8TdRUakBzmomswgVZ8hMhNdiCpxOiY6aE=;
 b=KgtKQPJL8DhbqjKMsN8VDTUA5F8Q2yNDU3oKofrz3ULihA18ZcoaDV+YvIIK4/wp3gcVbhJ0PY9Yo+h9Bec7rkCcjgsDcYDsKCMzst4eqD2WChwd0lFbyhAFma34Hrcfp7Ncm3E9c+FNuIEZ/ViWtIwx/em18Q2jRLWUae99Q8a5BjlCme9OkEQEZU/P448kTIAAQeR6waLyeyUyyrfg91OQhLVdZT7DJUXyk6z4i+BVHetNSJIvRGCrLxUCG/ZD37cpEmc9OoN7qvvBLQ7KhelHaUAeDTutGAN2hdxueYCqluwrYFNDbln/IfYbah9zrOmLZB7LJcSMAWmKCr0H6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGAijPqsOg8TdRUakBzmomswgVZ8hMhNdiCpxOiY6aE=;
 b=N/QhXmHZu2UTOgFlNGcyo0zcmHwzmuTZT6bGriJ/It9ysFzjIHE903yBHwgySfaVkIa+J++1uTAq3XVRlkDR+dRZnERghb1dq1MSytufC9izUZN+a6Z6k062kETxXhLRceGrGuk4PJQjHof8ON7dN5CXQZuT38FQgPgwCOddwSI7LdoMk0/hBqLgBNyJATP2HyTJ0CGRKWJu3FPncmaSKmKZ950mslI+zRmbUTrViq5W8eeMNE55Z8ek4sfqQGEPyY0fZ+DBIx+Wtj/avslLtE39BKC9EbCd5xjkruBEjKWS/akeVRwpBP+PMFAjlqFTiS5edTdu8Gv0BiN44pSu+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 05:43:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 05:43:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 3/7] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
Thread-Topic: [PATCH v5 3/7] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
Thread-Index: AQHY8kLyLOIZX+ZUL0O5snSOujx4Ya4y8x8A
Date:   Mon, 7 Nov 2022 05:43:11 +0000
Message-ID: <0a5f6b7e-b462-2e1f-eb81-8eafea76391c@nvidia.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-4-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221107005021.1327692-4-damien.lemoal@opensource.wdc.com>
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
x-ms-office365-filtering-correlation-id: 2f8052ee-466a-4f38-7a09-08dac082f535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRn5hsdCWANezOqKSFvlcV7iR+cqL9K+RrfDcq118BXPhZumGDAEv4k3BWIr6uBFvakWGKFZ8TZa0tNZg9i5bOKkzcd6wCHvOjAx5Wb1ig37VEZRxRH3manfoFB4ZuK6S+Uonm19Q71zWFpzSt73SCg89OkBq9oNi4j8NnaXwucheNVh7BE6Edylt2bthHmTM7i1INipeb5IHe0qG5ryE25b38r8MR+v5iaC3NqL4FT74fmRVWfTE7twqlBQ5BhIttO2M60zHY7Jnr1XvS4wdfmktTEXkAECGVkK15AptehIHfhFuUZpxAWtjWNL31tT4S2yYHXwA/AJl5Br/tmesysFFnR5tz9/DYRkH6E1aCxptwlzVXYQUENJSrrwzkIAsauK9rvjDGHo2m7WeStg9mxaFwAJGD7GnSxp3/pOl/wt+74M+mDUSkJI9kLJIfJeYJioAgyBe4IFeW0JPNh0eQpe2RSCOcY3/GX0ECPf3RyPUTVWrtUsHSAVi+LTpbSK8oMtgw40QlQwD7M3KxVY+T4GT9o+msv0vBZVfvYLGugvaMF98lDQ1iQSAfsbOfTaRRiB3Y9UwBvKycm6gaw8yjhfyniB+0fpyamDT6tARG8rhG3PL5xJVq7AtyyNdO56hQOLhiFq5ZyEjzu9Y+QZAG1JZpwYQTD/EQghVzR/+sL8mIrxjgqZgSevwyViEycQcPekkANZm6Avjw4Aq4eV8ytfnSnqHP6FdE2yyaZwR+5Ht03pO6CZXwGuAbkp/z4fxM6E0lhnkV6WtoqyvoTEk4TzjywifkQMHRRBdVgXwcCq+qDTc8U6LzVeNaN8Cv+QuqN4cGo3ShtheVTh8q3TcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(2616005)(186003)(6512007)(38100700002)(6506007)(122000001)(53546011)(83380400001)(4744005)(2906002)(110136005)(316002)(54906003)(478600001)(71200400001)(6486002)(41300700001)(5660300002)(8936002)(91956017)(76116006)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(36756003)(38070700005)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHpIRy8vVElOMTFFQ0VJdnZKM0ZCeEFuRjVRaEhpWVluRXNtUEo2cytPOHZB?=
 =?utf-8?B?R1dwOXBQcElJRXBtTnhSeGhPMHV2ZUhVcmdLd0MwWGxIMExOQlA2YUhtaVhY?=
 =?utf-8?B?K1IrbU9JUHdhZHkya2p3QmtNNlVDR0ltd2l0OW9YVzhkc01nRGRJZXJObGFw?=
 =?utf-8?B?Wk9zK0FmSDB0RTFNQk5JMW1tZTVEcktMd0RvMWFlQWdKM1hERHYwbzFXN2g4?=
 =?utf-8?B?TkZ6OXdWNGRlekVWZS9VeDY2aElEbGlILzhmMWNWL0pEZ0VCeWtWUm9SNTVm?=
 =?utf-8?B?cUIzOHFxSjcvclNRUWdpdnliRnlCUm1pVWJUU2MvUEZFcVpjaWVRVVgrUEVn?=
 =?utf-8?B?L3NhSFFNU2JLOTBkRkJaVlZtc0RETGlsSXF4OWVCQ00rQ2ZYcHZOR3FJcXk0?=
 =?utf-8?B?KzE4Ky9DWGxJbElMd3BwU3NHQkZnclgwL0xiVFZ5ZGJvMWVTVStLTkFDNmRK?=
 =?utf-8?B?L1dJUkt2TzkzdTNnTXg5SDlqMG5oU3RrS2ZtUEJXNWhQSTdVUWdOUDRwL25W?=
 =?utf-8?B?ZTYzUm5DcmU5dUNxamh3M1RlaGl3OGpDRENKdkRkMkdCU3I1L0xMUjJOOFFF?=
 =?utf-8?B?TEFxZ3EzTDJtaTBIajJvTjA0VW5jc0Fxa3NNOTNBdkVsaUt2ejgvWTBTL3Bm?=
 =?utf-8?B?ZjJCRmk0b1g5aVp1K0FtclRqZXR6MklkVlJRWGIyYktrRHJvU1h4VEJHYVJO?=
 =?utf-8?B?ald1aVhJSFp2L2RlaTZ4RjVOUGZLQTk5TzhtSzd3RFhibFVpSnBvQVNtODdP?=
 =?utf-8?B?MXJMbU1GVmE3RnZhYjdmTGJRc3pRdldSSHQ0MTVKMHJwS0ppT2xKWW9FdUdY?=
 =?utf-8?B?b2piY3gwYkhuaWgxQTRoS3pKR2toNmxQd2VaQ2oza1FOL3NCMC9BckJuMC9s?=
 =?utf-8?B?RFFjK1ZZSnJCNUNLZ1U2QUU4amk3eTBrYlFGNHpwaWw2QWJoMW5ESXZRZnVm?=
 =?utf-8?B?RkV2b3ZCVHdSbmdtcVNZb2FqMXhIUHcvdElrbFpjeE81TFMwdEtJcTdFVVhI?=
 =?utf-8?B?cDR3NnZva3VubkVLRXdZWU1iZUhjN0NBY043TDhMeURLV0tqbFFOc1I2QVZp?=
 =?utf-8?B?Z0FtendkeXNsL1FWMjVzTTMxLzVhVXk3UFZQOUQzU1BmVjkxRWdBRjk1SU1S?=
 =?utf-8?B?TDUvU0VsS0RRT1gyMjBXZWsrZmxJOXdTdTVPWjlFYTNiOFVQNlkwZE84TThV?=
 =?utf-8?B?OUorL0tVeUlYWVJySzhOdmVzbDZER1ZVcUtQQThmc1IyUW5IbkdoL3RJeFNl?=
 =?utf-8?B?dGVtdW1VUDhpSkxDTWx6dFVJWmt4SXBHMFBxS004MWk5WGtXVzQ1cFQ5bUM4?=
 =?utf-8?B?d0JtcTRMT3IrNEZOOE9SdkZXN3VnbU51aGFTVEZEVExhQUFuTGIxQ214MldT?=
 =?utf-8?B?SVhCTVEvSHcxYldtYWltdERCY3poUDJLaHRGUzJIbFBLQllmN0NWVWJhRUF1?=
 =?utf-8?B?UThQNWoyREVLbnJXcTIrLzFVZ204NjJEakVuVGU3VEJQbEJvcEI4UURaSFNT?=
 =?utf-8?B?R24vK1RCOHdGb00xaHRpOEtRUjA4cEd5czFCUzI0M1lyWW1nU3BBQndUdUly?=
 =?utf-8?B?MmtSTXVMTHdwdjJaeExXWE9wbU1PclJSclNsRXNFT1pDR04yUjRQVU4yazVz?=
 =?utf-8?B?TU43a0RRenRtSlZPTWZkM1J2MTZWRTRZYUdWNnlYNXJjRWlycUg2Ry9tVUxB?=
 =?utf-8?B?eWxLZnVDUmxhMkVJQUxwWVFYWXlTaFNCeWNNZVk1R3FoSGI3a2RkVlVDZHM0?=
 =?utf-8?B?V0xubURyNVJvc1luT3d3VkY0OTRlYmFRZVVQM0F3TTMyTlVmazBSTDh4VXNj?=
 =?utf-8?B?UnV3RCtyalhtWVBLcjJNSXFwUXA5RnlnOWdONTVJRzR4R0E3OWdobDMzUXdm?=
 =?utf-8?B?NjRGWWRHeGdPYnV0TlkvWEk0azVDNXVUY2x6cE9lU09ONjhaWWNEbG1MRERH?=
 =?utf-8?B?MUdiTCsxMktvbUpITzFZRUtNTUx0d0F3bUdwM01XTEJWa2NuNVJ4dmpvVnp1?=
 =?utf-8?B?MGhXdDMwaU1UVVhOVVIzQmZmT1g1OThzMkh1dzZLU05HQ0FjdThCOXZ4NjFr?=
 =?utf-8?B?YmhyWkdtNGlySlFnUFZ5VnJWM21VNnJxaVJpa3ViQmlQblBDREUxbEhXSDBo?=
 =?utf-8?B?b0NlQTlzM3RQSUZOaVZpNFFQaHlyQXZYNGs1c2F4VjZFem9vcGF4ZmtVcDdQ?=
 =?utf-8?Q?PelejDtZUKKLilLzqFO5qc5pYwNszVZzrdw2LLR07wRc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <713BB18478B8C8478D0619DC2C74B918@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8052ee-466a-4f38-7a09-08dac082f535
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 05:43:11.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30TfbnjCbrP92EfCrR9awwi6H190MAVg7DInXbzYvkM9C/r35i9WqoHppCoohXkO0P47bQp3+yz+G33GkBOiyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMDIyIDQ6NTAgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBSZW5hbWUgYXRh
X3J3Y21kX3Byb3RvY29sKCkgdG8gYXRhX3NldF9yd2NtZF9wcm90b2NvbCgpIHRvIGJldHRlcg0K
PiByZWZsZWN0IHRoZSBmYWN0IHRoYXQgdGhpcyBmdW5jdGlvbiBzZXRzIGEgdGFzayBmaWxlIGNv
bW1hbmQgYW5kDQo+IHByb3RvY29sLiBUaGUgYXJndW1lbnRzIG9yZGVyIGlzIGFsc28gcmV2ZXJz
ZWQgYW5kIHRoZSBmdW5jdGlvbiByZXR1cm4NCj4gdHlwZSBjaGFuZ2VkIHRvIGEgYm9vbCB0byBp
bmRpY2F0ZSBpZiB0aGUgY29tbWFuZCBhbmQgcHJvdG9jb2wgd2VyZSBzZXQNCj4gY29ycmV0bHkg
KGluc3RlYWQgb2YgcmV0dXJuaW5nIGEgY29tcGxldGVseSBhcmJpdHJhcnkgIi0xIiB2YWx1ZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5z
b3VyY2Uud2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNl
LmRlPg0KDQoNClRoaXMgZGVmaW5pdGVseSBtYWtlcyB0aGFuIC0xLi4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
