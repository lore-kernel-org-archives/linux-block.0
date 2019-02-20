Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8438C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922B62147A
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 19:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="N4O2NG++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfBTTfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:35:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41800 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfBTTfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 14:35:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so12370778pgq.8
        for <linux-block@vger.kernel.org>; Wed, 20 Feb 2019 11:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3SmdO4z7GSpLxjJgTizYtNhQ7jwCBg0I0NDDYVKdkdk=;
        b=N4O2NG++y5nj29cakbISE6ZH4Y3da6nHZAfG926vhE2/qlu4t7EByVk49Alssvzb35
         YwbUMw/Ogd6bR5lmmCS94LSkCsAUmmPEXXMn8tJ3fMrCYtzHkVVO6Khxcm11AvCuIIFa
         9TSdNbpYA2BYDUZFuA8rc1jLlTbaTeT4TnWEqFDGA6DeQGr9MJXKzp7v9osfWgKgDnxn
         4HR5k/KeRBCAflnyLOlYm64zI/JVM5V56q/gYf0LKSZXiPf+ZTyu4dQ1LnCCFbXrLDm9
         jDkIMpy3SjEDzX0BViZGsna7gYC9zIaQXARH9AtavUg1JGZYQDbRkMZTnc7zg+F85IFt
         Xh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SmdO4z7GSpLxjJgTizYtNhQ7jwCBg0I0NDDYVKdkdk=;
        b=I3cC6OQrW6wcb4Qu8gVhgRfOBIWTTelfRPN5PmO60wMfKSuyAApUM+6FoxkJ8Xc0qy
         nw+fvWkZ063rWtIN/OXqK1qDGSn4KlUGR04hSK+v+iHdirZAgi1Oc2FylGpb3/XrEWe2
         Wo34Adh3/hifIEf7XLwv0cCEv2T6UukQnWlUaKlWiDr3sk4wyi3KtiKu9gA+JufaBxgp
         q5GZpvV/ncStQL8J1yae06khsW+V448U/WaodFJrzQ4O/srEh7Cu6nQYUCKBPojEAR77
         jRQoLC1leu8ISxggFKk2Blps1moz/cgOtjt2Mzi2Tb4ltKVuBxyh2uQmb6n2+LMTnzGg
         SuEQ==
X-Gm-Message-State: AHQUAuZdl7GV/KAF+H+Sn186Dta6+mGDz+6wLwm1LB2DoTC8NncALbZC
        lSSAP8n7mxB8v8/OSLvrQxR2Sbd1biA=
X-Google-Smtp-Source: AHgI3IatyVGsTQrONN+CCYly5yFvtSfnhFK+gUuAtYiUannyFhSoPpKNavnUmc6OPJMdrV40igCcaA==
X-Received: by 2002:a63:2ccd:: with SMTP id s196mr30464651pgs.194.1550691301750;
        Wed, 20 Feb 2019 11:35:01 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id f81sm30591074pff.97.2019.02.20.11.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 11:35:01 -0800 (PST)
Date:   Wed, 20 Feb 2019 11:35:00 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Message-ID: <20190220193500.GE8325@vader>
References: <1550607835-11755-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550607835-11755-2-git-send-email-chaitanya.kulkarni@wdc.com>
 <20190220180327.GA8325@vader>
 <SN6PR04MB4527D0FAE8B353AEA45E0CD8867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4527D0FAE8B353AEA45E0CD8867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 06:28:50PM +0000, Chaitanya Kulkarni wrote:
> On 02/20/2019 10:04 AM, Omar Sandoval wrote:
> > On Tue, Feb 19, 2019 at 12:23:53PM -0800, Chaitanya Kulkarni wrote:
> >> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> >> ---
> >>   tests/nvme/002.out | 4996 ++++++++++++++++++++++++++--------------------------
> >>   1 file changed, 2498 insertions(+), 2498 deletions(-)
> >>
> >> diff --git a/tests/nvme/002.out b/tests/nvme/002.out
> >> index aa71d8f..abecda5 100644
> >> --- a/tests/nvme/002.out
> >> +++ b/tests/nvme/002.out
> >> @@ -1,11 +1,11 @@
> >>   Running nvme/002
> >>
> >> -Discovery Log Number of Records 1000, Generation counter 1000
> >> +Discovery Log Number of Records 1000, Generation counter 2000
> >>   =====Discovery Log Entry 0======
> >>   trtype:  loop
> >>   adrfam:  pci
> >>   subtype: nvme subsystem
> >> -treq:    not specified
> >> +treq:    not specified, sq flow control disable supported
> >>   portid:  X
> >>   trsvcid:
> >>   subnqn:  blktests-subsystem-0
> >
> > [snip]
> >
> > Why did this output change? An nvme-cli change, or a kernel change, or
> > something else? And will this now fail with older versions of nvme-cli
> > or the kernel instead?
> >
> 
> This change is specific to nvme-cli only.
> 
> It should fail on older cli versions, we want latest cli/tools to be 
> used when running these testcases so that all the latest tools are
> also been tested for the compliance, else we might be running tests
> with any bugs with older version(s) which are fixed already.
> 
> Actually I'd like to add quick nvme-cli version check at the start of 
> each test that will certainly help/force user to have a latest version.

Perfect, I was going to suggest adding a check for the minimum version
needed for each test.
