Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499AC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 19:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A0620675
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 19:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="tNj7Bxw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394488AbfBMT5C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:57:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37011 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbfBMT5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 14:57:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so1667117pgq.4
        for <linux-block@vger.kernel.org>; Wed, 13 Feb 2019 11:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=deAWBa3DwJUcptxHJnlimuI/gVHTzppqqEqxj0ZZDaQ=;
        b=tNj7Bxw9npSUF6zGKBMjLr+yqnhWcsppSUTPw1kWUSp6f/KO61HrJLQhJliFQ6tRXT
         fCnEy6BrFiCvl2ODgIJy4qGQGdg/St75EQvA0j7T/GsUec6uTMWJUxZMhXOVFnSLap25
         tf+OzcmVWKGOY2V8ZSpL0xrcd+19OcXVqC7FKkZoRIlXcXcq7+xamGRLpbeGy08MJezp
         u6nG/8dEFmG03/q3mHT2YdsZkWUTMlEPfWyq6KX+w1p0heReCoJ4DtxlwddPqwwSZCGs
         QS2Yvnr8MYCHZyjyl2EMHZcTQvVUwo/AzDtiSMrmJOF0GlNDQQjLQf0fKEdk1S8yJEqx
         PkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=deAWBa3DwJUcptxHJnlimuI/gVHTzppqqEqxj0ZZDaQ=;
        b=iLYV4O0+XjkVY5hlGunBN2vqYQXaPQwr8gIBcuw1rb26Nm0Q5+JXlODsby2N+f6AjT
         Lj7o9FzQ2wnVC7nrjxjS6W5pNiV/MD2uVknf6K1qgMi+A1MiPKUD0shfxd51JLJn/wBf
         pxQvn+CZgQnR/3xMwkbxa3BsOLmcjKdxjI9GSJoDs8RJHpOm76LZNoISSKV5Q0coA0zu
         +NnUnCrdWMamtO/KyZQD5VnJtJdEx8UIoFbkVmLLB00/bnvuiymPa2TaMbOP+aOc74vX
         iY+r10t5F8v1UiQtt/e+2KXZTHcG5VvW07CCTUTp04dNY0vcOYw6rEWobbeJAqSyTJaC
         jtNw==
X-Gm-Message-State: AHQUAuYMFBzb4s2ZByk9k9YVnbdY2nljhqAzse5FQUs0Iu4b5Qz9s9+C
        z+jFRsY/PodiqH1QzNcwFvqc5Q==
X-Google-Smtp-Source: AHgI3IaTppsjFjPfXXW7iRVrm5eAJOuM8ioulQO4W1E1qaKvWEzGVwzFNGW14/pVv/s8RyTb2tezNA==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr2166031pfb.218.1550087821134;
        Wed, 13 Feb 2019 11:57:01 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id o11sm151830pfh.107.2019.02.13.11.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 11:56:59 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:56:58 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "osandov@fb.com" <osandov@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
Message-ID: <20190213195658.GB9819@vader>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <1550081474.19311.62.camel@acm.org>
 <20190213184331.GA9819@vader>
 <1550084044.19311.73.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550084044.19311.73.camel@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 10:54:04AM -0800, Bart Van Assche wrote:
> On Wed, 2019-02-13 at 10:43 -0800, Omar Sandoval wrote:
> > On Wed, Feb 13, 2019 at 10:11:14AM -0800, Bart Van Assche wrote:
> > > - Is it acceptable that patches get accepted in the blktests repository that
> > >   break the continuous integration tests? If so, why do we even have continuous
> > >   integration tests? See also "[PATCH] Unbreak the continuous integration build"
> > >   (https://marc.info/?l=linux-block&m=154990323618159).
> > 
> > To be honest, I've never used travis, so I don't even know where to find
> > the results. https://travis-ci.org/osandov/blktests doesn't point to
> > anything. Can we add a build status badge to the README like other
> > projects have?
> 
> Hi Omar,
> 
> What is a build status badge?

I just added it, see
https://github.com/osandov/blktests/commit/a61aa7fcce0bad9094b0e7646f3a8299c30afa6a

Anyway, enabling Travis CI is easy:
> * Navigate to https://travis-ci.org/ and click on "Sign in with github".
> * In the left column, click on "+" (Add New Repository).
> * For the blktests repository, enable continuous integration. This will cause a
>   continuous integration test to be started after every git push and also every
>   time a pull request is submitted. The rdma-core project uses Travis CI not only
>   to compile-test pull requests but also to verify whether new code in pull
>   requests passes building with sparse. This is useful for the rdma-core project
>   since a lot of endianness conversions happen in that code and sparse can
>   verify whether these conversions have been annotated correctly. See also
>   https://github.com/linux-rdma/rdma-core.

Thanks, I got it set up now.
