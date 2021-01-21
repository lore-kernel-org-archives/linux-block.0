Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA32C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 15:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10462238E3
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 15:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbhAUPKI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732421AbhAUPGq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 10:06:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 712DC235FF;
        Thu, 21 Jan 2021 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611241556;
        bh=qRBq4u7IBFJWAXc+l6+Z4BWGpd3fk5F9IR1G/OirCzw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uWwiMQ8WxDMfmMeAE+vYHFkePF5KTk6uBeasfNO/dnCJ7nvQE0ZBnK78g/OkrtQES
         gVP8X9klIuBGtZDmQOXMrLFqMh7ELL7k+IeSomNgF6Kcfyv6doEdJUrhs+iOIVpDTH
         i1GaGf4AUQa8zDlDuOFnugysBdrKExBWhI5CASF1r2mxORZWaPaP8vIZuE6/j0jfqg
         JNl1y/cL69uo0eVohMe3AQJp4yYs34Cj2ZrR356csQzmiJWZrcRMxEvtt6kpAT+La9
         H/PFRYZrN6hpe4jXhjuYKWSXNvbmYclNg6SM/5MIo/wKchuW2idSUsWZk/qtEa2/BH
         XLMvIUG4nI5aA==
Date:   Thu, 21 Jan 2021 16:05:52 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Efremov <efremov@linux.com>
cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
In-Reply-To: <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
Message-ID: <nycvar.YFH.7.76.2101211603590.5622@cbobk.fhfr.pm>
References: <20160610230255.GA27770@djo.tudelft.nl> <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm> <20160614184308.GA6188@djo.tudelft.nl> <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm> <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm> <20160615224722.GA9545@djo.tudelft.nl> <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm> <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm> <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm> <5cb57175-7f0b-5536-925d-337241bcda93@linux.com> <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm> <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm> <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Jan 2021, Denis Efremov wrote:

> > From: Jiri Kosina <jkosina@suse.cz>
> > Subject: [PATCH v2] floppy: reintroduce O_NDELAY fix
> > 
> > Originally fixed in 09954bad4 ("floppy: refactor open() flags handling")
> > then reverted for unknown reason in f2791e7eadf437 instead of taking
> > the open(O_ACCMODE) for ioctl-only open fix, which had the changelog below
> > 
> > ====
> > Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
> > side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
> > this is being used setfdprm userspace for ioctl-only open().
> > 
> > Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE)
> > modes, while still keeping the original O_NDELAY bug fixed.
> > 
> > Cc: stable@vger.kernel.org # v4.5+
> 
> Are you sure that it's not worth to backport it to LTS v4.4? Because 
> f2791e7ead is just a revert and 09954bad4 is not presented in v4.4 I'm 
> not sure what fixes tag is better to use in this case.

You are right; I'll drop the '4.5+' indicator and will backport it once/if 
it hits Linus' tree.

> > +	if (mode & (FMODE_READ|FMODE_WRITE)) {
> > +		UDRS->last_checked = 0;
> 
> UDRS will still break the compilation here.

Doh, forgot to refresh before sending, sorry for the noise.
I'll send the final version once I get confirmation from the reporter that 
it's fixing the issue properly, add his Reported-by: etc.

Thanks,

-- 
Jiri Kosina
SUSE Labs

