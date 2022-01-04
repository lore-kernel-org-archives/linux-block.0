Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67BCC433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 05:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiADFcA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 00:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiADFb7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jan 2022 00:31:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84685C061784
        for <linux-block@vger.kernel.org>; Mon,  3 Jan 2022 21:31:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w16so143994817edc.11
        for <linux-block@vger.kernel.org>; Mon, 03 Jan 2022 21:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNLlKNJwh8yDutcgTSNh3rJ5e/XoBEFDQk6XXJo2O/I=;
        b=orxNeTfTE2OzEWokfk2Wh8DVYaqFMPwA1c+9b77lYcTuW6hbwkykKmkk7cSbeiqEsC
         pvf1eThjSWeQ360rDEfrIO+xStpX7Bc9tS8aHMzcN8CHOWOV7CDW9P7LDw0IqqUXo2XA
         u+yRsLAjnZ7KaizfhC6K/euSCNQhEAM5jliWYJljeNRZjegwPtQKhrCWurC5pKXIkhLy
         LEYbahcrfGS1BSgokeclMoh18wDTkTtoDr/BdwzMhCugoaDD95JsMw0KIS1S/FP1kGNf
         Fne5WM6AKOrhZjcdKBRmKxYnG2iBpNLpoGmzagQw4D9mh3g/oAcVG0Hm0J2f2eqYLLB3
         m5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNLlKNJwh8yDutcgTSNh3rJ5e/XoBEFDQk6XXJo2O/I=;
        b=7Fe3a/AEVCLnvuu0DlSdqMm7ZmQ3Kq6Yt1VRVMVuGZPICLVltRVdl4Vtx74qdEGOan
         oHQQx/Px3bbeiW2plM4LW3Yvplj3rNNh3fvi0jXoLTrALlNCEXQT/KH6Rt65blQ+HMo+
         HzNxeTiOUqdWAeJLeDXA+2DWp0Jl7uxBvvLas324P//g14p/hVqLW/lVkWuoossWxnxU
         d3QtxoCdESKioXuC2xg4eelKfCe09ar18xB1K/PeJDDZYo7Zs7tR3e6EjH6amMYHTntE
         M6pfB+zTB+jE1tuzYXxDX+h+vDhHniot9cqRFEdjxxoXUtJU8JNmhaFh8vY1+icfbzge
         rCDg==
X-Gm-Message-State: AOAM530uUDulU2iLVdvsnNhQQxUL0OncOdUN9jpiYcgRA0k8QJsrRf5e
        W8xZn5v3bEQRjAyumTX5gKvDP4olyz15rhtjRNAJ
X-Google-Smtp-Source: ABdhPJz4dWu/xStNE8Cp7gQF0Nk8Dd7RPTLq2p8D7/HOHBRr/cDSTbtPSjh/GJNQrR2ul1NA8DHUoRiaAuKq1ZJ6tkM=
X-Received: by 2002:a17:906:6a0d:: with SMTP id qw13mr40748060ejc.490.1641274318122;
 Mon, 03 Jan 2022 21:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com> <YdMgCS1RMcb5V2RJ@localhost.localdomain>
In-Reply-To: <YdMgCS1RMcb5V2RJ@localhost.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 4 Jan 2022 13:31:47 +0800
Message-ID: <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 4, 2022 at 12:10 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Thu, Dec 30, 2021 at 12:01:23PM +0800, Yongji Xie wrote:
> > On Thu, Dec 30, 2021 at 1:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > > > The rescuer thread might take over the works queued on
> > > > the workqueue when the worker thread creation timed out.
> > > > If this happens, we have no chance to create multiple
> > > > recv threads which causes I/O hung on this nbd device.
> > >
> > > If a workqueue is used there aren't really 'receive threads'.
> > > What is the deadlock here?
> >
> > We might have multiple recv works, and those recv works won't quit
> > unless the socket is closed. If the rescuer thread takes over those
> > works, only the first recv work can run. The I/O needed to be handled
> > in other recv works would be hung since no thread can handle them.
> >
>
> I'm not following this explanation.  What is the rescuer thread you're talking

https://www.kernel.org/doc/html/latest/core-api/workqueue.html#c.rescuer_thread

> about?  If there's an error we close the socket which will error out the recvmsg
> which will make the recv workqueue close down.

When to close the socket? The nbd daemon doesn't know what happens in
the kernel.

>
> > In that case, we can see below stacks in rescuer thread:
> >
> > __schedule
> >   schedule
> >     scheule_timeout
> >       unix_stream_read_generic
> >         unix_stream_recvmsg
> >           sock_xmit
> >             nbd_read_stat
> >               recv_work
> >                 process_one_work
> >                   rescuer_thread
> >                     kthread
> >                       ret_from_fork
>
> This is just the thing hanging waiting for an incoming request, so this doesn't
> tell me anything.  Thanks,
>

The point is the *recv_work* is handled in the *rescuer_thread*.
Normally it should be handled in *work_thread* like:

__schedule
   schedule
     scheule_timeout
       unix_stream_read_generic
         unix_stream_recvmsg
           sock_xmit
             nbd_read_stat
               recv_work
                 process_one_work
                   *work_thread*
                     kthread
                       ret_from_fork

Thanks,
Yongji
