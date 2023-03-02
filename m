Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFD2C6FA8E
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCBS3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 13:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCBS3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 13:29:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0F15C8C
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 10:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVHOPBZS2wC11B8jn10tJ+OLeSOvvhjrnHaf9j9KBU8OgBW7HiyTcRB5G2epYX/LdECHdCXur4EexWXedSAwKdlcNzR6R9MVw6WaRGEwVJ30kM50rohbSfFmZ8Dpr2vg2387tVlPK68HpGaPwHN8ywRHWB+zmLh4RRCJ2EnL99ShV6ILBhCVLiG7qIDqJ00nyS4kJG7BqViuhEOOMwFgBXARlREQcEbjOqjEvfpKLVSV1Nq+c2GS+A7LfhryVBNDGGUQMVpxsMiVPTObtsraRD2Ek90LCnyHWQapmMl0cd6Zv+kLJIIDZBGQo5VZTjwCUygN+9YVeYAtjmqzQN0UEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT0aXd6SNJ+TlG4x/UcCyyc5IMlcmfJ2h+RKlDjJpY4=;
 b=Yrc0BMWJQrhONLvv0W+wu/knwARPPBGvkKszzksI2kOtVGBcLZX9bgdz3XClSPV2jEtL7ncTKSxGWKFclL9lWl6xxTIZH0nBEIMYuf9mlUuz/DXHANnl0loQA0MWFZbryj37A/pguO41emtCOR4z6fVoB1QAlZbGGnNaUOODa6Y5KvjTgG7kW/9aHocMVdD1yT2QlRWTAhog6pSyaoqkhNr2iqtTFSRTzaGF1SmW0uQ5VneS8ZAkHY2x7CpBUIpAlSpY5zJoRgjhnE2MiXGWB7La7DL8tSwS//jq1Q18AYqBpv/kwG+IB+z6teY3F5InTXltyBSKYuiHwczCgZmrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT0aXd6SNJ+TlG4x/UcCyyc5IMlcmfJ2h+RKlDjJpY4=;
 b=PZoZPltKrPmYgF2gizgXFNmTXQDLwPwZyugmC0nTQlS0Oq99ZfTgz6ZPH8Tpl/T3ce2+EAOYIY7CTJ9BmB8wJirdqVohQiSqLVBCRud3mfw1wANSORBnrjd4VwU7/DpGaQLZnki55mciKryrb64cwe6sCR35YpwXj7TyBdTRGF/Rt4YIyFAQTVIZj6Bm7tiTuwvoHgrowjFXZxX9N8Pwafqs9YomTV7kaaRplzzk4GOSL1tSbrh90DihgHkxuXFkZ758qNjGKvo7dNZDGg0Waw1hu50zTNtKvqKcdZI5bXAD2ur2LIR2Yz8aCXDh5al9KGKS+QPsmXSRuXojbeqRSQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 18:29:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 18:29:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>
