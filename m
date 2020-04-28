Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4983C83001
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAAE205C9
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="SCsjWKQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgD1PHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD1PHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 11:07:04 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6994DC03C1AB
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 08:07:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 71so17497526qtc.12
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ut2HsDZG8QbqB1H7vjVFA3kAKc2oHBye7Tb2WSP9LeQ=;
        b=SCsjWKQ/pldG9NfGyXMm5h9bGYnJOv6wLyvY+YWL5Q95u7qy+YAxrJXKQ+VVTS2NQ8
         +tmk94r4Xr5jQvLb2k2s7hLtd2IckIkwo6naAwXYRIphVWhLJpACmvAwa/Cd1lu8SsTD
         q5sLN96ceOMhQGLFEGnmdeyfKBFrWAQe4gMb8Kxub2gLviK/XjOs66HnjfVEAMlPV8qp
         dZ+6jutOtVsfzlcZZ43qTvnXUOFwoZ8tSCQ0qMwkOEkzZMMInAdtZaDJwZFVfqviJlfq
         okGrt9byOJ55FEHKEeNSRJUw8uH6P3oLgybGAmJyPnCu4UE7Q/Zj7xibjrl9EVSG33ge
         u7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ut2HsDZG8QbqB1H7vjVFA3kAKc2oHBye7Tb2WSP9LeQ=;
        b=oWyUK8TV975lav3HQugpqMfA4tlOvPmbeJgBwbIAsArml4QG/SwhueCqw0541E80Ol
         KwL/VsNt5M2K3/BoInOJCe5F3ELv3V7pbMuSbOqWXvUqLCYcjh4yGhu/laeljkQAyT+d
         tr4Sjicv6gAcVOtxh0s7ViZP8NFSalEb0LzEw+mdkzb0Trlvlo8LFlkfY4tZDoFBI6Ix
         uz4NcC25jMgJsS7YrJTtaAWYYnBMPrtHWB/i9NL1QKw0HdYdgEiiCUw2c/MAIe/ikacU
         BhFF7vP5nnTfwQnPgUx50s4pFvhwVKpxPsNkbgLnxkOhSsw6NFp4C90O5fFIDwntgWfL
         g5jg==
X-Gm-Message-State: AGi0PuY8m9Nil60V7UV6QDv6A5f5F+RYNR45cRK+kIanM0SwoMhJ6bkB
        bP45XrrBqqzdd3z3n1tMfnkiWmUE0FU=
X-Google-Smtp-Source: APiQypLz3PVADJuFFj4Xe+uoucrM/FgDT6sBqDLo9xWWa0I1xO/qr6yT0TCzCS5OC6Bywp5qz9ib9Q==
X-Received: by 2002:ac8:3707:: with SMTP id o7mr29510880qtb.172.1588086422473;
        Tue, 28 Apr 2020 08:07:02 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id v23sm13304100qkv.55.2020.04.28.08.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:07:01 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:06:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] block: cleanup the memory stall accounting in
 submit_bio
Message-ID: <20200428150651.GA78497@cmpxchg.org>
References: <20200428112756.1892137-1-hch@lst.de>
 <20200428112756.1892137-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428112756.1892137-3-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 01:27:54PM +0200, Christoph Hellwig wrote:
> Instead of a convoluted chain just check for REQ_OP_READ directly,
> and keep all the memory stall code together in a single unlikely
> branch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hm, I have to say I don't prefer one version over the other here.

Keeping the the stall annotation code more compact is nice, but the
duplicate generic_make_request() seems to suggest that the requests
themselves are also somehow made differently, when it's really just
the annotation that's conditional.

That said, the patch looks correct to me.

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
