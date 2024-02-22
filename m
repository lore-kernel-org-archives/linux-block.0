Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973539FFC
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597371; cv=fail; b=NxGZtL5kutAwfi77oyqxIEpzmkcI+RPRSOYxXlhjEER0AWBHrYt2RpB0SJrLh8GA3NFmo/96yDkuZjTN1qKVvEQw0xfYTHhidHvbpCb7ybrl9OHczzBR4rk7O2/nzmUZWx8oMHkf+V623UijZUkuvoALAmsORWPqQtKXejj1+jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597371; c=relaxed/simple;
	bh=BEDfMfDOkUq4YzoS22cNjcg4LDKXKor+nOqWATA++mQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bVJA++Cz8yaAkvQeEdmi9hIbAZxCiug05VYWyxaqo/GWizNwUijdomnSg/Tolxu5wKdLvgno/up8A+Dke8hSXUZWoatBukIGB/FLinhxo6W3DmvOzS/OMySdqGLA9KivvWrC7Lhqzaw/H+Rjr5ziOjkCYI2Oc+w/dXqw6a4Pt38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXDBc+XQ; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXDBc+XQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMQNJ27S3OKkFcJ5TAeJcc108/M9EJ+6obN409dH5HkEA+Tv9IQuCIi7CnQvTReIofyLZ4sMsH8jejZ66uIdjp5sW8nZ1dt78hPBz5d4m0rlyyJY2gO6GXGHRMMdUDbIE8fSH402IsuoKOxhVC9GzEl1u8trHb8z41kxDbhcPbjm9DXLnH3j00XbmSqutzSvcEesD3n9iE6k8D2momOvaPMKCGsPZ6TAqBmqdDFLDYkwLp+qpQwUBYoX3EdVQteIRQuA3+uReaSGq+5FUArOEUBqgeoLT5RH3ZTNXDOw1pLkh9fQaFU4AEvxeQSENoZSE2OYWIsrdVKCPQOM/J1y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEDfMfDOkUq4YzoS22cNjcg4LDKXKor+nOqWATA++mQ=;
 b=eFrkJR9XwCj8nv9hJgVaDPrC8Vp+O0iMetGIIkIm9JyFs03EWJ6HmCzsOn97z3RFBOHWcr3v0dzHtn+MMeC8hlioU+uHao9eybEuESKJzWJn26KctEA2ySmmEJuZNQCFXyCbJzeu5Rs6MYKSPOI3Z4iCn4+Xs3PbhK+WpDlW/oAex9gh7jg126HYL+2g0uFrLmGLmwSxQiorI7r2uSllZr/feNbvsjn+kydV9ezCs+VWi+jVhFC1BtbplDZyi/CjsGiXRhBRjbwtZtOvtgyydfbHi7YJJvl0GOgr5WSU4ORLQ3PPW4HubQ8zYrOzH5u8mS4oPXhU6vGUNYxXIykVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEDfMfDOkUq4YzoS22cNjcg4LDKXKor+nOqWATA++mQ=;
 b=EXDBc+XQFNYILhmwY/MZCt0TCjDUOQhVmFraDCIadIK5ghdMi8Zotw23DwmDOSZjUF3Mc+C9SLOuNM/bPH1lPR3BjfmsQQSfQ221sEFOHLikNQH8zmlvsYNtSo/ra7J/lX7GW6FfTucCDB4F2l47Xm2aI7TKjC97ODstHiquDFled61BzVp1nhqrQ9xH0T/EIY+dDDgB11EPQzy5xyzb7QEyjiltAtSBGcoYfwFLph4PcO/EaftJm5fgWtwIaCaaOUJcIIyeuHlU1pfJmUN5046YXfkkY6QOakY5/IuvIsVyn+S6fV0yCZVov7XeI9bMQCXVBOdjOdY+1KsXEFhDeQ==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 10:22:46 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::fd67:3880:45c:8a3]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::fd67:3880:45c:8a3%6]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 10:22:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.org" <axboe@kernel.org>, Nilay
 Shroff <nilay@linux.ibm.com>, Conrad Meyer <conradmeyer@meta.com>
Subject: Re: [PATCHv2] blk-lib: check for kill signal
Thread-Topic: [PATCHv2] blk-lib: check for kill signal
Thread-Index: AQHaZRQv4V015UDtZ0iTwHFDXJqCcbEVvccAgAAEdgCAAGXCAA==
Date: Thu, 22 Feb 2024 10:22:46 +0000
Message-ID: <c261b1e2-c3cc-490e-b283-69b8799ce54d@nvidia.com>
References: <20240221222013.582613-1-kbusch@meta.com>
 <ZdbHXDCquO23rbJk@fedora> <ZdbLGqP8o0q9v1g5@kbusch-mbp>
