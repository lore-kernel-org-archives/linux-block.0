Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272D4C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 01:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCVBqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCVBqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 21:46:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49112570BB
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 18:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tobz2mJeffcYxl2wL2Sc7adeU0XbokbPrRWFP9GJp4M7eIAI03ZQAIOuIeRiJwNX6DzS9Zu2pMP4beQ7R6ap+AsjRVI2CBn9SIPoQOPncjsGkn76D9jcW+uR8kWS5dlAFrAU3xBT3/6CVm4i+Ss78MtZaY92TMbfGBu5+EFUGHCcLr7vNswxhL2zGI2GNjVT1DOKjDEqRyT6RBHbbrRCvBVSuwuTYJhDvDArGq8rnNUH1rEq3OlfsFl++gnZDNKuIJKtJSzCvQLOGhM4HmDV/wzuXVktv1GjTGKTktsF9EpDzltpUKWpVjbek9Lwz/UdkX/IkdJQop0qnhzrpS9/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhhcPXbWYPF9uINUaa/brfb0HLYcVwS4Ga0oTdK+0No=;
 b=Eww4hy9vjOvao57BC3Y4mIWcpkc9oGorFihuq/oooX+6JuYExmmsr0SH9bL+9ffrdzHUOnlwf6Rnvbl8pXmvxJnYbVGuwXGqZixvEePuE0FVadphvr4FflXoq0aa/ItOeKwzSbMXTMVAKtZRIgG7ZVkrYd005szvVa6VwyLDWQp1kn08HRGVc6AtPSueK3M8VHMIKWppOz5nyFCC4+eDrMagzKrq9Kj1uwjsQK7Q3UlxN/AiAyDj7/BzDTBZXGSk5/9YW0Qs0HPzzD/03e/zNshEwP2cDLP+YJDgJlqqA1KQX3g2lvR0rEaPavzkHA4cWeZe0h3hrA3ApmYF5balfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhhcPXbWYPF9uINUaa/brfb0HLYcVwS4Ga0oTdK+0No=;
 b=mqpXZ4Vh2yzRHPtxEjAUbxhJaSwRd+TMDVLxM/qPiAE++XsOa2bDvAEnpcbNwep3BKlSZWEooUFGOPK60ADiRyYLJZ75zxiKhn9mqjzdquPQxbrKcBkIPR1m2SrH61pDgqUwBEzbFAZ0xbZCsyfU2m02OebNND/BTVZZOxoOILaE0ecoJzBS9O4c0yRCnsEVHnrZzAm0nIwBUcs1UpV9A8Y2vZHG9uVzYuJ+BAkF8+N3qY2QXcKfXOb0kMpEWjUg8ah9u12zYo8KIGhT6wmQQTWXudw2LOR592qPHUXAIbwYUOk+Mo4dtOsrzVGokJ36MqxzSBjLEAQvWc2suAEhgQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:46:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:46:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@meta.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Thread-Topic: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Thread-Index: AQHZXFSja8nh4LSOHU25kfI3pxk+E68GB6CA
