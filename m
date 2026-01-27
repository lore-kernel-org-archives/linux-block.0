Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E122F74A
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497628; cv=fail; b=HbFWqlKbMUWDZBBfBoa1nNEB+YXSid/dd9qgKik2BxllFoL4OO5skHEL/5SmL421/1HaRSw583aQX0Tl3Tn36kJv68T1ulTi/hSdJo/e0lECEFLBlsU83sQiZiTVr41FPA66WmM+t8IrALLi31h/svr1nxXhwRbS3jRK3PiBB9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497628; c=relaxed/simple;
	bh=frGPL9egCjbc5rfZzSdrdluxQLIt5yxXxz9/gziasOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NgEoi2s3LdQ1Ms1v1wnlyfnL54abw8rB6ZsyyVEwEfHvXzIi7W7dbTj+wHyt/dhiO2f+PByuCX8gIOB5JmRGeLatrP8VRl82EGcoUpWTGtvUibqF3FNz0B856vuYMxmgSL2LotUJ/4BhcAs3/NWKRbeq5eg3+sV3gOk2qKiqcIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YZjrwvnU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=U44WmTUU; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YZjrwvnU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U44WmTUU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769497624; x=1801033624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=frGPL9egCjbc5rfZzSdrdluxQLIt5yxXxz9/gziasOA=;
  b=YZjrwvnUBISXYDVP3+AO+a5r62BDC/rGTzyt9QsrF7HPlqSVJ0uTz7V3
   b2ZwroMaoLvE5gXpTYyzCtBjLOKb1URbYyx0VPIBLdTXSGRO8kyguChiN
   YPWlRKSGSW5SiaYNElT15Pa+P8SbRcsuyiyaGrc/MqSj/mc+GQw9MYpwc
   tSacWGSuDCSkybs2zrAZGqfFbiA4yeK1DfWADqD4K6phan08IAWPjLs4j
   CqkQeAuJWMY7VY+BtoHK0HHVv7W3dsHPa7C6IF1WSIODvKWB369t/CsW3
   ru7TlLLHcDFthyqDZZMcZ2kX4e9Wo4eRBKTu86Xi/emYtNJljyiKI5kqs
   A==;
X-CSE-ConnectionGUID: M+ifsih4R/CruhZZWRkQNQ==
X-CSE-MsgGUID: zHbMs7T3Qx+btYRkaj61kA==
X-IronPort-AV: E=Sophos;i="6.21,256,1763395200"; 
   d="scan'208";a="139544069"
