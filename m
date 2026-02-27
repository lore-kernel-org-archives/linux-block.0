Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79E33BBA4
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176336; cv=fail; b=eJcrt647EMFGVh0FiRawURK4K1/G+R0ehFAlT6h2bgvCxyD3lQmyTRDhjZ+5BuksykyR1SaHojJRISegqJGS4Jf+uL3tTBUmn/ctXZ0ykRRyzkdp0ca769sxeAq0LfxJGuATVzcYbm75J1rJwuSWNrSMYwfMIa67keHpr3G7YXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176336; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I4P4tC4vkCT/BWYU2olY51tYBX8zLHXohLzE+O2tXkL0NF4ULE+fMkSBl/eyiG9Fwt7AOBtaTigUZJM6Hz1mI6be5xzGksfwmHu2dsA18PY53jDagyT9Gw6MZk20SEroQj1V1BnniJpwlKSafX5X3yf4EuP1wkz+YWqiF6lDjN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NKM38ARU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mrDld/2K; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NKM38ARU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mrDld/2K"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772176335; x=1803712335;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=NKM38ARUVdxeFfHf6q9iuS8lIbtlG8+vAU25otpsBWgKvJiQjiqhzSnT
   zQZ6+Cum2cqp9Owt105HuRSEn5ycmx3cjVnf7hrfZxCfVNQUHyLV2aQR5
   sBbC6TQQvUC3qzLN1cntlZq+UReo8VjP343enQvejFvkC5/ZBPJL7OR6G
   bilSfz99+jdtwoCU6DPN/Uy4nryjQ6p3PHfnBFNmVkrbriQZ610VU+G4D
   PNWqIlUPSk2Nl5wXx3lZGxMl4aVH+L9jMcNMKq+eBVf55RYDIh66wsY+m
   +Ft5QSPuO/fC8bBTk4ufAsrs2xWQbhDE2dpOOH6xpHi23qJA2kUBUwIe0
   A==;
X-CSE-ConnectionGUID: 1aQW8al+Tl+rqsP2nBqp+Q==
X-CSE-MsgGUID: 8N+Q+AD5S/6AB4Rg2cHaww==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="142125522"
Received: from mail-northcentralusazon11010044.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.44])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 15:12:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU2VL2mzBJdhURmjeKxbC3ojS7LxeL7UMOqcdNxapQBUWmyHAX/Xk78gB5LE2iNMD08b0/PGDFskYbhIalqYwnRRsW6jvsVp+OVQcgnMkBjLXYMNRojw2kSv4tJFBlGhzyg94e0IQvtaxS3AMN97lSC/0vOhxfcT7d5w/FGCwC1IWEV74pe9xk1F2fFO6YUQZ3g0z/lcEG6v9w64TpUP1mi6OLWOKUU3pg8QHP/1DWXDBD6Qf8EfJuN8Ii672tO0V80lb2kfSh506d7CA/nZl1eBiC07yYA4eZ5ZiO4L3VV2TXMisQu5Ff4ipCPBRkLnuzsvjeJ/nkyC1Jp7c7+iYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=w1K0Qg5Zcri7Yxu8KV9Ivq4p7VRc+scojGIZ2TUU3DX7G9tGqPT3iXF5E/j0PLnkhAgHWuXE+vanni5ouB3CcMGgBsmW/RQoda2fQpIhR1Ae3tirLZmks5/jjCn5nHevv/ftDkm0yrgCy4uMDmoXlrxomhpzkYlLmeZ/qohiAuov+kVkMJzT6yy9RPvrrAnJCsiP4LEhibOFgYIvDqh0/KhZ70OFT8MmWhm8wgzPDHJqV8u8BPxHIaM9WCAxZnY0OeYkbsZtUfvlYw5vJse8jKKrcSMJ8wpaohFcOXzUU7lj6G65uoNo368YK6umnVKlOaJg94y6Mgs+41A6uAQLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=mrDld/2Kll8edYvM+DfIWXQDvS53R87VP8A/3YR9AcYs00RN3cofhIDva/KyJCPJb2LtSUjM049bR2kGl7veg6m2oCHwVtaOULtCgnomnavCG/du9H9KL+4G6u2O/3+mYlQ40XxIJSUsVgn65aDyTypK+IYJe/HHjC3QcXpuJoA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SN7PR04MB8601.namprd04.prod.outlook.com (2603:10b6:806:2e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Fri, 27 Feb
 2026 07:12:12 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 07:12:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] block: fix zone write plugs refcount handling in
 disk_zone_wplug_schedule_bio_work()
