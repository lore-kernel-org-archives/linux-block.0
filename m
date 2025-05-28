Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F5170826
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405912; cv=fail; b=Ckjo7SG8BJqMP7OgYil7u0a+D/k6LFW+tLOZ5JdxQ1xQd9oB0wJwO+tSRERim7UVbjoxN3vWqkKaU6LCqaC4dYlE+owwCXXpwHWUUmhXsg6EnjBKoLoadCFAAsATCpHtzYe/9WlUKrZPFe3AUyunmGOUhKj1CqlqZ928cHy9uZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405912; c=relaxed/simple;
	bh=QvTQneg2hgLF7hjTJTNzq9hzeDC02csypNyktXbFOCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1IML19Z/C2rnIAMcjaRRlTZaODF9lONQ/Hd9mjguOkg41T9+rNgQHNO/f8b9qHxxS7eMs7sz8F5paJtf+vcXSq9atMK4JZAf1L82qKUgiL11+EpBTXurI5cyD/7Pw7ytQOyNDA6hJVsiR1+P2mdVfX/F5vjT3lOgGu3Z2ntXuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NGL7EMFm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Pcah9Xtd; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NGL7EMFm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pcah9Xtd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748405910; x=1779941910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QvTQneg2hgLF7hjTJTNzq9hzeDC02csypNyktXbFOCs=;
  b=NGL7EMFmc0E/qdsHX4EAEKreW/VLjHoyPhbdHEAdas+igDvbV/MhVmkL
   0E5iu25O+Mb+xSdNHQcdRsyqL55KIP5COW0ioNcBTF2uS/LrsVBUuECOG
   uhA/u6MFF6N2pmljWJPdjy3Uhx+Yk4ZeqYISXZUNjxzx1NWvXvGBTYpDW
   nu5OSyxs4gQAe/jndKqwIvWirQfIQn5GtIHJdv3rrxEvf+mOruwuITAxO
   j7sDDip68BscuV076CqyzEeoU+FIJ+J88rVLl5nofHkw/p96/4LILRg6K
   z2PN0of8h01wiImXddqb1R0ayGq0KWh/YvgY7m3xBq2jBBeFUyDcicM2h
   w==;
