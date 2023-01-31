Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C66FC636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 21:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjAaVks (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 16:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaVkr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 16:40:47 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC90D19F2F
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 13:40:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY9A/co5sdynqcHIeuG60+ZKQpGbaDuRXsqrwhqJRtGkVHv518cz/ePFiU8oRb52Vjraiv/Eb6huyl8r+kjRUrZ5zvx1I0PE8sSUCnNkRpUeT+CfcY8qpGDknAc5lbEX0otdWyQ2OO0p82cx11qXQbShG4cpYLiDpafUq2x9hR1aLiTdRmEyiMezcqxbkZjNiTzrUJ5iRkZAB7KCMzhzxQAs6+jWM+2saXW+jBjlg2z9AapQTKAT+lrToMpyvTy2r2xF80ixuY+CeKWq5PdHwU/eQ2PyS6L6T9wo5ZlY8gbgjuHYx3U3hVBf24W5G7kIjQ+ljwBkGWwuoDD6z+G2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEARC5X/QZNsSEUuBpVMXNQDy0wu82uRKYzTz/5oavE=;
 b=VsMr2MdhytoU8tNDtbVRN4Xi8tAxPgf0gVQAD/zUTwJ+ddO8MbSTIOOunYo9aC23ddeQ/Jp4nH1lxsaCuC0gc0Z5lbND56O+8X61bca2+rbtkHiaA0jg/EnVQOyJaEq0Bw6tBO/+PWC8tPF1vLM8aQrO8oG2J3G3RqMOrP6gOettFY3kHwcLN59SNCqgKhxw1naePvRlfdTqjvxJxDqf/1SklDWBcDGqhH8myWLB4rFetEgMqmx3QlGASpkCfvConMc4GDlxYfKo2hobdl1awuHUqcoyKKwIJWxkm06WJkd2wgPFxJCHZ25UkpwsGq7Gm3X4eBgDDIeemuwZA5oluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEARC5X/QZNsSEUuBpVMXNQDy0wu82uRKYzTz/5oavE=;
 b=k+7Mmv4mdDU8NtySk9t39tjT6lhuZOrz0JvCKb7imj9B8ybK43pnrIKT1aZLvx1cpn9jbfNA7Z47cKWwNxAwrpQ+Xh3Cx/O30mUZg597Mlb3+nxLFL48/9gHvoN79VtOCBdG77vjV85KM3MbU0SsnBpqbJucltnJtU9Qe38BhMf2ijWpyGy1WzDWS4vEz+uLyyJ4ktA45Ro3oS/FgJRHBc04mtCSvowXomLVjzgv0c5Gm2lxLgjk3jY2AkiEcj6fNrkLsKNSnbYKalTz2B/u8f1+D4WgBJ5lSft8M8ekkM7gTgLtIw6tPUpFLkwff/Lc6XF8pXB0YPwmADSYUCPpzA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 21:40:45 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 21:40:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH] loop: Improve the hw_queue_depth kernel module parameter
 implementation
Thread-Topic: [PATCH] loop: Improve the hw_queue_depth kernel module parameter
 implementation
