Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBABC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186D26103D
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhJRKYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRKYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:24:48 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9CEC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tk4Wbu7cdSndW46EZvbBJjK2nheaEarSSw/FpJs6180=; b=LxvqpKMpQn0EQ6NwsfZPJ6vb4x
        I25HibKOZR4cJ3rzY3tqDR53mQ5UtjYYBoHXvnqOxsZK+SfV9mOVp3G5dKUKt+kuPzyRJYp2jZ5F2
        /CtcudkwBfWP1YwXSqW804J8DL4dTP80xl2TEPlg6qQ4RCQOfAlPV0r0f+cJA4a5PYkOitlW2MgTD
        HF7L33d/LngpRU6RLw9uemfgJjMi1V6r8MrqNV7Wnm3rla9jSPkf07x2jark3NHHw5Ut4FmZd7e5T
        VdrKoeiCpYGtZ2Qs1CHSA0ihsbTnpyGP3K44RONVvT8fRNQfLNCu0YUYUkwmzy1G4Gx2ycGNLcolw
        j5RPRAWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPmv-00EzAK-CM; Mon, 18 Oct 2021 10:22:37 +0000
Date:   Mon, 18 Oct 2021 03:22:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 6/6] nvme: wire up completion batching for the IRQ path
Message-ID: <YW1K7RR2F+dL9ntI@infradead.org>
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017020623.77815-7-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 08:06:23PM -0600, Jens Axboe wrote:
>  static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>  {
> -	return nvme_poll_cq(nvmeq, NULL);
> +	DEFINE_IO_COMP_BATCH(iob);
> +	int found;
> +
> +	found = nvme_poll_cq(nvmeq, &iob);
> +	if (iob.req_list)
> +		nvme_pci_complete_batch(&iob);
> +	return found;

Ok, here the splitt makes sense.  That being said I'd rather only add
what is nvme_poll_cq as a separate function here, and I'd probably
name it __nvme_process_cq as the poll name could create some confusion.
