Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34669 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeCNI57 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 04:57:59 -0400
Date: Wed, 14 Mar 2018 09:57:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH V5 2/5] scsi: megaraid_sas: fix selection of reply queue
Message-ID: <20180314085757.GB28983@lst.de>
References: <20180313094243.8710-1-ming.lei@redhat.com> <20180313094243.8710-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313094243.8710-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Same as for hpsa..

Reviewed-by: Christoph Hellwig <hch@lst.de>
