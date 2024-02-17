Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B674CA4E
	for <linux-block@vger.kernel.org>; Sat, 17 Feb 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131016; cv=fail; b=qstiwDgwFTUIbkFFDvSIGkr3F2A2IWEc+yb0E1VzykvGeK6VKm+f5aQtmjE+KApCZ00M3LlTyIwLRcFxbo+wK5wbh51AifeBS/5YDqBGg9t0D+v7EaroZua28FeqJXtbsxKl9/lFjjSlbEI2Wu0/Iix9gLCNW13Gc7ANCP3T5Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131016; c=relaxed/simple;
	bh=YCa8Zez/pMSQkNUXbeBYL20cKWzhOyA5lI98hzJBbJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JKeG2DzEX7y9uhq+/v7IMzvl/WdxheGnufTFmalqfqOvIj/q9202RYsWi2pC8h10pZVfs0d27FmAActedFDPshBF06OGPxT7sAqgeRmpIPxT+sIg6WjWOGHIuZkuYGYKQtIVxGQwZhYIr61eoZgVz2kqzCaiF+btLg38jk9JToA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5kFfY9x; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5kFfY9x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMPPUrpv/wYDin01DVFYixsLmDjvJn/IDGMdeX8GSCKreGOHPny7fZED2kvii1yNso4fqLAOfktlBuGMGA0NkGvRtC+JpnXVvbZKkkbjCjXuuvMC/svs+7XtZ8NvFQUoxNl8uap8GJV1CWdV6GTZSD4m3Ig+5YsNDYhO6xI6g1rV4pFEdE/uB42BDrmn69NawYiipk7oIPs+mhzC5lhSlbkIXvppJXdswUsWtrZylxv9sx1Y9yrFQjzYBLaHjqTyfMrywzuk7VBkcHuNdrG1BFgT958Xpz5AGX1bCNoIjT8ZmKtiyWCAe4SkpcgbYUU+YpVkB0BxpZAzkTN6E6HVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCa8Zez/pMSQkNUXbeBYL20cKWzhOyA5lI98hzJBbJM=;
 b=lKQ9YwKsrYFXnid1OGpyLeXJLMmF62KB95IWwFVorQkF9TAbKBjahyAb1ffQZJ9iRp84PvomdnePtD0PTunhHEyl3b18iLhWuncmD+YFggE+hCTOQE+pAKu0e524XIEH9B3Mhj3R8UXTW+Y9qf7gRdMPScQH6dtQj6dflGWR+wRbBOpvEePEZ2xPFpQcM3JJgZrXbm3aHGrtz+IoEVyQVXpYa+pdgKqo6MQY/NBoylXyi3oMXXM7z+gggQrmndnunfHvXZbJdt/0oqPZxqCm1PJ2grb4dcciKLZxdZ0wRmfq8KaYCMEJ2zdSV7YIO+SjA1J9OYQEabW+Ifr896N1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCa8Zez/pMSQkNUXbeBYL20cKWzhOyA5lI98hzJBbJM=;
 b=l5kFfY9xapGz2MC8vQs4/Ph4gDEQo02ttPkPel/RcbFqV6xDYZcut6p42LTHjuT67uGExP/HhM44M0xOa7YBD4jNQ7U8hGEBsqmEGh8FIBc52ZMlSR0R5o1PAwQJGHiNLP2t9k6J7jYShRG47JjQz1V07sn4qICWtcAQdUeJEFppk9H35qqSRiAL9NaYHo3nrQMr0/NXyutFCrI1HEFlFh9TBkEB4YI/8/BQaEB2znJe51B0RiuskiiUq2rlwXq5zXBmdWlqtPpanhiF36B8JKk/9fwZZX+vttAtI4DCwTN+nELNxgsvE+1C7/wutsZZbM3jc6T/4hzub+Lae39F2Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Sat, 17 Feb
 2024 00:50:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.012; Sat, 17 Feb 2024
 00:50:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Thread-Topic: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Thread-Index: AQHaYTAAxfZTTebJg0eC4C2wspnvNbENtCKA
