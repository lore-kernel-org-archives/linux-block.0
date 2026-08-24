Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D74282F12
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568922; cv=fail; b=fgY2YxJAjQuyjjS/H/VD0zoEh2tXn/t/znvjQGLVNxm5uo18xBol2WXbEjyxsoiQP///9m3kFdYsmdrLokRqkcLW3dgDGsuLWuLhVL/DtRzfgTcFttQfYqp/Ci4Y0STaZfSVRW5gy2au3V7H6XYmL+wFF5YSwyvf8J2rLyUqFh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568922; c=relaxed/simple;
	bh=PeK2ldf1gtpK09Jp0x8iOmjGBynV6x/KxQMFjFG0gWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVct0ZTwDOL7NmcRpmcOa68W6USA85TezYoMPUnBvJTjw8WQnMDg9j201qMzd9PUrsfWGs+yibqWDCA9K25KTUZ0+2Sijcnqb17iv0pSvgoFxNDCM/9ZOT2P7FVb7/aW+c8y8Y1sVgRzUWM6tE1BiWaOsCmdQ/BTYFuH63AXg+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AvNZWPkv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=x9McJS9A; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AvNZWPkv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="x9McJS9A"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787568920; x=1819104920;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PeK2ldf1gtpK09Jp0x8iOmjGBynV6x/KxQMFjFG0gWs=;
  b=AvNZWPkvKaVCK4I5N8FBZiCq30JdQx1gEA08wwWy7svqEUHv5ePP5wit
   rPXAJElj9DT2MeeS3OYd9njVu1HleKQovaR3B5wHHtDr1W/rExZgU6mb6
   OfBXv3hIhnK2Epzx2DGLfHrxq0Onoe864c8BLFIurh3706won8kou+I0m
   wz0Pj84IqSeVlAc+PXIoldQJ2RWv+tCuunzYn5SjQR8h8FA+R9VSST9AO
   H0QvqeyOhmiESnSy964rsJHBcSLsXAa4PSW7MlnDnWeNSJDjDB9I8ZqJg
   u9oF3LK2jDks1VjlY8lrJbqYyElzQkrOJH3hOn1M85uphInHGHVwEb6hq
   g==;
X-CSE-ConnectionGUID: lSUVzQsbSNOOjh78GOS9SA==
X-CSE-MsgGUID: UOoR5wjdSkmRryV6n7JuxQ==
X-IronPort-AV: E=Sophos;i="6.25,240,1779120000"; 
   d="scan'208";a="153188706"
Received: from mail-westus3azon11010008.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.8])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2026 18:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gV13uJ7XG4PKtwaJJjNtCbt+Dcbls3MR0r7xWdPYEAgUmZb5t1uOTecxLNQQ2MuVkSw/JaZaY5AWZiZB8SG2S73sSuZqc3448lcOqBoKxWylc+lUwu23nxDdElxzT95D1oLA2YMCCucU1Y2Ku+NCAJCQqUy6NpQMcrgGzGnDjqt4K6eFAScc5VQhu5EJhfzs7jYGvowMxIyTwFKla1KGjsg7boBCa4k3D1DaG6qEuZYyv8Kz6vv1AoNMPgzrhksINVAZza1lJXX8s1zukOE/9VpRPs1WvLI61QpQenGXzRKgetX8hxvXv21TMIQRDr9DKjVssNZG0vKoammGGwTJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd4mO9dUjbqdF0GrO/FMwDUUJdNNSgiChAN7t5xEm5I=;
 b=cEf55jS1khsPsn95qTgpFK2ppHKfqhstZ5Mzxzqo7z6D8mC7jIP1j2guB0cVp6kBxl6iRcJeUr3kI5bkT1Aep6EDCMStZZtnPE1MdysHiPma917wPEzlvXCkAh+S96zg9bh5Nmlhhf2jaaDrxR2wC8U9mu8u+hV3fOmr5L5JaF3sQKAibwsR8eQ7ttTf293RzJh+iNfNznQuJHlHCaa/pk4n08zXfCNjcCl3MA9oCTbgIbPefAXGJ8hI0goYMeKZR0xOVnoIx7GAbIxEy7zRVZikjYkTe4dG9sPI18AXV9qfFOnodVMAWDG80g5TtzlTrmFJKqxuek20Y+sdcQLwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd4mO9dUjbqdF0GrO/FMwDUUJdNNSgiChAN7t5xEm5I=;
 b=x9McJS9AL4cR8Mal8yUDmE7o15+kDMsl5NcpGzFKCZRnm4spvztR3k0qwm6Ereb3k3lI1arH2EcM5mL6fkvPKqmE9kbAHSUr4sSCspiH+1BfL/40oJdsEFfWPQ/hqetGXgcFTxLYwimdwgb5+NDU6D0g2A9ZuLTHOOfmzQ3p+jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH8PR04MB8658.namprd04.prod.outlook.com
 (2603:10b6:510:239::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:55:11 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:55:11 +0000
Date: Mon, 24 Aug 2026 19:55:06 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] loop/014: Add test for backing file on loop
 device partition
