Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19626C28D13
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 01:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiHWBJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiHWBJX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 21:09:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F54DB75
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 18:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl8ErtnvygZldhpln9JpfUDR5nUuVZQTC6VpaJ2rBFTCZAUDz4mHFW1gVlrLaI6Dh8/+kMQCan+2TBMpc6a9U9C6BI4o3R0LAk8NOYmkcgoffe3cuRFPGS4zD9fQi+7FoMGJOpAxazsmZzFduk3MpseCN4Jl/0vpOA5XT9I/BZeIQ2elmWc7u8uJZ2ZcxaiwaT4YK3meimKWxWElpKzW3cRHlo797ed/AST2++CefJkwlt5Vvz50M63XGIgDkeC1slnQDr/y+HIFzv54yH34ecVCdYqKhwtm/YVHV9eEO1DQsyhiM1TZv1fww4gP7jzPmMTyO3N7BD8PYG+AyWG+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd6H7/Xjpx9x/0/wttxy2krZ/0jddrlolAaLrVoNvfk=;
 b=YvRpoeijjgQCJk8SHU2NtR6TdWzg5OG6M3biigJotlHd/4tNdqjz/nHix3W5LxS2htd6FucaF17CeUdr8/cC2Vj/uvnxlpBD7Jemzt3Q4Lhr/YWHsKNHppexxGoq4ILExF11MW/RCIJ5TATlVH4hIOWeKKJFtuzh6lxSlHOyS5jUIfNOLhEfTzr01wA6Rk8oLBDYTUOKkNHO+JGV4A90GN6GS0kAwSU0JrMVi98l47SiwFYUrGTbJkoq5H41w1MyVuzbQ4EpS4ZAODPmWUh9sa0wxosAxBmtc+fywPf0kpmtUDZ/nlKxaO4jrqfj+00PDz1+ju50SEMXeYfHxLKjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd6H7/Xjpx9x/0/wttxy2krZ/0jddrlolAaLrVoNvfk=;
 b=QuBZkXPanPyyg/nDnjT1/fOdl999mP+04FvDJsVRH9hyEeWwKNt/xn6p6UU9JEoNVK16Th7Y5FscB7KSuQzQpsXjsfan0VRKO7vUFTAJzG4+Sf0nlvr0tjYZdBylgSOqs0Sfwazrt3fgHNdVMeB+P88iZga7aX0g7/s2o+MsJF7m39aBR43efjvDwE0FoNMdyR/P7gua9R9FTh2CXuXYMF9I/4mpJVVL3bWLaUaTdhmCmWCcHnwzphE1Xwu5yGBVf2bEVQUumr2fE8WNogDxzjecLaz5c6P7Ha27pcelMAasMYMV9+nq8Bd6+QN7mXM+u95EaY+r9wpVLOMKNt7OYA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 01:09:21 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5525.019; Tue, 23 Aug 2022
 01:09:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] rnbd-srv: remove rnbd_endio
Thread-Topic: [PATCH 2/4] rnbd-srv: remove rnbd_endio
Thread-Index: AQHYte8bgW/LxnlkNUuW0f8hmMIyTK27rhKA
Date:   Tue, 23 Aug 2022 01:09:20 +0000
Message-ID: <a0f347ee-4523-d101-5e1d-7ec7a2c2ced6@nvidia.com>
References: <20220822061745.152010-1-hch@lst.de>
 <20220822061745.152010-3-hch@lst.de>
