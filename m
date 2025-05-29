Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283EBCA5A
	for <linux-block@vger.kernel.org>; Thu, 29 May 2025 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748480905; cv=fail; b=ZtkbCSbXkUNv7FjcK+V1d5yyzKBkhPFoDYWaicBB/t/C0gA7DKJuLRMv9ElhRO1FemxfeDR9VVOr99n6Fb6o/CQs79ClTcdi4HLl3s5rcPLYO44oA6By02g4RUN7PIMHtNqj8dsgbHLAz0AgDEbMEd4CVGTkLyxH0gKC/nrRaq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748480905; c=relaxed/simple;
	bh=GUM3MkVNw5pmMV15Lce6h1AgcUcxWUhD4OHQW80dVBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNJlg5uy1ZgCsJYUp5yI5J5jKXtbYzaqyUpgS0DpryjicAZ8nTleJxQSwlYU7xzGkx9mOj1iZ/RudMsyCE05FLVHProVvPJzhvFpa9SM92dTKxfYhBZuFLepZHB+WPnU1CAualF/v9f9D5Su6PZ3/tHoIVU6yk2PrzK/kaEK7Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qMZDtyWN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u7K/13ig; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qMZDtyWN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u7K/13ig"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748480904; x=1780016904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GUM3MkVNw5pmMV15Lce6h1AgcUcxWUhD4OHQW80dVBA=;
  b=qMZDtyWNUyQeFpehwOgueerrcnV+u4uCYkLU08AwElwCAgooQ0gJiFL0
   ZNmNEOAfP72jOj5WpS7Gf9htNRqdRVvr9HLJ0VqsM64s5me98vD0CFBzX
   K2QeHADzFAVgjgIRfyjiTkLJXZ6Ag0gtwkY4aqdPRyOjdRjlHa/S8f8h8
   bho8Zmi3WP7//DdrXn2sYN97FdfHduYZkF1ehmQwcC/p4sN68y7yctyGY
   gZkecjTqbCUoFMCdAtpGcnchvZwH7FX02EYdeILBK2J0/c+RXtcHj8EON
   yqV5MoXmdFIa6smHHD7DzyZWvhFXmf0OAjwKzN3O5/A8j7Qq3kkRK1Xo/
   w==;
X-CSE-ConnectionGUID: 4w3ITW0tRF+TCMg0jbAldg==
X-CSE-MsgGUID: LRtwsHLGRxC/nJ0twQUr1g==
X-IronPort-AV: E=Sophos;i="6.15,322,1739808000"; 
   d="scan'208";a="84334635"
