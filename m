Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388C0C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 05:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCVFXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 01:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCVFW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 01:22:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136BD5B5FB
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 22:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjFgoqie63b1vVcChInV+DKMaW5GDvykWE9Py1vMnbNQWXB0QQxxsvdRK8fTxHW8K+C/16Sk/Nnls0nYBNF5hhe4He4FjF51xabbo4x9+TTYAs18/0DILtrqG31ZUb0Upif0zCTfXXU+L2EsKKyKVNm8gmTkpyMJoxyoEiKObDz8vfuuG0uAAmEBfWETQvYLCSJk2zHuUO+/rbxoNQC9kgren5AhtEUyHRP6CT5E20paTYL19UwFReC+cP6LreyjmOeOg8r/dAALI5mOJLDUHObQTayjr+LMBCoLBTIo/9VmPwyYEWA2selMGoRj9NxfQ5Na6ZsrdHawj0qjwKrFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=punKiliuIw/LhhQw4pppTMMxK0H9Cz4Zrn99LHSDzTE=;
 b=lAjlI5cg6mnb/ca7wNebojxjwKasWqRshaTBLP01TEx5fQgxKupMSyTebVc2Om3GVsp+esfLJ2w9pMlq+TBwDzr1gQLEIXj2HMp7g8oNWK5xtPm5zOz4QkF7s7CyK7mE/e9jZSLWlVxekDcbS7I8YhXbsVMiPbunWT0SF0ZOBLD0UA0uIqhLhqKcHzBUqrCkxIqz/nMH1+bX4Oy1Uuk+ei1y9LRSgRWJZ77qBLAti6zZTueF8VDBv/WHsojLKt5pW1cCThv8qv/zJ2UCUDRyvvR3jRCaJQ3t6oZ30QCA1XXSIu5QDqg//T2gfe2HBzEGY2FIdIZi8kNUCsZOQ3unfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=punKiliuIw/LhhQw4pppTMMxK0H9Cz4Zrn99LHSDzTE=;
 b=acp/LDKRJxQy5E6pNBEcb4fgRVbXuOaXfeEA78No4a8PFYAj8/g7sxRnYP7P3PujcVG7vmIhokXQclNehW0I9UsaCk2sSlrU79A6Ax1J4o1xvQ0U00GqJLyzxR3TDuJMZR9axyRCSNzlnKv3TQhGDUpguRrv50XTJdYLghIBFLtdGmnYwxpmPKKQ6tNhNICUndwIWP4zGUkVCJc2NtD5tBbXaW76BDMhpWGqYc0neY5SGdHZe2U+nly4tl4//Rw6cxS0dWvOfP4DVBok3j/xakkm6hLal5m5At4a3hsUfdeQjDfonF+ngPDgYARPMa4vsz2v1Ewg57f0dSzjVjB7Vg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:21:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:21:53 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@meta.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Thread-Topic: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Thread-Index: AQHZXFSja8nh4LSOHU25kfI3pxk+E68GN6OAgAAMHwA=
Date:   Wed, 22 Mar 2023 05:21:52 +0000
Message-ID: <e7b41c8f-018e-8c6d-e1a1-aa8aa92d79e2@nvidia.com>
References: <20230322002350.4038048-2-kbusch@meta.com>
 <202303221244.KMWQNHnu-lkp@intel.com>
