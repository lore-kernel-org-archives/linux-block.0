Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FF472075
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346629; cv=fail; b=Uibkz/nnGyu09FDHZnVkimIQAsZ04LCB7TZGaB8h5raXqbGufGFFvHoMT7Kno2ZYS8DbeEqy80ro2/Rf872VRJrr5ahQkBdsNrHplamxXliYwEKuVoxFoWLtK+JPUmE/FlyEOGpGxNuxV5IiaJyEGWlEfEkdHlDAw+K/a+gTLb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346629; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aaKYEEPGBJPW6r6VcZOOkhDha98NWdT4AimLk8UxIDE+BPMqppN3YgoXbq64znjShl4xSMFctzm0nwIKr7D5kQM9KUfTxENcI0OROHTrNnsvNiBvejEeW18s/h4AH30myT7Xt+TzEb8OwJvoLvqwHoXSqLK/DqmGHrhZNE+NiCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a46Jwuzo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uPz4790+; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a46Jwuzo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uPz4790+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788346626; x=1819882626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=a46Jwuzowfp+wTpDFBOZVwJ5rKh2wooUhPVEtOonCZF8Ut7Q2HQkYvon
   Ci6EfMv2DtQ6fFy2gdNRAAvv9jVuq1pTszdKPk8F3iMvGs9Qh9K1OAuhz
   GRwNrrylA0XaiwXH2WoOvwM99vqso5dECJeF/GCiVwqgw54WdJK9v4ybB
   xV03xbweWDl6yLKppjFac36GtgMvQ9B6YS+rwFw/sY8KliQVbCWSin3w9
   uVnV21J2JnhxBTswSYCGa+2Ix94fV5YlLLMCQC7HUhkvmLV6X7+WoQGjN
   rnJy+xdp55ENGvfStPkMWcJlaS//Ve0U/2npXZVpGpZjkH99xkYqN8S/V
   w==;
X-CSE-ConnectionGUID: ZLB9ocVoQKu6CqU/9h34WQ==
X-CSE-MsgGUID: qJSmbm4NSOiIES+9iHpBeQ==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; 
   d="scan'208";a="150574482"
