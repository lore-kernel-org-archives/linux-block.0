Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F5471D03
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347336; cv=fail; b=rej4pId74BeWLJya8vvc8zI74mLPQ/lzvTkt+aVZU3GnSzw7m4MM2b7mGgeWB1JvAeukenHD9v91/gDFuF/HKSjncVSvkiJP20UN/hBWgjIVhw2VgFNCkbdXqfvvineY0IDbpuZgx+JtgOXLz7kkdB73npufCnFEI59ipEE5OQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347336; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZKZYdiRmB5a7QlgVXQv/3PwFItW78kf6P8Xd1qZo8Nl3EfmPgfU3r5zYyb/YgEGtrbbS4b2GptNJKtF6pZNUJ49cGp5A4Nzecn3VbZwu9otzTYSNP4w3D5/NboUtMXMHsSWX+jiAnVbKDkZj8Hujh/3LZyOQPGL7mkHrL6nFDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DYlM//IB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FqlH0DLa; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DYlM//IB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FqlH0DLa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788347333; x=1819883333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=DYlM//IBktjAV241GZc/af6pgwfwgC20e108UZ6IpdbLi+Q1S+VKOMQX
   +t9VQl7+zcOb7ZQkRa5XICdnh96bxVNMTIncR1tbTg9kSU1lpuejpMyy4
   X8l+Ue5T5/FPMHsxEsxDpK9irymgEPaNoDhcMCb/VI2XyPyiKWc2y6pLx
   Q04sB5+k8D1fxEs+bznCtaCxEOq/oa65Z3TFCM3P/e+nXYhgz0MPgyqYH
   b6Wd7AUYt25/O+HQk0YX4BWaqwRRVinMUng5LbvKOoBTCHcuPhLa/LHJ9
   UybstHDZp1Wny6kRZNsT7ELTfJXsVvxN6E3YhQo+ruP7RHGn5d6I8+BVT
   w==;
X-CSE-ConnectionGUID: S2Z8fUcFRO6awy3jNaOV/w==
X-CSE-MsgGUID: PtNi9pHpQyGec7XSOMqGyQ==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; 
   d="scan'208";a="154564305"