Subject: Re: [PATCH -next 1/2] nbd: allow genl access outside init_net
Thread-Topic: [PATCH -next 1/2] nbd: allow genl access outside init_net
Thread-Index: AQHZR/WSjhFHimDwwEqyAqCR7Ot4aa7n2fEA
Date:   Thu, 2 Mar 2023 18:29:32 +0000
Message-ID: <929c68a3-4e3a-03b6-4723-6515d28aefe9@nvidia.com>
References: <20230224021301.1630703-1-kuba@kernel.org>
In-Reply-To: <20230224021301.1630703-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH8PR12MB8605:EE_
x-ms-office365-filtering-correlation-id: c9e034eb-dc88-4bbb-eaba-08db1b4c1148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mXzPAoTDIztk4PGx7iIeYNijROWxtfgtbJy4j88Z0Jv3CP0lCvtkn+c7mQ2BNkJHPsVvZL7pY4qcry8Pa599WO5SxlcQi751EwsahGCGHk5RteUzt6m4yWBLaI34jnWfJktXhz61BN8cOBzxCWk1dGRxLbAVCLqOnfZupNsHfgImGpyX7pqZhEgPNxSi6n5V1y2QXgnZx1PxE4VpSMU24tpvvcJvzu1iLgJ0lbJgD73D7b2zo0B5Emq6XvtsbMyB8k3I34hflKaeEtAoocFGqIgsxTqsa+iUk+d8nhtk/MJ04MMVNySFxyKZxpJmjged95QhQdjAsRcOAFpumHxJ6Rf5FrPrY4kgJjZiv77+Dm3yZn7nPZcQ8eeJ76ICAsReqc49Gfxlkhqp8ypS7X71SNxf8M9MlgA5oonSAu6X/JyotliC2RiQlI4Y48KbGYer/diHxOL7nFN4yys1wGy4oaT1bbeuZ40aqXztlRFhjlZ//rM6BjUUInwB4V0a15j2n6cZZSuoA+PaCdgX/N7afQIfXfvVGjS0zrl4QbueHHP3Nl2GQk2eQWzl0aQ6G6dxGTp3CGxcRX9+YaUhJ7E/9Ejo9X2NMkPhjDA7BGtbCfD4IQ0E2yjCJO3iyE9l/aLPyIRbRPbnoR59hEU9Ds5FPMMfhMBFttw4UhD/+bxUQd6VlrvxKtH5oeAJI693L37W8zi9yqjyi5fVFeCwrqVynIUFZD1mWza9lRvUr/+5YGqHyaM9d6yF6ur/eg02Kjmu61QF7+51dIoNQl0Ey+EvHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(31686004)(83380400001)(71200400001)(36756003)(38100700002)(122000001)(5660300002)(8936002)(478600001)(86362001)(66946007)(31696002)(558084003)(38070700005)(2616005)(26005)(6486002)(6512007)(6506007)(53546011)(66446008)(76116006)(66476007)(186003)(64756008)(66556008)(2906002)(8676002)(91956017)(41300700001)(4326008)(316002)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm96czl2ekx2RlhTQzNFdnBEN3ZYZU5sT3N6Rll0c3RKRmRoQnB2cFNRNFly?=
 =?utf-8?B?OFUxd3VlYmpWY0hUbmFVQjk1NldPeTBzbG8zekdiaHBwejU0ejJSM0JRN2xn?=
 =?utf-8?B?RDBYRENNTmFiVXNrSU5qdnJTdFRacVlmb042aFU0aTMvUHdUcUNXVmMrcm9G?=
 =?utf-8?B?dWwzQ0pDWi90Q1R2TGkyd2d6dWdOeU1nbG1nL0xEN2VzSWtJU2hnc2FTMndB?=
 =?utf-8?B?SklHOGd1L0hpb2xCMmdvaytRZ1l6NklETmJ2L1Y4clduQ3VWbG5aN1JINzQ5?=
 =?utf-8?B?TEE3MFpoWTNZWUZ4UVNsei9tT245bjFCOW41dXVwWHNOcVowNHlHQWliT25J?=
 =?utf-8?B?aVFPUnRWQ0RSN1crRkhzU3hGVkE4VFhEN3RSc21GK1VFdDA3dlZLaTMxMUw1?=
 =?utf-8?B?MnRKWW90dVVLd2RjOWFEM1l4amxaTUN0OUtreVhpZDBJb0N4dmFZdGZUZTha?=
 =?utf-8?B?aUwrRDVQSTJoWVp0Q0RCZTgyWWpzMjhhcXdzajhzNGhHYVlib0tvVzhzclpJ?=
 =?utf-8?B?VlZrL1NQQnFpeElEdmE1dUNiOTNNMTNuWkFTdjUwbHdKWm9WQXoxaTRCSVps?=
 =?utf-8?B?eUczRXo5anpvVXNtT1k5cW5NU3FYcVNGeU5zTStnZE1WTzYwazRUNTlIRWhR?=
 =?utf-8?B?Rm5IRzZEaDFZWG5pZUJ6NlRGc1Zic1BUWklLQnNsN1RGNVljbm5PTjc3Z2NO?=
 =?utf-8?B?QWhTNElIQlAyU01hL3dUTUJROVhTYWxpM3JXNWFQS0x5K2dLR3FkTEQxSFFM?=
 =?utf-8?B?M1cxVGhDMWFiYWlvR25XVXBDbWRRdjVRd0M2bk9pUzFmUWxxbjRaWDh5MkJS?=
 =?utf-8?B?dlRqbGMrem01YWZVU0wwdE1ldjhPUlI4eEZWdDloaDlaSWQzRFFLYlV3dVc5?=
 =?utf-8?B?U1FWUmpGUk13YTlkbldCTUlmbEllOGh2TFFKMFRkODZXbm9DanZ0bEY5WUg2?=
 =?utf-8?B?VzdNRW1NN295RnBRbTVUZ0lIbHVTNVcwdWNIeDR2U3lJUDFDQlpnZTUvT2hJ?=
 =?utf-8?B?eDlvSVNCVmgzVVBKdWNqb0ZiQmFRRVpZVXFyenpNNnVGSGdJWlk1dkNxcExm?=
 =?utf-8?B?dXFRUitMN0xLYnloaUlLbFJyaWQzcEk1MWJ2UFJONHh6dEhUeis2a3QycU9i?=
 =?utf-8?B?Vkw4YlZFK1d1TEtOd3UzNzJSYWIra3B5QTNWdi94eEZ4aVhReDkxOXROMjVo?=
 =?utf-8?B?SWRBOGgzdmRJTmNMTjMyVEtMWlhuSnlhR2lKb2c0c3B4SVl6RzZSWWZ2WExk?=
 =?utf-8?B?N2R5SU8xUEVHeTd1UDFLbHU5VFE4M3M1S3ZkZTJob0dja3FDWUxpeXhNSTZE?=
 =?utf-8?B?Y1VXZFFWQzhVV1lieTJwUTRaMS9FZXRXRmlWR3JobXRydFpMQUtIK1lPQzJ0?=
 =?utf-8?B?OHZSbkZ5MXM0T21lN21ZQytjWjNsNDAzd1VwdTZDTmxQYXdwQlJHMHYwNFRD?=
 =?utf-8?B?akdLbmpuZjBIU0ErTFFPQk8vQjZVTXljbkt4VmpkYisrL0paWHhFSXEzUytk?=
 =?utf-8?B?VllldFIyU1BhTXdkb0lPUGVyVmY1TlZKWjBIRFlQckcxdytGVG9ZQkEzdWFm?=
 =?utf-8?B?a0RKWjF3VzR4SEphb2VRKzgzTmRPSUNIbVdrUlVDRHdHNTBFTGZhcHhkSUs4?=
 =?utf-8?B?VkpWZ2JRWUI3SG9HNEU0a2xnNnlibWhIRndyc3N0OCszelo3V0p6ak5TTzgy?=
 =?utf-8?B?T0F2aDRISlA2Qk01emZUZVAxZVRURkE4ekd2MTFWTXVuaHBWUGdaeTV1cC9F?=
 =?utf-8?B?NU0veDhrMDdUK1RIOHNPMTJpRW5CQXB5VFRDTzRhYlRocGRlN3VzMmsraGJT?=
 =?utf-8?B?eTc5ckZNdjFwcThYM014YTExMUVJU0QyVlo1QVR5ZFJyVVBzc0NxSFVaakpZ?=
 =?utf-8?B?c25USExBMHRUelJTajJsVW9DRWl6Uzd2UEE1cVBEUWtwTEJyeEY1YVpwNjRW?=
 =?utf-8?B?ckkrYXJBekYvRWU5ZTZjRGdNeDBSak0yYVFtc0d3ZG8xZGtYWmVEVG5GR0Jt?=
 =?utf-8?B?NU9ueGcxUUNDbDNnc1pldkxGRDY0bU1IUDRlK05WbWI2NXNpcWxzMHZnUXNL?=
 =?utf-8?B?N0IvUlhMeXdIUUhib3F4VHZ0TUZMZWpjckVKell0V1Z4VE9PcnVOa0JBb1Fm?=
 =?utf-8?Q?WAe3vYK7Nx1ap7xNMvrd6Sa08?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21EA1E589E35384C833801D25016A8BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e034eb-dc88-4bbb-eaba-08db1b4c1148
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:29:32.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chPC8ZavNeldggw6baudVTRlJP7WxWZs5rWHvOkTaDEABCVsnvYp0loZUGw3sBln470ZzFMoDgdV9qOE+OPvFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yMy8yMyAxODoxMywgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IE5CRCBkb2Vzbid0IGhh
dmUgbXVjaCB0byBkbyB3aXRoIG5ldHdvcmtpbmcsIGFsbG93IHVzZXJzIG91dHNpZGUNCj4gaW5p
dF9uZXQgdG8gYWNjZXNzIHRoZSBmYW1pbHkuDQo+IA0KPiBSZXZpZXdlZC1ieTogSm9zZWYgQmFj
aWsgPGpvc2VmQHRveGljcGFuZGEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KDQo=