Date: Sat, 17 Feb 2024 00:50:10 +0000
Message-ID: <2d2da03e-da35-418a-be85-b11f57bbd374@nvidia.com>
References: <20240216233053.2795930-1-alan.adamson@oracle.com>
In-Reply-To: <20240216233053.2795930-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB8008:EE_
x-ms-office365-filtering-correlation-id: 29ae217c-caaf-494b-30c2-08dc2f5264b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gl2BRLRQRncnHfY0lW1USJpwH3fqa7/jHeurw1xOwv1iBfQdGbZSjmtoBgU3x8ZfqBx8QPqWnrLfXqm6Y7Tu96mziKqOhVXxU+58XN9FlPBO7jy/YevEQId8c3Q4vrQjyblH8TxMgt0paOmxnnwRfn7YF7QTp22OWpXSnqQ+j/u9awK1HZVQ6mhO/WZOvzZJwZ/BoKciA9bCRZjo5kLWccXsYN9GtO5l1fkkMN2SEoSunZsS9Q5fJ4013LOiPVBl+0Oe+SCGLmg84qiGEYhhHQ1/boFx2mB1ciXyBQBY0uJt0UccVYt5xMxPFUgxeBEcyrK2I2HTfnoOGOQmrKhJiO0mR2jgdGLtQ5m871nLybs5dv8KCkDngh28eUxo1XiNXIh1PZ+hlW8Fm9I/hgpQOgK6xCRtPOVSGVv12p2/m3w1271IKkxdzY3/gUBwIlo7F2+ga19UFml/JaCpwW2XneArNgqLcE77oa/2LIi+JrEWyvAbFq57KghfMl3X+aB3C/YkiMqHcceB2gWbQhbY6ZEzhMgV1XuIE4r7Pm7HYBh9ZDVrmrSiysCiQ0PyR7vzMPrtyz/4CBJTF50S7G+0Wgteqk3vh5ptlc2DXJErNG3DmHx2ZdbvP3bUlMI/8zfP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(110136005)(83380400001)(76116006)(31696002)(86362001)(66946007)(38100700002)(71200400001)(316002)(6486002)(478600001)(6506007)(91956017)(6512007)(122000001)(2616005)(54906003)(36756003)(38070700009)(8936002)(66556008)(64756008)(5660300002)(66476007)(31686004)(41300700001)(4326008)(2906002)(8676002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?by9SSm16YUdUYjdEeTUxcHkzZ1htSmhWNEtLUHNqRXg4bHpZaVd2NGtHUnVs?=
 =?utf-8?B?SUFSenAxUlQ3L2pOTGhsSy95RjlFUC93T0pBZnhESWNqQnZ5SzBrOC9ZMEFH?=
 =?utf-8?B?SlhhUExoV1JibFlvMTRBbWYyYlZObVNWUEZWbGl2Y2w3YnRzc2dDRmp0ckxk?=
 =?utf-8?B?R2VUcVA4OVcrWHhaVWVZL0xEbWxHOGVtTU5SSmw3Z0t1SFo1SHdkNEFoMFZ2?=
 =?utf-8?B?Qjd6RDNDdkVnL2J6dFFCcXRiN1AzNW9FaHNIL2FhMmd0NWtsdTBUcDlocnNS?=
 =?utf-8?B?YWJQMzAzM3pHeE9VVjNSbWR1aW55MlNjMXQvOGQxS1RnYUdhM2paekNhTFFt?=
 =?utf-8?B?djhCakkybUxLblAwMWs5bC93bWNtM1dBdGVaUFdGV1gweHBYRjRhQUVTMHJz?=
 =?utf-8?B?RUczYTk3MFZtQzYreERhRExzNlBBcEFvK0U2bTRpbWJpOFJZUW96QmdEa0sr?=
 =?utf-8?B?VlhyeUlyU1FuN01yNTN3eTBjM0o2TGZubUpKWHdFeCthMFJyUWozMzIxakZp?=
 =?utf-8?B?Z1hqVFo3MFhPR3dnaEFMUDY2QzhCV29XZmlhMGZQejFJdHVpY01YeWN5alN2?=
 =?utf-8?B?MmQ1dnJuM20ra0dLd0hkNW1tS3FLUEpYaHcyR1p6YzVVOEhTTjRRQXdBVmEr?=
 =?utf-8?B?U1JCVng4VVQ5U0FqYmFzcFpDNHlDVmtvenlOZFMva0FzVnF6Q3p5bmE0b2ZY?=
 =?utf-8?B?MU9uNVJET2pFV0tiWGRYdW51ZTh6Uk5EMlpvMVlSaXAxNVJTM21Gd2MvWW9a?=
 =?utf-8?B?L0JXN25GdUxLc0o1cnFwOE9ySGZvTXFHU2RjNUY5Mm1Vb2pTK256OHZjeEV0?=
 =?utf-8?B?aFRWRzN4eEpVbW9GVEdLS2pDWGJxQWgxUWFkT25Zdkt0QVplOVFMckROYnV0?=
 =?utf-8?B?c0QyS2ozNms2ZC9QRS90c1RFQ3FrcUpHREtOTzE5SFEzS3g4NDVLQTZqbll5?=
 =?utf-8?B?MGFOYzlISVVTNDd3ZkZnRlVIUTFkN08vZW4wKy9GRkdmeHNIRWIxdGNiak5t?=
 =?utf-8?B?Wkl3WmRiYkw3RHRmS0l3UVJtSVdpSmZUblBxeUhZbUpyOGY4aGRrd05IcG41?=
 =?utf-8?B?YlFKY0tKQnFCRWtJcE0xcWowRTJ5M1NOZkNJV1lUSStjK1M1S3RYMTZ0dzY3?=
 =?utf-8?B?Tk9OYjkvMDg0Q3hVeWdqa0FOUGp3QkYwUG9XVWxYTVhUaHpya09pNTZPZnJh?=
 =?utf-8?B?RTRaOUw4THZ0YU1EY0sxbEh6QzFOQjM0OEJBWkVXdlRnaTVkZ2s3YmZERkkw?=
 =?utf-8?B?SzBvcmpWODhpYnhZcHdzQW4vWkMyYlJqZzIzbzRTazd4UmFVc0FiSWJnMnRT?=
 =?utf-8?B?YkJ0d2ZIN1NWQW81RTl6MEc3dU1uZWVrVUYycmpJSXlEcERmZTJPeHgxeWoy?=
 =?utf-8?B?WXUwN1BLMDVKMjJlU1ZwQ3B6Q0RmT3djVTMwSWRGSDl1dG5tRE9lWSs2WjdY?=
 =?utf-8?B?WHRua29CdmpqYVA1N2Vhd2c5b0IxbWNubHh2ZkgxUFVSSFRSWkRYcFhieWJU?=
 =?utf-8?B?YkFZMnQ0T2tUSXBEYWVsR2lrMjh0MXIxZG5mVnBHK0NPNlNTTHArR25CWlRh?=
 =?utf-8?B?NHJTc2ZvVUE0MVVuQklzVGJxTytWUUh3MGJ2c2JHakgxT3lyY3R2Mmo5a2xi?=
 =?utf-8?B?Z0wwckVFVEV2VjkyWjB0WmNKWkU3bzFEZGt0Y2NqSVJOZktuSWs3T3Rvd2Jp?=
 =?utf-8?B?UVA1TldLcVJnVUMxTVg3WldydDdZczR1WFNZcENMMWxyeGk4R1p6UnJRS0VM?=
 =?utf-8?B?UGpQTVNYTTJxeEI4L2dFUkp1NGs2LzlJd2cvdGtkUUNGM1owWmRoS3B5Rmxh?=
 =?utf-8?B?NTdLNGkwSzRWYWw4MmpoRjlHY2xXTVhNN0FkdmlKMG5vWEE3WGgvUTJMTUZI?=
 =?utf-8?B?VGlrYTRiemdlQUFzNVdhcjAzMjNoVGVvS2FkL09mUm4vY25SeHNNNGNXdlVD?=
 =?utf-8?B?Nm5zUjNSVlJJQ2FwZEc3SjJSSGsrV0phQWJvTW92N2hzQVFJbzBrVXd3QlpW?=
 =?utf-8?B?SHcyMTRjQnJ2by9zS3grNkNFemhFNU5jVHVOb0ZaQUxmNmlEckkzbCsvb0g4?=
 =?utf-8?B?cjN4R2lwTERUc2xxSE1oWk5pUk53UDRqRGRDV2tJb1Q4UGk0V1ZlK2djVFVn?=
 =?utf-8?B?cDVqTXNXS2ZIb3Z6bW56andHNHN1UUU5RzRTRWdPL1hxREhhVmRPR2pWN2hN?=
 =?utf-8?Q?e15Eu47NtnYsBu8GF7m+BDOztnCvFt3JzF/Pyv8Ae12H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D01E3139FC16044AF13CF9E0A3FF019@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ae217c-caaf-494b-30c2-08dc2f5264b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 00:50:10.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9VjziwQ5Cc47yrsf8JVqoTcfYI/dysmkrW5tq1rdrzBdcApGSNcjQm8UWJ4yQbvC2s6rMzFmEsfICrjCrQv6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

PiArX252bWVfcGFzc3RocnVfbG9nZ2luZ19zZXR1cCgpDQo+ICt7DQo+ICsJY3RybF9kZXZfcGFz
c3RocnVfbG9nZ2luZz0kKGNhdCAvc3lzL2NsYXNzL252bWUvIiQyIi9wYXNzdGhydV9lcnJfbG9n
X2VuYWJsZWQpDQo+ICsJbnNfZGV2X3Bhc3N0aHJ1X2xvZ2dpbmc9JChjYXQgL3N5cy9jbGFzcy9u
dm1lLyIkMiIvIiQxIi9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWQpDQo+ICsNCj4gKwlfbnZtZV9k
aXNhYmxlX3Bhc3N0aHJ1X2FkbWluX2Vycm9yX2xvZ2dpbmcgIiQyIg0KPiArCV9udm1lX2Rpc2Fi
bGVfcGFzc3RocnVfaW9fZXJyb3JfbG9nZ2luZyAiJDEiICIkMiINCj4gK30NCj4gKw0KPiArX252
bWVfcGFzc3RocnVfbG9nZ2luZ19jbGVhbnVwKCkNCj4gK3sNCj4gKwllY2hvICRjdHJsX2Rldl9w
YXNzdGhydV9sb2dnaW5nID4gL3N5cy9jbGFzcy9udm1lLyIkMiIvcGFzc3RocnVfZXJyX2xvZ19l
bmFibGVkDQo+ICsJZWNobyAkbnNfZGV2X3Bhc3N0aHJ1X2xvZ2dpbmcgPiAvc3lzL2NsYXNzL252
bWUvIiQyIi8iJDEiL3Bhc3N0aHJ1X2Vycl9sb2dfZW5hYmxlZA0KPiArfQ0KPiAgIA0KPiAgIF9u
dm1lX2Vycl9pbmplY3Rfc2V0dXAoKQ0KPiAgIHsNCj4gQEAgLTk4NSw2ICsxMDAyLDI2IEBAIF9u
dm1lX2Rpc2FibGVfZXJyX2luamVjdCgpDQo+ICAgICAgICAgICBlY2hvIDAgPiAvc3lzL2tlcm5l
bC9kZWJ1Zy8iJDEiL2ZhdWx0X2luamVjdC90aW1lcw0KPiAgIH0NCj4gICANCj4gK19udm1lX2Vu
YWJsZV9wYXNzdGhydV9hZG1pbl9lcnJvcl9sb2dnaW5nKCkNCj4gK3sNCj4gKwllY2hvIG9uID4g
L3N5cy9jbGFzcy9udm1lLyIkMSIvcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkDQo+ICt9DQo+ICsN
Cj4gK19udm1lX2VuYWJsZV9wYXNzdGhydV9pb19lcnJvcl9sb2dnaW5nKCkNCj4gK3sNCj4gKwll
Y2hvIG9uID4gL3N5cy9jbGFzcy9udm1lLyIkMiIvIiQxIi9wYXNzdGhydV9lcnJfbG9nX2VuYWJs
ZWQNCj4gK30NCj4gKw0KPiArX252bWVfZGlzYWJsZV9wYXNzdGhydV9hZG1pbl9lcnJvcl9sb2dn
aW5nKCkNCj4gK3sNCj4gKwllY2hvIG9mZiA+IC9zeXMvY2xhc3MvbnZtZS8iJDEiL3Bhc3N0aHJ1
X2Vycl9sb2dfZW5hYmxlZA0KPiArfQ0KPiArDQo+ICtfbnZtZV9kaXNhYmxlX3Bhc3N0aHJ1X2lv
X2Vycm9yX2xvZ2dpbmcoKQ0KPiArew0KPiArCWVjaG8gb2ZmID4gL3N5cy9jbGFzcy9udm1lLyIk
MiIvIiQxIi9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWQNCj4gK30NCj4gKw0KPg0KDQpUaGFua3Mg
Zm9yIHRoZSB0ZXN0LCBsZXQncyBtb3ZlIHRoZXNlIGhlbHBlciB0ZXN0Y2FzZSBpdHNlbGYgaWYg
d2UgZ2V0DQpzZWNvbmQgdGVzdGNhc2UgPyBJJ2Qgbm90IGJsb2F0IG52bWUgcmMgZmlsZSB1bmxl
c3Mgd2UgaGF2ZSBhbm90aGVyDQp1c2VyIGZvciB0aGVzZSBmdW5jdGlvbiwgYWxzbyBpZiB5b3Ug
bW92ZSB0aGVzZSB0byB0ZXN0Y2FzZSBpdHNlbGYNCnRoZW4geW91IGRvbid0IHJlYWxseSBuZWVk
IHRvIG1ha2UgdGhlc2UgYXMgYSBmdW5jdGlvbiAuLi4NCg0KLWNrDQoNCg0K
