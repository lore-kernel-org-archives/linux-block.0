Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A934221F05
	for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328785; cv=fail; b=p6w0vO5bifHKV96HP7hb8yz34D0CUFYfOHF5kB1nwWGKhUaMeMbq90/pZrqL1f7HuWqcE8CTz2lIa7etidIO2z6Donp9uGYqjkeSqHGkgDMIsQHBrgIlyTNS/8TzeYM6J/j+O9POh5aZAqEUwc32hky7auOwxsPeE0zed/2Hsz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328785; c=relaxed/simple;
	bh=mEo6PN24VNuIgJuEaOaw0A/Z0rgHGBc/rtbzF9ZTZnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KzyFBVCH7t5J/fvx3F67wsVeYj7CWfUFuh7i1JJF9Hg0l8VguP4wZwh/9E+1xEcaBJYw8b9yPDsbrgbvy2yc3ce0Po1o4Z6wq9eq2KLoub1wtnT3O6ZDYpJrW+SPLA0TwoURKIt9nXZA3HZzeABjIITPSj65bcqEoUh0pflRrQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KYvniBmc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DQDpMRyL; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KYvniBmc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DQDpMRyL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750328783; x=1781864783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mEo6PN24VNuIgJuEaOaw0A/Z0rgHGBc/rtbzF9ZTZnI=;
  b=KYvniBmcBjvb5yRSa7/yoiXjJnGT6+TO84iyqbqjIS0+lYMQimxKBMqy
   6hU5NUq7dbuhgbDSnsZxMpOFfSIUZVR7TkxaSjLp3JZkWgtMBjQdGb5QU
   7oi3QtY1uUR5evUSDKehAh3W9eN9f1LlUg8buO5atyHiRMAP1lGGBQnJl
   dxtA4wbu38VkRL+V1l0RADyDv48MeDTYDKgpoRAkN25cR2Jsaa5ioH1Oy
   5YVHpH8YKHlvVJSXzfG1e0fy8orQj7JN5djAI4nU7ToFAnaJ5NdEhQOkz
   kfee1uy0FZSA1v0pZl2vSUiT/qPqvUIPHtJzG83V0LDtIPhRmHBpKWQ5H
   w==;
X-CSE-ConnectionGUID: SccJHYhtQ9iRrG3heeoGDA==
X-CSE-MsgGUID: B5S9WFatSRybHC8i5MtNuw==
X-IronPort-AV: E=Sophos;i="6.16,248,1744041600"; 
   d="scan'208";a="90898675"
Received: from mail-westcentralusazon11011058.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.199.58])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2025 18:26:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFoPNwkzB3GThlJY/JzdXVD7xj3lGA3hSS3mU0PSsyd7wzpepoGQZz7ak49pmjTgA/0x0FWn5UcffsiO+n8vaPQk40Ft9ShgKlw4e6cKL4a99kOTtkvz1Ygt+oJAx8kqSIsgBSc07iF1eoY35OImNVItdxFTfXIXCnTtQPJV+xza3GogBNZcThQsAEIVUf0piyfSab0esznrshNUhL5PSR4HIK+rqlsFn9mWdElH4s94c2VUhJNYnegrHudp0SMfhN/7LmkbaI43oJ2jcywPzNMQBZnhGDDikdzYRC3nu89e9Cp1IpEwvQHqY8YQfJmNKIpcDeORHvnOKvfSV7KXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEo6PN24VNuIgJuEaOaw0A/Z0rgHGBc/rtbzF9ZTZnI=;
 b=heanZ1QFjXkir6r2G5EmkauRO4HtietD6XS9BxKlwn8IpLLIpHh8gi6RZBEMD4gVAlIp7UfBLlFQnZtb5wEDdqVs/6g5VBhZQ+X9k7LcMjeVsNMEHha5pUU48BcCQSwvvFt0xj3IOsEE+bLc/cSVmprhD7Yc+pxgMzAEuaW0Z7X1zhBFIndIOjJ2n/6yFEKd3v1E0JTow3QvYclgarTMDGt7/1oFEGW6FGukDWaUwRDMn9sPOswwtFSzuyBkxeynzB8ZilM4N/fKRYaSDExTh6CReJGlYiHyO/fIyiObriRe5mu+olTB3xibX02ns6OvpyZQ9Vm/G5ofJqGshdgo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEo6PN24VNuIgJuEaOaw0A/Z0rgHGBc/rtbzF9ZTZnI=;
 b=DQDpMRyLEaHrGJjxowg8VyolQZlpfEB++wjmRMaesTctmf8F06NwZ36nGYd0VZC291V3syMboA2PJp4q9Say+IF6UGgr8FrdQTLYJsrGH1+D51WncHKsNT2lKniyU+PmYTasnMq2Qaixxw/ftcZvtY5MhDh2NGx0rjtd932N0/4=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA2PR04MB7659.namprd04.prod.outlook.com (2603:10b6:806:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.31; Thu, 19 Jun
 2025 10:26:18 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 10:26:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zizhi Wo <wozizhi@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH V2] tests/throtl: add a new test 007
