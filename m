Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9F15E89
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674507; cv=fail; b=kN0gwnOlHE1arwpF7zW0E4qMzp5zx6YeVPAIdFBPO7RTy/JwYk0C1SdpLfAXtBrTGwfgWSqHb/LKiDNQtnyeHKxUVbnhj7tFyTxjZBULNGGK7x8Nft8kXYpCk2MXqw6MFIfvcyEHU0Gh/a/TlBVG6F/ukpI/KUNYVjZ+Z9yDeWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674507; c=relaxed/simple;
	bh=KoT3nVX/RsqctgmiUnDq2MljwOIXr8YT4llEp8TpGpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K5DuCB2ubtGcZKs04DgE4A05n51sxE/thT+9lil5fFeY2Gc0gth63U1LOJsmGbGDRlaFZyzYnqgLCUCmsPvmPVipKQNl13crs69yzOpM4JRtdzuIjs5kt3gl7qTCLjONl8PcXqERqZcxRRYS4K1cmZtxdS9RHeBxb9w2Fpp/Tqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0939tFg; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0939tFg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNtF4o4nihukcrhHX22/7EnP3y2ZDS8jqEekzo3f+B30z9EwY+djIbkBfxbK1aPYFQhfosqiGpqHnT9EQThtdTrPk77pyjVKu+qWhR86UwwhFQFYT6LIaKENIq4DXcNaQRWfydnTHYTVvrKly8bnl6N4Z1vTLStsT0HnzRkQMC60iNjONCuAz5XzT8xTnQb0CzEB39F4hfyH0z0SuMymgOHM+ooBTtbQ3hHL11cnClbPHXGU6l+kr0cGLjXoLdsx0bYNDL9lV3rOEtvmBp9WUtkbXRU1taH4FQfCFpnUL4HDWrVjl8wkvsDdyh49GXuTggWrhWI1NB6M5PiExhGqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoT3nVX/RsqctgmiUnDq2MljwOIXr8YT4llEp8TpGpI=;
 b=ZojRKPLgoVQnUnXX2R/dQJbeK47PFkesnJR7kZR3H3eTB/rxo9OGHuZUjhyVl39gUgygBLyQDKkFgmj6HeKjKUWayxgulz00LbPz+nA3CjVVgBKF+skCUOqzHCZLqp6LyEjtSVNaZ1Dgq/MNomayKj/VjKU/ZV64Wu7b7zOAvndZ3fXvfGox1Owomrnv3cvTQ0NMnZbrdcWa3VEleeI1/DALz/8KZWT/vAGP1lSpebwlOH1sWtUVLNccGXUxkh1k+HXkfzIjEHjpfrEcr0dYJU8IfOBqy9Ly0vawpbsTJ0UqWNxwxc7sLWY/JVpT8RrrwN7GOcKicYrq09X6AD/P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoT3nVX/RsqctgmiUnDq2MljwOIXr8YT4llEp8TpGpI=;
 b=E0939tFgNNnf433CiI2lH95SpLNklMxbi/rAhH1mPj5c5ynBqUMA/2fzz9wlilyfYY3P5ox9MkN6OnMUk0WofPdVYt7hzNLne8KVNVRYU+323pLBlQS4HKztLLGhnCIcceWtamrfo2y2fK5OJpstFxu5UuHNdoJ99IrWJp7hHfp85jdMZDLPmFVqjWN12bpUrcCUHa5PVpr5779KidC7R7IFmpzdZPOUrKlfH8q3wLO3Db7OrjmEJXduRi3PxJsZsm+Uq9+rEuksDmsm+1IQcOugbeiqURTVKYvqLTfkD0RTrYcNXmjEePriLrpcAnhUCfV9NC/sHMoV841EJI4X9A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 01:35:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 01:35:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>,
	"sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests] loop: add test for creating/deleting file-ns
