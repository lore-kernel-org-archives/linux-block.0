Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B752C001E0
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 11:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjG1LKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjG1LKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 07:10:35 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC03C35
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690542611; x=1722078611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Ygd5E4yRvEDUU0Jspg2cl2ydXwtA1nzdCVs9jxMXGI=;
  b=CbV3rFRWrpJfBpU9QgBuPqF9vOFaQnqG/uxSdswLx5TtQJc9SFdc9r1W
   boDIyyWYHnu5adDK5shqfcYPAwQKe0pxTm/PYhwsXyAOUMh1BQ0Kh6qpU
   oi19KL7v77Xg0jwcJakC4jktvV/8ffgHzMXAa1pD6r9TbgSCoSIL9Jp7z
   SVEmF8E+ROaAMwF75up0s756xn3NODl7HVWk3IbRnNKV1cZ1J8BQAuG1c
   XonAz2eS9fwyoLEEXTlGDujrJJRlJnlwSsgtbOjkVnqJjd+aWJkXaag1Q
   FWX05E5JoShKg6gMjRbm9t6BakQCiTDjPtd7CHHPFxnOknxOPbksPty+G
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684771200"; 
   d="scan'208";a="237709835"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 19:10:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiAVByxktIYLhFB4fMF5EBkn0qMG5Lx+qsT8MrUg4AI2nsNBe8BxEmtq6Wagk3CmGit2ODXbNTU5uCJmjKrwlwyxEqteY9jdplR4rah57ovLnmX7agQj/uqCVDeMUp9UYbFGlyxslDGqnaFEIiEi/V2uvu+x/eEUGU/5vaVrRCLc/3n1sOvv2VUbuy7TKNp1a3zClsV6y7cur3IF52aRkSbJc+2N2jXjOMCFqKmFBcDuB4DtXwKMNNRE2UDjrJCfT9Y4CSh9a9DDsnkAGlaMkh3QZoNJFbL32Op4h9W8cShQeF3fYKU1R2a8GHGtISvZ/uGiKZvnRNJu9D3axb9xcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ygd5E4yRvEDUU0Jspg2cl2ydXwtA1nzdCVs9jxMXGI=;
 b=QDlefqg9vmfy4Ev6cF1qakGp1jF1A9Wksb7iSOwdEuxrnBo0t2bn1YhxiepcK6O1VamFzTf2ynK2ippTWVk01JlUP5qSy6IiSQ4goVRd82rU1cn0vsFO9rFVABd4CEU2m1wOAp49ed7S6aBFDas7g6zo54wmmuHmdy7mw7q7QjzAguh1L4mVVLtFLTCGxnpYSUIj9Ar1eesCLMQ4/64a8BF/5TgRguA6gVYw7sLK3IIJMCZHf0jr4ru14rGwW/yZBGFgnT7SXQzaLZkM4fOVB89hG+dDbMUAJolkcMbvHCyIHnEw4gbXzFgunehTgHrnUPaw8rcQ/F6lJwr1PY7DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ygd5E4yRvEDUU0Jspg2cl2ydXwtA1nzdCVs9jxMXGI=;
 b=xCvtrqUu2iwUU6bnBbJfiOeqX2dXN2yBId3As62JLwUaVT7WqyJwxvJfE0RKgZ+uogVB9+ZwKbd48aj008konKsX+0wEamU5ihWbGOcd9o1uKFX2JJbwrSwnvhcb77I7ajdmxtzrKcCkV+Vrru3A0fIXQk2iW0cKzTUU8KLPzxE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7455.namprd04.prod.outlook.com (2603:10b6:a03:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 11:10:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 11:10:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 2/4] README: describe what './new' script
 documents
Thread-Topic: [PATCH blktests 2/4] README: describe what './new' script
 documents
Thread-Index: AQHZwUO3i7bOxVq6xU+z5Sr6YqqVXK/PBZYA
Date:   Fri, 28 Jul 2023 11:10:04 +0000
Message-ID: <cc12b8ec-9c97-687f-c90d-bfc6dc18dbbf@wdc.com>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
 <20230728110720.1280124-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230728110720.1280124-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7455:EE_
