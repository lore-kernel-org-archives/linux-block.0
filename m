Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15016D4FC
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970430; cv=fail; b=JqDTOXdsPE5zmC+uBRiOOw0SfnRKs+tu1zH4TTKx9+pONNzhNtpetZVr0zPSdmhlRb7sA1jrBMG3YNw7XcRypvkJNvj7WnUOYA/AuHGKe50KOT2Sh2wGT4rxc8SohpEE6j9FMcY4uf8SUtVbGLNvs8cAOYX84+Gje1IZHh0oXo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970430; c=relaxed/simple;
	bh=a1yO/pwVQz68a50UrjEk1too4S577TxotjkmTYTLK3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MRReYZbycsgf6L788++8j/csBszftC/z/yFU5PJJcn7nkiwLNJnJitcthykG6b7FHzakLxOtb8HGU3hgWHKXEXQApLvIlRw3AUU2PZEcUL3e8yNrQII2v617aPq8O0ew8zokTDbnGnKHHJi5nthe5+Y3k049TH+p+ZpWLNTRVpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OueweRgr; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OueweRgr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716970429; x=1748506429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a1yO/pwVQz68a50UrjEk1too4S577TxotjkmTYTLK3k=;
  b=OueweRgrTnIS0sCSdfy9roynqEAf05YV07r7BnhGgYsfcEViwsSGPtW5
   9q2GwD2DLkAR6vcmLI+NqKh2gyCVSTJfs/EyBKsLV4pUkN+qOEGfZbQsp
   t6F3Cmh8CFKezeYOcjEHYO2rA/e9xyF/dSl7wp8ymkRySlM6vFUF6Wy6t
   Pw0nd4TM//cEh4TPXvBdrXZLDC+7RVZdF6AAqzWHGTi60zj0Qudcuboy6
   BwmGDV74YbJ/NwXDUHMRjZTUqaIxgfvd9CBQ+HnxC/dqd0sPbHF300VFW
   hqj9KTgDUs5rSPjGwOxKbdj3ZlKzrdZ201Dd0zip19xlLjs3pFZP2YtvV
   Q==;
X-CSE-ConnectionGUID: 7tmwBBtBQ7iAjA+90NWTaA==
X-CSE-MsgGUID: FNYxSzRUTyWWRJk08qEOtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30859131"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="30859131"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:13:48 -0700
X-CSE-ConnectionGUID: VTrC09G/QGm3bKUsPj/CGA==
X-CSE-MsgGUID: pI3RuXpYSQS7LcCAEPTHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="40238228"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 01:13:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 01:13:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 01:13:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 01:13:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 01:13:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjMr6LZPKeyRnoxQqgWAOoAjAestMOGYHmApFNP59XBV5K/8myzquatfp9gkKGLDzZosD8/2nfTYwZKRZcG/kHkgn81Z2icA8Mz8aSlTmKQ6ccisQ8RU6Y5AKIwPcRZ5Ej/HyGz+FEjDGYLtk2mvCss87bxnOSHks7x5PJ2jdkVTmkCumzPuic7A5RbpeEFwBC4Qin1WBM7Fo/nET14ieT0VWAdGcIL+uo9hCqrTmLlnuyxp8/szW1UlCkgQX1WZTmQ+udReX64zGciSgPOvuO9HTnKAmL/11W1PuNiCsVw3h3nt609k5DdEE8tbdbJ0nfdxZZKcSJU2TrC3ZQENYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1yO/pwVQz68a50UrjEk1too4S577TxotjkmTYTLK3k=;
 b=FxXvwjpoCQ7i/xOOftlG/Trr6DaH6Qw3H9RriJyUzuWpnTfA65eU/QKnVMfOoqeOEDbHQKOnnM+JnINOZk9ijVY/5LYJAfPcgaV6XkDyob//tPRGf8j1S1INlpr/45Tc/RVv9B+vc6AhVPb2Lj7w8uUfb21gy0+DGgP1wSW1laS3hdyLhJcupclnpVqqp+WGgZE+zzIR2Nj5cevu/OAS91c7aPMyqyuOlwddXp22pSNG5j3nQByQJTVVz3FOtBIrNuTO+V5Jv1EqANdy0dUHcjn223fqMzwkyhcu1XuDx9oJNhMiF68294OtYYlxU1zGQSfS1u8ewcop26ci+QP1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 08:13:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 08:13:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Yi Zhang <yi.zhang@redhat.com>,
	"sivanich@hpe.com" <sivanich@hpe.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, linux-block <linux-block@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
