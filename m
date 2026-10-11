Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608B2D322E
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791735146; cv=fail; b=G/tV8ihwieKXcJJIdPEuSSbBILcH91rE02456zjbpO2z+ZpbkdmxxMLEh+ijVM4vwLra2GUXiJG/H+K0HoiTh0eh2b1YDSqsOzd636sP+crqA8m2zO8F/82qReYFKDngM2oVFYhfbtjqKTvpY5aOB5oaYKWJpyadsdYY8tDp47U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791735146; c=relaxed/simple;
	bh=l5mBdzG6Me+//o1/7PoG2bQ6+PSunb1MVGcu6cRGuSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOz33WZFFbg0qcTVOtmm5ZzLPaJO6Y3nltBToCZzmS+1l5ljc3nnR/fWBxxtqmlo4QaR10aOlAk0Igfc41VJIBe0oCvUY6SMrvu9ADZJYtfmq1otFUUmLHYo04obcnoLUTojqSqCsDJcJ4FxI+KK4SD9DHYgIzNAdjRZJPXYV0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SxwrWDRM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sfjlcTyF; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SxwrWDRM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sfjlcTyF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791735145; x=1823271145;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l5mBdzG6Me+//o1/7PoG2bQ6+PSunb1MVGcu6cRGuSI=;
  b=SxwrWDRMi8QWyzR73KrnXjpke710zdlfdkKOGYB+/aZnWka/T+Tyclfi
   o+u8KUScNsMN5UIXWRAil6URe+bIa9RptlGDq5t/UJu7MLThAO2HVgnQu
   8mF56YxWTL2OExSLeVrndo4GRp5/GAcKsBnMY0QN+e2umCsf+lVHX19Fp
   A42jOKXUYHK/NARzZpjF5F8yTor3Ki2+b+cL952JqUSkdFAaMP19/CJgU
   rE43zS9Ur/pkLAV53V8eXLQmIyPuH2bIHxaNv5EdGDI9D48lhq080VTAn
   vJcZPpaPviWP5T/tbHHoJ0CqZ5B+vOLaY+Us14QaNRCoDF5II720YXIuB
   w==;
X-CSE-ConnectionGUID: H+PsHp8rTsmmBI0VA36jOg==
X-CSE-MsgGUID: KqRrVpTyRMy8CX5iXt9rJA==
X-IronPort-AV: E=Sophos;i="6.27,151,1786982400"; 
   d="scan'208";a="153613434"
