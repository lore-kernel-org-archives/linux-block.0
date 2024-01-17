Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE55660
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465366; cv=fail; b=i2BfJKWMCSPUP64kZrEU1TQaTWv3fKzKLQV8WIi+643qoo+3dPW+XUTOJz8N2JH9kcJ91U9ESxhsnF8VP1Eeyq6bn4C/xRyMp6TFNfFV5rJyZrbjiQ5OuK3iIC1RDf8KSKhDRGhEOEEs0YLujeixwizVNQpffE90YM4XypKf2dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465366; c=relaxed/simple;
	bh=WwF9K/Mll3VUK0MLLxRiTQUM2GYZmNAi9x308+QQrfY=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Q2W8Srtsh3+/+jTewkC1rVe2wRglMXtl1u310TL4b3kGWlW7PfxsECq0sdUJDfeScw0yNEssUyvYXzEPj7L52g912Mzijud7W215T0N8wmZMdBXYe+tL5Sv+He8lWQUmmUoGBmctDCzeVUuYooabMZz7tEP1PRz6EwtLkOr0m9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FRuvgxn0; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FRuvgxn0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBT5QsmShwrErtS4o7vTe/m0HPj0SeLOmPGLFLAi8/F4XIuAF1FXpkwDVIY2/1cfvODpMHZSjfNZBPBH0cOIorC5xbBjKgogjje2M7/86xMtMiL2+nqAnB5DCvr+43I5+eCCYQbJOamoqH7+STotZhZnbvFBij8DNA585kVUKCXURmaQX8nCXYlPEDMa5BHYqyDF71A8wK95GTWENCcWUCMcml4n8fnWz2d+pG4jV4bTB3hsC2HMmR2QaNmwpDkI58mU+dPbKzDwXY5Kqwv1gN5AOE9PsGfExD5x+HiggvXWeBBaDXA5lHnEfISFUC8WLN0weaYTkhgoWxpGki35hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwAGAnffdUSvIy1baTVaOMwtuUT407Z8aVjSz0F0Zu8=;
 b=TJFxHzCksJppV12LT0eX6nO6u39QUy+zeKU6i5InrSGKjH0RXUfsaFolhBt5ia8i+cHhFiEB9PLydkCstWIPLY3VWVKhdIEjbuFYuidSzQzJUR7xoXX5745o8wtk6wLS1aaHh/aGgZLRZOm1u3RAFCA6MqPj+hCRllp8Yhd7po2wFTgIw6OJhHBa/DmIg7KGrysBNZ8lzoqTB7CPlYcCp6Z3IvJvyzIsoPrgExG7EwH7gVAkscdAUcUMWEOa6MAQtH1l0dUZdjQDaFa3s7PX1lP7dG+g2ar6D1XKF3RQStUlysCVRVqRnpOaQaDSlZTpbjjKyLR/ja8ztR49jTcmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwAGAnffdUSvIy1baTVaOMwtuUT407Z8aVjSz0F0Zu8=;
 b=FRuvgxn0GQmPdVp5JUe/bTc5q3t3hTvfJ6wvabTO9DR5lDYm+vZS+C/KJ0c6nYBNWmYC0JU6wRkSk8v3B0wR2FlIdqaJTy1dH1x9OKnInxKEbEFWCiD7EAEuAL1v+DSz7bD4E5Hfiu3NyL4yjVd4S1AhyQolEdrgUtvm+32YtGdF2fKqqREvw+De/VysdKl9xLKYcnwdhX07LfkM3MfwK6VV0Z+JgKrNYfhDOXEITs5tqkOy8Sn9kJ3kV4WAUlgTnuNfYU6ynjJ9UWOIoq8sIJQNA1lN0J9q2B91R7YXytt+co1l+TWCiD4bdoKwxDK63Av5kz0Kk12zQxriSW3lpw==