X-CSE-ConnectionGUID: wKzNGScNQIeSAOR36gOY/A==
X-CSE-MsgGUID: wBXa2WjlR6mAybbnVXp/PQ==
X-IronPort-AV: E=Sophos;i="6.15,320,1739808000"; 
   d="scan'208";a="88267571"
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.49])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2025 12:18:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZtDO5sYTk9Iv54V4Nvt589eN56LUILIl9KWxQZ4sE3jTqvxjsHrJUn545V94B4VrAjvyube3zELgGuGZJlOlj9lOeXFjbyUaBtPnwaUkAe4izkwurnm313fJ+tsRXGEj84d3r3WzA3cZARBsN0nEqyFZquFc6+BLmpaohAu35oG3ryASqEfjM4pGwIfoa1vHe5PSox8jdcxx5qGoj6lP309z+WsYZuJVmuzA5/l/iDsrhJAE66iacLC1E5TFKD3G811M+UdmvdWTtOyijuVkG4J7gfQYfHEsJdXMBGxSeuofPhAAeibI2gcEFl8gS5Uwwgq6vcDAZPwcIwOKy7jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYpNfg2rM1ciT3wxtlyMv08/Q4ykDkIDjTQ21MX18zI=;
 b=tT4fSblRULg+mEDrJKUyPbW0SpLE1IMxTxJb2t7lKic3ZWpXE89Z1Zoe5j1dCfMsH1Oa0U8vev58GzTAfSYZtGgJdCUM8DLsxP5LNuW5rca69Orsi56PPGyICangNZRmSF9ryT+YJhIXBCFNT+MIisU/708Qd1O6nIw34Hw1kVJ7NGJDfa0r6UKhNfEmDxa4Ddje1AcEac6vDOs3DqyDr5v7b7GMc7JueJaXEvqpBvdI1J/gXGzLICS64ROv8sARDHAgbxpHVuCYXPIEbEs1cOoXqz6+5NFUTjb5lk/F5Tyx56QetkNB33RClNALu+529PK2nkVmDSLJDDFYjzrM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYpNfg2rM1ciT3wxtlyMv08/Q4ykDkIDjTQ21MX18zI=;
 b=Pcah9Xtd+/wagQsdkSuQxxu5q4eiYBWy21NUHEtTgZ09aw8mNeLHDo8xGb9v2ZERX/7Zm51TsGg0gX+r1B09rHDyxRgtdGMG4ZuUUBWCy/t42TZ7zlEi2yCq5P8M5eyz3yRLztPaKDOKTVSs2tBEo93BxNxGMfXgNEFBVRgyPAY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN4PR04MB8400.namprd04.prod.outlook.com (2603:10b6:806:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 04:18:20 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 04:18:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
Thread-Topic: [PATCH blktests] zbd/013: Test stacked drivers and queue
 freezing
Thread-Index: AQHbzALLtqOQN1PdUE6hMcTwgzbaO7Pkl3UAgAJNSICAAJJSgA==
Date: Wed, 28 May 2025 04:18:20 +0000
Message-ID: <pyhsrdrzjskxkcgj32ccgls7wqqx2x5d3lu6stefjbpt3462ud@zpcvucwxad5p>
References: <20250523164956.883024-1-bvanassche@acm.org>
 <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
 <ca5d0fc8-e256-463a-bff5-d3a52ead800a@acm.org>
In-Reply-To: <ca5d0fc8-e256-463a-bff5-d3a52ead800a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SN4PR04MB8400:EE_
x-ms-office365-filtering-correlation-id: 48a82655-458d-4e67-cd9c-08dd9d9eade2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wKnJ6p9ZxuOjbCfeb3cQ0vNXcd1yt9sUI0QRHGVhUp86lnmbS1ca3gZq3z8C?=
 =?us-ascii?Q?fvJblNBzFE2m6Ds+83L2SMpWncMp4qnS7sQ9ETM2lj9yb+VRSujFK+5xd0R9?=
 =?us-ascii?Q?XG8Gh20k/UVpP8T+NuIyfBQm80uF92n/3wTtNbehQwpdxDjCWhPORAgXp9yX?=
 =?us-ascii?Q?LVgS9CQucCC4vWCUfHs3j1DMj6WHVeE6umc+kBJxf0mEdBi0pTtwU3t48u6Q?=
 =?us-ascii?Q?yP4aM8JJsiZ4h0LT6IGN2xqXooprjYhnH7SgxDqg6JWHneoS9yMQOypiJ8k1?=
 =?us-ascii?Q?OgzqgWozCDqCMCGTwboFjf+tcKJQii0BGDyDReD0CRnGUdNlUwqjrPIaTffZ?=
 =?us-ascii?Q?93DSdtzMaHAhj39be48JXQ3aJyPf9irIJH2x7vUJUrCEQi+Wq9ElvohjrEod?=
 =?us-ascii?Q?LIS8z6H7Xqbew1THyOcyFFqKhnrdwWfM0xXrTHXhJNqKqgRixkbmLMpeYysw?=
 =?us-ascii?Q?RVxdYoYye/7gYLo+r4BASJd0Wk9g5jbifRdbkCzr69wcNjEX1okisahbRl/t?=
 =?us-ascii?Q?0fK4HGSURmhEPHHz82kvuXP+6S6XfE9YUyfZ49FQEM9a5DqqtN1w4x+wSSiN?=
 =?us-ascii?Q?6bmrPsNim0PNejf7bkIP/RW25p/8oMG1tGO9nf30JJXpDdxni8IYXavjQN4J?=
 =?us-ascii?Q?hoBB4GHPLfOVQnU3lXGCrq/W1ygpxKR0bEZKNmDDELDEVmz4F3wta5ty+THb?=
 =?us-ascii?Q?QHAYiCAwg84iv8dXR2F3fbD8UK6mjWAO6lgcKfG5lfPQecrnjCSPhte/ZjcG?=
 =?us-ascii?Q?oPSKyUlg7FfjNuYitA0cnGm32h/tjZd8dYpgnijpqJ+TsnbuC/s62owhYjPM?=
 =?us-ascii?Q?tRZyybhqGXvXb/WYVNTbOfeVHQGldKGX1jHpuBItobHlxLGOMKsrYApFUzMl?=
 =?us-ascii?Q?jvB18Y5hqJMkuQilrllSf1mL11OqUUiErFkm9fNM3qf/NxVfMhOChsgWi4YM?=
 =?us-ascii?Q?LXvSdAR+EBVEBUeqkYoqVe63Q4P9PF0wDR3Eu9+vgBFK67fLaOqUG8Sn49eL?=
 =?us-ascii?Q?a1kwFbfsqL0ne5CR60QvFcP+BeCZMbx/m1dtaa+I4mRkRo1AtsmczfmJbTvu?=
 =?us-ascii?Q?WsCSRQXyg/mhts1WrN69NbAF+IEPV/7COSK1WXPUsK1AWOnWf38pvMJ9xgxG?=
 =?us-ascii?Q?dOTWIIOgVgGPsiotc1anVDiY7qjGB2FuHsz0h9quwKa3yzeRxnkxWSOHrjdR?=
 =?us-ascii?Q?sJe6W0o+0faWFCry8OR8pN5FuyggISI1C/mVrUgZ5T4dpVYbTAeQVwbLSegZ?=
 =?us-ascii?Q?z9Pscjn16/+CSRfQI9p2ThdHH7T19dm7zfnID/jQs1yz64tgNLX4bBdSnCeQ?=
 =?us-ascii?Q?aWxeeX1rf3I86F3p+2OIdcWI374ur1QQcOyLEvMRcf+4YpMODUWkQf9Dj4Tn?=
 =?us-ascii?Q?7DOXV6/u+9qfSNHel/DpokF2vvigBsWwXBh7NrAemECPYQ3q9ptHh/ohyRn0?=
 =?us-ascii?Q?CxqRyR/wxu8dWSmyCKth2rkL5BziynE8vY0MX2Q9OVgCLi0cD0py34kXTE5J?=
 =?us-ascii?Q?N1R3L0TuCznDI3o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GamI7K6UV/b/wBlYyMQk0U42Q42lHBR5Rw1EFkk2vo7Cfgc/6nUoXMZWzOSx?=
 =?us-ascii?Q?44Kj0Bimm7BQ8AucLQG5DdXscMOqlAToTmSe8bOTyrM5EJNGRnhWSYo6L1Sv?=
 =?us-ascii?Q?3jybAe659lQC2Z0YY+cV1kEMJjq85J/XUtDYw69HllqkRw18/3v7L9UEgxfN?=
 =?us-ascii?Q?dAkhdaGt/7/9s/wYZHGJK1UyfFFbSiY9ji+x+fck88z8BRywCOWrPpbCj+lk?=
 =?us-ascii?Q?9rVgX9hmisy1GEezgDjHrXl2UYq00VII172OiqDDTH6Vb6oRrAOBB+ArCsZY?=
 =?us-ascii?Q?bDXdq4tAQEJMQHokvLZ90JTIXaNfUdnDCo8uq+DapYxHExi5NOtTvkYhGVbl?=
 =?us-ascii?Q?g+ZLmoaSZZmCcl5q0uWu62iN6Ww9xmkXp6qHwoYSZ2h7gMzvCoc7A8u5jDz3?=
 =?us-ascii?Q?hpyBjQi+md2sOR/B/xiFWV3qJE4OYuMbreREit42lIRZve3gA0LBk9mgFZKR?=
 =?us-ascii?Q?gN+7gak69Gc5Ir7REFYDKUoeH6BXvcrNfxmyf9WDfGv/Oz62Pp11A3XMZfYF?=
 =?us-ascii?Q?EPGce54a1zIZ8UH+aQ+dTIIReeN9sanKhz8tX2TTjc75BCLYye/hhQTl6fi2?=
 =?us-ascii?Q?5cBKBxw7lJYsYarssd4miCMVp+y1Oqm7WUPnWGRJso51lG4qtLLOfqhrLZcP?=
 =?us-ascii?Q?XMAH/H0hjaUDbV3yK7ZAvhKE609843AcIaiETeqo4jEGR783cX//XLYtE54B?=
 =?us-ascii?Q?RhP49nGbf56K42sPec8vkSIgshEeltC7FTl5dRW859hRuxiQlsdwop4PTOJL?=
 =?us-ascii?Q?BYnv73dFxixNWhheqYyo9WXKL4kyuScSh7car7OgAKzJa5x+ssE+i2phDuEA?=
 =?us-ascii?Q?C2VIn6Cy2HsBeDkENjnl9aqnhlBOhN0qGOwuF/ohucNHysY1LVl7R/ViLZbW?=
 =?us-ascii?Q?YorR1K5YXpzsQktpOgE9sO5Xy3D5lItHbNkGIaOY55QC0qFyBa6TwEemVq+k?=
 =?us-ascii?Q?MlgqTfxNIPNnqdQQcJkf4WgbGmwIyJ/ejiW5k+QWSbBGwOEAJzdQWTIaPedf?=
 =?us-ascii?Q?2fABMH6+7l9d0YjtroE4Z91aL2n9BnQuFKSLDOEWlas9jkDGCbtHm1DeZ0iv?=
 =?us-ascii?Q?gf3qeLMwgUzyuvDb9Ay1J7SlM6aWl0IJ3I6p4BfjKEbY0ud+ed5A52X4RpPR?=
 =?us-ascii?Q?mHgXDI91kORRrhyA3ZpcBMOUk4c0x5BPzJKS8yRzf7Vj5lYFAwUQiR75Lc+J?=
 =?us-ascii?Q?+NLqC8u8q1k8DD5grgykTWzmZ2rC+ooyBOF1Z1w0aJSF8vNfcfxfzGSEt1fg?=
 =?us-ascii?Q?ZJGRDLB0wIzaKbo0HZp3o/c18tKrPKWSJOVv8a0zXa9EKEO27IzmB9zb4ZnT?=
 =?us-ascii?Q?p5BL2wjpCO6+dvw5iIMW6+F6qW3hPfp4P3XYC0wwikyaqCsxR/pb/lj6D9ud?=
 =?us-ascii?Q?j2iTJYL0AHC+6UshI67AZJbOqDAhdQ+o5bCzJPftrvlUiOhlMztPaQiLZmuw?=
 =?us-ascii?Q?cLwbNPDNoCKcyemgIopxutyZgnuIrcdtA+YExCxs54lzKLpdi9OcTpLYpsJu?=
 =?us-ascii?Q?6P7pCt+lbUJgxqsy1kvNVXShUB9xYmXg7vxrUnRmGgsM0RHS09tnU6IXAfXe?=
 =?us-ascii?Q?agABVpuKZnzuvDkrKj9Q8QCqoaGjwT91gn1ogdCaxHlYUbeNXv6jRZ+vxJoE?=
 =?us-ascii?Q?fIE7fPQ8e77XISSyQpr6Sl4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC5579EDF156FA4AAC6478B9F13B4AB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lP0BEvLGhoBI/DesMT0qdGeHFraN4aKV8sdhsS8pyqtTtjj/JL9KVa9Pc/gYXM7MQCGq5qqkW5lOrEXLIQDoXLpzfhGyw8nTo1MVeYsOhBUZbIRFjR4fPtXfaY0NqoHiVqp7jWIhQInfVFC4utZzrXNTO0aWT2cePcXRFYfDvEXTNFAlwVcITAfXfzAjMh3SOD0up6ZBYoTg0axhWfZEaCoeSDU1NKcQBPze7wcvt3ndjUqefcqgaExrFuCC2TMEsrHHRRwdy246LCfNHTPTeDoHm8tDbLfh767mNw7Eh2yrW2N4NrJIwVUnlbn1CN9gtY9EwVbOeNdkfxViPxTM/SFJ6S86lr6Q6NmcRStLQBf6Wn5Bf18J8v5uWLYV0/9tvycpaCs6yCQDC/nVAf17HDjLa0fYq659kx2j5Z0j7iKeq7UI+ygYoZXxOyOflHb7BL+rsYG8i6UnuCll9FPUs4DN+0IklrdPd4TIYa/o/5zq+Cln70ROCrFIV7D7JO5Zvic4x2o+f/cFLXRyGRB8RZy8EzVHGXx2zvm+pfUXq1DspljAFHU3IOG+3h5MaW6GyCNl6ayFs8m7Ficor9PaMld6PHXDj3e78Vzhojm2+K1xFo5S61cc0inrH3m/Qq43
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a82655-458d-4e67-cd9c-08dd9d9eade2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 04:18:20.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qipLtDcuTK3Ljci2QpvFhWSwEXGnWByJN9tou78rQxfhKx9P5zwIFEKsaJfp/t3QNZypZ+JOhmD0+6gad88CDAFOG49vvdu4xyULkI213fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8400

On May 27, 2025 / 12:34, Bart Van Assche wrote:
> On 5/26/25 1:25 AM, Shinichiro Kawasaki wrote:
> > On May 23, 2025 / 09:49, Bart Van Assche wrote:
> > > +	_init_null_blk nr_devices=3D0 queue_mode=3D2
> >=20
> > This line can be removed by renameing the null_blk devices as follows:
> >=20
> >    nullb0 -> nullb1
> >    nullb1 -> nullb2
> >=20
> > nullb0 is not recommended since it can not be reconfigured when the
> > null_blk driver is built-in.
> Isn't _remove_null_blk_devices() supposed to remove nullb0 no matter
> whether null_blk is a kernel module or built-in to the kernel?

No. When null_blk is built-in, it creates /dev/nullb0, but does not create
the nullb0 directory under kernel config directory path.

> And if
> the null_blk driver has been built as a kernel module, how is it
> supposed to be loaded without calling _init_null_blk()?

_configure_null_blk() calls modprobe to load the null_blk module.=
