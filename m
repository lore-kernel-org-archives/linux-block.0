Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCA257B
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwuaboTm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuqNzPuidP38oA4icZN7Hl0ICiOEHjyWhVnl/TYpJqLigqSTSAI4THHVw0Mmr9dmi3BQ1KuzKrs8mLa5sF5MVcZUrT2Nf3/GIUG1VDgkfAkHh/TLBTo7I9NHrTbPxO4EC9u/VYh8s/cjdazzzuK2u+gEXMTNSxKmUKUTHLoSE+Y4bbAIVriCBxy8WMWMuVCFini5M98M/AQztG+PWm2V0uya4m3KlzwemQgNvFvRXw4n0St1P90rnsOKUw8S6lpQvcJGzWr0DcAUfIxtAFcVMXx7zn5TD8ugap/ApNMGJ6u/Acz/sm0Lcx8qpl7BMZJ15kzck4INRigv/+wYNImWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAQnGRzKCN7v/LF5Vu5Oex7KTNlVpZUH92R50PlCv8k=;
 b=Ot/hX4iGBx/ZUhYmK6uOYvdvHY5XMBTUmsTs4cYmEM8gsDKhu1hwORBq5m7BcsWdK1N0DmBvlDnTgu+pa7SKJFwjTE0TMn2XX8WcW9ezEpvUx4mt58skZN3xKQrtyVYXrNZcLDMSdfyVKjD2R9dnYSK9eXBuc/qsegJHtgFLYW+3Ojz54tzVT6TIqmkeVVJN1DV4CStJOS8jWQrx7GEjbhQoE8teiUMDt71diaKDs6+DuD6PSP4jnKS5MO3+2+PTQiSwJQhZRNFyHg5WJyvv4jKaAfX9vJ8N0H7BzyTVgsZhKzcR/HahqEIPlrUX36DBr3pS5/CjwglcEPKT6txX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAQnGRzKCN7v/LF5Vu5Oex7KTNlVpZUH92R50PlCv8k=;
 b=NwuaboTmEp2LpNgBrg54j2f4sDGFR3n6E5E+LahOoX9bZ3B9cuW5thSKkx/7PAKnzwIDkJDPsuDKM//0chAoKeIgmdRkNjzMnwPkWKQRT5cKFo4qLbiMW2WUPGyGK2mK4gb4u4c0ctza8ziz04V+m3aiRAXqg21sQ28csksexLX1aDGrRNqRwpGTii+znJusBJanW3rat9GBqHbh4EGm4GvIop36hBRuNzK3Z1LUklRZQI1GMmfdA24a3HxFytAQRBTxP+VqzyWpfdh1viycoFMs7OY6wBWLUOJ/xlCBquhaqrSpfjOceZuYJmXCSstfEc4xfPxUvF94Gi2uJmyEqA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:20:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 03:20:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: move __get_task_ioprio() into header file
Thread-Topic: [PATCH 1/2] block: move __get_task_ioprio() into header file
Thread-Index: AQHaQmUgEMJGeFsU3k+RBzGBiIQAiLDQ0N8A
Date: Tue, 9 Jan 2024 03:20:45 +0000
Message-ID: <67eff704-581b-49eb-b293-0ed5084c77b3@nvidia.com>
References: <20240108190113.1264200-1-axboe@kernel.dk>
 <20240108190113.1264200-2-axboe@kernel.dk>
