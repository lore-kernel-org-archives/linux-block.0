Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096BEC77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 04:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDPEwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 00:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDPEwm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 00:52:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E164B26BB
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 21:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beufyX22oHK9VeEYyQ5K71ztn55VP61uMDbCZyz2R8aG7aryiIHGPODIDVd5oxoICUa45nDqGXCuu9DhXt3WWobd8d4f16hjrn4Q2uN1W2s7PqCh2gMobywoL7qRuPfP0NqUjN0rgP4kVQ7MwTWTbrRIEUGLOfV9KbLakQa/cIkFG8kqj3Xe3bkr81Sjpdpuy1OCCnSxmv0EtKJ1qA7lgmK5P4h7lfLFlDR1Tzbgr6RX4ETlpsREf7daFwMfPF/2+uTLCO1ija+odeE4f0Sqr0sMcNJ/hWmbWyPveXgU5Gc+nonx1sMYUMPrsmSr7NmpLmyrQcEzbHHEoW9Ag+y/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg8aXumJRWey57N9jfoludAfb4oSdkLO+VzZvkCosgw=;
 b=LqZIDHsfr8i10VnNS0ACDDy6PRGHo09JZ+0W6PsR5sqoDQRDz+zBb47hH0b3eUEMQG5/Dmsrfkqkp5boa/ZF5qM+oGE4kkloQBNVO4Rlf22am88F/SbY4YeWzqFVun68poiGhlcbSL4kAl6b7FE4fhyxCPa2lxrcEZkE/Rk5bg6Lm4g3LoqXcHD377mzWtj+cIK0Z1Ohe2/aM9XmMnLEEloQHKtlAOCRGhTRdd1t714iBXQowMxfBfi/zrlP8DJq0coissSSlKEPE8yJLTB9fmCo5H4mkUIxM8B7Wvlqx9OziEQpxLQtmiA667yrNZESrVUviQT57rW5bT6EBWUNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg8aXumJRWey57N9jfoludAfb4oSdkLO+VzZvkCosgw=;
 b=plR/U99f8lFux3BWAJFb0QZPUO+z1W7RjJZ07OmOMd3nLter93tkrF+gPMhm6MrC4gnZ/+fimLkKwMGxg1yr7XWWxd1PwKXD1rrJvPqHx1lr2jYI66XwgRwmpQhYjFwcWOZBSkGMhJNJUvNfZqDM4CwLSogr9BaBYUzDaCjrmrF/h8YZEJYZ7UDR6bV+YTiw+879OW5+olri2ajrl1VVEBZ3JY/LMz+7uzHBPrXxwPWo5Vkwq92Mev1jUHpadN7VfVvl6fYbXpP+YxHnFaYC8zRJbRwOEPx3E/FTCjsW1W+v6GVHurgRs6qB+OVrwYpDhAy6dwsg+mGkKy149hmQKg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sun, 16 Apr
 2023 04:52:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Sun, 16 Apr 2023
 04:52:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] general protection fault at
 kyber_bio_merge+0x123/0x300
Thread-Topic: [bug report] general protection fault at
 kyber_bio_merge+0x123/0x300