Received: from mail-southcentralusazon11011066.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2026 00:12:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfcvcZJ6Yb1AHXvj8/HxTg8BIR6rZOQ4AyJNyvU+b6M1DWfCuK5cpWU5qQFrsDKvZNgvYLmuVBnxUh6SNis0LCDWehSBdUNHNPYEnyFrqK6crP7w5hSYB0FXaqOsw+vrJSjtw1CwOM5BYBudYBN0x9XX5frXLUuel2UUjdubYybkjzR+AhwEbHp70vfSZAAu1CLLvjfDqz+N98g/mdXeHsM4PiIN/ZnpPZ3MkoN44xxWID62BWL1X9/QXgiFxzF7QRfi1y3sIEO2Ch+VOLt62Uc4CwV3/fjsUUuP2DFnS9YzEU9canL5NBODwMF46q6iW3ewILpLanYBdSM8pqDFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72EgjevZ5InErfHcw1ALOBbx3sWfFG9MvPo1JID+1Bo=;
 b=CGFR08KmLHYstjtFc3BPyhcFBPGVyo8MszGrUN3xyqFhC7sEA8Rf0z4yTBgNqsgY20y1ir3v/W+OTRpBbSWVnIXfQAFEBMSGgLXi8ChGc9+dRBGQhDSzNGhh72OO3QV/5KYq2brvWjSm58atEnOhx8lVeyAY2DgzTTyRArVucLEr+dTnDAEGSR37hjRlr7Ri1ifUv71QCJhnUmYjnjzbYQQbeQqpw4v2hkJLHUWR21PH6HaxZcm404CkLg9sq4syLycD2N+tEXWEnzSZE4+beqU6lwPsV+UFtDzN2XhlcoaFPDNqqk/zMzETWf4lO++5KwZbwt4xWf4pdRcyHZUnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72EgjevZ5InErfHcw1ALOBbx3sWfFG9MvPo1JID+1Bo=;
 b=sfjlcTyF3QcAlJhV8AOf17ZeACPBRm1PzUnJPWTAOLt7b6TOhxTcS6DKHOKWm/+shcl6tHY1aw+zdvOAzga1DRfaMrqIR0zYaKFl5kG8zU22nRARsCybwvzWrQ2ElTR84rC8nEYn+VTwDLBlvOuTZnTDljsQljATno1Pl4IAawA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV2PR04MB994494.namprd04.prod.outlook.com
 (2603:10b6:408:41a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 16:12:16 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 16:12:16 +0000
Date: Sun, 11 Oct 2026 18:12:09 +0200
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
Subject: Re: [PATCH v2] blk-cgroup: skip rstat flush for cgroups without blkgs
Message-ID: <asu03AokPh9MO2p_@shinmob>
References: <20260921132058.2091567-1-usama.arif@linux.dev>
 <1e4fffa0bafa64446846b2a520cf8a96808da89c50cdf22606fbfc91048cb036@mailrelay.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4fffa0bafa64446846b2a520cf8a96808da89c50cdf22606fbfc91048cb036@mailrelay.wdc.com>
X-ClientProxiedBy: TY4P301CA0050.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::9) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV2PR04MB994494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb35cf5-ca9d-44fc-86e1-08df27b26ad5
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|56012099006|11063799006|5023799004|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MymCsU45Tr3B0xGHPKTT/+tIW4D4xgWQt7aA4qZR8FF2grPntnMVy0IqX9VkP4fy9yn61ACf8p0lnlqIu+vGBoTOZ6JGo+czleY0YxoJtAV84qs9oHNXQh9bBKldVuGba3oBoA7q7PV2vsHkdhK1ADEPj9XJZ2frG3MgstnDbUMDMCIdBWyv0tfKENAxkyq4UBpCxzztgg9ZKcil2eZLb/FvAbYizf0JlNOy7/GLNgu9Pm41Mkm0ceYlleG6KMk4MuNsba5Vl+o/Jc2NyyuY43dY9irqCWuGq8SM1wHDpk9ntDBbp8a0WLuckkmO7kodFrYQ3VnUcd0+0r1qbuemEOCBICUu0tVYOk7uK5RRRwFb+bfVvXx5MGWEKRD7p3EYzEFjakIXM3/itB9ExPB5Q84Lyh2oiCToLPvQ3ChcXn2drEcdddn/c1fOgjE0fMRwN/YO4RwIjYKrZqrjxBCTLCqswlTWPfO8keIAgYnyZsy1CjoYZG1EpbI/UQkafSbHROw6K49u3c4dLQlbC1zTRSWehgLln6r5FnetpU7qfBKT/lcvL1WS8596Xr9lq0vLdHAnFfz4DQYyZf/A1vkfzbgFnxrHL8yTwxuIGkHFS9TAqf1f2M9rlcSXp+LTlTZvOQ+jdpgxkYPie+wlp2F0jYc2pLC4QJkY58O4Nt56x3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fdkXTPTbWUR+N1YYcykUv1V02ZmsMaskJs4m+OkHqoxmb0UEZ/jFnx1YBLf?=
 =?us-ascii?Q?wD5Hb4TrNx8FB/kJZKL1S/YuzQj86FDulTi0tv+jRhyi7Rc093sJxF97fb6U?=
 =?us-ascii?Q?q9sHqEay3R7DzBGMyP6r/ZxpYk5G2/vHVskUWJbNc7MPbQ3aw040sH+Ike7J?=
 =?us-ascii?Q?cvhOHWXZXZ1199BRaoS7TxaZG/piDab/W9LGthp4WZZXwQgqH+a8FG0ztoZq?=
 =?us-ascii?Q?zZtbXOjl7ESdgM9r7g2EFVNDKWA/BJAB6QWrJIqmEw5vW/9xIHsLdasTx/n8?=
 =?us-ascii?Q?fMmrAXCJ8dQ2bFoG5dvhLEoPA0SEZrXvuttbInuVDQYyRYyrd+IkRJ++Z5Qr?=
 =?us-ascii?Q?YycyV46XLn6+hNF6D7i8cWJ9aiJwmwkyo4YDMtgoRA118zuS0MnFM+ShWvA0?=
 =?us-ascii?Q?r8Rh+EKcDgz/xAxmpaLv9zvem/Ch1M0ex4o1UsUjHSNs5/gaeE6vMIOOA2Gn?=
 =?us-ascii?Q?Vaxk+RB1VEBAaG8qQbf9Z9Y4ykiBPy2ZEoiMCxrwKu85jOdqSuWbCWkGo/zs?=
 =?us-ascii?Q?kFg0HPo0CqHkKY3a6v12/nst7wvJ1jR/LHCBoG/RbQzx54ASWvJprWfTPpga?=
 =?us-ascii?Q?+WJXOOLDJUNBRnEylJquMjc0lTEiDrTOFZKcJgcT2jRBgfBpQ+L0TI7f+iX+?=
 =?us-ascii?Q?rS9FYfxHMpgyr9+L39YtpMiPM+vKyrVeEQk7uBpd7RMURu5Xxy6wyssw+0+Z?=
 =?us-ascii?Q?GAk4wLaIxX45sHzResVw2upAsEcyOoywx8TQXc371eQMR/7NZajpXsriqZf3?=
 =?us-ascii?Q?eLMF+f4I3M8eOmNLz7mW2kA77TiXsF/WMYhoQ3XcYUFrMkgIkVyIoQSh3Xh8?=
 =?us-ascii?Q?RYF9JLqNfYHYJvMJ2PljZqVEAIkfSZMzIQigUiXdQPQqdmTTMKVm5d/yfDby?=
 =?us-ascii?Q?veboBD9QJD0mUZEmW1krE7a8P0hXSztUbaCFl6rrMopl2qfY7htGskyQdGOO?=
 =?us-ascii?Q?YfTvTNwDqHvHgfJfX1T6WkyVIHz36DEDo+heaiPEvqaFyvSluy+QEdN8UrHM?=
 =?us-ascii?Q?D7/q3yKo3Wj1mGQZ6nzjF0l/8fX8rKoCZwt/3cQkAiLI/zIlicmInD6edA6g?=
 =?us-ascii?Q?RjJCdofOci/m+ylo8BhmxVqlUlI9dRMGC2zig8CNab6p5KB7DajqlQY/CuaE?=
 =?us-ascii?Q?ivYTsAqSDuWVSjzWBiVDRKCJzlwQATNxACRQwNAPQUYuabWqWio/i6QayhTH?=
 =?us-ascii?Q?ZsSn53KwWE/WBgttp/sMvZrN0Do8rTj3/2NTzqybNgk/xPI4qYGpIyRzwZUq?=
 =?us-ascii?Q?k/KbulPmu/9qTNzJ7CTHCItKkFRhXyUP6VYArOPEuXOtGwJmwZeCl1PAm6SB?=
 =?us-ascii?Q?CSTh+o+BT+cO9vWTAy1uVU8am0x4ayNKjloV5sCAzrBVxP9SZfnVrX6qZo1N?=
 =?us-ascii?Q?AptYo4oOvHjOnRt+Vdm0H+Cm6b69MKRX2osbxxgNwj8DT6AaAJRA8PHkaoX1?=
 =?us-ascii?Q?KJSRtbMUCbMbeqYeTBU7FWc+Iz63CYKOXSodtD1iFiTX9Hu/zeEUpfD61Uqw?=
 =?us-ascii?Q?qok15wuvxBW2meK5ByrDUnVkz7VFfVhsQ6daj9QUl738uvVWSwrMvgS1pHQl?=
 =?us-ascii?Q?jzkD3ThSYpnbnTLDFp/OA2ZbpqOnhrW8nlLPnp8aR6ceYel1tYvIQFQOlYem?=
 =?us-ascii?Q?igNbWEnnCEOFGWW78HoutrlX4QXoTfnqgBgZ9oEVW2xyM+E42LKm2kInLS3K?=
 =?us-ascii?Q?X2ElrpTkdzIcnszcOQFiQoHVFn8ppvrL3pCE4WS5pDg20mZtypmSEdDnhxGv?=
 =?us-ascii?Q?CFDjBdp1sym6gow+wKnJc2xLGYfgcpE=3D?=
