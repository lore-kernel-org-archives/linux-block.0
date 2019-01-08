Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB20C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4687020883
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfAHVZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:25:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfAHVZ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 16:25:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AF58C065F95;
        Tue,  8 Jan 2019 21:25:28 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18F101001F5E;
        Tue,  8 Jan 2019 21:25:27 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        james.smart@broadcom.com, dick.kennedy@broadcom.com
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling scsi_add_host()
References: <20190108205043.3122-1-logang@deltatee.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 08 Jan 2019 16:25:26 -0500
In-Reply-To: <20190108205043.3122-1-logang@deltatee.com> (Logan Gunthorpe's
        message of "Tue, 8 Jan 2019 13:50:43 -0700")
Message-ID: <x49imyy7sft.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 08 Jan 2019 21:25:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Logan Gunthorpe <logang@deltatee.com> writes:

> scsi_mq_setup_tags(), which is called by scsi_add_host(), calculates
> the command size to allocate based on the prot_capabilities. In the
> isci driver, scsi_host_set_prot() is called after scsi_add_host()
> so the command size gets calculated to be smaller than it needs to be.
> Eventually, scsi_mq_init_request() locates the 'prot_sdb' after the command
> assuming it was sized correctly and a buffer overrun may occur.

[...]

> To prevent this, the calls to scsi_host_set_prot() are moved into
> isci_host_alloc() before the call to scsi_add_host(). Out of caution,
> also move the similar call to scsi_host_set_guard().
>
> Fixes: 3d2d75254915 ("[SCSI] isci: T10 DIF support")
> Link: http://lkml.kernel.org/r/da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Intel SCU Linux support <intel-linux-scu@intel.com>
> Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jeff Moyer <jmoyer@redhat.com>

Nice job, and excellent commit message.  We'll need a similar patch for
lpfc.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

> ---
>  drivers/scsi/isci/init.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
> index 68b90c4f79a3..1727d0c71b12 100644
> --- a/drivers/scsi/isci/init.c
> +++ b/drivers/scsi/isci/init.c
> @@ -576,6 +576,13 @@ static struct isci_host *isci_host_alloc(struct pci_dev *pdev, int id)
>  	shost->max_lun = ~0;
>  	shost->max_cmd_len = MAX_COMMAND_SIZE;
>  
> +	/* turn on DIF support */
> +	scsi_host_set_prot(shost,
> +			   SHOST_DIF_TYPE1_PROTECTION |
> +			   SHOST_DIF_TYPE2_PROTECTION |
> +			   SHOST_DIF_TYPE3_PROTECTION);
> +	scsi_host_set_guard(shost, SHOST_DIX_GUARD_CRC);
> +
>  	err = scsi_add_host(shost, &pdev->dev);
>  	if (err)
>  		goto err_shost;
> @@ -663,13 +670,6 @@ static int isci_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			goto err_host_alloc;
>  		}
>  		pci_info->hosts[i] = h;
> -
> -		/* turn on DIF support */
> -		scsi_host_set_prot(to_shost(h),
> -				   SHOST_DIF_TYPE1_PROTECTION |
> -				   SHOST_DIF_TYPE2_PROTECTION |
> -				   SHOST_DIF_TYPE3_PROTECTION);
> -		scsi_host_set_guard(to_shost(h), SHOST_DIX_GUARD_CRC);
>  	}
>  
>  	err = isci_setup_interrupts(pdev);
