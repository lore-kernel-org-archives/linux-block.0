Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0C2E738C;
	Thu, 30 Jul 2026 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394711; cv=fail; b=ewLVR4UPTVo5TPe2uzkangZZEivqbNbKksppQ1kYZcDv4odq5IkNUfWWJODv5lDnB2PMTWJjxTSXm/Yf1kVJmjSLbuXOAzw/4Crh9sT8ltg/a7CLQXo2rcmvXNpIOZcBrYMuD95jJo5vpVvngfLid/LKvM/vIODd6qvq/vtxoRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394711; c=relaxed/simple;
	bh=3wTTKG7xa0s83Sa7mAXVc1Kt30Y2yGO1WVAYv44H42s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jJTky2fnRzyQjMSEa5FmzWyg+HtqdGzJm0Y6VkMFj33Q5CKVZ4566rJDdCxQWMrD8nvNe8KwsjEw79uvd1CTzK77HL+vxj+HNxVjXVnbxeatmGBZS4/TBlfJBt9JI3mqBUFouVnxFAsHS0e/5Q7qlDm0b9XiPz1551ehv2EDHNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibppBwN2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibppBwN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785394702; x=1816930702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3wTTKG7xa0s83Sa7mAXVc1Kt30Y2yGO1WVAYv44H42s=;
  b=ibppBwN277ceF9l4txVI3XdUZKg3rMynl5a3YbCtNvimMh84lhBOIFVW
   l0Up9ysJscc/xNKyL5C7v24LsB35FMYpnPO/AVYqXEy1xV5omdlj6HcMF
   jYzuhXB5bhxGicYAeetWvwO54vgy4q1+6BZOGS7t1L5MqxFMh1lzrfYyp
   lzli3YhVEGuyOr8tEDbPjokYi5mLDL7CDvCCwRspNCTj5he1oxs3M09dj
   OFZeGbjT8Cu0cfhWTSpTnh7MXY/GLjO68CP5BkLqVAOHOS54/tqPU5AKI
   q/iuygqUszBRCS7nJcUjDWv8KRNOIbqhRT8/cBz2sqcNH3cyY2VANIwFt
   w==;
X-CSE-ConnectionGUID: ddS8n/wlSsar8n/3dcjFQw==
X-CSE-MsgGUID: +Ux72O+ERsORVjs2BsleKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86084827"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86084827"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 23:58:17 -0700
X-CSE-ConnectionGUID: WzkKOpGiTkm8K6+kv+a2Uw==
X-CSE-MsgGUID: J5s1ufkCRKGTC70N+ldxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="265275754"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 23:58:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 23:58:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 23:58:15 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 23:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyIApDL9rFBiJlGnZR7bYxulNt9HUErzK28FfS8R9opr2mi3e4CKp/qvE+HvD7cz1IXjkiz5Y4v150fTB9myoKUwS+KicavsCetHdPbUwlIVUJ53dnAT3W3pFAidpTh1AbbOAaWDxUwMeYFkvpLS5cq8abB+wKAGIYFwOulCeG4629vS3zl2GsT7/PgYR59ri8VcTsbWyTS3Q8qTqCB5acveHMSHYVV6yXHJrcnEQ5KmTjGfvzs9QO112G7pKmmKT3d2HTxyiu98WG0xmBBrCsAzR1S1UkiRrd67xuG0jKMBUvHGDhDiJmm3rKMO2I1Qr1GydhPFDRNjw1NaSdyGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wTTKG7xa0s83Sa7mAXVc1Kt30Y2yGO1WVAYv44H42s=;
 b=oxViKOHBZjijDDe3zhW3pIOnwYOpkMkhz8flzkG5XF7dvlctxTcHWjU2J6OBBZkiR6Rer7mwjWDPvhQ+FaWrToddQgvka04S/QShW1Gm4jQdVlM2agkviviiZpRZsA89w0erEyPER6l8RMrBb9nmoJYVSFHLsExpVPin1U+IUko4+8YSMgbrcxzEEPegUdmvJ3xkyBlQafVen7rN9I8JlQFnA75Ufdql3bTr+JUikdoRcyG5s4qwyOj0jU2j3hkUNgg/2jJ3DIwy4Gljfben3Mp4YlLb6/aX0ABunyKC0kFK0P8yWktXnLJiprELJY0y8lcNRdA+3RFJoQdEaqURDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12)
 by LVXPR11MB9705.namprd11.prod.outlook.com (2603:10b6:408:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 06:58:08 +0000
Received: from DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c]) by DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 06:58:08 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Alok Rathore <alok.rathore@samsung.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "axboe@fb.com"
	<axboe@fb.com>, "Liang, Dan" <dan.liang@intel.com>, "hch@lst.de"
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "rrendec@redhat.com"
	<rrendec@redhat.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Li, Tianyou"
	<tianyou.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "cpgs@samsung.com" <cpgs@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "alokrathore20@gmail.com"
	<alokrathore20@gmail.com>, "nitheshshetty@gmail.com"
	<nitheshshetty@gmail.com>
