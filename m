Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C42EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 06:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjF0GSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 02:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0GSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 02:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8783599;
        Mon, 26 Jun 2023 23:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E0B61022;
        Tue, 27 Jun 2023 06:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2604C433C8;
        Tue, 27 Jun 2023 06:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687846715;
        bh=PT1TJLw/+jsSSNNLBAlk12SUbxG6D/fqh2oAjy0ah4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvU5iKpYqWVA3jNGsgrCoyywbuPTGdklwuTnu1DNNfnjwOvhIpNAnVnDY0xIEgRyc
         fI+BkyMWY7KkXc3N9iCxg7rsz8knJ5QS94K24eCYoftC6MxIBsLhyKJlpGEKPCIqeT
         2a96l2U7SLr5YV2EBSoZeEgD+z+XzcFzSImtezjk=
Date:   Tue, 27 Jun 2023 08:18:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
        axboe@kernel.dk, willy@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Message-ID: <2023062753-speech-straw-f2f6@gregkh>
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com>
 <20230627110918.7608-1-min15.li@samsung.com>
 <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
 <20230627045924.GA16913@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627045924.GA16913@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 27, 2023 at 06:59:24AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 27, 2023 at 01:39:26PM +0900, Damien Le Moal wrote:
> > See Greg's comment: this likely need a "Fixes:" tag. And I think that the tag
> > is: fa9156ae597c ("block: refactor blkpg_ioctl"). But please double check.
> 
> No, the lack of checks goes back all the way to when this code was
> added long before git was a thing.  So I don't think a Fixes tag makes
> all that much sense here.

Ok, then how about a normal "cc: stable@kernel.org" added to the s-o-b
area so it gets picked up for all stable trees as this is an issue that
has always been there?

thanks,

greg k-h
