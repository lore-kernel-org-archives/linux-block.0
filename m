Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA51AC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 23:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiI1Xki (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiI1Xka (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 19:40:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E206950063
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 16:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL4nhoBmLeN9Zk11yPxAGfY8YQgVJkikoDv57WTAIC499mSHcxOxfxzH9cocYzzNTLI1WZov161t5CPWrSTvwfMNoTciMIWQFd1WW6DJEiQKWbWjiJa6setCf6W0wLNtjeyDJtrWkd+EHw+nobM0wi7mZ7ZnO04AaaKOVkEh5H7FBoRXW6Tgnb7TfAullzDhykEvPmlEFVjjb+kHOkykkQNBQ4IobrchpUXR6w0LBw/L9ZNswAJdNd5dPESSwIlIlW1noxZ3VlhwkaNg8Qh96rygLL1mIrvxv2tD0BwPyOcIyW8MLEY2H0gv56BzmdyezKNyNu4Eh7sPePEPazGy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6/Pp4M/p7kThhVmY/N3V6NrSe32mAiEyO1qRze4AQ8=;
 b=RzkIR9dk/CxGMaiy/m9xABOgAymCC3h/l/RipmADnS3h6uHv3kNY5T/G27fSSygGOllJpRWe1DPvF4fGd/XSRVB6RWBzYHeGc5l2AO7j3xdjYRgDHHcGw8eHkzUzqDkhOd5VNXeoPweJ/48kT5PdTgDDnkX8SexkdOOrnM0KeaQNkjG4XB0CrC7ItcKyzmiRuGr2XWfmpfztplpr0ziqDWrWJ7yABK7dQPyrmc5SKDXQs0gQNWV2omKS1c3foIYH+jCFSOwwfa5il6JyAHNx5Abg6FnUfsrIbFPqcZdzmBycE8fIYWS6xAiX5+pJu0Mbsq0jYnn8IXeL9FmciU3fGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6/Pp4M/p7kThhVmY/N3V6NrSe32mAiEyO1qRze4AQ8=;
 b=YSKd5+JB8hdtw8BDeo4ifQomM1IQ37rETdRxcUZr5SAdIh8i+KO850eMQKW6fd6m+nIbTwkKc1teP4hvdF7gR3163pAsRmJOAH8jQMD3HvDcnfSijuIwPgwWKclCaVWsYUYvlW7Gbmohyo/Qh3GQTtZEFUvwosw50hhxz0ySpFnMmlJAjKhOOjJg/MYc9cAgOhabVx9DSAv9/5IvfQ+0ZP9uSkxMzxhBeqxwAvP5yVwML0B0VCxlfcixY1sNeusQin5VrAVHIPDEIk3x6V/vkITSQpsJerpdrlkEThImJiolziMptC86Jso5O6n1f+VB2U30hxa/1X2YplKZ6WfX/Q==
Received: from BN8PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:70::41)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.16; Wed, 28 Sep
 2022 23:40:26 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::4d) by BN8PR04CA0028.outlook.office365.com
 (2603:10b6:408:70::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 23:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 23:40:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 16:40:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 16:40:11 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 16:40:09 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <mst@redhat.com>, <stefanha@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-block@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Date:   Thu, 29 Sep 2022 02:40:08 +0300
Message-ID: <20220928234008.30302-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|CH2PR12MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 306f2c9c-d10f-4eac-ba47-08daa1aad1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1Dimv9MJBxeqjJZa/fNuVVzpcy6lEUvx2T6+0zMHlNYHhGAkSl/HRNPb3QEb8qy2nPwE+tg+YP2dVtYkOzDl8ITt/ywS7iX9CaF7pSnvVE47a+zwiW47c2IGqGhacevXEZRSnxfcR/1b3iPeJ91V+5UDH/YYad7/jaxqF1dmqplguuxIVT/NSJVrZwRzSJk2hWk3eKFL9gfMx/Li6AphRffVKkf6dt2EnlYSzW4S8OwCvlVX6hnLAX1n0OnL+L7oOLASEL1iNbtT334TyJVS0sksCAhoRYvfHZLqh1iTX4HtYxh/UHCsq5jj2xmY67/Al3K95i+R7BderMtl/QYMFD5SxnyUTkC3417l1dPmL1i4gLoEA/xDJHfT0Wd86I+D/uTrF6CzRSg3MmYo+xdLaZoDQXmZbnwyu8J1pRagvua6HuOhDS2tshYSmEEMJKIPBQG8PzjJsv+gZLEJoIsiab4iVXH7SbWdFC8Ni5nUgOChGyIddhSt/exS2dD9twAKP24QSnaH7x2x//YAlDAsthQ4qkrftE2/ZGrQVLhW8uTH6K9yjFeycQAVjixcBBisMHMPZ7nZ7TB2QcEttCIPtWHjp/eJfSOLWTURBK48VQ5H8IwFR0oL9eodOCMjZAbwqTt9Kgu+u6lKxIYg/39CZmHsliLdBBVKvUsr69svefUPxD4DzwGwPHQbdPtOf5KA+1l2FQ4VU+eHMrtuPTATwEMID9XygLtE+Rv1CSWyY9/orQNFTnFP6+gtPFDeI0jjSvhQSwrl1kNjKBLKPhYlQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(40480700001)(1076003)(36860700001)(426003)(336012)(186003)(70586007)(70206006)(86362001)(5660300002)(356005)(54906003)(107886003)(2616005)(110136005)(8936002)(36756003)(316002)(26005)(4326008)(82740400003)(82310400005)(8676002)(478600001)(7636003)(40460700003)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 23:40:26.0813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306f2c9c-d10f-4eac-ba47-08daa1aad1ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is instead of re-writing the same logic in virtio driver.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index ad258a9d3b9f..67d3970e57f2 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -607,7 +607,6 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
 {
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 	struct virtio_device *vdev = &vp_dev->vdev;
-	int ret;
 
 	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
 		return -EBUSY;
@@ -615,19 +614,7 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
 	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
 		return -EINVAL;
 
-	if (pci_vfs_assigned(pci_dev))
-		return -EPERM;
-
-	if (num_vfs == 0) {
-		pci_disable_sriov(pci_dev);
-		return 0;
-	}
-
-	ret = pci_enable_sriov(pci_dev, num_vfs);
-	if (ret < 0)
-		return ret;
-
-	return num_vfs;
+	return pci_sriov_configure_simple(pci_dev, num_vfs);
 }
 
 static struct pci_driver virtio_pci_driver = {
-- 
2.18.1

