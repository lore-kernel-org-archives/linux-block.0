Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7895C18E5B
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340D2073E
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584374550;
	bh=F3uFtZA2u8ZRQ54n1OuUoE9Ws/+UJuLW87tZNfqbDos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z+uRDejJMUeD6LQNRiJFrNMry3w37YUatoJUWjoLu4QxwcOczfK4EqbA/2RJdSSqx
	 9up0VzZ02W2DhuWlxgD7E9igVi/bPVHPEyURbQXIgp+31wh+LmbjgMDfRlgiVUdjxb
	 WQBMwyctPxW1ZfXWu5WLTxyS6qsL9jF2e9RLoopQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbgCPQCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731618AbgCPQCa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 12:02:30 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219E020736;
        Mon, 16 Mar 2020 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584374549;
        bh=F3uFtZA2u8ZRQ54n1OuUoE9Ws/+UJuLW87tZNfqbDos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqz3GvQqTBL2dU+QJb2MnA1FFWV/CZV4h+o8R7j7teKy/OCVNsG562uC14dWiMYge
         +YpMv1Bi2ZL/Wy5jIHygei+WetIpfjxtMmLere6GrFeZC2fL67fqi1qYsSJLxR5AKe
         R8zCSrCShvusq04uEtBmq+7zQ5MgOreeT9txK5Rk=
Date:   Mon, 16 Mar 2020 09:02:27 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nbd: make starting request more reasonable
Message-ID: <20200316160227.GA1069861@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200303130843.12065-1-yuyufen@huawei.com>
 <9cdba8b1-f0e5-a079-8d44-0078478dd4d8@huawei.com>
 <20200316153033.GA11016@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316153033.GA11016@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 16, 2020 at 11:30:33PM +0800, Ming Lei wrote:
> On Mon, Mar 16, 2020 at 08:26:35PM +0800, Yufen Yu wrote:
> > > +	blk_mq_start_request(req);
> > > +
> > >   	if (req->cmd_flags & REQ_FUA)
> > >   		nbd_cmd_flags |= NBD_CMD_FLAG_FUA;
> > > @@ -879,7 +881,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
> > >   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> > >   		dev_err_ratelimited(disk_to_dev(nbd->disk),
> > >   				    "Socks array is empty\n");
> > > -		blk_mq_start_request(req);
> 
> I think it is fine to not start request in case of failure, given 
> __blk_mq_end_request() doesn't check rq's state.

Not only is it fine to not start it, blk-mq expects the low level
driver will not tell it to start a request that the lld doesn't
actually start. A started request should be completed through
blk_mq_complete_request(). Returning an error from your queue_rq()
doesn't do that, and starting it will have blk-mq track the request as
an in-flight request.
