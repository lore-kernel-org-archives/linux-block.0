Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD547F769
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162866; cv=fail; b=cXt9Cewd6UhAV3XPD50VcDLgKn/czCMHIyiIfT/KzilllC8U4PDtepvCw4vhJ4QNjETOnGXp3es6G56Eu6GqEBo63Rwz6gXPQWvOSNKXDsZJjCGMNSl9j8aohp+8Z89bnGrBClNTvLsdLigkRjaIsA+mvfK5luRL4szbhJdEyu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162866; c=relaxed/simple;
	bh=6zNNmXerxl124oBn8urjxuCMheWEU4PA/3NbDtmizEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b1cMRCFNGrWl7Ac+suvbOTF+0KMocM4NTB893dFRejPPOYuJdaWjwMrLUSiqe2vOP3qpAB0IFnyI1Wz+ZrpGtKxqVn78deOH5160PpeE4PMrcy5olSiD1gGMPJpoezG3+LTPG//Q99qm7I/I06zqQ+e8EE0flHb92YqmvLzwpxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gEo6VGmo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bG5tYxYu; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gEo6VGmo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bG5tYxYu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792162864; x=1823698864;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6zNNmXerxl124oBn8urjxuCMheWEU4PA/3NbDtmizEk=;
  b=gEo6VGmoQUC8Kkkb5U7tJMj4wVZHgi0SlkniaKnOnxNyOVgEiH+nvMPS
   rvI5iHjfkCUxtTCFT2xdap4lNayzZEHBT0yyiEqq2GwfW58oaOhXHXn09
   FoWzuWPgfX0byMmDCFlCqgzkzD2252dTfg9tsGU3a9R/NUNf1ElL9dQhR
   nOQPfBdYRNZ6BhbspuijfwAFHXjDr0Q6YIdNQjod9vTlXhJ6QbnT/o884
   2iHUochxDrQWbYSd10BGMHOrbY1f2DQ9GnrhcTLCb8KDcy9Z+FXZ/r5Qy
   kZVk5muBcmqCQ9fVCLgfjCYirYEwzys7QABX4BXgiGzvmgGLJ2ywNMena
   A==;
X-CSE-ConnectionGUID: s4X3G6MlQJeJDra9AUtWoA==
X-CSE-MsgGUID: znoB+6saSh+TMx7xmbpuUA==
X-IronPort-AV: E=Sophos;i="6.27,162,1786982400"; 
   d="scan'208";a="156668338"
