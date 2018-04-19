Return-Path: <linux-arch-owner@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] storsvc: don't set a bounce limit
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180416085032.7367-1-hch@lst.de>
        <20180416085032.7367-3-hch@lst.de>
Date: Thu, 19 Apr 2018 00:29:52 -0400
In-Reply-To: <20180416085032.7367-3-hch@lst.de> (Christoph Hellwig's message
        of "Mon, 16 Apr 2018 10:50:22 +0200")
Message-ID: <yq1d0yvlsxr.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


Christoph,

> The default already is to never bounce, so the call is a no-op.

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
