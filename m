Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC4C433FE
	for <linux-block@archiver.kernel.org>; Thu,  7 Apr 2022 20:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiDGUbC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiDGUap (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 16:30:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11612E1C2C
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 13:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZuggZQQpY2q3BoxyE6gBTGgEJOtyXcusCYRb2rRf6/aBrvJU9WPPoZcT5cNnLZbULpg39Dw4JyCL4d+eGLW35x4zkb+ET7/SDuP7iSMuIqJzYb3GDaMsQKEGn9vUp1MhreIMpuRYX0iwWkWvkIntW8bdOjW6fbCfe8EMBJzNEa9ZsNTshvPUxK7byF3kUMMIfUGf97qrYE65PGLiB0mUT9YLZEQqakhvKWdSNASnFN38UdhYm9RJ/w700oXHem1o2LpcWgtWYwEbPSJT6IfcjjPFw2eIiFZ1Q2RVbDeW/tnVpL32Ul7RAThhiSzlodwhF7pMQPRyk08ouauWNPERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjFBo+bqpTttZYGbYZEifRJBTgLsL0Rak8nQtIDJrAw=;
 b=nW2q9/ZC1i4HF0dTWcBrws/u/ng1JOZzRAqORNarxkhUdVzHD+VFKQEM6u1hfWGGmAlA9TYISuxPd97nQ/TalbZPDskthY8cYWx8sGjIE6d70PuYdx0vqYvDbqP0E79hDzLHOxc0gpkJaS+saxwLWGHpsCZWElgk40ZgFEybv0jRZMYoHBEzgxw333MGCyVYzPtnuAwZcIcIePawWC+2lWyz7F0nay7JRekAQfB/uucNq9J1tr3J4IeKHk8BPuMyx/DjbFNkBM/Fn2p33NP703qhcF17jaLxUtG5JRHT1lPjBja3V12FIhVk+Uzx9WkKfc6/gI0/XUqItVHp4EaIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjFBo+bqpTttZYGbYZEifRJBTgLsL0Rak8nQtIDJrAw=;
 b=X+NpW+QMX0Xuk+Qp6rHe9ewG3jceeWNcljpWkqrSPDiRGsnFMq9kp3UGIWI5VV3HPrYKRI4k65VZKMSMASPJO8F9llEKZYSguCw3pNuWy72mgTsT9chz/xfkoXs8iB9RPBb3JEAk3V+vNC7TSHHb2kPvYGHj7GijMv1QI2YU5Su2nJu63x+VNkyRQ9ntuTMC9pXYQzEXSgUsnsEzGuxv/Jmw6GLrmSEiGkwV1YKnisDii0gEyuB1BXu23Z4N5FRxx7eFjySDCLeaPjXD+fGyEL6wiWdjpX9P/lIssImTdqK55Csx7a6iKJnlBVyKugfGZ3UITqjkoIfcIQfA3vXulA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 19:33:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 19:33:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Suwan Kim <suwan.kim027@gmail.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "elliott@hpe.com" <elliott@hpe.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 2/2] virtio-blk: support mq_ops->queue_rqs()
Thread-Topic: [PATCH v6 2/2] virtio-blk: support mq_ops->queue_rqs()
Thread-Index: AQHYSdwzllZ010uXXESRkL68ZHjYRKzk2OKA
Date:   Thu, 7 Apr 2022 19:33:05 +0000
Message-ID: <3b66fe79-74c2-d3ef-ef27-f4e1e3efb4aa@nvidia.com>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
 <20220406153207.163134-3-suwan.kim027@gmail.com>