Received: from mail-westus2azon11010000.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.0])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 23:00:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQbsHfzMA25iMzL2jDha/je3bybaIDuYVhK/24kAzc/fxFxZNRwA2CsBFKpgt6O8jeEH0XCZW40RhIwieR2QRW6u3C/883nSqEK/fI9to2yoQPWUKpuwRt9JEryyMVRGN1ZPmITXZmajseSC+hktdCIl4iSmNH0lfKvWPRjaweWsZKpTHCG85udojzeskAXfBdxLc7uBTm1iJ6JHBAo2ODt2TKNysGtv9HmCX8849oVKoWUyvWhpIwmI6X00SQSFMtOhSnUQ9dEF/FK+wontwcjub3IUf6qzI2hz8oe9OkUmJikVOhgES+1JJVvH9Gl3oyIijidoOjfclr3NF206sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/42Orc5rkKBtTzh5x55RiFvPYrRWcJisefpaqHuw6s=;
 b=rdrBXMO0ViwNO5gpn+h22foBVJL/wauuQZ/yMooPKiC4A+WIzSd2PvqaDurXXlnticjwsdaE2oreYCTWAWHlx8+41w9KVbW6daTnqyvXN+dR5ttaPH/TquDCgeWDIO9Dm005DoPtjNsmEN6eKtylIhuvyXLQOImt/rTjanXXGx1b/sbdfK1RrTiBg9fSttb6wLYiWmanhAZCndy7KvUBWp5u+t2ImeBY7YygretlPpLGucmIwqAelJUGOHKeDDn29SPn/+qs//OBOLvsMv3i3d3Xdxqz2OatgEvaTEu6uh2Qr2f+pu1rzdYd4Zc05i8iPztJd8BTpnz/8wKWDxx+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/42Orc5rkKBtTzh5x55RiFvPYrRWcJisefpaqHuw6s=;
 b=bG5tYxYu4H/SWNyi47YIXP2b10UEDb+6gzJSf+OAOA+J5b31c0WI37n/j40RI9ONcP8ifIYw3GO+5VfmTPcrY7CR5nhXqX1tCobeFs8aRbGEGFLsg+qOAjW3naL8/A9fB8sp60NY7n++Q39OxvAl9xBNoUHMQaZG5UPt9U1Cqm4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by SJ0PR04MB7662.namprd04.prod.outlook.com (2603:10b6:a03:325::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 15:00:41 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:00:41 +0000
Message-ID: <45e15bac-25a8-465a-a3ac-ca97d062ab9f@wdc.com>
Date: Fri, 16 Oct 2026 17:00:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: print device that had errors
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
 <4104c9c7-2df4-4008-ac2d-0c999bba98d6@kernel.dk>
 <237f8537-79cc-4ac0-83ae-31ea0d51e0b9@wdc.com>
 <5ce34052-c18b-4e3a-ab3e-f689218f6208@kernel.dk>
Content-Language: en-GB
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <5ce34052-c18b-4e3a-ab3e-f689218f6208@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|SJ0PR04MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea2ad02-b212-41ef-1829-08df2b963ed3
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|19092799006|23010399003|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uyx5pgyU/EOrgPHo48WVBlcsrveaV6xdmHao1F8HfNR10kGB+iSnnYPVsOkqlr/cQ8XCsL7vl+1d7br+EpCEk8L4xATBuocK5Jhe8Hf/wF8XaWFYiu0dKm4+ME4D9yXL5LjZTp2GnKGmM6H3iAe9xipQ1vD8TPMb53PGTGSgvLvyJAvE0/1KElCM/zUy85Gkt3MI1H5G+4pyBu9fFrmk/7YWZhGy7SBHQ3Hr6XtN8+YFHNyFDXYnI84/5+/TDEQCdkSI3PvMgV8uEug05pu2Y4pFbi0f72XaQ7GVEvAPpx+sDUHxeKvMFCNYECki9L3qDIP1TSAHldd5YHbKDDpg8g3CCcItWXl0dGrtTlYLz5vHuZ+gL6/Mle+D/JUa1ra5aozZyC2Frhhn/46LLDVdi0PyAm8TbxQeUNpSNy2l5p7zOtyeZI+XxaO+FsKBrg/rVJhGhI3SNFZStuTPe9j4mDDQOg3yBKRzNmSeDGAwDzYDHU/EMhTUOYzEh9jRX0PSmL+ish75yIRZUu2x81ijaEp3/7V+IKZY+cv/0EkpMRhMeKf9A1h+HYRkBN4ZgzjCH1xInjCSymBdfgn+O+l49iCbzykXameHYiamY11UBjto8QmiTGrCjazoQ1Cup8n1cZ1vIZzKjjyax/F5vrlCWGTtDDM+nFP3HSEy8uz/M6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(19092799006)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjcxSk1iM3AzWkdpNFNDNkhJN1ZXRVNDOXNIT2Q4Q0VQMzlkV09xVEhiVC9N?=
 =?utf-8?B?TzhFaG1PUzdnWkFrVGVRY1RZRVd5RU5QQ3ErdFJVT2VzeThtZTFGWTc2ODFN?=
 =?utf-8?B?U2xxbGpKd3E2azg0MElwYlk2R2FJV1E5OFNBaVZ6M3BXZGwxYXM2YzgzMGpj?=
 =?utf-8?B?RFlGVVN1Vk1CRC9DT0Q3RlkxYjFtTC9ZbThuTGUyZmdRTC9UQ2ZVNzhmaTF5?=
 =?utf-8?B?RW1jNldMekN2clE5OVJLWk83VGF6SkRaNTM4b0RzV1hsZllzVzhvOUhPK2wr?=
 =?utf-8?B?QlQ2V3QxRG83SzdQN21xZTIxRHk1bWwzaGlTeForYWpROXdwdGo1ajc5ZXA0?=
 =?utf-8?B?KzBXRjJxaTI1clVpQUJwN2UvWlJ6aUtoRzRLb1p1MXVMTmpNTDhWRkpNWUdR?=
 =?utf-8?B?ekJ0WnkyYnBwTnd6WkxZdEk3dkFsNEJmbWo4dkVpTGIyRmhyMDJWdDZVZjFt?=
 =?utf-8?B?MXpEWjQvdHY5ZXc5TVNBS1ExVDhnWGw5eWhLNFAvYzYxZ2ZYR3BzK0NJMW5m?=
 =?utf-8?B?UGUwNUdHZVdRZUtXZENtKzhsVlJ2a2lSaThWUDRxWlZVRVNLc1JsSW9WUVB1?=
 =?utf-8?B?ckZZeExhTzRpUEkxZ2ZSNzhackFyU0lIcWR2bUptcFVVWVRhS0RPcU02eGdG?=
 =?utf-8?B?Wndmb0tzdHNqVUJMRGlNSUZsOVVLYlBidWxpamRBNHBjaHpnVjVnQmtUUFdv?=
 =?utf-8?B?ZU9KZzRvS2dMTFl6NUo5VjBzaU1INTdtcWlCcUt1RStWM1M0eEVpQTdtSVZv?=
 =?utf-8?B?c0dFalZCakNNNWFNRjFJWHcwUEw4SkdGdzQ0WGlzKzhzaWpCcHhqem1GMnJi?=
 =?utf-8?B?bHBFaUNsUHBkUnBTZldOejZ0N1E5aG1Rakh6OEpqSjFhZlpLUkkxcnJQbyt6?=
 =?utf-8?B?aDYzVko3Zk5tMmJSeDRNemVtSzR4clBNaHQ1R2xSeGMzeDZ5VjJOWGxkSVNH?=
 =?utf-8?B?SjRGbGx0dk8yMXZaN1VXYklPc09WcnpiNklzdTBqMFdNTWdPelpzcytsK3py?=
 =?utf-8?B?WHFIQkRuUzZHU05IamNOTzljZzJLamZ3WkZHZDhXd01RMFVPSWdrcTAxS1dN?=
 =?utf-8?B?NEpkbGV0STlPMThYSmhRT2Z3Zmx6ZUpYREN5QVl5TmtZeUkyNThsUzEvaWpv?=
 =?utf-8?B?dmgrR3ZnRFQ4RFJJdkorZmxSblVEcmcwTVFXN3pTSUtLRFJTd1FGZUlxWXJm?=
 =?utf-8?B?V1dQMXJndkIwVUh1UEV2VnZxWG5JQUpmelJkVGk3VWhZZUorZnc2c1oyRE1l?=
 =?utf-8?B?K2t2eXVvNVZiSnRlWlpvdFlEV0gvYmZZZVhZQXJoeWwzR0t4YmdTZmo0Y3Bq?=
 =?utf-8?B?Q2hhaXhpTHR5c3BPa0tVNHpJZUFjUklrSEk3c29YRVZrenZmNDdDWGNEWjFp?=
 =?utf-8?B?T2sxaXUzeVVONDJVZHNUU2ZBWHl1ZW9TWFhwTWlobzlGOWhDd0Y2ZXFBa0Vl?=
 =?utf-8?B?VEFBbzk4SVRRbXMycWZkQmM3aytEblVGRzArcmM5WllHOWlCTHhVek9PcE9i?=
 =?utf-8?B?Y2pMa0tQNGZXWlZWTys4YmszNUtzUmhXTjVhc3Y0dFRRSlNNd2JhOVpOd1RD?=
 =?utf-8?B?OGdFYk5VVDRwUU0zVUN2aDNLaFUxN3VTTFhXOVJTV1g4WEpwTzFlai9Rc2Zx?=
 =?utf-8?B?Y3VlRUloeitMV0dUZyt1cU9IWnR1Z1l4Tnd2dE96Q080QkxDT1MzR2lva2pI?=
 =?utf-8?B?WHFYaHhsMVk3TjJRbUZwTnVrWlZtMUxEcCtoYVZKVnFHa2JSR1ZzdERoMGZ0?=
 =?utf-8?B?ZHZPN2lpblVxKzVqbktsYlMwL01POHhSNDBmTEg2T2hTNDMyZCtMamk0RC9N?=
 =?utf-8?B?SERDbiszOEhFbFdoMUVqR1psN3NNOHZJYm0rUVdTWWsrczR6YWw3Y2pCcWxx?=
 =?utf-8?B?cUI2dVlibnhweXFoNVZLc05EMEY4M0YwQlUzZEZEVUtudmJYTzdaZ3dBUDJY?=
 =?utf-8?B?bENCM000OXh5eHg2dUJCSE42UkE1c0xRRUMzMjdXay84cjRoeUxoK1QzYlR0?=
 =?utf-8?B?Z3V2VU1QQmhoYWZmdlZYOUNPd21FRUxNd2U1VUc5Q1lmTEdjTDBOYXFka0ZH?=
 =?utf-8?B?QWtxQnoyOG42M0hQMGFwRzMvQVh6UUlkT1ZjSVdqYVltZ05DN0kwN0NzSXJp?=
 =?utf-8?B?RGNTZ3ZwMHJFM09GVUtHWmJVREsvK2txQ3hZTjdLemZPRjR4U3pGN2JtM1J3?=
 =?utf-8?B?MmR1Y2hCb0xoS2RkV0swWmpBWXlkNUkzOHVWanMva2F3QnJFc3V5MHpldE1N?=
 =?utf-8?B?QnBndkZ5MjVNc1BsVEswbUVCemhuRFIzTjAvYzhWTEdzbG1kU0Q2SkcrT1Mr?=
 =?utf-8?B?NnMzWmRwT1VhejJTTXB6ZmVuMVlkRk0yaGdkanFmRkxxWm85VUdxcGVxajhv?=
 =?utf-8?Q?cToATezvvL1g/CakATPrwK0UpjqBNxQjvLNN2aJQ/XLs3?=
X-MS-Exchange-AntiSpam-MessageData-1: FgSlsuovmfFt5CBMeOvlf/tuha2Ml6+Uj0w=
X-Exchange-RoutingPolicyChecked:
	D8ZSo33ebqknzU8byxkP2hoRzh/mOjJyrF7UkIoRGAWZ8ZEIfRZFbpCYE1zeKc4/oCeYWeKfzNSH4l1J38qFI7xM1nZhPia/gLLdK9BT2eQMEsFjeZ9qWKg04LC50NiE65V7QGfrjxOGBx2Y0leSiAWSQdjG6Qtv2srkhmpWRJpb/+Mz/tkpgXg1Z/Gb+53uaD0Yo3AYXN32OJZsWOgafGYnkI/MVb9yrOJhzITUvPZ3VMOPPVOMsfpwZYUSSPls2fy5jO4X1vvONuEqt957gR3wqx3uUEtyOWeDzL4XAbRG3/Oi9L3sQhM2Z5h4TBzuqD4o+il0ElmD6Re1+yzG/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2J4ErwjBCPZqlWZtWuQyZ34yWPu44Mfs8unT0DXHAfFZeDzo3WmeXclN9aru5sU4BqE55yikwv+pHIUgT3oyGR7oosBUQbG7qraR0OiXqy7296ruqP5pOs1f7DOuMkgLaWk5NvWrlkr6SNcJhI6WQOOXwW0A+jYf1HSCWxj1ttpKlqmWA5vyTdWG05DcJoJNtDtsl0a5gzswPwdeLzTYMV65M3gtLWiIwkOOHbuouueq5a+JHECWYm0LERwLaoD+fCdYsbk+nQiL87r9NWYJMkg9jNHjvauhF6oB5fcfnz7VMZEsdFT4Lpc9QmLzmfyd8C3x5MJR5vu7PT6dw7eUUGb++Y33fvx0Qak86S6VVt3TDNkhF42kgR8D8fPeifLwXVJbn37833+KHM5bUoUktQuZtqBDKe0q+vcGQhi3VwsLeYdeRq+DvFRgR1/ClSs2iw6zUzdeVG9I1WVcUzIYKPefKFKoVNgRE5NGD26teouVMG585VIlGfgVVdhULH2/8fMcTGYdQ5nklTnc0V456RMTf6zlOabr3MeZMRaqLqgCv48ehf82ijn44naada4P8kRTSyJzoiiJ9ofR8BY6y1V/UL63aD/zY0HhzMp8Sikc4wksxruykaSl4jevhKOK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea2ad02-b212-41ef-1829-08df2b963ed3
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:00:41.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVRssEdYptGOmlRSai2ADQNxoNNpMGbE3JCiE8NnNygPRhzsUU6T63RjASkNkX5yx+wmw3u4G1s+o8ojWYUQ8nE/gEscz840O2gnWatSgfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7662

On 16.10.26 16:44, Jens Axboe wrote:
> On 10/16/26 8:40 AM, Johannes Thumshirn wrote:
>> On 16.10.26 16:23, Jens Axboe wrote:
>>> On 10/16/26 1:30 AM, Johannes Thumshirn wrote:
>>>> When testing zoned filesystems that span multiple zloop drives it can be
>>>> difficult to figure out which devices access caused an error.
>>>>
>>>> Prefix the error messages where we have the disk available with the disk
>>>> name.
>>>
>>> I don't know what this is against (doesn't say), and it doesn't apply to
>>> the next branch...
>>>
>>
>> Strange, it applied on 34fbfb9d8d1f ("Merge branch 'for-7.4/block' into for-next") in your tree.
> 
> Does it apply to for-7.4/block? That's what I used. Doing other git work
> right now and will re-check later.
> 

No only your for-next, sorry. I'll resend once I fixed my mail setup again
