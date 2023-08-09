Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C073C04A94
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 02:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHICHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 22:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHICHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 22:07:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF131BCD
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 19:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mblhTsynNtRKADBApHsnPVQDkhCVlI9LE2l5PXe/Y0Oa//VJIExnsoZa9EdhacbvpiW8OpeN1GUP00PC2bOdtAo0KQXGdO7/zxS9nv2ZJFIRDJYBWrjCgEMAu8wqFOkvgl5QgpdB/skitu2OoS1jGL6CEv8vAYHG0Pgiku5t1dmVhYa5icyp05QgpbgJD6R5V2S4dPO+dh3yeBSoIQi36Lbk/dvWky2kIwAcOqrEr9MN499snFiCCZpQvbn28RAkIx9TiVo0oGC289Vx3LR8YVvg1d8mDyqLNAKGA8tSWPYS3uXVat8s1Q2MGmfZbltT0jNycaf4/iz9C5RsItZw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxnEpknAMmL2Q9+TX2861Jz/pILfb23lKcluREJg2r0=;
 b=KfClClh4iGL+BnHf6b223l69++G22Qj8duhA/PkmQdIaK7NOIpzFcf+b3XP0VwP5zJ8ichbX1yEx7dc1wOaal0l2rfzzgXYw8qLMAtauu0dihAoJxbMK8pzR+K5UeM2BRspJQBViKGzm7wCo6s3wWhBPL7drR1HM2K+evNMaHjjZPCYbyI/GWkzPo/+uibohbP64RPrbNqi9aDXE57iljrsBOMaVHqtLrBn0PprjLMnJBxru2mFmI4p65kABVC12nbjSEm+Q1Ecwv2i7snePOiLma5IRc97J/hzCmjzLbB4d1X9cLDX6IAhwwJHxzHiWLpZnWAA/M4RGIdhN8Ej0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxnEpknAMmL2Q9+TX2861Jz/pILfb23lKcluREJg2r0=;
 b=CLl4aT5o6tWjZ0Bs2jPmncQs9ULYWyibIbD6yUrcsanaG/Hm+rkkpeD9d3xQff2doeSpZpcabk43VEn+KyLMhM5J8i/cEc3+O3rif6pUxYccf4jZSLb/7cHcLot36Ctv4cUt+8RKTlNzMFDcvaFEAnBvIwGaIrg6lg9DQQ/WdwrtMaTXfM4QguQyFpmvSy8VChn2JiZ298tJWa/I70qllJbJTco+yGd8Lcwu1Y7han1wQs6SvvF2ySmlHYvKLJtEyxAnnNuEnP6FXb5G4nKvUGj03Ev7fhpb1Z7K6K7AtIOUKcmS2l6uR74+OFwsVWcqh5VM8uGR66L+QRJOG70A4w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 02:07:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:07:44 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: Improve efi partition debug messages