Received: from mail-westcentralusazon11010056.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 15:06:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR2Oz08eW0Gb6iP2aQeKFnRfCqWv+G72dhib82vI+T9f9zbE2jMpeSNljYq/PyAbEvQHrqKo7ytbXe1PDrvKRlL+yt2mGNiGfWa9t2tAPmzZNJEcjm+cs1I5Pzi+aoLcFLMrnGn2g3syOhWoKLkHTYPTzBsEJgvyTLFJJ5+/KPsktMjQWRhX0rmjRSlntrcNRgvp4iI+ibhxgMMCHHK+ER1qB//dgKmSaW+dmDjY7SsvGr7fIYNsp+o0dLAusngtrP5GMBuhexMgVNtfVCaie56sZbID9X+w6xGzZYATjygAwaDycfyp0+IU3ii12K8kmuHPmlCoVwEvIlkVwyS7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52nME2fIx+P2g+/mN30q3eMWq8LZSLAkAuBs0UYXLPY=;
 b=kGiCUjn5Ao8A4jzeioTwTFimrBvbpeW7I+TRp9idCSvydaKg8M4myv5PCCdCnVlXGbtQUTTdbzsygHuF8Td0n8y5fz/ohQVkILfANbVoUvP27uHVBQoZ+UkPTASTtKnUt4kaLu5/s/YCQHHRBfTC7vR7jBUCOiAwj72ZplaUShHLWlDNRacQJFIDsKODN/bvobh8e+OPnL5m8gLLVteSu5xVVmZV8r1pmyzfL+Yd02Pq/6KFg799A0D5ivBlcB/llZB+w0q93ZEOs2RSxXa0nZhPYt0VR63iUw8TL0DcM76rQE8i5IVKC4bDmhtWKJjIWAHzeDjTN4e8orUPwUBj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52nME2fIx+P2g+/mN30q3eMWq8LZSLAkAuBs0UYXLPY=;
 b=U44WmTUUTOHEtnRt8omaHH8kQ/ZzsOuWfprEAsTwvCSFgKwceMNrNe7+YgSOZVjGVYLa/gMOWuS7U4SmwT/Esx162VwwvVsqCikxsNEgPbSGrVRogzF51TLXttnoyawCOL4eoQOZZ4tQOnGLsG/C7gxlKmqfdzfmaRDLgTTBl2w=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MW4PR04MB7299.namprd04.prod.outlook.com (2603:10b6:303:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Tue, 27 Jan
 2026 07:06:57 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9564.001; Tue, 27 Jan 2026
 07:06:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, "jinpu.wang@ionos.com"
	<jinpu.wang@ionos.com>, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
	"grzegorz.prajsner@ionos.com" <grzegorz.prajsner@ionos.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Thread-Topic: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Thread-Index: AQHcj1uF6aAFqkLNGkSDZznIJxQSVA==
Date: Tue, 27 Jan 2026 07:06:55 +0000
Message-ID: <aXhLQmRudk7cSAnT@shinmob>
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MW4PR04MB7299:EE_
x-ms-office365-filtering-correlation-id: 55e08b2e-d1b3-4836-c715-08de5d72a7bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?d5lV3j5P54OheJQndCc0rf1fsTxM87xPcb/W1rvXpXeIKkYBY7Lvl2EaENAK?=
 =?us-ascii?Q?lKr21EuDpMz7cprQZ5HezQ9m5zY7sV8WawswKDqyIaN6iiGI++nPpMFg9VOL?=
 =?us-ascii?Q?81QpK8HVOrHJgCUgNDVBEonTN8c2v65wI8EVdRuvLGVFIwE9r/ADBO79H6Yy?=
 =?us-ascii?Q?o/PE9xVFAGdP1ptovT6z/Qr1bYjJUJuowCzu8qbD2QBUWu6JASSdMa2DWXJt?=
 =?us-ascii?Q?B6P5lzS8bBARqbcYj3KHYx8wmzDmpQb71kV3xgaGlATAftDwU2uXgwar7Bcq?=
 =?us-ascii?Q?kPBKR7XYkC4fMLGGs8ZkkOg3JIu9PMJzktfACt5h/e5EWlLB/rqzHm0dzQnK?=
 =?us-ascii?Q?zdJDAXXcCOSLdMOjVjgTrqJZ6/hXn2aGVgnXquR+tnq9HQwpIgnAvSSkMPDI?=
 =?us-ascii?Q?N4gvPCQ63SmECYUhN6krNjJpW8N/s3DVivIAtZvPi8oyHCc/K41GDgnwYWgd?=
 =?us-ascii?Q?Yz0jN9RYi9X/gfwhjHeZQomHRbB4S5hQ5pi75WYv4iNECmo9SCmKacqSUsrD?=
 =?us-ascii?Q?g0GUivMr5eXgYirN3LZ6W9sysPpNcBA1FhetVyt8fe20xTpdMxcMRNYqzfod?=
 =?us-ascii?Q?/ZkFa1HT9Z4AGWZp3csxAY5bE0aKXMmpk5AEb0yRUZ4PUemt2AHBGXoQuBIu?=
 =?us-ascii?Q?szE/svI75Bqhm63ZtBI2XxfObP0AkGuh4Lb1me/1IkdJREKdM7an3BInCMUD?=
 =?us-ascii?Q?9yl+yXRui9DtBIGBs0Ceg955GvT8DiMEnEAIxavdoWO+bkjgv+jUAkvgRG9b?=
 =?us-ascii?Q?RVsNajZGCqLFdsjerjMM09kOWdN07s8vytP1yuNEaVXf/aBiZ2HtN9GVe+is?=
 =?us-ascii?Q?KE+14/zbYeCgr2BGssvQYHWyFf8JgBSM/cI2TWC9J3cb+Bkj2ysWOxvcZh+O?=
 =?us-ascii?Q?qjIgwt3n59DSzkqrTiKpgYRehSs3LdeOF4ewunSP9ebiULM3+G/7IgMsr2RQ?=
 =?us-ascii?Q?SM8dG/HT9exmG+1Fw8CYKzQbeHzb8C/i9Cch5VGZWj18MWJNJX6z4KJTvqAc?=
 =?us-ascii?Q?oANXiIGxGlClrE6dTead7UrCEGJ6wK2d8OVNhNhgL0H1hZnjHLwlpJMOrN8q?=
 =?us-ascii?Q?2MA+WMjYGAu28BKKS/Gnxi2/AMQkc7Y8CrwFxEhnM9aOPGlf6VMH+klRgcid?=
 =?us-ascii?Q?GTDudqj6G75/x4BUH33kcRnnEf+C/bWjo8Hp2dO5ehPsj1TBp1rmJgcvVeaS?=
 =?us-ascii?Q?o+Hmz9e0MxVFqTvnWUoPRbltXXV69q56HRi0gVxFnt8VirCXYy6k8xd9cgms?=
 =?us-ascii?Q?gspWUsFCs/u/jRNngIILXFgls2mGQ64WXXFWSlrWpxDf3kwdgH0cgnDMk976?=
 =?us-ascii?Q?+GWkg52xPI7NXaE9Otkaiy9P2TW3h2StAZG9ZUKfpEUSUqYgqJOB0R7GOXRP?=
 =?us-ascii?Q?kB+blp0m6sYxAAhDygZyy0/FXWiNmfWqHalSiz9YmIwgg8R367eDAf1HJVGv?=
 =?us-ascii?Q?kTry9UjyFoH3e4Bt8AnEyaPTOUzGfJhjHZbVwBxpX+tpFiCwkXCvTvUCx3g1?=
 =?us-ascii?Q?VkDkJewVL91nxVMOlVo1TcsAlKWsIEecsLilCjEcRylpohbjR1fs2G/6/Jys?=
 =?us-ascii?Q?LIlMFAG4pvE+y9lJp4xPSnJq0Y6ZQ1+bE2ZzgcfrILeu61DtQRppiKKHWdFp?=
 =?us-ascii?Q?HvscH4OmbI7NMn7K+W/ubUs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tsTBsf+1eNctqEmulU9gbe1tYsLCRKKXPk1eOMsAjGAGlOnJ6876SPoXLQlt?=
 =?us-ascii?Q?vPG2Z0drabI7ustvDp1x7lJdISQovRIbDEPPBk5uBWr1fS3tYmc1S/V9Vc2/?=
 =?us-ascii?Q?EY4j1yc/nATzKXsJnPhQM6gGWGhSWErHbntKDe2yWCG/jGvFamOagFOy0EJ0?=
 =?us-ascii?Q?0HUUMsXe7oa/4cIRkNcSSGd2TH9pkOQSlbZw/SCnpNuHx3lMZuThlzS3PZa9?=
 =?us-ascii?Q?mjYOqMxg3AqonhDaqhQ0RZyNhyJb3TjsExEMJlC1WqVJALsLThi3jeDrILw+?=
 =?us-ascii?Q?zsBTZN+5M4tf3eKXov8Cd6B+PJSl7PpclJ7Z5B/v+scsl05RG9ouf1qrY3B1?=
 =?us-ascii?Q?yQrMxOUBitoCpRNbXPDNYtbMJCYP22RYfpZr54mGD6TpZvFJfBbxuTjj3lBo?=
 =?us-ascii?Q?SJdY5JtBmchuy3zBS1Eh5NWdMrnTLS0uUe+9pPTTaKY8ChEC4tmXIOgBUsZv?=
 =?us-ascii?Q?trdisMShH5HialJ9j0+hng0SwYXRm/31L1rvCDhJJA8aaLYje+ULgVskaCfx?=
 =?us-ascii?Q?9fQ26hX3uA4Bd88UWHIxW4vBFmGqX6g5UDEXk7tXpuhx8ieBOhVwmbjbOPoj?=
 =?us-ascii?Q?UpnN3wvWLCz23v81UGhIpmaJWJyEhuN47dIwUe3B7uVQj3LG0NEyHtFZnl/3?=
 =?us-ascii?Q?nLho3Tczqcvr06fOAUjSs4UvUBvN5lHxDiWqjVkJIu8NJIgtWb2OT/pfax2W?=
 =?us-ascii?Q?Ay6MTzRxyx5M3B+8dAfgDysSVwV9UNWXLo9MLJfayjO/Kv0BDy5NrQoqStqr?=
 =?us-ascii?Q?vf+Bng4/uej1uKQXZu3AjZS11qMhJbpwtIK6NMqaCLTAyS3g9zjM6zZItp8h?=
 =?us-ascii?Q?87W6JuYcm1hNPlGSpwc481lv65MzkWQYx9LqONgLkVsn581w5Ub+w/xPVg1s?=
 =?us-ascii?Q?QuceyHJFq80zmlMwWqWM6HAKqlf7VskkJtKDFrCar46fLLst0+zj8Io+cMwm?=
 =?us-ascii?Q?z81r/zvMDAM71u4EiydmTbrE8JMUZd8omgH6865t0WhyZ4zxjtLgOmnXgUSa?=
 =?us-ascii?Q?9H5LAZVLWBd27qtryjUlGLPoVDqfddLhFjCEybL2/v1fVz+yiHFbKK8wUNR8?=
 =?us-ascii?Q?GDNlQDmSR5cxxscmk+U6BTrnc4EoIWIm6Qpa6koJ0htoNhQb/K/nVUWNfvtC?=
 =?us-ascii?Q?msg14RHCWjLiL3eDzmVkPpVq4p6r/mwBr72t2R4jL1ymMdm9MpASTeb3Fkg5?=
 =?us-ascii?Q?epK+Ub3xSjHjP9tqFX1pWNnwJxzFzNUAzqCP7RDYeDVeCyWL3t+EzXhrOHCd?=
 =?us-ascii?Q?Gz/5T1+rJrWtHDAQcziwunXYjII3Z40XCDiWpRSN8o9GIPpxS2tzvXkCchUK?=
 =?us-ascii?Q?opHiorpNZzxPCIaxFJ4CvVGrhJSbPYNbWVV6f6MicqLMu+YHdQOIRxsEz98K?=
 =?us-ascii?Q?d3WNLqghWXqCxhms640usBMPZ70diLJ+ax55z15i7GjGE45z2THDPNEztMvN?=
 =?us-ascii?Q?WE+tcLcpHlBPH0B1s6OzXBmvfgsNscN+9cbbE5U5WLjBYSi6mpETNPKxvHeV?=
 =?us-ascii?Q?LxSD/xhDCDapCGXZTWp1AEJDLnkTi+sk2fvf4l2UcwcViIZ8+aUrp/HVFiTU?=
 =?us-ascii?Q?kBGeROtwPgKL5I5OazgKBgjHvqXRBItYdOFatqGTO3iJrBQ+Q/gBYVdmSTYd?=
 =?us-ascii?Q?6+2qTE1yVH2kEjoSv0r/Lg2qcMnMF/s+1XMY/v7hnXqUd23GctsUjOk5Kie+?=
 =?us-ascii?Q?Z7zYNzaix3qBepVRkYIK20KlVLTAshx8Bj84/nZ+tD+4uvRA7YRwFNPUivav?=
 =?us-ascii?Q?7BEsTkkwWRE/f7rN58Lc9bTdtMiNhQo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56CEE01695D80748842255019C611AB0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZF0IWOg2Kg0ExWsTViCdevv4noX6xzDlUvpu3/cNFYDAVrNVR2VnGlb1qPUj7WFKR/aOcvCMI6dLFAcuzKXx3bcyXdYv+1vfSUZBgEAI19LaX3MW5+CCd2CHGRnA+H4vKTfGK5ArZgDFe3cysDd+J8zs2K+1ev9qKh6Z1/djs0uKmp2WJ5YQnVnPgKNi8KTKXkUilHOyS6gKROXfSAz6si/okNNC58JFQgy/359hpepI64XL63pXrS9YsE1zuq724lesQKVAy0/g0k2FHpdB+jdKaV4pIKYbdHdhQ4SN7QVFXCmh5p9gYg7cGJebnyfjKRrKgrXBMsDeiE/QF8gLGMAXLR/v/UVUzeqow5sC6bnLGaLeI3D0NLq2BNP3VLEyOvteZTFfxM1ssZf43J130qD0o76GegzePaFtzRtwUZAHfTMQ3kE4qDy/n6yTu6YqGUOuQMhimRThh0sYdLl1H5L7mFuAhP6Kk9IogqbM/bo0GJd/OD5cih/Q8d+wP9bn+yZ580upXfXk5Z2BgQkJ+CRC4WisI0wvVGnCqtng/pZph9WNfuT8/ojNnPIMWU2DrY0qYI5vqr+WRKeFaqjcad/AJsMEdjASezQeNlwKelx2Wq8kC5CoAsh64m9TdNzZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e08b2e-d1b3-4836-c715-08de5d72a7bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 07:06:55.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1o8j3pOqfVkLZItEN8Gbv1VXfpkQsuUVTwhIPdmxwQG2sjO891dwZfnP8DFpDtT+DPLLXYr1oKa0ekD3utidub2RRiaJZnCA6fbojqTv1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7299

On Jan 12, 2026 / 15:19, Chaitanya Kulkarni wrote:
> During device unmapping (triggered by module unload or explicit unmap),
> a refcount underflow occurs causing a use-after-free warning:
>=20
>   [14747.574913] ------------[ cut here ]------------
>   [14747.574916] refcount_t: underflow; use-after-free.
>   [14747.574917] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x5=
5/0x90, CPU#9: kworker/9:1/378
>   [14747.574924] Modules linked in: rnbd_client(-) rtrs_client rnbd_serve=
r rtrs_server rtrs_core ...
>   [14747.574998] CPU: 9 UID: 0 PID: 378 Comm: kworker/9:1 Tainted: G     =
      O     N  6.19.0-rc3lblk-fnext+ #42 PREEMPT(voluntary)
>   [14747.575005] Workqueue: rnbd_clt_wq unmap_device_work [rnbd_client]
>   [14747.575010] RIP: 0010:refcount_warn_saturate+0x55/0x90
>   [14747.575037]  Call Trace:
>   [14747.575038]   <TASK>
>   [14747.575038]   rnbd_clt_unmap_device+0x170/0x1d0 [rnbd_client]
>   [14747.575044]   process_one_work+0x211/0x600
>   [14747.575052]   worker_thread+0x184/0x330
>   [14747.575055]   ? __pfx_worker_thread+0x10/0x10
>   [14747.575058]   kthread+0x10d/0x250
>   [14747.575062]   ? __pfx_kthread+0x10/0x10
>   [14747.575066]   ret_from_fork+0x319/0x390
>   [14747.575069]   ? __pfx_kthread+0x10/0x10
>   [14747.575072]   ret_from_fork_asm+0x1a/0x30
>   [14747.575083]   </TASK>
>   [14747.575096] ---[ end trace 0000000000000000 ]---
>=20
> Befor this patch :-
>=20
> The bug is a double kobject_put() on dev->kobj during device cleanup.
>=20
> Kobject Lifecycle:
>   kobject_init_and_add()  sets kobj.kref =3D 1  (initialization)
>   kobject_put()           sets kobj.kref =3D 0  (should be called once)
>=20
> * Before this patch:
>=20
> rnbd_clt_unmap_device()
>   rnbd_destroy_sysfs()
>     kobject_del(&dev->kobj)                   [remove from sysfs]
>     kobject_put(&dev->kobj)                   PUT #1 (WRONG!)
>       kref: 1 to 0
>       rnbd_dev_release()
>         kfree(dev)                            [DEVICE FREED!]
>=20
>   rnbd_destroy_gen_disk()                     [use-after-free!]
>=20
>   rnbd_clt_put_dev()
>     refcount_dec_and_test(&dev->refcount)
>     kobject_put(&dev->kobj)                   PUT #2 (UNDERFLOW!)
>       kref: 0 to -1                           [WARNING!]
>=20
> The first kobject_put() in rnbd_destroy_sysfs() prematurely frees the
> device via rnbd_dev_release(), then the second kobject_put() in
> rnbd_clt_put_dev() causes refcount underflow.
>=20
> * After this patch :-=20
>=20
> Remove kobject_put() from rnbd_destroy_sysfs(). This function should
> only remove sysfs visibility (kobject_del), not manage object lifetime.
>=20
> Call Graph (FIXED):
>=20
> rnbd_clt_unmap_device()
>   rnbd_destroy_sysfs()
>     kobject_del(&dev->kobj)                   [remove from sysfs only]
>                                               [kref unchanged: 1]
>=20
>   rnbd_destroy_gen_disk()                     [device still valid]
>=20
>   rnbd_clt_put_dev()
>     refcount_dec_and_test(&dev->refcount)
>     kobject_put(&dev->kobj)                   ONLY PUT (CORRECT!)
>       kref: 1 to 0                            [BALANCED]
>       rnbd_dev_release()
>         kfree(dev)                            [CLEAN DESTRUCTION]
>=20
> This follows the kernel pattern where sysfs removal (kobject_del) is
> separate from object destruction (kobject_put).
>=20
> Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Recently, blktests introduced the kmemleak feature. With this, I observed t=
hat
rnbd/001 and rnbd/002 fail on v6.19-rc6 and v6.19-rc7 kernels with the kmem=
leak
report as follows:

unreferenced object 0xffff88826c5f8720 (size 8):
  comm "check", pid 145048, jiffies 4301507712
  hex dump (first 8 bytes):
    72 6e 62 64 00 15 b3 a6                          rnbd....
  backtrace (crc f6c244b4):
    __kmalloc_node_track_caller_noprof+0x69d/0x900
    kstrdup+0x42/0xc0
    kobject_set_name_vargs+0x44/0x110
    kobject_init_and_add+0xcf/0x150
    rnbd_clt_map_device_store.cold+0x164/0x792 [rnbd_client]
    kernfs_fop_write_iter+0x3d6/0x5e0
    vfs_write+0x52c/0xf80
    ksys_write+0xfb/0x200
    do_syscall_64+0x95/0x540
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

I bisected and found this commit ec19ed2b3e2a ("rnbd-clt: fix refcount unde=
rflow
in device unmap path") is the trigger. When I revert it from v6.19-rc6 tag,=
 the
failure disappeared. I also found that,

- The commit message assumes that rnbd_clt_put_dev() calls kobject_put(),
  but such call does not exist in the kernel v6.19-rc6.
- The commit message has the Fixes tag for the commit 581cf833cac4 ("block:
  rnbd: add .release to rnbd_dev_ktype"), but that is not in the kernel
  v6.19-rc6. Instead, the commit 581cf833cac4 is in block/for-7.0/block bra=
nch.
- The commit 581cf833cac4 added the kobject_put() call to rnbd_clt_put_dev(=
)
  that the commit ec19ed2b3e2a assumes.

So I think the commit ec19ed2b3e2a was meant for block/for-7.0/block branch=
.

> ---
>  drivers/block/rnbd/rnbd-clt.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index b781e8b99569..619b10f05a80 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1676,7 +1676,6 @@ static void rnbd_destroy_sysfs(struct rnbd_clt_dev =
*dev,
>  			/* To avoid deadlock firstly remove itself */
>  			sysfs_remove_file_self(&dev->kobj, sysfs_self);
>  		kobject_del(&dev->kobj);
> -		kobject_put(&dev->kobj);

As to the current Linus master branch, the hank above was applied as the co=
mmit
ec19ed2b3e2a, but the commit 581cf833cac4 is missing. So one more kobject_p=
ut()
is missing. It caused the memory leak and the kmemleak feature detected it.

Haris and Jens,

I suggest to pick up 581cf833cac4 ("block: rnbd: add .release to
rnbd_dev_ktype") to v6.19-rc8 to fix the kmemleak issue on the Linus master
branch. I applied 581cf833cac4 on top of v6.18-rc7 kernel, and confirmed th=
e
kmemleak failure disappears.
