Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872CFC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 17:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiBPRfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:35:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiBPRfn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:35:43 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D66223BF0A
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:35:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU1lM/JBe22mIpfR/YHHS48HsaKO09v5EZCXB+Lh5+nkuYDg3x3QY4R4rfYuwdMhjvyYCgOfz8gSpsPZnmtZTs55ADEaNxx0WpvKsSnlmcaQgDR9AngSb0fGGm3bBa3i5xDuOLBPWCDWr6GL+i2N0bwSjLiIIlmDwv3QC9aTDbDcF50eF/XFxEBFrpPT4wW7CAl7yzdff1IqjCTy4SJjrGO5zId6azIoCob3PuUpR6Z6U82uWWAhzPOuIFQceOn+dW1Q8UtBpBL/zr/nPLO2zN4tHthK1SXCxQ2hrgsY8jLDACpo41B02CCPXoj8+wCXZZrC0djKWJzeQ7y1eVVAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdchcF+BzQisZ6WWSZoZ/fp/ZJHymI3erVKjsZD7yeU=;
 b=DVFnnlbywfFxkvplSUi/F91YdEzqteRPNADn/N0w5DmS4n4Ld9rk4le/lObsXRA8FWoIPUnNJ5Sfid2aNHIsgcRev7Ev+rUjqUybh5pLFwT3Evm/vMB1G8B5qrjhfTj/NSindvqgYpNoq8SpxvNnwj20RS7hk6Zn+H8YQG7sfp2Wa+itkUJbRy5Vm4fQfYlkK8vZJ7cVLQompEYilPXnnUwrFUa0w1J2RAeClPAWpLUYSZUS1k8J29vNRd3xCx/QRTQUv1bqXbP5mSqIbQqLx3WWhuWUzy1JPAIESru5kUJsETjD5BwAWEdnxrNVsF3ro59nfJny2DA41bRakXwSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdchcF+BzQisZ6WWSZoZ/fp/ZJHymI3erVKjsZD7yeU=;
 b=lp3rsG/NgSGLXAwpAHy0iQAFKY56ij4BxbBpKzzGC7vFsSpYgPR0N7IH8Z5kdReUGB1jyNFrfy2rwISCCIeAo3ozVlZQD7ihuBV1yB/k7vM6agxrFhjWnA+22/W1D6aoFxXFP8Dm5RpCpUB+CHXjraFdURp1SVcmtROKlUs7Jyy++VovTVmGiXNEdz32DzBGhEnsjQ4/37IDyWwsXWNTQMhiiZ9p9OQVwZuHj+Z/PrGOvE1W3R6P2bBeAra7QAGcLcwMjyo9MiILfqpkpkoXVvNIN0qwj5bRPSbqau6mwM6Oc5EbJJBxgrvHJOX3IYgG3sO0d9nPfTMVLoBIQW+jGQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 17:35:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 17:35:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>
Subject: Re: [PATCH 2/2] null_blk: remove local var & init cmd in alloc_cmd
Thread-Topic: [PATCH 2/2] null_blk: remove local var & init cmd in alloc_cmd
Thread-Index: AQHYIxfowx7JF7mPHUWMRr6CsZ/hiayV+CgAgAB404A=
Date:   Wed, 16 Feb 2022 17:35:28 +0000
Message-ID: <ee0088ca-1a14-d3bc-d765-28c8e27062e4@nvidia.com>
References: <20220216093020.175351-1-kch@nvidia.com>
 <20220216093020.175351-3-kch@nvidia.com>
 <3ec98d01-6b9e-77d7-aa29-9f7c4ff21d4d@opensource.wdc.com>
