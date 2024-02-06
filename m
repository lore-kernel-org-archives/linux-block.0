Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F61C692
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261000; cv=fail; b=vD2cQ3FFA7NvX+F3T/Tk/eAS0S/f8GaG5EV1/EVRAQpr5hMI1SZNCBnuPp/+22/+FheqYnW2ylCpxHI6iTE7HTgsC74zMfFDafGLkUdOV630B42EEUdwlRcEvWxkQnePl6uUwIhdVMWfiKlo+GvL8j9lLKtUfTcY/IJ46dpdUx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261000; c=relaxed/simple;
	bh=wmfkVaJoyFFIN0/+5yS/Ldl/EJqXqVKUpejSx04/1Ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDVIDrOpegzS9yaKwulOpU1TC7z1ZaQUXw6NwJr6sNiRIAAwUd5+3wpZ7kKZXmj0e0Jnmjx/XCX10zMyEZJzwyMULYeM5pfldyUV0vd1PY82KEU2ad2CtO23Vf9Xp3d44xPWOQOwdvOXcYgcoUVdT7wgXB2PAfcHDwlBgy4+WjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KiLfZy6Y; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KiLfZy6Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJUWzg2E8VK8eqElGhRjXd/jlyPa0u6y57dCOxBPlei4parqncU1hdWH2ICgl38ZwRyKkHKMaInfugm1YkIaxmqRYNNXVHkrXcWkuRci5snj1bIbPmSuzt6KxoRW3pcjAGfaQkI8ZM0dQcP1g1CXgbkGTQ9QiZusA66bunq9dcfr09y3YPM46PbNogrV1zLXz2LuXr+cW67RAEgW2ekiBGtZ/L2pdUOQoeJ7Vi125cCen+9sWiTDv47VNAcPyhsY3rV2fU4LrJvJ9+4IWQ4SFd/oJZqcoqHOH95o+s93zouhFqgms7LwXtCb4cUKoPNWEPED6w+P6OVv7Wl5jGv6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmfkVaJoyFFIN0/+5yS/Ldl/EJqXqVKUpejSx04/1Ns=;
 b=YoJTAQdKF2hjxtPTGQsg+1iHGKMVQffct6IbW6Incw6FWEWtnQ+Cw+DikqkX1CebIRf+bv4wlx3V9GlP1kSJDXFVxz28vIcS0NwHemVkTr+deyrSTNE6uRznXNk40m2cBIfJMKjgZLfF/ocSmBLH5mvFuclEW1QZyjTNKW9jBNllaSyQa8YGWork5W82DQ07YFyRVSx0rfQoF/48luMSRLKf2aENlOXMG934t80BzDqi61e6pqC1jQMoycQbHHaqLikKrY8SHLmv09tiMK/5FIMw4E/srQRwSjFqL8M7B8iSxFq197ramnpzSbslt392Htiq11kbAzXDuRGtZdebDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmfkVaJoyFFIN0/+5yS/Ldl/EJqXqVKUpejSx04/1Ns=;
 b=KiLfZy6YGsMZq1QSvZ9eMuZeg07eDZwZcKwqbp6tZI5OJyqj6SXhGUIAh/vCrFfIpHHW3Awmy33apT5a6t3VpT2+MKTYq64u3ngZM1x4sAf32XIa6SiUuaKJqI4BV7lqiO1DMPNSTE0wUgC171IxXD3NyLr7N3+nX/pI4X/QpAsqt80JEQEjyyb9uonFHemIiYMqGOnbS3u+VYY+Xs04ib52KbSWpOTi4Y9znm8oPMDzazRiJGCw6w+NRN9Dvdai8xd3RWEnhxef4kyQfuY4xa7BZqbpXtck4BPoCg9xqtrBx6tPb3w6DaklDDmUcauFgW0KWliK5nS3jNIFTdmEbA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.15; Tue, 6 Feb 2024 23:09:56 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 23:09:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v1 4/5] nvme/rc: do not issue errors when
 disconnecting when using fc transport
Thread-Topic: [PATCH blktests v1 4/5] nvme/rc: do not issue errors when
 disconnecting when using fc transport
