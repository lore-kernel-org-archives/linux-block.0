Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C4246782
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558758; cv=fail; b=th5u9HHJk55FYQaRnhiNvRLduiZhhzGNqaTduWZH3CYWK7SFUPh3GRCEGNKMBZFc/U+kM2GixwRrD0Voh9/PLbgqseyrUOe2NCqhsV6Dv9hrGfcr8K+17qJZNN/+v9dBGCbTVIVP+S/MSStsKD0nH3YO/tuLBW/A5b60YBe/w1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558758; c=relaxed/simple;
	bh=MwMT4aIhdvt8OQJB1MN1/6a7OeyOlc3FAdCBk39NrRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K8J2RPaxQi/3eLVdg8O+0U/DOy3TbP/jXEcP12+rp995xZW7nXRQAAKDMV9y+iwCC0pTX/pG94vsE8JIg7hL1E2OvEggKqcdFXB1YfAn8THxLf+5XHtQG20mt2odYbOFgDLVtH20JCjCQQYaSE4JW2tjgjdogn2aZWLl49VOh8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dtbYTB+D; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AIC1lphu; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dtbYTB+D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AIC1lphu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768558756; x=1800094756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MwMT4aIhdvt8OQJB1MN1/6a7OeyOlc3FAdCBk39NrRc=;
  b=dtbYTB+DWvNCqyVt4zQ5K25yzy17HABnrxVxPEFCyMu6CL5M7jAqGuGb
   Ok6NDI2V94eU1MxMjsDjS4UU/1WFPiOhQwXoFlZuEIzZODSmLyulcfByl
   1jo4RC/EiuaI0Z2A+6Wy6JCos/nlMXexSVwcmFZbRfTiGL9yuVEONMvCI
   CjD6jtFyu1nR7iTR9b+SGKy4Y/tIdDhwmLypH6u1u9+UGbngrG+doZAQj
   hKyHvr24dgbxzxqP2E6yLCyGMtBSOcl20csHvYVN5D7+Bis7S/+cDapRP
   QV9wAxQhOw49ql5JsPKEBOYmh8Rm+wjLLEoUD3rkM1HfiKIHQmAR6DPv5
   Q==;
X-CSE-ConnectionGUID: /u7aGpu8Tm2kJGaScHKQMA==
X-CSE-MsgGUID: 6DIV0lO/RaSLr5r3B5kdmw==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="140101170"
Received: from mail-southcentralusazon11011010.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 18:19:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1zCKPdQnox/ZBzfiZadvdL7gPAROjod0ztNtEevVqKzpu84jbmKvKiA7SGIpSSvXtCd5HmiPY7zjzfgBN/tgJoQe7bTnUi0afx1ipSTxYSNbVQZvNzaC3eFFHu3S2KebmHpOtmfeSHQXGH8h7msxYJwCa95iZlV/ptCh8vYfXOzY6YGYcDTEKdzTa4DzOt16hJyQPwNdXizUzrVObH7tYEg6qb7LLKwgzUl5rJ+u1MymPHaVk0O50mRBy5R8CW6G8Y9K8NRKOQASL6YMlMPM8gzZUqJJRZcgnLiWLlEN88fflrzTFsHvN8ps8ik6yT+CNhJp7//ULrqq4vrRo2kkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhNXDnd/rZx/Inp6TzjRcuT4tLLVuBl3ixeMEBzxl4A=;
 b=W/k5u8+BRwcO7GBJTWMhwDWyqNeXVX5xGvp2IFSu3YVbqjPxOEDadXwRONoQNAxGSEx9p58nuwxcV37LbLVqoNTUCCphxY+pJDc8+wHvSsYeXkJ9Dv6MmWz/i6Ayvx0VBsueWaAyoHccwInpGXOr56KTDua+PU8EfIlSs5cDrzTTywBRBEFbwdHa3wHverUkXrkgCYCblnQXUI9vPDdFsQJF4/nR/h/82XzWqE/E6lHKTDFC2Ftt/IvCPirOt8iQURjSpxC2gquhBVN0P+IRdozNHjEH0Or+QVj1GN/o+zzOjnQXc0rOkoIfucVmqLQacevlCq99iiBzdLY8siWxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhNXDnd/rZx/Inp6TzjRcuT4tLLVuBl3ixeMEBzxl4A=;
 b=AIC1lphuMI1igyOylW1h41+wlLbNteW9Nr2l028onFZYeKllvbsi+9bWFanm480a4VT/j2qlJw/2zabcKNVipmGyBVSsQqQYNp0DhpujxiRAEBZ0EtQ8O9l4rRVxc29sm5eqCoqYD6xCo+NJxe11ALVjAixO3BZVQ0U/jRzsVB0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.4; Fri, 16 Jan
 2026 10:19:12 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 10:19:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yi.zhang@redhat.com" <yi.zhang@redhat.com>, "gjoyce@ibm.com"
	<gjoyce@ibm.com>