Received: from mail-westusazon11010055.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.55])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2026 18:56:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd9mJn/WN4Dcy0tx06wgnAqPVwb4WNsLdW7p9xk+TFb493V+z+EkFeVYvWlW74X6IqEtJJGM5jRw0D30mtFH/zmjRP5dPSocCJQMYprkNmRgONMAe+3fqI7d5XOeQBgyt1uSKAgZNcvQuzoCBzraWk8mbJI2DChrwxwM7MGLpBFSxyCJI+pJw/i/7VZ74A63UgPsLpoc0Rx+GPoNOy7sz42D9aYVqfmO8I0ocgg1QnHW3XEpPpGv/G6zR5l8Y80oOYIuPjWg0/qsO8pFL4BqPrzDcbFlTQ+hQz4t0eMmH412QL2fWHW8hssfVqwya8tmv954SHsvRQuenScejHmo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=tcZK4NmgGBkhfWrmubvq9auzb0UbD0DBPwRYx/EYIqwREZfCq030W/MERm/l7SlO5Wscx6n1tRcu5Wu1RzKQSssJs3Sf0BouqYMWHG+ca9SNBIYDfoUDvx74beffQIb7WA9lgLMwC2Ul4bkJHPhR3BO5pUlNVxEiIrWvBbAnpHFUo/by7cahMNSjeKzWZ6b5sNaJAxEmiWFsO2ziB+9ta3FUS5Rs+CM3zn/Ti4rcE8sa7adJGbMZuBvEg8jV5txh63nmtr2lrgKD64UnjDCwRTWYciobAhSoomy6/xX7zEH3nka6/HDGCV00vWxkWpIxbsId5kD+qJGhe/0xx/d8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=uPz4790+vAq+dVMB0yaDRF+5cE3yM4n37WDVlQ/20+1RP+M+TBZBWNC20Y+sLqBJna+mh0gWYGOLe0L9J4CTwpPKC47hN/09KMuz9zgZ4XifeipF4U8mCRmfERcEh0mnTY44PPzpWsqxhVXMghn+A72waLmSfmz8WXMR2Dr2OaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by MW4PR04MB7331.namprd04.prod.outlook.com (2603:10b6:303:79::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 10:56:57 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 10:56:57 +0000
Message-ID: <4d5fe908-da93-4906-b45c-bbb6414f694a@wdc.com>
Date: Wed, 2 Sep 2026 12:56:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/12] block: always treat offline and read-only zones
 as dead
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260831034109.744039-1-dlemoal@kernel.org>
 <20260831034109.744039-10-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260831034109.744039-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|MW4PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fce8e4-4f26-49fe-91c6-08df08e0e838
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wrO9DcHx8EQWWViwWHYhLnapstnlKMP3QxWSurDDiKwwA5U3lQPrOSjtDbFOMODhR8oZMaGYncE45WYHy4INlnjHbQoABUiW97EkTd1Oh3GNRMcarKW52KKBIFW7whyBAvomX+Ojs5FNJsRgcKdN/Y1oHoGZEVKBqME7i+10sDO/3bhkk4ck2/XSNDeYxFNYPUhmCB8gjti+PKCsuyoRI1UcYDtkTzh+mD/M2Fe5hkocN7M2hL49ilFj20zQaILCGSG+6bfkVJ00Wyxs830VhS87H83oZP+7HxwuQi3FmozaLu7ZXbDDUd8qFwUHFf5NmSgsxrhfKMzGVLEoahjOQM/1O07DpwpHPF4XBNlPdYKJ2BYR9UyPNOXfk0sU2Qsv5CzlfBW2gVtvXoDgGBd8JlYPysh+z2qCERwnKBo/OVTQ/a3OylvPAp0H4Cx9HqTU5oozBE0s7to6Ib/3J5IFUYbtMBKw/lMh7SRbnO313810z81Kl2QwFqaDzCS6q99SKnJrqp/JGzsfgWCBPqQo0+EWtA7KoFFVskpNRySHRqWMqWzS83Ww1LO3q/XaJxL7yhtqgjo220I561tCTCEXR4HSX28Y8GNqOoGswUwMYv++XEMaPhNmgwc1HTXXziRYrJnyHdvVC2SvZPZx5NA1+DUKbU5Tl7ubad7Lh81QbbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWhMZUNqbFhWY3BBb2daOGlERExqSllvT3htVUlGOVB0ZjM1K1dBZ2NCTzNr?=
 =?utf-8?B?M1V3Qk1PS1JIOXBqZlJ3N3dRd3dkZ3h6RTJVV3BLWVd1V2F0SC9Ld0NtQ1ky?=
 =?utf-8?B?VHJMQjhXOVlrL285dGk1Vm5Rbm92NnRTYjdWUUo5U2NSaEk0VDFEWjVxdjBm?=
 =?utf-8?B?VnNxM3Vhb2lmNWVkbkdBZGt0VHkyZEdWVjNPOUl5c0hNUVFWS1F0WUN1enl6?=
 =?utf-8?B?SFQxb1VOV0RWcXFoWGZ1ZzVhVWdObGhsUVdjSHUvTk9McVAvUFBPTzhnSXA5?=
 =?utf-8?B?VkpYV3JjMWlid0xNOTVvd1NSWlZHdmpwUEVRSFNKcFlGclkrME5KU1dEZmNr?=
 =?utf-8?B?MzN2RzhweVFncVlQbk5sWktpcG1sSUZIVzRyRUs1SDRIVzc2SFV4bGI1aEhT?=
 =?utf-8?B?aGFyVGlNRmJRMzdTYXVPcEd5WDEzMmtsdXN0NkMzUG5kR3lkN09hWHhLc3la?=
 =?utf-8?B?TDV0YWRrcGQveVY1UjVzMEpSWkc5bkVGWGRtVmJEV3RQRVR2cG00MEQvZ29X?=
 =?utf-8?B?Ny9tcXNrZm9XQzZFb1pEZHNDSkdvV3hzUGZVaXZiTGdEWCtsRzJZSzZwdDZh?=
 =?utf-8?B?akFpTEpmdEk0N0ZOL2hGNU12QzVoYnhmZS9tdVlLUlNJcDlaMDllb3Y3cUlN?=
 =?utf-8?B?TFRmSTdSYi9NUHBvNjN1a3FsWmdQSnk3WEZPVjh2a0lzZm5KTEFKSGNQMDFL?=
 =?utf-8?B?anJsOHJtWnh0QVFuZDdIRkduSGtwNyttL0ZZdlJvUmFEd01OSTRiWk9CK3h6?=
 =?utf-8?B?a0UvZkhsa1BMT3RkUWN5dVRodlQ3ME1QV2lSaHFZRXkwNDRyTjRyRExqL2tZ?=
 =?utf-8?B?L0pHUXVPZFd4STFCZTlzNnRtK3ljMllVbVNYdW16VWgyOHIxSDhQRk5OcFhN?=
 =?utf-8?B?RkZ1V1k4akN3MXVuVzJDZDdkbVoxTGtsZlFlWVB2TC9pNzZTbDcxa3l6YjBp?=
 =?utf-8?B?N25ZSmV5MVROejVOMmR6eXFrdTJoQ0p6RSt1ZDRlWmJoSTRMN2tyVFV3MTdD?=
 =?utf-8?B?anVLZVJuVklWd1ZwT1FWYWFwZVBOOWJ4TWs0WUU5OUJ1aXkzU2U0dHNNazJL?=
 =?utf-8?B?amxWaFh1RGN0emUwK2pRNFZMczIxMlp6cU15YndnbEEzMWh3cFVSc0JtK2FM?=
 =?utf-8?B?bmE2SFNOajR4NTROSnlNbDY2MmVqUUhtTHA4YUJPSDY1UU5Sak9lK1FGM0g3?=
 =?utf-8?B?Y1c3ZGxvUmlLS0dZY2kxcGZsNENPQ1NVeDJrdW0zOThmLzBOYWxZZzFEZ3RL?=
 =?utf-8?B?dzlxdTNyZTUyaVV4RHd0Yk9Ub1Z1bGh3cDFkU092MWIyQmppRUplQ3dlUGov?=
 =?utf-8?B?SkF5WVB2NHNsQXRNd1BobTZJVXdNOHYwVmN4UXdUT0xNZmpRT0lKUm9HQkRN?=
 =?utf-8?B?N0NRQWwxMG0yMWd3VDJUTjl1MzRsRmtvQmN5U1E3bXF2TVdialJIZjJVcUxK?=
 =?utf-8?B?bUNjRU9JYmxFbWQ2VCs2cFhpTW5WZEVMOUFuUDRDRUw5T29uYWFVT3Z6bGdU?=
 =?utf-8?B?VGdVL0N2eGk3TGxIN29ZenVmd3QybXhTWEZWaFdqYmdIRXJsNWpmMC9CY0Fv?=
 =?utf-8?B?Q24zOFp6Q3hpeXliN3ByY25UUmU4RGdYczNpZzYzRURHOTlBNlErSXNBZU1Z?=
 =?utf-8?B?SzkvVnpGVlV6T0Jta2xFaWdsZHgxbmhFR1dKWHRXcStqVE1ZU0MvQVhRWDZN?=
 =?utf-8?B?eDJtMkJLcjAvNVdjMGVreTE4ZmdyN0pnZDRSRXlNYXZkaUwzQmZnU0ZneTFN?=
 =?utf-8?B?MWphMkVpc2VndnVDSHN6cjBkRjJ3RmVNSFBQNlVoODF1SmJBWTJJQmYrMFJP?=
 =?utf-8?B?NFJtbGFCVytwRDVKaFVlUkxHV25BWjlUcko3eDJTQWk3RW9oQnZuYlZ1NG1j?=
 =?utf-8?B?a080R2YyR0V5V3NKYlhRb3VMN2ZiQW9FUlZRWlNHSytFc1dtOG1yLzhBNUVn?=
 =?utf-8?B?ZXFTTVQvcS9BWjBxM2J2TkdMZ2NDOEFORDRYOGVCQmFWSHNyeVRoUzdsK2Nr?=
 =?utf-8?B?dTV5TVEzdzlTSlZEOHFkaDJXazlRNDJHTVBUZXRzYVAzTTlzNks4ak45TTR6?=
 =?utf-8?B?dHVWK1Mya2gvaC9CTzRXZ0hicHNZWGZ5OWNVU2VSbFdMQVhUK3JlR2FBY00w?=
 =?utf-8?B?NWEzMVo5b0w5ZjdGV01IeEkzRmNLMEx3NjJuTm1Rd2hGc29ZRHBhLzNGcW5w?=
 =?utf-8?B?SndMd3A0UlB6NnBvckR6eHpYNlQvSjJyZXlFaGMwTnZNWlFxdHh1V09iUUM5?=
 =?utf-8?B?aURhNDdrZzQzT0ZTMnZRNERubVVUalRFc0JzVWNnNDhjZ3lpd3JIaVhaNm9m?=
 =?utf-8?B?QkJTeGlkSU9wTGozbHpZSGdaZUQyTlI1WkRMUmFpOFd5Z21ENytuekMzbzVS?=
 =?utf-8?Q?zi4rqipJBS49EaWrmCn0SIXgfxo26btPR9PuR+IjY1DEW?=
