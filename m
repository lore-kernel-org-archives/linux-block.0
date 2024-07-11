Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26D84DFF
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686268; cv=fail; b=qGN4MmJIxEHOutnqYHd5GcixxKHROb9Hoo3lQRhwVk5rC4RNphIOy+5fvTu8wvMpIHim8s/CtDV4fv0G+TvUC3MqTqZAag3BAWR8bV3SV1Wt7aZS3sESPlQ2rI1VScDhr6Uo/tNGGw92SgWxucdzVI6j1s66U0ICNulapHksPNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686268; c=relaxed/simple;
	bh=EiRfnCksxBZT5+m9tZdT04XU4Qbzy2TfNON8pHhEYMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FF4Ra+PDNdiZYaot1zzK0RJha5FnG8eU/9PhSDte2Ja6/1KhW054gr67MKKJi7Yx45QutEqMbmzQy4A8i8mReHfIZyX3KspgyKqkWQChw3LIvtQ1z0sYBkVw8jiMX/p3rJlFEzieUUiu2yq4zlwwOAGCbfcKtvaMsdIRRzs0kIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UXsM6GgL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OUw3WdgX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UXsM6GgL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OUw3WdgX"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tXeh011761;
	Thu, 11 Jul 2024 08:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ijYhQDfRanAxe8prvryKh65lkQzn46fymflIoyNnsnQ=; b=
	UXsM6GgLlt0EDpvKp2eCMpsNS7VuoLWs/HWSGk4t49pFB/7lSYEapW9NSVZyojIk
	jM9UIx4aKfKE4pP67RfTR6pSeY4VHfVjeUUmdQprgb3lNnGstaKNnCWDliv/kgLw
	4sev4WtHvRO6ZQ60tEAavO010CqHLyLHwrjy/QCRlAL5mBr0YXzjw7QaesWlR4rZ
	rmAbvgGGvtZk62tIxG5Fgp33fe/RtWOuAs6H62RDN3jANl6Ki7TfsbDiyNVX9/4c
	Y6/2ZFXcNFeQ3jVyfmeBHkUdGwazmP4kIkrIDmHxzOFZKljFayfMHQOp/LxQ34Td
	xCEvw+bP4Jzr8M/KF1YaVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8gyx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B7UjAO022924;
	Thu, 11 Jul 2024 08:24:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv25h5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD3F+lYJS/JpNKC8zokrgh2EtvENzIQPzjLKIniFJucOdCFZDjA1LQ9mzXAFGIQv6ZeuXh21Rny9B3QaMtDOvFZR4tLbJyIU6NkS7ofAqSvIz8fyJn4H1tnwye2/zF44sfMs+FWLl2UZVyk0XRYVazzEYhNrdPPF9sHUw8y7stXAPdvus4jmCy5FLQTonX6PwnnNuDcBoG0lRm8Cu7N4INDcsVaYiiYidd9SVhhskikyVuwDFkSFwaqsCz6dq8CjfjU+aYkl+Qvp/1E1TkV24VjpqRdxiWIgrX4SBQqhGvsQz2VwDiFg4Hj5++lxf8hlJpfIRE4IpHYOVaTING9FfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijYhQDfRanAxe8prvryKh65lkQzn46fymflIoyNnsnQ=;
 b=CdSJ/XnRlkNFMmnaVx6DoyB5r6vV4ry1jvF5v77Y4XJFLIP8EUpvxoG+P1yC+4/q0adsCuV/nV5lk8cFm1BLHB1HL0qvv3RL8fVIa2SDojJ7IE8EOoqZztphD4My2y/dRX/mesvK6lHbNDkU7uQrN6W8Ed74OGFpjV9ZM6cZEyAsnuBpch7I59Yy7g85O3RFNflcZcFLio+iVjObC1lHAEp2UoU+QFKZdfHlhIgMMGELY1vE8hHXg01ErV9C7jueNqG4I64Y3j96+FHI/olwzK3cVHIXBS2fWLXx2XR02kky4tpq0jsVajouQB/X+nKuF3dEdf0enrkRoIYZTdV7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijYhQDfRanAxe8prvryKh65lkQzn46fymflIoyNnsnQ=;
 b=OUw3WdgXrR5bCOfJ/4jybpcem8zyofdKB1caZJg6dywPxz+hqb4AWvcI2dAl9NoHTJQoYnw13GMQuQD8QYRH8ZvCZM6I3W8SJMi183p5b7ev/XEq6s3BoRWnTrEfFR5C3Um8XKt2XhCfDtRI4YE5S0XnKlRqCkVGU44Asoyc84E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 12/12] block: Catch possible entries missing from rqf_name[]
