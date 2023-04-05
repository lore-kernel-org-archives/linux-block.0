Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F60C761AF
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 18:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjDESj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjDESjv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 14:39:51 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B795
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 11:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQLYKBsTw6UkVkpRQXgzI8SJeQhLhKZZ9r02rYnaou11NfTwMNREO3jeM93uKpJfNI6hvAxUfSQBmQ6y9DwxFfSRFQ7C9PwOTX9S1YhWS6gEyCVlom097yxCLBGNyCe1ojESV8GykYdsn1NLC0SGHjcIRhGU2SJ0NmOxN0xXp9KWtLBVGcU5QpIUahrwANHBWIFdZ60QocjVaQLke7K8jciv9p+0tHVJtnNQTEZrMIAStZjgYyf2A+wo7Yj722fH1PxjD66GDzDiyijM8al/cmrbcFpRSbDb91GS6M1Fx5xjbszW68MyGq72QteIop845GdQJvGvhOO3oqi04NWmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhq2ghCUdaEhIq2psSLJ3nZwQOwiMPL36i/ubw+f3Ec=;
 b=A5QhNtnAVqfauiymtcPUCl0ZzxSSzcpjy21a2FsJapG0xokbVwyvzwdEMRm/7e6lQIG51FCOWCnd/9Gdwyv8NdcM0fzxvFSn29hRhSvqLAq+PWVl7Fm6Y7v3l5qk9Xnr2u/1R6OXAt+ok8ZhMNKRrbfRFCw01Ev5AB+LxtLuMseRdp495rQ4A0N3hfjNhGWqpc/r8aheULbjfwgwNSZtX2wpp2+Qo+iprmFFnpydCwtB5Hy4Mq1o+4qy3sLUD3tuZCOAvg55wVKvGvFAW1NlUiZZbbyrflvFOWqBU7NMfZ7J+7lZ8sR2LXLHLplVkLX3AoFpMjoUxN/SSaS4vdmxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhq2ghCUdaEhIq2psSLJ3nZwQOwiMPL36i/ubw+f3Ec=;
 b=kvQvBQX4YTerUytD6dxhn8921Amjn85YzBNmBF6FCZ5Xvzi4s0IBrDbXP/azrGqHyP1XA5viVP6zxn9OEA1b2cxrDY2VKQs/Aus7enOt/qnIpzUDsdQUHqLKHTL1b9aIqBJIQRurTMPE5Br1KC9kBAcylSXdg73OdH8NxG6qblE2tGX5sl9PEGhkU52aAHvT2rsDvyiwHcOoStj1lKVN4YBDdXnkssTWhtqCSf/2OyaWPKaSuot8cPIE17qcwp7j0AFTEYWcY0Q4W5SJ9/9lspH9U77ePZWxf5mzKFbIB8ytdPLU12e09sWN2ytiLc90iDo3hHscNqH/p2rzkMmY4w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 18:39:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 18:39:43 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Thread-Topic: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Thread-Index: AQHZZ9XvHQffJBzcM0KcFulzpb4Rpa8dDE2A
