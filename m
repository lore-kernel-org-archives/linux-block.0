Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E74C7EE22
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 07:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjEJHgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJHgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 03:36:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C47ABA
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 00:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwH2cXOsqwd3SO57ydEoU89VaO6zfCCXNQVYa3Mh2kxrRG6xi74gpq3kzXXqv6jN7SYGw79WTBg/C3xfFRk3lp+OEo0A+zV5oCbRcqWfd8LrSjRgTTHS3QDr3O2rTLpyC1u8xetGAaaw1hcHZum8Zom4wsqiDN8tLxaxssXjimmM6hft4j3bIEMFJnXynnjlqUU3uBVBra5xNonWphzLQoPmVC3hICFZ6+Zb8HYgGhjRwjbZVtS3DXiGRBeNHRTsea3qngr6YNN80akBkh3yxBPy0sj4FTJdhb1CjhR1wq5RB4xAAdRq/WOsqFsrD3h0e7RwguCRQBpoDriM5464Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U50Yp/g5ROUVsiln9kU3VngkL++eu+OI6KU3UIbuzlY=;
 b=avNhc/z8r+QFkahq0KA++tljRlO9cp9XFcanD4rfj2v7YqT0m/W1xf3yInZftS9Z6v0jX+RmufZ76s2Qj5yl1ufOVamj8cRa2pOPCCOvm769wUXxyAWvttRx5hoSNXLbk9Af7+gcYw+2fbwXIajH12wXKQho1JnMrqcyTWx0eEafrM45Mpzw6cVSfJXT9KA4N4UVue99KXsA8YQmUA88itj5GYzUSQ65s+lkf/cmCnRnllnr88cP/FBfExsZ25nLKS1h0ji508rf/cSEIFfYhnSN9V9HhonHyzf+cOPTCmoa8DapgGo9VUTbbg2r2TuA+nlaFXpOVf7cewHFfzbEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U50Yp/g5ROUVsiln9kU3VngkL++eu+OI6KU3UIbuzlY=;
 b=Gxa3n8vOzCaWFDTJkODmPR/YZRpZulRO8W0lJxClZuJkcdiCakbwr2IFNf7eSuu8c33BfW/ff9yygo0zKNxJDXoNjgdS044xhNi6g69VmxJLtf5bG7f0Qyhw/iYNozv+eoetGTrlvnh26vYLWd+M0ZhiLkAguUPxSUgP6Fs2hIxXeWAWtju2bLm0lVvjfC4YSQ/MJP1vvGPfJPz/dlXYbPcZ9PAaGOLOLbyEFGiVEZjUgkyKLQB0HCDe2iDx2vkTZtfthTPhXI5IEkzeAy/WKfWJ/gb8RsFReAK4TEvGAfKtonFziRLrwsp80oJpw83XszmByNeY6qvVdSSVEIAtwA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 07:35:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 07:35:36 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Topic: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Index: AQHZgw1ghYeKHCF/j0i/E537kPbdBK9THegA