In-Reply-To: <ZdbLGqP8o0q9v1g5@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|BN9PR12MB5067:EE_
x-ms-office365-filtering-correlation-id: 3f7f1f73-ddf9-4cc5-5d37-08dc3390369a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LTI8AuGHBkVmQIYSSavLFM0bYBkZbRkJ3nLwgcbCMNjk4cYX+M0dikJmm+hYwWwGz8qN2lcJYfXrHxobUT0gAIXcDAe3H3PDX6n0t29QX7hflc0nWId+m49aV0h19unBHWVbKAbsWq7lQizla0J2B/FgOGstODcirz2CLlBOuGDhTshoFqc3y3BZDafNXgQdXNXrwtiF2U1iUEzTJ/XAaFpvOBB1HQgA/85G05xYXMEeNMH5gU84FSVaZ/8WibK7tM+QGLHPfM4ZEImszRWNixCTdn9iOyoV6J9jZwVHp0DWbC1xy0xhoM7nFG2yNI5e3QMu4DX22r8rkoipw1HoMazTb4RknKOITlV+njT3xiDmpYIC/fZfdRwBjJ/q70P35TzVB2EM05Sks/OEHHoEqCB2+tTMyYI4Ni3weledguSwS4Y799+PkawMDg7FuCFI38DcVgSIXlxX2c3wssusLo6+gZhSyVhlgd8SVLCYtUIX5OLBfCKgiNtC46fJ963LfCjAzOV/ZsT4SQ9Cu1kKg8wZjwmVox/TElU0nbZnNLc6xbncEygBJcjNqmau3QSbD1ASdWZ89/fWr0Ka5L3CAA7aepY5rz8gyrCNuW7EZkbR3l+LvA8bPQnLllJ3uXI2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmhLeHJDa0JmaitMa3lYWkJpaVpUTzNUTzJXYmJXTDdrendVckdZWEtOblVS?=
 =?utf-8?B?WGdtSlFpNFl1dWFUUWdFK0k2VUJaR2d6UHVrQTNIVFIxTEtWcGJxNG9vM1ZL?=
 =?utf-8?B?c3p4S2hnVFo3dXdFR29FaGZlVkxUM2dWUWc0OTRjZnVjei85ZlFUd01zVTAw?=
 =?utf-8?B?QVlvdjhGRGVQVGduSi83VFlxZi9CSmV0SzdXZ2J3UzlrS1duMmgyMUFNQnN0?=
 =?utf-8?B?cWZnaUpNUjJwWkVjQUIxSzRaSmpEdHdoS0pMRUhMZG1TYzdPcnRuMEYreE90?=
 =?utf-8?B?bGU2M0VGa0hoTDN1SnpxcFVzYys4Qjd2T082STB2Qmh4c0R3UGU3U2N6S1FX?=
 =?utf-8?B?SzN6UEVaT2d3cHlqOWl2WjRSb3NTUzQ2RnJhVHpsa1A5cjd5dGhSTWVSMFZx?=
 =?utf-8?B?STU5clgyYjRGNy9obGsxQnpIRmdPYWpJOVJGS2NGYytTNFZiOFY0SWw3RUZP?=
 =?utf-8?B?bEZoTHZZTlBueG9vaG0vZTJTTWxVSkNLYVlWTUhSNnlhTU9KOTVsYXJ1aWZC?=
 =?utf-8?B?ZWNrL0NIZGQxUjlXaTFPNG53eWFWY3FVSHRXQjlZMDFPTWF5THl4U0pNQys0?=
 =?utf-8?B?MW0zT3k2VFN0YTgrbk5aNkZVRVMraEJUeHMraDZVZlJkZDhMSFNVNzN5SS9W?=
 =?utf-8?B?QUZ4dXhFMFprWmZKNC9BaEdyUGNwN0Q2Q1FBZHhOV21JaTBpWE96VkpZR0ll?=
 =?utf-8?B?cWk4VytOQ01HSTIrNUllKzg4SjFyL3ZhQkFHcFkycFllZ0dTZG1XWERQeUFr?=
 =?utf-8?B?MFF5M1ZEbXk2cU95ME9CeHRJTW4xRzZlNVVmQ2NXaVJSNm9wMGxiaVN2MWti?=
 =?utf-8?B?Q1ZJT0dDcnU3bzI4S3BqbXl3aGpLSVdEOHUrQS9zaHJncEgybVhJWWpIVmt5?=
 =?utf-8?B?MStHckNoaGtZdjIzQ3g4WGFETXF0Y1c2Vmlpbi84akwyT3hMNC9GSWhYMEs0?=
 =?utf-8?B?NTVDVGw3LzIvMkkyL0lSVzRPdHVmd3hvRyttWVg1NmFScE9CSmgxd2h0c3V1?=
 =?utf-8?B?L0VsU21QdVpwNk40dGFXOUxoaEt5RDdHSXVYWjQ1YWZFSlJCbS92cXJPL2lX?=
 =?utf-8?B?Y3RiMFRXcmVFT3Q0U2tpeE01YjhxU2dHK0JvUC9nbFZoNlRBQTgwUEd4ZEVC?=
 =?utf-8?B?bUE4L0V0bHlOVENVQmJ1ZXBLbUVDWXBmMXFkWWo2WWF1aE0rQ0U0Sm14cXpW?=
 =?utf-8?B?d1Q1T1lXOXU4YmJrTGR1UnRJSkN1WG96MjZyN3dKaExOV09jeFpUUWxLMmIy?=
 =?utf-8?B?dFVnYmd0QjNtTlNsS05rbE9wY0NNb3ZRMWVLdURyaTFTWisrTXpLRmI3V2w0?=
 =?utf-8?B?OEFBeHBlUmtFYjQra3ZiWUFwQWFnazhORzQxWncvbDVzbXpXZnJFelpxTDFW?=
 =?utf-8?B?KzhhYnlsR3o3WlQ2TzhpQ1U4bERTRFU3ZzhNaXRwSkdhVmJpZlJlclRDVVV2?=
 =?utf-8?B?eXlNeGJEOUt3R3E5Q21GZjQ2TmEwYVdBZnplelZMMm9tRDNDL1VmUStkbkEy?=
 =?utf-8?B?bkVBTlJjZnpycy95R0o1KzJQaTE0dE1iTkJhZXdDZTlMclNzOFFFT0FPZEZM?=
 =?utf-8?B?V2NlZ1ZaaCtBTkZhS1BpQXI3U0ZtNi8xKzB4UjFLK2EzT0w3NFlISU0vVFNa?=
 =?utf-8?B?OWpETUpsWnR2MExtSzFMc2lYaGh5a3BlU1NSY1lXMFRaNWFhRmdmWjl4K1BY?=
 =?utf-8?B?SmNWR21iM0VOT281Y1IvWDBjZXZ3OGhvZUp0Q3FwT0pUS2N0TzF1UE4rTG4x?=
 =?utf-8?B?QTZhYzhMYjd4ZEdIUE0rU0tDRHRvVnA5RjlLVjNndmhrdHFzdlVhRG04NEFK?=
 =?utf-8?B?R3dSZkg3RzEwRTFXZkNiZHFNVmRJR3hUV2V1ZGxmSFdvRmdnRTROU0QxalFt?=
 =?utf-8?B?cW9jN2o0YTNMNDFNdVRneEFicXdlOUJQTkM3anIwaVJjZjZPOTJWalFhUnp3?=
 =?utf-8?B?d3BLcGdpNUNFMkd0ZjErUnplV1diU2hKNzU3QWhENXYxOEFOTS9YdUNocEJ2?=
 =?utf-8?B?VTdkZDJ2L1dmRVZJV3NtbTBwMFE3dkVBNnpQWnpzSy9qbFlaaURseVVKbG5k?=
 =?utf-8?B?RXdzUnl3M3lXY0JiRDh5czZ5dWNjUzh2ajdra2tqdjcwV2ZRdGN0UDdQaG9w?=
 =?utf-8?B?QXlQSVJ6K2JuTVBBaXRBVmhaNjVkaUhGSzFqKzN2QUNCT29CU3BuSlhFYWw2?=
 =?utf-8?Q?+Qvm5Mk/3CMa9aTkU4qNfvoibNuFPrMANVcJmkSIgXvY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB4514169FFF954F94FADC215A5F9210@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7f1f73-ddf9-4cc5-5d37-08dc3390369a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 10:22:46.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVz1U8HSFBSh9tjDaPL3PwU3WjfyuoptPdcqjJ+kCybr6pSrmD4FvQtyehD2TJMpQAfwryuCxWCEh5vzhNi6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067

