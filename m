Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794309593;
	b=P6xQQxDSMfJyh/x/QnGj9g5HTeTN5TLsp+ojN4pTBkGvDVq+UGgI8sWXzKb9ViQWmWDP
	 StsqVb+SGCs+YYX7mF4fPZpe38KdEiWZdNDlZ12i1CRJk/Xo9sltt5PDMVRy0j/euMN5D
	 IPIKwC0p9It0rfawOmDiA8IHwWiA7LAgJWAxM2o6fhWvT6sd8upfYecWGHKDUwcgloCFV
	 iA9f1LKi0yhLw8fZWr7p592GiNZPAyDi/44XCVJ3nxj9iRSdK0JlvzG/NuqcDIqRQcj4T
	 nwc0OWK5jAFtUBuXIbiqvkGfC63Vd0Mm9dkRSlWDnSTWFftQiZEZoZ6BPZXNurpvVTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309593;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HIZly9Yu1T0mY5cTyuyeBbk9Z930c9tbSVUSvjoG+yA=;
	b=ybzqR1qFaFkKHjVpNf6YzrQxxwlJwWpNVFcS1hXw4EjygzrP//Zer7iwLKlTXI/8nn4p
	 pKEb+RmeMHxP5UyCnJgqkq5p+4GFiGPa9+RmUMvb6i7Enp2TBvR0oqYadX+aZYtieZgBb
	 qUh218FCpF5HaeJWVeea20w1G9E5vSpxo3LiMQz+rLH7cZin1nCgw1E3xd52pBrh2UOXz
	 Xd4niQHvmU9kgR5j6x63vGSlMIc3u7zirTelvqYPzaeKAxSqxWyl2tL/aZCqy1MCTDTJm
	 EeSjZNXHOCbrGJAfWU/VakwjhT4Y2nW/SEMXMlBmvIBxJP2rYiRiA9hni3rIo6BVETg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Z86Iiuc+;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=CiuKsuCo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD3606A325
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 11:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BADD3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Z86Iiuc+;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=CiuKsuCo
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794309599; x=1825845599;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ls8KBnjs2o5S3fit6oM1Rbn1SJiN36vcBo7qzUKx9+Q=;
  b=Z86Iiuc+mJQMUbc/5Y/o3Typ1VsV67KsfPHGdiKix/NrF9zV1JiV/YK1
   MXh4kKSQcVwDT4OhB5mj2Es9dxcxXNNdT/wqH4LP4PGqOXVp96X5/N9OJ
   jgKWvYY7sj8ZmVyEkTcuoylw+nhGQktUCsy/4n9G3+zj01qdj8VlfLFLe
   4/2p0PupwHqGcPsXWRm7BuAbiPICxeFHagzo19qUXR1suuvwgzcZ+c5V+
   PjdhJrV+jkEVC6DsHloELmcNdKHP4gGCu9tCKOKuc/cmAfSxsBF6I3ZT+
   sAVW8ZOiW1wuVtTNY1cEsFGYctnWLhPgxj0Z62hSS5dib2+G1jzFGhrmE
   g==;
X-CSE-ConnectionGUID: aPNwFC0MR5OdCB0O2XN/dA==
X-CSE-MsgGUID: ffI3sF9FTIaqGEJ3BVBkEw==
X-IronPort-AV: E=Sophos;i="6.27,205,1786982400"; 
   d="scan'208";a="159538433"
