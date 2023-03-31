Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65709C76196
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 04:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCaE4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 00:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCaEz7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 00:55:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E565A6
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 21:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvIaEVA0CzV/e4Ib96zPbhvS1/vhdn4UK/KokQV9x2zVstp/fpPVALDGoYBGDi6/qtB8h5t19TqZxPradacodn84Y4a4nEoPwF/1iyUUtcQNdadzNXesLlO/5Z2kbxMxvxoeiZMKhyH2hF9Y3YHKRET3hWSWoMK+lEcCQ76tWm2Ddkk6vUC23Wgml7e0XdeV9RQWWIfSHi3RWtSeN79Z5GPtPw5cMTbQ/wWs6QMo254AzSoi7VDrU7gZ+oJoosNNxfbUzDkNKc+KeQInB56Crs+wEsSJKM9hb7zbBJ52CFODP1uxTkUumurc/LntRos7xkAGo8YuiXCXHYtS3eoMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ1Al4P0meULGYY7nwITRh8pz6JqpGw3nI8Nfse+K2U=;
 b=XKQCYKOkh+S1XQvFMzbX72VsPeWC9k+H2JT7cRN9qVF8aXCqhQHbXrKMDw9Mx01G9v30h8TEh5k87w7J9j60ClfPBV7YPvDP95RCDGYeWSn2MExc+x1y+bsfKN1MXEOFP1JA/+8yDPyqKmAp3jZYD5bCQYDfVp/HWn5VShwYFV7/rni92ys/h4ZZj2fqTn71e4642ML6UxS62IfveTAl65AbXnJR+RrCXxGues2KNtZHudqRXnFjDcPHYQJIrsQIVRNPc8ohvACqSHQkNdtKe1b+oD+vcKMRI6iWdkV0t4CVfcPY9KZgWauOB0q/7Gj4mw8h6Ywgk5fPKAlBp2TioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ1Al4P0meULGYY7nwITRh8pz6JqpGw3nI8Nfse+K2U=;
 b=XZX2uhf/gLF9JQDTCtBynn9R2nc99Ua7Zj0Q8ZLpHZzjaAcZbHwaco0XvAvzCC8Qy9utzUvwS4uPkobIlctbtnF1aN4owyoTUUy7zgRSgmV3okV+c2/4X+vlvIVY/GXf5IlXx7+eIj0eaFABbMPeIGB9rKm1jHyeRTGh2KQ3xGVuwsD7LtT5nDwKsE56ay2CB1Arh5F842dktcO/0jlMixQY7cxpr8x6b9otkzMWgtUZI2U2kH6ChFRaPNmYPOLOpatK4HrI4ED7D4AWkgH1FdiMssr0kzKq8txBCt/BoLRLRi3QzwvHBO2N/nfPckJEC4FknRpIAOoCBE4Cb9jDNQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 04:55:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 04:55:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v3 1/4] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Topic: [PATCH blktests v3 1/4] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Index: AQHZYh0nM2WXVBN0TU2bnQ2/FxwkCq8UVe6A
Date:   Fri, 31 Mar 2023 04:55:55 +0000
Message-ID: <e0831c78-8811-6efd-ead4-a3f6883106cc@nvidia.com>
References: <20230329090202.8351-1-dwagner@suse.de>
 <20230329090202.8351-2-dwagner@suse.de>