Thread-Topic: [PATCH v2 2/7] block: fix zone write plugs refcount handling in
 disk_zone_wplug_schedule_bio_work()
Thread-Index: AQHcptaaI9Kxadt8uEmGB0B3zJYQrbWWIxuA
Date: Fri, 27 Feb 2026 07:12:11 +0000
Message-ID: <f378d4cc-9be6-4e6f-918a-4f63a18c837b@wdc.com>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-3-dlemoal@kernel.org>
In-Reply-To: <20260226041024.2154806-3-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SN7PR04MB8601:EE_
x-ms-office365-filtering-correlation-id: 7a49a1e4-fb1f-4c6a-57e9-08de75cf872c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 pdi6b/KAmnfg8gXOTrHrGnXjSft+xLbD4Nt/c4FHiboO6yC2ihEZ72caUQZ68XFii16aPy4K6yN3gD5lkp9HzGsB6dCFN8qwg2h6owiLCJQXrGyaiRuLZKJf1QMDqX6iyv4en95GNGvWTnyq1jPgIqe9CeRKsSSEKBnCFwt0jDIgCIaMc1/skhYzTKtW3CCtZDl6LPTrgY9jnw8TjSK29Tlv2YhuPYUNWb4xXkk7WOJDUdwPqeI1iH55gjhouTq8m6wQ9UhTq6+aVaNhrRq9DebNrfZUgPwFg2F0fqSYHl9ihjxXLDQABliww1/LVvBGwDcp+NYbIj0JwrKYUWlqEvUUnRo/p9Mvxvu4ofLVHDBaHNlvza0X+P0aGgIqWo33UsWym6OBPRchZ+pnhKf3zIiYh8oyLq9O0Evr5QdStd+7kEqnHmpJpyg+LIjPILPPPmb02zs3r5StjF833vF7wqaAXBhB/i2BEyeQfOkD5HXWjeRB1uHj82pxyyiYqhdnq4qy4aiWwaflBBID+B30+aJ6+t98/s34bcJRXrZdBRKYMHr2e5DNwdv284jsrOSW/kN+OTPky5t1fx6tXXXaOPg5iQdx3mUabFFuvJgO+KgszR8Ckn7KTZAehoqxqXqYXgUIJqYhe0S3qHRtSnjhPMC4XvUfg1bjnf3uSuCR4++831OtKLpOTx80CdSwqSi9rGzqgHTDvupzt9FcRw6ilDk8CfBi6Ztdj3WMsnph0P2VneYKoxHEJ5XGD0j5u1lFQNEGRDya/omHHa+tvMuP7hJDlotyjLhpkEHwD9QhCHY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dCttQ01laXdqS09CM294alpYdEFSN2M2ci9rVkJVS0xnVWhCRUcwRjJ2Ty9i?=
 =?utf-8?B?ejF5QXdQRUx2WllnYkhVaFQvVDhWTmw1RlVjdnNGdnp3c3lIRThpTkVUQys4?=
 =?utf-8?B?RWJCSnUzV0pOZ3kwUWE0MXVBQ0JPZWtaOWNCL29hNzl6a3VqL3FHdkRqVi82?=
 =?utf-8?B?VnRnUXNlYWs2akpBcTlQNGJ1RTVlV09TdjJUVXN6U3BqNkNieTNxZVIzQ3Z3?=
 =?utf-8?B?eTNRdHJxbFNOTG80bTV1VFFLV0M5bjkxY0p5emxuZ0RvVWtUY29mZUZxYk1h?=
 =?utf-8?B?YTNGTm54K1NlL0Z1MmJvMUJxUGxEQVZSTnkxV1ozd1lBeUV3YmVyYVlKMkVZ?=
 =?utf-8?B?dVVuMXZRZ2s5WjJCZG5sVTY1VWRuWVpEa3dBeVZURzZONE4vN1NLSDFwOHAw?=
 =?utf-8?B?QTZveWhzU0JJR3RKMm5QZVVwNVRlbmhBZG5id3NFQzFjcDJ3eGxVV3IvSndX?=
 =?utf-8?B?OVdpbnFySkRTQ25qaE53R2hJbDdtaXQwK25ockl6ZnI3QXF5UWN5eURsQVBR?=
 =?utf-8?B?Nk8xMXZPQVkwSStyRDJCYTF1VHdnZFpnS091am9lTnBqZ2xrUjFUVFI3TUQ1?=
 =?utf-8?B?cWkzczJHUXl0K0U3ZnFuSzBkSVhyblFRaDJkN1g4WFJVZVVXMXVHanhzRkEw?=
 =?utf-8?B?K2RRKzl0WS9BQ2V0WDNkSm94dW1LVG9CSkovYVZlMzUrWTMzRWpuTUdvdDFH?=
 =?utf-8?B?V0hmNzBvY3EyWGVIMmFKNkxtNlg5eEU2WWFVL0lDdHFMZVZaWHF4RjF4OVdQ?=
 =?utf-8?B?bDI2OVEzeFJndVI5clMwMURaTEszRDRlSnMrcFR6Q0pDdk12OE5jL0RJeHA3?=
 =?utf-8?B?NFFkY3AvQzNpM3VZRW51eHlXUUtzdFJjMmphd013VEwwUjAvcVJ6bFUwL05J?=
 =?utf-8?B?ZmlpdUNxY3YvRSs2SkYwdEFUZ1RVV0NEWjZuSWozbVZxd0twR3dKTnN1Zjdn?=
 =?utf-8?B?ZTNacCsyNnNpRk8yazR4dXFWRDFWRld6L2h0TEMyM2VrR2d5NlE5UGU4Tm5O?=
 =?utf-8?B?OUtPbjMrN3pRd29vbWx3VGdncjJWZEFLRTd2V0trVzRWSXBQNXVGSWFKQnJO?=
 =?utf-8?B?eW1tZG5XLzVYajl4ZzBSV20yNXRGTUpQc1pzcXpPTGtISzM0Tnd1eWNxWjE4?=
 =?utf-8?B?SW1YYmVaRjMweEtNcitlbkxJTER3VmxTVVUxTzloTjI3OUtndENodmJxSGNG?=
 =?utf-8?B?bDl6NExWYm94UFF6K0htZDk0S2lieHpQaXJiSEJ0UTdOaFhaZVdTcXVDbTdR?=
 =?utf-8?B?eERhbHJhRGZ4cXFlWjA2TzBmTGxmSVVhbTgvMjk4Q21PeXE4amJmQXV3a3I3?=
 =?utf-8?B?S3JWSlgrTW1lcEpSb2g2ejE4Z29oSERMS25PSitMT3FHT1VSVzNJMzVKYkhK?=
 =?utf-8?B?Y09TUzVra2tTRXZITlR3QWpaVThXMnpMNGloVWczcHdaWlQwa2NqTkN4Qk9U?=
 =?utf-8?B?SnNhMUY2VmxVQmozSXdJTDdXM1R1U21HL0RjWmFEYkpFRUg3NWRrUk8rVU9U?=
 =?utf-8?B?ZEtHcUhUa2traTBzSFkybEV4VFJKVk5nK0VMSXliVE5IREhwb0x1VHArdDd3?=
 =?utf-8?B?VW1ON1hvb1dncThEeXVBdGlXY0NqRm5ybllTNDllQ2xVRzJpenNMM3UycFBC?=
 =?utf-8?B?MVVQdmRyNkZPUjE0WGlVOE9VYXZvbllsNkIva1p3a1FyaVM3RDFDSjFTdXJx?=
 =?utf-8?B?ZkwxMXJuRzA1OGQ4SHRjSmxwSnp0azM1ckVtbFBiaXVDeDgyeXJSWDNsWHg0?=
 =?utf-8?B?RmFnRW8wQWJrbTRQdkNWMGFTdGI2K080WmZ3YnozeUJOSXpkVGdCVGRkMFpX?=
 =?utf-8?B?TmNjcVR5UHgwUzdBay9FUXZDVjRLbkJ6eHpTdlI4ODltNlUzRnpiR0dZeGND?=
 =?utf-8?B?ektrWkFoY0JGTnNSdk8vYU1qSUNOVy82VEx3RDdvVHNWSmhuSHV1U2FuZkx5?=
 =?utf-8?B?RWhwTlFSdXpsbGZOanBLaUQ5NURLZm84WDVzR3B6WTBwMUlTQmIxKzFHd0p2?=
 =?utf-8?B?aUpBQ21VYWpuMVMya2RrVTNkenpOOE5ybTZzYzNZZ0ZjK3dLckljRWNLaUtp?=
 =?utf-8?B?bU0vV1VET1h1S3lkTHFMUkpacWMxSHJJM3krb3BTZnMreHpaMlV1TnRHa0FE?=
 =?utf-8?B?WnFvc1RFSm9NdUFyekIrZ3Ria0hIc1VnOGI4U2ZTbG5Bb2VXcStYUTNvakNO?=
 =?utf-8?B?aUFWWFFQNThSdzdBdjc3ZmllZVZ2RURNMzRWbmVtdURIbVdHcitBbktwNlVT?=
 =?utf-8?B?QkNMK0d6c2p2dGdkSTNFRDhheDNkLzJUUUczVVgzS1VSdExjdHpBTUxpcVNk?=
 =?utf-8?B?ZVlvRVFZdWpYQ2pUTUsyUkJVUThnYnZvRWo5NXdCb2JPSTkrckxvc0NneXNm?=
 =?utf-8?Q?dmrVnlQ07vue7MWfEYGeqoXjDq3M57Ke3N+pZJfkyFNLm?=
