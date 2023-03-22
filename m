Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7FEC6FD20
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 01:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCVBrs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVBrq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 21:47:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568058B55
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 18:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JenRCgIbIgCwZbp9F2GifnnesuaQSieahg9rDmy+Kglh+q5WZmRs5A5WPjL1UGq6bj3WBzqYOiY22QuAAZLeAIId43OIMcKAO6HISpXNh749TqkIAs7ScI68Xv37pgIaIwtWGhh0oljCqwM6bigZYOjM+Ar21Z78vJmJcsVDfzmF49KwiV2VG1nO2/G+IbhXGon7ack1AYa3cYZtck1bXimQ8t0wbxr3cj5PnXhIcpu+ONP64aSJ2NTq5PSPMbf8g8QYVoMhaYnVY/RBpdzDLunC98UygXr7TJKYxhFEADK5bppD+hwG3vboZ+Ih7DNuXg/6wtByodMVBilAzAQBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKxyOdo0hr3MalEn6Fik7ugDWnvccA06Ew0AM4+oZfk=;
 b=lJy6EQwqV14qhG5z+LYAvBOV+gB0nrOdpTHZUJHF2xJYegO8+4Vb6wIfUSomGKMEmPQeT0j2+h0TbWVUbyduOqaaZr/RtslOf24MSZKILy2A0ah+Uau4yE9WR177oYZDe6ovoAWb37r/5+nATAyP0KI16IhVdH2+BxXSH0dsmK0vto08F7/Q2VQoPYZLD+kQ63OK1jI7b9RKVNeSFSErL9inQNQQ17Oe15qndPj80rdO1uHJoPS6FkoJ5Ep+uOqZkr4M4FulzyicjpRE9trlK66cMNsRwz15K4z8Zwqsb3IoRHXMDcNnYc8RLlMqQhUCPbbVbX5qdcaLbxXcscarLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKxyOdo0hr3MalEn6Fik7ugDWnvccA06Ew0AM4+oZfk=;
 b=opntq7kDJUbJTlv6o+gBbIzg4eFsk/HyajkA4gt7y0UiiBxTmMRwMUYbf+pzWAUUuDEUDvzMJUDkJE5uRuZ5zDbN0inKscPvJQUNjGC77zYYGDI6GHbEV3rharaYivqADnpBowuGHb3OsjJMGmT4Kw9AvM4upJ+BDEttxzs51uq0XErRcUh+Kwhqg/cH1ZnmvWWsaMUnaw3RyuAwzQwImbWG0HdvjsGGi98F59OGea5Humm5MZAvwrtCHVHYy33fRYyftYGPSh9h62RDMT/8A2kvRYzTFf/oneM3UsLk85IuLKXEyP4t7ma1bR0Rj1J+F2RgfvT/ILUaMPy1r95GVg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:47:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:47:43 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@meta.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Thread-Topic: [PATCH 2/3] nvme: add polling options for loop target
