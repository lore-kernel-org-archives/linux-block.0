Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D96C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D5C2075B
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDoBPhnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfDPRvL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:51:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39302 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPRvL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 13:51:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so10769802pfo.6
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2019 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yh8QIk3MzyPAczfSE14yzpC9uzmKqEZkdOVzS93oE6Y=;
        b=vDoBPhnbS7Mevz6/vipsUC1duXzyryszVNS9G+8YmaOThEqnCoUijv9Awc8fqI84HN
         5YBKOH0q0gn76ClukC2TtRH00804ZFTP3GxsgidW+5i/5XA8XuJGYKEdh3YHYsWF+p4I
         sDEfWOK365grsh7uVZee7z4YThUq5Ut/3st6K6KXN22SNxJekjmrxh5cqPWn3Vlf7/wg
         xWg9YubViNiVmtZ9YAwAJgWkiVKNaWeaJsUn57GzEytiPQI2lJf6YEaa/r0sGzuDj7Pk
         BuCIgjbOc9+hAahW6KxHlbUE+NS3XObRvdxF8KSpOnT9Nvj43SgUm+yzE7NX3P45r3F8
         Mjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yh8QIk3MzyPAczfSE14yzpC9uzmKqEZkdOVzS93oE6Y=;
        b=eZD9AIWsH0evTKoTPZaT7hqxP9I9RGkeZCZsORU6p6RSBRqP3uPyC5bs99c7nM5wmC
         yPKQg0l5asNDddqDvKg/VWj+p0Q7bCuGu+2vy+2NxjA4btgayOhF8DB5fVNIPdI4AOT2
         uFP33JdY1aPPT5ZDSnQr5e3hvi0rnPoTS31mCjKia/x8CMxpC0sSebs6wnW8e9iobM3E
         SfXJR5N64/tRYkclIbWCFOvTaSF7fWUfw+Yq7aO5cYBEgLR5cL+vRHxfuF8yFs2i3OA8
         2McvoBkoFyVH5QRPlko1G+jLAMAv81kdY3kY3QGSikOvGwESY7P+kogsxMU3oUtKig8I
         BYFA==
X-Gm-Message-State: APjAAAUG8pP+R2T1SeXhOrSQjbGW9fBNxJqWQCZsvY9migaZnWZribR4
        FIIkpU5nlil4dEUqR1DuHQY=
X-Google-Smtp-Source: APXvYqzCvb4gz55RdFtIXPeVRCKnN+6ii5AAVb5crZamWPK6qC1j2+2qxm2Oh7wKVMMiE5BmyFg/OA==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr85086882pfb.150.1555437070591;
        Tue, 16 Apr 2019 10:51:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m25sm70748961pfa.175.2019.04.16.10.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:51:09 -0700 (PDT)
Date:   Tue, 16 Apr 2019 10:51:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190416175108.GA9550@roeck-us.net>
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de>
 <20190415194435.GA23676@roeck-us.net>
 <20190415205242.GA6380@lst.de>
 <20190415210731.GA32723@roeck-us.net>
 <20190416063356.GA25763@lst.de>
 <20190416170847.GA5531@roeck-us.net>
 <20190416171011.GA4611@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416171011.GA4611@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 07:10:11PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 16, 2019 at 10:08:47AM -0700, Guenter Roeck wrote:
> > That is besides the point. Your code changes an internal API to be more
> > stringent and less forgiving. This causes failures, presumably because
> > callers of that API took advantage (on purpose or not) of it.
> > When changing an API, you are responsible for both ends. You can not claim
> > that the callers of that API are buggy. Taking advangage of a forgiving
> > API is not a bug. If you change an API, and that change causes a failure,
> > that is a regression, not a bug on the side of the caller.
> 
> As said I offered to fix these, even if this isn't my fault.  I'm also

"even if this isn't my fault"

Here is where we disagree. You introduced the change, you are responsible
for its impact, on both ends.

> still waiting for the the other reports.

I reported everything I know. To summarize, the following tests are confirmed
to fail due to this patch.

arm:vexpress-a9:multi_v7_defconfig:nolocktests:sd:mem128:vexpress-v2p-ca9:rootfs 
arm:vexpress-a15:multi_v7_defconfig:nolocktests:sd:mem128:vexpress-v2p-ca15-tc1:rootfs 
arm:vexpress-a15-a7:multi_v7_defconfig:nolocktests:sd:mem256:vexpress-v2p-ca15_a7:rootfs 
sparc32:SPARCClassic:nosmp:scsi:hd 
sparc32:SPARCbook:nosmp:scsi:cd 
sparc32:SS-5:nosmp:scsi:hd 
sparc32:SS-10:nosmp:scsi:cd 
sparc32:SS-600MP:nosmp:scsi:hd 
sparc32:Voyager:nosmp:noapc:scsi:hd 
sparc32:SS-4:smp:scsi:hd 
sparc32:SS-5:smp:scsi:cd 
sparc32:SS-20:smp:scsi:hd 
sparc32:SS-600MP:smp:scsi:hd 
sparc32:Voyager:smp:noapc:scsi:hd

Detailed logs are available at https://kerneltests.org/builders, and the
test scripts are published at https://github.com/groeck/linux-build-test.

Guenter
