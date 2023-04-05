Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A68C76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDESnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjDESnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 14:43:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE572E59
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 11:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVHjNIgng/F8GH6XGyBQN6sopQSMi1OaK4gcu8gdhiEaH5m5BbEO3pSePCKjwl8k5He4IR7sZ8kezmALCnxNL0XSoDaKv8azk9g/61+uQTxfaqQ0+rVlC3uSVFPN8er9DGqHcv/KXZRO26zmgAiryPcr++dvQIIdoVRnnclLdSD1cGOxTBfS1Xcefr7Kf+wy8zllxt0JyHoXgwX8tavMBHO+ZUx3S+409Cu7dJhJ70bcc8vgWiudoTldXWeqxpF1MxOxW/5dRyobxS9QpXSrHPAs7fg/0vQAemWNhtLvWp+JY5DMi7AXAChcmwcDbrTMF146dtpSQ86ZpMORXt+mzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p83k2jb5qyUnDAvF73cnE8w+WgbjCot+YTu7qN7b2ss=;
 b=H+mPWHTBIqxVni4CxFRG8M0pBq2tyhW2rUm2+nac3GZD2dBi5m5qzkD8GeCj6pIbs0+Eq7kcxYvsptaelHqgJDINMrxj8Gnkjsi7Rqqk8ggo3TVWJxSyIHo5e35MHKuARVgY+J7bmSq4yTkbGdcOTYIAy5zEdwCIYTHlcuasqWYpYfXbJEZQCFmIZcn3qykaSQaFuZG369b2jZgc0nXNTRAJxklBMGfxY9DMGr+nxCtlsxfzBnURREswDZDWU9qFkI3VF18eaB2F2UTxAlOAN0vu3CZX8lxysKYJIybv9MjjBmmX2/FHDl/5lNJg+A/x5fP4U/qzp9lEfOT44+kGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p83k2jb5qyUnDAvF73cnE8w+WgbjCot+YTu7qN7b2ss=;
 b=Cd3QSUuT7AoWGH6oaDLEdk6aqKq/uLwK412FkXi7zvSfsnyIAajfno+pa9Hjxy0sBTuzHiMl/DHzVil2zUsU+tgddTMrNuJ1hcn+aS9HFQEkfKj93pP4XfLu0XxW65SSQhgRszfyC2jOQV0mqsJraipZ0oMXzfV6/dIt8V2MSoeXLIbhMviQqv4snymKvA3GqnOz1YGeASmfHyOCM0mE3seVx6mX5c/LuAPJXBcRyvCTqwrvitYToQBKtP+xmU1Ni3Su4hiuZ+VhqfMrgvCEzKRK4keLjXMFTo9eGXCFJK9CKqukl3d/biJeenNemIlWX9B8ZRFBY0gP6Jt+1hn7WA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 18:43:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 18:43:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 3/4] nvme/rc: Add helper to wait for nvme ctrl
 state
Thread-Topic: [PATCH blktests v5 3/4] nvme/rc: Add helper to wait for nvme
 ctrl state
