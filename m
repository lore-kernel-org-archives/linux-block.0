Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F61C77B7C
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 08:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjEJIAT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjEJIAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 04:00:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8BDE
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 01:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAsKEKkrpSV5LQteX82Rcfa7D4mvROA+rBh/o5UCKNuLzGQaeOo/ZasJmvB20BYKCB3JgnLNVPK8gyyM6RRE5LH+cu/9lTEr1C3AEisbB1JjA+/OB3P60BOzLjymgxooiXQKh4xD+LWTzVFZxHvMGcE8nXumRbd51fmqMalZrHx9P3q/1q8PMzjAcugYR02a8n+yJ9OdYcdHjb/Z9Dd/uN65fjoVF05djOf4LrlkfHVLg4CO4TXb6mwuyIDYjZ8vKxMo4pedYxu/4RBSQUuuA7c9ssuT3hA+FbgAf7nu22OLF0JJ/T9R4Ma7qq9pGumbQnGOdl0Fyb+YLC3UwFqYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAtlO91TxrPe2d5D+QlgvY3dg32lcLQsKiHbY8sw8QE=;
 b=MR7tx8vNCgfut8iNq1+dbs12iD/DY4oQBsOWs4M/IDWFRcn1iw+OUXeKqJNt9cIb+uHLTkNkoxshhtokTR+JyCyboRfdDnP1bX3QPL+CD/8tvXdKVRZw7XznR+dby0ZzT49VGy2NZP+75S0YIckDRS7/65lUxahk+X3fsr7nLsTXoc4B/PToPLiuVYf1BsMVbrF1+Ge+S4d3JWgQW3e08HK74xWAgr7OZol+fgqUYpC7BWVttOeZuBr9dsTvreL4j6eOoHVJb868LzKVMRHC/t4cJLYivpHQd8L1otABn8YilaW7di1YhKzfLvUvPitCi4lgAyJyVrDI94xL45h5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAtlO91TxrPe2d5D+QlgvY3dg32lcLQsKiHbY8sw8QE=;
 b=tDb7dL7U99BEp1iax2I1IWj8EJOwYIs1xfTIUWzTcXjY0cziULdOhLdBrkM6EOppJicIN/oHRe5eWfn/oZ0I4qqdi+GWQQuaBlO5roIiffdYaM/t8kaPoR0jUIg2N//BBFXihs5Gcn6B6RjGXH7pIygGK8oi3jWJl4D+EiG7ewOjAwLHfSs/2G1f2yLRG/hHHNXcpYvPuydkkFlUVKjriJd+V0pOKBps8v1AUTRMO1T9068gkqhN4ZtluBa2dlWh54r0uKt8r+2bTQ7xznVto/gsuLOt6kj/VGlDvYaikXF3aup1Z5frGoT+dt8L/j/ALARQxU2AIjVK3ERC5WfV0Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 08:00:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:00:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Topic: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Index: AQHZgw1ghYeKHCF/j0i/E537kPbdBK9THegAgAAFcYCAAAFuAA==
Date:   Wed, 10 May 2023 08:00:12 +0000
Message-ID: <14ca2b51-6ccf-d3f7-c61a-ad2e8c384448@nvidia.com>
References: <20230510070207.1501-1-yangx.jy@fujitsu.com>
 <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
 <1f2061f8-de32-15cc-818b-56ca0024c5da@fujitsu.com>
