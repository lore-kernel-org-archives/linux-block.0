Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:28006 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754839AbdEYCFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 22:05:04 -0400
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH 00/31] SCSI patches for kernel v4.13.
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
Date: Wed, 24 May 2017 22:04:55 -0400
In-Reply-To: <20170524003420.5381-1-bart.vanassche@sandisk.com> (Bart Van
        Assche's message of "Tue, 23 May 2017 17:33:49 -0700")
Message-ID: <yq1o9uhsnco.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Bart,

> This patch series consists of the bug fixes I came up with during the
> past two months. Please consider these patches for kernel v4.13.

No major objections from me. Although you may have to slice and dice the
series differently so we can get the block bits queued through Jens and
then do the rest as a stage 2 merge.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
