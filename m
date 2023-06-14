Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEA0EB64DB
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 23:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjFNXir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 19:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFNXiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 19:38:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F2A1BDB
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 16:38:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b02fcde49aso41805475ad.0
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686785924; x=1689377924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5NyGIas4r90/YluD0JIEzQzRK0C8GBJBNaUdbHBvHY=;
        b=OHyB4cwRH53SbjrvO+pTbg+DjGo3UcjoRnU+jpA4chPt6mwT+wfg7SEYO9D/591GVt
         Suqcey77FvtZsZr28xKTOrHjJKEPMVgOIg/9Gsc2Wcu4Vwpb7iNcA+o0uB1U+njvVWUs
         yWMBMsIWxtA6kt9A3hAyJQKCISaNE8GsENgUYF8A81eTES7T78WsJFPID8bXDb8T33EV
         AhA+RrO4Izbacz34DUar3Z3a6xFVJY5AIMwTzMbWzEcIqsl07AWiSf21rs8fo2TB9Asp
         4osbazZLXR8MFddPu/Mm0c1ynEY3p4rBsSeIyaBvhqwZ0ud78/8zKaSkQVIJEikkzFId
         +VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686785924; x=1689377924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5NyGIas4r90/YluD0JIEzQzRK0C8GBJBNaUdbHBvHY=;
        b=NFKvVTBISnl0RAPkwh8MSF8FRtWZSCOs4OdimAwrLdm4+//AZcPcJbH08KwksPkUkA
         IsWF/wspPgUpGf/M2LVE6/8GhS8O3pjbgvikXld4IpUZ1PXNx8Iko+42wGrZuC3+NwIL
         ZZjzDdd8hyOLuDUxdSGro+xRYOIZZs8Ep47o+rQ6xkH7O11j97sPNV+qUidXtbJrKp3E
         mtRd+HPk6vsjyWK1XH3D/l00otqoxcfsnoG11uL3es87yNezk9wRCkUUBpNnH86MDyNg
         uubrJeWqozFLdZ0X33dNBQT4BfVX+1Cal+ZpZMbKkC+zwPCwI/7w5awHKpoUE7JmARbK
         /yZQ==
X-Gm-Message-State: AC+VfDwM4Mb4Hd83n1aSVESHRZkoHgvgoFVmkDGKUmNWMol/PLyIVDRh
        yU8KCQoedA+zdImVpDqXb9VzIg==
X-Google-Smtp-Source: ACHHUZ7Xw2lLpCM+tqXfcBoyp1r9dFsHlRzLZn8ihgL1zrZXZLPoC2+A+kuvjNMZ3Qev17UuPTj26g==
X-Received: by 2002:a17:902:f816:b0:1b3:f3c7:89d4 with SMTP id ix22-20020a170902f81600b001b3f3c789d4mr4173867plb.12.1686785924363;
        Wed, 14 Jun 2023 16:38:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b001b034faf49csm11227957plb.285.2023.06.14.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 16:38:43 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9a4W-00BrNP-3D;
        Thu, 15 Jun 2023 09:38:41 +1000
Date:   Thu, 15 Jun 2023 09:38:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIpPgC57bhb1cMNL@dread.disaster.area>
References: <20230612161614.10302-1-jack@suse.cz>
 <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
 <20230614020412.GB11423@frogsfrogsfrogs>
 <CACT4Y+YTfim0VhX6mTKyxMDVvY94zh7OiOLjv-Fs0kgj=vi=Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YTfim0VhX6mTKyxMDVvY94zh7OiOLjv-Fs0kgj=vi=Qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 14, 2023 at 02:27:46PM +0200, Dmitry Vyukov wrote:
> On Wed, 14 Jun 2023 at 04:04, Darrick J. Wong <djwong@kernel.org> wrote:
> > On Tue, Jun 13, 2023 at 08:49:38AM +0200, Dmitry Vyukov wrote:
> > > On Mon, 12 Jun 2023 at 18:16, Jan Kara <jack@suse.cz> wrote:
> > > CONFIG_INSECURE description can say something along the lines of "this
> > > kernel includes subsystems with known bugs that may cause security and
> > > data integrity issues". When a subsystem adds "depends on INSECURE",
> > > the commit should list some of the known issues.
> > >
> > > Then I see how trading disabling things on syzbot in exchange for
> > > "depends on INSECURE" becomes reasonable and satisfies all parties to
> > > some degree.
> >
> > Well in that case, post a patchset adding "depends on INSECURE" for
> > every subsystem that syzbot files bugs against, if the maintainers do
> > not immediately drop what they're doing to resolve the bug.
> 
> Hi Darrick,
> 
> Open unfixed bugs are fine (for some definition of fine).
> What's discussed here is different. It's not having any filed bugs at
> all due to not testing a thing and then not having any visibility into
> the state of things.

Just because syzbot doesn't test something, it does not mean the
code is not tested, nor does it mean the developers who are
responsible for the code have no visibility into the state of their
code.

The reason they want to avoid this sort of corruption injection
testing in syzbot is that it *does not provide a net benefit* to
anyone. The number (and value) of real bugs it might find are vastly
outweighed by the cost of filtering out the many, many false
positives the testing methodology raises.

Keep in mind that syzbot does not provide useful unit and functional
test coverage. We have to run tests suites like fstests to provide
this sort of functionality and visibility into the *correct
operation of the code*.

However, alongside all the unit/functional tests in fstests, we also
have non-deterministic stress and fuzzer tests that are similar in
nature to syzbot. They often flush out weird integration level bugs
before we even get to merging the code. These non-deterministic
stress tests in fstests have found *hundreds* of bugs over the
*couple of decades* we have been running them, and they also have a
history of uncovering entire new classes of bugs we've had to
address.

At this point, syzbot is yet to do prove it is more than a one-trick
pony - it typically only finds a single class of filesystem bug.
That is, it only finds bugs that are related to undetected physical
structure corruption of the filesystem that result in macro level
failures (crash, warn, hang).

Syzbot does nothing to ensure correct behaviour is occuring, that
data integrity is maintained by the filesystem, that crash recovery
after failures works correctly, etc. These things are *by far* the
most important things we have to ensure during filesystem
development.

IOWs, the sorts of problems that syzbot finds in filesystems are way
down the list of important things we need to validate.  Yes,
structural validation testing is something we should be
running, and it's clear that is does get run (both from fstests and
syzbot).

Hence the claim that "because syzbot doesn't run we don't have
visibility of code bugs" is naive, conceited, incredibly
narcissistic and demonstratable false. It also indicates a very
poor understanding of where syzbot actually fits into the overall
engineering processes.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