Subject: Re: [PATCH blktests] check: add kmemleak support to blktests
Thread-Topic: [PATCH blktests] check: add kmemleak support to blktests
Thread-Index: AQHchHJGjk8hYXq38kWsXekLN35ixbVUmjOA
Date: Fri, 16 Jan 2026 10:19:11 +0000
Message-ID: <aWoOpqVO9iqoxS9t@shinmob>
References: <20260113095134.1818646-1-nilay@linux.ibm.com>
In-Reply-To: <20260113095134.1818646-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7184:EE_
x-ms-office365-filtering-correlation-id: 2fe68280-2dbb-492c-9ec7-08de54e8b1be
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j9eCSt4i/+IqAweAxBOxcS07mqOx6pcwEw29KR1oivZk68voFgKH458IL7f3?=
 =?us-ascii?Q?jpxKNAxuRkTjrlGemPzX3xCeYbAMCeaTcXqJSPaD6H3mImzSewls1JpP/P6F?=
 =?us-ascii?Q?umT5JUeQHnjRNvXCtQ9Ioz76LiRyo6l2LMOgyrgROCHFFLfn6zrTjRrTd4ll?=
 =?us-ascii?Q?p85baxBF+SnVU2m5Jbt88BhKgNMbVoDyuJe7m2Xyr/QnMVpqoQ0DjwI95Klj?=
 =?us-ascii?Q?0hNXBx9ij5O2DLUUq+In4fX000bcXJpRF+1gIDNfiwZRNS6bKjcAa+5Qm6Q9?=
 =?us-ascii?Q?Keui1GzLQQUE2zLQRm5rsq6NzG7k2XBZQs+/6q6TiPhW9t1i4ZieMOi3/Qm9?=
 =?us-ascii?Q?CrZvhOT9UBE5tDzRVq49pDz5psFybBX/XR8CaCjZj0eeXzdSk7fpus3w/Rca?=
 =?us-ascii?Q?UuqRy28PXCyfMRHCKI/8ZOaO2bnSZDnHSpTz1smuA+nUG/5fsfjSKaHKUJeK?=
 =?us-ascii?Q?zgLEgSYbsAhQ+IOnFizxn9IghX366DhiZPH3WL85O7qP3mtjkAE03qyJxN6m?=
 =?us-ascii?Q?iFfmcOc8jF++gKnvFwr047L8FPLDpO7NbYodPjRKDT6xhIAIcTos76UMTBWo?=
 =?us-ascii?Q?1Rsf4etoFSD2NnWSD0k5KlsM7Nh5UR//EtzZAX5W76dcr6Bt+HKq8HcFWacr?=
 =?us-ascii?Q?MG/BVeFj6osR3PYxPQqvTNj7MjqadetJG27dPHwQ7djW4qXyY5Jhcj0ci3q/?=
 =?us-ascii?Q?5u7edmTNJMTPd9gXa1HkB/pVOdXyT2jhP57Q1n2VEVO7/1QixAUKvge1VoQ6?=
 =?us-ascii?Q?h3DTKO47lDoO4NeQyFdLTr2pNHPlKhFtD0gBzhCFH6xOdFaZ4jpTr0IA9vTT?=
 =?us-ascii?Q?rSh9sXAQuqnobjpcrl6qY2Z3dQPADu+OFVTCcZGA+JPeJYrADnbMHf1TtgWa?=
 =?us-ascii?Q?lLXZIJ5S+8HT5GoNzyxpoADBRSuyu+1RyrlFSRr3yY/T/yCtYbs/am8WzhxV?=
 =?us-ascii?Q?1ZntqFOd6fOLVCcOebTLTiuAS58986E6BIQcHtQ/wIszJBnicQzERw4UzUkc?=
 =?us-ascii?Q?c6lIkplsT0ggft/QkKIKsin/LlJaOdE+icayI4psCTnKxPMLn+UUvJx3eizA?=
 =?us-ascii?Q?wx/r3js+sjm8RkjIaM2ggmzw/iq6iDOPgHVfhgZqqMX7gcMWUMpUUKtkaL/H?=
 =?us-ascii?Q?iQYe3GfzvSk36fzNhKMzK7wRAHShfF5C+pXtrrdo9GZDCzY8w8Vjc/7uqUpC?=
 =?us-ascii?Q?uhq4XO4kxDrypR3/a5GLNrdolsC/MnfQTyje4dI7UsWAVdw3B8dGD9k1hIok?=
 =?us-ascii?Q?1UvovGHcFFuVO7ov+BzB2xr8P4l57Vzkd9TY+6uUUihGhIkHNU9Yo/1zKjjW?=
 =?us-ascii?Q?pMybguVGzu2T1QkMGdesfiXclsUqlsOfLl81oPZKuygBaJn6fz1s/O31KkP7?=
 =?us-ascii?Q?kDD+WbY489ZohF8C+nh3u1tLeCG+ivKwDUoGwL2+7na/8kABzRVmetI9S133?=
 =?us-ascii?Q?Vj7o5eT4G/5VPh9eF3Zed0poJlUBGzhngi579lApzqUFXXm5wwbDOAEj9bZ5?=
 =?us-ascii?Q?2qymUM9j/FWdgUtk3+rwVb0XWALsp+TveLB1xSjWoyFkKnixkR5p91d8kaSR?=
 =?us-ascii?Q?bGHEJ4/1lIhlGxerindMhiCY+XqiRAcfgl6xpFFxn96lOMELkQn0gjt/WHkb?=
 =?us-ascii?Q?TPjZOQlpPv+P9CAn8veRcsOpHKtpR4tdli6G9u2kWAH9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gMbKePXhNLaDc0nwlAT96a/PzOwabnV8xs9GsLO2ofVEuQlM6UcpofOC5x4w?=
 =?us-ascii?Q?PR5FpHK+Op/mI8hv3F7RSi6T6gMcAsZwNhyr34rThlpgyZeY90gHoQUGzr/y?=
 =?us-ascii?Q?WFGMnBAEQiPFnb+pTFKJBpauXNy7G/VF/3Wau3cNeZ6tZoovpK4w8l30+WQt?=
 =?us-ascii?Q?FFRZ+nVwI2IhabtUigydLaQPIY6QmdsWo/Zb6/jXn88dAG1kCvhjTjsFiCCO?=
 =?us-ascii?Q?/HyNMPcllmkxSuTytH4V7jqCDeLTja3YqmP6m1Z2zRVfWuFKd5QfeEe6JYo6?=
 =?us-ascii?Q?LX+12TtHv/gBKjkIXHca5rCeKRjWkR3TvaPnIWRLPCxtgda+bD4IGBaDQPOX?=
 =?us-ascii?Q?y3Qhacmt2ik3Rw90E7yeoIX2WLkfR9KoYQ4LffvqiLmxrVx3UCJVgRBYN1fP?=
 =?us-ascii?Q?ZSAjsKLDqTTl43BgMLbedjqzLagaghKQnixU9+2KXA1pqhpsI2xPVqSjUJVc?=
 =?us-ascii?Q?Iupo1+bD1+umeyK/hTMmtB44niKCwhOsFebzrUU2G0FNkzrhr9k28QEHGlVX?=
 =?us-ascii?Q?rMtgFHVLp8ODTWhHcRy5bphxiAnEunAE4SJEYQ8JhTgi7Rwfrmwhz8qS+ell?=
 =?us-ascii?Q?tniWYu+EXhX8KPy1zAUf0EFySP1P1aqGc8cq/dFbNLta9KNZTrkQXlEgkMcJ?=
 =?us-ascii?Q?SAJyUI1XM3Uv0ZYUA0q+rOB+cSqRIufiCbmBD7KAQo12d1enooXC1bCTav3+?=
 =?us-ascii?Q?fkH84+i52BJu8wvgOEmIM8MFTUCKOHG2UxcPMW9rOW41AyqZXe53b+4w20be?=
 =?us-ascii?Q?M5gOBHlZ5X8XD+EVlj/0vNxJoisboEiZU0+skViw2J2wifCAUPR+l1bJy0WI?=
 =?us-ascii?Q?U/G6eacIIzWpbWL2U8+T76p3QN+k9l2LT9YYPyiyIZmX0fKmS3DF1sz3/08U?=
 =?us-ascii?Q?/SGy0Oy7cMKgp5OUeQycmidUcjrSHZx3xN/VwXP9Tv+PMqeS0wzRybsBtmZw?=
 =?us-ascii?Q?YHDlxcdV/lm3jMFJKdeI1OI46tYXWfZwP+qx/8pfewJOFTTi83K/HfjNQIgx?=
 =?us-ascii?Q?CKaNrtPo+rZmvV+5poGtlLOe0LmTFKP8Ky9TgCAaaio13OfY7CaALNMu1s2l?=
 =?us-ascii?Q?NmWSypt2Prr0cQpsfR+yBiS/kfMemKuzE8ZRcFpjNLSTF6+2JogHRqCvbc8x?=
 =?us-ascii?Q?QHtv6nkHBeBiz++WsJJGsWMlOZ9cvjTiuMv6eg0KG45Aa+pX5tpbDipdLvcS?=
 =?us-ascii?Q?L8phHaPEaJ8/l9fawuxEChZ0K1yuHnH7d8nxpwCaXiNfnPYbK/makXcCbuMy?=
 =?us-ascii?Q?nSmltq8KxfeBh1o3yOrHmRm19aTUSW5ev0uIR4WhLpsl/m1aajs/EoQaKznC?=
 =?us-ascii?Q?NafPZ+XifGGFT9VKlezhw8r1SsbQ6j2YWBlAg7z89R53aZah0CW4YWn1ICta?=
 =?us-ascii?Q?27+ybzOWOZPV7aBpUwsRmE+qUxEO6AhYTEiQkSHeaMmJC0VrWbo6ruJJw0oc?=
 =?us-ascii?Q?9Kh8K6DRl7eGwjeuemIjaTsouHtJ2sm9bvm0ClWBPURXxQL3k5Qod8FPmyR/?=
 =?us-ascii?Q?ZuLyfgzNflOgPK0Qinvw2dfJpvzMJzSplfVAmEAbM5ZIxrrPecXoydtPviT1?=
 =?us-ascii?Q?QN2z1DD7kLLVKrPd0JSwy13g1gj0Y/SW8Z180jycArmJX26BWqSPUVdS+0V7?=
 =?us-ascii?Q?S+C5lfTeTENSnoqCoVTHHLpxsfpUmxjEH5j+9TaGwRgdL6BEpOLoeLvURU+d?=
 =?us-ascii?Q?/sC6YjMlHjKgzGeqvfRvDdV1cPNjC2jH7RKePo7uP+D6zvQTHAYYOIX+SKuR?=
 =?us-ascii?Q?ngXG3mJ2U9KO8uru0oR3nd+UP/1yO68=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5520AE1A7EA824295690518E53FBC6D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yb82RlqZtO3SL2yuA0iblUgrA9vRgryvSgmf+tI089ZCfWo3ZRJp9g0n3xAIsiP0ycN/KBZJQIIXo1achkG3xYVf3G13yS2+BB880Mg3tTRVkpV8wEDw1O9brZsPWvuziO5NCh45UhQwhrNmtTdK0V1aM4l8i1t1hRMN/PQ/6GTr8CPYtg80h46b2oWVwjMymcvi2KWZjpepT5O5EwbTripPu6kY8+RPHT2BR9gSolb37V6lYHDFTgupYywSGdNewAH74EkoO5mLN3u6LGIYNNspiHyou/R/N2eM7Jx/+iWEW/rSPKoTlRArcFAQorRtKKQ9C9TeoJtn3Y0Dcd4COf3PbP+k9VeKYgeoGkgyG7OSV0vHb4tSUviSMJxh5QwOT2kbWrTcgM5TU5QIwWDqI6ZnWBhXTHBgCd+cUBCbT7n5LAsCdrNglcmsAZ/gF7Wy6XhUap+1d9W/XgYH/ldSU5H5WZ77ZwB1NE97QD1EA9p5Awo3o/3Yw5hNsX+HBhIvfMCSpiuXTstZqRSD1vmfBVeUr3Oonw8g2GzWvDDYequ9vyJROXfvg5A8k4Rqbtmpuy5V0yhO+lOxDrwfHjIazmd29NC4GxAgcQICqLjXyxZFtQRScCrHl94TjvuI77k9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe68280-2dbb-492c-9ec7-08de54e8b1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 10:19:12.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78dDiXNaRGdMUbgOwTu3+yGNJ7WAMgFiUn7TjWVE8LBV4K2ZztWZYjboGL1F5sJ2qFehGqbMZsH2xxB+C/fOhKyP1LvkrihAsIFxCT32klo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7184

