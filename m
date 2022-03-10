Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C888FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 01:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiCJB7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiCJB7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 20:59:00 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE5FE414
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 17:57:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk556SW7YsiAlwCRzg+XNfUWX+0F68WeLHQAUSpeRtfEevJN335MczFVorySDJZYcRgh4PupSvbeEnVf/plQDIBqwZPMf40FiXMDkziPrWUMUhzkA7gXtzI+fjfhgeFDVFsaSpUjt1zexxUpJ+aSbP3VWnr537mQwrZuXfy24HLhw8aw8eY31DDc3bWhTlV0fob1zHvq819+DRpZGBk6LbrdtSk7+j94PQESpZG0Msw/XdvS2bELYPAmbtM0matkOcHn88ugA0q5HNCxo2jY4hm/wsijl8p+XUphcBcnR0NuV6+GZDkyP4el0l9hJfyIDcVxi08LqfsYWZNASRQUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvrgOTqO3ngHgacxyy0NawC7p1NY+6IyZICi7zMOqu0=;
 b=ltCctWd23+DZZO1QsGgoLlaOsD6IkrKkDqr24USkL/y6snQVGws3QCLIiI2YFbS193iG7mp+xtQlvu9Z9tkqFWhPSWADjpoacNNwGZUbQewDmzAmOlcEZKyHk9JgonUxVpMgws+36EXk/Gt2dN8CwioISDXPvOHAkPdJSQH+V+UPvqs+NUIs7Tnsbnc/i3cN27CzXl7AdMXI9ARyGdHOs+4laV13SbErV8A4lyvdkksdqO6kPXCctsBx5JIXjmg9qMrINv6OyiNy8+B4E+d5zIL2rNUDc2XC1i90rCVnXhz260pTZVvoWdPStvMk+iLVmqNTQtJxIZcR/ijZ8tsrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvrgOTqO3ngHgacxyy0NawC7p1NY+6IyZICi7zMOqu0=;
 b=evAYZOKocmQLhsipfIOllbn3E2FGMARzNGZ2CClIABKc3uSGSclPygAtDJg/5VSAHiIM3j+K6S3GPhltRP10LEI6KdPVJj3gFTeUvajuHuyX9gvi9f+d3axpmYhf9MuscUBU9Ovx9uLp/nspM2zcqqz74icV3eyMqV0dpZWO30lcAuKdFP0BKz1lIMew/kDwl9nf7/Q030H0QSZwWMYr7PCPuf8QSPmTVudY47lUSsLx39Sxld5s1TYPd7FsMAZxcgYtVwI4B1pPfmdtuV0QWEOo/j+Ku3T5QVBjHtrCX68A2udTipIl51UuG686Q+/iH2rQZ/fF8OE38afc6gZOOQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 01:57:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 01:57:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Thread-Topic: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Thread-Index: AQHYNAFuVF+H/2N9n0qCSm+TSOS4bay3tZsAgAAm5wA=
Date:   Thu, 10 Mar 2022 01:57:56 +0000
Message-ID: <78d45c05-2e9d-47e8-89db-331553acd433@nvidia.com>
References: <20220309220222.20931-1-kch@nvidia.com>
 <20220309220222.20931-2-kch@nvidia.com>
 <1dd210d4-a3d7-30d4-341a-d7b308679008@opensource.wdc.com>
