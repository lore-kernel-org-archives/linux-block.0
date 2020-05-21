Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1552C433E1
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 20:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25F120826
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 20:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RqtfZL2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgEUUAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 May 2020 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgEUUAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 16:00:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ABAC061A0F
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 13:00:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id y22so8551791qki.3
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+M48zwL3P4qBswmkDG7wpCz13PEIl+461d3T9PW9JI=;
        b=RqtfZL2mrsTsE3QMSTR7kttcHNVDTsG6Xg3tPcha4m5UZZ/qQOvBxOwMTCdgJ64XMD
         e6QquJJpnJTV955pm4XPNMjOA3KI/KRCZQIJ7DOIV/tUFFGb8v8cw/3FsYy6mBptb8q7
         x97xxC/KE/bSeLzJj0/lm3xauWU6TZOPgRC7YmAOyt36tU8hDTYTuPw/nLmswirUCMkL
         t1o1+EEmTDw34Re2j4ED9mjqbV6TCBPwML3sgnfT9KHqkP9sQVvhKkZbX3r1NOROOk16
         xU7CsXzdyBm1anFhSkxZSGjYRwlx3GwGZXhtdjnWnZewmm7wwUnIrmL/pruHCP2gBTHR
         o5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+M48zwL3P4qBswmkDG7wpCz13PEIl+461d3T9PW9JI=;
        b=Gt9qWRxiunF9OuOk8ASFzOe87v2/B6jDq5kzflUXqyoyymVc3+57KXN2TuswlS50KE
         gGQT9C70I6TvglrHd1md/dD0HkSfsP4j4WVr72bPAT1VUJTDtE4a5U2qcFFKNYDieonx
         yPK1CAJ8gptIk886QsMrsJy4nEjcSFalGCK90a/UxUbDg1gue9V2+psz8J/NiVsU3yM8
         LPLcn8hN4Jsiub2JSUw/jY/7pdHD0uliTAnzQKsjEDlopulq4KJzzPxhtCRDXn3IHPQw
         BilgSHMiowtySF0Z7EFv5hVH96mxr+uR+jizxmi5qRBBEgcndPI+d/PwRd/bV7CbBSWW
         o7aQ==
X-Gm-Message-State: AOAM530aNKNicuS5C0wU4yulCKZ7PZNdovrK3PwAG5uyRzQZQjf/wsZ6
        zstwW3AJu1YY2hco7ETbzauw4w==
X-Google-Smtp-Source: ABdhPJxuDgWajhOJpYbZyhzmQrMl0wXOrI1gpt5F94tu2v9uUy7JCkQrqhkVnBdI36hQ6lRUzRXDbw==
X-Received: by 2002:a37:a889:: with SMTP id r131mr3411165qke.197.1590091250787;
        Thu, 21 May 2020 13:00:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f127sm5546136qkj.61.2020.05.21.13.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 13:00:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbrN3-0002Yf-FV; Thu, 21 May 2020 17:00:49 -0300
Date:   Thu, 21 May 2020 17:00:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        bvanassche@acm.org, leon@kernel.org, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH v2] rnbd/rtrs: pass max segment size from blk user to the
 rdma library
Message-ID: <20200521200049.GC17583@ziepe.ca>
References: <20200519084812.GP188135@unreal>
 <20200519111419.924170-1-danil.kipnis@cloud.ionos.com>
 <20200519234443.GB30609@ziepe.ca>
 <6de09fa5-5a4f-dec4-7101-8dd27ca4c764@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de09fa5-5a4f-dec4-7101-8dd27ca4c764@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 21, 2020 at 09:12:59AM -0700, Randy Dunlap wrote:
> On 5/19/20 4:44 PM, Jason Gunthorpe wrote:
> > On Tue, May 19, 2020 at 01:14:19PM +0200, Danil Kipnis wrote:
> >> When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
> >> The rtrs is a transport library and should compile independently of the
> >> block layer. The desired max segment size should be passed down by the
> >> user.
> >>
> >> Introduce max_segment_size parameter for the rtrs_clt_open() call.
> >>
> >> Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> >> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> >> Fixes: cb80329c9434 ("RDMA/rtrs: client: private header with client structs and functions")
> >> Fixes: b5c27cdb094e ("RDMA/rtrs: public interface header to establish RDMA connections")
> >>
> >> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> >> v1->v2 Add Fixes lines.
> > 
> > Applied to for-next, thanks
> 
> Hi Jason,
> 
> Does your "for-next" feed into linux-next?
> I am still seeing this build error today (linux-next 20200521).

Yes, it is usually delayed a bit. It should be there tomorrow

Thanks,
Jason