X-MS-Exchange-AntiSpam-MessageData-1: RsjI9mbhiV4kvPm2Ouxjy6Wp6jFK7duz5jA=
X-Exchange-RoutingPolicyChecked:
	JEMLRNa9tzo5gjU5U7IeiLly6AWAZ7mrnvo8yQaJX2GKofn/zMDk7MmXxP5FmxG8TvLmPp9AuL8GhtLrVMV7lLvY4nzR+LlYrgu0nhrO3Ai3nAJfLgS6pkgwmrwLVABNaivCm6L6CqRD3VUYKv0bA5RAeWXrBPV5WpFhE9WigsRYfZMNPFoxEL9b0M3F66BC+sstJ8PCH3IdNEppWpvg9X50+HzxGsdaHN7rgVO+b3waO9WBXRx5U/RLjKIqhS0LyI0mZ0m3W0Rh9FwZVhiy0f8dLrkia/T4+Xm0I8gHQjhzzXKYiZcXGg7qV/xaPFqw6khte07+ElAoztQs0R/WOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OixmwDAgelA9SZ2EOwwTMVD7SYh2bo3AEUIdUDKcePisOTfLa1XzRAt/BIWBdvhbMdcvfYz5ek/uYWAOJKjARMBx11SDA0ggNgAGs095emURx1HE04TGR6YGHmqhGnV+mpPjYN/vadYuDdJarnvPJ0xDb59c614XJhbGzO/c6Pe7+BLXDkD+x5Z1d3eNvoSkBzvWHr6/NI9ah6fuZ9iOg+EmsGkTw5wBStsl/kDtRmRfMnqraQ31BFeHHJuKhXEiQyIUjEXkQ9c70utlG6irGd9QP6VQT1tr5AqKpE+gh9fLo5qaII04iswYEVKk4FMSsacTy+Cr7mCI6qk0oq5SH/XOyvNAXPXgoXORuALev1I6zDINNSMaLN5rUN2sSPjUHmh1uULLi/2qDr7IhHz2oiOa+sV+SFZGyTx5W45o26SpvoYnYOQDHZYwf9I3uBczh5Fjg+9eu2UmQQxB/nSTlmPHFSAczjv6paeZhypgVSp1BmPPgIz83cqvk6dlJl4OtcfsjOJNKif/TXh0zVfoggpW+MS/1VSvfWQ/bp0ryrD/fdI3Obb79vsVor4OEtd7zxmFwnYKv3pWtR9yOrW6gLi8YKgx9JpaxPmta3VjiepRDhO8hFNc/fvDcEhPcCVL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fce8e4-4f26-49fe-91c6-08df08e0e838
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:56:57.3819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEBuVNs9rl1GA450PdVO5hIqqmFmKFhXNnubOVUTT7JqTawDiNbH7Q5m1yeEyU2hjvpPg68EWZCF4V9t0FL3w6ZjuPHhOJRwzS2Q98YNli4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7331

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