Thread-Topic: [PATCH blktests] loop: add test for creating/deleting file-ns
Thread-Index: AQHawJezOAFT+aRjHEuPgzc/4vCTA7HMvkeA
Date: Tue, 18 Jun 2024 01:35:00 +0000
Message-ID: <d0f6e41a-4cd3-42b9-865d-df75d3ffd2af@nvidia.com>
References: <20240617092035.2755785-1-nilay@linux.ibm.com>
In-Reply-To: <20240617092035.2755785-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8884:EE_
x-ms-office365-filtering-correlation-id: 5f0a8cba-b2ce-4d64-2e9a-08dc8f36decc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?OG1tbHlSSmZERU5uZFRPUDFBWlB0MTdwQ2x5YUpWTzZNRU1pdXdjRndGOFhN?=
 =?utf-8?B?WEU4ZE81a2pQVVNSSEhlRGhocWZjUmxCK0lRTHlKSTFpK3lhM2ovOHMxTmlO?=
 =?utf-8?B?L2E2eHVTd3FqWUc1ZHh0T3k2aFkraXFDWXRLcW5yTGs3N3E1OVVhRGpXRkxQ?=
 =?utf-8?B?QUtUYVRuc0NEaEpTcFFjWHRKa2hFaW02M1d4UStrWU8zN01BVEZWYjhjZ1Fm?=
 =?utf-8?B?Q1lJcVpFUlByWGp1R2R6RlU3Y042YThrT3JVQVlVQ3dWZlRnd3A1WmpLbnFN?=
 =?utf-8?B?TklEOVRpcnZyYTFYL2NsU3NnRm5xd01qQk5vRktQY0JpSE9DUDBwR3JmbjJ1?=
 =?utf-8?B?cnR5WVlFZXh4bmQ5SXE1TUpDeWc1d25OcTkrR21OWEhWVTQ3QXUvakxsL0x4?=
 =?utf-8?B?K1hPRTVWdHBna2hTSlhjNS9HU0I1MWtjYjdFRjY3NEpsUTJ2S2VJV0xWdkl0?=
 =?utf-8?B?SXJjYW41eVg3dDhySlJ5ZjBGQWJEUFQ2YU9RTU52RkV2RjdVTnVKRFVnNmpP?=
 =?utf-8?B?SkdhM1dtYjZZQ3RuZ0I4ZnhHdUhhUy80MWZYR1lSK2FjZThWdmhkZ3phbkgx?=
 =?utf-8?B?dUZ6UmRNaHdWQkV6VnprVXNzSnhIY2cvYWhaWCsvNENWajJnU25rS3BXcktV?=
 =?utf-8?B?M2ZQUER6L3h0OU8reFpJdU1pSFFKN2Z6NVJTUVI4YXdsUXp2TmZEVWNsSjlr?=
 =?utf-8?B?NVVrcCtkYUlQTzNWUWxUVnZRVXU2N1VlL0s4bGdBNUpDdFMxY1VhVUhRdFdS?=
 =?utf-8?B?TlF6c0h0N1EyU1dmMTJLcWdCbmZaTEJ1S0VkbWkzYW1BUVFML3ZzZjY4cGdj?=
 =?utf-8?B?UHE2Q1AyS0xEYVZzbFp6bUR1UnQxcG1La2IzVU9JU3k5dm03UDBSc2Nuc3hl?=
 =?utf-8?B?SnRWbjBqOGljc1gvd01PL3N4MEdWa1dUaVp6b0owSFhZTU0yUzNLZlIvb2JQ?=
 =?utf-8?B?aUhyMXpiUlVDU3RDV0p4QzlKb3krK0twdjN1TWMzS3JUVndaaDh3Sk9iREQw?=
 =?utf-8?B?TEdqRUVMdE14ZmxIVDdIWjkxYnBrN05CeVRQVHorUStXLzQ4N2VmY3pXWXVj?=
 =?utf-8?B?eDVlZjRWY3F4QjJ4VUVrbVJxV1gra3dwWUZNYVcwRC9sbnl5Vm5STWk3QmhC?=
 =?utf-8?B?U3FOcEJKNDRYYTdSOUR5c2UvUWFiQ29ocWFSVFFJTG56WXVBdDJTcWpkNHlQ?=
 =?utf-8?B?a1YyV2tKMlF0NGNYamNhNTE4cTFaMWRNYkFwS01nR0VHMzhBZHJKLzhjcFQ2?=
 =?utf-8?B?UFEwYkx4dEZSbno3Y1JTZ3NnU1NEdmdIdUwwOEQxUmthakZGTm9OZlppd3Yy?=
 =?utf-8?B?ZGVkVWlMa2ErbnpvS1F1ZVgzQUR5MWM2Wkp5dm4vOE1ndmF4ei9sUTN0d3Ax?=
 =?utf-8?B?aFlheEFuRndqRUJzTWZoVk1HaU05cjk4YThrZ1RrVVB0VlBhcnBiaHRla0lw?=
 =?utf-8?B?b1ZLa3ZXc0VMMnFvaWtzcFVib1lhN3h5Q0FaSWR2LytBNTZ4eXlmYk1mZHY2?=
 =?utf-8?B?cHNFWjI5VDVjRm9uWmVrb1hhdTE2NTR1TkhHck5tSlQzQVVQVHR4VGhuSHpX?=
 =?utf-8?B?UmQ4UEhSOWFWTnVxY1FxVUNVSll4R3JvTzUrSnJrWW43bGFRVEJYQkJzbnI0?=
 =?utf-8?B?cmNIMFdZQlE4eXNsTmJIU0dHdDliSkRzNTRrS29rRWVqT2FXN01mby9HR1VU?=
 =?utf-8?B?RWNNZWZMNldialZaVi9hb2RSc0lPMWU0RFVwNU0rbzNXS0YxendpRDB6U1hW?=
 =?utf-8?B?V3F6TGcwcGY5WFZJYU9nWVdDSzIrcHVnL0lhS1BMa1EwczJhQ2NWRDBlQ3F5?=
 =?utf-8?Q?tD3wGZpEwtabehpLtAcvDx78v17POpV398EFQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnlzZWNqTFFyUUkwVFl0NVc1S2JFSVBNdTVISHFGeCtqdVIzTGt0MVh0RjRa?=
 =?utf-8?B?TVNOVVgrYWs5dUtYN2FjdEwybFNIU3JianI4cUxSOGJYd25NTWdIZWp1RFB2?=
 =?utf-8?B?c3JCUS9wR3o2eTlEemdmVnl1V0k2aE5QTVRFN1lyQjYrZitBR01uaHlYZFQ4?=
 =?utf-8?B?b1NTLzBKL01VVFAvMCtuQ0VHWmVOSzZSa0V6MVJWRjFqbkMvN3ZybDdkbVJG?=
 =?utf-8?B?UzAvV2wrZHVwY3c4U1Z2T0EveFU2TmMxVXQvRjMySDdaSTk3ZzY3THdlWXRu?=
 =?utf-8?B?MjYyKzB2b0tpclRwKzZzTTdqWlJ6QmtXOGJQME9OOWN0VkVpQ2RSeVpuK2wv?=
 =?utf-8?B?SG9YNmE1OEJYbDh1ZkEyWGtXNFl4MkpxNlFDZjJXc1NCeWxMcmNXNVRFQ1dp?=
 =?utf-8?B?QjJhTWRXZEFXdjF5Y3h4WjJBTmJSV0xEMU4xLzJNOS9wbVU0VkpYYmFrMjJi?=
 =?utf-8?B?V1oyK0ZqRk5hK0hDZWJpVFVVV2Y2cHZyWkQ1UXZ1M2k1UHFLN1FXaXplRHkv?=
 =?utf-8?B?RWNpRFVOOUZXamFMWVo2STRMQVYzSWdxRDY4NjN1TXhNU0xoQWRUU0t5bFRX?=
 =?utf-8?B?RUdnMFFDVkU5dGhqRG83c3pTcld5bzUySTlkM1oyb3hGTHR5TmdvV21ydkJX?=
 =?utf-8?B?cXg3ZFNOWjBadWV6UkxWOTN3MktYVkFZZTROR2RONDdCQmFYWVhMd0tONnlT?=
 =?utf-8?B?TUVoVjgrMTVFYk44WUtyUHFnR3c4WVVVV2phMjhydXd3aFdvbkhsR3hZOXE5?=
 =?utf-8?B?Sm5obWZWZ1lLQTJWVlowbzViQjZSTC9BemJpTkk4TDVzUW1rNUtROS9FS0lW?=
 =?utf-8?B?R01zREJMQlBaeUZUc3pqVlNJT1JNeUpWclp2L0I3Nnc0M1Y0Ulk0N1JjZVc4?=
 =?utf-8?B?OStrQWswRm0rT0IrUzhCenNiUTZSbjhtL244YVZFTVdPLzRWSW15SE9hZ0dC?=
 =?utf-8?B?Q0pWcnMvZWJxVnlOTDY3bHVVbUhZQTdLVktiQlJ1RHJQOTRnSmU5eU51cVBo?=
 =?utf-8?B?eDdXRUZuTnFuYjUxeUd5b1pLSXFLd2s3ZGwvczJkcnBTYnhwckNySnZDa3ZC?=
 =?utf-8?B?dXMxQUh5K0lIRzlFSUFTL1NQM0JPMFcwUVJkL0sxYmxIRGFCbWtFdnZ1OFQx?=
 =?utf-8?B?NWpYdDZVRjVvRW4wTldjejB5R01EMS9vMERXbDBpOVhPdDM0R29KNTlPcWJY?=
 =?utf-8?B?dmdZTEJQbk02RHczUC8zSE1xQVhTaStqNTZ1MTVqc1BHaUtHb1g2UjZmMnRG?=
 =?utf-8?B?V2RJc01lRHRyQ3lHbE9ZajYrUWlNdmw4YUt3YVM5U1hGNTA3bUlSSmZXOGQ3?=
 =?utf-8?B?MjNEdHlubGVEdys0c0lFdVIrYnVRd0xFTkk5dlM5a0tvRkxiTFlYMXdBT2tK?=
 =?utf-8?B?WUk2dHRLOVByRXNJMWR2V0J6RFMzNCs3QTB6ZUZFa2xYcFNlZEdBUGMrb2VG?=
 =?utf-8?B?elZXUVZSTFM5WVMxRFZHOEtiYVFBcGd0QWRFb3F5UUhhbDVWMS9WamQyRm9x?=
 =?utf-8?B?cnZQNmpkd3pKZlVzY2YrY3YrSFdLZHNyUTFWR2pXbWd2dG9XakJnQ0V2aEVM?=
 =?utf-8?B?S3BPMkJpUnRzanJlTnJFaTBYdlJOOEtLdzJSbWh4OGF3L3BSUXpQeXdyMFBm?=
 =?utf-8?B?ckZxK0dmKzhORUZRUGtHTWxPNjM4b1RNaDc3YVdwUXdWOGVCc29qanNrb2dt?=
 =?utf-8?B?eS9OR1JpdlZDNGRJTjREeHZ0RTA3S29GMFlQRnMwZHlsY0tEN3NRTlBqamlN?=
 =?utf-8?B?bW0rRmZRSTdPYjYvc0FqTmlGVHhrbHRycXRDbnpNdTFZU0FjOWR0cGZrYWdj?=
 =?utf-8?B?TWFBdmtWc2Myd051Z3BoaitzL0o1aXJUa09LRWw5c3BXeldBbWVMOWw5a2FT?=
 =?utf-8?B?Z1pxbDl1bUk0L0lwaWtTaXRIenZ5ZUpmT3d4T0FkbGNOTTZZbHBKV3ZIME1w?=
 =?utf-8?B?TTNvb1NCWk5ydHBML3EvbkF1QzN4U2dSTFhDd2VwLzZSWnlsMWxvamwzenZ2?=
 =?utf-8?B?d0gxMml3ejRYRXI0N2RjNk1nQmc3d1M3NlpMeWlKc0xKV3FhT1g3OVUxVyty?=
 =?utf-8?B?UjNaSFI3YVF3dEZqRnZURHVZck1sdG1TY0RaUVVpTXNoR0p0NTFBUDNJZkNL?=
 =?utf-8?B?TjJvdEhmRk0rZ2lKUzRNVXNFSHBzN2tJMkRvbXBIU2JKRW1YQlpqaVJseFhX?=
 =?utf-8?Q?S/vgZfUGs9lJuD0rqjiu/SNS86Ozq4n/SyG3t4r6mCip?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F98EC56E6736B40A47DCBFFF91E198B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0a8cba-b2ce-4d64-2e9a-08dc8f36decc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 01:35:00.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srCKRvT3jhmgWuFZR76TauDG3x4wEEn0XoKX1UBOBtH8UgQ+UFVsTd74hps2Z9u7smRw42oaHFpivBrie6urPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