In-Reply-To: <20230329090202.8351-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6762:EE_
x-ms-office365-filtering-correlation-id: c6d65b97-0f2e-4571-3720-08db31a43665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0t0CIyEoYP3UdFzOmDQd+51C2j+px77u3cfku+zwOEOeSSmcSbLVT/EzlhIMAcSOWHSmzi2R3Dsec69IotxIfRITk18bdz//CSrCuHvG5vaZ4BV0jfWDGE2QZaSlI9kTW0YAE11SfHiyFf8sm9Jmizj/IPkKKWtTlC7qcDn84vOSHf0qfAhNVgYFhENOkMQ3rRu9aLWnYUdhU6NxOa/rreHN5Qcg0KZD8QuO/vWQNuZnbX4gLCdzZzGPQKIDCqiEL/6YSmkGg9e9MTEBEKW4WTRNTILuz9mV2gmh678LudiRruQUb4w97kuy5qvAsgQ/Thonk317zzp1APWlagffu9swpSfWyJSNTDsGLuVfDZYN/eSMhH31CRd4oHkSYkAeYipoMAWAbaroE9L+ygu1JoQjeHFAu1f5OzQJNcgp25KKYmMBzfNXF713p6mPNfWDb+bR2s0+28Wh8JdQ0UgomnkeEKDi78hsSpXG+z9hUUor0/cVwM6/nSbHHT05xAoLRYhRgCpRQHK8D4ZCG/jQGC8y4Yvd9h2wdv8G6psrp6tcPMi2Qi+YogNUuMnCDQnN9Iwl8qwkud7xSheh5dQ1186cKYvIGGbbEjv1wxpelI5NSOr1GBWk7QV7VCeKp8dysEyJYRddsp0QULMergMiG20Ur2EZ1nNghOGRbgVinTE1VfMtRGy4GiKKp3HwGKpL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(53546011)(186003)(6512007)(6506007)(41300700001)(2616005)(110136005)(54906003)(91956017)(66476007)(66556008)(478600001)(76116006)(316002)(66946007)(6486002)(66446008)(71200400001)(8676002)(64756008)(38100700002)(4326008)(2906002)(122000001)(36756003)(38070700005)(86362001)(31696002)(5660300002)(4744005)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnY0RXRqUWU5OHNxU3B2SitBcUJoeGI5c2h4VHNnWFFkcGtJdXdON1Y0SFQ5?=
 =?utf-8?B?dWNFeGkyOWcxUVYxOHZzcS90eEJqeDFuSGtuYlY1N3BmSlFRd3ZESnFrVEFH?=
 =?utf-8?B?aTFqQmhJdUtyUVNCYkYyZjdkaThlR3BYOWVrbnZaWjlmVlRqRlZ2cUNtUkt5?=
 =?utf-8?B?U01XVWFQdkpBbVFJSUkxdHJ3UldKRktqd1JXRXNwR2ZsQ3ZRTjhHSmZyQWYx?=
 =?utf-8?B?MXJtOVB6cGNibVJsN0t3QWxocisrZ0Ezei9sSzNnVG1OR3NFSE1sQStZTkto?=
 =?utf-8?B?L3JUUkt2ZUxNNnpDOWRHSUl2dDJaeHJCcStpS2laUm05RE5zV09JNEhHMldk?=
 =?utf-8?B?RmViZGVrU0xmaWZBNUpQbDBZRmNWV2hSeGgxYyt1d042a3B5eVFpYVJtblcr?=
 =?utf-8?B?NHgvRGJRUXRwOVNuRnN0Rldnenl0N1l0dEhsSmZMREhvZ2ZmUW1hbitDTlN6?=
 =?utf-8?B?aHRSbW5QSE1iZGdtOWMvTitLTEZ2M2Zzbm1INlZZMUtCSDlabmhlN1R3bXZw?=
 =?utf-8?B?YmUxN3pnTk9rOXlPUUxTejRVbTc1UlRMd0twSEpGNlQ4aVdWakUzM1dtRDc5?=
 =?utf-8?B?Y1FzdUQ1SlJMcEhETlE4YWZDZG1kWE1mTTlJdXpkK0hpdWNwYWdIQzIvd0Iv?=
 =?utf-8?B?enEreWEvaFdDcWcxNXN4SDBsdnFPNk5WYVg4akpCdWFPMnFUaS9nMHFOQk1G?=
 =?utf-8?B?SlBLRHE0cU0zREhMOFFHS2Rjc1hNQ0Z5NlJ3KzllSWJ3TCtaSnBMUnRDUDl3?=
 =?utf-8?B?QlF0eDlFcnNVbjVZa3h6eGF1YVVzTlVKV25BdUJwOEsxNXJLWjNxNmM4THhs?=
 =?utf-8?B?K2JUVENGOVgvRzBVOE9KVU1TOWVabXpCcFVVc2pCZHNTMGtRdjJNaGpkcHdM?=
 =?utf-8?B?QlJFTTdHcFRiTlNneFRaczhyN0dhcVNWbjhiaW52Ungya3YyMjdCU3IvZUlz?=
 =?utf-8?B?a1doSWxKS3BOTlhKSW4xTG4rLzhsU2pIVlYxOTBmek1UNXRTK2NmU3JISTEw?=
 =?utf-8?B?d3JKaEp2cTFRSU1oTGs0blBEbERFN2RTQ3lXNWNFS2ZwUmx1ankzS1N2QXdD?=
 =?utf-8?B?Yk4wS0lrMUhxMmQ3Njc4djdiVXU2TVhTbkhtbTNxYUxZVVZ2djFEc1EwbDZC?=
 =?utf-8?B?REhOeERrNEtnTTc4VFAvb0tWaTFJMnM0MEZ0aEVscmxiMlo5QkR2NStXeXNH?=
 =?utf-8?B?M0hKbnZUSjVtcHpnTFFtODF5cVh3dE9iMnhLTmdnRVVPWEYxTWVMVWdYOEdC?=
 =?utf-8?B?RVJuUDdQME05WFdGMkxOUCtxa0NnZnJPWmZ0cmRUZGZpSm12UTNHMXNwajNP?=
 =?utf-8?B?Zm81QW5LOGZTeUgxZTdiTTErbko1T0taMUVzazlWN3c4d3VleU9lcFYycHM1?=
 =?utf-8?B?ZVA0anZDMXBKOXIzU3JXYUVmVjJ5d2pNbW5WMkowVWJDVmp1MWVqWHRMaXk1?=
 =?utf-8?B?YSsyQkU1V0tHNzJxRHphNzNvWXNmbytCQWpHdGIxZHdIV1Y4bnp1UHJFV0VF?=
 =?utf-8?B?TGMzV1pMVVpBbXZGVGV4NVptdmEweFcrSGt1dHRjSCs4bDFMMGtGbjVyUXYv?=
 =?utf-8?B?UmJOZ3BIOFV0K0llOU55cWxTcitvb0N1WHN6clpMRFpGSWVuQk45bDkzd29S?=
 =?utf-8?B?ZTVLR21uUWNxSGt1RWE3T1QxLzFIYVpXcnFyMlpwY3JHcXNaNEdSWHVuUjha?=
 =?utf-8?B?bXdBcGxacEFsZjZkVHpnUXRKc1dHTjVHdEsyY051azBYbVRDT2tIUDdDSWdo?=
 =?utf-8?B?RlZiMjFNbVBxUlFRc0FpQmpsQzBoSXN4T1JKYVliMTJIdDZ1NTRFUGVkWGc0?=
 =?utf-8?B?MVdGMitOQ1NzditlZTlFNVlOUWRpdkN4aEFkZFA4UGdMQmdNc09tTDlzYzZX?=
 =?utf-8?B?YWhtajFBRWRNa1hKUEp0YklXcWZleFRMdW9BZlZ3TG9aRlQzNE5oeVJ2Tis2?=
 =?utf-8?B?NEt4QUMxbS9LVjdtQUc0MGdCeHFpN3hQdUppOE5CMDZIaHRxTkdLWS9iOFBn?=
 =?utf-8?B?YU85NFpmcGR0RVRzQS9ub2JyN0ZoVkx4OWJmSFpTUTVkNkFad0tmbk9wdEpN?=
 =?utf-8?B?a0kyQVljblFJdklGUy9UQXdEV1dXSG53aUxISmhPdklRSm1OKzNxWVRnU2pH?=
 =?utf-8?B?K2YxT0c1dTZYcHdjKzZmKzhxd1RxMVdFZld4dWRZR0hnUnl1UWRuWGtEUDU4?=
 =?utf-8?Q?Pa7dCoSM3Gztv1dKvWs0i9HIQ2MsMryEGcrKqKVxiLQn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20212E6EDF95924D8B9B1357A125F1BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d65b97-0f2e-4571-3720-08db31a43665
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 04:55:55.9949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Gu5AJZV8pXc/9uho6nzRUw0Hg+4o+2+Hgk5JnAejnd7EjS6VDtffTQ0/JTwIMXW9+WZn4Fq6VNVCW+ALmC5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yOS8yMDIzIDI6MDEgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IEV4dGVuZCB0aGUg
bnZtZV9jb25uZWN0X3N1YnN5cygpIGZ1bmN0aW9uIHRvIHBhcnNlIG9wdGlvbmFsIGFyZ3VtZW50
cy4NCj4gVGhpcyBhdm9pZHMgdGhhdCBhbGwgdGVzdCBoYXZlIHRvIHBhc3MgaW4gYWx3YXlzIGFs
bCBhcmd1bWVudHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVy
QHN1c2UuZGU+DQo+IC0tLQ0KDQpUaGFua3MgZm9yIGFkZHJlc3NpbmcgdGhlIHZhcmlhYmxlIGRl
Y2xhcmF0aW9uIGNvbW1lbnQgYW5kIGFkZGluZyANCm9wdGlvbmFsIHBhcmFtZXRlcnMuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=
