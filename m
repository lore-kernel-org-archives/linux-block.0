Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1D0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 05:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiFMFvo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jun 2022 01:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiFMFvo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 01:51:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC33C36
        for <linux-block@vger.kernel.org>; Sun, 12 Jun 2022 22:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl7kPH3ztpMk1FqE7+PvhUqqI1b/bqkrOvxRF3qmoEWkTAaq7SG5FLPuUPRCTsQbATGgas9ze0vejuAL3MQFh61HwPpXs8o2JCRPQr7TuXp7+AM4y8vE/Z+8mua1SzizQnEcwtnCokNjNkSxixFH3IWzL/kMaz+e/o3bX2QXW2/T9LsFuj2xFOILrhO/FE1lqk/fOHW1ksx+RgHSmdRxaH9L3he0H35obswC0JJVXld9YWofZ/x4SOJAtSeO55ZN7IL4/bhHD+sQvWu8AufLPXv7fX6prM8vXM4WN6a8HwELyZSe4dU1ltV5jB2Zp5Z55+2fFpFGas2jS+ZHrPbq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKkfJWzAkNRf10+Htm+nt3QSRAtzry0Ja+LmvP22G6U=;
 b=dtk+MkGznHSmf7GtVJVaBpitow9pcgeTm5NK3XaRYdB042Nyo8xWNhtiMKoQ90L2R7ApVwO7otAldqCBCA7h5A8zsFKHQn4sYdb4XvJm+XOuD0l1L4n9OXMBO4jRb1Bhl2GT/UDOkVQv5qdQfhefmHgCbbE8B6H8GLBy3oj1a2ZuqvHz4iuqeJ689UK7V1QXf0b6GI5pA1jWAb9jX5LUN5CDaHgny3l+PedThOiM68qh0NgT59Xz8aA4q9Wm8LHAEiB9PMsbSlaHovpsMoOE7zjF7ldKNw4sBxC2jwfA+6Um/rvVxtYM2BPyvl9Sxbqs8PrUZELazqOJIBKCU2y+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKkfJWzAkNRf10+Htm+nt3QSRAtzry0Ja+LmvP22G6U=;
 b=LabGEbAM+FP+AfvAeZ+mTv3jnSQD/DxgxbSJhSSzG7jZy4B+cbaRuq4X3qhZwfQ53+z4Z7HC5DGhw1iI9P/Spz/7RlnojrGpYuT2nUFPxq+SYWk7wZQBtQmocvX2AjBzROEoOxOkQ1jZ4HSeB/Q68Y3UKQjIP6WimiklKwwoO77CdUt6zMjOFSNC2SPJGqQUYL1uyg8ACggfrJh/EY793/vwLSetXJytUfdHgPtrlJFHSDhyrrv71m4TKn/8sf8PisTIchUran6mFQymswnQJPsXAoJgGKhvfwI1sxAMpTc9jZN8QgAVUAw/DAuLD+Dhr2VVEnF2tlyPVW7IXSbkVg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 05:51:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 05:51:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Alan Adamson <alan.adamson@oracle.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests] nvme/039: avoid module loads for various
 transport types
Thread-Topic: [PATCH blktests] nvme/039: avoid module loads for various
 transport types