Received: from mail-westus2azon11012047.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2026 19:07:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSLSp3RT/P3tdlDTZv6GXcOxowjs8LArkbN1pzjCmBOrMknCxd9T/nzmdpvdhvMyHOpMP9ChyZE/sByuwFs7nbLb67ytox4QC4TI2g0s4svPRfKY8Cq50xF3V/0TeY1YqOLbmqDGQm+BCniZf8q9gitxYPBTcbRPITZeXo81jvzIJuTNeGz/P3GWsPaIJi4lzyBvgRM0ibGxS4GjJNMmMzBOS8KrnSWj/b95rzUpGIbGJiE/LZmTb7udcGlwgBtl1MwRJe/Rtqeg4TvcH+HfII1RK3sSRZcLY+V/BbEGKwzCfI4CAbd86fpKHsTGbFXxt7UqESShoABN50QbOlc8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=Kkfh8eoRQwEN1B0lG+ijKh6I4+feL/UxRxMfVaXeak69TMGydILnDtxeUervCGi/Qb5QWa5NR8yhw/Fz3hbDwZvSshjoezCPGlub/46FsBkNsC+a06Vx9dvHArYqveszrAw8+8v9s2zKXMnWFJ6ds1cNZFAump5q8KGqFfoEk8dIjicH2eglZrBmykecvl/ONNfRmeXyjOoI552Ip9HL3TNrzx00o/eVBw315/hHuqRpK86VyWRW+OfNErW0ZM6jOWvoHvziiELE01nH/kziwpanL0BXFEj1QP7D/ZDWDyihZwAZW3TFIqETlz0y6drLaicJlpoBitwXizdsLANPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=FqlH0DLagPUKcUdw6vLmyW2085QSL7kJ5HOyteYe5K0hCCxuCsR6cZgGgJHDI3KBi8t0lV6TOSGle/92cOJBkaVMRSYf8GWHGe6mSb5PPYSTXx/hmrQ7HLSOPyQSiF3iezuYzO0KftFOAhaYXWECGZi/fbPjfrxyiA1RyELxVnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by MN6PR04MB9360.namprd04.prod.outlook.com (2603:10b6:208:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 11:07:43 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 11:07:42 +0000
Message-ID: <ffbb28e6-35fa-4341-9c05-a4cff6aa0b38@wdc.com>
Date: Wed, 2 Sep 2026 13:07:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] block: simplify disk_zone_set_cond()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260831034109.744039-1-dlemoal@kernel.org>
 <20260831034109.744039-13-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260831034109.744039-13-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|MN6PR04MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: cd55e5d3-b24e-4bec-0972-08df08e268f9
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|23010399003|10070799003|10067099003|56012099006|18002099003|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2JR8YeIwZDdKifLFFYK16tVboBG1OaeB1n1xA2SaCrsHC5g81u/nSI7nh3RI3YAq1fanqbKVQg1NDWqmBlnVpkNLRQj3a1jWnTNYaqtcCWr1iPBF7YCZieL6jZL9upxjhfXA/Irl87ZhMP+rXq8f+dkBmSFzAeZ+Lpm/rpxxqLKLX00/QOMk4465CGMTqUnkAp33NtTuCMaTuA0TwsTF3eTlTrnHYK1h0qziqXflHBKaYmbdi9w+8InRdcwykLUjhucuThodoRHeuh0l43pKgiReKy/KgwZZKNbFeurPTZnoWPQuLj8XnyyVAuFqI+VHl78IicljeHxisGRqrN9MXoUyuWzxQnlHLI24ysUK1h+8PeuAyCpJjaaSuLSFDIXNjJRJNBA9970p272sNzM+hUjHI4os5JlFhAxnea1ueEaY0X6kFR0/4HqMFmR1lgcaUxQNLwLlrzU3vptru0ycv0Mi0Mly+nmZBtDBu9Z3fdEMiqbCxXegASSeCxGOoPc9sK/a4mf8VbUe7pfKEhaFujYBXKboHQJYYKl3vc7+z4rh9jEr2UMDmYqnB9vQ5PDseCWuE9PCSVHPQ83l8aAHQKxsXWNKpZ3iLIip0QT2ZMJk1tCa1FRdr5IjJ2pEPiBKZTXZagwjlywrCm/ktYuRMljJMC8l0gXQ9ZyWgbeQz6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(23010399003)(10070799003)(10067099003)(56012099006)(18002099003)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3JBdER5OFRKcnFzZ2lOQTF5RWN1dUpnNFFNbC9DL0dQSkpLR2tzRUp5OERD?=
 =?utf-8?B?OUo2ejArRXJ1OXpwZnpwejl3UVlWZVhPd3NxRFJseGQ4dVl3akhnQWxHemdv?=
 =?utf-8?B?ZDNWUUNsK0J5VmlPUlNEMC9hRFk2c3R1cS9hdFVtV2lTWWZMRXUzZUJqc2hy?=
 =?utf-8?B?R1dmeUpXOVNaMVBRQkRTZE1UN1lQV1k2Mm9IVDJnSXVWNnpkMFNvQzRWeG9q?=
 =?utf-8?B?YmNmZHlQS1JIM1liN1pxSndUdW4wN1JlbWRCSDNSaDNoaWs1UkN3RmNoZXJI?=
 =?utf-8?B?MzR3aFpZaTBIbEl2VnNlYXpsS0ppU3FPS2UwL2VycGdqeFR3R3NadlJIUmw1?=
 =?utf-8?B?dk8vcldNdk5wL0lESGhaUFFPTVQycXFKQTYvb3JzbWxXTk1WOW10VGMvcU94?=
 =?utf-8?B?K2U5ZDVwbmdNQTRza21tNjd2TllESmdsYmduZ0p4aHIzVW1XaHQ2QldyeWl2?=
 =?utf-8?B?aWJtNU9iWEVuSmx0dlRYVGg3a2g5eWkwQk5FM2Jwek1zam95Q0lwRWhNQ1lT?=
 =?utf-8?B?REx3M3lOME1hdjFiMUxRR1F5STB0d2pNcHNIOENHQnFKSlRRZ01JL1ljUzRY?=
 =?utf-8?B?RldhRHlYS2g1VFpiY1UvYkFVMWV5dkw0THVtdTU3OXA2UGQxTjkrMlorQStW?=
 =?utf-8?B?TzVLbkYyQVpUNzUzQ0NKQnlZbHJ6a0lubHg1b29hRmRMZEtWZWFvRkx1OUZ4?=
 =?utf-8?B?QnhjYlpRcEVQc0dRbHkxT2h0RXlGYnJIZ3dUa1JZYWxmb2liRW5PZ2Fwc3RZ?=
 =?utf-8?B?NE9qVW5XKzlsRWNSditvSzVSd2QrL0JTTi9qdEJoU1VBdTFJWW9nK2MwbHdi?=
 =?utf-8?B?d1hMMDk4VWlTcEV3d09KUlpIVFIwbHd5Wlh6YnRld3BNNGt5OXMyUG5pTTBH?=
 =?utf-8?B?elQwTmg0SUhicHo2blRjZXZhSlBPbXBDQmxyL3k4ZGZKZWc0eEx0UlBNZnpL?=
 =?utf-8?B?N0k2dlh1WXVWRjBuaGlXZmpNcTJCSmlzbTFMNDNHYUZQVHVmUnBBMVhsNlVE?=
 =?utf-8?B?ME5kTzI0Vnp2eTMyb1Q1YW1WaWxiT1Z1eVJJQVV2dzhnTTJjRFMzampOZ3Y2?=
 =?utf-8?B?TkgvRXl4MGVqbFJCOHpDVyt6SU15aUhkN29PZERRSGY1K1p2ZWNtYU05QmJa?=
 =?utf-8?B?TmZTTW5BTmtJMUROU0RONFhNUkhSL0ZUTERTbXhWTUhkOGp5NmVLeXhRRTFv?=
 =?utf-8?B?OWRxTmxWTmg5K0hrM2xHVmpSQldCWSsrOUR5bW1YSWFRQVdiY0xTTlZKR25K?=
 =?utf-8?B?UXFEMmp5SGt3SG5JY0kzbUdoTHJ2dTlTUExxQVNBdEY0STBNTERSMEtSMU43?=
 =?utf-8?B?bVRySlpBd3ozdW5ZWXJUdkNZQ1d1R0ZucktpTSs0bFdOb3FDSVp1R210TVlx?=
 =?utf-8?B?amY0Qy8vblV2d2pIQ0FLQ3EzRlM4SGxSM2RES2JzY3ZFR0dNcXZuS0k3ZjV4?=
 =?utf-8?B?RHVCL2tzSmk5VFVOTmlxOE5jOG83bmNqNjJxdlM2eXRONTlaMzlSaXBLYmFo?=
 =?utf-8?B?UjV6NU9KY3hDSHVpWVlSb3Z1YlJ6MUc0UzMyTTEwWjdJY2UyREppTmxVTVNq?=
 =?utf-8?B?VDcyTnY2eXIycmRRVGR2UENWT0NJYkxPVU5nNGZ6cWRIVFdoaW41MlkyYy9M?=
 =?utf-8?B?MFJCaTY1K2ozbGxvemxSK3lUU3l4SFlDVzFWU0gvWTZ1aW9PUjNBNGs5MDVT?=
 =?utf-8?B?aDZNZWdzRkV5eWJvR0ErNGJ6K1UzaXYyNFZST2x4cTNlRTNHV2twVE5HYUR5?=
 =?utf-8?B?dEtKN3RuNFdOalFMcXNFMlhWU2VHOWtYRTZqYTZzRC95bGxDMkNtQVNvZzRh?=
 =?utf-8?B?YlZNRERRZHpSbDJTUnlkcFNrVmQ2TDNMdWE3ZjJSYm0rMDdsVjd1aVRrcjVJ?=
 =?utf-8?B?WExtUTVwNXliVHdSVk5iSUNPRHJKUVFET0xBbDU0cDRaZkxwREdzSFlYZ29X?=
 =?utf-8?B?b2dpcDJ4YUVrSjV3bStoUHRSWGFGTUI1a1F1blRrTFliaHJWYlp6OSs4dEJD?=
 =?utf-8?B?aGd3dy9GZTk1SWRxYVFjdGNkaTRSTkgwcUVqZGxkTHRlcXQ1STQ1YmErQURZ?=
 =?utf-8?B?eU03cm8rMko0b2dxa2xKbS91V2RIV0g4b0xqdHU4aVhpY1ZTeFZuVHdSR0JZ?=
 =?utf-8?B?cTI0NEdtdGJibDRod1pZdGliU0JlWS9ON3ovNEJCZ3FzeVBya054aURwQS8r?=
 =?utf-8?B?RGM1VnA3WGYxdEYrYTE5K1c1OVV4Sy9QcWlhQTd6dHdJcGYwanZVQXBTNXdq?=
 =?utf-8?B?clJrd0tpanV2ZStTMWtmZkQ1STRJbmRzOHpROTBiZndsWVVWTkw4SlpmOGx6?=
 =?utf-8?B?eXVxbE16OFd0bjVLelpBajBRREpGckFUVEwreCtxaHRqOElsRk4vWE91VFJW?=
 =?utf-8?Q?2UV68OnmANPOt/abwOAfyFUlQuWRw/WY/fIURZophSLRT?=
