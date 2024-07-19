Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B578383AC
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388894; cv=fail; b=dsY/6BmjbV2veknTCFcUMWlem0i4/WvVQn3A6b9rqjdj1r+Z5dEHFo0/fnXAPTVbKL6oAkIqpU1vY+LdDShT4+B0jD+CH2Y/y3HA0JUUPxSD0A9XaSu/yf5rfDlaZZ5GffOjifPdziqg8PccWBM+/yoJ6wJucdkKE3AAvbW7x50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388894; c=relaxed/simple;
	bh=MlAImvu4sKhaC/PxB8eFQ+q6w9vnPA2fVpNkxcdAKb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFq9U3Ww11SJlBck2NhOcY592IZDrQFdEQSmqzLQFc5IuvCxm9mGslKo5pUSsJvopVmXQ8RXVKwaKkBiQUNIq/JUzJEV8IuRljZQKuxqatWBk26YvN99XQRnttOEQjQeXAc5SjhnIWlCHYsovkZ+d7qmimmg46PVJeBt1o1CXv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lo472M1X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o1brX3jj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lo472M1X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o1brX3jj"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBC8YC007723;
	Fri, 19 Jul 2024 11:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=6VYa1FDYaORkSmGxxEAMWmGDdF+89LemoQRC2Bs6pX4=; b=
	lo472M1XzZQxKLQrbjY/7f18Q+quobLuWpYHHp2I1H43nehAfK3G6VO8l1F6stPf
	nRmiVNhYIJLpXqkDZnyeYpHv7QuJCbc1DBIz2QTJEEoWdrjKWjoMapNdCp0TadPu
	3VAy2asxsYc+sJU5av1HavCA/75En5O61OHlrzOD4rhc2pajhFF4jrbs0migJeC4
	8h7aA6LOvyI1Ec7MKMP6SBcb8C9NKL5O78CkffCHPrLNLcuqWEltNFYxGoe/8yq+
	9ruRh/gxVGXGBJfuBd/PShgFCqzBcHacglkAj0ueIj+MT55P9DXj3K8nTU789rEt
	i54xUsqEJhhDrnfQkEa9Bg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq2h0150-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:34:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JB3bn7006724;
	Fri, 19 Jul 2024 11:29:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf14cf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRKHt0dDik79zisZ0icwf3WXJRAkX3l31EjjQCIqKRqCbv+FsFSttQAx95vJzTFR65RoB7cA9MmpbNvTUEpZJOQ0gOztBtztX4kQEah/aNMWfHt9BMWdNFliZgXtDHO8k98x9YhRO0dtQHDnEktRjoHVybgHbiOq2QpnLhkcjcfuVYaK+Q62SV6wF0/Bvd8oTkO8sQYA02P4qauNcBMOGK2wwcSo7RkGD52C7Fru6EGzoTYbbW8XpcpHVgagP8BfrHsmapa4XYz0oyjyb+gZfi5Q1ObssBQ7L8KYGAnkOiG4jE96d69btVdKnr/0YKpYm3v20FH+pBkNC+we4uXhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VYa1FDYaORkSmGxxEAMWmGDdF+89LemoQRC2Bs6pX4=;
 b=nsDVnO9ft8hKqoTw9Axi6dhxQ2pxQ06towGtFErEMlY4aCr0lLnf4PCdPORd05p2DNvGm7b6S9mq6Z6Qtv31cnQJZnGFUWqgwtZnH8ATESVcKdF5IcjvCjcVwx0mVzREJJHRwyQOD7gz6ZUhUwbDPbeQ9LkziFeK8KB0NLWvuwgO6k+RugLzge9/4uNQ2wHXyJaEzG20hoKPYdqjIwIWWz1vpsptwwwqJeSES6ZbmUmYNgKgV/Yw67Xtrc/oIP+XGDER+E+K6Y2gjr6gpKYVmlGZwl0DyrzhZG7CQJoXhvauLXP+gDJAORmOEyNrC7rgBEasd6zwKCFbUALvt+Nt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VYa1FDYaORkSmGxxEAMWmGDdF+89LemoQRC2Bs6pX4=;
 b=o1brX3jjzHRCdpEggUJU4eS/eSdkamQhiLLSqKV5KcWfRJr85R+QX5aSj96BeMyQIxybekKYQNGPGODOlpzPTGe3169vC4w0PtcZJrc0XTrImDSWNZeGbLQ/bE2IAoZgtZZPTzFJZRdqditdlpSmW+UoX3mjezsDfWDcNmUW23I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 03/15] block: Add missing entry to hctx_flag_name[]