In-Reply-To: <1dd210d4-a3d7-30d4-341a-d7b308679008@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ace16e9e-6f2c-4c72-e9fa-08da02396576
x-ms-traffictypediagnostic: MN2PR12MB3949:EE_
x-microsoft-antispam-prvs: <MN2PR12MB39493E9702DE601906496F68A30B9@MN2PR12MB3949.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3GyLtbjY959y2pwybemkyC6acjdkiTcuMfurpUYbQjk9P4DuXiX6hexWIjLruOFmVmv5mm5TQdHxhY1eoc0nf6Y8fdwCJIVG9WDJxEBAihZYGoYJO14ls5WMV/LfGeGrrv36eNe5CNAh2UUgxvcsJU2pkRxqAOGz/3KAWxDf21dnBrbtMdzeG9+C6UR1WjkYoFT7orBuTTQdcWw4dk5rFf8CHcBM1cmkZykkT4l66WnBOXbAaI8gEnnAnNTslrnAD2qVLk8mK4SKrFL/y3aYNt8BPU4O3NAxiL2u4PeMKv8pbpAqv0mVnD1542qjJ+p8t/QEtCrxzQPgBPtorR4fSqN3bhUUtn9CvdWO5boMHtVKBfWghRidoki6SCCDs79woRA7cb+qTU9cxmcPTxLv110xLRN1g/wHDlQTEnO0hyf9jFKjCKMSWJvPosRCBk3OXPvWMD07iGWM0UK9+5acgq2yphQ+2VCjgE/E21Co3AGDPUpfUJ0KdeOK8NEjDpDha52+4SfL65kNOeVur4P1TNx4w8qI55WZNTGq1oa0R4ww87hMkn91jSdyaHlbyvHL8QwpYObeZlVHs78IJOuTeOJ2FKUWkOUuOWsHy8Xh99dyZYoDVmAqB9ljDUn24+e+CmHd0nInnH5WYY+YFKX3ZWtHBrnhQb0RGm3uygJk+nJQUNQZWmav/F3XFFEr/MSL/O4+MPwwxIlHnAKX7gHs8iG/dHsQe+fmZWCB7FapEDgxW7/fcZcyeuOblVJJVXHHfx99oCLDdF7cmmHL8cHnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(38100700002)(8936002)(316002)(86362001)(31696002)(2616005)(186003)(4744005)(38070700005)(54906003)(2906002)(83380400001)(36756003)(53546011)(6512007)(6506007)(71200400001)(8676002)(4326008)(66556008)(91956017)(76116006)(31686004)(64756008)(66446008)(66476007)(66946007)(122000001)(5660300002)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek1hYmRlMjlWS2o3WVdYMkhqZEFqQzVVUHRNSk13bm1QL2RkcmpHemFxWG85?=
 =?utf-8?B?Y0hnU0JKamZSM1pPdlVuZVR2L3A0ZFQ5WUtOSjhtUWt3QzZ6V20zNUhzZ2l4?=
 =?utf-8?B?NGE4Z2JESjZXdXBTQUs3QWdrVnduUDFoZk9qYnlUL2I2NTVKZ3RmdThRd3E0?=
 =?utf-8?B?RjlQcFVveE14MWdDcHJRb05mcUxKNUhLd2x4T0p5NUxGT2xHNzUreHdWZmxE?=
 =?utf-8?B?aU4yL21RVEt6NEU0NklTS1NPU1ppNm1rZ2w4ZHQ0WDFvUXVUZWFwbEZzc01J?=
 =?utf-8?B?VmpURWxTUVl6Skk5VWZJcUJ1VHBJc3M5QWFsbUFkeklpZCs1WDVPd3R5bzlK?=
 =?utf-8?B?Tm9LZlQzQ2gwUGEyZ2JoUEtQMHBXMmdHOTdWUXB4RFd4QnlEZnVmTUtnL3hC?=
 =?utf-8?B?MWloR2tkSU45TjhwcEJGYk5rREJYNlZnQzkyaDhtdjRpdGxIbDkyUnF6cDRw?=
 =?utf-8?B?N1lvbzg5Yy82VzlDdXVjWTduZ3hyRE5Da1RSbVBFV1RRVFNtYzB0dkNjdDUr?=
 =?utf-8?B?WndueXVqTmVWaEIrQnlkZXYybEx4ZUpNeCtFWVJ3Q3hqWFZINytIODRIQUZU?=
 =?utf-8?B?YWRDZkRqdTFnck5ZZ1QvN3dvNmtzdDMvNllMYU9rSzllb1Q3Zk9hbHNaazJM?=
 =?utf-8?B?U1Q3N1JvdDZYbndtZ2NBWHNOWEFzeXl5RHVEMUdWQldXNmZxUWwxbit5ZUxj?=
 =?utf-8?B?bzFxbi9Fa2JxVWZiTXRzeUV0aXJyWjdsU1lQdVB3WnRIVGYvMTdGRSswM3p6?=
 =?utf-8?B?UFFDdFA2aW1ySU9XNXZySVhYN3IwQzZxM0oyMUF0Ri80dCtpc1ExYks4elpn?=
 =?utf-8?B?QSt1b00zZWNZS1NlUDlQTDU3SGVWa3N6NkltVmxlNHNDRXRIRDRRL3ByN21K?=
 =?utf-8?B?SGYwMzkvSitJSlV2cld2dzlycWowWVdxTU5jTTI4ZVl1LytNYVU5aG12TVAr?=
 =?utf-8?B?aFpPdFlqMzBRZ1pQeldGdnlnZ3N5SXppdG9OVHNDZnVvSlFQdlVWMFJyeldh?=
 =?utf-8?B?eWludm9oSldTWXR3Z1d4S3BGZDVEMEQ0Y2NqR0s1dTJXNlBidVJBR2tFekpY?=
 =?utf-8?B?U2FBeXBubVczSURhaCs1ZWZyUnQ5NVVlMmFrRFZQNi85aHB2bTkyaTFiQUhu?=
 =?utf-8?B?ZVZleHFRdzM5b0pzOEJvWjkwRnYvZzVMRzNnMVR6M3Z5K21CdThpblQ2WlFY?=
 =?utf-8?B?a1dESTJLYnBUb0lKdldkVC9jM1VhcVYzRG5HWWdpWUhGU0pndFR0N1EwenhP?=
 =?utf-8?B?bzBFYmlJRE1FaytLYkNlSEQxYWsydnVyVWJvNnBSNHZkUWRLdlB0N2tkVE4z?=
 =?utf-8?B?TFdmWmFZRElTc2FvVW82cUYvcm13MVhVUWdHWkFhTDJGZ1RUSmp4OTRydWxl?=
 =?utf-8?B?Q3BwK2hneGNETCtUVXhnTURCak40Um41VmtpZjlYOWNZbnVwSzF5cUFpMERK?=
 =?utf-8?B?WFM4MVZQa3lINkFKMVNzY2R3RkNsajk5azcxU1lTK0FZLzI0OUllNDVnK0xz?=
 =?utf-8?B?REY2RWhPaEo0K3g3ODVNaW45S0VvcnlEaktjNEtuZ0t0RVpjVVdWdzdhMnZy?=
 =?utf-8?B?c0xxdk9xT2QzZ2ZtVnJ4V1EvSTBTdWNGalBYdWdYS1VDc0Z3Qk9iVmRGSEwz?=
 =?utf-8?B?a0EwZlZMN3lZRy9uRmZXNHp6TExZZ3hkR1NVdzM5TWt1WnJlNjZpSGRGMmV6?=
 =?utf-8?B?cTY2a2VpVnYyYmtWQjdtTXRSZUxHRjdhSkRIOWxsMDAvNlFLZHEvdEl3RytX?=
 =?utf-8?B?ZzQ5Vk9SNytJN0pWbHJ4UE5BaU1MRWRxSzFFRjBjbEtGM2NlUjNGTGJ1TXQv?=
 =?utf-8?B?QUVxcklCR21tYUROVkVmQnhQS0dDdWlrUFBjYVJRVVd4a09FcE0zckMxS01D?=
 =?utf-8?B?UE9NVDZDTlhWemJsL1R2MmR1SjRTWUlyZVA4ODYrb0RrOHp3RzBQNzY4dFRy?=
 =?utf-8?B?UmFyUk1hWG9SRWFUUlMxcHhnMG5SUE9LSXFZVlJ0SGlQTkRqZ1pIS09vQTdY?=
 =?utf-8?B?K0NuNXQ5MmM5VldyZ05tK3MwczVuTW45OURrOFk2bWVPOWpwWGl2OWE5Ykli?=
 =?utf-8?B?d1VJLzJmcUNjbEFFcWZaYm9LQnFTVVc4L2l4QTE4bE9VVFlDNkhRcHZQVXQr?=
 =?utf-8?B?NVNiUXlyOUZWUDd6VjdNWHp2aDk1b1dObzRtMEFkY2p6Szk0ZFEra0NidHdI?=
 =?utf-8?B?VTA1RU9TYXkvWmRIYloxeWJaSlpWUW9pd2o2YUt5WWM5a3VYMjFROEd4cjF5?=
 =?utf-8?B?eUxIMS82OElYamtSdXFCZENBczBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <931EC9FD3658E5419B96360B8C176509@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace16e9e-6f2c-4c72-e9fa-08da02396576
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 01:57:56.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuBAENmbMvNSoSqMaOxBQOGEQoEd3LadUSrXXJKPw6tXjdOKHn/FtCre9ICFsSaEwy3Ad9HPMfZVL2aqbMxJgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy85LzIyIDE1OjM4LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gT24gMy8xMC8yMiAwNzow
MiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KDQpbLi5dDQoNCj4+IEBAIC0yMDQ0LDcgKzIw
NDQsNyBAQCBzdGF0aWMgaW50IG51bGxfYWRkX2RldihzdHJ1Y3QgbnVsbGJfZGV2aWNlICpkZXYp
DQo+PiAgIAlibGtfcXVldWVfZmxhZ19jbGVhcihRVUVVRV9GTEFHX0FERF9SQU5ET00sIG51bGxi
LT5xKTsNCj4+ICAgDQo+PiAgIAltdXRleF9sb2NrKCZsb2NrKTsNCj4+IC0JbnVsbGItPmluZGV4
ID0gaWRhX3NpbXBsZV9nZXQoJm51bGxiX2luZGV4ZXMsIDAsIDAsIEdGUF9LRVJORUwpOw0KPj4g
KwludWxsYi0+aW5kZXggPSBpZGFfYWxsb2MoJm51bGxiX2luZGV4ZXMsIEdGUF9LRVJORUwpOw0K
PiANCj4gRG8gd2UgbmVlZCBlcnJvciBjaGVjayBoZXJlID8gTm90IGVudGlyZWx5IHN1cmUgaWYg
aWRhX2ZyZWUoKSB0b2xlcmF0ZXMNCj4gYmVpbmcgcGFzc2VkIGEgZmFpbGVkIGlkYV9hbGxvYygp
IG51bGxiX2luZGV4ZXMuLi4gQSBxdWljayBsb29rIGF0DQo+IGlkYV9mcmVlKCkgZG9lcyBub3Qg
c2hvdyBhbnl0aGluZyBvYnZpb3VzLCBzbyBpdCBtYXkgYmUgd29ydGggY2hlY2tpbmcNCj4gaW4g
ZGV0YWlsLg0KPiANCg0KR29vZCBwb2ludCwgYnV0IG9yaWdpbmFsIGNvZGUgZG9lc24ndCBoYXZl
IGVycm9yIGNoZWNraW5nLCB0aGlzIHBhdGNoDQpldmVudHVhbGx5IGVuZHMgdXAgY2FsbGluZyBz
YW1lIGZ1bmN0aW9uIHdoYXQgb3JpZ2luYWwgY29kZSB3YXMgZG9pbmcuDQoNClNpbmNlIHRoaXMg
aXMganVzdCBhIHJlcGxhY2VtZW50IHBhdGNoIHNob3VsZCB3ZSBhZGQgYSAybmQgcGF0Y2ggb24g
dGhlDQp0b3Agb2YgdGhpcyBmb3IgZXJyb3IgaGFuZGxpbmcgPyBvciB5b3UgcHJlZmVyIHRvIGhh
dmUgaXQgaW4gdGhlIHNhbWUNCm9uZSA/DQoNCi1jaw0KDQoNCg==
