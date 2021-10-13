Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9482FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E80E608FB
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJMFA2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:00:28 -0400
Received: from verein.lst.de ([213.95.11.211]:44127 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhJMFA1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 01:00:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA99E67373; Wed, 13 Oct 2021 06:58:22 +0200 (CEST)
Date:   Wed, 13 Oct 2021 06:58:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
Message-ID: <20211013045822.GA24761@lst.de>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I like this in general, but some comments below:

>  	cmnd->rw.opcode = op;
> +	cmnd->rw.flags = 0;
> +	cmnd->rw.command_id = 0;

The command_id is always set in nvme_setup_cmd, so no need to clear it
here.

>  	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
> +	cmnd->rw.rsvd2 = 0;

There should be no need to clear this reserved space.

> +	cmnd->rw.metadata = 0;
>  	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
>  	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
> +	cmnd->rw.reftag = 0;
> +	cmnd->rw.apptag = 0;
> +	cmnd->rw.appmask = 0;

All these PI fields are reserved when PI isn't enabled using the control
field.  So I think we can stop clearing reftag here entirely, and move
clearing the apptag and appmask down next to the reftag assignment.

>  
> +static void nvme_clear_cmd(struct request *req)
> +{
> +	if (!(req->rq_flags & RQF_DONTPREP)) {
> +		nvme_clear_nvme_request(req);
> +		memset(nvme_req(req)->cmd, 0, sizeof(struct nvme_command));
> +	}
> +}
> +
>  blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>  {
>  	struct nvme_command *cmd = nvme_req(req)->cmd;
>  	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>  	blk_status_t ret = BLK_STS_OK;
>  
> -	if (!(req->rq_flags & RQF_DONTPREP)) {
> -		nvme_clear_nvme_request(req);
> -		memset(cmd, 0, sizeof(*cmd));
> -	}

The nvme_clear_nvme_request is not done unconditionally for the read
and write commands below, which does the wrong thing.  So I think we want
to keep it here and just move the memset.

I think the best way is to split this patch into two:

  1) remove the memset here and do it unconditionally in the individual
     nvme_setup_* handlers, and document there why the extra memsets don't
     hurt (no partial completions unlikey SCSI)
  2) optimize the read/write case
