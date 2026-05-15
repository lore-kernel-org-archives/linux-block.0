Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CF377EAB
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827126; cv=fail; b=fQpJ4khH7m3GMXNgqGfAMrDMKDns9sQyif5oNZYGXgrQDdAAzj+wkWMc+J9qGDzzxWOnmYxm7kkOIGX2VFmRnzpwFzG0L/MfPZ0GdzVE4M8OVO3d4MflkAtOCzncYFlbFoE2oCvNzVJ+qWaEaX18VwCSZbR1L15NH9vn91ao35Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827126; c=relaxed/simple;
	bh=FSXtZkE0Tbg0I5J5bXCPCFpLtJuSRAJ+jZP6AY9qPEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k8zw012H86i+0vCr6z3wig//PtlevCckDQ5qLQicnj8NW8G40AA2ZGPxaz3H1zyr8A23bZYD5r19o+FRhwiWE2WREJehU/TaItyyeLLwEB6hme0U1r1JoB1STtCWV1jSJrFld2Taz9M0xqajD3blqgIhbyoU6VaN+sRshkfQxkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZLOwyRY4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=emXA0Adr; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZLOwyRY4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="emXA0Adr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778827125; x=1810363125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FSXtZkE0Tbg0I5J5bXCPCFpLtJuSRAJ+jZP6AY9qPEo=;
  b=ZLOwyRY4BkBb23aCmMHOwIWvhoeyJkfet0HQS14HCvuOb8OY6qaqOgvy
   vFzqLwgAI0TU/I/JkdLQhC1EDjOGyfn8E11l/2iHiFGmm5lU08s3SHykq
   bJbxLlA3UpsEjIqPmqPCpxIS/CUr/1YrO95xCL2R3lZkNjMCSrGc75avZ
   p64q3YJPX1kCp67gq3BCKrbMSqzLK5lp95i4/TrDoLD/EHUbGJAx6VtPs
   skiVo4KK110prStI8WCqk/3vPTVjVSyS/S/gKYNgC3f8+N87yiI1EzeX1
   8RgChjhTG3NL9mdZ2s9AeAp8Q4+5kf+3JvsecPpFeH/nRQeMK7V/CvQIt
   Q==;
X-CSE-ConnectionGUID: jciRkVGpQdieYZSQXPDajg==
X-CSE-MsgGUID: y2tYciv1RYiEPvXa3QC++A==
X-IronPort-AV: E=Sophos;i="6.23,236,1770566400"; 
   d="scan'208";a="147798041"
Received: from mail-northcentralusazon11013015.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.15])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2026 14:38:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGYtWdq7dqta3T2q8/dx/lQGwSnlykHQodXZUMyyoUNYfjl9M9aZOGgAj9g9fPhZkWLlGdImN25C+skm48InLcbSTijLxlahzs2kjmCHWlU4hL0S/QIkOOvlSIQl8ZaE3MVQlp3NFp1VQms/x8oJrM0O+SJKkOtlmIMvrdovBwFxlcH+oTPa+QqgJ6ptq/JF60iaeP4XSrjOzqoftBUvKlpQI4fUsJF03/cfuxnTuwxQ3IRrd0CLSSUENE7DUv7L9QuSMFQq22ssuPMUiv1ms68flNxP3Qjo0+sdruJ87n9ATs06Vk3eMi+XykvZw8Ya5TcLDtcaIMeQ8zjIbD3HAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPM2ZySF9kF6iENeRWacKtba0anmL0jDBxg5B2egl6M=;
 b=ArGFY6X2uAoEV1ZmpWGQba4Mfrcq5BTrniVtbmJrtcIp0QLeBUCuGSHsO3w5+UyzwV5F42b/xuT/coVyYHyy8dcKIbdusVOHMYGlcKhLn71KceBF2hl2ZFbrwjlix0bzpj2avymQXvj4GzucldhM+wqTSCrgKupbt36Z7hHc+nFGry8EWDx2oqjVk7D6v0krZX65hh2TcSVqtREvmAgM8Q7LN5krH33fGanZvvso6u/6aUgLxJSWm6aZmpWd/zavIIcI7SI9c6Oab/kDbJcKvLvB4HU2bRDXBJgr/vsUEqCNNepsVFrTeQNCVwrrcUX0vYj9sGkVc3o8/YMSPivJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPM2ZySF9kF6iENeRWacKtba0anmL0jDBxg5B2egl6M=;
 b=emXA0AdrAYc6xZH4isdNu9URzQ96SSPUjH6UT0+LrVUNCqxfprQzYc4Num/F8hI1pCTfoeuVKmHKdWoYXwuPPYeiu1OxSmCLJ94K0JTPiwVYVfR5fS55GZ81bwRrtBUao8a3zhV0h+1vpI1WqeKlmWTOHgHFVEq4PeXHJ5flAxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24) by SA2PR04MB7532.namprd04.prod.outlook.com
 (2603:10b6:806:144::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 06:38:37 +0000
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f]) by PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 06:38:37 +0000
Date: Fri, 15 May 2026 15:38:31 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	nilay@linux.ibm.com, dwagner@suse.de, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v3] nvme/068: add a test for multipath delayed
 removal
