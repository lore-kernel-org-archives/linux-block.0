Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE6C433FE
	for <linux-block@archiver.kernel.org>; Sat, 15 Oct 2022 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJOAat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Oct 2022 20:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJOAas (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Oct 2022 20:30:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0942B48A6
        for <linux-block@vger.kernel.org>; Fri, 14 Oct 2022 17:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWV0Tr7jbPYtCWLpHIWas4cFCWXzH9z2+NvqVOri5saZGWtmuCwDO247L6iWnhDeLpMN/e+tJ0gWYpDY5ub/KAc7aIGv3l/WTfBmQN3Smq18EpGXbfh4s67mw2yQE+moQLwWjRXdwK6OA+bmYgPuUEF4MFTxcx8ky2O29WjqKRBZTROkAby82+mLRXbo09g0jLjfxvrXlbMq4CeyoH16dwA4jE9LtG+n92A4fPKRWZZMKV1vEwBNe2or6bNN48oXdyiV6ysDESpeRn4jcXYwBvXOf/pUqRPrmtOObAQ9cHClAUlLLuUVQ7sM39k7KfQk3B2PjT3wKoIGMw/5xkAWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve2n+8UP2xM9u8px1L9Z4QLtPmFZGkURRyrUCYWEz9I=;
 b=k/n8HgOWZ4HIPqbzgFRy/8LbfNp8EWytrdMtkltCGvj4taCSFSS3WRHbNuJ9ez+P62gZASEs5LNbveb12okNBlR+ay877D7F8z8O6LKxconZSZQoI22fxp+fVa5fuV4PkaOHYtdzlJZ+cwRUQKOsWVV6IbOOg6mF24OxIYPqK+XAnOSoQT4i1ZT+Wm5zURwam5aR/WaCYusX0iVITGO1RIaOD8Bm+0ChSNbPwTHA1Kgaz6Bbq5x0U5D0PJzjifJzzxDolBpHZlAqQj2S28COFVNeTYRJ3vlJYIslclAt7nYQDinrwVLZiUv+CygeUwIEoofguisquzriEh808TweZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve2n+8UP2xM9u8px1L9Z4QLtPmFZGkURRyrUCYWEz9I=;
 b=FJ5gYQhBl4OWMZaDOyHfWvq55Ofk3FHKVUnLDG6quMv6rbIrIzo9t0bbnFTMSRMyUTcqLLiWKIMckByq+irO2zS52BTEenvERnQGtl8koz+1oe28MPb6aT9ezpE/Qe3cD7ZYhfWHLJoo5WfX8GMxc1Ik7tNvPWGQIlwOq8RnlavZz67/ZpolH2/OnPqtY/tqEP83vwS//dwvtBDfYDgwLUpj9Vqb2sZHV3EbciW5kbDNs2z+f8VOp2jLrBqetqitudqQR8YDoAIfWNHb8iVz82jcztAaWfvZz7yCwENQL7fvD7P8emoC+dSEaPvjPnm4JSa9NiusGzDIUMwlcEiVLQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 00:30:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Sat, 15 Oct 2022
 00:30:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Chao Leng <lengchao@huawei.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
Thread-Topic: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
Thread-Index: AQHY3uh4/bADRDRv9kaOrr+lm2Kvp64MY1OAgADDw4CAAXXSAA==
Date:   Sat, 15 Oct 2022 00:30:44 +0000
Message-ID: <3bd6fc45-ed8a-32da-56c8-93edbe583649@nvidia.com>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <d83c88c8-0486-072d-a03d-d0a3a8e4387c@nvidia.com>
 <e785f247-7ae1-ef26-6dd2-d7379fc739e6@huawei.com>
In-Reply-To: <e785f247-7ae1-ef26-6dd2-d7379fc739e6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4919:EE_
x-ms-office365-filtering-correlation-id: d32b0952-1632-4728-0b42-08daae447fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IGJd90KftnCOeDUzsYwY69/qdnh46Ciy8lQRc1jVKcogW3cskVSpeF4FY35d6REjcDuzkp47i8doG11n+5nrJucvjItaAMVPnRM+3S2PsIHQTsnFCVNOnBziyh30ZICdJK2CMmbD7ViupjWqUP13deUYh2bXRGzD4rbtGGacpgee3s63kRoFXVCL/yauKoScYQl2apt3VlZpqYdJ0nJhUw/rJWXHWHtbtSVLajez+kyV/f2UZ6d0LhZhi8V/G95tRqkYQak5MNyavTFKsGuhrN1XAJGEhmtZZ48VWN82YHw2H3czatvSUuuVZEx1i5GiZ1JhRrdA2vAbxvQO/TwKIV0LXaXCaM5pwhS8DPhL3lhDVS/+AW+OGdvASUYhlcQZkHLbqCE0EC1p9t8uN5xns/b5KdE7XYkO3i2oY51zyUf98mAjbD+mnfCkn0McduqbGd7dI12Eb9O1IkSGo2rAkYw8R7NQ6ktus4n0v95BGBtxpPO4dd/q3kYtcrEG4Zd21S07B5MeseyKHotN9Rn/mHVQEn+S7RaLhrbEMkLTSp9uCFHUunFVr9/dnWt9zUy7aWEK1cUAOAPOReJ7Crr3nAsusMwsRYETDjvdxDjND60RjGV9mYLc4anmZJjMfrXp6rAJIbnTiYOautPwgm/MzWInd6E6s8n4T4XzpoZaDfGJUfOGkl25tJxDj8qZWbO29uf7mM1pCWy8CwzyDwfgimJUwVYA1E3Fv6Vf3ibqoFPsQ1hKd+UBZZyFdy6e9TKsC+czlXgU9cUokro1KCoXj8HvLly9cfH0Q1eIgTK9rMJ4lbZrdS+IpJouUNM1y7Ss1LZ4hxYO2OS1nIHBvrDvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(71200400001)(6486002)(478600001)(6916009)(54906003)(316002)(31686004)(6506007)(4326008)(66946007)(66476007)(76116006)(8676002)(66556008)(66446008)(64756008)(91956017)(6512007)(41300700001)(38070700005)(36756003)(8936002)(5660300002)(4744005)(86362001)(186003)(2906002)(2616005)(38100700002)(122000001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NENTeW51Q3pHZzdVU2l6cVNqZkVUTWcxMXNQaFdUM2NyWTVvL0dNYzRsTTNv?=
 =?utf-8?B?THpaWlNlWE92RmVXOXFaQXpVZzBxYjVDSThjN2IzaHZ5NWsrVDB6NkxvSlc4?=
 =?utf-8?B?QnZyWGxWMWVLV1RTaW9CRDFSQk40K1owZ1daVTNuREphejNaSUFNMFNTK1c3?=
 =?utf-8?B?VGZDQ0NLZEJVL1VmbVFxOWhFVVNwdEJFZ095RFRleUhpeEpxTU5pQ3FoVTJJ?=
 =?utf-8?B?RHNkMFRVeG9kWXhTdHhqTDA3Uk84cjNRUzFlaFRrL1pkRDFhRWd2VldpNXlM?=
 =?utf-8?B?dDVjSkp0RUpra2pRSWtKRlIrVmdaclJxZHQvNnVFNXFpZnBFc3AyM1hEc0ND?=
 =?utf-8?B?Q3NoaFZHVHJWZlBqa0FsQ0lEaUtIaDBQbWRYVjdjVzJYc241OTNHNnlzNnhQ?=
 =?utf-8?B?REp0RWo5WERMUTlxYU9JYThYcEpnZ1ZlMm91WndBS3VKbHVaUmVreE1TQTNO?=
 =?utf-8?B?WEJxdjkxeTFXeXB5OEJ5Rlo4NmkzdUp0K2VsYnMvTmVBWjIrNzZXQmhqSk1J?=
 =?utf-8?B?TG9lN3hYWkFRaEMxNTE3Um5ZYmJQS21aZFY1RW5VK1V0YjN5aUhkdCtqdEMx?=
 =?utf-8?B?Q3BzejN6R3VLdlVRQjlwTGwzejN4ZXV5Rm5FTE5IQmNtK3JRbXcvM091blhi?=
 =?utf-8?B?aDlQOU9qbjRjNlNkYlVVSmZSTGtLVXk0MTdTVW1sM29LdVYxT3IwRlcrV1BI?=
 =?utf-8?B?VExQeTh3dW1oTDRHTmxGbm1uNk9tN21SVjhJdmdQbVpnckYzTTZsVExnL0gv?=
 =?utf-8?B?VDdyckNlcU55cFBKNVVid2RDN1hhTUhyd3NRNHBRR1RQVnp2WWF4Y0hONmpX?=
 =?utf-8?B?NVBieGZrY3lIM25MdXpCdkllTXlvdEpUT1dtSFZEak14VytUVWpXdnVnQXgv?=
 =?utf-8?B?Y1BVK3R5ZXhhM1dOM1lPMTlTK1JPY0ZiRnQ0SU9vaVgwbjNFcVppZXFzQUxO?=
 =?utf-8?B?UGVaZjQ0cWhYbnVBenpJQVAxV2hWSWtESXNqa0cveEUxV1I0RjRTWkMyd0VU?=
 =?utf-8?B?eTJLb20rNGY1bVBBcGlsdXBycGdTSlUrN3Vtbk5pVys2QWt6VnhoQ2dEbXdF?=
 =?utf-8?B?WGY4eHJybVMyRzJVbUIyNUswWXBxMExYRXZCbFFDZHB0d3RBaitvZ0hNS1dz?=
 =?utf-8?B?eTBhbkdKOE1iSWZNK1ZFZWVDYjdKaGlyMWxWSUZobXBFRGEzSEM2dmdHY0tk?=
 =?utf-8?B?MmI3blpIU2g5TlNWSHhOZ2JkUlQraURPNDE1VG5lMGxpcFN1c2JNb0J0UDIw?=
 =?utf-8?B?MTBvNWNMcnd3OE5CVXpPRm5iZ1hzYkFSZjFVRmJKendSb2U5LzlsUnZkT0pi?=
 =?utf-8?B?VENFWlVMU0V5a2hvYmZyM21WTmlxRTI2S09yZWhybGl4L3BIckJLeFdmK3Yy?=
 =?utf-8?B?bWNGVW93a1gyNjMyeHk4akNsRFdOTnM3Q1prZzc5VFNoRGtiUnV3bnJVdEFv?=
 =?utf-8?B?MzNuajJWaFBvdHJoVzhSckFSZzVzbEZvdktVV0N3bEg3R2F3eFdSanYyNzRH?=
 =?utf-8?B?YjVRZWxXeG01a2VKdzhndnFMR1lUT3NLRlo3Y3hYODFDYU5Ocml1L0FOcUV4?=
 =?utf-8?B?VlpFblQvSHFZUWFDYUp5c0IyNzBMVkRmRFY3V2ZyUnRNTlRhN0V2MkZGdlow?=
 =?utf-8?B?TkNmbVU5dkVYUzYwNGxsa3BDOE9xb25EUzBjaS9Rb29HV0xTQThCbHI3VXpM?=
 =?utf-8?B?THZrK0dBcW8vdFBvcms5SXFuUmVYZGZUVTJoMXFOcm1OU2dMUGhvb0lBL3hE?=
 =?utf-8?B?eTg3RGVsZVJkZWRsWHVKcW56T09nQjh0ak9lSllNSC8wRkc1aDFsLzVEbFVM?=
 =?utf-8?B?UlZuYmFrU1ZXUGxKKzlkZFM0UGNMMWRsaUdobmNEalFEZm0rQ29SRlY0Mll6?=
 =?utf-8?B?am1KYUVldUMrRzBFZUU1ZlEvZ2hIZTA3Z253NTk3NzBkRVZBVlRlTXJrdnpQ?=
 =?utf-8?B?WGVHd0N5QW13Z1J1SmphRDVlVWxFaXBMMDN0cDd3TER6dkhoUFdPZWNDM1Fh?=
 =?utf-8?B?SFgrT2xYM1hpOXl2YkZGZk5jWGF0TU5kbHY1RFVLY1hkbW5ndTBHNjBqalRr?=
 =?utf-8?B?K05HRWZtemJJQ0tCS0Y3dlpPNG55N1hQc2FYdzhDM0oxcnBHQ1BLZXR3L0xp?=
 =?utf-8?B?eXlJZHVzeU1ZNlZ5ZWZGQk5BNk90anFCNUZzV1p4ejZYTm1XYStCSVZZU1ZJ?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF6BE5EC9A7A80429F5550F6B04FF68A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32b0952-1632-4728-0b42-08daae447fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 00:30:45.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btt22MhrigN82s0+DsB9oPvY49Wi1KLCvuuE32BWdTiwUdQI1NdYDn71Zx5TBmL0yHCcL6NfKFe2iq6Wmj/rYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IFRoZSB0ZXN0IHJlc3VsdDoNCj4gVGVzdCBTY2VuYXJpbzogbnZtZSBvdmVyIHJvY2Ugd2l0
aCBtdWx0aXBhdGhpbmcsIDI1NiBuYW1lc3BhY2VzDQo+IFdoZW4gc2VuZCBJL09zIHRvIGFsbCBu
YW1lc3BhY2VzLCBzaW11bGF0ZSBhIHBhdGggZmF1bHQsIHRoZSBmYWlsIG92ZXIgDQo+IHdhaXRp
bmcgdGltZQ0KPiBpcyBtb3JlIHRoYW4gMjAgc2Vjb25kcy4NCj4gQWZ0ZXIgYW5hbHlzaXMsIGl0
IHdhcyBmb3VuZCB0aGF0IHRoZSB0b3RhbCBvZiBxdWllc2NlIHdhaXRpbmcgdGltZSBmb3IgDQo+
IDI1NiBuYW1lc3BhY2UgaXMNCj4gbW9yZSB0aGFuIDIwIHNlY29uZHMuDQo+IEFmdGVyIG9wdGlt
aXphdGlvbiwgc2FtZSBzY2VuYXJpbyB0aGUgZmFpbCBvdmVyIHdhaXRpbmcgdGltZSBpcyBsZXNz
IA0KPiB0aGFuIDEgc2Vjb25kLg0KDQpJJ20gbm90IHF1ZXN0aW9uaW5nIHdoYXQgeW91IGFyZSBk
b2luZywgcGxlYXNlIGFkZCB0aGVzZSB0byB0aGUgDQpjb3Zlci1sZXR0ZXIgb3IgIHBhdGNoZXMg
Zm9yIHJlZmVyZW5jZS4NCg0KLWNrDQoNCg==