In-Reply-To: <1f2061f8-de32-15cc-818b-56ca0024c5da@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB6899:EE_
x-ms-office365-filtering-correlation-id: 64fc08a3-f19b-43a2-9ec1-08db512c94f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3TqDFXfK2Wfh9Z6izj8xAsy9/tAm/QMMMbK/zE41l4IrV2byCiWGXwAQChcKmPSh2L/T6tG1in3CjayDduCJ9LJnOeGB+dsVargw6Oss8RYQklwr8uV1/sHRX+XKMMQtR7W1llAMA0C4nTT3nDy7kGPutGDKG/7NnOE0V7LWdEZnp3cqEK0YZdkWQHHpH5bTILWmGwnI5PXsqnafHrCXjRH25KLRSNXhrerg7sa1OfSJZWrSln5bSDKUlHEMl2xntraRM+TW/tR4oB8dcXLAGwOUCRCsLrl3BZz5hPHqktfF9EgXg9ndFBrbo0Ii/oeM693eXLkiuFGve1GfzEgPoJAujy8wbVy2hxLdla4khE+hYuIW4uQR7RduzgVI9UB4JDEXVt/Cdmk7DAST7M9jV8YZVGvWbfC7SbFS25m2vZWEwG3WPW/IaxkmeRJzqDkfuZC26QkZXAkZ2/jGHkFQRCDT85Z1HKG88uHHCJ/EPJzSfQK/dL2q6Lx7iqWZc/ARq1hOW2F4FmGBWD1zzYL2H0FWXMslzUR3mezXXcAVyrWBMQNfNTQn60ySH9jBXLW/35Xphe9ifYQqGllG5VZUF7G2QD3IqitkZ0XppNbqJDsBcK4d7g+4NqSDuHjHDcL+zqxU7Y/DzNo+GWixOgix/4rvzHu8AF4C0itIAEb4UA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(2616005)(4744005)(2906002)(478600001)(186003)(36756003)(6486002)(71200400001)(38070700005)(6512007)(6506007)(41300700001)(53546011)(316002)(122000001)(38100700002)(31686004)(110136005)(4326008)(66476007)(66556008)(66446008)(66946007)(64756008)(76116006)(91956017)(86362001)(8676002)(8936002)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2o0SXhNTllsU01wUVlUQUhPK2k0eDhVZTlnT1M2SktFNHlyWGNGZk5sck90?=
 =?utf-8?B?ekNXa2l0V2UySDNCMHUrNkpkMlhyaG5DUFEzVzA1WHJpVVp5b00zYXM0SFlu?=
 =?utf-8?B?ZGF0SnVwb0luRWNTbkFpVW5keTM0dzlPRnl2cFpkNU4rUlo0WlFaNWZkOWNo?=
 =?utf-8?B?cFVaVW5wNU1WRjE3eHNHdUlDUmY4aGNiWTk3R3djcmgvNTRDODRqSWo5Tm94?=
 =?utf-8?B?dzFyZCtzenZBbnVhQ1k0SEgwMHc3TUcrSDJrajVZRmlIYy83RUErS3ZtRHRH?=
 =?utf-8?B?M3hRMWR2b0N4TUdjaG45Y2tPaDd1WlRKL2hsYlBZb050TzBqRXppUE5JZUVn?=
 =?utf-8?B?U0hFYmY3TlJGMEJaelhVYkdLRFVBVnhaTVhDQURKbFEreVVQUnh4K3EzYzFN?=
 =?utf-8?B?MEJPd0NTZURkcm1WcE9lMW9rSGMwSFVXRG1jSkJ0YXdBOHUvb2JweUlUVmNQ?=
 =?utf-8?B?M0MyVjFsVUdaNFVibXFVTm9XbUR3dXdFNzZ4Z0FkdVBvTjBrMlFXejN2UE5Z?=
 =?utf-8?B?ZUg3SUJtNGNmVjdCbndRZDlubG1tdHo1TzBYa04yYnNyQVh5U2NLT0tvUTBI?=
 =?utf-8?B?cDVTYzFweTY1bjB6QnpwS004cFM0dUhkRUNqWlpadmt5OEp1cXRmbmQ5dDE2?=
 =?utf-8?B?b1lhQks4N0lpQjUwczg1bzJDMldBNTdpYzBBYk9WSENKdi9VSDF6Yi9rOUI3?=
 =?utf-8?B?WXpvMmNpYjl3TkszWnRHMkdrVXZtRXFxT2VDa0REV254Vm1uTzF2M0x4S1VW?=
 =?utf-8?B?M2NXMUE1cThGQ0JPcnFLQzAvVmxQZ0VlaEtPZE1ZdEQ1aEtjd2x3WkFwQ0RX?=
 =?utf-8?B?M3czckxkNlYyUW5tVmRQOUI2VEM4elhkcXFxYk9Ccmkwc2FianF1WGtWb09k?=
 =?utf-8?B?dnlPdDFLdUlZeElwTXZER3p0dVFQSDUwaEhTRmQ5YkFXV3hRNmNxNmwrdXhH?=
 =?utf-8?B?LzRRWE5CTndnY2ZBeTF6cHNnOHdRU1ViditFWnloRFc4V0pkeWFPcUZLdFRF?=
 =?utf-8?B?QmFnYkgzMmE2MURuaEJQZlU5TmgzRjFYU2hIQU4wTGZaQ1MyNWw3ay8vVTZT?=
 =?utf-8?B?cUU0RmVwdWZQVGVMNGIvYVN6SGFPanZMRUpzaFNaVFR6VnF2azlIS2lqS2Yw?=
 =?utf-8?B?Mm1kdThKRlBQaVlWVWQvdWkvR3cyanVhY2VQTGV1TjMydWhFRjhSaEpYK1ZX?=
 =?utf-8?B?aHZEeXFJTEFPYmdrWnBOMTU3ekRwcGJINlRvVU50TmM4Unh2K2tZVHdqdkV4?=
 =?utf-8?B?VHZwQjZZU0lwNFVsWWVGdFVyRzU5aGlLUmlDV2prd3pKY1pZWmFiTENWd1k3?=
 =?utf-8?B?QVlESDNTU1ptWTd2TE9PMjZZU0NURXc5VmVOZHZjUW1DUGh2ZlNkZXJEbC9L?=
 =?utf-8?B?SXBTSUtlVlIzL0MrOWZmNjUwajk2TG8vcFNjZENqUkZoZ0hOSDBtOGtJWHE2?=
 =?utf-8?B?dEVIeG9wTDRJcyszcDZrOCtjU3JVb3RTajZ4Yi84TURxSitadkYwSjFyYno5?=
 =?utf-8?B?RjRqUnRrMzNHU0lzT0l4TUREOFB5RTNrUHoxdmwvLzhaYWNEd3FaVFFOMzZp?=
 =?utf-8?B?QjRPMjVtdVRaUHIrVkszbmx6NEI3UUU3empoaTVOUE1GKythSzM1STYvNWVI?=
 =?utf-8?B?YmtmblVjUkZ1UTRUejR0MTFLRjB5dHYxYlA2bkd1cW1JQ2NQcFhHZTFVNEZj?=
 =?utf-8?B?MHMwQ3hqcXBEb05QaGZYMzIvRmFQOE56VWJVT3FmRmJySkJYSGV5cUgvaU8x?=
 =?utf-8?B?MVMrd2pXN0J1R3gxWURnSXBHakd3bm1yUWVia2l3ZVJQc04yZFQ2bmUwL2ZU?=
 =?utf-8?B?a3N6MzFoUWNwZDIrTm1FOU5ZU1QyUFYwc3c5TkRZM0txajc0bE9nbTdrVzV0?=
 =?utf-8?B?VHg5RGhkT1kwb01UTnZXUHRNWGVOdUdHbHNCQ1ZOdFFNdk5MUTZsam01RFpP?=
 =?utf-8?B?VWlhNFc1TDJHVlBaWVdhbTQzc1hTejNNTk5MOGFKOG5uUmJORGhBSmxvOXRJ?=
 =?utf-8?B?aExKZUFZWFFYc1NZVjlOMEZIZlFQWnlzckg5eURvaUxneU9PQ1RBODVEb29n?=
 =?utf-8?B?K3NiYVZvdGJxUTNwRU9aTHRyS0czQk5DUzVhTnJ3MDRLeHpPc0U5WkVQS3hn?=
 =?utf-8?B?RzFnOXp1YWsvdDlvOTBGZWlwUmhvWGU5SE10RnlzNXUyVDl0ZmUxMGdXazJI?=
 =?utf-8?Q?15c4ellU1q0/xmjylV0nIfqrxi0MB0qrKUD/HXJFeSP3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16371DC0EFDA39488B51B778229B33F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fc08a3-f19b-43a2-9ec1-08db512c94f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 08:00:12.1821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bYHwAlMGrIoCQu+Jx5v0FOIGBsdLsgnAI/I2yyDiGAV69/XMHzGP8EZyTRFVRxnZSnx4lxLtF0PPgwpzTxumA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMC8yMyAwMDo1NSwgWGlhbyBZYW5nIChGdWppdHN1KSB3cm90ZToNCj4gT24gMjAyMy81
