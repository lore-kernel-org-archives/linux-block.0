Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF7BC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A4F21773
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tMokctLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfBRS2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:28:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37892 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731888AbfBRS2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 13:28:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so29894822otf.5
        for <linux-block@vger.kernel.org>; Mon, 18 Feb 2019 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61A4/pXAOuL1qD1InScuL+ZQsJ2daF8hYngPLbv7POY=;
        b=tMokctLGcpHhqNR/e/NSsxfB6B5p5c5imJypXFqVXPxj7LDrmVG1wKTTIiXPbsDTb6
         IC0n1WClX0z8Y/wo/W/m7eAxOJ9LdIqJRmPJx+sSGsQ1uqUrfnq86t8Z+VL6rLnUY7uq
         Z5hRen8gddZOi5AdNeahDrTlOTBnoOy5TJz54i3/NSjYwnlIvzCX6BXU2zUX6pW1D++m
         WNWJHeHZOWwRl9FKPFQXW9lQ1b7Y2TdmCVNxSznJt2e31Yd3AJrFdUmj0jQa60vVVv0S
         vqZuFmRKP5dqEmAg38rPXvEEU6GsfiyP/aCSDkO2Dqtp/iRyUA75SlzmGalM0l1gjdGQ
         OOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61A4/pXAOuL1qD1InScuL+ZQsJ2daF8hYngPLbv7POY=;
        b=SpsxhAH/2B0zaANRS/AKCSB6Ut/wnZIGD1LE+7CS0JN6SIPa6AKaZgUk6Gu9bfOL8/
         /x7QNVmYk3zJLujfP56qjizhoSBj8WEMpVz+tUHJ4VSxk4aNBOTYiuS9TeL7iPNlbKiU
         Zrm2esOfCCu1/4JOIGZMAXtwDuWKJJVej86LL829dRAv4/AQuOQjtSaz6yh7x5M8XBxx
         7CBNnWpOEmDOBTfj7czkCYqpjoPthOKGO1xNBcs0o8JU1iDY6k2weAPBTLNhehsZfC1E
         Uvq6kMXmYcKSLfdkGHI+0s/6S8qC+vl9b1lBgNee8b/+JkgEAsaMq7orWHa8ovOL6EuL
         7TQw==
X-Gm-Message-State: AHQUAuZC5n5/gCJnDna0rM2kSRJKC6tuZ4w9toEeiHmPaH1ZlEogvzAL
        f8c8cRGlq7kM1hzWwjnQkeIm3ivUn7Mmd4CrYYk8QQ==
X-Google-Smtp-Source: AHgI3IbkIgHd4N9gDtQiSpFZ73fHij9/1mD20PmrL889XoDapAta8tZ+YygnfWt8BdNz8yPa/i17b1XZW6ywlIC8Gxk=
X-Received: by 2002:aca:3906:: with SMTP id g6mr86101oia.149.1550514481035;
 Mon, 18 Feb 2019 10:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20190215095710.GA12279@linux-x5ow.site> <20190216053133.GT20493@dastard>
 <20190216053957.GU20493@dastard> <66c6ad91-9e8c-a01b-d0c0-ce04e628db67@suse.de>
In-Reply-To: <66c6ad91-9e8c-a01b-d0c0-ce04e628db67@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Feb 2019 10:27:49 -0800
Message-ID: <CAPcyv4gYvf923G62uFhuW+tKwY2cdQ=1xqCudqkmQqRN5W0b-g@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Software RAID Support for NV-DIMM
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 18, 2019 at 2:50 AM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> On 16/02/2019 06:39, Dave Chinner wrote:
> [..]
>
> >> We've supported this since mid 2018 and commit ba23cba9b3bd ("fs:
> >> allow per-device dax status checking for filesystems"). That is,
> >> we can have DAX on the XFS RT device indepently of the data device.
> >>
> >> That is, you set up pmem in three segments - two small identical
> >> segments start get mirrored with RAID1 as the data device, and
> >> the remainder as a block device that is dax capable set up as the
> >> XFS realtime device. Set the RTINHERIT bit on the root directory at
> >> mkfs time ("-d rtinherit=1") and then all the data goes to the DAX
> >> capable realtime device, and all the metadata goes to the software
> >> raided pmem block devices that aren't DAX capable.
> >>
> >> Problem already solved, yes?
> >
> > Sorry, this was meant to be a reply to Dan's email commenting about
> > some people needing mirrored metadata, not the parent that was
> > talking about whole device RAID...
> >
> > i.e. mirrored metadata w/ FS-DAX for data should already be a solved
> > problem...
>
> Trying to answer you both.
>
> But deferring the data redundancy to the application sounds like a no-go
> to me, sorry. We don't do that for "traditional" block storage (SCSI,
> NVMe, you name it). Some applications might already be able to handle it
> but definitively not all. I don't see your random DBMS like MariaDB or
> Postgres already doing data duplication over interleave sets of NV-DIMMs.

Oh, definitely agreed. I was just saying for the subset of
applications that *do* perform application level redundancy the lack
of metadata redundancy was a liability.

> And if you carve out a bit of your pmem space into an own namespace for
> the metadata (did I understand you right here?) you still have the
> problem that all data written to the DIMMs is interleaved in an
> interleave set, if I understand it correctly.
>
> So if one DIMM in your interleave set goes bad, you're lost anyways.

Yes, if you want to be able to survive the loss of a single-DIMM then
you need to disable interleaving and RAID across the DIMMs. However,
once you do that, dax for data can't work by definition, but RAID for
metadata would work.