x-ms-exchange-antispam-messagedata-1: Jbo0MPNkWJA6u1I9lF4AaSjexpRI3Po2LU4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C94A5BBF676C342873CB51E7CC3D2E5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U5pS2+y8jYgRvkoUBjdfUblqMmC3YhND1S5CfQC2bxPg/UUSjXAOIXy2MAXUkFq5H1z0QzWaP9GTwGxLGPKOU+RpMFKYM4fnt09nQgGGEMyn0Bvwq1HKH1tmXyt82r+PfD/V3kHnSSAsuTYv9WsnWW1gfjG5ZtOj8hBEfuIOrHG8E2zksSRS0C2mNNUlCfM3DKZHuiTw/+cqxsG8g17rtezFQg52vI6y2j1rD5TbuR2fhIBXDcqbdePr7SeA9dR32ZPINCt87VJBD0bckXJ6H9UtzyuCfXuj/wciKpnNYtA1rET8dLA0siWoDUxpfj4P74Mzt0Ps9ajyOfKhko/LkHzIoxwXeBmu8gsLjUoJECwAqiEmre6/LE+YRwgzGSzh2qZ5/b7y1FtOWgVgGh05NQnkM2vRJWG39nsasUl/Cn/lGjTo6EyD6Q2jiDAtgux5g6rTqnkRHd7aH/SkArvFEZvXW2ZHhPZrmDQFybw7bKuqbAjMMdyMWXwTHMUQhoXRZkN0iBQO2szKm8VTJCc/mgSc2PMgNAhhmAXKjr245Xl5R+PIRbbKavBCz7Ut837osp3z3ot8cslnMwvVeJFk83R8gFT+Di+8ULT+nROs9vS8XwheHaHaq4ePuI5lfXyC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a49a1e4-fb1f-4c6a-57e9-08de75cf872c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 07:12:11.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNhhRGSzdwNWmX7GFwZsAmkr+hwZqUT+nBdZbs1qDfcBUELCuAPJlRDXLBC/mhoR4NWSrSR9to9iKRhv8fCAVwQ3iPfVZZqKKZxL1xe9NbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8601

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
