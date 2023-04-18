Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC8DC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 19:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjDRTrC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjDRTrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 15:47:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA655B5
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 12:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvpstktfTmmUS6/NLH+53cu0rrfsrLOouS3plASyQGvGN7OQiJqwmu4IbMJ0uGMvPUKr7w2KUWtYdz5KSU3a0Pxwow9czEIMSbtw+nYaNvgGSVypJkl6CMMFXcTiRlQODEOKttZ/TyWFjubLfcEro0JG/L64PTJFP603KYFTxAahq8rOORtUjc0V1CuZ22E1GnTGnBx1gnP8J1nebrjlohCIAxaryUvd5Nbd5iyVq2PWhsAV/TnDClPEiN9Fh3B/1EDuG7Fn7b2djUF36OCWyLBHZqbCf1B5Lcrol38PNFVz36Zpkiivsg5j4SDx+yJ+85nMiFMEKtEXi95x+ediPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCzVMEZ/dRc4AvcD1QpSH+QBw3SnZ+0YUlabwFDJuG8=;
 b=jy7WVpsCLtvYpmns8JKXcRjQF+0LIRctQlKlnQqNBlWclB4J74zIiSi+LpyOAAP+UvC0OgjrEsRL/WarK5WXlpzBLN+agw/cSHceUL2N88SeOTxgpPcuv6eLc11GYXkU+GUucikiRPfizvuYTqH/GLv8yEtmSCPJ8NRnApneZrBhvwjsVEKeR18N1j+O1fCjN6WsRVeMbIITJMb4FYE3yBBbR2cbQn85N/RfMrqN9haB86fMAxQX/W8WAzWsDY3AjN29C7W7MMdbIVWqCODS37Gf4kNFQkNr0iDce3hae2YIiuvr8AmuNdvoXnPt7A+F0d0IN/hTY4Hxv5OzEu4Gxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCzVMEZ/dRc4AvcD1QpSH+QBw3SnZ+0YUlabwFDJuG8=;
 b=gGFr6lUgXN3ABBcQdx+9hYa2cPzbXHjuVqzK+iMYwx+c9bqaUC5E4JcYG3yulM5QUGAA7DLughKC4KwhK2DA8lwgYTxV7AYbKQ5Y7gIhF6HuLpsvQNdOH5iOVbHGF5EvYxCvJs2HDTHT/M3+FRM/3Dmz4u1lAXXzq3mlsJ3b+HnE6N1RL1CXRiLcyzMwUUkKERB1kCuuSLvNz4ADKzPcvWD1VELaG26imuP4xX+b/2b3t2RNiC08PFZDQzHN1z6+n9gwrqoOp//9KRrs0EjkTmv51FAQawOIjlqof3B577Q+fcPhbWRt6liho9tLEyYImYdW8szXKY5gJZd2drESKQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Tue, 18 Apr
 2023 19:46:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 19:46:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Topic: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Index: AQHZbRuBGnDoA0PLrUmq3zDXdDqS5K8w+yaAgACHr4A=
Date:   Tue, 18 Apr 2023 19:46:54 +0000
Message-ID: <0ac55d31-8db4-d645-4528-f0987ca871cb@nvidia.com>
References: <20230412084730.51694-1-kch@nvidia.com>
 <20230412084730.51694-2-kch@nvidia.com>
 <CGME20230418114947eucas1p2350d60e2643c11bd01964805ef9baded@eucas1p2.samsung.com>
 <20230418114115.zhcabb5lelbeyyeu@blixen>
