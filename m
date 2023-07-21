Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A13EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 08:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGUIt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGUIt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 04:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9122D5E
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689929347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rIuqhH6IY8ONncAtN7QDgruUel+r3gNk5xnCvWyYpDA=;
        b=SS8yxxQ3TpLcj0WI02iaN3UM4w6VECUNSApzVIfhAhsFMgtu8qgH3eScfg1wKlEctqBGJq
        OipP9vjZUeuh4vi8DAHVedd0Y5ILCmCqiDKtG5Xs2U1O8la/hRQV0klalXT2p7LZ1JWS8X
        acnMVkDN9na2Uz9CSVF20hvdtJUji0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-7BJI8WwOOCGkGhdT2d1gVA-1; Fri, 21 Jul 2023 04:49:03 -0400
X-MC-Unique: 7BJI8WwOOCGkGhdT2d1gVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 531D3936D27;
        Fri, 21 Jul 2023 08:49:02 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F57F40C206F;
        Fri, 21 Jul 2023 08:48:55 +0000 (UTC)
Date:   Fri, 21 Jul 2023 16:48:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Justin Tee <justintee8345@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: Re: [PATCH 3/8] scsi: lpfc: use blk_mq_max_nr_hw_queues() to
 calculate io vectors
Message-ID: <ZLpGcJbCFyK0vB4+@ovpn-8-26.pek2.redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
 <20230712125455.1986455-4-ming.lei@redhat.com>
 <CABPRKS9WPBq1R9EH39=8vCAcW0+0YDAuYKRtEU9ck=BRfZKo1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPRKS9WPBq1R9EH39=8vCAcW0+0YDAuYKRtEU9ck=BRfZKo1w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 12, 2023 at 05:03:19PM -0700, Justin Tee wrote:
> Hi Ming,
> 
> A few lines below in if (aff_mask), vectors can be overwritten again
> with min(phba->cfg_irq_chann, cpu_cnt).
> 
> Perhaps we should move blk_mq_max_nr_hw_queues min comparison a little later:
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 3221a934066b..20410789e8b8 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -13025,6 +13025,8 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
>                 flags |= PCI_IRQ_AFFINITY;
>         }
> 
> +       vectors = min_t(unsigned int, vectors, blk_mq_max_nr_hw_queues());
> +
>         rc = pci_alloc_irq_vectors(phba->pcidev, 1, vectors, flags);
>         if (rc < 0) {
>                 lpfc_printf_log(phba, KERN_INFO, LOG_INIT,

Hi Justin, 

Indeed, will take it in next version.

Thanks,
Ming

