Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B6CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AC621872
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="rVJLXt7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440061AbfJXR6v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:58:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39418 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440060AbfJXR6v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:58:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so15607274pff.6
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DlzLUF/hdzVRviV+LyYpZCwUi0UNhkx3WEXO/N3jm1k=;
        b=rVJLXt7pbEr4dIzfpLr2nqcTEO83EBA1S/emI+6MH2R6hcYT/4ZAR6OKoVyDf5CCaQ
         7/RRaT9Vi1FbYfy/8A/6ZqNeqj/0HR9hJ8mecivaUT62XzD91Ael4wfiT7sr0rd6yn6E
         fqcIWQQ+HHGtMkSlfl1rBjI+z7AMgMbvQy1e0XkQUHNwgd1Mr6NUHsVDLlK/KpvznQ0b
         QZzJMXNecj0d6tZtYjMe6oFnxNPt+CpPVBFHWi2nbM19rN8sBuiXjxWksA1md+v75rwj
         O+102/8urG+eF1sy5If9uZO50Qb4PZdHNPObSpf5yku3LH1woQmYnGBp5UNE5t01x8fU
         mK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DlzLUF/hdzVRviV+LyYpZCwUi0UNhkx3WEXO/N3jm1k=;
        b=tOMYYQ+PtWrSvK227wHj9sKj9luawDew+OKqE3Ozl/uiiiY8ck+losG1iA9+6AfEgD
         dBFUQ+Sss3LZ5HuybYMqS60fkD5s9c0ZUm3whx+nohufcTGx7RT7aenkaVg1pHQD1THu
         6w5451v4oC18PenbFNvM5fJQJdhecJGycg8Fsv2NV1tqkoGa7e5e/YEoxKk0gjPhteAw
         dIj+m22phJQRV4gbxIebznZp9cofqtkGLooiOuDo+OmQCv7w0iPyCyD8HStESxL8Zoa8
         8gv/SIPHlKAlDPR5uA+iKqN0BX3RTsQfLHpyvS4YCIgcWaEXOFTcXwFWUQZj2BYEUeKJ
         wbyw==
X-Gm-Message-State: APjAAAUsvvyQYzUtNIkBKyx/cUIoxZMfwHjdFXo2rh1o7g+5d5nPYwSD
        JjF6+oill9WMbNi7yA88KJdnjw==
X-Google-Smtp-Source: APXvYqzgUi3sjqqe8/m1dt0aLzYGxnp5/aVDlrqEe54Hx5YioIPZQnFk2wEnw0ASO+mDJGgcVSVAJg==
X-Received: by 2002:a17:90a:a00e:: with SMTP id q14mr8914816pjp.132.1571939930531;
        Thu, 24 Oct 2019 10:58:50 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id 6sm2883072pfz.156.2019.10.24.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:58:49 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:58:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests 2/2] Add a test that triggers
 blk_mq_update_nr_hw_queues()
Message-ID: <20191024175848.GD137052@vader>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-3-bvanassche@acm.org>
 <20191024174242.GB137052@vader>
 <03e57c18-83b0-2b53-48b9-84d56b216553@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e57c18-83b0-2b53-48b9-84d56b216553@acm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 24, 2019 at 10:55:06AM -0700, Bart Van Assche wrote:
> On 10/24/19 10:42 AM, Omar Sandoval wrote:
> > On Mon, Oct 21, 2019 at 03:57:19PM -0700, Bart Van Assche wrote:
> > > +# Configure one null_blk instance.
> > > +configure_null_blk() {
> > > +	(
> > > +		cd /sys/kernel/config/nullb || return $?
> > > +		(
> > > +			mkdir -p nullb0 &&
> > > +				cd nullb0 &&
> > > +				echo 0 > completion_nsec &&
> > > +				echo 512 > blocksize &&
> > > +				echo 16 > size &&
> > > +				echo 1 > memory_backed &&
> > > +				echo 1 > power
> > > +		)
> > > +	) &&
> > > +	ls -l /dev/nullb* &>>"$FULL"
> > 
> > What's the point of these nested subshells? Can't this just be:
> > 
> > configure_null_blk() {
> > 	cd /sys/kernel/config/nullb &&
> > 	mkdir -p nullb0 &&
> > 	cd nullb0 &&
> > 	echo 0 > completion_nsec &&
> > 	echo 512 > blocksize &&
> > 	echo 16 > size &&
> > 	echo 1 > memory_backed &&
> > 	echo 1 > power &&
> > 	ls -l /dev/nullb* &>>"$FULL"
> > }
> 
> The above code is not equivalent to the original code because it does not
> restore the original working directory.
> 
> When using 'cd' inside a subshell, the working directory that was effective
> before the 'cd' command is restored automatically when exiting from the
> subshell. I prefer using 'cd' in a subshell instead of using pushd / popd
> because with the former approach the old working directory is restored no
> matter how the exit from the subshell happens.

Ah, right, I didn't pay enough attention to the cd. In that case, I'd
prefer not doing the cd at all. Something like:

configure_null_blk() {
	local nullb0="/sys/kernel/config/nullb/nullb0"
	mkdir -p "$nullb0" &&
	echo 0 > "$nullb0/completion_nsec" &&
	echo 512 > "$nullb0/blocksize" &&
	echo 16 > "$nullb0/size" &&
	echo 1 > "$nullb0/memory_backed" &&
	echo 1 > "$nullb0/power" &&
	ls -l /dev/nullb* &>>"$FULL"
}

> > > +modify_nr_hw_queues() {
> > > +	local deadline num_cpus
> > > +
> > > +	deadline=$(($(_uptime_s) + TIMEOUT))
> > > +	num_cpus=$(find /sys/devices/system/cpu -maxdepth 1 -name 'cpu[0-9]*' |
> > > +			   wc -l)
> > 
> > Please just use nproc. Or even better, can you just read the original
> > value of /sys/kernel/config/nullb/nullb0/submit_queues? Or does that
> > start at 1?
> 
> I will have a closer look and see which alternative works best.

Thanks!