Message-ID: <aowhot0Y6jXYjeMY@shinhome>
References: <20260820200034.3849080-1-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820200034.3849080-1-bvanassche@acm.org>
X-ClientProxiedBy: TY4P301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH8PR04MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 688c41f5-d234-474a-7821-08df01ce2b87
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	EpbXSt7OuCntaVvdlhZRdOIvoWsU0j35mJ4w0C0Ywi0/sXpnCMpwa/30EwH5R0InCdVnq9dwKFRmMacLvjH+hYxit+k7WgwkSWt28l3z/xPROpXBQY11do1+K8zQgwX+1VuYFVJMhpPF3ZDGrxud1KIPIG9wYmvNik2VooVw37eiOLYgNMyPdYbpbUlKspy23m7pD6Ap7G3PXpmYo7mv6kQKzsOeYW2DPvrFnfa5Ny9eAXYaSFLUu1jGykI4lqAvXvQsyVjaGyJZoQa45Jj6XWDHGdszxLxtNK9tGjH7/vSeBhqLRPXzFqQT3aR1nFOnHY3JabVgfYxOsCm/WPn2vdK8RCifnYZru7IGIiw5vHo5S5WsEwv1n/Aw7+hOrWq/iZuoWh3p8EOb+1WsDp9ffzJlJ+H51DLDu3sMBq/83yAuu2eIsXNtyoGZUurSnnOoM2mtloiaD8UWXeTuX2WHX8ECsw4GIyKn+2xVJMVlb/BJYr8DaNIpcy/RUfXz39HZyV+LojFVHTGJMVpRMx0+kkFQBq4HLkBGDEeLi7/pDCdCnQZKowfXABvnDkzD+/oIomGlPtvdmlDjut3GRTW8gO+TnZ98XNbETvCvBhMK3N3c+fDCgadEpZPE3dfpksA+DGyRQD8LaEMEu9sbQhb902hEB5yjkdf9s0ufx5+v/Uw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nSe5MDAuWIijaway4EEugQydZ8TvzujshVPciKMWhNSdeTAVIPAXH+Gr2/iG?=
 =?us-ascii?Q?xfVWudXNHOyDGnjBRC5TxV452iwYYAM9t6sgsJFqQgwraRJXxhXgLcbhjn82?=
 =?us-ascii?Q?Jw7qjYG7YuuaU2uqbaCm8HDtn7rCiACTwux58aorw11kLHQ8XL10pKqklROK?=
 =?us-ascii?Q?my2wp0b5x0/jCnv2VmTeOq4bXW3p4Z2olIPbDzuQ+Av+Kl4mrp6BZ1quwJSh?=
 =?us-ascii?Q?P5nZNVeZTQM6P4h/z7P36+j0+QGICnlitkqPSyTENDl9OMXSEXC3dH1OK67q?=
 =?us-ascii?Q?cHGibDBxA5g8fpD2K62MhoYzhumpnHacedizXYeX9vIlBz83LsyolniPrGoh?=
 =?us-ascii?Q?IfhkIksKNMBw8/oHCUVjjjMYOd9yvB0GM1Vlp745mlZ3MzwUMAOcShtJ4YSR?=
 =?us-ascii?Q?QV8yZdfVA67wyO//6Q9rrA271it3UY/+HTQ0/vDp/ETtqxCybq/vrww66gOF?=
 =?us-ascii?Q?DgrmUebeGZHEUD2A+72VJaeINmX1qNgHjs5R8/YmoU/4hOFh4N9QPhVsGjqF?=
 =?us-ascii?Q?Z0wfIugkX2n6+3sOz8Kd4DCfzpNKC0vTonUrNR8h9QhrWwGSTzn9dQfU6EOP?=
 =?us-ascii?Q?UYFQHCga+aQ9ueNpVKHOm6Ihu1OPLgpm/k+HnLdsJoBSbMwbGOr9K005PVbG?=
 =?us-ascii?Q?tISPA0y57RLHA+10qG35X/seZYN4u3VEzb3nhSQ4IU+WoabbF25ovGxi5HPn?=
 =?us-ascii?Q?ri+4tPff3tV+r+RlRwTdLNhhxgpeUp52jSuHSVpJZZvZ1sBQpBMo681If949?=
 =?us-ascii?Q?jq7xyrYkISkFRQwJwGi1F1iiQy+O9GHkgJLyK7kACjaXBUYeYsK4Z0Zl7Gdf?=
 =?us-ascii?Q?ewh3Usn9rRHTEOsIi9Q5BqWlpZVqa9lAptzKb9KsDQj7FQ5pfEMX5sY0HMX3?=
 =?us-ascii?Q?jMClsNIKvsCjM8E5Bk+7GMDGEBYsd93CpxLJndExfLhPKQsujvpi4oVfPJJe?=
 =?us-ascii?Q?Smx9RUzYMjqNHIw/YGOdEkq9ijsCrHu//UboxVW9/H3r/L5CtwK8ANOhHfCq?=
 =?us-ascii?Q?vjqIXZr6l2md5mnS3gw1hnpudEIOnIGZrtI1iYFAaMC7R3troPRYT2EGI9tM?=
 =?us-ascii?Q?dcK8cyZOdzuX9dV9yIKQsJ7NX5lOeRIiULAGtAj6q6inA4kmdLVoCToze2aX?=
 =?us-ascii?Q?v5JupbT91rgCD0aENiDBtgxTsyp2xOFKBf7zgQvMY+O1BFfY6d/WpoAt1k2A?=
 =?us-ascii?Q?AZUZzcBdA3hwhx+cEviz7yj5VrY1jAl5akuKF8a+WxsaM+dgwv32X4HusRCR?=
 =?us-ascii?Q?NSA5srAmdD2OFq0EPNp0tpyMZiOpWtNWYnImjSY1iq9Ck6DsLZ6WPYplknHS?=
 =?us-ascii?Q?QHe07/U/MrfmCDfgQ8GMCvhzm4qPJpXojLD5ua01TETQ6k1NHSLs8G+Mj783?=
 =?us-ascii?Q?DUmPBmnh3jmvyCT3fBtgwpmpNjOWvYLrU5BByEvs2+ovvSDiMm4kaHJ14KWB?=
 =?us-ascii?Q?KP3QYNZp/HHzhv6q5TlgtSw7lkpslqF5z3CkJJ4A7CFfJEUnU4LkO4TOgZUi?=
 =?us-ascii?Q?2axfa2sSAKP4rYtERedAMIjBDchCWUa97HNGzQBb1gG1TTKTrrM7yAms+QgX?=
 =?us-ascii?Q?KQLW/Tz0WaAFaUdU77WVB7B6YgfSECiF8rW2qxGtJURbtvN3Ga8k/LmZDP6x?=
 =?us-ascii?Q?/K2xsmmPgHI4u1f+vtinDrfaOVX9nbLUNYgtvd9j4rnGRmMPx5lUqTj4CPEW?=
 =?us-ascii?Q?nrHP2qLrYkBe8943YtopJXupx94IlH1Zn/icnSGkbLdIiUCjteRd+1lu3CTv?=
 =?us-ascii?Q?xRWn1tEGUrNOGxj1etvpNa0PTE71NEc=3D?=
