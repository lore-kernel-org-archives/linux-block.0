Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBC4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 23:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiF3X5U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiF3X5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 19:57:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2082.outbound.protection.outlook.com [40.107.114.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5295A2FA
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0lkxr3RWTQASYyQG+dLRPGy/NpC1fmGFfvO/g2BHx7ITNNxPxewmZeYNG7XraO6sfxyo5jfs5oVYEXsT+HlvREWjULCHuY2+C0mIX/mYrOZOPn4rkNxAOIKqDVFEMJBS71aoBMNTN5ZIvU1w5o3+xBRHTfZ8tlNN3MDZs6V+Dt8BVuCz+O4zrnyhyjV3LM/b2dt+l03F0Q6g9A/Ez8gWaClrdgvBqSetZF5OBh+pUqnPI54a2RjLTI5q6UPy9PVqlF5ZSzKSOoHDcKyIqcg0izIDWFJGOx9VuLisVHboQPY8Ufcrk6VGTQ8NLBq0hdfVfsn0/FQMJAFWeTTOipO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IFLvhS18ITVv5CP0mNlMa4UYZyywjt2aMrP740tAwU=;
 b=LhRwqVPV+gMjbBU4ZWzvOVjAMfqhUa1aQcMkwjkBdIv5Or8WKAe3KldOPxP/c1pWfLLq9BpViyUC8pNYTAeSwI9QZIAn+z3UsKUkczIh/t28odGbSQoIAEXgw0bKLCr5odMPflNPuR5SWsa39ysHX8niND60vjEjhD2jhRsSEC2ZSdcoOBf4k7Gsz1iAd7xvJhXYim/aNDVR0uB1J9NcX/II3YzNXDGjE9OBpfyyOrAjTS487rNFD4QZWi8Oqk1N3pAHrsrPpjF8qOyHSR2t0WuAXrdkvEmJTWuqnr8QwHTSaT4VZD/s/pa0R+JWam1Yn+dpV4GofOSAn3U6lHm05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IFLvhS18ITVv5CP0mNlMa4UYZyywjt2aMrP740tAwU=;
 b=RdVW3K57WiACk455ovUROcZ+GshrYa+36yWaa7OkgqTCnph0pH3UlY0ZZx5uCfyTMszVvOwHkMLi+F8Qzy97KCuMdH4BS6LkcGxb3srvzTCrHB7Lo8OvIUINgvUxxG/xHhCh8CzGhA01PkB8u9+a2BhblxVt1bRlvZkYF0LJvvk=
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com (2603:1096:400:bb::13)
 by OS0PR01MB5427.jpnprd01.prod.outlook.com (2603:1096:604:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 23:56:55 +0000
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9]) by TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 23:56:55 +0000
From:   =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?= 
        <junichi.nomura@nec.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
Subject: RE: [PATCH v2 10/63] blktrace: Trace remapped requests correctly
Thread-Topic: [PATCH v2 10/63] blktrace: Trace remapped requests correctly
Thread-Index: AQHYjBB4rE4KR6sGw06HxsG/wmPwWK1nJYnQgAEcZ4CAAF9tgA==
Date:   Thu, 30 Jun 2022 23:56:55 +0000
Message-ID: <TYCPR01MB6948E8B55B5BD058B1B3C3CD83BA9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-11-bvanassche@acm.org>
 <TYCPR01MB6948A4638DBA55684374AFFA83BA9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <12bc3e02-898a-5f29-62b7-334937efd867@acm.org>
