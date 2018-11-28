Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D6DC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B9B2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B9B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeK1Qdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:33:31 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:31666 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbeK1Qda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:33:30 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 28 Nov 2018 16:03:04 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gRsT9-00049X-EY; Wed, 28 Nov 2018 16:33:03 +1100
Date:   Wed, 28 Nov 2018 16:33:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20181128053303.GL6311@dastard>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 08:49:44PM -0700, Allison Henderson wrote:
> Motivation:
> When fs data/metadata checksum mismatch, lower block devices may have other
> correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
> decides that the metadata is garbage, today it will shut down the entire
> filesystem without trying any of the other mirrors.  This is a severe
> loss of service, and we propose these patches to have XFS try harder to
> avoid failure.
> 
> This patch prototype this mirror retry idea by:
> * Adding @nr_mirrors to struct request_queue which is similar as
>   blk_queue_nonrot(), filesystem can grab device request queue and check max
>   mirrors this block device has.
>   Helper functions were also added to get/set the nr_mirrors.
> 
> * Expanding bi_write_hint to bi_rw_hint, now @bi_rw_hint has three meanings.
>  1.Original write_hint.
>  2.end_io() will update @bi_rw_hint to reflect which mirror this i/o really happened.
>  3.Fs set @bi_rw_hint to force driver e.g raid1 read from a specific mirror.
> 
> * Modify md/raid1 to support this retry feature.
> 
> * Add b_rw_hint to xfs_buf
>   This patch adds a new field b_rw_hint to xfs_buf.  We will use this to set the
>   new bio->bi_rw_hint when submitting the read request, and also to store the
>   returned mirror when the read compleates

One thing that is going to make this more complex at the XFS layer
is discontiguous buffers. They require multiple IOs (and therefore
bios) and so we are going to need to ensure that all the bios use
the same bi_rw_hint.

This is another reason I suggest that bi_rw_hint has a magic value
for "block layer selects mirror" and separate the initial read from
the retry iterations. That allows us to let he block layer ot pick
whatever leg it wants for the initial read, but if we get a failure
we directly control the mirror we retry from and all bios in the
buffer go to that same mirror.

> We're not planning to take over all 16 bits of the read hint field; just looking for
> feedback about the sanity of the overall approach.

It seems conceptually simple enough - the biggest questions I have
are:

	- how does propagation through stacked layers work?
	- is it generic/abstract enough to be able to work with
	  RAID5/6 to trigger verification/recovery from the parity
	  information in the stripe?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
