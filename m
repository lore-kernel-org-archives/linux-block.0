Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D301E528
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732340; cv=fail; b=tY+lQ+VIf0+xfUNO0yd9t2vq3VgC2YVCrhntmlDL87Mhov9g7MzIKXP9ayfWPpdsrklWV6JpvFYAn9B3GdzIsQ2etbRFjRjK0Tji3B7qS8/7fpLLhW8B97FIkbStIXQ8z7onwXD15i8luk4eZXLMrcdOuDrVPRL6Cqa4mH0qMh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732340; c=relaxed/simple;
	bh=+bdis6fpktlckkr/kWSu/jhEXSE6MyYRISkzs8ybw2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rO/y91Jr4CHpsi3Q7XQ13Q4B8OUYap3XaqWS3dX6uXsNLum8kL6dIG9mW8kR85M4r23/hDjJmzp9ZCJKaOWwllicRswvfudgJVT0iUYUnsMAANsp34I/vkmy/CgyMSE9bGtiOf2RXNvMMKi1KwPlfMpxRB6hyesnZo6TyVhGKtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NH8Y+EMu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ePCkzJNI; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NH8Y+EMu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ePCkzJNI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714732338; x=1746268338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+bdis6fpktlckkr/kWSu/jhEXSE6MyYRISkzs8ybw2w=;
  b=NH8Y+EMuVD94ip4iAII35MRxc/GWghB/Hay6Bvr0q2H/l/lsdkyqlOqC
   kdIe20qrv73GV9/BBlm1eIHUT8eA1ZN/9WIn7pSN33ZhuTMDW3jD1C0WC
   jWyRk32d0XwBhumw/2zlpEGcbAdQF+SPSZteOfUS2awsLzB6MlV+f8Cu3
   y2dr2GB3nrAtZOISwJ2o7HOkOV22rVpMSWkZpafGH3Y/OYQlkBElku6wv
   ttplnQkd+sBHohv7v+VIQJahZihoWM0KzaVVXhipzIjC4Y5hXmtkIkC4R
   fUt+2m38yZC+D+zDZ8ROYLSkMvKynxXlv/9mHHleEtu2nhN5cDpyPkymI
   w==;