In-Reply-To: <20220406153207.163134-3-suwan.kim027@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46f2bf4a-a12b-4718-13e7-08da18cd7015
x-ms-traffictypediagnostic: SA0PR12MB4480:EE_
x-microsoft-antispam-prvs: <SA0PR12MB448064C29FBDC8CD54E494ACA3E69@SA0PR12MB4480.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhiFuMN2C2c7Gg4sbpk9ROCvuMGI8fb0M6wh8P1PfzCFhxu0Nki8reZWpUcrIqCJ91iZsP5WLDYzc8K+TWl38nwFCLPSPOmVo+MnYJ/NXcmVhFEZQMiK0q6ahHP3lVzwZObGGTjw7AYQuB7g7NLh//ZncF5A3uc1foqPYcYgZW7lxLRxKuL+uxbzV4bUDCP+PB6LmdsNCze2eUqR+1S9HQLHeHrbWDX4z83no5/x/TMG1BO3gdsOsgKTYvKmGECYniRuvcx1QWrda3lbyyfRoq3UMZnAJsi3KYv0ctxQp4Xfvvah/PzK0jflTHK5Q/JLlrqDpzEaOCGJevyQ1gXzl8glpJhZ7VdmRM74zjElqd6d8aSAfl/39q1Tj4G9XvW7eLfjfccgcLvjrXsG0M38OC4XRx/dglpuNUYmkAaPTBjBInxyJ7tCxMjmEIT06dfRVK+pXPll0Z6uGWOq17cXE3ysV/8YjSJo2x7ENCokuUu2Etq+xwf5/Gy8jILC2Ol/b2BWms+C/NsQtQOauQarEky58yFUIGTbhUkyZfQWbsHAx4/jmiliaoZWfOifUj9X1r4L/xxjXK076Iqy0LYx8SZvz61EZ1meLerowuKtEyHYGogxB0Yf+R59xPl3vNMz4YJUQki7+iN+OzR9ruUmmYwzinRdQUS2cKOThNUWS79RYbEqM/hfTgtqd/3S1wVYCLTeS+qdSPIsL/RZpUxoLMVYjEVU69nVhFBMWk6eRN6Fv3261IhMjBZcl8QZmcNuu6Oxyq0CfwOlC1TLWQwdjLj5kOylmohP8qMdGd68xHX0NONUXzdg2gjKXZXhDmmR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(66556008)(8676002)(66946007)(64756008)(4326008)(76116006)(66446008)(66476007)(91956017)(6512007)(6486002)(83380400001)(71200400001)(53546011)(31696002)(86362001)(6506007)(508600001)(5660300002)(8936002)(186003)(7416002)(2906002)(36756003)(2616005)(316002)(122000001)(31686004)(38100700002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWg0MWxuWW1reGJ4S0kwemVYNmlleDFxeHlKQ0ZqV2ZRTlpZbzRIR3BaZGVx?=
 =?utf-8?B?UDBNTG85d2oyS2dBWDJDRzVRY0V3KzhpMzhFSjlCVE5yZC9XVHJqeEg1RVov?=
 =?utf-8?B?MEFQcVBnNjg1d3A4cTdnY1FrcmJtbnI5WTQxeDAwYjYzZHJvb1d3SHpvN1M3?=
 =?utf-8?B?dks3eGhtUHJ5ODFyNDREemsrN2hRVzR5U2lnSGlFdEJSSUV0RVFWWmY1SzdZ?=
 =?utf-8?B?WmhzS3NhbkhhMUhjNlY0cHE1QVF3cUhGYXFOVHFOUi9yN3NWUm9MRzAvUi9I?=
 =?utf-8?B?NVMwQTc3Z011bGNLVWRQUmJEaXZKKzlXdHM5L1RUR1lUdFZxand4Z1pDemQ3?=
 =?utf-8?B?czFDWFE1eHZMZkRPTVlUaExCTjJsSnUxOWhnZnFKYTRldldiTFg0eGVqazIx?=
 =?utf-8?B?MlJKZHdwUklCWXBSWnpkcHJQcHkvdll4Tk1YcHBQM2hvMnRTUnBSUFA2NWdL?=
 =?utf-8?B?NWpPVFhIKzNZUWREWEFBRWliUEJseEprTEpFTUpIQUJhcVE1WFdyR0xFcjVO?=
 =?utf-8?B?Q2QvYXBFOCtDVjliV2hMdDRHTHF0cDVEbm9abld3NmVFSm5ob0h2S1h3a1Mw?=
 =?utf-8?B?cDJrNTV4RWlnYXdEVkdWdDlIVmhnQ3pSbFBBM1JxV3pYRjNRNDlLMForRVdT?=
 =?utf-8?B?cnAyc0NkbS9pSTN0RCtyN0Y0WjVhV095U1VPRWFscFZ0U1hxZ041MjBpS1Rt?=
 =?utf-8?B?cmNVRjZvb284ZmI4NGJla1YybnJZZTR3cmQ3L1ZqTVM5TFpVV2lyMjdpbEw5?=
 =?utf-8?B?S2U3cTdHS1VsZXVlcnFzejBqZ2I5UWlqVURhY0lETFFTNkl0eVIwMWhrUy95?=
 =?utf-8?B?aW1za0tsUktxS3ZtNnhscXdWcDYvTUR6Wnl4dk9IUWNsbkhyTHZjSjJUVEho?=
 =?utf-8?B?cTcza3hRMWFZSjhuZ1djaUVPRWhxOXJzUnR5QTBVdVFpRFNiejlWajVxbldn?=
 =?utf-8?B?UGJiSmxjT0tqUGsycStqWXJqYk9vd2xPVTB4V0x0M0JrcjErNHBJQmNsUy9Z?=
 =?utf-8?B?aENXcmFlZnNDNndjeHFWYUIraGhUVTRqOFZra05MV3l1YjB5c3YwOG5Ca3lE?=
 =?utf-8?B?Vmp6VGZZek04VHkyS01jb1JVZ1gxY1ZRemZ5aS85MS9aV0o5bndiSGRLYjR3?=
 =?utf-8?B?Ym13eVVrMzZsd25MTlhzZ2N3U3V1cVd6dlRueC9RMjZKNGxHQzF6OXFRYnF5?=
 =?utf-8?B?cEFmWDUwYUJhdms4ZVNYRmI0d0gyS0YzUEJkdVNGa1NnZGxiai9wbVo2YUtO?=
 =?utf-8?B?cUZZZG85bHZkV2puTmFKb0RDYm9rRmp6bXh6dGF4MEZRdmttOGRxS2xpV0hS?=
 =?utf-8?B?T1BvcEFyT2RvRzJJQ0YydXN0TW54UCtaUGZTN2VYMzE1YnBGd01xVW15RXZO?=
 =?utf-8?B?MlJHQWttNUVUVDQwZ1NITC9iaGFrVThWdkpGejJJaEdkb0I0YWd5WWR3VUVF?=
 =?utf-8?B?YXNkQTFOM3R0YmZndlpMNXVlSXVBNGQrK2c3QnAxTDV0M0JSVi9EdnZJNnNz?=
 =?utf-8?B?NlUvNzZUb05PdGJoVHFrMzZOZnhRamp6WGhFM0ZTZE1aZ3QvUTB3bzZBVVQz?=
 =?utf-8?B?QVRGNUtqQi9IZGc0c2MzZGVqMlRDdDd3WmcrOTNLN1BvZE1SS0pTWnFyVk5h?=
 =?utf-8?B?Nm9yeG43UzVvVmhWTGpjUG0vQlRDbE9wajEvMkNMT0lYa0NBOXV2dnRKaUZk?=
 =?utf-8?B?aXF4S1FERWdBUXBSeWMwT1JDaVBtNUF2VVc2ZmNvMlpRVlVnalplc0J0U0Zn?=
 =?utf-8?B?dDFvNXE2dkFUZ21tZ2xwRlN5Y2ZjMGlBWFpkR1FzT2VLdHYzQVFVeU9HNHFF?=
 =?utf-8?B?bTBacWFXY3Z4dFROVHRwS3FBeFFIZ2VZZW52MFdsYk5wTklFbTFhV3VRTmpH?=
 =?utf-8?B?bDk2OFNWMTdhUFBzQzJEelRJN0V3Q2V0clYxdGViRjJlMndvdG9LRGd6alE5?=
 =?utf-8?B?UmxQeFByWlQreVR1Q29BdVVXYnhicDM4MDN3SDV0ZCtTVWo2c3VZZGx6LzJt?=
 =?utf-8?B?MGk5a0VIM3A3RjErVHpvMkpWTzg1SHpxVHF4N0hCWXo5dXFsVzVQNGNsRC93?=
 =?utf-8?B?a1F2T1dMYWZwYzF0QVdqQ04zQ2szY3dkbkZDWS9BWWNEQ2hqbUhhNzc3dVk4?=
 =?utf-8?B?dEtmRHNudlNiamhNZjhtemFkSTltSUVRSGZWRUJmaW9DaWF4QS94ZGM5T1Nv?=
 =?utf-8?B?UEMyWEFzNDRyUDRla1BWeHA1YzJsUDBjY05McTFOdjBmSWZsQkdoQzdsWFln?=
 =?utf-8?B?akx1cFpOakVSOCtuWXR5Tm9kdGZmVWNzNkl4ZzJZcFdMMFpMcktROGxPc1N1?=
 =?utf-8?B?S3h6YXpQSmtUYThidDlpNjUrWEcvWC9HVTdaLzc1RmUrT3ZLR1JjSXdTUTN5?=
 =?utf-8?Q?5hXgyJkXA7Ga/bEuAcH5gTc50fbuYwV6CehdTGTFBiBag?=
