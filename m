Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D5C43334
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 01:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiFGBrj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jun 2022 21:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiFGBri (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2022 21:47:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3141FCEC
        for <linux-block@vger.kernel.org>; Mon,  6 Jun 2022 18:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYXplWcagRx83qkBKLk7FjlSGtS9df7clRDNOiwcUF6BXjYnT2fY0hGp9ubd+6YvEimfRAVhmzja3PaeKKWcj9LOmRASwQl/Lay6luSdznQ9iSBgbIYinp9ePEK6G6SPNZVU+WJ+Y1OkECcZpjrw1m23ANpr/kO9cxgTuh/riDCDPCvnufa8RDAeLmEeLILJHZlS5xOYu9bHsrhifvnX+hqwPyzwPFAkJ6kbQEWEtGjJv2GLIO4f/8jkYYD/DgiXQ/fCFpS6+AQh39+rYjuO2bwVoFgM9+YPeytott62/4G7lgaqoklTOyJzuM4EeYdPtguPvWA2UQjsxZLCNHmZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbS5xu6acJxRf1tT61NMShIxyG3I3DkwuA9KQlyi+/Q=;
 b=gAyKOgzyU+mZSJvRIZ5VYE8mdAWVwypXhTuaXk/M12umXantqj/EHc28TrbyLZHzjS0WKQo+ro8KYbZ6KmJ/VED3miJiNkHNQRnqfuCh6soxX6zWqZ/Vh5drTg6J2lk5bisb15yV0yjANopa8K5deCoLLvJ3dl1Lrzr2S3Xxf+9FncdORcT3QSdmW4hN1utUY9yxLncdCDOVhpOfswIbIcvrYBe+DC/P04+chcSZQtx2uMUetyrpBqKOG2s5yiLF6QNc6Q/maVoABIzgkVktBFeZRrS2HzGa7Ntbf1FE0duFxq5vPw9p3xRpf8cbOZpgqxtq0Bn47LoF1iBAW2KuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbS5xu6acJxRf1tT61NMShIxyG3I3DkwuA9KQlyi+/Q=;
 b=tUuQpgQFehqo8Y9jjmFd/TrJNg2rXt123hlceqohpVKScqQ1nMa01y5EzLdM4rRhiWfh9NI9mP4fc90rx4lzGPOrCKXeY+7yIeju9nIwBgP3wzMRea0/pgvaXcxbuTjqWBeCqb/mshRKHiGUnxhXagBjDgh7wJX0+fVjFTi1jnmHT9l0Ufya62FT2mPaDoPprmDeEjl7MUDNE7eKrvSO/2losNGcAwOSwTvSMG03hPMnz8n3BTu9DQZmcGuW371BqGJ5/Y1OiZXvGPPhyogOaHQUDm5bqVa2CrsbyBhkqFJP73uxqeJrgzX6/mxCjMzjNeY8NQi6VG1KlG+LqX2hQw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1273.namprd12.prod.outlook.com (2603:10b6:3:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 01:47:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 01:47:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests 01/13] common/null_blk: remove explicit
 queue_mode=2 parameters
Thread-Topic: [PATCH blktests 01/13] common/null_blk: remove explicit
 queue_mode=2 parameters
Thread-Index: AQHYdwmJTcLLiGEB5kCDrQsV4oCwLa1DMwoA
Date:   Tue, 7 Jun 2022 01:47:34 +0000
Message-ID: <10872495-a171-da84-2d7d-37d256f08d40@nvidia.com>
References: <20220603045558.466760-1-hch@lst.de>
 <20220603045558.466760-2-hch@lst.de>
In-Reply-To: <20220603045558.466760-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e34c114-3bc0-4009-9d93-08da4827b1c2
x-ms-traffictypediagnostic: DM5PR12MB1273:EE_
x-microsoft-antispam-prvs: <DM5PR12MB127347D7B02611A1661CCDABA3A59@DM5PR12MB1273.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lESx2GML/rdPyDLFCBhT2Ps/9+kgjGuEo4HCbcB4n1hDKGQnzzv7beoCSKeAUzQVcHW+0TVG1t4scXY/MnMYKztCnkmUoSkNmDhFTtWQDjgJT8nyespe5JULgPyMzJ3kHEwipt+g2523YJbtyBSHDioNSH+phxUkde8AdfayzAE7FIVYfaLzSfqZ76c3eXx0kZvUHkaQh6F9B3ZVjj0f962cKArJhI5s9s5MfWcXDNzVegn0EtvKkUQ+OOETLel+tntpJfxQprDswyjcsgigBeQ79UR8IySKsYUf8geDDMigwncws5hV9L3vg0V+8HoGgkxp/CqGxsGCxfUj/zbJfoMCjaMG+3n7OUA31Wt/e3Rc9340/D+hFSY609aVgLUcB0yr6syS4tBPoE0UCPBI4PVeaVhncH2Dt/w+WtX+jAARd+nz1bUvOCE6iXlXI0vah7ltgcosA17dvp0vfdn3+yt4BSLodWkGnozCoBbRt83Aqinxbd54lB/siX/tVYeXZFv1utf4Ox4eoBlPzQoSRxhq42TFdZsoNCJ7VC9S0DJuKJakHfiaj3dFvOSiiF7d5ZhhK06V09Par/ZrPp5wMTPkTB+UmN8Pop0ynHnlDGXaBQyYRI72cXWO9iSG+1vizbhbAd7vAQvn9q4zolz6ZLQEJ7BFuNMgKzJQ9RFSjzG9aOw245yi+y0TpDTDvNH9HLDSX0adyxf7moulwYnQ27nWvs5JANbqxzxn+jqjQ6luED2jr96PjTzKY1F1EyPqT8uajKY0B4MrnPZ7oUgjrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(6486002)(508600001)(316002)(31696002)(558084003)(2616005)(2906002)(186003)(53546011)(6916009)(54906003)(6512007)(6506007)(71200400001)(122000001)(5660300002)(36756003)(4326008)(8936002)(8676002)(91956017)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(31686004)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0NEamRGRDcwcVFWOG9SOEppMUhVMVQwVURDNnYvQzRTVnhBMWNzWGdDa1hM?=
 =?utf-8?B?OU9yWm44NkNzWmtUZFhMWHJUYnh4OFgxR0g2dlA4N2VCd3BWOG8wcU1BNnQx?=
 =?utf-8?B?dUFTWmdoUFJLU0dldmJ0ZUtmM0IzNUU4TjFnT1BEUVAweC9JMFBIKzU3Wjcx?=
 =?utf-8?B?cXZKWlB2OFZXOWZZTysrQXpzbDlMWEt3cnpzcE1jU2piazRHQ1JqMUcrS2dS?=
 =?utf-8?B?TFIxTEdidGFrMzVzYnNxa1ZOS1A1cHV2QzJhU2VveUxKZWQzM2QrNHg4NXBp?=
 =?utf-8?B?TklTbUFvSit1NG5xcFk5SmMrZW5TdFlTVWF3bGFwVmkxUkJaeDRla01SbGdL?=
 =?utf-8?B?TDRMS3JndklrYytuTU1tbitFRmdaZ09rU1BneTNVRk4vdzhncmFSUDRqanlJ?=
 =?utf-8?B?OWFVNnNUTVBVTVZIWHdocWN4eHhqbHJWNGtzcjJRakJmZnhZcktiZEFOeit3?=
 =?utf-8?B?VEdFWjh3SzJjcWM2SUlvYXJVQ0hZNGFhNXM2QlNrMXpJejZJbyt6NDdqOW5w?=
 =?utf-8?B?T1lBN3NoLzVqcXVPZnM0Y2U0eUl3MmpCRUNGYkZXUzhKYWtNQjcwY3l0aG1n?=
 =?utf-8?B?SDlLWXRxSWpYRVhvdSs0UVdYNCtSYTZ4UnlXeEpxaVZkcFdmREpwQnI1akd5?=
 =?utf-8?B?MkRYRWdVbHB6aUxBa1NsdVEwaEwybEpwbjU5TXU3bnJGeFhQbnAzc2p5NDlS?=
 =?utf-8?B?L2xqL1pWeDNCV0laREp6c052UHErZVpRKzZZbnpicjVVNThOTnJOcjJ4akd3?=
 =?utf-8?B?ajQ4Ylo1R1JKbWJrQlJicjNQcXZmK0ZSbUtaNmViRVloVmU3ZXNiNk9kTzV6?=
 =?utf-8?B?akJLTjF1K0JjR2p2VWNoQlhiZDRwSlhnOWxWakRmejRkZFdkTUhwZE80NFBU?=
 =?utf-8?B?NmVITVdjVUtpWFdZQ3lWd0pJOCtBRW9ZSVRRTHlRMWVXTzg0NjA2UHh1cnBY?=
 =?utf-8?B?Q3dnNi9tbm1sSk1saFRNdlNoV0h0bWJBVzB6d3dISFJ3VGVNOUJJNGVPQTFY?=
 =?utf-8?B?TUNWVGlSTnBlUEZoRTlCL0VMTDZMWHcvOUJmWXBKS21MWXIvdWE1SEpyd2pv?=
 =?utf-8?B?VXdOYno3cDFzQWo1MGpYY29ITFFUMVRUM2F6RHVIK0JYQXVsbSt1Y0d4SVRz?=
 =?utf-8?B?cjJROUY2dFN1YmhlcnRmK3hXakJIWlNzT2E3R1U5MW5yTzdkWUFER1JiNXhm?=
 =?utf-8?B?VzlGK2lIWXNOV0pCZ3BINTl3dXBiYkV5T2NsNXNoazRCdUE5U2YzQ1lCSHQv?=
 =?utf-8?B?aEYrK0hZM3dWZjJrQ1dsVm5jT05PdEVrdGFGTzBFYjNJaVpvVDNneDBoMnI0?=
 =?utf-8?B?WUxvUU94ajNZQVdaV3ZFc3Erdno0Q25HL2lrVm5RTkJKNGl0NGdPeUFNYmJj?=
 =?utf-8?B?UWczMTY0dXJyTnlER2xIcUJHMVVXQlFPMVhuSU9JYnJkT3dGUjFpUkV1dWhJ?=
 =?utf-8?B?VjRuSkhNWHlIcnhCaC9QRFZMSEhVc2srQ3B6VzdMYUlKRFBYeXFYcnR6d0d2?=
 =?utf-8?B?RkpHRkMxek5wZm14OCt4TUhpOTlLYUhLS00zNVg0M3JBQTRJSHgwOWJtMmRN?=
 =?utf-8?B?SWF3eXFTT3cvRWsxYmc0c1VONGFySEQ0dzhvc0QvaEVEd2FraisreW1idnFB?=
 =?utf-8?B?cW1IWFFTZXU5U2N2cjRRaUpEeGpGbFdBSi9rZjYwUWF4a25kOTRXeFFOdCt6?=
 =?utf-8?B?V21wOHh5eUEwcXhSVmFBRUJNWTJlcVdtM2NBbS82UUdpZWRCWDl1eDhuT3py?=
 =?utf-8?B?cTZvNDloMTVta25FY2l4cHVYMm9Ta2RYZzhVUm9CdmlTM2FZZkJwN1NJT3cx?=
 =?utf-8?B?b0xHTlU4VlY2QlRlcjcreGQweVNRRmdiMGNVb2w1STBZUmtFcHVIM041R3g0?=
 =?utf-8?B?WGVQZmtSKzhCSCtTZ2F1SnJaNGhjREI0LzErQTArRXJHNTREblp6ckpjS2pY?=
 =?utf-8?B?K2VxZlVobnYrck1kV09OQUNNSG5obkpFSHZJVXRWRG85a3VaalNHTGlZckNk?=
 =?utf-8?B?eUxLNmlDN3JMR3RPZERLdWpYS2NLS0IraUtITmo1VEhuZVF5V3drWkxybktP?=
 =?utf-8?B?YjM5bGk5Si9ocnc3OXRkN3ovaFFIRTRjOTVGTEo0dXhqQzhYOU9oOGJLWEdG?=
 =?utf-8?B?YVhNdzVSMGMwcnBoU0hUOXI3RmMrV0tKbEVRNWpKTGNYV1BHdWdzWGk2UXdk?=
 =?utf-8?B?OG5yOStOcHNGNW1IVW0zUi8zUll1UDBLRFY4eHJhdnNLUjd0WDVoNWoxT1pP?=
 =?utf-8?B?eEhnWjk2L1cwQ1MrME93SHBON0xlT3hEMy9xcDRWZmJYK1ozV3g2Y05sRnpk?=
 =?utf-8?B?ZS9aNVY0U1RhTEdwd3daemxsUjdMaFJxbmkzeWMrOFkwYWJFNDU1RGlmRlJ0?=
 =?utf-8?Q?Z6iYa8Jh4NihFHY/FCGecSxo2WbIREQAjOqs1MqwKB5/M?=
x-ms-exchange-antispam-messagedata-1: mBoiVYfSddkbeg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4491ED7D91B61A44A6FC2EB10AA307D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e34c114-3bc0-4009-9d93-08da4827b1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 01:47:34.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLN8lHRTRReB+2LiZ/feYtu4x37pCguzJqCLItDffZ/AJMPu6+zGudRFR9dPUEWP6fM6BVwTwtcnWJ91A6PLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yLzIyIDIxOjU1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gcXVldWVfbW9kZSAy
IChha2EgYmxrLW1xKSBpcyB0aGUgZGVmYXVsdCBpbiBudWxsX2Jsaywgc28gcmVtb3ZlIHRoZQ0K
PiBleHRyYSBleHBsaWNpdGx5IHBhcmFtZXRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
