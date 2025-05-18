Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09F17A2E3
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747612474; cv=fail; b=WXoN5DGUUzzb6lzUvfJfeuT2xArpnGr5LDwXBMi5ANb8uAb9LxeiQt+rcgelN0qdMBhOn4Ke7V+JbR4TvFQz8mxFpQvGyligNsMwUiZkQNJAesAgfZdH9uWM5p54CRci+fRjgQEWNsbDdwN5dIsj7wYxSrswBOW7yQ4DZfeZk7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747612474; c=relaxed/simple;
	bh=PrvdL0QT6CmFGOk5sOTGowkaw8qwUVlBJaiO3oXRhSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNKxUPSY8ShZPIUPqGsQ7Sc6nKBV7m7rL7b/jpy0oXHrNcZAzeBsQs/aqjK2Vwj/5ow8dFAI12rHsUQ2NttuebVpMEhrlf9XAJRks27rGgvpjsT99wQGtfEKr1bU0RKnG1dF9vOrUxtJZcyAdi81syXDSA6+rX+0LxIcaLmxG9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RpAoymJ2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0CErnWtb; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RpAoymJ2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0CErnWtb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747612472; x=1779148472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PrvdL0QT6CmFGOk5sOTGowkaw8qwUVlBJaiO3oXRhSg=;
  b=RpAoymJ2gmoXM+m9n/wLnrBZMXxhgFi5TqrI2cExiAjhB/mHN9NIN6yR
   c/yZVf9UAdUQ0wwn83J2SBnWscpBVb/At8wPGBE+ql0mw7F6oI/MzFrlQ
   23F1iPQfgJA4QCCbFtLqTPsPY2eP7RsCMJMIXMcD/vbVskbT8ooFmZhj6
   6QQ+IyiJBi3CeMoaodH1De2JdTDrGOD+Yl++lvjUFMLOb9AJt2Ed3JR6w
   h4RpSLf5HGV5F+ZI10vkQMVD/tAz6jtMllK7TXlY0io+ZDKgv+Z1fyfpT
   Hbtn+/V4V6vg2ZgPJTz4nq7L2YvtK8lYTAHsLQQWfvwhps05J89GuUiL7
   w==;
X-CSE-ConnectionGUID: tDcFdzWJQEKfUTWk84USHA==
X-CSE-MsgGUID: 45kOE+C7Q+6E7Kn8UgB2Bw==
X-IronPort-AV: E=Sophos;i="6.15,299,1739808000"; 
   d="scan'208";a="87398201"
