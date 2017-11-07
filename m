Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] scsi/ipr: Use sgl_alloc_order() and sgl_free_order()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171103222339.26540-1-bart.vanassche@wdc.com>
	<20171103222339.26540-7-bart.vanassche@wdc.com>
Date: Mon, 06 Nov 2017 22:44:44 -0500
In-Reply-To: <20171103222339.26540-7-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Fri, 3 Nov 2017 15:23:37 -0700")
Message-ID: <yq1k1z23g7n.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> Use the sgl_alloc_order() and sgl_free_order() functions instead of
> open coding these functions.

I'll merge patches 6-8 once the plumbing goes in.

-- 
Martin K. Petersen	Oracle Linux Engineering
