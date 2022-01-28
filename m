Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE1C433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiA1JIX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:08:23 -0500
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:36705
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232481AbiA1JIW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 04:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbrVqyYHc0HtgcNumkcMQm+JEpaKcnqKtt07x1u+2sNhwhF5GiwlMr/SYsIvjGJ8nFzMZDrRQTCRH20Z8vFhGEvbzoZ8jo1PCRgeQeRnOA3bAw2mJOcY3ikxHBjAlgbxgVemmBr8O1N4IA0EyPSraB60WrENew3tdeGbO2EXxXBvG4ovf/hqzckFCI0m26Z2NubsR4BombVxe+zHfn+jBSxas/34noOVSk5ils8YK5UIGNFY6hp0l4Cj9L/eyCQ/+GZF8q74IE1vpsDdz+hxPH/YV/94niENXJY3NEj/EA/HzYLHKCyklOQDiMVccC4KrNFr08++xRdEbgjVsKARww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNb67286vQXfE3HUeMSuEmzSWSPuh2lEDYMNskUzhRU=;
 b=XYy1Qev3HD5QwGQ2wSntHkEYvm5qTw0XQx2mFFTraW+JR97GqHq+0A1sCbzSNJvhKKimcRPpZSyHOBhwdQfykop+2vDLBu3fzg/mCa4mtga8zN3x89HxEDcj9Y2bo/FYToOIp2lGocqpFf2D274le1bnyur1Yxt29OhtSHyJgIuTEeX5wHlaiRDXUAdsrBnRBXiCO0yEganonD9UzEmPg+NEgZuv2N+axFsRH5m32szVtIAARO3ImhXj5wmRPz3JaW7do+q0M3ZFM2O+35gdnNcbetwgjz6f6pyJfE0E5ClW4/J1g3TmqcZeiaJDZSKbqe8tt92QCAyeJ6rS9k07PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNb67286vQXfE3HUeMSuEmzSWSPuh2lEDYMNskUzhRU=;
 b=WbjKjDTldSGR5+j+Q3eKol4StG6qAAhO3gi6FXpLP0emR0ODvWSWyfS3/XcwNfSMhryJpv/h8mtCh2rbi3/kmsP2KDcHI0FFYbwJyjIJz6j8vlpmSNU7heiPiFYzKn2acCW/NG+YFSfOmyJXzai8fa/TFmRijXYPJiHzVJVjAiZ9+ujdkuZeoMQ/a0eREgboZ/Ni2E4M1wPq0ujotLh+qhDgrPID6Iea6YB5ZJfWWrZQepY7mloOq+VMFmQIThiT+aw9PtGIyDo2lpfeHwm284q6P15FsKnw2My0/0/d7DYUAUeYrIwMGPwwH0TI4gRzVv22RK9YMmMLTjkzDLybPw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 09:08:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:08:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
CC:     Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme: add vectored-io support for user passthru
Thread-Topic: [PATCH 2/2] nvme: add vectored-io support for user passthru
Thread-Index: AQHYE12tCq8ljHi9J0immPLFxWwITqx2mf+AgABX2QCAATSbgA==
Date:   Fri, 28 Jan 2022 09:08:21 +0000
Message-ID: <d67a14f7-f703-a2f9-99a1-03d76364bde0@nvidia.com>
References: <20220127082536.7243-1-joshi.k@samsung.com>
 <CGME20220127083035epcas5p3e3760849513fb7939757f4e6678405a0@epcas5p3.samsung.com>
 <20220127082536.7243-3-joshi.k@samsung.com> <20220127092921.GB14431@lst.de>
 <CA+1E3r+tZH4AtnHduTTZenbJTzn1pC9HuDcYNaZUVX4+umyk5w@mail.gmail.com>