Received: from BY5PR17CA0038.namprd17.prod.outlook.com (2603:10b6:a03:167::15)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 04:22:39 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::ec) by BY5PR17CA0038.outlook.office365.com
 (2603:10b6:a03:167::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29 via Frontend
 Transport; Wed, 17 Jan 2024 04:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 04:22:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 20:22:18 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 20:22:17 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests V2 0/1] nvme: add nvme pci timeout testcase
Date: Tue, 16 Jan 2024 20:22:05 -0800
Message-ID: <20240117042206.11031-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0f202b-ac89-4f38-dcea-08dc1713f060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lR6d2qM7coCqJSmpl3rUZzf2P7S6NhKJyxMX2W3CNif8dXsh1K8tS03CGjcyWtBWhDeGvtwWgtcMRt2iMjUW4Xfd7UBL1w28oErNGqsCs2wMVyy/Xj9RrdkQGYk6DBex4x6xC1J+bCETT+o83oK1mwyhg34WuNxa6KmOLxHxRrb2DIntx8fXGh6C5WQsN/eRCACW+8f7e4PTWe6u2QAi7vewS9FvPhrwwBczOcfP84bNNVP4D9AkwJAqxulNdYpFEycSttCeH3ECyd0yhfaREQLmWJUfaq1DRIqVXN09mEP4FDpe3UV39ZdyVbyXzXlcCDvOXAaKbzOQJ2HVNrBTiIzw7FTV+ptKQx+5kqNWwq/5R4zpSwFoPvsxfTAhrJkNhxTQk5pa3ovvF2PEL2X2LfFexj1/XiD1+tja3iwshLU5iSJKiYbXWySOekpS55zZKYUCmrw0qHeYaTVQhlspnjrFNbhQEfRhe9r5uV8c2ry/5TEOuwdoPuoJBqlxONJMKhl54AVz/8ieDIEMuEJhPQpwcxH7hBFE3KbrIBTopQviuCgFcosWjC3uwTnpDgf+7ul+RjCDcbeSUvUB1j/Z4tZg/GhuB+ipp1p3ZoWr2NSKIBKH5bM44gZDrlsnLqub66DnGv7aW1Hd+awSvf3JFWXiNtPQBtcqbahoNouXKRK6YNiED93OgG+QCEXty4ipgh9eOOBSHHFrpqYtVWc8+g7T74xrbNSucvzS72eCQWOdEzsi3fKZXyEvbPqWmg4A
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(82740400003)(356005)(7636003)(47076005)(83380400001)(36860700001)(36756003)(316002)(110136005)(70586007)(54906003)(70206006)(5660300002)(2906002)(4744005)(4326008)(8936002)(26005)(336012)(1076003)(2616005)(426003)(16526019)(107886003)(478600001)(7696005)(6666004)(8676002)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:22:38.2902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0f202b-ac89-4f38-dcea-08dc1713f060
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

Hi,

Add a test to trigger nvme pci timeout handler function

Below is the test log.
	
-ck

Change log :-

1. Use test_device() and TEST_DEV.
2. Make tesctcase pci only just like in nvme/032.
3. Remove . from copyright and test description.
4. Add _have_kernel_option FAIL_IO_TIMEOUT.
5. Save and restore fault injection settings.
6. Use "$(nproc)" to get rid of shellcheck annotation.
7. Don't remove the device keep it as it is, add module remove testcase later.

Chaitanya Kulkarni (1):
  nvme: add nvme pci timeout testcase

 tests/nvme/050     | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |  2 ++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/nvme/050
 create mode 100644 tests/nvme/050.out


blktests (master) # modprobe  -r nvme
blktests (master) # modprobe nvme
blktests (master) # TEST_DEVS=/dev/nvme0n1 nvme_trtype=pci ./check nvme/050
nvme/050 => nvme0n1 (test nvme-pci timeout with fio jobs)    [passed]
    runtime  90.854s  ...  91.087s
blktests (master) #

-- 
2.40.0

