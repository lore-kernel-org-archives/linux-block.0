Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4D1DF242
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432694; cv=fail; b=q7AZYazmTmHMDOCH8dRZEbVgCxr0P0kUVv7T9CFmEP95w0DlqXFPG1PrcWSckHJ1HABJmAAmhiL7iM3TRHxrLsp4g1ln/+Nna2wgdsjrf3AcsG7iOtAmOeRWhKG64c/e/7c79byKFR9z4/9mKZL4pxPfK/tdN1mTqrZY9UogC6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432694; c=relaxed/simple;
	bh=vBJSWHt+JkTWAY8KoWc+nOX0PaCuHpFRysS3y7+Ycpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/kdLlYpOa77RVUWkdN2B+voWNFniFOxTsloJv+W/3deT4cnBkmrqtJ5KIqeZzA5wZU8cGW6qvM1cEYR+v+iP6CrFuBKo3030X1Ej/PwK54jgBb6eYNGx07MFKC0RBJIXwilxFWepVoI5BbqCANILIRpYwScqQtJvmI+gMJf+kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xO/PvS++; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xO/PvS++"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQInxxknHSjyMxyQ7r4asjzURr1TzMvwo6RI1waJhtWzjR9toUnGlZ9MN5ni3X73uHlM25utkEDY5RjBYOSHxGxh83x7+PqAdTULj3LIt2ZwnwIxxF/mCyVhMG79IyJvZOrw9bv2nVhH68QP0O5NbVbqKNZG8xbXPDGztmhSIvJI7e5d5GYb/fePJVuV/HBe/Oo8PiISkSiyd6hAI/SGrNSMsykdItuXJ6BBLrfiB+BoIm6+gti/3lymg4+DtNa+kzhmfxIkWzFgGnwET0ZzezxZ6oyWPZg+frN/JNuyPuLzF0b6VUMpGP1uFl1m6yUXJLxaerb70/VhcPe2bUN01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBJSWHt+JkTWAY8KoWc+nOX0PaCuHpFRysS3y7+Ycpw=;
 b=cXud7hyt5cQwJa3axRNNhwDMypksYlSOjfIbFZ/bJ9azJoFXDL7HKklVKQlZiNj11VXcO3I757H+n+7WfBEftse5sI8ZHgeD2cZLw+jzdr43X2c+FMCYdZ674TO8nGgeAQByh1Xb5vG5rO7iYYI+gVy2YPkj3S03DlL6XUi409VGtxvK85Os3pXoeSmfdNSrc9H8gzwh9HLCEmFOmKBB6IOZm00xUcFs+CfNL6WwPQfijA325YyxzuiqqV6+atDdOq70mQN6C5nlT9fqO2WQhep8lMGk0DRZL7WUm989PkavTW8jUy6kjm+eeSxGkxyTb2g38t196JX9kcFZzYa6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBJSWHt+JkTWAY8KoWc+nOX0PaCuHpFRysS3y7+Ycpw=;
 b=xO/PvS++lPyUSlOjc3klJekb1o+OSBqgNAAK9JPBsEH0BrUxEhRZ74Ozu598pSlKP+4ba51QqYMyWSLhKXFdCSPEDasBCjwa0UdLPTPqbB0dO+MwzPnfOyokqkZ5AlMTqvXJAm7wJO6vvtiPXi2FN1eD5+nbPQotUf6P29GAuFs=
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 21:31:25 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a7f9:7418:ac9e:203]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a7f9:7418:ac9e:203%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 21:31:24 +0000
From: "Boyer, Andrew" <Andrew.Boyer@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>, "Boyer, Andrew"
	<Andrew.Boyer@amd.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez
	<eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>, "Hubbe, Allen"
	<Allen.Hubbe@amd.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Thread-Topic: [PATCH] virtio_blk: always post notifications under the lock
Thread-Index:
 AQHbYTG5PPtb1U4eCUarxpU24+zL4bMOWgAAgAAcSQCAFH+oAIAALw0AgABMsgCAALCgAIAzGk2AgAAH2oA=
Date: Mon, 24 Feb 2025 21:31:24 +0000
Message-ID: <575C32BA-63C3-4A2A-BC95-0E4F910DFA67@amd.com>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <5952f58f-9b80-4706-adb4-555f1489f2cf@linux.ibm.com>
 <20250224160208-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224160208-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8308:EE_|DM3PR12MB9435:EE_
