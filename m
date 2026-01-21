Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7119CD05
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959496; cv=fail; b=AsK7p1eA1h3mb1Vnsq/lAUg+q8wLNZxi6lU8Fb02KL4yIsxs86OqEtIM6EIqEWRM59mweNeYIyPIDFDF3xkzIyjZ+D+JEZYWBgBsB8Z5p6/GOv7YNWG69/GaqcFqBP/toOsjC4YWkUrjA+bKdpook8wZPuLUe76/DbWXLGLvRx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959496; c=relaxed/simple;
	bh=zJEIHLHWqD2AIHGY/H+bW95jICU17y6B8/Z3D4m/jU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vb+a4+l8IV5l0LR9c0L+1ew1sB6zkt7zEvub74/mVQF0G9UXryQmM5mmdDH2F3sp/gh6FaZKU3fFsDjXE4nL7EFxOA6WnIIy2D2xTs1YALTxedXWGdYWKPf0+u9bwOQc0xxbACAqtLjM1Lnp0J+p0oFhJaeX/TCM3LiwSoEZxY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h+MIFp6l; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=h8xp8l+E; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h+MIFp6l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h8xp8l+E"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768959490; x=1800495490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zJEIHLHWqD2AIHGY/H+bW95jICU17y6B8/Z3D4m/jU0=;
  b=h+MIFp6laHFUWINM51s9mPPJ+FnqeaJTwvJxSRZ79fHkRf9iBXPmQK6P
   Jyjx4Cb9lhyq/Gq7JEJxKinQ/mI/CUjZGaeSn75J8f5s3g8kSuC0UApWP
   wbsFJs2atV+AF0GMtIBUpc4QKSIMXgb2cnRUjpeNgYihnjDQxLoJsaQ0v
   Aa6RuinzjzJTi8DCFRjrI3l/DF1ZYh3QZwl4egqSl3H1YfHREFEymU8vG
   BPwo+mc34hHtPM0nM/GN1mXYsvktpfNrY8Iih+j5qTijob207YscpPXBy
   u+/OjODcwo24KY0pcMCTOyV4eiob5Kb11OdeYXxDZ19FcuvirmJbOx0Cm
   Q==;
X-CSE-ConnectionGUID: DT/ZClLOQieSkNJWGMPehA==
X-CSE-MsgGUID: LCDPZxHEQaCURlng78aXJQ==
X-IronPort-AV: E=Sophos;i="6.21,242,1763395200"; 
   d="scan'208";a="140345508"
Received: from mail-westcentralusazon11013018.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jan 2026 09:38:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnFcyUudMtIS1VYzg/5VP/00/GTydPEddVTXi1drSL3GwcLN2/FRUaUiQfqW722nPq04nYLaxB469F0D+0mnwv6pxykVPOGIEsbiuWC61aIpqCkbivkVI7BnSzs6Gfjg2WyKs/2+G1hMkIN5WdqcQQ9tbFnXpk3xJePikktX68TpSvJDg+X+Ir8Zgr9wq0UBY3tesaga7KYTuHZfnrdQfG0mahYhLcGnHlo78kB8ay1pPqdoaa5Pyd5cmtm+LUB8VoLYvecy41e7LEtmJGr0nx3NP0myz6YDcZO8IZHTLsA1S3PVkJH+Tndmgc1RZEP6z9E242PJYcvsTj1qFlZ5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sg0GLUYSPHC90AhwhKOVxygqlkqJpAyj0qvPtzMggQ=;
 b=ZZSv1M1Go64l6wY5x8eLPXXwWVXGpiH5azcbqh7c1suZV0Q8lNQ0GTAgOYfYHpJ1KjBPasJ+Re91fcKRiOaxbXPIzSmQiBNRf9sBWIQdND76gyGLLazB4TV7fN3MtscN1/RslQM+CidLYvl9nsBUYJjhcMMtTZx9z16uO+ImwOwS7Cc+uL+n56VW9k5+z+ZMY3nTSHs+kcf29bOiSar3T9C/ik22cCTRTtFFgEww7Ova5gtur6WUZ6aMIGP8JILVxRhqvIxhnIgfhPso4K/qrYUy/OgGLXK0xBGw4LrPJaaB9zY5BzqOvJ7i7XV88fFQI4CuZmNcWFdw5dlhucWBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sg0GLUYSPHC90AhwhKOVxygqlkqJpAyj0qvPtzMggQ=;
 b=h8xp8l+E48IKWUYsUwatmtEsmjIDw6Cx+VWcx9OdCmmBmD08fY0epiFKP9iLM1GsdRA+8Cw6oEbLF4g8KCCT4ltZslrVQjF/OEOVM8CvE2PyybXhd/w4S+LYBQP1HYhwxPy6fOuSvKath+cqrI1i22LvrchgXZGfPcoor4cd3VA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO1PR04MB9533.namprd04.prod.outlook.com (2603:10b6:303:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.7; Wed, 21 Jan
 2026 01:38:03 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 01:38:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Pittman <jpittman@redhat.com>
CC: linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/2] block/042: check sysfs values prior to
 running
