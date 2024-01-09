Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EF6D6CE
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLguE/2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMdJs4S//ktYnXtl7nwzL9Z1v4eEzcHFPE8VBoQLfF+8lLznl60RGAxaeg+rVShOSGIFJYi6M6mBlK0W8vFVRhaF8muU/aR3cVmkknOgHrBXR7jDZYxTk+JCUfQZrIKlUQI+lni13Wm1r0lsPIaMxl77syga5275kWwaKPCZ1J8561WHQdK4AhczMh3d3a1eW9OKPxM50PdYaIO3qsFyhAreU0D6F8hlHh84wsVXgnvG2XPSf8hbLIMge4tO691OQRNXDidAhYNuOg9wnYLYLvcBj6OqYbkCkUq9eDUmn1+GVV87ptgPEePPaOnmhVr62anYCyI3ElzYQCwOYV1ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpLNyrrA4aPooJpp9U2eQgvhsODxSHFLZqaECPk4glM=;
 b=SWGARDvI3jXP1i276zAv6Cg+16LCv+U0DThxt543A3Ey+JW/Kx3qzr6JXia0XTS/WF87Z/trcmR7am7ZDBreJ9XxibBZXcGLYiEnBTvYuTZtJiM/C5EJrT4ccPPuP3JFDCq6MTyLiusci1+hrX/h+etgXUjukrlB/sS0BImav8myLRafaaZX147INCU+PDlYLGCjzJO1l1jSbhgJ0SqAFg4Qrz/GJnaecxej2FHbXAruSD+C/qR3f3XQQu6Y0vweRB0Ks702BJI6YZlOlOIOGQpoC2UHn6SNdMPLsAe/fpP30/Iyn6TMYvexlNVGHwb5lUKr+lGkTCqCi6CZb/mC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpLNyrrA4aPooJpp9U2eQgvhsODxSHFLZqaECPk4glM=;
 b=fLguE/2HmsCWT2d8mlYeU2ndzGuqNRpqqhwQKt98O5/KluSoJbWAjt1nOm/9OAWuDeTWpt65+19e8BAfzxJPDdIK7GdoF7kjsHfmvFhjhC2s0Xuq12I2zehqJJRaf2d/MW+0CQV46ITciR8L3AjFhZpE9FtrIB2rhara44RD9SLV2PqxriHIyq3PaO+Cri0l+XYdQq9+3eBL+Ulj1OrxvqVfwPbrdIQuPHuMqW9tzlNUeG5mScFEDL15MTSSq59TaxrGX4iPJlv0AJMOUEVK/cfcrWDCriouW7FROL71w00uaOFZBdVej13Kfff0duJGyDvjtb8hD0rTRCS/EdnhRQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:23:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 03:23:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: make __get_task_ioprio() easier to read
Thread-Topic: [PATCH 2/2] block: make __get_task_ioprio() easier to read
Thread-Index: AQHaQmUhfkKGap+fD06oc+E5/HsJBbDQ0bGA
Date: Tue, 9 Jan 2024 03:23:41 +0000
Message-ID: <254738c4-2c58-4e4a-bb11-44ea36c3a9af@nvidia.com>
References: <20240108190113.1264200-1-axboe@kernel.dk>
 <20240108190113.1264200-3-axboe@kernel.dk>