In-Reply-To: <202303221244.KMWQNHnu-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5899:EE_
x-ms-office365-filtering-correlation-id: a5c68a22-cc56-4fe9-2b10-08db2a9558af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJtYNL/7mnOj6JZ5NU6XWVt4Jfe3p8wWdaO7L31ZBtWrbQBE3wyf8NBq9T52Yg3rzpAfdi8WjQb6emvmA6nE6rV1uhdO7icq5RrcCdG1D6LODl4+VmMMZbyxD5zE/OlSD2h0uDWqRh/051ucgYSvHYOYSdbdPnv8DgArto/eDmCXF+/l0Db2cH1NNHB4gxqbxFUWbOxm1wkuQ6pdqFXykDfes+1jGCgNznYbnMRuuevkDthi7eKc/JwNKgRYzkiLtl6o1BvVdC9lMmAJkzBLHb3av6Qg0oAc7WEitXPXzC9ekx2ew+Q9Kl2w/EkzsexoNpQkLLgMYNLRvM6euQNy3OYTCTyDID2dT6goqQZ27ri/B9HNZK9mw/DspJmOQomMm/XtcG1M2B5DUdlFavDOD+/QuinEuDdrJFncczCGLQscxWzZDcklN3ECPsIwuS/49LUYFSGTTiINDXMbe3EnyMJxFQ20yYMZcZXPEMneszm+8tLoqPsHxcdlqH/S7B5kU5+pPRhU0FVGhVYEVaEnwJai0k1zbW3IfsDeBvu5j4QOipqWaLZRQM8BnXsf6qxPDCXhQlhp9MSS1X5gDshgf2lVQR/Exrg57wv56qcqBY8ffQI+WpDhNO09fdmciChckwJji2nFje5sS68j1jmx4Hnu1vD8gguErf5EdKAQUlVEXIxcLcJCuwbE//9xo34fR0ZMF28w2Q2FCWsNQd5E3VJFZCxXbaZDWJw0KfWTcfAy8MqLEzKpT6mOXy3Oay9XUzeGckD9LGHy/t8IliKgQSpaOUskc3RqhszRqYV2u+WNkKE53Xk0R4K9aIZtAKuG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199018)(38100700002)(66946007)(91956017)(122000001)(31686004)(66476007)(64756008)(4326008)(316002)(66556008)(8676002)(66446008)(41300700001)(110136005)(76116006)(478600001)(6486002)(31696002)(5660300002)(4744005)(8936002)(38070700005)(86362001)(2906002)(966005)(83380400001)(186003)(53546011)(71200400001)(6506007)(36756003)(6512007)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtMYlM2OURCakh0TnJPZlNoVWZnQisxZGxYQWV3V1IzOWNweGp0cStyWVFi?=
 =?utf-8?B?aW1GOThyakprRzlGUlF6V3VGaDJkeDNmYzFwMElYYjVFa1lpRnE5eGRWTi8r?=
 =?utf-8?B?NUQrL1V4ZVRPUE12Y1pXcW5idmlYWGRmR3lWK2JQY092RWY0eVNDNlIwdDYv?=
 =?utf-8?B?VEI0SWVaZlRVYWpJdUdhT1Y4Y3VQMmVCYTdmTlNjRktINVpCallrL2xBUnA4?=
 =?utf-8?B?bVR6V3ZqYmVzZ1NXM2dWNTA5cDNFSis1OStxTXU2SkpwVDRMeGpjK09SRVlJ?=
 =?utf-8?B?dE1rZ0M3YkJvV3MxRlFvUndudXZqSmY0RlZoeU9OMloxa0ZDdHNJR2gzMDdm?=
 =?utf-8?B?bkIrMzZHOVUvOGs3Slpnd2ExM1poYkl4YTl3RDl5YTBHQWxGNHp2eVl2bzAy?=
 =?utf-8?B?Ri9GSER5Yk0zQkxKcG04UmlhRkg5YUtJamVPeVdaRnJDQnY2a1hIYlA3TDlr?=
 =?utf-8?B?dzE1S2VjZEo1SlBVL2hjVy9pQzJheW1aYU9mUVNCUmdqMGtCM0xLTzlGdWNn?=
 =?utf-8?B?VUFXbmkrakQydHlYVkl0V05VNXdqL2ZWQU8wdEJoYzNBR0lmZEhVNnFCNnBx?=
 =?utf-8?B?WlNGNzJuR0FsNE1ZQ2tIWnZtcGtoM1JWUWNzMmlFbitnZXhZVmdSQ3hEenMw?=
 =?utf-8?B?TjFSakJtdUdKZGs4VW9nbkFkUkJCKzJmYms2Z09qeUxWZUJFeWJWU3BOS05S?=
 =?utf-8?B?V0RObDEyZmJCZWcyU1J4QTBLNkl4aXFuKzM5eGNkajgxM29CREp1SU95bUxI?=
 =?utf-8?B?OHVlR2wydkFRZVdzVUgyMGU3L2RsMWtlT3k2M05XM3owK09GV0VjbnhOejE2?=
 =?utf-8?B?QTEvbnVZZ2QxYWZPS0tUdDNqZDI1bmY3cW9oL2NMbm9UbFQyU3laM2x1QnFC?=
 =?utf-8?B?VUF6a1Fjd0h1dkowdkdNd0tsSHB1UjRkNnNRMldOYlRmeWR3dGdUeHY2dXAy?=
 =?utf-8?B?VHVkQW16WjNDTHdBNVhJM1B4WmxSWVNjUk9URlBhNk1oL2RrSUpRZXE4dzd0?=
 =?utf-8?B?YWpwWmQ2WWxNS0JIQndmU1c3NjZVcElGbVNCS1lGbm5sTDJFSzRySks4Qyt5?=
 =?utf-8?B?RGFYUmhZdXplUWJRWFFiTHBtNmVzQ0VodE1MSXJBMUpmZjFzakFMOHVoMEZ6?=
 =?utf-8?B?UGZLNC81aUI5cDg3YisrY2dyM0ZzMWNZcmhVWTBncXpBSXVGUVB3NVJyU2ow?=
 =?utf-8?B?UUthTGZQVlNrWElRZGNyRlo3ZkFvK0JGN0J4Q2RqRDFwYWMyMnRaWFRMRStE?=
 =?utf-8?B?aW84ZFdEcnBNRVJnZkR3SEsvdlVBSEZjcnlUNWtCZmtsRGFabm9hZVRLN3NH?=
 =?utf-8?B?N25EUWRTRXA2VW01NFVVbThBY3dRb0tqYWhSdFdXTnpTclRVTDcwbHRnNEI2?=
 =?utf-8?B?VFllNmp5cE5keGxGb0M1UHlVOFArTWx4YkFHbE9lZGVaNVdqdFowMEFCNXJW?=
 =?utf-8?B?d3pCN0NKRVIwOTBRN2dEL3lLMjlWdXdtUnNwZkoyN0lsWDQ4WnFSY0k3eTZk?=
 =?utf-8?B?YVY0Q2UybDhUZkVuUmNLN0pHMGI0TFJXZTlLaDVYZ1RDeEg4blE5a1VDZzln?=
 =?utf-8?B?cU9aUXczTktnTVBRZFplSUUxRG9FMmtQdzB4Zjg5MzVNQ3lwajBvcGswSHBm?=
 =?utf-8?B?Vk1KSHFGTEdUU0xCVkErb1NmUW90aFZCTmw3czc2cEVrS2toaGJNaGU0ZjZY?=
 =?utf-8?B?WXl6SXF1OVcxdFh0dGNkQk5Fd1FsaHdtaFdsNnhFTjhUdWRsMzhoUjZ3WVNo?=
 =?utf-8?B?bXAyUTloT01EdDB0UCttYVBtUGlFVFE4ZWZVT1N2NFJzTzBVNjd6S0FldG5u?=
 =?utf-8?B?NDk4c1BUZUVsR3g4OWluZjNMM2VRamltYzFaaUZXYjgrU3djdEJ4RDIzZXNL?=
 =?utf-8?B?SnA3cEhBUjNFNjNDdGppNWdXaEIvNTlPV014UmpMM0dxU3NFQmJtdHROUndn?=
 =?utf-8?B?KzdBaFhlaVZXdzBKSHNBdFpybW5mSWJDbFd4Vjh5SDFMbXFwNWVETzd3bm4y?=
 =?utf-8?B?MnBlbnhVdjBSMEFVL2RhUHRxQmwzWTVhTmxXNEY3MkJPZnBiZVNzSGhCOHZE?=
 =?utf-8?B?dEZ5VCtPSzNYYTJlME8rNUlVOWVpVTd6c296cVRMNWxJalE5VXoxOHJvT2o3?=
 =?utf-8?Q?nQbYRSDwk9K5TY+L8b5hMJZ7Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02456ABD54A3864BBAE15D6199A69275@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c68a22-cc56-4fe9-2b10-08db2a9558af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 05:21:52.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAHuyVTrJ3DkQ4xh7SLjY+vQoNVq48FYMvJFjrM9GmcwFhmG4Br2/xKbziabQjq7qUSa2QKEmYnyW7nzlPpHmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMS8yMyAyMTozOCwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+IEhpIEtlaXRoLA0K