LzEwIDE1OjM1LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiB3ZSBtaWdodCByZW1vdmUg
bnZtZW9mLW1wLCBzbyBub3Qgc3VyZSBpZiB0aGF0IHBhcnQgaXMNCj4+IG5lZWRlZCwgbGV0J3Mg
d2FpdCBmb3Igb3RoZXJzIHRvIHJlcGx5IC4uDQo+IEhpIENLLA0KPg0KPiBUaGFua3MgZm9yIHlv
dXIgZmVlZGJhY2suDQo+IENvdWxkIHlvdSB0ZWxsIG1lIHdoeSBudm1lb2YtbXAgd2lsbCBiZSBy
ZW1vdmVkPyBJcyB0aGVyZSBhbnkgVVJMIGFib3V0DQo+IHRoZSBkZWNpc2lvbj8NCj4NCj4gQmVz
dCBSZWdhcmRzLA0KPiBYaWFvIFlhbmcNCg0KV2UgdGFsa2VkIGFib3V0IHRoaXMgaW4gdGhlIExT
Rk1NLCBJIGhvcGUgdG8gc2VlIGx3biBhcnRpY2xlIGNvdmVyaW5nDQpibGt0ZXN0cyBzZXNzaW9u
IC4uDQoNCi1jaw0KDQoNCg==