Received: from mail-dm3nam02on2070.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.70])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2025 09:08:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KocMf9jQ24XIVp9/yBgWwDRmrzYXKLQjaA2vznqsu7s4v1Fl+QUCrDsuwk93MnvpXYenSgugy4KbebsrGIqXW4c03GUKVvuxO8Bm1EUMIXBl/Wl0IMBQ0eYDBju3/Rkh6K0UgQZSCaJmXCigabBB6+R4MarHQ4QBE9EsCfDQq/b0FplyE31HJ/fI0KO7w+Z9k2oPIbfEjjmWt9fUn+TSb5z75IfnnCoX5IR3mk8Kuo8iSrAhLwPhfjnwrc1TIqZG1HrFAECWfHITXVhs8mckQ/hZkElm0BdHqEfEsa/d+2JwGxMIkyzQs6jHZxi9q1l5US0P0YA1/6BBB+D3ckRWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhjJ3hsQ+FXQStngrs5ehLE69tCh2yMgHOOFHzaxzkk=;
 b=Gwu1+HJEDaVdqQhGXuNDLyHWDfPb+ZysiKDlWCM1mhFCuDgc2I3M8IUn/vQ9gIqC2eGt4wfdTlFx39ndClJWEfNUWJpIIHiMveZi1dapjr7FkRCegEMq3dvI6fizTVFFCpW1Y1VGQDyAjQq+MatmIKQggvqaBhH6L/piGEOSU0C+Wv0ure9F9e8vT2wk3ApA4TZT/AeS9W4/ZA1DXNrL2cNU2xu6vN7wESAZsT1tDBQ2pqBsMlWrN7bbybnHmek1SbdIqnaocRkJGNB8AeaA4KUgoBdHFuhhqxt0rWOfOpS7TvZN4MHqcNFndzpVjLt/IT3ongD8PlgSzc5XD/gy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhjJ3hsQ+FXQStngrs5ehLE69tCh2yMgHOOFHzaxzkk=;
 b=u7K/13igKJVAkO3fQfPXCax8DgNJNkO6jSpifi29EMFMj6jjT6Bd/Yb16nT/o22AAIVqo7/Jofcj6Tk7a5U89cuGtnxlTvd4sFWph5DpEoHZom18W7eLpM0uG31ynXrAEOI4V+xFUlJvGJkkREYfQ/e2W+tVuYP94PYC75YfsFw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY5PR04MB6502.namprd04.prod.outlook.com (2603:10b6:a03:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 01:08:15 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 01:08:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
Thread-Topic: [PATCH blktests] zbd/013: Test stacked drivers and queue
 freezing
Thread-Index: AQHbzALLtqOQN1PdUE6hMcTwgzbaO7Pkl3UAgAIPjQCAAM8gAIAAx6gAgACWfgA=
Date: Thu, 29 May 2025 01:08:15 +0000
Message-ID: <ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w>
References: <20250523164956.883024-1-bvanassche@acm.org>
 <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
 <09211213-e9fc-4b59-8260-dd6f8e9d9561@acm.org>
 <fggaqqc5dxwbrvkps6d6yj34a6isbcsr7cxepg64bppinpk2w6@dkmleb5pncjt>
 <f8284cf0-0b05-413d-83e5-5cbd1c72ad35@acm.org>
In-Reply-To: <f8284cf0-0b05-413d-83e5-5cbd1c72ad35@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY5PR04MB6502:EE_
x-ms-office365-filtering-correlation-id: 43679278-9ecc-4931-6e50-08dd9e4d4a5b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?copseEqG2A8z/KSdyxBCWuAT5Cy2T+rwL95jBRJRkimTacRIsE2xyl+l015i?=
 =?us-ascii?Q?qopNIh4otJ6WxdNNwDpmM/9Sv4n2lGb+3P4URdpbpZ30/I9Uh1dXXhpe39WK?=
 =?us-ascii?Q?PMBSrfyzC9qMyj9GCSB7EfCnyireCscSJgOeTm4Nd5PWUWxTGxOIqdoBIlxU?=
 =?us-ascii?Q?p0O88dwPKJ9IvkjnmMeXOeIgGhtiN+fK81fnul7OlorSgv+rEkSY69CTEYjG?=
 =?us-ascii?Q?lLDVZUCsbGqCD4Z8F64YtlVi84MIz73spvJaGUd3EtVVypHw2TjmdBQH1+1G?=
 =?us-ascii?Q?0n1lV9Lu1V57Tslk90shGp27CydVPTa5vXR69tDsNtDNm7h2CguIdAkN35kb?=
 =?us-ascii?Q?QGxc7oiqFfdBgAfGIHqlac/p+ioq2EFjeX6gOskp5qgr4iYGAHM2P8hJq62q?=
 =?us-ascii?Q?/BIUC9nfdGTu8Wn74WZDAWDo1xdbhkoVUN0REipeEpGGHkpZAzH7gqIvRPXl?=
 =?us-ascii?Q?mTaZeTYhcq0YYRwUpSCoMmuDcH2wyYIskTSFjN5E3qZQTGkKfZ8vYZaa8n0p?=
 =?us-ascii?Q?iGdH1u7FWxsC+pUw0Y9Xkh7Rcn6/N1IpW7iuDTAHV6s/ulZQOB2AFEDchL1t?=
 =?us-ascii?Q?WxJMAJB4f4wtw7DtCWEJyjbCtPz8g0dJd+9+6oD+Uc9WS48X3gnObRmRePGU?=
 =?us-ascii?Q?esfMvy+oN0tOtNZicghv4Sjo5c+XVneiqFCjsTfLlgY/ZbhdhVerb/7x9adp?=
 =?us-ascii?Q?7DtKG3pCxqBEyWaqEuupivLmr7XXC6iiDSzrap8aicHpOIxRIHKOh8zWWH+f?=
 =?us-ascii?Q?VInP9mLohOUjSfCQTnpH2iSXA2RaFOy4S0OM2FHHVYnPokNOwCrR41cVhA9c?=
 =?us-ascii?Q?/cakFW7kJIbdsssJMZnkfORw5ipbjskBTCKiVFeK1f2+4A10lbO2ET7gy5MS?=
 =?us-ascii?Q?DCsjy/2MBG2u5pHr/MJ43Trubv4BvYjps3wOVUs4hd/3/sl9aZmiXNlIpt+l?=
 =?us-ascii?Q?uvGjeHgPWO019020gDDCJQ58SoS4SEt3W0rc09EtlGKfffCOYyvAVvCFWUe2?=
 =?us-ascii?Q?yFWW5oLEN287moHqAP/tDV7O3R88AJLr7S1fuNMSHlhLOBn2SQp6dYJT/6Wj?=
 =?us-ascii?Q?x7hos12UADVayyLenTw/nTL4vwpODUIdXF/jVUQwN5DKi/G3yAInKyvfBGVL?=
 =?us-ascii?Q?N92JrVN9vnswc7rmUp/3qaHAn+c5iZl+40fnO6gSpYQisvo4psp4FxKMSvzB?=
 =?us-ascii?Q?kd3udVMkLHRnHH/LJzZY3M4mGa7sOoNV5n0XgIsX+S6s6JWxkvASuPkJYsSw?=
 =?us-ascii?Q?1xULKKvEuZKaonrx6mE6oTwORjpopFLjm6HCCgDE+UX9ip6i7Yj3mKFkSB1v?=
 =?us-ascii?Q?IFoqWZrgkTYWnMfpIrqtLH8PhlGeAQsLDCHoeIedLlk3nS1VUE/lI3ZqygSP?=
 =?us-ascii?Q?RVuXzfcs1vOBpePp/WCXcTPi9X7WEzJFmOeMukdvmZGO+FZwk6T1keKJRoJ+?=
 =?us-ascii?Q?0Z837XobWmrui4Y7Ov813ZSsVqZ7BgCzyb/+3LIjC64PormbUwr2lTk4C5DF?=
 =?us-ascii?Q?S7CvT6QSsxIok6A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g0VJxgTHt57jhj0wXC+6kNQtvY1BvZ680pXyOv89nhxQZfN65i0DzdxKsTSd?=
 =?us-ascii?Q?WcamNlHavB6yIUf9ovYCCfRDHDQZfHuOiYGj6BraoQ2jBPn9DLFiJk/mrYZE?=
 =?us-ascii?Q?yVv84LLOI0gS0A/4NlMK5YzjTNvkVFoT+k23P9Yv7z9wCC1fHqZspB6WTJBf?=
 =?us-ascii?Q?qRsL0ZH9vrCs9FDq+kr3Kx6Z+4TF4eIRTTG+33xNpRqZcmGoj/bUIyPjqjzK?=
 =?us-ascii?Q?gyUqV+ctDlXyZR0qCFt0W7V3TVnMazdMmKJDXNSwKrbIT8COBARudchSVyJ1?=
 =?us-ascii?Q?71cSe8cRjCZSOx9GeRhaDG9Es3hhswDKMpzqgIKaBKpNfqd4wzGcp0d8uTaA?=
 =?us-ascii?Q?wsF03tVv3SOI8LSXRi+BKzvCGtVtSzX+t7OmXUf5AqmkOZxd4vsUUpEJedy6?=
 =?us-ascii?Q?6YOgOKr/0brOzE/gxi6denQCJr6MWoYz/Ey/7BBoZakJt7/cqYfBbaNxSLbI?=
 =?us-ascii?Q?SNdk6M/zNKuiMV28qHlByXxJTy7zOSRcbz7k9mnJS+kjx0hcTwajSJ5avW6a?=
 =?us-ascii?Q?0rtVWeLfudZ9P7AwSSSvW5/5grgJ5xuMZRrb7NW0Sr+APxBtBE0Ta+vhY74z?=
 =?us-ascii?Q?y521uhRALETcez3Dnd/YpL/6ij2Iqz/MmlOpVRrUunsRe4aKmH+AabF6Qf7l?=
 =?us-ascii?Q?6w8a2hRVwd6+EWq1EghelK7iOKYnVcKf3i+s9K/cHTzDgLEfH4+Mai4XSvWy?=
 =?us-ascii?Q?37YmMLJY7rerHtcMPi3W97zMdC1+wN8g53kOvoHVLU5dzt6NxjIzO3M0NbOo?=
 =?us-ascii?Q?KnVh1DGPsoQcJ1+FAXR5pcvPBRazUq3fdgcql8xNqVYKyWClocvJgGAO5kng?=
 =?us-ascii?Q?bYLQbEuZnMAF2wSFJIwP0gqenESwzsySg2Xw06eJ2h3ITDVuqDedtf++nQiB?=
 =?us-ascii?Q?zWjIE7tQ8kPJSkf0JfeLQY8msahe0AMsVfNOfNmEYdcZDyDylrStwtovdCOY?=
 =?us-ascii?Q?4sFsa/H55Q6OyeNIeS2HbVRCAnb/rYpahsFQ58HrWcolMerh8R30lM9ikMDM?=
 =?us-ascii?Q?bxvtBsCrHHEHtrR/X4ehjmpXg68dR225h9JnBUGXdysllsV29HcBMXbWG6Ht?=
 =?us-ascii?Q?DDLezMQZYJy+8Fv5vOYJTZGcLWbZ2vpj1Ki61As8TNmmJZyBEkVMScN3OYf2?=
 =?us-ascii?Q?fVSZks+gD+CkYXL44huYtE9zERtTmo1WBYVzk25L1PHlONvPAS7gwyItAG9m?=
 =?us-ascii?Q?SAy175BjiQFdk607jmaEiF7TfjwwQ22VDLtbKZEqIly7w1XsJ3SJHrZXTjdL?=
 =?us-ascii?Q?S6r29JfishwZed0/9izd+xvUk0l/8wZAaNJoRmXd4VvtrrV+f7mxWHzXdnIZ?=
 =?us-ascii?Q?s4h3tZP7XzdgF1BA2Kf7D3B9UziTZtGOkCPt8URPnSQTaFKtBCjeM45uB9Wm?=
 =?us-ascii?Q?Pp+C1cTbb/he1kkfznZb2jXjI/ajPen6hZVC9pBkdy12Q0PA6YZ6bIquU36E?=
 =?us-ascii?Q?tvjJx3UEVCTQVMWX8eQhgpZVDRn6rwFHTcZHPzjGl6nREWOW1K+/fYP+JJD+?=
 =?us-ascii?Q?nu+lW8FCNuD69WD3o8V+haVaFfonPqnrq9/BkHN/7FO5PdjDKwny0m4BFmzg?=
 =?us-ascii?Q?rMOwvVrRfWKGSKgQjO/SelJ8WoUKTKjJ/NXqf7LZlU6kgjMc69/HF7jkkw1k?=
 =?us-ascii?Q?Lf4xvoXUFfBx2vAbk4xOvXo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2434F7504FB8D45B1101BEDC4A26461@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IqT/rl44XQespPFVZ3BhvsqLlh06plyU29zB4hzfz4MDaxWGARWA8sqFKEh8Mx1wDFHD2rnHUNuyWXTd+v8M1wgX4HqjeVCtnDbZRdIKAMWBgvgemDIjavT+n8mqDeMnBDwDDTdA3qrTWthhIf89NU5XE0z446QCHnk67Ef1GiMNQlxiWP6AYhuOFVpEPTECBfAKCvs0DBVfVyxEIG/YUfNA51rOozH9QTnhN8OGiSWeOyc9dg5IiMmq9A1DY8S8US5kdWlYY0CCQwMQ3Jd5x7Tc7c5HKld++FQOMQAQUEZdgogIcOBp/b7Ee6Amznyv2Gp55gtUnCEYKbwTQEwh+yHAl6AyO6yv2pZedk11PSrvAZO3Z4b9b0DE1NhBPMXZ0yEHuWRbuIcvYJdpY/gtzILymMT5Jz7Hw+ZvOwSJxV3OBsqnOeQjYXLyLPuA1oLvMfUnQNYGtpGL6MPObQ2HC02pKkqVKhypcibT6wt2kapVvi3HLaNRPcLlUoEDVEj+tyZLJhFEf3A8mndDikFpajEkB8OoNzpGUuoyp/2gPLzcSadDVl9AGUGqWyu8AklRSEACQ9IsZ8qRFMoG3DdP4ja8WN2c2zNtKNZ3yRAx3Uu1DER767FvcDecny+szk7t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43679278-9ecc-4931-6e50-08dd9e4d4a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 01:08:15.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiTVyDU6Lu+pyl6h3zUvRDRp0RuP6+uB6nbcs18RQ27/WzAwXl77C7/HYIPjEmTVezCO8y5DxjxJo5pjB2rUqo7aABwiK9SVCXDaXzFNdOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6502

On May 28, 2025 / 09:09, Bart Van Assche wrote:
> On 5/27/25 9:15 PM, Shinichiro Kawasaki wrote:
> > Said that, "set -e" is a good practice in general. If it will help blkt=
ests
> > contributors including you, I would like to revisit this topic.
> >=20
> > When I had tried to support "set -e", I faced were two obstacles:
> >=20
> > 1) There are certain amount of places which trigger sudden exit under "=
set -e"
> >     condition. To fix this, dirty code changes are required, and this c=
ode change
> >     will need rather large amount of effort.
>=20
> If we would have to make a choice between set -e and code readability
> and/or maintainability, I prefer the latter.

