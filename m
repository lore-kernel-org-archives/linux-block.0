Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/13] scsi/osd: don't save block errors into req_results
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170526085620.3113-1-hch@lst.de>
	<20170526085620.3113-3-hch@lst.de>
Date: Fri, 26 May 2017 16:24:42 -0400
In-Reply-To: <20170526085620.3113-3-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 26 May 2017 11:56:09 +0300")
Message-ID: <yq17f13qsc5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> We will only have sense data if the command exectured and got a SCSI
> result, so this is pointless.

"executed"

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