Received: from mail-westcentralusazlp17010000.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.0])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2025 07:54:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR3EtbF9hU2cPMEac1v3HA8UAZ7uYsjd3qh1+33xu7ouIe0BaBsTT1vW54fcJaWiYqo6TMuYruvoLQIbBOhTzNCBwhqnLeWFAWfA8DWgkkGlJyIVBaRi62aYNe42DF3DU/2tS8B7rxh7jkUscAauTeFxr4kZZSfVuEhJg+plihNEeGd3ul8ah2EVukmR3Qir0fYPMUbUPH1nPUWnwqjOvOrCVE59Hl4TwU5lQtT8jCRpGX9kBJWiKjPMXTEx1PQfhMbw4LcQX4M3s6YjVCVcKmwFvRkfC8enflM6UWFi+0Cdt6IN2wmhQov8Klf0OHmXoCv/jj7TQgyN9YEz0ro/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaSxcrPxDNF8OCw309GyzvPIkprw9o3Nvr3cxnA0Cf8=;
 b=vDn7XarJySKMjG8czWnpYfLsRLYWldxuPbiXZo04QhXctrK/+WIq/3wnzDgYBbYtNQPLDMaGjwxQZwBVAkj/PW+0icXYam+3rcUJJCN0FKIXINqBrTiij/X0SOiHlTkqT/3S+f6lwTKFDD45gY8z+2XZDyvaweI75pwqP4zK+yI7woUMI3ITVS/bi19Qt6OZYxJaUpbaNhBARTJOz4C7R17fimUYVI6WGryaJwF+EkmGjXVmcHjjn0AfQ2gvxE0+lf3dU/j5dZJn4uHTDfQrHI86qpi52UwDLEAoavv4OTkjvomtU9UeOTTBh8XUAEduFdXfbtiEUh9TT376RUgm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaSxcrPxDNF8OCw309GyzvPIkprw9o3Nvr3cxnA0Cf8=;
 b=0CErnWtbCq0WtTZsxz1poxZCxI3aaIRaMQQw4pUBACLOusmV73WpYr73HzcuYrb+yubYzQyWusN1cICAZSnP6EC9wh3dw4/MjU8oaH65cZWzaBdXFiT0n72rEMnFV5611vGZbvkCqyZ4Yp9OAYq5wcs+KsHxf4i1IaA1WPFjj44=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY1PR04MB9633.namprd04.prod.outlook.com (2603:10b6:a03:5b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 18 May
 2025 23:54:21 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8722.031; Sun, 18 May 2025
 23:54:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jared Holzman <jholzman@nvidia.com>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Uday Shankar
	<ushankar@purestorage.com>, Caleb Sander Mateos <csander@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, Omri
 Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: [PATCH V2 2/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Thread-Topic: [PATCH V2 2/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Thread-Index: AQHbxHKce2MexPIDakWQe+5pgo68q7PYyLOAgABOvoA=
Date: Sun, 18 May 2025 23:54:20 +0000
Message-ID: <tuw7qsrw5z6kqruburhr4jgxj36hmwzazj7lkiwkop3xucf36u@wz4pg5gnlktw>
References: <20250425013742.1079549-1-ming.lei@redhat.com>
 <20250425013742.1079549-3-ming.lei@redhat.com>
 <mruqwpf4tqenkbtgezv5oxwq7ngyq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn>
 <4395080b-7628-4290-9edd-ba442f0e096b@nvidia.com>
In-Reply-To: <4395080b-7628-4290-9edd-ba442f0e096b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY1PR04MB9633:EE_
x-ms-office365-filtering-correlation-id: 88e4ca0e-90fe-427a-0dd8-08dd96674f0e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nOb5K2GHRSzhqsXI+jGScvc0BKctUpmcSDX/uKndAfJXKHQpNhfKwxsag5h0?=
 =?us-ascii?Q?4RmyXfdIYWIMnwv1bEjh4VWBNpf0cPyqr+vvSfeoWw04KF5KlSiQzBWaCtZ1?=
 =?us-ascii?Q?NsouJvO/dHAjGPsZk9AkSYSxHsdyCgo4/Ce+l6RpXfO+3RKD3a88M/xV7NrC?=
 =?us-ascii?Q?MQBsDTLIfW5/G+jSQGJfUYf197eXku/Dt8QDR5HAjU1R7VqBgiiboFYYAlGt?=
 =?us-ascii?Q?VEDEcZ6wngmKAn8GRPA6fEDfBUE8v9TwKxV7PXnJldUKnupoQZEOdDWoiUFx?=
 =?us-ascii?Q?q3nGzOiNAXikGcGetHmYd6SGDAvmx4unYsRvVpEMhbQsInEAFqPojyuzC5th?=
 =?us-ascii?Q?YKoLSqUHXPeiqFcGFExbSw7nOta1Y9S7ReYWdAWAi+BI1qmNmITzUcxv+Pjt?=
 =?us-ascii?Q?OhrlTcxXja2dUH9AVXlDUhCh0Mtu2JFtUTKga2VunMCaXMg6PX6FwsRgnFHn?=
 =?us-ascii?Q?tKfgQ18sB8qQtqTTJIg4dHRfDRowNbxuQHSgDUBgZ1dzIP0APCwUMOStILtj?=
 =?us-ascii?Q?DaFHV84xCn8xkYMjQXnDC/LYcBB1pS9y1rwhIgO7DgQvbHXtOOhSUgRGrV3/?=
 =?us-ascii?Q?mlig8b3FcFMMQHh/btNK+ZL5fVy97seN7sjAr/TGslCyiwA0F7PCbFiWPHZ/?=
 =?us-ascii?Q?1m9xE86wiRm8VcFr1+sEB+o8sLR345PPbaP1FG8LFmdZZdvtOAuHPivGJmbW?=
 =?us-ascii?Q?oLAmKsI0/VsxiY+2mG9/tgk2BvJ1b3juBDDP2aNmDUUsPWkUVx2KBOGGy6k4?=
 =?us-ascii?Q?UQKth18CTDESy8TM4/RSR1ioA80O3qi9Ihj+OnFR+cpVVN/W+o2A8S0cMgMQ?=
 =?us-ascii?Q?VTMunb7fAYsuCBc0LZHxTCq+vlxZ/K7qBLVcdERn9DBJxcVDABBdSGorNKf9?=
 =?us-ascii?Q?syWfsCT2YH9V7GSLvXAHOBbyTz67Efb7p0NY3h29wfKpWfT91arOh2NSFLqH?=
 =?us-ascii?Q?viq7B47KpZu8G51rNLcb4KDf9pdK3hN+RxL6dNSPNVifdjFjCDuK9+ToHo7X?=
 =?us-ascii?Q?BIxfhzcdW0Vr0/1vafLgeSlxUjr20ai25W+XILYLgNpB7QCpms9rlganvHOn?=
 =?us-ascii?Q?9jiVBjEqqlwRpwf7E8GsEQN9hY1hRWEyodJor5YIpCa+t1nCUwhthLchDBJS?=
 =?us-ascii?Q?t5PkOYjAwtgbYz4C5bB0hYRdNfe6CXbzAzOMD02iS1bCHo2RZOVVXNxEatfM?=
 =?us-ascii?Q?5TFlvk+TKpk4modR+YcFWAmyLTbAo4TT/7StCKWXAh35EkP3HxFBm4lPbpdl?=
 =?us-ascii?Q?Lk9aZxH2j7S/vONgaQwnBMU7cNU+gxnm4HrRxXUNJn5tNfUjmDMxziaWT3gV?=
 =?us-ascii?Q?hjMPl5Yzsf2tV9c4zxdnvC8VL8bXzHYqIovePz51C5eiqSuIagcmhDbWQamM?=
 =?us-ascii?Q?ugMhG2LvylUV1VoJ211r0KBfzahnG7Mb/R58TYXJNBhoR11/Z3EuaOblrYAN?=
 =?us-ascii?Q?Jy9rClbqrpK544yR4/6JNZj8tHvbgF3h6YUn4VZZvexe2pAybAMqpV7wiryb?=
 =?us-ascii?Q?fCGrtav7obRyhVA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zv5FR1WkwAosVUlsWMsrM3r0wlFUqkQV01cGWSn7sTfjtfXszmVrQzLxNZNT?=
 =?us-ascii?Q?vcYwVTAczXKCJrOrT2s0mh2yKnAMtd0QamNYCUtgKj9bv6g+3RvtK54ODHDT?=
 =?us-ascii?Q?wh0ebLtuKrfGLq5uTTOnB+457shaV49o+qGVM1Fd0x/EH60aN8lQGu2cpkra?=
 =?us-ascii?Q?B8y7VVUy52N49vZYQW+izwF3YP49XOw/Msd/k0oKBNRYYjR5URU0YFMzHPyj?=
 =?us-ascii?Q?QKwfmV7qtHSN5t1E1B8qsWmXNh4ttQMSs0xK2MQ2MLn7KjgI/s5gtX+5GXUp?=
 =?us-ascii?Q?qj1IaQFTa4iBen315XhIDxsIv2vSc70HruGAS6+euBwIN/jvhuY1B8u2fOtr?=
 =?us-ascii?Q?zschlfu83i8wmKV4VhzN+DIUOvP8SADBiZy9V9vAGh0xVEU9TEf6ZnUn1KA0?=
 =?us-ascii?Q?SRsCPpWN+epWba9mVXXh5zWaIuyl0yXHMMc8qEfy4IpGW9DcCbHd9kjtA9JK?=
 =?us-ascii?Q?jD1m8NdsQQGx3qMh29hFR3kp3cQA9BCp6HKpVfHNUMZyscJwN5xErhdq6Kuy?=
 =?us-ascii?Q?fMpOIuk19d4J7mo4G3rtfBE/Vy9U0FaB0n09H0vs80Gh53D5wqS4HLPZKLwF?=
 =?us-ascii?Q?/ruBFh7QMHH4iEWXtcO/kj7kgmsvrBufoPIJo8lTD7hdGPOAze6+JY+PP7iH?=
 =?us-ascii?Q?O4tGCUiK/jcG3y7VeCtllkchaicX4x5Eb7+OSkzM6bbaUb1/GIQr5zO/fi6A?=
 =?us-ascii?Q?aJpHskC8Er+y/a4HGF979Bpq7CsLYAHMuMaGAMnqbuIt7LDYAL/xTVIcdHQv?=
 =?us-ascii?Q?oy5tItlw0GH1+qv6ocXHd3Ry4PZonhXa/IJ/Vh8m3pFk+fk4JfheSZZid+4p?=
 =?us-ascii?Q?WWq/9ooFXFUA3ujKypwkZZrxubT5GjiBr5C1SE0V5VcWAJzmY4Gz0oyvv4eQ?=
 =?us-ascii?Q?UqTMjjgfAlmGcPrfc4ILPC9vu69Iu6DJmmn3bKOpHnqqtoVmU7j5idKgQJmB?=
 =?us-ascii?Q?nWwwy/TKoB8I+Ft7NjZusg20dxLYpz6zDE18NCiFRbbTVQvRPSXwtBZSvQI+?=
 =?us-ascii?Q?fEVnv0F8H1gWZdNNyqQ5/BRGZ8UFR5s2raoS2wRbXjy+zVFNX0FZ9m7zNv/E?=
 =?us-ascii?Q?igmuqt2ayopglFow8gnDdmYQmMLWEKZ+bYzLaUK+gKRU20S8b9gpY/3TIo8/?=
 =?us-ascii?Q?97gBPtE9DXy8hTCEqcIG0lhjD9XBIWUQCn227a3wBlM3LAcVzPbsWVTE0aRE?=
 =?us-ascii?Q?wims7jKjqWc13aVS8Qi/TG+c90cQs2X1u6oGveLXaqQNmUQcWgUc5TG1rEYg?=
 =?us-ascii?Q?MwvVNx6pWjl2xlM1Cbw9ifpZ//Tf9ArI9T2y1WSvVIWkvso9CAF6XCqdzMF2?=
 =?us-ascii?Q?SCpLvTRNmweldS5dUUPTogSLKchNXyfPfzeIOHZgD10Ij1rM+rT7oxyYloB+?=
 =?us-ascii?Q?VOkJpif9lx1jlLkm6lwq/Zi+7maWxYEFnvCOThPh84mEdsp9KuaWkOPwKnwo?=
 =?us-ascii?Q?zeHQtbyeWdKwyyA/8GVjuu3+73dtFVb/FDRHFhDZtfAPqa2we8KpYiY9yiLT?=
 =?us-ascii?Q?5Zyl1SQq9CZPDrpgqohWzaAS1EHMaRrXCONWb37ADzcdm0cRJFeJ0QcAT8sS?=
 =?us-ascii?Q?8vje7H4LqGdyhtD9lYVZolmss5XBZvnL4bpulAG25HB/8DPAxqvFcY+vCzKd?=
 =?us-ascii?Q?X02WJdJJ1893pP79ToFndAc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28869F645504394FAEB33CC2006B6B95@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I8WCyo8yOUFyIBv8ch+j4jcp6ksWwbr9ETJTmcB25c5Ng55kxgDp5JpoFbvEwrFgu+8o8rF036aysIYsesbgKnDqnxPjKZfFXHbo+RFrnayQUD+AdDer6RmyJA39MTGNzmsEhnC5xvNAlPpXqZK9KL3ZY4ECV7zRxG+qhUT8Zd+a3Wp+xfHppoSct9+ITmJp/FdVLV0OUt8LzfJDoeDd+YY781iTzQ2EZu1YPpaMrJ1CVbL6fxLEe8XO6SaKjg003e9iZ8U642VbtObe/xZTEtQAVBtIWYXLroHudLCJvl9wxEUatl5aF2/F2cIiw4az8WBbgEGlL08K/WgrLfQHlD5HYnNhldr11vX/CknqXALZD0TVANSTDoMbHH7ihAPLL4UyqRBgzLAVuQJh+p2izUJSD21geDgbCUdpGbwkxHfSSSjpOvXRFkUuxD8kinMtbWsrJJUF1Z7jL1JdeRZSZikfmC6mMBLWWygyAXQDs0/cYinYk2zeqwObdDlPPrVQ9yednTtgN6S5BZoVDeZZ8NdQOByz07w5mPAdvFstbtuIhDs5cqxoBe8t9AeDD2LSSy0Wtl/rxga8bBU1p5UIeCCsIB+eOYtnHWsu/gNXldCmhk7IcAxLWfWN3919QoDL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e4ca0e-90fe-427a-0dd8-08dd96674f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 23:54:20.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUi6tiPS5ptUbarBgOEkouiB2qBfiyjY6bH6nzhTI5irhGJo+m7sJvkoaiZ1rIjDNBO0dkWKN4wfZ6qaxDgNjbA8zDjeLBYv6vyJrOvjHcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9633

On May 18, 2025 / 22:12, Jared Holzman wrote:
> On 14/05/2025 4:50, Shinichiro Kawasaki wrote:
> > On Apr 25, 2025 / 09:37, Ming Lei wrote:
> >> ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
> >> we may have scheduled task work via io_uring_cmd_complete_in_task() fo=
r
> >> dispatching request, then kernel crash can be triggered.
> >>
> >> Fix it by not trying to canceling the command if ublk block request is
> >> started.
> >=20
> > I found that the blktests test case ublk/002 often hangs with the recen=
t
> > v6.15-rcX kernel tags with the INFO at iou-wrk-X [1]. The hang is recre=
ated
> > in stable manner when I repeat the test case a few times.
> >=20
> > I bisected and this patch as the commit f40139fde527 triggers the hang.
> > When I reverted the commit from the kernel v6.15-rc6, the hang disappea=
red.
> > (I repeated ublk/002 20 times, and observed no hang.)
> >=20
> > The hang was observed with test systems with Fedora 42. I do not observ=
e
> > the hang with Fedora 41, but not sure why. liburing version difference
> > could be the reason (v2.6 for Fedora 41, v2.9 for Fedora 42).
> >=20
> > Actions for fix will be appreciated.
> >=20
> > [1]
> >=20
> > [ 4497.777695] [ T130863] run blktests ublk/002 at 2025-05-07 14:48:32
> > [ 4499.983130] [  T67084] blk_print_req_error: 58 callbacks suppressed
> > [ 4499.983136] [  T67084] I/O error, dev ublkb0, sector 106830432 op 0x=
0:(READ) flags 0x800 phys_

[...]

> > ...
>=20
> Hi Shinichiro,
>=20
> Are you referring to test_generic_02.sh in tools/testing/selftests/ublk?

No. As I noted above, I refer to blktests [2] and its test case ublk/002 [3=
].

[2] https://github.com/osandov/blktests
[3] https://github.com/osandov/blktests/blob/master/tests/ublk/002=
