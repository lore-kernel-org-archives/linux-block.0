Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1112F9982
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536701; cv=fail; b=ZRyhHJmX8v0oht9HMxRLz1xFaAcb3/s7Z6IRsbfL+vqOrxa7VhY30W9N6NhpKZK+Ckb0aCou4xkSTHnjzvg6/yBInqOLE8GFPImXQYiOOsRsHLcbxnOdmuK2ETmjfSDyHgb+a7LGu+3llSHZaau6mRjGLQfbhudjscmONcRn7SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536701; c=relaxed/simple;
	bh=qXYXNZIL4+sRjcs+AJhyyswoF1uR8VZJkLD7nVVQ1kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOvyVr4JzdEtiIW7+ZfzjOQc2pxIiGWl9OSo6ApWVGayelA0paY2GmOh5UdRXRMuDKqOm8CwbVNT87pVn5E1e0Zr8mXL3ZsnIMDxfsvVqDwVdeAKpmzJ8FLfTgMiq2qHejjUaobfZufJMN7aHsolgF/hQduPppJHcufAQy0HHGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dgkQnk6i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qvGUfIjp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dgkQnk6i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qvGUfIjp"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NO0G024209;
	Mon, 22 Sep 2025 10:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pQwoX0dzy+b5vVNg5NL54EKEzcyJ1/BuwMNfLTRfnoM=; b=
	dgkQnk6iL+bavrSp7wnzkuDXHKDyVbnDMZjoQ8xoKHlrJxmnhzqMwd8prm79LChk
	7yizRmfIGBAD0yQdDtzPrPZ3BdP+TCGqeiC5vDDSxzr/jUcwwUW7/ha5DAWzFCA6
	7bKNPoRClqH0KDPjXbHZK3CePtH6i92/7G20IDWrI+O0D70ODCTw2DJZF+zfqMpQ
	SzlSM+prGCXJYTlwtG4OQAQ6A59vT4ZRzranxTXT9LEoFmXnfZPn9y2ebko7Wd5m
	Qzirx86+U98jWxBdT6Van2Ci/1+tq2qvcHOmIZkMp8SXU4hfWM/I/PXpBUEVSz5f
	2bn/ttYJaIDIq26Ezeg64Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdj4m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8HAVh026008;
	Mon, 22 Sep 2025 10:24:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6upnk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THRGw8sUYDqHk3OsLKxxoXPL5l502qcUzr0JtZcM4tM9//nPl6lL68NPot1J0I0DDsil0aS3RAKHle7kci09vH9N+bxujjtKZVop7rm1My2ei4HIzPtMNtT5hG9kYkwaFHaJam/sO+pTL3EGccRKf2yGyAjVCpOw05+XoEzJdcOOAoH018Gh+bZHuZWJhCvN8bE0L0V165xX1E0MUVtqqllHtTEaRJqEYVQGmu2zj6VTlOfHrX2TipZ6zvHDW3F7fkTKLKtXALa4fclp+M0zGj19ZHiq+p4n+FzRHOM8IVEefxX0oj/03HuyFjR5U7ujpbBDFnkLHam9jn4x3T6K+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQwoX0dzy+b5vVNg5NL54EKEzcyJ1/BuwMNfLTRfnoM=;
 b=oFuvWvXsuAPmfI+8QzW2IMYqYlOtmXeGvLAxMnqTS4Or/mMz9H6xrBp2szAvUrvjkE+e5MbToAS7yw9QJLOcpAadEbm8jUtQFK0yQMLxdMNm7dyOYyH9u9Lnw5GNylZgCt30KxNxHzVaMTYH5rXdh6E6HOI+ez1QJDO6PMoQVG7dleLBi63ED8Bp/51GJm5jdG5ZiC2yaPERdFp0ZHX03AHMznMMX4nAIMyVrDlpzKgVV5SDOw5gJredP3Y2R7IU12sIfod+uccyhKXNJInpc/FyyASTM8WBXSZlzZNEyV+DgFqJwVnVb5P2mtH1x4XFI6QmRlcxZLBM3Ndg6ATF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQwoX0dzy+b5vVNg5NL54EKEzcyJ1/BuwMNfLTRfnoM=;
 b=qvGUfIjpqhgqzvehPvUCMWlYhWfiGRi1raWEC0lTz25KEhhpgl73r8dMcY413bGi0q94tRpUDLbT5DmaKT4UVWCPTkoeR7NdaX9PVoI1dEXk1ys6k0t5lOUqCFd6TbpPs9pXTGKnskwTV5M24w5Pn09elJsf/ziGYSM2ltYB/hU=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:52 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 5/9] md/002: convert to use _md_atomics_test