Thread-Topic: [PATCH V2] tests/throtl: add a new test 007
Thread-Index: AQHb3ycmL7IZbykp70OAk4z062E6CrQKSt2A
Date: Thu, 19 Jun 2025 10:26:17 +0000
Message-ID: <riagf22zp3eg2iipaajujfdnaid2zr5tu62xikf6kuadvz7uze@i6fftxqzrnjz>
References: <20250617012159.3454463-1-wozizhi@huaweicloud.com>
In-Reply-To: <20250617012159.3454463-1-wozizhi@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA2PR04MB7659:EE_
x-ms-office365-filtering-correlation-id: 9bc4c7cc-6c59-4ced-8f87-08ddaf1bb9da
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kBOltnotgeaE5NTqzDetHeTA+TsJG/kwJpBpQ6x1KYp4Qi3Br7hYhpvjlj48?=
 =?us-ascii?Q?z6Jgj1IiWcxX0URd4VZwp3fBfhh7AxHcAoct6FzsXXsCzQvOMD779bazcIVh?=
 =?us-ascii?Q?8Wzj3WXwuyZKa+jnKsgMsnqRSTb7oXu0JdrCcuwKnG1Ff+AeQ25uW+tmThMe?=
 =?us-ascii?Q?FUzZZgVeUoC/+NOlCImu4Ss6u98EeBYlyayqD4nSF1OaWbK/bJifZzBzlEOI?=
 =?us-ascii?Q?3tTWSzbyU4uJJQWR0f8ThIAGc6W9hCmOGIdMPvwYd9Ou1Pk3xCYuiYi/CPYw?=
 =?us-ascii?Q?Qu1IkP3TlhyNB6RARXiFpeoefrSP+LHE5R/L9u8gvQ0H6bpasvxQThMeQcz/?=
 =?us-ascii?Q?3vN+m+aJJ49OVApusTOyE8qI+aoNdZA9uydnwxlpsR8d1Joo4mBckIOxk+La?=
 =?us-ascii?Q?50FSO/3d/TtPZbv7UCYWWaXKaEJasM/jnl5PGl41HoiMRySC4oct4McA+6MM?=
 =?us-ascii?Q?4kMKuvUtWtYCoqVbmSC/ZYRciAgPqQNI0T012we8Hvos4AMQvkKtROyIqf5z?=
 =?us-ascii?Q?YXyMphFLwXD5vXfut+anoj1C6vWnK3wVTT3x+1EfC0Vjn2uRnjVuYQn7AG7L?=
 =?us-ascii?Q?4Y0/pRwcfw6HjY2R3xhbpp11lvCwGi0W8vj6owI9EFmPh3aHIM2skniWdubS?=
 =?us-ascii?Q?jj9A3jHoyJI5sX01qQMhXaMNAwqdbL82LWIxIgEmYJ/1gzKn3UkVSlVUjGWk?=
 =?us-ascii?Q?EVIUvzEhbQ2+4XKJHftvyqkf70oHMGm92fSQTCnqa76KwSjWPkhyj9grQfOy?=
 =?us-ascii?Q?5GbhvQx7w27F1c6Mi2WLOoXbSDs7zroj7mOdmK2vbWhpESntszb01l92oCjG?=
 =?us-ascii?Q?rjdC2IcioSnJygNC2sXqwOzgRYE1yuxd+EDrzLkp+8g6Eqnq1z4U5tiGZP4D?=
 =?us-ascii?Q?slVTSVwqGPXh0E8pLMivX0weGrvAgTI1h4Ilp+bHJVl7yf2oqmjmG7jNaz0G?=
 =?us-ascii?Q?SmVYaPHdQmnJF2BaNvSkp7uVGMZXxtvST5/9JVknNONUTJXwcUloxiHQrk/1?=
 =?us-ascii?Q?zSLAIR4WxxZ/hqgmo2HM419R3vNwgVodoING/QBlyZHp4/rCbq0vDyqgaE0L?=
 =?us-ascii?Q?itlb7jjUnM8REKraBD2zM5hJnrP2lvUvqwZQv/ifkFu7b2rjbE+xKLe0qm4k?=
 =?us-ascii?Q?HjmImjk22JrsYff7FeloGeNqch/ETvSz5tnzSHJGwJFxU8gOIl2eUItNUqEz?=
 =?us-ascii?Q?4hjhc9POf3UYyfOtdQT1pN2HHj03Lv8dPlcde+a12jmzIelbDk1WYEcYUFzl?=
 =?us-ascii?Q?BItOu8kpGauudbnSteHIxIe0KT2Y44yRj/Q9h6/+dJtWhp5zY4Ur42wePcvy?=
 =?us-ascii?Q?IMb1NoGcxkkFDAzJFVx4bWJe9/YLmhgbs7XbboPxdPLzJAWRJSiYwrvA8f7u?=
 =?us-ascii?Q?qQ3uPwdRRmWWQ0c1EMgSsR+l56N7yDMT31uUaANjwUFlZShOeqT0zPNZUe6i?=
 =?us-ascii?Q?PkWMVH5OJbOO+IS1nifICQBbf2MmLAwkCrAu6SoeIBvJtZ+w0Y/5Hpb5czxb?=
 =?us-ascii?Q?3E4Nr37MEEdOxn4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EfuNwl6oEOgJ1zAwnkhayNXur1VOhwlOEa5Bwa260/FyqoxudLSBNHjeixja?=
 =?us-ascii?Q?BxPog6KtDteJELpfOYmS3RRLAkQ6Yds72V/tWJ6iZN0etNzbeZqKKaMYx5LF?=
 =?us-ascii?Q?hnD98NmO4qSttnk2GtbgrU4S7g05i5zYT+86YiZxnkcbJiguV3Z+ASRbYBqI?=
 =?us-ascii?Q?Xxq4CkKoRuiZE2/Xr+TW+MVFY1Dc4e1BIM8lAKuKVXFD1tH90CYqbg1B0MXB?=
 =?us-ascii?Q?tMztDLRTpC5dzK9se0pJMn2Ygx2R08uSxZ5ry5rz1OowvaNGozynN9rBYdCW?=
 =?us-ascii?Q?tAF7RiK6hZD4KA//tmeOExRm/mw9u0RtBwUro4VSSzp4HHsxbznF6uBAVgE0?=
 =?us-ascii?Q?IzOJAB7zICeesq6y68Ce2vtvwhYtCsLNkHl7uN3vi3FOPpcBpYVclCnLpGCp?=
 =?us-ascii?Q?JP/xfsWWuXtHAdH8u+xD6POp/02S4p4ZizH8r1LvImGisn9jdvcRDcXtTWWy?=
 =?us-ascii?Q?GmIOVxJy19yyaq27RLIB9i1R3Ak5izEN8tngeH92S/tlHnV7uNF9EcicQ1C9?=
 =?us-ascii?Q?A0KyIT2V0/goyVExNlyw3oYVW82iJyOJsrANJ8v1c7MDAjcerfFi+lksKx/n?=
 =?us-ascii?Q?telkAGcCfd+Nu+m4QLNFh+pJBCo7oFRhspdK7aKvrASYCnjU6bC7pJpZNIym?=
 =?us-ascii?Q?MWtLcOqDdZaDPAvMqf2XxL6/eg672oJ8h0FsI/+pASTAtVr3c/lRYwh96/jw?=
 =?us-ascii?Q?4ma0CYnI3r16MARjG4KzVlETCdsOvDzjQv6WXlRI+kk+DS0S2SVqvOEx55ey?=
 =?us-ascii?Q?xYtdVIJn2731CRfB17F3UQ01t+NKq5KotBb/53Z7rixBztYlkSxjO7HjLhcV?=
 =?us-ascii?Q?kV2UfjEBqL5vosXk2OToZiU6b4qatFtcT68Dx0+D072Pj7gxvu3KDlEVvOxP?=
 =?us-ascii?Q?QdS88osF6lytz+n5FkVBe49xD3NSgINiJElJM+OOD14rrBeE+ZDhYV4A5of/?=
 =?us-ascii?Q?5dtjdC4Zdtb5+Y/tAMU1/3nT0iM+PS89Lzjg+zVSZ0aOs9qwozqoAqfJt4dW?=
 =?us-ascii?Q?APD0ZIqY5M9xYUL0LXQZ+ISn1d64rfQaR7pa+/IJ78aBCMv2JVlwuUnaWyRK?=
 =?us-ascii?Q?KTS+qSMQ//h/11DIbpp2u9ateSUsI30vsmhOcDAlse2fLzd5XMwGfRr208Eu?=
 =?us-ascii?Q?YJNLSkNFd2rzpBmzdhaWgrFGeQPKSMv4wVR7NXgALqCcMeMhFjDMkQgOsUc1?=
 =?us-ascii?Q?LwKALt+R62wOlbwII7faV7lEaFR7RzWD3tv3PeFlhtQrK9RW2g3OmT7NMtr/?=
 =?us-ascii?Q?A05SkOHakfg3hxqh+UiU2PPYOFUhNKgqq62hB8f7ct08/Vk8+cWjKUPUk8hh?=
 =?us-ascii?Q?R7WGr/A2tI5pgLplHyfaghuXAnIQ0Ts2Mm6YJhjvdQATo4NOAA+5ixGN0qy/?=
 =?us-ascii?Q?dxG3qfkk+CfzSCFKM9M/77L2NGnOV2xg2uvpd65/15bMg1POTPHkutv/oJeP?=
 =?us-ascii?Q?eNL4R8Q9b5yf/kQoaAK+nOhbu6ANO/Gmt9ZXN01Y3Qr2By/IJ8cZYp+03Uoj?=
 =?us-ascii?Q?EzT2mTgLkBUzFYOzIq/p0Ow9ICh6G14RFPVH7L97TlbJt6LAGQW0srB+3dHG?=
 =?us-ascii?Q?7CtpHRakYx9/+4SsQTuguXumSVZkwv8kG8WNDS6y3lj7zyna3EDP+L9g0FiY?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6ADC11707DBE1543A174C8E7AAE7F434@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j4ZhTjM3HYe2SL1AFkQ+XyBe9KTkMDGAXcKzo9oFmA9+n0vdDk4/VMuVObBwoNwVOHR6dvBBCQ2fylhFKwhkkiPPMgeVkJbH1RCOSJwtJXIEZGmE3jxrekYACrS54dQeZulzo1a3THDtfM0dMUA/SgVNdYJYa8NfGDaHarqNfbxxRmIChCgrT5q9jnGKYOIVzlgvJnc1gxuxSYSOS5HVhscP85xausVKspNJ5fCITnuG+Txv8C0IZs+k1Ndeqq8EKVJsZLCl43YyMapsyBtTqTTqgylaYW7q+KE1tM2Q5+iw4ii4+dxQr9NglsywXtgwTtUQV2QetapOHLt4abZf2ql7oL5RVz6mc7mBIN6ust7pN3BWuDfieYd+//K0jITJ790I+QpwjRUjufUaqHmrzNKQ8C7cTFYDZ/Ner9/QO7LIa0VBMWWtAghggjAZ0n1tOIevETIkbOUY9kHgkaSYkxz9byigkbwotHzYCsR6TO8ITYKdcT2etI5dzGI/ITc+EEneBHg07nGY2XHO0w+2waOYLKvb9QTgH4p7xnOK4njcTOMov12hLv2EFjT1nhIrE/N0XR3eFBwW9TeSrhZVszLQ5KCJCEXLiH4baSEBzZFWzBMNqavmrBKmeNp8v0l2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc4c7cc-6c59-4ced-8f87-08ddaf1bb9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 10:26:17.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DSrpKHzbx1kGIsxCR2+xvsCMTY0QpfBvkbspnKTSTPd4pGYatrCMpkVEx04ipKWrbn88osY2actImjv9Pnpu4i+Ms14uEBTdxu43oyWdNRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7659

On Jun 17, 2025 / 09:21, Zizhi Wo wrote:
> Test the combination of bps and iops limits under io splitting scenarios.
> Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bps
> restricted io from entering the bps queue again").
>=20
> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>

Thanks for the patch. It looks good to me. I ran the test case and observed
that it confirms the kernel fix d1ba22ab2bec. I will wait a few more days
before I apply this, just in case anyone has some more comments.=
