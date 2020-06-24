Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6162FC433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 23:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F480206DD
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593042872;
	bh=zhzvxKTu4Nos4Vq0enqy8sI8qgZX/6cGhDrBlOn5kLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MVfRzVnIxSmmHBN8ttr2fp9aw8+7iheztCWhoBfIN4LeqnMdHmxZokDXayNEK6NjK
	 LohSY8oe2ceCUqIV5GNZ2Tq3H62F+Wji71jo/p8dZ4Q2swguQghgeKcVw03AgHcM8h
	 AByqaZ13cK02lSr4m92XOINjJuwVL2ntCvuM3CnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbgFXXyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbgFXXyb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 19:54:31 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1146C20672;
        Wed, 24 Jun 2020 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593042870;
        bh=zhzvxKTu4Nos4Vq0enqy8sI8qgZX/6cGhDrBlOn5kLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTBrvB//Chcl+4aOUwFZkNN6jEygPOAVqVE3jDkhvWuj/8P7eQz8wCoHD+5FXaqN5
         ECxCplqFy2+WEILh6z6W12J2WHdbSBkIm6eOSH5C9wKzqqn1Fp8xnKXG/uyVklaNbV
         jQgpTSD8/0ObCt7vXf6GueBBrr3FcEQyOJAfTnAw=
Date:   Wed, 24 Jun 2020 16:54:28 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Message-ID: <20200624235428.GH1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
 <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <c217a3a9-990f-b134-b3d5-ea719d9e2062@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c217a3a9-990f-b134-b3d5-ea719d9e2062@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 03:54:05PM -0700, Sagi Grimberg wrote:
> The code needs to be:
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2afed32d3892..3e84ab6c2bd3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl
> *ctrl, unsigned nsid,
>                   * Don't treat an error as fatal, as we potentially already
>                   * have a NGUID or EUI-64.
>                   */
> -               if (status > 0 && !(status & NVME_SC_DNR))
> +               if (status > 0 && (status & NVME_SC_DNR))
>                         status = 0;
>                 goto free_data;
>         }
> --

Aha, I was assuming the code was the way you wanted it, hence my
confusion :)

The above makes sense walking through different scenarios. I needed
to reconcile this in order to understand how we'll address it with
Nikla's patch that start this conversation.