Thread-Topic: [PATCH blktests 2/2] block/042: check sysfs values prior to
 running
Thread-Index: AQHchZnujE12moSEB0+wf613H0JikrVUxceAgAZ/UICAAJzagA==
Date: Wed, 21 Jan 2026 01:38:00 +0000
Message-ID: <aXAdYPb9WewRMO65@shinmob>
References: <20260114210809.2195262-1-jpittman@redhat.com>
 <20260114210809.2195262-3-jpittman@redhat.com> <aWo2phhtvibIfQ1D@shinmob>
 <CA+RJvhxhrRMnSqwdOtme7om0=qzdAtkYNectDU7HC4f6w_7KOA@mail.gmail.com>
In-Reply-To:
 <CA+RJvhxhrRMnSqwdOtme7om0=qzdAtkYNectDU7HC4f6w_7KOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO1PR04MB9533:EE_
x-ms-office365-filtering-correlation-id: a3753ca8-5cbf-442c-de8c-08de588db691
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nBMpnGEVwfNmSg8Nafjgitv6Q+kvXBlwjgPztEzselFYzQ/+WFSGI+1g4rt6?=
 =?us-ascii?Q?TuKozyE/fv89/DgQv+JLbp7vSORJpa8FL0r5rjuWlh8/g/2VkiMjWBHZFOdd?=
 =?us-ascii?Q?Ode2PgbhMimCKdnLF65IPvj8LPO/DvggdDK/ilxT9RZCZKWuqpxNGI+4pLup?=
 =?us-ascii?Q?DJZlOHUMnpu30u1X7UiI3rL51Lm+J4y8UHaYSCNdefWct8ClD5gTLribcKES?=
 =?us-ascii?Q?Yam17PkjG4ULJZbwC+fehyhj3gw+PyYsNTbXaYevMIpHxzI9kYBmgPZaYUk/?=
 =?us-ascii?Q?yLJRvA6keHEcaJyekL1Se48F0hRII+cf9ufngY5QXNRKYlFWyS5ie0Y6CJrF?=
 =?us-ascii?Q?+8MM8gVkBUWDrcqzq8TDyslTCf8M8trQquLQldKYvZRhczcYFzp3mfuq3Ch7?=
 =?us-ascii?Q?wFIGH38GMlXOD+/CDsnLBIqYBCXRodMbskdcW91gJRCRq/pfetwn894jZAyo?=
 =?us-ascii?Q?QRfi6rucVhB+70TMLHPpiM41a3Ydre23SKWq7j2vTzIEV8oAl5R8IkAg/gfW?=
 =?us-ascii?Q?JUvl4aWobEh2R8Askq3MWLKdod6TOCfWtc+DTsg73h5rGII1E1avcYBfgLmg?=
 =?us-ascii?Q?Mx3QDPhGbZbLdhG1ar3jr2qGOT1nWsWG7+DiP/25sKaX2EFQxkeBFmQiNhxs?=
 =?us-ascii?Q?YhDf6wWIDavum0ZbJ6nFZkIq0Xop+DxVEoZ8J1WPdg1w4Q6yDOAzF3DY2rYC?=
 =?us-ascii?Q?uZRVbHR3ZJPYppEKUJvKIr7G0S4joRbeeYomlZAOa1I0LiwHy/0i440zDLG5?=
 =?us-ascii?Q?TdEUUic6XqCWBGVVtZk9rRSBkW/INh3W6fUI0CKseJbK210OgrRBr/1nkH/W?=
 =?us-ascii?Q?SOn5x9Rvm6b9t93c2xCuagz/HUQvlvWVu+YGpDFRhM0hcdKJzr03lDqeOylU?=
 =?us-ascii?Q?wQpDqN52WXAgkO1k5Wq4IEv3O0xCwrw7Z0tnvFH55rbvft70Oaq2+GXEFCmS?=
 =?us-ascii?Q?W6OPBGnez7O2msEEtA+xjMET9FxuMypNkxhN0zVP/Z7Datxfygl3aUIeTyc4?=
 =?us-ascii?Q?xQiVLj4gmgx4ad6W3y2CBPEez98mM/AN/Be551Nq9/2d3lR2njZWFgcR9N7/?=
 =?us-ascii?Q?EzgP1y4cSXMUjZ87R9coGmvf5Kak/yJVvv1Ps0X+tTppqQGy2gtxUrp6g5Sh?=
 =?us-ascii?Q?jRJQGImp3RXZcIhV9viQU78gXzV+HSvplxz0D+NcJYRQwLsOXB6ebMwp5Zg0?=
 =?us-ascii?Q?3ffWSa4iVSOBL+CLr7X4W6PJU5zCrTIAwE39DuwtqJgTNgmTJ9Mw6kgBdZ/w?=
 =?us-ascii?Q?VUSXYzutUaZwzXpdkvJO4ppHK04wQ7V1nq5Q3G0gdYJ07oZiilBgPMDhvHoU?=
 =?us-ascii?Q?BtUNz85ZU0FaIUk6/Qlite5X7kkV0/we+nZG0NdrxTTWuU5rusVjfNihBM3h?=
 =?us-ascii?Q?GzUPtfq1xENZb/g3D6t/ZaeATUqWZpT24m4cv+lRuUyiLItj64ejWDTV+o/d?=
 =?us-ascii?Q?h437m0F613/l/m2EEKWb4+bOfXS7LA37jKFlF7HM/5BMF+36mL57pKI9/BMd?=
 =?us-ascii?Q?UXG9GNGJFEa8jBY1TeAIbn1dfbF+xGX+ZogAiSDm6El/QM/Wa/AcHk6O2AKJ?=
 =?us-ascii?Q?qqtrtcNtec7gyk6SGBreHhdOcLxQFwvvcuj7j4XSlY1cVZDAdWtZ+wJ4CuA0?=
 =?us-ascii?Q?NFUmGIC9UTnvFvf5OY7g+jboW+3E3oh9ldjZxfZmDq4+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+MC3vJA0qT1U3vMJ7nw8exFxjLz9Lhj0VAhm2gJUCt9n8H/HHWOMzW5h+t53?=
 =?us-ascii?Q?4nx8fkymrjXMPFKsFofSyqHWVcUXBdYpuzfctTOC2HNHmWsRwqIwOkrx9uNq?=
 =?us-ascii?Q?PGjoMbcv/1pPUSlH6fnm+aqne2lbSVmS6R3Wr8OPdbyGSpfCqtQyP0IZn+F2?=
 =?us-ascii?Q?wolNbSV+urMHwh8AAzfGt/vcPvAOL8EvhjdOyIIL9aIwB3dj63kPv0QH6wxE?=
 =?us-ascii?Q?9Wx7qndl475F9ylZGJ+K6vfgKONOU214S3kMwBSzFkgUuuC844xdMoBN7L2B?=
 =?us-ascii?Q?tDO5dk9HU5YekVcbPwqovvYp9KAAz7myMhHAWztulf5boOYqp/FUhsiLdZjO?=
 =?us-ascii?Q?TxcOTOkDwttDvUXfE3s4aDsjkM7ofnoUtO6BP8vhaInyhA4fcao0YkMhohGO?=
 =?us-ascii?Q?OWgRUD+/3JQKfgc8P/QNSFurj1sV912MdCQMQxtsZoqR8IeNTGh8hpxJfIju?=
 =?us-ascii?Q?JIQ12hmcT9kuiyZwdog+CdQNnovR9M28fJ8jbmFGZJCSiERIkh4eYDtatZiF?=
 =?us-ascii?Q?0WkNpVK399zIBc4AnRi3EYbwqiqJLSj+Qs3ZAFtfNLQuNYn0Bok1i0+5Ddzt?=
 =?us-ascii?Q?2lr4oTuyS9GVUWa1aozSKJ+yyGlLsFbYLEnOo7VcNdgoKGXueg8+P7EtXaid?=
 =?us-ascii?Q?R7GiHDbZ1nDx+Nxs3PUumub5pq8RXmJsJ1xOMQxLJegTR+RII2glT3cpYZmi?=
 =?us-ascii?Q?7tNpOGTMYeCPH62ZkQJWijwhw0totjopBR8yMxjV+d8GnLLRW8+qqMKEm8EE?=
 =?us-ascii?Q?jcEdr4txtvB7/K+ZHh5+4VL8k677t8sZaQ2DdxKn41PTiqijiCBb/wFjagYw?=
 =?us-ascii?Q?eRErAc3zunwlWh5ID9idVlV65pCJhe5J9DMsrMlDb5LXjVwDrch7i8QSAYPN?=
 =?us-ascii?Q?tBSmRKd8J66y6UelMTtdU78O7bWMSJsJncxmEfE0+tC0o1p896BNG2FQKjv2?=
 =?us-ascii?Q?uomk6YXL6QUliYFsXgcOy91FeuGwJkD14CG88tyEwIKHePKtCFQiYO0fgRcN?=
 =?us-ascii?Q?hpSvBW2KIev2cuw82hbDC4Z9XVAdaFoHVqgw3Yf6mSKQBJhU1jyD8CqiidqZ?=
 =?us-ascii?Q?I2sZ9LwkdQzMawFhTpYiRUkTI8zkol1WsDuN+e105AI1WG3q5dP2/lD89mkC?=
 =?us-ascii?Q?TEnDQj2SdRvPpsbp2XHH3O8PljTVz+aJ+vl9EFMREsMT1CHDF5ZKx+pFd1t5?=
 =?us-ascii?Q?rHkISJ4jy4OSlQF0RJAVLfSLQozE2cWlhvnb04M7QwOB4Rug39bf8HqkiDa2?=
 =?us-ascii?Q?ijhblB8fzTpB2cMtda7VU6SyCuqxK8xHmeBSq5iAr+L++jn6gIigiKQ3lK1M?=
 =?us-ascii?Q?kcKmPy+ooaePhy8JXcOUA006o3+4AFknBL294Od+LE2RdxjsSxq0MCWbbVgi?=
 =?us-ascii?Q?TSXNY9n5W/QuRo49kYcQ5Ab2pBIqrH/OSuoU8038djAwF3oi2I9N+aiD+TZ/?=
 =?us-ascii?Q?3T4WazDfQ3qCNAzXj4GjYsLHtng9v0+LH+SnDFjjR9y+62lzvH95Mg9vLpFR?=
 =?us-ascii?Q?unduQiWhtk9JV7ZvWJwg87hk6MFeeEaydyH7OJZ9ic6z35lMmSwnNSOQzPuw?=
 =?us-ascii?Q?1+hSYPbVT6685U7+ac4o35izv/xrn+/yeHXq/nxaE1zxPwT5DIjxXl8z3sHT?=
 =?us-ascii?Q?MAaGWMaK1vd6u4OFOoGD+Ie8QJtvoIirutfLY2QaBPy6UgI88llm3tdAzP5G?=
 =?us-ascii?Q?x5mHZrHA6qabvAs9dUZQmMo+KD9apr/3ZFEOmwVaZUKaCwFu8KBhI/d4sqk9?=
 =?us-ascii?Q?Xmp1CT7h7KElrJto0U9Tuyr3VmXw6KI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A34E7912C250D946B7622CC7437BC75C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g2sG3/4AaBi/EHoKkDn8zOhpAQSkkgl5dfMHy+qLvUG2X4UgWE1JkYtd8ddAWzXMwXIUOEDD20k1ChE2FLUa7Mi/KRdQYChAnzzrvLX29HoiiIwuPHNss1k6hbl2QclFO0AK6agxz2zUG0JKoIa0Gy+OQPZkF+eeG0zNdVdPSG6xmUk1gS321Dlj3hh8KDWggTFF8ZsK7bI+dp46sypS+k1vokrHQCapwjsqkMqKD51fi4yAdPoX5sZpUPwwUreb6V4l0hcHerbvo80WC3lQKOLGY9wW+SFvDTr6yz1983fnWWdK2OV7i/1PXhATsYGVVBFWKqhewJQ+hovveO4czIAfjjf1OOPs8rhz16Ln9mvzrLpy9YwwjJAoye5+/VhRS6vLlgFQKkqMml0homoqVKwJMXidm9asbRW6A9kF6y4Cgr4yg0Jk6uCAN9WeaByw5MlpNoSLuawv8/2vPQFyTTC9qCHU1OBkSjzFGxcuvOvct3VkZ7/IDD2GdaqtjYtrrYHHqcC0+sCXYIYIIgdERpRao0K7W3PP/qIYOyE1ksZvsg88yojq+8JX3S9Z4povGiPJCRPtlFii4YeLrTq8SoejC6PAN80JM0EWmCMQXgfo6LieUNRmOU48XP88Lz81
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3753ca8-5cbf-442c-de8c-08de588db691
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 01:38:00.8741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6Gde2zqwEMgHbgvLO+UXUdHgPB6K7bGjf+Y+XlaxtUxB3WeH2mnKs/PI2TS54vHJUx8gJoek+FLiA62TEsZL7pgpbkrSYOCpHeiiwG77Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9533

