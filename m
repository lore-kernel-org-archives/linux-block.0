Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7421CFEAE
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618676; cv=fail; b=aSDiExKry+EpoDu1YRa/7f3yME9VdgmEhbh/IcsNelWfnbGzhdT+FdD0HDJAhThCQ+JL14P/CG8DWpM6Bg0Y6Z0XJCcjLRu5j4OvN2N5B5stXZaPN1b4/3HIZ+oWP/poRv6h+iWo9r188U1uKGmij8kg7e5cKB85la28eJ3gJsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618676; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gvIMQDI8xnK0P94f9GfwkxyfyLjWEthlc5GnhZ9D0/7Zc6SWpaPt96rsaqDmL5s//xEax87ZPq1Sq22xt27dNqmfAmwqKzk75Q1Frl14db/OCFbKmXbavUx9Z16e5R2IEdFairGRomsNtvCo2xWksLu4pGmRU+fgFXC6SwVj9tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lef4YEsB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BVMb71xO; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lef4YEsB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BVMb71xO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732618674; x=1764154674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=Lef4YEsBPAxRyBK5ARcNmKl5R+Zgh9AVQABcZKTLSEdfYnqTY+04m01u
   dVGKGfA6CJoreU4GnoRxdFdP9ANfWsmywmlJCM9Cz+38bbwO3lE1tEDOB
   QIedQ5xFYtGRTijwVywHWiD5ddRw9CyVt+xD/nLzeMnctyNwS6BAjR40a
   MpLkJy/wbKbIb2LMRT5CAdnaoyHZiEbUfHf6ssilCDZk82l4W2hXphwOc
   fKhAaWtHTlkCDdqYMsPCTYh7jKmRliAtHZ8iNJf4S9EyIFqixSZfJbvgh
   vG0xz+Lw3l61H79KJXIHkErruf22oHRet+I3A8Wp+B03diy2OZWjSL0BH
   Q==;
X-CSE-ConnectionGUID: OUe9vDMRQ7GC3KgYDtvjtA==
X-CSE-MsgGUID: g0W2jJaHT0afgQvSpda66Q==
X-IronPort-AV: E=Sophos;i="6.12,185,1728921600"; 
   d="scan'208";a="32917760"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2024 18:57:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdIJY5Z0k9FOBeCfRj/yMcgfhkVgNrKRs9RdGMBNzvGivtltqYNdz9JrVqpA2S0ovgAOqFQJ0hO/K3t67W3PVcz0qg127Lu5DvqrI5RGGKqkoXLjFHEM0VT8/Rns4TYxD9PMuDxmhrkxWNEK6HQHNlGHwtAgcza4xsywhi8vqKEzEyckl8nrXVNVpzvTO8ei2a8SJwUi1dukRB2BhNQ+5zDdyAYh5PE/K6ssfxsNEhPuwR4vgnOZzwl43qjsSCqeYF647uOogZwJBQRaPab667yqdAy7aOQ8owkQlt7iKBp8NWc+qROKQ3lj5luWQtGexLxzL8l4aSMgO6Xe9FYGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=c489RPQMxNNP3eQMC9mAWDoG1sjhNQHeqnDtUECEXjjASEwgyBCJ4yP7OxxxQTHAM46IH4r+5Bbrx+ok/aE7TmP5cIxtduO7TIS9/kTemOh5ufifUu/7iJbE9MzKebgFO58wPmXYTLtfCeYlejZt91kT7cjUJa0X4wR9QR3cvKrm+lRXevw3W+jm8ZbsEoJq0JeLe/23bunLdnsnSkvkVhC3MIJgmHbqVexUj5Rz+j5LtKtmUPOtQ/8cgQHqZPEvxDP+4Y5fS0ycBcZBLfNeV7j5ObyB7QrwZq5GEtxjZ+onsEaDqfL7lRsfvW6rgmKWVTPKPdETmH52t8Gc+WzxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=BVMb71xOj8yzG5k69y423KwbzdmZfOHwg7EmHiwMNXboh3D4E2y71QuUB8FwSnR46lVoHWfb6tDt1aQkW1PAYMHknwwOF7lv91ysS4WET0q9q9ewTFx8NjywVLPdQId+nzaNK1PIWk65PFxZw6EkL1OdU1wf2AoquwfK1C7uTZY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7861.namprd04.prod.outlook.com (2603:10b6:8:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 10:57:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 10:57:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: hch <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] null_blk: Add rotational feature support