In-Reply-To: <CA+1E3r+tZH4AtnHduTTZenbJTzn1pC9HuDcYNaZUVX4+umyk5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6dfac2d-f5aa-4b92-db95-08d9e23dbb50
x-ms-traffictypediagnostic: DM4PR12MB5230:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5230EFAA2E96445CD38FE5A4A3229@DM4PR12MB5230.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHzDwpol5cIVsIHsojLGF6Qec15/2KVzwseGnI3lJmOBZtQbUSgp/E3J/KLYSYyaaHuQSGqke46RWuGuypm8/gMYRIihif0eFUExFwOu3IUnkQsUZYl49d4LYrb5rtlcj/79N2kaI15sYEGYOoW0ysjDP842rsDpjZRx5ejTc/bi44JVk0phmlWP9KRYCOzzLUYbbvCDwDuoPr0xd18QTngUbLM+6X4DnvOR0Qwlp86mslZ+LUgYjDHPmPrt6suZ87bTyh6kLeiGH6TBCzQrgnJg6KDlyg03DBDk5xb3uENfGlluyQspH5llQba/HYHIxmQtjvH/ZXpvripexSLU9TlD3kiRV3jf8n8ePo6wC4FmXYRij+SGeTqv10kWdavrallNKjz8VRU2vqD4jaOhzkKEw/dJ2prIJSCBHphTOnbH/717Uy8VaL75gY9xKceHNdgWaWWXFqWcvb9fqz64Oz7OJkRULNPJRZ8GFbqLmT/g7wK7LPVxqgr5lQynyg97X3cexsBaCtEqX7r/PeXPoWDlP2N4dcEXBQ7354Ixth9sNR1irZlabwA407VVG+bBmev6rI2hJouHvHa3Mh3U+6MTYh8NewHTkLhZ5Kx/HIUPrEPwSbYukzcB1dWKDHXNs+uFk9jESsgNTKiIioDiWE8PqGtENI57tuZQEHj1XMDr2B/OOacdY6r76k9clOrmx6KAj5FvGSRJRXmbJtItR9GUIjFZyLgPUmLkF52NNWrtdhs9Z4mgPTnkuUuMXmQd8mjzKtzQzUcly6gAWVPFSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(64756008)(31686004)(8676002)(8936002)(4326008)(86362001)(66556008)(71200400001)(66446008)(66476007)(66946007)(6506007)(316002)(91956017)(5660300002)(36756003)(38070700005)(6486002)(508600001)(31696002)(54906003)(110136005)(38100700002)(2906002)(6512007)(122000001)(2616005)(558084003)(26005)(186003)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWFxVzNhMytudmlkWWRLbmhNeEU0NFAxV2hLV3gwOFE4NHFXY1FvbXNCTndN?=
 =?utf-8?B?NDd1bVFTb2xGNEY0aFI3T0VqOEk4Y0w3bkoybXE2aVVnY2t4MmQ3S0ttTVJC?=
 =?utf-8?B?bkxwaEZ6cEpoOHBSZ2NnZWdZN1RaeHFWbURWaHlXRXg2Yzg5TXYyVllwRmZW?=
 =?utf-8?B?a2NrUDRwdE5YZUNhVno2ekk1U3BWcUswUWVoK2NaOW1ZTXN3KzZhblJzeFYx?=
 =?utf-8?B?Szk5MFo4cExzREhjRkN0Sisrc0s2NWdKbnBha3ZwVHdHREo5TXF4Y2J3M0VQ?=
 =?utf-8?B?Z0tYUFlVUFlSWU8wL08zaVhoZTJPSFUrcTRuZUIwcVZaRGdmNWpyWDlXanZL?=
 =?utf-8?B?bUx4ekJVdGNjM1pvT0FIN3ViclBGMmpvbTVEdlhsak5tRTZneUFGMG95M2lX?=
 =?utf-8?B?R2ErbWovb3lvMVcySEx1dVBjaGxIcHpDaThNYWxTZ1hJclBOK2thQ3FNVjVH?=
 =?utf-8?B?ME04UmEvajVyZG5qUUwwSFVXWGYzcTIyRmFSUjlZUGFyVHN0YmM3U2ExamNy?=
 =?utf-8?B?NzlkNVNkT0QrMTM1dFRzaVIwTFRIYnRxY3ozczdxZXBrTWJYQW9LL253TVRa?=
 =?utf-8?B?Zjg4ckRZbHlKd2F4cUxmZkcrWlFZem9nOXVzaFZNajBLMWRPSUxnbW9xSktW?=
 =?utf-8?B?SU1xWTNUTVZmb0hvdHhEVitSSGhUeW0vdVdja1hyVTdCZ01Oa3FEYkNxdldO?=
 =?utf-8?B?bTJkMzhndE9qNVdJbFkwMkdYQ1dZL3R1TXNteW1JQzl1am5qTyszMWIwc1No?=
 =?utf-8?B?UEpob05pUVBEOE5xa3JGbnI1b09memw3Wi9ZMk9ncXY4SndlUnowZ09VVXY0?=
 =?utf-8?B?SHdyU01ad0tzb1hCYVgvWFZlMmRhUXJmOXRybEZOcktJSE9TQ1NtaEx6NlMz?=
 =?utf-8?B?aWowVFcyL0cyaWt2SitLeTdHZ01PTjAvYWFFNmhlUWx2N1lsaUlrQWVnRmI3?=
 =?utf-8?B?RFFTcThiY2JXWXNUOVNtdnNTcHVkeThGSk5ZelpDempMUk1JeWhScXlPVVBa?=
 =?utf-8?B?dmlaVDVyQm5PR0xDRzg1ako2akp0WXVvNHE0bkh1SlRuWDFXWmFhM2pmWFha?=
 =?utf-8?B?ZGUrbkt3MVRPWE1VaWNhZzJheTZzR0pLVGNkVituZEhtYlk2UjJwNFJ2UWpy?=
 =?utf-8?B?Y0JmR3ZVRmZKT2YvRjBPYXNPeG41WjBnaVpwOS8vSnhMZmRtdzhCYjZ6clFU?=
 =?utf-8?B?Zmc5QTBDdlJxL0o4Z2hPY3A5WWVBMlRZNjNXb3BTQ3NFbU16a0NqakRFV05V?=
 =?utf-8?B?b0k4dEJlUW1Tb0lGZjlIVXh1NTBjRUk3akg3QkwyY3NWMnZhVDBRTXkwdjdm?=
 =?utf-8?B?aWRqSkFkdzlGMXR6YU9nQVY4UGEyUzlrT2M5cFAxeURoZ3BkYlhCS2lYWnRW?=
 =?utf-8?B?WEFMdUd4VTJqYkZuUXRWQnE0Z0dyYkpzajBzc0hRak03SjZZVjBLMGVHellm?=
 =?utf-8?B?SzU4K1F6Qlh5aUw4QXhySkRBdEQxSExaMDF4UXNINGZkTU4zRXFTWnc4N2Vw?=
 =?utf-8?B?Q05UemRIY1U0b29hakNCdE1ieE9ZcU9ubjNPNnJmNjhJVXpXV0NKd3FRRzl5?=
 =?utf-8?B?Um5zZFlMYTc5NFducC9iM01pYjBhQ0VNV2ozSENGSGtuclV3cG5ieTRFelpz?=
 =?utf-8?B?RlcyQldnRmtoUXVlTHI2SzJFN25uL2pJb2lwM0ZYZ2dFTC9tanRXZDFhVkFr?=
 =?utf-8?B?aE1lK0lCY3FlWnczdXl1NnpxZ1Zyd2tUTTFQRXlPb1owWGhjVFM5eUFIYjZa?=
 =?utf-8?B?UWg4Mm1KWGRqalk1eWZaRjhLVkdBUG1OMzRidGxtYzVOclViYmQ1bXBGN0hI?=
 =?utf-8?B?V0I5NUlraDFwUEdCbVJJMHliSlpzbjBpWVpuOUN1RVFmQ2ZrTDNJdWRwek1L?=
 =?utf-8?B?ekE1aG9JTyswYUNkV0FrVG81MUh0QUFCcXBlb3dHenVYZkZFL3I2N3MrNXdZ?=
 =?utf-8?B?b1Y4cUd4L2xGbm9ENG1NZW44Vm9qeXNaeitnVFVZalNtby9UWmJDMHBPQWkv?=
 =?utf-8?B?ZTZmWVNLdjJmcDVibTJRVFl4YVoyRE4rSDJ4RWh0V1F5R09MUmNZK0pIWWg4?=
 =?utf-8?B?djA2QitoYlZSWkhsOEcwNmZwVllFc0FIRXN0RE5KRkZFdWEyVmlRS284UkY5?=
 =?utf-8?B?aytGazhXcnJuZE9sTlFQRnY5eUx1ZDdLZnVCTVlpSXR6bUNya3dmb1g3RFNK?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <613B6D22F5E5AF4E9E65BB1FE0A93EEB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dfac2d-f5aa-4b92-db95-08d9e23dbb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:08:21.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCFfyI36pUQQLu2ZtG4EMMXC/XLietui0baqzCGWB4CLM1B3BRppk7GtoaB3MSIiCw9jZV+9yDCnKAG29pp9Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RmxhZ3Mgb3ZlcmxvYWRpbmcgZm9yIGEgY29tcGxldGVseSBkaWZmZXJlbnQgQUJJIGlzIGEgYmFk
IGlkZWEuDQo+PiBQbGVhc2UgYWRkIGEgc2VwYXJhdGUgaW9jdGwgaW5zdGVhZC4NCj4gDQo+IEhv
cGUgIk5WTUVfSU9DVExfSU82NF9WRUNfQ01EIiBzb3VuZHMgZmluZSBmb3IgdGhlIG5ldyBvbmU/
DQo+IA0KDQpzb3VuZHMgcmVhc29uYWJsZSB0byBtZS4uDQoNCj4gLS0NCj4gS2FuY2hhbg0KPiAN
Cg0K