Thread-Topic: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
Thread-Index: AQHasKYPTv7zz31i1UaKtXUejL220bGsFquAgADRa4CAAALegIAA01uAgAACm4CAAB2DgA==
Date: Wed, 29 May 2024 08:13:42 +0000
Message-ID: <BN9PR11MB5276CBD826F1E95D28B2E30A8CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
 <ZlVk95sNtdkzZ8bE@8bytes.org> <77c7eb43-2321-484d-a1bf-50ddd907db17@amd.com>
 <80ceceba-ac9c-4ab7-a0e3-bdb9336a86e6@amd.com>
 <CAHj4cs9W=OEZTPqi6jx4Hinebz8VCJBpngHnr5LO-+xqWMrG2g@mail.gmail.com>
 <f9252410-a295-4ad5-9925-228119011539@amd.com>
In-Reply-To: <f9252410-a295-4ad5-9925-228119011539@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6300:EE_
x-ms-office365-filtering-correlation-id: 56590f1f-ab98-432f-f5da-08dc7fb74102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a1Q0WExscUVBYmdPRHF2YXB4d1RRcFV2Z0hYUlVORWl6UUQyL24ySXQ0U0FZ?=
 =?utf-8?B?NVAyQ2t3SXlud1l5WUZlKzV6eU9iZ083eFVtaUp6TStwYWVWYndRVncwSVpO?=
 =?utf-8?B?NXhxazYxbmYvN3dFK2pqSlVZQnIvVytFNWcvUW1rbnhVQXUxOXpYK0ZWUFdC?=
 =?utf-8?B?QlR6V2JxV3B1T2ZQSUR5cFI4UmVWamlMdHkxYXZLdk5USjlQRGdERlZSaExp?=
 =?utf-8?B?NGh3VkQ0NTY5UlArV2E2azk4cEdZYXJUTnFlOFNGY3ZEdzVLNmxOS2JoQUVj?=
 =?utf-8?B?aVBjdzRYOHo1VUdvNGhwTEdhS092L1V4d2FUazd1YXdZa3hoajEyVWMxOVhj?=
 =?utf-8?B?VVF5aVQ0VEg4Y2Yvamx0TjNKSzI4RU1UekNERExEZXBCL1Q5U0lmQUJHQmtm?=
 =?utf-8?B?TkpOUm90Q1dzaTNhYmk5QjZIMUo2VVZ0bFZzcjhmeGNJWFYzeXJyYStWMmJu?=
 =?utf-8?B?c0cyWVByQlVJV3ZvRGl4TVBQWi9OVTVNWGJnU2dRRnN2QjJLN2U1aGJSTHJj?=
 =?utf-8?B?OWtiRXNIaG9FeENtQUthK0pnYWRzRm5OM1I2R3BLRTBIckJBOUVDR216eGtL?=
 =?utf-8?B?NEhtV3FHSEhhS1FzVE55MmVZYXBwQ09IR3AyS0FrbDRXMSt5Zm1iU3FraGxM?=
 =?utf-8?B?T2dYZy94OG5tMUlJUngxV3J0NDlUZGQ3ZGNhRUM1ZENldWkycjdhUitMaG85?=
 =?utf-8?B?dnpqVkNxcEcrZkVIVEJvc2hYQkRZZHM4OUc1K0NXc2pldnArQkgxclJwYmJJ?=
 =?utf-8?B?Yldrc2tyY1dENnVJYklZaWoyYnp6dHZRUDZSbCs1dk96eDhocmJkTGZ2aXho?=
 =?utf-8?B?TWVHaTB6T1Y4RTNSNnl0L2JHSHlIUTRIM2J4c0c3dUxpZWk3d0VIb1hwd3pl?=
 =?utf-8?B?TExRQ3M1MXd0OHp6WGsyTEVSYWdldjF1VGJxUFg4SE03V2wwQS80Qlg0RXdn?=
 =?utf-8?B?M0ZPN1RWQ0plUiszUU52cmxqZkZkQlhUMnFKaXBQZmt3a1dudlJFNEVQVys5?=
 =?utf-8?B?VHo2TzF3aFRpeHc2Z20xYkY4Q0o5YUdhbTBkcXlrMnVtZnRHNzFRWXZIQzFh?=
 =?utf-8?B?eXBacEFwRkFnSStEOTgvYklqeWFRSnozRnNHOWxBSWRTSWRmbnlrdkUwUGl6?=
 =?utf-8?B?UFkwb1duckxKSk9aTFdzazY3WitrTUUwS0t1NUNQYmZab3FsQVNsM2RKc2NL?=
 =?utf-8?B?TUUycm05NDc2STJuKzNSTU5wZ1hGZUFMVzZ3UzNsSkF0UEdWOCt1UEN5amJx?=
 =?utf-8?B?S3drMWRpMHpUMS84YkVVdWtiNFZQOFlxTlM4NlBjajRHVC85dlVhbjdMK3hV?=
 =?utf-8?B?VlhEdmJUeEh2L0NleExCRG5NMFd1UTBoang2Z3E1V01DeFF3d25Tb3p6cDdW?=
 =?utf-8?B?QWlCbTRSOWZpQlp1NXJBR290bnZ4SWdUNyt5M3h5M3c5akxicE5mNXJIRHBj?=
 =?utf-8?B?NVJwaFB4SEFrUktGM1BaOUZDTEpYSkx6RHkyKzgyZkd2N1VpdjlQUC9vUjk2?=
 =?utf-8?B?akp3MkhHN0lPNHRZaFowek5kYkFDK2ZPcWorYkRTUzVzV25UK29yYWNrTURZ?=
 =?utf-8?B?Wit4Q0lqRjZHTGxUUm9tNGVQMnozUmYxMWhTRWFXWURIUXFNTnBpa2xDNXYv?=
 =?utf-8?B?TTRYWmFEcGRielkvRXROTGsxYXpUSHYxU1hHZkgyWE0xdytoYlBxdkdIdWht?=
 =?utf-8?B?OEM4T1ZkRWZoOEE5Q2Q5MndFdE1lWVhLMXVHVzZqTlJ0Z3pYRVN2dytaejVD?=
 =?utf-8?B?ZmFoZUo0Wktldlh5ZjJXTnlYU2FxNXNFRUlhc1haaFJxK2M2a0VZaXhOODJL?=
 =?utf-8?B?VlpMbUZGOW5ObnRESlJPZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdDdnFza0U4QWN0Y1Z6YXdqYStnelNKenpHdVpYRStXem8vZEt6a2ZuZDhI?=
 =?utf-8?B?NzJvcTdWQlpFK2JrbGExNjhiaHI5S2phU2JYWlR1aUpDMEo1UVhQSG9EcmVx?=
 =?utf-8?B?Nm40NEtNOFdyZkNGell5bm9BUzVtSFNoUWQ3UUxIWHFmNTNocUVwWlk4VEV3?=
 =?utf-8?B?UTN3SUlsWW1lVVJkMGtFMFRacnY3MTE1WXh5THhIZ0traFh3Z0tWZFRaSTV6?=
 =?utf-8?B?WDdRazd3ZUl6eE1LNnVncGFIMk05MWZ2d0VGdDg5cWNrQjlYWFVmUTJ2VEM3?=
 =?utf-8?B?ZDJHTTdES2lXSGtJYXVBWDZTNEx5dGFwZUxPaGYzOG1CaGtCWFpRakcwMTdX?=
 =?utf-8?B?UzBFWHVCOURWTWRMc2NOVis1VS9rT1Z5STM2bU5NbHFNeGs0L3ZkWjk1THhK?=
 =?utf-8?B?SDhYT3JaN0grWmJtcmMvZWtGL1ppSVd2aGhDK2ZYTitBd3N5TXFmbUFZQWl1?=
 =?utf-8?B?M1k2QXlNOE5JcHQ1SldKVW5PTUozdHRtNFQ0WnRTaWgrek40RjBYZEdEVkw2?=
 =?utf-8?B?aW5XTWdHaHJGWU1SUm9XdmdiRFB6SU1zYkUvZ2FCclpBL2FOdkthcjhLYldh?=
 =?utf-8?B?VWZqb0xzd0VoOUd6TUt0RWdGSW15aTc5VHVWUllMZG01c3lUSjlxY0l6RUFE?=
 =?utf-8?B?SGc5am9DWUhrVnBUdVhKdG53Y3VtUlpLb1JZWG9kNFBtcGxUTEliZXBPeC9C?=
 =?utf-8?B?RE1EcDg2MGtQRGxTeTRqT0kxSVAzckZ2UkVHc0lUZmZyRWhaVjREYlR4VGow?=
 =?utf-8?B?eE1QVVhWQXVTWC80V1RkSU11RkEvU05oL2RYRU1VT1o2Y0lOYjYzQWpPaStl?=
 =?utf-8?B?VFdxUTEzT0xQS3ZMNWwzRUMvdGc4bVJOOUJrTDlteE9oRUZQZFdXMy9WeWow?=
 =?utf-8?B?c2Y0VnBZOGcxbmRhSzJ5NFYzckEvY1ZaMjVVZk1KRXVqTmJjUkNHcE9IY1Av?=
 =?utf-8?B?N1F0RTBKR283UzFkczJydFFWbHI3STRQZjZ6RUttZ2NsRTBnbkZ2MHpYaUhD?=
 =?utf-8?B?RENWb0JsNFREWjZhS0ZRWVFLVTZJQkNVRkdpTW5rektxTklwWG50eCtXd3Rj?=
 =?utf-8?B?akJhOGVxMXc0T1VSYjhEdHU1L3p2TFdITjU1M3E4VStrQmlUWEs3NGpiMmQz?=
 =?utf-8?B?ckp4VE5rWEZiR09iRWtnMEdIMFB6NDVBUGNtaW1NM1AxSDRybFNpZUg3Vllt?=
 =?utf-8?B?UW1QRlNJZzFvQ1BVT2ErS1ZhQ3cxa3ZVdndleFU0Z0ZTWUpFTVh0WW56bENt?=
 =?utf-8?B?M28yMERZWFU0WW12cUtiTWkyT0tmQURGUkpQcE9zenhsQno4SFBTeEdxdTRT?=
 =?utf-8?B?d1ovSU8xVVoyYlEybmVRaUJHdmx3QzlqaWNTS2xodGdTMXJiOWdiOTE0c0Nr?=
 =?utf-8?B?eERuN0ZZZzV4LytqaDRDb2VBRUNZcnMrcjJZYmZtSlVoL3pGdkRpVFlLVEFT?=
 =?utf-8?B?cnc5QjIzem93UkdUMGt3R0U4VFJmZkdFaFMxREtERTJtMTh6bjBCYmsrYm9Y?=
 =?utf-8?B?VUllTWZMM2ZwOHE2a2lEUS9MMUF6Q0grc3RRRmxGS09mZU1Fand4MXR3Tk1S?=
 =?utf-8?B?NURlOXVXOS81VG5tM0Y5Q2sxUnJ4QVRvdVU0ZW4wdjl1bG9mL0k3d3Fhc1lh?=
 =?utf-8?B?dDdqR25Jd0pvMzVha3F3Sko5MlFmOXhaV3o3WUJocnpNaE9RSmliM1M5QzVK?=
 =?utf-8?B?RVB1WWI3bjJLdzdLeDF4Sm15YXdacmtoTE9JUllqSFJ3SkZEYVF3NWRIWGpq?=
 =?utf-8?B?S3BiTTdwMkRGbUY0enpqWWJlcXpoNUJWelgyQThDdit1MU8yNXU2dzhuaHdy?=
 =?utf-8?B?WHpobmlRWFhIVDRTRldOdU5Sd29OUVRtR01Ud0k1cG5icDVZODFmaFE0Qzhy?=
 =?utf-8?B?NEJQK0VhNUptWHJ4QU8xK1c3bVpKcEFuaDlZeW9DZzdmQnNCN29xc2gvMTBr?=
 =?utf-8?B?OHUxTkJKSEd6YnYxT2NKNW5MRVZDVWlzN2xiQTdTT3NXa05uYkNDTkFwb1Fp?=
 =?utf-8?B?U3JROUlUWERGdVNPRUxtTjYzbDNlMHdJK3dwMDBlZklYV1RUS3hLNWFjM0o0?=
 =?utf-8?B?NmpLMHg3cmVaZzZtVzljMDd3S2drMmYveXBDSUlGVEtkTC9jODc3ak9ZT2Ft?=
 =?utf-8?Q?qVUBVqz9qfgw8ZZgm7xlX9Iub?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56590f1f-ab98-432f-f5da-08dc7fb74102
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 08:13:42.6026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/g0DRMJQ1bOjzqY0TDwwhx4rO69MktCkqejhZXxpEnIaf62GsNHkbrbP8dWczpeoFA5yXH989oGd79ifSf9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1heSAyOSwgMjAyNCAyOjI2IFBNDQo+IA0KPiBIaSBZaSwNCj4gDQo+ICtEaW1pdHJp
LCBMdSwgVGlhbi4NCj4gDQo+IA0KPiBPbiA1LzI5LzIwMjQgMTE6NDYgQU0sIFlpIFpoYW5nIHdy
b3RlOg0KPiA+IE9uIFdlZCwgTWF5IDI5LCAyMDI0IGF0IDE6NDDigK9BTSBWYXNhbnQgSGVnZGUg
PHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiB3cm90ZToNCj4gPj4NCj4gPj4gSGkgWWksDQo+ID4+
DQo+ID4+DQo+ID4+IE9uIDUvMjgvMjAyNCAxMTowMCBQTSwgVmFzYW50IEhlZ2RlIHdyb3RlOg0K
PiA+Pj4gSGkgWWksDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IE9uIDUvMjgvMjAyNCAxMDozMCBBTSwg
Sm9lcmcgUm9lZGVsIHdyb3RlOg0KPiA+Pj4+IEFkZGluZyBWYXNhbnQuDQo+ID4+Pj4NCj4gPj4+
PiBPbiBUdWUsIE1heSAyOCwgMjAyNCBhdCAxMDoyMzoxMEFNICswODAwLCBZaSBaaGFuZyB3cm90
ZToNCj4gPj4+Pj4gSGVsbG8NCj4gPj4+Pj4gSSBmb3VuZCB0aGlzIHJlZ3Jlc3Npb24gcGFuaWMg
aXNzdWUgb24gdGhlIGxhdGVzdCA2LjEwLXJjMSBhbmQgaXQNCj4gPj4+Pj4gY2Fubm90IGJlIHJl
cHJvZHVjZWQgb24gNi45LCBwbGVhc2UgaGVscCBjaGVjayBhbmQgbGV0IG1lIGtub3cgaWYNCj4g
eW91DQo+ID4+Pj4+IG5lZWQgYW55IGluZm8vdGVzdGluZyBmb3IgaXQsIHRoYW5rcy4NCj4gPj4+
DQo+ID4+PiBJIGhhdmUgdHJpZWQgdG8gcmVwcm9kdWNlIHRoaXMgaXNzdWUgb24gbXkgc3lzdGVt
LiBTbyBmYXIgSSBhbSBub3QgYWJsZSB0bw0KPiA+Pj4gcmVwcm9kdWNlIGl0Lg0KPiA+Pj4NCj4g
Pj4+IFdpbGwgeW91IGJlIGFibGUgdG8gYmlzZWN0IHRoZSBrZXJuZWw/DQo+ID4+DQo+ID4+IEkg
c2VlIHRoYXQgYmVsb3cgcGF0Y2ggdG91Y2hlZCB0aGlzIGNvZGUgcGF0aC4gQ2FuIHlvdSByZXZl
cnQgYmVsb3cgcGF0Y2gNCj4gYW5kDQo+ID4+IHRlc3QgaXQgYWdhaW4/DQo+ID4NCj4gPiBZZXMs
IHRoZSBwYW5pYyBjYW5ub3QgYmUgcmVwcm9kdWNlZCBub3cgYWZ0ZXIgcmV2ZXJ0IHRoaXMgcGF0
Y2guDQo+IA0KPiBUaGFua3MgZm9yIHZlcmlmeWluZy4gQU1EIGNvZGUgcGF0aCAoYW1kX2lvbW11
X2VuYWJsZV9mYXVsdGluZygpKSBqdXN0DQo+IHJldHVybg0KPiB6ZXJvLiBJdCBkb2Vzbid0IGRv
IGFueXRoaW5nIGVsc2UuIEkgYW0gbm90IGZhbWlsaWFyIHdpdGggY3B1aHBfc2V0dXBfc3RhdGUo
KQ0KPiBjb2RlIHBhdGguDQo+IA0KPiBARGltaXRyaSwgQ2FuIHlvdSBsb29rIGludG8gdGhpcyBp
c3N1ZT8NCj4gDQoNCi1pbnQgX19pbml0IGFtZF9pb21tdV9lbmFibGVfZmF1bHRpbmcodm9pZCkN
CitpbnQgX19pbml0IGFtZF9pb21tdV9lbmFibGVfZmF1bHRpbmcodW5zaWduZWQgaW50IGNwdSkN
Cg0KbGlrZWx5IGl0J3MgZHVlIHRvICdfX2luaXQnIG5vdCBiZWluZyByZW1vdmVkLi4uDQo=