In-Reply-To: <20240108190113.1264200-3-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL0PR12MB4883:EE_
x-ms-office365-filtering-correlation-id: 1516ddea-cd5e-467e-1062-08dc10c2610d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dChWEdNjHBpHQV6SfjJAo9j1CL8GWUUZefTjKa09/kOIkTdEdnJUgnjWIbzX8ix9F3Ay90bFA+UV3hhFasZxhDmn2ftdah2XJbvuCZBLTlwuPhPg0pexkD9LkZkoL6ECZgey0qxJ5chAoBrwdGmaHcB4ZSdX0No4cQw+ND5io72xf2OiI0UTzuTLzNHyhVKaLsa9VVwaiRwYTu63GCvCHrShN8/xvTREn+1QYBhlUJl3vhiHliRvcKOsi5o2jlFC+VkXVPWRE/F13awy3FjF7rxk7wBot8rhxQvYT9LxJ/qg5bT1xAh+7GdfT0CLJ4q2BUw7YtKTRa2jgl46cIbuOWid4OJCkQwMPsIJPkrnfe1rjd5+9KsmsJBp4QsLWPDFtCi8m6emfvGXFqzPsT90HgDfoLitQdQTndn1mAXq3VoF6WQv+j3QbCp6PHt2veEq5sTPDq7MjGVhqsfHOamraKOQLfKg3janLcHXn1rqQA9t8aLENvJAgCAcoLFm+e1/2lsDXpEN1xJ4wWSlkxPqyIHucH6NggJJI9+WnNxZdKq53MJVXtpyO9iK8DIFENYCefNugbuhB9ZnGe6d+/xidFMUBq8UbFpj820iqKubRN0zfUjyKRUeYWmhdag0wBm7zo04EuBnaw2VJ1u7zljzI7YELMVPZm0XMsLOCq9d4Iw+IjP4MuEzuUnEKUCRkRGh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(31686004)(122000001)(2906002)(5660300002)(38070700009)(41300700001)(558084003)(110136005)(36756003)(6486002)(53546011)(86362001)(6512007)(6506007)(316002)(8676002)(8936002)(66946007)(66476007)(66556008)(91956017)(76116006)(66446008)(64756008)(31696002)(71200400001)(478600001)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3lML3g5RnEzT2xxNjlPMzF1TjdXSndkUWhMUk1OMC9BYmNEK0dsSGpaUVBU?=
 =?utf-8?B?V3c5M0lnQlY2UGxSY2owcXpRRlNpZmxqNWh4V09pc1JYZ084N2lBeHRDVW0w?=
 =?utf-8?B?YnpiSWlZNlRCNGJVVUM2SkpRYTNSdmtQNzJSTVVqdEpuUy9ESnhRZ0cyZUxD?=
 =?utf-8?B?dWNkWU1pdURnVW5DSnJsaHdXNlNCaTNhUS9GTlg1OEdQVVZjR29oV3h0U3Ji?=
 =?utf-8?B?dGNVMG1PZlYwVWsrQ0xqVFJKR2J2bWJhL05hU1hObHNibmk5OXo2TWRwdkRa?=
 =?utf-8?B?TlVpUHV3UzV2SDVRYjVQQUJvemUxOThXcGI0R3BnMHBHVXVkd3BnbnR3d29S?=
 =?utf-8?B?OXBiYVZKTFlhNkFTMWhGcytQVEQ1ZHdabFBZbGs1aDROb2VnaUFjR3h2V040?=
 =?utf-8?B?dDFSa0hLcHJ4TzNBMDhOVk9GTkVnWWFXUkZSRUZjSkdZcThwVk1UeFVSQ2xE?=
 =?utf-8?B?b1EzNXZmelBnSHd5VDBGRDNKbzlaTVR4WFQ3NjJNL3loekNuZjBoRHlCQzRH?=
 =?utf-8?B?amlxYzgyelZWWmxyanlxTGZJQjVtVVR0dE5mNkpJZUhXeVczUDlaRjVqZWZm?=
 =?utf-8?B?elRkeGVQc2dFaFo3WVFkNWp4WmFZUHJ2V2hPQmp5VEtLQ0lXR01jTGFwc2Vu?=
 =?utf-8?B?QnBQYitrQ1lXZmxBNCs3MGZnVU9OME9vY3FQUDN5SlVmbFZPRDBVRDgxakdT?=
 =?utf-8?B?WU5KMS8wak1Fa3RNVlpUb2w1eGliL3dGYzZVOG9Zc215TWJ4eXN0b04vdlAr?=
 =?utf-8?B?YnNxbHdMeTM4T1ZXRGVlWTk4eGgvNmhYZ2ZMYldtYUxYcmJLQUVqTDJPOGth?=
 =?utf-8?B?MTZmMEVxSEVPRmUrMHZjSmh2L1FzaWdERTVuOXlxcEdwZ2k2VFkzRnZHMWgy?=
 =?utf-8?B?MGMwMHc1MVd5VnBkaGZvOUxUZlBsOElrV3g3Q3U4Qk8zUFRtUUFadWt1YUVC?=
 =?utf-8?B?eDJraWtsYzdsdlp1a2pKTW90Q2s4UzJVSmkwWTYwK0hScGYxVnlWNGR3UmZT?=
 =?utf-8?B?S21CbWNpd1owVXlLeldkZHRLeWRJQ1FEVzZyNjBmQmxSU2ljWVpIcEE4MEZS?=
 =?utf-8?B?Q2pwN3NCNmNUUS9IcTRyQXZIZTJJUldYbGt3SVJsWTU2djFzZTF5YTdSUFdG?=
 =?utf-8?B?Qis5ZzZOa2wvUS8vRUJjUzRmRE1sSDFTZ0VVSG9HNnQ5OGREUi9MNVkvMkxu?=
 =?utf-8?B?cm8zY0V3K0F2WkhjMUZON3V3RXI0NUd0NFdudEpUWnI3TURlcnRwRGI4WWVu?=
 =?utf-8?B?L0RpWTJuODdrWXFiS3pDbncweWtVZDFKa3dwSjZ0d0s4ZFRnRW9COVlNditJ?=
 =?utf-8?B?ZzNHRTIrc1REMjlqMjFKQ1dFb2QzbnJCOVBmVGxyVEUrRklHR25CbzhiekJ4?=
 =?utf-8?B?V1RoYVRWdCs5c2NBS2ljN1U0N1dxb3dydUZmdU5lVDlJNi80dUZlVWVkVVU2?=
 =?utf-8?B?ODZCVWphS0djWEFlMWpHTnRTWmxId1owWk40eHRUZEtsN0ZVeGxldDJBdG9p?=
 =?utf-8?B?eEV3T0d3L3Rrbk1CU1FlN1dLa215Y1MxNzVYMGdza1dtclZVSGNySGVIajVG?=
 =?utf-8?B?TWZHMGtzenhPVGdsRVZwSTByVFR6RVBheEkzeHBXcmt4U3RERS9JY1cxK1ZE?=
 =?utf-8?B?MHYrRlpaa0tKcVdvUW14ZWpQQkFocjFWUkRDZmFiRkMyZTMxZkVyV3dPNjE3?=
 =?utf-8?B?b3VTenY4UjA3cGU5MkY0WjJEWmNXZnhiS1c0WjJnaG1rOFFvZFRONysxSnl1?=
 =?utf-8?B?Rk5DeWx0SXoyQk5NYUtIUHNSU0orUkNiY3NyTjd2RHorZjZOYk4zMHZLUUVX?=
 =?utf-8?B?c0R3YzJzaWZ1Wjl1VnBVVXk2WGdJanFPNnJqMHhqaHJ3b1MzWDU2VGhLdEFi?=
 =?utf-8?B?UTk5eGpzRWoxNlRVeHg2MXpuN2lwcFhSS3h2MkNVdXNnZyszSzl0SEt3Sita?=
 =?utf-8?B?cWdUL1FZUVdOdnhydHllVTB1SzVnR3hCNktSVlY2aUk0RGRSYTFFVTdFYlps?=
 =?utf-8?B?UEJoMEJRbmNtdlJ3djEvYnI4V2pnSWxxTHRXNHJBZzgreXVVUld3ajk0RHk1?=
 =?utf-8?B?cW1PTEM4bHpOVG9oRXBDM1M5dC9wNkNhWkdYTnNZeFgvbUNoZWIvb0d5U09U?=
 =?utf-8?Q?Guhsc78fS18ZIy4mk1y/IF6cC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA5185A25779BD409EF18A483541CF57@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1516ddea-cd5e-467e-1062-08dc10c2610d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 03:23:41.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bv+cjtDgQ4H3B+/V0dyKgRvM/jBir/czgVN8nKqWgselcCKOgChVHBWq7UfYTJUJX+soczjaSyFBR1wKHjxdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883

T24gMS84LzI0IDEwOjU5LCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBXZSBkb24ndCBuZWVkIHRvIGRv
IGFueSBneW1uYXN0aWNzIGlmIHdlIGRvbid0IGhhdmUgYW4gaW9fY29udGV4dA0KPiBhc3NpZ25l
ZCBhdCBhbGwsIHNvIGp1c3QgcmV0dXJuIGVhcmx5IHdpdGggb3VyIGRlZmF1bHQgcHJpb3JpdHku
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gLS0t
DQo+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
