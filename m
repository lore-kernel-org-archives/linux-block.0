Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA35DC6FD18
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 05:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCaFAA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 01:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCaE77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 00:59:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A3B767
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 21:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2esnIaW7dduuAPbI3bCZtMyCaHmNhjYDnFlhDdiijuOUjCLWRFYRG2o3iGi2DV+TkP2zixJHzoyZ1m0mgLrrpSpx9SgPPImDVHNVhOE8ZMNLs7Kb5qcU/XzC0TYP2eEAMnLR+T9gq1n2BaavVWScuJ0tP/4mvskbZtIZpFWDBGjH8cLp8mzOxG9n4GFPD1PnJfRAimzZXQzkaIFmfYBmQoqsnht6k4vyVXWI0hzsvQEFVukNXnFb715FDrrFhzGJZqYjWiP+PM1rv5tjzdB7/maGv7TZJBA4bGyQ1VA+8fY3KRpsB5PdwfmipKxO0Le8+YZ0B86rd9LeWiK2/E/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHUPnTvEAzwaeWB4gSPQRnTWpkhtzLwGOcWF0WrYDxo=;
 b=mh7YXo05DzFBF3VXkbF8w4rGRJR8aXahc+56LDSU+u+aq0B+a8pfRM6GauYGtUgWRKwjldJxgN1wkoaXCzyJaPd0gnR465lN9k5ycb9d36E2ceY0lk9G1hnqzA+0h57oe7Zfg10NLwxXVqsWZSSa0r2FiERxh8FyTo0pocWvdetAqBVowxFmX4RNQVPfGriE6kzwSM8RK6aApsNIV413PZXwctXfp3BXGBR8Aq+jubPzLxo2N+K/1jg5Z0zWiYaM24bnryF2MTnslFJSMYHFUDwRu8dRTl2hf+EF8asUXLPKEB9N8TjUFOHMjbTIejOnJK7nBM7qtc95xk/wdYBiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHUPnTvEAzwaeWB4gSPQRnTWpkhtzLwGOcWF0WrYDxo=;
 b=C0OCmXiP1cb9NNxMc7jzF+tnk4ISxq48O0dnAelr4Tg/rQQUfE7TxhAty0+Mcmj+ftJFIIhky2fSiwNHEKMD+B9YeXVSRMFbo22qTGO78jQf75XEWiOzQ9VHq2PKR4M+HBXUg9IqvQf9nj1dpWaWsNRzAbz0E4zf+wx8R8TnIDgajTbAloXu9TCAF8KayxS6FeLp/5Am0tlKjLgvcON1xJzBgjHQyvX1a443Wt08xp8IhBtrMb8MQV0vsAPvYl3n2hP1x60ozLkfFXIzMH27LZI0HTx0gCTu0WggMt7rDd4CxZk4fAaVrPP7BT0qChSNL/X1hjuoB56wXp7ijQNFdQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 04:59:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 04:59:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v3 4/4] nvme/047: Test different queue types for
 fabrics transports
Thread-Topic: [PATCH blktests v3 4/4] nvme/047: Test different queue types for
 fabrics transports
Thread-Index: AQHZYh0l+zr1K1ILSUaZea1NVamk768UVwsA
Date:   Fri, 31 Mar 2023 04:59:54 +0000
Message-ID: <4b320ba2-3d6f-a65c-c340-39e0d2ae1215@nvidia.com>
References: <20230329090202.8351-1-dwagner@suse.de>
 <20230329090202.8351-5-dwagner@suse.de>
