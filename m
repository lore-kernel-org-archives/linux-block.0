Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF32AE68
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770253127; cv=fail; b=JMCQRZ8G9XRcrf0SPLS0JMhOATOFwfGq6181dpLFExhlG7ZGuPBXguJt2SET8DkNuUq6ejVNe48mydIhkduLXFAGBbxvoi50NxAz3i3CNsJpZgrRnEAoKM1yuIg6T+Iqx5Tk1vnrQGPI0FEFSxYoW/BXnkxRzL0pMAzhLO7RebY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770253127; c=relaxed/simple;
	bh=D5q6/G52vatCSxROqT4InMAWdeYVElzKxxEKvkhL2r8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UnUKFjRBEB29Q3QH/8gnP1RmkIsSbRVzV6vtd9mJpXm90Fr/4HirnTeXVvQ2seA5AXWdLqCOt0YI7KQjFmyNYCrxWgypMuUPDgcbkDqgci7EsipgML3drNzuIb50vqQwFUn7cwnMabAYjv0iBDWZqbm/sTWs0WJ/Ayd4xoHFVdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OstaNPuV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ki9L88ex; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OstaNPuV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ki9L88ex"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770253127; x=1801789127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D5q6/G52vatCSxROqT4InMAWdeYVElzKxxEKvkhL2r8=;
  b=OstaNPuVsDL3tdeUWuN+Qct9nBMY7vrfM+lhWuPs8v01AvKGdw+3gw1C
   loqf4lqnravKum7XUEi9N/RDJzyEJ0nSQsWgiU2lhi8tQM4xn2qB4dHgS
   OajhBRCKbS9C9xiGnwqMJwTf4z4GbulTOrW8fWUJJ773uXC9LCluOWsq/
   3W6iuVbPHRwGtU85C59MI+f0vq9YdT57txjpiN9D3/xeH3WNlj6PqygXx
   qQIYJj1B9GkJw7vkSS/DcNLV5MR5dWEz0TWhQAmRdwNzjt/GMQ85ut2A1
   6yI3oyf0wjA5bA3Ttpn8fFWjkoQYe6WWrFdA1YCBbOyMnqA/7OWDR/fW/
   g==;
X-CSE-ConnectionGUID: Ayv1GcnvTPWWSZr4I270gw==
X-CSE-MsgGUID: ietfmpkyQy+kwIev00mdgg==
X-IronPort-AV: E=Sophos;i="6.21,273,1763395200"; 
   d="scan'208";a="140755389"
