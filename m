Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAE35E93B
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167246; cv=fail; b=WoPI+qxHgXvbGiAHRzQ5CDm9tuLL4GvZHzKxsr4H4WdSo8g7LVQzwdK0fSh5K+0fW9/7C/dVojBoKXBRmFqB0L0vA345Tj2Yn/8WnWw5l+QN9Ou2lBxLDAerrPwGFbN77uGfzgHwpecaVCyFSqjWr3won1pMURl1Koy/s1y3cG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167246; c=relaxed/simple;
	bh=U2Y8ZE/VUOKpjt8SZexVM/cwcYIr+QZ+xWzU63DWyeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOqipafsXrmtv38tlQLsBlif7zICSls1ovorQJVFR6FGECyHqJchrIBXDhtmUkUc371uwStKRH3ygdYRltypcPy6qiCc211GEpT0CQBN6qOkIearR21TBohwSL+zXLzHGp7pc0Y7jAqPnLTpomByHf+ThAcEEjyZhsokUjWnTjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G94Bg7Ec; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wX4n61el; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G94Bg7Ec";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wX4n61el"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782167245; x=1813703245;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U2Y8ZE/VUOKpjt8SZexVM/cwcYIr+QZ+xWzU63DWyeY=;
  b=G94Bg7EcVsarm9iaaqQP2Oj7lg4E18UuFg3JdY/iuq3Co9auGNw7DBg/
   JxeBJ8jYBt+Evqvi3tF700UdB5qtBM5RedTvs5xPBNH7onU6xAkjJkSso
   MM4tNKZn7tlZYBSvg29RG05R3GpIu0s95jNC6z5+PTtvVzT9cSLtlGV2S
   AlXfQXq65/drofR2wEgCi0n6jhB69VCAp353CN/X/FKKVvaqz/sIGoekn
   subi7fNKoq4UPu6WJDn95yFBHAkUqwN8J5vHu/934YJLuAmk7HPAUwoh0
   9vw6/GmPZhilmSmJQSpCTTjTCTHMYPAuYj8JwDaKETZkPkg/1k1sDlfHO
   g==;
X-CSE-ConnectionGUID: XhgL8gp8T6WPzZeQT7oDxw==
X-CSE-MsgGUID: 0LjQ7VdLRQ+9F8Pq631lQQ==
X-IronPort-AV: E=Sophos;i="6.24,219,1774281600"; 
   d="scan'208";a="145486085"
Received: from mail-westcentralusazon11013061.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.61])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 06:27:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6jO0f/ls85nlYIrmHmy8RhhegwGn5GbRbME7NQCfpgLyk5f2oL3iWl9N4+SUKmgT3lviASS0JTw+cIqbOZsp2JOjxw0Y1Ca0C9aKXKGUn5rF6ZoQw+PDm+lrIcAtyIZF1Q9b48+j40/RvUtufrSGIMSwXfQH+mywgadGjmSSfgxeXfFGWgG0hgnCoHv+vpShA3FOXJ4rx1CYIiqW/HxQdLOCBeMrE0uvBtcOVoedi5vnrKrG2hKfQNdEQupYmntmTJh62wC6KxZaQtkVmjDHCsXxtmkXWedf8T1sAe0DVMg/M7nNdTzSoODq99oFotpklIBwmHFM7oDeVH+km2ZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH/ghogdTzGpma9c7n6hMJHwxiVvcIE8NvNAhMYMado=;
 b=JENi9xWVB8Wbr6a2Uxftd4XyzxWXMACs1TNly00RboV1Mnn8iR71uOfQ0+Zx21oWa17aub0NAL86FHgPGs5bgopHpi9umQhz7zGonKBmuG2XM94//6pEp57apOjsn8AXLQor933rOItZt0Futxev7Q+eID3gJiqqw7V4oBbF0hl3+R+IOGQgTGqPZscIhHjRtZzL+mtrhM4hQgP1768L9/a4kobFHvTbq7rz8OvkXf1z/3Iq9qukGAnKYqe837Zl1S6UtQMNfp9pt+eipKw0WZy/n8jrmJjzQikS1ebWuDMpD7CSPiiS0lOMp7T81bZZ64qJin2H7q7PfVoSSSs2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH/ghogdTzGpma9c7n6hMJHwxiVvcIE8NvNAhMYMado=;
 b=wX4n61elqp/hnfYgVkjN46NVGoeYkDLLWLmSEtN5Gn1oynqIkYcqTpvHX00+E69P+uTyM/dMDBigKQ7L/YgUK5ew1rkKsXFVtKXBAKw1UQ84LaItUSSC5tScqkLa2BdJDixM4/hmwwOthoQoC14kIq9S/49GMNEbX41VxOTmLfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by SJ0PR04MB8424.namprd04.prod.outlook.com (2603:10b6:a03:3de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 22:27:21 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%7]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 22:27:21 +0000