On Jan 20, 2026 / 11:16, John Pittman wrote:
> Hi Shinichiro!  Thanks so much for the review.  I'm correcting the
> attr and the unneeded argument preparing the V2, but I'm confused
> about the below request:
>=20
> >> Nit: spaces are used for indent. I suggest to replace them with a spac=
e.
>=20
> Using vim to show the tabs (using commands ":set list" then "set
> listchars=3Dtab:>-,trail:~"), I see in block/042 that I am indeed using
> tabs:
>=20
> device_requires() {
>         _require_test_dev_sysfs "queue/max_segments" "queue/dma_alignment=
" \
> >------->-------"queue/virt_boundary_mask" "queue/logical_block_size" \
> >------->-------"queue/max_sectors_kb"
> }

Hi John, yes, that point needs some more clarification. My nit comment ment=
ioned
about the line "_require_test_dev_sysfs ...". I did not mean the two new li=
nes
you added. Before you modified the existing line, it had used spaces for in=
dent
which were against the guide. After your modification, you kept the spaces =
for
indent as they were. This is natural, but this is a chance to fix the inden=
t by
spaces. So, I should have said that "taking this chance, let's replace the
spaces with a tab".

>=20
> And lower down in block/042, I see that in a past patch you used a
> single tab then spaces:
>=20
> >-------if ! src/dio-offsets "${TEST_DEV}" "$sys_max_segments" \
> >-------     "$sys_max_sectors_kb" "$sys_dma_alignment" \
> >-------     "$sys_virt_boundary_mask" "$sys_logical_block_size"; then
> >------->-------echo "src/dio-offsets failed"
> >-------fi
>=20
> However, when I check other test files, it seems like people have been
> using only tabs for indent rather than spaces.  For example in
> block/010:
>=20
> run_fio_job() {
> >-------_fio_perf --size=3D8g --bs=3D4k --direct=3D1 --ioengine=3Dlibaio =
--iodepth=3D32 \
> >------->---------group_reporting=3D1 --rw=3Drandread --norandommap --nam=
e=3Dnullb0 \
> >------->---------filename=3D/dev/nullb0 --name=3Dnullb1 --filename=3D/de=
v/nullb1 \
> >------->---------name=3Dnullb2 --filename=3D/dev/nullb2 --name=3Dnullb3 =
\
> >------->---------filename=3D/dev/nullb3 --name=3Dnullb4 --filename=3D/de=
v/nullb4 \
> SNIP....
>=20
> So, I'm unsure what to do.  Do you want me to use one tab then spaces
> as you did lower in block/042?  Or stick with only tabs as others seem
> to have been doing?  Or only spaces?  Sorry for the confusion and
> thanks for any help!

Ah, I understand that my comment confused you... In the two examples you qu=
oted,
a long statement is broken into multiple lines. In both examples, tabs are =
used
for the first level of indentation. But the first example uses spaces for t=
he
second level of indentation, to align the continuation lines to the first l=
ine:
"$sys_max_sectors_kb" aligns to src/dio/offsetes. On the other hand, the se=
cond
example doesn't use spaces. It just uses tabs, then the starts of the
continuation lines are not aligned to the first line. Which way we should
follow? "use additional spaces to align the continuation lines to the first
line" or "just use tabs in the continuation lines"?

In the blktests "new" file, it just says "Indent with tabs". So it does not
strictly guide about the space-vs-tab usage for the alignment of continuati=
on
lines. In general, I think blktests should follow Linux kernel guide. As fa=
r as
I read through, Linux kernel coding-style document [1], it does not guide a=
bout
it either.

Looking into the Linux code, "additional spaces to align the continuation l=
ines"
looks more common in Linux kernel code. For example, I can find such space =
usage
in block/blk-core.c [2]. On the other hand, I know that f2fs sub-system "ju=
st
uses tabs" for the continuation lines [3] (When I posted a patch to f2fs, I=
 was
guided to use tabs instead of spaces).

Then, it is not strictly guided in Linux kernel and I would say it's the sa=
me
for blktests: both ways are fine, and the choice is up to you. Just in case=
 you
do not have preference, I suggest "to use additional spaces to align the
continuation lines" since it looks major in the block sub-system.

[1] https://github.com/torvalds/linux/blob/v6.19-rc6/Documentation/process/=
coding-style.rst
[2] https://github.com/torvalds/linux/blob/24d479d26b25bce5faea3ddd9fa8f3a6=
c3129ea7/block/blk-core.c#L321C4-L321C7
[3] https://github.com/torvalds/linux/blob/24d479d26b25bce5faea3ddd9fa8f3a6=
c3129ea7/fs/f2fs/segment.c#L451=