X-Exchange-RoutingPolicyChecked:
	htwl7daicy+CY7R3GfIbDnz3XOBTNWiQqNzFuLWJwvxkEd8rI4XqY08kSjI3B+9w0p4mqJ0WT4mxvU/mJ0JeFt+J/n2t3aOuxSiKlIyZgLrJWLDAe4Hh7X9UFSnYPYMAeTbnF1GuuBzumwchms/wIvermOadsWygrItDEuGE8SFK2VhdhVd/j/CXxqwJyM9c/V3F6082GEuQz7jUlketWK6CWElwmXeA9xNnCyROqZ4XjKfWz+C+CqTQ16fBU7OMWn7dhNmp+j44zVioKZRTiP7n+bQizNiktd4tbPNzmRnc3DKF8awi1vLk3ZgEMnx1z5iEoNOFOlVAV31r1TFD+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ebgqh/ijquOXaM3GE3PXTIjc26x6xdCw3/KKbo/x59h26EFC/63e9KgjybKk3nFNN/mNk9PTe7fm7GgPqyGeIAvPCgTO72BR5dALHbK7soUrmK6Mm9iEyxaWu6WEkiVMKQ2qW8EAoa17oKiFjUBUvaEvTvjYUQhQIp/Ix196T3UqetJNbmQ2Dw7WNpdAvTGah9bbkuhyRUD07DgQhXZYpmguYAfz85Z9NvPuWw+pHfVT03eA02ROIeQDS1vJAeW0pDg4VbxlQjk98sIKAFpxFuG8qtpFA68pFwKtmdIm9pFPHatxD8ncsj1k8KGe8OV5nl5srokvE43oO3fwZ6YBMjbkcWgxoFtJgXAogj1tvIxlxzxznRX3M7ckS4oM9pcGyo63r5DJQlM36Y17OAGABQt1hqJS92NZR9PN1FfrqCRtcR35k5St8WgC3vGRsQI4btttEw9jF4j7X1u2MQoQphVRlFsxI2KpzYdsPSz0OFamuiNMz+dBerMDo1/pGVxghWyofF/hBESAy4rWKMYzwb+NdS7d8Iq7Q/jgkk/15yTZFigBERAdDiTqPTM8OhMJGXb3uS1EMgSTGrXQrCZx0QhZh6fpNhg/fXw+DdQa56kIlfYQ8fvBdZ+Ndt8Q0J+Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c41f5-d234-474a-7821-08df01ce2b87
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:55:11.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCjjK3vaM+JL2UZ0J9ZClZL1xj6iF3O4c+KtSylMHlqoo3l/8NGFoSkCz6m/bo4ABIdZj2J9Y8N6fw2MVDMTWhMNxJC0QgAhpCkgdXbJ5Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8658

