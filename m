Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D7C433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 13:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbiEZNux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 May 2022 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiEZNux (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 May 2022 09:50:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB582EA0C;
        Thu, 26 May 2022 06:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6050FB81ECB;
        Thu, 26 May 2022 13:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4564BC385A9;
        Thu, 26 May 2022 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653573049;
        bh=TZ9suwP2Cu23eXuYVpICjiBUHCpObZ4x+7GATJXYMQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOnm6opX6rr5LBUtemokkRUtyRd735v7Fp5sqyQQFG0SlM8YVLkpNuJ9AYxhv7hPc
         E78TZtRVqlbtQhcAmA8VEnoRaLoJBWOuy0jKxY6g1XxLOMSnn1tBpkKoeR3dUQYwzB
         xq5XJLb7wyU+NR0IKI/h4ZaM14N3PS0FiYosM5p8l1qIIYKbena6JEd7lfmQD78CbY
         74AeAYOknYaN68ySlucUAGuuv9P/vSGZt1az84JJLLQlukxJouYn5bVR+arZlXrK2s
         47sEYCXRjZs+6AFavULPDjQsAaekRU7tlu4uO256fbMZb1XN37S/gXH/jtx1f5bTCO
         0RvPdWq63DKzw==
Date:   Thu, 26 May 2022 07:50:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv4 8/9] block: relax direct io memory alignment
Message-ID: <Yo+FtQ8GlHtMT3pT@kbusch-mbp.dhcp.thefacebook.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-9-kbusch@fb.com>
 <Yo8sZWNNTKM2Kwqm@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo8sZWNNTKM2Kwqm@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 26, 2022 at 12:29:41AM -0700, Eric Biggers wrote:
> On Wed, May 25, 2022 at 06:06:12PM -0700, Keith Busch wrote:
> > +	/*
> > +	 * Each segment in the iov is required to be a block size multiple.
> 
> Where is this enforced?

Right below the comment. If it isn't a block size multiple, then ALIGN_DOWN
will eventually result in 0 and -EFAULT is returned. 