In-Reply-To: <20220822061745.152010-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4083384e-3a10-4a39-7303-08da84a41bb8
x-ms-traffictypediagnostic: BN7PR12MB2708:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+nM/OxVnkvKY5eiarFIZSEfZzxKzACd2cf7rqFR8LsXI0fXvSh8KGDh9XwFTWqcQ8fsLLRsju1ZEpRfKapJ01YDHi/Bsjco5mPWJPfq7mQVsAJQT3sJSWoyy5FcyB5JXH3fq4AEwB2VJDtOeMXfn7HTiMCGoaJJGZ9zHizav+F0sh/ytyyhlYK8qbW/O+SKSB/Qb1XAZgoR/kB2aswo8whGbpRpVLFAGzOpwuNFruWQTgBbRixqgNHHNn+fIRUk5sxiuWnJrDNJkTgTsazTvbGqcHsGqdA5hAx/OnSVVC6Eo5aNxwKTNju5Dtq9jq6W2/yyn7ifYzRA/smntb+0b8iUgCmiSMDgd94OS0gHwvz+In0FHr4h9Oi95KrDPE/vrVUtS5+XVMQ8+rXt+Rd8HMRXNLXJsYXymwVnV+VRMAkxu6nR9H9YoFwdsVYZZlLcAJ156CvH+KJKEl6LV4FkvwKKNll+YxCVikhYV6xASvupFoxydmFPN0pVsxqGLn4YYd4ofsGq/H9TXs+m7u0e12RZ3ByZ8yiv3qaYzL1dkn/CG2I06jXRkMp5bOpp0LSl58zZkbu7jqedBq3nTQKxDl2xekv4RpQBeIWzSlLZqDFHJ209OjXbx0HF5GxFbGBczaJ5ig9QFfMTPCdVTXpcgxHMyGTmFU/ahHBzmGZ5IrANMqxjvYe8Zp+xyv8DePCbAzbMhRVuw1/vKCuUEriIiampkSnCepkcuYUnrPU2MIdqtGJcSdVEzSygpV7bwc+7i0/It4FuPtlgRIlfz3P0x0037Q8LCXUj1ipLUL1KneFKJD4lo0wvyvzlz/NEUONTmdkz594Ho6tNkLEwgC5Cjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(66556008)(66446008)(66476007)(64756008)(6512007)(4326008)(5660300002)(41300700001)(6486002)(66946007)(6506007)(186003)(86362001)(2616005)(558084003)(91956017)(478600001)(8676002)(2906002)(8936002)(38100700002)(38070700005)(53546011)(122000001)(110136005)(76116006)(71200400001)(316002)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVQ3MFlqYzdzRGtHcGdmMmxzbjlTbkZQeDEwZFJQb0ZoTHNkcm1wRXh4d2Z0?=
 =?utf-8?B?M3NrU2VQVHBGcTlXWnZVTUE5MzQvL3FQZ2JydHRmNlViY3l5OUNTYWVRRldL?=
 =?utf-8?B?d0pnRTJKdDZlaWxuOFVqTzI1STkxRy82cFhrakVmc2l1azNaY0owK0NacC9U?=
 =?utf-8?B?RUpWVzY3UDArdUpkSCtYRUpOZEdHYVlkV3J3dmViRzdzNWowRXdLVytQYXh4?=
 =?utf-8?B?eE5lUWRJeGx4SVlZZXJxcVVRM3huM3JvamZGRlpFaHZaTFlMbXdvTkMyMERJ?=
 =?utf-8?B?ZlI5eGpjSnZZSFQwNHZhVit5ejJmRGY4THI0NmJCTHkwejlQTVJsQnFKNjdI?=
 =?utf-8?B?L1ZlK2JWd242cENEZVhMODI2RmFld3g1N1FQLzFDUEpsbUh6ZWpLcWpxMXc5?=
 =?utf-8?B?endLdHprTHVJZ2h1cDJEU2UxTmlta1Y1dzRGVDhtRjA4L0RRNWR2YjdhWk1j?=
 =?utf-8?B?UThpUWU4Z2ZpeUtwNXdsNTFVUFRyQ2V6UWtreUwxM0V6SHFRWDlRcXVTbUw4?=
 =?utf-8?B?bGZiQkN4TXVVMmw0Vm5mTU9MOGtyTjhtbklFRkprVFdVWUU1dEloRDA3dXBa?=
 =?utf-8?B?bzIwaUo4eFJveVlmbHBTZUdIcURESG9GRy96c09vZldaNWI1R3dSeWs5MGkz?=
 =?utf-8?B?V3ZyQzB0d3piOFVKcFEvK3loeHVXY3oxVm9iT1ZKSjY5aHdMYXZTYzVJY2ll?=
 =?utf-8?B?TjMvYlV4NXhCLzh1NzNkL0NQakdJY0VDanRsbmJicXlzVEJudDNIV1JnQlVj?=
 =?utf-8?B?NnNITk1UQk1JMGo0ZTlKaHBJZ3JMMzljNk04UXRVK25VRHFpNVVtVjRrcW4v?=
 =?utf-8?B?Z1JwSXNDeHBLcHU5V2JkT3VERDk5ZVFlUEswQzhjUHNWbnRIYXhEQzNqaFM1?=
 =?utf-8?B?VjZVdjEzWEU1czdXNXZDc0IrTW5kdVh3TnJNMGwxd3JubmNaRDZRTEYwNW5l?=
 =?utf-8?B?R044UWpLSlhDVCt4bjdQa0xIcURnMTRBZnZSeDJXbUQ3NjdUWmhOaXRMNVRv?=
 =?utf-8?B?bUIzdzFqblBRV1B6dllYS05MWlh1WGxUZVNHa3EwVHF2dThvTzNZRG1SVHdO?=
 =?utf-8?B?SzVRYm1wSkpPODg5dEdUS04zcDQzSmFPTWxaN1pvUEFIZ1NRNUlvcWlNL0o0?=
 =?utf-8?B?dk9wdDlWM2RSTG0rd29WNEJYOFpGLzBldnpwTVJBQzFCSkZLQ1VJenNMYk9p?=
 =?utf-8?B?R1BWRlpRdU0yL1BPTFUwd05wVXdOdGRCdWp5dk1OTkJHMjBNRk5YUWFHV0Vn?=
 =?utf-8?B?cTI1Zm1DUnl3YnIvSU1FMy81MUN6Z2dudlhrR3pyaldsVXVMM2YvT1k5V3dh?=
 =?utf-8?B?ajBFbzBFZkZOL2dMVVNJbEc2dTFzZVpsTWFoZ01mREF4S2loNFNQR0ZLNHVl?=
 =?utf-8?B?VTU2QkRSQkVLTkpZaEk5REVia0NlelAyWUY3WW9kOUdxSktQdGcvVCtBaTZx?=
 =?utf-8?B?MzNKNjJmWmlFQVZIN3VwL25NVWlYaUMvTTQ0enBxUkRQbXE4b1FuT0swT1R4?=
 =?utf-8?B?UFJIejRjbk01c2RoOE5VLzZuUVhweVhjLzdydEFtQlhVeFVzVTFsaWJnNHNr?=
 =?utf-8?B?aHRoZndNd29Lc0sxOHhJbUhVTmZTR3RoNVRuSnAvQVg1QWNpOWxFbXBWVWJF?=
 =?utf-8?B?S1c4QVdsQ2pXbkZjYzBYV1BUYTVWWnNPU0NpUWMzZHFCbERvZldsNUpTeDFa?=
 =?utf-8?B?UVlQKzBwN2FZakhhaXhRYmRQL3JnU2dDV2lXT1RiaTI1dHBxYnpFZE1ZRmh3?=
 =?utf-8?B?WFUyc1lwV1pQMExhZnEyczFqdWFMaTVIZm9FMVNuTkduWitRdXJyQ0tzY2kr?=
 =?utf-8?B?cUhTeWJnekowWEFTZVMyZlc0NVlQVmhxTHYyWU90bWxwS0VsTUhSakNxbDN4?=
 =?utf-8?B?YmhaUVA1di9VM0Z1czFtNlNQV0hWbFJJeDdmdXRZYmtyVzVZLzJJK0RCeDFH?=
 =?utf-8?B?aGJJejRKcDhnTVdBa3YvZy84dWlFMWJzZW8xMzJoZnQra0F4UGU5OE4zMkk3?=
 =?utf-8?B?Y1hrUXRzSkVSbE0vTmxSRmRRMGFVY25wTUZsNXROMDVnTnZlZUJkWFhVemNi?=
 =?utf-8?B?b2xYQ1RlSzN2aE42OXR3d2pZcS9TNnN4RytHaWxFR2VJY1JRa0s4YmI1Z2NI?=
 =?utf-8?B?QkpqNE9oVTR1WWFvR1dCM0R6MUJYVW5DQmE0NEdzSmw3dHpHMW5MZlN6SEQy?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D21A107BD56BB47BAA72EDC1340B8C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4083384e-3a10-4a39-7303-08da84a41bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:09:20.0297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEHZwlIIfjtVWYKuurFY2HlLZorYEWKqYdJZFNtUfQuQ5aB+ZKEAOSILYwU2w16whkLDYH3iU4rhmsmtPDi9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8yMS8yMiAyMzoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEZvbGQgcm5iZF9l
bmRpbyBpbnRvIHRoZSBvbmx5IGNhbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
