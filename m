Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BBE238D52
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568607; cv=fail; b=Q7wvgF9MOWZ1M300s9a9+tQjSrpxLtazf6VeT3GwY1F89uJ2Y+dOviMRSWUk38Z5qxGFO+3iU6jJSOU+cQFCpNMZaJIwCLUR34zU40s68Xgc2zaVblvW2MJ9jZXMQ6P4tHWOR8mK6MYqGLR6/VS9DtQXYQzJFe1334E4Gxxrlgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568607; c=relaxed/simple;
	bh=elKZ/ixcm8MmKCI8pQAE4MOVRVEGZqfttPE/ypxqy7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FX7FwU8c5/XuUQpKVCCfPoxPrTcS8IrEvC4DAHR7Lctu+9W+4NGiTREgeKIDfPFRLICPR9ueUqBUlh7Uz1sAsjLFilObAuqRVM8+s4k/8gykLwU2ykoVpJzqWzXl8Rvunk44w6qLyUlyeSy7YfEnnpFcyO1lJXqqxJ8it73MPtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q6pQFqRW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=J+NQick+; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q6pQFqRW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="J+NQick+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768568605; x=1800104605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=elKZ/ixcm8MmKCI8pQAE4MOVRVEGZqfttPE/ypxqy7E=;
  b=q6pQFqRWUaho8C8EEIPzm7nnXac09G3TQIcLClYc58/L9REfODvYkCgW
   jhMnZdpo529JtlWcfwW2tQ1jBIOlPGx5+LeapTh94p6sEpHUPqy09tysc
   dxQYumuojSpAiTklTg7Vs0ADSBbEpxc+8h6jM1Czbl5pTIu2P8t3O4lLT
   jbLEuV8xz0K+RSjbi3o6myvLO9ykUqVHkzZMpW+LilIS3Ha9hd+rsqvga
   pnSKky3q3sjqpmOw5DOVYNow+ILLDVwC8PQVHsSc/7EyUxUeykV6Dr8yi
   taav9tYgVY2U7Gkn2fa56Up3K2tVNJ7bM1VOneH89bLJaleq5qVHpF9ua
   A==;
X-CSE-ConnectionGUID: ZC4em5CCRRW7HQhXDyWy1Q==
X-CSE-MsgGUID: bSMYpYkdT8W6iSNQgPNdqQ==
X-IronPort-AV: E=Sophos;i="6.21,231,1763395200"; 
   d="scan'208";a="138921125"
Received: from mail-westus3azon11011060.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 21:03:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeLo58eUEQ3F7LZd3OgKuWwgYVGQEsJmXuD9lwU/QJ9ZVmydyOp4URuK30jXuS3amEbZijzrp+JMLVHEWySZzE86Bt5ibMu2QCoy9Rf43HaqhPeCFRjjjZ3MCXRFVlfK09vxF85DnVzMRLdQEVrr8a74/HWlVGVqbcWW2LbcUba6Lkk9zyuHhddCLyqt913KhJKOexhDx0ipgFvRzSdHZq26EMkqFwn/rUarFisOJyArMzkIDjmQzywiiwYmjifVwxOURv+beuii1X8X/JmyYLicifZUeIta9iFYDmlG2byawjUMTMubCDp97tECFcjMYmpN7RrQHQ36SE1GWRQ/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qGWaHaQ5DPO3Z8OqAp/71Tt7/5/P7rnNSszcKHX+NI=;
 b=cw5HbPmbmesR75gDIJZA7Njs/TDJ6lSKpIQueMuJGH043I/IvIqj2/xVgMc7Y+qxWbIlf1jpChrga9nIWjgIcu4JNdbcYGmk+22G+aRS5IWIiC5F6KIWHIhTTOrMmVD4h2xLiVb4PNt3mugKyY/72NzSrc2nvz42ObcypKzoT5k3z52+9olA/4htpHHkmtbS+IIr6y6jJbPcO+/m4kOCKRL/s+URi2xNt8ijKjqtSjylAJB0bP9TjDLHQu3io/9+uWIc28Ce/F+23mUBo6/fwVWFG9jUMfVmO0CTZFXDFNXRe9hQiXqFyz1F1wAesO5vyqu2i0eu2rBQL/ci2nuFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qGWaHaQ5DPO3Z8OqAp/71Tt7/5/P7rnNSszcKHX+NI=;
 b=J+NQick+zUpE0rnrj0WcamjaJn1WqvjVwzJ49nE6fKRtifYdTtuUTDst8fwSi3dHYSkvO07lWq5kHxqEyH6aUEvVAWrnEcYTswJ4U3AgsEQmwkm+RrqUnRq3BVW6c8somM7/xyFnWbPSI3q4XSe/JX4R2XjKUMhtZzFolZbmFSU=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV3PR04MB9492.namprd04.prod.outlook.com (2603:10b6:408:284::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 13:03:23 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 13:03:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Pittman <jpittman@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/2] block/042: check sysfs values prior to
 running
