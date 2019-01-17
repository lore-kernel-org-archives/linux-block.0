Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B477C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C6D20657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="luthkucA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfAQCQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:16:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 21:16:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so4019476pfi.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 18:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRZHibO5AqwXG/v8LjKtVYgEPtfk3FyzTZh3YqqE8WA=;
        b=luthkucAJVgBaSY61aLFkD96KHWR4qEsUzHwMlpqv/w1PuAxZqeX2TlkIBgRLDjLQG
         K4Nkt2cJkbiGOEao2UgMvnYciqP4jiZcMOu3OhJxVP4zHNh4nQi7RpxXfWyHtAtEA1H2
         +bek65iBbPLbJUdEW97cyhR9wAvT3P9V9//zoKyPBupQJvgyeMRMe6vqjr+mwbg1JZ4e
         D/5f7L1jpGjELMVXPp74ezfLZ0jjnsvbA2cxHr7Jol0V5E9Ch1WgvZHipZ3SGBA7PTu/
         pZ7aq5R/pIXR66MdpYQiljxXZEnMwj7O+nPU7yw/oVXc2zt9s5LuZPlwrVeVa0TOXf+H
         JgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRZHibO5AqwXG/v8LjKtVYgEPtfk3FyzTZh3YqqE8WA=;
        b=nNkthIOsgKZ8dT0jGTiFTh+IrUXP1DZtgJ7jx6q1FQ4Et+4pNSK7pwf+HMawQeTmux
         xlNtVOpfy6XhMnQoOYzuPFymzldnHAVq/UcGfDy8QndYlvsg6YxfQ1BL72CeXtaCF6fa
         Av+GpAoFjQKfx3htM10Zaieyb04L495uwdqUE6WI6k1T14arW9katW2rMVhuwt9hEfVB
         aROL3XuIzc4eWqveN2xXUufbQWbzI/5RXf7JtZdYvWKrnNMqDr0uZ5y0Qd6bHaXihtPE
         A0g/YD18udACVUczdW6XtZa8yLrNJrG8e0QPO9vzeRIeIqql4Kb0F1dDxl6XpM5d8K78
         Xi5g==
X-Gm-Message-State: AJcUukd2EiNRJHEu1HkbsBgKagi+7w2MOcm1BPU5lIGwXA3qYT3uGu0R
        M1knnJGA8FnTNcbqXB0BM8Fx/w==
X-Google-Smtp-Source: ALg8bN5BRvg6CQn+GvaS5Od/seBCHu1xboKVA0ZJsWO2TWj/+o4RrZhdMsEAEAMY+5wwRLbdfvVrzQ==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr11829038pgl.270.1547691376297;
        Wed, 16 Jan 2019 18:16:16 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id q75sm175549pfa.38.2019.01.16.18.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 18:16:15 -0800 (PST)
Date:   Wed, 16 Jan 2019 18:16:13 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 00/16] Implement zoned block device support
Message-ID: <20190117021613.GB25494@vader>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 10, 2019 at 06:37:09PM +0900, Shin'ichiro Kawasaki wrote:
> The current blktests infrastucture and test cases do not support zoned block
> devices and no specific test cases exist to test these block devices special
> features (zone report and reset, sequential write constraint). This patch series
> implement this missing support.
> 
> The series addresses two aspects: the first 7 patches introduce changes to the
> common scripts and configuration are introduced to allow existing test cases to
> run against a null_blk device with zone mode enabled (new ZONED config variable)
> or for these test cases to be skipped if a test declare itself as not zoned
> compliant. Helper functions are introduced to facilitate checking a device
> zone model.
> 
> The second part, composed of the last 9 patches, introduce the new zbd test
> group to cover zoned block device specific test cases. All these test cases are
> implemented using the test_device() function so that target devices can be
> specified in the TEST_DEVS config variable, to cover a variety of zoned block
> devices: physical real drives, partitions and dm-linear setups on top of zoned
> block devices, etc. Furthermore, using the infrastructure changes of the first
> part, the TEST_DEVS definition can be left empty, resulting in the zbd test
> cases to be run against an automatically created null_blk device with zoned
> mode enabled.
> 
> 5 test cases are added to the new zbd test group to check the kernel ioctl and
> sysfs interface, zone report operation, zone reset and write command handling.
> These tests are simple but only a start. We will in the future send more test
> cases to cover at least the regressions and bugs found and fixed in the zoned
> block device code since its introduction with kernel 4.10.
> 
> Another still to be added part is support for host-managed ZBC emulation in
> scsi-debug to further improve test coverage without requiring a physical SMR
> disk. This work is ongoing and will be added to blktests once the relevant
> scsi-debug changes are accepted in the kernel.
> 
> Changes from v1:
> * Fixed _test_dev_is_zoned
> * Added _have_fio_zbd_zonemode
> * Added patch 10 to move _dd to common/rc
> * Addressed various nit commented on the list
> 
> Masato Suzuki (6):
>   tests: Introduce zbd test group
>   zbd/001: sysfs and ioctl consistency test
>   zbd/002: report zone test
>   zbd/003: Test sequential zones reset
>   zbd/004: Check write split accross sequential zones
>   zbd/005: Test write ordering
> 
> Shin'ichiro Kawasaki (10):
>   config: Introduce ZONED variable
>   common: Introduce _test_dev_is_zoned() helper function
>   common: Move set_scheduler() function definition
>   common: Introduce _have_fio_zbd_zonemode() helper function
>   block/004: Adjust fio conditions for zoned block device
>   block/013: Skip for zoned block devices
>   block/018,024: Skip when ZONED is set
>   check: Introduce group_exit() function
>   src: Introduce zbdioctl program
>   common: Introduce _dd() helper function

Hi,

Thanks so much for the contribution. It'll be great to have some tests
for zoned block devices.

One thing I'm not a huge fan of is that setting the ZONED mode hijacks
the existing tests to be ZBD tests. When I'm doing a full test run, I'd
like to run those tests in both modes without running the rest of the
test suite twice.

Instead, what if we added a per-test setting like CAN_BE_ZONED and a
global config RUN_ZONED_TESTS? If those are both set, we run it once in
normal mode and once in zoned mode. This also avoids having to blacklist
tests which don't support zoned mode (although we'll have to remember to
whitelist tests that would work on a zoned device).

The functionality for falling back to null_blk if no devices are
specified is nifty. It'd be nice to have that as generic functionality
instead of specific to the zbd group. Something like a per-test
fallback_device() function which sets up the fallback test device. It'd
probably also need a cleanup_fallback_device().

Let me know your thoughts.

Thanks!
