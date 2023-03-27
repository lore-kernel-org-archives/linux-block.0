Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7385EC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 22:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjC0WYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjC0WYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 18:24:43 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C093C25
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 15:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiTbaOtjub39jNgG8FAl770mio/K2uoIJjLMceKmeMrdjB3hYnyXc+oXGB8EE/oafWQU2UFS1Vpquzjy7+mRcPUEHSD1h1lk0G6vEtkpKOVvmjGGd9QWj4sN14I0FnP8SChMMaTiirmAvoZ6s067kDRWk047DjwujWKvF9fu5RCfB4x0EUpb7mT3dY/tYZyBcIrjaqRWCcu6xjYfpuhBORrUVvKrJ8Gh49FkEW0idTti13Cq0cC4DUFQh5bjxamtH7Dsy3iRB/e7VDCrn8sJyYuUuZo3ihT0L+1vDa1efSzwtNmz+5z1l4/IWM+b/b8LEDa3Islvjy4NOIBYrkc6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7ETW5w4afL5/L9tHPztedTz/hoglVbnPNdZfXVbA5Y=;
 b=QUkGcpBEJZINOoXOlugjlm+vIFH6/ZYFmxdeVScm8jzt8a6/GAIjYUNUdru1/us2VB44vnGDIEIH5HbV6NUQLBOUge5ENHgQ9BOnckhPMXreLZUCP6CJSd8cfxaIyv7CrsWOVzBq0a9ymsQefqBZwKbcce4JhGdH2FR1cNKtU2pYG+ovSYNV9GRLDdxaVjqsYsm8Hzm/kYuU9BApNWycOOMt83r1pk5S/BgWqWNGLRw9yIXWrv92VAoS/qTTdQWCGVq7h9TiVzapWVJRNJaN3qY+TPXtx7P4FvrX7TSVRc6HNu7oG8ljzM/hajn1j6AHR4nUITvQlmse9dYS3ZAxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7ETW5w4afL5/L9tHPztedTz/hoglVbnPNdZfXVbA5Y=;
 b=eqrsGuzB9snXDiSVV0FjBfh5+IQPSHXuvTAc6AfNTLFUt5Hgnt3MiDXx+4mrNKsA+M/CmNf3WLzaPG4vVB2xwFIwJE92rY/SdPeCxIvPVWPi2t34bxh1oADOJxjO4SE86G29tIL2cQUrSXbyIws9E/LePHQCBSRuYAdmVwcwBTIM8Nd034UvsmT1NyR6gJsBApK03cyGo6YDKf1olpm/+C2HO39YV+FfYL+Xg1TGiP3+WZseCM5MdFbb4F4Y++upeU2/fklYp3AlMX9Aiy+3X5FIU9KAAbCI+J1T8qBFDqHzwGGXQ1BvjoAfgCpJLMHNHwRfybGAR32nK7OMC4pxuQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Mon, 27 Mar
 2023 22:23:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 22:23:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/2] block: open code __blk_account_io_start()
Thread-Topic: [PATCH 1/2] block: open code __blk_account_io_start()
Thread-Index: AQHZYH6hVk/todFNuUqZw/HDM0PD+68PMVaAgAADOYA=
Date:   Mon, 27 Mar 2023 22:23:37 +0000
Message-ID: <a021767b-bccf-be63-9cdf-ec0db42cace0@nvidia.com>
References: <20230327073427.4403-1-kch@nvidia.com>
 <20230327073427.4403-2-kch@nvidia.com> <ZCIUtZGOaxIza3j3@infradead.org>
