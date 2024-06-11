Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2155.outbound.protection.outlook.com [40.92.62.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018764B;
	Tue, 11 Jun 2024 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077940; cv=fail; b=u5T3dQjdKJs0qo/NwFhFzb4BEDwP2A3afpPsKOO7kLzBE9NlkJeyhaYjERBJLRjLNUAg8tNbm7I0qgRoqJa7fHIEQbgEwMT+trHPN2WP4sjD5Be8ctkHecFRdMAOCjRvogZhNcKp8GBG5ki/hyMYbMhBLDJtT/Ha5a6ANUs7Z9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077940; c=relaxed/simple;
	bh=FRineXL3ewsuHRFSCaUZzblmAmpxJIsYLuJy+YE88dI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bsPHV7qn99UN51spVXWpuuL8+ny28FKqPW5QUDwlNc3IkLelIFx4ciYduDt4PeWLUFy5+3WisfTdPSEbF9y6FH9fAcn57kYSbR/j+9hisAevfkF2rSdEVrCvQjTo2Uk4urrR6DEnHvMhntzHTlbzkMxdlRr+MDHJIV2jzCRIweY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kYqshQHG; arc=fail smtp.client-ip=40.92.62.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kYqshQHG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+j9t/1orjc6Vi79Wi5QRA6oV09w48m09Hv0KmAtAkkj77llXIaTAlKVa+o5BuG0xMFMDPCsVq0LtgwJnxNHPVuLrVUJbdTGBswekbvWvwNvC6R3VrAMuJSq7vXctcST+n3f8aKwKXp8shQCmIHly6SBURTKwiRt/Yi3HfXEYROTQNbwnHHI0lzho67lgcN23O8V0e4DEQgIvNmR8HZ1EQn5jYmO8mbZj9sSX2XU95EbtCvNbk/VXSmz9WBeR+v1694TbYlQ/6NMSRzi+nlzPc682JEsKkC1GF/PCftwWXXShUWqU57K/aPv0wRKyZyEpLyZ+R8lhIjjpwccuT5DXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ZAoDwRPI3x/AIyFd0MQa/2e5enD6haWpvBAA21fqA=;
 b=Lczw1JYeNy8Cx/riYOKML1Oc0LoV6yF8mAHzuaj45oYF6ku4cWsi2Mdn/pE7jZ4VftpvFAFJUXUpsAU88IdtQ5suGcRtRCNH0u7vd+E5N7ucm2WrZI7ub4eCuzkDqMGDS4FERiwq8aeg7/586OgCdSicq2RoMiHd+0YBtXZprvBN3P+WYTu9tGiVDFYt753eRc3F/PfujDvLjqKmyF0V9nR6el0sZN77CxdYsuzF7v81yOihWkKkei8GNtZnH4rUDvsPL5bUA8xejUwTbV3zaxPNIyELHU74e48GFVI6CMcARKfRUn7ic20omoDekgqIdvnArcDgj4E1HFz+u6m1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ZAoDwRPI3x/AIyFd0MQa/2e5enD6haWpvBAA21fqA=;
 b=kYqshQHGthKa72gfwUPyiiAjPkRzThVdo/bWGJgVNs0TOa+jivGVfH7HZoyfJmcsvSlbQnjPpgLhNyC5AT/MFA2nm8kbNmB5B/GReX/xqGMocT6K4Gvk/Fv1stepP6qJRTxJgjkFg6C7B6VKA1xTt5TAPi6xm8I7unId/WIoO13UKqrrfXCPZA7znW/VNczpWaUCfQO6PtR4xvazHskjLSCQe47Qm77vUbQovmV4Xg0+NOtA4dMJ9AtHzZKxfR12M8PVQCvkfPIRpYlk9fUsOdoZUdMETeYAk/TE6Mfk9lXg1qLFuWxNN3QPUfMc6Mu7+z8ap+UW9i3/hOsuXdNL1w==
Received: from ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:186::10)
 by MEYP282MB1639.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:52:14 +0000
