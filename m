Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2263CC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8A520672
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="WF3H95yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8A520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeK0Epv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:45:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33703 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeK0Epv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 23:45:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so6238812pfb.0
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lwPoG8dgzVSI7nJr1i7SFabtklxBE7epTzbgC9a/20k=;
        b=WF3H95yVLT/V5bqPDXIJHKylo+0yLCmu6nvVKNLTqBf2VrSw+CPigZc3EiCsPg5xVY
         BtoCfTMYbkbtaWbX8rYMNsHfg7rLJUR7D/7y4+lBf/E4dFdMHy4Oqv2XiveaXrsbLcZg
         3JH/COg3irPc2Q536n0A6+X4IHO6LPCA4sWPXbPSeBlhUSMBfOmz+9yru2AJcEXWbYsz
         t8fMT7+4zF3bi3vshocaKXhPpDGDp0vS0a49m08CWi+mA8SrokmeZNSKTaFCWCeCg6Cy
         Iug1i3fN7XELdmQFCjMYkxVFoQ3Tw6gS4n4YFzVGPuyfsH7zIUBZMgGR9UgVhlFQ/vTj
         1LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lwPoG8dgzVSI7nJr1i7SFabtklxBE7epTzbgC9a/20k=;
        b=sq6HT65b+dWGK5WlzhT+tD4SWtK96HNqvHjShORQklUKQsQ2YU14H7bzsJBMmAAnBr
         wCn9jdPpncIYtivmQGK9qxewAAnsHWK5/5GBuu6/y7oU2Reyw2zt/m1XzGp0LO46yKy0
         C5CSzU7sWUDuMrH/BZDlH6m+LFsRZo6MpAyfOJV26Zco7HFFR03eZiyvXMx2Ki/PejaL
         Pd1okFCo5YOqhjPeZJS0VmveVcl1D30HIsUv3D4flvw9QQFd3/cgE3l5EoG+PLia+p53
         CgHqf4o/+/AAP4Tp7TMBoXYIL1JAVEA3z2XGPp5e80t6RvJgSpAv8ek/uAw0hV58G02e
         XORw==
X-Gm-Message-State: AA+aEWa2f1ubWCzgtSYjA0t20pH7EXLIxpO4B3Q9Jp7l/WR1RMW8FYWX
        +Tydy35iLH5hOYBnJNFcpdimAWwRHfc=
X-Google-Smtp-Source: AFSGD/UsqeJhZQYBfPYA9R3krLKczOupHthN6dBujm0/NOPUkprU3u/sZ5yrvjTx+I8A81c8fkz/Kg==
X-Received: by 2002:a63:9d05:: with SMTP id i5mr15992873pgd.98.1543254660045;
        Mon, 26 Nov 2018 09:51:00 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:fd28])
        by smtp.gmail.com with ESMTPSA id y12sm1465509pfk.70.2018.11.26.09.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 09:50:59 -0800 (PST)
Date:   Mon, 26 Nov 2018 09:50:57 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Add use of logger so that syslog files show
 when each test starts
Message-ID: <20181126175057.GA30411@vader>
References: <20181029161557.7652-1-tytso@mit.edu>
 <20181123010221.GA6311@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123010221.GA6311@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 22, 2018 at 08:02:21PM -0500, Theodore Y. Ts'o wrote:
> Ping?
> 
> 					- Ted
> 					
> On Mon, Oct 29, 2018 at 12:15:57PM -0400, Theodore Ts'o wrote:
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  check | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/check b/check
> > index f6c3537..ebd87c0 100755
> > --- a/check
> > +++ b/check
> > @@ -319,6 +319,7 @@ _call_test() {
> >  		local dmesg_marker=""
> >  		CHECK_DMESG=0
> >  	fi
> > +	$LOGGER_PROG "run blktests $TEST_NAME"
> >  
> >  	trap _cleanup EXIT
> >  	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
> > @@ -578,6 +579,8 @@ fi
> >  eval set -- "$TEMP"
> >  unset TEMP
> >  
> > +LOGGER_PROG="$(type -P logger)" || LOGGER_PROG=true
> > +
> >  if [[ -r config ]]; then
> >  	# shellcheck disable=SC1091
> >  	. config
> > -- 
> > 2.18.0.rc0
> > 

Hey, Ted, sorry, I meant to ask you about this in person at LPC but
forgot to. Forgive my ignorance about syslog, but does syslog not pick
up the line we write to dmesg?
