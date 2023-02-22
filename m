Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F690C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBVWK1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVWK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 17:10:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8229392BE
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 14:10:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it5l7aKp7dfTCyCWFCex4B8Auf8LTLtuk6HLomracbhZsf7ej/G6Wt0h8KcjxtofvZWsEfKpRf0/xGKhSbG/dozkGa8lsSeEX+9zwuVMrDSMn2ZVijJxC+pfiD+vdGKQVlfkKeM5/6uV56MoYcZOju9EtEwggTpvqKun9YSXIMC98bOvOON16alCtl2XFgw8sSApx3iD7fd4vBtnmOTnsILmCUbhJRBFmQZgXa7Arr8Qq7BYz6xeZFJjTxsIHBAFwU+i3wyPvwX8nKMk+LjhdP0ULA4hN/8AfPbeGyd8S+kVB7duCNI2ijirvfpjiItWmx9bEWfaH2iLC7Fat4FAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGsT5S9CmTzllV2f6tqV3qLpFIrpRTTJOrSa7PkONLM=;
 b=bHdA0t99zK3lIHFG0Idj0IZ13L6gd+l/9Pu/vu67JK5jIe71PF4rorKR523ZGUdk1zf0nWkceOFRJWxapJs6dT5JKhGJyztRREd/+N9oFJQU511LITRjoBy1SAK+GzXF6wTlWVaGzVF3Yn/Zfy/GsN+BWlkVP1yKrYUvqyhz/d6v4dAByIO/UWjYVfIL379JzD6EYTPZag3EMRM3yiEfKeJgNBHvSnIzsVv5XccB9HpsHkQ6oqdQak3ZdCFi+Q2PW+Cf4GvgBX7svNamkoDVa6wR0KChwrGtHvZt/ad+tfEGHpmY8QlBjq9mJ17AZdND0WWfmHikGXantws0aa1m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGsT5S9CmTzllV2f6tqV3qLpFIrpRTTJOrSa7PkONLM=;
 b=mxzUq1KpTRvjsLAOtLZgoMpRr0n18mB9bmRhuyDDhAkoLP3Vc9vb8h4vqywgfcKfaYVLauhp0sSddVGR5icBjAY4TTYfc4+qV3YbLhhH9bz5/hxHtCNK3ZspESWNGzbfG+FHmMywyzIRr+N2N3rZlIkyg2r2ssSIHzVFhiI61PXg1KEOiTjhCEhS+Ht1AvHn+VUp3HGRfxm00/dt4/xnQM9irXmF/CS2VK69rh20yY4QOC0Gojjua5ByTzbPX9MiTOarPyjTNY0dyLV6k8T6Jad4HiJ5eByWX+nfdEzGeYSnDFlLZnh/DYmQGA/0Hwi4kGjiFqdJ81Xa89QM14K0UA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 22:10:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6111.020; Wed, 22 Feb 2023
 22:10:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: shift with PAGE_SHIFT instead of dividing with
 PAGE_SIZE
Thread-Topic: [PATCH] block: shift with PAGE_SHIFT instead of dividing with
 PAGE_SIZE
Thread-Index: AQHZRsrZykexV+2HWkSaBhqG7PSBmq7bh1QA
Date:   Wed, 22 Feb 2023 22:10:22 +0000
Message-ID: <d9c7a08c-68f5-d426-bce8-f84a14a88984@nvidia.com>
References: <CGME20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5@eucas1p1.samsung.com>
 <20230222143443.69599-1-p.raghav@samsung.com>
