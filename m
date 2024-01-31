Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82963A8CA
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744033; cv=fail; b=fRLo6bi5RoANYu+NaBtQjku5dD5rvE+x9qfO99vqTC2fSDSLaLZYDxpvrA6VYtKL1iZz455EnwKPuhfXXdk4DnTf8htMbKhO1ZOrEPj+PMYzcUTRPfswAAja/us+SmbUA/NTV2o+EfRD2ALNL4zl6ogC/wosnPIKS8GufQi8YpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744033; c=relaxed/simple;
	bh=wRO1/vpMbwG55hJkkha2mAVJf6w3SsCduArHofpFk7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bT/DMdmIHJdEj0srgZCfo8tuKlEXJtBaSMENaNNm9rVoFL94AQCuo+/uOGqe/mtQ4cF5aryCLwCbYmUQDFAlW7mnlQ1NZ1ZwRFbV41m35vA1JxcrJXJJ3GI6bQwdPlRTnAB6BmBaeVsaybjTuoT2g+5fj74jndg/paLlSq7rzgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMZNiffK; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMZNiffK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWawmIqLIKuWFLue8Lj3yjXfCwI29wHmcjwmJ0NKpcwYP4je95W1PvtyA6W1f6bB2211QQPnlnFmOxfEMuL596q4CLMnxJpHsG84UkxarJB9pbZ1mzAoQb++L9TiJ9IK2aPYQXE31sHgBLMwlEXI3Oe9788LwIXXiARTz/Pq1+zDJc6cNyUjC9a1EvXJSDeJM0DDiaTL70PB9A09TNtRlhKFbvBqar6Emy/4CiyK1Gysak2hPGiiiN0siCR+JXWbBMRYY6IMcXs5LuXX/wUEwEdz5AugWNdebwxVQ6hxvPQAXdeqCHcY/MAc9MRfazwzoGg9alRqQI92pFgTAE14xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRO1/vpMbwG55hJkkha2mAVJf6w3SsCduArHofpFk7Q=;
 b=Z7nyFcriLDwKqlGE3hf6pJbewbx6gEF6bugUnN26MN0KBQKNgOLn4dBkkpqlR2hPqIKobAArsO0C8gOLs2oz9UcWplb/rKOLcoGk9d9o+/F7D1aymZzZ30JbQE39E6EmtqN5maO8EqP4jD5Hu3fW/j++9du+4AHI8v2JyiwQAPQARUAwwJPSst72BLTZhJbSKR1PyDwnNbLWZgjBQSqg3eryiTO3d952LKOEpOTqbPHGH+l8dGdFzi75WdMbl6ifJf88nUjTnmR2aYAs4bsHd2Cud2quwVUPGRUZ2kFK3c3IFK+sUuPnG4d53VT21gQYJzfYdDu3gcZwDcoa+qnp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRO1/vpMbwG55hJkkha2mAVJf6w3SsCduArHofpFk7Q=;
 b=RMZNiffK+dZBZHMlnSwrHr6is9D222oUyrBU0ayPMFt73ZhrgHBiGIZ6C+M6vxMFWsSt/isGr1E/NmHiS3SOkdkRLdEuUn5RAmoBXm/Pz2BiFJdoA9kpoJmlRhJsMJwzEye3P8UqEqDpepNsYeWluhoIvE97zryXgZsrjesN+4dbH8ZGtdqLz3S+rF2y+imL0xwm+xdc1s1mRPD9rpQd8hylGlYFS4ASr6FXZ/Gzhuy/W2vJaSe+fLmIpEDN4ZayJbpEszun4e6FoVdRj6pDKfY9aqjzu17M1SEI+PSABjBDM0RIngMYTrL4e4sUXZY4ALn6RmdneKGYhjOa866wrg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:33:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:33:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, John Garry
	<john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 08/14] block: pass a queue_limits argument to
 blk_mq_init_queue
Thread-Topic: [PATCH 08/14] block: pass a queue_limits argument to
 blk_mq_init_queue