Thread-Index: AQHZXFSkM9XxFUNEzkyLN3US/HyS768GB+yA
Date:   Wed, 22 Mar 2023 01:47:43 +0000
Message-ID: <29fcf1c7-56da-7f13-fae9-8571413e6100@nvidia.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
In-Reply-To: <20230322002350.4038048-3-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB8063:EE_
x-ms-office365-filtering-correlation-id: 57ef4046-fb9f-4b34-bf17-08db2a776df7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vc5XiR8N6wpXRVG4opa/5q5R+jFWbIkxYouZZ5L4RWHz7E/EIN4oMSVvA89dM1RmdSu+3Vbjg9zkBQ/mkAn01iN7JnqIFBuoAl8cHvO45ZI+5s+ynagYUjIy5vS+xlRoNrzkS6yOPMg0VPBtb50KUGdeNYBd5ByQmG4aAE26RWKOG1hrV4C7HdrjZ90lblHSF5Dg6sXc1RiSyZtjOeNbGrh0hnTXjsAT7al7nwVwQO/5pzKz2ODvjQOeQ2qjTNJESfSzxSd2hZz0Gxs/RlrwXIyvhtFQqiozTpndpsB0FHyQLcYI+LpE327V1hMDYCQaO8e4oUH3qL5RqKbl8ORg75cyqjqSo59Lms4oP+ZbJf6o8Hnxt1bRqFpgieQWE2v/fZCrmEfPweynmtoFhm1pCqPqKILb6ArJvGM0dW2X11GxttIQk5vLiyapo6iBOxXrk597cRuYJp6ag+R6B4C0ZaSdStGWR7Q9o5SHt/b1DBOcVT4oPvVwN0wNtHUxOoCLI2x9KveWxYTwCmJeubVrHm45Av5q7eWogLgHmWzaFeghgF8d1YZdaIQIEJqyreg+oGk1p6XXjE1qEuL8sNo+vANbMJw5nEbrLKla+wcLXHS+mjpFLJZ4iwqLGYmQBypWvG+EuiCBmGaJTqd4uVScyr3VwDTjFJo7Vjx74tS51pHZL4y59I0VXekB2Ga6yqcgAkC7/0ZiUaMGYLTCCUpIXjxHi5jr+M1wiEkv5kNcQ35rbC2WE/ie8XodDDdpCdzatsAKrdauwNUYPKowSoDoeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(5660300002)(8936002)(41300700001)(86362001)(558084003)(38070700005)(31696002)(36756003)(38100700002)(2906002)(122000001)(4326008)(6486002)(478600001)(2616005)(71200400001)(186003)(6512007)(6506007)(26005)(53546011)(31686004)(110136005)(66476007)(91956017)(316002)(8676002)(66946007)(66556008)(76116006)(64756008)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amt1cUFsMnZRZjNsdWtzczk0NXg3aVRUK2t3OUFZTjRhdnBOcFkwOVNvenAr?=
 =?utf-8?B?dVkybUI5cjRrQUZWZUw5b3VJeEMxUmNyb2tOWk9UR2preTQ2aHVVeTIyT3Bu?=
 =?utf-8?B?eGZuS3U5VzNKSzVPMU93a2szWW5XNHhhcnYzQnhYWUkrOHFVeTQram96K0xE?=
 =?utf-8?B?QUQ5UmhOTVcycmZnY2svSXpEZjNyRmJlWGM2MHh2SHRoa1I4UDZGcWVWZ01m?=
 =?utf-8?B?SEpMazBUQmVBbFB0WWxUZU5xZTBHNG1raFgwREVwVXBXcUtFOHlPOElINmZm?=
 =?utf-8?B?Z0VvbUNDTGZ5OWRGemtTbWUvWmRkMFA1bTVISDBVUzM1M3FDcDZSOGNId3VP?=
 =?utf-8?B?TVU0SGltWDBPUDJSdWcxajBUT0plZjg3dnljOGZaRFFsRTBpUkRoblhyL2Z3?=
 =?utf-8?B?ZUJwWU81UFNRTnRHcTl4bUZrVVZPTkx2a01aYkpRNkxiM1NaUlBoZkNzMUc5?=
 =?utf-8?B?YjRTM3RGVXhJeXd0cmlNQjhHN3cxUGYzbkJZVDZucndVQkMzOWtEVG81ZHlE?=
 =?utf-8?B?enhlMDgxbVR2QUozSlpUUmNsdWY3RnlNTTJjM3NEZ1NOREZ6WUFWQnE5SkVy?=
 =?utf-8?B?VmVlZzVPYTVhVSsvd3RvL3lqL3AzaEEvT1diTXVOazRUTVBvYWd1Wm5mREhn?=
 =?utf-8?B?ZU5iYXVTZTN0RG43MFRMME1qWXFJL2czMXhTelVZV0FZcElkempJa2RtY0xw?=
 =?utf-8?B?QmJrVmp3NlpzVW44TlpSM3Byb2xOQ3o1NytmNVMyQk4rRXd3aDUrU3l5U1l0?=
 =?utf-8?B?bHZSK2lqWlMvNDJzN2Q2MUU2Vk1zekRiVTF5QXlLdGsrZldKb1pXcXpIeXhK?=
 =?utf-8?B?cUFldlBiNEtUdE16dFIrK1Q0WWVGUEhKVk9jOFBPUjJjWFRXZ1BvQThWclp5?=
 =?utf-8?B?UkcwQzU2VkUrYmRXMjdpMFdIUmhEc3l1ZE15Y244QldpVThnbWN2d01DZkt3?=
 =?utf-8?B?TDFXQmEySUV6a0NPTUtYQzdUTFV2UnJ2V29MSWZkQThRNjcreXd2b2NVQURH?=
 =?utf-8?B?SE1EYWM2MEgyR0ozbjU0ZlZwOC9vVW5hT1FFVEp6SnJQV01IV24zaTZuTDgw?=
 =?utf-8?B?eURjbjlPOEFNcnpwT2dIZTBLazRSMVdxSE1FK0E5WDh1SlBqVG00OC85RUtU?=
 =?utf-8?B?VCs5d3RJMU5HZjFoNGQ2czlOK1NQUEY4V0tLN2F5eUhvQ1FFQ1VYRXk0dklU?=
 =?utf-8?B?RG1NOW43dktXajJveDFIQ0pnemJhK2xjT3UzVk8xb2txUXlURHpPSnJQcEI3?=
 =?utf-8?B?UTJuUDNBeW1va2hpWmJFbkZOZEVMWG5RRUVZbHkvNDVDUWh6cFBHNmxLRldt?=
 =?utf-8?B?a1kveDNRV2JSY0RraGhxOVhTSVFrSllSN3laZWRjTW53Si9iSFFwcjlXelJt?=
 =?utf-8?B?cXRSeVZjN3VlVWVZZ1h1R1hUOXRwZUtLbE5jSDdDeTBqbjFQeUU1NXk4U01s?=
 =?utf-8?B?QVpySVBkZXVQWE5XTG9rL3BhSzdBMGcyMlA3RVZ4YmRRRDVURTN3QnFBSlE5?=
 =?utf-8?B?Q2RvdlFQMEFqSlhSc0Zpb3JnbmtxSlBZVzBSM1hJYU9wV0xqZGl5azZBRTB3?=
 =?utf-8?B?MGRjcEtiKzRSQTNtck5ZcnJ2a3FGZjg5UzJLN3NWdE5UUVRoM1RDbm01Q1Ix?=
 =?utf-8?B?NHJqRVdORXdZRUp4cDBiWEMxeDhFMjVVVVdaVTZUUHpQTmtjTkttdkVxSzRQ?=
 =?utf-8?B?bTFVZC93a25PN0pWV2VxMW15dmN3dUNVeGRiaXIwUm9HUDFTUVAxb0pqREY4?=
 =?utf-8?B?cnFJZ1pDUllmcWNJa25FYXJWU3Q0ZGEyUkMyYytXTHA1WE1YUzVZcVJvTktX?=
 =?utf-8?B?a215ZS84b2tYUlFVUm81SG1sRU9Fd21ZMmlpMmQ1VXMxUklBVldnbFgrWmVJ?=
 =?utf-8?B?ZkNvak1ybnlaTXZGZ0lUVE9hSEExaDltR2RLT1VENjlsWWhEVDhzYm1pRDQy?=
 =?utf-8?B?d1QzUTg5eWJ1ejlEVWdLNEIwd2NWei9XMlJzaFNQY3VIS09OaW1QN2xqaTJB?=
 =?utf-8?B?dEF4SkhSdEV4U1dLeHQyT3kxazZxYlAyTFU2TjlQZXdVcVFrOWM5WjVCdEFQ?=
 =?utf-8?B?RTRINnpyTlRKdlU0RHU2L2NUVlNWOEowQ1VuN2o1UUxXb3U5bHZYUHZJV3dX?=
 =?utf-8?Q?Z6/O6lwhtb10HYIXDo1sZbmlr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEBDBA9D41D43340A1F42E23214407F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ef4046-fb9f-4b34-bf17-08db2a776df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:47:43.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lsVFWhFHC8NarCt2+7Ad9MaAdNmWecCYXtLDTQOmPaAGL7lBs94mQqNk+nUkrAVDmSgAYw7bmgxMc+GDw2pRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMS8yMDIzIDU6MjMgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBC
dXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IA0KPiBUaGlzIGlzIGZvciBtb3N0bHkgZm9yIHRl
c3RpbmcgcHVycG9zZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2No
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQpMR1RNLCBpdCB3aWxsIGJlIG5pY2UgdG8gaGF2ZSBhIGJs
a3Rlc3RzIGZvciB0aGlzLA0KYXMgSSB0aGluayB0aGlzIGlzIHJlYWxseSB1c2VmdWwuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=
