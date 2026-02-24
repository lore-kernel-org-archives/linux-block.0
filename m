Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5CC217662
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967937; cv=fail; b=s29DwnlDpCZUN2L6r539DjKhxprPNOgAKbQuVi/5amnoXQPzs5hlBAfT4xnBBG/8MtLhB38btwCbK1FTnYw8fNoZxWZnF7WjJcZq89qBDxCh8FMngOJfut8ZKkYWxeaSPKOH1PnLjxnRatDJBPYEng1luEP6oJwdGe3gKbYF8Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967937; c=relaxed/simple;
	bh=UGvWaPV4N4VDtkESHkVvc1B7IrM7UEneD2yiTvC3k8I=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=RZUr25BpB29J5nSVqc8eN4o3JL/xsSetd+AFkPCWHxR0VHY2wizvRE8VmcQsoWG1647GgvYtoFNfQYEa9qjwx74Mn1si9hre8J0spZJo9L2pYJcO5Fqph4s6RcrUTNf9wjgFx+tJPCWV4T4yXaARKjWaQ5V/IQ6NWnnu9XMsYSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kkO0k/B6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OKlWb1eU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kkO0k/B6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OKlWb1eU"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIuB1M553428;
	Tue, 24 Feb 2026 21:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=m2ORinrPQPF+SBfTNY
	fF7OuEYpVD7yw7dpRFjoMA4gU=; b=kkO0k/B6uKSA7/hCIOemdg1pDR3W+AV6aH
	Zb/5x9u+Hi+5xTiAxKWaeuLdGnMpKe6oI/bEOZp7bVMs0Hf4SZhqjFid73CvfZFp
	asS6OU+4RIz6WgedoyruUtzRyfaht8bgtu76ipdMwT2sniRqh3zSi0jMq+4EYtqM
	QgPBMfLeQKGlKjVC81fZ4w0p/ZBK7srJVuGYUgsDWUrHwsSAv/bN4a1NhPODheAi
	DDUEMJ7D0c+YOLYULCkG7/oRKV0WSLw354RuVlptH34zl9TubMiylBAClVYJi9UI
	6q2nD0bumfrd02wipy3E6s7JwZTw1oMenLnWBtZVXrIWMaNAUqNQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3g3n57v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 21:18:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OKn5qg028092;
	Tue, 24 Feb 2026 21:18:48 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35f8gcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 21:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqjkxGdw929/GmMWw+hgx7HP7PmnLUEWILDoTqr2wuSgz0OcI/J+40BtBqzaIwy7cdeLHdkt+3+ulPPBbz6+gE3Zp8RN0gYYkwe5wGRFFPPg0zd24OtJmdB9dw8zptMIpKsaD0/96iqUIgvp4Iz0Didrf1rC5IkZHbvf5XXIJ6PxC6kNLoZjDg/aNW8TG/0iAznuDfDxvzEnDjRw5HXdKyNBY5rRx7WwW41xMjtM8XYSYYTufHAkzzTTVzblTmapef+kPC9wKx/rwziZ42MXWirNyMxMRv95hBI70OmM3n5Yd7kD3LBiKiqK9UvrLJprt4h6vXJNg0kB2Qtlt11nbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2ORinrPQPF+SBfTNYfF7OuEYpVD7yw7dpRFjoMA4gU=;
 b=QUSNZmGCLtfcHMpGtte4NxfUc4afAGa65jTxe6wMeoUkJ7/hN7zRai5IiJdTHHNEQ07uHUTLda2vS9AGsoxSkhBA1zI/yADhVfciKvoDITMBl4Oaf/qzQepZlqRSwlmv+osxGuUDSwOGlhUqY6zUVyzA9q39Ee2GQdQ4x2o+hHHWKTRPBnhVfZaraIIcaChZSIEAn5UWOpsqkj5xTuJgIFxCz/T4hVshC365i6uObYjTm5CB0JzGklIClvVQAwdHZt3bJWs4oQfjmBUTMGXxoixezdnTXDwV4DSSor7cg5ozJB+i8sn1PDWY02IRREb3gk3mdu1aUnZ14bxQD8Hz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2ORinrPQPF+SBfTNYfF7OuEYpVD7yw7dpRFjoMA4gU=;
 b=OKlWb1eUGH7q+1vfMprZTu5HZbV6pEVakjDF+jUeyfF/ppSc49JwSjhgTERNfQ3EorZtrPFO9H2e01aSOqL1A1UUiQ784eyIzxrc2rwasE669CK15XyYw9XsmgoX8igdrnGpcdD8eb2881jJKjlu3NEaQsVl1frX8S4y51IsQso=
Received: from DS7PR10MB5344.namprd10.prod.outlook.com (2603:10b6:5:3ab::6) by
 DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 21:18:11 +0000