On Aug 20, 2026 / 13:00, Bart Van Assche wrote:
> Add a new loop driver test that verifies that attempting to set the
> backing file of a loop device to a file located on a filesystem on one of
> the same loop device's partitions fails as expected by triggering the
> kernel function loop_validate_file().
> 
> Modify src/loop_change_fd.c to accept a -r option to open the loop device
> and backing file in read-only mode (O_RDONLY).
> 
> The test performs the following steps:
> - Create a 1 GB image file ($TMPDIR/img).
> - Instantiate a loop device for the image file with partition scanning
>   enabled.
> - Create two partitions of equal size on that loop device.
> - Format the second partition with the ext4 filesystem and mount it.
> - Create a 1 GB file on the mounted filesystem.
> - Unmount the filesystem, detach the loop device, and re-instantiate it in
>   read-only mode.
> - Mount the partition read-only.
> - Use src/loop_change_fd -r to attempt to change the backing file
>   descriptor of the loop device to the file on its own partition via
>   LOOP_CHANGE_FD, and verify that loop_validate_file() rejects it.
> - Clean up by unmounting the filesystem and detaching the loop device.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks for the patch. Overall, it looks good to me. I ran the test using the
kernel at the current Linus master branch tip, and confirmed the test case
recreates the failrue, and the kernel side fix patch avoids the failure [1].
Good.

[1] https://lore.kernel.org/linux-block/0c8a65b8870b2ef09119093b485e37896b80e2a4.1787255652.git.bvanassche@acm.org/

Please find two nit comments in line below. They are not a big deal. If you
want, I can fold-in the changes when I apply this patch after the kernel side
fix get upstreamed.

> diff --git a/tests/loop/014 b/tests/loop/014
> new file mode 100755
> index 000000000000..5814b8148a26
> --- /dev/null
> +++ b/tests/loop/014
> @@ -0,0 +1,107 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Google LLC
> +#
> +# Verify that attempting to change a loop device's backing file (via
> +# LOOP_CHANGE_FD) to a file on a filesystem residing on one of its own
> +# partitions triggers the kernel function loop_validate_file() and fails.

I think the kernel side fix commit should be mentioned here.

> +
> +. tests/loop/rc
> +
> +DESCRIPTION="trigger loop_validate_file() when changing backing file to own partition"
> +QUICK=1
> +
> +loop_device=
> +mount_dir=
> +
> +requires() {
> +	_have_program mkfs.ext4
> +	_have_program parted
> +	_have_src_program loop_change_fd
> +}
> +
> +cleanup() {
> +	if [[ -n "$mount_dir" ]]; then
> +		umount "$mount_dir" &>/dev/null
> +	fi
> +	if [[ -n "$loop_device" ]]; then
> +		losetup --detach "$loop_device" &>/dev/null
> +	fi
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +	_register_test_cleanup cleanup
> +
> +	mount_dir="$TMPDIR/mnt"
> +
> +	truncate -s 1G "$TMPDIR/img"

Nit: I suggest the long option "--size=1G" instead of the short option "-s 1G".
     Same for mkdir -p option and mount -t option.