Date:   Wed, 10 May 2023 07:35:36 +0000
Message-ID: <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
References: <20230510070207.1501-1-yangx.jy@fujitsu.com>
In-Reply-To: <20230510070207.1501-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB6994:EE_
x-ms-office365-filtering-correlation-id: aca9ca45-5f81-4090-f453-08db5129254b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVdlkFuoEILnVd5tVoIDgsJC+uZ3lIzbnoIYsuvt31vH1aI503mj0i9S10VihnfZzHOiBzXCA1UjuWR+pS64PyiAfP7+Tb/B2I72WganTrMgmWKjBSvMc0BJC5DVTejAHgdbYP7OBQA5duAzlT1bmxOtgb6eQkNFJ0suN44YGRU+WuHG3RUlsz3+lbxfTX2NxUN+ZBjaykgW/8QwPWxKzPISUxlY76D7/YD1zEwBlP7safYWug1gdms7rcZvWmn6VopQbZw1qkO2brPC6CjY451x21zyq/lQ6JZX0uD2FuEcmVKWbUovyh8bZM7GrHVa7SptseFOLNSTWBT6if8sXSccj4+OTDx9WJhQwgxIXAW3qz2zOKG1DCZ8NfPu6gF562ioj/Y0DcQcFZTKicdLG9ttcjdzszoWsnA92gBA+Pr8uaDMey87wvrAWlO58tQA6sintNWnPwI1AP9MriRO2GS6mh3wJlqrHkbYDWX/AQV+iLHjIurXhOdpYjJT09kqClXhOE4LLiiGMjyV57/9utfWyqpmSQjb+OzxqWMz9ykSmynhLdu/pDOFR82UherebXbqQiI9iah/OVWUU8ustqaefEZB44l1hoAtXmmi5A+JGXnR9C+e69fbU4VBYIXC9T/VEQsvpfDb1N4pyEfVNwkEXmbJBpao6g1qtbPf3lPTZeXyGyg5aFEza9sHzyub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(122000001)(31686004)(2906002)(5660300002)(36756003)(4326008)(316002)(41300700001)(8936002)(8676002)(66556008)(71200400001)(478600001)(64756008)(66476007)(66446008)(76116006)(66946007)(110136005)(86362001)(38100700002)(31696002)(2616005)(6506007)(558084003)(53546011)(186003)(6512007)(38070700005)(6486002)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmVjRy9TOEhTMnlMd0llQmM3YnRDcmtGV3hHRGN3UFUrcittLzZaZWdzam4v?=
 =?utf-8?B?ZkZaZzZWajh0NlRQQkpncFpHK056bGtBTXBiYWs5dEtXeGZBS0JKVHhTalo1?=
 =?utf-8?B?a3NnckdjRU1Kd0p1ZEdXNnVYdUlodEhIQWo3RURLdURaQlNQMk55OGNOekNN?=
 =?utf-8?B?UDNYQlRNaHI3UnlTNFErcmdRdVhmZDJGbElCaFAxazl2aTJaeUVUSjhVN3FD?=
 =?utf-8?B?SkJqZGFqaTRkTUlZdENrVDNDOHhQWjhEakRTRTZYNVNPQk5VSmVoL3pHY292?=
 =?utf-8?B?NVdrNW13YURBRUIvOUxMelZLbkQzeDNOM0pXM1lUYUVIaG1IUHowWEpkMjFq?=
 =?utf-8?B?eWJ5azNuK1RoNXpZcnNMZS9VSVl1bW5LUkdsK2NxYnRJUjlia1BENXBVUndD?=
 =?utf-8?B?UkpUbElEbWtydEJkUjdrVEROT0o0VUl6RWdnWS95QTBNM1NTNTJ1MG0yZkd5?=
 =?utf-8?B?U2tlRUd3YWVnWDZjKzFBWFk4RVUrTi84MVFyZnRSV1lMcmZ6alMyZ0hha29y?=
 =?utf-8?B?VThVOWYwamdHcm54UzRQOTIwb3hhU2MxOXA0N2tScEhYUE1EbXUyKzI3THMz?=
 =?utf-8?B?Um1Ncld2VHpqQ3dQNDNJdVBiSUZUTktocitvaHRYcHdCZi83SFhKd3Y1Y1Az?=
 =?utf-8?B?eFIxYk4ydmN3QjFNWUc4VWFZU3VpVHE4QXdLWjZ6bTNMQkUvRUFrVmJWSDJV?=
 =?utf-8?B?cXdUcWFtTC9NY1VTM2VLTlo4UmdpRklselltUHpvbFlaUkFsbC9Vcmttc0c2?=
 =?utf-8?B?UXc1c0l1WDQzQU1QOE9HMktmdmdtQllsdW51akY4UEV4UUhlalVHNFlhUDlw?=
 =?utf-8?B?b0dvWWp2K3hSdkJFcy9KaCtXcExqaVY0b3ZLeFVNSzBFM2FRMnJ4V2RwcmYz?=
 =?utf-8?B?dHJIdUdtN29leGdpYVFCczViZjJ1NUtHQzhWTjM5bVZjZk1tNUJDS1pMVXRX?=
 =?utf-8?B?c2g5U3hyT2xyUWFqSzQyR0FMRXRMemdDdUVzOU4yT3paSkNHMmhQS1BHb1p6?=
 =?utf-8?B?Z3BnN3ZUMk5QeFJOem5ON1Zud1dhanRmK2pWUUJVWnkvbnRsTXNNUHlLNnVj?=
 =?utf-8?B?NFIzZ0ltZHlsMGZZd0loRFNZN21uUEVWWW5UbmtKbmdRNmY0SmF1cDJDZWM5?=
 =?utf-8?B?VXRzdEFYMHpHbmlvWVFZWUlBZDFUOGEwUXNqWE1JWERXeVdOcmpOVWF3U3Jt?=
 =?utf-8?B?MXk3RFdBOE1BNGN0VndtbVRLaFVoLzltYlhvUHNpSHk4Mm1kck5EU29wbmdT?=
 =?utf-8?B?aFIyZmdNK3ozSCtnWDZSOWdnZnBMSk1pb21SNWFFOE1wNHljUTV1UmFnQ2Fw?=
 =?utf-8?B?ZHF0ZlJKS1JQbi9nTi9WbnoxV1huaW1qOHhHU1RFZEM5WWRmWnp1dlFjcDBN?=
 =?utf-8?B?MkJkVER2bWRkamhtL1YwbWJaeWFmWFA2a0xUeWhkWjhNR2tSM3JZNlJnVDhG?=
 =?utf-8?B?VGlENnE0eitUK0pMQVg3RFFBdlFxTElIbFJiM2hYZzBzY0hpSjFvN2RVcXh3?=
 =?utf-8?B?OTdHM016bHZ1eFVjL2h6WkI0VnIyd054RkppWFY3bkI2Yyt3NU5WQWJkVmpW?=
 =?utf-8?B?TSttanpNZ2VtSGRMbzJHdkxkc1ZiTVc1bEFhQ3ZJZ3FhdHk1eVd5SzFvS0VT?=
 =?utf-8?B?TkpDYWJNSUFsN3FpMEJ2dHNIcDlEdmFTOW81a0pwK1J0U2xCOVl0ZHdoY1p5?=
 =?utf-8?B?VEhNd3krOFZySXhCc2JtRW5ZUThTTUJyckpMY0p1T1UvUTc4V1lreGdubUpm?=
 =?utf-8?B?c2dTRmU3NTRvaHA2YnNxRmoxdE43czRDbGlnYnFlMk5jTldQeWk5aXp4OXh4?=
 =?utf-8?B?d1ZSNUhiQmtBS2t2cDliRldRTlVHTWdKRmNHekhVV3prVkRiaFo3cGxLSWY3?=
 =?utf-8?B?YjlFdktHWjJ6am8xYXBHa2g1WDRpZVZKbHdVRmJUbmlQeUk5WDM0TEVhdFpL?=
 =?utf-8?B?Y1U5aWU0akhMK0p0SlNHY3hyNEdUYTdFZnY3bFZnRlhZQkdFaXp2Wi81MmpS?=
 =?utf-8?B?Sk5IcjlWNWZxbnpNbzN3RnBhV0tVM2JkcHBmUXV1OC94VHVhZlU0WWNQWUI1?=
 =?utf-8?B?ck8vTStBelg4L2xsMnhxZ0thWlVpTGZQYm9yUWJoc01HdU55RzJ4Mk1mRGc2?=
 =?utf-8?B?Rk10bzU2WHRVWGJPbzhXenhzM1dydGVFcEpLeGw0cWVTV0ZnL2tkTk1WNXRF?=
 =?utf-8?Q?1N+uCFW8ih0j3CY6LBi1tlZauIkBQ5z/9/t6C44eYemM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0BF9D2AC1245B4298F8650AAD5A9803@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca9ca45-5f81-4090-f453-08db5129254b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 07:35:36.3799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZv+F/iMLffZBBLaGcp6Pr9La4scahCQFm2LoigkETOL2mdO5gdi7krp1ig6Bw/iwhjRVPpekwWYLchBvPiyvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMC8yMyAwMDowMiwgWGlhbyBZYW5nIHdyb3RlOg0KPiBudm1lb2YtbXAgYW5kIHNycCB0
ZXN0IGdyb3VwcyBjYW4gYmUgZXhlY3V0ZWQgd2l0aCBidWlsdC1pbg0KPiBzY3NpX2RoX2FsdWEs
IHNjc2lfZGhfZW1jIGFuZCBzY3NpX2RoX3JkYWMgZHJpdmVycy4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4gLS0tDQo+DQoNCndlIG1pZ2h0
IHJlbW92ZSBudm1lb2YtbXAsIHNvIG5vdCBzdXJlIGlmIHRoYXQgcGFydCBpcw0KbmVlZGVkLCBs
ZXQncyB3YWl0IGZvciBvdGhlcnMgdG8gcmVwbHkgLi4NCg0KLWNrDQoNCg0K
