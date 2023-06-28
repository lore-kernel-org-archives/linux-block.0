Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09D6EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 07:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjF1H4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 03:56:48 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:2257
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230522AbjF1Hyn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RagH3zWjR00P1CTGmAbQyiBAM+cgMkVt+E9ejb5Plp2uWpTREd7ze0pN8KD2nhamoe+ObUCLW33VFLOkuHfrrNUGXLHw3EZnHctJJ5sUY2Fu5HqFy2sIWcNdfIutmFjpG1ZoklORDoz3e2QK2fzrYkH6D5wj3lvr1aiufERDSlqgVz5KEZwzGPYiiaVKR1oQUAtWfJPeNXNU0WsNiSZthdDL+hg7ID23DVAHC9tGwDhhjPqm4J0Z/einrfQootym0GZf49+KRuDAVk0iIZfaoWV+r6WCuOttBUGNC5bwYlB6NTeDbaoFJrjtWxWpt7AyIG3L9rtvR/zjMHcqESGZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVyIpNbIk9bDvKdm+J5mWGKsAKCHI2SMie0ZYpBiLTw=;
 b=QwJx2hY5AwHkBIJ1Dv/eTnXfXYV44tAFYNWsvIhW9UjrrPnWgSL612Lz7H10qwOF2aRYKjAvdhUQQWhD38aJ8ixL3TmSTanTu0cC35othxVTkBIcb8oDHFdnrbS4uskwjWYJizGMUDIhf6QRRLet26eLokufPNSdhHxNSztC4fjPUW/OGaR2m568jxTU0Y0P/tD6XlFze45daM5DbdibKwsjGag+q2jtA1YoHdcomSFFCLz/yWDDDHEluYNvQ61fIgsHiIpqnSJiSjgILbqNg16+i5bq6uCMYh2RfzfS7CoHjUocnINGIrlM+8ED7eEhIO0vsLQmSGwq6drb+kX/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVyIpNbIk9bDvKdm+J5mWGKsAKCHI2SMie0ZYpBiLTw=;
 b=UARvC5F6PA6C4w0ryEtSldhtJSJeKBksqx31PXuav4NA0xcTyrOU/wrpCd1QVDSVkB6fVqOcdzft2XmiqaY4RJIdgq6pl8ytk9pHDHirJURSgo9wa1RUY1kz8bQTA5bzmyKQjdrMbEmfQgsrlN3sqVAFABkDJGTEmk5HyzB1RvSLUsI9w18mcHWr/0FZXAEZM7Xoz7ASLxm0mFtabENpdS9J/fbl1KW7MIJ/XdUzYIvFb267zCqVANENmGWxGqG4Ifj8soL0yDQBy5LPzeYkf9jJfz6XQdSV/GdIUJzVH9QPlkjPPGRkfjWH6kkXgQqPXxC1iGQm6SmsglyMoPU4GQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 04:07:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 04:07:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: blktests: nvme/auth testcae bug
