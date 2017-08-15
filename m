Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:34739 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdHOC6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2017 22:58:32 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] Revert "scsi: default to scsi-mq"
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170813174422.16197-1-hch@lst.de>
Date: Mon, 14 Aug 2017 22:58:23 -0400
In-Reply-To: <20170813174422.16197-1-hch@lst.de> (Christoph Hellwig's message
        of "Sun, 13 Aug 2017 19:44:22 +0200")
Message-ID: <yq1lgmlwn8w.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Christoph,

> Defaulting to scsi-mq in 4.13-rc has shown various regressions
> on setups that we didn't previously consider.  Fixes for them are
> in progress, but too invasive to make it in this cycle.  So for
> now revert the commit that defaults to blk-mq for SCSI.  For 4.14
> we'll plan to try again with these fixes.
>
> This reverts commit 5c279bd9e40624f4ab6e688671026d6005b066fa.

Applied to 4.13/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