Thread-Topic: [PATCH 4/5] block: Improve efi partition debug messages
Thread-Index: AQHZyiIdnd8B02zutkq/PJYUBDiOzK/hOEyA
Date:   Wed, 9 Aug 2023 02:07:44 +0000
Message-ID: <1a0e6f08-e33f-32cc-970f-4e23c8c3fd7f@nvidia.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-5-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-5-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5744:EE_
x-ms-office365-filtering-correlation-id: 59b200e7-deb4-44bd-7123-08db987d6b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziBK89awtETA3gHcOMLT4aCgGUp1kBgRpk2ET1xDXo+1vLmIdPTbCOad0ahf3F2pvS7RrXvETYSb7nqm3/GBWvuQ1qPDfvwuK9MKPkfCDtngXPipcjxmI2YhrlqF28unpMn1KA8rqaOuZag8qchlgDw8IsLPIpi1FanXVtM2turryQIUix2Q5m367Ksg2S/AeS/hB2dedBsSJlzy4goqxanv0G33oP8VI1XMaZlb+N2bm4gRLGvDQZpx7CV9DY6asyn6sBCp01sHOC7TOx6zEzRpg5YUespHRlmLO9HR44539oSmmrPicviAv4R1oXuLyGTokE/X3eaQS2J29dV+jpyKxVBQO5BVUcPdtnToHjkJ9t8cN5idycnE3aRWPqi8faIYChohSDyoPngNnH/4g+ckKYWVjYIskoCsVME9gAQobqQQ0QeNGN+jCNCTGv2uhro5VYgOfkpuR5wVVow+5JmrMWPppgwlRv6iynjC42Yh1j4hXZnwlGSYbRwo/Lyd4APRhaBPoO3BYNUurxpBB1F7oDtOB4AB+otVnnu4LQNJByKh4D2KyjczUz4w9eTuAl3B/kloRF4670P4GRH1T1DuN5daLjmOV6gntt5FCcFhfkCFrUvI0PLrpO+2Ni3qkh2x3gXRNi/5kaOauO/NZmCRy2jjIdvDPNGBNxjAq49bOicTZ+iGLn+iGxuSl2Na
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(1800799006)(186006)(451199021)(8936002)(53546011)(26005)(6506007)(8676002)(38070700005)(5660300002)(558084003)(66446008)(64756008)(66476007)(66556008)(122000001)(66946007)(478600001)(38100700002)(36756003)(110136005)(91956017)(76116006)(6486002)(6512007)(316002)(41300700001)(71200400001)(2616005)(15650500001)(31696002)(83380400001)(31686004)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXhhZ3B5ZUptUTJYN3p0WHJRUXVYVUR6VHVXRXBlM2MwT0JqRGJ6N1hpbTlC?=
 =?utf-8?B?M2Q0L2xuTmcza3ViYm40MXZ5Sk9RSGhrT2hETEdYZGhGcFBhdjhMUkdadmU1?=
 =?utf-8?B?bU0rSlZqcVNsRGRLWExSa0s0cWd1VFpGQ3VNL1VReDkvajk4eHB1QWNsWEJw?=
 =?utf-8?B?OGZpSnhKS285K3lsTlNxTkZhVTdqcS9TMUhZeXlzUkRYRjZ5cmFYNU1DcTRO?=
 =?utf-8?B?M1Y4MU51a0RySVQzOTZnZURqNnNFZm1lOHlaNTZNOEVWOEJoQTNDTUR3d2x0?=
 =?utf-8?B?cU1LbU5FWHNabCs5ZkQxTlJ1SkdyN1d3WGNWSGxmWUJZRUVCWUx2Y0VuWHpl?=
 =?utf-8?B?RElXZlk4VmdRQnZTNWdLOEpGY2VLRzJkbFNOLzgwSXVsaGRBbnBBZUFHSWxz?=
 =?utf-8?B?dkpXSW0yaXd4b1k3WVlXMkFIYi9WYnlRWlpDQ1U5OU1TSjBNby8vWjBDU3Jx?=
 =?utf-8?B?NWtNRnV4VmNzalFHVFlPTUVzZ3h4MXhoZEZXY2dFTXpmcU1Qb0pCemFJWFFw?=
 =?utf-8?B?TjhmRENGZ3prTXRzZVRGbmc5NFRFMHZvVXdHZThFbnpicU14R0ROeUNmT09a?=
 =?utf-8?B?SVNwRkJiU05aY3Fic1Y2RVJ4N0pIY0ordjd6UDBjckU5Rm5lMCsxb3F3V0tn?=
 =?utf-8?B?amZyWWh5QnBvNE9ZS0wybGF6emhQTUVselNRZ1AvUG9kd0FyMzdmNHdXUHMv?=
 =?utf-8?B?am95anlmQ1VEelJzUTU4blpIWEdCL0lYSGE3eVVZdFFqWjZqRGZjTzZBRnhH?=
 =?utf-8?B?U0RZaWRxcWxoWmtBeXNDMCtuL0pQa2FQME1OWFRoWUxnMTZhYUNMRDllRjFo?=
 =?utf-8?B?NG1VdTlTVmMzaDJxRVA5R0RPNERFRHpXK2s2RktJN1hvVkRSeUx4SFI4dC9i?=
 =?utf-8?B?Vi9GM1QwS1FqemhUTVFhNGhPMkgvZ0tpcnV4SDhqYm1LR3lPcitnbTR4SGFm?=
 =?utf-8?B?SDJSUHJjVm9jTkRnblB0Snl0YytZZjR5RnlaRXFOa3RENDZnOGV5QXdYaERn?=
 =?utf-8?B?aklZQklZQmpKUlNHOXBlZzljNjJRWmpSaitkTDl1b25FaSszQVpuZnRwUzg3?=
 =?utf-8?B?WCtINi9jMVZmSjgvYmNud2VOTTlOYTFMSVdCbExoaHJVQUhZQlBSUmtmZDFn?=
 =?utf-8?B?ZDlzVE9nbXpIeFpkNWVYT0NvSkw0MGhxS1MySk8zc1pac2syU3hsTDE3S3No?=
 =?utf-8?B?QWdJT1dKeTVSNmdJRVd1OU9FdE9la2pSR0NzQ1lXb2pISHJ2MzNLdUNhR1pL?=
 =?utf-8?B?MWdNSG44bzg1amtoSVM4a2FyZWU5NXNQcE81SEVlVzAyWHN4NktiSDZFVDVC?=
 =?utf-8?B?bUZHSzArWklJaldpMXliZllKSlU2Mk9aUXc0ejdQeFBnN3BkekszQUtjWjRQ?=
 =?utf-8?B?TE8vNXd4alg4Q2o0NHJ6SUM1WGYxeWluUHFKNklhZHFnWHlsRmZRc2I0OEFh?=
 =?utf-8?B?b3FkV3FtMjhIWjVwZnlKbEsvMHNibWtFcjRIYWhtbHlwMk5zLzhiS2hCTWUx?=
 =?utf-8?B?WkVLdUVHWkdYOGgzcVVFUDdWZVozQmpHcDhZeWhVcnBVemVPNWt6Vzg3WEZq?=
 =?utf-8?B?TGhQSERBNGovbDZDMVJXTlNXQ0JnRmFtMlZlM1BJTmRxWTBqOUdRNVNNY2xx?=
 =?utf-8?B?b1diWXJsSnZjb0w2TkhnMlN1QU5tTDU4UHVBNlh4Ny95Q0dWWnVjUkQ0QWht?=
 =?utf-8?B?WmRWOWl1ZXMxNHBnNnRtOFFMOW5LeTBzTUxNZitjVS9rY2dCQ1VPT1ZRYmwr?=
 =?utf-8?B?V1FiQS8wUU1IVGRXczBKVUVjcWczNzJGZkYzMGFWNmpaY3JwMXJPNEhGdk1N?=
 =?utf-8?B?Wm9sYS9kb2R6emoxVUZMd3ZvbmlSOTZwcjl6ODJ1NWNIUEs0TzhaV0s5N3ZR?=
 =?utf-8?B?czZveFdsUWJGZTFzbTJsR0xJQ0NPSlEvSHVoREU4N2lmOFhyK0toSjRxQ2xz?=
 =?utf-8?B?K0hFVXV6WG8rMW1wMGM0N0NvVEVjb2p3NmJGODlwbkxiTldBb2tISzIxYVhy?=
 =?utf-8?B?UnB6WVF5dG5jT01vNmcyQS9pWFVQbldVRW1ETEl1UXFBODh3OUdacG5lR2Vu?=
 =?utf-8?B?YWIwdVVVME9tVDd0S2cvNlFxTTlXR3JwNkhqVzBIZm1EYjBDajRJcjZIREp4?=
 =?utf-8?Q?3odUmK2W9c/+GTywvAjRBjiQQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FED38FE24FC1B1459284BDD838AF0509@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b200e7-deb4-44bd-7123-08db987d6b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:07:44.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFc2MFu2yEhvGOaJNmUugw3NRam0KXSdDkl+8lfBiRHUO36T6EPmLRblWcAKSllKVVQu/zBnRtIP/rO7ptWu1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC84LzIwMjMgNjo1NyBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEFkZCB0aGUgbWlz
c2luZyBkZWZpbml0aW9uIG9mIHByX2ZtdCB0byBwcmVmaXggdGhlIGRlYnVnIG1lc3NhZ2VzIGZy
b20NCj4gcGFydGl0aW9ucy9lZmkuYyB3aXRoICJwYXJ0aXRpb246IGVmaTogIi4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IC0tLQ0K
DQpTYW1lIGFzIHByZXZpb3VzIGNvbW1lbnQgLi4uDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