Date: Mon, 22 Sep 2025 10:24:29 +0000
Message-ID: <20250922102433.1586402-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0081.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::29) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ef1d18-60b2-4920-e0f7-08ddf9c24419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+eEpXT3A+O2u1iwSYNgwj9p1zl7aTmzG/xpMj4Mb5TvAsQ15BQ7Wv/MBCIq2?=
 =?us-ascii?Q?qQ47LI7ya1dqvbMW8or0B1reZ3fKTDPp0ZY5OHd8daMnbJwd6twYAPnfzwrl?=
 =?us-ascii?Q?EEgyWH8Jo9U81aClXHe/SPgYzAqHYQFhcbHGMVvUslVbtxPqh8BYbbhwRaJE?=
 =?us-ascii?Q?qumOHAX4m6t0AIbTLVdZFd8zOp31MorMOUfE1pg9Ee2lY/ckca01NJTDZjws?=
 =?us-ascii?Q?+idDynRiusizpcZxYudOsr4QBkGn3zLQdzKpTrYDtmpkTUMlbbP+YeFmUV3j?=
 =?us-ascii?Q?t+BBTDTua1Gm1xQSLwu4mwLpQr8Du4By/ap/wdRTkHYWyq49C3Z+RJFNPvNc?=
 =?us-ascii?Q?HdmiRdhCOKetz/wD47HtRiQBG3HS7GxA8NXv6KX3z9un+sAG2Z3bwpccM5qI?=
 =?us-ascii?Q?gVVgAFlAU57Cam2yzr8CN1XsJ745FKjB5h9vVIWO2tU437Dl4GwHMDWX6UJt?=
 =?us-ascii?Q?Z/mQXW7mNnogH4c+waXWIiD/e38IhQUDC3P1ywqWZaJlIDIdlOQsKe2EQ716?=
 =?us-ascii?Q?T+VNF+ZMry/e/+KWm3wSFz5iT+0Bs5tV8RjCXLG73JJdA/Agz8MthDwK84UZ?=
 =?us-ascii?Q?GhbpU+Reg/6elZMl4k8Ufer7nWrqt0Jv9Da96LF9w3Gl8uxXUO110sHPMYJM?=
 =?us-ascii?Q?b2+nSA1BXGGj1c3v2fgeuaOcnCBCDLZA9zukj9c9f1v58brttXZgRn/0C1fc?=
 =?us-ascii?Q?8qkDjr8pl1j37Ra7KoD35uJTuAP9/9b2dI0SET/1nfzkmsDf1G92GBBHWnOW?=
 =?us-ascii?Q?UQ8YS1l5UisdedVdsbx6kK0ErtVUu78RR6TFnDrUhEI9yZjsrMoiDqF6omOg?=
 =?us-ascii?Q?0st8ZaTuWPKf5780Pw3koa6vYcLhrkiUBL9ax64Tq+cJns/bOK3KFtMwjC+R?=
 =?us-ascii?Q?QMJHlXF+eA6Ys2GJxFuApecU3flAVG1WLSkHhgdFThd+fqRyAJoy3Qnokbdv?=
 =?us-ascii?Q?76mw34er9ukUt9dY04C2YVMPfMXxHf+PKok9HrBX0UQ/6sTyjVmKaGTszHrk?=
 =?us-ascii?Q?gJ4r77Dqp7HMhkkBM4H28XIAgPcxAVUPJNC2YY44yw59OmTFgdxc9blGcCF/?=
 =?us-ascii?Q?cLrxokBDOwOXrvkj0CmeyYVhRKyaYtSugD7A7Mbw1+tIU2xtOxmJwUZe5bHf?=
 =?us-ascii?Q?tR7Q7v25e0kwzYsyAg1M/fFfDaBMk+dvkm+6gWV/RC5/5T/xCKw56w4B0Bts?=
 =?us-ascii?Q?NbRAXgfFW99rix3OWqPicslZyjLI9sER6qhbszrYlGr1qV4XOx+3qqKZ+THx?=
 =?us-ascii?Q?A40XhjXhV79qHUcV9BAWNA/+vwWn5IT5m+fr0bfLcKxSKAzrQnoRlDIXFqgu?=
 =?us-ascii?Q?1FoeyZhixBmm7p9wTZQ0RgQcfyOUYOZ5pmKQd1Nfaizy+f9txkn3IDU9sh45?=
 =?us-ascii?Q?1ru/vRzaG3RFcI6ZkQAifrNmvGRVuDVpLKDV0aM5+X1H/IrEpGlU21diW8Kp?=
 =?us-ascii?Q?U9GIXS1t0Dg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Ucu3w5/jhUUQgeCcRCVkjujNETTiyQZ+bvYMQPLBUS+KzPT3U2QqKqxZW2O?=
 =?us-ascii?Q?FeG7fNzdTVJOXmtvxqpqPJL+0NSoE6RySLfkp8EgOlcJJUlVJb0KGz+ZB8ft?=
 =?us-ascii?Q?A7r63QSNGB3lf0x5xBGYWAWjgw3+KMFh/qYBZSIMWShTL1jszeVhMMUr6wrD?=
 =?us-ascii?Q?y8zVtKWVfwro7xJnG3/31jEkjcJPWwgzXjSX+Sd21kOAt29n5OeCVVRHuTcQ?=
 =?us-ascii?Q?S605DXzGI72gQDxStrq5ZIPt3KeExpD7vZhvM11Ldfy58z0ySdT5HqVeqX7Z?=
 =?us-ascii?Q?QzhZMZTF4EWJR28MS24z6xtvx4y38hyJQ3zsM9/TtY3ELOqdm0nMdTxe4Cbp?=
 =?us-ascii?Q?qWgS+BfD2/knlgDhLubJbLfMpeyWQYDYDsWoYk1zBwr2nn9W8GNzvCpCODJ0?=
 =?us-ascii?Q?54Dy6U9Hu7APRIGbKSKuFvEcYN0ZX//eyk7SOVxdro+YdqTtIx/Z+0fgQmtE?=
 =?us-ascii?Q?QVnHZ9xvq7ziqgj+d/lDa6Qvp5jDaLSKNPosWyMdXajFvJh3AJQ3mykM2HQV?=
 =?us-ascii?Q?11k3T53X6uUne2inJHhu/PrPmBy+yIYKk65X6RQvs4MwL94JznynIgtct4oL?=
 =?us-ascii?Q?Sve6PY7jbi1X+wVE4UQevTmBRb5qf+MJk6rJKqZiPVi0KhKUGF8BNJlAWwEv?=
 =?us-ascii?Q?ATz57Pj1zPn13WRzpv2vM32Cnxrh52ZahADmIwRlIZBrD4SqJ2uttkuE/1q0?=
 =?us-ascii?Q?yM3tyHYM/YOAs8nMlPtzflKyqJWqBHa5fsBw/apsps3Ox5JNqMS32cnH6eS6?=
 =?us-ascii?Q?eOHwTjEDx3X1z4tAp0aO+xz7dVRMKYY3z3QVsuPU+cGQv5ydbENcRR6WmCQa?=
 =?us-ascii?Q?qqSTHuHw748jcRfDTS4Qms39kZVVOLrGqms+w4v5UZNsB1FYU0TMRKOtd2gQ?=
 =?us-ascii?Q?iTpRFBtzFWvw260s/FOGxNVzjIIDMmZSLJRi9WSZ6P+3sS9YqP/HtWeQTWu+?=
 =?us-ascii?Q?UGz/WobklZBEHZalSGu0gbTRrxx6HlXZh4jKlfg39QzHAMaE+QzqP5nIS6gb?=
 =?us-ascii?Q?GoIlpPen9qPRr2KA32SaC/5xSqfQ4ZhZVgFkdvmGZaWtlWddDk30zl0AKg2S?=
 =?us-ascii?Q?8ZK71JJPJhqXJHcOmaeaIpt4yqXt/3nS4q+y42FuF6LZlFxPei2Tcq/KfauV?=
 =?us-ascii?Q?cD7w4xGh/kpvbhEPWjsuZ12dxvBGlSJyq+InrSVbTTllYrPT/1qhdi4JtVqa?=
 =?us-ascii?Q?sfLgLJj3BDU7/yWE0J2JzYqP6dJnag85L8ernA22suAcV15JPFf1SvxXuLGO?=
 =?us-ascii?Q?AhqkuuAn3Du+d4AkbcZFyc80h2yYUlqD5TWFoxpsUTxhFXYj3aC/KUCPvgQD?=
 =?us-ascii?Q?3kPW9+cwdFWpytv0rR8dAGdRYERZPCefTT3Bgfe1fjRAFxoAawvHHc+vSDpS?=
 =?us-ascii?Q?+fA921qMYSEoajMbw8AwC0+fmxa4P/By7B6OMwkCDVSCbjiOJdJB9labRRqo?=
 =?us-ascii?Q?V3iRkG1qyc9bPDOKc7Y/pjIYnl7p40cLY0DCQiU5HmJuRyT6T9VV1/PyduvZ?=
 =?us-ascii?Q?jfvvQc4lFHU//9Hj1L3ipVC7dtW4NM5O6R2p7ufFKjFsM9TTT6Uzf/P5Za9e?=
 =?us-ascii?Q?ICWxObMqbYGoZ+mHkZH3I3jStA3aE1aqCY5kBAeIc4FOHAV7RxjvUVXqf9pm?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c3dWkuQGDYKvPYCBt8kZZQH9NpPvRfpF7in3n03vmRIT52PSvO/JtSeJoOw+I6WQhrUXn4CxO93N4rGLrrjirzqiHMwcMOgs2eG742qxPvfTkEdtZ+q0rUI3P4i2sh598a9V9J0ye3/zOZvaDJItlTLcx3zYv0smIFetvhg+iKxIIjVeoxyNW8xrePKK6KGGNCADcJ8l2o+MbTQfoXZrXR7s7mxED4A6mr0FweyOvMz4KtBg5EupcVHVtYZwbQ+jLej0v1zZKKU5vbqaC505GN3WoohdqCDAlQG9GJ7EJTH4/sX/fYC/Lhudfs6w14XNTckLNRZob05FibvIqiIPagn/zVhYtOcMuQyvWiunN2uoi1CP+0WkxYHCSmJmtxxhmAGUPYY5ju+TIquDLDIi1K4E7JvLcbDke7uBXjjtHa5OG0Pl5NwzjbhP5e2JlxzgbRCBei3hiPTSesR7IVcp0oz7E6wbx74Vu+E6MOPP5RsqsucNPU+HzvFZU4XzB6Vr2veyHQHz0xUiwrnmfaJqV2LCzvQuTKij2M0F7mKbVciboaWPWZkelcbVeuCJHNpiX0FnVK5UYQf4EhX1E1TmS0iCJ0TvYzspt2fPOqI0bOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef1d18-60b2-4920-e0f7-08ddf9c24419
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:51.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpZuonbN4kP0GkrBSgWoU9dB01IY7Nccuo5F5uQkmS05/0V5DgJrSh2FWPbXR2f66tMHTJLQVpFXQGjpboB0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-GUID: D5fS-ml4gy7hWtFtubVg8AFNiafX1SLv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX7e9yBqaMyiSD
 O5yO8y0l0e9defjKEB+56zr3Lugkh9gT6kw3T8bqr89rcfGEZYpMSQ0Z5cxgwb5jvxS5t7U2qPR
 g9Jz+MtmxokKIHo9IM/IEGbpK1WNr4p58SWMBbfOKWnWvTUnAkeL5hL0B2LGTk7PHubGiaOqYbZ
 /eEbIR4qSU6Rj+qBwMcp8B1P6j39izNj+HwiXz4gnFBNzkE3+oYTJq99JZ5ZnQ1I1SmyzJZHSMI
 Lu91H1lGjWyRQMpEkvRzHuY6UWR+2oXcoidUXEVOmOBvbIMvf/WLt0O1FSlU0YE3P7kTovErERp
 rN5lo+Wzs/RX9Wgi/TkTjHd7sdfzj4NY5xRwhlDSTMBmHjO1jpT7YGQ8qT8YcVBTI2OYXEcCztm
 x3VOlbHV
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d123fa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=q1clhW5q0aa-2bEoYAsA:9
X-Proofpoint-ORIG-GUID: D5fS-ml4gy7hWtFtubVg8AFNiafX1SLv

