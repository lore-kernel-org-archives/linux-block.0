Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4415687D
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569593; cv=fail; b=A6M3U1xHHrOS0gfC7u6EIqDajlbPpR3obA5ad+BB6qfERIedFv9lzIy19VMSlsy9+10SCt2tWAezFVw3Gg1UGh1HtrMfVq0iqmcFxhFdEQ+ji37SClE09MgibB2abzT8OsiaPY2l3r9lXNy4ph0uOIvYhjMNFCnXRswPLW97wnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569593; c=relaxed/simple;
	bh=Z+k0rhRvxAxzkUaXn9TAN4Lvw1gkyRtVi1dsmKBydRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZ1qHqdgCve8pFOl2R9iJwNZvlj6vs7GeK4G0bz+d1d8EzL66+92PsQfCMyxa6L2HNtk2kwFTTs8FERP91MH9gEGpCv9Db2j5FHXiV8er/JkgOvdVtSAQt4HsyAf4SNsp1ZfUP4K+Og+sgWYW8Zayc5mvKmsJpGqhsvHq5Mq62Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RhutfDjg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=abNd0UiO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RhutfDjg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="abNd0UiO"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8MW2g018971;
	Fri, 28 Jun 2024 10:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Z+k0rhRvxAxzkUaXn9TAN4Lvw1gkyRtVi1dsmKBydRU=; b=
	RhutfDjgNyMtN2D/0zpNP+c6sS586TStBTTGNkF9Lswc3ZNpzQtF839Zj1k0VO8c
	Zd0pJmE9Flokzx+r76oxauOVw3GrXD2+tZo9llsTF5YELKpUuTnNhtDDxGjbnP+U
	Q8OcJfpznnE1tC7F4evHzT5ts2i07MaGWXaJKLR65Pevt02waGdAB9eHMrK9Wdc9
	5MvzWamgHzeNQ5kROJUkn1hnU57dPuU9zu7D511SDKU0ICOZYWs4mkOKp/nhCBAy
	fg67yCOAoTOttoX5kQbcXc6FAHGt0E10zJnoaZ3IXNW/1bWQ5oZ3Szbkvb8rRNer
	/p8pfg0NDsEh49On/lBlAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70fw9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 10:13:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45S9OIlX010788;
	Fri, 28 Jun 2024 10:13:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2j3r20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 10:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrgm6e1UX28UmVSYTCqVtf0Gz10rpVER5GaT7Au8/G19LMfk4bjUZMHAEGVkkmwBJPALMhfz9Cm1MhULR42G3w0Cq7nSGy+MmHvEQBZavtWpYObP4rjiwgTHPexOIJBT+azUtXE7pjeV2jeG8f9xygtOVxsjoN4lmXoRO3Jw5mCofuwWq3urOqSxladVIhTxIFkCbTpPu+ahJw0CxFP7vdvf/029aJlXbGHbYz9jEEJFy2G2fb45/NW7tXQSByL4jRyoiV8fNghLtFOpg2h5C4CbCNiPPCFrBqNUl3fv4msTe7tsIedrcggBbjAb2NX099SYka6xW+1pkHv/aLGl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+k0rhRvxAxzkUaXn9TAN4Lvw1gkyRtVi1dsmKBydRU=;
 b=Qguc6viBv7pBuku+aWr0QGalrmUJMz+m3lRJS7m+uKb3ZZRVKSMfCcEWouXSHdj+A/pWZIZDLGO1JZwfLv0C52s+jYaidxQf1ZO/FzlwsVbBPZMjB/Jnuk49OsEboJDimaVElvD1MZF0WphJewDCu9E7sEL/chn5ZpbzXJLncxDOlFYcN41JStPtR0ttfUM7HG4/VHG9WyNfcfVWC6KCzaWPQ77QsFDYcornHR797u7t52GiDpIe3M8rG34blP9BrxS1+hmGC/TLVKdda4ogqGvFB+fovjLuLD7OOudnEpA6Qogc3dOW+K82B1k1HoU2UgGPj7mNPEMSTA6eOutDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+k0rhRvxAxzkUaXn9TAN4Lvw1gkyRtVi1dsmKBydRU=;
 b=abNd0UiO3QA0Vzkd60UeMcVONlMHD08lPs/s8xRRAwixheN83k/eL/L4r7AvtT2jfxxBLmnCNCUM42ZSEzIyQF4kOdaJDdSuSN4rWOTrDvtWlnf16igUUhtheiX10hyOLM3/JHXXplHamhYh48N23PZMMe5UtOlr/SxBOcPDYCE=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by BL3PR10MB6161.namprd10.prod.outlook.com (2603:10b6:208:3bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 10:13:02 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 10:13:02 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Chaitanya Kulkarni <kch@nvidia.com>
Subject: RE: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Index: AQHaxvGqU8FGkoz8g0SYpqchRgg6QLHc+SkAgAAAN6A=
Date: Fri, 28 Jun 2024 10:13:02 +0000
Message-ID: 
 <IA1PR10MB7240323F87DC53B56A930B5A98D02@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
 <svy6jcrepk5rdsao7y3ocie4tfyfgkpm6vq75er2youfmsrb3e@ta7q4ocua2vd>
In-Reply-To: <svy6jcrepk5rdsao7y3ocie4tfyfgkpm6vq75er2youfmsrb3e@ta7q4ocua2vd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|BL3PR10MB6161:EE_
x-ms-office365-filtering-correlation-id: 0c861258-79c3-4b5c-8905-08dc975ae4cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?nPCdagntu+xgsDSoUus+I5LZR2rpduanmIByuuoaKxwfN9DDP82LTzVBiFjA?=
 =?us-ascii?Q?gXidcUe0Cg1LE3dkePjk2FpcpJq1iLomOfIKVG2Po8VPJjiUyIJWno2VnzIy?=
 =?us-ascii?Q?qgeFEnRZ2laSeG1tHIANsxow5XuR3u1CfLGUZEuQQYhIMVqHzteerfU1U36F?=
 =?us-ascii?Q?heSKhDvnDeC7MvZ7Ot3ThGiDtV8cQCUd2nj4GpvoDuC7qdMb2hj2wkXRWElN?=
 =?us-ascii?Q?p9Eo66FvofTIeX+gOkjlxx968JpEuOuG9QF7bIk8s4bGpq8FYfAkD/cBWxwz?=
 =?us-ascii?Q?XJLbsqhUjHN2j5M5dx66zfrzGXP0s2PTdyX+ENen3RS0Z2l04nr7Aw4C0Mx7?=
 =?us-ascii?Q?Uifakvbaff0WxlPcqQz9EOP/c5KMdwq6Bb+QXmGnZVp/L8eIBSb7wNAVdY9r?=
 =?us-ascii?Q?UCSo/tWP7bswqzAyMm4KM6NTv/iBhYXYzfLnGf1pVEjNoYEcCTIY4FLxAFRw?=
 =?us-ascii?Q?DijNQ5WAoJmikdqOk1cwzrp+0KpslIUXH6kA81FsuaMXh4BHChqdpDt9Bbnh?=
 =?us-ascii?Q?ZvlD7kEMDsy+veBv1gMymQV811/cK3tc/APdGoexl+IgESZny+G9h5GVpLIP?=
 =?us-ascii?Q?JGnxnFeamLk0ju/WVkqWDbb34l/LO81REp7sfFrERPNO0SJSa301zdaUPrgT?=
 =?us-ascii?Q?2phdKZLHLzyli7E1h22pgQEm5xcmBNed3QmUxIvbItTjUa/GvrttyJKXWYFe?=
 =?us-ascii?Q?hNNH7+9sFyMcwf3R4NFlcGn2H8girKCYDebTzWu7s9ri79CBK8PIuyMf99mH?=
 =?us-ascii?Q?jbQmAgvK2T6q+m35M+lWhaiNEuOrVr/bkMEdqzv/qhW3KuJduWXlRmUanwg8?=
 =?us-ascii?Q?Vlh1qXQNqF5VEVu/LUoohkNOnqga/LFV3R2zmpW32hirKzXzBirJEG1+8pJ6?=
 =?us-ascii?Q?wl4frbB5rWb1wN4w1+lCk+eMDmrwG6VRBsrExVbDhwE6kHNk2RUT8r0r5jRn?=
 =?us-ascii?Q?dMIYf9i49Ax+kgWjNi2K/P/K46OXtYz5eN/+jRFMo0z7CXDObmQqPaWt+qJm?=
 =?us-ascii?Q?cvu3YrgOMlOANJaETCEbkcWXA6Vcv2nky8A2U+8ZR3dtnIFuXWi/XvuKBhqD?=
 =?us-ascii?Q?6b7bKk8D1/vNo0KJWcMY0eMWNOeK/DtewrHnQ/8sFw6aMK1GOHZvkhkLMr3E?=
 =?us-ascii?Q?qByqtBp7qvYh2Izcqa5M+pBFCu0SEOvOPxN58hn+lMsn0oG1uk9BWdnB3/v0?=
 =?us-ascii?Q?32kgmDvpmtj1k2+HNZ7k/Yph3SZGyqgy6vO/FwVaG4JsgUG/VYulNdpAfAmU?=
 =?us-ascii?Q?n02RjT+3etMgoJBK4DP6IFyUD1szHedJJxu+lnFpskQbyfNucovXJJPyXeCx?=
 =?us-ascii?Q?hn73bKPZU8bN4ZsX5VV0ZPESMv1OpepN9anSxIWP5FadvvVNtktJ5Wac8abj?=
 =?us-ascii?Q?uyryB3IbjGy1l3SbttwOj9TPZou1ZXyYc5sq27sgPZjT4EoifA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?rTa6LX07pORSoy6ZBSi4mBDjgkgUzsD8tRAzulgdmTYJPDmpKX4KT8vv5Gnt?=
 =?us-ascii?Q?qeAYoL9/ChIziNYZRoP6vM1j8ZjZ/22rDCfGpqWRb6V72lTVGosF5mSLmzMP?=
 =?us-ascii?Q?CKe6QIcDuE5KTtD/QELlqlBwwK1PHMSkF9/6jgaCMm8ciDAYTVlumQLMG2Y2?=
 =?us-ascii?Q?wXDquvjtMIcq+1Ro/SJccbYMrrm0tkDAGT16irh1IUufX+yJG2gdiDYf2pDY?=
 =?us-ascii?Q?RyG9SQW4G3Ah4XrqP2uBfZXnJrRvsVxZ3vznIe4n8RfiWy8+2RyJFSpmUMSB?=
 =?us-ascii?Q?oOeDWt7i59bcaCLh0/lU3NK5A4mc1Gn4ckWnPun7Em3yI01eK8jh2qngDIC1?=
 =?us-ascii?Q?8HjmcIpCEY/qUrIGk5qjvfXn2418aeJq5trxWlQp+Qm8rRzCCUSdfgdgiMv/?=
 =?us-ascii?Q?IPNt9YpLeu6Fue2sLtXAtee/uClBgUjZGrwShq/RVYzEaC+WIDPVW9zrNigs?=
 =?us-ascii?Q?w+uXBErufSv2dVmyu9TzFOnUawLoFZivmfaeQW6Z23DmFsamIvTZI6IfRJDV?=
 =?us-ascii?Q?/8/ZaIeL+CT8c6AIWrQQs36Bj6hNzGkZHIJ3MP4STDmRHoEapNV9ddXqViBE?=
 =?us-ascii?Q?QyHMnX11AWI5FSr1ts/4lYScYJdKaLWhfTX2WlQ/cRG6KxyJH3PzJ5NSQv/L?=
 =?us-ascii?Q?BeLQf471yORVgdFYi36EPfRVpgNo5OPguzNNCDEqV9s36hZw41l1IYOKEvzp?=
 =?us-ascii?Q?rpoHWrPCXyckdhi+D/TBzdns65LZtFAg5r79cPPHHn2LQoAN/OhpzC2vfiuv?=
 =?us-ascii?Q?pzOTTQgU0Ux1wwNxh1ouAXnclF7WGWw2jqC9nYXkAE3e8511i0pufeylJGSK?=
 =?us-ascii?Q?gMfJIFHOBDRELczKprHFzR+W2uTRlLeXo7uObysX064fEZyK9d4t26+O8GMX?=
 =?us-ascii?Q?6IB8YnZy064qwgwJXKqDtUcto3ZP6SEwUg1DNKOK2tpn99MIyKVEfNHhMOt/?=
 =?us-ascii?Q?j3jAvtTlKMfWoLEb3CAqb7LXdEH24cw5swV/WuE7KHuwJagMCXxa4NWR7YXn?=
 =?us-ascii?Q?ht/M0dqQ8/dZkCt2GDFRtVr6oJWU9LNezfK5K4hgHSKWNe/3uhlfxhqvs86/?=
 =?us-ascii?Q?kulabCLYxilxyDIRe9ZSQw+AS6lff31pdEJ50kciT2cBOCpR1ZG1uhxDoUwO?=
 =?us-ascii?Q?lSE+LOyTAwSo3CXb4RYYpRIwMWD32PVOooz9CQd55YDuIIdPlvG8ICHkPBjr?=
 =?us-ascii?Q?q+4DpQza048B9Je6qWHHdSU/dq3NcTuBQVjVX4GkDfl5AeGANz2ZmSHsmzNE?=
 =?us-ascii?Q?wJw5dWLwjFf9exGtdrWujTZX4NfCp5xShfMpzDt+J+1xneT1HrEC4s+vsshp?=
 =?us-ascii?Q?dLS3H6sj1oPQay68IgqJ3xZuSHPwrpKcevmDS14M04sWhs/6EtNkwS88pw1r?=
 =?us-ascii?Q?V5KZvgYFxn5d7KkkQSt/VgqKzwfgVrdZNVaINS4NfTKjNnWokr/t43+v/XgR?=
 =?us-ascii?Q?FYEK5tqmNJqB5PEb90MLmrs/fqM/BWKDWZU+w86GgXocfGjFVos5grfklOO2?=
 =?us-ascii?Q?bq+BztOJclQDlD3iI2ssBt48rUCj0NT7wwjzD011qCK8cjxcPx2x6IA7lKbM?=
 =?us-ascii?Q?zKA6sUrbqUZnU6Tg1gKsvOKD8ZALLeItvRT9EKBw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aT68M9JxPZ7gDkNx3zxvqmDVEvC7nYsw6TYey24C0WARWlfdmYPG9aOPZq1OwnrHZuKGvYRgMwgfSIUuAWfZ8gOpLM/PxUWzCZl7z4VpJtUt29y1toUufflcJen1kTb8os/Ip64WYXEEX41J+rH09ZohylcrqwaFjdldpor1Cd222M+xSlxdtS7Yw/8OAsBw21XtBNBCYshB0h8T77l3GN2f0RTJSm0QEDBBps0Gx05LjPdoDnxXFdyHOUtyWUFPzQCHGMlyO4/lm2sURB6Gne4UbISw9iDwYwz2eTq3Re/fgFAXBbX3oEwXgOcJo7xBj+O2jdEeyuMBehErQvNprx4NJza/K82BSMhfE/GAA+FlHQxv+g6iXJCAEf7BAm0by89NdAVEGgaG60RFDGHYViuNxXnN9GDbJngR7cIKNOqld+VeC8Hv8QFugPElj4z4zxdbw5NVxnXAOsMfghtO3tjlnT+y4XoTQLj71UpL/lwjTTXdPD3ha6zRK3lSb5dWYR1GA6vdhomvPb8o2Ye6qeJwkkHThYjzqS3xnm+Ss4k3ah9jAVEWyb2d/nh76qH/94kypRDclw0Uk4qF1D/JSytg95A3BneDTrHAkJoieXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c861258-79c3-4b5c-8905-08dc975ae4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 10:13:02.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxaBQGxmhW/22C4urCc5DjkyvEqsp9JbB5bz3gyeoYuAx6RYQ73MEPShQwt323wiKcbWZYIcr+RWgLz/wvpx1B+LawI3UH+QsCLEMA7k8RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406280075
X-Proofpoint-ORIG-GUID: Mu5nnyMEHun1R0pJUq9Jk4WKEeRCJR2A
X-Proofpoint-GUID: Mu5nnyMEHun1R0pJUq9Jk4WKEeRCJR2A

Hi Shinichiro,

Thank you very much for working on improving the test case.

Regards,
Gulam Mohamed.

> -----Original Message-----
> From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Sent: Friday, June 28, 2024 3:41 PM
> To: linux-block@vger.kernel.org
> Cc: Gulam Mohamed <gulam.mohamed@oracle.com>; Chaitanya Kulkarni
> <kch@nvidia.com>
> Subject: Re: [PATCH blktests v2] loop/010: do not assume /dev/loop0
>=20
> On Jun 25, 2024 / 20:20, Shin'ichiro Kawasaki wrote:
> > The current implementation of the test case loop/010 assumes that the
> > prepared loop device is /dev/loop0, which is not always true. When
> > other loop devices are set up before the test case run, the assumption
> > is wrong and the test case fails.
> >
> > To avoid the failure, use the prepared loop device name stored in
> > $loop_device instead of /dev/loop0. Adjust the grep string to meet the
> > device name. Also use "losetup --detach" instead of "losetup
> > --detach-all" to not detach the loop devices which existed before the
> > test case runs.
> >
> > Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop
> > detach and open")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> FYI, this fix has got applied.
