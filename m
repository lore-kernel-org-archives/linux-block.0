Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FB9C433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A378206B7
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="BBwhJxjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFOXBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXBS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 19:01:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20586C061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 16:01:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so8515603pfi.13
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/rnlpXiiGZdC1LE/20fgWJqgFjZR9jC2KgqGKyNh+Sg=;
        b=BBwhJxjZCDMJR3RfoCpXixmfR8GYO2/X6nf4RvZPQD3Gh8pKttC9nc38YFzSqBPgFQ
         ouZDZuZDR6L6vCHKks39Za6H5drq9it2owCSoTuGZTHsRkpRWYPjoH/PcXsqK4lQJaFt
         84guH/DBXtHuMC43hpydN1WOPkQ4WxNE89eaHGWSRU4laSjVlS59vGp4cBjhWvGxUxgy
         maSPOXCPNxCNk90HIHarV4fdvZesw0nOnXaQO+9s7iPzVnbekkYgfer9i79b0B6obgoq
         mOwpSSiE6tnUzni2LBSeSrykcKIFKm1n0ep8rWQNSvc0zXM9KV2w5Gsq/CkSic/gzuGn
         6iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/rnlpXiiGZdC1LE/20fgWJqgFjZR9jC2KgqGKyNh+Sg=;
        b=hMQ2TIQAop/8OXDcom0r5wOhTg0iq95JI4KCOVfHswv3b68wbduHoYcISxulU6YRBi
         +8tTQDwuRcUSEkumedbydDsQTOYv+sBeyuqULbThDIc22Okx/YFc15iPVpfiDF9jMsdh
         wF3gS4OQA3ySmLMuEzxmmWqTvo4zsjFz2bEodTKaBVkpLTcMM8UV+ZvFNPJ3IdBRMFdL
         dqabH7BxoG1xXhWZuhnsYlJG45/lT9A3P+3rK24ElPYXbRc5sUwF6C1PPd8th3IL7rlp
         6qOpZgcBWYp90XrPxAJ3Zgqd3HGWMPyHTKjrWMEv1DNG4Kruk4fhfbdF6SddtYdPNJI3
         qw4A==
X-Gm-Message-State: AOAM533bpKVOTCS6U/JIWWUo1usVbUdUIa5VBmSmfZnR6kA6XmropQDd
        bsk0vE1pqt/5QsFeocgxAb0/+A==
X-Google-Smtp-Source: ABdhPJwZLT0V8aZ7zXonAAuWjF88EzlllQh7MjBcwocTZmmsGqPGHmBwK4cyHogOfhO6wJ4PjhOH7A==
X-Received: by 2002:a65:458e:: with SMTP id o14mr21539450pgq.87.1592262075676;
        Mon, 15 Jun 2020 16:01:15 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:4fd2])
        by smtp.gmail.com with ESMTPSA id i125sm12434246pgd.21.2020.06.15.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 16:01:14 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:01:13 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Restore support for running tests without prior
 test results
Message-ID: <20200615230113.GA2642892@vader>
References: <20200520165241.24798-1-bvanassche@acm.org>
 <8d53b2a8-c9bf-959c-52a0-bcc649151c6f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d53b2a8-c9bf-959c-52a0-bcc649151c6f@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 09, 2020 at 07:08:45AM -0700, Bart Van Assche wrote:
> On 2020-05-20 09:52, Bart Van Assche wrote:
> > This patch fixes the following runtime error:
> > 
> > ./check: line 245: LAST_TEST_RUN: unbound variable
> > 
> > Fixes: 203b5723a28e ("Show last run for skipped tests")
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  check | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/check b/check
> > index 0a4e539a5cd9..5151d01995ac 100755
> > --- a/check
> > +++ b/check
> > @@ -240,9 +240,15 @@ _output_last_test_run() {
> >  }
> >  
> >  _output_test_run() {
> > +	local param_count
> >  	if [[ -t 1 ]]; then
> >  		# Move the cursor back up to the status.
> > -		tput cuu $((${#LAST_TEST_RUN[@]} + 1))
> > +		if [ -n "${LAST_TEST_RUN+set}" ]; then
> > +			param_count=${#LAST_TEST_RUN[@]}
> > +		else
> > +			param_count=0
> > +		fi
> > +		tput cuu $((param_count + 1))
> >  	fi
> >  
> >  	local status=${TEST_RUN["status"]}
> > 
> 
> Omar, ping?

Sorry Bart, I had a family emergency so I've been away for a few weeks.
This fix didn't work for me for the same reason that Li Zhijian reported
in https://github.com/osandov/blktests/pull/64. For now I'm going to
apply that fix instead. If you'd like blktests to work with set -u,
please do so by adding it to the main check script and modifying the
rest of the framework.
