Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D532580CB;
	Tue, 20 May 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722615; cv=fail; b=ciminqyD1LzUwD/ny40k5bRZgT974EsIE0++S+zDnrsnh8zPoVyivfO7EneeBw8VJ85EVPBC7Zs4TdZ8y7xrjOur5UpUyjQCs1gh4RK/FoMiB+J/+K0WnSi6jHtzgyzAgpWMmPG9N0iZ2ERFBn5Akr0HxIQ/r3yIeJTCD/0muc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722615; c=relaxed/simple;
	bh=QSBYuxNXSojgSkAfpuN/zC60NyftzhO+rWaSI1G8d+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TtX/7hAZS1sO+7CN1EbZ+P1QB4xuUXObwXaGZil5PWjOGLxueMPJHRWVmkm8HE93Q6bSzkWn7W+X6QjGOY84ES88OIcAlGQSS79ynph9R674jDNTekeWJHHFeIgEP7ts+AkAk0wTNkyre6xXN+RUCQuY3gUnMUryFh8Z2EBfl+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K59HK3015105;
	Mon, 19 May 2025 23:29:51 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46psykjh8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 23:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgCXTAvhWKxlxPTXIkrKhAJaNHpykcTDp4wlteXiakyotz3bPoimMhGSkhPiJwOej9lPLVWTPcal3dHzb2OdbxjirdszxZ210MeEBPhuCVwKN0r7NnBsLLSKyC8m7GVxYfKrAv1CM2sgb1Yrnfz02CkVN21vqaCR5skllziZlGfDXSVxu5ZFXC17VCIM+Rz8GDbTmSpvEqEezNYMTMikgpVDA4YLde5joUZ2P7Ir4xIBr7+hcB1J9h9H9SBbbcYJg+2ejKRygsmbOCqiV5gpaZvTNsn6NKFHvozjm/VMJaBCvTGUrmQewRSSoDMiMMWUnjq/SG96vYTmrD5K071+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSBYuxNXSojgSkAfpuN/zC60NyftzhO+rWaSI1G8d+k=;
 b=b0UiqBT7x6OcHzF80W19051zIGNc6gmC8EZDmcPvMNUvbD8OHFrp2lyK7RNTzP5a0LeOkBLTeLHp97QmFJX00xTOqFYIimS3FEBxtrvssoL/37H3fXTtnDyEYQ3f537g06xJnpq+/PWfikcoO3TAlDIjYaXkcs31v46v4pTKLP/ptjYBomOF2i3BwJB5M8TTsVN2UtaQHMXNsLy20VRksGgFQb8CA1sIIf+YVsCmCaKvh5G7gICz5mbgl+qKc6McRz9n1UkoM/fmIzix3pX5PF/eFP+W0WpFnPxx4qXov9CgselcXyVLhOdOBTsDvqEIyoLBqcTz/L72mpwFz/fDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Tue, 20 May
 2025 06:29:49 +0000