X-Exchange-RoutingPolicyChecked:
	KEvihT2MmiKedCNvWt2cEf2V2H3BX+R2HLG2hkWbbcWEKgNqwceFuSci3MjPvhRhUy6wmfGXoYc+L8tYv8xCbektW9ALo6jbrUD0Exw+/KZGb59wUe0ZqRmq2ubDMLsUr/rBjFxUpRepcuVJB0pjQBxpJxQMyGbgZ+AdfguuTPs5ywsdJwqPrQy4MADliZO849PMFXcL6BDnznC6Tf8URu+5XkUflNrGEy7B8iREUHE1BB6/9E5bYLI2OgSbKAIqMIsJRHrJFbhgrWu0CDI7JjEx5f2NF7r7O++HN/+JygdbbH/WSFX6wn+v+b9hXJYhV/soxT3LOpPs2q2uvpfIZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cp49LP1Z1pDjF8fKJ7bHwG8rcHj31pQCB/7Vt2QJ+qjUpQ/G7UA1IV9lPRtoxWxwC+j8GeUFZBoGaFscFofa4XVXjpeqS22VnVxx8/giU2T3zWHKzMx4sRYiHwjdle2+MMnlMfWIa7tJHHboHBPGiOFTUrrOGg4M+aVSMV01Xzmy602ZsQ9FoJ23/BMYE3304WZ07NK7GO0sxHnU7F9qFIA4M5xR95WwWm3tny1EI508BBYoYqQkRkxsZM7Aoognh3qifjX9AeF02dv/ppIdKQXikeu9MUlF3ItaMIBdl8NFYj3oq9KgtOSaj3/0FvQvJbiMWHEUxzxqqnIggGqWrjntxJjIxDVfUVZ0xlrOdasigUSqCX059MvuGzA2Oyl4+1dx+q2brMaHBv3SLPCQcGbrHtf2ZjbkOpW0qI7ij508ZuvlIsrNbkRHjJ4LqFTYuR/XkZftire+ezqMviogjZHvo1K/1DXtp0ePSOiEMi4HahUcAu+19GjBSNoYK/0mczKW4HQ3fDjzjlvAMa40vi5wlnlPh3ySLti7dYdjomE8HipJ9gUVkcTk9RMXZPQWebGTNPQC4ILlVhoKuGwom6Mk/tTTrmazKh93VMWqhqol9tvnexSHlKiYrF8PgwD+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb35cf5-ca9d-44fc-86e1-08df27b26ad5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 16:12:16.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5mtIlgrAhpOc88SQL8Zm9+6UFu+VbAWFq4hmeouA1GD2ptGnp3hw9PgdXq+87zAaIn6c75SY/WcV4dfHYt2CjXxxuN0fiIncP4Y/NM8NtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB994494

On Oct 08, 2026 / 19:32, shinichiro.kawasaki@wdc.com wrote:
> Dear patch submitter,
> 
> Blktests CI has tested the following submission:
> Status:     FAILURE
> Name:       [v2] blk-cgroup: skip rstat flush for cgroups without blkgs
> Patchwork:  https://patchwork.kernel.org/series/1170402/&state=*
> Run record: https://github.com/linux-blktests/linux-block/actions/runs/37647078673
> 
> 
> Failed test cases: block/034

Please ignore this failure report. The blktests test case block/034 failed in
the automated CI test run for the patch titled. However, the test case has
nothing to do with blk-cgroup. Sorry for the noise.

