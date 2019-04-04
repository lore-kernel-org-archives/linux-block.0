Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F8DC4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 21:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2187D2171F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554411989;
	bh=BuFQxI2ikN8NPpVkMZ5FitA9s53ugO0kD84lGxTFkbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lP7O/HfSKHCouh+ZgIW94hucT0DV/+YwjROaDPDkYofYj07zNDMOKLz3F62y1PabN
	 obgqnuljdcJriUdhMR47l491XmRrYBK0CZR+s3/E6PyNxG86RmOhTr/vu4rfjYlmmu
	 5LHwLPQMTE0to+2dhD0tTUJYdzFib0v7voWPR8ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfDDVG2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:06:28 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33252 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfDDVG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 17:06:28 -0400
Received: by mail-yb1-f194.google.com with SMTP id i10so1614621ybk.0
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 14:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pe8/Fr0oR95Pa3OVVYApTU1hG+erIsTLlqavTfXLZ34=;
        b=ch9qDVYrNna5crnuDjufwv4uOc+/KC6uzxQ1KrQOU5kK9//UDzMHpWEnQBLXRfHaE+
         17MsEScfvGD6L/EAlEZdgJMhoJgPXTXiDs1j1DkDIens4Bq+jCjG91V3icDtoah55hrk
         yt6UmtPY3rfQq4SvZhJ6XPAbAwZtxTfKwfQ6OsukkWdB9hlYtPQgOnVHcRIcs2l2sQG6
         NI7fdP3PIUxuc+KYKxpVshKYeXOBrYB5KuQw3MjKTahzrFBQYUyTzI9uoxOiTeEu26xG
         0NuPz4hQ6JvwWijXcgyE8wh1eW9CUDZSZuXuWVvwMxNFsB4N1LoPq9pqqc3b7co3JXoh
         7LVg==
X-Gm-Message-State: APjAAAWIEAiay4FokTXRFCy+MDYQZwEpC1kTMQLiAryiNSxAtxD/96Q1
        0KRKLvk7JcvDIrq3tNc+g58=
X-Google-Smtp-Source: APXvYqw1gpSi/G7uDm0jXUDrJ4N6NZeylhI+Yf69gIqRF7A0Eu/jrlxpxXxsVM7JQnXWRtXd6tas+Q==
X-Received: by 2002:a25:a049:: with SMTP id x67mr7427792ybh.3.1554411987678;
        Thu, 04 Apr 2019 14:06:27 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::1:ff2f])
        by smtp.gmail.com with ESMTPSA id h3sm8182459ywa.61.2019.04.04.14.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 14:06:26 -0700 (PDT)
Date:   Thu, 4 Apr 2019 17:06:24 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Dennis Zhou <dennis@kernel.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix fio jobs for 027 and add cgroup support
Message-ID: <20190404210624.GA20575@dennisz-mbp.dhcp.thefacebook.com>
References: <20190329221432.38726-1-dennis@kernel.org>
 <20190404180224.GA25741@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404180224.GA25741@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 04, 2019 at 11:02:24AM -0700, Omar Sandoval wrote:
> On Fri, Mar 29, 2019 at 03:14:32PM -0700, Dennis Zhou wrote:
> > Previously, the test was broken as "$fio_jobs" was considered as a
> > string instead of additional parameters. This is fixed here.
> > 
> > Second, there was an issue with earlier kernels when request lists
> > existed such that request_queues were never being cleaned up because
> > non-root blkgs took a reference on the queue. However, blkgs were being
> > cleaned up after the last reference to the request_queue was put back.
> > This creates a blktest cgroup for the fio jobs to utilize and should be
> > useful for catching this scenario in the future.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> Would it be valuable to test this both in a cgroup and not in a cgroup?
> 

I lean towards no because testing in a cgroup should subsume testing not
in a cgroup.

> >  tests/block/027 | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/block/027 b/tests/block/027
> > index b480016..36e88b4 100755
> > --- a/tests/block/027
> > +++ b/tests/block/027
> > @@ -26,6 +26,13 @@ scsi_debug_stress_remove() {
> >  		return
> >  	fi
> >  
> > +	_init_cgroup2
> > +
> > +	# setup cgroups
> > +	echo "+io" > "/sys/fs/cgroup/cgroup.subtree_control"
> > +	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
> > +	mkdir "$CGROUP2_DIR/fast"
> > +
> 
> Why is this called "fast"?
> 

I just picked a name from Josef's test. I was hesitant to use
${TEST_NAME} because of the /, but there's no reason that's not okay.

> >  	# set higher aio limit
> >  	echo 524288 > /proc/sys/fs/aio-max-nr
> >  
> > @@ -45,13 +52,13 @@ scsi_debug_stress_remove() {
> >  		((cnt++))
> >  	done
> >  
> > -	local num_jobs=4 runtime=21
> > +	local num_jobs=4 runtime=12
> >  	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
> >  		--iodepth=2048 --numjobs=$num_jobs --bs=4k \
> >  		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
> > -		--loops=10000 "$fio_jobs" > "$FULL" 2>&1 &
> > +		--loops=10000 --cgroup=blktests/fast $fio_jobs > "$FULL" 2>&1 &
> >  
> > -	sleep 7
> > +	sleep 6
> 
> Is there any particular reason you changed the run time and sleep time
> and added the sleep at the end?
> 

Validating this is a little tricky because we don't export statistics
around blkgs. The change in runtime and sleep here is just to shorten
the test. Enough time has passed that everything is setup and enough IOs
go through and fail to be sure that this all works.

The sleep below should probably be a little shorter, but it's to more
easily validate that the blkg cleanup is due to request_queue cleanup
vs cgroup cleanup. Prior, I made a bad assumption that everything was
okay due to always cleaning up the cgroup when in reality request_queue
cleanup was failing first.

> >  	local device_path
> >  	for dev in "${SCSI_DEBUG_DEVICES[@]}"; do
> >  		# shutdown devices in progress
> > @@ -61,6 +68,10 @@ scsi_debug_stress_remove() {
> >  
> >  	wait
> >  
> > +	sleep 10
> > +
> > +	_exit_cgroup2
> > +
> >  	_exit_scsi_debug
> >  }
> >  
> > -- 
> > 2.17.1
> > 

I'll send a v2 switching the naming to ${TEST_NAME} + shortening the
last sleep.

Thanks,
Dennis