Received: from ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ef09:453a:38f:15d9]) by ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ef09:453a:38f:15d9%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:52:14 +0000
From: Gui-Dong Han <hanguidong02@outlook.com>
To: justin@coraid.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@outlook.com>
Subject: [PATCH] aoe: consolidate flags update to prevent race condition
Date: Tue, 11 Jun 2024 11:52:04 +0800
Message-ID:
 <ME3P282MB3617DAD141ACDD21170355E0C0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [V3bLihkrbbRRIeXTwI1pdOFhKHVuI9suIqLdPYefBx0YbCPJlk75L/oggdRqhUVC]
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:186::10)
X-Microsoft-Original-Message-ID:
 <20240611035204.9238-1-hanguidong02@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB3617:EE_|MEYP282MB1639:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a579dce-833e-4413-e51f-08dc89c9e19d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3430499023|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	4t3GqZDKo6YqOXgJ90yR1zo5AUiAK8Mbo564BueFANQSNFqxRY/c5xUTt9aIQOT9TRevQuttq/9UVuM92Yc/n3ZF50JQZ26zR1akwZxBZe5BHvGGbi0a8O7ZalxnJR2EJ7WO/52yhEN711DHe9W6ziGfwC4zML9U0UFouabrjbXaSbxgHzuNXuPTLmH7I3Yic1SEcb/zWrQGZtazznVcQTwnMhSsIsr+/SviBkHJBYfvM+OWcwqfZ0HNNkm9QvwgwnsE8XSGEVfN1mp7o0FDeFKw3Kdk33aD34+GPSVBspmW7X3oUX2mtduD9I4fJAjOqtBeIzOvIdgcOXqlJ0ouMlp6QsNJnufV5cDWdX1fcilFzoD1xaIxcNTvGlp8J4164s1z66VRzQTPI+omLMCg9kpI8JeHuSBSltQ/t4kz+j6AOaMpNInbgE2GUOEvrBnOFsjjPhJD++EZA6GuuEU+sp1hUrqe4O3aAIrc9tFCn+zONwAQP4+4u8fh4RZKKTuv014+LKZmfFlOV7UycuDJNIxnHxxbOo+xROHQXbwhSssOXfoAabxZ2HtEEPkek63cnNOwJEzJQTr9V/a+Rtvh7QbxivTetcEr4/zedpdSDnq4ONY3l0Z4Lx5k1Xd/PCGk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DE3LecUxnWuas0fwapjWkRsCZ4u0UtjDR7gSjeHwurki0W3NxJO8dnonzs0I?=
 =?us-ascii?Q?oebkas3AuQfJsfNpF9kJheRmWbm14icQabXzoi1C0UBI5WSbMOaYWZ/dDgPs?=
 =?us-ascii?Q?pv+RObOk/HKXAcR5moAJKRkxt0aChJ9yaE8a9PuRET3BkTfK/3srHtWGsoq8?=
 =?us-ascii?Q?sc5mtXdVRYpLzTDhSd8pdQql9mC/Oky9P1DXmgcnjppkpwFSjHR7DEo1ePMi?=
 =?us-ascii?Q?dz+w5Fss5IyZ10+4onNe+DW1HRZtlwG02JWjHJSKOKuPe4IEiiBIFBZpuAja?=
 =?us-ascii?Q?VRwD+2qsvWWfo0ugCGj9mEpTbL1EgdhFgqozcK5xTwSxRVKBFrLTXkl/c/pX?=
 =?us-ascii?Q?4BvVcTsbKIIBo0p9Ek0JLBldaZVWG9zxkJy2l8FxRCnF0jHO+WJPQuVDTrCG?=
 =?us-ascii?Q?5wYBF1bOIGd9QnM8TswX+SE2yiUqUxnWKoOH6YEzEQSUIRx5T598VHmT0TZu?=
 =?us-ascii?Q?dS8jqNaiCxcp8NR9kxXJflRBGzpgfNBxIuaIKM6Zk3gZG/UcuEeR+9kTd0L4?=
 =?us-ascii?Q?C1vgzqPOEgOkt74OHdgpeH4xNRZ86P84OxqUrgtoOYVhfQr6brMRggd0Ogxu?=
 =?us-ascii?Q?G086E1FQtBWggphmraX0anByXB6AjwIcy4wterzhnRgbwNEBzwmBZQjqK2UD?=
 =?us-ascii?Q?7Afp4dYAB2nPPLcaukugQJl8rOzbMnyw5RNYsD6+sLvOEeOquPzYfM91xWuM?=
 =?us-ascii?Q?ibh0FzOP4UdeyCpghVgiSadl37YCiYVbC7aYwQ/2JquFzGsr9owOe8IxSb2m?=
 =?us-ascii?Q?eb84Bpt9u8SeKQbRH4TfvcFNAZi9F81nmFPW8yO1PKrrzSe3iI1suhdpX6Gd?=
 =?us-ascii?Q?+4RmQDmpAIY6uWcUmZhOSWgCsVNCDTqgOE0ZoMZ7pVxc28ERfgqBvZ+Ae61G?=
 =?us-ascii?Q?3fheiDUBAOSZjSLFw3xvvS0Y/955UyE2w7yBgiXBSlxgzfuSjzCQQvjnOlE6?=
 =?us-ascii?Q?9DlenYpH1bIxev63nqHAGrfvS9lc2ExDU7BJlUr7qoTmsJAhDdAYD8mppLv7?=
 =?us-ascii?Q?mb8OTV+VqwcIF0CSfi7P/9HDmUhk67o6A7Hzx0CA9MkOXQu7FL+1Dvx97V2w?=
 =?us-ascii?Q?HnQc9cv+6ou21HYEvKhn2E1PXwZxDBcNkJRgAlA8ld9puGBLGR/HvJ8n6npR?=
 =?us-ascii?Q?O28i2X6vgwnhaL/ssEaZSAq5mFp2awMUz/3iIx07SQLrQcBkv+cnGcbIPmtt?=
 =?us-ascii?Q?x6nbplfMxj05eRhyCB4YjR8QmYLVmYyrpwzxqzmNVp0SArdyGwbSNf4v+gAv?=
 =?us-ascii?Q?iSSOBO70qa+Bix4ItJ27qJx4C9tOJeYTAwNbOS39yGBg48T7fJjT+95BRDDM?=
 =?us-ascii?Q?JjdqU6hOGR3MBOAjMmykqXSY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a579dce-833e-4413-e51f-08dc89c9e19d
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 03:52:14.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1639

In aoecmd_sleepwork, there is a race condition caused by two consecutive
writes to the 'flags' variable within a critical section. If a read 
operation occurs between these writes, an intermediate state may be 
read, potentially causing bugs.

To address this issue, the 'flags' variable should be updated in a 
single operation to ensure atomicity and prevent any intermediate state
from being read.

Fixes: 3ae1c24e395b ("[PATCH] aoe [2/8]: support dynamic resizing of AoE devices")
Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
---
 drivers/block/aoe/aoecmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index cc9077b588d7..37d556f019c0 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -897,8 +897,7 @@ aoecmd_sleepwork(struct work_struct *work)
 		set_capacity_and_notify(d->gd, d->ssize);
 
 		spin_lock_irq(&d->lock);
-		d->flags |= DEVFL_UP;
-		d->flags &= ~DEVFL_NEWSIZE;
+		d->flags = (d->flags | DEVFL_UP) & ~DEVFL_NEWSIZE;
 		spin_unlock_irq(&d->lock);
 	}
 }
-- 
2.34.1

