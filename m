Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329FCC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 06:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbiBKGwq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 01:52:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBKGwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:52:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12BF1A3
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FYBXBH2qKls/ybNC+8SZHDmjz7FGQGaRd0FU0tRBw5A=; b=nGeW9EL/k/FPtrpogvUfUB75bM
        6M2GHm0ER0NRhB49z6PhCXhGKOF5qjRTEjLPInCKxeuyBahaKtZd+68/VR5WqJJEQJB+tRbuhLUUt
        bxbWtiLx2Ijk42TnaWWELj8osvFye1ok7tMTjJO9jWfmLmsH3U22iuphPKvVN9cwvmj844vQIp11s
        nCBBoV4JKz6RAARALnZev8UJHwBuAN1rtOyeOoMizx7zsphLqlnKvJEdGD7rox7z+WGB95mIab1BG
        JkPtAFR0gMpvi9tku5u1Fm0giUcKtGPKT4yqPojO74avrU3/QE6KXv+6LOjuEyYBeBUydxy/0ZF1h
        /LuiDuMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPnO-0061Ll-Er; Fri, 11 Feb 2022 06:52:42 +0000
Date:   Thu, 10 Feb 2022 22:52:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/14] dm: refactor dm_split_and_process_bio a bit
Message-ID: <YgYHuj/GNpShJxcO@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-4-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-4-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	error = __split_and_process_bio(&ci);
> +	if (ci.sector_count && !error) {

Maybe turn thisin to

	if (error || !ci.sector_count)
		goto out;

	ci.io->orig_bio = bio_split(bio, bio_sectors(bio) - ci.sector_count,
				    GFP_NOIO, &md->queue->bio_split);
	bio_chain(ci.io->orig_bio, bio);
	trace_block_split(ci.io->orig_bio, bio->bi_iter.bi_sector);
	submit_bio_noacct(bio);

and remove another layer of indentation uing the existing label?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
