Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFD9C28D13
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 01:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiHWBJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiHWBJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 21:09:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4457E04
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 18:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dspeYv5ou4ie8Rqz/uelwxrSNU3rd1fTEXmIe6vFNit67/CO+T1XturFgvclXVToZGE//LoalU1VMuCgY9XtfvTKcOYrkF8+Bxo8seQiY2xqis7ws+oRDbp2hh9BjU6Gnqw7X8anN51PAB7TK8vV95dAs+DMHTno5xYYnWqE49zU3zNbP0vaVphXe6SnW/+ljO6CtAjM0EJm3GZsiBWIzfln6H/M0ehh95ZAeNzizDfq5JzOmjsFNwOH9MeWF1Pst5ckpIIzcVRCEfH7Rms1hoZQx35vcu24JNznP/Uza+oMR5hrDctZWA6QbN4zXtp/T7ZqSLpMkd8pzVPcDHjtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXOo6B40u1MxZI+PEpex9coljv45clwPmYPWyuYgqAg=;
 b=cfAQvswwFbZJIb/P9wIl3yrn6LykvQWPwvPkJec3ZNJ4FIlHPgTC5JPamNKm8MuTJPyNR737TZP4BByPXcLM4oUauDMw6m4v2fKwrCgJFSsBV90HafThRdLig+nN7LdRhv8m+9uWNnQrX9udMY4NnAfs0hzr6uS6SpcRA+G920a/R+PoqeiHIh45/zZGyEHxhhiZ9/pKeTrRTfmoxgj2ARxtkI6yb0qhUOxM+NgWbWsBmFCL5wfOmZEbcWRcTTQFZlLLZDwtQEP2ASCrGX7tbhypK7vwLXamm+Y40bibF3oh9weF91bkPudyv/kWykRtAIjxwt7BsU/SUPZ1EFKZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXOo6B40u1MxZI+PEpex9coljv45clwPmYPWyuYgqAg=;
 b=LxNjhmULw3IuCdHBYiV/6YZYucvS/1wAj3da8Ta4ljagjNO7EaSGI6XGBqETiwkFN+q3dHWlcB8DPqOI+lMrgPnmF3kvpXDkObWwVJ2iAQKeWnq/N/67ujqUVyIPqjxOvoyVaS8oevEXoPravfpP2z3qG8uDMwc1rHU7MQtWZTJRnROc4UdVx8bFpEQ0fYmJT5yBo5SndmnPCeYbrfgY4vbtvdjq8bS1u4WfJ5vRCQ46bMRgh4/Hh709WNsEFNGDhp5by1Doz/Nj8Ys1IcZyyOoo6WK3H1ByCCRt0yMrAQzlilLOvIfdErO2AmDJfQIREqBSasBe2VQb5u7MpkFReg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 01:09:51 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5525.019; Tue, 23 Aug 2022
 01:09:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] rnbd-srv: remove rnbd_dev_{open,close}
Thread-Topic: [PATCH 3/4] rnbd-srv: remove rnbd_dev_{open,close}
Thread-Index: AQHYte8c/2ks3cjeLEWDe5TcVbD2vq27rjmA
Date:   Tue, 23 Aug 2022 01:09:51 +0000
Message-ID: <47bc1744-0246-8ac7-c32d-531112fb4cfa@nvidia.com>
References: <20220822061745.152010-1-hch@lst.de>
 <20220822061745.152010-4-hch@lst.de>