Received: from mail-centralusazon11011032.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.32])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2026 19:19:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtQXiJj7e1FopTIRx0lsVPeAVmDtl0rjCyOfKreiB9gmJ5dF52PFRdHI6Qa1ZoJhGz89x9wVbqR1lliOBrmDx4cFTimPaQ/5ZsV2Tk1MbFTGy1BUYP31rGZUJGIY0SfxE7ACk/HO/BuUnv5ApdbTtrnsQ+9Ot1crTps+waRj375CRDOkNKzD7lhhRNVXz4Yy2RP3/eda5KNWlK8iyG9MtChzHt7Us4GQSwIlx6ZpXBOPElWL0kKV0QXdRXCvg4pCYa3hgsB9bWFBi4RSm9f7CtofS9Bw3bkeidbCATRWIk+dExiCQf75ueh4qvI040/KQlNEP497ztPvYjHb5Z047Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIZly9Yu1T0mY5cTyuyeBbk9Z930c9tbSVUSvjoG+yA=;
 b=sdrWg6v2OXJhO4KplGO+Yosn+CnexSIahMo4rPM3wfQHxuUWqQ9cT0n6cWtoCcYPL9WzuNEJlXBNekN9d7J5l3RIyCyBJvCRjpPVMTFXz5S4VxnMpSrVn18Jg3RxZs2g7Qo03OV82Z5+Nq+TZqrlgtZctnhezLd9Aw/ocLKrizvPW9GgpBRjU5cobAlVVv+8bsEmgbfkLGjmpju72r95ssSoutNWldB3/cRviUDwVhz1H0olTdKFoEd0+nGaCS+99Q1FdYnZqnSuqbgvtGG/9bhe0X/sK5LXFuO0FkoP+AcDOduYOH0Mooc+Cns/VyocULNhBp1uemkF2GUzhbxjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIZly9Yu1T0mY5cTyuyeBbk9Z930c9tbSVUSvjoG+yA=;
 b=CiuKsuCo+Nc+JGQBc16CXRToLIoAsMC1gm3NEuyyFhIymN/0SPiWG5xFunvIlgwTzgFieYPXz9JB7WvQWd2xF8VW5nkawXGjOtNt13wWvTUxQIRpuWL7TKRCzV9G5J8R/TsebUc9tEV1YuD4X98B9GOhp4L9ZTvd0SlHmoE8c7I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6534.namprd04.prod.outlook.com
 (2603:10b6:a03:1d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 11:19:49 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 11:19:48 +0000
Date: Tue, 10 Nov 2026 20:19:43 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	John Garry <john.garry@linux.dev>
Subject: Re: [PATCH blktests v4] block/053: add a torn atomic write test for
 block devices
Message-ID: <avL9qcoPV384yOC2@shinmob>
References: <20261030-blkdev-fixes-tests-v4-1-d8d18808e965@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-blkdev-fixes-tests-v4-1-d8d18808e965@columbia.edu>
X-ClientProxiedBy: TY6P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b5d5a7-bdcc-4473-a738-08df3f1c8836
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|22082099003|18002099003|6133799003|10067099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	bJA3Qp57zOl9NZLWsGpYFMZQhYvmK2kT7abptXnHU3E+Mwq/ZJaiWtMwHJ17r9iG1hcA8uL6ZWhWx1g1RmmoYSIC9QMIU43t++yNpS5xMfyk5pux7Cdx0Ux9MSEc20zR9dTXlK0SJtwwSPbH6x0C3mbfmU0liEf+S8glGeefjpL37ySo5FlyvLJB0+bhCOvj2gNZSrLaGosC9D04KGgEG80fLR/fut0UOm8k7f+LYBzcIqoQcbE1ivm0MHioYGlmlttWLvUVZZEzhbM0sgn671am3Ze2sYia4t4VdptyswNNGdLfNXOwwLFE65oXVU1c555jWf7xCJaJHY8tEEhpzO91gVETehHIgPzldOHwIdVsxeZuQ3GJjJVe5Dejl2ipr0J66Ww62DWvJJ5LLMXWxYEuBnrCAhgwgOYFGgrZ9SApZ3BtCifeY1zm8a6Bvm0Nc9tYyzDqVmP26d1jiJGhxBmdAFjnNJn6j6fsiCUiCcwqiaOecEBaOTQNuwnriN074Dg11XZ5Yl8FZSWLKhRtenDGz6edRxjpbDTML+iwNuUrsNA2YTGS4qI4WIHPgm1xvKCJEIQ2LZato5dmz50pmbZe3c19ZZo2ow6LN4qjW9AyXKSrje7N6FHBOmG67cpHIgd/WsJB7km22dlaBcT43/EjwKfbQxSXtTLQFahp9ms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PViRDAyUiKvs620Hbt4EraRQokhOeL1ZVqaU+wJHPqtD6SOxW7aW2gcTJeiF?=
 =?us-ascii?Q?P+c16PdSZHIrBJlrJ6dZ4fzD9AYki+Bk7UeE3F6A4A+nnZPosQXuUDekICEG?=
 =?us-ascii?Q?Td80cgPjMVDAK6JeZoaT7JZtCM6Gk24GeAmTDKSse7qLE8ymPu6+CF9Xs9Eq?=
 =?us-ascii?Q?W3DX7/EWXsrBVxYWQWwprOqFobgSqXfy5a7wGKJ+xuazQMTm7L1A4hk6MG1T?=
 =?us-ascii?Q?6RToIsh+LTA+paomFQ5G6Ajnw/judfclHi6aJxXvB0GKUD1Vql+/U91HHKhf?=
 =?us-ascii?Q?zsLjIWZYXD5ExMkSlXFLxO/W9j4W+GGZ8r/yVE+cliSPIPtpJW00STop5uKA?=
 =?us-ascii?Q?N6DOQ5uWXHs39wpG/35ROOEB+ugxuCDWdweUNuqBvv5AGEWRf6/KWqerebOk?=
 =?us-ascii?Q?8gu/0ti0TRGC8iR5dzE+1aWpVYs9wWhYUb+2B691E7SJ3L1NmGFokP2M8EFj?=
 =?us-ascii?Q?tivGjrUiCtuPlJVXUhtcblplChSmA2wOzvngeZMql6eUXyVegYtHQ0/HaB5o?=
 =?us-ascii?Q?icY7v6zb8xxxNPpkzStp0jO9Ca83LE4Bw3NjczeiGaTS2IVWzewgT9xau7OK?=
 =?us-ascii?Q?+spC2rh8wgjSzLI8bQlZ4WOBZBEMWiyAsMSLZCI6V3RQMmyYepz/BYsBNleo?=
 =?us-ascii?Q?3m5MMPwLixTQTGa/scNfl+pkEPQroacq8x5GqNJQyP1hVmHnpsS/iXfXRCAK?=
 =?us-ascii?Q?r6LZZUZwARoCN7diIL2++wm25vsiB5Wb/kFjv25+pQ9EmIFC2wz66OT+BY97?=
 =?us-ascii?Q?DCSCwtq+KVlg+Si4cMy4Bey3QgeV0ETmX/GsaKcQIVq/X20Y1LSpZHWeZGA6?=
 =?us-ascii?Q?yQARsFDswAvgRzsoMHexBiZyhqXzNaVbMcgRAdBYiHBRtfYcJKIpDfTCyu5H?=
 =?us-ascii?Q?RhUKONDjfGTUZTBRv0UxdfYOj18cd7fEOzVHlNfc0XsCWrzkxdIa7lkFU+8a?=
 =?us-ascii?Q?1C6zXFa7cUToXVIiZC6cgdTM3TwdP5szLLmvNPnpcv33gDPbMFYZA/+q5w6d?=
 =?us-ascii?Q?YzoBF+lzfOuYswn2svEDXjvmWhiyzvIoyiuyqkiHN1PjjaZqA3zTnoP2VSun?=
 =?us-ascii?Q?bL95JaTxonDGRfXTp3wK7zsttzkcm8sh0ORcsDgdpX303Ekh1yg5UFUowCGM?=
 =?us-ascii?Q?NE03+ug4j8fPLUiGxN3wWdbmX7yNpYQg1tRIRk4bFIue/rjlInfIAvO0VISl?=
 =?us-ascii?Q?3bt0eVRXQ7XbZ6z1OKr6SG9ZC2Uy2ULQh5DylMXuBFImiDFPfeec599XhYzm?=
 =?us-ascii?Q?sK2TVMAcyzvkTNpbhmCr5EiflKE82cII6NGllXW8aEAzHfUN41B2ZU1ekqk+?=
 =?us-ascii?Q?rGhFp7R1tgitZJ1lf8qsqPowFRb2ZiCRS8AiXVnRDpu8vj9+4q9Nwm6IEtrO?=
 =?us-ascii?Q?m06XlAce5wwUZvap8eh/Se3VR2Zla01MUEoVC4Z/yFI4Sd1mf1fDAFKL6FeE?=
 =?us-ascii?Q?vaEMFHqqFMq8LWc1rP5N4tfe6ebxe+C6jQOa/VuT1LF5Cn05YjW0qy1LRP9t?=
 =?us-ascii?Q?t9b6ITmtcB+BwOt73GTPH41kAc1EUwtgDRo9X5IElInSxvkPLVetaH7NmE8P?=
 =?us-ascii?Q?cpzVIcgCIf/OaHh5mZEovTnvqZ2wpel2WiKgUWsAO2N9zApX9hBJ+bgbSzPJ?=
 =?us-ascii?Q?NtRLwtdb7JAMP8SdgRO7Q+oxS4EG6eNffLtpJq4ezUFy+jzVaTidKgAsIMpV?=
 =?us-ascii?Q?t935LUiH06kOgAnM1TDatkUy3GHtaYf3zkWs/G+ygoMSfA/vG2FOdq/x2byQ?=
 =?us-ascii?Q?qMshNMh5AfN9hqqvm6tgtGAjO1uWKPk=3D?=
X-Exchange-RoutingPolicyChecked:
	Rzapb80Noj0K2mFRYrIOwxQbNe9PrCjNevNvnvuUXLafNCPdfhk+BmRKOV7rsssrNsPNge9w2tpGnLXgr4rjHXjrDxnAyzLW11v3mdCGUDaNDarbOTxvhMcpTT12ODz+cCK+mlLZMiSccx6/1t0dVR0mtI+Xcuo2P46rtnz0ivfmlNfVdl+TwY2y8UJDFBEipVsO4vpGeUCklt3acxKEBIzG26dgM7T/lTsMaOc3bHUsGvTdr+1CZ5nbkHLMXETkTMeyquKc3CSRwVwV5yzwCPKD8XL5pFP1oRpj50HF35lbTapvxjkn1uoZIozX2yJI5LJKw4tojyIg6lJQTqAgFw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gkxTWKi/1REUUTpbuB5ewlthrLcMt3RD6O8guOqzFRAaWuxJrmkMXlQcP5IBfmafgkxAP4241wLeAN7Qu9tJ3DBoS8FxsoY+h/vYyXPVTCkwP/pjxfRIYorxdqbT8E3x1tzx3OSZMfoKXcDkmQGzyzgOQc+SaCHMQHBzOqj09aNu5WkhWtvYi2t1W6J7iwgkX8iMQntaYA7bYDpmHhO2n6194gQ//tpe3/yQTrxRzJXU34pItLBTnoYN4EDb3JSzLHrYJ0+bsz5PVqV0IFTF/xd5kIzeR1G2s1sBYJPmO6uOZs5LTd7aUjO5zTtJtSVQatyuhI9hu3iWs7M4S2f67YwgSAFlTOD7/49EbLaVWTmlpkFr71UTRFLIGAryyfqDmUEuzJDnCgs7NuYRT0c6qhyyj35Dgs2FTar2LaLly3o77tubCm5OyLmD5Wd2nRBkUJlfXhOa2mOHY2diUDSaqji7QxQ4fQCjVNH+0qpiLtshKTP/9pXIjC504AozlI8vPYP8lvQXgIeMVrQ+ImAbBi+8QQOdk+44gXfbUe/sKM4V/YjvoHDiciqQ9RA/lDG7RwIbnQo30YAgNs4DsquTH+wDgoxW8rFriiI+DNy9CL7AnDdVu7QVxi6jSwOyEOZP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b5d5a7-bdcc-4473-a738-08df3f1c8836
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 11:19:48.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcf6CN1wPjCtktLp+YdVdeMlJrCUc5i4FaaVlMkdhY56KjZ8bd6+bibvof41XDrmY+sYA78/mHeiLUe0l/Hh1aSXKH6bTzPIr6iLbgt0Tk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6534

On Oct 30, 2026 / 19:26, Tal Zussman wrote:
> A block device atomic write is a hardware atomic write, submitted as a
> single bio, so when its buffer can't be fully pinned, the direct I/O
> path has to fail the write rather than submit the pinned part.
> Otherwise, it submits what was pinned with REQ_ATOMIC set and leaves
> the rest to the buffered fallback, tearing the write at the pin
> boundary.
> 
> This is a regression test for that issue, fixed by commit 73a0ff6030af
> ("block: fail a short atomic pin in bio_iov_iter_get_pages()").
> 
> Issue a two-page pwritev2() with RWF_ATOMIC to a scsi_debug device with
> atomic_wr=1 from a buffer whose last page is PROT_NONE, so that pinning
> the buffer stops one page short. Check with statx() that the device
> supports an atomic write of that size, then check that the write fails
> with EINVAL and that the range still reads back as the old data.
> 
> Two pages is the smallest write that leaves one page unpinnable, and
> atomic_wr_max_length=256 raises the atomic write unit max to 128K so
> that two pages fit for any page size up to 64K.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Thank you, I applied it.