Message-ID: <aga_QNyfB-L4lCh3@shinmob>
References: <20260430084635.2438048-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430084635.2438048-1-john.g.garry@oracle.com>
X-ClientProxiedBy: TY4PR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:405:372::9) To PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR04MB10005:EE_|SA2PR04MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d367a8e-37db-4de6-b299-08deb24c97f3
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Hq9djzCT/QVSrCki/WbH7gPoKUT5XdESzdoYkai0jHcFbcwGfH0TkJ5oEmsRjaXMxP8dRzX+Qb9QpmGTPDmN2mAdC0ays54RFrWf4+ME5BL97SJM0j7bgbPLCNbI3nod5Y7Mr1IWtVJ2FJNJm1D/RUPQWgHymyzo4VGuowga72BjvQkVk972NES6XuWfYP7WGpLC646NchFsU4gvXpcKa6r7qmSJWwsmjDp9blu8tEERmuf16tWOw/Ie7bvog542mWJDQH5xz1zOnS4TBZ1obWzSB4sHk2nr77XP1PtzFQMLaxzWyYEujAEWBqRlIHA8p9h7PhhLhUiuQ8Syflyp00Zqa2K9hlrHEDafn/7FsK+RLFEEQGee7v4rCEi4qDs20bcvG3nVAIFWeF2pYq/mLL77IrD+RQy7sjM48J7/69Yzm5SNRjb3IvCWBU328bZZXeNCLSfbLEDypdbbFJsuQDRhh1sPF++tP5QMLrQvL9I809VI5rGAnz/+VztmgYgIrP5cg73cuoUtImtx7HzktuGXUwISgPSfQ5aostir447ABxAa3y6n26l+hlTK6u8Lh5yLRI42nDqcYbhNhfcKlic+SH6ET6xO1iuRDzjuRqKuBeTW3XtxrFbQLmVOQaJMLBgreWVSw0zUKzdjDwkzsaCFOzuQLXMbuaHAPliFqS8TPv1XmXosNg009GPND3Jh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR04MB10005.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcHiEof0UiihBq1POdXm2wNqNwbYLuiSmpuRfFZl/g3zvDjFmWv1wGfPLSlL?=
 =?us-ascii?Q?nx8U2iB9r8GNTo1B9KvS5itQ0AiwEeWebEHtUEu3T+1XuOcdr4mRZRkkUs1P?=
 =?us-ascii?Q?w4MCmSX8A3c5jNxUdIvZZsC9zXWpwCuNbaUyG3IBeTlLFeE9Bx37lWfMgI0Y?=
 =?us-ascii?Q?jw4iCRLERJ7R2QpbtU+gZ/pKd+xYelJQWrsEiWU4HRM14S4N/84j/dnddsq4?=
 =?us-ascii?Q?MKVW/mebRF/0xOmE46gRwUncUwEsbnokB35Y+OWzBIOipa8nOpaaD/e2jBY8?=
 =?us-ascii?Q?Gr/TAT9W1tuQzR/MJSHECdQTva38jY3RamNqV5m0Uv1AkdGYBwHgKMntSTeb?=
 =?us-ascii?Q?/u68uHVFBB5FSJUF1QoKS5n8yVb+aiJ5w2dzJrvT/i/GxewNVA1yTQsFu/cC?=
 =?us-ascii?Q?nKrQsNWQxXS58IdKkbCyvir+uC/OWruluCAMUxYY7ZnJ58hI4PYiR85PJIhG?=
 =?us-ascii?Q?kTBR4/b7XI+QvUB6JouR1xERm24mVfuaNO6wQ9qQoMUkMN6P2xvlwRV0D/Ri?=
 =?us-ascii?Q?o4n6mqeymPDG0U946irKWL3fZ7ru1DTC7u8Wwzcq8dXdpu4i76aQ2CMNYK2m?=
 =?us-ascii?Q?g/SDXDKePpa5I3/nXIJ2QAPBs5PAZ4Nks8se7p7nVhvZzi79Ekfd1mqtULE3?=
 =?us-ascii?Q?NL5S+nJdnWi+w+NQe3bXSL23kZpqBXvZ/jNJY9a6G4FE+oIuXuW2EBRPgh/I?=
 =?us-ascii?Q?b2gQu/+PvmkjGLZH1kAY8Num1MUg8YvI1SCO8d3G6Yy8L/wr+Nru+Dl5eSX6?=
 =?us-ascii?Q?hEPifAq/OmNUu3v1xWiTex40xJBCNFttFKoCRI0MxwEu+roZWFbAzE6pYV0N?=
 =?us-ascii?Q?BUAIuhAclUB0/C5CnpbbgHYZ/JU5pv1SAKc3bZ/cm7F0i9DRKsXZrMc7E3pY?=
 =?us-ascii?Q?ZMfYCz7ofO8rIIYlHcyc9Zm9oZ3G+lCjfmJl+HMZ1xJeWZVx/jpaSv6uRYfa?=
 =?us-ascii?Q?LybDmZqt9xSnS7DO0V1SLjf35qFy0uUXnRNsqJ8tjs7TOOLfvIUDwWs/X3oi?=
 =?us-ascii?Q?JA+qmkX71lnEsbTJdE3guSmjB/Vxwu4srH17UbTV7AtN+VeEfE5rlg9swJeN?=
 =?us-ascii?Q?MWItH0fLpqlvnr96C1mQhtgYBkHi/u3pLIlU67xGE42z3VHtglVMwPu3QOB0?=
 =?us-ascii?Q?giIGtxwuGOx2DBlAZjKuohpq/qkCND/RNktbxBofx4IhTtsvdmUn5ythUO3d?=
 =?us-ascii?Q?djLuaSW73zP5koBnpacaVlJAWlGCTwVQsTgodFO8nH2a9BcpvPt34v5Tyusi?=
 =?us-ascii?Q?PZNSH9ezrLrs8nqhjJaiu30jKiGYLvwk+RR7sH4GZJiyguxa9sIgtCIzyJCa?=
 =?us-ascii?Q?CDcxDu4olpaklox3qHHE9b5/wMNbQJAdJhGCtbwbWNOpSrI4+Vl0Q1kOzNfj?=
 =?us-ascii?Q?nUkUeUXJ+BWYB4TvrVtOUlmCI7TY+Oob+UNOuOvuK7waj+OfTmz1k4jt05o0?=
 =?us-ascii?Q?5JzanwwMpViulfijgpEMKtH75YGmC921JOakk4WSl6xXt1bRJgTSKKUVFByl?=
 =?us-ascii?Q?uAeSPbw6I5sGh4OBLTttp9bjtI27nSwtT0eC03TMnrs9/NaGA3pIuoGDqODG?=
 =?us-ascii?Q?ygyhqmR9pqK43QZrq2gr7Dy/3MUuAELLK+kShvjg8EvTw5cvlsQ8B/x2c/6y?=
 =?us-ascii?Q?i4Vq6POq0nF6BX8t+rZnOcA8RNi9guQEaV7PuSxnU7MmZquVY5cWdqV5rDrK?=
 =?us-ascii?Q?gZMbcCKecd07bGZWcGup5R5R0liTxhp3+DZUTM1U+/6Cx9ZbALdQKryHxj5d?=
 =?us-ascii?Q?5DrkgNTVhYaEgH3uQ0Zdbyflg9+5X1Y=3D?=