On Jan 13, 2026 / 15:21, Nilay Shroff wrote:
> Running blktests can also help uncover kernel memory leaks when the
> kernel is built with CONFIG_DEBUG_KMEMLEAK. However, until now the
> blktests framework had no way to automatically detect or report such
> leaks. Users typically had to manually setup kmemleak and trigger
> scans after running tests[1][2].
>=20
> This change integrates kmemleak support directly into the blktests
> framework. Before running each test, the framework checks for the
> presence of /sys/kernel/debug/kmemleak to determine whether kmemleak
> is enabled for the running kernel. If available, before running a test,
> any existing kmemleak reports are cleared to avoid false positives
> from previous tests. After the test completes, the framework explicitly
> triggers a kmemleak scan. If memory leaks are detected, they are written
> to a per-test file at, "results/.../.../<test>.kmemleak" and the
> corresponding test is marked as FAIL. Users can then inspect the
> <test>.kmemleak file to analyze the reported leaks.
>=20
> With this enhancement, blktests can automatically detect kernel memory
> leaks (if kerel is configured with CONFIG_DEBUG_KMEMLEAK support)  on
> a per-test basis, removing the need for manual kmemleak setup and scans.
> This should make it easier and faster to identify memory leaks
> introduced by individual tests.
>=20
> [1] https://lore.kernel.org/all/CAHj4cs8oJFvz=3DdaCvjHM5dYCNQH4UXwSySPPU4=
v-WHce_kZXZA@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQO=
kRy=3DDsBB1w@mail.gmail.com/
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Nilay, thank you very much. This idea is excellent, and the patch looks goo=
d
except one nit comment below. I also did trial runs, and confirmed memory l=
eaks
can be detected and reported as test case failures. Great :)

> diff --git a/check b/check
> index 6d77d8e..3a6e837 100755
> --- a/check
> +++ b/check
[...]
> @@ -451,6 +486,18 @@ _call_test() {
>  				print \"    \" \$0
>  			}" "${seqres}.dmesg"
>  			;;
> +		kmemleak)
> +			echo "    kmemleak detected:"
> +                        awk "
> +                        {
> +                                if (NR > 10) {
> +                                        print \"    ...\"
> +                                        print \"    (See '${seqres}.kmem=
leak' for the entire message)\"
> +                                        exit
> +                                }
> +                                print \"    \" \$0
> +                        }" "${seqres}.kmemleak"
> +                        ;;

Nit: the hunk above uses spaces for indent. Assuming there is no other revi=
ew
comments on this patch, I will replace the spaces with tabs when I apply it=
. I
will wait a few more days to see someone makes comments or not. Thanks.=
