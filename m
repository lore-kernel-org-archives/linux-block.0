Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DB7C48BEA
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 14:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiGZOMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGZOMm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 10:12:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DC62F8;
        Tue, 26 Jul 2022 07:12:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QE4JTF006134;
        Tue, 26 Jul 2022 14:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=27D9EdK/99Ms0t5NEsQD5h9XUzjlcfaJezoJmgg1PoA=;
 b=CmPX8lM9rWd7RMFMK/sRpYJyqzZrh/DopTMQUGjARrTwkiW3glvS5cooiD2Xkpla4cOh
 6nsCEM0I1ZYxCkLt7t6vj7cjEMnCuQu/JP7J1xZq0/zcL7XCenO9u9rm9kYerzyBjeII
 BQIFp6TJv7o5vsdEF9rE+hJhUC7jxvxbG6KBDAb8GLDZHYHBGc8Fs+Y8n8lkTx+rYwXz
 EP4AzFFTTMGTj4gmFsDUkliTu2yzpWQG15tuzQSgBH+ZjVM9gw2FWFjh62TPAGMjw2Tk
 ZkzPNXy+I06eoAU0Lydm2IEWHJ9SqGvBjUhptwKnT6kXQi9Oi4p/3uAfR6sy+DXia9Ve Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940pg07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 14:12:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QCQgaE019867;
        Tue, 26 Jul 2022 14:12:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh637txwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 14:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9W1w0RjL5Zcb3PZRZgOcbf+Xgze65eE/kJ2rVP/OG+UqaO+zAN6yu/15VFCMMG9AGjm5lP1ORqJipc6I10OUJnH3I2aTELr8wPUOC1FDXUwEeHfw3TiPIISTQnJaETMwLmXKTPZeFUE2Qhrtcwva+xjdfK1E1H+IuEGcqvzkf4YuHfwUHss6LuWgUR4TZDf/MItebc0+q/SGbHJ5JvqDvuNuODbpsRdj3gGEU3zikKa+LGfrYunSkCY3k2TMsgOat143w3VtBqzsyYpfKRJME10GUnylXCtt3EZuRRRLBsuoYNkqsIUok5KaIheXa25QXg+kQsMkWMKT7+sTdFs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27D9EdK/99Ms0t5NEsQD5h9XUzjlcfaJezoJmgg1PoA=;
 b=gMHNLpXwKcXphnPwVxsUGeKT6kMAdjGOzL1p7if1qLkjgeyqyPN7tvHPIvRDnLuWdNjMhnrj3h/GlcB8WBYcPaJPvGzQh8CFJwHmTLLMMTpXDOqe4xq3Yl44VkRFYxH2ati6B1Vx4vSHcNkG9VclEGfnpm0Q4DDR6Q0oDMGDCt+NxPBdXLbXt9Oy6fE2wVmNcM6gLhC1ebrp2jys01FVfiVJzs/UJ7HBnkfqSrY0f0nGtGocWU5Ww60TbtqF3lKZQHyirc6dVAKBe5Dt70GGN48VibFtdhYzdUmfzm+V6hEoJLRRaGZvE4HkzBWy3lr4a8jbBWTerjAqSrTfZ0uwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27D9EdK/99Ms0t5NEsQD5h9XUzjlcfaJezoJmgg1PoA=;
 b=hPM2ZKLhiL0aB7HVX7kMUFvXKtQlMRWscVa24nOz6l1sqPpbq82nEELEcJMm/732rE/gmSg9zqPkwMrCv2vEkAonp6AgE/cpyfGBUvK63hUQRRaILy0uSK6rsSVaR83mChzuRN1oMya73rRBO1cEnWDx6Uz4ZsuDKE3pdTx8K4g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1271.namprd10.prod.outlook.com
 (2603:10b6:910:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 14:12:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 14:12:33 +0000
Date:   Tue, 26 Jul 2022 17:12:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ublk_drv: fix double shift bug
Message-ID: <Yt/2R/+MJf/MSoyl@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3402da-2957-4940-0736-08da6f10e268
X-MS-TrafficTypeDiagnostic: CY4PR10MB1271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQu7FOgC+C7SJy0u/Snqlf2CmMy72dUSig1SncwJfr47/PnyidimNNMgFPa6cPKlZns7gZQa11BvWl75tIKhxvB/YroMtQ77vNaH249CGrLIYSM8esv76C7ELN6r3/tlLPG47k51MqX6IW21xwSjbh+SV2/oHH7dh4EjNKyyAGvs84g/dZ3Kk81c0K+XKK0z42p0RGForvCC7i8rYvZ7dZ7IwzHvl44fjfZS77KfzRQJ5FZL37k91Xvf0fwj/GlQs6TSSdpdHh83VIm4ahRpxNQnABcu61rXOgPhRBhvvNDARBYaT+0VXlUeAV2FsNVjkXoBvpjeRcCUAz518JT19YLvnIFKUkyi3KS5Z4Nn/YURGHgLdIQtKyxy3FUQWKKeZ1JTSqEn0INFyVDgptmN3WtKX8jTWQq6vN0yfbkdWOP0QYlIcaIb8ddPKx+2nsXGoyr9KzGw2eWtcPcX59FH77sZ4lw2CLnMUj9zagPF++ULtWmpwqB7uKcrKFxEHvK8iemn2svAAtEkYGL694xlJFMCjdvzysDXswDGJjKxFM9FcprM7ow4AY3VADSJzlGylrXi4cPTVgI1b7A55GBU8XhwKV0iqMvwzH6vFkJLgSMSMHJ+8Y8F+BhPZxPTwT65ZpgCHam6x5dBoXb9Hi/9uMjxFEqtzhEz4vEcbVZgYROsu+6ldHcibNP621GCIPSwMK92upVebnytvvUf8eWympbXJoUS7ycGcs44M5yvn2PgMbMiCPP0XNGTzSdgPfKbakBs+ZTdqttz9/NnzNFiU39A8o7qw1MYzovqGlt3yvaGWd4T5lFjbsJ7VSFiwk1I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(376002)(396003)(346002)(366004)(38350700002)(83380400001)(6666004)(2906002)(38100700002)(86362001)(4326008)(26005)(66476007)(66946007)(33716001)(110136005)(8676002)(66556008)(41300700001)(316002)(478600001)(8936002)(52116002)(9686003)(6512007)(6506007)(44832011)(186003)(4744005)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saunf8sRvtFx+H7t9qekTZcBzHHdxw5MUnlMOBOFuH32ekmzF1Bh95TolKT8?=
 =?us-ascii?Q?Rl9cAVWdw3gCNiOStssPN9vFqmV1KhWhHu0iKjem2o/1zSFM0I6dtSM5htux?=
 =?us-ascii?Q?tOmN2HskuCtPeB7IFd0bAVYqZgAIaYcGXq7VOdWCbBgPtwiPBPviwLjE0cqU?=
 =?us-ascii?Q?zpCmmFctcRIlEH7iCjpxldGPIE14Szef7lPLTQdp5Uxj2DuGDZREI4JoXFNw?=
 =?us-ascii?Q?rng+1otcM7R6UR5D8xCe/ho0FFdbhOeHjTMmHFiypZ0hN45Fg+PwoiSXm/Ol?=
 =?us-ascii?Q?CBG9zvitLntCK1bxqRPrkuYuayerE20HZ4HXMTTNecfZE2fCBR7LMHF2OJ5z?=
 =?us-ascii?Q?9i+/9jEr83HLwsGLtTwHDNnqeoqLDAgnSEIumSKo+zaLt+3XmQu4mUchVUfM?=
 =?us-ascii?Q?Idu+w9sNnePaV7ErIvBuv10PSPELsRjqNc3lb+VV2k3cmD781Yn+q6vn0LdO?=
 =?us-ascii?Q?uDZh8foBAHr5k0gh5QtnLmc71L3hwUz2+pGqhmgxRYVp97+HCOAihbH08SKt?=
 =?us-ascii?Q?Hi+1pQY1/0QYhP8i7lvSsRvQPnjm6/HxIvlNcsGzKlK3v5lw18DVupge5uG0?=
 =?us-ascii?Q?hxbUThF408qlI8KtAsU9JEnokTeWIHGmciA2FAJVCFNEEAbMkLIOkoQq3g5P?=
 =?us-ascii?Q?1Ykq7DMlFI/LXr0xCTkEE5U6zm9OOJLdAj3EX4A7jhJ6xkJbnaJH2z9iUrrt?=
 =?us-ascii?Q?oqgudQFK9etfx+6wyFiqO31FsPqkcPLK51mRNc0UJ1ndchX8VyWroiUmp+5D?=
 =?us-ascii?Q?g+4JBj/OxofOp6ye9bqbz752eV522TOUb4PCMxW6YPWe1RSADiQjVecK2+Ft?=
 =?us-ascii?Q?iCXx6gGH8EiQqPnzabUa7I3QZds4qvnaILOubtRTuSjlDeGTO7tZ6LE4edOb?=
 =?us-ascii?Q?P/zBYZS85lkUxaklE77tXnHQOTQz7O11lRgD40tPRr0avMBAC55aOQN+i1nY?=
 =?us-ascii?Q?MU4Fj6DzGxYGWdoZZie4hOQSRxrruLu0Cv00IdHJXB+iWxgXk4fu3RKarnQN?=
 =?us-ascii?Q?6q/BrFBMs5bHJx4TmPozRMV7olY7Yoa6xXLdalR8qTxRn5PEOxP2UHZC1RzY?=
 =?us-ascii?Q?PVA5pMoEQaA9XmyGbfucWnyfCcDjl4caF/hMsFtX1QjrDloDViKLC032pM4S?=
 =?us-ascii?Q?za/yBLhzrrDePjBlum98T5zvtegRrP1o3CxFzZF419xO+AT6/O/Xjmxu8gem?=
 =?us-ascii?Q?ap1kXciDXYDgmL4yTkfebepUx3g3BmGbSQrzJe6Dr16ET95SCJG4TN0+UlY+?=
 =?us-ascii?Q?+EpXA6qfPfMFJi3Ds7OjwxLeduT1UkvNr7kL0rZiMR5bCADQjN9279HoTR8o?=
 =?us-ascii?Q?jjB+6CntmmN1BVEtUM+TzOxavuchzeVhN9UGI9i16VYeTR7ywXh3Y8g6wvuS?=
 =?us-ascii?Q?iZeMPkIz9VnDRzSh5mVx3pYejXyIu5EbdOin1sSYmhbqUQ+5Q6g9PsilohOF?=
 =?us-ascii?Q?WaHZEH84VleXqrhoWDATnsYmE3gKOAtE+8diMSeZy6Wf104CbsBAeDLHUYNT?=
 =?us-ascii?Q?xcq/RRH/X6Q/84U2c33nT6zXwyO2QS4qIgNMQzgsg9DNty8jtzcD03tF+Ug3?=
 =?us-ascii?Q?t8X8L1lDoSaTTr0I6vi3L3ciNrwv/cPq0V7Xg6ojfijWvYdWQ8Hh2EZjaQyE?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3402da-2957-4940-0736-08da6f10e268
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 14:12:33.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxOP8zHOwdHMuIMUeM990J/nUwcul6YL7kQjJ9JeVFdqn6irgis/+a4eIq++D4jUfKR3gAUtbuxuhhqIK3V7IvAqyfE+o7Wou5UwemRjIWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260054
X-Proofpoint-GUID: hx0X6rK9XoLJvxvQpSTusG315RDGmURf
X-Proofpoint-ORIG-GUID: hx0X6rK9XoLJvxvQpSTusG315RDGmURf
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test/clear_bit() functions take a bit number, but this code is
passing as shifted value.  It's the equivalent of saying BIT(BIT(0))
instead of just BIT(0).

This doesn't affect runtime because numbers are small and it's done
consistently.

Fixes: fa362045564e ("ublk: simplify ublk_ch_open and ublk_ch_release")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f058f40b639c..67efad976205 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -124,8 +124,8 @@ struct ublk_device {
 	struct cdev		cdev;
 	struct device		cdev_dev;
 
-#define UB_STATE_OPEN		(1 << 0)
-#define UB_STATE_USED		(1 << 1)
+#define UB_STATE_OPEN		0
+#define UB_STATE_USED		1
 	unsigned long		state;
 	int			ub_number;
 
-- 
2.35.1