I think that preference depends on each contributor. My conclusion _was_
"do not do 'set -e'" for whole blktests. What I suggest now is to decide th=
e
preference per test case.

>=20
> > 2) When a test case exits by "set -e", it may not clean up the test env=
ironment.
> >     This may leave unexpected test conditions and affect following test=
 cases.
> >=20
> > Now I can think of two solutions respectively.
> >=20
> > 1) Apply "set -e" practice only for the limited test cases. The new tes=
t case
> >     zbd/013 will be the first one. With this approach, we can keep exis=
iting
> >     scripts as they are, and don't need to spend time to modify them.
>=20
> Does this mean no "set +e" statements anywhere and hence that statements
> that may fail should be surrounded with something that makes bash ignore
> their exit status, e.g. if ... then ... fi?

What I'm thinking of is different. What's in my mind is below: (I have not =
yet
implemented, so I'm not yet sure if it is really feasible, though)

- If a contributor thinks a new test case should be error free, declare it
  by adding the "ERREXIT=3D1" flag at the beginning of the test case.
- When "check" script finds the "ERREXIT=3D1" flag in a test case, it does
  "set -e" before calling test() or test_device() for the test case. After
  the call, do "set +e".

With this approach, the existing test cases are not affected. And we can do=
 the
"set -e" error check in the selected new test cases.

Will this approach fit your needs?


> In some of my own shell
> scripts I define the following function to make it easy to ignore the
> exit status of shell commands that may fail:
>=20
> ignore_failure() {
>     if "$@"; then :; fi
> }

This could be a useful helper function to add, if we introduce the "set -e"
support into blktests.

>=20
> > 2) Use ERR trap to detect if each test case exited by "set -e". If so, =
force
> >     stop the "check" script run to avoid influence to following test ca=
ses.
>=20
> As you probably know there should only be one trap ERR or trap EXIT
> statement. So that statement should probably occur in the ./check source
> instead of in each test script. To make that trap statement perform test
> specific cleanup it would have to call a cleanup function defined in the
> test/*/* source files.

I was not aware of that restriction. Thanks. I will do some prototype and s=
ee
if the existing cleanup function handling can work together with the "set -=
e"
exit check.

>=20
> Another solution is to concatenate all statements that shouldn't fail wit=
h
> "&&" but that doesn't make the test code look pretty.

I don't think all contributors are okay with this approach.=