Received: from mail-southcentralusazon11012021.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2026 08:57:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6dsiK25NXInpN/Q0fs72KvA7sKQtKM52bsTb9+ZdBSaDxFQbDBHSRm6xGg+P84cLiVKIuUfJdoJ3tFEhtKCk6YzkZjGHjKaGsbD0ZeQCIlXlxQ+cNgMDkn6NmZfEu/r/HqJ1oA3irECMDYuipr9bnqQMESeaMeSLaedoLk9cSIjkdVW/NjAHT1v8l97H6K3DrLF8HXeVonafFLC3COh1S2qAO++BLjFzi+R9uVEIR0ZlxJOefR/8IM2o6zDz5GAYasBHIseJl0HRWdekAOOfWoTk8YKvu/bwNB00RSwW2js+16QzaZMJj/PPoeRxi0y/qFHP3Euur8MOJloBTFVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSZ8WQg6qIyLX8FGmJDC5h/U85zBm+XiKplptj0WAsQ=;
 b=gnwZPPSu1vXHGRbbanxCcSHh3fG3cQooiaXqH7bDXxwSIfqtBOxGu8PSujEbX0IFR4NTEWfAE2LVdayeVBmZJ8DoNowm0EG3sRytx3LR+uWE+B0vUzNZREavhgQ1y61hr3L2NwRcR7UijI2Xgbb5qprENq8S90N5B/GjhjNErNAE4z12aPLwIvRY6KRYISxEg+xbQq8Js3RQgtFLrNsIjk3LV0wYbI0CquryOEv6UuyiCY7mBirlXkbQpHX2LwK9I2+ek5hLY6EiNZ1qmp5yfYvYhHQSFcSjJUv3B3bbOZQ/pfOWML1HJqnABnYQHTgeas4cor7i68BJpvIgjZZTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSZ8WQg6qIyLX8FGmJDC5h/U85zBm+XiKplptj0WAsQ=;
 b=Ki9L88exP3Qd7ihkBA7e5fyZlZ04X+3hwjdU0Ir5r1Gku1RsM5RZDuToHauuR97FE/g8L4ziq9a3XrgyCBQW2hgNcjf41kYegd07bTrc1M0BUups/Js2W9RSlxsHP+QnaTkRJnWZWEkGHxUu8zS9zdD0NWpASt3ro/4m6QV/sEQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN7PR04MB8673.namprd04.prod.outlook.com (2603:10b6:806:2ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 00:57:37 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 00:57:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "sw.prabhu6@gmail.com" <sw.prabhu6@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"vincentfu@gmail.com" <vincentfu@gmail.com>, "joshi.k@samsung.com"
	<joshi.k@samsung.com>, Swarna Prabhu <s.prabhu@samsung.com>
Subject: Re: [PATCH blktests v2] nvme/067: test io_uring pass through for NVMe
 admin queue
Thread-Topic: [PATCH blktests v2] nvme/067: test io_uring pass through for
 NVMe admin queue
Thread-Index: AQHclHn7mIjVHRBrRU+d0zphS0gOAbVzS+CA
Date: Thu, 5 Feb 2026 00:57:36 +0000
Message-ID: <aYPp3qZTFTmdBRMq@shinmob>
References: <20260202192631.194256-1-sw.prabhu6@gmail.com>
In-Reply-To: <20260202192631.194256-1-sw.prabhu6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SN7PR04MB8673:EE_
x-ms-office365-filtering-correlation-id: d85d9d0a-fc5c-4dfb-4e3d-08de64518ddd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?StULYJ1/goptAwRy5WaeLSSmYERfTY2VkIt2/lUBaEP3auHu9pPjgUMDXsve?=
 =?us-ascii?Q?FkQAiCcr3BnkzcLVHu+ZhGdbZtC3ucilEIkkyaDD6JpPc2nqxGswPCLqN417?=
 =?us-ascii?Q?9V7kEHUNLQDlOTf8byis6sm6zNg4x3xpops1j+6vwnGOa28Bk8zhEUck0dlX?=
 =?us-ascii?Q?vRTrn+wvapcfPtQ4iFyXoqD3962vyHBXoi9ELxmRkekW3pV99DxeJxUakdfd?=
 =?us-ascii?Q?HIi3tJJG+pmWCW5K0T1BlNfGmx8DmCb/P6z3SS+/eLVc9IZqhyOLsCQna0Wc?=
 =?us-ascii?Q?N8eGBTR1/PPHsMs+VJJn3tYWoezH0jt4iqwPPvd0hIqEwcGj5DAOBKg7RL4f?=
 =?us-ascii?Q?J0GHXSMukugYeyfrb5nGR0W0erUF2bUJ6KfbWhF12mVQrgB2UVd73TrWymdo?=
 =?us-ascii?Q?g5jDRe5ImeTdCYetNc9AX5SULbQYooY9GoqrLGexcdC4nGAv5IGz/S92TN7i?=
 =?us-ascii?Q?EdbjYXx8qn2VkL29y2apSRVS8TRlmb7recnKrvSe9r5klUarGQTii3pXveRm?=
 =?us-ascii?Q?lXrkM7NuOfqRpoeP2oxJUP2P0KeCdIYyjWA8+A/tLb3c0Dvxf0QsCSlo8VOx?=
 =?us-ascii?Q?zHeLwtcCTTwDYBlSS2nz+cKySbC43jKNMZFpQg1uR7INXY9odAaNbKDGQu51?=
 =?us-ascii?Q?pJbPR/vW8gLobQpwW5JT8EzzO2rzGy2HJJKXCGZ+G+r32FDqz2fRvCQj21qb?=
 =?us-ascii?Q?VpCqv/I3f41w6Elxssqa2rdJbAZdMjK6C1d5wM8Z7NclDatcyXwpysCyqkDU?=
 =?us-ascii?Q?Ul/L+Zxi3XkVq2o1bcGQOQx6gNsXWpwFkmMupwYD09KN0a4PGX23FPkMJq6U?=
 =?us-ascii?Q?wQ9r2ixriOf+8qzwG3P9C8NVsvnWEcMf+h+iqLnP2t/4mOiQt3iWSOFxmZYZ?=
 =?us-ascii?Q?JvVQ4T242EHYWNdw/TqK7dwGkk/sVqRLViuq/1TGhB8xkCz1QDT+tT4/wW5E?=
 =?us-ascii?Q?jgKDHfy9IqkcSPKqRePIeOrOGxpfHn1UIwugFT0XKozjjJjNj67AMfMxvhKs?=
 =?us-ascii?Q?DLPDzNM/CXvnFXw0uy/e4DqsK/uYds4ccByCjbmNnidQBa3SXwh5E6ur9M3A?=
 =?us-ascii?Q?TFq0nDDp4b3hNH1XGHUN4pckXZXl8Qvd833LsRVDEodO9ejFdbm7jpotw6E0?=
 =?us-ascii?Q?V2HI0P7sP0lmkjLF0PhyqbFsP57RVucUz19ifEWY/1i9jwmqlyhirZWdV4t0?=
 =?us-ascii?Q?lST9RqJcT/fipkQvbV50+egO5qmoyagwNljzZKJ6mUE5Zb2DSomgAe80FE/X?=
 =?us-ascii?Q?CXM++c0HJVWB5KfGtLo0bXFi4zhV0nVT26drrNnHniwAev6uqwrR985A5jDj?=
 =?us-ascii?Q?tAk0/SaHIG8NmaJ0dZjr3uvnLDPEunoLUq1ChCE3dhDnLaR5f2LieBb7NOU0?=
 =?us-ascii?Q?sL6siJOIGx2RvnCpUN4lXAjH3dBoRtr1T7ErrB/ujQJ2XcJ8zjxRKf8D5cP0?=
 =?us-ascii?Q?3H4/r0iSQZZySfuFpUAM+ESsrcyU2unOWJSjGBEPIOUs++zodmM7bbwm3iOY?=
 =?us-ascii?Q?rMYdZSAX/c+5GMwyo1b/CZ2c/MZDW2Z0h8TW4qscL6T4t388nHtOdJCOCVT2?=
 =?us-ascii?Q?69NB2JzyrC9UVegcW8mKcuUeLRXAqlEpywRFqoo7jeFskunn2bLgRL6Fmk9N?=
 =?us-ascii?Q?6QQAOs8E/JGuIQNqNjifb4k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n9z0+QXpZk6KB970y/IVVSHB7+xVTNoFiUu3xIuOm062/Mfw8Gwa7uvlCNPv?=
 =?us-ascii?Q?y/suFm5+78u+CaHDZxUhENaJOXXc2Fh5YrsO20+GmPemCUehnayVWePPZ5ip?=
 =?us-ascii?Q?R3Fr1LWSJ22JjMxw3tPHK8KwrMY03bQjbxRT82Jp/tZ7cicYQasvwkwF3HOP?=
 =?us-ascii?Q?bKMO8bofC938sK2P84xfVGxCOKjdomPUyxzUTxIELdymWoJKXJKhoPPCgBcN?=
 =?us-ascii?Q?uhTjX2Ko6WfdypfPfo+EVWivcraBQ+LHThC/qP6heBZrr/BeoFNijmAdUJJ4?=
 =?us-ascii?Q?+fO30+XYFgorZcspP3h2gXF4N7M7cvKTB4GLQic+364xh5Evtep90JjGbbfb?=
 =?us-ascii?Q?d5c+iaRQdsgYhCC0jZDLpUgCFuDn4VVCYxhMHNFQDH8EL+0Kx0q5MFMz5AS+?=
 =?us-ascii?Q?ckkL4O3NyP1cMvOFbVjw65Ptm7dbTLLtQvLSYWA/nK6EY6mHnNb3DLOpsOHl?=
 =?us-ascii?Q?vG/PBiLog3B6fThWDkr5W9OiSe9eMZiGcHSdF4WKAU89bK2LLK8s/324naem?=
 =?us-ascii?Q?shZgw1TPJj7Eiu8q2z/y1lLQTgtqemqq4NrcoE4cMxsgAlnR28M4IMcj0VsJ?=
 =?us-ascii?Q?hMCACKwED6HORLVr+JlickQu8Bb/LEiOAUuznOgEcDuyiFRFmJ2uVIMj9X0Z?=
 =?us-ascii?Q?+aYeF5d72zwgFTz4xhOp7ch6NpFOgM64iFsXygQ+uE6AtMKkiynWzWBrRJNR?=
 =?us-ascii?Q?KL2qIexZPMkb7F5JxPYblTbFYzatRWSDgzeQrmaOI/iJtHMNdAyBcMhdv7Nz?=
 =?us-ascii?Q?ZRJqFW3tr6Zsa2PVlMSOwQ3qYpZBirFa6WWoXkNqxbfOcvj2IgTZNHBV5Yb0?=
 =?us-ascii?Q?KekbLYMmOegTK6LvF4TnAMnidgpxRT9pXUnU1LU+AnOAeSSXIWp/mjFkN/go?=
 =?us-ascii?Q?8TX2QTfRT9+uQTo5DUMzSpev6suFapG6BTAoghhncwKL/atpYFQQmEsKjY+G?=
 =?us-ascii?Q?ZJSvJvP+0vqDRCGdFmpPNslBo+rO+Fc31SewBcBSHCTE61hMqmE0gC3eJ8hP?=
 =?us-ascii?Q?FuIDpZ4nqKHOrXdP/8aLwU93aAGuQqBQTK3QzbiUtfjl/Xcr+ygXoUcSMGP1?=
 =?us-ascii?Q?yytg3YmK6qK4+thgoHuuM+/N8cMfpck1EajtkSjVlUS0RQavQlPVmSgMWTMW?=
 =?us-ascii?Q?swbljoFZ7xjuKn3CaFtHlJuSdC/NRh7VOr3fQRcLfVwfcoyIEiFQUnt6VoEj?=
 =?us-ascii?Q?3MLPUR/Yd1oLwmZUYaXPVsWhWw/6hHy9wUKI5uoSk1xzlNBRGJ6iTWZjjUSx?=
 =?us-ascii?Q?A0/6E+39yrhV1mYiiPINcdx4fd+n3K/2C3k/rgnTUZRWAzycLgraDCW+Kk6Y?=
 =?us-ascii?Q?nSFchoP2jFbq4PDtaXD1SJcf53wnYIpxgzqQ3oEnlopYMtWWz4WoHbwmihOq?=
 =?us-ascii?Q?yewfAgKrg6igTB92SmZ948eC4mdbJdj0QybDhfNzg4tJoASre1hkx60c+lcz?=
 =?us-ascii?Q?hDMApTFPRLMVUM2VtTv6ewK8VlsrNQrXJGwM+Z2aaV99wwE5wbVctdwknkcK?=
 =?us-ascii?Q?ktmfMAc1b9JBJ162965fef93SzJTlTSoj41LUR8bUtM8aJWsUoyTqXtiKs01?=
 =?us-ascii?Q?YqLYMcrp7L43dozkfzobjOoeK7vJ7QjxwXKSD8dNZqvz5mSg3ghpk4GFGbnr?=
 =?us-ascii?Q?C6l9Ft2I83zC3z9tbpJdag/+3eBS5gAfnM1A9IyR42kemKNBFuSKUU2epGHW?=
 =?us-ascii?Q?5Zv1sVAT5uQTNUZZibBuNMq19wcPnqOPnY7/b3rNfrsXcPn3YVIAJpYFtfsr?=
 =?us-ascii?Q?RkjIw02ielwKSdMdBNw9f9G/4/Z/0Hc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BACFAFD4B0C3C4A8DCE4348F59E7379@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fUTfHeUMf6Y4cBwOzqWCf2fgwxNfTG2iHQSh+xTYzQmQp20Qy984RC9Onb24cf9C0WnlC7z31dB3HSCasDDgF4BQWC6it6ZBI1qkEe3GCdSTFrVXnSby1gBk6ZtYjJgirQzKtRppAoMFfvV1H67K1bgBUsVZ36ABslrrgvYmm9rjaBI/9Y/zePmTCz06ZzNW2PHiTcUhxX03jGi1IPARLviozAP0deEKNhCUUGtHeBpZMKhS3Cdm9EvR7iCq1UoYv3BOQMLGQVs/bT4m/C5+fI9SqY32nqRJmx7q8Uc1d5GpsI/0cTE6uoy6prllhL/KHwNTWeikdtMVbHKj10pshps/nueQpujeeTazfcR5+wrUM6FS8LbskSPUoiLM5tYNz6Odx4IImgULQAmraX0K3wI/CEVISqyZo5Nly7ZdRknsWVUQFhMgNxjVcsXoDVE61d6/Y/rJAuAu7AoZYxxpewVlvezJ/rtGpGohZimwa22O0zWVyYLlq1eXzNcessH6EZby7y1SZDN5qKt9q1+cDdz/EhA9cPjveAYMi+ctNj2uu1UwlHdRQimv3zAzqwzzVadQ2JuIaOreJ5SSI0/jHlrbE2pIkFJau/tgsbyPfg+lIgun42BDf46aI22UorEW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85d9d0a-fc5c-4dfb-4e3d-08de64518ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 00:57:36.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tQdZCuxUn9ElNa2/u1MsR7Em1Hg5jomtZirogl5O/NvRZk/xz+654Q2u3mzClO7Psy1BBrJq5uhoWP6+A0e67RjY78cQluW+3swc2Ot1Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8673

On Feb 02, 2026 / 11:26, sw.prabhu6@gmail.com wrote:
> From: Swarna Prabhu <s.prabhu@samsung.com>
>=20
> Simple test to exercise the nvme admin commands usage with
> io uring passthrough interfaces. The motivation for the test
> is to extend the kernel code coverage for NVMe admin commands
> via io_uring passthrough.
>=20
> Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>

Thanks for this v2 patch. I applied it. FYI, I took a liberty to fold-in
some edits below:

...

> diff --git a/src/Makefile b/src/Makefile
> index dac07c7..bd94636 100644
> --- a/src/Makefile
> +++ b/src/Makefile
[...]
> +	if (cqe)
> +		io_uring_cqe_seen(&nvring, cqe);
> +	io_uring_queue_exit(&nvring);
> +free_nctrl:
> +	free(nctrl);
> +free_fd:
> +        close(fd);

I replaced space indent above with a tab.

> +
> +	return ret;
> +}
> \ No newline at end of file
> diff --git a/tests/nvme/067 b/tests/nvme/067
> new file mode 100755
> index 0000000..38d55ad
> --- /dev/null
> +++ b/tests/nvme/067
[...]
> +test_device() {
> +	echo "Running ${TEST_NAME}"

I added local variable declarations for devname and ctrl_dev here.

> +
> +	# extract the ctrl dev from the test dev
> +	devname=3D${TEST_DEV#/dev/}
> +	ctrl_dev=3D"/dev/${devname%n*}"
> +
> +	# enable io_uring when it is disabled
> +	_io_uring_enable
> +
> +	if ! sudo src/nvme-passthrough-admin "${ctrl_dev}"; then
> +		echo "src/nvme-passthrough-admin failed"

I replaced the program names "src/nvme-passthrough-admin" above with
"src/nvme-passthru-admin-uring".

Thanks again for the contribution!=