Thread-Index: AQHaVEYXBH/7vyXEPUGRmktW9uOUMbD0k1QA
Date: Wed, 31 Jan 2024 23:33:49 +0000
Message-ID: <3f12f290-0d20-4ba5-bf16-6492c245e7a2@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-9-hch@lst.de>
In-Reply-To: <20240131130400.625836-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9027:EE_
x-ms-office365-filtering-correlation-id: 98167b7e-fab4-4db7-7dcb-08dc22b51380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ocT3T1m9cXO88xGyQyvPWArYripA2TDyZ9/IqsrkAbph1X/Nj328dJa/i373aDTxbJCzQb2jGwwviIPwG4iPcQAnKca/c3tsy7G5bau9NtNRFl1mR6w5gOhZGVOsVcXk6hPBX7BcquCXDdCN8hzd4K/ZqW4Q031QV4hqV4tNEwTZxDtsNO7MgM6GXaXhxWmAljjxui7Tee7AjP9EkBGumReyNGHAPW8lORMG8fjwyyKY/oXbDTQw6wDQzmkwysw4K96+YsTQIAdSZRFkDMWwdr656vLLnuaRah2gZ9m1Vw9FiCiM2QgRCpBVy5PT4Al9bCm14JzE0B5PEbM/2y65dpjk8nsDFesgoPxxzYNzqy5oSZugmQOsX9UlFhJEVy1eaHUUgZLLGH8tNh+DXjqwx/sRipw1v1xk9a5DIY9I4Hb4CbbRty8/ZjR3/Jb7Ohn3B6WxV4oCf7qKaiGTsr79OBbD6ZdhAHalmloFsWuM0zYxLSR2iSWK2vVjoAcVnviqo8qtbT6daTtuPMhIAZ1gRbkwfnzGH39B+RmXbWl6+YAaVCAeSywCbwaLdPlV3trPGsEqNyBHCTgXg0EqPFvIRIKDEtqw5B0xVL5pL/Uj3z/rCZ2Vb820np/M0MB0xqDJtdz7/lj9yFF2P7O69yAsmiJXm75/5Q+wq764fdPlsuS5CqsjMlT0Z9WAqwb2K851
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(38070700009)(86362001)(36756003)(31696002)(6512007)(4326008)(76116006)(38100700002)(2616005)(6486002)(2906002)(53546011)(6506007)(91956017)(41300700001)(110136005)(71200400001)(66556008)(478600001)(122000001)(316002)(54906003)(66946007)(8676002)(8936002)(5660300002)(66476007)(66446008)(64756008)(7416002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dS9WTDZjRzNuUkQzNnZIQ21GWWJEL3N3S0VvNGo4cjZ3RGdxTS8rcDdMWXJi?=
 =?utf-8?B?bEdQZnVHbml4bnFyd2pIc1dpd1hlbFBDMHVXZlB4RlhKRisxc0VqblJkZzVY?=
 =?utf-8?B?WnFxMXg0Q0pEaGdYSEttMFNOQTQ2dEpEY3RtL25lYzhZWExGVXd5cys0S1NH?=
 =?utf-8?B?dTBQZHkveGptYk9seENheVFuOVZwSGVZeEphQ2VhemhRTGZNYi9CaFREZURq?=
 =?utf-8?B?TmFaQlg0c0doVnhUWWpKRXJ3RFhIcWxWUEF1WDUyRjF0bFJIRllqS0N1eDYx?=
 =?utf-8?B?eEVwMENvVWx5UUhnV2MrNWFjU1FBYUZXMzdOVVNpZ2ZwSHZXcVV0ZmxIZlF4?=
 =?utf-8?B?Tk16cjJadnlwbXlzUS9UM2piblNmcUxpVDdCWW5uZFNEdUp5Z2RqS01Rbkxm?=
 =?utf-8?B?ODZ3TlVVcFpaWTA4a3NzQ3gzSDdnUldjS0ZNZzcxU25CTG1DQnNwRkJmUWFl?=
 =?utf-8?B?ZzY2ZGcvVkk4TmRXU0xWRUZMeldSRjZod3Rna2tuaVMreE5lVUlHdStoRERz?=
 =?utf-8?B?eGRRUnNyb0pEdC85S01CRVFYR0YzdHFNdTV0T2gvbFVjVHV6Ukp1dnJoK1Zj?=
 =?utf-8?B?ZW93WXBRcng0S0Rta1psS1RxYitEYUFhSXpDV0hveDRJR1A0ZVdzU3ZKMHgr?=
 =?utf-8?B?MG1wRzFQREkzL1V2RmoxUmcrRVcvR09vSFNTcEtpUDEwS01xQ2Z0bVhSZkVQ?=
 =?utf-8?B?d1QyOVJkNGNHWjN2anR1WHJZVFhTc1N0NlRIRGxaK01rbDlpYitHYm5hRmxL?=
 =?utf-8?B?Q042ckZpSllubHlxS0lBaVUvVFJQRFV2SmdWNzAwWC9JS0tyVWQ0bE96MzBy?=
 =?utf-8?B?ZEFMcjRrUVRGN0Q1N1I4alpzaXlDdnBtZTVtWXJXTUg3UlFkL0ZEekNLbXpD?=
 =?utf-8?B?bzIyN1cybDgxZ01QT2luTmtMQUpsL0taMGl4T08xbmdaUHJiZTVaNmtGcUF0?=
 =?utf-8?B?WUVZTlpITzQvcXcyVzZaMWJjTjZyMFRVN0xlRkprZjFGUHFuSXBVdTRZV2x5?=
 =?utf-8?B?RnZjN25EK3VJUFZxNnduYnhUdkJVbG5nbVJURXFVcFVGTThFNnlUbldzZC84?=
 =?utf-8?B?Z3RZcUZFNjJSV1lsbWxtanExdmxZbWR4MXp1dzFWUk9kbU14SDEwUnVnaVRv?=
 =?utf-8?B?dWovQ0NZRkJ6NER5RGNyNW5zV2tRQ0IzK1pDMFFsazQ2N2ZYYlpRazUzczhC?=
 =?utf-8?B?UEN5bzRLTUJTS3pFQXdSZ3QzSUkvMERmQmg4d29Pc2lvRWQ4OWlDQ1ZLR0hj?=
 =?utf-8?B?dFJwSi9kaGxJNHRrRFlJM2dISDRXU1dzMUNRUDRlY1d5WTlqQ1Vqd1hmVkVP?=
 =?utf-8?B?S2lUYWFzeW5icnFlYTlJUllYSUZTVjV5Z2ZBNUFPUDNLTnU5eHFyckxNbXdG?=
 =?utf-8?B?eFVvZzcrVFArL09mZVVBQlFDWHViQmIrczVIZm1KaEpyY2VXR0lpMVRKb21X?=
 =?utf-8?B?QW9tUHlGNWQ5VDBLYVp2STdSRGVVaXM5anN4ZnBKcko3SllLSTAyajVmMnU0?=
 =?utf-8?B?L29jbjg4amk0SHRRaTRIMjVTVHFqUXJqTFVKZ1RsdVF0a0owSUc2OVhrY2pO?=
 =?utf-8?B?NlZ5Q0owKzNwSUdoSjZGMDFXdmVjZE5FNklySTFuVGhTc0NPMm93NTNIY050?=
 =?utf-8?B?NndxRlNUMlVNVFQ4cm1IL2dPY2JTSHhmb1RwZ2JEanBWamUrUVdPd0tCSXJi?=
 =?utf-8?B?UDRtS2hkY2p4WHJlRFVzcEVQQ2hIV0tGT1BUL0I2aCthbU16ZWoydlUybEVo?=
 =?utf-8?B?cG1rSnlrOUFWaXlDQ0hNZXcwNzdYbTFmQUkzMWxtSXZYSkVVVDVmRHQ3QlhH?=
 =?utf-8?B?VmFDZTAxaTB2V0NJWTZTMWgxa3l3cGIyMWRWZ2JsRjJkVHJaZ1ZvemxWTXJi?=
 =?utf-8?B?L0Rsa3VXNWVPOHEyckM3aE94dThmNk9sdU5LSGhVRy9Oci81emxUR1NGUmh2?=
 =?utf-8?B?WkdESG00eHR2anlQY2dYQzNwdmxpUlh4YmdqY1NHNEdCNGRLRnZuOFc5end0?=
 =?utf-8?B?MnZqcXY5Z2VWWElhK0h4UnA5c3hoUVlhSWZ4WlBwR2hETWdRT3hNWnlwaHpj?=
 =?utf-8?B?S0FSV1FxTTByVzNtTktaSFlocjBQTHlUTk1KT2UrNEpNc0V0Ujk4Z2pyZ1dJ?=
 =?utf-8?B?VEpmU0pFKzdqYys3TlQ1dVRrVHQ2d2pQamNCUHVJZVhyUTZhWjFzMkxDZWhS?=
 =?utf-8?Q?TD7ZOPmskHI3dOMpAWtNBsBiEGmdiDQWw6ogbLXwndWF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <693EE69A7D8CB2448D46F53E7BE888D3@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98167b7e-fab4-4db7-7dcb-08dc22b51380
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:33:49.1109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eecx1QhFHzNaurPD5UNDBx0yCzPeVotYtK5nMCKdY+63Py7GN2t086vejdrvIZAZlddf0t46bWYCFqizzUkwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgYSBxdWV1
ZV9saW1pdHMgdG8gYmxrX21xX2luaXRfcXVldWUgYW5kIGFwcGx5IGl0IGlmIG5vbi1OVUxMLiAg
VGhpcw0KPiB3aWxsIGFsbG93IGFsbG9jYXRpbmcgcXVldWVzIHdpdGggdmFsaWQgcXVldWUgbGlt
aXRzIGluc3RlYWQgb2Ygc2V0dGluZw0KPiB0aGUgdmFsdWVzIG9uZSBhdCBhIHRpbWUgbGF0ZXIu
DQo+DQo+IEFsc28gcmVuYW1lIHRoZSBmdW5jdGlvbiB0byBibGtfbXFfYWxsb2NfcXVldWUgYXMg
dGhhdCBpcyBhIG11Y2ggYmV0dGVyDQo+IG5hbWUgZm9yIGEgZnVuY3Rpb24gdGhhdCBhbGxvY2F0
ZXMgYSBxdWV1ZSBhbmQgYWx3YXlzIHBhc3MgdGhlIHF1ZXVlZGF0YQ0KPiBhcmd1bWVudCBpbnN0
ZWFkIG9mIGhhdmluZyBhIHNlcGFyYXRlIHZlcnNpb24gZm9yIHRoZSBleHRyYSBhcmd1bWVudC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJl
dmlld2VkLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmcuZ2FycnlAb3JhY2xlLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQo+DQoNCkZvciBOVk1lL1ND
U0kgcGFydCA6LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
