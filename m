Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD1FC6FD18
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 04:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCaE5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 00:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCaE5f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 00:57:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D08A1985
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 21:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neUnZGMuh0OWUWWJvYQcNuEkY3YPpl3U52lY4XdDS/RNezuTVIuVkndRcGbdUd63zUqx5G21fAOQ38qWXSWNHsXctg0tbYdAVORc33kiPI+Pz3uRJZNmrePaTVzqLBzlIDckOJppih9DoFRSyof6sgT5CVuRJrGBHXs/Qrvp5MwlcvqBPw1QG1UUtiWI4Qo2hi+vqtwNyaoUDzIAFxwUwTKptMCq81bhCZhoHTGyc519FAd94ExyNJNGB1Y1faWTQXBsU9rN9a17jufXtdzExSPQqB8Vywv7N2n3YDj6lB0Ht8z3BopOlIlFACmlN4Vi73yYjAPIblmLXAkyQU4sSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha4HwaD47DveWhdOB93g05uzgPMf1iEZvOLt0Rid3WY=;
 b=bqEe9ZL4O+DX8J5ZhM2tszzxTnsk1DDJorcRe5FAVZoqjiMGuD+zBjJi/Ai0ZWRb6iojFPr2wTK1o6Ex6ghl0SQ0zk8oIDC87UnGLpOY/j3Ha2b+Kg5iH5JkcIfLbolnpvT7TamlR/XPn4Ed2rUMDdeP52AyATPPPeAnoz8U1j+g9xKwnLU4A2LQB45vVH/t2fUutTTACH3oUOzx3usgIZHQLGWah55klZ2pEZUOuI8ldy1ICx7pbLfg6DNcph1+yOtGvPED20hb4Ptq1vBdTCvzYVf7VMnNrS86twGeIRfPweM24o5ooep45GpGeCRqVv8JvCAinefNvdql+BXDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha4HwaD47DveWhdOB93g05uzgPMf1iEZvOLt0Rid3WY=;
 b=CM1WBJWDQfpy8yjDNJe7wTDXZNzc7ygUkwvXBchTXMIg4GhZ9O9fA6lHdJjUaCi5/Ih0e/lLNgp1G72SOaiE3VafWyT9pHBgKOTMpPCxqHwD/RPqcURG15ViYmyl+VxLNRG5yJiPfTfY5bNsL7vbD/uj8gepqxKjog/fp+r2LV1Fy3NEVLPpgSi96WlzU7t7t071ACi8uOq+33i/N/28+ODLh4MajltSGzIzShVC0AoKarY5dK351n35TNu/+6wyk3DzEth3Vh2Fvt5Zr9NRsfkQ/+fYUjL2qw0S0K1GD3FYKOGcIOU5aNwGj92yWoH34Ne5qHibZzKm/M7yS0PDjQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 04:57:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 04:57:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v3 3/4] nvme/rc: Add parametric transport
 required check
Thread-Topic: [PATCH blktests v3 3/4] nvme/rc: Add parametric transport
 required check
Thread-Index: AQHZYh0kso3g9sRV0UuV3tQjmIUdva8UVmIA
Date:   Fri, 31 Mar 2023 04:57:32 +0000
Message-ID: <07ac9b86-9bad-ecb5-8d5d-4cd34d7c6b6c@nvidia.com>
References: <20230329090202.8351-1-dwagner@suse.de>
 <20230329090202.8351-4-dwagner@suse.de>