Thread-Topic: [PATCH] null_blk: Add rotational feature support
Thread-Index: AQHbP5eXrLKbmhbJy0u3dCD6PA9YubLJZNeA
Date: Tue, 26 Nov 2024 10:57:42 +0000
Message-ID: <6f19e0f1-93e2-442e-94ef-3733597c8448@wdc.com>
References: <20241126000956.95983-1-dlemoal@kernel.org>
In-Reply-To: <20241126000956.95983-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7861:EE_
x-ms-office365-filtering-correlation-id: 23a02dbb-2943-4b0d-b5fb-08dd0e0926e1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmM5U21PcERFM0NaSmNBOWFwNnZCaklXM3p2emNNdVFBZjVDNlZmeTZNYkFi?=
 =?utf-8?B?L2tJVEd0OFNjT0dScUtjMEJmaURDei9ybE5JRFY1NmdOcXgxN2l5a1NyTzFr?=
 =?utf-8?B?QVFRVkVhMFgrZlRRbHFOMThrazREVk80c01wYUdUc0RGYlMvWlFHRnhKVTNu?=
 =?utf-8?B?dW4zKytRZ3AxY1YzYkQzMmltVUhCQktRU3hUNGplYWUwWTUza0k4Rk8zZFo3?=
 =?utf-8?B?NTEva29aMzRSNXBaOTlYcWVQcGoxSlI2ajJ4MWFsOWhDVURpZnpReUlIQ0JI?=
 =?utf-8?B?SGxDdnhJUTN6MGFQbjNPUWFFNGdUbG9aM2x0aXlnQUppVDQva0N5Qi9XQVRF?=
 =?utf-8?B?RGltSktxdC9xcm4xRXJDdkpMVXpqWllMMWhmNU5UbEMyc3NqeWRoNDZQMitw?=
 =?utf-8?B?Vi9JZnNCNFNPVTJFR1h2MGYvWktheTJSTUdQQzVqMjJ4VUppYlg5VXVYd3hj?=
 =?utf-8?B?clZKczFBQkhZL2hteWFtYXhGUDlhcXVDN0pjTnlwVE9zOUdtU0g3MitkMTBE?=
 =?utf-8?B?VmhJUHBmWEw1RFhYd1BQTllxWmlka0xlNndGSVBRWlF0dzBMQXM2UlFVWGMw?=
 =?utf-8?B?SE84VEFHc1BQcUpVRFZuSCtmYSt1NEFGNnVXMXJCMEV0Vnp0WHhXT1IwL3Vy?=
 =?utf-8?B?bG15NWRiTkhlUGZYSGpET1I5ekJxZmhxZS9rcTlyczN3dXpNK05Ud1BBbFBM?=
 =?utf-8?B?V0NBc0Rpd3M4aFJSbkV4SGNkMkt0bEZkMnZvczNBVzRHUzErbHRjRGNVOWdO?=
 =?utf-8?B?MWdkL3RIKzFOU3NJa0pCd0NJNlI0ZVpVK3lUM0xZc3pGcGFjUGtubkNGUWlP?=
 =?utf-8?B?N0IvQ2t4MXR4bFdaWFQ2N1dwNmNQZ2pqMDgyTFYrenJkTVEvT2h5ZHA3bmgv?=
 =?utf-8?B?eXZkdCtzWXNHN2lTM0x1ZGwyeVdLRmpISkNhOS95TWZFRGYzK2ZqZUVtc0ts?=
 =?utf-8?B?Y1ZNYm9EM1lQOFJyMEJxcFdvNU9kTmtrZkNQOENETlUxK2tWQVE0Sno1b2VD?=
 =?utf-8?B?YWJjMTFURm1mczZSSUdiSGRXMTFJcFQ4NlR0N212aTdnZFIvMFZ3Z1VmeUFM?=
 =?utf-8?B?K3RGYVMrWU5oMjFIR0pvN3JmbmpzeEg1Z3VqNUR6S0V4ZUZ6MUo3cENhay9B?=
 =?utf-8?B?VGNWT2Myd0E0Tzd2c09TTUE4N1NQVUhzb2RjdEtVUndPaXpBRElpc1l2b1Bw?=
 =?utf-8?B?cjRsMVFaVUxTbUEyRlhjYXB2RnZWSWZyTEV5T2h3ZVR2WXlGakdyUmZTeCtv?=
 =?utf-8?B?c3JPY0c2UVZheU95Z3NLaUNFa3NqRisxZVgxOTZ3NGQ3cHhCdlRsb1lWOXFZ?=
 =?utf-8?B?V2NsS2F3UUFCNmpLQlBFMXdCTGVhbnJLL0d1eUsvSFdxMmN5Y1JuTXZES3A2?=
 =?utf-8?B?SmZ3QlZQdDE1VUlGZ3Y5YVFGMGh2MWdsS3NuejJpMkk1TmtFTjE4QVN5UzFV?=
 =?utf-8?B?ajhuOWs2REd3VGFzZVlGUjZ1UXdxeWJwSm1RL01pNHBkSWpMODZSS2U1MmJz?=
 =?utf-8?B?eEYvQTMwTGVCMmx4SUJtNjNCS0ZNM051Y1FJbDlxNVZqOWZ1Si9uVjNPOVFw?=
 =?utf-8?B?dFJDeUZyN2hscnpVd0ZpaHhzTlVweVZXQkR4RUVzSjRqZ3k5Q012bDl1U3Vr?=
 =?utf-8?B?QW5zZnNFMHhHTjN1UDdtYjgya0c0TGtzbDBqYUd6R1ZFUnJrWFhORjNvdjhB?=
 =?utf-8?B?VTFhZVNQVktQTWpGWjFEa2htR24vRG1GaGdnSzFFSHJBNWphZytid1g1YU9o?=
 =?utf-8?B?MmlrOFF3cGR5aVZNREd4UlZ1empuYzZjenR5U2tJMTcwcDlxbU1ZSXpxRDVl?=
 =?utf-8?B?N3R6ZkxSb0Nrdm5oNTkwVTRPRzlrbXduVCtpZ1VaYjZWd0Q5ZUw4eEFtNGFp?=
 =?utf-8?B?VVduTVN6NUVqWVVJbUJiZGJoVVp5blRrTkdUc1pDc3hjcFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjZ0VzdPWDNRZlpZZUtWcGtITTVJdTRaSHJ3ZTBaRkx6MVR6cFhQWjF0QzFX?=
 =?utf-8?B?QjlvSEpSRWcyWEQ3QnhkYk5zN3BFbnAybnUvQ3JYMnNlSU5ZdzA5SjcwOUtw?=
 =?utf-8?B?Z0lTWi92dVB5NEk5aFpXQk9WRzdkWU1qSTJSUEJGK09SNG9yNEVhYWo5RFlH?=
 =?utf-8?B?TmcxNEZlWmZoTnpYK3kvQWhkR3VTQTg0UmtxODhIZHhmQW1lWElGWnEwYUcy?=
 =?utf-8?B?MktZTitPeEdUcUNsMkVucW9FNXhBbGNWWTFjUUdqeUJYL1BuQVJmTGxXMDRH?=
 =?utf-8?B?MVdveWppYzAwcHlKUnRzUGRZWGhFcU9TbDVTTVpRM2Njd3RsZi9jS01OZGxX?=
 =?utf-8?B?WjBoVWV6K3YyY3ZWU2xqd2hqSXZXSitEeW14eFV5UHFQclEza0F1MG9vTU9N?=
 =?utf-8?B?cnJTd1JDK0hHcmYweTM4azJ5YXBhTWx1M0tEcVYxMlA1WFc5dTU5MGdWK1dK?=
 =?utf-8?B?R3IxZVFsUjVIRlBiZzJ1ME4zZ2s0WXg2Q3dvcGtrd0htZ0NTTmtNM1IydEVy?=
 =?utf-8?B?OFJSdTh1Y2NNSDRlZWRxOUdFbU9uNnprL2ZCTUdRbVMyOFJxNVRQcnI0ODFV?=
 =?utf-8?B?b1E2cHBMdGlzRGk2M2RsZDYrYWpPZlRlS3V5anA5L0xNOTZVejI4SkxRK3Rr?=
 =?utf-8?B?SE9Fb3A2QTEwakNlZnV0RG0vTU5uUjBrWEVmaHUyQmtCbSt6NXlJdUo0bWJJ?=
 =?utf-8?B?bFBwVTAwR010aHJWQkZuUmRmMjJPWmdYU2dZUEs3OHBYNkkzM2Q3MzFaUTNO?=
 =?utf-8?B?c1hEemcza1VYWEJOMVA3ZWVvblRMQk85Um9MdU5JeEFKS0ZOMWYxZ25ybjRI?=
 =?utf-8?B?TlJrLytBQUZpUG92ZStuazg3SlZoS0Y3ZU1SVUhWTmtxUkY5dzFaS3QrWEh4?=
 =?utf-8?B?VDBGZldHbXFyKys3d2lzdE5yTS9RdHpwQmRPM29xLzNhc3VnYkh1aVkwLzVK?=
 =?utf-8?B?LzVJaGdXK0pvelZveU9iVkdHVnQ2TG11NzB6MG11RFlLSVZmeFh4L29COVdS?=
 =?utf-8?B?My9YZXJPZ01TcnMzNHFOdmhqdHF3bGZVNkRUUlFvVjVRK3U1c3ZKOHdGbmsy?=
 =?utf-8?B?ZlJrMDZKYisydS9adGVHNlhBZDRObm5RMTFUWmNYWVBQM2taNlJLaFFLYXFI?=
 =?utf-8?B?U3E4b3V1cUxWWTBGSFQzN0hiMFhFeUFIVkN3RHZvMzdlVUkzRE8vVWpBTVlV?=
 =?utf-8?B?NWIvdXNDRnE1SE5lNzJpdG1RUi81VDA1b2lRbU9na0xxR2FoQjNSNlFjZXNZ?=
 =?utf-8?B?U1l0cW51QVNGa0U0ZklPb0NKZVU0MHE3Q3lCWmo1QXhnU1hOd3JaaGE2bVFv?=
 =?utf-8?B?aG95SnhWMmZlaTZPUng1Tk1peGdCWSs3NDk2TnVwbW1TcU9mVnRmQ1NxMGRr?=
 =?utf-8?B?Sy9uMGFCMTJJWW9udlBhcTIxQUhlWUViWlI2c1JlOWlIYWtTdm5VMHpMYUN4?=
 =?utf-8?B?ZnVDbjNJZ0tIN0pqV29RekxOKzdYZ0V1WGJYYUtJbUYyVGZyTjRscTM2bVJo?=
 =?utf-8?B?aWI3eUdIcDVEZkNEL3hBR0FkY2dQaS9OOGdBbE9QU1EwK3dpb3pRQVpINlRX?=
 =?utf-8?B?Y0ZRWmlJWnZLMlhUR1lnaWVVRmc3UTNLb2dtMlh3S21mOVNWU3VTWkhlY2VQ?=
 =?utf-8?B?bEtIVXlPZlZsVzFvVTlUWGdVL3hJS29MRWI4SlhMazM1VVdkSUJHS3VVQWNr?=
 =?utf-8?B?endTVjZzazNtK0R3VjU2R2tQcDk5RHliTHF2VHlxMXBpVUZTSTkyTlhEdjlD?=
 =?utf-8?B?OXBLTXZQaVJ2czVDQjdPV0JMVXBXKzJXdW1kTmt5c25KSDc5REMwckFhRXZN?=
 =?utf-8?B?TzZOMnBGckFhRWlsTzR0ZTdJeTh1QVgrdmc5dHp6U2UxVjNTdVlvclN2WVBN?=
 =?utf-8?B?WE4zckV6NE92YnBsR3NiOTIzYzFsenhsRFkweW5HWjRWdVpUMmhIQVN6N25n?=
 =?utf-8?B?L0VhR1pjT0hSTXVOSHBEQ3pTSCsrL3FiOWRNZU14SmtSRmxzZ1VITW9RY28w?=
 =?utf-8?B?bGpPaHc3dm5kWU94WXQxdWVzRFdKcTVTSkRFWDRZMnBsbDFOS2ZsNTlRWHJY?=
 =?utf-8?B?V205MU1yQXg4UEtSb1B2NzE4d3grbG9JNTUvaXVZT3ZELzViKzJDVU9tbEIw?=
 =?utf-8?B?WmdVM2dNTE4zV3BTWlhZS1FrdEVJYUpLU0pjQ0dUWEEzRHdoUk1kU0tpSk1C?=
 =?utf-8?B?ZFVMSjRHbGJJbWRkOWNJSG1zRVBmL1Y4cElucWhGWE1Qc1dodlkvQnlJVytB?=
 =?utf-8?B?NGczQlArNjYybGZSeEFRQ2pDblpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA6A43D5BE36B3428B7144FA893FD7EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EiHqBJ69FCLI0mgaKvvH8AsCUBI0VF7VVsJ6PCAQd4CNVwc4V84Xlnxx2q8bzY6GmTizB0DbVkFOOuQ9Ny8P9e/I6b8sZuR7BAHOg/NSj2B4pCnJaoe2Q6EHVCPhuI4D8sZeYvjUDAZSraL8+Hq7RGYw9YfHhTsmbX9J4s46rrkwbtKrPmq4L+p226UiFvb9isaeeX0MHUxRF3vlQhehg8mVjZ+Im7vc+KjBr3y38yPJ5Ez+ZCbFIPHrXhY2vFmOgQ1ye3kXDNB9e/d6ypo338holZ+z3z7qbPUPbvCeQsefJWS3cK9mZ/QZdKxAG1kOK8lMRs60P5q6DMVqLMxkfUxLXP9HPuW2wakeR42OUqjXKnQfTtzMSYh2GpI3btHuQf0xN5YhM/ojoXryI93ox3meoiFNr21rnbg+l2MxHn2BA+hvMz+io2B6kWPq/TlMIqBoe/+vdPk+ybvGv7Ui14rn0XOUGDIMNxmqLS5oGYuXSB8PmcpfMlzCZvrTX+Ttcmo0lx9ZTq2KlVu+CFu4ImyZBcZ+RAMPXcjX2D7ffKIrANuO5J2hOlVWCR/wHlh2lnMIDGiNbTuilYmna+ixRP4YInzXLKt8blnWWUt6OISaGGRqbK3u3FcQhnTmXvR6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a02dbb-2943-4b0d-b5fb-08dd0e0926e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 10:57:42.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R5AaJD5RcJ5eOePbL2rjXA829EV2IeqVijv7/OE0b5BEmMLgpDuxLrxr3TZKymA4S2zdIjIPll4OkX3+u339CQNp0jMMV5kug27KB41OAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7861

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
