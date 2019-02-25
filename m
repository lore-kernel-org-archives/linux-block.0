Return-Path: <SRS0=QdhR=RA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C8DC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 17:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F3E2087C
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 17:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2qt0utX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfBYRD3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:03:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39619 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfBYRD3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Feb 2019 12:03:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id i20so4775149pfo.6;
        Mon, 25 Feb 2019 09:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UR8hfqhE4aa8jApKoRXT6gMsPJFMDg+eI2NHscJ5iVQ=;
        b=M2qt0utX7Mwshpou2a29cxE1aaGT+Ynknk8VxiA60rMahoVY19SRKzCGtmqNHFqKg9
         +P0N9EA4HY38uStBFF+NpBjDd+z0VET+f7VaBncmRWakrPTWaImJxlmJvoLiExvML+sH
         y8dH6Hm/4FoAZHZ2oW817hPibSTfdIoLdcG5Yd5GQ/7iiefCrPIHF9+46o1QsEI0Aadp
         PRsmAvk8f+x+e3IRXKomlGj/O2nTrTTQFtxgKOaJvJgMLGbv7LmxWbMavIMRKa+3dHg/
         qiM74p/Gs80GtkAGA6fNn/tWfFLSGi0eCRSKJ0bIMdlZIGfoIfI6WQpkDIIcLffnWbZ7
         eqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UR8hfqhE4aa8jApKoRXT6gMsPJFMDg+eI2NHscJ5iVQ=;
        b=n0WJxIjKMEz/hrV7cUBuzPacguzq6eK5DbmeemBuYphnc6oNT6kvPBlat2TtdNe+r9
         PR66cddL7odPAHPMcpkmUWLZI3qD3Hf+c8i3yuEUmTWI/aEoPgdAJMkKExMEefbmjmNM
         PN2Uz8cZGWnYqEcg1JgHdPr5Q9ar7yzrkNluO4irEKxlJaLT20vnK5BpeeVmVnBJMHca
         kLn2C9YyoO/nkRHr6XErM8F0x1Uvrj4bCIl3cnq/Xgggsa8aF6aOyKGBbPyxK0YUxcXk
         BBrkZh7WGUuSyEJy3f+zgBbDlGEIHbDc3F4SxhOn4wlyhUeguNBD+XYamxOKzPQf5Qs1
         02yQ==
X-Gm-Message-State: AHQUAubIHVA1Ojacec0dVt2pAhtVUBf96UXW07eW61aBYaHrG+vGom0h
        +PQODLrH9V+vLCVFe/cRTZM=
X-Google-Smtp-Source: AHgI3IZckY8GBRC5LL+2y6IOKWFEVMNduE9oZAJetgzjYHpQkcPv5wPEMyVJmyxTcOXo1DtCpKzHBg==
X-Received: by 2002:a63:c745:: with SMTP id v5mr20182029pgg.261.1551114208326;
        Mon, 25 Feb 2019 09:03:28 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id k17sm32038782pfj.92.2019.02.25.09.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:03:27 -0800 (PST)
Date:   Mon, 25 Feb 2019 22:33:22 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] badblocks: Prefer unsigned int over unsigned
Message-ID: <20190225170322.GA10453@bharath12345-Inspiron-5559>
References: <20190224141952.GA3653@bharath12345-Inspiron-5559>
 <b96f9ac8-639c-adfa-e0a4-5ff537bc9db4@kernel.dk>
 <20190224153712.GA11981@bharath12345-Inspiron-5559>
 <CAFLxGvy1fKXEwZJwhD=aCbQ67HO+eK8T27KEfMrLu13ABvO1Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvy1fKXEwZJwhD=aCbQ67HO+eK8T27KEfMrLu13ABvO1Wg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 24, 2019 at 04:50:51PM +0100, Richard Weinberger wrote:
> On Sun, Feb 24, 2019 at 4:38 PM Bharath Vedartham <linux.bhar@gmail.com> wrote:
> > I understand. I am starting out kernel hacking. I have been working on
> > fixing checkpatch.pl warnings. If you have any tasks for me in the
> > kernel, it would be great.
> >
> > I have also noticed a lot of warnings to replace printk with subsystem
> > specific warning functions. Is that a valuable change?
> 
> This is a very good start:
> https://lists.kernelnewbies.org/pipermail/kernelnewbies/2017-April/017765.html
> 
> Happy hacking and welcome! :-)
> 
> -- 
> Thanks,
> //richard

Hey! Thanks for the link Richard! I have read it and clearly understood
the message. I will work on understanding the kernel and writing my own
code for my own personal learning before jumping into tasks! Thanks for
your time!

Bharath