X-CSE-ConnectionGUID: 1DOVWxxzSMmWe9heRsNesA==
X-CSE-MsgGUID: 2JOtvCnFTIWIq1XWhQ1DZw==
X-IronPort-AV: E=Sophos;i="6.07,251,1708358400"; 
   d="scan'208";a="15519178"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2024 18:32:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKGV69QLGr9gCu7soqsLzEYBg3OdYq/eSq1RgyuZ+8h/lfarz9BT8nvMV1lVGY8eSDo3nuA+KdWzNdlgpJ36GJ0M02w+TGy+CLYfTpgTMIA7z0RAU5p+65OWqpS2SpZgbAuBb4+zsA4KBPlC4U7jUSGtZ+sj4SycUP23DBFStrW+6SGXYauSi/JeNV6mqQd/DDy2+bLM+/EzaLvsCN1Y8MbxvvkU2cGy4IdanTjOGjqKpwvY+xKbsSjrKDdYPb390AUtjQ5I5vd2G1MipwJoowylQX+RAVDhEKbnLJBA1FhNVzveKXQJAWY7vnzv8VwHWX9Xx4YrqiPhcNDkg0bYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bdis6fpktlckkr/kWSu/jhEXSE6MyYRISkzs8ybw2w=;
 b=h8OW0MwJKgS6IeDn13j6/yvuYb1rSqIeBVk+YbTSbn7swHRvFDOntbFMb0z8Cgai+DCeIBdUo5hW7qZCIx3JAC1eTf2jIRA8CVezu48zK9FsCwLulOsbiCwgFJkaagZu197XmF8LBcMA9ndmwHGUUrFz4L0KP12N/is66JP+P+WQ+cw2cXfLtPkH0SJmO1aPjzQY5m61TFQk3Pep/htKkj6/nE7NjfNvXN2K3o7eWaN4UatMHr+oagtXxg1ArpNiZd84OYEIYhvCbw2/QU/TvvQQFcZqD+zmH/vqnbnh/huor+i48ig1MKjCcc78LbCELHxLPwD+NV0LrlR4SJmAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bdis6fpktlckkr/kWSu/jhEXSE6MyYRISkzs8ybw2w=;
 b=ePCkzJNILl17/zAgW877cIa41+WfOQ/Gi2xcsCrPjNmq2NZmyfkyfQY9lrqqUFDQSpekqoHm72qCBJx6Foio/tijiiiUHFk7Ul0gvqxlzyYq5SVhl0BjFoqpMs5snfZcGqZB7/e55lWJD/yJjQzCanH1ZyBU71hMaLlYn3D8Y2A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7457.namprd04.prod.outlook.com (2603:10b6:303:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 10:32:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 10:32:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>, Damien
 Le Moal <dlemoal@kernel.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block
	<linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
Thread-Topic: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
Thread-Index:
 AQHalYDAYvNpgmNs+0unDARlhknrY7F/Wf6AgACBYYCAAIWOgIAAhjoAgARNlgCAACqJAA==
Date: Fri, 3 May 2024 10:32:05 +0000
Message-ID: <76c17ab2-b3a2-491c-a6b3-7bd39d6d5229@wdc.com>
References:
 <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com>
 <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
 <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
 <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me>
In-Reply-To: <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7457:EE_
x-ms-office365-filtering-correlation-id: 1a4862ca-a6ae-49bb-e979-08dc6b5c4730
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmVGdEFpY29idzlySTQxa2JuWDhDdk43T1N5M3JqVlNxMXlUTXlEN09Za3hR?=
 =?utf-8?B?TFZqd2kwUTVZTnowY1dkNlJhYW1QakpjRlNNUlROUjhZd3JlVnQwN2R1RmVj?=
 =?utf-8?B?eDR0c0dZQVY0MmZIK0NiekVIWWZLQ0FwT1NyMDBQdzY4QmNRL0JsRkFDb3A3?=
 =?utf-8?B?TGl6WjRiOTIxdEdsdjZhL1ZjbE9wdG1uWG8xM3VydnV1alFoMmlJdEhBYUVB?=
 =?utf-8?B?TUtWd05HRnFnTEYrRVdwbzdocHdiWTAxd3Z4bXFvSnZPWEFhak9uZXNtOUt1?=
 =?utf-8?B?RzZPdTU4amJVbU5NOTJ4MGVxdlViOFRKQnBpS0M3YUxKUzJ2citHem1OYzN1?=
 =?utf-8?B?SEQ3UFdYalFqMFQ3amVPZW04ekV2VDR3ait3VTNPL1ppVzJzSTZicjIxOWtL?=
 =?utf-8?B?a2NSOHRLUzVCV0V4WVhnaW5SQU5CZlFvdmxzN2s4RStlcDVRd1VYWnFRU1Fu?=
 =?utf-8?B?QWtwNHJvbE5ibmhRbk9mYlpNWkViMTAyb0plWk1TeUh1SWVqNEc2YTN3QWxJ?=
 =?utf-8?B?akkyU2hzUHNTbWRkVnY5Rm9ZaDhUQlhzVVlZRUhXK1NYdmJza1lCaTBhckdB?=
 =?utf-8?B?Qk50Qlc4MDdMeDdmUUljVlJKT2FBN2krMTNIRExFZnhLcTI4SFdMVjFEZWdX?=
 =?utf-8?B?bFNvTGRrYjhIWUVnSDJtdjNEWVhzRFpOSUtJMk5heGxUL05Oa1BLcEc0Z2t4?=
 =?utf-8?B?R0hlUlQwTVQ1a01iZE9BQW82Mk1LM2EwWnh3K0JSSjlKNXBrL0FSVWVmWGVi?=
 =?utf-8?B?RlN4V20zWkZMYUgyUHEvSDNncitYVnYyakNXaFFBbnd2TWRJcFQxUnZMUitt?=
 =?utf-8?B?cW5tT2VtSmZlcCtUc2pNekFkemdkV1AxSmszNDZBTnZydExhSWxtTnR5TzEw?=
 =?utf-8?B?bDlaZitGMERIK1p5RXVSeU9RT2JXTnNuQXdEaitPVlVrSG5jZjM0RXcyQVI0?=
 =?utf-8?B?Y3h3VzZvK0lvUXVRNVNxSUZESGlWUnA1UzEwVnZFT0UyVTZiV283enNVVS9k?=
 =?utf-8?B?WGxoT0pmRWFmMHlWb2U2ZUQ1anF1Q0lZQXpobm9ncWJMZ0hKTWtpa05IRXBk?=
 =?utf-8?B?LytjVkI4d0syV0V3Tks1UHZieFgxeSt2YmR3Qmd2RDhjTGZCMmFzOGpjODRy?=
 =?utf-8?B?Q0tyTitpRjZ4MnhpQzBzZEJ3aXR4QjlMQlJPTE1tdGZZV3Z2cjR5SjdNaHFD?=
 =?utf-8?B?dVZHNG9hV1Q4OWg3emplK1hoR2VaSVZBTDkyMUFTSFM1MXM2d25aQXpTN29q?=
 =?utf-8?B?OUI3M2FRcE5GZ2liZXlxSXVBWDJZMXFXMDRreUNaeFVDNHNlbmVSdjEzT1Zn?=
 =?utf-8?B?VjlGeHRGOUd4emlLa0tkLzFERFBSMVEzZnNGbGN5U0xmWllmc3paYjJ2V25h?=
 =?utf-8?B?T3ZidEpZL3ZEb0Z6aVAyS2F5cXAyeFI3cFJzd0ZhZmp0VTY0V2ZNeTlOejN0?=
 =?utf-8?B?Vm9sa2tUM1g5S0VHaVZadldXNHpJdW9xZnRvTkZVUFh3bCs5TzlCZ3pDeHM5?=
 =?utf-8?B?V2V0MHBJTU9seU1XTUdNVjVLYm5nV2hoWWlUUE1RQ29NbmsvM0tKUUtVTmNY?=
 =?utf-8?B?akYxdFVBS2E4bmZML3gzV0F5MUhEUEFJTnBreTBCbDFDd0hEb1U5Y1Jkc0t6?=
 =?utf-8?B?UmZCeEI5alg5SmNqL3NSUzdNWlFCL01YZjlRUGpwTmtDTGNYVjg1UjI0eTVG?=
 =?utf-8?B?OEFmOWxFbnA2ck8rVGZjK1hIRlJZNXNQa1RpcTd4eFZScmtub0l2QWF6UnU4?=
 =?utf-8?B?amhZMnoxNGVvN0xuMndEdktiZll5aE9la0E1LzhTdG00VkV0bE9odUJiVE13?=
 =?utf-8?B?YVVxWDg4L3NUeUtJekx5dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFRSRnp5SUVWYmVIUTZDRVpxRXZ3ZFBPRTNiNW12d1hpYlh4bzdMUTRvR0xP?=
 =?utf-8?B?Zy83NzVQeGlJK3N6Mk44SmNoZzh4Mm5JWXVEcFlIMk1YTWd0d1h3RE1pZU13?=
 =?utf-8?B?WUpPVzZTQVEwK2hIWWwwMXRhKy9nMThhVFg2SllMSjVqSUVVYnJleGZCUXlx?=
 =?utf-8?B?eFZSc3M4cEVvTFZ0TGpqUDVRVUQ4NWpqeWdKV0w4S202VlVldFRsaWtuOVhJ?=
 =?utf-8?B?b2ExU0JoTkxkSU9BSmkzRGRGMlFJeTAvS2cxSVhRV3BObU9BMlQxRGRkMkpy?=
 =?utf-8?B?R2pJMFhBK3B5azYya3dtSSs1akk0NmtLTzRnTElrZkJmRkhOQjJONEdEcmo4?=
 =?utf-8?B?M1FIQmZyck9sWWNwdHBuVlJLNnNvV0dCT1JIT3QxaEd6Vjd3WE5DbXBJQXJt?=
 =?utf-8?B?RjhveVFQOHVHV3FCMjRPQW1vNjUwNW9jR1N4OXphVlNBaDZsbWU3ZGxSeUVP?=
 =?utf-8?B?OFV2dm9pQXUvL3hyRkMvS0t6THk3bmEvU1Y4aHBYRkdIdE5rVkl1RWdJaU14?=
 =?utf-8?B?eTZnYjZ3U0txVDdSRlpaaS9RUlVMeW9nejlodDVSTlN2QTBCTFArWkFnd09h?=
 =?utf-8?B?TU5nbi9qUXN4LzNSQ29qOTU3NmdGSStGejk1RkFPekpPbE5vVDlHeUM0bEdD?=
 =?utf-8?B?bEcwOURqZGVwbFpybitOWklLOFhzd0pLdGlhTU9QWnY3ZDZRdC9PQ294aTNm?=
 =?utf-8?B?UmFZeUVVNTNDY2pwdXZoUyszSXdndnJhaXZPblFkTnV6RG12L0hKYUpoaGZR?=
 =?utf-8?B?a0ZQOS81SG82RmxORG1PNFlXNWRQNDAzeVd0RGFDRUxTYy9DUFhVeUQvSDNI?=
 =?utf-8?B?KzdhL2h3R1NoSDMveWs5WTExNW1wV2ZleXA0ODM5WHBQTE5jTk42SWRmejVX?=
 =?utf-8?B?dzlvN2Z6UmZUUlp3Y3lyK0oreUVESktFT3NWeU0rZjRZQUFYa0tYQWlwblgx?=
 =?utf-8?B?bCtKRkJBeUpCb3pMTFdndHVKOGR0U3hKM1dXaHFoQThyZDU5WTdLMUlRSlBu?=
 =?utf-8?B?NldkakdwTWhTTkVVQUFCczNtZGJBNmdEMFhYOHNheVliYVVlTDY4UWxGRDk3?=
 =?utf-8?B?OWUwaURwNWZWNmpPa0Q5aTdKT3N4TTR0OVdIV1RhQ25NSXJ3OVhoOGV6eDZm?=
 =?utf-8?B?Qkl3em9ZMmVqSVBoNWJ2eEVKVDhQZ1U0bi9lRk4wRFhSZ1RjcU1rcmxrVjc5?=
 =?utf-8?B?amFHVDFGLzY0QlQyTHI3RUJEMnN3UTc3Njk4SVhaV1lVRmo5SjYyL0ViZERX?=
 =?utf-8?B?bUpSREhpMzBrdkI4N2lmWGlnOTUrZ3dRN2thaWVQZ201U1Z4Q08yUjUvaGZ3?=
 =?utf-8?B?aEtrRVJ0VnZBbmV4M2FwTWpyOEpqT2g3bkd2b0QvY29xazVCQUVPVm1CUEFS?=
 =?utf-8?B?NGVidlVxMllaV0llV3VMdjE5V2FHUFprNzlPQWp3QVBma3dWSnpROTZFZlBB?=
 =?utf-8?B?V0N0YXgwNlE4MkZycCt1MmlRS091NTBHemN6ZVoxM0lLMERiV2k4cnVnMlpH?=
 =?utf-8?B?RjluREtvT1MwS2Z1OCtDWURNQnNYa3V5N29aTGZvbnh3dGxydUMvNjBqVWpa?=
 =?utf-8?B?ZDRZQksreEVBRGs2SDlwbW9EUlVKOS9zSThiTWNURk1zOHlFRlFPY3V5eGpW?=
 =?utf-8?B?dkRoMjErZmZVcUs3NFBydGRzZzRVL2R2ZVpBRW1icjFhYS9US0RkSkVmSWM2?=
 =?utf-8?B?d1Z1S0taVWZJZVRRdnBndVNvTlZ5dGp4N1ZJMmlrM3ljZHlBWkZiR0pPRFR0?=
 =?utf-8?B?OWFDSEsrVlBRcHhRMjF3bjdHQ01vd0pIek9PdnpZK3E5MU50bWJCTnZ6SUhE?=
 =?utf-8?B?MDMvSGZKRElYL2RnSG4zQ1dqcUtrQ0trTUZRaHZiWGRpaHpieEFrV1k4TFdq?=
 =?utf-8?B?aENIYmoyeXdJZmZsUjAybE1XejF4bjIvaGxydDk2Y0J6V3JHMTlQNXdmRGhC?=
 =?utf-8?B?Y0Y0dVk1QlFCSWNzYjJSdk1pVjRoT3lrNFhEOTJYQzg3UThFcmhHMG43YnFz?=
 =?utf-8?B?aWcyZWJ2bTJDb295OVJPMk5kTDlpbVZuTGQ4eTUyd1A0Wkx1YTNWZklqa0RS?=
 =?utf-8?B?cUt2WkhZdHFqZjA4eDNVTWZqZjZWRDV1Tlp4QStlNEk2WExnS1lLNXJLRzAz?=
 =?utf-8?B?UTZzMHlGR1puYWxYbnJUVTVyelFscktiOXpiK0t6ZmdEQS9vTkZpcDZQbDBC?=
 =?utf-8?B?U2RPYmVPWWM5ZXJjaFNLR0NEdXIwakg3N3JtclpDYzFtSytEWjNrQ21wL0RL?=
 =?utf-8?B?RXZNVnB3eDRURW4yR29yNGlOanlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EE504FC07023C438FB5E1B79CDB4B16@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zg7c8XuORZm8X7zJD5mIjF2jW4KJEX4Af6BtI8A5T+9WsP6A+79MIqrxvjucqGjubBMXWSOwcvYltDk65ROlnRR1nYqT9Mm+YmgErPM/2nfUziBGv40pcI0ul6wvp117SJdh0YFWljMKgY0MbRDiItBDIqA8BA9qSC47F9F7n8gb7b80/PCxH2r6gB6KcR+eD2sYiBjByE1bYLGDKjCCCp52Ogx2G2NBUWorm1eb4nO4vU9ccCVdVJYG+ioZwWojlFHTRM+VE9JCkreeON/rlQb40l19KVonCLykAw1CwsV0yBDrNYxOat+OxA8XEEc3t3I4etjeOi97PKTLm89lcYcBOYJ3QqZIdTbZOSWyPqa5yl9tPadQ0E/vxhk/54Emhshrxi+1dfRjt/Ns0UeFY20yGekeEBQkBI0EWrTNu1iLTWEJwW1863bB0W34V7RNMnUIGZ4+Ak7Y42N3r6pLoDDEW4SFXXrmKWWl+sSAQdg5A+tVvOBK5OHhROcdtW6bmqje980rWITwYkFDmIh2koBMyeXshKPMrRxPefRIUB5FQuwPdM38LjO0qCSPA+Gzi2B63OS5Z+g25GQbDTgVoQjxC0dStfBtu4xJsAIkk2eqEJUjr0COf3/XzbPyOI/0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4862ca-a6ae-49bb-e979-08dc6b5c4730
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 10:32:05.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRUVZ8eEi7RmCg0pKzOIGS5FuptXChITxFhv+KYRKXqRzpGlwAnlb4MNFXAGzRZKqLS0voZQFlUU2UTfHY+X+VEs8QPQw/XmrfpUa1e6k7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7457

T24gMDMuMDUuMjQgMDk6NTksIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IA0KPiANCj4gT24gNC8z
MC8yNCAxNzoxNywgWWkgWmhhbmcgd3JvdGU6DQo+PiBPbiBUdWUsIEFwciAzMCwgMjAyNCBhdCAy
OjE34oCvUE0gSm9oYW5uZXMgVGh1bXNoaXJuDQo+PiA8Sm9oYW5uZXMuVGh1bXNoaXJuQHdkYy5j
b20+IHdyb3RlOg0KPj4+IE9uIDMwLjA0LjI0IDAwOjE4LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+Pj4+IE9uIDQvMjkvMjQgMDc6MzUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+
Pj4+IE9uIDIzLjA0LjI0IDE1OjE4LCBZaSBaaGFuZyB3cm90ZToNCj4+Pj4+PiBIaQ0KPj4+Pj4+
IEkgZm91bmQgdGhpcyBpc3N1ZSBvbiB0aGUgbGF0ZXN0IGxpbnV4LWJsb2NrL2Zvci1uZXh0IGJ5
IGJsa3Rlc3RzDQo+Pj4+Pj4gbnZtZS90Y3AgbnZtZS8wMTIsIHBsZWFzZSBoZWxwIGNoZWNrIGl0
IGFuZCBsZXQgbWUga25vdyBpZiB5b3UgbmVlZA0KPj4+Pj4+IGFueSBpbmZvL3Rlc3RpbmcgZm9y
IGl0LCB0aGFua3MuDQo+Pj4+Pj4NCj4+Pj4+PiBbIDE4NzMuMzk0MzIzXSBydW4gYmxrdGVzdHMg
bnZtZS8wMTIgYXQgMjAyNC0wNC0yMyAwNDoxMzo0Nw0KPj4+Pj4+IFsgMTg3My43NjE5MDBdIGxv
b3AwOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDIwOTcxNTINCj4+Pj4+PiBb
IDE4NzMuODQ2OTI2XSBudm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMt
c3Vic3lzdGVtLTENCj4+Pj4+PiBbIDE4NzMuOTg3ODA2XSBudm1ldF90Y3A6IGVuYWJsaW5nIHBv
cnQgMCAoMTI3LjAuMC4xOjQ0MjApDQo+Pj4+Pj4gWyAxODc0LjIwODg4M10gbnZtZXQ6IGNyZWF0
aW5nIG52bSBjb250cm9sbGVyIDEgZm9yIHN1YnN5c3RlbQ0KPj4+Pj4+IGJsa3Rlc3RzLXN1YnN5
c3RlbS0xIGZvciBOUU4NCj4+Pj4+PiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzczp1dWlkOjBm
MDFmYjQyLTlmN2YtNDg1Ni1iMGIzLTUxZTYwYjhkZTM0OS4NCj4+Pj4+PiBbIDE4NzQuMjQzNDIz
XSBudm1lIG52bWUwOiBjcmVhdGluZyA0OCBJL08gcXVldWVzLg0KPj4+Pj4+IFsgMTg3NC4zNjIz
ODNdIG52bWUgbnZtZTA6IG1hcHBlZCA0OC8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzLg0K
Pj4+Pj4+IFsgMTg3NC41MTc2NzddIG52bWUgbnZtZTA6IG5ldyBjdHJsOiBOUU4gImJsa3Rlc3Rz
LXN1YnN5c3RlbS0xIiwgYWRkcg0KPj4+Pj4+IDEyNy4wLjAuMTo0NDIwLCBob3N0bnFuOg0KPj4+
Pj4+IG5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6MGYwMWZiNDItOWY3Zi00ODU2LWIw
YjMtNTFlNjBiOGRlMzQ5DQo+Pj4+IFsuLi5dDQo+Pj4+DQo+Pj4+Pj4gWyAgMzI2LjgyNzI2MF0g
cnVuIGJsa3Rlc3RzIG52bWUvMDEyIGF0IDIwMjQtMDQtMjkgMTY6Mjg6MzENCj4+Pj4+PiBbICAz
MjcuNDc1OTU3XSBsb29wMDogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAyMDk3
MTUyDQo+Pj4+Pj4gWyAgMzI3LjUzODk4N10gbnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vic3lz
dGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS0xDQo+Pj4+Pj4NCj4+Pj4+PiBbICAzMjcuNjAzNDA1XSBu
dm1ldF90Y3A6IGVuYWJsaW5nIHBvcnQgMCAoMTI3LjAuMC4xOjQ0MjApDQo+Pj4+Pj4NCj4+Pj4+
Pg0KPj4+Pj4+IFsgIDMyNy44NzIzNDNdIG52bWV0OiBjcmVhdGluZyBudm0gY29udHJvbGxlciAx
IGZvciBzdWJzeXN0ZW0NCj4+Pj4+PiBibGt0ZXN0cy1zdWJzeXN0ZW0tMSBmb3IgTlFODQo+Pj4+
Pj4gbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDowZjAxZmI0Mi05ZjdmLTQ4NTYtYjBi
My01MWU2MGI4ZGUzNDkuDQo+Pj4+Pj4NCj4+Pj4+PiBbICAzMjcuODc3MTIwXSBudm1lIG52bWUw
OiBQbGVhc2UgZW5hYmxlIENPTkZJR19OVk1FX01VTFRJUEFUSCBmb3IgZnVsbA0KPj4+Pj4+IHN1
cHBvcnQgb2YgbXVsdGktcG9ydCBkZXZpY2VzLg0KPj4+PiBzZWVtcyBsaWtlIHlvdSBkb24ndCBo
YXZlIG11bHRpcGF0aCBlbmFibGVkIHRoYXQgaXMgb25lIGRpZmZlcmVuY2UNCj4+Pj4gSSBjYW4g
c2VlIGluIGFib3ZlIGxvZyBwb3N0ZWQgYnkgWWksIGFuZCB5b3VyIGxvZy4NCj4+Pg0KPj4+IFl1
cCwgYnV0IGV2ZW4gd2l0aCBtdWx0aXBhdGggZW5hYmxlZCBJIGNhbid0IGdldCB0aGUgYnVnIHRv
IHRyaWdnZXIgOigNCj4+IEl0J3Mgbm90IG9uZSAxMDAlIHJlcHJvZHVjZWQgaXNzdWUsIEkgdHJp
ZWQgb24gbXkgYW5vdGhlciBzZXJ2ZXIgYW5kDQo+PiBpdCBjYW5ub3QgYmUgcmVwcm9kdWNlZC4N
Cj4gDQo+IExvb2tpbmcgYXQgdGhlIHRyYWNlLCBJIHRoaW5rIEkgY2FuIHNlZSB0aGUgaXNzdWUg
aGVyZS4gSW4gdGhlIHRlc3QNCj4gY2FzZSwgbnZtZS1tcGF0aCBmYWlscw0KPiB0aGUgcmVxdWVz
dCB1cG9uIHN1Ym1pc3Npb24gYXMgdGhlIHF1ZXVlIGlzIG5vdCBsaXZlLCBhbmQgYmVjYXVzZSBp
dCBpcw0KPiBhIG1wYXRoIHJlcXVlc3QsIGl0DQo+IGlzIGZhaWxlZCBvdmVyIHVzaW5nIG52bWVf
ZmFpbG92ZXJfcmVxdWVzdCwgd2hpY2ggc3RlYWxzIHRoZSBiaW9zIGZyb20NCj4gdGhlIHJlcXVl
c3QgdG8gaXRzIHByaXZhdGUNCj4gcmVxdWV1ZSBsaXN0Lg0KPiANCj4gVGhlIGJpc2VjdGVkIHBh
dGNoLCBpbnRyb2R1Y2VzIHJlcS0+YmlvIGRlcmVmZXJlbmNlIHRvIGEgZmx1c2ggcmVxdWVzdA0K
PiB0aGF0IGhhcyBubyBiaW9zIChzdG9sZW4NCj4gYnkgdGhlIGZhaWxvdmVyIHNlcXVlbmNlKS4g
VGhlIHJlcHJvZHVjdGlvbiBzZWVtcyB0byBiZSByZWxhdGVkIHRvIGluDQo+IHdoZXJlIGluIHRo
ZSBmbHVzaCBzZXF1ZW5jZQ0KPiB0aGUgcmVxdWVzdCBjb21wbGV0aW9uIGlzIGNhbGxlZC4NCj4g
DQo+IEkgYW0gdW5zdXJlIGlmIHNpbXBseSBtYWtpbmcgdGhlIGRlcmVmZXJlbmNlIGlzIHRoZSBj
b3JyZWN0IGZpeCBvcg0KPiBub3QuLi4gRGFtaWVuPw0KPiAtLQ0KPiBkaWZmIC0tZ2l0IGEvYmxv
Y2svYmxrLWZsdXNoLmMgYi9ibG9jay9ibGstZmx1c2guYw0KPiBpbmRleCAyZjU4YWUwMTg0NjQu
LmMxN2NmOGVkODExMyAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLWZsdXNoLmMNCj4gKysrIGIv
YmxvY2svYmxrLWZsdXNoLmMNCj4gQEAgLTEzMCw3ICsxMzAsOCBAQCBzdGF0aWMgdm9pZCBibGtf
Zmx1c2hfcmVzdG9yZV9yZXF1ZXN0KHN0cnVjdCByZXF1ZXN0DQo+ICpycSkNCj4gICDCoMKgwqDC
oMKgwqDCoMKgICogb3JpZ2luYWwgQHJxLT5iaW8uwqAgUmVzdG9yZSBpdC4NCj4gICDCoMKgwqDC
oMKgwqDCoMKgICovDQo+ICAgwqDCoMKgwqDCoMKgwqAgcnEtPmJpbyA9IHJxLT5iaW90YWlsOw0K
PiAtwqDCoMKgwqDCoMKgIHJxLT5fX3NlY3RvciA9IHJxLT5iaW8tPmJpX2l0ZXIuYmlfc2VjdG9y
Ow0KPiArwqDCoMKgwqDCoMKgIGlmIChycS0+YmlvKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBycS0+X19zZWN0b3IgPSBycS0+YmlvLT5iaV9pdGVyLmJpX3NlY3RvcjsNCj4gDQo+
ICAgwqDCoMKgwqDCoMKgwqAgLyogbWFrZSBAcnEgYSBub3JtYWwgcmVxdWVzdCAqLw0KPiAgIMKg
wqDCoMKgwqDCoMKgIHJxLT5ycV9mbGFncyAmPSB+UlFGX0ZMVVNIX1NFUTsNCj4gLS0NCj4gDQoN
Cg0KVGhpcyBpcyBzb21ldGhpbmcgRGFtaWVuIGFkZGVkIHRvIGhpcyBwYXRjaCBzZXJpZXMuIEkg
anVzdCB3b25kZXIsIHdoeSBJIA0KY291bGRuJ3QgcmVwcm9kdWNlIHRoZSBmYWlsdXJlLCBldmVu
IHdpdGggbnZtZS1tcGF0aCBlbmFibGVkLiBJIHRyaWVkIA0KYm90aCBudm1lLXRjcCBhcyB3ZWxs
IGFzIG52bWUtbG9vcCB3aXRob3V0IGFueSBwcm9ibGVtcy4NCg==