Thread-Index: AQHYfMPCNl1t0VEPd0icKrQgH0uNCK1M2csA
Date:   Mon, 13 Jun 2022 05:51:41 +0000
Message-ID: <d7c3df9c-b46e-3751-b681-43c17ab97da4@nvidia.com>
References: <20220610121518.548549-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220610121518.548549-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68315c26-0e6f-487f-147f-08da4d00ca48
x-ms-traffictypediagnostic: SA0PR12MB4446:EE_
x-microsoft-antispam-prvs: <SA0PR12MB44462EB7FA1C37D0A15B4B12A3AB9@SA0PR12MB4446.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZTsVPptUaj4wN9SsXFFNsNlW9/5Ue4DA6Fee+jYYMi+JObypIbVIaxbPIThpOIVwn2UIG11cFrY6m+uYGtX9xpb6b8OeE3x9dlsV2S+Fme1nGIKZQcMUJrxL/y33ueQqhO3WMB4otYfUcyT33iS8f/+258/SdyLtLH37Rf4N3tML6v4XWT4xZqV3G+GOENLJlqY3YXX6g8apFiE5FFAB+LmL8GuYQ0/JD/RKuJHJiUPLcoKmkAIVg+Te2KfBnnGtJWjmDGmr5xT+GGdVxqQqgBpnrMFsPTLCz9GjeVDPac8Qlvmf0bwJLn7MDkBPOVVH6hRP/Okp+C8nlpQsnaUz/jDzA+y4OySj+UKo96vv/OPW7BwNimKcZYwXTqLAM3uV/RGxOuNt9dI/VaisblOJjKJk5C2XL8lAPtTfyISmoJDhxTLGPKoXsdzHZV65Q06lc6szziK1WLZS3pJnvQBU4MMxtFK2ScXIu/yyl8mZ5taKljWx2zwOcTraTzMidqJo0kSEEPBHOtY2TorATxwKIS42tbcRY7yT9KCRfOixOIPTh1p4X24OgSaGRefq/eY0xpRqA6CxIhgRflP7ve8hagLGv8UzEP+tfKznpReoZAJ+pYNlB1U/eeA1T3Ax/ipoZV/Ar0YVLkNx+KQmuptnNaspvzKuL/du5lFkSejDORk2ySMEQVgrsUZaGTikC1v3XwPiOIpwcBGZPtuSFxf0+heHalKQTHbSx7ROhp3umTp/EdUQfQddgpBw+iwRnV7e8cT6dPRYZHHMTgXY5tdmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66946007)(76116006)(66556008)(91956017)(66476007)(66446008)(4326008)(2906002)(8676002)(64756008)(8936002)(508600001)(6486002)(4744005)(5660300002)(31686004)(38100700002)(6512007)(6506007)(86362001)(71200400001)(31696002)(53546011)(122000001)(36756003)(54906003)(316002)(110136005)(2616005)(107886003)(38070700005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sng2T2p2dTZzRjg3aXRlbVJ6aGQrZGI1dlE0STNjT3VLMHEzMmtTcCtTeXlx?=
 =?utf-8?B?eVNreU5aQm0wS0tHNFprdUtkWlJzb0VpTERCcllwYTRTNXdjRUwydWtGYTh6?=
 =?utf-8?B?ditPN2xuUlRqT2NGWXRZYy96RUZkWHpJR0lERW9yWTZlUW9sQ0R6TnRwMlZr?=
 =?utf-8?B?bVB3cDFWRlFINDRScHFSNHNSTzI2NVZCSEZYWWxLKzUwM3FodFRyQXo4OFhZ?=
 =?utf-8?B?Y0RZWGZxaFR5OFBwdEhiempPVCtlVlRoRmJ4dzdFam95Y29SZTQxd0NPNzVy?=
 =?utf-8?B?OHhCdTdkVHZldVFMV3I1bkt3cWs2Qmd6bGdjR2lTbmovL1dJbVMxdHpaOUVD?=
 =?utf-8?B?WTF3TEYvKzhJOXhqTnhpRGlwNUpSNkZMa3dSSE0vK2FCTTlTaFAvazZIaWNF?=
 =?utf-8?B?MnFwb2xacVRBZU96anU4YWRWMlRxemRNT1kySUE4dlptems2Mkd4a1M3azlU?=
 =?utf-8?B?dkpYcytMSU1BRE9la3BsdkRBSUtpRUhiSjJ0WWMwU1BFblJ2Sys5QXFtVEl6?=
 =?utf-8?B?QWt2cDhLN0RTalBTSUJ5ZWtHMzQyWTNDQmhTYmpaVmQ4VUNCWEltVlVKeGFS?=
 =?utf-8?B?ZEVjSzJ2QzEyeWVDYXZya2N4eTFXRk1yOGwxWkdQT2ZycmFoRmNVeVJyQ2lN?=
 =?utf-8?B?VmhDSFZjb0JYVVRsVWJyVk9LWVZqcFBVQ0dyY01oVDlxbktDdmQySzBpUy9Z?=
 =?utf-8?B?c1k5L05LdVI0WWl6anhRYWxLQnJuRFZqQ0Y4WHBRWHhwTGpsWFRDeThST0VF?=
 =?utf-8?B?V25GRkFFbllYcjZOZG9aeFJ4M0Z0dzN4elRvZjR0YUIxa2pTQ3I2eWRPTE1Q?=
 =?utf-8?B?UWlPNjUwR21JMjBXa2RYclFSS2J5amxCWi9pTGxYZkFMWUFGa083ck1pTkt3?=
 =?utf-8?B?ZDlMTUJEd2VxSmszSU4zVWhjbktRTm16ajlqY09YbktBOURneHF4MXBYNTdQ?=
 =?utf-8?B?ZStKWGRSK2xKZTRMUXFUY21RZTFRQTNoVEJRcGJQL2x1MjRRenJFU0NLcldy?=
 =?utf-8?B?T1BkaW5XVTJzRWJTQUJqTUJlU3hXOHdBOHVVTmpxNXh6QXh2cWhzeVR6RjFM?=
 =?utf-8?B?Ri9tenZpVGtwakVPVk9JUm1lYTMxQ3ZRb2RCZHJVZS9CK2NFQ05Qd0UvK0Nt?=
 =?utf-8?B?em8wdXU2amFXWWhXMjgwYTVDRUx4OGRCQmxURitmQnlndGUwYjdXYmVhQkNU?=
 =?utf-8?B?YUxIQlpacy9PT1RGa2VPeEwyYmhJZDRaNWtEWHY3ZGJQenA4RUhDZW02VEdv?=
 =?utf-8?B?QzFiZ0RNMklzNk5Bc0V6M2IrNm51SGdIL2tZMVRYQVhacEJHNldQMm5Qc05m?=
 =?utf-8?B?THNlQ0hUSGExSk92YzZEMVhhYmdRZE1JMzRSZXEyWGJKdzFHNU5KNkJGV0dy?=
 =?utf-8?B?Q0IwdkFHUUlzczRudmZ4cFYvYnZNKzg4SjBzMDhsK0t3RlBFa0NFVlFUWXpk?=
 =?utf-8?B?U0NTYi9SQ3AzOWo2QlpyaWl0akxSOWRaTE1seDhpc1ZxM001RE1pNlViUE1P?=
 =?utf-8?B?Z0dieXVpUWtOZjFRcSswc3pzRGZ2ZXJrbzhCc3c2ZkhPQk40MEozd2NGQ3RS?=
 =?utf-8?B?ZTNSTVBIem53dk1jMGVNYzQzZFpGWnRHZnE1THdqMmY5ZWFJL2ZDYktjMVlj?=
 =?utf-8?B?bnJwZnQ1bzZVZzlLL3R5TmtGdEFRd0hZN0gvRkNLdDNZbGVtMUkxck1Ebit3?=
 =?utf-8?B?V2VrakkrSldnZHl4WjNnbGZLbFArTUk4a1JZcGRPUEhJUU1UbkpacS9BTURx?=
 =?utf-8?B?NVAwN2tjUHRQbDRxOXRRNUJqK2ZIMkNPNEtZSzRRZE00YXUyWHJFb3ZCUy92?=
 =?utf-8?B?TkMvYU5GbjhlZTZ6U2kwcktQZ2lQc1B1b3NsM3hXU1U4YTdUSFgxVDN3MEtX?=
 =?utf-8?B?eFBRZlU3ekZCSng3MmtTNW9LWVZ5VmdWbi9hUjgyYURFb2pSTUNVdHovMU1i?=
 =?utf-8?B?TDdpc3RzY3gyWnY2dnM0N29qQ2R4dnk3bnVNSkhId3NFdXVyQ0RBdU1NR1pS?=
 =?utf-8?B?eS93MnhVOW83VUlseHBCR2ltV05UVFh0U1ZvYmsvZUhNcUZQTVdLTHNNb1NS?=
 =?utf-8?B?eXVRSG9Ec2VyS01yeDlDMm5VQ2UvK1dEeFhnZFpPMjdTTnJDL01qK0YweTNY?=
 =?utf-8?B?QjJ1aHN3S2dxVFVlUFVKTUZDQnRDV1RoVjhieVBCdDd1ZWdTMGszKzZjT2Uz?=
 =?utf-8?B?dEFwUUtScGhFSUNoeWlaeWVvSHZEaGE2VDVQeGdwUm02ZDkzblZlbHo1S0xM?=
 =?utf-8?B?RmN3MHJQWUpyUXZLUTJtUUtnNURoUGc3ais2aWtPMTdCRmZWaENlYTd0ZkNj?=
 =?utf-8?B?Sjh5Smw5M1ZGZHV0TmxsUEpQb0lyN2xDdm9lUEdlTE55MVRIWEgxcmsvSll6?=
 =?utf-8?Q?JSYC/ohk8t+Cdr/nHUQYPLZ2l7wY3dfJjq/jPDLVmCfgu?=
x-ms-exchange-antispam-messagedata-1: lchGn7WXwWK+jg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C889ADA886461943991BD675F5853F0D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68315c26-0e6f-487f-147f-08da4d00ca48
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 05:51:41.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpUnfiiLHyUM/GQhgbrY+EumoEKsCD/feCv4kfACF0yxxC0POhY/S041BzAT+tcwzXjFqSDVAdpifX6z6jzofQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8xMC8yMDIyIDU6MTUgQU0sIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBUaGUg
dGVzdCBjYXNlIG52bWUvMDM5IGRvZXMgbm90IGRlcGVuZCBvbiBudm1lIHRyYW5zcG9ydCB0eXBl
IGFuZCBkb2VzDQo+IG5vdCByZXF1aXJlIG1vZHVsZXMgZm9yIHRoZSB0cmFuc3BvcnQgdHlwZXMu
IFRoZSBfbnZtZV9yZXF1aXJlcyBjYWxsIGluDQo+IHJlcXVpcmVzKCkgbG9hZHMgdGhlIG1vZHVs
ZXMgYW5kIHRob3NlIG1vZHVsZXMgYXJlIGxlZnQgdW5sb2FkZWQgYWZ0ZXINCj4gdGhlIHRlc3Qg
Y2FzZSBydW4uIFRoaXMgY2F1c2VzIGZhaWx1cmVzIG9mIGZvbGxvd2luZyBudm1lb2YtbXAgdGVz
dCBydW5zDQo+IHdpdGggbWVzc2FnZToNCj4gDQo+ICAgIG1vZHByb2JlOiBGQVRBTDogTW9kdWxl
IG52bWV0IGlzIGluIHVzZS4NCj4gDQo+IFRvIGF2b2lkIHRoZSB1bm5lY2Vzc2FyeSBtb2R1bGUg
bG9hZHMsIHJlbW92ZSBfbnZtZV9yZXF1aXJlcyBjYWxsLg0KPiBJbnN0ZWFkLCBqdXN0IGNoZWNr
IGV4aXN0ZW5jZSBvZiBudm1lIGNvbW1hbmQuDQo+IA0KPiBGaXhlczogOWFjY2I1Zjg2NjcwICgi
dGVzdHMvbnZtZTogYWRkIHRlc3RzIGZvciBlcnJvciBsb2dnaW5nIikNCj4gU2lnbmVkLW9mZi1i
eTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4g
LS0tDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
