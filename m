Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4D196C7C
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764848572; cv=fail; b=bBi9URClL+BRErExY3z/BChxZAG3V4lIC/24appOUPP141txLfhOzMtd7aXVdcoBjqMBbhL0iF9PcBazD8Gn5xhq/wHQIDuUIM9q/AqT6mqkv0a4aEKkCbtm7gyns5uIYW4XQZfp76VCWmaCbu4CNDo+JwRZixh4UTeZVU4nsGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764848572; c=relaxed/simple;
	bh=XBwp4a5KvdMiLDrluhtvpcC56k8HiA0WDavJdT45DiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ljQG3UP4EFbUVEDJTMlXK1gqjKDnaqZIqSjjU5iXYkWCU8i1JNPjicvwEKIAav0D06ksR7vIVI71leqABIctynrKrAdMbol3IMAGP6rTbbgnr7yZWJ06cDndtnDiX8SjolcaP4xFBYrxld4IAwCelonERUwcGiLg6hjIjFRrXfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XGNeR6jN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FBp4iZmh; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XGNeR6jN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FBp4iZmh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764848570; x=1796384570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XBwp4a5KvdMiLDrluhtvpcC56k8HiA0WDavJdT45DiA=;
  b=XGNeR6jNKPH4Mo2YAq8GdrXTmA1nqxzlozqQJpMGps7SXjrd+XCVtBpX
   AR1VcKJJEpEAZsukj7AmIHuBqQVCIqHJdhpOlBM7Qf+oFgny+7tusXS12
   PVS+LGyoTQX/0qnwXvlPZfX+chUi308Y+vQ/cwG+xhKg7a7tBWFuCSUuh
   epQKbI1U8f9CllEuhc8ZGoDKuEeKfXUzemPPlNC6C8prFc5HOcujrpA51
   PAmzIi4/c/YvwpDgBWVDqsp2FffQW2eYDdm9DF/IxY/KLHrNsOg4ZobzU
   O/GPwyIb2uWU9sf6ceA2ju9qqwScIy7xetmbyBunDWtdQqyaGh3eFrxxB
   A==;
