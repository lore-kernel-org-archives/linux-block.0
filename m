Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6AC48BD9
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB2E20659
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="IfgUs754"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF0ROk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:14:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35955 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF0ROk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 13:14:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so1559101pfl.3
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6qtClzWticIIkyiv4XHmz7Ek5WrhMquPeHbv1eNgDPA=;
        b=IfgUs754qYJNm23r1ljvfBMdzko/e0dglXK976a8UGwGTfwYKe7SIn/nkuFiiS6C+T
         TY456MHkQTlo4dMKXCF9hVXrVzGCrDH/bOSzSJMXNA/n5ylDN/TjpZcGd6jnvg4qSeMP
         Iaam/Jz2lJxNWGUcQX0XDo4XuC6kVZ9lfrUbvBw3kw4ePcFhNZmQ3GT8T45ME35ZSj/f
         kxVUYYIoIa3PkZQ76JwZH+29G+PTtvN8LINlzpaPodCvZH7mAJqD9Aog9vaUn7Y9a3Pw
         2fznyyPNS53Evu3779JpJ78XHFJMeus9KQYDFZVugRs2WPFmC8cCz116a1zRyEe+kfQ8
         TNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6qtClzWticIIkyiv4XHmz7Ek5WrhMquPeHbv1eNgDPA=;
        b=GocrTN6RHaahmiOx9KIGr/BykkwsaLdrmcdHBdg9/GSwlaHRdLh4LNir9l8vBzzY0W
         2E4N8w1oYd6sKwTqv1ZmHvhSDhEwiBpM/pPkvzhi3c/+uKPNlzDXF23eJHOnWn/rT++r
         +NgQrbYPUzSU+5WJwfn5f0Y6moQWms1Qwg4tdF350WE2NFiCiAqdB0dGXDmKNthD+hzY
         /WSY9KFj/uGanhWR/hiLedmyxDyGha4/Bl5XnxIZHt/4VqblByMCE+G9+1EL8Vnenav5
         cnGnySSvsEOUMcSiOdXjxM6lmxBgqJMhQPJIXjieQPZopPZKr9lHcusVTxaZxCrdgO8J
         KL8A==
X-Gm-Message-State: APjAAAU4e4S05y2S3NUX106h92K6iXv4okxTV8PmJ5WuFnB/bg/ynvpb
        ATmtGM3t1qpGcvjxG+ZgvxHLaCs9TVU=
X-Google-Smtp-Source: APXvYqxqu3+r8pUG+p2uk8I2BorMeSChYG/Z2KcGofYsUefaC4SoSpQnleMjoQpvhYzz2FD/Rhndzg==
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr7216148pjb.21.1561655678900;
        Thu, 27 Jun 2019 10:14:38 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:5b92])
        by smtp.gmail.com with ESMTPSA id v27sm8969358pgn.76.2019.06.27.10.14.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 10:14:38 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:14:38 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Omar Sandoval <osandov@fb.com>,
        Andi Kleen <ak@linux.intel.com>, linux-block@vger.kernel.org
Subject: Re: [REGRESSION] commit c2b3c170db610 causes blktests block/002
 failure
Message-ID: <20190627171438.GA31481@vader>
References: <20190609181423.GA24173@mit.edu>
 <e84b29e1-209e-d598-0828-bed5e3b98093@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84b29e1-209e-d598-0828-bed5e3b98093@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 18, 2019 at 04:09:26PM -0700, Bart Van Assche wrote:
> On 6/9/19 11:14 AM, Theodore Ts'o wrote:
> > I recently noticed that block/002 from blktests started failing:
> > 
> > root@kvm-xfstests:~# cd blktests/
> > root@kvm-xfstests:~/blktests# ./check block/002
> > block/002 (remove a device while running blktrace)
> >      runtime  ...
> > [   12.598314] run blktests block/002 at 2019-06-09 13:09:00
> > [   12.621298] scsi host0: scsi_debug: version 0188 [20190125]
> > [   12.621298]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> > [   12.625578] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> > [   12.627109] sd 0:0:0:0: Power-on or device reset occurred
> > [   12.630322] sd 0:0:0:0: Attached scsi generic sg0 type 0
> > [   12.634693] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> > [   12.638881] sd 0:0:0:0: [sda] Write Protect is off
> > [   12.639464] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
> > [   12.646951] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> > [   12.658210] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
> > [   12.722771] sd 0:0:0:0: [sda] Attached SCSI disk
> > block/002 (remove a device while running blktrace)           [failed]left
> >      runtime  ...  0.945s0: [sda] Synchronizing SCSI cache
> >      --- tests/block/002.out	2019-05-27 13:52:17.000000000 -0400
> >      +++ /root/blktests/results/nodev/block/002.out.bad	2019-06-09 13:09:01.034094065 -0400
> >      @@ -1,2 +1,3 @@
> >       Running block/002
> >      +debugfs directory leaked
> >       Test complete
> > root@kvm-xfstests:~/blktests#
> > 
> > The git bisect log (see attached) pointed at this commit:
> > 
> > commit c2b3c170db610896e4e633cba2135045333811c2 (HEAD, refs/bisect/bad)
> > Author: Andi Kleen <ak@linux.intel.com>
> > Date:   Tue Mar 26 15:18:20 2019 -0700
> > 
> >      perf stat: Revert checks for duration_time
> >      This reverts e864c5ca145e ("perf stat: Hide internal duration_time
> >      counter") but doing it manually since the code has now moved to a
> >      different file.
> >      The next patch will properly implement duration_time as a full event, so
> >      no need to hide it anymore.
> >      Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >      Acked-by: Jiri Olsa <jolsa@kernel.org>
> >      Link: http://lkml.kernel.org/r/20190326221823.11518-2-andi@firstfloor.org
> >      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Is this a known issue?
> 
> Hi Ted,
> 
> Test block/002 removes a SCSI device by writing into the "delete" sysfs
> attribute. As one can see in __scsi_remove_device() that triggers a
> synchronous call of blk_cleanup_queue(). The "debugfs directory leaked"
> message is reported if the request queue debugfs directory is found after
> SCSI device deletion has finished. Request queue debugfs directory deletion
> happens upon the final put of the request queue (see also
> __blk_release_queue()). I don't think that there is any guarantee that the
> debugfs directory disappears immediately after SCSI device deletion has
> finished. In other words, I think that this is a bug in test block/002.
> Omar, are you the author of that test script?

Hi, Bart, yes I wrote this test. I can reproduce the failure. I'll try
to find a reliable way to wait, otherwise I'll probably just toss a
sleep in here.
