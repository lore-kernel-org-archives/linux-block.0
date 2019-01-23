Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C84C282C3
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 00:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E38217D4
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 00:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=noserose-net.20150623.gappssmtp.com header.i=@noserose-net.20150623.gappssmtp.com header.b="gQ4Nl7vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfAWAb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:31:29 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51625 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWAb3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 19:31:29 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so807438ite.1;
        Tue, 22 Jan 2019 16:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noserose-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HfIhBZ63WOqBXt9BLrMwC7nB16ZBOfkry+Iv0A9qmo=;
        b=gQ4Nl7vyjttTrvcX6VZn8G3Kn6YNA/7Y/H+CSaJVd8ONY/p+mV2NoMCHnAFXEUOn8t
         4yfv18oWpnRDyPbgaXv7I7DCk4o5YRcvBGjxlsw3MdUhZ2+l3XOMkcTp9+GkTcpRpj4v
         t3BHbZAYRlcqHuYwFeL+gU+rEM9KwP9Nyfjk96ojaaecoFZNfqTeUSpn0gWaD8A2WK08
         9PcYBKXi2PryF2ySioqEPizFehcz2yIjGhE+V8YzwzztCL6LTcbW0Ao2YPfdR2v1Vsjg
         hGcOuGG8+OAk1uJXqab75CnYhYKutn/d6+UcmlqC79Pr4wZekh/YXG0TuCo4Hn8OQmen
         4ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HfIhBZ63WOqBXt9BLrMwC7nB16ZBOfkry+Iv0A9qmo=;
        b=kgs00JRPbmJD054ALrMpM/meo9lFPRtcCAcAm8hrOZHhxFSDSi+M2ztPn+3ZPomq/W
         4HPeKcdrnXpzbut6mnR8XOwBzn13FKh8tdwzw7e8UZokmt7QxQPY3XoE2GIqT7GT4+nO
         fGizt0rtL0nObnkPrdyUdEnYw+DwjI+6oWn2IHS0lG/GR18oxclEa/UfSjSGfPC+/cDu
         yEhjfOT74jEBV7s8YnKe2aL7OCqUBhXlVWpMm4Y65kutJo0QnONO8cr4m5gPPmPCdwxs
         9zgVkr8wCbV7l6kP9TQ8d4Vz0TJjUPS3IlpTN90Jrxkq0Rh9yQ6/9XxfZ4jLov9i4umR
         qiHA==
X-Gm-Message-State: AJcUukec+M7X29kbO97Hyf0fFWqpjBY/iMnYnl+/tGNvm3dpiXIb0xnl
        mmfo+NS1w7FEsG5UK2MED/l2QWpLWPPB2fGAMkbLKihb
X-Google-Smtp-Source: ALg8bN4f7mNWW14LyjGgmLOf0ZEgM17uP6AKSwj0pElfuyGXL6WBiMtMvyrF9pqacFWjelRIXE+ryj9RGrWw+gN8NqQ=
X-Received: by 2002:a24:4d87:: with SMTP id l129mr444767itb.37.1548203488683;
 Tue, 22 Jan 2019 16:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-5-gregkh@linuxfoundation.org> <20190122232933.GC5884@vader>
In-Reply-To: <20190122232933.GC5884@vader>
From:   Ed Cashin <ecashin@noserose.net>
Date:   Tue, 22 Jan 2019 19:31:17 -0500
Message-ID: <CADvA-dmmZOUCDpr0QJu6zcrD0ZU_HAGT=UmguHWWnUcm0S0X6w@mail.gmail.com>
Subject: Re: [PATCH] block: aoe: no need to check return value of
 debugfs_create functions
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 6:29 PM Omar Sandoval <osandov@osandov.com> wrote:
...
> Now entry is uninitialized here when we assign it to d->debugfs.

Thanks for noticing that.