Thread-Index: AQHZbuKDa2CoeXM/sECOZItF+w+p+a8tYMEA
Date:   Sun, 16 Apr 2023 04:52:37 +0000
Message-ID: <a0a0d448-76f1-3e02-145c-cfdcff07cebf@nvidia.com>
References: <CAHj4cs9-PhuUM0ztSnCuryKkOa+tX-RGP+M=zX-UoCE5f9E6FA@mail.gmail.com>
In-Reply-To: <CAHj4cs9-PhuUM0ztSnCuryKkOa+tX-RGP+M=zX-UoCE5f9E6FA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL3PR12MB6572:EE_
x-ms-office365-filtering-correlation-id: 571bd716-5136-41a1-65bc-08db3e36667b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bclzcTvCArdLPzAkArR3MyXF1CXPlX2qrGWo7+Ehp6G9dQ60PPXs9+vYLQcn+JSVznvBTHe423tX41HCHyi17wPvI81+zS+UjcHJ52yIDzOVNMAHkB13cpEly2SRFOhqq/2D6BzPg467u/FReZGCuX42KdzqRDMTdULXkxW3So/IDtfwK8rA6rnjFzqn3QM2Ecj0suXsqE/j8q0QQEgUUhO8AMHbekSNGOVFyJLbdelnzvw7F+JYQHbzmM6Rfw0yJF5Ha2fkDNkaAME8EhegYpkw5CK64x2Std06X4kJ/LUXd9jn3Im8VLA4Ry+p9FvYc8JuRJu4NmN/1kEQvDiB12L9V2zfL5fPTYC0IR9KErLnbgJUjueFO40CQ7FvJ44MDMRIf1CSJTjfJlmiSrFDJ4W275y9frmhrOSmxxkYYrLHpN+ddiA+F0j4KYf68hByB7G+tU+8lOOw8/9tKtn17VpAxBazYytldtj6/03J08538pZzDlRRJud7StOuhTlyO/vM0yjyesldBWQf1j2OLVmhpr7PXot8R+ZsfDgKVPG3FSabkppIp8nsjTGd8sW3uK7FdpH1WbYy4mwWqRZ9TAUvvAtbZNAby+B8YaBSnJaN67UlNW3gETO8wUqZwHLlukGliDwJxE5KsY/kbyYDMz1dTH7glb/TRjZJojxkiy5rMDfJqQ0DL6++y5/YLEDs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(31686004)(66556008)(6486002)(66946007)(71200400001)(64756008)(478600001)(66446008)(8676002)(316002)(91956017)(41300700001)(110136005)(76116006)(83380400001)(66476007)(36756003)(558084003)(31696002)(86362001)(2616005)(6506007)(53546011)(6512007)(186003)(5660300002)(8936002)(2906002)(38100700002)(122000001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVFhWXVqQjdpamRtaVRJekttRHEwS3pWeEx4ZWMrNE4xandtZFg3Y3owVGg2?=
 =?utf-8?B?aFpDUlRKRmh5bnF6RERjQ3F5TDVZbi92QVVLNjdyR0UzZFNmcWttaFR4aHNV?=
 =?utf-8?B?K3B6Y0tnZXkxbkt5WGswRm83TTF1WkQxd0F6Q1FCcXNnMkVjQ3FNam04Nk41?=
 =?utf-8?B?bGxhZFl3VVRiRDByZ0J6L3dTZHZQb3NJejlWV0RNc1VMalcyMjFvVlpxR1Vz?=
 =?utf-8?B?YUlUMXVXcGRzczhyRERiWDIxL0ZVUnRQZS9qOXMzaU1BNFBHWWl3dE14NXlW?=
 =?utf-8?B?VDFIdEM5dEljN3hYRXg0aWh6YmpXUWxaVHlTakt0VS9HSVJCL1VzRkZLY2pw?=
 =?utf-8?B?WXFZVXNaYVk4b2g1bkhRaU5DRUZORFVVdVBZTThCSVZxeVRHbXRoc084c2I3?=
 =?utf-8?B?Vzl4ZnRUY21rME1IcFJDR2srRmZzNEMrS0lDK0xtc0pQUnluVnJUNnVNQ1RD?=
 =?utf-8?B?dHpJWW9ISWtYSWlXa1ZSRVlDMTRJOWFtNFducHErZm9jNm5FU25yUmdkZFdy?=
 =?utf-8?B?QUxVTEtvODVnbWhjS3BEcUszS0JINVJIZStxZk11YnNtTjFCY1dncFIvazJS?=
 =?utf-8?B?alpKMTQzWklNVFlBNXBVUmEweGRVTWpNWjllYVVZeTJtTGNubTNzOWpLblVt?=
 =?utf-8?B?RkgxRjdka3pHcXVTRHo5RXNjeThNbGFKdGc4ejFGWThJQktaSDFTcFNzWDNH?=
 =?utf-8?B?Z2VEbXNFS3A4THFGY3ZvNm03RTlOa2hXeUxzQzUwSFZHSXNoSzBoQ2lTNEpC?=
 =?utf-8?B?aDUzMWlOc1M4a1hqZVJ0RjBCNEVIWHhZR085VU9TbDlJY0JnS0VDM3hLZzdR?=
 =?utf-8?B?aG5aRUt6aC9qak5ndHoxOFhPclVPWTgxMGNpUnY3bW9VUk1HRnJkVm8rWGtR?=
 =?utf-8?B?aHc0M3NDVlNuWHBUMmVBZ3p5T2hOQW1zeHFQdXFoY1RHZ1VoVUxiT25kSk5K?=
 =?utf-8?B?MGhZazlUU1JydFR3Y1dodW44a0hWQk5QV2QxWTBPSTZkckwyTHNTMVo2bTlN?=
 =?utf-8?B?WWRlbkpCMmk0YVhOMVNHVXU4dEh2TTJZRTQweEIzUkZCZFpmVXlwV3VMbEdh?=
 =?utf-8?B?Z0ZYTGZSa2VGL1VwSnEzVmJvK0JsOGRwNXRrV0IxTmJSR2JXeUNsUTJnQ3lV?=
 =?utf-8?B?elJRMGhpd21aMnIzQStiVFJwT2xyRGwwNTg2OVduakorWXdJL1M3N3R5Lzhq?=
 =?utf-8?B?S2VTdE04Tk5ob3pCK2FFVUV3MnJFR2ZndUhZMktLaGxBS0tzbTdXNXZBc3dF?=
 =?utf-8?B?QlE5QWljS2t5aHpqSmFMMi96N3NHWFF5aUVBQUdLTkx0RDFSSk1Nc2pjalJw?=
 =?utf-8?B?YW4xNUZTQXF3Qy9GNzRqODkrWmhCOTFwaUdEdlZrb09PTkJneFZyMUdFWVZS?=
 =?utf-8?B?VGxXYTR5UVJSek5vcS80STdmZ001QjJpTmpubDlmNUFJSDNvK2FvWW4ya1Ra?=
 =?utf-8?B?dE1CajNKTFpLZ1Z5azM1UHdPY09Ra3pYL2pxLzdCOEF5QUF5dzhlVUhYRDF5?=
 =?utf-8?B?TkE3RENVZmNMSEhiaG1IempEYTBORUJrejdZZW9FQVZRdFN2bzJ5KzcwSnVy?=
 =?utf-8?B?OXdKd1N0WUJzaVpGZktrZXZ4YkdmWU1hZWMyRjRYTDlQcTJDZE96NzlRMVZL?=
 =?utf-8?B?dGJ5T0J3SWVBSjhtb0gxRFRkcUc0cExrZmZWTmlXVjlkNmwwKy9pa1lzcWV6?=
 =?utf-8?B?UlBUbHkyd1pWeUlaVjNMczJkV05FRHdQRC9UQUxRVkdJd2t3ODJXcVBvVnZL?=
 =?utf-8?B?ZG5LZ3E3Zk5aQTZxalppVGk0SExiaFlvaDF5WTZIQXBGSjVhbDBIV2lOWHlF?=
 =?utf-8?B?MUNUU2QzUFQ2ZHY4VlRkQ2tzQy9PWWVzbHFuVytGaEdKb2wxTFBhL2hwM0Q0?=
 =?utf-8?B?MFBRdjRNTlY1dC9mSUdySmFSb3ZkNVVMc1pseFVYSmtwdWQxVjBBUnZVNHhh?=
 =?utf-8?B?L2drbjZtdG40TWlrK3g4ZG9qcllhVjkvcXpvWkhodTUxell5R1BQVjFJNk9i?=
 =?utf-8?B?emU3ajJJZEhxKzFEcWdJNkFsdHNvWVFXcnV0WEpIM0ZycUZ2WWhPY3dITURN?=
 =?utf-8?B?VCtER1ZJeGRqQ05GTWFxMW52M203LzVOQm9NaTRuTlIxTXBHNWxXZTBlMjlB?=
 =?utf-8?B?eC85c2FkcUJnZU5OcU1uQ043clpITlpDOFgydTRlNWVNSVdjMmF6bTI5emVZ?=
 =?utf-8?Q?CSPcfrXRrf75KezbZyGvywJdzAGie5HSK9oqzzwwuu+b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4233255F324A74A953DBFAD56D86B53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571bd716-5136-41a1-65bc-08db3e36667b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2023 04:52:37.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bv2zrs3J482K5AYQzqzKp4s5iIdx/XmA8ma7TT2aWb7a5nrD1P8zRWbJEc5kjA/8AdwbZx9U0ulfnUdjvvt75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xNC8yMyAwODowNCwgWWkgWmhhbmcgd3JvdGU6DQo+IEhlbGxvDQo+DQo+IEJlbGxvdyBw
YW5pYyB0cmlnZ2VyZWQgZHVyaW5nIG52bWUgZGlza3MgcXVldWUvbnJfcmVxdWVzdCB1cGRhdGUg
d2l0aA0KPiBmaW8gYmFja2dyb3VuZCwgcGxzIGhlbHAgY2hlY2sgaXQgYW5kIGxldCBtZSBrbm93
IGlmIHlvdSBuZWVkIGFueQ0KPiBpbmZvL3Rlc3QsIHRoYW5rcy4NCj4NCj4NCg0KDQpJcyBpdCBi
eSBhbnkgc3BlY2lmaWMgYmxrdGVzdHMgPw0KDQpjYW4geW91IHBsZWFzZSBzaGFyZSB0aGUgc3Rl
cHMgPw0KDQotY2sNCg0KDQo=