x-ms-exchange-antispam-messagedata-1: IGOQW3oAEvOo9A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <39CD55E6CB717E469B44C52BDF804283@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f2bf4a-a12b-4718-13e7-08da18cd7015
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 19:33:05.3513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1laHYAzMfYdIGam98l+2ooZWgmJhR8PXzh3nWRbD1gjZSB0ReV53QkC1r+bOjaqA+sOn/0Qqar/nDogd3tROw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC82LzIyIDA4OjMyLCBTdXdhbiBLaW0gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggc3VwcG9ydHMg
bXFfb3BzLT5xdWV1ZV9ycXMoKSBob29rLiBJdCBoYXMgYW4gYWR2YW50YWdlIG9mDQo+IGJhdGNo
IHN1Ym1pc3Npb24gdG8gdmlydGlvLWJsayBkcml2ZXIuIEl0IGFsc28gaGVscHMgcG9sbGluZyBJ
L08gYmVjYXVzZQ0KPiBwb2xsaW5nIHVzZXMgYmF0Y2hlZCBjb21wbGV0aW9uIG9mIGJsb2NrIGxh
eWVyLiBCYXRjaCBzdWJtaXNzaW9uIGluDQo+IHF1ZXVlX3JxcygpIGNhbiBib29zdCBwb2xsaW5n
IHBlcmZvcm1hbmNlLg0KPiANCj4gSW4gcXVldWVfcnFzKCksIGl0IGl0ZXJhdGVzIHBsdWctPm1x
X2xpc3QsIGNvbGxlY3RzIHJlcXVlc3RzIHRoYXQNCj4gYmVsb25nIHRvIHNhbWUgSFcgcXVldWUg
dW50aWwgaXQgZW5jb3VudGVycyBhIHJlcXVlc3QgZnJvbSBvdGhlcg0KPiBIVyBxdWV1ZSBvciBz
ZWVzIHRoZSBlbmQgb2YgdGhlIGxpc3QuDQo+IFRoZW4sIHZpcnRpby1ibGsgYWRkcyByZXF1ZXN0
cyBpbnRvIHZpcnRxdWV1ZSBhbmQga2lja3MgdmlydHF1ZXVlDQo+IHRvIHN1Ym1pdCByZXF1ZXN0
cy4NCj4gDQo+IElmIHRoZXJlIGlzIGFuIGVycm9yLCBpdCBpbnNlcnRzIGVycm9yIHJlcXVlc3Qg
dG8gcmVxdWV1ZV9saXN0IGFuZA0KPiBwYXNzZXMgaXQgdG8gb3JkaW5hcnkgYmxvY2sgbGF5ZXIg
cGF0aC4NCj4gDQo+IEZvciB2ZXJpZmljYXRpb24sIEkgZGlkIGZpbyB0ZXN0Lg0KPiAoaW9fdXJp
bmcsIHJhbmRyZWFkLCBkaXJlY3Q9MSwgYnM9NEssIGlvZGVwdGg9NjQgbnVtam9icz1OKQ0KPiBJ
IHNldCA0IHZjcHUgYW5kIDIgdmlydGlvLWJsayBxdWV1ZXMgZm9yIFZNIGFuZCBydW4gZmlvIHRl
c3QgNSB0aW1lcy4NCj4gSXQgc2hvd3MgYWJvdXQgMiUgaW1wcm92ZW1lbnQuDQo+IA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIG51bWpvYnM9MiAgIHwgICBudW1qb2Jz
PTQNCj4gICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAgICAgICAgIGZpbyB3aXRob3V0IHF1ZXVlX3JxcygpICB8ICAg
MjkxSyBJT1BTICAgfCAgIDIzOEsgSU9QUw0KPiAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAgZmlvIHdp
dGggcXVldWVfcnFzKCkgICAgIHwgICAyOTVLIElPUFMgICB8ICAgMjQzSyBJT1BTDQo+IA0KPiBG
b3IgcG9sbGluZyBJL08gcGVyZm9ybWFuY2UsIEkgYWxzbyBkaWQgZmlvIHRlc3QgYXMgYmVsb3cu
DQo+IChpb191cmluZywgaGlwcmksIHJhbmRyZWFkLCBkaXJlY3Q9MSwgYnM9NTEyLCBpb2RlcHRo
PTY0IG51bWpvYnM9NCkNCj4gSSBzZXQgNCB2Y3B1IGFuZCAyIHBvbGwgcXVldWVzIGZvciBWTS4N
Cj4gSXQgc2hvd3MgYWJvdXQgMiUgaW1wcm92ZW1lbnQgaW4gcG9sbGluZyBJL08uDQo+IA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgSU9QUyAgIHwgIGF2ZyBs
YXRlbmN5DQo+ICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgICAgICAgICBmaW8gcG9sbCB3aXRob3V0IHF1ZXVlX3Jx
cygpICB8ICAgNDI0SyAgIHwgICA2MTMuMDUgdXNlYw0KPiAgICAgICAgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAg
ZmlvIHBvbGwgd2l0aCBxdWV1ZV9ycXMoKSAgICAgfCAgIDQzNUsgICB8ICAgNjAxLjAxIHVzZWMN
Cj4gDQo+IFJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gU2lnbmVk
LW9mZi1ieTogU3V3YW4gS2ltIDxzdXdhbi5raW0wMjdAZ21haWwuY29tPg0KPiAtLS0NCg0KDQpM
b29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KLWNrDQoNCg0K