In-Reply-To: <20240108190113.1264200-2-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW3PR12MB4489:EE_
x-ms-office365-filtering-correlation-id: d4719f78-e688-46be-392e-08dc10c1f7e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jkmf6MWhcHbl3NDg3J8F6sAb91wBUR67AV7fQw6CsrE7vUGIaiZDzdiBpJ7xb4/wWnHInRdeQdKM3BDzi/zb5WcjnU7zYFqgSX1x4YvtwYkTBL90+6TBhQakHjDDXNhWIdlSZJaO71AGpuLANhGKtsxIhYSY+V20fb9iHoWiIds7MgS8/xeIdLQyFuoLSbYo3Y49DK0VE81t9KazQOCrDLXznoCtDW8JpC4LGQOVje16LYV6HzPmdVsQWJJ8yneMTuGrop30w0qHlzkGYECGhlamBgWba2978G+VMZav8ECZzHY5A9V/4w72hCWqE3D4xZ/OiMVJHN3fiPciAojfWGIFXneOqWD3FuI+N7in+XapxsQs6ZI4D40fchsqk2PU0f9DIqP9Sj2WMQnjPwY0Q/L2FKiz+Xv9BNvBJSJTPLvd/yoBJX2y/a4HgKLe5uzpBQ3rn0ZdcqN5QgeC0c5iOjgnMNINW0cbDHW+gNMYvAOx20PXn5sbJLzR3kVA9FWEn+ss4hmabCAXV32K0k5ueICoYRX20ufnHPM8JOqJoN6abfG/nJZtsIOpff9zaO+h/Lck51tfpYuxS+/NCErvWjX8oXQsOvknuvMrqP8wRyDSJUpN1p4AxEPPIQ7SqG2UmXJzQc+KdG2kuAZqYbToHd36RydINwsvB4iXVJRFrKR/eGZDzJqdg7g8nDMMCQsS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6512007)(26005)(86362001)(36756003)(31696002)(38070700009)(38100700002)(71200400001)(4744005)(5660300002)(6506007)(53546011)(2616005)(122000001)(91956017)(8936002)(8676002)(316002)(64756008)(110136005)(66446008)(66476007)(66556008)(76116006)(66946007)(2906002)(41300700001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXJQSmZnOXk5WVFzOFk0WUhFYnpDUzFMbjBXMXBGd0xhSmNRc0ZrVnNGa3BQ?=
 =?utf-8?B?MWsrTG5mbzBVeVpwemJ1VmNaUUc1Wk8ySXhodWZTd0FSRkEwZEJWYnduTnB6?=
 =?utf-8?B?ci94cXYrOUJCQlBXTU9OV1JVNXM2Rkd0TnMvdEhwT1lHalozWCtRMm1kbWFS?=
 =?utf-8?B?QzlmRzBCM1QyMXFsNDc1a2VDYzBXWWdWVjJRc252STZEclN1SVJIdS9VdDhr?=
 =?utf-8?B?aUU4NHJ0eURUWDdZRzJISDJ5NFprby92TXl0RU5GTVNuVk9WNVNEUDQ0K1VR?=
 =?utf-8?B?NXB2aVF5My9rclZQbUxoN1dRMXp3VTIwRkhEYjZaQXkreFJRdzBtQjFvQzAy?=
 =?utf-8?B?K2oyMmJiekczUmlmbERzSlcvQkpuaEFxYkYwSW5hZFYvMHhJcTlBblRXOXJC?=
 =?utf-8?B?WDdlc0xMK29UZ0d2aisra2tvcGtKTkZCOU5CY2NYTUtzbUttbjZsdU94Q1ZU?=
 =?utf-8?B?SHZqamlxMzZtR2hjdWY4ek9LU3J3d2kxdll0TzdTOC9nNjJ0dTdkUVJIbzRm?=
 =?utf-8?B?elVGMlBnNE9kd1dMT09rbERodHk2K210WlZWMFFwc21BVHc3V01uYzNHdUR2?=
 =?utf-8?B?WXZ4T0dmaUg3dEJvRGt1NnM4U1hyZEJEakFOV0piRThFOTNUUUdSanQzUTFX?=
 =?utf-8?B?M3IvM2poNElQeUYxU25IRTdMWVpFa2x6UXlNL3hOb1VCUlRKQ2IrQzZMZ1dO?=
 =?utf-8?B?aXI4YmQ1TmxUMWkyR0RSRDE0aVFGRVhDZjJPcE1Ld1JNa0Z3dnVRRzRISFR1?=
 =?utf-8?B?QlI2aEVReTFibWc1aUhBVUQzcmNVME5tL2ZKRmRaYnBvZDdjREZLYlRnWStZ?=
 =?utf-8?B?YWZob1BvSEMycVQydFdlTklJRVo3T25LeVFpeHNuK2MzWmtITWs0OUV4ckNY?=
 =?utf-8?B?R05EbENteTRFS2hxeEh4V2pFTWpxWnlHa1JyQUlZaThERTFLWDhITGVoNnlG?=
 =?utf-8?B?TFhGMjhFNVhEc2x1LzVmSUdDMTZKeWlleE9hbEo4YllRd20va2xsR1M2UnVQ?=
 =?utf-8?B?a0xDQ3pZR285elZuVWZDUnpxSmhRWEl2aFk5ZjZjcCswdzlWWTE1TWZ1cVcv?=
 =?utf-8?B?M2pkWWhiTlNEeVRTQUtwV29BMzRvU1lIaC91dkRPN1dzd1hIbTQwSk53SGpG?=
 =?utf-8?B?UHlCYWhVZEpXVlczanI3RTFNMFoyNnUwNUVWWDhDUWRYcUxjVWtZcUVKOW1o?=
 =?utf-8?B?Qk4vK0g4OUJCeUVOOFdnY2FNRHJLNEJnVWZsaE9aRVZpaWsrakF6SEhRc04v?=
 =?utf-8?B?UVA0akt5MTIzcFNZWkNWRUJPeEhxL0xLTkhYUnNRaVVlTFlJRjJZK3F1ci9v?=
 =?utf-8?B?aXlzdTU3VjZ0bzFBdUJpSWgyQjFXcWlpSUsrTlJaUFBmLzJDc3NkZkpaazFh?=
 =?utf-8?B?Ym1ZM1hzY1BSbkV3RWcwNEo5YWZsZ1pRS2hnWVJSaWptS2hwSGVaMkhBR3dI?=
 =?utf-8?B?WWprbERRSDNwQ3RzeUVySEc5NVRwMnk5SWRmaDQzS3ZUcDZGOFNuclZsM1h3?=
 =?utf-8?B?NEZoRGgwejN0eFdsR0swOURCM3JBN1FhZmFiSHh4QXdyY3hBUkVaVml5dGhn?=
 =?utf-8?B?VVYwZExLcmR6Rkt4UkFrNE5qeFJSaXVsRnI3NlNMT1BGM1MwR1R1dnkxTXF5?=
 =?utf-8?B?RjhmUHJhajRLdnIzY2N1YVRTWVFLMW5GRnRQV2FRMGxJUWlSWTgySGNOMnRh?=
 =?utf-8?B?aU83bldvWjFVbmtEQnFVMmhmZDk3VjVWWTJIekY0Zmg3c2ZiWTh5VHkxUk92?=
 =?utf-8?B?bERGVlYvb3llRUFHTElXcFVHanpiRHNjSjZMeXVKK0IvWmN0NURxQVlRWWho?=
 =?utf-8?B?NC9xUS83TkFNeGhFSCtNQnVjRDNqUzkxdzB5NkpDT1d1N2NtU210RGVpTUlR?=
 =?utf-8?B?K05FWlhDaUNyenBwY3RlczlqY1FacVZhNTBiSEtnME9BdXdUZE01MzJWRUl6?=
 =?utf-8?B?S3RkUkN6N0hJeTY5L2hsQkpKbWNXaFVEVnVRSUM1NVBYY3k0MHpTNUc4bnd0?=
 =?utf-8?B?MVROaUJHUkNSTkNvcmc5elBVTDhXQVJJbU5nVzcwb2RoWDd3eGJXanVadU5G?=
 =?utf-8?B?VmJubUw4Zm5XME05akRqWGVScURvWVp3SzUwL0l2Sy8rZHVIWS9jVGZMSDUy?=
 =?utf-8?Q?XcymESgNLQtB4qCDJV45TnQnF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6DBE98C65A79145A561B7AD356A63DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4719f78-e688-46be-392e-08dc10c1f7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 03:20:45.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mnc3EUy45dfEqwXlgGpagT3EfIi4MhZQx6ZcOsWK4DpNjB/XerIaKexDgBUYN3hkf+MNZlXA2JHx24l5DUwRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

T24gMS84LzI0IDEwOjU5LCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBXZSBjYWxsIHRoaXMgb25jZSBw
ZXIgSU8sIHdoaWNoIGNhbiBiZSBtaWxsaW9ucyBvZiB0aW1lcyBwZXIgc2Vjb25kLg0KPiBTaW5j
ZSBub2JvZHkgcmVhbGx5IHVzZXMgaW8gcHJpb3JpdGllcywgb3IgYXQgbGVhc3QgaXQgaXNuJ3Qg
dmVyeQ0KPiBjb21tb24sIHRoaXMgaXMgYWxsIHdhc3RlZCB0aW1lIGFuZCBjYW4gYW1vdW50IHRv
IGFzIG11Y2ggYXMgMyUgb2YNCj4gdGhlIHRvdGFsIGtlcm5lbCB0aW1lLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+IC0tLQ0KPg0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K
