Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D685C51
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293003; cv=fail; b=LkIRUueU3nxn5+otQmV4HW5XH3IW88hQbpnNWagyG4dFN2LNuDUtZfEO7POIWazppO9inlrKyQ2vLDLfu8Nh7LUeyxMy55Bhho+mnqpGxlN1MP0/458V3+9kBkfOzKbRkm/jsUfAj4a9uXxQFtu0Bog7bxZ7VM3Yer/3srCycew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293003; c=relaxed/simple;
	bh=B+GvZPIpjrnF6cnURO6k4+5Ji7J5hgJWpKtZshGWveA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSH6EKfoJNdcpDyUzXcv2+Ohxq4fi49El1ezM62ImvhxmdOapcnFmstxaCG4NXzAW7dvhK0hqDzLP4lgncFWh+LEWYQs59OLbrVGYzunmZpQfoA1GJtQ0OuHGryXR5xNXy85Gut8LqHS6OtauJs9rPXFbSFHFuG10gAp6SIqHKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=emSo7FOZ; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="emSo7FOZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6I2Yzq5EAoxUBqBtJQ1GN/67ifBfVLeGWL6rTSqEZCKRPdcXAkzNRNmjISWAJNtgQ1OytdsGP65RyVzeWKdYKzgsLG086CAX3l+pqztuAHiht7r1qAwqdoT4e2bqFuwPuXILTGlFYlLC/H1A0G/DMlM240RafBTzHJq4zZPxJQg21yb6LlYBI6tir+ndO3J1croLeFPXdSCiKtWb9CLauTRWuZhhr1E66TGEolSITz8TjV31HDD1YUBwfYHY+LqCad7qO+4ALGmIE4NRdzhizVkwTz2+gJ6O5xJshuyxVtkEPaVFdM/GSUqGp+Yv9OLPhAVyA6QKmDcSE43VMphFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+GvZPIpjrnF6cnURO6k4+5Ji7J5hgJWpKtZshGWveA=;
 b=jubChgC6u8I2ut5MXWnPVinEDzdteGkX+QzBnk3uQ59MFMDEUeIF+40McV9FVakrrI2ld95BNCQHuJ+IboKeN1sFPGKyDQI88F6UVJ9D+EHrJtvNkM82EKxTG4HBW4eKIAgYeaBX6SqTGwt+15tmkZ85uJJN5Ellht0pVRiQy0pojZPgkq3+SUZ8pylDsHkB//uBfVd2ROFm2MzDK25IVD3TPzYXhkdBL97ajtFAcTTCa29V6jbPg19Qi6OYgZ3ssz+nXFoEeS6fS1zj0sEABsyMiLCyQQdKHGrbXQo//LDqYl2J/LfwpRr8aaTzDC9PXhV7orjJZfcu0HeTmHhggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+GvZPIpjrnF6cnURO6k4+5Ji7J5hgJWpKtZshGWveA=;
 b=emSo7FOZLgbRU74KciN+ECkqlrAcIYfdmzQo8cqAiH4zcjcs50Z7fUvSCqx+Up93w0D5DFLp6i3JqensoMQQ5B1CXIk8IhqqCjLyrdh5KSX2csBFpyyJMQx2wux4xwQn9b4ThxYDBLv7mXC57AN2Cyg4RGBXLzVAhNVG+V+U/sq8xs24jvjQ7mIkOGeoGRt161Y80EqSxUM3FY0z2cSqaOaqi+rwg/1roHMQnxWwvzDtsTgir+OzIex9vy2RZpETCgRTBKMxVbqnOTcqJcWVP6oBUPVtVLv7wtPV49JU2UIqlyHRcc7MSsy6x6hNYCpKCMOLqcS60ogy1Xv7GsoFMA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 18:43:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 18:43:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHajAEqsQCXyo+DXUatOaKWBnORo7FqY7IAgABWCICAAGMtgIAAJv2A
Date: Tue, 16 Apr 2024 18:43:18 +0000
Message-ID: <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
 <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