Thread-Topic: [PATCH blktests 2/2] block/042: check sysfs values prior to
 running
Thread-Index: AQHchZnujE12moSEB0+wf613H0JikrVUxceA
Date: Fri, 16 Jan 2026 13:03:22 +0000
Message-ID: <aWo2phhtvibIfQ1D@shinmob>
References: <20260114210809.2195262-1-jpittman@redhat.com>
 <20260114210809.2195262-3-jpittman@redhat.com>
In-Reply-To: <20260114210809.2195262-3-jpittman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV3PR04MB9492:EE_
x-ms-office365-filtering-correlation-id: 68a4f803-c05c-457e-b4d6-08de54ffa0ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IFZy1ozDM8eHxj4FsiLlHpdpNSrlAdn57ynX808pGibK5fOHlvX9Kcoj8trJ?=
 =?us-ascii?Q?gvMhJDgcCKbAl8G4eEJgn9fzJt2fJ4Oq+8RZpPTKEdX4IztEFSpcG3gQsvXd?=
 =?us-ascii?Q?Lqz90daMUE1eAaP5+qVhzlxEM/4vFsR8ShwiYM37mYXdzr1YclJSdi7CCaEd?=
 =?us-ascii?Q?M8nsPfFFehYrB4PRRsjajatCp9ocWkFqiog2vxRX5e1mnuQ4tckpw9rqiqy8?=
 =?us-ascii?Q?OEes8AEWjjSxaP1GIuPDZlPpt6oZ4nWaJUuO1hzABO1FgG92RAJ05bd24OyQ?=
 =?us-ascii?Q?muX0jcLlnoQheTb4I2juM0EKENYV1qasIc4dLg0QyqtiY31nDxYX3yYmKo61?=
 =?us-ascii?Q?IAYKvxyC9mgyRYvhO9dF8Ci6LklN40UDPGuBhGL0W7WZRik/pq1s4n32bCrM?=
 =?us-ascii?Q?bQPaONiosFGct9Z9tJk6H4m3CRrsp7B314rN3LPt1ILT5hbPI9WneRBKs+rY?=
 =?us-ascii?Q?Z5ZkXARBoy5MwtTZI5yWxDp2nXbHKIlJplc8zy+/xURZEZZIvX1VPYLMIMJN?=
 =?us-ascii?Q?MQgHCXKak4Dz7HD9LyBDOI5lSpCzW7+JPiFRtd/4XR976BnKJ0bNWjNeegvz?=
 =?us-ascii?Q?LiKnC3JxrE4Ubg7iqo29xxjC5NwbCkpbSDiwddOVeXL6oJNlmXA+0UhqF0fb?=
 =?us-ascii?Q?enZZRt09hbvYqsHs0uVUzx75FQ3CRet/YjLkndo7NGtTotzZe8foIfkjqZ2J?=
 =?us-ascii?Q?8LG9LIaIHY+CkvhMbF1N+nEUwxdFwQmfmbIYZ6pfl/832NkbeGsagcMtkKF9?=
 =?us-ascii?Q?i0Y7wwfNLSNVEdnab6qj+8enwOnJ5RXOv1pTWUHumQWMJSFXZNeYp3LS2xNV?=
 =?us-ascii?Q?LxX3frTJZN+VAUh+VEtZl0WaFzByMqokIN41EpD/14AlFdN81BDd35wEOAew?=
 =?us-ascii?Q?HKnaoXIdtHr5yJ9fTpyz9VJ2uaEFa+zmj57FXV0nBlz3O3Y0+iTWLq7Ude0n?=
 =?us-ascii?Q?c4bwCGIGx682q6Dgbc17FuF6wzpVjhrP9Bu5XiHW4FEQhGI35QrSuhBgwARY?=
 =?us-ascii?Q?Jsip+I3K+rnKp5UxHn7gTOIMmOhiYbrGAzqQay+Xie0zHSudJfafclCP7eho?=
 =?us-ascii?Q?adm8jidv6d4UtnHvwYHfmIIEH53f+lnP9+5z1lXhcBpfPDVJgFqrDDcZYK3U?=
 =?us-ascii?Q?HeRvCiBs/ZVXrqJ97PKzSns749aB+vH+OBzsxphmH6+4I54PSCbe6G6+8NtH?=
 =?us-ascii?Q?P+NECnWKyPlQPkf4HfdzuXIf1ee0rTflEz3c8cF0wW0nQLTMzz8XLlwQBvQw?=
 =?us-ascii?Q?2otpDNWqEoue5ahUcAQ3F00VFSQr9F/U7ismJQuabKDWW/Vl/ZDZO/lS2JOZ?=
 =?us-ascii?Q?iZ2xLSJCtMYfgXNpU5/uZgiAhoJ4Gxqn+OfLXL2QGoaC5wR9o6X+ZHyNGXIh?=
 =?us-ascii?Q?qMxytwBRMI146mXRQon4xgHxrx0d9M7EiZnHwBzhStQtMSXbh2h8F+4MKRYC?=
 =?us-ascii?Q?eUr4gwVkBrzv68C+M/yvrr89NyQk4O1zAk93FlHEJGRWBvmh3vB4yiwlONsT?=
 =?us-ascii?Q?c7rh0nw8HCBhQTAs1VRWAJ4WV569SUvM1IgHEER1B73sR7ez7kviVp6nqJEb?=
 =?us-ascii?Q?YDN/dmNCRaZGBYJq6QXiNaUHjEk0ed2zBoOzD/bzA5twdwkZANkPDogwyX2A?=
 =?us-ascii?Q?G4ZQxOlEOxIchvaR5ayyChE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rVYYdtM3Y6HaoKkX2H60EZcRuob50VYnqXGWBAQ3Mz3HsYX9A3c+Ns9+wuHN?=
 =?us-ascii?Q?c+JZTp1HoqFqNqPkG+HKuTu9tIiDYpc4VzUGs2TbN56IpfssT1vPQsHa8RqF?=
 =?us-ascii?Q?UXD/+cHbtqwJHOHUGmLyMwn+x/6BEtuEmAnu6omvTTxEAAqWF6A+U0ow4J9v?=
 =?us-ascii?Q?ghZZEoHbM7wDOV2w35GAh+CA8XW8t1xOZeea1/UhDBdRFhTviM2q6+WPAJzN?=
 =?us-ascii?Q?Yz3+QbmXP0W+S63v7acIcSaGu+6P2+gJyc/HPbtQeoGn4+ENZD3EHJY+4Hql?=
 =?us-ascii?Q?6wf9pwww/4ZK3788AS6tNBEEb0Iauly6VLjpFIXDQ88tdOOwVCIbL/HH/HjA?=
 =?us-ascii?Q?2YeBpGBav9nxT9kpCOwFoAhVEWpYqbiGQaPgJtwL2Izg92gksF2E3Jdeh3SI?=
 =?us-ascii?Q?7ioY/+RBsx0taIFvaWKxpNJ8R7b55UfXMUI73bR2ur3tvgGy+aCxdKSUb65t?=
 =?us-ascii?Q?aqN0b0tjULc3AbYe2hPDEx0W7EXuAnQ+wEfc60HSAiRPT/KQyLtJT76Kuap1?=
 =?us-ascii?Q?fHaPhkjAEq99L6fyppkv0cksFuN+J205hSihHfFRvJCJf4Fo9q07pWD9cOfK?=
 =?us-ascii?Q?kZ3fxaEbI2Ivt4JqGKBmLsM+CWFMSdFK/mW1ug6SoxDz7XkUDIPz4ssvCAoY?=
 =?us-ascii?Q?1K/EsxDLSoHLZgYSKHb77hLCXiG7BkbH1wpR7zIKSzwONSVcJ+4DuG7+O6jf?=
 =?us-ascii?Q?s/22EtOwnbw29QQRJkHkoQCR8wVPfkfz6nbVRPbRfYIDUynAxqfq+yNJa8hT?=
 =?us-ascii?Q?5KllIpAlYaQPmZyn56niE3K2kGqRxe353Gw2Qv9KETTUqVDenxsMAsu3XIWW?=
 =?us-ascii?Q?B+h1RQH4px1RMwzxmlI0ai1yqEOMHd/s5LG1x2nSxquLmzIK5SRg9id5L9Jp?=
 =?us-ascii?Q?0ygoHs3ddzAiS/i5Jw6BVrrQbBY18MZXw267HhFgsawWDotH6ve2okNGT9xR?=
 =?us-ascii?Q?+b96K1RtBUbXPeiVwh3CJHWNGi1YP9NyrAGGrLiczpMcf6GuCNneMilT+qUS?=
 =?us-ascii?Q?RMTj7UnPnTGfLKZWQGsS9Rbrqcz2H364D1PaWduFhg4WxglaxWfHVshjrUyC?=
 =?us-ascii?Q?t1GOKLvOUnfTi1qBqaxulJNzZowY4RfD5xwmrXZdlTUklXu5goV7f2QDT0IQ?=
 =?us-ascii?Q?eJigpK0rHqw/sNgRAOoKN47Y2P8wa2f/maj6rNIx6QgrrejFhcO6fOReGVng?=
 =?us-ascii?Q?LmbWdeaVaE2JiNzgC/lFunUfifqID1ntTmmTmEMqv0tqhWNyA9e2VAwtBOza?=
 =?us-ascii?Q?M7jcy6WRTTwyQkpwQ16+JmagzmxzOlYIV4mdtuEiCZV+FDWKzK4UAE44Hgoe?=
 =?us-ascii?Q?3D4RbrY/wIPER2RG/EZGQEP1edWYLDLswwapB+raXXWBSQIyZjPHK4f4lcY7?=
 =?us-ascii?Q?xlBiOBgYNk/Jn9LYgAUcmcSouD8BP58+RQTt0L0WasFuv80NZUx5M4sekHyh?=
 =?us-ascii?Q?ggtLsvtrGuSuCFiadpgORPfxxZlWpIPjpQIPJ/lIQ3zY6ykZewEuagUAZpQ9?=
 =?us-ascii?Q?9BzEI1F/aCiwXYyafxv+PSwDICtejexdIA0j+TkUUKYrR3ZWFap+JFobyItY?=
 =?us-ascii?Q?asR/jKtNUHUUGhal6KvjRjngyKDfGaa1NDYMuQxadK7+I3yIRM06Jfe6NNGh?=
 =?us-ascii?Q?HaUh+WbrZtYq21EqtksTgKKbS4M8g6wRChMZmLY6z2aaTBJSG77j4OPOV5YY?=
 =?us-ascii?Q?r1FwlIAD0HrFtR/n5A/1qm6tEyAQ54Hs7tvhpyNnAGDBTsi9zGexaDTr+LfF?=
 =?us-ascii?Q?EhToTvW8gPR4bl9Gonj/rseUOmH3kRw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <531F18781D2546438F1B2390C2FB20EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	03HYTam7t6RPhk6rcivYH8wVhFRKk7Mv3wkfWd1O0p5lIETxCxogl3EXnAAGLPBj8EjudUTeuFsqIKsBz06daWZEUo897AwmUKuduCqXkSxmpGw2QTm1cjtu7MACxGCsRt/JWqKTOHL8TE0fkYVPs9EDj0b/9ZqPbywgPh8UzyC2Cgpl3gAOT6CjVbZO3F9sUJZiCPWl5RSXVVvcFBi8k4VDUAfnBcAUxx6rCNMXMGAyjDZrPKRYG/YMbQow36d/R6Zt2yeL21I1zf7NAdYplN8ocQLmRxsylpXGbYHzWkBwoF/soGZettV7OoPSZE6virdgmboWKFD6sev0zWxx+XdldUOUfL40+XISODjPaMqXOEqMHvtvTY8peeY9rp5QMYrRsSoChZ0jySmLGAbW8zhaT0h++7TYAp8rHT8nN2SqmIatm/oFU4pKi2iNwe4KMNQNJcQm5Uy8w/qOTcCHxZV5nN/UO0NR7QoLH+jKb0ggQ/vKI3JUHTZ6xgnjQJaN3+DGEu8FSRSDqrPYVeaIRnuqX2iN9JCjQng77Po9kXD069fUoLhFfqvz5qmcYYumvYUY5CTny8e9F25vJJq8JaPzqDKF9PB14pZu8bvkaJlbntPjnw+zDrB2bOm7LG4B
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a4f803-c05c-457e-b4d6-08de54ffa0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 13:03:22.6059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Cg49CARYj6edp1siY5yQPsk4pE99WhX7N1kSBj1HEa4qNITeK43vdL9yV503/Lyk+h2lsoDIzmPjPgtYkAZVDz7qM1jTKWX8IoXQu0YX38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9492

