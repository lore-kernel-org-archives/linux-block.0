Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3864BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiBPJQR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:16:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiBPJQR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:16:17 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA92AFE99
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:16:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpeqTVd2uQDMs5JFHZC/0TsHfrns9a4EueRKVMv1Mkyz1lpO37T7YNJzadtegyppQ5/C7kKPoTfoRzmd/7GtHHHx5r8HybaFEdUtQHt1oqNn31sVr5TodOQFioM7urcWpcuMrqhqkEqcs8LZtndCbzXfrGtP8Mt2NtltfUa+nFa+xJPfEyvVSt7jO/hBVRQrkQC3Ky6gFgS3rIVOqzZmV4FtkaWge/ue4fCz6wnr3dNU0q3n2ZrXFXrz61nYtgtY4Zhcg61MyGzd9UJh0t1dvpyTPaW/9oWpBzhtjNEr7J0UIzohLy+QpezmfDTaqwbMTIAlleRwuvW6dn2AqRgy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyUMVnbJUE+shQkpv8oYEk0n1XI04MigkXEs4ufL/h0=;
 b=JN+n8hlv7R2Asw6NrYOkTCfbzsDcvT6f4BrxxqVx+DARsnmvRf0mxInQmyyUkVWg3GGuAmXmz0a2axWw8Tv/kM6WEzkMrG6T0gQx/1Rs3JTZgZToc+Sz/YcjBeNvSKYGpFwzsYWvjXhYICGiq0rGxlMywToLXBdO8koZJ9YJoPqhBxLcxmQHVaiVW20a94gIKl1PLvbaCojZSDY4EPIkrDuUvpm0Q6LYlY9cb7RKZqitUj5jFkY1Ccoaw4XNzhPvUAtjzjzuz/0NJpUddR5jU/yybf8sntM5socb5z5ao8EVI4Bmw1JsL3cGJAlfkVIJjTVWA0wcPfAiceCT+qiWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyUMVnbJUE+shQkpv8oYEk0n1XI04MigkXEs4ufL/h0=;
 b=TmdJg2unHg85PCFb3gP217uTjUEGHUdKwEa9pc+Rlk5sQHQ+QWEVIJd0ZbszuWL2o5XOYhqLOUwr7scK0vV6F54gC7ToUzMLut5L02a5x3CI6J31Qr5o2rdXCQz6p5/ZxofyEcJLIcrk0D2VWrj/AWxFVWX2c6fE7amuyqsA4f+sR9oKdLCOial2w6njzT6WGih6sgIooYLwIKhho5HT0eKFeR1vlL0u+3cBP+g2eEtrcRzUFL64KcmLzRpe1+cNf2EJYlTP0Ap4Jm3+NEYrzCHEzYjm9ZTdQnKCcmkc4J1z6kKHgLMQPfMFO6yf0LvedIJjHh3fJ517qWKkcvSb5g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR1201MB0069.namprd12.prod.outlook.com (2603:10b6:910:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:15:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 09:15:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 2/8] block: move blk_crypto_bio_prep() out of blk-mq.c
Thread-Topic: [PATCH V4 2/8] block: move blk_crypto_bio_prep() out of blk-mq.c
Thread-Index: AQHYIvAmeGX0GSNscEODvD19MPuWnayV5bEA
Date:   Wed, 16 Feb 2022 09:15:49 +0000
Message-ID: <c990b091-e1cb-7521-e0d9-7e3e3dd8ad6f@nvidia.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
 <20220216044514.2903784-3-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8424ed92-8218-4cc7-9aa0-08d9f12cec1e
