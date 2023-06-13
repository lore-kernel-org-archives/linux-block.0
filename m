Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20598C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 13:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbjFMN0d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbjFMN0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 09:26:32 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABAD1B0
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 06:26:31 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f7373b5499so9289515e9.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 06:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662790; x=1689254790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTZxN5m13ruXfj1B8m/Bn5YhWNHFY++7NFGSmz/Butk=;
        b=UdVacHeCTsIlVAmuqTOfFAi/enm5UIHDXG3pxDZuAtvQuUuLDB9/IYrqJhB5G4DgY3
         W13E7adzccWSLu89/GfiDIhaIELytsn4+USe8BW0/9gnAq/d1IPpE7Cko4ayVaUw6N7f
         wUo3KwXFVYxmkmfIVJqApAAi1oj4Rc5/1o4qLXcpFPEBQxZyARW8FGxn4WQC9b+GRlo7
         K0H3j8mpyw43Guz/A8ugsYG1rGsZ1qLrDm5v6oDtXzccbZ/dsVg4pXotxlXv3aqFBBNX
         KG/pGS1RaUGpOnARV+Eltda+ZxsEH+KxoO3HUcQqlSq6/dPwy+DXvo7lk0+03fw/cu8c
         PTgw==
X-Gm-Message-State: AC+VfDyjtxjyYYp7aOudEAv847mh0xPLhE8lrMbCzvcr5c1NbcXoxKYl
        23lhoFVjbOg25SE2Fmhaj2w=
X-Google-Smtp-Source: ACHHUZ4YWQOvQmvc9An+icPA01JC1DVn5JfT/ZQJz9hAkUTqkSdi8LV739uDhC8WEloaUqseYBzVcg==
X-Received: by 2002:a05:600c:4e01:b0:3f6:c88:c318 with SMTP id b1-20020a05600c4e0100b003f60c88c318mr10343960wmq.4.1686662789691;
        Tue, 13 Jun 2023 06:26:29 -0700 (PDT)
Received: from sagi-Latitude-7490 (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x19-20020a1c7c13000000b003f7aad8c160sm14423161wmc.11.2023.06.13.06.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:26:29 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:26:27 +0300
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Message-ID: <ZIhugyimdWoW7bU+@sagi-Latitude-7490>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
 <c850f479-36b9-3478-6400-95faea095467@grimberg.me>
 <ZIhtJ3PjJYMWXS04@ovpn-8-16.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIhtJ3PjJYMWXS04@ovpn-8-16.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > > index 0eb79696fb73..354cce8853c1 100644
> > > --- a/drivers/nvme/host/rdma.c
> > > +++ b/drivers/nvme/host/rdma.c
> > > @@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
> > >   		goto out_cleanup_tagset;
> > >   	if (!new) {
> > > +		nvme_start_freeze(&ctrl->ctrl);
> > >   		nvme_unquiesce_io_queues(&ctrl->ctrl);
> > >   		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> > >   			/*
> > > @@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
> > >   			 * to be safe.
> > >   			 */
> > >   			ret = -ENODEV;
> > > +			nvme_unfreeze(&ctrl->ctrl);
> > 
> > What does this unfreeze designed to do?
> 
> It is for undoing the previous nvme_start_freeze.

ok.