x-ms-office365-filtering-correlation-id: 07af9ee1-7eaf-4bd9-735e-08db8f5b3203
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWLSJJuPB1CnIV9B1hdd1OVjHI6hxQG3ZeFOVhIFTj2zdDK0FHWQsh2/xghH5YHUaHd594wMF8RJTnK2cqZSi7tWTEt/jQnjBLY1yEGDYFcjwU0SX2Mtm7ho30tj59k48b+Q6H2tXbXSewwcdgZgPnmfpFkJNLAJkkJBY/mxuY2dPPvu3QeinxPYORnhgBeE3VIFMQMfKSerslfTIqA+3dTB2qpo4DvnoPmR5HXe9mJXpn20h0yFpbphTajotMf0BFr9D1qjplncMXGX9mcTd3LxHzXIBwWMj2ETspHO08YqGFWBURh6x7pKE5lBGFtagD13GPUFagvh+Ow/2dv8eU73ennZVQXG7E7sl8/qKKeOiN3Z5bkdfrbN8X3Z819yJC4jC2o4UG1xrF1pCE1ubvO1vbCHcMyB1c7jD3V48F1h8HPReZOyo1D11Nimcsn8Df75Awu+DBycJxsYkmohmvU4oUIZetTLuvSfTsMX7P5NaFmPsxtjDG9TgWSLX7syC6v1cSUnRcgTROK278L9Sa7hB1bKImCFoB8xKi0I6IzT4rkILSDjMuMkI4tmKaWupmjHU0SExlu7PChzniQa6n0IZ6aZ4qPX9KWMQCVq/50vGRXWUVyawDXIyb8XT7r+lPNNriFq18nS2XgTnJkVsTIWa1gEPrII3z6w+WH9m6ZHdATJ7dW6LsKROsaXZm3m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(31686004)(6512007)(6486002)(54906003)(110136005)(478600001)(83380400001)(36756003)(31696002)(86362001)(38070700005)(122000001)(66476007)(66446008)(71200400001)(66556008)(186003)(53546011)(6506007)(2616005)(82960400001)(38100700002)(2906002)(4326008)(66946007)(91956017)(316002)(76116006)(8936002)(41300700001)(8676002)(64756008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejMzbTE4SzRMOG84Tng2YUJ2cFZLbEtxbklIdWYwd2VtanY2U1pjazI3Tk9D?=
 =?utf-8?B?dTBiNC93UkdUMWlkbDY1dlIyVlViUndGeHlwcUh5MGVIRUc0K1ZxdjA4blB3?=
 =?utf-8?B?UDB4R1RpUHJsYm9zQXFueUZFaDNRQXE5M2hFaDFFSHJUS3Y4ZEhxVVJqZjZ4?=
 =?utf-8?B?OEdhWjlINllhMVJHa3F6RDdsODdnNXNabEcvK2VPVzBYV0RqaUlGazBzZDVo?=
 =?utf-8?B?cWFIWjJSc1hleUhlVDhxMWdJUkc0dmVlbEJaank0OG1vQ3JMUG1YeUxtRGc5?=
 =?utf-8?B?c3Z4dUtuQ01HTDlHYTFJR1JxaTV4NjlBNVZjRDN4RXFmdzR6dTBOTXdwcnhR?=
 =?utf-8?B?VzJldHhSVjZwZXh2R295SGJOQ1FNM2xKYitHQms3ckw3NXdGRFc0ZTl0MTBy?=
 =?utf-8?B?dGlZQXpVS3lZeWdvVkVvVlJDdlRIdFAvM0R1c0o3ZUFkdXZqR3Jsckp6R3A2?=
 =?utf-8?B?cVJndm8zUW9EaVlVc3VDaHlKZlV6R2Rna3B1S0NHSDIzSnlncStqMkVHN09L?=
 =?utf-8?B?TU5Hdzd1L0o5c24rVm80cUpNYnhRNUx5Zy80aDZSS3BSRE9JR042eCtXR3FX?=
 =?utf-8?B?NmVWcjZNUjlXdHJLdlhDaFFwQnpXdVNPWGpDcVE2U3d0WEVCbDJzZmZ6dS9V?=
 =?utf-8?B?RXQ1aVBGMDhDQmlaZGQwb3ZvMlFEYis0YVRmWEYzN0NVeWJwT0ZQYUJ4cFdP?=
 =?utf-8?B?S3pjMUVWMWFqZkNQTEJ1bGVJSENJblEwUEhlb00zdGROR2FBZUhBQ2IrL1Bv?=
 =?utf-8?B?UmhSa3ZsdDBuZDdOVVhLMitSdmxLWmRpdkpoS090UWYxWDV1dXIzY0lScVZP?=
 =?utf-8?B?bzJuRlR5YklaVkxSSlh6QVExVW14dzdqNUp6TGQvbjhFUHJtNHd5NG81aE00?=
 =?utf-8?B?NEo0RGIvWDBqQ3oxSXMxT3N6WW50R0Rrbm5hMlNIWlZRMzVBR25GeDF2bkc2?=
 =?utf-8?B?UnJ2WmVhMHpRWk1SMU5TVjlDODhvcXV0aTFHZWk3MjdpakNyT2JQZVU3V2Fw?=
 =?utf-8?B?RktIYll6RGZWUXdGNDh1bUpVTmtwRFY0Z1BVUGZ1RXd4UG8wL2hBeDEzN2RX?=
 =?utf-8?B?SlYrYi92OGhnYXpmQ1dDYVczcTV5bG1qa2d3aHRKNEQzd01YMGdENDhjWDYv?=
 =?utf-8?B?MjVxZk83ZVl6OHBvRUY2ak1qblNjdzUwejJhYjlFNy9zSWJ6czltMkhvVXVF?=
 =?utf-8?B?dys4VTdtWHBuOHNBMHdBcVZrelcxQ2QvQjdtVW9WM3dWZEdJVkh1cS8wQmo3?=
 =?utf-8?B?UWpOM3BTenRjQnhpQml1ZUFjdTc2RHVaRklGRXZpSnkwc0RLdHhvclpFS1RD?=
 =?utf-8?B?VlBrRU9SL3pLSmtJek1uNENvamxvQjBDMmNrRWtsTFI1MXpDOGlUdFVmSUla?=
 =?utf-8?B?WTZ2aGpxdkFYT2ZVbXVTU3RJcnRCVHRUM0VhVUZFSDRyb0ZWenE0K3ZVUVlG?=
 =?utf-8?B?YjhZUTVWaXAxTU1DaTBnb0lnbzV3THNpZ2g4d3R4SFIzNUJxVTJNcDgyRVEz?=
 =?utf-8?B?U1ZnSjFlQ2lBRHM2M1o5cjAwcC9yMDA5STVtTm1vVlQrTk5mOGtHY29KS3Rz?=
 =?utf-8?B?QTl2TlBZVXc4MW1sWFFIZTBKUlREKzg4dVZVU3NUWUtLYUh3OHJsRVJ5MkdP?=
 =?utf-8?B?MzlpRy9xOEpXY01jajR4dDVMRTdtV3hnNGhtVmQreENDM1pPRVVqY1dKUWw5?=
 =?utf-8?B?NkhONUs3UUQrOFZNM21DUGRlUzdLSW8ySUorRElWZTJ2ZHJLNXRvN21xK3dD?=
 =?utf-8?B?RUwwQUlaVmpCMjdYZENTSStrM2xIN29qTHJYNDFtdnNsYXVXWk42Q0FyRVpw?=
 =?utf-8?B?MzRxMFlWcWRocGsvNDBVSEtkOVJRaVgxOEJZaFBmTnF6VVBycjcyZkpxSUdy?=
 =?utf-8?B?T1gzK1R6UzFnRXA5Q1JBSjU1WEF4Q1g3LzE3UEdwUjNRZFBMTHR2MjhyaGZk?=
 =?utf-8?B?UnQvUVlZbThrUEN6Mk1kVHlPcnV3UktPbnZBSm5IRytCdjByVFNyOEFCY2FM?=
 =?utf-8?B?aXpCa0JNZUF6dkFwdlJoeE85eEFkMnRZMDlxc2I1NHlDL0xUWnZ6ODQ2SmNW?=
 =?utf-8?B?UlpKN1Rib2p0WDhWbWRmbmFlNjlUd3hZM0lnY25TMUtMOUpKRWJJaUxGRTJM?=
 =?utf-8?B?bmliU1hwY0dBaUE3WWNFanM1alBqdlBWRFp2YnRvTnBqQU9yZjJDengvc0VT?=
 =?utf-8?B?Vm1nUHpkMzBOaXJ3TjZYVkYwN09xejE1YVUwMHRjTktsbFRCcTdvVTh2Wkdm?=
 =?utf-8?B?b09jSzd3ZzVvQ2s4T3lza3dNWEpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7832847EB535084C87783B9F1902C032@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pzFw6kMQy3w5M5xOGdqdkbRzWTngGv/4Ykpvd7BGk6wj57TXGSIdGxQwl1TcMuf5XC+ekBizl1ih19dT/Aqfm0GGzkzgGWcXDyG/u1tfM64A8OEAH4pRrGvaVROUpk5XJ2CxserNxRdEGLSWT2t3ZFqb+iA27EQETUo6MSG+cHsmnMdxvxhFVv27vofIET2wdxC5T1ekVFggcj9vG0V7JSwYfM8iFVC6BHoGkEV2Zs0pYJNM2P4Db0dekLJYIWUwPIhwIJkW0R+s2YZ7iZOJOIPmjopnhGvDqMpC9J0lvhS9Oejkg8dfRmALwlp21N+dz+6l4FmtH6yykSxllqvAbhNCzx+fzjJmeGSQK3rpM+ESVX+YL8w+j6cdG90O3GBF0dj+kagUPZdosLxmx8NRq9/VW8MpH2+5Fg8RYbaRbqZOUFGEPGhALAbd7pekv6xRkwuj90jcb6HbMzZt3Ps20lw6TFk1clDrx42pwIYcyDTBa3a+aV3SmJuLXbAJmlhVaU+jkR4DqRkWlLGCKXl1IN6fulqcFMbV2+wrqdoVBCsYmZLm+fIA/AH+G9EQgVKhJJKs0m8XojS55N6Lz4E1Zo0WYs3Q/+7lXh7WE3hmSWCWT6OyzjX89rI2YMt3nibCFmJNpb6XkeIKFldT9roxSyUb+zGg3/Vie/sHv/iTAhjOvIokTlDn4vxkk+7B331scWCRLjWJKfm65ExGgUFYJBXBzc2gLiDHSIfhZ2A9Tjf4rx9P9m0V7Og+qAqs8bhGTJa/T7NDj3hv6vWLCkmyGZMYfA5nW41xh+VNhurUJQBc11sUVJAZhrKLagHWykW+xWH4+Hb349jpgHW+ObIJT6uzAn1ZwDXMRZyy8huoDdc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07af9ee1-7eaf-4bd9-735e-08db8f5b3203
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 11:10:04.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnUzZJ/tRazftm1Kq0Vl0nJSUWF8fzg3Mh/xlh+d7CGteWY2UiqtsrNxiV0pSAcBWxjfQeZo/+LyzzFEVxoj2xn29yU7TqQXycf6ijLvlL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7455
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjguMDcuMjMgMTM6MDcsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBUaGUga25v
d2xlZGdlIHJlcXVpcmVkIHRvIGltcGxlbWVudCBibGt0ZXN0cyB0ZXN0IGNhc2VzIGFyZSBkb2N1
bWVudGVkDQo+IGluICcuL25ldycgc2NyaXB0IHdoaWNoIGdlbmVyYXRlcyB0ZXN0IGNhc2Ugc2Ny
aXB0IHRlbXBsYXRlLiBUaGlzIGlzDQo+IGhhbmR5IHdoZW4gd2UgaW1wbGVtZW50IG5ldyB0ZXN0
IGNhc2VzLiBIb3dldmVyLCBpdCBpcyBkaWZmaWN1bHQgdG8NCj4gcmVmZXIgdGhlIGRvY3VtZW50
YXRpb24gd2hlbiB3ZSBkbyBub3QgaW1wbGVtZW50IG5ldyB0ZXN0IGNhc2VzLg0KPg0KPiBUbyBo
ZWxwIHRvIHJlZmVyIHRoZSBkb2N1bWVudGF0aW9uLCBhZGQgYSBwb2ludGVyIHRvIGl0IGFuZCBk
ZXNjcmliZQ0KPiB3aGF0IGl0IGRvY3VtZW50cy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2hpbidp
Y2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gLS0tDQo+ICAg
UkVBRE1FLm1kIHwgNSArKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL1JFQURNRS5tZCBiL1JFQURNRS5tZA0K
PiBpbmRleCAxODZmYzNiLi4xMzI0MTU5IDEwMDY0NA0KPiAtLS0gYS9SRUFETUUubWQNCj4gKysr
IGIvUkVBRE1FLm1kDQo+IEBAIC00OSw3ICs0OSwxMCBAQCBjb25maWd1cmF0aW9uIGFuZCBydW5u
aW5nIHRlc3RzLg0KPiAgICMjIEFkZGluZyBUZXN0cw0KPiAgIA0KPiAgIFRoZSBgLi9uZXdgIHNj
cmlwdCBjcmVhdGVzIGEgbmV3IHRlc3QgZnJvbSBhIHRlbXBsYXRlLiBUaGUgZ2VuZXJhdGVkIHRl
bXBsYXRlDQo+IC1jb250YWlucyBtb3JlIGRldGFpbGVkIGRvY3VtZW50YXRpb24uDQo+ICtjb250
YWlucyBtb3JlIGRldGFpbGVkIGRvY3VtZW50YXRpb24uIFtUaGUgLi9uZXcgc2NyaXB0IGl0c2Vs
Zl0obmV3KSBjYW4gYmUNCj4gK3JlZmVycmVkIGFzIGEgZG9jdW1lbnQuIEl0IGRlc2NyaWJlcyB2
YXJpYWJsZXMgYW5kIGZ1bmN0aW9ucyB0aGF0IHRlc3QgY2FzZXMNCg0KcmVmZXJyZWQgdG8gYXMg
YSBkb2N1bWVudC4NCg0K