Thread-Index: AQHaWP7ZxdBUaAFHTUuyBThIduWl7bD98TQA
Date: Tue, 6 Feb 2024 23:09:56 +0000
Message-ID: <ebaf06b3-f667-4b70-9751-5c2597c7fcd3@nvidia.com>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-5-dwagner@suse.de>
In-Reply-To: <20240206131655.32050-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM3PR12MB9285:EE_
x-ms-office365-filtering-correlation-id: adbb6059-0cb1-4e07-713f-08dc2768bc1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QbjXJ5ob1m8d2sQ5hFMRKXd8cCxQdCOkJB6MeYBqBo+OkUn9cnLrkFQNhpGF0rv7ImI+JSIBm4YvPUMNaQqfsPuCLlQkvZsoxkm5tsa/67obKRDpEmVoD9Cv2J0xnooXUWg9DcfuCOSyCvaIIdLz0Ji6Idx7n65XX4nOa0TcdThfxxrZkBU2q0CPZI2M0fDc7aC1N2+Frzi/WFaNxy6EmlH35zjc+RdrgGXa9WCKxxHMHD2m9WQ8ph8vL0XQsiiKSoEOonpnKMTDIdLB+NPhsk2f7/3LhAgJeVEnGketzwA0OP2jV59KGc2lOA64xWm1Hy+dK/PPt/4B7ufnW7dLMpkCu8tG1N3zzs9ghUz9/7HqrX1ZLnAfgc7pq/ZLeIqnkCfCAgjczAHF2J3iPn+4tvMJ/J88/5zkwRsLQ/VeEUu/qsz+LexnuGwXwwE6Qg58pRScP1LFWmtwh5A3Fq7/zPKPi3PnPq2C/WJY1NEls32WKrBf6+7j77W5X+xMCTusqTe8X17GBjpiMuMC1rgJCkLU6YvDji1j1v51W8xVKzO9BXu37ElCeOz+tKalzmvC+ZQLUtZIH62VBVwIQdDSKIKRihQCpS+IhdF9Um4NHGBOdRvxIrOjw4ltnzQUUZymqgs6j1ovPDqTrohxpPw6DUVr891zCpwnkkB8D8KQzQPU80YNKqWou0yFV2Oxx5JU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(86362001)(6506007)(71200400001)(478600001)(8676002)(64756008)(66946007)(66556008)(66446008)(4326008)(6486002)(2906002)(6512007)(53546011)(76116006)(5660300002)(31696002)(316002)(2616005)(54906003)(6916009)(83380400001)(38100700002)(91956017)(4744005)(122000001)(31686004)(8936002)(66476007)(38070700009)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXhsVzFFMDF6TFpheFpHYmd2TDdDQXRCYXU3eXVaTHI1TXIzM0IxcHBWVFM5?=
 =?utf-8?B?V2F3T21xVzhiMU5aWVVCc1JxdEppelpyTVZYRWEwLzROOEpFWFcwYUNXaU1x?=
 =?utf-8?B?M1VKaUIvNVcyc2JjL2U3bFk3ZElBc2g5UXlLQ1dPdGRkN2pXRDRtUkxjWWg1?=
 =?utf-8?B?MVpmeE8xV2MvcTdCbTZsR1FWSjF0blc0VFdFbmU5Z3Z6MnVHcTFKTUQwSFU0?=
 =?utf-8?B?Q3M3VmJoTTRxSkNtK05FbnE4ZFhJdVZMSS85U3Vvd1EwbW9ROXhvZCtLY0JF?=
 =?utf-8?B?MGgzK0xKdytLOVQwcXlKNFV5ay91K25mZGpvZEt3ck1ObW1QclNBMElub2Rs?=
 =?utf-8?B?WE03akw5cG9UQ1F4dytxd0dEcnFIWWpVN2FoaWlmcndHNEFqK0djb2JEcXNr?=
 =?utf-8?B?WmlMRlRpOTIzRW83UnpJMDE3NmdyTDlaRE1pOGJJdlVmek8rbG5EdGxvdWNm?=
 =?utf-8?B?T25KU1JDVUZHSWJVMTNCeFEvOXY0UGVzUHI4TW9JSEJJaUNCNEZrQ0RwclZs?=
 =?utf-8?B?ODdyWnl4YXFrMnlqREIveVFyM2RQMG5rMU1rdVo1L05CdXh5bGFSNTJpY0pp?=
 =?utf-8?B?bklXTzdrenIyT2lnbU5FbGhmUzJuVUtBMmQ0YnkyUWFIWHhWUVgrSUxGbmpY?=
 =?utf-8?B?cnB6ckVudFZYeFhGNGFLWWlZWGJqeGtuV1RWR2pzd2UzS3hLUktYdVdNWHhx?=
 =?utf-8?B?QVdyN2dJOEtvZmVqSFZ5QlhOZ0RvcW5pYTJJMFduVWQ5L1RhWTlZK3ozd3Vy?=
 =?utf-8?B?ZGdlN3ZaS29HSnJBZU5mdGdORmNWRkdZWHNORVhyQ0dTVzBWbGtXTFhUZDJi?=
 =?utf-8?B?bUdHYmdwdmIrVEl6U3pxS2xFcUFUYTliNEhKLzIvOGVsM0VZVTkxYWZTYjZO?=
 =?utf-8?B?N1hVbm5iNC9ONXFyKy9YZDFOSWtsWVY1QlQyWHNBUjBkWnU1djlnUVBNdkU1?=
 =?utf-8?B?NUsrOHl2WC9zdUp6UWp3UGlrRkp4TTU3RDNxVko3d2pJY1NRQlpEb1dNN2t5?=
 =?utf-8?B?dUt2ZkNSUGpaMElZUTZQcVVoYUcyT1pkTEsyNHRiYXR3ODBWRk50M2dqMkIy?=
 =?utf-8?B?MW9xbURybFk1aFVPd1V4Tkxxdjh2L1grTWZVbWp2L0Z0RUw3aEFwc3BKVmZ4?=
 =?utf-8?B?ekxMRFc3TmdKRE1pcWNmakpQa1hMOXV1d3JtYTh5cVUrSW5CYnRURnUwUDUr?=
 =?utf-8?B?Q04ySVkwelhkUi9vU0VmeE9rVTdmejE0a1dUSk5MT3U1NXFhRnUzYk9Qd2hu?=
 =?utf-8?B?cVEzR3F5RmlhQU9nTXZIVGliOGhtLzh1THprN1VEbyttdk1TdUZHRVJCY2lp?=
 =?utf-8?B?WGxiTmc3ZXB5YzhaaDJNdVBuRU9GVk5pMUZ4WWtQbU5RYzhIS0x0bTNINjlm?=
 =?utf-8?B?Zm90VmFaUjhMYmF0Tnk2Q25iM29weHBQQmZ6cmt2ZFV0bjVlV3RkVHpYNGs1?=
 =?utf-8?B?SjBJNmh1djU5MGN2RzBtb04vRXlnWFJjZkpUSGJxVUtqQjNieFhxQXVPNWYv?=
 =?utf-8?B?aCtZQ0JDU0k1QXg1ZFdIUk1zVEJwK2J0V3VnSlFNcHlXNnhtQS93b2U5eGFB?=
 =?utf-8?B?RVZiSEZOdDlYNlc4U1pxNjNObEo0UC93UHRiU1lKS09mMnZBOHMwZDVkbGtK?=
 =?utf-8?B?TDUvb0RDVEQ0UFNBbFg1cFcyckRiTFljdWtEbzNLdi8yYUxOcURudUlna3Nz?=
 =?utf-8?B?YnJqWDdUbUxaallUOWQvTjlYUHJ1MndVdERvZHlJejBGZEVDb0k3RHpMUTRo?=
 =?utf-8?B?YjllS1k5SmpvSzZzUTEzM0ZBVUlLVlU5aEkrOHlrcFJHWkZNUkw5d3RuRHB0?=
 =?utf-8?B?VDdZQWF5aHphVGZxZXd3amFINUl3eVdqWEVkcmpKa3Y3NEVvZytCTkZrZXZO?=
 =?utf-8?B?NjRXVEROUG95aEVLdXEwNFYraEE1dHFFMVI1d2F1QVY2VFIwbXJqOTFDTytZ?=
 =?utf-8?B?NUtoQnZPM0pJNnozNXNvZUU0ZCtMK05ZRlpmVVNsVkFuNy9GNlAvWVVsek9C?=
 =?utf-8?B?c3JhdHgra21MZEZVSDdXME1lYi81d3JmUkFMOGxkZGl6MXEwMGFjYXhpSDRM?=
 =?utf-8?B?MjZPMkc2aDhuMzVXanRHR2FXdHc5dnYwZjV0N25CK3lSK3dEamZGVUxaZ0Zs?=
 =?utf-8?B?Tm91OCthQkVoWEpKbmswUEdSL0gwZHY5MnIwczBuZ2RJdU50ekRKeERXU0tW?=
 =?utf-8?Q?btVquF6R7UghuCUgiY+eTJH77vVw7qDw9te6pH+skzKw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E8A518D53C2C34BB83632FBFD487E4F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: adbb6059-0cb1-4e07-713f-08dc2768bc1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 23:09:56.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl1Uu+YpOOwbCc35x3YasKZ2CUfjFpH1Si40KOwTR7oWiMU7/BFVwsgGWRmUR9KqGtiZ9gdzvTN0ymA3tG09ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

T24gMi82LzIwMjQgNToxNiBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gV2hlbiBydW5uaW5n
IHRoZSB0ZXN0cyB3aXRoIEZDIGFzIHRyYW5zcG9ydCBhbmQgdGhlIHVkZXYgYXV0byBjb25uZWN0
DQo+IGVuYWJsZWQsIGRpc2NvdmVyeSBjb250cm9sbGVycyBhcmUgY3JlYXRlZCBhbmQgZGVzdHJv
eXMgd2hpbGUgdGhlIHRlc3RzDQo+IGFyZSBydW5uaW5nLg0KPiANCj4gVGhlIGNsZWFudXAgY29k
ZSBleHBlY3RzIHRoYXQgYWxsIGRldmljZXMgYXJlIHVuZGVyIGJsa3RldHN0cyBjb250cm9sLA0K
PiBidXQgdGhpcyBpc24ndCB0aGUgY2FzZS4gVGh1cyBmaWx0ZXIgb3V0IGRpc2Nvbm5lY3QgZmFp
bHVyZXMgYXMgd2VsbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWdu
ZXJAc3VzZS5kZT4NCj4gLS0tDQo+ICAgdGVzdHMvbnZtZS9yYyB8IDIgKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS90ZXN0cy9udm1lL3JjIGIvdGVzdHMvbnZtZS9yYw0KPiBpbmRleCBjYTZhMjg0YTFlMjUuLmNk
ZmM3MzhkM2FlYyAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvbnZtZS9yYw0KPiArKysgYi90ZXN0cy9u
dm1lL3JjDQo+IEBAIC0zNTYsNyArMzU2LDcgQEAgX2NsZWFudXBfbnZtZXQoKSB7DQo+ICAgCQkJ
aWYgW1sgIiR0cmFuc3BvcnQiICE9ICJmYyIgXV07IHRoZW4NCj4gICAJCQkJZWNobyAiV0FSTklO
RzogVGVzdCBkaWQgbm90IGNsZWFuIHVwICR7bnZtZV90cnR5cGV9IGRldmljZTogJHtkZXZ9Ig0K
PiAgIAkJCWZpDQo+IC0JCQlfbnZtZV9kaXNjb25uZWN0X2N0cmwgIiR7ZGV2fSINCj4gKwkJCV9u
dm1lX2Rpc2Nvbm5lY3RfY3RybCAiJHtkZXZ9IiAyPi9kZXYvbnVsbA0KDQp3aWxsIHRoaXMgb25s
eSBoYXBwZW4gZm9yIGRpc2NvdmVyeSBjb250cm9sbGVyIG9yIG5vbi1kaXNjb3ZlcnkNCmNvbnRy
b2xsZXJzIGFsc28gPw0KDQotY2sNCg0KDQo=