In-Reply-To: <20220822061745.152010-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b309fd-07c6-49c8-9f9a-08da84a42e9d
x-ms-traffictypediagnostic: BN7PR12MB2708:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPIDKzkBCFw1/n+ImeMcbUyYoMBehP6UFwSgasGcx450+pXYgwaqXXCSwvsQHxxve6/Wk/+Biwky7PqNULqGXYGT5L6p/myB9bJ1l+M0W4sQ1+IBZgOCZ33jLX0d1T+N8oQ0JXkU52mdVUFbbew1hrlMY8bFUIU9+idvMWd3mfN3wtzNAhI3Sp4iZAhAu+k0SOI7AdNLBVNnznS1EMybYzlmsF0iQC57INqtCK5Nfu6dqF3t6uqHcMje/Q1zLpp7U1LDYfqeJvjFvWHWsB/cedvfmwzofJxIeEIsMX1g9BmFDF24WrRv6XJYXL9NRZb9S0THNqJIIUZekg46BnIeR8fpu7r7CW3pCyj/lo0bE/5ClApepEG7Kn95eQphhy/gJpy8zqtDg22CZSUXI5AY0q7kCqX1Zik0pifabDOJp0Ajm5ElOByCY8X/8A7buARnrG088H5O1uvjIwEJqju0abUcd34vZkTxGvrCtXI/qFThxRzLwimzSoAcwEJir5TjWAQrLpmi36sgGKmDJ9CzoSpPu/13YtaTcr2HJb0lC8Y1mmd3nxtAYJkUn7Irqy1leVZW765TsoZFbe6b0uCS3hQlGvifPQa9Jqs6XVLEm25EwZbZwoWvN0hUQ/bGAyv7vFS4Me0NfiTwxGcDGAw/zLOvES91Ru/2oejH/Z89/TRi9YsbVNBWNw8saz8846BryXytUvIs0O6+mbKc0HDUaxRdsAyHNJWYUgXNkvoCRm6ciQjQN18W8RLwGZ/9OG0VAcDBlljYk1SRe+rWG3/VvEvQl7wg2Iq4W7c9Q2zQ+PriUTNB/B0P2uYzMYOIlgr1h7IFEuP3Cz7J+cfP/t1lhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(66556008)(66446008)(66476007)(64756008)(6512007)(4326008)(5660300002)(41300700001)(6486002)(66946007)(6506007)(186003)(86362001)(2616005)(558084003)(91956017)(478600001)(8676002)(2906002)(8936002)(38100700002)(38070700005)(53546011)(122000001)(110136005)(76116006)(71200400001)(316002)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDB0dFpMMEVMUFhXOE9uSnd6TXdrRjczazY5dDlISnZXdE5TZjUzdVFMRmI2?=
 =?utf-8?B?QjFEQzVOV0VKSiswZjh3RXo0VlhzM1EybmRkK1lJT0JjVnBrTklhYW9TVnZs?=
 =?utf-8?B?OVVXUlVmaElJSEMrdFU3N3kveEZpWWhqOG9vdVBqaDlKZFJwYU9aM2Z0R2xZ?=
 =?utf-8?B?YVluM1ZQa0t2bm5oRVRjMVlRLytMUHNMRnFtN1VBeHhFU1NmckFGeHBGdjJF?=
 =?utf-8?B?ZCsvRDN4NVZPM0JlNkJyMDU2MmlyQlc4bGxCMUJuZjk0dkM3cHg0cmMrYzhO?=
 =?utf-8?B?N3BRblZwbWkvYmVheURYRE5NMVk2QjB3MEZoM3dSMms5bVJKTGt6Z2xkYlVS?=
 =?utf-8?B?azBGMURYYUhPby9PNHc2dWR4ekMyNkpBblhKZGpFZm4waTNxSkMrK3ZTSDRC?=
 =?utf-8?B?TU85SFNPT3l1bjgyL2hCRVk4d2pqUkYwNkp2R0Rkb1JidVpTMVlGY2QzQnNY?=
 =?utf-8?B?R2Nrb1VyK0ZGa1Y2WGJhcEI1U1hVcSswc0d1NlduMVNhai92cWh6bmdUY2pT?=
 =?utf-8?B?aEdWNGVqeHhwbkZjUE5neDhLWlZES2pyb2dQaHZZUWd6dkdSaDk1UzJSMC9G?=
 =?utf-8?B?UC9Od0Rmc1h2THhGMDZXL3Q3RjZ3bXpqZ0NPQ1FudVdhUllabXdVY2I0ZHMw?=
 =?utf-8?B?aWtVdnQ3REVlZ1d0d3RISjNxc0QxbGJtQ1F5WWRuVksrSWwyNlpRcnlkQ21r?=
 =?utf-8?B?ZlFuKzFwR2tLSXFlMldzdVZ3SGRBUXR4RVExZGFRTEpHWm1sZk1CM0Q2dkF4?=
 =?utf-8?B?azRNR3RiV0VJOTZZcGVXSHorY1NnTFgzNzJFaEE1Zm05TEtrQU1Ba0xGR0Nx?=
 =?utf-8?B?ZnBqTGgwVWxsZWZxZU8yZ3Z5L1RyZ0drZk5yMWdMR2xpTEFVRi82R213dFlk?=
 =?utf-8?B?VnZSc1Z3WnFIcmdDZlVqUW1iTE5WVjRrVnFRQ2Ewb0VWaXlnNlJKV0prRGJN?=
 =?utf-8?B?a0hWYVJObXpJS1g4M1F2WWlVR3d3clpBaWhXbDUxR1F5d0dzam0raERnZ3pp?=
 =?utf-8?B?RWxXOUJUMUxpTGRqa0s4azJIL3N4aGwyYTQ5Qmx6Y0FHeGU3YmhuNUZpdXl2?=
 =?utf-8?B?dWxtNkFiR1Vya0hzeU0waEZoV0Y0MG5IN3ZkblptYWdpTmlCanRBTzYzVkFN?=
 =?utf-8?B?M2dLbDVRWGZkQ3Z0dWUzS1I1WENsQ2FHeFNWRDZSdlljZHFUMEoyNnhFUWVO?=
 =?utf-8?B?TytuMm5jeHAvVFg0RmFUdDdhdHZmRXhlNFR5ZUV2TzRYWUEwV1M4V2cybjNH?=
 =?utf-8?B?Wm5ONytMcHNieFVLeVZFVWljV0tBaWt3bStrV2dwREVubytkY0VzMjEvVm5M?=
 =?utf-8?B?aFduY3IzWWtEeTVFUUpzRHV0YUxrd1VielB1VmxId3JNdlh0NmhTU2h3L3A0?=
 =?utf-8?B?ZnVySldrdmdQd0twRGU4eGYxYzRENGREZkRsVmlMblQyTEJPeXR2MUVxVSs4?=
 =?utf-8?B?a01JZzE1SzRZOFNnSzNCaGxUTEY0R0tkeGh0bjRPbkJ1NExOZ0kwcTM5elhv?=
 =?utf-8?B?OTZNVldBMFFQYWwyMGRwU1BqbllSR3Jxa25LdUh0YjdQSlZhSWhtenJFb2Q5?=
 =?utf-8?B?a2ZFVFE0ZzA2Q3BQNCthR0lFd2FhSnJPUElpdEhtSDlYN3AzSy96Z1FhNU43?=
 =?utf-8?B?TmVvb1pTOWlzL3JqUzFOeXdqenQyMDh3SXdGTEVYbVRuc1duRnVieGMyd1Zm?=
 =?utf-8?B?QjJoNkZyQmRxZ2ZmT0I4Q2hvU3QzU25hU2d1V3dBTzZ6UHd2UkMwSnZOL3J1?=
 =?utf-8?B?OGhzdG5mMURZQjZvaVVqUzJLcnZiZk1DUlpPek9wbml3Sy9DR1F0WXJpNC9U?=
 =?utf-8?B?bE1ES1h1MVRNVjdNTlVCdkRwWXdSdlczMjhSUTVpK3g3aWRqQ0NpQ1Zqd3p0?=
 =?utf-8?B?NjZIZlZJQ0ZmV0xNdzdYS2pER0RFMUM1Y2JZYTMyL011c2h5QmhuczFSa2pS?=
 =?utf-8?B?Yk9uS3g1dDBSaXFET0JNb2ZFYzRSZ3RPWkZpS3BnNG1hYXJtMkkveTc2TDBt?=
 =?utf-8?B?N2Q5eWoxTUE5NmRPT1Bxajk5elRYRWpYdlZrSUp0RVFYMEc0RGlIMGd2MkdJ?=
 =?utf-8?B?MWZaNVc5NHZSc2dlcEpsY2toYW9xOWtMWWZZN3J4anZtZUwzQ2IrOXh2a0Q2?=
 =?utf-8?B?dUVKQ2cwUStsb0tKUEpVSnR0UXE1ai9BaFJQcjVxRkh1V0E5UWpsK2lIV3hK?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A11F02C984CAAE4DB7F0A5089131E19F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b309fd-07c6-49c8-9f9a-08da84a42e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:09:51.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvnJgtnAcUQAl5CTC3w/IxLKjvO8dOVKgQB0LEkbk842fMKdjvqFZNkVHTqYxK7sjG2j79/TkhwvLpaNJ4KpmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8yMS8yMiAyMzoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZXNlIGNhbiBi
ZSB0cml2aWFsbHkgb3BlbiBjb2RlZCBpbiB0aGUgY2FsbGVycy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
