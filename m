Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF4C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6D2086C
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="zeTj3JVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfGOXOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:14:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41479 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfGOXOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 19:14:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so8124245pff.8
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=43ut9F37IivXr0wxhSuvpD20A53QvajOAoIP5Mv0CjQ=;
        b=zeTj3JVPib1T3f0ZXqdd0HqpMZAQYHa/h66r+rYUuVxZgxiHVPu2ccEEnwklqVElVI
         HgmoIdwmbRVU++b5F6wUPl7FQi7hzM++GrIhg4r0+rTXgQHsE/d1v2o79inOkRhNIf6s
         UD7MhWkcVBZiAM0WQ4TYUQcEvN+sbekHY7p7fhdLQlz1ma3Wt4TziF7HRxQZHycB832I
         vhuqBr3HhXkNB4Xl6NW+GvQm76egSUgFvgV9t8ZnjMqcLShj+VzCKxixAZfCcpyB3fEJ
         NfhjWOGRh0V3YYIQs/TrBeuY14zkyMiG/Q+afeKA92q1sGz4Uc5x+wchvGGnL8Kq/Mq7
         Etuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43ut9F37IivXr0wxhSuvpD20A53QvajOAoIP5Mv0CjQ=;
        b=HT+g3iB7jqdsfXhpuVvETLRs+wG+wVYUwjuIjWWWn7g0AlGqJsfjtyRI9L7Y5+luXw
         9DovY66AYiinZjQ0mpPFGdBhJ2HMurdo08e+MMLi/CAYmHkRzzZbiEtGLs0XUVo7F4zo
         9RcDoa3n96UZ+Q0IZqSPVjwHggK/k578R26LMMk5aQpfDRxDP2hDww6pZ6wirRY7SAO/
         cOFDXPsGEeU7eIp9rYs3SMdu8q290ukbJY5ov/SAkKx/jTL3Ko1/M14qu+ED23M4Vy+t
         mBGmp8YAbx9pl9MEnJqaZ0E++LmIhx5xPBmJpjEAAJ3kgLNCgIUhp0FTpW+gXFTdP7tV
         YuJw==
X-Gm-Message-State: APjAAAUgEEji6+JRcklVZh9IOTejW82iot61esDnVsNT9MOr9Et5jvSH
        sCL3NV/VRjuOAA+L/XmDdOSXQw==
X-Google-Smtp-Source: APXvYqzswRPHUBtaK1lClUn8PJIvwZDdw76vBHzPpeT9PhmIGfmTti65pHpW91HCUpx6De6DpJVPLQ==
X-Received: by 2002:a65:6406:: with SMTP id a6mr16141201pgv.393.1563232452725;
        Mon, 15 Jul 2019 16:14:12 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:f4a5])
        by smtp.gmail.com with ESMTPSA id b136sm10956871pfb.73.2019.07.15.16.14.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 16:14:12 -0700 (PDT)
Date:   Mon, 15 Jul 2019 16:14:11 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests 00/12] Fix nvme block test issues
Message-ID: <20190715231411.GB5449@vader>
References: <20190712235742.22646-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 12, 2019 at 05:57:30PM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset cleans up a number of issues and pain points
> I've had with getting the nvme blktests to pass and run cleanly.
> 
> The first three patches are meant to fix the Generation Counter
> issue that's been discussed before but hasn't been fixed in months.
> I primarily use a slightly fixed up patch posted by Michael Moese[1]
> but add another patch to properly test the Generation Counter that
> would no longer be tested otherwise.
> 
> I've also taken it a step further to filter out more of the discovery
> information so that we are less fragile against churn and less dependant
> on the version of nvme-cli in use. This should also fix the issue discussed
> in [2].
> 
> Patches 4 through 7 fix a number of smaller issues I've found with
> individual tests.
> 
> Patches 8 through 10 implement a system to ensure the nvme tests
> clean themselves up properly especially when ctrl-c is used to
> interrupt a test (working with the tests before this was a huge
> pain seeing,  when you ctrl-c, you have to either manually clean
> up the nvmet configuration or reboot to get the system in a state
> where it's sane to run the tests again).
> 
> Patches 11 and 12 make some minor changes that allow running the
> tests with the nvme modules built into the kernel.
> 
> With these patches, plus a couple I've sent to the nvme list for the
> kernel, I can consistently pass the entire nvme suite with the
> exception of the lockdep false-positive with nvme/012 that still
> seems to be in a bit of contention[3].
> 
> Thanks,
> 
> Logan
> 
> [1] https://github.com/osandov/blktests/pull/34
> [2] https://lore.kernel.org/linux-block/20190505150611.15776-4-minwoo.im.dev@gmail.com/
> [3] https://lore.kernel.org/lkml/20190214230058.196511-22-bvanassche@acm.org/
> 
> --
> 
> Logan Gunthorpe (11):
>   nvme: More agressively filter the discovery output
>   nvme: Add new test to verify the generation counter
>   nvme/003,004: Add missing calls to nvme disconnect
>   nvme/005: Don't rely on modprobing to set the multipath paramater
>   nvme/015: Ensure the namespace is flushed not the char device
>   nvme/018: Ignore error message generated by nvme read
>   check: Add the ability to call a cleanup function after a test ends
>   nvme: Cleanup modprobe lines into helper functions
>   nvme: Ensure all ports and subsystems are removed on cleanup
>   common: Use sysfs instead of modinfo for _have_module_param()
>   nvme: Ignore errors when removing modules
> 
> Michael Moese (1):
>   Add filter function for nvme discover
> 
>  check              |    9 +
>  common/rc          |   18 +-
>  tests/nvme/002     |   10 +-
>  tests/nvme/002.out | 6003 +-------------------------------------------
>  tests/nvme/003     |    6 +-
>  tests/nvme/003.out |    1 +
>  tests/nvme/004     |    6 +-
>  tests/nvme/004.out |    1 +
>  tests/nvme/005     |   16 +-
>  tests/nvme/006     |    6 +-
>  tests/nvme/007     |    6 +-
>  tests/nvme/008     |    6 +-
>  tests/nvme/009     |    5 +-
>  tests/nvme/010     |    6 +-
>  tests/nvme/011     |    6 +-
>  tests/nvme/012     |    6 +-
>  tests/nvme/013     |    6 +-
>  tests/nvme/014     |    6 +-
>  tests/nvme/015     |    5 +-
>  tests/nvme/016     |    6 +-
>  tests/nvme/016.out |    9 +-
>  tests/nvme/017     |    8 +-
>  tests/nvme/017.out |    9 +-
>  tests/nvme/018     |    8 +-
>  tests/nvme/019     |    6 +-
>  tests/nvme/020     |    5 +-
>  tests/nvme/021     |    6 +-
>  tests/nvme/022     |    6 +-
>  tests/nvme/023     |    6 +-
>  tests/nvme/024     |    6 +-
>  tests/nvme/025     |    6 +-
>  tests/nvme/026     |    6 +-
>  tests/nvme/027     |    6 +-
>  tests/nvme/028     |    6 +-
>  tests/nvme/029     |    6 +-
>  tests/nvme/030     |   72 +
>  tests/nvme/030.out |    2 +
>  tests/nvme/rc      |   64 +
>  38 files changed, 208 insertions(+), 6163 deletions(-)
>  create mode 100755 tests/nvme/030
>  create mode 100644 tests/nvme/030.out

Thanks for cleaning this up! I replied with one nitpick, and besides
that and comments from the other reviewers, I'm happy with it overall
(assuming it passes shellcheck).