X-Exchange-RoutingPolicyChecked:
	JtY5lAzuqkpftvx4nia9jVwql5Ag1X6RglRd3VBYgZzqvMeVhD/odlHCGrgmdhvED7g5LFEiAENLyudunYooLuPjXb4+nGVT78Kvm+qwTdt+HPkgBPIjF7jcdedTLjO4fo1uw99rXh9pP+EsN5hF8hwelQ3ZMguMF948vTm4L3uANtiLM+W4b1fjbhDHtE9lVaYPrC+iCiqxZcFR5+JQSG2ZgK4Ics98mcuzC2OkGDwg/ci5davr2dme83dqXogUo8sweUhd5n+zn2yRRzE/2TYcZhlzJ/FBMvqk+vV0DqeVSWJP8xCPa3Z7ImqEAILYTK7klHGLLgzlagx2Gncyig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vwgFZyLwt6efBOm233S7guqS2wedL3zZ1hZyZQRdoKbG0eBhKcAc1tAxzsb/dBetdsdPQdu9FC5LXYKucv+Oc6MfFdWYHu95J/p3vGOxpOGi69yZFpUML2C1j2kgPhpQ2XEnQNwtXX+sFZi6all25gUO0S3o0KfMPLm/0rfvQd1nZYVSGiOPKurJunS4xrbmmYjbUdYUTbivfIa8pToVoWloM+Irqno4Eh+Wb1EQDCYxoYrfU+guPZzKGpysrzixNdKlL63On6YGp5fD+85msmHSeEkicZkQNgG1fVZht9YGHCybJvuATofkd0QJ/HaNGWmm4ICR+xX/JPpnrOSvf20DTmAVaKYxvElVmSY5iMTCfGAbHVRlqh4VB+pPGxQ1R6E2RYCsKcoTXi8jqd3E1NdT4fxoHlcFPFKPPyGn4SBIXJlWIs3Zl6a1UvbrWI/N3hU+HTlehEYJVLAUhRFzyXd4LCtPT42P7OHhI+fSMPekxYX1QPlWoCMEu3GcrKfQ9tCBHxk+EjqK4CjO7lF3MjAjHcWgZYAkAAk2O6wGud5C4NwPcTvWyuPe6C+6Ggy5NUUC+1G+TlJonjaBK6pbi9trdSAwC1dfRL6XYxc4G+807GR72PM4pJ25bcih9WI4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d367a8e-37db-4de6-b299-08deb24c97f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR04MB10005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:38:37.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1z5yXCQi5vQHcXlx9gOXp90yhZLufCmHSydy/bGeNkJwol/2tB16DDTLpeiqpe/AR/BVHqsmyvDSMUpz+eVOylb687T1bocaipbCP9kDQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7532