x-ms-office365-filtering-correlation-id: c0569386-e6a3-42f8-47ad-08dd551a9718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlYwSVpuOWpVK3NwNXZoTnI2NHpVOFRicTlBUno5dytQYXR0dFN1alU2anZX?=
 =?utf-8?B?b05FbEh4b1hqNWxray9TZ2pTRmY3VEg4dEs4TEJ2eDJadkZYMFB6OTNybFJj?=
 =?utf-8?B?Mm1OUGhicHJ1aU5wbEZvTnhiVHRCdkRORnBEZmFORkN0a08zR01LTFhEU09X?=
 =?utf-8?B?Z3R0UnN1N0hjOUg3aGVDM1A0ZFBzdUZmVVVZcjVVTWc2czVEaHVPZzI1RTNl?=
 =?utf-8?B?R2VJVjFOMUt6ZnNHNGF1LzNveWNVYU9ITmRSKy9vUGVXWEdSRHR6bStzUFVV?=
 =?utf-8?B?YzYvYThSY01SeEl6NGpoMlNOdVAycnFpRTVWZXZjNEROM3dWYjVxVzBNU0Rt?=
 =?utf-8?B?dm5HTzRjc29TRVFTa09zVWJlU0VNbzRkL3gyT2p4WmkrTmZPWEltYkkycjZz?=
 =?utf-8?B?QXVyaE5RUXpiT09hOW9iSUVQdXBVU2JLdktiZnFTODFTQm9wY2YveXd1LzFh?=
 =?utf-8?B?VjBTRVk2VTZaKy9jamtMV0pJS1AyY1poZE1IdmpXTUFHUDdUU1BZS1Z6c092?=
 =?utf-8?B?aThpdzVzOTY2dGlmdWZsWFJFWnhJMTg0TDlld0IwNytmN0dtTEZyQzkwMEc3?=
 =?utf-8?B?bU81SjAyZ0tMMG4yeUNXNFF6NS9xZzMxbEt1WXptZXh6ek1Denh4b09WcWRF?=
 =?utf-8?B?STB1Nm54S3BrMm5PQUJtREgxRDRUWFlnYWw4WHgzU2plTW5WOGNVZnE0Qzk3?=
 =?utf-8?B?UWZodnhZdTFQOWVwMHJPaS9mZlJSQS9uc3dHOEgzVTVzcG0yTStCSHM0WFRI?=
 =?utf-8?B?ZCtlMG9PUXZxNDNUeWRHS0twZG44SUEvUGgwY0FTUWFOZGQvc1hTenBPenNm?=
 =?utf-8?B?cXZiaEZWaGdDZTBJemhVZTlvMjhaU2xuT3h1Zjk2YzRpZ3ByUm5QMjFMcWgr?=
 =?utf-8?B?ZHk1c0lpL2E3eFc4Y3RNNW1zZjlXeGZpNHlGTVdaN1NWYXRESGIrb3J0TEk1?=
 =?utf-8?B?SW5MRm5sL2FFcGVYVkJ1aS9OKzZoL2NSYnpiekR4YllUTEVsbnFuenZvQzZ0?=
 =?utf-8?B?b2hkSDQ5YkdRMGJSVlFwcGZyZFA5VmJLQTF4a1lxUjJ6NFNleTlxVGxTMW5C?=
 =?utf-8?B?azNYcUdBMHpmUXJTbnByOUlNMUFqOGU5QS9RNVgrMmdqdC9VRzhpNEVaOWI5?=
 =?utf-8?B?N1Z4cjh2OThHRHJXTGhhVGl2R3owdEpVMUZMK2tTZXZiN0JpWEhDVDZYWGYy?=
 =?utf-8?B?djg0ZVAvZWJnYzJLaG82VDYxdmNTRm5yNGY5NWhUd1NMSU1pNzBWMnZTRTU3?=
 =?utf-8?B?WFk5NVI5QkJxS1hPcE9FZFlTVzVmZFEvR2pjNWJGelhNZnZiWHNEamlma1pP?=
 =?utf-8?B?ZHJXVC93cmNTUm9EYmxRNmZvdE9ya2pyNUVmSmR6Yk9peUR0ZHEvTG5hRnlL?=
 =?utf-8?B?dHd5Ym1hMklRUm1YeTBiRjdJYmVieUdlYktBWEFnc015QWtwemFKc0RpMUxx?=
 =?utf-8?B?SjRBT2dzZTVqQUROaXBmQkZXWTR5Mk1oUkVobWtES09CbitZYUkxa1N5Y3pR?=
 =?utf-8?B?MGRPZ0dQVmpYU3ZxVytNNzRlcGVnV3FmOU9lcWFKRUNNWEk1WVV4QW13bi9C?=
 =?utf-8?B?ai85dzYrVWxYMW96TUs4d094WWxjZ3lNLzNEcFdzV3B4c0diWTRWZXJ1cVJ5?=
 =?utf-8?B?V0pKMXRRSGFzVzZBZ1J4UVJXNW1PMGNYL1dwMmM4QUJlUkZvVC91U3loR1pD?=
 =?utf-8?B?MndTSzdOazVpbXNoeTExcFFyY0picnVCWExEZWVHZzZtYkpMeEZTUmx3d2E1?=
 =?utf-8?B?UDhnSXdZZHhLNkNTRUZnbmx0U3ZhNW5Kd3UraXNUaG1mdkI0ZnAzcU5nSlk2?=
 =?utf-8?B?MDkyNmJCZnQ2eFhETE8zNlZ2V1NRcG9QbzBMdWRtaGhjSEl2SmtFQjNEcW9w?=
 =?utf-8?B?U1BNWmphWEpPZkU0cE00OC9jSi9EdlRzVG9VWjJZRjB2dnhSZ1Q4VGdXdTF0?=
 =?utf-8?Q?GdgH/wupYnvMjHa2CY8Jf2iXj5cgpNIo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXpzZUlvc2wxK3JMMHdsdVZsVFN0Q010MVhLdWVxYXltaTFjY3VNRkxJZzBv?=
 =?utf-8?B?TXFDaGhGdjJMd3FaZU5QVEd0eFl5ZXdFN292RjRpUDhieXpWbHNxYXNPV3lW?=
 =?utf-8?B?ZDJBeWh3SDQ1SGJ5K2cwQ2lRQWYzakZVZ1hHZ2lYRi9tYTNKVk9Bck45bFd1?=
 =?utf-8?B?eERVV1ZGNmozKy8xMUNMYXlEYWxtUytjL3JzdTl6Uis4N2Z4UmpMNGY5TFVa?=
 =?utf-8?B?Ti9HYTV4MEU3MDJQWVd2cHdvaHpxRkVpVHE1c2ZPSVNOb1NON09GQ1l0MWxC?=
 =?utf-8?B?VFRhMC9ZWThvdVFLVE5QUmFnZjJiOU5iWU9OTTRUU2NzKzNXRnhjaS9yTURs?=
 =?utf-8?B?Zkg3cXV4ZFE0TjZDTzZnNEQrdnpRZkNJc3pURlBab1Z6Q0g0ZGVVVkV4dW1m?=
 =?utf-8?B?SWZVQkdMaS9ramwvUm9sLzVZSlB5OUV2dEZpcnlqNTJ4M1FkYWFXdWVpakJn?=
 =?utf-8?B?WlE2QjdMbnd1djBQUThEZU13cEdMUE1UVU0xT01JQ0U5MEFxUDErQ2dBbTV5?=
 =?utf-8?B?OGlwb21KVmR0cjFDdGZhR1ZTU1dZcjF3dnVWckljcW55T2taY2tiUFZUU0Z3?=
 =?utf-8?B?TXpKSEpCWXJ0b2J6UStJYVN4aXZHZnR0dDFlVWNXWjNsU2N6TWdtb205dnYy?=
 =?utf-8?B?TEhsaWVkZDBkU3hqLzk1R0VSM2ZjcmdiMEhyRkRSREMwaVpLaEFPK1ROYmxJ?=
 =?utf-8?B?Z1ZkRHJCanpVUTRpcnBtMlNiRjRLbU5oUVhLZ3lZT1A0YnpqdG5FYTUwbjFM?=
 =?utf-8?B?OHRNVlNHdkFLdE5zYkp6NmFwUndDVnl2V2lNbXNwWmxIbTBYYkNGK0dEQi9P?=
 =?utf-8?B?SWdtWEJwWXdSOWFwWlFHRDdUeCtkWkN0bTh0by8zcW9CU1hzL2IreVAwVFQ0?=
 =?utf-8?B?R0NLcDBwR1RxWk54amtqcE5oUmNXS3dqWXVSaXN1TmJIL1JsZ3dwcW94NkFa?=
 =?utf-8?B?SFkyTUYzZXMxdFA1Z204OHNPMW1GWWJYTVFIeUFmMVcrUGV1TFlrbFVTenZI?=
 =?utf-8?B?TENzMGQzSmwxNFQyTWd1WlpYNGZRclNkL01lT29ZVFl0bzVULzlsakM2RUc5?=
 =?utf-8?B?S3MycU1NNXpuL1VPRitpbkhKd2wvTUswNW9FcXREZ1RDY2I1bm5qWWdYcWFj?=
 =?utf-8?B?Y2NiRklURGxFcDNvTVhNWGFjSlFhd0dhdS80a1FmNzAzdXowY0tCQ0k5SCtK?=
 =?utf-8?B?L2xzem9tQ0RNcFZOUW05TzdYYU5OM0VWUVhXSG5ua3lLWStYTEt0N1Jibzhk?=
 =?utf-8?B?SDhCa3lDYndUZ1FtdUZlY09BUGIrWDdvUmw1QjBTWUdYamdHaTdhMmgzUHpl?=
 =?utf-8?B?d0Y5YjdYQ3V3NGhRL1c5anFSVzZCYVV4MW9rb2oxR2tvenJCQWRkc053Q0hQ?=
 =?utf-8?B?YTFNREkrWHd5L0xtdW92dk13eUgybzdMU2xqbHBldGFnVElKRDlWa1QyQ1hG?=
 =?utf-8?B?UGVyNCsycmxhelprK1NXMDR1YzhWS0p4TjJvREF3NWx0aFB4Ull6eGZvWmNy?=
 =?utf-8?B?a1o2a1B3YUxIb05rWEYzTDR5Ti9sRk9wT0grT3R6YlRiQ2E1TXBWZ1hTZ2dt?=
 =?utf-8?B?R1RBcWF2SHhZSnJkSUgwdVkweFZJQStTNW5Idkt6ZEhFQmRWa2xYMUtmRDM4?=
 =?utf-8?B?YUNKUmtaSDVpbkY0YUdyTmhSMWJPWHk4Ymg3T3RyajBqZnF0M2pVMU9FYmRu?=
 =?utf-8?B?Vm1PTVV2WWRvbE9KbElRaWtGMlhXS1ZEUDBqd2xLOHBtYVl2WnNnRjRHSkk0?=
 =?utf-8?B?T1NOM3lodU5tazZWVUhsK1FDRjBnSEtQVXVJTUVoa3RHcEV3ZVlVOG1rOTZw?=
 =?utf-8?B?TEl4QTJ1N0plQ21zakFCZVo3V2MyaUxob3JObjArcHp3K1M3RDR0Y2ozbXY1?=
 =?utf-8?B?R2dRdm9iR1NsQ2UzM3cyUHJqQ0FIbUp2MVU5My9VdS9HdHJycmxuQ202Sm1w?=
 =?utf-8?B?cTZyU09GUTRGR0J4ZVd0WUhHTzVHSFMyVkNDbTZQRHE4RDNWeTIvR0RlTDVi?=
 =?utf-8?B?TDhUdXVOMVBKd29VSGo4UktPcXhqaFBBcHJtWlhwdEpmQmxBbnhIalpXNEVJ?=
 =?utf-8?B?L3huQjUveERBUStRODk2M1BBMzVBK1hKSFdsSmorTjk2TlU5NXgxNGJuK01P?=
 =?utf-8?Q?AFc+U1394aF09htw7OGkGUT6I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65AA227389784D48B8080DC8FBA572C0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0569386-e6a3-42f8-47ad-08dd551a9718
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 21:31:24.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RRkbP/0/kx8gv/7psbMj/DN44nNBexSscXn4EVYTEEVtHHXiUnHWyIK3nEaP5X7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

