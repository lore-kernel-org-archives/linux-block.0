Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB59FC4332F
	for <linux-block@archiver.kernel.org>; Mon,  6 Nov 2023 15:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjKFPDB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Nov 2023 10:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjKFPDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2023 10:03:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D7B7
        for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 07:02:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A33C433C8;
        Mon,  6 Nov 2023 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282978;
        bh=mdnasKN++L7iH5e6EPZzJn9sOH6/oy4ZkzaDKp72Z4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU6+zLStHSVytMX6tJg1kzHdIVLIwVf+659Kn3Bsd27AgQ6bgN0FVk0a/m6EtZgir
         Z7eL6fs21SfS2wj7A6a6altos0BNWVgUgcCZRa8aHcVTQYF4Bbq4iRjOJc6bFj2ihW
         FuVegkxQSDOLaFhZA/IBYcLnobbcGy8CjPxGJTS6MNlWRxjWVivIfhba1bw+WSLktq
         46O/PPGqCzA8gipo5PV7570BE8sGSGWdSScplcVIt5UJ8TkH0eNJkNSebLVuMw9AoO
         fi5tsJpjgTHOqo9oowhWEnX6SwKhDD0VaFzkpj/Ye4ZzvwI6KgnRihNVPEb1+49Ngo
         APyeIf7R+RqZg==
Date:   Mon, 6 Nov 2023 08:02:55 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZUkAH258Ts0caQ5W@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <CGME20231027182010epcas5p36bcf271f93f821055206b2e04b3019a6@epcas5p3.samsung.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <40ac82f5-ce1b-6f49-3609-1aff496ae241@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ac82f5-ce1b-6f49-3609-1aff496ae241@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 06, 2023 at 11:18:03AM +0530, Kanchan Joshi wrote:
> On 10/27/2023 11:49 PM, Keith Busch wrote:
> > +	for (i = 0; i < nr_vecs; i = j) {
> > +		size_t size = min_t(size_t, bytes, PAGE_SIZE - offs);
> > +		struct folio *folio = page_folio(pages[i]);
> > +
> > +		bytes -= size;
> > +		for (j = i + 1; j < nr_vecs; j++) {
> > +			size_t next = min_t(size_t, PAGE_SIZE, bytes);
> > +
> > +			if (page_folio(pages[j]) != folio ||
> > +			    pages[j] != pages[j - 1] + 1)
> > +				break;
> > +			unpin_user_page(pages[j]);
> 
> Is this unpin correct here?

Should be. The pages are bound to the folio, so this doesn't really
unpin the user page. It just drops a reference, and the folio holds the
final reference to the contiguous pages, which is released on
completion. You can find the same idea in io_uring/rscs.c,
io_sqe_buffer_register().
