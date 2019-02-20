Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F384AC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F4221841
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Y4fTRZ2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfBTSYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:24:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35086 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfBTSYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 13:24:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so12288103pgs.2
        for <linux-block@vger.kernel.org>; Wed, 20 Feb 2019 10:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZ7TkL1FslkE3S0an31JRXMZYOnfRcmJ3Jm6QbARa3Q=;
        b=Y4fTRZ2jnZiuA1vdNGxEO7lhLqvdl1cAb2Vn9R+mTS84Wk5hlMbfT4qjiev/XEayNl
         M88dv5ROuLuAQg6Ikr4uLByK7uIRewRH2nFoGHxZwTAbN3DVOlp9AU3DFGj7h+in1rkk
         LROzcP/pejma/Ny8mS+9aFrRGutvlKcq7WeuIqHOb+pt/asS1ROgFdcVn7JgvzP1Rgwn
         ruSKF2PeSSZwceCGjGh5CaeefeM1vpYbYvcmttAk7a01/z94tS9hY9AMgF5ZFpxmqLac
         if+L8/Os5UkGVWsURIqQMaHGmHdIud3mzyuuYnNm2t6xq93KhCCT06kyGpMthpUlR/Fa
         tCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZ7TkL1FslkE3S0an31JRXMZYOnfRcmJ3Jm6QbARa3Q=;
        b=P90vHQdLKXdYOss7KHjTEQorIJ4mbN1JW0fKWZlf7BjrITyuDhKybtXqzoINgbjcot
         seehdNSSj9uP0QuCljDaXCvtc96gLq/a9ITRJb6nbhlQBtTHTJaYEiG9nFpcbW2AeU+l
         o8555KHazlRmXzKsHsGirXpAOFYh6fPzOGUXgK7BXNAQoZl96iFwJ/mvKGiG21SwiOJD
         XLdIYv4H6V9nxRHB0nfdPfbJGPkXh7VxGqSzw2APb7hDhJ94zBerT1nS8dmLQnMvPnwd
         q/N4kP3YzeqZndiCGHe6Ecd6hUmxqMGsySFFIrpIzWjErpD0xZFsu54LA8ghitp37HiC
         4GJg==
X-Gm-Message-State: AHQUAuZ6zKY4I7k2dI3U+FVFuQKjp8/7NF2rf6fDZ/4tAbpJeEFmEE29
        9x8hyyroEH/j/gKs543n8UkZwA==
X-Google-Smtp-Source: AHgI3IZu60rTlX62sIVOl7C+LJJtwLN5Wt1WFaJWG8zM7Fmd6B6aCPGkEi5uycdJbiPz4SSH/ih2rg==
X-Received: by 2002:a63:4f58:: with SMTP id p24mr16271271pgl.283.1550687040841;
        Wed, 20 Feb 2019 10:24:00 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id q7sm53652882pfa.119.2019.02.20.10.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:24:00 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:23:59 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH 1/8] nvme/021: use consistent coding style
Message-ID: <20190220182359.GD8325@vader>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550618905-4112-2-git-send-email-chaitanya.kulkarni@wdc.com>
 <20190220181042.GB8325@vader>
 <SN6PR04MB4527E6227D11DE9066855F55867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4527E6227D11DE9066855F55867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 06:19:58PM +0000, Chaitanya Kulkarni wrote:
> On 02/20/2019 10:11 AM, Omar Sandoval wrote:
> > On Tue, Feb 19, 2019 at 03:28:18PM -0800, Chaitanya Kulkarni wrote:
> >> ---
> >>   tests/nvme/021     | 15 ++++++---------
> >>   tests/nvme/021.out |  1 -
> >>   2 files changed, 6 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/tests/nvme/021 b/tests/nvme/021
> >> index 8e9512a..f204a2f 100755
> >> --- a/tests/nvme/021
> >> +++ b/tests/nvme/021
> >> @@ -38,11 +38,13 @@ test() {
> >>   	cat "/sys/block/${nvmedev}n1/uuid"
> >>   	cat "/sys/block/${nvmedev}n1/wwid"
> >>
> >> -	nvme list > /dev/null 2>&1
> >> -
> >> -	rc=$?
> >> +	if ! nvme list | grep -q "${nvmedev}n1" > /dev/null 2>&1; then
> >> +		echo "Test Failed"
> >> +	else
> >> +		echo "Test complete"
> >> +	fi
> >>
> >> -	nvme disconnect -n "${subsys_name}"
> >> +	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
> >>
> >>   	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> >>   	_remove_nvmet_subsystem "${subsys_name}"
> >> @@ -53,9 +55,4 @@ test() {
> >>   	modprobe -r nvme-loop
> >>   	modprobe -r nvmet
> >>
> >> -	if [ $rc -ne 0 ]; then
> >> -		echo "Test Failed"
> >> -	else
> >> -		echo "Test complete"
> >> -	fi
> >>   }
> >> diff --git a/tests/nvme/021.out b/tests/nvme/021.out
> >> index 5fb0601..b6b1a7c 100644
> >> --- a/tests/nvme/021.out
> >> +++ b/tests/nvme/021.out
> >> @@ -1,5 +1,4 @@
> >>   Running nvme/021
> >>   91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >>   uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >> -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >>   Test complete
> >> --
> >> 1.8.3.1
> >>
> >
> > For all of these, I think it'd be useful to have a more descriptive
> > error, like so:
> >
> > diff --git a/tests/nvme/021 b/tests/nvme/021
> > index 8e9512a..0b215c4 100755
> > --- a/tests/nvme/021
> > +++ b/tests/nvme/021
> > @@ -38,9 +38,9 @@ test() {
> >   	cat "/sys/block/${nvmedev}n1/uuid"
> >   	cat "/sys/block/${nvmedev}n1/wwid"
> >
> > -	nvme list > /dev/null 2>&1
> > -
> > -	rc=$?
> > +	if ! nvme list | grep -q "${nvmedev}n1"; then
> > +		echo "NVMeOF device not listed"
> > +	fi
> >
> >   	nvme disconnect -n "${subsys_name}"
> >
> > @@ -53,9 +53,5 @@ test() {
> >   	modprobe -r nvme-loop
> >   	modprobe -r nvmet
> >
> > -	if [ $rc -ne 0 ]; then
> > -		echo "Test Failed"
> > -	else
> > -		echo "Test complete"
> > -	fi
> > +	echo "Test complete"
> >   }
> >
> 
> Okay, will send out a new version along with if any more
> comments that you have.

The same comment applies for the rest, but I don't have any other
concerns.
