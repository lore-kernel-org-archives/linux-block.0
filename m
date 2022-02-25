Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF56C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Feb 2022 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiBYSh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBYSh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 13:37:57 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255F2D92
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 10:37:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIhNt/YKip1Ky/RplDbZ9jztCxAvrqNsnq8cAAkhg7U3HC19RpcgF8NFRNomwXXkrsikozVP+DvBdtbMT0oPQ6NHF4tJcqxdDX28LCpVcX7azxFj7Hdo6iNLnePCnTVsAzXxmd7zC65+wD1Xnv62fOQ5dJHoVBt+FlDRVLEfQFvgnMFHwGz9bNq/1YmtxAsBGGWO8XLZMDYc8eIy3gSNj96YdkYFd1JRztExQ0hJJK8xqgtNxzrjqx7421IzpTkr54qGPc13Nef0zEV55BeAw+6MY+DQ2R1gu6vyuPGGuM1Vd1FQJQZbyLU1grJbNiTxsk1zcjWGKqbXmaT8PnrwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7Pb8OYtgOeDISVZqiuTi1U9AqJgaK2HoraNswJkHms=;
 b=dlDADnFaDV7GkTcMckBKjqFDgcRslfPTagEUfqsvxGWT30dWEJwxDXhDhNsm4Zfx6gfIlIvkpvdQnZsgQdfRW/HgnmJMWFTCwVcT1J1MJQBv0raAXDnubPnkaainkTh7P9CzjA4rJQUxKMz+S/nk9qZq2UGd2Bmc/BPiYAaRzaTSfcdgDIDVBSHu4OvLwRc9SMziQ5QjZY0Om2m2bVXR1k6Yj/4YwZUnK1tP4gUdU9iwIofmiE86L9kmVsiQ0/M/d53lvhOvse38SR/fAoH2GdLzF5M/FC2QoW4D0fqA6gxUIRgU4H/dpWksnZqcRgbxASqeCwzMgfeOyjxBlnM6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7Pb8OYtgOeDISVZqiuTi1U9AqJgaK2HoraNswJkHms=;
 b=p2moR8RztWZen2Wo1eoKxVoFkRnjJ30Kc5/Bx9PCoSkjlXHP9bIdYVUDTxv0MgSWwPgE2GVdRMu8/LClDm/TiTaQZmEoJl2X8LDBBnyPz9Fa1jHH2qaTUMbutgFp2gdv9ME2Iho+XKi3q4iBx7sHgM7aBSFMBhtNjSA8zrPMwQtt93/FtDpbI5wWREB+MWxyZQ1Ek4736XNAvz6wibflSxMxDeZoXXwWPAsOqKDljNLUjlNtOjgGgL0ej4mXWHMhw8bXNZ8f2AzSPwepEDTByPK80jD96gUx9HsL/7Uc8nLo9HQ2uUqrg8iu9e/DuoSowNAcIOZdS4mfBkDocqDJ/g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 25 Feb
 2022 18:37:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Fri, 25 Feb 2022
 18:37:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] block: default BLOCK_LEGACY_AUTOLOAD to y
