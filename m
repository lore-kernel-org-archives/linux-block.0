Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315041FE457
	for <linux-block@vger.kernel.org>; Mon,  2 Dec 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140666; cv=fail; b=onMqWe0/WfyO7Z54L4F9/2Sd1OLxTs2qycJSNYCgwC5W1eHdiy9Uv8DI+Qc9m0JzMuW+e7DSrjrWOPvzwhGSODLqyDSpB2IUsKsW2yDvveoqMUHOSqdPfQm46IleGjL7E6OqoTh49xLEwERbcj0gL1I/Te44JQ7GB2911pEqDaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140666; c=relaxed/simple;
	bh=SilATohDA7BCCGahT8KQqszNPApLFrDs8x0yIRhRu2k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OWo3GHmqnfi2vstO9tVA5NfkaeSv3s2IcPwJZswTXNWYOG6ocdi8e9Nj3066oFz56PF5pDjCFoU1BJgiy92Q4G91X5La4yryTkua9WxORLBX3MWdEdKyEzJvbiwvSBxTUg7N3zswsr5dQjl8vG8AszNTznDSd4Q70W8VDjagu8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=knUi9sr3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=amaycZq5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="knUi9sr3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="amaycZq5"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WuXh024788;
	Mon, 2 Dec 2024 11:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=UsHE80oRKVnfcH7I
	dMrnJ+B5sXwXeYHxx/CwsPLeAh4=; b=knUi9sr3rkulScZP5CepkSc7r8mmbto/
	y8ijYIa5JSDvp6bsXfiscetqufHGm2V3XJox6qlaAF1IV8OjZoeLYVCKWaQy+ap7
	ql9Mo6oV6EA82I1PnSpCjfN4wLKdgdYCYqHyxUR8tzTpZ8Ai7mvmQ4X1NpH4+xqQ
	6GQc9Fouxkn/jHKXB6KihZ7PvsA1YX1lsIXhgwaDfLhNXDhuDu+Cw3RsvrskA425
	ftWe4eDRfRdn40WkewIN+fgyZV5IPoPfv3dGJMOCvjrPHZa2XzvXHJWgwKh7vJh4
	2ciPfpGyLY8myac8hXTCmWyFOrP8U6CGKelip+KLzk2Sfgdt15puvA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg22t8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:57:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2BbThJ031378;
	Mon, 2 Dec 2024 11:57:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836sdc94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJG0UxiMWRAcUNDzL2xrb7o4EkARW+NrIBpaf5YVeGVB6TfcM3tkq21tbmbgiPQHgne2UYTR4plg+YnLmPlSy8NjGC5JC56IVePxVJJk16eevPHvAQyYiyAPq1Qs6ekwsHkDpcna/2Y6qh5K/KHRqZDjTY+2smJdLtoiF1n7QbXhGoEMPtPEE+lf2hX5t2iPyDWBillzpvWWEZK6tokHUhmFfU3L+/g4pB2wE7YRvq+VUgYhcb5lZhwrfx20Kla+LO0n3tEkB+4uk+pRzXhdjDtr8uHTgflkbw3vRG0vvor74j9QImcA3ZS+fGkpewnhVVuuSMi/pwtOlWFF84Ulgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsHE80oRKVnfcH7IdMrnJ+B5sXwXeYHxx/CwsPLeAh4=;
 b=PKQRbAQlJbuaB2f+Wn9jmZ+0czneLGJ5HA4KBMmlBM6UP3RjphUTdcGd+Dn/g+Y7zoaePpIhLll5ufk9gIOBfaniZoeAJo/NSSbvrGn91Lo0jzEO29oTrTJ6y5DshKEhw0ZX+RFgQk5oi3SFiWxQ6wrkRhqu2ADJNPyNf1MjWzSE1Jqq+4Q625qykwRzfuw03d65VHGgOvFr02jAaEeg53ja9i8ljf4uTiww+GR6Q0+Vh3HvJbpUGjAIQeOYFCUXR/lWpCGnfE9s0wCfqvj0NYfkqmxIpsgCkUPAbxTxx7toOE8+NgJyPSUNTfnw4N/FaHVUyt+SDbsXD75tNl9cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsHE80oRKVnfcH7IdMrnJ+B5sXwXeYHxx/CwsPLeAh4=;
 b=amaycZq5O5hQCa/kJFKKkGLNlX0RMs0RohjkVe1fqh0OHR9ooonMWTy42oLfC5nbVJcNHZKJRHnyVjitJQdkxh5eVlbOkGPhgw6tQKdc/0GD7MKwyL/bOsG5oe789CJzGut4zxb6UychwFhnvs+GKjTkTYlIss/UpmwhiDy1r3c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5828.namprd10.prod.outlook.com (2603:10b6:303:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 11:57:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 11:57:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Make bio_iov_bvec_set() accept pointer to const iov_iter
Date: Mon,  2 Dec 2024 11:57:27 +0000
Message-Id: <20241202115727.2320401-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc465c3-6259-4f1b-26ba-08dd12c882b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJGmmuAL+QSRJ9yBWSHWQgErH0bKlIVQBJjX6WPJkmtwQjfF1mvmQhwkiL4f?=
 =?us-ascii?Q?U5GO2csfeWfIPmt3v91wGao+tX9obNIiNM3rHzUA4Bpv6QGLf4AK3odrv6hr?=
 =?us-ascii?Q?KdgJsV3U+T74KiQBRi6dym5j5w8R9WILPWdjgaM5kFvBsZYkQCSOwJ1vmZ8m?=
 =?us-ascii?Q?nBVlPrWxc7baEOAFuk+H9DGIhzvDS//H2EVwlhd9CBqWeIxVirrVzsbClWps?=
 =?us-ascii?Q?/NDLcb4/ubz8qWH34vaGRfohxktLyf/vdpTCMsz20KW4cwvp/xXwyoch+Plw?=
 =?us-ascii?Q?cHAKefOCUJcFhzvymgmZEb5RQi2983Iw3GWx44Ti0UepT7J3/8Z5Y32+4/i7?=
 =?us-ascii?Q?PEmBbPyqez7A8sb422mKBPf+rEjC4nV08tCLVNsWKAU+4d41N82jIR3pIIxc?=
 =?us-ascii?Q?Eg+pyZjX3KKEU7S4s43RTWd5oWrcgXbuPnGFojEun1LVivO1RC+Nfxj6adUM?=
 =?us-ascii?Q?RUOu9J0mGxk5Nq2+qKEvzs15bvCbi3xYR9waEDBPoVDe2jI/DeB44aWJuO9C?=
 =?us-ascii?Q?C+Q3usxxEzAAUk0HrpEjgH9qE+m+cUyER+EZao5h9ePE3pSKPq2P/vhSzuCo?=
 =?us-ascii?Q?yII+aZ8l5WfalrtP+VrGW/o+0x4/wYN/xkik+Fy4GYmlfbBBP0rPevOr1HAJ?=
 =?us-ascii?Q?1gmQe213hvo7GImHWt3dpn6akPD0af3+vk4Z3Vqk+QbtDcbIAscuQsR0+kom?=
 =?us-ascii?Q?jks76IO/NvCYxlPn5/p5ckMljijbMCc4TyiyOEdP1x5G6IET/7mMPenFX0UH?=
 =?us-ascii?Q?7/suKPewhmb3iDn9Keo6r0oxjFdgiauY5HJtdA7r+a+Okw8O0/LnfZFFVQp4?=
 =?us-ascii?Q?KFnFpP67Bs5VuArvIN4edU2tNSmAz6yTlYDHyt7+rKKwXoOFDfx7sXGzbNcK?=
 =?us-ascii?Q?bAedlHpy099HWJH/m62mkPQ27WKJPX7reNqKgbp30JePVTGbHtGfwkhSZwbd?=
 =?us-ascii?Q?L9AG8761KoQrh+e2TieBHgaPtZFFfUK0boqXa72l6GU+LtqbecvXXqdqUgyB?=
 =?us-ascii?Q?mT4mM4b5oyghVrXGnMAr8hbotIMrOFXOUZTU/hdqInZVKnkkni8wTnGcd7gA?=
 =?us-ascii?Q?EJwvb45eQC2BPfZGM4nXmLuZSMaber+J013Kn21O4AZRdsD8++aO6mi/1owu?=
 =?us-ascii?Q?nFrknU7xF6A88Kx336RbTk7cyTby5lkvUKhYTHOIcgdc5KUAdNdU+72+mp5j?=
 =?us-ascii?Q?RH9g7b3qFLDJAaCersAOYt+M4SdW8G/mGx3m1zfwtjrDnjgbJ8Dp31mB2u5S?=
 =?us-ascii?Q?SuIbGGE1F6mGAeHmHskLFis8SP0AOyKR+MdqY1v7D46W+1+ssHxhoiY7x4Z1?=
 =?us-ascii?Q?zlLdfpvhC336nGeb/bqRH6ofOT6IpFIKxP/KMt0vlN3Vfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/4MF6EZh4werN0BqOBP4aJVnaK4roGPaC3ixgB4QpKP5T8CuAx3qe+mvF46y?=
 =?us-ascii?Q?pU9TB+8zX7IvESD99hDP1XbGD1UJ1VgX2/U9G0o8ln016LToAGxGgZyutOKV?=
 =?us-ascii?Q?RFQBS7qssAdP3LPWSZyjoXdJ5SPLpIQyuiJSB+qZcLnZmYlpT7sMIwE0quci?=
 =?us-ascii?Q?bCPpeEK7iw/hmOoHWGR7J8wib6OFI9sAI4RF0IjK55HNaMhZp6F13UeGL2Ka?=
 =?us-ascii?Q?1P+NZa3hHABgNvbu9bW2BoMj+1CSLprRQxeMdAO165Vt1wmpOnZYr4CzeHPR?=
 =?us-ascii?Q?PDytOYdn/PR6FqZI+m8gMP71kXqmJYKwhtUYcEnLW7k+gEiiRi7UQ9ihH42j?=
 =?us-ascii?Q?zV5rskM4z8S3izQdK33yBTPjBOZtyyWwFxrb7Gi37394G9WhViCtLI15qzhw?=
 =?us-ascii?Q?T+rBH+jTpCOWiMrPSpzqTTuPl+Z4kqDoPJ7h+HPVBwfdhJsGfXMAs4zkINJ4?=
 =?us-ascii?Q?lKXx7OKqon9W9aZFUXKwt9i1yXI/d0zZ3lQivxM4ppvot9R745HHTTZci7II?=
 =?us-ascii?Q?CWcjFi1KldavI8g4852M88md32uLc7BuBPjkavy5DzrceSDBDFO2w2Lg7BbE?=
 =?us-ascii?Q?TP/W6VP9nUEJ2BgfCcjywcVP0xPwR7nAE/M9jcNryCmEKsqzFJIWQlicMMzU?=
 =?us-ascii?Q?VpKiotiiCBoitsn9GyS8Dj+qTzG3pERQDmPA4WXNvRdezP+V1/K9n5VgfOJN?=
 =?us-ascii?Q?jf+Yu5+i0qwnpRU+VRYGd8p9qFBARiAuC6Dtr1yXgtLGpC0gcEQCeMfQg86j?=
 =?us-ascii?Q?NEY88dL/EuZerIcPxdsZemXIn8tDW2orrbI4W5ar+vpRzC+VvfLgd1r84uGX?=
 =?us-ascii?Q?ekBkGzIR2o6Kmyjq7LdTFuQr88tunJmTXygh4ErvmcD6B718ox+uvZxdCdgI?=
 =?us-ascii?Q?4U53t78pRSnw/iTPJUD+jYh/ctxBr4DCQSAwtfSZaN7RX/zVv0UWgZMxsTrh?=
 =?us-ascii?Q?LZef3lElL45Ed+2V3Mm7XE2hsAbtV8y/H3+3yxQ7hYEztO6H4SXljkmhUn7O?=
 =?us-ascii?Q?1EIPI6MHwOv+/hN0nelRw36mM/PzoZ8/S88W7voKKBHdQj6dZaIJTLP7g84v?=
 =?us-ascii?Q?n7Fn9JvnA2dTUBjV3yJ3VzGH9o3wz8DjKgSRfbuYWRRpbr8Xn4tOeHOHjDYq?=
 =?us-ascii?Q?W+JHg8R597Q3qXFks3iGAX+6ji1xwwfEw6yllHOOWqfOFiVt61ef6MluZqCX?=
 =?us-ascii?Q?iLTn0Sst/70Wzv2B0OvZ8OvoX0bZZQZOKp8qgz2mZ6aVxN/g2gaKrmDbR/ul?=
 =?us-ascii?Q?oZU4Y+vqVJXW0cyIDD48lmldne5k5z8CqAc1BuIOgBeD2IWYHbGrIGIwwemZ?=
 =?us-ascii?Q?OAz+CzpGOdJGQxQwtgIsW9nfq5rhKhdHnNRDo6TvJ7wH17R0wB8qfBqeszNY?=
 =?us-ascii?Q?ZGxKxHsZM0/ekFSSjrnv3T0tsWABAaqpei/tP5J2fY971X5F3fu2hCjYWsCX?=
 =?us-ascii?Q?Wd3uIipD+D8r1OP+j+9D4cbBPabFTL4SleGVB4Ck5ief0S5Yo+pHKLmhpawy?=
 =?us-ascii?Q?jtAQOzcy7VfVZ5gjKiXFLO83Zt374iLy2acqhvcniNK+SVXs25hnDZq5bry1?=
 =?us-ascii?Q?obI3zUEoS+xiEq6Q5h5iRdzuVWVABCLcMvjCzjGUnpx+w4E0wvInTU/gio/F?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u/v779cbFlhUBgGB/uEEaicaIGyVyg36nuxokfOARNk6wkidmp7qQ2B6tcQea4e4B1RkgJr42i4qqc+PqXPx9XjLvTmsAdWUT5+ejGvUoJL8WiQKRhIiY/jkHSZpc/eu0MvkoN0Qq/lOOHkm5kVf9hC+eCmknJAU/hFuGO32/JSBzDD9tOEGOx3do8T/d+FauWPekd5Pod0mh5zEaJ95Ypyl6TVrhcv4+/YD3Iu328nNxt/nvksKeOB2gUTuurWk+ijdpc9NL8EsdZxPKAqzG0T2TMHY6IscodeM52bpYtp02JgxZ0MP0AaQV49wDUqp8P9xVs65kZr5VvZJWimW3O/oZQPALDcnygxL4XlOoC7R+xJzZxGjdGvcCgrOBy4ELa9lsVtg6K8Sb8Waw46/y0Fq8KtgSc+DSlAP3kzP/Soz+BFfxIktzNEmifi8aZW6Pq8ZjrNI4iMiSfw9pAADueu/BjeGAIi1hfi2RIYAGl9JfhNF35hSXniq35f/lr94RzQu31Dreg294hGeV4ma23DgxeSUaU0skoTLxKZHQRJvk8DJvK+iafaPIQ4/gZWIuNSfs0U0xf1u0TwVX5K8b54KDDK1foEHSUiHCX5vUVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc465c3-6259-4f1b-26ba-08dd12c882b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:57:35.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTzfGLhV2wNd6dqI5YkBNQWhxdBWJ2zENllJhOovfjRuBCmWMx19iiRysCZbNvBKHTXIr6aFj5B1u19jG8yg7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_08,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020105
X-Proofpoint-ORIG-GUID: N2wBDMftAIU-LhQDO9gOw9gaV5JHdSWr
X-Proofpoint-GUID: N2wBDMftAIU-LhQDO9gOw9gaV5JHdSWr

Make bio_iov_bvec_set() accept a pointer to const iov_iter, which means
that we can drop the undesirable casting to struct iov_iter pointer in
blk_rq_map_user_bvec().

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/bio.c b/block/bio.c
index 699a78c85c75..d5bdc31d88d3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1171,7 +1171,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
 
-void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 {
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
diff --git a/block/blk-map.c b/block/blk-map.c
index b5fd1d857461..894009b2d881 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -574,7 +574,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 	bio = blk_rq_map_bio_alloc(rq, 0, GFP_KERNEL);
 	if (!bio)
 		return -ENOMEM;
-	bio_iov_bvec_set(bio, (struct iov_iter *)iter);
+	bio_iov_bvec_set(bio, iter);
 
 	/* check that the data layout matches the hardware restrictions */
 	ret = bio_split_rw_at(bio, lim, &nsegs, max_bytes);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 60830a6a5939..7a1b3b1a8fed 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -423,7 +423,7 @@ void __bio_add_page(struct bio *bio, struct page *page,
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
-void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
+void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
-- 
2.31.1

