Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7833BC61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2D12087E
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 09:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZMLkHu12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfASJ4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:56:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfASJ4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 04:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SE4Od1c/hvwKmZIXcwElOSxwgZwwVR53Yxhyw934rAA=; b=ZMLkHu12Q+If8pmrhH7xCX+1B
        lnB14AwgW5UP7R57fEnN+UXu61IjWOWPBVSenam9e03nO3ecJCGXiBosJtBy2CV8Qw6DgWe7NUabQ
        fBXQweWrfz6yVg1+1ZJPkyWLG3ARgQsrEnxFoXr9Cq1nygRjtWCJ0T/ctaIfas0SNQ8wVAIxR5Z8l
        YuCDNealZtbhnYWB0MwXB12K/X7gNNPHRg8ao8AttO2LaH6KZ1SpLa63DTz9IHFwkfVnLvCzEzB4Y
        S8amZmH3HKELASYKqmfwWLhmSOEE/PEvjROhV0hc9u1vd2XrRpy+k3TOvhilHu6MWL6nrMRcNPYr9
        2+UGUOggQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gknM9-0004n9-Kk; Sat, 19 Jan 2019 09:56:01 +0000
Date:   Sat, 19 Jan 2019 01:56:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: dd hangs when reading large partitions
Message-ID: <20190119095601.GA7440@infradead.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 10:48:15AM -0700, Jens Axboe wrote:
> It's UFS that totally buggy, if you look at its queuecommand, it does:
> 
>         if (!down_read_trylock(&hba->clk_scaling_lock))                         
>                 return SCSI_MLQUEUE_HOST_BUSY;
> 
> UFS either needs to get fixed up, or we'll want a way to do something like
> the below.

I think the right answer is to just revert the offending patch instead
of papering over it in the SCSI code.