In-Reply-To: <20230329090202.8351-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6762:EE_
x-ms-office365-filtering-correlation-id: 32cd0d74-873d-4466-3b64-08db31a46fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3V+yyzwFjDcM/W4+PwRlJ3en2OebaQD2+XUlGKj/eftfkpW5utTWxV/0accxuvXSs+6vtIXVgGR1Wj/IvMcaw/DPUpPT+bGN4j4v+HTZnG6kDdyKT98cARFmA7hTNBjhvf1BMydyf8bd2c0jqzfeMngTHjJTyg0JfZXsgJPmiVl1Vkrl5R8mLbg3eaN1TwiIWd2xHiUeGtF8wVL+uI5iwUHEMTzTUwU40J0+kppyTVG/TojaUsZX6TNzQxYv0D7hEgfOpipGl18lfFcyBY2AXOwA+0AJcgx+QPUQp1Mkd1QxRaeQUIHretu/FB+Sdzm4ly+k3nHHcgZjllVEn7e1jcny014rBqQtUhH/e3pd5RKQZLJrMSmHCT/14A7Nj1+1NWp8YWo7Z5dstXDAr2Ln4YT1WcXIuvNShom/+22V7VJT7HCNoM1FIBhOGPgJE9b5dTLF1aWtLdRNTuvndhyn3O9amYu0BS5YX8JWl1pVUnp7aCV9f+xZVJ1MLUUWKLxjoC2c8ekUGgu0NOaIXY6Mp6q8IRrHkyNkrLycRxBieMVAtkwsDwqECKX0zCwrG9CE2sYzZyeWukyWesbNISYVPk2qyBlfJ9+pWFScgm6EfJ62o9lY+mMUSeTK1TacuREft+8MLqMECAzrnjZZvm2tGVHp7gYWTZudAxnkh6zSkOdIaB+scVyRa9t94r6PGzQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(53546011)(186003)(6512007)(6506007)(83380400001)(41300700001)(2616005)(110136005)(54906003)(91956017)(66476007)(66556008)(478600001)(76116006)(316002)(66946007)(6486002)(66446008)(71200400001)(8676002)(64756008)(38100700002)(4326008)(2906002)(122000001)(36756003)(38070700005)(86362001)(31696002)(5660300002)(4744005)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU9NNmpiWXJjS3lmWmxvWWVoKy9kdkhWLzgzTkxOTGNMS0NHRWErOGUrTis4?=
 =?utf-8?B?NFlFc2dUV1Vxd003cTJqUEVhbjQ4NnFXeUhINjF4VGs1SW1YQ0VhQk5ycU5E?=
 =?utf-8?B?d2NQSHVnd3VvZWhzYWwxWnUydlErZEtVeGpHRTRqd0pOZEpwak0zSG9QMVBY?=
 =?utf-8?B?K0NDR2JINit5S05CQTFuRmxSZUg0V3h4Rlp3UXp5VkNNY3dHeWE4eTBFUUpE?=
 =?utf-8?B?ZXlvT3hkN1N2anRNWnFsU2VhS1B0dlNwMkg3eFVKQzJtUnk2QXh5eGQrVWdh?=
 =?utf-8?B?YlNibmVaclFCQmRGOGVKR3h0Nk9GaHZyMmN1aFVHRXdnWG9Xdk0zaUh5ZVRE?=
 =?utf-8?B?clJRdEQrcnI0dzNsWXZjYkxjREJYaE5Vd1lTa1ZkdkJWU2cvSThrd3N6Z3No?=
 =?utf-8?B?U2IvNFJUa1ByNUlJaGdCZzlsS2pCN1M1VTdVN2xCdTRIOTFRRW9RRGM0MGtk?=
 =?utf-8?B?VzRtUnhrN0IvY0hOcXpKMm9vMU1PYkp5azZHbTlNdDNBOGZwWnk4OGU3eTRL?=
 =?utf-8?B?U0pSeFZ1Y3JCTlRCMmhqYWFubjNSQ0kxejdFaDljTGlZTnBiWGZ4a0tqS3dP?=
 =?utf-8?B?RENtc0NROUJ2Rkx6N3ZxM2UxbE9NYzAzYlNIZC95Z2h3bXg0OXJKcU9iaGIw?=
 =?utf-8?B?L0dnYmlubk5NVVNob1piZFdJYy9EbFFtWFgrejloVVNPUndWR3oxZWFQUytY?=
 =?utf-8?B?TzZ0TEY3NkVrMm9BcXM3WDRjR2dRdzNhNjZQeElJd2NVYUk0ZlRhRjV2ck1T?=
 =?utf-8?B?blB3Q05pUEdxNWRJcjdoM2tqTmJnWXZDQlh2c3VZTzRGNFNuUkEyMVlhVTlC?=
 =?utf-8?B?RnBpMEUrY29tR0ZjYVdZcVZIRWxOWExDSnZzOUJkMXF5MThFN3BuQU9HaENV?=
 =?utf-8?B?SEFqeURveFhQWlVRd1I1cWtDam5uM2IwdEU0b1M1Zk50OGV5MmtjN2xFbjA0?=
 =?utf-8?B?bXkxc25XMGU5MUZkVlI3ejBocHpHcFJMcGZ0QnVYKzNHeDlSeVRUcGl1UG4y?=
 =?utf-8?B?UTR5N2g2S2UzaGtlbWJMT2NtOExOSUFHZzZlcEFqVHk2Z2F6TW5ucnc4U3I0?=
 =?utf-8?B?VnJGWnF5QkVXeGx5TUFwM3RXMFZnS25JYmM0K2FVVzlkNDVGTWpCQmFmMzA4?=
 =?utf-8?B?RENjbEY2bm9kcmVqeTdsVllEUWhLQWhpeHlmQW53YlRWdFFSVjl0RHdFcTZ2?=
 =?utf-8?B?dDNsTk5NaTg3ZGE3R1pDR2hNS0ZlNVZMVkJqQWRrOElzT1NSUGZnb1BSTXFr?=
 =?utf-8?B?RmltdEswYTNIeHg5UXNDYm1GWmNOWUhvaDZ0Y01xWnh3aEg4bEZSV0RYT3Y2?=
 =?utf-8?B?cXE5Q0tpMU00TXVwTThrSXJ6Y05jbDF2VHJtcjlzNEhHTjExdWQ4dmRjajdl?=
 =?utf-8?B?c0ZBVzhjL0QrU1JMK3Q0bVV2dGVRQmtEaXc0eC9uc21nOU5MRlFGdE1jckE0?=
 =?utf-8?B?YlVBcTRpd2xQRTQ3RDV0clNTajBvQVc0YlQ4NUpSOUF1TiswRlkzK1ZNNVFF?=
 =?utf-8?B?c0NmeHRlOVVGZ3FqYzVKM3ZycTZJYVZTZ1FXMVB2TnRGMGdMcFJ6ZWEzbGVx?=
 =?utf-8?B?enlCWU9JcEVBRkhiY2ZMZGVXc2ZlMmRLWEdaT1JjMW4zVHF6SWhvdURUT2wr?=
 =?utf-8?B?T0RZWGhTSGJYOCsxODlQWjZwS2dTOXpjMVdkZ0NkelRmVmh6blB0T0lCS2Vl?=
 =?utf-8?B?TzYrS2tXY25adWJCdytJd2I5Zzh6REZzVDJGTjdKZFFqU3FNbmFPNHUyRGxk?=
 =?utf-8?B?dUhBSDZ0NWdPOURlK21EN2M2QkYyemNRSjNzYzYrcEFDMURZcXlOcUo3WS9l?=
 =?utf-8?B?TWVib0dVS203RmY2N2huRzE1ZCswcmtvZlZsQW1ldVNXbThybEg0T1dxVkcy?=
 =?utf-8?B?YkRLS1VCQ1FmKyt5Um1IaTRTeHZhZ21mZUwvcExlMFcxd3ova29EZmRnTjRE?=
 =?utf-8?B?bGY4QlRnbmYwRXVEM2pRRGtZdWNSVkdDT2VJT0FwakY0Z1lNVVJVT2RGSDdW?=
 =?utf-8?B?VnF3QU9vNTNwbEZiZXZNNTFsQjIwVVpveEZXeGtmNXhwL3g2bi9walo0b2NS?=
 =?utf-8?B?dmdSNDAwQXJnZGZaeFVFTEVuaEtxWGVtN0dSOUZJQ2hkcnpSN1YrWW9XUG5X?=
 =?utf-8?B?THM1SklXaCs5Kzk0L3NSYzExbmpiZUdNQTk1T2tYQ3VsR3pKQkEyTFM4Y0s1?=
 =?utf-8?Q?IFsw/yehJsvX1qzBKGMuKapcOLpoIysy8fL16/uxrBBs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E63F5E05CD0E7459E8922B972D5B406@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cd0d74-873d-4466-3b64-08db31a46fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 04:57:32.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iLDvTridmtuM5yPRp3JLJ9XOhvQ4oCL8NvwsDQylqdb7EqJvXuwvdzN4LRSpWg1VnKZPMjBZ2tPh8WQy67dQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yOS8yMDIzIDI6MDIgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IE5vdCBhbGwgdHJh
bnNwb3J0IHN1cHBvcnQgdGhlIHNhbWUgZmVhdHVyZXMgdGh1cyB3ZSBuZWVkIHRvIGJlIGFibGUg
dG8NCj4gZXhwcmVzcyB0aGlzLiBBZGQgYSB0cmFuc3BvcnQgcmVxdWlyZSBjaGVjayB3aGljaCBj
YW4gYmUgcnVudGltZQ0KPiBwYXJhbWV0ZXJpemVkLg0KPiANCj4gV2hpbGUgYXQgaXQgYWxzbyB1
cGRhdGUgdGhlIGV4aXN0aW5nIGhlbHBlcnMgdG8gdGVzdCBmb3IgdHJ0eXBlIHRvIHdpdGgNCj4g
YW4gZXhwbGljaXQgbGlzdCBvZiB0cmFuc3BvcnQgdHlwZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