x-ms-traffictypediagnostic: CY4PR1201MB0069:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB00695BDF3E155F7FA662B4F1A3359@CY4PR1201MB0069.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+KeGIcj0+XlXDeQEFKAaFQIirNsO0rv0L8STrEldPFv4pbGHL2gF11NRlNTLEHn7iho2p3asldWCfiuiaTU9PvtMaSV18DQ4lPKauvP9DA3P4naRQT3LRY6VBCzl64kbiHcB0yzRLKf+1VK7vABNdzA4YZla1kCWGRXfa3YJfFr98jwWstfzGmf7u4MIVIH7wqch5OJ0zC8s6wXPlBRld8bzFUd2rFSuZbLdPj7R2e4Nk8k397VUoCN291mBBxie5Q1zsZj5HPpmYu1628km/I3yBMceMTnkLwc4rsEs4KWqZCIYAXlFK1bKMrbMr82WtG0DifFDopuhy0HmtpGC1Jd1RaXy66pHhUSSyjtQsik56yzzBHdZIeqTffoAd8GmYglnwBd2TJVmqOvm9LZplJAs+1mgtnHMaRu0SkYfzUajY3G+TO3pEgotQNqHdXG7YEWGW/PCCSRI8kavXZeUxFNSuZ0N2jKJGdCyyXND6A4CImUddrcg3P7Ob6tKQpf9klvqJRjfqj+p5BwSyG/cmKy+UJc25+3yxGJl+1Dwne9upaC34pfOyJuO78CpF1KkF8SceTBbpNqs3l3Joqk9mjsO5I8ZbnZeG2TcIn5FwJXUlPOesDz54jHCXdtZHa4R1EjBlQ28YTkNmbFiyUaxBmjx8OspaOxjaXY6DQUtRpKqBnJXHBM5AvAgn/nrhe9pYfipevKDj5YgvoSiGpLqmEG2YxQtRugLzhpbDYZBEcP26+e6koPO7YFKNOVGwuhB3Zww+3mI7xNdBxwXzra7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(36756003)(71200400001)(38100700002)(54906003)(2906002)(6916009)(83380400001)(38070700005)(316002)(6512007)(6506007)(186003)(6486002)(8936002)(53546011)(76116006)(91956017)(5660300002)(66556008)(2616005)(66946007)(66476007)(4744005)(66446008)(8676002)(86362001)(64756008)(4326008)(508600001)(122000001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEV6T0g2aFBMcDk0RGdaN3BLSnpGZEFmMHYxUkZqdXRvZFFFbkYxUmVaVmRl?=
 =?utf-8?B?NzExWUFadWt1R2lOZEk5T3Yxb0lVYW5TMm5XZkJoeEd4dW5KVjB4L0NKbnVL?=
 =?utf-8?B?OEJVZ1JQSzc4NFhBRlRiNmdRZEtyVk04cmdJSGJTT0RCRGdLUHpmUkJwek9J?=
 =?utf-8?B?dFNvcUorYy9GZGtVSDZqYnRVSG92c1JiU1FuSDJpRDFWRm5keHN4amRuMCtr?=
 =?utf-8?B?V1ArcVh1OVl2SExGeUd6TXdoMWlLZkVUQUlzWVdaNVB3OGNxdVZHR0FGOXpZ?=
 =?utf-8?B?NERrcHl4QWRVejI3MjkzcUd3S1Q4OEV4NFZxUTZaY3dCV0l3TVREbXBaNldj?=
 =?utf-8?B?OUlzV20zVWRCRkd0K3FIQm9GK0FyT2JBbncrU2tyWUJYeldhR0F5aDJuai91?=
 =?utf-8?B?Z2I1S2J0bVBPc0lDdGJTWkNDRitWeVdmL3pGWUJOaW1PUkV1MkhlOEtxcmt1?=
 =?utf-8?B?ZGQyZVNMM254OU1ZNXpTU1NVL2tOQXZoUDB1WHhrdjRjZXhyUERxSlBXZDk0?=
 =?utf-8?B?OTVzOTNyU2M5N2JjUjhTZ3gyVjIyd1BoWmEyY3BDdlJhRDFvWWhKQ1JMVmp3?=
 =?utf-8?B?dkF4R20vZzVNdWl2SGtla0tvREJuYmlXTTFUa1BVaUVsVTc1N0IwSUZGejRk?=
 =?utf-8?B?cG96eXV5VS9TQmNpUjAwUWwyVytLZWdWNmNHVlRiL3gvcFZWNHZzdnZibm91?=
 =?utf-8?B?SzNNREg4eHFvWFBzanRMS0JtWW0wZ1RzOGJybUJEZWxQK3c3VjJ5RGd1VWJH?=
 =?utf-8?B?RTZBWldNcnpyMkNFUllhOGp3a3plZ0E0WjFraTFFNkJlVzgrSkFPSmtWRlRB?=
 =?utf-8?B?aTdxNWVmRWxPNWwzS054NjJMWWtjUXpKOFRWTFpmcm05Q2pyQUN2TVlHcy9r?=
 =?utf-8?B?emZJM1MxNDFLNkJoeFN1Q2NBdkw5VjlJZm5KbWpnSVFQbVdFUk4veG0wbnV4?=
 =?utf-8?B?bXBVZzBoZXZrSnZhbkQwdWNFSTV0d0JCUWowRjhjMTlrL29pN3UyYW51UXp1?=
 =?utf-8?B?RzZSeWJZczlaWklPZkdmektuSE8yTFBJVWRmQ2hsU0NnamRPdlBDZ2xxblAy?=
 =?utf-8?B?bnQ1VVhFRitjNk9OVXlFempta0RJc3VFOWtlcHBMSnNtemtUZnpDNWEzYldS?=
 =?utf-8?B?VEN3UjhkQ3pCUVYyNjNSdG5sblJPMVdZbkxEV2V1eGFuUVNzOWlkQU5UZVpn?=
 =?utf-8?B?eVRuZ1J3WlBsMExmQ3Arak1nWnllc3UzbnhZMXh4QnpqTXJVOS83bVBMT2dj?=
 =?utf-8?B?SDF6Q3FWejVkaGdoVXBiVjRMWWdoaEhhcGZaYnVhZWRmQ0VraVNWMUtSTmVx?=
 =?utf-8?B?NmxYVUdJdS84aEc2NUFCYUcxVkNKV09qUEJFRXhGUy9HSWVOUm5qcFR0cTl2?=
 =?utf-8?B?T1VHQ3daUWRycEprUUxVTHRrVEZHQmxhSTdkSG9XYkpyUlNEbEUyVkYwMUtn?=
 =?utf-8?B?czAva0VQdXByOXhPYndrWmVLdzA3bHg5TVZjOGozV2ZRNHYrVVQwb2FpV2Nv?=
 =?utf-8?B?RkFxZHF2cVB5WUJrTWpZcGkwYlJScFpIb1BjZDU5NVAyalBCQTkyUnJkZnh3?=
 =?utf-8?B?YXNuRHZxNi8ydVJnb1FSSEd2ak1nSXAxa1NIdUg3L2JJaUFKZFVOSFR6bzBD?=
 =?utf-8?B?RmJsVGxqaS8zRHJwZjk3S1FRMWVTMTF0cXVQR2VXVlJRczE3ekxUYXNnSHVq?=
 =?utf-8?B?RzN5LzVCdlVJZU9RVXZ4NDhZTUJJR1dMMy9VWllNQXNjZ3FKYytYdkNraXN2?=
 =?utf-8?B?eEM2ZCtvakpscklTSUF5TGZ2UDRkZ2p5aWk5Y016emFxY1dnelBYQ045TkRZ?=
 =?utf-8?B?TG1ZTzRSTStvUFVFUmhDTU9QOFl5cENIMURmYnVNcEpISU90c250S3NzOHU4?=
 =?utf-8?B?YlZpMFJnaTZoNjU4YU93cGdpMFdoM1hxZlpZcDNsVGgveHE3VFBhTHhnYmxy?=
 =?utf-8?B?U3Nka3hqOW5pQllSdTJBSk9yTXlCTEdsR3QvMVlTa3dOUElSRlpaWk43b2kz?=
 =?utf-8?B?bVhSb1p5V29MOUhmeFA1N3puN0ZqZTZuKzlOV0FGYUFwdHY1NWlKT1pVekp2?=
 =?utf-8?B?ZlZtaHpTSEJ2cnNVWmZpazh1N1c3aGg4elRUbUFPanhOVDZhekV6aHd4cTBI?=
 =?utf-8?B?Y3FsdXo1bG13K2dhbEQ5OEZBdkVidGxZdTNFeDkwdHJ2SE1NV3BuMURxMStS?=
 =?utf-8?B?SjZJaTJBcmFSN1VRUVg1Y0FzbFJKampjbHRHaDRSU1N3dk1hZHc0TXU1K29z?=
 =?utf-8?Q?8VSx87rGaFqV17Thvh0sjxTApcKUEksx4Vi/b41VKI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5232511D380468439568E7F72F95E99F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8424ed92-8218-4cc7-9aa0-08d9f12cec1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:15:49.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlfI6KHdLnqN+OC/EGD6jVBZJmjFgUQ8sNAD4pImDwqcq14NCy7jjTMyZrT9PKBOPrNhR7znTM1vPciBnMnuSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0069
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNS8yMiAyMDo0NSwgTWluZyBMZWkgd3JvdGU6DQo+IGJsa19jcnlwdG9fYmlvX3ByZXAo
KSBpcyBjYWxsZWQgZm9yIGJvdGggYmlvIGJhc2VkIGFuZCBibGstbXEgZHJpdmVycywNCj4gc28g
bW92ZSBpdCBvdXQgb2YgYmxrLW1xLmMsIHRoZW4gd2UgY2FuIHVuaWZ5IHRoaXMga2luZCBvZiBo
YW5kbGluZy4NCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4gU2lnbmVkLW9mZi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQo+IC0t
LQ0KPiAgIGJsb2NrL2Jsay1jb3JlLmMgfCAyMSArKysrKysrKy0tLS0tLS0tLS0tLS0NCg0KaW5k
ZWVkIGl0IGlzLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