In-Reply-To: <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4055:EE_
x-ms-office365-filtering-correlation-id: 25bab11c-3529-40d4-6f95-08dc5e451568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eWvCbSm5aj/B4LXoYx2LcT8sm9WWyrPkGsEmjPxH0Ou81KuTC6NkwKjCrSIUo8dgnETk8cntlOwVn9CGixtHnW5ul0ZMQsr/x/DvLMLbJdL+K8T6tjqZcQERmFltELaZDQCD8M4yD4ezkYEMbv8HQHBYKTggdt7GhxRrfCgugDDM5mlpv0xs+8kqc5A4irVxIFxV+y4X6mxb3lN+QCMpOiqWi8RQ1E/EFHtKVGAHFPUTVSDhc/LchB+qwV2dXzFDLYA6jWbeMvetd313Vt4jcQcurgpuqUG+UmPFXYyOidQVaEBYl6EYL5MH5L5L8qj4V4LmtX0WcGVNUb+l5++bHDf0ixEkWKxQ4Cf5TaEHbH5y/0qhKyngiEpPp7bYP/Nm6S45MwCsxpqAYBYnpSQRpyN3QpAi4zK/mhrBrnpd/mYcarA9xCZRD5s4taSKx2c7osInEw85HEa550jf9X7kb+RpL2bLkLbPQc5NKjbInKQPkPENVK2k7JAr66qyMxpm5KDDsC1KS0qscen/6mzoifxxEfml47+e1UwuHl2vF5sZdxw5qNFjhq0trtZoj9ZD6tNJlDLqUSEMeSwYyNusDRJlByCWphbabMfJ0RFE6biSHRPAiMZAGJ0n9esWDKv0rI3wGfqTLa9BUohIMY/AjqP2I4nFaqj5PCI0jfwMgwBueGlwFRJzG5Wqsx1H8v2rp1mPzA/FDe70UupaeS38bS/1Ss5zhaUTd2v/izb6daw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wko2eXlhODJFV0g2VUtUYmR2MXdaVmZyVXoyYVlzZnZRbGNVS2FpUWc0bWJL?=
 =?utf-8?B?Znl4Ylh6d0hYYlNqdHloZkFsR2tiTlIvaVVRbmpHTllZMGVwSDRwY2Rvd0px?=
 =?utf-8?B?R3BvT2Z4bHFTcDVvQUVtZnkzbFFGZldGQlBkNGZ2Z1lzbTZqenBybEs4bnRO?=
 =?utf-8?B?VngyUjBSZVpHazhHK05TWDVXakVUYTU3aFh0TmRnYWpBSTcwbkVQdFRIc0lk?=
 =?utf-8?B?akNnYTlFYW1tWkZCa1E5ZkwvTU1aMmJCekNIamZlN1k2RDJ3aGEzM0J1Q1Rt?=
 =?utf-8?B?Tm1COHJEM2wvRVlCMGt3c291Sm95QzlSQjN5WlBRUUF2V2lWWVNuYWd2MTdI?=
 =?utf-8?B?OHRrZzQ4a2gvVWE1bndiWmxGK1lFMm5IZXhzdzYwMkZiN1FqZkdSVjQ3cXdx?=
 =?utf-8?B?OHNGMG1vN3BIUEtITzR5ZU11V0Vycy9vTlRMMEtKeVNmcDlMRFFLbzZQVDJS?=
 =?utf-8?B?ZFRqMW5ETktiUC94UGQ1aHN0a2QzY3JsUmdLSSs1VEVteFVjYjY4VjFmc2NS?=
 =?utf-8?B?WEtKTnNqVUxPZUc0SjlQL3ZzaGp0SlpsbFZPczBRODVNVXdPd2ppNjRRR2RQ?=
 =?utf-8?B?QWtUbU9kdDBrWUNYYjhWcUxIbEdkSHZIOG10TDM0NXJKVjlpalBReTNPZTI0?=
 =?utf-8?B?dDYyZVpsZGJNTk42T2tDdi9LU1dSN1o1MzhBTW56OVgzd2R2RVgvQW9qaVZl?=
 =?utf-8?B?M1BEbmU4eHFsU2NuaTZVakFvVFFjczdqa29iZUNRMW1EN3dETmNuS1UvZVlU?=
 =?utf-8?B?ZC9BcE5XSXdIaW1kZFgyemM0TVRCMzBsZHAzbEhPSGVJdlJYUnllclNQTUhP?=
 =?utf-8?B?SWJBWUJZdE5HU3l0SXI3b2FmUk1YbzNPYnlKWm1SWDRvWVBlNlNHS1hvU041?=
 =?utf-8?B?SVRUVjFIb1I4VlJsQXNMcWZabU1rYzBjMysybEx4NFZnQjFIZDdSZlE1TnJB?=
 =?utf-8?B?MGwxdzkwTi94ZTRGbWE3d2dGRndnc3AzbE5jUkF3Ym9ua2pCUmZKOTNUTXJp?=
 =?utf-8?B?L0hybVRDbW5sUEhtelN3NDdhN1pvU1RCL0dYRTlQempKRGdUdlhJUGlmeldr?=
 =?utf-8?B?NnlPb1RvNy8wQ0hSaHROdXYrc0srL0pyaFBVMDY1Y2pXVHUrNE9pUHhtaUM2?=
 =?utf-8?B?YU8wZDU1MUxVcG84Wlg1emlQczh1RkhMdWhKRmUzcGJFdk9EWTZESE9HNmgr?=
 =?utf-8?B?K1JCejF4STdZRnIrbCtMTjlDa2xGVmp2d0dyMFRUTnFNK0VBaVZOM1dNY0th?=
 =?utf-8?B?RkN0VXNBdE9nV2JaZi94WVB6RDJjdElWcC84VW1qSFZXZXdtT3RYcCt2SDFG?=
 =?utf-8?B?cFBkZlFUMGptSEpXWU9TSHJBSWFNZGpOakhsUTYxaElWb0w2RFJqRUZBaEcx?=
 =?utf-8?B?MWJEam1TZHRncjFjS3prbTJXWDV6S2ppUnBseVpwR3J6VE45NmJmZHJwallq?=
 =?utf-8?B?TGtVS3ZTNVB2aEVtb2N1RWpDc3RXTHdmUHFyWUE3K2FXNndFSFlCWG9oc1hn?=
 =?utf-8?B?UThxYlJQOGR4SFNNQU1KVW9YaUNlRzZxb2NyUFBkREJGUnE5cmJhSkJ0TE1U?=
 =?utf-8?B?bGUzY3ZUdFRyUDRjSFlLbWQ1aS9EMC9DSGpjdjJ2d3F3TEVSSGlROEQ1RDgz?=
 =?utf-8?B?N2hBSGU4a0o5RWdNaGNzeE14UkFnb0F6VHNDSXBvRktHMGpqTzlJZTEyUjJF?=
 =?utf-8?B?Tm83TFVhcHJ0ckJ1VzZ4Vnc1ZU9keE5sTEJjV3pqOVBmSHZGaUoxaERHOWVI?=
 =?utf-8?B?dTk3bFg2WlA3cXpVdWVhZFBBdDdwVW9VWUlEQjJMTXVYQWlRVVdVMllyM2Zi?=
 =?utf-8?B?RDlFMnBFaWlTV3VwUVpUWEVPTGRFU2dXZ0w4U3h3bTdXYTY3SVBrNGV0OUNR?=
 =?utf-8?B?MG4zNlYyT2FRcUtsSzNFVktOZkFDbVZPK0dRUlhuWWZTMWE0YklMcS9iTU1Y?=
 =?utf-8?B?STNIbmp4SWhwaFpGSWhJbkxkaWhmazFoT01WTDNnSlVRWmt2MUpDeFVPQmkw?=
 =?utf-8?B?ZGEzTUQ2SFhuYlRVdXlXNWpFblJkMnRwU21PNUZFTGxXOWFlc01VMWNDZHF0?=
 =?utf-8?B?N01ZMU16SFRYK3QrS3N5bzFWZDJXbS9ZcDVvOXdMWmJLdEY2bCtkWEZIcG95?=
 =?utf-8?Q?Vtf3pNv7BrT0m0/MekiC84hf2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D1831DF3F821E4E8EED6E5BF1FA0D1A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bab11c-3529-40d4-6f95-08dc5e451568
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 18:43:18.4413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQ6JW9c5SRM/XU2GuP9NwKbvh9YcEuLzNn4Cy4W+72921XxC/mt10hAHcPZc3H92bzu7fAg7nBxuaVb0TLRzrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