In-Reply-To: <12bc3e02-898a-5f29-62b7-334937efd867@acm.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 305a6837-78b3-4a70-979a-08da5af43605
x-ms-traffictypediagnostic: OS0PR01MB5427:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxV03El8El5ytHBj67b9Rec05DpWo/QRyzOzlVVZ/+FrV9X8CCdjRu9i8UtzH9e5E8nOAAzakd8sDlG81TuFBLp9oVgyIuIDImtJkl+5JmKRIKJT896MoIfwNuKcAuGpfczV7xQPmecxS6aTnqI4zC/tzVonFxL/GGnYB4ooYd4xafr6keyj7t7ZDwahK5LhxdWDJg6/qWlDQ4xw8NgrnhMD1HCH7mY0NSLGHxGTVLBM5CEDKSxg7xMMGI4TYavYMnbwLwORiq1BbY4Yl7J5zz5cJKexekznRD6O4EPVYlH5yuUGHHhY4HryvE0ytDhYFm7SFAqFIzqR5I/znK0NdrTSgihYUMr8SedJGEUTIVQRmDCkh4jad76P7uH6y94FSiSXg0VJtdMQT6yQgwjeAcZznBbRgHGH9Qh+FajdkYntGnIEj/jfkSFtwYe+5yvqWZ6Sa4B9OjYzQ4Mez3eB46mfpO3d4WMBgYoxfJhfUSzMgJy9Xezgpn4faxaU7M01n2ycWFkkxnK0cFaoN7iJmdVr+2MQHSLipM8Cj8PPv6jaKPhDKH4PJ1xZ3cQGjVsByMjSIvaBXIQC1svr3ob7RfHbiJQNEW/hMqG7xXfgnJgiD87X/VaqCbcctbmH/UM7dCiUMgJmE9+4mnECQJ1X1wzFE9+lukqlUdi4OgY7169AuRvHqkGRaBT9BB0pGtfCu/t7buWLHlUzlyWAHw26DouRwTOQHE7L2ZtPUYwIRHzBGYwe+MGb4kyyF0v8DC+sgYYaLdXf48LILthfTdH9Grpau0ZOiCfMYij6C41KakSyBH5p+wOlfNHQZdzzWyro
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(66446008)(66476007)(478600001)(4326008)(8936002)(64756008)(38070700005)(66946007)(76116006)(66556008)(8676002)(41300700001)(2906002)(5660300002)(83380400001)(33656002)(4744005)(52536014)(71200400001)(85182001)(54906003)(99936003)(110136005)(6506007)(82960400001)(122000001)(55016003)(7696005)(55236004)(38100700002)(86362001)(186003)(26005)(9686003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU9vaFg0WWJoOVZpdDZIS2VJV1VuYzJyVHVsR2JtcWE2ZVhzYW55NnhYZkRG?=
 =?utf-8?B?ck1lQXhMc3RNVW5wS2FkeUdUQWVYUEpleWl4am56V3BHWXZCN25mcVJzQU9X?=
 =?utf-8?B?YjNUWmNPREtaVzY5cEhja1J0bHJWMGZtakNKK3p3RXFDRFdlNVlWR0I5L0Zh?=
 =?utf-8?B?NFovTWpFMjh5R0U1cFR4clpEN2F3a3Q5U05PMCtYRCs2VjBCQ0ZQc2VDQ0JZ?=
 =?utf-8?B?dU51Z2dpU0pnRThEc014UlhyWGpueUQ2QWpjU2VmbHNUSm1ESlZMVytPLy9K?=
 =?utf-8?B?L2EyMlBiL25mVzgvQlJHemJ0b2pRaHBDUXhIcHNrTjRHeFBWYUE1QStnRWo5?=
 =?utf-8?B?WGNKVHFlaTRBZU1qa3B4OHpOS1Y0bjhwMkdGSHNDQm9HSDFvdFhKUXZnWXFV?=
 =?utf-8?B?ejJwaWRkTlpsZ3hnUjN3d3pacGtiYXVZeTNFZ0t3ZEhhYjRBNXRLQnMwYkxY?=
 =?utf-8?B?ajZSbHhyanNVeDlZNnZHajZRS0txS3Q2NWpZZVhMOWx6U0NkS2hmcnQyWXRT?=
 =?utf-8?B?aDA0RHE0djVMWDFiSzQ0OE1ueHFsS2ZRR2dlRXBtdEg2TkFVQUdtZ0lPblJQ?=
 =?utf-8?B?dCt2Rk40RFlOMkFPQTdHZWlYNElseDBQd3pEN3pTMithamJGTEdCZHBsTlRz?=
 =?utf-8?B?d0REUy9pTVp0WW9zbmFpMUxuUVZ6R29na0d2UlB1OWtSZFo0SVQ3R1NBc0Jl?=
 =?utf-8?B?L1k0RFpzcWF1K281UWh6UUU3c1A5b0JickllL0YzSHluVmVQd3BkeVRsWHZZ?=
 =?utf-8?B?YlRSVXpXb21sa1BhMUVXckw2WU13elNhNkcwaGw0bWtFZnU1cStJTThpOExO?=
 =?utf-8?B?OGVDbHoyUHBKbjhKOHlCSW5lNXBsMEpOdnhyU1V5VUQ3L0d3UnAvaWtBWjFF?=
 =?utf-8?B?cWI1V3kvMTIxeFZ0U0R5ZG0wY2c0Y3kwSkFzU3hHY0N0dENRM2NmUi80TEpy?=
 =?utf-8?B?RzJqRjdaMVlCZm85Q0srWUEvNnJTODIvbDlPWGF2d0lOSUsrOXMrRmVlRDl0?=
 =?utf-8?B?b1c0VWJ6R1B6SU5TNmpKR01vQzNzL3g2OXg0dnFUOThNdEFYRDhmZFBuK3or?=
 =?utf-8?B?T3dGd2p3bWNYWVVMRkxJUC9qZFBLOEdDMVhPVDFQUU9NWUtHclUxZnZHUnNT?=
 =?utf-8?B?cTdOTUMzbXZEUjhnQWxYYUlnaXZQSGo5VVFNK2VKTk9pSG1yRWZ4V0dMVzVi?=
 =?utf-8?B?dWdxc1RLaDhwL0ZKcWtZWnF3YVMyWnRtUTRhYSt0Q2JOcU5ZZ1hQWWZzWFVs?=
 =?utf-8?B?VEpHQTd2My9wakdxWHlaSUtqT0xSQ080RUhoa01uMkJUdnp6c2JZbnlNUjho?=
 =?utf-8?B?dENQV1pvSHlRSlY3dklXSm9mVUY5ekZyME1xV2dSczhudURJcjZiSFV4M1hq?=
 =?utf-8?B?cFNBWEhyUzFVOU55WVJKb2RSVEdPZWkwekt5cEJ4d1RPeTNIcWovUDRETnRo?=
 =?utf-8?B?S1RyTmZVa3N0MjFKOUs0dEthL044akFVWlArZ3Y4SzJaNEgwSVBTdVA5Y1hN?=
 =?utf-8?B?WjVISE4xb2RVWTl5cExlQURPQy9Jb09RbWdGTlFuSE1Ha1dwUTNsc2g2V05D?=
 =?utf-8?B?MmVHc2V2SGxFMjlUY1dHY3ZxbDg3ZlF1QTQyc0hPYXRuangwVEdWQ05lcGV5?=
 =?utf-8?B?Y2prUDUzTzE4bi8xa0pzem1mcDdlQTl5Rm1pdGdkb3RoZ1YxbG1FWHp0SHds?=
 =?utf-8?B?R3pDOFpraFJDNytIMFRuNVVxTENFWXN4TkhORTh6aWtnNXN2NS85VnNoSzI3?=
 =?utf-8?B?VjdRaE9SMEZpWWVpOVd0SVp3TUM1K1l5Q1ZJbzhWMkJxVlJleXBzYU1lNkR5?=
 =?utf-8?B?Z0lNTEh5Y3BHTUZRYmlIeEhQTktER1BQb1pVUFppelJKRDhyZFNtOXRiSGdq?=
 =?utf-8?B?ZDZmby85SzRJUVd4ZkU3RWcvMlRQRS9FTmd0b2xiQWRGVVdjVFF5SjNuS3pw?=
 =?utf-8?B?RkN6S0QyNWlCMDJNc1VMWUZYcFR4RU9SQ3I3SHVDU1liSkNJZG5IdzFoL3Rv?=
 =?utf-8?B?emk4K1V6UTR6QkRJQVVJWTk5TDV2TU52MFVid0IzdlZPdWJHcDlUWk1XLy9H?=
 =?utf-8?B?K0NHeU9QTkxZSm1nWGJpbXBsM1ZvanJ5aUQzZkdxRERVejRXL3pWeERuK01W?=
 =?utf-8?Q?tD/JkaeDS2Z+ECVFgwRFooxej?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_000B_01D88D28.82426FF0"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305a6837-78b3-4a70-979a-08da5af43605
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 23:56:55.0890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uatdD63xxAThdmNVc44/o2q1QRUnWXaSy9DJyu2NFxBcvSqBo+xP9ded2MXbTzaaGjSyNEalBWZ5PJd4B59/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5427
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------=_NextPart_000_000B_01D88D28.82426FF0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Bart Van Assche <bvanassche@acm.org>
> > Thank you.  I think the change is fine but what it really fixes is
> > 1b9a9ab78b0a ("blktrace: use op accessors"), where arguments of
> > __blk_add_trace() was extended.
> 
> Thanks for the feedback. I will update the "Fixes" tag.
> 
> BTW, does the above reply count as a "Reviewed-by"?

Yes.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

------=_NextPart_000_000B_01D88D28.82426FF0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISxTCCA3Uw
ggJdoAMCAQICCwQAAAAAARVLWsOUMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxT
aWduIFJvb3QgQ0EwHhcNOTgwOTAxMTIwMDAwWhcNMjgwMTI4MTIwMDAwWjBXMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UECxMHUm9vdCBDQTEbMBkGA1UEAxMS
R2xvYmFsU2lnbiBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2g7mmY3O
o+NPin778YuDJWvqSB/xKrC5lREEvfBj0eJnZs8c3c8bSCvujYmOmq8pgGWr6cctEsurHExwB6E9
CjDNFY1P+N3UjFAVHO9Q7sQu9/zpUvKRfeBt1TUwjl5Dc/JB6dVq47KJOlY5OG8GPIhpWypNxadU
uGyJzJv5PMrl/Yn1EjySeJbW3HRuk0Rh0Y3HRrJ1DoboGYrVbWzVeBaVounICjjr8iQTT3NUkxOF
Ohu8HjS1iwWMuXeLsdsfIJGrCVNukM57N3S5cEeRIlFjFnmusa5BJgjIGSvRRqpI1mQq14M0/ywq
wWwZQ0oHhefTfPYhaO/q8lKff5OQzwIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUYHtmGkUNl8qJUC99BM00qP/8/UswDQYJKoZIhvcNAQEFBQADggEB
ANZz53xPdtCNv+y6or40xSgytXz8bJwsK70JnlO/a16qEUi25Qijs8o9YU3TRgmzPsOg42NVG/K6
76054UO5OKPmL4omO++gUFb5xgr9OM3EC3BRlJeYBN/DX5TVFckUQZzEXXVkFQ3/VTDsho//De8s
uWNG9qr837xp/S4SSGSa4JXwpu8pjwGxFbUMHaX+aSxpJHges6cccWLuysiXrBddisL4R4ZuKsRW
MZXQZ4mFK/lspl1GnQyqguSZUd1wt9tWPWHkauFc1vb+Pd5BzAeuY1K/U1P0K+nH/bb3gl+F0kEY
24GzBBzFH6SAbxUgyd4MiAod1mZV4vxIySkmaeAwggROMIIDNqADAgECAg0B7l8Wnf+XNStkZdZq
MA0GCSqGSIb3DQEBCwUAMFcxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxTaWduIFJvb3QgQ0EwHhcNMTgwOTE5
MDAwMDAwWhcNMjgwMTI4MTIwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
MzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRfJMsu
S+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTif
Btc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7
v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8
rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaOCASIw
ggEeMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzA9BggrBgEFBQcBAQQx
MC8wLQYIKwYBBQUHMAGGIWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL3Jvb3RyMTAzBgNVHR8E
LDAqMCigJqAkhiJodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QuY3JsMEcGA1UdIARAMD4w
PAYEVR0gADA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0
b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEAI3Dpz+K+9VmulEJvxEMzqs0/OrlkF/JiBktI8UCIBheh
/qvRXzzGM/Lzjt0fHT7MGmCZggusx/x+mocqpX0PplfurDtqhdbevUBj+K2myIiwEvz2Qd8PCZce
OOpTn74F9D7q059QEna+CYvCC0h9Hi5R9o1T06sfQBuKju19+095VnBfDNOOG7OncA03K5eVq9rg
EmscQM7Fx37twmJY7HftcyLCivWGQ4it6hNu/dj+Qi+5fV6tGO+UkMo9J6smlJl1x8vTe/fKTNOv
USGSW4R9K58VP3TLUeiegw4WbxvnRs4jvfnkoovSOWuqeRyRLOJhJC2OKkhwkMQexejgcDCCBQ0w
ggP1oAMCAQICEHhKqRA/pb++3nUIsTSTHQAwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wHhcNMjAwOTE2MDAwMDAwWhcNMjgwOTE2MDAwMDAwWjBbMQswCQYDVQQGEwJCRTEZMBcG
A1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29u
YWxTaWduIDIgQ0EgMjAyMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2wplwnLG2f
2tH0SEDAcaeICZ58np3hWKRLTcna2WfhnikjHR4g4Fw9VJ0UiLnSqPpqEOmJQjruLa1VjvxIl32J
yu83qKduq8tUaSraIAe/ztdec7pbQM+uMnUGC3vmtXv3M5AC4N7IE3DjnBWU15N/HmqrF7IqaF9b
7Dbq6j7Zwtu01rAO6ZOLil7HBY5HlBPCWbvQQymrMGcoMQTjwUAcKwOfttFsZZOpNXuhCmmjWjWV
Mt9KtwKxH99GQ6V8nwrYl57qY0ivFlNnCuKrBLY9PSUuPpoYtAkwqwp1wM7pt7YHB3B0YNKa3Es8
xFA0FqBccrqsIsIR7t7D0DZhTjMCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQEAwIBhjBgBgNVHSUE
WTBXBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQGCSsGAQQBgjcV
BgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0OBBYEFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i
3Ru8MHoGCCsGAQUFBwEBBG4wbDAtBggrBgEFBQcwAYYhaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vcm9vdHIzMDsGCCsGAQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2Vy
dC9yb290LXIzLmNydDA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L3Jvb3QtcjMuY3JsMFoGA1UdIARTMFEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIBKAowNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDQYJKoZIhvcN
AQELBQADggEBAHQF5P1wpw3gDnfZzRFL1j8W5TkP+aP6ujiHk2L6BL1FItqh1DrW34wRnU6bRbF1
3uEYI1RfW+g7os4GH8vnCC5r4uYX5NyKvDAGbILVvgP6LULCbytsEWrSxOtUW85F/PfzlxGdc0+7
f6tkYias6b1fDQocSI/j+1k7XqT5vQCI9CnrnvoEtqr8wGQGN+GWXkR4AO4OTuEzyf6E3fuK4IlP
vsCw5XGWHf7JRZGk98YOKlg3qRDI0+E9ahTkCC/oo1AK2EuKMKT4PTSEkymtaqiliYxaMprNHdBs
Dp4iCGwb4SNjCewUmPTGLVlU+YyTt7bFR8I+HKfdgkhbhsLpxTMwggXlMIIEzaADAgECAgwO+efB
Kgmslz77fEQwDQYJKoZIhvcNAQELBQAwWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNp
Z24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIw
MjAwHhcNMjExMjA2MDUxNzI2WhcNMjIxMjA3MDUxNzI2WjCB7DELMAkGA1UEBhMCSlAxDTALBgNV
BEETBDExMEExGTAXBgNVBAwTEE5FQyBHcm91cCBNZW1iZXIxDjAMBgNVBAgTBVRva3lvMQ8wDQYD
VQQHEwZNaW5hdG8xGDAWBgNVBAoTD05FQyBDb3Jwb3JhdGlvbjEnMCUGA1UECxMeTkVDIEdyb3Vw
IFN0YW5kYXJkIENlcnRpZmljYXRlMSgwJgYDVQQDEx9DQy0yMTQ5MVAzMjEyMzAsIE5PTVVSQSBK
VU5JQ0hJMSUwIwYJKoZIhvcNAQkBFhZqdW5pY2hpLm5vbXVyYUBuZWMuY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4Xk01AQsJLT0nBNqyIrzkwP2bWrpCq74yoIHLzvyqQrgEU2C
VYazZwQR2dRDP6tLhz83LrgJpIke1INa49/BLUJp9FAfPVTCZb0j4kftbCj5R3O/JHFpDy//9Cx4
9osgejC+Y0HmP5onVmEe4tKxG3hBFoVhLyUU+LhusvQ7SRrjYU4Bj4qjv1rhUZLzAas69+B73ehF
dA0c+fBZ3V+eAWQILmGSkbWc3uXZWK5pR0cB2ZJxC2eLlMCMdWNVyZxbt+aTC2R4Sw0FQ/iuf/4F
Ar8qFoBevR4qmyZq11asIidufyscWOhplGshENi7+rzYTd1HioynChC67q+rL0K86QIDAQABo4IC
FTCCAhEwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIw
MjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVy
c29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8E
QjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwLmNybDBJBgNVHREEQjBAgRZqdW5pY2hpLm5vbXVyYUBuZWMuY29toCYGCisGAQQBgjcU
AgOgGAwWanVuaWNoaS5ub211cmFAbmVjLmNvbTApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUH
AwQGCisGAQQBgjcUAgIwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYE
FLri8sCe/FVMIHLIr512r1mpmJmEMA0GCSqGSIb3DQEBCwUAA4IBAQCMiqvivcAx1ZHBbcdmA7/z
ZBddJ+hSWAmZE26ZTWksq+WvzX1get6KGMu+6f/KqrBcxCukH+ajNIkaFcJFh0uoJEkbhXzvyqY0
RbFVAF7OF6bC7kySTjLQUB3c1AzfAgl8/JyYf5s2kjNVqP3FqDUkW0zGa5+LOzXhfy9NBLy1ZciL
JAFB1rSkRfRiIBUZaQS0P7qwRSMu/8NckySUoGbE1Yi20dCdKRyUgAoGnhr3mVJ0MNSHwr9FTDPv
eaL3cOR0P6Qr9lE2qmHvfRJQWxW3ufPiaTeC9o0NWDW7tcLDVTrYjavXMMR0yaIr9R7XJka/hMCp
puI9qbISANymP36AMYIDgzCCA38CAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0Eg
MjAyMAIMDvnnwSoJrJc++3xEMAkGBSsOAwIaBQCgggHtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYzMDIzNTY1M1owIwYJKoZIhvcNAQkEMRYEFNRfJC3KIcxZ
LeXHVVFHVe/PzKQEMHoGCSsGAQQBgjcQBDFtMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAy
IENBIDIwMjACDA7558EqCayXPvt8RDB8BgsqhkiG9w0BCRACCzFtoGswWzELMAkGA1UEBhMCQkUx
GTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBl
cnNvbmFsU2lnbiAyIENBIDIwMjACDA7558EqCayXPvt8RDCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAIC
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCCdN+ffoisfy/y98a+h+vPnA2rhsCz+Efg
UGPfGR72VtYq5aYPesipwmQuROXfl6QpWRYmSRDkX2zlHqtYvbWGp62QkS7LcvPRWNG7elwGXTMO
4VcwgdBXwhFUgp5yUctn2PHWlwF7XNpNVliXNsA6BMFhj3SHwnpxjCtsLgVEQIr6dHmJNJCfnmZD
YCiEKhcEzHFTNYal7O8VAw7MTVaqri9FujCNlyfBeUPEKp33giCAF3rJfQMa6YhnMayOcxDoieFn
FfTJhQOwpzrWGKeWPQC7VNFhDls5RQG/aloSrKbvFRR1NKIK+KxTNEjDz8sTPbjLTdREVacTCsro
zE5bAAAAAAAA

------=_NextPart_000_000B_01D88D28.82426FF0--
