Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D01E51D
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274454; cv=fail; b=kXWhQboVsztp7ZZPKYiUzFyOBrbQC1m8Nbwd9KbaFzOS7ENy24QLpAHIV4JCanHUTw4PtzqE1p49tGV9potbk9CWyMo9r9zP0wS+fAXRnf3hu4HGmwKMUBzums/P6O8MU32XfLDKvOWpf+geUTxzgvL1w6SJ3HBile3tROQklXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274454; c=relaxed/simple;
	bh=TrNdW1nrdmTYw5bHFrsNT1xQIzB6fuz0iCKxEPdBnik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GWONBX2HuQFK/zXbzCwW96rXH0QNNDp0ThLpUOmCJ48foqlNNWIve1YDEklfWBBfsNnS9Xblkt+v23DOA51E5FbfR1taMSPtqdUKjlk5TNSRv+7++ljclvBKK3xQI3IWJ+EvH9XRzRbgLR7VVa9ykOJX9SBHTvOGsyZN//hY3bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PPH+Lazh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OjJEZ5Yl; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PPH+Lazh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OjJEZ5Yl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725274452; x=1756810452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TrNdW1nrdmTYw5bHFrsNT1xQIzB6fuz0iCKxEPdBnik=;
  b=PPH+LazhyYOgvCTOzLYSenC1NMDHExD9rcF+qY1HUCToxSJuQ3UXtzfX
   RBlP+si6VCeyMuymboaL5L9pHPJa64nAjXL3rB2HKfk9yF/xrmy5p13sO
   uC9PPQcuJPqiI0h1LidmhjZuFdzm7mZ/OuMcopFdU5oPFWDhxHhZv+/Nq
   BF7XUk1eN53HQ1TIZZMFmz0xobOhsa5h4dTCVjqSNx5DA3dqdK/OcV+Pi
   jQS5LjDSvdnjJ1JSLdukcWrW97wz6xr2yaU/15IxKRn2IHPAWlcOV0XKT
   124OauURgTAIfKnu3FRWtd9/PO0jVoLTHMoNeUbFNv9Km6RZldUDedgKq
   g==;
X-CSE-ConnectionGUID: ut1tMlkBSF+D9WBX7bkz+w==
X-CSE-MsgGUID: TdomP2y0SSykkpeVguGvpg==
X-IronPort-AV: E=Sophos;i="6.10,195,1719849600"; 
   d="scan'208";a="25103740"
