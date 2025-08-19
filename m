Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8181285419
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568072; cv=fail; b=GNmMA9hIPbubSbOLKwQhnxGGIC0VgX5det6MoeBE/eyhy2hCMY/CQJFuaUjebCJiSEpdGpcpWcncAUcMxP7Lu7Q+B0qzaIPUvhlZyK8zfzKczwuoEMc0NnZsIrZ1UAlpzXHe1JsV8kT21sd9IMTHS9p+52HejwUE4kKLCqlN5Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568072; c=relaxed/simple;
	bh=LiuQjAIbfzI15TsEx4trzsWhT7CRoWn5N/X8Z+d/1Ro=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=fgWtuCqiPlV0UWVne1cHzpOeW2D/5cZuVuB6zkv3xZKepuICqg/KUFmGEbahuDKZn/auW7eA1ioL9N2BuTg1BTElcXr5sLJbWSsj8Jj4dr4incy164et3y+x4PUB45V/8+7X3qx5CEktYJsuEshtdegj86ibNEcOI6F1WPZJiD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bqKsnJso; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vfW+JVs0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bqKsnJso";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vfW+JVs0"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJgLlF012396;
	Tue, 19 Aug 2025 01:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=X5bCjDApy8KhiXpPVS
	VDhMkrbnFxwB7c2oflUwsNTPE=; b=bqKsnJsohK9cCwJFA1BqerbMvlkOdM2mvc
	Rjquh06D3R77m4bOC6AjPc9zW56ob8a1q+mcNy66NHUxwJbEH6roIm9lant9s8Mx
	GdZWcOVjMGB42dFEBe7Z04QiTGNXToKx7OW6cr+0N4VaP1x8NnBpKpQHFx/D93YV
	NnY/yCQx/CvoH0ynZSGfrVoN1gcVs4DIjyQaHcdopwKWWgi9+6lOcp27NamvOxJ5
	2VW6R0kWTxFYVASEtb7xKMyYLn+veEHepYcC06Z/GMG6jcuRVQt1QDn1y/acLPXL
	96zR9NhEQsHfy/jbcIcIntJDEiYOyBqEWwk5uTEmuByckHfw4g9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgs5ma3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 01:47:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57J1GXh7030890;
	Tue, 19 Aug 2025 01:47:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9h94u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 01:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/SN/ewY5jFP1BCPTF9/6itq8krCaZsAgxDuo5wuDe3HCstyjsyRdxereyUWvSlZF1/u3B+QZn99B+scuPEIo6hX3h5I8CtYn/1IQXVTskdvCSsgKTrFxnLqlTorH+z/mtrXdmOvkU4oCkVIc2FCYWTgF6Rh7z8nbDnuI0u100yfyx7qhrG6G0JtBOjVn+ztte1gQlN/6WFNTqyTwKY4JdqvxUaV5eMJZhHVukXOynjP9my+ZrsuQ71SDnILiltOImG/AFixkL3QRRsz1sy27xyu8SY+ctn1GkMhiizsJ0Qc+LVRnY81hgOQ3MTcsEjMMrMkwtDwPZbxTpiXY1j+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5bCjDApy8KhiXpPVSVDhMkrbnFxwB7c2oflUwsNTPE=;
 b=SZaIl5RuXvar+qNrBCl61jJl0tfK88iwYyAQtuSZakchR24/HKyIMMdgx0ZjbeXQnD2SVUgxSN8+LS9k88O76/CIEUswL19zMQPrMptwcSxwPlFbw8XoFkLdmIWxMNDqUzFhPiWxcXA7uuVTpg4oRQA5FVz4vde6y2/S6wrx/cNazNNgqom90/KaAFlaYc6KeMtjOORXfadMpi2AhFUPAobXpvnrI8XiDAZwrv77TCj2/uRvGsu6zZjv+PW74p7IgP/dmwCCUjbOHvvJ3tUAEjUaApX7Q2EI6ECDqDKc4D1w7DnwCVZOf9HXmAzvSsw1A4F5WaxUG64AHjTz1Wt0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5bCjDApy8KhiXpPVSVDhMkrbnFxwB7c2oflUwsNTPE=;
 b=vfW+JVs0PWBf4zXkGSQmwuPZDOt8o/Xeu1zM2prlaqfIJEzBJWGN7Y6OwV1ap/kIB5qVz13Ut1ysstuxMDFspOs0u3rh3Phviu4gWykjW2Sut7xJ4DRnpaLHyedlCHPCf7SNbF+pVZNNAp1ai0gWi5/jh49+ofFdopSt4OaCyRU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN2PR10MB4335.namprd10.prod.outlook.com (2603:10b6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 01:47:38 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 01:47:37 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 0/5] Remove several superfluous sector casts
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250815165453.540741-1-bvanassche@acm.org> (Bart Van Assche's
	message of "Fri, 15 Aug 2025 09:54:38 -0700")