Date:   Wed, 22 Mar 2023 01:46:40 +0000
Message-ID: <b1cab83f-e277-2516-31b5-338c1f16a2bf@nvidia.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-2-kbusch@meta.com>
In-Reply-To: <20230322002350.4038048-2-kbusch@meta.com>
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
x-ms-office365-filtering-correlation-id: 773e1c16-f772-4f57-392b-08db2a77481a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrRcuSVFz9YYh+H7kloFqRWGRkbrsNurMYcP3wJnVgDQy4YfO683HnLA1SZd+8D0DDffZ4d4VPfkuvwiFpYWF+44se/dD0sDoNfIUW4zh6l0svQdQWwUZNuoywvzuclXDnp8RSPE2O8MJVrqvLfqO8u5is6U5zu8Qq8ZjsMsR652USnbK+vjH/k8VA0l3/wDlaTycbHIB9ni17T1qeRAFGARZry1o6uATHN0QaVppoK42DwiTQjT1jn+o8++cS8BWLOE6a2MWphafUTEWGIFnIgwKU0M0hjyvV7lzSY1VeAQqIC3t0YVa5jn/6dXwokXaoo8l3O8QJ2VCg4gx8O+zYvEmmDDsHewVwvCiPJL95KHo4LsfhIK3KqLg9sDfu3dH0+syTJm3gCw1LLCGa2waoDQasxXWWH8mSAdJAVy5MLp5na3mPZ8uKG0UBWT4aDpqrdeDummbKm8nzn89ov4Fn0+houYB9ApL5hl+tFLmIc9tm3V1z8uCgCOfJ7tN2ygf4nYC3Skp6BY7Q2/e2cBEfWlR0D4VSc9s5kKu2hymCcwcxIuuYD526Mft25SQoKYvI3B3A5c+I7PhKjzvREAR/CXDLvGVaSrd8h9V7SnWEA2oNhdTuYwtHj2aLHhgIwX57yBpOpeZWLMcHoGNMYiVhBPRJJxGbnHrVeY3vvbVWYwpGN4r1wr+BmYHRlKQBjkb/x9pgEHg+ZefPk5n7NTrQ2mbBweYQLHg6Q65y0p42WP0nxg3IOeivUGNeLj3du17qV/OMN0SFMHd239HLYXkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(5660300002)(8936002)(41300700001)(86362001)(558084003)(38070700005)(31696002)(36756003)(38100700002)(2906002)(122000001)(4326008)(6486002)(478600001)(2616005)(71200400001)(186003)(6512007)(6506007)(26005)(53546011)(31686004)(110136005)(66476007)(91956017)(316002)(8676002)(66946007)(66556008)(76116006)(64756008)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzBuK1JUWnkwSGh2Z3VOaVFDYWdiWkVKMTNFLytMRFZTeWlSeUo2b1NhamxE?=
 =?utf-8?B?d0JZT2dUTkxkSll6SkJvMXhPTWRIQ21GRnRJNnpvV1huNzhac3hYZjg5d1FE?=
 =?utf-8?B?SVFkaSthNU1ockpHcXBHSm4yZk5aMVB3ekp2dWhCWjVQQm1rditiSFQ5aFBr?=
 =?utf-8?B?NWg5UUdOV1hDZVp1YTVyMWxXMjhCbFNFVXFKWTBEMHlCVnR5aFVwQUhzbWpF?=
 =?utf-8?B?Qi9OdVhKWmk2SFRUQmRMS05UeXZtK2Rmd1JFbGdkQTFiTzluaG9EMzhiRmoy?=
 =?utf-8?B?YTI1bnBrVWEzQW42ZlJLdmFkYnA5c0QvK2xiNVhmOFlYdmNFVnR1R2s3SGVE?=
 =?utf-8?B?Q0VzKy9lbmEyaTBKOGxvcUVNT3FRVjkvWFB1T0hyUi9DRHdzVkNBSStFSlRm?=
 =?utf-8?B?V1dTbU8vS0kycGZEU0wzOHNYWFpOcWN5dHB6RzlSUitqemJXVDVockpqNkcr?=
 =?utf-8?B?Mk91cFdPMGgxaTVPbDJYS0ttbndWOC9nWTZuTmtBbUJvdGV6Ujhnb3B3eWJq?=
 =?utf-8?B?dTZod1kwMTY4Zy9ReDdGMndJUFEzMzdjSmJTdmJxV285bWl1cmc3UFkyQ29U?=
 =?utf-8?B?R2FFaW9mZ2h0ZVJuWTZuMWRBQk43b3JXY1FNcnA4MzZKM3lTUVdhbGxmVjJX?=
 =?utf-8?B?dGgxM3lMWTAvSnJHK0sxakpMbkdLMXR2OU1FVGtpcEo1dGxZUW1XWmJNREVI?=
 =?utf-8?B?WUdpMnhGRXhRdXN6L3NPcldmOTFnQ2QyMmhJTUpYaHVpSDBidGxYWHViOTd4?=
 =?utf-8?B?ZlJramlzeUpCY2pLU2ZyWmJnR3BvYnpnNlhtWlVLa1FIM0NXekE3R0RUb3FN?=
 =?utf-8?B?TU9TZUprdTFrSU1YeW1LV3RVZzV0bDYrc1p0YjFVSm03Ni9qSVJrSFBmUlVu?=
 =?utf-8?B?ekFkYWl3NTErVkVMOUxRUlFITlJjcjNDZFFUNjFxOHBldmtmQ21HRmgvMUlH?=
 =?utf-8?B?N1lNWnVNZE1WQk5PM2dIc09XNmZ0a0ZmdmgwWmE3K0o5R3dPNWYzVkt6THh5?=
 =?utf-8?B?K0xVajdWUzl4bXl0YllhSkI1MW5LVVBnc2J1dWs4MkhMeStROVZSR3had0M5?=
 =?utf-8?B?L00xRHp5QldFY3ZjYWdBQjRvcnpSbVZVT1NJd0F3YTlMTzdpRHBkT2g4OFlv?=
 =?utf-8?B?WTNiYndhQUhGZ3hGekFBT2VqeFUwbmZwNEpkVUw0UitxU0t0VXBTZjdKdHNN?=
 =?utf-8?B?WFJMSjY4RG9ndnpaOE1jRDRLNG44SFlyeFc3MWZhdnhYMzlOQmh2aURYRTlz?=
 =?utf-8?B?NWI4elpQM0oyQjRvbzEzSHduOFFBM2djRXUxUGpadmdrTkhzTUZ0YzJEZmh3?=
 =?utf-8?B?alhaMEhZOThKNEN6bGtOZ2p3RGU3TXppaXBmWCtrYVRyM3hNS2xGY1RiVVkx?=
 =?utf-8?B?K3lMVGtuWXNzelpNemY3bTdLTk8xOW9jTXpzVzF6cy81WThqSFVOV2xiM01n?=
 =?utf-8?B?Tld3OUdsSnZWY3YyRGpuV3M5WEdINldJeC9oUzFyODJ1YzJrbzVCVjVDazd5?=
 =?utf-8?B?R1FMWHFsa1BsWmg0V0tTdzZlcnQrZVZDajdxOGw0MzFHQ1d4U0wwNFg0MkJP?=
 =?utf-8?B?Y2ZoRUh1c3J1LzArSC93aDdVeGJ0NTdUSG9GaGVsd25rdnJFemxOcWRkekov?=
 =?utf-8?B?YXRJR2QrT0Q2MkNZWjNMZnRHbDFpaGQxQ2dxSnJ1eDRlcGU0YVJVUjZoUGoy?=
 =?utf-8?B?ckhDMTVrejkxQ3NYWVVvdTh0SHZQeHNZL281M29pWVM2MFhzRUVvbmxGZERL?=
 =?utf-8?B?amZUVUdESGFBVWU3RjFrZjV6b1JubGhUMFBYYUpLLzhNeVVxSDV0TU9udm1y?=
 =?utf-8?B?dTB4cTZBVXpIQjQ0Z01paHRweFJjalBDcVZCczJMNXZhWnJrTkhFVE5jWElW?=
 =?utf-8?B?b3NRNWRzbWl0VFBwSVJiaVlCYWs4bHd2WFh2TXhscG1DUGJzck91TzYwTGlh?=
 =?utf-8?B?bUdoWVhDNm5sdi9tcE5ITG0yaUNYNjRVdmtIYXBRd1J1YVN2UW9hYnRzYXNS?=
 =?utf-8?B?YWw4UmxqcDZvNDUxU3lTWFpFckdObTlHRlN2c3I1OENlTDVSOFZ0ZlNiOHNp?=
 =?utf-8?B?MGMyREc2ZEFWUDAyd1JZYm9jOUFEWkVJem96UnN0V0xDZ1VUd09Vdmhaa0x3?=
 =?utf-8?Q?FzzPjGZZ87qJ2az6QOCia2jle?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95045AB13AC72B45AB9FE32BC2B99C03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773e1c16-f772-4f57-392b-08db2a77481a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:46:40.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23nBKwAPjbrAmPGbt7hIIL4vApFXCKHxhQ5GXbfIHLU7cVxYP8fILuRzCU8ZKhGkA8A4icHOlRfXZrHzald0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMS8yMDIzIDU6MjMgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBC
dXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IA0KPiB0Y3AgYW5kIHJkbWEgdHJhbnNwb3J0cyBo
YXZlIGxvdHMgb2YgZHVwbGljYXRlIGNvZGUgc2V0dGluZyB1cCB0aGUNCj4gZGlmZmVyZW50IHF1
ZXVlIG1hcHBpbmdzLiBBZGQgY29tbW9uIGhlbHBlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBL
ZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQpMR1RNLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