T24gNC8xNi8yMDI0IDk6MjMgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IE9uIFR1ZSwgQXBy
IDE2LCAyMDI0IGF0IDEwOjI4OjQ5QU0gKzAwMDAsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6
DQo+Pj4gICAgIyBudm1lX3RydHlwZXM9cmRtYSAuL2NoZWNrIG52bWUvMDA2ICAgICAuLi4gd29y
a3MNCj4+PiAgICAjIE5WTUVUX1RSVFlQRVM9KHJkbWEpIC4vY2hlY2sgbnZtZS8wMDYgIC4uLiBk
b2VzIG5vdCB3b3JrDQo+Pj4NCj4+PiBJIHdpbGwgbW9kaWZ5IHRoZSBkZXNjcmlwdGlvbnMgYWJv
dmUgaW4gdGhlIHYyIHNlcmllcyB0byBub3RlIHRoYXQgYm90aA0KPj4+IG52bWVfdHJ0eXBlIGFu
ZCBOVk1FVF9UUlRZUEVTIGFyZSBzdXBwb3J0ZWQgYW5kIHVzYWJsZS4NCj4+DQo+PiBJIHJldGhv
dWdodCB0aGlzLiBOb3cgSSB0aGluayBpdCBpcyBiYWQgdGhhdCBOVk1FVF9UUlRZUEVTIGNhbiBu
b3QgYmUgc3BlY2lmaWVkDQo+PiBpbiBjb21tYW5kIGxpbmVzLiBUbyBhdm9pZCB0aGlzIGRyYXdi
YWNrLCBJIHRoaW5rIGl0J3MgdGhlIGJldHRlciB0byBjaGFuZ2UNCj4+IE5WTUVfVFJUWVBFUyBm
cm9tIGFuIGFycmF5IHRvIGEgdmFyaWFibGUgd2l0aCBtdWx0aXBsZSBpdGVtcyBzZXBhcmF0ZWQg
d2l0aA0KPj4gc3BhY2VzLiBGb3IgZXhhbXBsZSwgdGhyZWUgdHlwZXMgY2FuIGJlIHNwZWNpZmll
ZCB0byBOVk1FVF9UUlRZUEVTIGxpa2UgdGhpczoNCj4+DQo+PiAgICAgTlZNRVRfVFJUWVBFUz0i
bG9vcCB0Y3AgcmRtYSINCj4+DQo+PiBOVk1FVF9CTEtERVZfVFlQRVMgaGFzIHRoZSBzYW1lIHJl
c3RyaWN0aW9uIHRoZW4gSSB3aWxsIGNoYW5nZSBpdCBhbHNvIGZyb20gYW4NCj4+IGFycmF5IHRv
IGEgdmFyaWFibGUgaW4gc2FtZSBtYW5uZXIuIEkgd2lsbCBzZW5kIG91dCB2MiBzb29uIHdpdGgg
dGhpcyBjaGFuZ2UuDQo+Pg0KPj4gRGFuaWVsLA0KPj4NCj4+IEkgYXNzdW1lIHRoaXMgY2hhbmdl
IGlzIGZpbmUgZm9yIHlvdXIgdXNlIGNhc2UuIElmIGl0IGlzIG5vdCB0aGUgY2FzZSwgcGxlYXNl
DQo+PiBsZXQgbWUga25vdy4NCj4gDQo+IFllcywgaXQncyBuaWNlIHRoYXQgYWxsIHRoZSBjb25m
aWd1cmUgdmFyaWFibGVzIGFyZSBvZiB0aGUgc2FtZSB0eXBlLg0KPiANCj4gT24gdGhpcyB0b3Bp
YywgSSBhbSBhIGJpdCBjb25mdXNlZCBhYm91dCB0aGUgbmFtaW5nIHNjaGVtZS4gV2UgaGF2ZSB0
aGUNCj4gbG93ZXIgY2FzZSBvbmVzLCBlLmcuICdudm1lX3RydHlwZXMnIGFuZCBub3cgdGhlIHVw
cGVyIGNhc2Ugb25lcw0KPiBOVk1FVF9UUllQRVMuIEkgYXNzdW1lIHlvdSBwcmVmZXIgdGhlIHVw
cGVyIGNhc2UgdG8gbWFyayB0aGVtIHRoZXkgYXJlDQo+IGluamVjdGVkIGZyb20gdGhlIGVudmly
b25tZW50IGFuZCB0aGUgbG93ZXIgY2FzZSBvbmVzIGFyZSBnbG9iYWxzDQo+IHZhcmlhYmxlcyBp
biB0aGUgZnJhbWV3b3JrLiBTaG91bGQgd2UgcmV0aXJlIHRoZSBsb3dlciBjYXNlIG9uZXMgYW5k
DQo+IHJlcGxhY2UgdGhlbSB3aXRoIHVwcGVyIGNhc2Ugb25lcz8NCg0KY2FuIHdlIHBsZWFzZSBr
ZWVwIHRoZSBzbWFsbCBsZXR0ZXIgc2ltaWxhciB0byBudm1lX3RydHlwZSA/DQoNCi1jaw0KDQoN
Cg==
