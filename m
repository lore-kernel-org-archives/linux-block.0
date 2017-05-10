Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35883 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdEJOjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2017 10:39:08 -0400
To: wenxiong@linux.vnet.ibm.com
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com,
        dougmill@linux.vnet.ibm.com, axboe@fb.com
Subject: Re: [PATCH] blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error on dd with split op
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1494424451-856-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Date: Wed, 10 May 2017 10:39:01 -0400
In-Reply-To: <1494424451-856-1-git-send-email-wenxiong@linux.vnet.ibm.com>
        (wenxiong@linux.vnet.ibm.com's message of "Wed, 10 May 2017 08:54:11
        -0500")
Message-ID: <yq1lgq4pyii.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


wenxiong@linux.vnet.ibm.com,

> When formatting NVMe to 512B/4K + T10 DIf/DIX, dd with split op
> returns "Input/output error". Looks block layer split the bio after
> calling bio_integrity_prep(bio). This patch fixes the issue.

Looks good.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