Received: from mail-eastus2azlp17010007.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.7])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2024 18:54:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0DlEUkGFBKjqLqlbzigIWVzekHnp03LgQeBGz88NgnvmDohhVaev9aYSyaZYelIjMgnPM9YWHs0Tm2anrUMAw/DsNj4xcLIEbJnDx1ic7XuTSjCr6oquvIq2Z4/mTFi8Bm229zDuD6ZQ0ePToqjqZjPMa6+NJMKQzwzsPt0jWV6p999mDBl1eUwwRhK3xGUwlSXZGCXmXX7cWiOLWyFUUskZBjK7QgR4xyaVcbG97YBVvRnTaiGYieK/gyZgbOdGxMDzbpBe4sHfyfhptLVIlbNnIQQgMc2ytMGU9KnYcjkgFk9M0oROe9DtdfD8G2BL0WrJ+i3QrgvTRlfDGkrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9pO4YXrRqXPkh8JmUR+LxBnxp398frzYnCryMR6wzI=;
 b=p7w2lAApgdT+c2vwmdF2rzuhk1Ap3JP4bma+ItQRHFZmYEOK1+b6OQGBCxbv6spE43W2PCqKbV6QdEjWv5yTcLNac2ktI0GI/LB326VIg+d7MRvzfkY1oQQLyhW8pkQ1IGwz6uPQWbWX1jDSSfMqET2dIwq0aZXJowK2kkmwznAudjdljQhw3chi0VT21b8Ms9a+Y4g5bd5fIKY+8gS5/HRfw26vd29sdHO0hSf2PYp0wrLPmf+HYGIBplRqkXX02ZyGSIM0+T0tE9AmYow1flC7+ht/WIiclxPTFpMwjCtn4YQFFd6UCWyFdDqk2WjosA2cjw6lBtnlDVvYkojP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9pO4YXrRqXPkh8JmUR+LxBnxp398frzYnCryMR6wzI=;
 b=OjJEZ5YlRj0YmRP/SKdevH5OObTsQwi4h6CzaruZEP9mu9G6alcnBqa4BGNNOnKObuNQ8iF7Nrz+hZ3bwqsvPm8O25NdZQGS3oJPTfDGt/XV5K6k0QgRRHXPI4W44BJR+sVAio/7fCad2xY+NsaDE0Bjr9MstoZeMRx/Kl1SBTo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA6PR04MB9119.namprd04.prod.outlook.com (2603:10b6:806:410::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Mon, 2 Sep 2024 10:54:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:54:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Topic: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Index:
 AQHa8uqR0Nq3uU3VMkila6SfAwK3vLIwXbgAgADx2QCAACN+AIABgyqAgAAtNACAAAw+gIAAL3UAgAAPHICAEPjGAA==
Date: Mon, 2 Sep 2024 10:54:03 +0000
Message-ID: <6ujdxaiie7wsztwmlhrxcr5vnmntj3f7yz5mmhn2i2suf4dncq@jlbtb4syfjvg>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
 <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
 <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
 <wf32ec6ug34nxuqjxrls5uaxkvhtsdi4yp2obf5rbxfviwlqzt@7joov5mngfed>
 <12fa9b5b-8a8b-42a6-9430-94661bfbdd21@linux.ibm.com>
 <wpapwfrmpkwxdqahiwvp5y6l53z2xuidc2qyloolzfundec3p6@vsuen2jtxot2>
 <a9a79fc9-6c0b-4a35-afea-85f34e9889bf@flourine.local>
 <20a3f01c-0992-45e8-8970-30a2747ed8bf@linux.ibm.com>
In-Reply-To: <20a3f01c-0992-45e8-8970-30a2747ed8bf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA6PR04MB9119:EE_
x-ms-office365-filtering-correlation-id: f4a327e1-ceca-427f-ecbc-08dccb3d8f1e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6H+KXyyoD9eLr/UVFODO/jMobPQbP4vcCc2XGWoxYyw6InxX8Sa0AsqNJzRu?=
 =?us-ascii?Q?d1ZCDzH52WL60qG+pBX5UXsretnreNiLjBgf+HCHMHuHHhYfCZUw4GnFIy74?=
 =?us-ascii?Q?OnspnI4CYL9wlCV2SEBeI290pas8/FssGqUCIH9lICYgpm8jE89hDkgaAyMw?=
 =?us-ascii?Q?SjCcIUiSNxp/rXeo+3fvhmA/359+Ogo2i18bgZLff3l4Pb8jkNhXkd4ZJ62v?=
 =?us-ascii?Q?VYv1zX/txQzdr4365KleLDXFWNYPYNNYbacXXfZRuW4OkmVBejITqah5UWse?=
 =?us-ascii?Q?25ppYoPxVEnIK9sCoc/jNW5yYYOXm4oy3TH2ptyWsJTJA0CkxJDrnOxhSBt7?=
 =?us-ascii?Q?3aSXfiqltw76uCuUX5kVJCwRbtNhaXCXSLwPTBq7feMlGSIHAN6xlUvYM7ne?=
 =?us-ascii?Q?L5b8hkvHgEZACajW4LivlcFw7W+937w5OoqDyiKHY8d3bDEsbZntD1fspCjb?=
 =?us-ascii?Q?S81jiQrQuMFcVFXtQOJPCG9SSIZdfKnC0LdCJOvpiatiYHtVCsjjjM7yITMZ?=
 =?us-ascii?Q?PM7reAzbRUC5N/91UaujMPbnNRiNwl4Y6WEPztO5UChnpJB5IP1IkYTHTIxF?=
 =?us-ascii?Q?C4B1GQflQgVbiBhBMIh2cDpys84eIk2Li3niSn7GyZ8SeI152UClXaGJUewK?=
 =?us-ascii?Q?GLDmBCXIRs5IljdLk2FyxAwqpj7VUIf1pVjWQAc03i/6/ldb19fPJ3TtBqfB?=
 =?us-ascii?Q?9QSEgCthPdzhH4UdOO+xBzfFbsB85DZT1iZM3JEWXzbwB4Vo4i5QCtNSVZTG?=
 =?us-ascii?Q?t4NWLOcRBhXIwDw1fpf8qDrIRC8DfUrRgNl/6mEqa/7+hoe42yrMM+bifXsS?=
 =?us-ascii?Q?fhzTMy81HF0q7OnGpE71SKWPfceVVL54EI8yEx0RsDyKPyrBjHVOwaHlLT+s?=
 =?us-ascii?Q?SYUGenkCdCFZvLUFhwWY6fg0zNo81pbxoQHGN4zSfVfytxagFtJmV3HBTu6Q?=
 =?us-ascii?Q?qwJgtt9SN/o4RuD4mfaqpjT+Z5Knt8bXr+YJsLX00VLLra61G3kgFiqwTi4K?=
 =?us-ascii?Q?j1+1Xw9XGBcIyjZgqciune0wcnMaE/VG15modSlxEj502vN/u6h+yFf0ek8O?=
 =?us-ascii?Q?+Wnz4mmkUeK69tDSfTaR7MM+LIOIPOXH8BOB2WHlLl9OUJbI9g/Ok/QsMBJO?=
 =?us-ascii?Q?ZUYOzNF2uoX/PZrbhuc+ntTDnbfhTlGPAKHipFYME1h79PXi1+GecKxkXG8v?=
 =?us-ascii?Q?upqHRslsYT2uzgGUTOwkb1MYQ7CEa9HF8HIhi+mPWtK+zo+DJvwb/m8Y9FYJ?=
 =?us-ascii?Q?8M2r+XX5GNzEXavw3HCPKTl0XAm40uM4/7meMOTOxUMPemChbVVvqCFJdbos?=
 =?us-ascii?Q?prR8l9twJwZSXC/hR0r8G1aSwNprWJJM17m+hwg9sd+crSEUeC4yQcybtTCw?=
 =?us-ascii?Q?tmLvSlDyNMYvkvNpHXoFVVDimiVBNa2CiL7iup6ZYIt2qa20rA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OOHEXkfALD0rG/c/4MhRYFGV9KMuRbZD0s5P54etRlk+sb0qA7WfNp8p5+Kf?=
 =?us-ascii?Q?c55lyqtEqxXjtPNXt6ZVng/zMADTD1KkZvnlIS4lNziUVfee38L0j0L/uiuK?=
 =?us-ascii?Q?JZTFDUcUB8oD2XLbnOwS8PnMTVdVe4e1USNkE6kQnTgR/1dB41esLWIFi9AE?=
 =?us-ascii?Q?d7jW4OS/DzwcAdzTiHKJ8ssA5B0hi+89e/tHnSEGrLHkN+QFBG5Bn8efh5Fy?=
 =?us-ascii?Q?AADPbiI9hO/qLTR/ywr420XqX0Jpkx3+6YRSV4fG9Z7Pt0w6w24C21h5XZ13?=
 =?us-ascii?Q?H8nKW3ZyGTHn5V7qoGQoRVbplNqJWu9nDigmnyMoUgLpBTlQP7wl2ike/p3U?=
 =?us-ascii?Q?cs46MG/ypN8swPI6ub3GaLHJGoDv/L6gtw/37ClbKTtBwfH9qlZ9pEz4VoI3?=
 =?us-ascii?Q?C0ZH3nbW+6mLQpJ5mHFr2v4FGto0i8y7Bk0b7UYzMhEt37k8ZmFVISMaT1lP?=
 =?us-ascii?Q?ZCs+brXaxFEPuarlTGRgZ89RfXDQwe3OZuJeIjDTtdByYCAV67T7+2vc6k3O?=
 =?us-ascii?Q?q3gnnYMXJiY25bdKCrgSwnE1iKkJ3lMGkvLBQcB6I+/oDto/VRVM108qSYEb?=
 =?us-ascii?Q?K8VbxcNhlxfA45XIj7UmYN2jNC/UTCOKvPW/ZzHKupiUZ2zvX1Wl0KnQlcQ2?=
 =?us-ascii?Q?lwViOeQtXCOC99Zw9Lful2Zai3VcZVcZ8PVxj3dsa5WWu0WwMjzhmIaA3CWK?=
 =?us-ascii?Q?T7ArcTo+hzOCBIka3pTPNJmlQzxin36hoh5fLgu/6on0vi8RZH0f+F8t8EPm?=
 =?us-ascii?Q?eN7LtMsMcIfZxfHmWQkn8olFlwvq/OG8tGUWpkphEFh/GgoiWEotKigt55PC?=
 =?us-ascii?Q?OfEvd/xwyG4AR1tKgwVCTvHqO5kYzZ6dyf7f65RWELyv5den58DbyRcwzxCg?=
 =?us-ascii?Q?8Skf7hlbrvIvVVlB8dNmGnKigRrX/XBj2y5EtoBdKfflJZyPJsJ35tC3BHEl?=
 =?us-ascii?Q?cVFG08Z7otN5rwd5grqNPgqennW50ogXE/lU6V2Df37ZDaKrZX4AdGjfB7zD?=
 =?us-ascii?Q?yyEIT73tYE5WRpJThgn+wiJVVQBgXZ7JbdwYR4lHCxB/B3g6asWopFrZNMq5?=
 =?us-ascii?Q?k2OFpQeRNL6ufJGiSYuN9TEv1gakwIfQOCflHl6ALPdJegXreF3rqnpMTdfM?=
 =?us-ascii?Q?E2/6+MCre95AO91INdwdctZDwXqkAwt+pfvv/tycClTPKeb7WB3sG58XAJrG?=
 =?us-ascii?Q?Rplf+C9aTNrSbJoBKPe30TB0d5N/0kPjhZoHkWRZXwZAiaAFTUbLU1lfRuIo?=
 =?us-ascii?Q?IU1SLiJEdaw+r2X+LxxMmXQlXH8PZGDE4/jfCc2fJJPFh7CJ0rbGKb1wn+p1?=
 =?us-ascii?Q?1adXFZtCEeABHw6Iv/w4lSqzn/on5NmQNkbNtDw1VL23jECPzxW7bM3LBLUA?=
 =?us-ascii?Q?RQi1HyhsPmCOBs0qObeitP3feAHgCTZTJlQKX7eYi2eSaXrW1GG+bJ6rvpHs?=
 =?us-ascii?Q?WXIwI0huCZWjzG8z+V/+8QYKmGEqjiRsbqQII1OvkfYc9dDnzii7kj0ceKR5?=
 =?us-ascii?Q?z8V+EtuZcki+fSBRWyEFiTiDxF4SuFPuvgVWweFgmuxvta3Ta9e0zG0EAMzm?=
 =?us-ascii?Q?gx9CaZ2PHu88PHvWIrVh3pUsZnlrUnFLRCyoI+xwUEzKDcfw9qevrxR3u08G?=
 =?us-ascii?Q?8d9GVdwvm3s6DDZN5LahyD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <770C1C73089E3142B2796B862F56EDA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hBFjMrUwenpnNnD3PgKAgOetN4MBgAJ/PL4AiPu0zQs6jO5uVtKG/UzoRKQokKdt3e7Cqhfq3dtzMzXUJZp8F3zS+bXjge+RB2o/nlhmGX9t3fpA1zZd4Oe/6XTfcesk5JZJk8KnS9lTFZDGY0rGa3CXlWi2oBzo4v+/LpOozIFJVaAVgtYkH/iEdZMAK7leOLPHstvCR7s2FG1UvhsotAQhJ9uqrnZ6y/sPtLO/5xrCZuBQ9hZMcJEd+FLqAt5z92w+3dLzgEfxmnOmAuDfP//YuD2Ab432uN/l/KKYyFCrCJf4drRzOHKX7nb53XaqNBBepfUyopqh17xzkABGAoNATGq7Ri8srv7BMqvEx9ibq63Sy2b8QqH1koIXwu0NUX1xWGQ7BXXom5VIim63MjEJpTZg4WQ1p3vUX5cwIqdlI7pPanNHfTQgGFvAvdo98VWolXMxMbP1KJfysJZkCo+iIxusIp7x5tFbG8l4KUDyN8qiKV03kgZELO8Xl7jypfOiODC/GwowaeRDVKHj+RK78saRO0VVa8LspT0JDnXR1iZ5QfCj0sWyiYhjtizDYB6n/JfWWkb8c6fxdkfxxcLz3HO5TxA98TVlapq6V2vbr5HpWsBzXu5+Mvk5rQZD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a327e1-ceca-427f-ecbc-08dccb3d8f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:54:03.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bW+ngEKsbmCuo7GpKqm6LcLep7TE6au0aOZYSfJLtLikfd05iqZdq0P76chlTAvhUsQwiNCnkHrHNbBqvbMYbyBlnC3NtNI+W4s2rYDPfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9119

On Aug 22, 2024 / 21:13, Nilay Shroff wrote:
>=20
>=20
> On 8/22/24 20:19, Daniel Wagner wrote:
> > On Thu, Aug 22, 2024 at 11:59:35AM GMT, Shinichiro Kawasaki wrote:
> >> I can agree with this point: it is odd to suppress errors only for the=
 namespace
> >> removal case. I did so to catch other potential errors that _find_nvme=
_ns() may
> >> return in the future for the namespace creation case. But still this w=
ay misses
> >> other potential errors for the namespace removal case. Maybe I was ove=
rthinking.
> >> Let's simplify the test with just doing
> >>
> >>    ns=3D$(_find_nvme_ns "${uuid}" 2>/dev/null)

While I was preparing for v3, I noticed that it would be the better to redi=
rect
the stderr to $FULL than /dev/null, since it will leave some clue on failur=
e.
Will reflect this idea to v3.

> >>
> >> as you suggest. Still the test case can detect the kernel regression, =
and I
> >> think it's good enough. Will reflect this to v2.
> >=20
> > Not sure if this is relevant, but I'd like to see that we return error
> > codes so that the caller can actually decide to ignore the failure or
> > not.
> The _find_nvme_ns(), when fails to find the relevant namespace, it return=
s=20
> "empty string" and if it could find namespace then it returns the namespa=
ce=20
> value to the caller. And then caller (in this case nvmf_wait_for_ns()) wo=
uld=20
> take action depending on the return value from _find_nvme_ns().

Even if _find_nvme_ns() returns a different error code for the "cat:
/sys/block/nvmeXnY/uuid: No such file or directory" error, it does not deci=
de
the condition to ignore the error or not. So I think the "empty string" che=
ck
for the _find_nvme_ns() is enough.

Anyway, will send out v3 soon.=
