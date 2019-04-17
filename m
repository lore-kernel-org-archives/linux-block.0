Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F13C282DD
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E16F20872
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="oLksjwqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfDQVmA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:42:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42599 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVl7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 17:41:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so140904pgh.9
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Ffp7LTriW4pZbHOYIfH6MSGa+PFmw5p6J5ArUsVsRo=;
        b=oLksjwqONCg8oyP7uSuYIJ2KNPDd/CGe3NjXSzh6PIw2Nx8276MS4Y6CJtfakYUN45
         aJIwd0W3PggLbCQ1xu6F0LcLTuKmQ3A68Cl3Vpw4vDKegcTwcuEwmdQ85PMoIZmcVz6H
         2W8rhOlumzbYAZEgsJoi0mr0fCFvdS8CJZE8uSHuNzF4U75laIAvZbdgyn/o3yGI39VJ
         MkiWzp6LfYhmumBqRpG3GPokjFTnLAXErv4OoVjBUIgO76pSYh+Ctojd7A/dqi3JKFa7
         rgsZqPQg2pBgrl7Q95ZKqWfzOr9LSZUFgZhb11vl8wLGYNFcn9Edqg5c0Tv017BFvbtb
         B0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Ffp7LTriW4pZbHOYIfH6MSGa+PFmw5p6J5ArUsVsRo=;
        b=hKqw/r7a371FpEWcRUtRPJMLetYBco36D6SyrnA7tiuebCBAuj+MvNJkvnIFDQQihI
         qsQ6luWMsUkIgI1BmHKt87+owEzuuR1gvTJugwXkxcBUiVt3YPNIhWcQKvwCWJkwCg4M
         qoOe6BBSzrn7dzJqOYGsM36G65C3YWrT96cUy+tuEiw5aF3tLBi3w0mPbxWHnCZt8gL1
         2hBD/uD47GENs/3g95571whVsTtyfYyojYW0oL/oE84csXeWrW0a+2dGZShYqKkhDDsv
         ivo0Ss1od+lnV+uMftR0thq82y6CnFEylMt8N4fRza4Xda/ySHWGBz/8ycQdvoeu6E5l
         38gQ==
X-Gm-Message-State: APjAAAX9OrygxfnxVbGEOAjGYoOVOGu2edRvgyaWoRvCv8vzxpn4jK2D
        VcvBW1CalflJzF5JBNZ0CX/s0A==
X-Google-Smtp-Source: APXvYqz5QU00pwWy9Ii5kJTDPYtO6rk7rChttfyMzl8OR0fxbzF4B3sWzrdMmbzESrtsOF1iaGS47g==
X-Received: by 2002:a63:cf0f:: with SMTP id j15mr84247032pgg.329.1555537319083;
        Wed, 17 Apr 2019 14:41:59 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::8abe])
        by smtp.gmail.com with ESMTPSA id x66sm184574pfb.78.2019.04.17.14.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 14:41:58 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:41:58 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Xiao Liang <xiliang@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests v2] block/020: dynamically change iodepth if
 test aio-nr lager than aio-max-nr
Message-ID: <20190417214158.GB18727@vader>
References: <20190406142722.6561-1-xiliang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406142722.6561-1-xiliang@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 06, 2019 at 10:27:22PM +0800, Xiao Liang wrote:
> When system has large count of cpus(eg. 96), the test failed as aio-nr over
> aio-max-nr limitation.
> 
> This patch continues to use 1024 as default iodepth, but change it if
> iodepth*$(nproc) > aio-max-nr.

Thank you, applied.
