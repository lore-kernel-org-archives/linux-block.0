Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A8C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 21:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1C8214C6
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 21:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545082112;
	bh=qTL/oj7ZiO+0JiKGHEvcg8NE3WggL+eYluASmXssyG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z4bViDzTkaluXM8QiJSLtwO49Vyoj3LZT2XB6CE0TaHnYM5TbLjZdkGbi+8UFaA7p
	 4xnf1Oyw7WSVYBodmFXdOXtw5PjHwCkE0PiooiQa6gJ9oCKc6Xoonb2uoURy8MJA2Y
	 LpsvxcOoG7IWjMH2Mna5K1OxGqZxjczihMwemn4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbeLQV2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:28:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40592 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeLQV2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 16:28:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so8261300qki.7;
        Mon, 17 Dec 2018 13:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hICT8iegwCs+8IKlBLqosthCdlIAWqoprn338q3xsdE=;
        b=aIRPOKn1obThGB6E3dWqMtfRVsYceHVvCoAfx+Sdtv5Kt3hgV26gMMziIfqNjRAC8f
         3b2U2MUUmzZMCXZbEPMFwivNdaosaf82nUEwSk8IfUIuQ4to7R5QqucM4dphrlblA+uz
         VASUjRCN3sSPC5JN2vNTLzIFYPSWy8gvOw7erucIkzm3xuG36KbzsGMpZSNL+pXSbYYw
         PGTHMdppQ8Ph3lBjHzGRrPtJLWWhyVo4yU6Qyn0pUNt8RSCNanCuUVRgAvzt0//VHEvT
         /Up9IrFa5sMcEVCh3gAqbE+BwPJezZ8me0oPTb1NJbHx/2NqwePruV26zON6udVPaATz
         i9Ng==
X-Gm-Message-State: AA+aEWZxMB5EET0v4I6U0Yx5xmqkrFHyOxXeDE4wNMyZj2mLkQt1Aeup
        r2d6a5d9jqsdQ94Qqix6JPU=
X-Google-Smtp-Source: AFSGD/WJljSDUuf3JCJY2+THbbVhJZIw3augeggiVVWPK+6M69I5jalE0ArBEDajRgOPj+8rihGTxg==
X-Received: by 2002:a37:1054:: with SMTP id a81mr13241242qkh.150.1545082109511;
        Mon, 17 Dec 2018 13:28:29 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::6:416f])
        by smtp.gmail.com with ESMTPSA id y70sm7435858qka.75.2018.12.17.13.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 13:28:28 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:28:26 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Liu Bo <obuil.liubo@gmail.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: fix blk-iolatency accounting underflow
Message-ID: <20181217212826.GA71824@dennisz-mbp.dhcp.thefacebook.com>
References: <20181217160351.27903-1-dennis@kernel.org>
 <CANQeFDAO5PdMOrZnn0UgFHcHGvXEs7qS9Kqrk1KRCAwgfRzSOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQeFDAO5PdMOrZnn0UgFHcHGvXEs7qS9Kqrk1KRCAwgfRzSOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 11:42:28AM -0800, Liu Bo wrote:
> On Mon, Dec 17, 2018 at 8:04 AM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > The blk-iolatency controller measures the time from rq_qos_throttle() to
> > rq_qos_done_bio() and attributes this time to the first bio that needs
> > to create the request. This means if a bio is plug-mergeable or
> > bio-mergeable, it gets to bypass the blk-iolatency controller.
> >
> 
> Hi,
> 
> I have a question about merging in plug list, since plug merges are
> done before rq_qos_throttle(), why would plug-mergeable bios bypass
> the controller?
> 
> thanks,
> liubo
> 

Hi Liubo,

BIO_TRACKED is tagging the bio that is responsible for allocating a new
request, so that rq_qos controllers can decide whether or not they want
to process the bio any part of the way. I should have phrased that a
little better in the commit message. It's not that the bio itself is
bypassing the blk-iolatency controller, but the blk-iolatency controller
deciding to not do anything based on the BIO_TRACKED flag. This doesn't
change any of the function calls made on a bio/request.

Thanks,
Dennis