On Jan 14, 2026 / 16:08, John Pittman wrote:
> In testing some older kernels recently, block/042 has failed due
> to dma_alignment and virt_boundary_mask not being present.
>=20
>    Running block/042
>    +cat: '.../queue/dma_alignment': No such file or directory
>    +cat: '.../queue/virt_boundary_mask': No such file or directory
>    +dio-offsets: test_dma_aligned: failed to write buf: Invalid argument
>=20
> To ensure we skip if this is the case, check all sysfs values prior
> to run.
>=20
> Signed-off-by: John Pittman <jpittman@redhat.com>

John, thank you for this series.

> ---
>  tests/block/042 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/block/042 b/tests/block/042
> index 28ac4a2..bbf13fd 100644
> --- a/tests/block/042
> +++ b/tests/block/042
> @@ -11,7 +11,9 @@ DESCRIPTION=3D"Test unusual direct-io offsets"
>  QUICK=3D1
> =20
>  device_requires() {
> -        _require_test_dev_sysfs
> +        _require_test_dev_sysfs "" "queue/max_segments" "queue/dma_align=
ment" \

Do we need the first argument "" ?  It looks useless.
Nit: spaces are used for indent. I suggest to replace them with a space.

> +		"queue/virt_boundary_mask" "queue/logical_block_size" \
> +		"queue/max_sectors_kb"
>  }
> =20
>  test_device() {
> --=20
> 2.51.1
> =