X-CSE-ConnectionGUID: oZerlHsEQOat95YB6CB8kQ==
X-CSE-MsgGUID: dCbFUYb6SrmOg3HQ0hIV+A==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="135899648"
Received: from mail-eastusazon11012010.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 19:42:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpY64X0G4LilZWW9ul9EFjjjHbUxcPYaTIQ7x7ro8fM6wID+RAQKMbRhygJyFERv94fyIwRqOO6Hw7YKZz4SV804CQF/5eXVyUUYwXTyQcxglPWxmUa08wAWXi40mspYP1wmKnnoWucgzIftfgrJOqI9cLZTFdflacPlSzmqRQauNJkJq2Ci9V94zKk7D3rLRW2AXxqtsHvOsIN7zo0r26FTiYvVYTLb08rT5MX+Mb9/UgRRBQkZhMzQ4rLlrJEs9KBMsYV4e1RKQUROAV5kwmzp4IPamY7F0T0Gcw/wu5WDZOMjrREDN7GoDpXNxxM4x9Z5zwkp8/QNkyozM+K1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVFGsMbQt+zjfImRoii+RcuZ5R6oTWCh8GELNOC0ZfI=;
 b=LcjvCPAxOxdXG7P5x7Xo7Uc3rbE8vTzrNf6x3DQ/MLwUCi1Ucz5QxBeqrbz1pFMjRTuRdbCi7XwR0RyKlbbhVaRv2HHhjgx6VcuykU8R0UsnYAd0K2UMazA90Kt2Umn6YNlajZ6B8a8apa8wafP1E3fQQtzmfuxwim/OSXOOudb+Oi0FMuWZ8BR52X/XRdQ6nFVVxJB5Q1HINykcg1x+6NcmFO9/1eCfKdKVL/1FXUNOx31JWPQstyx7cEpNBcA12CB/SDZ3vH5e121paHyCHh1TYHuUPLEWLwz3wHa8TxG0hiUm0ARbpI0g7tteCVuY68UUM0ihccSCwJCw90nK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVFGsMbQt+zjfImRoii+RcuZ5R6oTWCh8GELNOC0ZfI=;
 b=FBp4iZmhoIU/TsF6bRZDkdbF/wDgap/WRd/kKGClOZ8ltgjvERqfSsDpiZ5+Pysa54okbw95zkCm0OvQv0MluASWntKLK9mDOHV3hvYu9QWa97Mov7e5PpxEiE4cbOUF5sGq9wLgLBp1OiIpW3/LT+y49Xgz1O9SuhjEZIQk6uc=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA0PR04MB7212.namprd04.prod.outlook.com (2603:10b6:806:ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 11:42:46 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 11:42:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Topic: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Index: AQHcWbydTCAS9iO+n0Cwz+vVzrq4SbT7KHkAgAAQ2ICAFdnggIAAJXOAgAA6GAA=
Date: Thu, 4 Dec 2025 11:42:45 +0000
Message-ID: <gjl7kqnnziae3yumvohew7nacq4553k6lahfdefc3xrymohzgt@727qyoksolau>
References: <20251120012731.3850987-1-lizhijian@fujitsu.com>
 <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
 <17b6a4ab-1709-45e8-93da-a068192b0137@fujitsu.com>
 <2pvduxbjeccwqgfn2rlofm4aacrnublbwcav4bpcsz7eg5mimd@5tm3576mikyy>
 <82978f0c-4426-4bdf-b270-a86ef9c2d1fa@fujitsu.com>
In-Reply-To: <82978f0c-4426-4bdf-b270-a86ef9c2d1fa@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA0PR04MB7212:EE_
x-ms-office365-filtering-correlation-id: ce50c852-dbff-4d18-c3b1-08de332a3e44
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xr1D2ZXs0u5KE2KRHFm3H4s3VkZePwzcJ6YsnLxcG+Sm+Uzwq4CXevseOnX7?=
 =?us-ascii?Q?9DsOjgUzsD8hNiH5GrTy5XPRUFJ/h0BwnZ5JAChSVu1TgDtDDt1A0Q1bUDi1?=
 =?us-ascii?Q?QvxkvJzQql506AYL6WHU/sd71ohBtrSX64LW5/bbXcqgptCU/kK0fpgEXoFz?=
 =?us-ascii?Q?TIdH7Irlau59t05Ruwr8b9Cy6iyr6rK0n+HnRs7kCDlhudKa8kxBcDlk0DoY?=
 =?us-ascii?Q?LfpZQZY1tG+4YsTUQoqYgCu7Lkbf7dUJb1O6nnoOToWI1ZAlC74tUSgH0QLw?=
 =?us-ascii?Q?iYnkPAOeykRDm7wBBdzRjJ2ktu0oTrwrs4ZzJs69XVZSLG6twEfrueAQsOHo?=
 =?us-ascii?Q?3gwhfh/rp1FNPxH9fGNUpCKFE42ZFYy5JpEY4wdccwjDZ5j1DmRw02vx0WOb?=
 =?us-ascii?Q?b0GvkxPvSMAxqwQM05RejbCMHjPcERIt+KPxBzS1sWkCu67CmVPGEuSILe4r?=
 =?us-ascii?Q?2hD9mYHgXlz783CjAk03JhgNNk+gU2oQJsU2eSijbYy98ERfVHL0Jk81cXm5?=
 =?us-ascii?Q?KzwaVMrxCHOxSruRV0Us/fthARQsHas9hSounzdsUo7ecSdnhSk8tiP5igBH?=
 =?us-ascii?Q?PwMFMGJiFc6rwK2VIzhFHmuLLrz67Bk9xZcZ9lUgHKqBCYSvGGIgMM1hf55m?=
 =?us-ascii?Q?09tJO4JXNDarv2PqZ7ENlRTZEn0LJnoOeluW5S+vLWkJpejw2ArJyCY4OVVH?=
 =?us-ascii?Q?yk2SKh/aW4WMQAxrQPMu56NogkOypFWJhV3HMeWsFAaAIf8ESq5D4cUOwwm7?=
 =?us-ascii?Q?/q4mGCpasOaTXulz0jXyafhqV/+UM02S0cKUa3EYXZANipnPZxWhxmRzOLo4?=
 =?us-ascii?Q?m4qFLUPMrPwS7cWbCj0Cl4pttHRO0xGZA9NnTTUCPNFFLPVksDdcm+4o2m+N?=
 =?us-ascii?Q?ouvC8UO537CHa3Bglm+DPAW3CgAGJ5ZAw1W9GkKvK4/Ri+IQ8RNLSNgiNzVM?=
 =?us-ascii?Q?/m2am0+Y2ksIVqX093TMlYuqPycFY5j0DN5P5FzH4Mz7uEZNTAdlJHkpkIHw?=
 =?us-ascii?Q?qljlo4Zun7jqK4Ae0j4c2k683zbRJxGWbjJhdGA3J1R5jFFkqCOtyDJ3aZMT?=
 =?us-ascii?Q?5J6X0ocde6rMGQ2HpX+JN3+pehRO11tKWYS4iqJrPx5NkRdnPb7VX74jfw4H?=
 =?us-ascii?Q?FfhLbCiZzvFvWqTIRUIlYN/6fS1LiQOMW3QhwGZcCDha3DjrP0ewfWH3hpX6?=
 =?us-ascii?Q?6i/npr8fSmiRp++877Mhl2G+8HNvMlL0OANggw456nv16cniZUwX3wC+ViMc?=
 =?us-ascii?Q?agm+3x7qGbSWoiaprVPP0DOU1I7KaO7EDgBF8iDriFzQJXzLseVo8jzy8Q48?=
 =?us-ascii?Q?TRkCxrXG+TL7UsKERfdDr+VgTfn9STJVXqVpjR8Cbyw47KBiWDI+D0ciCrrv?=
 =?us-ascii?Q?e/wJVEGrMzy+I4RpYht0gT26gaskFg/Uy/Prdr9kDth1XDnZ2gPBNGESNXZv?=
 =?us-ascii?Q?T4v7DjRfGPUH6ND8NJzdzVubczd1ztr/tyL9Q7Hn/DJxBWnbVEjwA6ztmi3D?=
 =?us-ascii?Q?LRtQ0yucoexmsCfO1bqLnNOwAxE7KVSEJ4ha?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6VNBIhqHhYR8RheAGEDbBypxGkc0/hZwOUhB/+AGr9Qg09khufx7FsGBkkmh?=
 =?us-ascii?Q?teM9tM7DLEHYfJAZ15UowXMwY06GlrC3dDssaBwR7xSDHxhFFfzjcFvKs+9/?=
 =?us-ascii?Q?8VmqvP6k6rkCW+hU0ZrTJHReHndDWuIGTEikyc5zGQdBnfOGEuXqEbCkFBlz?=
 =?us-ascii?Q?QgBMpHuPNouHeDzAqXJcX4AD1x9Ffv6qRP+QqOHYEQKoI+Yx9b+3/ZcK4auF?=
 =?us-ascii?Q?l1mk9Q/qas9ZEiXkwLPvPDbVvPymYnXnZXD9+LdOx9V5cH5QvYjL/XSzl0E0?=
 =?us-ascii?Q?ey3uX51V2l3KVfLKyRZ3ry0z8cL0Uww6gkuvBeKnb5wmnLBw5II5TUYnR3Zv?=
 =?us-ascii?Q?2Rl05naiB+DJ2KTGvLKVtUNPX3WYDxFSwfkUxAV9ZxqI+ObaViqqLWbSc1sJ?=
 =?us-ascii?Q?rZCLYgDPBvQ5jwjUHLXoH00q1zAhrzxTKc//mpqG9GJpaGpjUDSVUAHwh03l?=
 =?us-ascii?Q?LOBaw16/W76l4p6Uaaf76PQ+lbJ8Mj0QQRyEeNQkDsbfU/bar5X2R5YHSMeY?=
 =?us-ascii?Q?NIYw185Kfu0OCDIj+sX2r7o0RR/LVrvGvECc2S54Drsh9koADGfC3ZtrBQX5?=
 =?us-ascii?Q?jzCDirxmz43dIRg3g3Iw17J6IA15jt30bZO96n61upmAS6a1v47LGCM6dl1+?=
 =?us-ascii?Q?B4ucDjibFiaMJW8zP88mqEBW+TJHlDs98csBEeQN+/jiNr0TybaFkHP3N0QC?=
 =?us-ascii?Q?Fi8e/Kcb1PSuRu5unbveFP3jPukQE5XVNmtqiEOq63ii+iqPNajOJtUAL6gz?=
 =?us-ascii?Q?e6MQxsdnPSHhwxMF6tdsbs3TOGxaJAEE+8ScIVV5GfalcX4mh1KjE8auXLb4?=
 =?us-ascii?Q?uemGPhbY90LpiPB1XhLp810bxZaFvyL48UuZaS6DOS84AI0iJNlP4XA8Uu1k?=
 =?us-ascii?Q?TubHCCuwxvEXUOkolLT/8ueHEsHK9NvJLwcCVbQGPpD0Nw3FtFIKLo55OLe1?=
 =?us-ascii?Q?9Qf+EwLurnX+GFYuRPSaU34Tj4d6zs4scEj2pEze2ULGNYOT/CDSbDOR68P8?=
 =?us-ascii?Q?gDqv4dIqXMcm1Rwt8HZhMOWtsvJFLxoLc0OB/AXB58VJov282MPrSNJZ3pKx?=
 =?us-ascii?Q?jZrbAVxKHev3DVdkfsd2CBiECNUZrLyQWrhdE+WoeOUCXFKIQbY0uZpUSzyo?=
 =?us-ascii?Q?1HkyIKFaDx0Pt/z5Z3Vt8Y/5XAsnJUGaj8tuWGP5pXQlCrpel7q+ZARgE0Kh?=
 =?us-ascii?Q?C9iZiieeX4iorG7tJ92lf3dt1xaeNgY8aIFCqbWko0kw4bBgDlk23sCq/afA?=
 =?us-ascii?Q?JR7xGw0xJBs4plXHlx9s7IiU6zpRRyN6+B7nHwGL5yQzc68Ohv4WVwi0s+W+?=
 =?us-ascii?Q?u6TlX8ZErJJvD4w6PcNj2B3o8XD10/R22xwcmZc+p2K+OwneyRTsFLxzs7NT?=
 =?us-ascii?Q?RQb+wKtQ78RXWD7SERP77lHLE5MYbSuJ5OrATYQLIAbDYkcAjk1RhVRHS8Lp?=
 =?us-ascii?Q?7D7Uy4NKAvhswXwYrK3tSsB37mfRf2AG9l4l5BmP2Mw9LiqMPZh6sDUDzHrJ?=
 =?us-ascii?Q?GkCNPP+i0P3DBufMKZRNMREZ2dBPYiTzIbfs2KTPDQPVt/Vkq3gk7GWKdpPP?=
 =?us-ascii?Q?cY/HjIXglkwAfPvR/gEWqetRDbyInkaxPnL9NuoG1+ixoH80jUbK2gekXIMJ?=
 =?us-ascii?Q?gbGI7nWuQKGKX1c8YRJYAVI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F31C1893A6C7E4D8EB7311CC66F4251@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qqXxhEWi0GfmVhuB+Lm6IRBd9txkcTi7STM88I7xkn9TE+AJBG4jddeELGsFlt6iCNUBrJkZPhFuPzrOrQyYNDeWygjuTF8cL9avL5l2s/T56TwmhXYN89ax8GWzHjMC1uw938ZJM0leR7rIIfIfdinKVURctD3D0bq/AWBItq96sYXhkpMopb5MCLlnj64VmFZFoM3D7dPsllhPhaWUHeHLh9SUNYUJQtAdZzoKeccKDjeOjLEovO8J/gcqM95mxEhtu1CsR42AFny6D0CL3Xx/i+/i0gKG3pZ69k/QRCwg5n9o1pvUsCUW9mppKIZmum2T49Dy5cBgE4MP2w9anp27iUSArmxFuGV74tPQwVFTx8nVFxDe6gW0K03PE1P3XBiwvUjukIM2kj/Ht4sgB/DjWpksDumQUWAumc2v0MNCnK9qovbXOn5CotE2JSV/jXUr6/nsVKy2EQ9m3wxhD3PFEBfTUYoYe5BxR44/6tD/OZvprtSgz4+7MbHqNuQa4fN4Zt/WEhIDe2UklOtJvUbda0T31HePKaOA1dsjINPGJ6WrpuzpSR8YFwNbypV9f0J/wUgbM4ZkL06IAsyiz+rn6kGBTHM7+X3udD7r8cH/RPsZd5Xw3InAEPGHugeb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce50c852-dbff-4d18-c3b1-08de332a3e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 11:42:45.9157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpEwroRO/bFRD0Ml2tz2oB68Ih4Hi/7mdkaGxxRvYNJvongw5sKyrFgCdhBcf1vMAPc8D/ezEeazPAdWVM/hKq/2QzJx1e8/LfQjD1lVROs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7212

On Dec 04, 2025 / 08:14, Zhijian Li (Fujitsu) wrote:
> Shinichiro,
>=20
> Thanks for your efforts.
>=20
> On 04/12/2025 14:00, Shinichiro Kawasaki wrote:
> > Zhijian, thank you for finding this and the patch. I took a look in it.
> >=20
> > The test case scsi/004 checks/proc/scsi/scsi_debug/* to find out
> > "in_use_bm BUSY:". If it finds out the keyword in the proc file, the de=
vice is
> > still doing something with using a sdebug_queue.
> >=20
> > However, the sdebug_queue was removed with the commit f1437cd1e535 ("sc=
si:
> > scsi_debug: Drop sdebug_queue"). This removed the in_use_bm that was us=
ed to
> > manage sdebug_queue. Then, as you noted, the commit 7f92ca91c8ef ("scsi=
:
> > scsi_debug: Remove a reference to in_use_bm") changed the message from
> > "in_use_bm BUSY:" to "BUSY:".
> >=20
> > IIUC, the test case refers to/proc/scsi/scsi_debug/* to confirm that an=
y I/O is
> > not on-going. So, I think it can be done using the sysfs "inflight" att=
ribute as
> > below (not yet fully tested):
>=20
>=20
> I checked out to v4.17 and tried your patch, but it doesn't seem to work =
as expected.
>  =20
> I added some debug messages based on your patch, as shown below:
>=20
>   41         # dd closing SCSI disk causes implicit TUR also being delaye=
d once
>   42         grep -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBU=
G_HOSTS[0]}"
>   43         while true; do
>   44                 read -a inflights < \
>   45                      <(cat /sys/block/"${SCSI_DEBUG_DEVICES[0]}"/inf=
light)
>   46                 echo "${inflights[0]}, ${inflights[1]}"
>   47                 if ((inflights[0] + inflights[1] =3D=3D 0)); then
>   48                         break;
>   49                 fi
>   50                 sleep 1
>   51         done
>   52         echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ cat /home/lizhijian/blktests/results/nodev/scsi/004.out.bad
> Running scsi/004
> Input/output error
>      in_use_bm BUSY: first,last bits: 0,0
> 0, 0
> tests/scsi/004: line 52: echo: write error: Device or resource busy
> Test complete
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This output indicates that even when "in_use_bm BUSY" is present, the tot=
al inflight counter is still reported as 0.
> This suggests that the 'inflight' counter might not be capturing the stat=
e we're trying to detect.

Thank you for trying it out. It proves that my suggestion does not work.

I wonder one thing. When I just remove the while-grep for "in_use_bm BUSY:"
check, the test case does not fail in my environment. I guess that is becau=
se
I use rather newer kernel. I tried v6.1.118 kernel, and it passed without t=
he
while-grep. And my system does not boot with the kernel older than v5.15.19=
6.

May I ask you to try the same trial in your environment? With v4.17 kernel,=
 the
test case should fail by removing the "in_use_bm BUSY:" check. I'm interest=
ed in
which kernel version the test case can pass without the check (v5.10.x? or
v5.15.x?). If the necessity of the check depends on kernel versions, we can
limit the CONFIG_SCSI_PROC_FS dependency to older kernel versions, hopefull=
y.