Date:   Wed, 5 Apr 2023 18:39:43 +0000
Message-ID: <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-2-dwagner@suse.de>
In-Reply-To: <20230405154630.16298-2-dwagner@suse.de>
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
x-ms-office365-filtering-correlation-id: bd76a6d0-bb41-4fb7-73f7-08db36051fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YmpG/Ba7+cy/Jxowg1hRbKiluQCjgpFvI1eRfd/lRpCkRI7Dw7O+JBKabWmsCbfnw7h110QNsXfL7ttYjx32RArRgsFA1ZP8mkYTE+m7Mk9/0U2dFv4VlTpjwpTuI1qnI024JnB2fvWBu62o125h8JgeGgn9DEUbxGrMqbbCeQBgSeq4lOT4BBO/GXnmMmpgjlR9YO2t/Fmu39eTgMmnT7SSBjKDYQcsw78hUDufnOosDWSl1DeQhQ4Av72oc1jap6hMk4Rv8WVaknJt1Fd3ULULroyBFpsXLrHab85K/XvRDx7X+aW6l7vlcVeXeZ/mchDs3GeU5066oBAzAwgQWYLYdKkkOdWoCK6pLZNFfTufV0Ancasbap01CSEa2ZfMu3sxp7YKDz9TCJsXHJLmhNe7P4T/K7qGV+nDpPSsxkNoil8+YD5LuuVbUSL3PtgzXJxTwywqpzeRMhzQaVyUttA2CWlBYgE4aJpoBWHvKNLl3SglKekuG+nnL+z8foHOLzesEFQUMBp7as7q6ZKzB1UQ+4xhduNS6icP5r4XVdsUy9ibc72oaFJ16QOEAr7YWwhREohneQ7xN1dy0H0A9SyaXVic4CnXhkWnzhyIPlVTF05D6Avx6nRKrjDj9m9YMwUteS/VlHxnm2p/9IArpyTkGbxZw/7aT1rgEmbM38PotyH4XNpgpeFX6l0wf1eU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(31686004)(186003)(122000001)(38100700002)(36756003)(5660300002)(8676002)(8936002)(38070700005)(66476007)(31696002)(64756008)(66946007)(86362001)(66446008)(76116006)(66556008)(4326008)(41300700001)(91956017)(4744005)(2616005)(53546011)(2906002)(54906003)(6512007)(6506007)(71200400001)(478600001)(6486002)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blltdFNqWnRTQ2pDR1diSTNEWGVjbFY1REdDc09BUXFydW5HYjdBMkJ2czht?=
 =?utf-8?B?SFRuVXRwektaUzJHWWpkZitkdXpUTmErQ05xakpBdFZUbDJpeDdkdjBaRGUy?=
 =?utf-8?B?bWJFbDlqUmRkWm1SM1pKbXA4NlptVHRocVV0ZG1tYlBibnJ5YVRIU1BsSW1I?=
 =?utf-8?B?Q3VKQ0Y0MXRmSmRiekdCTXJ3S0sxdDVoUkxXQkxIelNVUVZCd0lEZFVwbzMw?=
 =?utf-8?B?RWJQb3B4end5RmtsOEtiUGlyWWloZjcwaW1TK3VwMDRidTh3RzlqY05pcHZm?=
 =?utf-8?B?aDluS2ZPSHpacE94NkdZa3FxTHJRbitTQlhjYkNURStnbkppT204bDc1Z0ZP?=
 =?utf-8?B?K3hpNllhc2F6L3Q0NWFsZis4SkhMSjdpNUlaVDJQWHVNc001elUwa3FoUmti?=
 =?utf-8?B?aGdqWVExaGRlOTd1T0hPNVBmajN1RUhERXdFRldsUWhKM0YyTjBGZ1VoQklt?=
 =?utf-8?B?Wkd3YXlBbnFXc01RaDdXSENsK0Y0aTQ4aWVNU3BHSDN2WHJhcWNTSEZHczVF?=
 =?utf-8?B?ZlQ5bk1jWjFRUkhxV1pOVGl0QndmdWlzNzd2ZjZOODFjQ0ZCUWp6MEhUT2pa?=
 =?utf-8?B?bEs4eWdSalZORGlRM3lmdld0dTlPVkJHY3BUL1pwODdIeWxDU00yaml5N0lX?=
 =?utf-8?B?VnViZmpVOVZTTFRhaC9WdFNQVDQzZVppcGtZT0NIem5mTi9yUytmaW5HTEpk?=
 =?utf-8?B?bTlvWWtieGw0UTVkYyt6bjVUNVBGQXo5bGlST0VaMkx4Z04rQXB1RjBUTnM0?=
 =?utf-8?B?WkhjZHpCSWZGOFRQaVpEVjY1a3JRcjJSSE10RHB1QTB2K1ZYSDhMS3I0bTYv?=
 =?utf-8?B?VldxZysvbEJKc3RrY1QxeWhCblV1NWxXbzUxdTFDWnAvUUV0akhZdDJTNmJE?=
 =?utf-8?B?L0w5VjNiR0FYT2NPOGFUa2NUTzJqN3kvc1huUjZjSWwrdTN6OWFTeGEvMFJs?=
 =?utf-8?B?aXB2U3hOdUl3dnVhY2ZabkUvNHowNmRnWHRKcXMyNEQ4QWpQQW1DYVVYeUV6?=
 =?utf-8?B?ZElDaGNZbmkxNGtDdHFzVE5wUzBZaWRmS1czMWZyYjdXRTJ4bXpSeFBtN2Fm?=
 =?utf-8?B?YzYyRkdFM29WWmRGajErSVVoVXBBTERzNUwyR0ZMck5hWHBxaWxWaHVLMkEr?=
 =?utf-8?B?U1lFN3JmMVNDQlM0UTQ0c3dwRTBEcHd0WTVrUExZYmpGYk9vOVZsUk0vSXRZ?=
 =?utf-8?B?M0N0emw2YlZ2RHJpK09PVGJGSkdTankxRW5BRndjQkNQM1B2N0hKNmJCMUlB?=
 =?utf-8?B?VXo0S0V6MDZ0VWdLbXVaajU0Q282M2Q1WXY2aGtpTGFiSVNFQ1FLbytzdnc3?=
 =?utf-8?B?NTUwNmdUczFyV09iWG5tNFBiTnpNcVBMVFl2T1hwSEtqOVRCMGR4ZzJOWHU0?=
 =?utf-8?B?Vk5lc2NQYm51Q3B1d1MzWVZvV1NmYTFkV2JRVm1BbzE3NkF4ald0WjB4SGQx?=
 =?utf-8?B?TEF4cVcvMnUvRFNNNVZsTjVsazFmaWFyVkRONVltYmxabUxuTDFFWU5BalN1?=
 =?utf-8?B?Z2lPdmRrZjg3K05OYlRUT3NJOEtXY3FjSmRxdGIyajF1dStodnJxS3FMV205?=
 =?utf-8?B?SkJqTkh3ZlhjcDEzRldhT204WndwY08vUVFFQnIxaGxvWk8wL2F3UWdTbSt3?=
 =?utf-8?B?VHVTbVZpTVh3Mk5lM2daRW55UXBCOEk3WHVwaHFKQTBleEFZZ214b1VlbGND?=
 =?utf-8?B?RTdTRndGb0NLc1BkRW0wQTcycU96RWpycVI4R0NGR2ZzS3R0YVlKNW9ScDEv?=
 =?utf-8?B?Y1gxMkg3VnhhVnJKVjBBelovVXgrOXY1N3QzRW5zb0t4TTNrTnNpY3RxY2du?=
 =?utf-8?B?c0o3Z0srVnphVFYwMm9XVDl6SFplYzJBNVlIMjFPNzEzSTM5U3J0ZFhUNXZn?=
 =?utf-8?B?UUFBaXNxNnV0QTZ0YmtJeHIyN21LczU5R2phRXdHQ3R1UlZIQ05xLy9JY3FF?=
 =?utf-8?B?YnNOSDhMN2JSYmRYbFp2aldPeW9TaEY2OVpyUk1EVVZvamhnbGZmL3ZrZWR4?=
 =?utf-8?B?ZGtlOG9yNVpFRVdjQUQxdmdSS21OOXQ3Rm83RHZjTm02V3MwSGh1aERQaHFO?=
 =?utf-8?B?MXY2YkFlWWdEOHU2RCtDQ1Y5OGpjTDlQOC9wWDUwVlZyY2NGSjRldUZkMit3?=
 =?utf-8?B?WXdNbHpVeG9BZnhKcWhMWDR4YjZodEFpd240VEV6ZXNwTGsyYVB1bHMzQjRk?=
 =?utf-8?Q?yFTB/jt5Cjz5D1c1wCqJr5LRS4D3a+ZgrE4jL43JAqQI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <864FD909E71C1E4CAEBF57AAF2A4DEFC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd76a6d0-bb41-4fb7-73f7-08db36051fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 18:39:43.7733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoEVNGYEDWHdwouNkeJlzIo5Jvmw/GqTGv9USL44WEpbexCR8rusyqHcD9SavX/4Y//Yy+77JCIm6OrNSXxWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC81LzIzIDA4OjQ2LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIHRlc3RzL252bWUvcmMg
fCAxMCArKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWUvcmMgYi90ZXN0cy9udm1lL3JjDQo+IGluZGV4IGEz
YzliNDJkOTFlNi4uZWM3Njc4ZGJlMDllIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9udm1lL3JjDQo+
ICsrKyBiL3Rlc3RzL252bWUvcmMNCj4gQEAgLTYxNyw2ICs2MTcsMTYgQEAgX3NldF9udm1ldF9k
aGdyb3VwKCkgew0KPiAgIAkgICAgICIke2Nmc19wYXRofS9kaGNoYXBfZGhncm91cCINCj4gICB9
DQo+ICAgDQo+ICtfc2V0X252bWV0X2F0dHJfcWlkX21heCgpIHsNCj4gKwlsb2NhbCBudm1ldF9z
dWJzeXN0ZW09IiQxIg0KPiArCWxvY2FsIHFpZF9tYXg9IiQyIg0KPiArCWxvY2FsIGNmc19wYXRo
PSIke05WTUVUX0NGU30vc3Vic3lzdGVtcy8ke252bWV0X3N1YnN5c3RlbX0iDQo+ICsNCj4gKwlp
ZiBbWyAtZiAiJHtjZnNfcGF0aH0vYXR0cl9xaWRfbWF4IiBdXTsgdGhlbg0KPiArCQllY2hvICRx
aWRfbWF4ID4gIiR7Y2ZzX3BhdGh9L2F0dHJfcWlkX21heCINCj4gKwlmaQ0KPiArfQ0KPiArDQo+
DQoNCnRoaXMgaXMgb25seSB1c2VkIGluIHRoZSB0ZXN0Y2FzZSBwYXRjaCAjNCwgdW50aWwgd2Ug
Z2V0IGEgc2Vjb25kDQp1c2VyIG1vdmUgaXQgdG8gcGF0Y2ggIzQgPw0KDQppbiBjYXNlIHRoaXMg
d2FzIGFscmVhZHkgZGlzY3Vzc2VkIGFuZCBkZWNpc2lvbiBtYWRlIHRvIGtlZXAgaXQNCmluIHJj
LCBwbGVhc2UgaWdub3JlIHRoaXMgY29tbWVudC4NCg0KLWNrDQoNCg0K