Received: from DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::21c0:ebf5:641:3dee]) by DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::21c0:ebf5:641:3dee%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 21:18:11 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: zloop fixes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260224142153.368472-1-hch@lst.de> (Christoph Hellwig's message
	of "Tue, 24 Feb 2026 06:21:43 -0800")
Organization: Oracle Corporation
Message-ID: <yq1ms0x7se3.fsf@ca-mkp.ca.oracle.com>
References: <20260224142153.368472-1-hch@lst.de>
Date: Tue, 24 Feb 2026 16:18:08 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::21) To DS7PR10MB5344.namprd10.prod.outlook.com
 (2603:10b6:5:3ab::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5344:EE_|DM6PR10MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a13e66-a61c-4f35-bc43-08de73ea3699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LBrhBIA2SeiQnEz7UiUzBt04ISQAGzPiT73Lm591u3R1XPP7/9nGloIefjqv?=
 =?us-ascii?Q?NeSlr+rxvUfQIv33Ooq39ho7anKMIJ3iTcR+X3nxrny8ZzTJyarpmvwa05qa?=
 =?us-ascii?Q?3MhRJ4ZMS7j9BMK8IaeK1rKDbL1jS0ahKngy8R6aN05chEr4o5fpffJGHZvO?=
 =?us-ascii?Q?mfcIBCEZeJrO7YRSVR+rN3cSu+TVjwT4XBQ1doSOkAYiQ7jxBozS86L/JmQD?=
 =?us-ascii?Q?71dKm1agjMvXXmUDm0hhIng3I4yxPmrspbks7BpNX+X4FvBIXzno1gF2annK?=
 =?us-ascii?Q?wajueJwYOqQt2JGhVrzGOOSc7NRUkplePvpsQfZ5fXRBwX3NXJ/ONKLJLJZw?=
 =?us-ascii?Q?uiIAVToDLa/44znN7z7pM74asJ6aiuRuzbh2i2DMLbzwEwglgQxdhYlFV4Mb?=
 =?us-ascii?Q?XrkuPjtX/MUIzvpYuTCtJS2hEH6SUufgFhzhv0yN3I7aubALcePt8JsXEcen?=
 =?us-ascii?Q?FxAX34r0PHr65S7AiebmR6uI6SQDU9jbigMMPShEsa/r/lyF2MQfFrjDu/Eg?=
 =?us-ascii?Q?fA/3aUBhxy4/WHTU8eOkMBjMFYsf/94Nbx+YPmfmjtoXx0bMnBMI714qw/sd?=
 =?us-ascii?Q?bdkx82wPsplZknBdJamVNDkYeKsFHMImxVBIoffLxTLsqxH1SwN7XJQ4g+b9?=
 =?us-ascii?Q?vGkSjAMMKqQMhmt7wj50srqAQAOJdpYtMCAlL9qyGUO3rvRJ7Vtgjdo4Otd1?=
 =?us-ascii?Q?8QtVRN5JHx/tUHTEBUwh/YkZwiy5tyDhMXXYXq+Orv/T2dPS44abC7lQvDZb?=
 =?us-ascii?Q?658eQ1bxHLFnIHCXDIDPJz0lOeypGsco8KSstHt6w4CDZadKtn9rEpFNNYkz?=
 =?us-ascii?Q?+ND6LH1JyCf6IA1+IlbP3a19mIcdOSoR7uq73rfZs5sUzJINSA2WaDoztPV+?=
 =?us-ascii?Q?Bza65j8EE/TsRL3GBckAoELwiDRQrl6hbNN6evH90KWCcpngp9a4horfz8C/?=
 =?us-ascii?Q?VeYSAXyw7sObVI0yKV+I43AMWEJJMkgbCfWqjtQ6RiUlo8YNLkJ2rrJ5d5i+?=
 =?us-ascii?Q?jYoPbx2sPJ1266utQW8F5ZIh2GXYI6zcAvnxnm1kL2O5jyzKhbH/1ztUo65Q?=
 =?us-ascii?Q?2F5iV+iRpISppBpbY6Vci2/cdFUkZk5LiPmSYd3wChlx2INrj1oFyCgsNEVe?=
 =?us-ascii?Q?NwIqfojhmO/mTnROmtJjcnAbXlpvDum68+s5FWiJBCxx7U5W1SvtRgwRjt6S?=
 =?us-ascii?Q?g0K1EHxLnEzTOYDLwC9X1K/n84v5VZxKQfBfgBoqGlBvYvWNo+aJglz0ZX4A?=
 =?us-ascii?Q?BRdb7FwKxFfOyUjMbYjr5UqI6MFXId+Xe8tqfD8YA0HegArtOwbumJa18C29?=
 =?us-ascii?Q?E+EB1oy8B2R6sEX2y7cnhSwJa/Zub2xx+qWsC1IgAHmx2r1GG9YRAXYi8QR8?=
 =?us-ascii?Q?4SpqeMaz3V0swwVitHBcARV1JZa07etds4xarh+V471rzrbw8nEbMQPvDK0p?=
 =?us-ascii?Q?aZka9n6WMt0EYBh6bMjHV51R1nrBWHlzL426dGlv8ymCh4dfuoHUo6wMVt4j?=
 =?us-ascii?Q?67hYPUgp83MzidlJvzly6b56KqZkemGGhpDjn8lNPnBTVvTpBeqfGsFMMi7d?=
 =?us-ascii?Q?h7m0mjfOJT1PajWU2wo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OuiAV7znX1nSynye00Qukl5Ztoat0fGaAULYkkd4gEVR9YFdz/Gtani1ff/k?=
 =?us-ascii?Q?ttKBMglpoblInXUNq7ZTMFJqtj7bTIsK1Zh0okm2512kL0+F5cgaftR6Q5VZ?=
 =?us-ascii?Q?aL1YtLr8q9ieMLKnvBDl7zDH+3LROUWipqkkDgfzwk5l4aAvPUiMeCCDLxAq?=
 =?us-ascii?Q?tbZP6tR74j/C+MFBT3TLmFzH3yDgf95xu57fX400c4+uR6g1/LVviEL6eB3l?=
 =?us-ascii?Q?A5dfo6Pgjezs4h/ADFI3e+cAHVG7KCAVP4hUhpT3R4dyZ2LKiCaCYfx26sJR?=
 =?us-ascii?Q?LfJ6cSyy5IHxyh+LsvrEbnS+HRbDy0DIFo5VCHPqw1I4kjDX5WM7Njmdjwi8?=
 =?us-ascii?Q?GbPPDVpOznOjraMVkrJd6139EVFz+hV3mJfkAm0aT7+JzuU25khnY8/sI67/?=
 =?us-ascii?Q?IoJs+AcRFNZRo7ZiQY0xXLGWqq67W8P3OAaNkQU9MSb/uD4xviwSk4JG0GPw?=
 =?us-ascii?Q?7bM9S3KkiOjMP6iEGFXMd8Df4AuqUX20ox1K/sVW5Ou23lDZGfMjxVdhDm35?=
 =?us-ascii?Q?AmeQqIghIaHHH9p3m+ttb9dquWuNZlpYN9rHvflwAnwpbArzZ7Zj/sv0u1Cx?=
 =?us-ascii?Q?It7Y6I94sguTRlRkEfMkOCWfcOA4Bym7CoLUliPfQ73m/IgcNr57SyfJcClN?=
 =?us-ascii?Q?EEg4MhKIUIztHJFFbRKKr5DqFP7fdF1c/T/vr8Ly6laJRFE3JUoZpwIopurX?=
 =?us-ascii?Q?tWcguObBDuLqERd1gp/8eHZox1L50GHe0RbzraF89IzRMKOqjQHpTWaPH3HA?=
 =?us-ascii?Q?bKq6gj1DYByTzGfXKNZMTXNe6BP+kV9ihBZ8j43dFFfTWJX0wkP3pz3iKvep?=
 =?us-ascii?Q?E2MmR8wPyqBooYMCvJ6FZGv2oEtDkXomECSV61xcdERapDckhetgFvZ1Aw7d?=
 =?us-ascii?Q?4WsKh32o7tTnoGH7AKOl4ZSLbE+7fOQjTrjGqLcZRJDmz7fD7g7Z/OiRQXh7?=
 =?us-ascii?Q?JbKUrbd3RfxutQpJUiYhvOPVbDS1cNJhhuDp85KR3Bv9tv/D4KoiA+wc1tTg?=
 =?us-ascii?Q?WUzd+3dF0g6Na6rqafE5SU8CK66NmFt7feVVb8dzk+QlayA0M4r3K5u4xCPO?=
 =?us-ascii?Q?ElZdV8LI2kdyV58levLKsWYStnayJnoOgnrso+/3pjGFprvb2qihWukEKNiI?=
 =?us-ascii?Q?ORLB1hIXbVhPOjQqXz+tlfWnSovlFs7NGD1c5d12u5J5pssGHp+ZW8213aS4?=
 =?us-ascii?Q?8NKnGunQjK2L76DVR2GFOQ8Rcf4zkokyDewoff+uVTSQK12QMX4ArPGZPibF?=
 =?us-ascii?Q?PSs2Jn2i+T6TWmC8sNZyo4YG81O+LeU4/GJsIoMrSOP+pPhq3l5aqt3rmVPh?=
 =?us-ascii?Q?R3o63YQrIxS0OOKw3PqePjWjWcrs2kN86NyP8a0l2NB5ihAiSesrmK62EgYK?=
 =?us-ascii?Q?KWhPDm7HLj79pRnawBoMEPvtgordfqPqLWxrNtZO/J7AnJbHSUr/0F0rup1u?=
 =?us-ascii?Q?rKVUfMXi0NJLpCRDMImBnMUt/NIp40cQUTIRyrRAKDyKbn8KvP+jxpO8OGIm?=
 =?us-ascii?Q?HF1pbmgN5Mrre2o1caTBgtV2MFKJK/e37TsNp+cG/D7tdfElJn8TT0kDp9Lm?=
 =?us-ascii?Q?sKUrEAgyQfim6PGiRr/otBTuvHSm1zK+VAZ4287NCmEFu/qMhFYgjuQxWbS2?=
 =?us-ascii?Q?ok6t8s/djyThs5qlugsw3rskCzORH7WqpjboPqQUECAL0WuIacQosK2lE83J?=
 =?us-ascii?Q?2WG1EeYskAf1u4hJjDZvqB5CngALurE9+s/+OZxS5ulxVdDEREBeVIISLTau?=
 =?us-ascii?Q?r3sFubbTd0DUTF52P1Crbhiroy6v17U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WiVBk+GGhiu3SMhvyjHSausdW5mqvwjiCcywauQ0bQ0ZqV7B15KuSQJmhix6nqOTJixhvigcbY8Gi5Nhyfah3zEpHQ5tihYfbHk4BeOKVklGZtPHiXmltg37KLhn6Zl+5uqiukA+cagnlY3aJ+7CdHm4Uw6gnJiPL+AYE/9y3RbevS/aaJA/gQOxH18t+uZp748TgbwEJeDXkGyn3h+Go58Kk6chgqyD94wHA0k8aDyYa8HnGriSsAedBurRrCi6HQk7NsPgie8i+BmeBsnl036sBvDVgT3gtxIXfzMEUPQH+eqiiEiaK75Q2FJgXnsYBsBTP0ytRGqCFKCdohZFQVse9BetYHONsQbVfasDiv9jqaPhLwrvUeV7zWDHgRWHkIRuYH9kCR7qaGtbXDHdFbYWeOGPtgUS+ms43NBPfixpHnZCBCdH5NgHu+2AYALV8e3TJ6Fo1DjVmtkT4/f3w2Yr7eTwhM7NTCgRCqrJ/n9cVnRTw5Oz9M5LILXkNG5DO1Nl9epJT5Qsdb6HtPAsuB9o6zu7QD2SwqasPKIqg6vNDKpxYeJo/lSVhlrNkxg+9/WtdzopJ4ua+NeITQ++tPyUe5Qdkx3APM7/mZG2Oxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a13e66-a61c-4f35-bc43-08de73ea3699
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 21:18:11.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKQymPn7UIamw4mXFcVNuDSwqwmWjsa4kK7BZuk+oP0opQ9xxeDdTWINuXyvwwW70SdBcoljYzdX7rMaWMvdKBU49c5GrvGRhAoO2ZtC/b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240185
X-Authority-Analysis: v=2.4 cv=Y6r1cxeN c=1 sm=1 tr=0 ts=699e15b9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=gplBdqUvFSrG6UGGaDkA:9
 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12262
X-Proofpoint-ORIG-GUID: tnx2wEsHMxGHSBA0ACwRmtezqtbF6OET
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE4NSBTYWx0ZWRfX1rZ5wvj/i2pr
 uSA6HBNOpr1w74Jnm9MWhNSwM7ztsAt3TCE33ztkabPn8b7aaOhhzuKAryGmT6CtQMfTk7nnrhr
 fkyLbsDJYPLtonfhIIxBkRZhLOqgS9IyNNQjHQ+Z6Wf+R5zR0SlrKUPmIDTMlAIhuX9MGJlMFJj
 tMqIQy9BB7K2Gj9pkRg5NvhYkNExKIb3K/CEdcjBMfkoT4KOnS8d8D6gnls/g2zUkbDp4TYWhP1
 9sZUDdgI6EmiqnlfBqBH0RPKoVwyB2rHcYwA3K2/g9telWtaOSRs92Oh6fBPj3Nx06+SZTWogGI
 6m/z6p/cTggUIxoFZ7VIEjEmXSaQknHj1+OwM/TAeUf6lDQxPm+ad/gV+1hMuqgZs2cPBL1TUHa
 QMRDTuRlTThKEmgp2oq7ya0RtCP2cbo0zReBZ5KKTBah0NrQf+4jfI2K546esQ54Kp3bEd97ha5
 HvQeGussPayloelVqpPbsSk/uuIhvfPLlFosU0vg=
X-Proofpoint-GUID: tnx2wEsHMxGHSBA0ACwRmtezqtbF6OET


Christoph,

> two fixes for zloop found while writing new test cases using it.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