In-Reply-To: <ZCIUtZGOaxIza3j3@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB8063:EE_
x-ms-office365-filtering-correlation-id: 45337273-2feb-4235-ce64-08db2f11e92b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2EhwXzGFNVd0A9PX91Vp0bnJLzdfYKIO+uVhNin6yUicWRCTG9JG3BBQbzYTuDcc8jHac0kvaUoB5Yk1Jvu1eB+ifgF4Fm0CpQN84PqPLztJpWV70dgRvLryRFwUDTozqLCszaOsUmxiBcYB380NbAfbfOM9fHIcujvLM1EHn8tUY5DyWz4RQOpPGkw9dPHRsYUYBonsXIMS6KZjwwsS885mW7TafYenJkT9EM3AcSe6ssZFdOqThzaSNscK+5mBL+o6BpbwKbYIib/Ov6vV4N7QXi3QMc3kQ9n3eT2BWYXGvpvkkLNXVSNydi1g4756eJG7zloeCOQ4e09kVPL3QadvWcu6hpgqK/MP6EU9vloyq3c53vA3rtNqstlaxLX7mFA4nGBdKOy4NEB4hHyhJX+GIT3+zghiAlFIDWXTWGtYjfgIcx2MPEvBeYPRsW/C459Z+Prmz3139K9AYiom44kO7FiZC9Hy6bPO4gOcymHe2hw+ZbONVR+EJ3zIE5E3d6ekPs8UWVQniYigy5FCR50C96r2/5IAf0vHUqjIcqWDHcbGgWG+XN2pQwb0X9s+rJYc01JAGTSpEh/Z5T1Rr9GvUI4uxPPy74d0RPZ6coOy9cWpoQnqTUbRVVgGntOP9MvzfmxtwjhOf+XeTmFaQahH+aj92T905pYfS2ssz58jo91w+nILmOYbvg412CO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(122000001)(38070700005)(8936002)(5660300002)(71200400001)(36756003)(53546011)(186003)(6506007)(6512007)(2906002)(107886003)(31696002)(86362001)(2616005)(83380400001)(6486002)(41300700001)(38100700002)(76116006)(478600001)(91956017)(66946007)(66446008)(66476007)(66556008)(64756008)(6916009)(4326008)(54906003)(8676002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFE3Vkt4V0hkVUxZdEltR3NIQXpqUW9DQis3Z2RsTTUvbGUvc3ArTzcvamlE?=
 =?utf-8?B?ZXBTZXJabWkreEN1R20wWHJySHlQb2s5WnR5dWxpUEtic09sUjBFTXdBckNB?=
 =?utf-8?B?N1psNEN6LzIyb0ZEV2hnclk4ZVQ5c2Z0K0RwazE0Mit6bXY1MFVkYWhsUEdK?=
 =?utf-8?B?STlYMUxCbUdtc0htcWhuZ3IwV0hGdkQzQ2RjN1Y0dTN0UHZINzJJZ0VaOUgw?=
 =?utf-8?B?K01BR1FoalB6UytPUjJ5Ymd3c2Yvek9vOG1Fd2FpRzNWcGtoOGl5aUZzaTBS?=
 =?utf-8?B?VUFueGxESTFhdGw0eklpdm9yYnJyTzduemdHWHhENkljU3J1bmhNL3hnQXBL?=
 =?utf-8?B?L3FvUXkwblJQU0V5MjFmYmtJSk9SRnNLTGgxNGd6ZnVFWXM1cVVMcmtwNHZO?=
 =?utf-8?B?bkcybFQ1cTYyMXFUOE1aVUt4VkV1WDcvN2NTMGltNFJ3STJlcnBpK3dHZ0Ry?=
 =?utf-8?B?ZWxEbjcxS2tyZHhqdC9pdDZKL1l1ZDlRK3R4TXZOb29CNHhYbm02bm9SQ3h0?=
 =?utf-8?B?a05oeGRVWjVOQVh6TzJTTnNJbzNzMVRwdVRKTVkya2paVjhUMzRMSDhiZ3lz?=
 =?utf-8?B?ZTBCRUUxT1VJeFVuZFN3d1pOdit5TlhFd0R3YTMxM1RDcHBPMU1iYmMwc0wx?=
 =?utf-8?B?NjlRWFN1cGpvU0FsTnVOTXFwQi91VnJOUSs0UEphb2JvVThDTzNUSFA1Qlkz?=
 =?utf-8?B?TTl6bS9DUTZnZjRQYytrejUweXVUS3J5VXc4azZOcDQzUjVLUUZzRStGZGRu?=
 =?utf-8?B?MFc4QjNoUlNnc2I2czY3OUZtYkZuTm5DcFlKR2wyVjRYSGdMV1ZuMTU3d2Ev?=
 =?utf-8?B?clJxSmpqRUY0WkljQlRFZThKaktiZW9pNzNiaXFHNExrb2MrL0F0RkdRMDZK?=
 =?utf-8?B?R0QzbW5lVVJmWnFoVnR0QURDS1lLVTdCK2JvS3lGNlZRWVlFNDlwWHhBeXZq?=
 =?utf-8?B?L3pXYWZVTnhTVXREMGZRZWRCT0NXb1VReUI2Y3JQWmcrZStQcXVRN0tYYTJP?=
 =?utf-8?B?OGU1cjkyZXVKbjlZbkUrYXp6WW9lblRRRWw4cUw1QWExejVCNHYvekxBNlov?=
 =?utf-8?B?aW00Wk1ZUVJ3TEpBaFRpOXMrSmgwbHpFZjhjUnBYRlNtSUk1Z2k0dXZ1c05h?=
 =?utf-8?B?aFpacFRmUUExYkxlbmlmbXcxanArK3k2SU9LTlU4bGlZbHozOURLMmFiZmhS?=
 =?utf-8?B?YW5PM3d1Y2FBcGQrTEwyeXJEQkt4Q2pGSzN2RGR0anFZMC9WYUNDekdkNjdk?=
 =?utf-8?B?ZVRyc1kxeE4yc1lMNlVrUEF5ckNLWjEwU1ljVlNsMHpTNWFvNmxYck5naU55?=
 =?utf-8?B?VTBkNWYxV28xbFcvaXNuMmtlYjdmSHlFdHRWckNwNWNxckFWMEo4enFyOHZw?=
 =?utf-8?B?bGlaNUsrNnpMcm1SWVNYNHpETlNVLy9UTlVHN01IV1IvV3gxSFpGZ0R0V3hm?=
 =?utf-8?B?QUhpdUtoY1Z2cStmc2tuZFR6TWpsNC8xRi9wcEtDNE04dzZvTnRRMUYvNm9i?=
 =?utf-8?B?T210UEFsQzUyUjJQMDhUUXMySmxGWkIwU0MvMTUrQ2pmR2dwSVN0MUZMSzUv?=
 =?utf-8?B?N2xWWFBycjlpZTltV3ZqdUZ2RzZrNlNqYVM3cE9SYldkcWwyVWM1dVNaV0cr?=
 =?utf-8?B?WHhwNUtNVEZVdWx5MlI3bmF5aysrOFhXT21GaENvZnlObmNialp6V3RENmtG?=
 =?utf-8?B?L3F6cHZTUjVoNG9nRTRwbzI3RkNlYXZDNzBEUWgzYjd0NUovRVJRMGtJUlhD?=
 =?utf-8?B?Mm8rWC9nTHltY3V4Z3hwZ01iTG5abnByNGVwK1FtT3hOdnhIZ2QxeE13Ulp6?=
 =?utf-8?B?TXpyVGxzcVhka0xGTDdFUlVaRWFuRlN1YmJ1Wml1L2tBZVMyQ3VzVStxVEFO?=
 =?utf-8?B?UDNyTDJBRkZLM2phUDJwY21ET0w0YTJ0SFV1WUp6V1pMeFV4QkVReWRNbElW?=
 =?utf-8?B?OUh6aWRQU3lGMk9xUjZ4NXJCandpNnZqckNRT2g0SE1BSnZTbWo3VGQ5aUFs?=
 =?utf-8?B?N2lmMlJZdDFqa2M4aFdrcm01cDRxbm9YRWY3bHhyTEVuK2tEdnRzaHdrdHc0?=
 =?utf-8?B?K1lrdUpVYTBmVkp6V0dGaHZWTGxTRkg4RmdwQXk5OVJUV2tCZkdlQ3JnL3l5?=
 =?utf-8?B?dkpoU3NWbVUwNHlIbjVsbHhUS3Z0QkJJdlRhODNpRGE4dmtta2oydHk1T3Ba?=
 =?utf-8?Q?iBYiLDrmPfrGz2qBwXN0cNn7fHdwylqWreEhXNVez3QV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8AF0273246C894A84F0315F00030F54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45337273-2feb-4235-ce64-08db2f11e92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 22:23:37.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klx5Y13k7PlN0QtKO1Rl1jgx5tBa4QrmVZD9B/lipOpEs80+3mufNY+WcFCGiDa/3zS1gb8Jmw+6p9TnYiZM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yNy8yMyAxNToxMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIE1vbiwgTWFy
IDI3LCAyMDIzIGF0IDEyOjM0OjI2QU0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IFRoZXJlIGlzIG9ubHkgb25lIGNhbGxlciBmb3IgX19ibGtfYWNjb3VudF9pb19zdGFydCgp
LCB0aGUgZnVuY3Rpb24NCj4+IGlzIHNtYWxsIGVub3VnaCB0byBmaXQgaW4gaXRzIGNhbGxlciBi
bGtfYWNjb3VudF9pb19zdGFydCgpLg0KPj4NCj4+IFJlbW92ZSB0aGUgZnVuY3Rpb24gYW5kIG9w
ZW5jb2RlIGluIHRoZSBpdHMgY2FsbGVyDQo+PiBibGtfYWNjb3VudF9pb19zdGFydCgpLg0KPiBI
YXZpbmcgdGhlIGFjY291bnQgc2xvdyBwYXRoIGluIGEgc2VwYXJhdGUgZnVuY3Rpb24gYWN0dWFs
bHkgaXMgbmljZSwNCj4gc2FtZSBmb3IgdGhlIG5leHQgcGF0Y2guDQo+DQo+PiArCQkvKg0KPj4g
KwkJICogQWxsIG5vbi1wYXNzdGhyb3VnaCByZXF1ZXN0cyBhcmUgY3JlYXRlZCBmcm9tIGEgYmlv
IHdpdGggb25lDQo+PiArCQkgKiBleGNlcHRpb246IHdoZW4gYSBmbHVzaCBjb21tYW5kIHRoYXQg
aXMgcGFydCBvZiBhIGZsdXNoIHNlcXVlbmNlDQo+PiArCQkgKiBnZW5lcmF0ZWQgYnkgdGhlIHN0
YXRlIG1hY2hpbmUgaW4gYmxrLWZsdXNoLmMgaXMgY2xvbmVkIG9udG8gdGhlDQo+PiArCQkgKiBs
b3dlciBkZXZpY2UgYnkgZG0tbXVsdGlwYXRoIHdlIGNhbiBnZXQgaGVyZSB3aXRob3V0IGEgYmlv
Lg0KPj4gKwkJICovDQo+IC4uLiBhbmQgbm93IHlvdSd2ZSBjcmVhdGVkIGEgdG90YWxseSBtZXNz
ZWQgdXAgYmxvY2sgY29tbWVudCBleHBhbmRpbmcNCj4gb3ZlciA4MCBjaGFyYWN0ZXJzLg0KDQpv
aGgsIGNoZWNrcGF0Y2ggZGlkbid0IHNwaXQgb3V0IGFueSB3YXJuaW5nIFsxXS4NCg0KLWNrDQoN
ClsxXQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCnAvYmxrLWFjY291bnQtY2xlYW51cC8wMDAxLWJsb2NrLW9w
ZW4tY29kZS1fX2Jsa19hY2NvdW50X2lvX3N0YXJ0LnBhdGNoDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KdG90
YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCA0NCBsaW5lcyBjaGVja2VkDQoNCnAvYmxrLWFjY291
bnQtY2xlYW51cC8wMDAxLWJsb2NrLW9wZW4tY29kZS1fX2Jsa19hY2NvdW50X2lvX3N0YXJ0LnBh
dGNoIA0KaGFzIG5vIG9idmlvdXMgc3R5bGUgcHJvYmxlbXMgYW5kIGlzIHJlYWR5IGZvciBzdWJt
aXNzaW9uLg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KcC9ibGstYWNjb3VudC1jbGVhbnVwLzAwMDItYmxvY2st
b3Blbi1jb2RlLV9fYmxrX2FjY291bnRfaW9fZG9uZS5wYXRjaA0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KdG90
YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCAzNCBsaW5lcyBjaGVja2VkDQoNCnAvYmxrLWFjY291
bnQtY2xlYW51cC8wMDAyLWJsb2NrLW9wZW4tY29kZS1fX2Jsa19hY2NvdW50X2lvX2RvbmUucGF0
Y2ggDQpoYXMgbm8gb2J2aW91cyBzdHlsZSBwcm9ibGVtcyBhbmQgaXMgcmVhZHkgZm9yIHN1Ym1p
c3Npb24uDQoNCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBmYWxzZSBwb3NpdGl2ZXMs
IHBsZWFzZSByZXBvcnQNCiDCoMKgwqDCoMKgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLg0KDQo=
