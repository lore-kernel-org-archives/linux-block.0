Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DC8C43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946C220700
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 16:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIGcLPO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfAKQMJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:12:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55736 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfAKQMI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 11:12:08 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so3260360ith.5;
        Fri, 11 Jan 2019 08:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlBzsEs/XxBusvnYWKzL1PBITBpfByToXfynZ72hRww=;
        b=tIGcLPO3tNyxvASaaMmclrPxueuO9Mqp4FzY0bFDxrFLDXXzWkBmGF0NIBAxahwWAh
         zdfW6NBbj3Xu5n90AtMVUb8slD1unzPb3TZiSXkcI/QBIY4G98wf0RjreGB3ebb0y7sE
         C9BPS1KBEpi+JFK+WsUCCW/+41k6fRUU/TkvjY5qN/OQJJCqNwO19T9ndD/NfxT/6/49
         lLz3cteMGH9s9Sx6G8hkj9CACYJPkfG1b0gGpkBW4uNqGXv4Oz7NhbUdxYPVRMJ0ID3x
         bSzA2NBbSPQhoihuQZd58lMLy789oDYkq8n0eJyQnsgJZnxA4tXpRBWU4F58AcpQPw3f
         oh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlBzsEs/XxBusvnYWKzL1PBITBpfByToXfynZ72hRww=;
        b=RKOzDtDLPFaBh5xgiIeh+fsOMxdsMEYIHY9N00zv4LDxf9vnxY/kANaCCMPK+O9vVn
         IAZzRTWv9yT1w+/AJe/FbPGY5bQZhiym1mj59ngyiiDAhLAETb9em24VDAy5zF96BbHc
         cuyzbT0BRTrkLndqB3KbFGZti5kpANVBePNPohRONVrIF05Vg/U8DRbnBH3bZUL7oZW8
         6AWKHO39bWRWVPCf5JM3/P+Asgwt+ETLGyvtM9ot/gTio+gOBZl2hsnseWCgHP7xOLmJ
         lJOqCz+NXPJGOhs20lrj1Ff9oM1KtIxS85TfyykrEKRP8dj+d0T1cEOK8ROu577edqy/
         4pMQ==
X-Gm-Message-State: AJcUukddQAA8s/44aGhOMeWpTdVlYXZ6YSyfVJ+YvgIFlzPHfdf7WDze
        FvOYaL1CeBZ3I5xc6MyX5VVS4CnvGTdsLBPgF8s=
X-Google-Smtp-Source: ALg8bN6KyNJEZkJomzRQWBOwyrZfdzQYREHKE/HOgkQBqA7CXQdqBzty3YXh6x4hwKucnEFX7vr3tjEXKBUDalkJkY0=
X-Received: by 2002:a24:d3cb:: with SMTP id n194mr1530248itg.57.1547223128088;
 Fri, 11 Jan 2019 08:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20190110024404.25372-1-axboe@kernel.dk> <fe686e4316f9746c46b91fd58c984531@suse.de>
In-Reply-To: <fe686e4316f9746c46b91fd58c984531@suse.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 11 Jan 2019 17:11:57 +0100
Message-ID: <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
Subject: Re: [PATCHSET v2] io_uring IO interface
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-block <linux-block@vger.kernel.org>,
        linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 11, 2019 at 10:51 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> Hi Jens,
>
> That is interesting.  Recently I sent an rfc related to epoll uring:
>
> https://lore.kernel.org/lkml/20190109164025.24554-1-rpenyaev@suse.de
>
> which can be mapped to userspace and all ready events can be consumed
> from it directly.  I am wondering, is it possible to make some common
> API for all kind of ready events / urings, or it doesn't make any
> sense?

I think you can use the new IOCB_CMD_POLL from Christoph and avoid
epoll_wait() in favor of aio/io_uring interface, at least in new high
performance applications.  Reaping events entirely in userspace (i.e.
performing io_getevents() without entering the kernel) has been
possible for a long time even with the existing aio interface.

Thanks,

                Ilya
