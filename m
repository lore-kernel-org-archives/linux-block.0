Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2FC4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKGFmB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiKGFl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:41:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736E2DFC;
        Sun,  6 Nov 2022 21:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8sQTGdUAZUj5OKRG2SP2McWmFozsp/Wkir5H1spXxOGadIunzX8xCI2sC+laiJlUEd3itImbzWMIiMlDagYABxrn9lhMMtVH/KKErPvQ/1nj6odTZM9dv91PjzdmPDsGlx7GG8gsG9liyFowPovN2Mlos0wACMgOx6I/Ui0yHyrPdj6uV0pVxspCARYUKfjBaPROMGyNLXC5eEfb4xBh0XsGvW8gq6aHBWSwWVRorLPUs4N3Xg9LHEius89j7aCgF7U2qBLNfEOgtDZG7O9ZDxwdJp2K62BM0i2psjq/nwx0C+1GDVvr4jmIa3mjsg4ZWo5wpFwwr/ta/Tg4LUWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgOIjR1N7sSoqNdL7U4tC65caWHBFvfn0kDOg2AX19A=;
 b=Gu5Z2ctrPEN8u2APpICQsPjyOnvqOx2vgtxrLE3xr5z5bQVSzAza3KPjpFS1U+tZJKHdJeaiqUxPMpOADkZAeWLRe+jAoCdUN/aMB9VLXE4KfXIDj42YAnpwTStCmVSHpBjzkz1sbX/6tLFF/iDyqOUgCtUMy02m4oThZmEiQxcrPzg91yK6U3CapPldti1TbRK5EwGVYVZxgvowVCNIx6d57Pqz99ttZrofLpVz7d/HITw4YK6f9bR+mmD9rDDvE+2dffcR4A6GWI72Xsze92jMcP8wQzUhvJNoemBg6l1/BIEyAkrg4LR0Lh2cgnzk0MmDLUV6/P8pb1ixKAyNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgOIjR1N7sSoqNdL7U4tC65caWHBFvfn0kDOg2AX19A=;
 b=m+MKDXrEZp22uBvI2C8sRxuNeUkPg23HdpxH14jSJgKN14GMOW8YNELZSxyiBtpcUu5wUWtdEJUSl5xak3DNj1yUTQ+lEnAg4R4Bb5yeXDcT9IRNpvx4WUxBbvPadl8FrvwWy7o97esHEBfCqZcTVcJYwSAuy1+mXJBRyabhpq8PqNjdZR1oM2OM3kuaS6lLbjE8kJH7AzuaJzL5p/X/RXfARTbA3SuVmuJLFf78gsVI/qtA/Zgc9+KvVHXXIcEXAPMOGYkimkkz1mbbBUs71pNpBGMh+3iK4l70dVklKZEdQf+j3zRHPI3Qf6U70586R6sDOt6qEVhhcBCFzeKggA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 05:41:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 05:41:53 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 2/7] ata: libata: Introduce ata_ncq_supported()
