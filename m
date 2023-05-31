Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18925C77B7C
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 05:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEaFkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 01:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjEaFke (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 01:40:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4711C
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 22:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3evx5XgqyBMrwj36pkGJcsFb6FtJqCU6cNzM+o9HoNk=; b=YRdPnbyY5MlT9JkDXwjNeJbyvR
        u7T5bWLPBQyjpvYXqPLOQsKA1nR1AqfYSTd/Hil1EYgpA1e6sI4XTOvbfcSLmMNOFdaRNu61EAe+R
        RPtmt4+GPz1g4e0RTZh1YvC0s05wsyEpvyAMIflr9m+YBc4aEnK3GTr8lOoOGjnb4HCsxlZWNI3FW
        FcRaBFIMrxuETob5vB95FDI/QZBIBRAkWCBxcwFGAMrL9LN1u0nXccHaVfU2N7guX+cni0kiBKLQv
        lCFiP4cmcLk8K8GZeBa3HegvkprBHE2MVVkV5g0NB97YWllAQdUmKPSOCDChuHk6Gy0iiGsaAEMiE
        +4aU1+mA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4EZT-00GCCC-04;
        Wed, 31 May 2023 05:40:31 +0000
Date:   Tue, 30 May 2023 22:40:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 3/9] block: Support configuring limits below the page
 size
Message-ID: <ZHbdzvz3HElrrOL6@bombadil.infradead.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-4-bvanassche@acm.org>
 <ZHF2Hbv5qBJl9CZl@bombadil.infradead.org>
 <62e672ad-be3a-2ce8-ee11-c9682ab7d21d@acm.org>
 <ZHO6oYt/y2lKPBaB@bombadil.infradead.org>
 <8cc92543-8d3b-6ec5-86a0-349c55a46e37@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc92543-8d3b-6ec5-86a0-349c55a46e37@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 28, 2023 at 03:32:45PM -0700, Bart Van Assche wrote:
> On 5/28/23 13:33, Luis Chamberlain wrote:
> > That's right, so the question is, is there a way to make simpler
> > modifications which might be sensible for this situation for stable
> > first, and then enhancements which don't go to stable on top ?
> > 
> > What would the minimum fix look like for stable?
> 
> Let's follow the usual process: work integrating these changes in the
> upstream kernel first and deal with backporting these changes to stable
> kernels after agreement has been achieved about what the upstream
> patches should look like.

I'm not talking about deviating away from that process.

Sometimes backporting a large chunk of changes cannot be done due the
size or other things. So one way to address this proactively is
to see if perhaps some compromises can be made for stable, while
upstream carries the rest.

I can't see a way to do this though...

So at least as-is, for the rest of the patches in this series:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