In-Reply-To: <3ec98d01-6b9e-77d7-aa29-9f7c4ff21d4d@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b21c0c1-1118-4ae0-f561-08d9f172b91e
x-ms-traffictypediagnostic: MN2PR12MB3902:EE_
x-microsoft-antispam-prvs: <MN2PR12MB39025A21D8D732BBFD7DADC9A3359@MN2PR12MB3902.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDyZDsAIrJceAOvSPLGMl9xy7J7CXc4xhJkJuZuBgACugk8iM14UHrjmL5vpnscaOH4lt+mXcJLUfCxXC6lM3ViB6T9aBleQqDRczTmKUiquw8ZQMc+c0I3RLr52B9xjC7YR8lQc+K25/rHgIvgst0PnBdiBLHdc5s+LsxUG5sFZi0Y2MJKl1m5fP0PQn+vNsSJ7Bd0GS2y6MhtsVN76fLTofnredn8qZByyow49LuTChGr4B+J4/YLnlU2255d8uz/Mtb/7jXaj63r6xk+pZqHKBekr7J6nE2uloIneMJkFP8oWulWFZk7KVxtfTl4bLV3bqwxoUSVzQVXDVVfO3DmX8w33BqqFk3Bdi7Dxo/NENROQEES63YR80Dkf1zjU/smO/4xceL6U02Yv+WVmaVYzBeJfqmMYsbw/Ve3/+1rBrWVWAR6RrIXC8gN2JlDx3wdnXeedzZBq4AdHFuMzj19HC6/+FOnoZEB+opbOg95JqSKdTPQGsPB16nry/U/dMqlYUvAJHydI8C89n5nPASCBloXHthWJ33v69zhD3vz1yy3t7v6mJL0ZvhTnExnPqIPGf5BYKTP8HlRgsV0wWIL0AgDuzW0iLomBs0mBSmWUoLKGvp77yvyF5DqCv8vZcYz9uhsl/v0B4R3UnklwPYwi/m2EOgEth/+rGgo32OMCdZWNzgqXQc4PEGptwbrZS6/5Nv+4ikLOlKat3BG3eiJWcZw/axHQeS8eM15GuQai7OJgvCHk7zYYHJQvP75CHpEE3iiPrBt2yEfogvq4nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(8936002)(6486002)(38070700005)(508600001)(86362001)(5660300002)(4744005)(38100700002)(186003)(36756003)(83380400001)(2616005)(31686004)(2906002)(66946007)(4326008)(76116006)(91956017)(8676002)(64756008)(122000001)(66446008)(66476007)(66556008)(71200400001)(6916009)(316002)(6506007)(54906003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ditRcXhTMVB3dkZzRVk3Ty9ZckF2RkYwbFcwRTFTWkpWU01EcWZvaFJ6M05G?=
 =?utf-8?B?aytDZ3JueW5KdG4zMi83LzhtZHlIakpBSTVaMHBQUGc3eGk0OEJyQ1dPMVZr?=
 =?utf-8?B?eVJ6a1NybGlhYVpSQzVzNXVNTm1yb3hmelQrTm8vODEwNWcyRWFMTllVYmlC?=
 =?utf-8?B?bWY3aFJac3QvaHVvdlBrUWpnWWdZell5MHhDZlFBNHRpMXJZOUk5RFMzb2xw?=
 =?utf-8?B?V0VGL1pCVDA4S3hSN1R5ek5YQXExQmh3NVZWVHJUODNqaE9MNlpRcm9vdXlr?=
 =?utf-8?B?Y0ZQTkVWYTlKdW5MRnA2blpibVd3cGxaQnVvNXVZK2dMUE5WSDlSZG1ETHhI?=
 =?utf-8?B?N1BaZDZsbXpsZGg3OGEwRUk2NGZUSDlzS2hNNlVUL0pXYzBoSVJxMndPd2FM?=
 =?utf-8?B?ZTZLRTZETEF5Y2svWW1UTUNEYTJlVk9IRDhFakhKY3VLeTBZeEd0S2hzWWE5?=
 =?utf-8?B?VTdQNWxYVC9UY3pIZXhpRVVlb1hkQnZZK1EvcytjaXN5QzJRMzVxdURIOXlh?=
 =?utf-8?B?VXVHNFZrcWpIM2V4azlOdGFYWDRCeTRWU3hmYkY0aHRHUE41NHZtaWRJQzlB?=
 =?utf-8?B?Q2VnZEswb25rM0Q5TklDNGlYRDZGbWZjY3VvdFVzejJ0SFNOamF2dHE0aHgw?=
 =?utf-8?B?SXZKdGNTeE5iTkw4WHNZQ01uQjZML0JEU2s2Yy8ybnpjRnFFRlJsM3dzOE5j?=
 =?utf-8?B?Mk9keUNzT05CMXRWTjFFdThKcHJVSG1OdGd0V3YzY3pTaEhBSEY3ZzEwQzUx?=
 =?utf-8?B?dkdXbVJrNWptRXNqMDZVeTcyc21oeGhSelBocXk3VjljOTI1bDl3S3grWnZw?=
 =?utf-8?B?cEdleWtsTSs0ZkhpQlk3UnpuMGo1WkUrMUFxbDBkajlNTFBuc3JOL2E5Qno1?=
 =?utf-8?B?cWlWUHdQT0NqNEhFNEpVR2hDTXAvYlQvTk8xUVBiZlJ5elNwNjUrSmg0OWFT?=
 =?utf-8?B?U3UrSjhFc0FGNC9Ob2R2bUJraG1HME84bzZyWG5kUUxRVGpPZWx4S3lnRWwv?=
 =?utf-8?B?OWVVZGVLTUJSdG9kckpmUHBOQTljRHVHbGJEZFo5M2ROQmlpR0Z6bU9LN1RE?=
 =?utf-8?B?bVF6QnhaQkZLN0t4bkhMVmtoN2ZHNzRkb1JLbEU5WVRuaVRoUk41MEJITW5C?=
 =?utf-8?B?eENWZVp0R2pCaTVIOHdCbUlkQThCN1pOWmM2d0l5YnpwVFM3VGp3c1N3aEZJ?=
 =?utf-8?B?OSt1T3poN2NlVjF5eHhuU0lHbGZHSzdoRXZhQUV4ekxTai9QN0J3SjZKMWZy?=
 =?utf-8?B?NHk2dEJXT0pQeDE0RmhYTGd2NUNtMnFXVzlFZVNDQjZlL01qa1ppeE55NmI0?=
 =?utf-8?B?aDBQVkwweXBGdkM3Sy9BMEZLNVN2ZEJiSTBwMVBWTnFKQUhVVzNnTVNsMEhp?=
 =?utf-8?B?KzAyd2dQenlkaThqRXVud21LTWlOUU43eng2V2tYd29FYWlNTHhxdjF5VkR6?=
 =?utf-8?B?VG5tbEltZXdQMnF4cU84MVpZZS82OWpmZi90Q1dSclhRTlVpWEF5U3J3Z3I5?=
 =?utf-8?B?ZmVlU3AzVzdUd0ZJVHFCemRQTkdudVdTUFUvSkNCR0RjNitIaXNaT2VrODV3?=
 =?utf-8?B?ejNLbFVVenZyeVBMNEZ2TDVTY3NYdVZ0MjVIZVNWZ1hjTVl4N1U2K2N5Y3I0?=
 =?utf-8?B?L3FndDBSNE1NcVZEamkreXpsV1NWLy9tdThYZW5RNWdlbHh2QnFxQlJZQmJi?=
 =?utf-8?B?czBlUGxNMlF2ZkdqYnVxWjdpY1EwZGZidXVRVk04R3NVTnZzZGwxUS9OMEta?=
 =?utf-8?B?c0FqUlJLY1Z5N0lBajYyYzYzMGVxUGpPZ0Y0NVIwTFZJYlFCM0VudmR6ZnNY?=
 =?utf-8?B?eEwrRTlGQmIvTjhoYjRmYUF5MHVRcUJ4SkVPODBCUjVrRTZ3bEFGQU01Tlk3?=
 =?utf-8?B?akp2VkhqVTRtRkhyRFBFUUIwRzNSbjlzcnNhQjVIMkp5RzFyMldWdjRJYmEw?=
 =?utf-8?B?dGU1VUFkSGxvdElmQm8zVXJ6OTRzV1B5UmV5dHd2Z1NXVzdKOE1Gc0prWnFy?=
 =?utf-8?B?MFNZeUNsVE1KczN0ZUt6NTYrbGFGUW9Va2N4ZGJ0T3ZpN2hDOEZ2TkNXaWs1?=
 =?utf-8?B?eHlzeHpZU1lQVXBiSGszRnZaL2FXUkMxQjdka1VhTWxaK2ZQNEdnMEZsYmJp?=
 =?utf-8?B?QmcrUlFndlpPMVdiVUxDNUNreEZWaW9UMEpKckJ3NmlOT2E3NDBnS3h2WGZo?=
 =?utf-8?B?UHN6c1BGeEdtOFhTZS83QjR0R09SakRqaDJJcTk4ZzZFWklRYW1HMWlQaHBR?=
 =?utf-8?Q?XWIa4Zd7925c5IAYPnoC1Ai3Ca/XnLK+7xuGVoP9ys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <313A56CC6119094BB506919A933887AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b21c0c1-1118-4ae0-f561-08d9f172b91e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 17:35:28.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSVUnvj2ffoVFxQ/dfb9j5zRRcr2sBP1WKTnpWEro2PPN/xWWJN4T9GeEkDkwSS4GqtupW7TXkN7bx9Lb/DYnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+PiAgIHN0YXRpYyBib29sIHNob3VsZF90aW1lb3V0X3JlcXVlc3Qoc3RydWN0IHJlcXVlc3Qg
KnJxKQ0KPiANCj4gU2luY2UgcGF0Y2ggMSByZXdyaXRlIHRoaXMgZnVuY3Rpb24gYWxyZWFkeSwg
eW91IGNvdWxkIHNxdWFzaCB0aGlzIHBhdGNoDQo+IGludG8gaXQsIHJlcGxhY2luZyB0aGUgY2Fu
X3dhaXQgYXJndW1lbnQgd2l0aCB0aGUgYmlvIGFyZ3VtZW50Lg0KPiANCj4gDQoNCmlmIGl0IGlz
IGVhc2llciB0byByZXZpZXcgc3VyZS4uLg0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3
IGNvbW1lbnRzLCBzZW50IG91dCBWMiBwbGVhc2UgaGF2ZSBhIGxvb2suDQoNCi1jaw0KDQoNCg==