Thread-Topic: [PATCH v5 2/7] ata: libata: Introduce ata_ncq_supported()
Thread-Index: AQHY8kLx1yJC7cyxv0u/fLjQDk/Lia4y8sGA
Date:   Mon, 7 Nov 2022 05:41:53 +0000
Message-ID: <76772b1f-84ad-804f-05d6-8a23d06f18cb@nvidia.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221107005021.1327692-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4468:EE_
x-ms-office365-filtering-correlation-id: d2550fa3-9a6c-408a-adce-08dac082c64a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUukfzq00psfTl/G/HmKUniWnjpW+Z7pQsDo010DK82G/2rhm6c3Se07mZnm4zKS5hYZicxSwDUoBo+nq54mhtN/IchGautGc/M35Gkv3CxNrAvGBZhLqVvjElM6DGhCt7kqmWkbXNGW2nYZGtcte/nN/4FJ8KhqfvxQilileAWoQGcqAOPbck/eze0sY6hHvOyzlUBfyOT+U+pcEVaPP0T/SwoloojDzKHmMKG7pu+T/BIEyeNHfRxmQuFw3innA6dkS76lFJH6HDtSX1T0A5P5igGIoL4aP+0d4ceSEgc0c7ZoKl/zCmu1IkkdlJj06RJzDok0yNcf66lzaiTEmgRDz1YiSMGwwp1d0uTveoQ8SFIrow8yAUbifQ78z2hEwKEPPhShc4977+IG1OdKSqzLyzCE84hWhVWk5EairGycZSEgZtZ0DiPWn0ROtKobJG6pOXE/az63oLtiYcuu+4mjs/HXwd7UYg0+mxILgELWTCjFpahWPgbXzQiWqDIzwP6OJJ0J7qnAXyof4SzX9/qQkZR6v9oa7ac2RVHj/yGfhE+RT2GQOD2wQf5IMdMXRcpA/ktU7sh4iIouyQWiTvoYNbOrmioCtIz8q/RNcLQfaK3IOa8++Dp86gNn7TTpCPHx1Eq2AwOGhLPJc4Bth/qUWyAe3tzS95hv10uwUwkhhG3EQLd2yO2tg7JpGXrmlMTS6OPPBg1HCp+YFJWNVcCyNyn0TO7S9BXnYxai7TCUcFgwj9BLiku+dpQx6SQAYDUl8VhtNT2eWBqkybxuH1EY5vsXSrNdhol9rRCA5j1Ep1zM7j4+cTUqnedsjLng/qVTTaWabA6A56xbZvBZXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(2616005)(186003)(6512007)(38100700002)(6506007)(122000001)(53546011)(4744005)(2906002)(110136005)(316002)(54906003)(478600001)(71200400001)(6486002)(41300700001)(5660300002)(8936002)(91956017)(76116006)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(36756003)(38070700005)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05Gb2JXckM0UythWW05djBZM21jZXVuY2RiMXozRFpSMG05aDZ4SDNUZmJI?=
 =?utf-8?B?SzdsTmFTZ2ZLNUF6VVpTbW9RamZObFhtMHhVcnJnRVBvcHJIZDdIcXh5NkY1?=
 =?utf-8?B?eFhxZUxZZUl1aFpSREZOKzZwSDVpNTdocHU0bGZBdktVZEJDNEYyRmhSQmdI?=
 =?utf-8?B?ZHBZdDA0N0MwNGM0a1djeXFRbnNualdYaDZSWVlBM3NQWDQxNmUweXJzdGU3?=
 =?utf-8?B?SGtObXoxNWc4ZndlQTNzaVZYWm44dllESURXWGVOdUw0aTJ4UDcweXcyUTdK?=
 =?utf-8?B?NlVGR1pNMkU5d2xORGFKVENDc01RbVVzTVQxYnpaeitPTmlCVUFCcUV0bHlE?=
 =?utf-8?B?aUI1bFZQTG9BSWpkYThxY0hUQlhGNk5kTzVKekNSMjNjci8xZG9MU1NIYWdR?=
 =?utf-8?B?SmNxSmVQdS9iblVWWG80ZmNYaXJmcEhGMnluQVNWM05RNng5MTVNUnpLRUlu?=
 =?utf-8?B?dW00N2xveENCRWIxMTQ3dUUrbjdzWlVLbDlDZlozU1d1YndDY0JBcEEwdkw1?=
 =?utf-8?B?Tzd1bGdydHJBSDg0SE1yUFF5K0k4WVdVK1k5NXhZRE1CaS9SVm1KQ0thNlJC?=
 =?utf-8?B?cnpQNDhaYlpLcVp3V3JOa3o0aklJMExSMlk0Rmo2L2pSb2p3OVlXdWpUVnI1?=
 =?utf-8?B?UlBnMkxsUkw1VENOUEhGTU96VXBLVVpTcDBNOEtKUnVjYkRJaERKU0Nad2JM?=
 =?utf-8?B?bEtMR3JlNm50dlN6SjFReXZXek5mZ2F5N3A4UEVZWWptVlBpcmtVdEU4NlJn?=
 =?utf-8?B?aHFybWt6UzkvdHZya210VjVGaEVtaUcxQVYzdzZHVWZiT0swTVN1YlRHb0JB?=
 =?utf-8?B?bDNUS2ZLUC9WRE84eEtCcWs1VmZpZFdLdk04VkNQQzE3TG95SHdyOHAxMmJT?=
 =?utf-8?B?ay9RbEdpWUFVUmdCTDF5YUVSaWNvbXZKNHdvdFlxeHZOVDdveHB5aTdyeklS?=
 =?utf-8?B?dFl3NnhKUngrdFNWNDBXTE01ZFR1N1hyaW1lN0lxcnJjS2xLYXo3RkQ2VENp?=
 =?utf-8?B?VWE1QkJNQ0MrRlVKb3FmdDR2M2VNYjZZWXhKRElOaTNnQitRb2MxR1pQRVRJ?=
 =?utf-8?B?Q2lBOFU1Nmo3NHFvYWZKUXBza1dqNXhpNFFqanZCYS9DcjhaM0VBWENRSmIr?=
 =?utf-8?B?RUpYOElFenRrZWIzaXNHRFgvTWlxUmoxTTRqZVM5RFFPdUVlZGg4Mjl2UUt4?=
 =?utf-8?B?eGJvQWk4cDBkQnZVWklvWGVVRWRXWWJXZCtnSEg3VzlpY0hjclY4dzJWWlJ6?=
 =?utf-8?B?ZHRZcXRRRW1OTUx1c3pjWXVERWtGd1o2UFVoMzN5SFlmRmdPWDFjbU5YR1M3?=
 =?utf-8?B?UU8wY1FzVmRMaDh6MDJUVmZRVG5hQndIRXpUVnNQWDZKZ0RldllleVhuWjNy?=
 =?utf-8?B?b0NUbWNMWHJoWU1QcXk3MVpBT2k3UnFGOEhCc3JsaXdkRG9oUisweWl0VFBw?=
 =?utf-8?B?elJMbVYrU2JSajlXMzVPYUFQQlV2T1NIT1hDZ0o0Mys2MVB3RG1rY3VuUnhH?=
 =?utf-8?B?OGpYb2hBZTM0UnE2WU9DbjdEVHlYeHNpbERRdnp5QTFpRXE5TkYzTE42dFNX?=
 =?utf-8?B?WGdaL0tNeHd2NXRKRUFUTzFoQlNOcEdCdmw4SkcxNVAxTXlKSmQrMVd0Z0tn?=
 =?utf-8?B?UHo2Y1pXb0xPYlRiYU1HNWx4U2VXTUJSc0Eya2FqRmJCOE1DTVRkZzVKYU1L?=
 =?utf-8?B?ZEVCMEdadVFzNjRESWZlSmhVSCswZi81VXo3bVN4WW54RzVhV1VPQmRwS2c3?=
 =?utf-8?B?alB0bmhIVFU3WTREWVJlWmpzWFlwdVovRXlKbkMwZndwRDBQVXlQb1BrS1M5?=
 =?utf-8?B?Wmd0dFh0SERlcUp3c05SVDcxKzR1Zjd5d1ZOQ0ZCek9NK21FYzJjM3BjNFF5?=
 =?utf-8?B?Tkljek4rcmJPWmVoVFZvMllmY3dBbERVYzR0VUVIbVBKVXlCeFNZbllZeUlJ?=
 =?utf-8?B?L1h5eDc1cnMyYWpmWDhvNzFBN05iRU50cnd6T1BUVHNVS001UGY5dmRKSW1F?=
 =?utf-8?B?bmIwR2llcGhkY3JEVm5EMmxiT3JrNkFob0tLbFVLSGo2MmNEbkdCYmFuZHNy?=
 =?utf-8?B?YllCM0hST2JwUXJGWUYxelpWQkNXTWNkSmIwTnRITm9iU1F2UVJjUi9RSGpG?=
 =?utf-8?B?VitKbGxsN0k4dFFFSEdqSXRyVzhuMTRYRWVFTzdFbzBWNXRuZnFuQUIvL0dj?=
 =?utf-8?Q?Ktx4KFX6MaE7P9mFFZgRg7v0dDCJYqFOu4FKexM5fPAv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEDB03D6F4D86B4B96554868A8CF45DF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2550fa3-9a6c-408a-adce-08dac082c64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 05:41:53.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQXwwIsqexknHR47czyYWw6ExfPzFcmXqn9pgaWXRfieDBs6PoXU65oY8fDEDjJDBcd7GlP7wMeoHvmM4+ML3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMDIyIDQ6NTAgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBJbnRyb2R1Y2Ug
dGhlIGlubGluZSBoZWxwZXIgZnVuY3Rpb24gYXRhX25jcV9zdXBwb3J0ZWQoKSB0byB0ZXN0IGlm
IGENCj4gZGV2aWNlIHN1cHBvcnRzIE5DUSBjb21tYW5kcy4gVGhlIGZ1bmN0aW9uIGF0YV9uY3Ff
ZW5hYmxlZCgpIGlzIGFsc28NCj4gcmV3cml0dGVuIHVzaW5nIHRoaXMgbmV3IGhlbHBlciBmdW5j
dGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2Fs
QG9wZW5zb3VyY2Uud2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