X-MS-Exchange-AntiSpam-MessageData-1: okjUjfP9HPQomGgFhDc76EaE7BRNTd7CRas=
X-Exchange-RoutingPolicyChecked:
	ZWqqphHj7sBVX6aRIoA96FDjzWzDFqRsLy5Pt/gJgw1CvaSuN7ayrlLto0BUzIVJWjLuPcWRfelEjYy61PdUzQ9fkqxcBQBUVSMuN5WBg6S/pYScD1VBIR/zA/T9HCc0LuvWTgk85CfM4Eg7mfZkQmTTkA/uNTdboQpfvvNZP75nNv0kg6eIOtbxXx9TtpvJrvc3kgZifdYpRpuZd8nB+usd1CE3UTamA4cMvmSepOeHwracWbY1EDq6sgRMa82lxB4lcI1LXg7m8OOaDTS/mj0f9HixpogxUa4Gb4oXMO0fVYsKxxmiSgteMJXRvVLHXMQSbMtPkUMli83IYfntpA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3mIgHDmrUbRgnNQIl6nkbvk/dru+2NuuY1fNGb9NkWMdQtvrG2zdKGIH3wGqJ8CX66K6pvkv632osoGTRYaQHYCa+11pmfzFd5oRKtNuQ69IP5P+TXEKL/CRX/opTVq/spw/vay2O/lBmzWHnRhNH+uQP6D2JLvJYThvVYnWn347PlSyNEx1ZLIQqiCZ0grten0syIf0iYgty+U+eQKJhYgCeVNWwE+60ijQmDxi+SYpp2O/5wrORwnTQRuYxvJO0E7ChOG02/qyABJTJYj9oym5cFi0z/3FGpHOUFOaDT6YItiinjW/XFy0BYV2sGC001nFVIQm+zbpXiWIVFg8dm+xxwv+AxH0JV0jL5jYhJ8DoAI51GLbOo9IlDqUCE4P0k/AQ4+fbt28DmN8gA2LORs+4idLOYBuzH4p8aTgYouoS+lIpfy+CG6E0K6SjUR4CwuYF4+g0mHQP8KB9waoyBg7/6vqGD8LRJbX5owORVW8kSf0tMLublOe5stKKPlPMuOepf6adA5BXagrILxuBdRajw7UKystDdD4arWnvdGazX2W6wL9fJWqbU07HgSdDwU8SAnLv6cT4aOm3e82R4MulcbYZc+dJmbIBUux0hkC2OYfyHMClk62cJchdm16
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd55e5d3-b24e-4bec-0972-08df08e268f9
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 11:07:42.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpjU7/iUzW7/R/AT3Y5F4K3sXI0qlTJObglfDDFA9vE91C+5GMNrfgqmZaG46wDe+PGUGsheRuEsHV/PDp2EH17/dAGNtm33DFShdVBjKus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9360

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