In-Reply-To: <20230418114115.zhcabb5lelbeyyeu@blixen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL0PR12MB4948:EE_
x-ms-office365-filtering-correlation-id: c82aaf63-3ab1-4bf4-6a0d-08db4045a96f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8SbgjXwPcSlR5dtWQ7eLdWDYEasFUVdeOOGB7krKWbeNvfrsveGfjtMb/YdSNgelfIFIjhHZ+KstnkRlAc3SKL7VNuTUdnu7W+y1PfVvPlhQl8ORfFOUOZaKmULkm5puz80znwA3vCI10z5ad0BZZmkL8IxeEFwov/u4RsPTYfLBzc92yoUlv8BBuTlc7MNUX730OSLUhilF6BrVR44PkC6WueY2ZZwGupS9OLN0qpLNf/QSnRxOOZQVIY8zfYs3xpD1GMqPqgsNV07WTzLqUoq74JgOA3OWR6HjtExOV0eSW3lf5yGpSgUlL7p4K9hE55/ZZZdjFOQYdutZV7yhXKrs9hx0n27ariUsyyrLqyBrNv5QD9f4VjvmycyKCCuG7ROZN2h5BixqUwzgbiCocei9t2Xya3pjheAbxl5AE3Wpge4WeC1tl9bkBakbkScqVCIGhHRTSX7yzzaROO9Ac+y9aZPmKQ49bjbeNXBbuTUbgi/32rJ7OwaanJEWLsNEoB5dmF5ng6lwdzOYF7cqKey2UqoHkjd2Ec9tW8CNv/vQR9TVl8QWkaGdgoZg1vrsZCdbQOpeZE+8EBmOYYuvszW8OhcqxaiVhcLOe1q8dsuzBvBT4+G9uXVfhQUjWvfdcg14Ly7GN/lm8TVdYon7epX2srPq08EZqcsfKPbvzPkiBJw2DbonjBUSVL+LE7QG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(36756003)(186003)(4326008)(54906003)(110136005)(316002)(66946007)(66556008)(66476007)(66446008)(76116006)(91956017)(64756008)(478600001)(71200400001)(6486002)(8936002)(5660300002)(41300700001)(8676002)(4744005)(2906002)(38070700005)(86362001)(122000001)(38100700002)(2616005)(6512007)(53546011)(6506007)(83380400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTNhWE5XT1M3NC9xb2RCdExQNXhyR25PYTNURVVPVGJsRVBPZ2NQN3JUYzBt?=
 =?utf-8?B?dFN6SUxPdjUxU3RxRnZIZGNjYnRlb3BZS21uUmpadlpsb0xaaVlZdk1tQkJN?=
 =?utf-8?B?WlZab0NUUExNUFVVdktabE1md2pCN3Uvc0cyMUNiV0diSVBqZjlXZngwaks5?=
 =?utf-8?B?c0lCNE1VUEhaRERzMkNERk13Y292U1pIZDkweXdkNmlKOTJ6K1hDVXNyOU51?=
 =?utf-8?B?U0ZubFAvQ0Vxdzlvd0VaMFZXcGo2UTFDNGpONDdySGVyNFJIdWNDdU9XOEs0?=
 =?utf-8?B?OEVEZjdOWWlUT3NPUmY0elJ1bzVsUmFuNVpOU2U1N3hjQTA1U2JDS3NnRE8r?=
 =?utf-8?B?K2hKZzZlMGxXSysxVFlkbjlkazJPNVoyb2Irc1lCdGhMMXJaN3B0M0poZlEw?=
 =?utf-8?B?TytxcEZPaVkxNVhnVGtXQklKQWk0M1JyN052VGVUTnlLZlArUmYrSmhlRHhE?=
 =?utf-8?B?aWw4cXk3MStUYVZjWmEzNEJQN2NXWG82RHFFL0dEUWh3NVZIcnRjMk90M2gr?=
 =?utf-8?B?NUxzRkI2QktqQTVialBHZkIyT3hEc2VlZGh5Y2pEbTR4VHZ1Q1F4ZGtlaDZq?=
 =?utf-8?B?TDN6TEQzcTBETTBFR0dwM2o0c05IMnVFU2VRenFrMGgwZkhPNitQd1dYdGhQ?=
 =?utf-8?B?TWdMZlZQK2tHT2Y5RkVPS0h6b3FzUE1qVGZWSnduV1cybFMvMjlDazhFb0Yx?=
 =?utf-8?B?VlgzMS9GdktzNkgrc3R4QkhTUW1rOHZ6VktGS2FpeVJKQkdhT040am8vRzMw?=
 =?utf-8?B?U0hQNUFnOEdoMnVsdkdCRGxyMmgxRjBrRWdWbVJta0ZOQmdsNUd0ZUl4RnNY?=
 =?utf-8?B?emhBdVNQRFhBWDUvS1V0WCtHblhBRkp4QWtqYjU2NmFWTGtnRGlkSlk0ZnJq?=
 =?utf-8?B?eEd6WWR4TjZlMzcraHRLV0VvOXllSmJJVHl2bGZEdkM2VVVkR0xrOTUwdXh2?=
 =?utf-8?B?N3JGTlladFIzRTVWdXR4UEtOV3BhRktQRHNoYnlDYmZUbC9LaDUvSXd1d3pm?=
 =?utf-8?B?Vjhja3lPT29RWVJtS0d3N1dBdFhzd2puajlxbEZsRDNHNVhrRWlpY2ErS3R5?=
 =?utf-8?B?c056cGtKWGR4UjVWKzJxL2hUd1BIVU9KcHZJaVdWYmZkZ3AvanVCUWwrS3Ew?=
 =?utf-8?B?RTZ3d0trSDRmRUxjTUV6aWpER2ZuUlMvMW11UkdCZzUvN1VwOFdhRExKMit2?=
 =?utf-8?B?UGRqWlllNFo4N3B4R1Vjd0laZzljcEtKbGlCeXlha2tZdURwZ05JNlpDWGQ4?=
 =?utf-8?B?citieDZNMUdPQVJ5YkxCT1lsV3JRZ0huV3MvdzZUdlNZVmYxd2Z2ZGJEaWNH?=
 =?utf-8?B?T0ZFaFlxa3dMam9nMXphZDV1cmJyVFlxUHZpemlKVCtjYTdZMGUxZ1Q5UFhy?=
 =?utf-8?B?VjZPYk1Ec28yaGcxMGtzTTBkZUVLWjNEMytiQzNMWkFEOUVoUmZCSFdxVXpP?=
 =?utf-8?B?V25EaSs4Z1U1YnFZaG9UQm93STR2UldpYjhCOTRBeng5TXJvT3hoak93aTBo?=
 =?utf-8?B?d0JtQ3lsd3QwMzlQb1VQTlVFaUJRczc0QUg4c0VERHp2THBIdlJYdEJvdE1s?=
 =?utf-8?B?YXVWRHRFa25mbUhPNXVVZXhRcXFZeUtnUHhRUHZBTTNjd3Q1Rmx0QVVkTWtT?=
 =?utf-8?B?TCtUbDlYZXNYTTBHYktmUk1GbkdhNXNvbUJLaC8vQ2RXMG9xOTJ2REVxSlJ2?=
 =?utf-8?B?WlcxT3pvcDNzbEJyZVY0WXJNWTYrb2tPbWxLUjdIVUZNMDY2c1BrenNOa0M5?=
 =?utf-8?B?d01ObHduWUZqVG5YNng4YVJ5U1R3NTl0eGlRTFUzTjU0Zi9vcUgyMEVqcWVJ?=
 =?utf-8?B?b0VBUjZjQVVJVTM3ODQ0SzllTmtHVmhQSHBEQURqQXhmb282MGlzcUw3SWI3?=
 =?utf-8?B?MGc4UG5oU1NjWllnL1EyZXExTHJySTNvRitlcUFKbWdSY0s0RmNCdzBzZys4?=
 =?utf-8?B?RlhWR00wbkhralFCTG82disxZ3JHOTkxQ2ZObGxSdE1MR3ZkVFhoTUc1OU4x?=
 =?utf-8?B?NTkzelU0dTUwdVpIMUs2d3pNVENERDhwT2Z2clF4dFRvb3V4VDR6eHF0TG4r?=
 =?utf-8?B?TGg5cTBteVFPRk5PT2VKQ2ZLUWFZQ3dQUEU3ODNoUk5IZm5QKzJtaXNuSHI4?=
 =?utf-8?B?MGtIU3J6U3dHRThab2xMaE1IWWc2VXVWTzdMZXRpeEttNGhWcWxMK1NRN04x?=
 =?utf-8?Q?Zf/S3j2B/O8BackbrO1LdsUesW5F/A0yRo43ihtDHZBO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <696C6E387D216340A67B5726F7D7963B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82aaf63-3ab1-4bf4-6a0d-08db4045a96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 19:46:54.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1e/Gi9AWe5xxe7L4gkVp5rOHik4oXAxW67K5HgAO8nb3kDXkNr+2VqNvXyAfmESIEbeF9nr39dsq5BpQmVZrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOC8yMyAwNDo0MSwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4NCj4gVGhpcyBpcyBub3Qg
Y29ycmVjdC4gWW91IG5lZWQgdG8gdXNlIHJhZGl4X3RyZWVfbWF5YmVfcHJlbG9hZCBiZWNhdXNl
DQo+IEdGUF9OT1dBSVQgc2hvdWxkIG5vdCBibG9jayBhbmQgdGhpcyBXQVJOX09OX09OQ0UgZmxh
ZyB3aWxsIHRyaWdnZXIgaW4NCj4gcmFkaXhfdHJlZV9wcmVsb2FkOg0KPg0KPiAvKiBXYXJuIG9u
IG5vbi1zZW5zaWNhbCB1c2UuLi4gKi8NCj4gV0FSTl9PTl9PTkNFKCFnZnBmbGFnc19hbGxvd19i
bG9ja2luZyhnZnBfbWFzaykpOw0KPg0KPiBJIGFsc28gdmVyaWZpZWQgdGhpcyBsb2NhbGx5IHdp
dGggeW91ciBwYXRjaCBhbmQgd2hpbGUgZG9pbmcgYSBzaW1wbGUgZmlvDQo+IHdyaXRlIHdpdGgg
c2V0dGluZyBtZW1vcnlfYmFja2VkPTEuDQo+DQo+DQoNCnBseiBzaGFyZSB0aGUgZXhhY3QgZmlv
IGpvYiB5b3UgaGF2ZSB1c2VkIHRvIGdlbmVyYXRlIHRoaXMgZXJyb3IsDQpJIG5lZWQgYWRkIHRo
YXQgdG8gdGhlIHBhdGNoIHRlc3Rsb2cuDQoNCi1jaw0KDQoNCg==
