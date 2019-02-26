Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00ABC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F506217F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 15:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AuKf2ntI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfBZPU1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:20:27 -0500
Received: from a9-31.smtp-out.amazonses.com ([54.240.9.31]:37470 "EHLO
        a9-31.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbfBZPU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 10:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1551194426;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=ldR12rhIAH27PJULJ/GQ8uBA7E5Qmh6QabaMRAf2POs=;
        b=AuKf2ntIA9HPKaIu6QHuET2pwbeDm8YRYNCayFlsQcWOUWhXuasu/4vC1q4UB3qZ
        rtmd0Lb+fBOVLu4LWop1juy6Li32yURC4RFjZuJHHbkx08q1Xsfy36HU5UQgSv6M3iH
        5MN2vLKMfrwUMTk//vyTFd3DatFCg/CPTE2o7Raw=
Date:   Tue, 26 Feb 2019 15:20:26 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Dave Chinner <david@fromorbit.com>, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via
 page_frag_alloc
In-Reply-To: <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz>
Message-ID: <010001692a648c57-4215863f-7d66-4086-90ba-2c0832117e3c-000000@email.amazonses.com>
References: <20190225040904.5557-1-ming.lei@redhat.com> <20190225043648.GE23020@dastard> <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.26-54.240.9.31
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 25 Feb 2019, Vlastimil Babka wrote:

> What about kmem_cache_create() with align parameter? That *should* be
> guaranteed regardless of whatever debugging is enabled - if not, I would
> consider it a bug.

It definitely guarantees that. What would be the point of the alignment
parameter otherwise?