Date: Fri, 19 Jul 2024 11:29:00 +0000
Message-Id: <20240719112912.3830443-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 64412017-eb19-433c-b8c8-08dca7e615be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Zo6S6HS7DgwY4ezXZF/9WYh5XpLH/+u6Ceisl40wEhar48Z6GNuHEYi3faDU?=
 =?us-ascii?Q?ibe3AuRJVz6lfVz2a0DY1POa4JZ1vi+ePfOr+5g2WIZpGsi4BQeviQnLIbJd?=
 =?us-ascii?Q?wC4LpD2MTQ1/5FFKit++KSgUNoG7roDl8QxQH2VtBg0yFgxDYaS9ToPeokw4?=
 =?us-ascii?Q?lkJMpvYADvoV+x5f97gE8EqMLCzxm1H3dMltwMWNQWwrkXFuzq65IpJI77A4?=
 =?us-ascii?Q?1Bf9++ebfVLANjANTJwutK3uZ6x9oTIfoEJ+A+v7hCu8BVzeZaO8UXFSjzXd?=
 =?us-ascii?Q?KQQXepinzmiwNxXv4J7SrPwYybRpEDitbWMVgb8PyJ14RqYr0ghjXozYVN23?=
 =?us-ascii?Q?MSPp/mHyy7Gtu1cp+ETnIgadCo5oR2NVVy7HkXT675hhlMzMuTH8Y3z4RjSK?=
 =?us-ascii?Q?pdUkwa5M4ckrbUOrLy8zo6bYiGhHJ8oFRARMZvYs5nJevA0za05U0RK60J7v?=
 =?us-ascii?Q?HsUj7qZaFUgwgGnPFwPoGQ8ACNHJflC84JsaXB8nc9Gz63eYCGMv54yQ93XW?=
 =?us-ascii?Q?P5fSeVDx5BqcJt1GavcBZR5b5scuU1gtnnW3irC7ABR5usSGZmqX+rd2kdcM?=
 =?us-ascii?Q?SWXkWmss1Wb8YkSCGLols3rN88W7MoMkiOlg7oq5UixOJsoZ3l5z+t2fhqVe?=
 =?us-ascii?Q?LcoG+dZwbxoiP+vjiU3lWnmA3/YHMKmc6YtO8n/iDaB+iCGp3Mmo+l5yX6ha?=
 =?us-ascii?Q?0YepnjP1qNl8uSqCJtlhx1BwYQnUsdHzhdISjdz12eRp5NenRwvYawizD61Z?=
 =?us-ascii?Q?qK3qPnPs4FGjveEta1MiqnPWZOqA/XsOuTFNFO6sN2DBVWpPu5uQ29AmBBMB?=
 =?us-ascii?Q?n7y4aWq3VbRL8wLwybcKu1zqH4hUKNiwOW0onYb4ARdCKr/ec1SqXtNuW9wM?=
 =?us-ascii?Q?f/DgCWAuGVvQ+/nTpOlBMer4YELcM2t543J2rkX18VG3r/fhbmEzhAuOHAG2?=
 =?us-ascii?Q?N+Wt1uQ5j0E7ybZ7IkzTAn26gwReJLZvi1OMnvzymBm888PLX5UphNQVkLmL?=
 =?us-ascii?Q?scaZ4voKgVDDhiyzxWmXv3zkiErocxTme1nj0+o7ziwfkjFGBpO8+C93DcyU?=
 =?us-ascii?Q?aWjwDNGINj2/vTSCm+jyOnGCuVfKb4Jv5xPmqrsaZwWkPM2wA2XrWOLpdyGH?=
 =?us-ascii?Q?a5GAEqVDMr9+Glr+ty6Fw5GSk5WKvj31iuWxNt6U8/gTf+HzE0ds0awQWggF?=
 =?us-ascii?Q?VZ3Ddf29e4Ax/FP3oLOf0T7hveqOQI05kvHz86gOiofedqox2b8PObRYk7Ny?=
 =?us-ascii?Q?nvhtm2QxzOX9HIKiHhWH/YXfT0VDyP8y3dgYCc4F6HZkSXOi7PEvlrgADeM9?=
 =?us-ascii?Q?g1de+MlljbsSkboMebm5oRk/kWo6teUImpIJcvOsfBGXZQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vEWjpK8yXiWZVqB9qtEwxhkBEYiLNyNXnNTtSMzhJyESgbXw4PATIL+cPmt6?=
 =?us-ascii?Q?4lZpU6T/N8DZDsR7wY0ZNxD7t1nR3Ipg2pXevDHzoTkZgi6QPxvfSEe7Oa9M?=
 =?us-ascii?Q?qf6K3kejq47PHXzH5FFSLUZUikJfeO0zeTLRV1TNOZMD8CzF2RxJwPvg26Z+?=
 =?us-ascii?Q?2iqjCxYxkWY0ujqyDRON5E7zhnciOriDg58pgr+g1HVTTZ9zTgxDKdGVy4GY?=
 =?us-ascii?Q?FpTKhVDlWeTqSX6AKDV9CwJ8usIDzQu7939jRX+olD1cc3g+UsbUoXAX3MoF?=
 =?us-ascii?Q?jToVppt1lW9gSZXhppwXd1A7Frcwj50q9eQf4/rJamCHaW1F5blb7N2w/5xn?=
 =?us-ascii?Q?NLQOv1yaSLScAhmuvy+tcMKKs6/9YO+KKeqb3lcBJ3sdC0uN0/iVEu86d8WA?=
 =?us-ascii?Q?zSfn0db8IcxtrbowhoXPt4ClT+mwTIUSJFEDfTPOy4ex15kkRGBqlEYpUyrD?=
 =?us-ascii?Q?eX3UVix4CQTs9IqIkqGDy5i/kiydRtrc14HxipEJFXYTy35eyHMdr1kWPPId?=
 =?us-ascii?Q?z+xr2w70eG+oXo7lYNrBP0rmc/n2b9TEVHWPln7scjZ/Muqy1+9rZpUiDAu3?=
 =?us-ascii?Q?nTuZPN8mqHIXbgOibY0UqbA8LQkX+MRoB5zZ6lQ/GApAbUXrDulTvir/mfU7?=
 =?us-ascii?Q?TXqYblaLPD6h+egBtLHW1R4YvUliTIp4JtTX7EC8ducYOhdxgi9Oa3a1lf5O?=
 =?us-ascii?Q?65ZJIHs7sTcoUyhBTYZoaYPSUZBXBIobhZnB8cGOtZUto5rAQeYns3VN2sad?=
 =?us-ascii?Q?4f3k9IRzGmvvCWhsb4wfDMOuHpCXbfjD4cBe3NZ/B6IVjFaLuudPozDKQ7X7?=
 =?us-ascii?Q?vx0T1kZZP7C0R5R6tefp6L60GYlN252j60E+uT1wv+KGeqwYPHDZLCtFYOYF?=
 =?us-ascii?Q?YJZiQkFygdCz/TNJK+bj6lC7sWoCs08rV5llhDx97vTHYakGDig3bgXegpEe?=
 =?us-ascii?Q?yxmsIxVvApaCO9dp7f+q/HpcqXolnALyOPNSX80OKQxTtWReb2InoFWDcT0k?=
 =?us-ascii?Q?BhMh/vZUAq7Ilv9w7FBsgMXoMF05lF8XqRlPBF4LZxKBYAKDO9L/+Ru5NgLg?=
 =?us-ascii?Q?xpFsQRdgdfl99/mMdXJHqkzjUzWi8Hw5/ZCl/a7Eg3SvBoYLcfxj25lDMgde?=
 =?us-ascii?Q?xh5XZWd5RNp4lC33mJs+y+rtZfac+uhZzl26WGOE+B6/rImo9SRed51fpShR?=
 =?us-ascii?Q?CCNtKGwoenmobybveMg8/RmK8ZnUJGPEDO0wPNXk4N56CaTYFOzlTYFfVVyP?=
 =?us-ascii?Q?6nKQ9bsnc4A5hs35IQNIX2jXWKaJmodalUFzh0iWbeRvgTf6r7rWmMbEst4Y?=
 =?us-ascii?Q?Qqx0tN9LHcTj9yjfM/CUCKu1ySISfDKYcciaWM6+dBXlwTmwMsaSpzandQ1z?=
 =?us-ascii?Q?H3dlLfmSqOPT+sFUrotEYuktXuHbdKURCW9+veIfVnBJxCNykH6cuzMSfMBE?=
 =?us-ascii?Q?VMruvRTHWoOK9HT75aZEte4k5d4iyBCgCnUTY2kl45ADwf+32pn/fMWJhIII?=
 =?us-ascii?Q?Pl8/GWR95FqTwwvMuqfihhreJM7iCDu2AiEoDqOtwbSo6/tt9uktkkQ+Ni8N?=
 =?us-ascii?Q?TnP1OZeULEayfdXmQ97jVihCg67oAAA//RdXkSVd9ccg2x4Bw4gWEJOMMqZD?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xFFI8pxdEvvuui8w1uKiHxocVL8sG37/rr10tbamrNngIy7BaveUVPWABc1bnum+xNRgMDPlVMPp0yAnHM9Y3fIK2bDJApH5QzSHuo6dSkCrSzn5MGJbg15g74rlmxBNupZ1pSpx/VhjjabGhRSTF1J/ts9iPQif70y2WcjWtaK9cBmLk549fTy3SVENppIBjrBnMZhXDZh6p9P17BYJy39+OcXGXi9m5iQrY+j0om4Q4Zidv+kCyczzi+9ObaELAFYNbLz1u/7i/AJYill8CeUjlcXi7lSXzzmTuC2Sru56IKSOV3ZFFR67nisR3dC/NwRc1WkKykZI0YWXhllfUJSFIGuIDbqpO2xMmeR2mZ5uPiwcwdMGdguPrKUDcpwzNQKt/LYiiU4dLwF7KvzYLDCzck0SGRd193D/ERZ9I3xHVPK3IsFG5orUKH9gX6NW3RmC0mOdnRZGFKwNT8d3dI7+WUwnTuBRwhP1I+2xsFN+CSHjYjDYtDv0HJiRzPYHHk6rJH2sPiSW2ulOJMRHF/l+Nl76JTk3IFzW3/ttEtrPIwRegrN+TerO5LIlM3v+x4bzwrXp7yKm350GaWeyI+NgO8+KfBw4oHUUazuBeMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64412017-eb19-433c-b8c8-08dca7e615be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:43.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYkmo/AUhsSLFPd6ilq95oXufzu++gAZkTfzxzRsu7BRUBAoCIL2nZ8qdJbCwEMfuD5XsUyuZWmoHFHFMMXQWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-GUID: 4kXtdU3ZCB4bu4vhpkXv-15a_CmbdS6A
X-Proofpoint-ORIG-GUID: 4kXtdU3ZCB4bu4vhpkXv-15a_CmbdS6A

Add missing entry for NO_SCHED_BY_DEFAULT and reorder to match the enum.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 49d4f6e0a719..5f53796bd6e2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -181,10 +181,11 @@ static const char *const alloc_policy_name[] = {
 static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(SHOULD_MERGE),
 	HCTX_FLAG_NAME(TAG_QUEUE_SHARED),
-	HCTX_FLAG_NAME(BLOCKING),
-	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
 	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
+	HCTX_FLAG_NAME(BLOCKING),
+	HCTX_FLAG_NAME(NO_SCHED),
+	HCTX_FLAG_NAME(NO_SCHED_BY_DEFAULT),
 };
 #undef HCTX_FLAG_NAME
 
-- 
2.31.1