DQo+IE9uIEZlYiAyNCwgMjAyNSwgYXQgNDowM+KAr1BNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gDQo+IA0K
PiBPbiBUaHUsIEphbiAyMywgMjAyNSBhdCAwOTozOTo0NEFNICswMTAwLCBDaHJpc3RpYW4gQm9y
bnRyYWVnZXIgd3JvdGU6DQo+PiANCj4+IEFtIDIyLjAxLjI1IHVtIDIzOjA3IHNjaHJpZWIgTWlj
aGFlbCBTLiBUc2lya2luOg0KPj4+IE9uIFdlZCwgSmFuIDIyLCAyMDI1IGF0IDA2OjMzOjA0UE0g
KzAxMDAsIENocmlzdGlhbiBCb3JudHJhZWdlciB3cm90ZToNCj4+Pj4gQW0gMjIuMDEuMjUgdW0g
MTU6NDQgc2NocmllYiBCb3llciwgQW5kcmV3Og0KPj4+PiBbLi4uXQ0KPj4+PiANCj4+Pj4+Pj4+
IC0tLSBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jDQo+Pj4+Pj4+PiArKysgYi9kcml2ZXJz
L2Jsb2NrL3ZpcnRpb19ibGsuYw0KPj4+Pj4+Pj4gQEAgLTM3OSwxNCArMzc5LDEwIEBAIHN0YXRp
YyB2b2lkIHZpcnRpb19jb21taXRfcnFzKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KQ0KPj4+
Pj4+Pj4gIHsNCj4+Pj4+Pj4+ICAgIHN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrID0gaGN0eC0+cXVl
dWUtPnF1ZXVlZGF0YTsNCj4+Pj4+Pj4+ICAgIHN0cnVjdCB2aXJ0aW9fYmxrX3ZxICp2cSA9ICZ2
YmxrLT52cXNbaGN0eC0+cXVldWVfbnVtXTsNCj4+Pj4+Pj4+IC0gICBib29sIGtpY2s7DQo+Pj4+
Pj4+PiAgICBzcGluX2xvY2tfaXJxKCZ2cS0+bG9jayk7DQo+Pj4+Pj4+PiAtICAga2ljayA9IHZp
cnRxdWV1ZV9raWNrX3ByZXBhcmUodnEtPnZxKTsNCj4+Pj4+Pj4+ICsgICB2aXJ0cXVldWVfa2lj
ayh2cS0+dnEpOw0KPj4+Pj4+Pj4gICAgc3Bpbl91bmxvY2tfaXJxKCZ2cS0+bG9jayk7DQo+Pj4+
Pj4+PiAtDQo+Pj4+Pj4+PiAtICAgaWYgKGtpY2spDQo+Pj4+Pj4+PiAtICAgICAgICAgICB2aXJ0
cXVldWVfbm90aWZ5KHZxLT52cSk7DQo+Pj4+Pj4+PiAgfQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gSSB3
b3VsZCBhc3N1bWUgdGhpcyB3aWxsIGJlIGEgcGVyZm9ybWFuY2UgbmlnaHRtYXJlIGZvciBub3Jt
YWwgSU8uDQo+Pj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IEhlbGxvIE1pY2hhZWwgYW5kIENocmlzdGlh
biBhbmQgSmFzb24sDQo+Pj4+PiBUaGFuayB5b3UgZm9yIHRha2luZyBhIGxvb2suDQo+Pj4+PiAN
Cj4+Pj4+IElzIHRoZSBwZXJmb3JtYW5jZSBjb25jZXJuIHRoYXQgdGhlIHZtZXhpdCBtaWdodCBs
ZWFkIHRvIHRoZSB1bmRlcmx5aW5nIHZpcnR1YWwgc3RvcmFnZSBzdGFjayBkb2luZyB0aGUgd29y
ayBpbW1lZGlhdGVseT8gQW55IG90aGVyIGpvYiBwb3N0aW5nIHRvIHRoZSBzYW1lIHF1ZXVlIHdv
dWxkIHByZXN1bWFibHkgYmUgYmxvY2tlZCBvbiBhIHZtZXhpdCB3aGVuIGl0IGdvZXMgdG8gYXR0
ZW1wdCBpdHMgb3duIG5vdGlmaWNhdGlvbi4gVGhhdCB3b3VsZCBiZSBhbG1vc3QgdGhlIHNhbWUg
YXMgaGF2aW5nIHRoZSBvdGhlciBqb2IgYmxvY2sgb24gYSBsb2NrIGR1cmluZyB0aGUgb3BlcmF0
aW9uLCBhbHRob3VnaCBJIGd1ZXNzIGlmIHlvdSBhcmUgc2tpcHBpbmcgbm90aWZpY2F0aW9ucyBz
b21laG93IGl0IHdvdWxkIGxvb2sgZGlmZmVyZW50Lg0KPj4+PiANCj4+Pj4gVGhlIHBlcmZvcm1h
bmNlIGNvbmNlcm4gaXMgdGhhdCB5b3UgaG9sZCBhIGxvY2sgYW5kIHRoZW4gZXhpdC4gRXhpdHMg
YXJlIGV4cGVuc2l2ZSBhbmQgY2FuIHNjaGVkdWxlIHNvIHlvdSB3aWxsIGluY3JlYXNlIHRoZSBs
b2NrIGhvbGRpbmcgdGltZSBzaWduaWZpY2FudGx5LiBUaGlzIGlzIGJlZ2dpbmcgZm9yIGxvY2sg
aG9sZGVyIHByZWVtcHRpb24uDQo+Pj4+IFJlYWxseSwgZG9udCBkbyBpdC4NCj4+PiANCj4+PiAN
Cj4+PiBUaGUgaXNzdWUgaXMgd2l0aCBoYXJkd2FyZSB0aGF0IHdhbnRzIGEgY29weSBvZiBhbiBp
bmRleCBzZW50IHRvDQo+Pj4gaXQgaW4gYSBub3RpZmljYXRpb24uIE5vdywgeW91IGhhdmUgYSBy
YWNlOg0KPj4+IA0KPj4+IA0KPj4+IHRocmVhZCAxOg0KPj4+IA0KPj4+ICAgIGluZGV4ID0gMQ0K
Pj4+ICAgICAgICAgICAgLT4gICAgICAgICAgICAgICAgICAgICAgLT4gc2VuZCAxIHRvIGhhcmR3
YXJlDQo+Pj4gDQo+Pj4gdGhyZWFkIDI6DQo+Pj4gDQo+Pj4gICAgaW5kZXggPSAyDQo+Pj4gICAg
ICAgICAgICAtPiBzZW5kIDIgdG8gaGFyZHdhcmUNCj4+PiANCj4+PiANCj4+PiANCj4+PiANCj4+
PiB0aGUgc3BlYyB1bmZvcnR1bmF0ZWx5IGRvZXMgbm90IHNheSB3aGV0aGVyIHRoYXQgaXMgbGVn
YWwuDQo+Pj4gDQo+Pj4gQXMgZmFyIGFzIEkgY291bGQgdGVsbCwgdGhlIGRldmljZSBjYW4gZWFz
aWx5IHVzZSB0aGUNCj4+PiB3cmFwIGNvdW50ZXIgaW5zaWRlIHRoZSBub3RpZmljYXRpb24gdG8g
ZGV0ZWN0IHRoaXMNCj4+PiBhbmQgc2ltcGx5IGRpc2NhcmQgdGhlICIxIiBub3RpZmljYXRpb24u
DQo+Pj4gDQo+Pj4gDQo+Pj4gSWYgbm90LCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIHdoeS4NCj4+
IA0KPj4gWWVzIEkgYWdyZWUgd2l0aCB5b3UgaGVyZS4NCj4+IEkganVzdCB3YW50IHRvIGVtcGhh
c2l6ZSB0aGF0IGhvbGRpbmcgYSBsb2NrIGR1cmluZyBub3RpZnkgaXMgbm90IGEgd29ya2FibGUg
c29sdXRpb24uDQo+IA0KPiANCj4gQW5kcmV3LCB3aGF0IGRvIHlvdSBzYXk/DQo+IA0KPiAtLQ0K
PiBNU1QNCj4gDQoNCiJjYW4gKmVhc2lseSogdXNlIiAtPiBOby4NCg0KT3VyIGRvb3JiZWxsIGhh
cmR3YXJlIGlzIGNvbmZpZ3VyYWJsZSwgYnV0IG5vdCBpbmZpbml0ZWx5IHByb2dyYW1tYWJsZS4g
Tm9uZSBvZiB0aGUgc3VnZ2VzdGVkIHdvcmthcm91bmRzIGFyZSBmZWFzaWJsZSBmb3IgaGFyZHdh
cmUgaW4gdGhlIGZhY2Ugb2YgaW5jb3JyZWN0IGRyaXZlciBiZWhhdmlvci4gV2UgaGF2ZSBtYXJr
ZWQgdGhlIGZlYXR1cmUgYXMgYnJva2VuIGluIHRoZSBsaW51eCBrZXJuZWwgZHJpdmVyIGFuZCBt
b3ZlZCBvbi4NCg0KVGhhbmtzLA0KQW5kcmV3DQoNCg==