Date: Tue, 23 Jun 2026 07:27:15 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jeff Moyer <jmoyer@redhat.com>, 
	linux-block@vger.kernel.org, kch@nvidia.com
Subject: Re: [PATCH blktests] Fix _get_page_size()
Message-ID: <ajm1x0koQ4BftBOc@shinmob>
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
 <ajXmBu9lDZwgMG7_@shinmob>
 <d0432702-ac0b-410e-9586-2cb9be079033@acm.org>
 <ajYabLMbEo6zyOWh@shinmob>
 <089e0281-4df8-4358-91ce-1f5cc0f0ec4b@acm.org>
 <ajkeGQd-0LnKJbHN@shinmob>
 <ajlxXfgpMQJ4qlRR@telecaster>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlxXfgpMQJ4qlRR@telecaster>
X-ClientProxiedBy: TY4P286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::19) To DS3PR04MB10053.namprd04.prod.outlook.com
 (2603:10b6:8:38f::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|SJ0PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 000d872c-42db-4df8-e758-08ded0ad6d00
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HgLOMtB4PB5Of4WlF+bMQyFyGJkEAU9yf72ztTWo7Kz4WLHqrSgQOubfjEePX6d45dChIYiR01SbEy14e6e9lPIZl/gHHR1ak01gmbPrLPHzILanLapbGD1oSQN4dzyoUFIAls1g0D9ic+FjEd1SZG7S+Fa9aJjQqSWJ3diyEElhgSvZo7ygEyBbK08cT0E9FVrvILzaBuQht6cqVjg+JjIW44h4FzOGPFe7tU/omgXBhE2S4lFahrc2fc7RWcIbgcihlL+I29CZrk+OrX1gc5YzNxWgC9dASaZl/UX+GI/NBTBB5lLaExPUI6aaZNfxw4fhGYMrkoIqmdKlegW/IkRqxq5mv6xbrv1paOkK0Ywq9BuXYMP5HkBTfR9mfHuixEFEnt/exS5sVNn+rCakLN6m65IJtS5bOmMmjeGvZyhlrsGk1aLxdGVdjdXDXxqQIXCVoRrkdu8aazte5G4YULxeyLDsVUA3V4aHCB9tI7q54SE3+EnV6X0nwa7sAeNSgEK/fSStbIB+qRO2NrJ59J015xB6zh7sktbUHdk/p2EsVtcoIUqMKZqx4AN46coM7WA5M8PvqrtZTV1v58KV3wUca/leXruSY+LAfzGaYPUjSDJRxrHUH7EU0+0t4Vl9JAU5Bub9KKNWFs55yuK3X0JNmi2kM8dmMOktybqirZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJ0ip37nM8wvEuUZWl+U9Fgk5hQWqGoNANmYD/v/l6GPHkude5bn7lUwgUvW?=
 =?us-ascii?Q?IlWhysuD1e9T6p0udc/xoHVLqZSiWtybRqVNGspiNok8u0fZGzM9oXGESjF+?=
 =?us-ascii?Q?bCwNJqjv3HMxuG4XmAKQzDC2Cnmaoo9Q/EtcL5EBSwW5tG0Zu8xG6yUVGJUy?=
 =?us-ascii?Q?WRE0LchoSswB5GaBtgMqAtIey9FCXy/8QzR36wlIpRYbJSKYnMqL5AiC1hLH?=
 =?us-ascii?Q?5331VCWaUK1q9ADkUPGjARq9kx5wtUm5Lls8yR8q3Op0DKqXRqs6K/Ejo38o?=
 =?us-ascii?Q?UspVqhZMXueUriCET7dGG+yk4J7EXrU/mDa7kJB8h8lxAk4H23MMKXNEU2qk?=
 =?us-ascii?Q?8/40tv0fMqrfk4qWDloBuDL91R96eKrMT8x8vzsFmGXok9ocfDYmuM5/Q5h/?=
 =?us-ascii?Q?jVRfICDObeBikvDT/P0jNxYsfugmgcoJ7PT8uiK2iNaVKa2aYIkJKC8SYFAV?=
 =?us-ascii?Q?j6VB9FZu90uf3URC40uQZ+H99E2COhnVWs9cqb/+i06QXLuK+wEpwp9I/RYr?=
 =?us-ascii?Q?tkUJUNfd5YqFe2fb2L7p/HfiA4+ugxTHxo4SZ8ioPK4o3CksBA106sW3q8ih?=
 =?us-ascii?Q?FcFb03BAJ3cwTSIwEmnl/1gyQV+pXmcQTzS0D6kyUs7jX4CwACxhtago/NvR?=
 =?us-ascii?Q?mwv0PHTDkbMbyPYyqE9Z/vXOzBZCk1Ry+k7+zRtAHjMA7pFJF96CwnY2o6eK?=
 =?us-ascii?Q?XxZMVSe6Acl6IIUV/ge6haMmbEKwjEBAxlZfGhcdeEEzpYa8HCe8ps/mljUI?=
 =?us-ascii?Q?DGq3HhjpFGGKbA6XflBvlbFPAy8DBlUFJycQ7rqW8+dwwT24ZTczcWdLGPK4?=
 =?us-ascii?Q?2Dm4xFTIvBbHu2xRxE20Ij30NB9mTddcg0YmOVqXDSnxcyQ2C77vpOoOVA6k?=
 =?us-ascii?Q?WymOlWbfIIAcxAa2BdqkyYArFBcUsXsBJIP2JeHKugG+tspzDEgwJMU+ERmM?=
 =?us-ascii?Q?feqcfRPOTGnesR9bghHGGDpiyzkVSKKYmGjQijs4yD80Tz3Up5sTtaS6IDB2?=
 =?us-ascii?Q?wjV+W7ASbSxjb/ZtaGoe/e0rrKfCp+dmw9f04iHFgWfHH84aLORkVMvdUnqL?=
 =?us-ascii?Q?0PC1R0YuDDgJQ+DaqUDmhxmCZjUKCh1X6W+ckO73in9oRBodXR07UZYnpWCA?=
 =?us-ascii?Q?AGoyYKDKu+Uh173WtH7P9ExJG0ymLVqekgErtg0PQWyEplG7Zcc0vlne0OBu?=
 =?us-ascii?Q?N1qI2BrftKVs8h4uU8oeu0GaMpaGBwIeYvEQeyz8ufp861/rmyIMBu9BSlr1?=
 =?us-ascii?Q?pmBtSfj4xyLYCEjLhWIwdb2CJqIRRtI3tuvwev+BVeAN3pR64++gsRfHGGza?=
 =?us-ascii?Q?inxPXCbaPOAJci4t+Ng01LLdzEiYleHhOvbTnv0vZKqfnjVjSyfjW4zGLdH9?=
 =?us-ascii?Q?G5+jaRfHZf9N19G4qdTuVJA0p6NqAkxGy+oXWqwD2/3GPW5EBOGzxO4T8Sfa?=
 =?us-ascii?Q?tjurecC6VONd/xIxyky3gmgA31KOthXKyBhcGNlac/9WWtQ9WI4OgjnRAdLc?=
 =?us-ascii?Q?ejqFYy4WhV4yD+enQnUM8ezQajxxHGXzOzK/tHKNpne+nWqkO/9Lh4HmoP+s?=
 =?us-ascii?Q?OILin55Ki4i+80OarHX+uZ+da2x6tMoT8MVoAcnxym9iKlyzyF4pq42Y0mLK?=
 =?us-ascii?Q?n5DIdgI5hlghCIEeZUVmnlvFt1I585LjHb0ZjiGM2OYzHbzWHg663A+nbe9h?=
 =?us-ascii?Q?58oNJNlvVN0I+ZGSBqn36rRlcz5UQcBiTW/W5eXACAl9OLVZOqcIlBFRq36b?=
 =?us-ascii?Q?N3HlhzzQXrvUgoE9FGrx51+eKPSn18c=3D?=
X-Exchange-RoutingPolicyChecked:
	CuPiCiP7+VLwgUAEQXhv+EbkNOyDmi8Se4bZv7FdInKZjHEuVL3sR7kaXkCwdtubBLkMz5X8iStL/D9PXpN4LYd+uUFu4cTLjNIa+1a17oOn2zMey0J44gM6oIdFObWqDV/CqU4lbguEPw9NKve4onFg9GgrXTu7wg11lpaH596Pm8rsKg1RTCfqcehWBS7PP9r+G8CqmU/JtM3G9JxZXY0oZCLwbr4wwcqe42FX3htVM4ssIpiUz9ZI6VaevtmiahXHDLW+Iho3VEcMvoBKA3H48u8VkJHNy1iEf9tidmZMvOksPnX7FbvGDJTRE0kdJ4ShjUdglozDCaOWSJoOkg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lMAwT7RvCkgS+QiXLoEpz9Wjxur/xR+/AaimhRVgA+3klTIh3bbt17vTtmixHZyaOZ16/gt0rrEs2EaAPS3woynFwf8H1XPbO/JZrjUMQOV3baTzrv61qiIRVJj63ugan0NSBKo3lBQOvivboKJGBmnOlsm8LO9B0JTrkK6oRS0f9FAQPWL6p2Xpc0pQ/vAQVtB4pfTHVQH1cEEpg9CXFD24Pw6Cyc+Nu2b8xY6B9VO0lO149uZNWU7+ou4VdzdOFJSrIhpWSZG+RrebVtyImo6oZyU/ZZzocjc8Dewd5trzOi4ZO1+GPlocN87hmXZSr7VZ1i9YbuuFuSCdeGyzDhg1xAr6JZlLb5oLWrwAr1Q3yT/pxBaG9tBpfCmfYfOG7MX0cIPJbV+/DQVk6c2z1lMPt8G43t8olJ/wanwY7nE22ip5JxOueA6YSnv0TTrQpvJvNV/cBLl6+RQ8Iixzd2L4x2zPzjzKRDD6UGl56VKbkNSnTm6PGAOo9Zz1OEcpdrajqXI70WgGfjPjSJmkj+mffzcJpCePqlcP5BLx3znHRZ8jSMRH1zYwVaCYtAZq8JzatWfGzbu+HO+N+eUCPqvlZk6nJgqe7EQcx4BMFQ5cC+QcY7M9Uk5P0UEVkDLO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000d872c-42db-4df8-e758-08ded0ad6d00
X-MS-Exchange-CrossTenant-AuthSource: DS3PR04MB10053.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 22:27:21.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXHrUq8vGr4gnPlIfdBLdsuUUIhQvXeovEKh2P5Bk5S9rncb9Yc+hWWluXMqvqeJl/NWdcglWgaD0JlVlQuW+LKvE8pcARJX/cG6Q3KZim4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8424

On Jun 22, 2026 / 10:31, Omar Sandoval wrote:
> On Mon, Jun 22, 2026 at 08:38:48PM +0900, Shin'ichiro Kawasaki wrote:
> > On Jun 20, 2026 / 09:11, Bart Van Assche wrote:
> > > On 6/20/26 6:51 AM, Shin'ichiro Kawasaki wrote:
> > > > On Jun 20, 2026 / 05:55, Bart Van Assche wrote:
> > > > > On 6/20/26 3:26 AM, Shin'ichiro Kawasaki wrote:
> > > > > > This is a rather fundamental change, so I would like to ask opinions from
> > > > > > other blktests users, especially Omar and Chaitanya. What do you think about
> > > > > > the idea to add getconf to the requirement list?
> > > > > 
> > > > > CONFIG_PAGE_SHIFT was introduced in the Linux kernel in February 2024
> > > > > (commit ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB
> > > > > definitions")). Older kernels had CONFIG_PAGE_SIZE_4KB,
> > > > > CONFIG_PAGE_SIZE_16KB, etc. This means that it is possible to derive the
> > > > > kernel page size from the kernel configuration file for all upstream and
> > > > > distro kernels, isn't it?
> > > > 
> > > > I checked the commit is in the tag v6.9. My Debian bookworm system has kernel
> > > > v6.1, then the config file at /boot does not have CONFIG_PAGE_SHIFT as expected.
> > > > But it does not have CONFIG_PAGE_SIZE_* either... I'm still afraid that kernel
> > > > config file approach is not reliable.
> > > 
> > > Right, for older kernels CONFIG_PAGE_SIZE_*KB is only available for some
> > > but not for all supported architectures.
> > > 
> > > It is not clear to me where the desire to avoid the dependency on
> > > getconf comes from? As far as I know it is available on all Linux
> > > distro's. Since it is typically included in the C library package it
> > > should not introduce a new dependency.
> > 
> > I think less dependent is the better in general, and wanted to confirm that
> > it is fine for everybody. If there is no voice to object, I will create a
> > patch to add getconf to the requirement list.
> 
> I agree with Bart, getconf is ubiquitous enough that it's not worth
> trying to hack around its absence. In my opinion, parsing kernel config
> options should be a last resort. If anyone complains about the getconf
> dependency in the future, I think it'd be better to add a simple
> src/pagesize.c file that uses sysconf(_SC_PAGESIZE), but I don't expect
> that to be necessary.

Omar, thank you for the comment. It's good to have the plan B idea of
"src/pagesize.c". I will prepare the patch to add getconf to the
requirement list as the plan A.