T24gMi8yMS8yNCAyMDoxOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFRodSwgRmViIDIyLCAy
MDI0IGF0IDEyOjAyOjM2UE0gKzA4MDAsIE1pbmcgTGVpIHdyb3RlOg0KPj4gT24gV2VkLCBGZWIg
MjEsIDIwMjQgYXQgMDI6MjA6MTNQTSAtMDgwMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+Pj4gICAg
QWZ0ZXIgdGhlIGtpbGwgc2lnbmFsIGlzIG9ic2VydmVyZWQsIGluc3RlYWQgb2Ygc3VibWl0dGlu
ZyBhbmQgd2FpdGluZw0KPj4+ICAgIGZvciB0aGUgY3VycmVudCBwYXJlbnQgYmlvIGluIHRoZSBj
aGFpbiwgYWJvcnQgaXQgYnkgZW5kaW5nIGl0DQo+Pj4gICAgaW1tZWRpYXRlbHkgYW5kIGRvIHRo
ZSBmaW5hbCBiaW9fcHV0KCkgYWZ0ZXIgZXZlcnkgcHJldmlvdXNseSBzdWJtaXR0ZWQNCj4+PiAg
ICBjaGFpbmVkIGJpbyBjb21wbGV0ZXMuDQo+PiBJIGZlZWwgdGhpcyB3YXkgaXMgZnJhZ2lsZToN
Cj4+DQo+PiAxKSB1c2VyIHNlbmRzIEtJTEwgc2lnbmFsDQo+Pg0KPj4gMikgZGlzY2FyZCBBUEkg
cmV0dXJucw0KPj4NCj4+IDMpIHN1Ym1pdHRlZCBkaXNjYXJkIHJlcXVlc3RzIGFyZSBzdGlsbCBy
dW4gaW4gYmFja2dyb3VuZCwgYW5kIHRoZXJlDQo+PiBjYW4gYmUgdGhvdXNhbmRzIG9mIHN1Y2gg
Ymlvcw0KPj4NCj4+IDQpIHdoYXQgaWYgYXBwbGljYXRpb24gb3IgRlMgY29kZShzdWNoIGFzIG1l
dGEpIHN0YXJ0cyB0byB3cml0ZSBkYXRhIHRvDQo+PiB0aGUgZGlzY2FyZCByYW5nZT8NCj4gUmln
aHQsIHRoZXJlJ3Mgbm8gSU8gb3JkZXIgZ3VhcmFudGVlIHRoZXJlLCBhbmQgc291bmRzIHJlYXNv
bmFibGUgdG8NCj4gZXhwZWN0IG5vIHBvdGVudGlhbCBjb25mbGljdHMgYWZ0ZXIgdGhlIGZ1bmN0
aW9uIHJldHVybnMuIFdlIGNvdWxkIGFkZCBhDQo+IHNpbWlsaWFyIGNvbXBsZXRpb24gdGhhdCBz
dWJtaXRfYmlvX3dhaXQoKSB1c2VzIHRvIGVuc3VyZSB0aGUgcHJldmlvdXMNCj4gYmlvJ3MgYXJl
IGFsbCBkb25lIGJlZm9yZSByZXR1cm5pbmcuIEF0IGxlYXN0IHRoYXQgbG9va3Mgc2FmZSB0byBk
byBmb3INCj4gYW55IGNhc2Ugd2hlcmUgZmF0YWwgc2lnbmFsIHdvdWxkIGFwcGx5Lg0KPiAgIA0K
DQpXZSBuZWVkIHRvIHdhaXQgYW5kIG1ha2Ugc3VyZSBwcmV2aW91c2x5IHN1Ym1pdHRlZCBiaW9z
IGFyZSBjb21wbGV0ZWQNCmJlZm9yZSByZXR1cm5pbmcsIGl0IHdpbGwgYWRkIG1vcmUgdGltZSB0
byB0ZXJtaW5hdGUgdGhlIHByb2Nlc3MgZ2l2ZW4NCnRoYXQgdGhlcmUgY291bGQgYmUgbWFueSBi
aW9zIHN1Ym1pdHRlZCBhbmQgb3V0c3RhbmRpbmcgYnV0IEkgZ3Vlc3MgdGhhdA0KaXMgdGhlIHJp
Z2h0IHRoaW5nIHRvIGRvIHRvIG1ha2Ugc3VyZSBub3RoaW5nIHBlbmRpbmcgd2hlbiB3ZSByZXR1
cm4gd2l0aA0KLUVJTlRSIC4uLg0KDQotY2sNCg0KDQo=