_md_atomics_test does even more testing than 002 does now.

group_requires() already requires mdadm, so drop that also.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     | 216 +----------------------------------------------
 tests/md/002.out | 158 +++++++++++++++++++++++++---------
 2 files changed, 120 insertions(+), 254 deletions(-)

diff --git a/tests/md/002 b/tests/md/002
index fdf1e23..3e9c1fa 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -12,41 +12,11 @@ DESCRIPTION="test md atomic writes"
 QUICK=1
 
 requires() {
-	_have_kver 6 14 0
-	_have_program mdadm
 	_have_driver scsi_debug
-	_have_xfs_io_atomic_write
-	_have_driver raid0
-	_have_driver raid1
-	_have_driver raid10
+	_stacked_atomic_test_requires
 }
 
 test() {
-	local scsi_debug_atomic_wr_max_length
-	local scsi_debug_atomic_wr_gran
-	local scsi_sysfs_atomic_max_bytes
-	local scsi_sysfs_atomic_unit_max_bytes
-	local scsi_sysfs_atomic_unit_min_bytes
-	local md_atomic_max_bytes
-	local md_atomic_min_bytes
-	local md_sysfs_max_hw_sectors_kb
-	local md_max_hw_bytes
-	local md_chunk_size
-	local md_chunk_size_bytes
-	local md_sysfs_logical_block_size
-	local md_sysfs_atomic_max_bytes
-	local md_sysfs_atomic_unit_max_bytes
-	local md_sysfs_atomic_unit_min_bytes
-	local bytes_to_write
-	local bytes_written
-	local test_desc
-	local scsi_0
-	local scsi_1
-	local scsi_2
-	local scsi_3
-	local scsi_dev_sysfs
-	local md_dev
-	local md_dev_sysfs
 	local scsi_debug_params=(
 		delay=0
 		atomic_wr=1
@@ -61,188 +31,8 @@ test() {
 		return 1
 	fi
 
-	scsi_0="${SCSI_DEBUG_DEVICES[0]}"
-	scsi_1="${SCSI_DEBUG_DEVICES[1]}"
-	scsi_2="${SCSI_DEBUG_DEVICES[2]}"
-	scsi_3="${SCSI_DEBUG_DEVICES[3]}"
-
-	scsi_dev_sysfs="/sys/block/${scsi_0}"
-	scsi_sysfs_atomic_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_max_bytes)
-	scsi_sysfs_atomic_unit_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
-	scsi_sysfs_atomic_unit_min_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
-	scsi_debug_atomic_wr_max_length=$(< /sys/module/scsi_debug/parameters/atomic_wr_max_length)
-	scsi_debug_atomic_wr_gran=$(< /sys/module/scsi_debug/parameters/atomic_wr_gran)
-
-	for raid_level in 0 1 10; do
-		if [ "$raid_level" = 10 ]
-		then
-			mdadm --create /dev/md/blktests_md --level=$raid_level \
-				--raid-devices=4 --force --run /dev/"${scsi_0}" /dev/"${scsi_1}" \
-				/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
-		else
-			mdadm --create /dev/md/blktests_md --level=$raid_level \
-				--raid-devices=2 --force --run \
-				/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
-		fi
-
-		md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
-		md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
-
-		md_sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
-		md_sysfs_max_hw_sectors_kb=$(< "${md_dev_sysfs}"/queue/max_hw_sectors_kb)
-		md_max_hw_bytes=$(( "$md_sysfs_max_hw_sectors_kb" * 1024 ))
-		md_sysfs_atomic_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_max_bytes)
-		md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
-		md_sysfs_atomic_unit_min_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
-		md_atomic_max_bytes=$(( "$scsi_debug_atomic_wr_max_length" * "$md_sysfs_logical_block_size" ))
-		md_atomic_min_bytes=$(( "$scsi_debug_atomic_wr_gran" * "$md_sysfs_logical_block_size" ))
-
-		test_desc="TEST 1 RAID $raid_level - Verify md sysfs atomic attributes matches scsi"
-		if [ "$md_sysfs_atomic_unit_max_bytes" = "$scsi_sysfs_atomic_unit_max_bytes" ] &&
-			[ "$md_sysfs_atomic_unit_min_bytes" = "$scsi_sysfs_atomic_unit_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $scsi_sysfs_atomic_unit_max_bytes -" \
-				"$md_sysfs_atomic_unit_min_bytes - $scsi_sysfs_atomic_unit_min_bytes "
-		fi
-
-		test_desc="TEST 2 RAID $raid_level - Verify sysfs atomic attributes"
-		if [ "$md_max_hw_bytes" -ge "$md_sysfs_atomic_max_bytes" ] &&
-			[ "$md_sysfs_atomic_max_bytes" -ge "$md_sysfs_atomic_unit_max_bytes" ] &&
-			[ "$md_sysfs_atomic_unit_max_bytes" -ge "$md_sysfs_atomic_unit_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_max_hw_bytes - $md_sysfs_max_hw_sectors_kb -" \
-				"$md_sysfs_atomic_max_bytes - $md_sysfs_atomic_unit_max_bytes -" \
-				"$md_sysfs_atomic_unit_min_bytes"
-		fi
-
-		test_desc="TEST 3 RAID $raid_level - Verify md sysfs_atomic_max_bytes is less than or equal "
-		test_desc+="scsi sysfs_atomic_max_bytes"
-		if [ "$md_sysfs_atomic_max_bytes" -le "$scsi_sysfs_atomic_max_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_max_bytes - $scsi_sysfs_atomic_max_bytes"
-		fi
-
-		test_desc="TEST 4 RAID $raid_level - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length"
-		if (("$md_sysfs_atomic_unit_max_bytes" <= "$md_atomic_max_bytes"))
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $md_atomic_max_bytes"
-		fi
-
-		test_desc="TEST 5 RAID $raid_level - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran"
-		if [ "$md_sysfs_atomic_unit_min_bytes" = "$md_atomic_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $md_sysfs_atomic_unit_min_bytes - $md_atomic_min_bytes"
-		fi
-
-		test_desc="TEST 6 RAID $raid_level - check statx stx_atomic_write_unit_min"
-		statx_atomic_min=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_min")
-		if [ "$statx_atomic_min" = "$md_atomic_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $statx_atomic_min - $md_atomic_min_bytes"
-		fi
-
-		test_desc="TEST 7 RAID $raid_level - check statx stx_atomic_write_unit_max"
-		statx_atomic_max=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_max")
-		if [ "$statx_atomic_max" = "$md_sysfs_atomic_unit_max_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $statx_atomic_max - $md_sysfs_atomic_unit_max_bytes"
-		fi
-
-		test_desc="TEST 8 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
-		test_desc+="RWF_ATOMIC flag - pwritev2 should be succesful"
-		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_max_bytes")
-		if [ "$bytes_written" = "$md_sysfs_atomic_unit_max_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $bytes_written - $md_sysfs_atomic_unit_max_bytes"
-		fi
-
-		test_desc="TEST 9 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
-		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
-		bytes_to_write=$(( "${md_sysfs_atomic_unit_max_bytes}" + 512 ))
-		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
-		if [ "$bytes_written" = "" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $bytes_written - $bytes_to_write"
-		fi
-
-		test_desc="TEST 10 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
-		test_desc+="with RWF_ATOMIC flag - pwritev2 should be succesful"
-		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_min_bytes")
-		if [ "$bytes_written" = "$md_sysfs_atomic_unit_min_bytes" ]
-		then
-			echo "$test_desc - pass"
-		else
-			echo "$test_desc - fail $bytes_written - $md_atomic_min_bytes"
-		fi
-
-		bytes_to_write=$(( "${md_sysfs_atomic_unit_min_bytes}" - "${md_sysfs_logical_block_size}" ))
-		test_desc="TEST 11 RAID $raid_level - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
-		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
-		if [ "$bytes_to_write" = 0 ]
-		then
-			echo "$test_desc - pass"
-		else
-			bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
-			if [ "$bytes_written" = "" ]
-			then
-				echo "$test_desc - pass"
-			else
-				echo "$test_desc - fail $bytes_written - $bytes_to_write"
-			fi
-		fi
-
-		mdadm --stop /dev/md/blktests_md  2> /dev/null 1>&2
-
-		if [ "$raid_level" = 0 ] || [ "$raid_level" = 10 ]
-		then
-			md_chunk_size=$(( "$scsi_sysfs_atomic_unit_max_bytes" / 2048))
-
-			if [ "$raid_level" = 0 ]
-			then
-				mdadm --create /dev/md/blktests_md --level=$raid_level \
-					--raid-devices=2 --chunk="${md_chunk_size}"K --force --run \
-					/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
-			else
-				mdadm --create /dev/md/blktests_md --level=$raid_level \
-					--raid-devices=4 --chunk="${md_chunk_size}"K --force --run \
-					/dev/"${scsi_0}" /dev/"${scsi_1}" \
-					/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
-			fi
-
-			md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
-			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
-			md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
-			md_chunk_size_bytes=$(( "$md_chunk_size" * 1024))
-			test_desc="TEST 12 RAID $raid_level - Verify chunk size "
-			if [ "$md_chunk_size_bytes" -le "$md_sysfs_atomic_unit_max_bytes" ] && \
-				(( md_sysfs_atomic_unit_max_bytes % md_chunk_size_bytes == 0 ))
-			then
-				echo "$test_desc - pass"
-			else
-				echo "$test_desc - fail $md_chunk_size_bytes - $md_sysfs_atomic_unit_max_bytes"
-			fi
-
-			mdadm --quiet --stop /dev/md/blktests_md
-		fi
-	done
+	_md_atomics_test "${SCSI_DEBUG_DEVICES[0]}" "${SCSI_DEBUG_DEVICES[1]}" \
+			"${SCSI_DEBUG_DEVICES[2]}" "${SCSI_DEBUG_DEVICES[3]}"
 
 	_exit_scsi_debug
 
diff --git a/tests/md/002.out b/tests/md/002.out
index 6b0a431..cd34e38 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -1,43 +1,119 @@
 Running md/002
-TEST 1 RAID 0 - Verify md sysfs atomic attributes matches scsi - pass
-TEST 2 RAID 0 - Verify sysfs atomic attributes - pass
-TEST 3 RAID 0 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
-TEST 4 RAID 0 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
-TEST 5 RAID 0 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
-TEST 6 RAID 0 - check statx stx_atomic_write_unit_min - pass
-TEST 7 RAID 0 - check statx stx_atomic_write_unit_max - pass
-TEST 8 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 9 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
-TEST 10 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 11 RAID 0 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
-TEST 12 RAID 0 - Verify chunk size  - pass
-TEST 1 RAID 1 - Verify md sysfs atomic attributes matches scsi - pass
-TEST 2 RAID 1 - Verify sysfs atomic attributes - pass
-TEST 3 RAID 1 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
-TEST 4 RAID 1 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
-TEST 5 RAID 1 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
-TEST 6 RAID 1 - check statx stx_atomic_write_unit_min - pass
-TEST 7 RAID 1 - check statx stx_atomic_write_unit_max - pass
-TEST 8 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 9 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
-TEST 10 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 11 RAID 1 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
-TEST 1 RAID 10 - Verify md sysfs atomic attributes matches scsi - pass
-TEST 2 RAID 10 - Verify sysfs atomic attributes - pass
-TEST 3 RAID 10 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
-TEST 4 RAID 10 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
-TEST 5 RAID 10 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
-TEST 6 RAID 10 - check statx stx_atomic_write_unit_min - pass
-TEST 7 RAID 10 - check statx stx_atomic_write_unit_max - pass
-TEST 8 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 9 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
-TEST 10 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
-pwrite: Invalid argument
-TEST 11 RAID 10 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
-TEST 12 RAID 10 - Verify chunk size  - pass
+TEST 1 raid0 step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 1 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid0 step 2 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 2 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 2 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 2 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 2 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 2 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 2 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 2 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid0 step 3 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 3 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 3 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 3 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 3 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 3 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 3 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 3 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid0 step 4 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid0 step 4 - Verify sysfs atomic attributes - pass
+TEST 3 raid0 step 4 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid0 step 4 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid0 step 4 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid0 step 4 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid0 step 4 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid0 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid0 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid0 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid0 step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid1 step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid1 step 1 - Verify sysfs atomic attributes - pass
+TEST 3 raid1 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid1 step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid1 step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid1 step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid1 step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid1 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid1 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid1 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid1 step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 1 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 2 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 2 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 2 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 2 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 2 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 2 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 2 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 2 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 2 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 3 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 3 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 3 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 3 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 3 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 3 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 3 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 3 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 3 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 raid10 step 4 - Verify md sysfs atomic attributes matches - pass
+TEST 2 raid10 step 4 - Verify sysfs atomic attributes - pass
+TEST 3 raid10 step 4 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 raid10 step 4 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 raid10 step 4 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 raid10 step 4 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 raid10 step 4 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 raid10 step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 Test complete
-- 
2.43.5