T24gNi8xNy8yNCAwMjoxNywgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KDQpJIHRoaW5rIHN1YmplY3Qg
bGluZSBzaG91bGQgc3RhcnQgd2l0aCBudm1lID8NCg0KbnZtZTogYWRkIHRlc3QgZm9yIGNyZWF0
aW5nL2RlbGV0aW5nIGZpbGUtbnMNCg0KPiBUaGlzIGlzIHJlZ3Jlc3Npb24gdGVzdCBmb3IgY29t
bWl0IGJlNjQ3ZTJjNzZiMg0KPiAobnZtZTogdXNlIHNyY3UgZm9yIGl0ZXJhdGluZyBuYW1lc3Bh
Y2UgbGlzdCkNCj4NCj4gVGhpcyB0ZXN0IHVzZXMgYSByZWd1bGFyZSBmaWxlIGJhY2tlZCBsb29w
IGRldmljZQ0KPiBmb3IgY3JlYXRpbmcgYW5kIHRoZW4gZGVsZXRpbmcgYW4gTlZNZSBuYW1lc3Bh
Y2UNCj4gaW4gYSBsb29wLg0KDQoNCnMvcmVndWxhcmUvcmVndWxhci8gPw0KDQpuaXQ6LSBjb21t
aXQgbG9nIGxvb2tzIGEgYml0IHNob3J0IDotDQoNClRoaXMgaXMgcmVncmVzc2lvbiB0ZXN0IGZv
ciBjb21taXQgYmU2NDdlMmM3NmIyDQoobnZtZTogdXNlIHNyY3UgZm9yIGl0ZXJhdGluZyBuYW1l
c3BhY2UgbGlzdCkNCg0KVGhpcyB0ZXN0IHVzZXMgYSByZWd1bGFyZSBmaWxlIGJhY2tlZCBsb29w
IGRldmljZSBmb3IgY3JlYXRpbmcgYW5kDQp0aGVuIGRlbGV0aW5nIGFuIE5WTWUgbmFtZXNwYWNl
IGluIGEgbG9vcC4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBOaWxheSBTaHJvZmYgPG5pbGF5QGxpbnV4
LmlibS5jb20+DQo+IC0tLQ0KPiBUaGlzIHJlZ3Jlc3Npb24gd2FzIGZpcnN0IHJlcG9ydGVkWzFd
LCBhbmQgbm93IGl0J3MNCj4gZml4ZWQgaW4gNi4xMC1yYzRbMl0NCj4NCj4gWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMzEyZTZjMy1hMDY5LTQzODgtYTg2My1kZjdlMjYxYjlkNzBA
bGludXgudm5ldC5pYm0uY29tLw0KPiBbMl0gY29tbWl0IGZmMGZmZTViN2MzYyAobnZtZTogZml4
IG5hbWVzcGFjZSByZW1vdmFsIGxpc3QpDQoNCml0IHdpbGwgYmUgaGVscGZ1bCBpbiBsb25nIHJ1
biB0byBhZGQgYWJvdmUgaW5mb3JtYXRpb24NCmludG8gdGhlIGNvbW1pdCBsb2csIFNoaW5pY2hp
cm8gYW55IHRob3VnaHRzID8NCg0KPiAtLS0NCj4gICB0ZXN0cy9udm1lLzA1MSAgICAgfCA2NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMv
bnZtZS8wNTEub3V0IHwgIDIgKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMo
KykNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvbnZtZS8wNTENCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGVzdHMvbnZtZS8wNTEub3V0DQo+DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9udm1l
LzA1MSBiL3Rlc3RzL252bWUvMDUxDQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAw
MDAwMDAuLjBkZTVjNTYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9udm1lLzA1MQ0K
PiBAQCAtMCwwICsxLDY1IEBADQo+ICsjIS9iaW4vYmFzaA0KPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTMuMCsNCj4gKyMgQ29weXJpZ2h0IChDKSAyMDI0IE5pbGF5IFNocm9mZihu
aWxheUBsaW51eC5pYm0uY29tKQ0KDQpub3Qgc3VyZSB3ZSBuZWVkIHRvIGhhdmUgZW1haWwgYWRk
cmVzcyBoZXJlIGFzIGl0J3MgYSBwYXJ0IG9mDQpjb21taXQgbG9nIGFueXdheXMgLi4uDQoNCj4g
KyMNCj4gKyMgUmVncmVzc2lvbiB0ZXN0IGZvciBjb21taXQgYmU2NDdlMmM3NmIyKG52bWU6IHVz
ZSBzcmN1IGZvciBpdGVyYXRpbmcNCj4gKyMgbmFtZXNwYWNlIGxpc3QpDQo+ICsNCj4gKy4gdGVz
dHMvbnZtZS9yYw0KPiArDQo+ICtERVNDUklQVElPTj0iVGVzdCBmaWxlLW5zIGNyZWF0aW9uL2Rl
bGV0aW9uIHVuZGVyIG9uZSBzdWJzeXN0ZW0iDQo+ICsNCj4gK3JlcXVpcmVzKCkgew0KPiArCV9u
dm1lX3JlcXVpcmVzDQo+ICsJX2hhdmVfbG9vcA0KPiArCV9yZXF1aXJlX252bWVfdHJ0eXBlX2lz
X2xvb3ANCj4gK30NCj4gKw0KPiArc2V0X2NvbmRpdGlvbnMoKSB7DQo+ICsJX3NldF9udm1lX3Ry
dHlwZSAiJEAiDQo+ICt9DQo+ICsNCj4gK3Rlc3QoKSB7DQo+ICsJZWNobyAiUnVubmluZyAke1RF
U1RfTkFNRX0iDQo+ICsNCj4gKwlfc2V0dXBfbnZtZXQNCj4gKw0KPiArCWxvY2FsIHN1YnN5cz0i
YmxrdGVzdHMtc3Vic3lzdGVtLTEiDQo+ICsJbG9jYWwgaXRlcmF0aW9ucz0iJHtOVk1FX05VTV9J
VEVSfSINCg0Kbm8gbmVlZCBmb3IgYWJvdmUgdmFyLCBJIHRoaW5rIGRpcmVjdCB1c2Ugb2YgTlZN
RV9OVU1fSVRFUiBpcw0KY2xlYXIgaGVyZSAuLi4NCg0KPiArCWxvY2FsIGxvb3BfZGV2DQo+ICsJ
bG9jYWwgcG9ydA0KPiArDQo+ICsJdHJ1bmNhdGUgLXMgIiR7TlZNRV9JTUdfU0laRX0iICIkKF9u
dm1lX2RlZl9maWxlX3BhdGgpIg0KPiArDQo+ICsJbG9vcF9kZXY9IiQobG9zZXR1cCAtZiAtLXNo
b3cgIiQoX252bWVfZGVmX2ZpbGVfcGF0aCkiKSINCj4gKw0KPiArCXBvcnQ9IiQoX2NyZWF0ZV9u
dm1ldF9wb3J0ICIke252bWVfdHJ0eXBlfSIpIg0KPiArDQo+ICsJX252bWV0X3RhcmdldF9zZXR1
cCAtLXN1YnN5c25xbiAiJHtzdWJzeXN9IiAtLWJsa2RldiAiJHtsb29wX2Rldn0iDQo+ICsNCj4g
KwlfbnZtZV9jb25uZWN0X3N1YnN5cyAtLXN1YnN5c25xbiAiJHtzdWJzeXN9Ig0KPiArDQo+ICsJ
Zm9yICgoaSA9IDI7IGkgPD0gaXRlcmF0aW9uczsgaSsrKSk7IGRvIHsNCg0Kc21hbGwgY29tbWVu
dCB3b3VsZCBiZSB1c2VmdWwgdG8gZXhwbGFpbiB3aHkgYXJlIHN0YXJ0aW5nIGF0IDIgLi4uDQoN
Cj4gKwkJdHJ1bmNhdGUgLXMgIiR7TlZNRV9JTUdfU0laRX0iICIkKF9udm1lX2RlZl9maWxlX3Bh
dGgpLiRpIg0KPiArCQlfY3JlYXRlX252bWV0X25zICIke3N1YnN5c30iICIke2l9IiAiJChfbnZt
ZV9kZWZfZmlsZV9wYXRoKS4kaSINCj4gKw0KPiArCQkjIGFsbG93IGFzeW5jIHJlcXVlc3QgdG8g
YmUgcHJvY2Vzc2VkDQo+ICsJCXNsZWVwIDENCj4gKw0KPiArCQlfcmVtb3ZlX252bWV0X25zICIk
e3N1YnN5c30iICIke2l9Ig0KPiArCQlybSAiJChfbnZtZV9kZWZfZmlsZV9wYXRoKS4kaSINCj4g
Kwl9DQo+ICsJZG9uZQ0KPiArDQo+ICsJX252bWVfZGlzY29ubmVjdF9zdWJzeXMgLS1zdWJzeXNu
cW4gIiR7c3Vic3lzfSIgPj4gIiR7RlVMTH0iIDI+JjENCj4gKw0KPiArCV9udm1ldF90YXJnZXRf
Y2xlYW51cCAtLXN1YnN5c25xbiAiJHtzdWJzeXN9IiAtLWJsa2RldiAiJHtsb29wX2Rldn0iDQo+
ICsNCj4gKwlfcmVtb3ZlX252bWV0X3BvcnQgIiR7cG9ydH0iDQo+ICsNCj4gKwlsb3NldHVwIC1k
ICIkbG9vcF9kZXYiDQo+ICsNCj4gKwlybSAiJChfbnZtZV9kZWZfZmlsZV9wYXRoKSINCj4gKw0K
PiArCWVjaG8gIlRlc3QgY29tcGxldGUiDQo+ICt9DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9udm1l
LzA1MS5vdXQgYi90ZXN0cy9udm1lLzA1MS5vdXQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMC4uMTU2ZjA2OA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL252
bWUvMDUxLm91dA0KPiBAQCAtMCwwICsxLDIgQEANCj4gK1J1bm5pbmcgbnZtZS8wNTENCj4gK1Rl
c3QgY29tcGxldGUNCg0KdGhhbmtzIGZvciB0aGUgdGVzdCwgSSB0aGluayB0aGlzIGlzIG11Y2gg
bmVlZGVkIHRlc3QgZXNwZWNpYWxseSB3aXRoDQpyZWNlbnQgcmVwb3J0ZWQgaXNzdWVzIC4uLg0K
DQotY2sNCg0KDQo=