In-Reply-To: <20230329090202.8351-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5286:EE_
x-ms-office365-filtering-correlation-id: 4e13986c-b068-4b39-8f7d-08db31a4c4b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NbaXB7ygvyzxqXiAwso7cgZ/JsHkn8eQa6MsytWtN639R9E2w4P2MMESBS5akG5xd5WaqrJvFEi7HnGs5pbs/vBAgv+4dK4Wgwrm7WKnX0PjAkr6hE7VP7qQwqmT7sh/M2SezR7c6VomiriiTb+zakhx1h3s/N4tuVTfM8SwQQo2RKodb6Im/DyN8hduv1gQ4glq+a+3cNuiVPVL0l3TIy2+5loRiBGp+8SctcwcV3rE6UvQ69ou8nYxmRIBm+4b3OjOOsVXZhSjJe5eekGLrFrz3JU0uY1hEB0U1fyk37BjBAg6F1zsmZagykLpDylAwyxAvKWRDfvDwkCLA+R4x6GNKpdz760A0wGM6S8BqC31J9ohJaoOPy/q7RnSfYP2EW60NQNOMXI+1yo3Xgviq8RAv6tFWv7uyVSCAMNIyGbCoq3dinkgsPDqGlKyTecYawwFUS4PTr63F+waGK4iWGIfqAn0IBwp7X8ahwUTw+GbQrm4SjsFGu9HwO/I2uHzZ215cSI7O/Vv4cTM3Ygt8A4POaz4NYZmKs+0HAhOFyi96ZEM+1h83hYvQ6UiS3RcGtDGnnpz0f0I/7vfdFdcHMiTv9QlbjUKLzVVFbr+Rx5rRd9zi5OR6phRYn+qnDwvGW8JmwzG3O9Pmt+oKnu5jwEkQPrh1y7Qu6ZQx/BjBO+3L80GchZV2gB9YZbA2OC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(6506007)(186003)(6512007)(53546011)(83380400001)(41300700001)(2616005)(110136005)(54906003)(91956017)(66476007)(66946007)(316002)(76116006)(66446008)(4326008)(6486002)(64756008)(71200400001)(8676002)(38100700002)(2906002)(122000001)(36756003)(66556008)(38070700005)(86362001)(31696002)(5660300002)(4744005)(8936002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjM1K21oRXdCdkc2dXFRY3VocFlFa3RtT0M4MEVUbE8yL2tqWndFejgzVEdh?=
 =?utf-8?B?Y1lYOG5taUFQME5NVVd3T2NFMmVTMy9IaUdhYXdrK003WXFJL1VoUnh3MUhu?=
 =?utf-8?B?UU41TVVFSHNJSmM4cno5cVdITGh2NEhzblBNd1JlM3ErT2ZCeGlWLzVreUNI?=
 =?utf-8?B?dVkrOXVYa0tpYlZZSjJTNkVpR25wYVo2RW1XaityTERVLzIxZlRCWGV1Y0hk?=
 =?utf-8?B?Zi9hdTNhdkZCTW9CMzNBeHNNZno4TkF6M3FpR3VQZzYwRzliYnZEa2JwUVhV?=
 =?utf-8?B?SG5LQ2dZOXM4Z3NoTk81WElSMnF6ZlFUYkNCcjJ6SHg1dENrc2gzaFdaSnFq?=
 =?utf-8?B?UnJMbC93VEJ1SGM2SlRjbW4rdDNheVhab1JnVnEydzBEN3ZSditSbmJVUFFx?=
 =?utf-8?B?c1F2NXdhU1hxK3JLREQ4T0JWNGxvWGZSd1B4YUxnK0U0Qzk4bERLWlNGUmJi?=
 =?utf-8?B?OTJyb3JWQkkzV0FvcjJPdHFRWmlxa1VUbUJrMk5rTWx0YWdoL3p2VCtpVlg2?=
 =?utf-8?B?TnNIVXRqRFJZcjl3ejZ5VGtvSkVwVnYvS1g5UFEzQ3BaazlMVEswdG5ESWk5?=
 =?utf-8?B?TU1nazltV1J1YUhFZ29scHQ5UldhanJDSzhkS05TVnNOL3RWdkV4b1dzOHAv?=
 =?utf-8?B?alRrNDRveUZYdGZHVWNVbFJTMzRHb2Q3a1FaS0liQ2JMa3FBRXJ3Mmc3bUhx?=
 =?utf-8?B?VWxhSXBMRjZOUk14a0FJYVBvcW56SWp2Y3dremVEdkQwelpLa0FlVzZWZ3E0?=
 =?utf-8?B?YndzRjlmNzFWRnNOVnpaZFNYSVJ1dTJGWStoSmtnT1NWTmFmVVdnMFNUVlNM?=
 =?utf-8?B?M09qcDFHRlRNZ3NNQm1CUStZR09FNllyek1YV3hicXVhQWFBYzFMMlNTaEFT?=
 =?utf-8?B?OGpGbEsyOVB3VWwvNXE1L1E3Sit3S3RWOUJOR0JrYWJ0VFI1UHpDV0Y1RjQ3?=
 =?utf-8?B?NWVMbFRDdVF5cHFkY095dkNUVk1lSng5djVXbm12LytSVDg1SVZqaUpvR2lr?=
 =?utf-8?B?UVRsRzJmd2dCekhaazhtak5FcGtHd20xVUdWZ1lwR1Vnd1NUazE0VFFsVUE4?=
 =?utf-8?B?Zkp0QVk2RU5VaXV5VU40VitrS2xueXVtRVpreU1QcHpSdmtPSjh5elFJamtp?=
 =?utf-8?B?cUN1NzVVVXJOcVI0OFR0eEpVaVEwU1BOQWlrTHN1MEhpdXY5d0ZkNU8yY1p6?=
 =?utf-8?B?QUtFbmgvOFBxMkwwb0pTaUkzeVF5cXF6SzMyZmU1S1pCWURaT21MTDNBNmRo?=
 =?utf-8?B?Uld1cUs0WVd6aWdtcVRmZ1RRUi8rcFBCeUFUYTNGRDZkSXdab0l4V1I5T1Vl?=
 =?utf-8?B?K2NScjZnTWJCZ3hSUmk0dzdUKzBBVWt1WjNFV1hKQUlXQjlQTHJJZXVFdVRp?=
 =?utf-8?B?bEQ5RVBjQkJtQWovM0FiTldSU091VE92RHYzTEViRkkyWWtVbU8zN0xXbjlY?=
 =?utf-8?B?QTcxaGRRTkdCc3hJdnJTVGZ4TDZTcmdXSUtFYnVSVXhEcU9oRjhEQnJGVSth?=
 =?utf-8?B?QXdRM1Z1OEhNYitIZzE1Ry8rRkRreXlGZFY5TjEyeCtjd0JxcVhzM2FxMFpx?=
 =?utf-8?B?V1R5YWVPYUt5NjNPd3pFVHZMMjJJTXBicUtRRzBxa0RabWZVZ2dnNWdiWW04?=
 =?utf-8?B?QWF5Rk1sZkRDaFpRdmR5dmtzb1B0djBWNFF4UEdJRjk5OUo1MFJxQ1BTblhD?=
 =?utf-8?B?Z2YyRHFxQThmcU04bWxmbGcwa1RpL2NUVHlvTXBPOUFqNGN0MXRXVk1tRG5E?=
 =?utf-8?B?dFNxeFY2Wkx4cGpYbmFDRkkzSVo4UG85bHQ0bEVRV3NmU1p6Z2hxOUx4d0Vk?=
 =?utf-8?B?Y2RaeS9wR3ROVDRYTlE2YWFKRWRjNVVJSWNSOWUzSGxMWnloZXVMcHBseHpT?=
 =?utf-8?B?bk8reHpnOGN1c2g5dVNleG53Y0I2VlM2Rk4wT2VlZXBQVXNUMjdjK2h4NGNh?=
 =?utf-8?B?OGFXYmpSdlFNWVovdUxYNWhtT0s0Sk1wTzNtTDFJbFkvUnlVNUh6UFFjdmpI?=
 =?utf-8?B?RnM1T3czTXJTRGlhZEwvSnA4TlQvQU95djBWTGRjbFlZUjZvYUFlaSt4Sjc5?=
 =?utf-8?B?b2M3U0JIZ0prTmk1RlJsTlAyTnM3STErR0VJT3VtK2RjMXRXelBUNlBxWEdF?=
 =?utf-8?B?bEs4YzJqRU1aSFBxQ0NpWFZjUnVZWFNxMWxBOXFGNm1WWm56SzhUYVRBVk1i?=
 =?utf-8?Q?6wR+GmkSz4BOGnJQp/pAajAkWG76f6Dj5XeNpj2aYBic?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <056793BB716C0C409628167F0B53B814@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e13986c-b068-4b39-8f7d-08db31a4c4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 04:59:54.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vo+7krYHUr534XdpRZ0crCOzY05gl+ZI2/F+3jHBNp2f4FklXssxQ8SQ88yOGugRdw1tBLs1Xy2KN80B7ShihQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yOS8yMDIzIDI6MDIgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IFRlc3QgaWYgdGhl
IGZhYnJpY3MgdHJhbnNwb3J0cyBhcmUgaGFuZGxpbmcgZGlmZmVyZW50IHF1ZXVlcyB0eXBlcw0K
PiBjb3JyZWN0bHkuDQo+IA0KPiBDdXJyZW50bHksIG9ubHkgVENQIGFuZCBSRE1BIGZyb20gdGhl
IGZhYnJpYyB0cmFuc3BvcnQgZmFtaWx5IHN1cHBvcnQNCj4gdGhpcyBmZWF0dXJlLCBzbyBsaW1p
dCB0aGUgdGVzdCB0byB0aGVzZSB0d28uDQo+IA0KPiBXZSBhbHNvIGlzc3VlIHNvbWUgSS9PIHRv
IG1ha2Ugc3VyZSB0aGF0IG5vdCBqdXN0IHRoZSBwbGFpbiBjb25uZWN0DQo+IHdvcmtzLiBGb3Ig
dGhpcyB3ZSBoYXZlIHRvIHVzZSBhIGZpbGUgc3lzdGVtIHdoaWNoIHN1cHBvcnRzIGRpcmVjdCBJ
L08NCj4gYW5kIGhlbmNlIHdlIHVzZSBhIGRldmljZSBiYWNrZW5kLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAtLS0NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
