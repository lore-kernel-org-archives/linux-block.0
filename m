Return-Path: <SRS0=qLSf=3R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEC2C2D0DB
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5033324681
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 16:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC2DVCpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgA1Q0m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:26:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725974AbgA1Q0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 11:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580228801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqVtRSzkoJjQLEgbdqSGEvfYPpwwOebXPgY4TxBNfDM=;
        b=fC2DVCpPpNE6N08v7efcXeKu6GYAj+Sj8vjEUP9Cb85RfFNNZZZl3RXY/k9c+rWyR+2U2g
        qdRH3tfjPJ5V+VE0jE3Ufv9ctZ4dFswZvtQ1sTGvW1s5iDwGIiGtgY7ul7+h4O3Lh7Akvo
        X/saqig9dNbjaM4uFsAAt+k5yUk45Vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-BRPZhQCpNfWq0jyeUaDVNA-1; Tue, 28 Jan 2020 11:26:17 -0500
X-MC-Unique: BRPZhQCpNfWq0jyeUaDVNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB3A48C05D2;
        Tue, 28 Jan 2020 16:26:16 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A189863DE;
        Tue, 28 Jan 2020 16:26:11 +0000 (UTC)
Date:   Tue, 28 Jan 2020 11:26:10 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Stefan Bader <stefan.bader@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Tyler Hicks <tyler.hicks@canonical.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
Message-ID: <20200128162610.GA15575@redhat.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
 <20200123103541.GA28102@redhat.com>
 <20200123172816.GA31063@redhat.com>
 <81055166-37fb-ad65-6a53-11c22c626ab1@kernel.dk>
 <20200127193225.GA5065@redhat.com>
 <e0475dae-a55f-f30e-a82f-ee35cdb171c4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0475dae-a55f-f30e-a82f-ee35cdb171c4@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 28 2020 at  9:32am -0500,
Stefan Bader <stefan.bader@canonical.com> wrote:

> On 27.01.20 20:32, Mike Snitzer wrote:
> > 
> > I just staged the following DM fix:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.6&id=28a101d6b344f5a38d482a686d18b1205bc92333
> 
> Thanks Mike,
> 
> yeah this looks like it resolves the problem without adding any impact on the
> generic I/O path. We certainly had thought about that but felt uncertain whether
> it would not open other risks. Like something adding requests just before the
> table load. Could this cause some I/O be handled by one function and the rest by
> another? And would that really matter?

I considered this too.  Any IO issued to the device before it is "ready"
won't matter anyway (no where to send the IO due to not having a DM
table -- such IO should result in an error (from dm.c:dm_process_bio's
!map check).  But given the device has no size, a simple write will hit
-ENOSPC before.

And the only way to get the DM device to have a proper destination for
its IO is to load a table, which requires a sequence like:

# dmsetup create -n test
# dmsetup table
test:
# echo "0 20971520 linear 259:0 2048" | dmsetup load test
# dmsetup table --inactive
test: 0 20971520 linear 259:0 2048
# dmsetup suspend test
# dmsetup resume test
# dmsetup table
test: 0 20971520 linear 259:0 2048

And once a table is loaded there will be accompanying change
uevents that trigger udev, blkid, etc.

(NOTE: the suspend phase implies a flush of all outstanding IO, but even
if 'dmsetup suspend --noflush test' were used the IO would just get
pushed onto a list in DM core and it would be issued after the new table
is in place).

> The other thing that was a bit strange but maybe someone else's problem is that
> mount generated I/O requests to start with. The device size should be 0 still.

That's just mount not having a negative check for device size being 0.

Mike