Thread-Index: AQHZNO/Enpye0sLXoUmsRaY1DtK47665D3gA
Date:   Tue, 31 Jan 2023 21:40:45 +0000
Message-ID: <9957a0ed-ed74-ff02-ca28-7b16196bdaa7@nvidia.com>
References: <20230130211347.832110-1-bvanassche@acm.org>
In-Reply-To: <20230130211347.832110-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|SA1PR12MB5657:EE_
x-ms-office365-filtering-correlation-id: dd43b39b-a1aa-4cdc-6177-08db03d3cf20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZWW6dJkFWXtM9VbwEkDEzTIH4lS3WXvHGoAUzRIMOQTMaRzRoHvBaW4LXXBk+R1aqLeIQ/rcsF2ekfUwyfx+nGzN2cmQOBLPs+P6b6I2FL9tDi+4XZhErY7AxXdeEaMvg3rCBaqVibERVDDQ/wKR2KiYDkFZZzB/vvK8V5NdPgs5mR8Z99AU6ipkgGugPleavkUWO43mVABXxYTfLa5hG3jwpkJT9GPKjzIEar8eLw3h7iqrm2wiigT6OfXzSh5YD5gbrttRTz4zPZnLbWUewvoXtlN9AJVeClSDL+W43kQFBRz26Ec9iy1qGv0jJ3x7sjjkaxeqiqoH8/UBDHWRqh16xsWJeTu5KINuYiG7QG+OA/J+7GG36GDaVPQAMSMerU19HnuUD82bGPhj/HVMimQXNm/s9XEpqIajtnTkRbYdCRmHa4NxXOE2Cf5748gX7TkZCZqvX4Q4tXGFXn2y0fHlbl1uIdvosjz1Zfkqn3igz2YMAnPn6jSdWuivHqam0geiZjIJgL68I5keU/B76Lw9mCVTX5a3evTJJnyxkbpGRYd2CKohOZB1bVVR2HD5kdxsbDBvKVghRoip7oHooamcChDD6ILXl3DAp/SxuYUbjKNxv66BmP58/wf415olHM5vIoRlvLkYghW3BcO39c+0ezv0m3DynfzJzJf6KoBFFjlKA6nnR0yfFM3Ec1dUNqoARExB4dn3HG+3SNOso4QszBk2JYRC0Vc5KTXnUfu+OtRJuyIFl5YG7oBr098oLeoFPc6hGJPNBaa4FRNag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(8676002)(316002)(478600001)(86362001)(4326008)(6916009)(54906003)(36756003)(71200400001)(6486002)(64756008)(91956017)(66446008)(66476007)(66556008)(66946007)(76116006)(2616005)(31686004)(53546011)(38100700002)(6506007)(2906002)(186003)(31696002)(6512007)(38070700005)(122000001)(41300700001)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEpDbU84UEhoZkN5Vkk2V1k4ZzN6MHNrdmFVRnc0amhERjFFbXphS3JxRm9T?=
 =?utf-8?B?OU5WUXgvcS92V1J4dzhWUDFsSVZVY05DN0pwQ2NIVzhDcVpXMDFGSWhoU1hj?=
 =?utf-8?B?ZGtBVERPWmJ4L3g3UmpXc2dHcWtCZ0xSMUxyOWVvMVZkN0FUS3pKWjVkNTVy?=
 =?utf-8?B?dGVzR08zUzRQSFhFZFdIOHg4SXlNQWJoSVYwZmZqeUg2eWJYckJxSWRhajh0?=
 =?utf-8?B?eklpNWZQS3dSY2xHSG9GNkMzZDNCcGtjYXAwbGJaUllXRS9ERG0xd2RuUnhF?=
 =?utf-8?B?UHdMNDB6VEZmYWVVc0ZEMkR2dmdqbEdLbFQ2UDVldURyUnR0OGxLbmNFYS84?=
 =?utf-8?B?cTZXdWt5MlBueU1tei91VDJKbVFuNnFUNlE3OG9rQjVWMll6VXdkekhNUFI5?=
 =?utf-8?B?ajBGMVJJU1lzZE9vaUM2RFhBK0JXN1NvVk1DZW5CUkxwRkx1a3Fyak5MdkJ0?=
 =?utf-8?B?NzVrMlZPU3NJbFh2bGZQbVFyakxpcTlWVnN4cm5OcmJTSkZyZGc3SG1TbFBS?=
 =?utf-8?B?V2U3QlMyb2JiSWNtWHUwdVVaN2JPWnUwTUozWVZwZGJWdmdXbHoxbmFmNlov?=
 =?utf-8?B?WGx6bWM4dHRDaHYyalpSK2xPdnZLYmpqbGl2Y2E1ZFN3SFdWZ0JqQTNHVVdS?=
 =?utf-8?B?UC9RK3g1eERpcEtmS3pDTmlya0R5N3FJQnVScStVcVBKN1VldnN4ZjBVYk5C?=
 =?utf-8?B?SEN2dFFWTG4xMDc3MUtiUFdsSEh3aDlxa1RpTzVhN25qMndwam8wRVhQSkJV?=
 =?utf-8?B?MU5KZVhhb29pNE1JRVJiTkd2MENYRGZqVnh6STRQNTllbStFTHZaaHhrSytB?=
 =?utf-8?B?ZmlOelVTWVFTWjVCVG8yY1AzMGhSU1ljU1RqdEE5U2tQbXRBeEp1NFQ3MkN0?=
 =?utf-8?B?eEtuTXZUY3psdDJ1ay9CMURBYk41SDlBOXlmT1E5NitxK1VxVDhBQzczbVF1?=
 =?utf-8?B?Z2M5Sm10emZxaGJBRVpnY0NTMS9vaEM5SENNeVYraHpEOXhtSWlFd2VXNFZl?=
 =?utf-8?B?VVFZQysyMVFoZ3V3MzlFZTNjMVBGZnJ5ZFdTSnh5cmZvKzltRWxYQ3hrUEEy?=
 =?utf-8?B?aUdudVZwb1JhOTRUbVg5Y2JFZzUvTnkrMWh5OU85RXk4R3pXMnhUa0E3NnN4?=
 =?utf-8?B?OUhOWGdEQ09lK09iUmR1SS9GQ01nNlFvQ1JNSWpianlvdkRWTGNwTHl1Znl1?=
 =?utf-8?B?dUJuaHZIVG9QUEVTbC9NWnA1Wm5TckN4UEJQZGJ6MHdrbytnZloySVoydENH?=
 =?utf-8?B?dHlGeEMzbU5wQXRWZE5QeVhkcmVqTE1uSjVPRm5xMjFqWVNTZGZuSnUvdmdS?=
 =?utf-8?B?c2dRRXRXU0hVV3A2cExaUy9XYks0eTVXSVVFNVRvaWc3azhyQVI3WkJ1cUMv?=
 =?utf-8?B?dDZqSzNDZWx4U1ZhT0t4S0diR3hPSjdHOWxQWkdNRnplVUxvM05veFNwZjNY?=
 =?utf-8?B?cTlQRnl1VFVyanpDUnRLdi90ZVJnVnVPbnpITVBLS1QwU3BqbmlTdkZaRmVZ?=
 =?utf-8?B?MGRBUGlyOUJzRXZsbTkwR0xIYjlTRWRSN2NDN2I5R281QWRaVlovd1YwWHhi?=
 =?utf-8?B?S1JzbXd5RkQ5T3E2a0FrYWFvSHY5NHBJVENYWHNuKzR3NGphN1BNSUF2bmtr?=
 =?utf-8?B?emp4MW5EY2Ywc3J2RHNPTGdHUW5XSUsyZllIdjdMSU1XbmR4TkkvMEs2N2ZG?=
 =?utf-8?B?SzdQUHVPMElFYjRXa21zSDZtR1Z6QnFWdUtHRGJRZ2NOclFqYnd4VHQ5VHJR?=
 =?utf-8?B?djRCdWJOK25WYXFBNDM2UlI2OG9oc0RvVHdJTitYdzFTV2pIUEFUdzAwTkkv?=
 =?utf-8?B?QkdMVW5KajhOdy94S01KbmVNOUtjYTB3UnM3QXc2emVjQ1F4M21RdndubTY0?=
 =?utf-8?B?Mm8weGsxOEpZRFZHdmJXeHVKb3Ayb0V4ZVlLK3dzMTI2djF6eGFUUEdYeUpX?=
 =?utf-8?B?STdLeUJxRG1zQXpTMDZoOHdkajRjVDBYYy9wQ0hmQWdienZ0amhkaXplcUp0?=
 =?utf-8?B?dzhYNWM5RDlpVnBnZmIxa2FDQnUxWlJMZ1I1aHBoaDZpNERJRy9qbE00Tlg0?=
 =?utf-8?B?WXAvNnovZk5aWjV6UFlSbTZ2V3pDMkh0Q0Q2cXMxYkZuZDN0bVFQS3MvRzg4?=
 =?utf-8?B?QU9HblpFQ25RYnJvMjF5VHA1MzdIVW1hMlN5NFhOVVRueGo2MlJPazZXT3V2?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F9BA1F558FEA345B98E410B7D022EE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd43b39b-a1aa-4cdc-6177-08db03d3cf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:40:45.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYt9CSwYW0QpmZC2cziEB3vO6kY87MnGo0/z+iLmyo8bRYu4Y2pclEaOv2htFkzEavt55JNGjHW12U1M6M75rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8zMC8yMyAxMzoxMywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBNYWtlIHRoZSBmb2xs
b3dpbmcgbWlub3IgY2hhbmdlcyB3aGljaCB3ZXJlIHJlcG9ydGVkIGJ5IGNvbGxlYWd1ZXMNCj4g
d2hpbGUgcmV2aWV3aW5nIHRoaXMgY29kZToNCj4gLSBSZW1vdmUgdGhlIHBhcmVudGhlc2VzIGZy
b20gYXJvdW5kIHRoZSBMT09QX0RFRkFVTFRfSFdfUV9ERVBUSA0KPiAgICBkZWZpbml0aW9uIHNp
bmNlIHRoZXNlIGFyZSBzdXBlcmZsdW91cy4NCj4gLSBBY2NlcHQgb3RoZXIgbnVtYmVyIGZvcm1h
dHMgdGhhbiBkZWNpbWFsLCBlLmcuIGhleGFkZWNpbWFsLg0KPiAtIERvIG5vdCBzZXQgaHdfcXVl
dWVfZGVwdGggdG8gYW4gb3V0LW9mLXJhbmdlIHZhbHVlLCBldmVuIGlmIHRoYXQgdmFsdWUNCj4g
ICAgd29uJ3QgYmUgdXNlZC4NCj4gLSBVc2UgdGhlIExPT1BfREVGQVVMVF9IV19RX0RFUFRIIG1h
Y3JvIGluIHRoZSBrZXJuZWwgbW9kdWxlIHBhcmFtZXRlcg0KPiAgICBkZXNjcmlwdGlvbiB0byBw
cmV2ZW50IHRoYXQgdGhlIGRlc2NyaXB0aW9uIGdldHMgb3V0IG9mIHN5bmMuDQo+IA0KPiBUaGlz
IHBhdGNoIGhhcyBiZWVuIHRlc3RlZCBhcyBmb2xsb3dzOg0KPiANCj4gICAjIG1vZHByb2JlIC1y
IGxvb3ANCj4gICAjIG1vZHByb2JlIGxvb3AgaHdfcXVldWVfZGVwdGg9LTENCj4gICBtb2Rwcm9i
ZTogRVJST1I6IGNvdWxkIG5vdCBpbnNlcnQgJ2xvb3AnOiBJbnZhbGlkIGFyZ3VtZW50DQo+ICAg
IyBtb2Rwcm9iZSBsb29wIGh3X3F1ZXVlX2RlcHRoPTANCj4gICBtb2Rwcm9iZTogRVJST1I6IGNv
dWxkIG5vdCBpbnNlcnQgJ2xvb3AnOiBJbnZhbGlkIGFyZ3VtZW50DQo+ICAgIyBtb2Rwcm9iZSBs
b29wIGh3X3F1ZXVlX2RlcHRoPTE7IGNhdCAvc3lzL21vZHVsZS9sb29wL3BhcmFtZXRlcnMvaHdf
cXVldWVfZGVwdGgNCj4gICAxDQo+ICAgIyBtb2Rwcm9iZSAtciBsb29wOyBtb2Rwcm9iZSBsb29w
OyBjYXQgL3N5cy9tb2R1bGUvbG9vcC9wYXJhbWV0ZXJzL2h3X3F1ZXVlX2RlcHRoIGh3X3F1ZXVl
X2RlcHRoPTB4MTANCj4gICAxNg0KPiAgICMgbW9kcHJvYmUgLXIgbG9vcDsgbW9kcHJvYmUgbG9v
cDsgY2F0IC9zeXMvbW9kdWxlL2xvb3AvcGFyYW1ldGVycy9od19xdWV1ZV9kZXB0aCBod19xdWV1
ZV9kZXB0aD0xMjgNCj4gICAxMjgNCj4gICAjIG1vZHByb2JlIC1yIGxvb3A7IG1vZHByb2JlIGxv
b3AgaHdfcXVldWVfZGVwdGg9MTI5OyBjYXQgL3N5cy9tb2R1bGUvbG9vcC9wYXJhbWV0ZXJzL2h3
X3F1ZXVlX2RlcHRoDQo+ICAgMTI5DQo+ICAgIyBtb2Rwcm9iZSAtciBsb29wOyBtb2Rwcm9iZSBs
b29wIGh3X3F1ZXVlX2RlcHRoPSQoKDE8PDMyKSkNCj4gICBtb2Rwcm9iZTogRVJST1I6IGNvdWxk
IG5vdCBpbnNlcnQgJ2xvb3AnOiBOdW1lcmljYWwgcmVzdWx0IG91dCBvZiByYW5nZQ0KPiANCj4g
U2VlIGFsc28gY29tbWl0IGVmNDRjNTA4MzdhYiAoImxvb3A6IGFsbG93IHVzZXIgdG8gc2V0IHRo
ZSBxdWV1ZQ0KPiBkZXB0aCIpLg0KPiANCj4gQ2M6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQo+IENjOiBIaW1hbnNodSBNYWRoYW5pIDxoaW1hbnNodS5tYWRoYW5pQG9yYWNs
ZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20u
b3JnPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