Thread-Topic: blktests: nvme/auth testcae bug
Thread-Index: AQHZqXYKKv0icp4yukWU2n/X8YUTrg==
Date:   Wed, 28 Jun 2023 04:07:22 +0000
Message-ID: <6dfe85b5-5415-7140-e377-c1448fd7fb8f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CYYPR12MB8731:EE_
x-ms-office365-filtering-correlation-id: 6425f007-9817-44f6-e108-08db778d2cc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzaCrh8nqRv3OEbdnMf4kEStPuWv1bhqwzzulriiSiqO9HUXJ5m7tsY3olcS0S/qRUwxdK9L/kzwaqdgtW78YFxl1UUSlncK+dUR8s4T+dsJUEwIm/Fnz0TYvCplt7PfMinASoogDyWBVnQm61dJRRXO9F1qZcGFeqd4m0fPjh/jmJjDxW3LOYxUqcCRJmv5lXEBHIx8Bw9Z93kU4ql5Wdj5cyVYcLCupy7PoDfbnvPl/3Eh0mJ80q3hUrLNmMrG69I05TXa3qJck5EIdbJQxaSFMllXvNafNhqK+ZqIjOMbRczIa8gByojhwO0xrtOfVBnt58vGufidOp6B96VrBOHxEO/gqk7GipOiT7laVTxvuOvLGqTPMKeQVXDcRcx+TNiGIGOhJrMPAzJQHIPRrRv3HLr36RSHGfd0ar0BOjp5za8IWhTnp9m9yn2EF6AwNaKkibPM3jZX7eC7nzykwGHj+UWSqmNoVwsRlhCy9LS57fp8sqIZkLkG+sLPwzSNOq+sAomVvZIDmfQWYF9F1dnNJ4+NIoQtEMQmyc14lcIlXe85e6Q1q8ynKLzfE1LJ4UR76o9RS/RMzsa5nCD6Jr5yzmjZiT4L499arwmFx+a95xdM7Ol6uW1YtMCWtjrOCiq10SFsUS58fH3crPYLInk/klBRHAR0l7GkC7EN6mhd9kXQy8RkR/AGcXMGCgNj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(31686004)(36756003)(38100700002)(5660300002)(86362001)(41300700001)(66476007)(6916009)(8936002)(91956017)(38070700005)(66446008)(8676002)(64756008)(66556008)(316002)(4326008)(122000001)(66946007)(31696002)(76116006)(478600001)(6486002)(186003)(6506007)(71200400001)(6512007)(54906003)(2906002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjlDeWMzdExGaTFXNDE5eE9maTc0VEhIWnMybmhINWJNaElXaVlxVE5tTmI4?=
 =?utf-8?B?VkxqUDk0OS9sT0RaTm5YUEdZL3NKa3NXeGxyTEx0MjdQc2FEcXVUMDRlanJE?=
 =?utf-8?B?UGRyWDQzTFFDU1dFZlFmR3Jpb01tSTNtS2puQVY1ajYzbFpNaytJcmtSWjdo?=
 =?utf-8?B?V1BrQTk1aEx4cXo3SVFZN1pVRDQ2bmkrVzM0Wkd2WGtKeHVTaXFncGR5eUVi?=
 =?utf-8?B?YXFLdlByRTlXNXE2emhXeDBvMG1pcTkxdWNiK2FoQjh6YXk3UTBqZUxPYU04?=
 =?utf-8?B?bGJyVURIU0xFN2U4Wno3ZkxaQWJRcXo1aVNKSjJCUE9RY2JrckxOajVCcHZG?=
 =?utf-8?B?eHJTSjZCZWdnNFBHbXlXQjFyV1FlZ0VaNldPNkZneHZDR3c1K2RWSFB0ZWJF?=
 =?utf-8?B?RXN5WFB6UVQ3Mm1FYXlZajZHbW9zSFBsTE1CVERGYzNWTUIwOXRFRnVVU05N?=
 =?utf-8?B?akxzVGhIT2JpK3JaRVMzamxKa0QzYnpYTlpPT2tYeG5WZWNmcUFZc283VUZB?=
 =?utf-8?B?ZDgzamdSdmM0ZE9RT1ROZ0xpdlBhUHVmUkRXQ3RaTWV1RktxNWJVRlJISVBx?=
 =?utf-8?B?UWNpdXFsWGNwa2xYYzY2bHJlL2RRWmcwQVZ2TDN0NTRaV0pvWE9CQm5mdUFy?=
 =?utf-8?B?SmVZMU9iRG42RnJyQVNEd2pqSFdaZ3lRcEFPTHczUVhPQzZQY1pudnlUWkF3?=
 =?utf-8?B?SU1LSDRFZVc2SGE0WGNod0E3TzJNU00rV0RUeXNobHd2R3FMZFVmNDlJS3BF?=
 =?utf-8?B?NWFTc1F0a2xTV2tDVUhtcS83V0VHNHBJaVl0a21qejF0S2hReDhCZHVUNXYv?=
 =?utf-8?B?cENlY3h6NkFpdDZKZmhvZ01uM0hsMVpKNE5YWms4T1NpSjQrZXhheGFSQy9C?=
 =?utf-8?B?dGRzM1pzdWNHMnVKMWVxeHpNcU5ya05Ybk1zdUZhMkFrU1poSnUvbUR6VS84?=
 =?utf-8?B?SUVhQnlhQjlPWEhsL0lPRm5XcGczenJZOU5YSEg4K2pDbGc4WU10c2xJd3VZ?=
 =?utf-8?B?dVlDcFNPNWpmOTRWQ0x5Y3BvenkwTzNTSVQ2R1ltdGdKaGRJN3NLQ3BoNTFm?=
 =?utf-8?B?R1k4UnNWNUFaWStHd0NzZTVTbXZrNjlLYXJvWEwxUmMxV0pSYmE5TXNFVFM5?=
 =?utf-8?B?RDk0RUdkUmRQemd5RUxpcHNlVWxPQ2VwZWh3M2FUL3VndHBjZ2dmM0NEQUhw?=
 =?utf-8?B?Nko1c21BTDY2bkNYUzN1NkRrYW5tVjd5WThlMmhOTVRFbTkyMXIrMmZIUS9M?=
 =?utf-8?B?OVR2QXVyYmRkM2t1aTlMdElzd0l3SjNQMHJrSkhRY1hjWUJKMjhWTlE5ZXNZ?=
 =?utf-8?B?SHpOaHNFSzh3RVZXek8wS2ZSa2lra3JMTWVoMTczL0o4TmRZVWh4ekZpQWpE?=
 =?utf-8?B?YURORE1JWDRzUldFMDFlSFNLd2gxbG83NWQ4TCtiWVUxNDYrV3lha29ZZkls?=
 =?utf-8?B?L0JrVU5idW44OGZBTkZ2dEJuKy85WmIxSzRTRnRWKzN0OTgzVzVNMGpleUlP?=
 =?utf-8?B?RWIwN1B4L2NFa043YzQzcHJxbTRKMTBsa0c2aW5IUGVNejBhdDhsdHpDTGZL?=
 =?utf-8?B?RnE1RHZOOTMwZlRCcnY3V1FibFNObUx6alo5QXhNUEl4R3BGUTlUWm5TZkg2?=
 =?utf-8?B?NStnQkhUOVljZkt5Q1pLSnJHd1oyYjZBS0paQUNFaDZLak9uNTdCMXFmV0ZI?=
 =?utf-8?B?RnV0Q0RGcjlBS3pWK29zY0tUaWdNMmxySy9TT1BUVTZvalNEalFsMVVQblFv?=
 =?utf-8?B?SDJWcGl6UE80VUw4WHRuVVE0LytiUloxcHNyVGJLL2FPOWlYYndSLzFTMGxP?=
 =?utf-8?B?MmtZREt5b0hRRWY1YlBBYzhiUFBSWU1SNW85SzJxUkNUYWlRTFVnZXlUdWlZ?=
 =?utf-8?B?dGNoVmdCZVJJclpNMWplVTZXeGVFN25RZWlDdk84ZWpBTi90bjhudDhxM1R6?=
 =?utf-8?B?WUVObUFteTBOT25LeDFpSlR3RmpQY1U5M3J0aGtWcXNqUWNFMkpxRi8zWlVk?=
 =?utf-8?B?dXNLYzNyampidm9iTnNmRHhDcVoxZlRLeHc4TDBrMkJkVkx5MlBFNVpaYkZD?=
 =?utf-8?B?cDh1NG4xYURvMkg3MEpDTm52TWROb09PU1VTeDM1MDhwUFc2aVUrblFoaDdq?=
 =?utf-8?B?WndudU5JeVlXWjBpam5vamFIeklXZGxjZVdpVXF5WjRleko5RlV3ZzFhQk8w?=
 =?utf-8?Q?GR+BqWxz2RCjqoE10ZCChoKUmGjodmUnwG3KylljJ/lg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DEEFD95C507D948A0F3215532769FE3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6425f007-9817-44f6-e108-08db778d2cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 04:07:22.8302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kApcJEJi677sb8FkZKYhfkZl9uK1cDH0DeCviguS2JDLK9GGraZTrmbal34TXlZ9F0d3leG0PxthlwAmikQcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgSGFubmVzLA0KDQoqIE15IGNvbXBpbGVkIHRoZSBrZXJuZWwgaXMgd2l0aCBnaXQgaGFzaCA6
LQ0KDQpsaW51eCAobWFzdGVyKSAjIHVuYW1lIC1yDQo2LjQuMGxpbnV4LTAxNjkxLWc5OGJlNjE4
YWQwMzANCg0KKiBXaGVuIEkgdHJ5IHRvIHJhbiB0aGUgdGVzdGNhc2VzIG52bWUvYXV0aCB0ZXN0
Y2FzZXMgYXJlIG5vdCBydW5uaW5nOi0NCg0KbnZtZS8wNDEgKENyZWF0ZSBhdXRoZW50aWNhdGVk
IGNvbm5lY3Rpb25zKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW25vdCBydW5d
DQogwqDCoMKgIHJ1bnRpbWXCoCAwLjQ0MHPCoCAuLi4NCiDCoMKgwqAga2VybmVsIDYuNC4wbGlu
dXgtMDE2OTEtZzk4YmU2MThhZDAzMCBjb25maWcgbm90IGZvdW5kDQogwqDCoMKgIGtlcm5lbCA2
LjQuMGxpbnV4LTAxNjkxLWc5OGJlNjE4YWQwMzAgY29uZmlnIG5vdCBmb3VuZA0KbnZtZS8wNDIg
KFRlc3QgZGhjaGFwIGtleSB0eXBlcyBmb3IgYXV0aGVudGljYXRlZCBjb25uZWN0aW9ucykgW25v
dCBydW5dDQogwqDCoMKgIHJ1bnRpbWXCoCAyLjcxMnPCoCAuLi4NCiDCoMKgwqAga2VybmVsIDYu
NC4wbGludXgtMDE2OTEtZzk4YmU2MThhZDAzMCBjb25maWcgbm90IGZvdW5kDQogwqDCoMKgIGtl
cm5lbCA2LjQuMGxpbnV4LTAxNjkxLWc5OGJlNjE4YWQwMzAgY29uZmlnIG5vdCBmb3VuZA0KbnZt
ZS8wNDMgKFRlc3QgaGFzaCBhbmQgREggZ3JvdXAgdmFyaWF0aW9ucyBmb3IgYXV0aGVudGljYXRl
ZCANCmNvbm5lY3Rpb25zKSBbbm90IHJ1bl0NCiDCoMKgwqAgcnVudGltZcKgIDAuNzMxc8KgIC4u
Lg0KIMKgwqDCoCBrZXJuZWwgNi40LjBsaW51eC0wMTY5MS1nOThiZTYxOGFkMDMwIGNvbmZpZyBu
b3QgZm91bmQNCiDCoMKgwqAga2VybmVsIDYuNC4wbGludXgtMDE2OTEtZzk4YmU2MThhZDAzMCBj
b25maWcgbm90IGZvdW5kDQpudm1lLzA0NCAoVGVzdCBiaS1kaXJlY3Rpb25hbCBhdXRoZW50aWNh
dGlvbinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW25vdCBydW5dDQogwqDCoMKgIHJ1
bnRpbWXCoCAxLjI0MHPCoCAuLi4NCiDCoMKgwqAga2VybmVsIDYuNC4wbGludXgtMDE2OTEtZzk4
YmU2MThhZDAzMCBjb25maWcgbm90IGZvdW5kDQogwqDCoMKgIGtlcm5lbCA2LjQuMGxpbnV4LTAx
NjkxLWc5OGJlNjE4YWQwMzAgY29uZmlnIG5vdCBmb3VuZA0KbnZtZS8wNDUgKFRlc3QgcmUtYXV0
aGVudGljYXRpb24pwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFtub3QgcnVuXQ0KIMKgwqDCoCBydW50aW1lwqAgMy42MzBzwqAgLi4uDQogwqDC
oMKgIGtlcm5lbCA2LjQuMGxpbnV4LTAxNjkxLWc5OGJlNjE4YWQwMzAgY29uZmlnIG5vdCBmb3Vu
ZA0KIMKgwqDCoCBrZXJuZWwgNi40LjBsaW51eC0wMTY5MS1nOThiZTYxOGFkMDMwIGNvbmZpZyBu
b3QgZm91bmQNCmNvbW1vbi9yYzogbGluZSAyMTI6IDBpbnV4OiB2YWx1ZSB0b28gZ3JlYXQgZm9y
IGJhc2UgKGVycm9yIHRva2VuIGlzIA0KIjBpbnV4IikNCg0KSSB0aG91Z2h0cyBpdCBtaWdodCBi
ZSB1c2VmdWwgdG8gc2hhcmUgdGhpcyAuLi4NCg0KLWNrDQoNCg0K