Organization: Oracle Corporation
Message-ID: <yq1bjocytej.fsf@ca-mkp.ca.oracle.com>
References: <20250815165453.540741-1-bvanassche@acm.org>
Date: Mon, 18 Aug 2025 21:47:35 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0096.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::25) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN2PR10MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e18b2f-3c77-439a-8c6f-08dddec26019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNPn7ArhC/7lkO8blRa/Z9YEr3MmrWm831rtXTOkOsGDWPaMJwVPYHFFPVh8?=
 =?us-ascii?Q?E+R45kc/E/fDqCdjqDi3dh3f8iIj5g/RRd+inrSJViIi/nAuC6gcQmvAuBH/?=
 =?us-ascii?Q?JiB1lrGbeJe+cb+R+wZB9RVS/ieFcEfBDDikBOVCBifb6qNHi7HH0ntUGjMc?=
 =?us-ascii?Q?pdgrwuThuSiMlCHeQ8PFHXsdVBMZcHVdUgzv4L7XU25ZRSOdbHfijJ+eUrsF?=
 =?us-ascii?Q?qrszJbNnQFMMiFi1/u6/+DdrEWtpaAmEylzLqPoASFPSp0dHVrg0EfxyAOe1?=
 =?us-ascii?Q?yCC/kcK/4DUWv2XlgwiVD5r9amo8n7Zc2hO7qZCMMHfxBBXuBxCstrUtpzoi?=
 =?us-ascii?Q?CBS/ocxKBeo9DYDiMbDd9aaQd/GqkpgZXHP9/JH3oPApegyfPRYqbcwqbbDj?=
 =?us-ascii?Q?EPeDKGhBh55mBKM5rOE4IWajaHGemgJzdwNtOAH/iorb5ZRXwL/JUCEW7qh0?=
 =?us-ascii?Q?bRU0Myk4y3pU6wkvSRnzv2seZYg/pVZUvTzc9JPi+yXX5QQHFLMERDulScge?=
 =?us-ascii?Q?WcAdoGTpr+6Kgq7T8QBZvmOoLhgJfpx8mlsjytPIaUsHRedyz69xt8peZC9z?=
 =?us-ascii?Q?/Udr2f4DfcfrY4k6bvBHYcjmlC8TNuXqOCO4b80YrMnAL+tQzpvfCaesasur?=
 =?us-ascii?Q?eUogSKlAWYFsDpaQsZ/EI71A5WbpzKk4y3CM6qfm5eXoefhsogzBBptnSJV9?=
 =?us-ascii?Q?i9+RtLT6BH0FlCiOB2ldtnGGFvRmx5HfucOMTAz9iYjv4EiAJc0ItzGpL9Ep?=
 =?us-ascii?Q?ZC91m1F+IEG3LB/FHBF5GVapPTdeES9tvrE54rHA6DYn5uXq1zCyo6CYzfTo?=
 =?us-ascii?Q?AoQ3CnmpSGS/OO01jRbiu8lHRe5lEr+UPGwwXTRhNIA48bz4V3p7CraT3sZf?=
 =?us-ascii?Q?vFi0tQ6jRsWu7KwtxfpC1aWt4N54Lmlip5RAefdcfI3b4JcUxGklwrdfDy4k?=
 =?us-ascii?Q?IkgDRGOrPTiZlIIQuus1ljLhmL8Ag+AG5rYhCUZMt71nT7IxxAvVC8iZELiv?=
 =?us-ascii?Q?nRGTIF3CxL2VmhSR2XSPtaRNTjFjZG7CvH4GpEH4GSdeQlZ8F2m9icCKh+Lr?=
 =?us-ascii?Q?595v1tBF5fiXgqBGoGtApUsIsgQ3A3pBCPxqd8etroUp5obdV/7eDi40Sod1?=
 =?us-ascii?Q?clmyddAOQg43FcuRVclDqLLvnrV/++R4ChvosPPG5wN1lcn2WjBB+lrrem1e?=
 =?us-ascii?Q?UV4CcDSqdXV2SAjZ+snfhhGT0M8kDTFwfboKcyKTXuUedP3WzV21+T3SPfAR?=
 =?us-ascii?Q?t1P42x/+QXIOZvHoIeGj7B4X2yhDalB/zsV+AuUSN/Kx2iNs8itzg9rUVkjP?=
 =?us-ascii?Q?UkmNi23Nz2cBOoK7ujluQKy/OskGDvDfVfYBLwMicBESOu5Mkihe0NSygFRA?=
 =?us-ascii?Q?sqTqqWgfxlTyBkQgAAvfZqhWJmagdu2hkPXZK8hJp/eur7s/fE7K9N3duxXu?=
 =?us-ascii?Q?CW+PrVqtAnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Glfd4FoEJIa2cHK+QRoAQFZ1NUBMEVlUK06QvBOcda18mOuxUx+FCuufxQv?=
 =?us-ascii?Q?DDuLU9KuSUOAAJnmfKoOQC9iUodUbllhKs+i8M7u/wRn50gBmLd4KnbmJv38?=
 =?us-ascii?Q?g10GrKHLayinugg85KpdpFmfu1kWFJqDeq6kFmz2p1Sa09Xzte+eTMIR+4ZH?=
 =?us-ascii?Q?596bHIjTqPGs+q5GIKxxuOpvyrLQU5gJdXM9hQyxO5+3FrSZw9sS6VFdGdUd?=
 =?us-ascii?Q?XCCs2b4J1Nf7t0xaGwCxLt5d3QVeZxpcG0UtZTp5grmrjAILxuHpGiGZSsVy?=
 =?us-ascii?Q?iolFLqdSKASXX2AhzJJnLWuK3k4YgTM2hLlFEHJDHSRYUATNCdMGTv6eob+y?=
 =?us-ascii?Q?3tYkBGHj6232vZsGMmnnbs2yb0/5CP1NJEOHW/s6wJZEiIRh1Y0jq228wth7?=
 =?us-ascii?Q?fK9VfO55Q4ikL1QqUci1HiIYZwLHzJ8rWbIwxP3ZLyrmlOon0kyTNWnIwb76?=
 =?us-ascii?Q?IHJYeyPog+w0P/49ZmUGf2kmfDqelETF1uRwOt2czneZWhL1aBaaJazXVK/n?=
 =?us-ascii?Q?GUNxlIJ4TrQnTnsuFYrkiaPShJU00IxZX2UgqOkj6prkEdU7KpIL91bdoDKC?=
 =?us-ascii?Q?77ID9I4Y0hr2FKkzDosF6jK6w2MFwUnBQ7xGe+qTmGflb9FURRcjLbYe3NQo?=
 =?us-ascii?Q?CvY7Q6NaljUHpk0kwdCwjnTz9gjgedfsBdfwyWiXOWcM74MW6qWro2ph9zB3?=
 =?us-ascii?Q?UlvMf+k82e9U4dZT54EOwzO0QpmsbhIGl+P57JTjzGmS/FiQwbYuczwmcqZH?=
 =?us-ascii?Q?s+IAnzliQX0VdhEdBkb9DZWRNiB1xZFMYfeA2ZxvwoZWi6I+MmmXXn20X5sl?=
 =?us-ascii?Q?ur3b0H7HiiaYxywJrsgLgJIiaUhEngmP8hCPuqepvl45lwzbHI7jqjWMYVeU?=
 =?us-ascii?Q?e61NmzGEhWFv0ZmYILVBSMc7A67RpEChWxLCXAQUEX9v96dgHnVsJB8TNeqQ?=
 =?us-ascii?Q?5goqh0bR7lTLktD/83c+p5rmr7QiXgNNe9olf2DbOJcV6xgmeCkCulUla4xv?=
 =?us-ascii?Q?3pfXTyEySzXn7niXLPOQfyl7jCJi1piTWqVqTvYqnhA6bG/niqIV63GaCD2L?=
 =?us-ascii?Q?p0n6sq1cduwAY9hK2PqpTEC9p6H1R3QeyC5btsRafGHAa76bj4m+6tzgg1eW?=
 =?us-ascii?Q?8UJecngp6r3diMmmMB3lxprgEs8SA2Ow9My94fBX+Zt4uuk1fOiwNq959yCC?=
 =?us-ascii?Q?YL/U8zSHvZWxCjJ9R0IRxDAmTA5wv95jSr7iOF3q3M3VuDvIhQ4eYGH4btmC?=
 =?us-ascii?Q?a467M3kBNMzvosbD27ognL/r0p9OuACNrUWapmsWsDMbd9PRZ7LXpfgODm6y?=
 =?us-ascii?Q?20A2ZdwLCjOBpEA/WGRMAmaEn9O+BdN/dfvuqnHWE0xYBB3FeJ8ykH8cs1Gd?=
 =?us-ascii?Q?QRlnKyOi+PoYOgl1S0LicJqaa465+k77ZWGkVmuZXOHIUFPRvbWKl/TbejoP?=
 =?us-ascii?Q?pjbzeManGYnQ9urwH8SNtbk4AEoL2tR3AE0J228dp3BFeJvVtjPnNaJ2CfkC?=
 =?us-ascii?Q?cXLB+NXP80SRHPRsYhTxdE1XNOodA0DOUUjTnW/u6UzW2xiOTsl5/n4SZPCk?=
 =?us-ascii?Q?QKJJXmtXdD2/ldXQ/Nni7nd25DoaC4sFXLqn1v2YLGNAC2xADGTXyWnWKIA0?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k/276z2h9ySBQJoKurceOQ6slBYi02dok4Q7jFStOd7XDg9oev0h0zNcx2iti7Tm1aUWnxGPIlvJdrdRxhB/YDlb9KMGPNULnbgs/rC4MF8sW2ShukyFnt4DWXa84X0BRXfRvKhU5rsozUwPEIVzWGZjOyyBo0OC4ePAw5t04SO16bUZQ/jo6+V0fI7sLZ/QvOZMdxKF+uGRybKafmdHXrga/8qCQVTXWgp54d9Afc3jEGlROcHrziBR2q4D6X6geQkMPeVs7ybLHSiPY7axVsPAXJ/rjFLPIU9GUoe3c+0IE3B07baLw3VtE8n846P4c1MUwYVJA3ijEE7PqFYrLA5ursxxdMZdx+LmQZDtQUG6075eTn/tlgUkEapD6B3oNXTD6wBrx1I2+6KaFduTEJU4byjgBuPRb2adYVS3hKz64BAIb0akjBvK0Pp61YcEJszAep1q+PC4IrYwn4/vDgzaDIlNaqqaw5mAdcI537wqbjQBLHZQDMi5Ex4NQ8aYGIVJPXnIna/2kS1rUHndxTAxtStYXDoNnJIWU8lyAT35xI+v7/G8TcouD/6w8+I57ZR+98I/VS0hQcJ1r4PtNx+Y/jn4bTPXp0WKNRy2+RQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e18b2f-3c77-439a-8c6f-08dddec26019
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 01:47:37.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+D77o5IcsxWBeyAXfzDkuGbskYmjZD8nPCCNRRBEBxiCMdLnYM8aKs4vB0bHKdCd6c3sm75p6Lc9z2muPsqpNXdFQQ3AXXFVJdll0PG0U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508190014
X-Authority-Analysis: v=2.4 cv=DLiP4zNb c=1 sm=1 tr=0 ts=68a3d7bd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=eLN8Ij8YOGcNs9XCGi4A:9 a=MTAcVbZMd_8A:10
 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDAxNSBTYWx0ZWRfX7HML893DIKIx
 Vpl5xikNYwLC79WtxjhlobJN23UsH2av/IpdGU1hPGfO/9odBNxA/uCvRCLbYY88EU+ekkbfBiZ
 sbmJ+iHZCwnaXIz22mkWUnNipXWc2CTjKu98+GNkzdzosNz/nz9dGPp9p7SKrOKOP+hnx8Tjb46
 vJJiqdAWs/tV6toj2u3zYvnw7S7o9UvKC+kCmv2KD3FO9sw7DhOInnuvR9rQiKYWNGvx/Rx9Efh
 dK+bnSTgIMCiKZQgoRoZDpXrhtC5aBMNEFBfmzoOUZwnrCsKAMwrjKOqyEBU2g2Pj71LCJPOxLM
 tMyy880R/3ZysOP2syYUg6NXBSun4xmNgsmC9XazVgXWMHnBAkmTu9szEM6cov/1y5U289LT2XV
 0JR7H/IuNfjAi1W45N6G0i/WcQAKBMqt7wZpNcB01IPPcPPnGUYvCYIsPtp9ZIqWCWjWe28m
X-Proofpoint-ORIG-GUID: Rv9BI0NxGd3p0UmjN9WeuEDNWeOzQB9s
X-Proofpoint-GUID: Rv9BI0NxGd3p0UmjN9WeuEDNWeOzQB9s


Bart,

> This patch series fixes one bcache bug and removes superfluous casts
> of sector numbers / offsets. Please consider this patch series for
> inclusion in the upstream kernel.

Looks OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