In-Reply-To: <20230222143443.69599-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7216:EE_
x-ms-office365-filtering-correlation-id: c5de08ec-d229-44b2-b558-08db152197b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqvJ3Z0f90im0kkHSS2Q6A04zBiVWeobNm3U53Eh9TzzvwwDclFRyHU5pw56Fh5tbh15ge/nh/ayrhK9FQvrm3E0wFSNidhkDy++9RmBWS+Vz2FaGaqCuJJO6dWqSNMXMwz5f8l6N34ECa+rMzequTgX0XqezETPnnPqRcnVhN0dbx4lO/U5Nn9Cvx8w4g/NYO/WkYN7boLueGje23j4Ya6vbPbcyaF8QDZGbu5d+XDCxkbs3/cDCmVzDoCUumrLdber5pCXa/u3WKFnMRZ+NNv4bMC5y1BxcDK4sSiC6I0bAORvHDapLRyO/xVK5PbNuVWhtR9yZGLsgdbXCT/1nVtcyHCEfMkTKdJCAxyJJVMobb0fN8GJ7ieuNuug2/v267n/eMeM3AOFIxd+8mvQPcQz0A9jEapj3nRsSFOKoXqtTLTy2wZskmsFzVPU09owTEt5e0GHUjrWimmixabGp4T9vkG8WW5IzLZVfI5XW69r4AeJIO3PZ9ty28otXy6ookoyhK+3uNjIE26IJbWfDHBwEPZFRzV5mlKl6nzOAEwQCcY7ikaQ3EPXzH/okyTpo3axb3by/jPQvBrGDJ3GU2QzxMF+Xn2hjL1PckveCnYaFu0odmhJKeYE7zp3GBwll7VZ0wKlBi8hEQVOFtkgbOEcRyxEzt6m1TZomJAnVvWx0Zp/V1hXhSlhrS6ub+imb9kAeRgCaFiOrJXFNe4T4JRF4FL7JtaOeAN6zgfl2qW6y/JYX3DcshsC6WtbIMIlIe6sE9LvK/XtB0JRBEXdLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199018)(26005)(186003)(6512007)(8936002)(38100700002)(2906002)(122000001)(5660300002)(6506007)(4744005)(53546011)(31686004)(38070700005)(41300700001)(91956017)(66946007)(66476007)(66446008)(76116006)(66556008)(6486002)(8676002)(2616005)(4326008)(86362001)(54906003)(316002)(64756008)(6916009)(31696002)(478600001)(36756003)(71200400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cElsUmV0VDJHOGVsc3pwaWZSalhRbHJicmV2WUxXQUtkMVdtYmxPVEN4enh1?=
 =?utf-8?B?dkZFdGd4azFMbEFWTkJpWHBHQmdSbHJJd3ZFc3FVWWhpUW8wSTBnRFRGajh6?=
 =?utf-8?B?clVNU2hWKzR1dXoyRmdKR05OTXliQ1JwRU01ejMxL3FaK21EWTBjMXBTek5U?=
 =?utf-8?B?ZnZwOE9jM21OYWY0SEtoTHdoWXpmQmNGUTY5QytuSlBubENXbGx2a29YWGdu?=
 =?utf-8?B?VnhVWUZCcXUzMHdQSVpjTjVrcThWOWJ5VFRHeGlsR3k5RWtrNEsxdHd6YlBK?=
 =?utf-8?B?cWdXV3hYcCs3ZCtsYm1FVXJ4dmZhLzNBa1hLNlBZK0lXQWg2UUV6S3VSQVgw?=
 =?utf-8?B?UWhRcnBacTZ3bEg4bTBIZXVxTmZLOEVEWUhaOEtIWVZ2UFp2SmZPczRvdmJj?=
 =?utf-8?B?UDk4Uk9vZ2RsakI0RElCTE9VN2VSZEdiRVZLY0I0Ylo3VVRjckhXakxEa0xi?=
 =?utf-8?B?REdkenNwQjAvaytpVXdkMDFiNkVwYXNPekZpL0xBdGFnUzdKTDlUSWlYU2Mr?=
 =?utf-8?B?NklLS1pjakEyVmlWTWdUZlZzM1RoaVJ4L2hDRUZnQm9QRjlRNkxpRWNJM050?=
 =?utf-8?B?MFhMMVpQUEpEYWtiajZiMmd4MDYxNEJiOWtFc0lpZDZLZnlzY1piL3FUaW9m?=
 =?utf-8?B?aTM4cXVPWmJBSldYSXlUTGRZRVJRMldTcXU1YmRMTFRsY01DQVY0akgvNFox?=
 =?utf-8?B?T3ordmZDR0lXQjZxMDBGTXphSHppVExvaEVSR1I4bEVDMEZFUmkyc2R5ZDJW?=
 =?utf-8?B?cE9CVnJRdnUvbDFsTERheDN1a3RGdU9IcmxadGcxZWRYbXZReEhUQklDZ3pR?=
 =?utf-8?B?RXhyaWpXazZVMzlyWHU1M0VZVVhWZ2Y5SmNKUlk1dmRjSEY0RnBGMWhOaHhQ?=
 =?utf-8?B?akxKa0hpQ3NyVjVCVEVsUGFGLy9qUThQNnlVTlpMWUFVMktMTndVcVhtdFNC?=
 =?utf-8?B?My9yVWJJWkhDM0tudzkySjhhSzMrdjRqVDFCRFlUYXVSd3pFMVhUT05ZTGVS?=
 =?utf-8?B?YzQ1RWkweExpS1dsZVY3RGJicGN5N3hjdFdObzlHY1pNNXlmQ2loTnJrOHBD?=
 =?utf-8?B?RUFjRE9xLzlPK2JrTFE3cjM5YXRjcS9MbDVrRzJSbVg2RDY5ZnZEWDNEMVNy?=
 =?utf-8?B?VEwzR1RoYmRrK0tSaDQrRUx3NVZtVHhZTGJTZjhYOXJBMHdPRFdRLzg3cWFa?=
 =?utf-8?B?Y2FZZzZYWFdVRlprZEtlRjhWUG5Qc0RCMnhVZCtIc2pOUHR1OENpNmZyR3RL?=
 =?utf-8?B?SzVyeC9iMnF2T1NZcTIrUWN3V1JRQWl6UmlsM1ZwNStTNW9Vd0I4S2dtSVVr?=
 =?utf-8?B?b3o2SXpHOGE0WHMvMkJKUUtwTlpNclZsUENuVXdQSWU4L1V0SnFMTmVEVmE2?=
 =?utf-8?B?Tk5IMWZETnozaG8vTVoyWGFNUGpTZ3cvYkFoaWgyS3JLY0l0SXdSWUR5RFUv?=
 =?utf-8?B?a1o3RFVoSnpwbllENE5ZVHNXMkdkYUVPbEloZWZhOWx0ejE5VHNiNHFDalFT?=
 =?utf-8?B?eDR3aE9IMUNFOXNCUXVVNklTSlhqZVpGQ0I5c0xCZ1BxeElwMjlpVXR2TlFm?=
 =?utf-8?B?Qk1BZExKRGY4MC9nU0FCc0ZqN3lid0NLQUN4eDdTT3VtSTlKTVRVNy9OTUJh?=
 =?utf-8?B?SWh5Y2RTVEJxdzhIL3ZVSU14a1Rpa1gvTU0yR2VVNUpMdEk0bTNQRllZYUli?=
 =?utf-8?B?UWt3bXgxYTFaTGZsc28wT3krWlNMT3QyeE5VRU9ialpYcVdFaFpZVzZuMTl1?=
 =?utf-8?B?VGpIcDI0NHNWM0hiWlJMMDdRTzRnV3ZUWlU3T09vQUZkMHk4cFNxeWhNY2lL?=
 =?utf-8?B?WTNCUmpqS25jb3pETm04ZlkrTVNpMFFVazlHbDk1OVhIRnc3TFlTdW01bUFv?=
 =?utf-8?B?bElFY3B1T2ZSVWwxQkhFeWsvRThGVHJoT0hNRjlVVzBUMkZhWmI0aVVtWEZn?=
 =?utf-8?B?VFhMbHJ0MUdaY3p5YTlTMFg3cmQ0YlJzSDBtWXdqbElkT0dJcEw0ZHdPbDN3?=
 =?utf-8?B?OWEwSFQwUzlVUGRBaHh2RGlrMWwwZXdtSFFKbGVFWVRudjlwUHJkTHhlblgw?=
 =?utf-8?B?YjdZM3Z0YWVSajZiWXV1STNya2pxM2NZVEk0Z0hDbGZZaWcxOTYzVnozd1hk?=
 =?utf-8?Q?l4U8/CYSYF6OMZUugRVLcPIHS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42CF424BA2D3CD4AA44D83C9219C24BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5de08ec-d229-44b2-b558-08db152197b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 22:10:22.5738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgTlBK7DLy/DgjZivuagQrE5LhLJQOiCHAIT69Vz4MKIAee2HeE6HquOBLqF16Je5RRiRPQcUB9G2ypkrFc3sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yMi8yMDIzIDY6MzQgQU0sIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IE5vIGZ1bmN0aW9u
YWwgY2hhbmdlLiBEaXZpc2lvbiB3aWxsIGJlIGNvc3RseSwgZXNwZWNpYWxseSBpbiB0aGUgaG90
DQo+IHBhdGggKHBhZ2VfaXNfbWVyZ2VhYmxlKCkgYW5kIGJpb19jb3B5X3VzZXJfaW92KCkpDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogUmFnaGF2IDxwLnJhZ2hhdkBzYW1zdW5nLmNvbT4N
Cg0KDQp3aXRob3V0IGFueSBxdWFudGl0YXRpdmUgZGF0YSBwcm92aWRlZCBpbiB0aGUgY29tbWl0
IGxvZyBvbiBkaWZmZXJlbnQNCmFyY2hpdGVjdHVyZXMgaXQgaXMgaGFyZCB0byByYXRpZnkgdGhp
cyBwYXRjaC4NCg0KLWNrDQoNCg0K