Subject: RE: [PATCH v2] lib/group_cpus: make group CPU cluster aware
Thread-Topic: [PATCH v2] lib/group_cpus: make group CPU cluster aware
Thread-Index: AQHchDT6wFLd7i76skSbLxvNltZMWraEOSqAgAKe/IA=
Date: Thu, 30 Jul 2026 06:58:07 +0000
Message-ID: <DS0PR11MB801889FC50AAB91FCCAF8D3A92C92@DS0PR11MB8018.namprd11.prod.outlook.com>
References: <20260113022958.3379650-1-wangyang.guo@intel.com>
	<CGME20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958@epcas5p4.samsung.com>
 <561480862.11785314102640.JavaMail.epsvc@epcpadp1new>
In-Reply-To: <561480862.11785314102640.JavaMail.epsvc@epcpadp1new>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8018:EE_|LVXPR11MB9705:EE_
x-ms-office365-filtering-correlation-id: c7bb55aa-14d3-4d2f-2440-08deee07e95b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: z0+G0J+Uhrm3l+WMk/d4xwsDd3kOzQ1iIuJhuukEeQAURMltE/YfpcNcvbHfryMpxNrugYB5rZQWVAo7Nbo/hceEDL4/RUvDax0+WJoB2ZqRXPvhKMDxGN8bgk4cgKqeW3XygRpd5ZpdqgnU0Lq8lkjP8cczb+Ei0PpXXqUMnhEEZHGbngBvWGjKNR9fPC2nGMojOTCKWEb3+XbD5mrF/epTnLeqmVfit2ZAuBTIUqsx4llvJON4YwtMY4CtTeV77FBgkEdOMGAiR6WYw2doUVvp0hXhYm6jRpybecRmFbUHmcOE4aRQGR4LA31FX8joy4SlOfaRnMC/xBB5Y8/CgtIt4nwWIkiboi2vvcW2nv/hTDI7Vl55cHwoiAQ3t6jOhkqO/BLWSfAMBdYO1WhCiKvnfNBNVEBJ7hVIWr3NTaMiylmHbmBYIxk5LAMnha0Os+6ViDsozPQMjHqTv5aSehh8MFiv4qBAltby8gqlCyBcvfUBt2fN+FWR/gKC6WkOyI/Wsx3dBpkXcJ/ZmvT99gkaq8UjFCc3kqOisWu72kP3loNNgoW6q9FA3FYW1zwL0O2K/MNXVF4ZX8Xmy1jQ0XF7vH+QN11RVAex5Cj5dpbL/5YJ4E87pMqu3HdTRakoMs0gJynlslpuyCFpCaHj+RfCQcbi2WyfV87dAS/qQExJEUznuNtOXr/rW0kqZ+RZdz1R1mi7tPySF3gaB3sNfA7mhMzAgnOPhhmBITzIf4M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0VkS3AwN0VTYWNBZUdWWEFMTmFPdm4xL3ZCcmhZYnFndWpJVE5IQm1lVDNX?=
 =?utf-8?B?WkNxQy9pZTFidzFaYTFRWnRaRkpPOTJHTGZmUHVRWXlRVVhxbHI1WEE3TU94?=
 =?utf-8?B?UkJuZHN6TTFNVEhzVndEdExVL2Z1bElUejlhK2ppaTJIdUxiM0R5NGVnNEFH?=
 =?utf-8?B?eTN0NnFxNkIrUy9TdFo3SUVPdmZKdThJOVJLK1hvaEFYeDVNUkIxSW8xVlIw?=
 =?utf-8?B?dTUrWGl6M2xrN3BWTWRMaXZmMDlkMjdiRVZZY1dOQkNjZDJsODFpZ0s3WWIz?=
 =?utf-8?B?UnR1SFA2TXFFakFzS3U4ZmdyZTAwWUlFZ0xacG5qV2taOEw3SExoYXFQemFr?=
 =?utf-8?B?Zld1dlAzMzZ0WFBlVEdJc2lyUHVFUC9vN0ZBcWdnL0FVT3dJRVVMYmlldFFs?=
 =?utf-8?B?WGJDWGNFM21wd3drSUFoK0hTdVYrUkpPTnhEQ0hqOUU3NVYvdXhNK25lbGh6?=
 =?utf-8?B?T0wxeTg3SUVqUmVBTHdhSUloVDlXSzhlZW5QSURvWWRENmpwYUxMTktMV292?=
 =?utf-8?B?UzdvN2o2UXEyb0VFdGZqK0Uva3N2MG9CbWI1dmlpa210Q3o0Tkh4dWg5Mlh0?=
 =?utf-8?B?bGIvRUhLWEhPTFJZZ3hmbHpUUlRhd1IrUmlSSmlTcTNnSnRLOEE5RS83OUtv?=
 =?utf-8?B?SjFhSGVyc2pzeE5GSWg5TEpBT3lPSGV4M1hLOGJscFh2UlhubUR6dVA5VHg2?=
 =?utf-8?B?RzBNY3RUcXlZc3JPRHo4aEdXQyt4SXNwMjVQNXZqUHR5MGo0Nm1wQmdXTUxz?=
 =?utf-8?B?U0NkRXBUSXI4NENFazZqQXZINnp2NnlXQUdmRTJ4eGJtZjUwbW45NnRMSDRG?=
 =?utf-8?B?K2FMR1FiNTlOcmhVZGUrRlBXNmx4MXk2Ni80Sy9QTVB1Q21PZWxuelluTmU2?=
 =?utf-8?B?T04vRXBTOHB2VThScnVoU2xSQ1ZKUkVrR0pNcVBYQ0lkNWxBeW9MSjR1WFBF?=
 =?utf-8?B?UDVzd2k2YVpFSFFIQnJkTGRHVml5ZTJRTmgvTTV6V2dHU21YZ2xGTDEvVkUy?=
 =?utf-8?B?cHFoZU9ETFNGZ1FsRmUvR1FCTnRKdEd4ZFJhNkJlZkNKUVBtVDRSS3RGZEd1?=
 =?utf-8?B?TWM1clN6VFhiNmpneE1SbGlSVnhhZHFsR3NLdzlSQmVkSU5KRWQ4dVUyalo4?=
 =?utf-8?B?VzRwcnpqSzczNkNCWkxDNzZNQUFqcU1EUVlXdkR1ck9NeVpTK1I5ZGRZWTVl?=
 =?utf-8?B?T1lRWENZM2NrWEw1d3lJaTJ1aW9mMG02dkZlWXQxT1pPWUpKMVlWWFZ0K3BK?=
 =?utf-8?B?alMzVkE5cTNzYjk3Q1lPRzJmMWx0cDJobDlVU0tkbldOS3BkMFE5N2xmdmxs?=
 =?utf-8?B?akpGaW9VVlB5dmtLQmlTQlcrRGltR0lyd1dHSzBROTU3SXJ0R0J4U2R3TU9W?=
 =?utf-8?B?Q1JrTmRQdEdmc2FVR2hZWlJ3dklsazcwMU1Fajk4c2RXbkRSSjRiRVVTSmRJ?=
 =?utf-8?B?VUlvOE1ZVWl3cG4wQVNtcmpWSDZKQ3FkNVRkWnFtZ3k1VjhmYVB2TFROem9V?=
 =?utf-8?B?aEVrdnBpdVM5cXFSM2dhZzlsZzBCSzQwMUtxdmFuQ2d3b3FvNTB2UzBibFdU?=
 =?utf-8?B?WE90M2dESTFoNlRTU1gzYmFDYklwNmxNVHUxd2FEUWxWeDNWNUNMWW95MEc3?=
 =?utf-8?B?M3VTTG9pMTQ5bHU3UVlrOTFQMTVYaXdSTi96S3FqbkYrN1ByelJmOUExZ2pH?=
 =?utf-8?B?NkxXbENFRTVmU1d6eXNBMVAydUJPcHl0c05rcGN3QzJjSXJUd1M1clZhK2kr?=
 =?utf-8?B?N3dnVXdSejdodllXbTBVQzc5cVFWRHo0WjNKeGtMQzhQcEZ2YngreElJU0xS?=
 =?utf-8?B?WGhHNEtROC9nYTJVRXJELzRtYUZwcjF2cGUyRWpUUTVaOGExY3JRUWlZTkEw?=
 =?utf-8?B?bUFwbk9WNjRTOHBQYW90NFZHZ1NsUnNaWEE4czNLaGQrOXZtL3pyNVBWT2l4?=
 =?utf-8?B?Q0JlS1dGNU9xT0RrNTBoSGgzaVR5Sjhxd0Z1L21OeldLcXhLWWpmaXRqbVZP?=
 =?utf-8?B?bHNOVXVTaVd0T3dXRzRGSjVBeXpkaS9KL0wrSm1Tbi9rMWxDNjkwV3hWS25y?=
 =?utf-8?B?QXBzTkRNdURtSnV5MTgyMTkrS09nK2ppeVFTL1pqc1RhQ2FoK04yQmtxek9N?=
 =?utf-8?B?czZqNjN0RnM4c1B5WHJtYUVkay9hdURYd0h0dmt2Q1czMDR0SEI0K1dHV1Fl?=
 =?utf-8?B?OVFFdXdZTlZXQ2VWVStmbzZ2U3hqREJFanJRRHhrZEpvTGdSSVJMRjRUWVBC?=
 =?utf-8?B?L2lya3kyVUdWUkdmSnRLOFR6d05Ba3BIN0pSTkJFdE01VWE4TitEZkNtMkRX?=
 =?utf-8?B?aEpNRFM5WGFaejduSnl0L0U4eTl6WmJPT0wrcTJUZmtxZmlralNsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hr/qQ5y1GX211CSj9m8PVtZYWFKXtFiHYUMsjgHvTuRpdgGOs/4xid6DcMhDAx6T0i8b3HMdALbl90yLCSF2aefhMCguqm2srZxsouUNzbxwAg0GAGDf5IF3wBQmxgenH877AP49R+rs/qDAy/Jj+Frn80DVOpKkBn4Pnz8Y2vIR3eLXaY2AhW4uqC5HYckHwf59V9KFNXXRl3Nzn4giRGVmiEmkpLpyb8SovQ9EWPMEErOft4wU0s2aGe23EGiIBimK80LLkzUKH5hhykpQAyMwXflzWokBSji4O+crqNh0kgQFM5cRtSdo8b6WYVRCjHUCPYYYMEzLIkS23J9o6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bb55aa-14d3-4d2f-2440-08deee07e95b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 06:58:08.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydVdLM6LUAg/U7rSqfSYHBo4HnmsWxPVCys/S3/VgnaNguDhL79qh40/kPVE0GH0iMLo/dc00qpskuBXbnjD2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9705
X-OriginatorOrg: intel.com

PiBGb3IgaGlnaGVyIG51bWJlciBvZiBqb2JzKD49NjQpLCB3ZSBhcmUgc2VlaW5nIH44JSByZWdy
ZXNzaW9uIHdpdGggdGhpcyBwYXRjaC4NCj4gDQo+IEhXIGluZm86DQo+IEludGVsKFIpIENvcmUo
VE0pIFVsdHJhIDcgMjY1Sw0KPiBDUFU9MjANCj4gSVJRLUNQVSBhcmUgMToxIG1hcHBlZC4NCg0K
SWYgSVJRIGFuZCBDUFVzIGFyZSAxOjEgbWFwcGluZyAoMjAgSVJRcy8yMCBDUFVzKSwgdGhlIHBh
dGNoIHdvdWxkIG5vdCBjaGFuZ2UgYW55dGhpbmcuIEV2ZXJ5IGdyb3VwIGlzIGV4YWN0bHkgMSBD
UFUsIHNhbWUgYXMgYmVmb3JlLg0K