Thread-Index: AQHZZ9X/e2+AaXkW4EqFV398piKRf68dDTgA
Date:   Wed, 5 Apr 2023 18:43:00 +0000
Message-ID: <f4fee088-89ee-4afc-544e-2a16e703a33a@nvidia.com>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-4-dwagner@suse.de>
In-Reply-To: <20230405154630.16298-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: 26c3b50f-4eef-4f66-deb9-08db36059502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFPmojYnjpt+MiQdZWvh3F5G7xFlMT83RsNU8vD9e+/25gL6cg9PPCrzuwrOWAtHwKZT57RBNFRCJOgwDr279einkdUa/bjBYQQT2aWUilqIJ8QDK/At52scTa55F1is+fZrs39aBp03Em7WADW1RiuLQFjtbs6XHgZFNs3l0LxfPWXqAZwhMb7RAxSbO5fyw5+XW9ucutThb+kNMKNiyQp4ozdTYJfnGw6XveEZEE/znVrXGxdJ8Vb2VsLaqmoHVdpgffngEx9B61rKnHpCd5oMmsUwmAL3eS7QHEGNd4Kqzv6zsOPczsurEcMoT6gyf9bTPBTjqIq2/QEoxliIPxWfwvAr1L5IRLWhc/5aPaQe+SnvuVkQ5WSmGCwR6Nkkv/xtKcrU3l4MAXolQCu3DlOIhcTU9rGeuehqFHspuwkvWHl7NbiKYhzgI+xgyS3Lfl1IRoK6CvDFEnvvdrOIvl4HZEy2J5ZwlaI4qYobinj0gnAwDFOb/RxUaH58LPICdCShQdCPVovA9l1DWeEfbFa4u5T69Z42Vvm3rPZ9brff3enhT8iBH5bN2dNOjTRqpex8ChBIORQxC+QyhlalX8obRalkMiZFQkePGtN9DB6tI4DnlbQAfRhEbPjBAL4OYgd/QhNlLgCr6ihCA/i9DmJvOZBtNrdej6mmD2EpQCgieJ29T6eXMjIGcQ/G/xEU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(31686004)(186003)(122000001)(38100700002)(36756003)(5660300002)(8676002)(8936002)(38070700005)(66476007)(31696002)(64756008)(66946007)(86362001)(66446008)(76116006)(66556008)(4326008)(41300700001)(91956017)(4744005)(2616005)(53546011)(2906002)(54906003)(6512007)(6506007)(71200400001)(478600001)(6486002)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEJHdlF3RDdlSFBxVXBzRUZMZFBQZzZzWWZvbG4yVDJCM0xNcnhFZC9PaVlO?=
 =?utf-8?B?eUI4VmFYeERyaVZjdDAzN1J6cEd3YnhDaEhySkJrUmFXNlFOYkRWMEM2Z3RW?=
 =?utf-8?B?TUJ1aTFsczdkY2E3aXhRcWYxWUlRKys2Q0xad2dJR01hRUJ2clQreVBBT0Fl?=
 =?utf-8?B?VXg2c1JISlhJeHEyWVFYNW5YaFUzWk5YMzZzb0oxQzNFKzZBRExaM2pTWUV4?=
 =?utf-8?B?UXFOM2RIZmRpRFpuNmE3MStYYVd4SzFnTUlKY0tCcmdMbGFGbFordklLcjVs?=
 =?utf-8?B?TStJbVVuMjl1Rm45OW1qb0dOQ2QreFIxU0EyeU0xZ2IwMzBWUThZWmNTUGVi?=
 =?utf-8?B?VXArWTNFWlFUc1pXMzcxd1JId0lyUXoyTXlPbWlkK1A5UEFzWE5WTm9ZSnZx?=
 =?utf-8?B?a0RnNGtTMVhnTE1YRlZFZ1VLNk9IbW1ZYytyQWQ0Z3ExdVRmNHVsN3k2OEdO?=
 =?utf-8?B?ZFlIc1R4Z2lvMG5BUyt6WmlrOUhrdkovTGQ2anBWK1ovNjJweFlvQ0RpTnBW?=
 =?utf-8?B?L2MxczV3ZU11c2w2ZXJ0ei9jcDNEQ2p0ZjkwR3BwS3FRQ1RvV0x4aFQxK1Jv?=
 =?utf-8?B?Qlg3aU9CNnRlc21YVVdjRnFiRmJKb3lkYmk3cGhmRm13MzQ4WVQzQTFNa1dm?=
 =?utf-8?B?eGR6eWZDd3FPbmVPMnZyVkxKUlU1eWpaR00zRzkrZm16dldCTmFaMXNMbkxO?=
 =?utf-8?B?c01nRGR4ODFodmMvZ0NxbjkzWEZwUUJwY1A1U2xVU2NuUDVnT3h2QnpQNk8y?=
 =?utf-8?B?R1hrcDJWTVhzSjA2RDMyU3FQeFQvaWEyM1JoREFkZDVSNHRaRjJpL05tU2N6?=
 =?utf-8?B?U0xNaDJZTWlkQllVN09QMGhlU0NlajFacTEwN3pFWXpmVGppUGlhYW9iNkRX?=
 =?utf-8?B?b2hVL2JFWk1rQ0VnOFB6T09qZ2FkOFB0UGdhYWI1RStIczdJVlQ2T0I2cEw5?=
 =?utf-8?B?TkNuMUpFTUFtUXdqaVM0aFBzOWhSWFBISGE3eGZYdjlLOXVDUG5VejNvVGtB?=
 =?utf-8?B?S2g0aEljZnJJT1E5R2Y1Qk1wd0dsY1c2Z1B0ODVGb0wvZDFQaFl1aEsyb1Fx?=
 =?utf-8?B?SDFPSXJVbmpmSWtEYm8ramYwQkJXS1ZIZWZoRExnbjRuV1BwUnVXNXdSU0tW?=
 =?utf-8?B?QlBWdnFhWDFsNkFqdUNvZVZOQU9KMWE5WW9sZkhWbDY0K3V6YnFqUUZuNFpE?=
 =?utf-8?B?VzdlS3hCdE42THluY3lzRVB6VmJLKzV2RXU0Y0MwczYyWTVteDlDQjJvendy?=
 =?utf-8?B?OWQzanloR0JKQUhKT00wcUpVakVlQnRwcVIyTWw0eVFlaEV0Szl6Y2ZEWWtX?=
 =?utf-8?B?L3NpVUIyNGN5cHUwQk9PTjNPQUdhMWd1WXFwNXVTWVFhbk5XRjhhNXc3endU?=
 =?utf-8?B?QnVDazdpOWQwME1pZHAxTlc2d1BqM1JYWjA2dThSZ2lBZlVyeGszOElnTU5R?=
 =?utf-8?B?NUltckczdDkyZ1JScjhyUWZnYUtyQittOEZuc3NjdEpqckpWUVpsUTJDb2ZE?=
 =?utf-8?B?NFkwaDM4YTdRTjVGL3lDSFJUUWVzQUVyMmNjQnc4VGlSZTZicmdlbXM0YVVr?=
 =?utf-8?B?VUt1NmlGcHllVS9tcGtYcUlUVUc4YVNiR2lSTTREdHB2ZDkwcm9GMHJsVGFF?=
 =?utf-8?B?dHoyU1lOQ1VPMGdWSGtEQzdmUG5FUmJ0NmM2Mi9sYlprLzd0Yjc5L1VjamIv?=
 =?utf-8?B?UEFJS3dtKzN6cDVCTGtZMk53SFZFUTRiZzNnRkZJK2xkcWJNcjF6SWtOVFR5?=
 =?utf-8?B?a1psbm16TEFwdW1mMzZsZUVOR2YrMkswUVNidjVIZnFlSUF2aXN4N0dZZlZK?=
 =?utf-8?B?Z2g5Ti8xeFBINWI0Y1ZmZGQ3dFF5RUhsMDluaWE1bTQrdFVKMEdhdTllTDFX?=
 =?utf-8?B?S25EbzRjRzNSSlZWU1k0aS9WZTFYdlpvVzlicDd6ZmRKbHQzT3E1YlN6L1J3?=
 =?utf-8?B?cXZPQWlaZTZSL2tWRmFiSUdKTllPNGF6aTcyYlVxb0tIS0VXY2ZNOTRXUkxu?=
 =?utf-8?B?Ri9oSGZNQW8vVnd2Y3BWWnJJcTZVbTRlR3J3QkE2S1B6RnB6L0pDM21uVXlv?=
 =?utf-8?B?UzRTeE5tTUJrV0FSZ21aSzhHMTJkOWkyZUVaRmM4L1JDd2hRMm5lOG8vOGVZ?=
 =?utf-8?B?QVk1UDZEbis1bWN4QmVmakpadzdMTmV0bFUvd3c0bFp0S1d6L00zakllbzU2?=
 =?utf-8?Q?r0BO/npppHiUAJwNJGRk9ZOJ3IRZNy0uj6FghtSZKV9q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA576BA98C59F74C86BAFF761DEBD923@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c3b50f-4eef-4f66-deb9-08db36059502
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 18:43:00.5469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyDVmxbBIjsI7UMB4x54eXDm5EICBVFo6hgOcnhpznrnSxxNY6tGNth1u38X0AT5QwdxeZiRfmPx3Mb3+Fb/wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC81LzIzIDA4OjQ2LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBUaGUgZnVuY3Rpb24gd2Fp
dHMgdW50aWwgaXQgc2VlcyBhIGdpdmVuIHN0YXRlIChvciB0aW1lb3V0cykuDQo+IFVuZm9ydHVu
YXRlbHksIHdlIGNhbid0IHVzZSAvc3lzL2NsYXNzL252bWUvbnZtZSVkIGJlY2F1c2UgdGhpcyBz
eW1saW5rDQo+IHdpbGwgYmUgcmVtb3ZlZCBpZiB0aGUgY29udHJvbGxlciBpcyBnb2luZyB0aHJv
dWdoIHJlc2V0dGluZyBzdGF0ZS4gVGh1cw0KPiB1c2UgdGhlIHJlYWwgbnZtZSVkIGRpcmVjdGx5
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+
IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
