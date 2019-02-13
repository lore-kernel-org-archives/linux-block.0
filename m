Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F54C282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6EF20811
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ZzvqvTEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391118AbfBMSv1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:51:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35189 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405909AbfBMSnd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so1611945plo.2
        for <linux-block@vger.kernel.org>; Wed, 13 Feb 2019 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cskGER2kLhDYffh/65lC+CyjN5WHevaK5sT2Fu6EyvA=;
        b=ZzvqvTEPwm3CT6fzzeYh64xOPozEcfW3ZNmyzFfIrh2Gge+P3SSd57CEFC9CoXNxU1
         nYpkpVUoESPzdEf/kpK1qpxNbeRS/y10W9h+4hX7NfPyf7Jz3bzoyk0/OA9KwnGGqPvB
         qi+GvFE++G5CesctVczcSuF8eax3CBQEEFdlKyXTI2fhX3I4oEilrhbjgmvsFrvSBPAL
         m8OehzTP/z4e0RGYgirbZxmBWg94KZKiHbuszSMDfhb8kixsbJ0rVrKayouR+lw2Z+tS
         L0rtwo29wL0qiA8f92HF6zryGqYXzONcCj2kdyNmU6rSKJ2MOh1pqcZPpts2sNY/sFmL
         CFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cskGER2kLhDYffh/65lC+CyjN5WHevaK5sT2Fu6EyvA=;
        b=S9EB5BM3x9/A+aY7Cm7P3AWGiJeOXHxhdlNpLCFw4Gky7PqQCMFXGat8EKyH1mJewq
         CtTpU/fI3ux2DXwCdVSD3FdXfcIaDVp/QKjUK/D7k0PTaz3/IW5r55v97LIkOsTVYEdF
         PtxeqoJoI41kJKvEZasrMvOQ4BhO3e8AIgH7XzU11NvwHoISWAZ3SSaOF8F4YfqhzTZD
         NFxqlMrxTFCJloZYMbBhfpugELWB5GHFA1bAAI0miur0t7OpTqGcoBHZFDIiUiuRokXs
         gJxH5fRLTN+1hZYYyiyRHFFbFBF/R41Uzp6uRPjfstMYqJAL0FbuOsIHUXoLYS8uZWwo
         /8QQ==
X-Gm-Message-State: AHQUAuYUnZ6BuOTnQH++3PnImqAwRJOMVNRgZrR0/i9xKeaj7tLoGoZY
        7hlEp/LwuPgQsNzfHiTc6ht4mQ==
X-Google-Smtp-Source: AHgI3IYCk6CoprSWobolT1B1vyO7TCHetiXJTeLeXcnn2tMTSTe9NiotMFsJYPTRWxsuAzzoa72wOA==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr1812907plb.223.1550083413088;
        Wed, 13 Feb 2019 10:43:33 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id z1sm1850pfi.155.2019.02.13.10.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 10:43:32 -0800 (PST)
Date:   Wed, 13 Feb 2019 10:43:31 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
        "hare@suse.de" <hare@suse.de>,
        "hch@infradead.org" <hch@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "tytso@mit.edu" <tytso@mit.edu>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
Message-ID: <20190213184331.GA9819@vader>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <1550081474.19311.62.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550081474.19311.62.camel@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 10:11:14AM -0800, Bart Van Assche wrote:
> On Wed, 2019-02-06 at 05:21 +0000, Chaitanya Kulkarni wrote:
> > For storage track, we would like to propose a session dedicated to blktests. It is a great
> > opportunity for the storage developers to gather and have a discussion about:-
> > 
> > 1. Current status of the blktests framework.
> > 2. Any new/missing features that we want to add in the blktests.
> > 3. Any new kernel features that could be used to make testing easier?
> > E.g. Implementing new features in the null_blk.c in order to have device
> > independent complete test coverage. (e.g. adding discard command for null_blk or any
> > other specific REQ_OP). Discussion about having any new tracepoint events in the block layer.
> > 4. Any new test cases/categories which are lacking in the blktests framework.
> 
> Hi Chaitanya,
> 
> Thanks for having proposed this topic. I'd like to add a fifth item to the
> agenda, namely blktests maintainership. The following could e.g. be discussed:
> - How many maintainers should the blktests project have? A single maintainer
>   or also one or more co-maintainers?
> - Is it acceptable that patches get accepted in the blktests repository that
>   break the continuous integration tests? If so, why do we even have continuous
>   integration tests? See also "[PATCH] Unbreak the continuous integration build"
>   (https://marc.info/?l=linux-block&m=154990323618159).

To be honest, I've never used travis, so I don't even know where to find
the results. https://travis-ci.org/osandov/blktests doesn't point to
anything. Can we add a build status badge to the README like other
projects have?

> - How long should it take before a blktests maintainer provides feedback on
>   blktests patches and pull requests? Is it considered acceptable that it takes
>   more than four weeks to process a pull request that is in perfect shape? See
>   e.g. https://github.com/osandov/blktests/pull/44.

Nope, that's not acceptable, sorry about that :( We can talk about a
reasonable SLA for review and merging.

> Bart.