Date: Thu, 11 Jul 2024 08:23:39 +0000
Message-Id: <20240711082339.1155658-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: b7701d22-2c2d-4a0e-49a9-08dca182dbe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZmUhGKvAm8qSIDAe+WNjfqc0njH+PU+eO0f00ARLM866ukJLR1mxgxyqJB4e?=
 =?us-ascii?Q?agWZ9uF0BsHwfGxUGc9S+Dxlxi9FXruTlnbzqHL3bQ/ynm6w01cFkX/D1Ax0?=
 =?us-ascii?Q?3C47n47WRrhP2Jpl8Xqfo2xIYTlpu//AJLC9oo1mOjVdzEbxK+7q1bCA5vrM?=
 =?us-ascii?Q?EeJoYVNw6c/XUETMQR8fvfg4zedYaOc9DCAkl7+x/EhUNb+h5d6F8YA+5TsH?=
 =?us-ascii?Q?hBTgnJScDq+sZWcoKRDZPcFARRjuVwoV3f53GMgBjmPfJgERx+7MAmZl6IOv?=
 =?us-ascii?Q?P2S+adbS27ILQffbSxqsVdNl7JWHurTHh62skvNqBeX1E/RaQhFLxt9beWI4?=
 =?us-ascii?Q?hh8A7PSGHb/9u+b3RmJJRaoA5sjWEVvy/lDXWf2VWkt4hA5SPxaHGkh6021u?=
 =?us-ascii?Q?ICNjcqjPFxw9ed8/mOEOXHyWQf0H3DoSfr9XBHRW1h+hji3lIYAvzWmys/tq?=
 =?us-ascii?Q?1WQcudNZsKKuUFswBG4rru4T8WstDBDWGXAnhPBRlG7HhPKogZqXXq22CBsw?=
 =?us-ascii?Q?vlJoRONSFKC4kCBCij60Vogmpq1j6Ys7La5GSNGBVPX0nhV5UsQI+Vt6+S8p?=
 =?us-ascii?Q?BOv8peVUO4vDERsVkXaIlkoc9e1yDZ7g8XEPOr9yvUj4R2QScuvjR9bhCbVO?=
 =?us-ascii?Q?EM1RltwLrtMdddQMikZQC7aFlAR66E3xsjxGjCzQIE+9ILurPNcsunlSwjt/?=
 =?us-ascii?Q?FJGkS+99Isq8DgcQGWTgC0at0zWk6YLmvj4QAMirN9TINOqMEZoa0gJdCqTj?=
 =?us-ascii?Q?np5ehRQKSfA1vMYyQJVj94ipJ3gyNdya5qeKiDLTGHcROxCXQrWRRqu8MGld?=
 =?us-ascii?Q?nn+R923D+E+bhg0Q0bjfOR5JGVuEdw1BcM/TouH7mOmKOrUgTZ3yZIjLJGXC?=
 =?us-ascii?Q?u++++tWlibr6TXcNHxOPppRLv1K7mFVsDl8VAPNHpCEkQlwFkuhWJuyI8kMO?=
 =?us-ascii?Q?Koi32JyIfnzK4sL16zBSom5aFXT8FouakS7LMJbJt0vZVgcY7bScpUH6YXK3?=
 =?us-ascii?Q?KvgAPsS2/ez4NVZ4MxE67B7GEZfyxS/cakCwFW0THujYwqDYfxi9puliHTPv?=
 =?us-ascii?Q?fUXgrQLYyLmxNJbgePR/F+1vofxzSo+AXXvQUt1WpVvm2uwum/Epe32lej6i?=
 =?us-ascii?Q?XhHU55NBfmx/XkFCZb/Df10A6ypg5b+VdIUGrrnrpiEz2ZepU7NvxW3MGxOZ?=
 =?us-ascii?Q?hRVaZWMT2kb9x0P9jqPgfqmiMOV3zfl6HWZSuVHut47YIkoEIayLpplWHbaH?=
 =?us-ascii?Q?K4nCg9qUAf8SGICAU1tiMOMoUEHklnCJYq+rZ/1+8AaYqVwUKQFONljpz4hv?=
 =?us-ascii?Q?2wLWZBSgWvvlCMhQJK0s0WXaUazj89Ku1tIvVBOkFleTjQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lAFZlR3plU1sshPfroQykGfXYu4AXG5IH70INPvLME/xtlKBIMZVQ81hRzMk?=
 =?us-ascii?Q?JfvCSBos9o9oOC1EdrHevoCb6TS1t+92Epmf920uqwGks71y0OThlcB633O3?=
 =?us-ascii?Q?/ZEom8oI/UMD//iJ3s0ZS/je8wT3IgsRzG1iBmD2OwPjV9vw8+DHbQOP5RJ9?=
 =?us-ascii?Q?bbc+t6BS7tk7V9ePoiLVFBx3w8wHNiTbwvcex+H4oGFITw6ZV7MZ4SEdd0pU?=
 =?us-ascii?Q?0BuVpWCdg5vsDM3FNnUQyLrhTTwJlCsAcoOFVWAkBQ5UDSZAN99q2MXypGsC?=
 =?us-ascii?Q?tLXv3M6acEgFvJ4TKlRgjKDyZwAmIHXpdfxE9C+RMbUP8SzNLyPQffZXPsUo?=
 =?us-ascii?Q?TCG9+m40VyvTF2TCP+/0cP54kmJVREfHAouHkMkCwpcgi0OzRF6Ss4yZjAB2?=
 =?us-ascii?Q?nXoHI+nCaZtad65ccIVVaFLR53HBbMRRokSdeynjgyn5VDZ97eCbcKGI9XUy?=
 =?us-ascii?Q?Ow4WleJ3/kwn4Qtu5YG58sODlYvRdRLEKMQT8lpfEZkzhLvfe9KKmZIOpZBg?=
 =?us-ascii?Q?ftr32BUBSrCUv7RKeXUN3RWS8t4lmoY0Y33RvH904DP4vADL2mZDU+dcH2lM?=
 =?us-ascii?Q?r1GadcxNsSTNJJhzzOR5ekJfpPGV2F3R3NOtLUMJQO97Tzk9bVhusKzi38tL?=
 =?us-ascii?Q?s8Umf0UkKqHXXPJ0/0pvbBCkAtyqFDhuZ68meHYP7oxc4DBnMbJ+zXyxbQUW?=
 =?us-ascii?Q?G31/CPFOVzeXAnuXVKz48Z9nADg++yBgQDVmpexy+E4xcQIFj/+cYtjZt+K/?=
 =?us-ascii?Q?bIj1KUkwE1ms0gukYlIchy465SxOOJhSgInHlcahZtVIwnDo9ijJl7ykmewD?=
 =?us-ascii?Q?hflpF9RsrLBaSSSWaGFVSuucgACUL8dk/qo83p+4q5wRpeGvJNbe4ARXBdBb?=
 =?us-ascii?Q?99hSC/9v3GtgCLsT8KlLa2UIRo6r0Ujc8+eRb9Q5ItRnTQjC4Wd97m3taCU+?=
 =?us-ascii?Q?8hX+V5Crt/TJ14H2XCyoOHSTHLD4qlArG2xXtgRi6m9OUvA8CDHO7QffFPHA?=
 =?us-ascii?Q?v3fUc8d/8GdCj6P91BxhxQER3vD6CYSz2LbxZW/7hPSCe8kFUUCvm/FWN2Lx?=
 =?us-ascii?Q?YbQdrBkfY4VeYaXu2dENL/yAw7CyzbZNYZx6hzl1yqf2jFs/Ik3utPKKHqcI?=
 =?us-ascii?Q?sDwoue7pmnoGGmTYYXHfrPv2kwog+cK91nWSz7X+Aj2s8DjFOLUap9xDHGq/?=
 =?us-ascii?Q?c3n3k4JXYb8Ll9VG4/FVAInxQ5OKx37WqarPHSYHSSGUF2DCQsLeSl0qmj39?=
 =?us-ascii?Q?XbBvuwBB2nLj76FX4tLub6/XwEPc9Ky/2qbD351VHn7r/6ziF+y+ROxxdJrp?=
 =?us-ascii?Q?d+SqJ5vP6sMLdqxtpaOQvxTYE7f8WSguxED4nXSseDcd2Xuj9XgW7oOFkaxw?=
 =?us-ascii?Q?tYUVESwnJqRRKdJ3mSXr8AftUdSh3HtdX8+VvpMr5Rrata07WW3WZckrLc8a?=
 =?us-ascii?Q?RZwgY0pO3nTrG6yFuh9TLr66cMp0SOwxTf2R1W151q2dVoZaqnwOfoqGSM+W?=
 =?us-ascii?Q?qsCxyTTdsexUP/E/Ryi8ZqZ9GL4jCLg3C2vEWlOovQy6XE2u6+Z1kurONMm3?=
 =?us-ascii?Q?lL83Li/eSaDLHSoYATW8dAUrflMZgsTy2G1NXq4CtCTTwvBoFfBSXxGnWnOC?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LdPbF4FOzMws/sHR9v4MPoxMo8fDltuVJEMN7987zigrgwn2lXmKGTQ52oLGrENWwJ6lYyalI2SBCNiBtHdc3D71gno7TmMHH6l67vOHxZ0YkGD3zgHGbTenjMVTBiT1kfs/DmqWhcNGcL1rv5/czeSP3MxT+fkXiXWKOHBliKkNR2eLApnEhZIgjj/62H/3xR26FSsBMkIMTCE3GVtuL2BbvhEf5gtSLBYUv9IKEaXBR2IKT6J2rbjL6yqdZX/cEdc94Hh9iY/VY3jnuyDOK60bg3VJV/jk3dCamgWLrRtaQcS3xjzUKOMaJbG3k3JFuXeFT/yskmE8RasUpeJmNJBYQuTVvUwlTgKCLcuAubWAjVqepPZYMLb5kO/i8P7FWpWTHnZ5j1HIKdNRXq1VWrSODBEZp09xVoVIn0U5bOiganAzdrncFWuCgpP5LI3zaQtQRvGZqxfYNdQZdcaMmumUn9/gFyTFtaqPz8eriLzQ87Y5xI7wnYA24PBLGPZTDeRTbNNVjUGsP35HBx/THxaa2XJ3tu+WB0c7b0H4D0KrsB4b+qio4gR363eUniM3bHBNufKkk443kyHjn2hFuF2imolc0vKsxfpqOM2lKwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7701d22-2c2d-4a0e-49a9-08dca182dbe1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:18.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6qS6XnChPoW41d++OEpLWd55Ga16JC6bcymiKNFlOOKxnWwCmjHjKAFl6pZhMPzRGW2IJ6SlbmT3JfQxvdkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: VavoY8h7FB59zMg3V7pBg0jk59vf-7NA
X-Proofpoint-ORIG-GUID: VavoY8h7FB59zMg3V7pBg0jk59vf-7NA

Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
in rqf_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 include/linux/blk-mq.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 34ed099c3429..5463697a8442 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -282,6 +282,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	const char *op_str = blk_op_str(op);
 
 	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
+	BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != __RQF_BITS);
 
 	seq_printf(m, "%p {.op=", rq);
 	if (strcmp(op_str, "UNKNOWN") == 0)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4b300f902d8f..023e5b9f6758 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -27,6 +27,7 @@ typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
  * request flags */
 typedef __u32 __bitwise req_flags_t;
 
+/* Keep rqf_name[] in sync with the definitions below */
 enum {
 	/* drive already may have started this one */
 	__RQF_STARTED		=	0,
-- 
2.31.1