Thread-Topic: [PATCH] block: default BLOCK_LEGACY_AUTOLOAD to y
Thread-Index: AQHYKnOTJIeu7ur/X0ebUCHK+JN2/KykmIuA
Date:   Fri, 25 Feb 2022 18:37:21 +0000
Message-ID: <428b2fa6-68a4-79a6-3eec-74dd407e1efb@nvidia.com>
References: <20220225181440.1351591-1-hch@lst.de>
In-Reply-To: <20220225181440.1351591-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b97d634e-4370-4809-f524-08d9f88ddc56
x-ms-traffictypediagnostic: MN0PR12MB5931:EE_
x-microsoft-antispam-prvs: <MN0PR12MB5931D1B6E18B154F0A3F580BA33E9@MN0PR12MB5931.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vbd/wGMXuD66nzrQZvJGlHN2rAhuc1jM93PqBmcKYhw8fQXhGJuJuknLsuYw3Jmdn9B8IOVJLN0gqcrxrPBzXN7CagRoDs9LgPMXo1nDjxZ3GM7F56GnDECAhGt/JahwfN7fkyTND+BTaAQbUSjhGtPYy/xUaHAmcWE46nz7JJmj7KGABwASYkw0VwB5IXoCpqVaE+K0WFK3g56c8W/CfZXBoIGtCcIxUxM4WrcUzexY5wyfDvjcswrunl3ngAt5ELnWdxt2mnfecBYupyW/DnbSIh6dkCigCAcXh74z7gbWA+ytO6Z3cnzzqIwGQpi/xQlY0QZbPNp0DXMKJD51nMQGJMzGQAKfX2t8pEw8jQfVRYbr2bKugDzwGyp6fsPLT0ZRG/nW0J4b6DmbZO1l5IuQgN1vpCpNLiYcgxOAy0seWDj6Yp/4EWZXO4NkkojpOtwobUim4Kz4oO5zf7yoEiN7ycKBacPtaNI4G01+jM1Kw/Jd8pHxZvgAdyVEvN7eK6A/oTN3Q9YB0pKH0PKw5T+H8VNbmZl320v6bkDd3BPoXDPO6iOyDlbjfF5byJ501Z47bWEun2o1M/t1jWBaL20sDykbWmsnQ2moPG5xaqo77yffuiSnxwcjwXjzskd5UZ3rotioNmh0ylx1P4dgFfvl+XEu9Nba8lTwh+FG9pS6lv/A3H/I1CoiU3KO11HIOi2sVVwiCMW/edUINUplQ+CnH/JzZmPYEdDdD531eG6vGicczp65dnfHD0RWZGQwiQnMiLYyuZdRemZgaBZlIH7YATjTMqpm+kMKwzgUWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(31696002)(38070700005)(122000001)(5660300002)(8936002)(38100700002)(4326008)(91956017)(36756003)(6506007)(2906002)(66476007)(86362001)(53546011)(76116006)(2616005)(6916009)(508600001)(6486002)(71200400001)(66946007)(64756008)(316002)(4744005)(66446008)(8676002)(54906003)(66556008)(186003)(6512007)(129723003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNKcHpudWtFYzQzOWxETCtwL2VOT1lncTlBOEYydTNMVGdjckRNNlc2Y0pJ?=
 =?utf-8?B?VUJsbWJTT0k4bkxWaEpKSnJVM09DVHJhVENMTEMyZ3ozVTVhY2VBS1ZieXR6?=
 =?utf-8?B?bFhxRkZDSzZMR0RHRityaTFKRlVjRkdMODZEb2t0RTFpNVpqaGFzRFhUUVl1?=
 =?utf-8?B?ZSs3cU9qemQvRGlsYVZlYnU3NFd2OVdublpYNHE2UGRmTFlOc3BqS3k0WkVn?=
 =?utf-8?B?bEw1djJaZ2s2RkhGb1dmUXptVnYzWTRsNmhVR2FOQkNCa1RHU0VmRG96L3lU?=
 =?utf-8?B?dXRSeDRyNW9JanY0TWgzdFNhRUw2UG55OXdQbEdvcUY1S2k2c212S0l2V3BG?=
 =?utf-8?B?L29KOFd4S1pWZnI0OWFJSko0S1Y3c3daVFJ2bkVpUDZjOTRJcHgxMUsxUDZi?=
 =?utf-8?B?U2dCenRsTUw0NTRWL1V0dDZNNm9wbmlPWnZ3RUFTQ0gxZFhzZUFPRDNQTTh2?=
 =?utf-8?B?UHl6WFMveFhTMkRnZjhueTJsYUR2Nm1DRXpXdVVOekFvY1B0N3IySHJYdXZS?=
 =?utf-8?B?ZHkwTWVZY1QrZUdIRWh5OTlSZUtNYUVoV1ZvQmRmd1NacnVZUE9jVHlocVpM?=
 =?utf-8?B?V1FLcEIveStCUEpKa3NtV3BEbXl6SWE5bE4yV245OWlBbTdmNVcxdTBWOG5Z?=
 =?utf-8?B?M1R0Y2JuZmsrY0RRdnd6dEd0eWE0TjNKcEIwaTI1R1JVM3hONm91SXJCR09l?=
 =?utf-8?B?TEEyQ2NRRkRNT1ZNTzFPM3BIMjBrUEt3NCt4ZFdLMkNhRE9qc29TQ3lRc1o1?=
 =?utf-8?B?b1MwY1FiOWlKdVo1a2ZiUGFNbytXVUVNQXRReE5VaFFiOUd3VzZ0WG5wUUVq?=
 =?utf-8?B?d0F3SUpUbG9iWWdPQTF4c3NxVmg5Y2tWdVFTUUE3cDN0dkdyVnprZG9KUVlz?=
 =?utf-8?B?M2NrRkV5TWtvakpROC83M1cxQllqZXNxVHZ6U09qdFNscVpQT21MVlNCZWxx?=
 =?utf-8?B?YUMzL29YZ0FZMmcrcGtCaG9aOXI4dmE5MkNxSWs3NDI2QmFEOGdPR0JjMEN5?=
 =?utf-8?B?cWxWUnZsMWdGVlVidVJ0R294UDRZcjJvMnNzSXlzelBqazNDZENUeGUrVGwr?=
 =?utf-8?B?azhYaHFpNE1BOS9pcUVxc09TTXpDZDZLUER2aThzMEE0bDdYb1ZWK296K2tK?=
 =?utf-8?B?MG1PVkdONW1XR2lsYXNxc2g5dVdseDFvZDFuMW1lNWlqME84aWQzd1VwckJK?=
 =?utf-8?B?SW1HVmdXTlZmWktCSEFkZy9qaDYwRzBKdmtaRWZRMzg0eFFnaGhXUkZsd3Uy?=
 =?utf-8?B?MVU4N2xqRDRhTnkvTitmdm5UQWxYTEZIUHU2bGZZSU0zb3RkdDcwc3pOdGJL?=
 =?utf-8?B?MEFWL0MyMzlTVzJMTEZqekNyWmppK2liZ29Bak1ESUp4QjAwOFJXZ1FwdGJF?=
 =?utf-8?B?OGQrNzA4dHNVVWlBZlFmUHdvRFZzei9MeXduRWorQWtndXBtZmlCM2pLMXYw?=
 =?utf-8?B?S3RsQzRiN1VIbWtyaXh5WVl1UkJrQWtoL0N1TE9tb3hkTUd1MWdzbm12aWpn?=
 =?utf-8?B?THY5UWUvOFA1TnZpT0NqdVdaWGZ5a0hnWFN4T2pNMUFsZ0NoTVFFK1lXRCtY?=
 =?utf-8?B?QmNiU3NYV25GQUJKV3NRUVhrOGxycE11eUVGWThSS0diUkZSNmFBZkgwZmxW?=
 =?utf-8?B?eVNTQU4yako1NEtDbnduMm9WRzFnakNmVGdKL01BejB4STliVVZOZGhOazhD?=
 =?utf-8?B?THVJRmwyR3JUOGMyc1dpVjhJamFsMkRSLzlkVWx6S21BODVONytUSllYTmk1?=
 =?utf-8?B?RFhCQ3NMRFg4UGE2Y3BCZ3EwUk1SbmhmZHpxT1F2QTlxNkN3V0RqZzFuM0ZE?=
 =?utf-8?B?NTErVWpOWHJVUDZ0ZUVSNVFVRVhzT2dSNmV3K2prc2YrWDJ0VGNVME41QmNs?=
 =?utf-8?B?YTZ6dHRtd1VUTFlveHg1MExmL210UmxmV0lJdUI0VFo5eTBJUWdvYUtRbVNu?=
 =?utf-8?B?RWs5R0FXaTY3VVF3VlJZNldEemtHQk1VUUpUNFlzcXVzMmE0cGhHNUZacWNI?=
 =?utf-8?B?ZDkwUTQ1U2V3dHZoVGI3UkZTK1pzZUxxa1JuUUx1dHZobHFuekVHZ0xwUElW?=
 =?utf-8?B?c2IveEU1cTlEMjFFSFhaTU9WdUxtQkhkWWozZjFJa0k1WnArdUVadGtyc29T?=
 =?utf-8?B?eDNGeFNrcVRiSjgzeHlZajlBS2lJN2VTWFlVbTlPMWU3OTY1TjQ0aW8rbXp0?=
 =?utf-8?B?VTdDUDJhbTBmNm9GR3N4cjAvZmlreTA4TzA5d0ExZEhiZGxISzVhUzk5WjVK?=
 =?utf-8?B?cWp6Mkp5eGJJbHl0dEs3S0ZIM2x3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C788BE22DAC3FB41BB8846F1BF9CCE36@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97d634e-4370-4809-f524-08d9f88ddc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 18:37:21.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/GlLzim/rKNBAR21FXiEWoTx7BLcpAKLv5ZfSwR79jvDzjQYRfsVvTKqzLL/SdSWCg4ttDFfKtkSBARedwyZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yNS8yMiAxMDoxNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFzIEx1aXMgcmVw
b3J0ZWQsIGxvc2V0dXAgY3VycmVudGx5IGRvZXNuJ3QgcHJvcGVybHkgY3JlYXRlIHRoZSBsb29w
DQo+IGRldmljZSB3aXRob3V0IHRoaXMgaWYgdGhlIGRldmljZSBub2RlIGFscmVhZHkgZXhpc3Rz
IGJlY2F1c2Ugb2xkDQo+IHNjcmlwdHMgY3JlYXRlZCBpdCBtYW51YWxseS4gIFNvIGRlZmF1bHQg
dG8geSBmb3Igbm93IGFuZCByZW1vdmUgdGhlDQo+IGFnZ3Jlc3NpdmUgcmVtb3ZhbCBzY2hlZHVs
ZS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=