On Apr 30, 2026 / 08:46, John Garry wrote:
> For NVMe multipath, the delayed removal feature allows the multipath
> gendisk to remain present when all available paths are gone. The purpose of
> this feature is to ensure that we keep the gendisk for intermittent path
> failures.
> 
> The delayed removal works on a timer - when all paths are gone, a timer is
> kicked off; once the timer expires and no paths have returned, the gendisk
> is removed.
> 
> When all paths are gone and the gendisk is still present, all reads and
> writes to the disk are queued. If a path returns before the timer
> expiration, the timer canceled and the queued IO is submitted;
> otherwise they fail when the timer expires.
> 
> This testcase covers two scenarios in separate parts:
> a. test that IOs submitted after all paths are removed (and do not return)
>    fail
> b. test that IOs submitted between all paths removed and a path
>    returning succeed
> 
> During the period of the timer being active, it must be ensured that the
> nvme-core module is not removed. Otherwise the driver may not be present
> to handle the timeout expiry. The kernel ensures this by taking a
> reference to the module. Ideally, we would try to remove the module during
> this test to prove that this is not possible (and the kernel behaves as
> expected), but that module will probably not be removable anyway due to
> many references. To test this feature, check that the refcount of the
> nvme-core module is incremented when the delayed timer is active.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

I applied this patch. Thanks!