Received: from BL1PR11MB5979.namprd11.prod.outlook.com
 ([fe80::b0f6:fbc:94be:2372]) by BL1PR11MB5979.namprd11.prod.outlook.com
 ([fe80::b0f6:fbc:94be:2372%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 06:29:48 +0000
From: "Xu, Lizhi" <Lizhi.Xu@windriver.com>
To: Christian Hesse <mail@eworm.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>,
        "christian@heusel.eu"
	<christian@heusel.eu>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com"
	<syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggVjVdIGxvb3A6IEFkZCBzYW5pdHkgY2hlY2sgZm9y?=
 =?utf-8?Q?_read/write=5Fiter?=
Thread-Topic: [PATCH V5] loop: Add sanity check for read/write_iter
Thread-Index: AQHbuErx4Gy6Q3BfWU2VaFclcTtmhbPaPKEAgAC5koCAACwxgIAADW+z
Date: Tue, 20 May 2025 06:29:48 +0000
Message-ID:
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
References: <20250519175640.2fcac001@leda.eworm.net>
	<20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
In-Reply-To: <20250520073901.6fdfbee4@leda.eworm.net>
Accept-Language: zh-CN, en-AS, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5979:EE_|SA1PR11MB5802:EE_
x-ms-office365-filtering-correlation-id: e0d22066-c30a-4189-5225-08dd9767b879
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXBHQ0oydElEN2xzTzNlYkhQSTBDQ01PVlFnZEdvb3J6bUhUMTFtb0RHSmYw?=
 =?utf-8?B?S0c3VzlZOHE0Mmlub2dJZ0d1ZVV4c2Q2blJTVVpPdFJ0czRGMStSUHNvWWQr?=
 =?utf-8?B?U2VycXNvNzN5dTA1c243bjlBOXFYN3MvekFkMFBGb0U0c1RXa3FtQ01SV2lM?=
 =?utf-8?B?RTgrdmlRbWJncThoV25yRW9DVHFSSGx4NkhzZk5na25xYnFHRW5aeGh5b0Yv?=
 =?utf-8?B?VXp1ZFZBTkRNN29tYWw0Tm9HWlAwOEtvblBCRHo2aXlzbkU5clNBSmh5d1Na?=
 =?utf-8?B?THcvRk13VWJURm1vR0VhdjVsM1lEb3lFSzVnREFnZ2F0aE13KzcvdzY2UXhh?=
 =?utf-8?B?OS9ueXdtTFlsREd0OERpa1VSUkNvbWFEc243eXV2aG1UbEplcXBKbnNXaTBM?=
 =?utf-8?B?MVpPSnRBV2dxZTJjekFLNzdZRnJjWmk0Ti9tNkZpckthZWY1ZlRhZG4yNTJU?=
 =?utf-8?B?dFFpaFV1N3ZtM0VtclpmRTVqWEVmdUNZS1pPNjUvOTVGc0lSbEVjL25vTGls?=
 =?utf-8?B?ODhQNzNVS3hCc1FkdDM3YVZ1eWdkRjFManQrejR6TkpYbklXSkhGZStmTXpq?=
 =?utf-8?B?S1dWMHBiT056ZmZpRzhUK3YvWE5abmhoZkNLVG9UU0VuTW5aUHlod3Q5UTZ3?=
 =?utf-8?B?KzFsRzhnaE1MVnFqZWFwUFBxV3l5SVhDZnl4ckJwR1MzRkdVaHYwT0RCNFJL?=
 =?utf-8?B?d2xNZ0I5MG8xOVRVSVhsT0s1UC9OdDQ1UVFHZUQ0WUFSWm41eWY0RklBekZk?=
 =?utf-8?B?UnFkS1NYcFVhQjlDdTRTMWo2aG5kdmtiTDZGbzZZaTg3Q1JXM1E4SGozRS9o?=
 =?utf-8?B?Q3BOUUROS0ZNV09GR1VNUTlyWUFMTmgvbzR0V3pYc2RXbWJZM1hCNENaN2NI?=
 =?utf-8?B?TU1JOVVtVXVBV3I5UGFQVWJFS1hmNTc0VmpwbGw5bFJWY25Sc05VSy9sQVdT?=
 =?utf-8?B?VW9HZVU2SkVJeW9QbTU0cXRMSHA1VWhKYStnR0VNcTBad2U0RmxwM1lNTFVy?=
 =?utf-8?B?bWNiUXB5YWJmMk5pWmVOdzBDdWlSS1YvZERHcVRINGNqclBid3U1OEhrdzFq?=
 =?utf-8?B?S3hDN2pwSUFSemhBR3pSWW9DMHZLdUxHS01aSXdNVTZtUHh5dHpKcjQ4R1J6?=
 =?utf-8?B?MCtBM1JlVk15bzh5RnBmdGhSMUN1N0RuMVJxUmRQcmxXL01oUGM4d1ovemFx?=
 =?utf-8?B?UW1TOGFLcW1BaEtZNU1VcHEwc05ya3p2RDlYNU5ReGZPTDJsMm1PRzdQRGxL?=
 =?utf-8?B?QndxV0xzVjRMZ1Q3dlZtRlY3bFYvN3BjRHJDV2dWQmNqd2RKeUVwSlY5dHNh?=
 =?utf-8?B?VEc0VElxaXBmc1V2bDhYQitVWjV6OWFIRXZBL0x0dmRuRGJDZ2tycmdHVklr?=
 =?utf-8?B?TmtBeTE5d29lVjBXMSthKzliMlZLMjlrT0xZSHgwNFVHU0tSZk5rR2EwQ29t?=
 =?utf-8?B?WFFid3gyV1pSRmY4VDBLbmEzK0dIVFpKdi9xVURtNWRMcElLRktwc3VWT0di?=
 =?utf-8?B?c1BMUHNFZElwMDVGNDVFc0t2MDNsYVZ0UUlsY3dvdThYRGg3eWFXMllYUXlz?=
 =?utf-8?B?RnFsdDFYbEgwcUVSeWphRUFTdDA1ZitkdVIzMGw4NGNhbmxqanNycktQV0Vy?=
 =?utf-8?B?Ty9aUklBUWhmNVF2ekR6VFdsVkUrejVXYVVHaTlNbWErbnhxMS9GcU5iV3kv?=
 =?utf-8?B?UDlBMU9ZaHJEV3ZwNmtpMXJ4VHV6TUZhbmlxTWhiTDBhMXdIazBYSC9WS0hp?=
 =?utf-8?B?T0JTeVhKNXE1UHhpdnVoR0o5ZGJHaCthYUJ2eDFxT1d4akhlK1Mwc1ljOVZC?=
 =?utf-8?B?aUtGV1d4ZVBIazU0akhnc0JwcllteUgrOXhaemFIMkpEaEk1SDVDVFNrQVFP?=
 =?utf-8?B?Ynh1ZW9aZXNLOXJSR0JJbVNpdlJUZWwvNjMyMENEbWY0ejdWVzNoZ3l4dnJV?=
 =?utf-8?Q?bQHJCGHtpc8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5979.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c24rM29SR3dtTnE0Z1pjanNpRzhiOWFXWURxd0ZOcUpqQk5Gc1BTWW5CYTFl?=
 =?utf-8?B?bURyVHNkY1J0TEM0Z2J3VnVDbitGajF3b0VBUnBIZTdtNm9nMW1oekpWRmh6?=
 =?utf-8?B?Y0F4RGZQTEhwelhJL2M0MGFhbjVucngwSmdqc3dhSzIrMGtlU3RNWVlsRkFG?=
 =?utf-8?B?alV3QlVkaUF1V3ZTbVF2d3FRWnFUNW1ZZnJMT3FRZlZtVHc5S01KWkVQQk85?=
 =?utf-8?B?cmU4MlREYVBvQ0ptSGpMbXRiMFRxNFppbFRIeGUya0FQUTVFSnZYM2E0NE5X?=
 =?utf-8?B?RGozbkJ3TDV6MlFSTTBqUkVydStpeXJoVUM4RDUxSDg2bVdvSTVOVVVvWVR1?=
 =?utf-8?B?YkQ3aFVOd1hzUDVqNXJaZGJMN3FUc1ZDNVFDSWswNWljVGhYc21JSmhVQ3hM?=
 =?utf-8?B?cXk2anI0VFY5UG14bUxNZmNadzJWZUNDN09ZMTE1NDQ2TzlMNXA4K1RhSHBk?=
 =?utf-8?B?Qms2amdYV0JOV2JOVGFvWFNUWjNYSVhyQUQyMFBON0FwSStSY3lDZDBqaldo?=
 =?utf-8?B?VmdUWGV2MXlLRHkrbU4rSVkrL2FQTnVUR1kvVUF6ZXBEVFFSRU5TKzM4ZHhH?=
 =?utf-8?B?UlNJa2thNEJzUGFTNVRqMjdpdy9PT0xiWkg4VlBjWFgwLzBybENCSHNqT29y?=
 =?utf-8?B?TzBSY3lnTktDREQySzNMS0I4dFVzQXYxbWFjRjV5SXJrRzZDY09LODY2WCtB?=
 =?utf-8?B?dEYxNXVSN3F3NzMwZjMvZHFnS0syQzlIV0wvOWs2ZkkyQ0VJNGVPOWRWK1Zv?=
 =?utf-8?B?aTluRmpNbjJ3U1dSbVZZZTVGR3M4REd1ZEtKb2YrN2pkUkNlemdqWEthRWdv?=
 =?utf-8?B?TENWOUIvbTdGTndUdTF6MVpxVG9WRXl0MTRadjdyWHNyOStpSWtDWlBHYUYv?=
 =?utf-8?B?KzBhaEJGTldOVWxFWlVieG1acmtuODc4aCs1YTdHT21mM1A1RXBGNWpJRXJ3?=
 =?utf-8?B?dUIzbUlSdytBQ3pPeDRhdENqdTFQSmFuYnZxbk5uZ0pxTTRFMFNYUysrNDJu?=
 =?utf-8?B?WDdRa2xSVjFXRWFXOTJ0RHh2ek1FdjBWaW9tenhoV1RjTGRLbEFnQklUSi9W?=
 =?utf-8?B?YUo5MFYxODFHR2R1U3Z6QTcrRy9nWUtPMjBNNW5LOUZBRGp0d0JUbjgzazF4?=
 =?utf-8?B?cytnQ080M1Iyam5oN21jMC8xdzVKa3hraHhjV09SM2ZiLzdrbDhMVDlEdGh1?=
 =?utf-8?B?Y1lzdHhQUG1kMmp6RnJwMS9JeXZSMHFvQzlaNEkzVE9aN2hoMXNqOTd0cmRG?=
 =?utf-8?B?WW0vNnBOQWozaUlzNDRZU2VIbURkaU1vbXhkUmlTVWFSNXRrdjFkVndZZ2VS?=
 =?utf-8?B?RDBsZjBRMTZXRWkwZlZ4M2hPbGdFQXpkQjFndzZSaFJDZ1NxS1dFWW5NOGdM?=
 =?utf-8?B?MTBoSUwvcm9rM2VWRVNmdG1aSitNOGtVWTJKdjJtTzlVWDRPd1NaRXB3MjMr?=
 =?utf-8?B?WlU2azNOSFZtMFByRVZ6WkdQeE40azA1S2ErKzB6Q0N4TUk3SUhxKyttamRW?=
 =?utf-8?B?R3VORDNqSHpkU2c2aUtGbkVxb2p3a1I4RkVDRFZXZlJrNWw1UnhZMEs2emRF?=
 =?utf-8?B?VXEwRzY2c2svZ2MxVGZyWitDQStyWklTdmw2Q3ZUOTArZzBOeVJBM2dpaDNn?=
 =?utf-8?B?RzZVc3p1SmVpdk50cWF1VUFvMlRHWFVNekk2R3gzYWMrOHdmZWZZL0VBTjlw?=
 =?utf-8?B?dXdXa1p0Q1M5ZkZvSmpOUlo0YmtEZUllQ3FPeklFYTNDOWdnL1NDTnRLdHY5?=
 =?utf-8?B?VlM4T2ZwcFJ2NEEvdHBldW9CTmZiajJlL1h3alBLUlhBRzUvSTVzWFcwdUx5?=
 =?utf-8?B?SGFXcGZOaWZKcEVQNEtWSm9IYlZlTVFrTkNWMEQ0SDN0RlBCR0graHdEYWNC?=
 =?utf-8?B?bnNXeDlYYjQyU085MklSMlBKVTA4VWxaNG92bkQzSnh4bDZQTWRpcXZDOUI0?=
 =?utf-8?B?SVhQVVM4R2N1R3lXai9jUjNMRkZtVFV0bXBrQ0VMOEpKb051RU9kQ3ZBQmZl?=
 =?utf-8?B?V0dwSXJKRlhNWmZRTzNVRUg3b0Q5Wkx2a09UQnNvNE9mRWhtQXZoNk42QWNZ?=
 =?utf-8?B?TUlkME8xTkJuNU0vdEFBNlNPWlhQYWlkRExFTkk3WCtpanpaUnBtZGFZUnZH?=
 =?utf-8?Q?qjtgWH/uSVN/p+HmPE/4oqvRL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d22066-c30a-4189-5225-08dd9767b879
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 06:29:48.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6IJt6e0gf16bcSct+oo5zsk3AL2Pl4zHElHKs2joMlXkB5iioaDUwSD5kQXo0HcRpUfZE3CPFWPESpv84snkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
X-Authority-Analysis: v=2.4 cv=a8kw9VSF c=1 sm=1 tr=0 ts=682c215f cx=c_pps a=PdgAl9AEy1hEU2ikvxmBtw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=fxJcL_dCAAAA:8 a=qmU6OyjKAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=t7CeM3EgAAAA:8 a=t6vzeXTAS4MVXs9SptMA:9 a=QEXdDO2ut3YA:10 a=iNQtemt1gxbOOLyaF_ST:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -3ZgPoimMT2Kn3inowlc3EeeU5ORvzLO
X-Proofpoint-ORIG-GUID: -3ZgPoimMT2Kn3inowlc3EeeU5ORvzLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA1MSBTYWx0ZWRfX6T4V93X3sP2U UimrOz3lsB8yU8QBMN2FMajYmehqwu7Xsh719egmyjjzXTUpYKnSORxxGNBGEInfaccjDdeeSGR sQ9vET2F1pKIb6/eD7MtDyZiiYbg9UpGVvsGZJmEHyo3V6rJEY/w31B7mFVHdV7XnyEyZZkDEKN
 fBi5z5l7OYB8RIWqiRgGcbx5P3i9OpBnpdl8rImsB2oYUR1npkZdH5OI8dQMjuG8Q/aEVF9Fzhc 5SgT3aktMzsEmjerkZGFcsSWDLq/Xrh4tI7Ggrosfp9/rZtAkFFICkHrj+bpU+hOFKANtqgRNCl 6IXKjDGw+Vls3hGQIOk5BFuXOIfdl6Uu6yMlfHEGHFPYfG/166SPjM1fYlFkgoWxcjHI8SG/UOe
 +3ZNjrjwRF+30ZGeHD7BZuAg5HCnDN8iPOhEZNI+eTg+B9miGr086N83ESX5Qy+68imYWxni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200051

SSBmaWd1cmVkIG91dCB5b3VyIHN0ZXBzIHRvIHJlcHJvZHVjZSwgYW5kIHllcywgdGhpcyBwcm9i
bGVtIHdpbGwgb2NjdXIgaWYgeW91IGRvIGxvc2V0dXAgd2l0aCBhIGZpbGUgaW4gYSBmaWxlc3lz
dGVtIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCByZWFkX2l0ZXIsIHdoaWNoIGlzIHdoYXQgdGhpcyBw
YXRjaCBkb2VzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrlj5Hk
u7bkuro6IENocmlzdGlhbiBIZXNzZQrlt7Llj5HpgIE6IDIwMjUg5bm0IDUg5pyIIDIwIOaXpSDm
mJ/mnJ/kuowgMTM6MzkK5pS25Lu25Lq6OiBYdSwgTGl6aGkK5oqE6YCBOiBheGJvZUBrZXJuZWwu
ZGs7IGNocmlzdGlhbkBoZXVzZWwuZXU7IGhjaEBpbmZyYWRlYWQub3JnOyBsaW51eC1ibG9ja0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1pbmcubGVpQHJl
ZGhhdC5jb207IHN5emJvdCs2YWY5NzNhM2I4ZGZkMmZhZWZkY0BzeXprYWxsZXIuYXBwc3BvdG1h
aWwuY29tOyBzeXprYWxsZXItYnVnc0Bnb29nbGVncm91cHMuY29tCuS4u+mimDogUmU6IFtQQVRD
SCBWNV0gbG9vcDogQWRkIHNhbml0eSBjaGVjayBmb3IgcmVhZC93cml0ZV9pdGVyCgoKTGl6aGkg
WHUgPGxpemhpLnh1QHdpbmRyaXZlci5jb20+IG9uIFR1ZSwgMjAyNS8wNS8yMCAxMTowMDoKPiBP
biBNb24sIDE5IE1heSAyMDI1IDE3OjU2OjQwICswMjAwLCBDaHJpc3RpYW4gSGVzc2Ugd3JvdGU6
Cj4gPiAkIGxvc2V0dXAgLS1maW5kIC0tc2hvdyAtLXJlYWQtb25seSAtLQo+ID4gL3J1bi9hcmNo
aXNvL2Jvb3RtbnQvYXJjaC94ODZfNjQvYWlyb290ZnMuc2ZzIGxvc2V0dXA6Cj4gPiAvcnVuL2Fy
Y2hpc28vYm9vdG1udC9hcmNoL3g4Nl82NC9haXJvb3Rmcy5zZnM6IGZhaWxlZCB0byBzZXQgdXAg
bG9vcAo+ID4gZGV2aWNlOiBJbnZhbGlkIGFyZ3VtZW50Cj4KPiBJIHRyaWVkIHRvIHJlcHJvZHVj
ZSB0aGUgcHJvYmxlbSB5b3UgbWVudGlvbmVkIHVzaW5nIHRoZSBrZXJuZWwgY29udGFpbmluZwo+
ICJjb21taXQ6ZjVjODRlZmYiLCBidXQgZmFpbGVkIHRvIHJlcHJvZHVjZSBpdC4KPiBUaGUgY29t
cGxldGUgcmVwcm9kdWN0aW9uIHN0ZXBzIGFyZSBhcyBmb2xsb3dzOgo+IAo+IHN1ZG8gYXB0IGlu
c3RhbGwgc3F1YXNoZnMtdG9vbHMgZGVib290c3RyYXAKPiBzdWRvIGRlYm9vdHN0cmFwIC0tYXJj
aD1hbWQ2NCBmb2NhbCByb290ZnMgaHR0cDovL2FyY2hpdmUudWJ1bnR1LmNvbS91YnVudHUvCj4g
c3VkbyBta3NxdWFzaGZzIHJvb3RmcyByb290ZnMuc2ZzIC1jb21wIHh6IC1lIGJvb3QKPiBbLi4u
XQoKVGhhdCdzIHRoZSB3cm9uZyBlbmQgb2YgdGhlIHN0YWNrLiBBZnRlciBhbGwgc3F1YXNoZnMg
aXMgbm90IGRpcmVjdGx5Cmludm9sdmVkIGhlcmUgKHRoYXQgd2FzIGp1c3QgYW4gZXR4cmEgaW5m
byBvbiB3aHkgd2UgaGF2ZSBhIGxvb3BiYWNrIGZpbGUKaW5zaWRlIGlzbzk2NjApLgoKVGhlIGlz
c3VlIGlzIHNldHRpbmcgdXAgdGhlIGxvb3BiYWNrIGZpbGUgaW5zaWRlIGEgbW91bnRlZCBpc285
NjYwIGZpbGVzeXN0ZW0uClRha2UgdGhlc2Ugc3RlcHMgZm9yIGVhc3kgcmVwcm9kdWN0aW9uOgoK
cm9vdEBsZWRhIH4gIyBta2RpciBpc28uZCAKcm9vdEBsZWRhIH4gIyB0cnVuY2F0ZSAtcyAxMG0g
aXNvLmQvbG9vcGJhY2suaW1nCnJvb3RAbGVkYSB+ICMgbWtpc29mcyAtbyBpc28uaXNvIGlzby5k
LwpTZXR0aW5nIGlucHV0LWNoYXJzZXQgdG8gJ1VURi04JyBmcm9tIGxvY2FsZS4KwqA5NCw3NSUg
ZG9uZSwgZXN0aW1hdGUgZmluaXNoIFR1ZSBNYXkgMjAgMDc6MzQ6NTIgMjAyNQpUb3RhbCB0cmFu
c2xhdGlvbiB0YWJsZSBzaXplOiAwClRvdGFsIHJvY2tyaWRnZSBhdHRyaWJ1dGVzIGJ5dGVzOiAw
ClRvdGFsIGRpcmVjdG9yeSBieXRlczogMApQYXRoIHRhYmxlIHNpemUoYnl0ZXMpOiAxMApNYXgg
YnJrIHNwYWNlIHVzZWQgMAo1Mjk0IGV4dGVudHMgd3JpdHRlbiAoMTAgTUIpCnJvb3RAbGVkYSB+
ICMgbW91bnQgLW8gbG9vcCBpc28uaXNvIC9tbnQvdG1wIAptb3VudDogL21udC90bXA6IFdBUk5J
Tkc6IHNvdXJjZSB3cml0ZS1wcm90ZWN0ZWQsIG1vdW50ZWQgcmVhZC1vbmx5Lgpyb290QGxlZGEg
fiAjIGxvc2V0dXAgLS1maW5kIC0tc2hvdyAtLXJlYWQtb25seSAtLSAvbW50L3RtcC9sb29wYmFj
ay5pbWcgCmxvc2V0dXA6IC9tbnQvdG1wL2xvb3BiYWNrLmltZzogZmFpbGVkIHRvIHNldCB1cCBs
b29wIGRldmljZTogSW52YWxpZCBhcmd1bWVudAoKSG9wZSB0aGF0IGhlbHBzLCBsZXQgbWUga25v
dyBpZiB5b3UgbmVlZCBtb3JlIGFzc2lzdGFuY2UuCi0tIApCZXN0IHJlZ2FyZHMsCkNocmlzCgoK