Pg0KPiBJIGxvdmUgeW91ciBwYXRjaCEgUGVyaGFwcyBzb21ldGhpbmcgdG8gaW1wcm92ZToNCj4N
Cj4gW2F1dG8gYnVpbGQgdGVzdCBXQVJOSU5HIG9uIGF4Ym9lLWJsb2NrL2Zvci1uZXh0XQ0KPiBb
YWxzbyBidWlsZCB0ZXN0IFdBUk5JTkcgb24gbGludXMvbWFzdGVyIHY2LjMtcmMzIG5leHQtMjAy
MzAzMjJdDQo+IFtJZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQgdG8gdGhlIHdyb25nIGdpdCB0cmVl
LCBraW5kbHkgZHJvcCB1cyBhIG5vdGUuDQo+IEFuZCB3aGVuIHN1Ym1pdHRpbmcgcGF0Y2gsIHdl
IHN1Z2dlc3QgdG8gdXNlICctLWJhc2UnIGFzIGRvY3VtZW50ZWQgaW4NCj4gaHR0cHM6Ly9naXQt
c2NtLmNvbS9kb2NzL2dpdC1mb3JtYXQtcGF0Y2gjX2Jhc2VfdHJlZV9pbmZvcm1hdGlvbl0NCj4N
Cj4NCg0KSXQgd2lsbCBiZSBncmVhdCB0byBnZXQgdGhlIHRlc3RlZCBieSB0YWcgZnJvbSBNYXJ0
aW4gYW5kIERhbmllbA0KZXNwZWNpYWxseSBmb3IgM3JkIHBhdGNoIGluIHRoZSBzZXJpZXMgYmVm
b3JlIHdlIG1lcmdlLg0KDQotY2sNCg0KDQo=
