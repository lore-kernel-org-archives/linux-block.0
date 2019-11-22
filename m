Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF248C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 09:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BECC20717
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 09:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVJue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:50:34 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKVJud (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 04:50:33 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MvrRB-1hfI8X3Hlv-00ssQp; Fri, 22 Nov 2019 10:50:31 +0100
Received: by mail-qk1-f179.google.com with SMTP id z65so927624qka.6;
        Fri, 22 Nov 2019 01:50:30 -0800 (PST)
X-Gm-Message-State: APjAAAV0ldZTBL4Ft3K/uJgrzwoVxnqTPWN2HFPkhLyaiSq1zg6/avTe
        Siw3JynbzHfz08/xNCuK27AU/gXHPpnFQ7BuMEM=
X-Google-Smtp-Source: APXvYqyBbFKVVR3FXTkDFvwHRE7H5Jy8JAoIZoCUL5McqZlMeInM+hRvfaAW9OUOiilOP2GBEBEa8SZoNxQmUVeMSp4=
X-Received: by 2002:a37:a757:: with SMTP id q84mr1755748qke.394.1574416229279;
 Fri, 22 Nov 2019 01:50:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com> <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
In-Reply-To: <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Nov 2019 10:50:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
Message-ID: <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     "(Exiting) Baolin Wang" <baolin.wang@linaro.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yf2+O+g5tCVZYMzCQEMFEmeu5g4we9ZW4vA81E3c7XZwoHi8d58
 EN7mwooTP+txAO2sRTGFKRPgQU5WHJD6KSLu4D8L7x8q4tnoyR8Eqa8i/0MiLiRP3G8fqkf
 ixO8CK+6hNdBoZr8bfMnCyE2kOySNrg4zo3aE2b9C9sSAGwhSZi2ewE2bLQEH1BmGRLloAC
 g1wJx5/aritLIU6hSyvcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jjIbv/evM3E=:c/dDiOqo6Ov0iynd3qxUvl
 csh2Py00DtZKJbzqV1W2TcHT0WgIUG41fSXePDC5yARZWCbzT3CdWl+K9lwRtEw0U3Fz24VS4
 FgBm9CJ/iHXeukgefC9raDGY5an+UhyaDgJtAqk9uW9uwpr0h62TvQd57O3Pq2g+M1RYCeBsc
 fu8EEAGMOQKtuSR/hDNh+aXpgAUZvfiGfLWtFLFhsLdBtJ4d+8LhYtTzgOwIYJdztLQpnhoyi
 vcuiaBHGvjroB9GRnZsohQXI4w0+0WwNWEZoKsxBK0DF8dLTHyORR5nnwd8GnPRm5HW7nJPDn
 vK5TCuUgdRNZfiwSx8VrqS69FeODG1Uw20TDKScHS22vo0BkKisMWVXYASrdF0SDaZkBkLdVO
 wf66qb9eJ5DwNsnXsvuPZgGmaV09O2dxq8kuiWXJEnjZ/Xepi0SrIUhJvtuBg0//RSpj+EvPT
 IV1SeOnCImd6e6A2hD9n//ZUJvGER7/NzETHjdTQBJ7aIer0glLES0Fe0EIX16gONKnzdXBSR
 NNOh+k+vgvYYbPM6QiBi/ZQxFYUji1nd2jtDltXVrZcpJvyWG1okYvzNLEDITI0qZwFYFlL+x
 yinrcqUWUrBcBD6HRAby4p6g1PvLQpmDWTZxJ3PJV0Cinr3euj3q+q+Sd6f4bQzS1ZsSmQv1d
 nc3vDRbIei2kBvz0wJa6dR9OEUORNIh/Nn/UPTAevvgdZti53oE0oEef8XOFEbzo9P6E817kk
 8yOxLwkkvc2lZUnd+i/HrXDqgHr8kSQHgUcVv+Dxyk8bilhNvz0bwq31mTLnOuc2oAFcxg4q7
 PRcmYJ2KeTR8rkUQWu0Ee7Hu6iZ1mUifM5HFEd/ghvcoZoe03MS4iDx6OU7c9+wvMCExhkVtj
 lcajApv/nUFsKCfmUJdw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(adding Paolo as well, maybe he has some more insights)

On Mon, Nov 18, 2019 at 11:04 AM (Exiting) Baolin Wang
<baolin.wang@linaro.org> wrote:
> On Tue, 12 Nov 2019 at 16:48, Baolin Wang <baolin.wang7@gmail.com> wrote:
> > On Tue, Nov 12, 2019 at 12:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Nov 11, 2019 at 1:58 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > - With that change in place calling a blocking __mmc_claim_host() is
> > > > >   still a problem, so there should still be a nonblocking mmc_try_claim_host()
> > > > >   for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
> > > > >   return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
> > > > >   should always return right away, either after having queued the next I/O
> > > > >   or with an error, but not waiting for the device in any way.
> > > >
> > > > Actually not only the mmc_claim_host() will block the MMC request
> > > > processing, in this routine, the mmc_blk_part_switch() and
> > > > mmc_retune() can also block the request processing. Moreover the part
> > > > switching and tuning should be sync operations, and we can not move
> > > > them to a work or a thread.
> > >
> > > Ok, I see.
> > >
> > > Those would also cause requests to be sent to the device or the host
> > > controller, right? Maybe we can treat them as "a non-IO request
> >
> > Right.
> >
> > > has successfully been queued to the device" events, returning
> > > busy from the mmc_mq_queue_rq() function and then running
> > > the queue again when they complete?
> >
> > Yes, seems reasonable to me.
> >
> > >
> > > > > - For the packed requests, there is apparently a very simple way to implement
> > > > >   that without a software queue: mmc_mq_queue_rq() is allowed to look at
> > > > >   and dequeue all requests that are currently part of the request_queue,
> > > > >   so it should take out as many as it wants to submit at once and send
> > > > >   them all down to the driver together, avoiding the need for any further
> > > > >   round-trips to blk_mq or maintaining a queue in mmc.
> > > >
> > > > You mean we can dispatch a request directly from
> > > > elevator->type->ops.dispatch_request()?  but we still need some helper
> > > > functions to check if these requests can be packed (the package
> > > > condition), and need to invent new APIs to start a packed request (or
> > > > using cqe interfaces, which means we still need to implement some cqe
> > > > callbacks).
> > >
> > > I don't know how the dispatch_request() function fits in there,
> > > what Hannes told me is that in ->queue_rq() you can always
> > > look at the following requests that are already queued up
> > > and take the next ones off the list. Looking at bd->last
> > > tells you if there are additional requests. If there are, you can
> > > look at the next one from blk_mq_hw_ctx (not sure how, but
> > > should not be hard to find)
> > >
> > > I also see that there is a commit_rqs() callback that may
> > > go along with queue_rq(), implementing that one could make
> > > this easier as well.
> >
> > Yes, we can use queue_rq()/commit_rqs() and bd->last (now bd->last may
> > can not work well, see [1]), but like we talked before, for packed
> > request, we still need some new interfaces (for example, a interface
> > used to start a packed request, and a interface used to complete a
> > packed request), but at last we got a consensus that we should re-use
> > the CQE interfaces instead of new invention.
> >
> > [1] https://lore.kernel.org/patchwork/patch/1102897/
> >
> > >
> > > > > - The DMA management (bounce buffer, map, unmap) that is currently
> > > > >   done in mmc_blk_mq_issue_rq() should ideally be done in the
> > > > >   init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
> > > > >   can be done asynchronously, out of the critical timing path for the
> > > > >   submission. With this, there won't be any need for a software queue.
> > > >
> > > > This is not true, now the blk-mq will allocate some static request
> > > > objects (usually the static requests number should be the same with
> > > > the hardware queue depth) saved in struct blk_mq_tags. So the
> > > > init_request() is used to initialize the static requests when
> > > > allocating them, and call exit_request to free the static requests
> > > > when freeing the 'struct blk_mq_tags', such as the queue is dead. So
> > > > we can not move the DMA management into the init_request/exit_request.
> > >
> > > Ok, I must have misremembered which callback that is then, but I guess
> > > there is some other place to do it.
> >
> > I checked the 'struct blk_mq_ops', and I did not find a ops can be
> > used to do DMA management. And I also checked UFS driver, it also did
> > the DMA mapping in the queue_rq() (scsi_queue_rq() --->
> > ufshcd_queuecommand() ---> ufshcd_map_sg()). Maybe I missed something?
> >
> > Moreover like I said above, for the packed request, we still need
> > implement something (like the software queue) based on the CQE
> > interfaces to help to handle packed requests.
>
> After some investigation and offline discussion with you, I still have
> some concerns about your suggestion.
>
> 1) Now blk-mq have not supplied some ops to prepare a request, which is
> used to do some DMA management asynchronously. But yes, we can
> introduce new ops for blk-mq. But there are still some remaining
> preparation in mmc_mq_queue_rq(), like mmc part switch. For software
> queue, we can prepare a request totally after issuing one.

I suppose to make the submission non-blocking, all operations that
currently block in the submission path may have to be changed first.

For the case of a partition switch (same for retune), I suppose
something like this can be done:

- in queue_rq() check whether a partition switch is needed. If not,
  submit the current rq
- if a partition switch is needed, submit the partition switch cmd
  instead, and return busy status
- when the completion arrives for the partition switch, call back into
  blk_mq to have it call queue_rq again.

Or possibly even (this might not be possible without signifcant
restructuring):

- when preparing a request that would require a partition switch,
  insert another meta-request to switch the partition ahead of it.

I do realize that this is a significant departure from how it was done
in the past, but it seems cleaner that way to me.

> 2) I wonder if it is appropriate that using the irq threaded context
> to dispatch next request, actually we will still introduce a context
> switch here. Now we will complete a request in the hard irq handler
> and kick the softirq to do time-consuming operations, like DMA
> unmapping , and will start next request in the hard irq handler
> without context switch. Moreover if we remove the BLK_MQ_F_BLOCKING in
> future like you suggested, then we can remove all context switch. And
> I think we can dispatch next request in the softirq context (actually
> the CQE already did).

I hope Hannes (or someone else) can comment here, as I don't
know exactly what his objection to kicking off the next cmd in the
hardirq was.

I think generally, deferring all slow operations to an irqthread
rather than a softirq is a good idea, but I share your concern that
this can introduce an unnecessary latency between the the
the IRQ is signaled and the time the following cmd is sent to the
hardware.

Doing everything in a single (irqthread) context is clearly simpler,
so this would need to be measured carefully to avoid unnecessary
complexity, but I think don't see anything stopping us from having
the fast-path where the low-level driver first checks for any possible
error conditions in hardirq context and the fires off a prepared cmd
right away whenever it can before triggering the irqthread that does
everything else. I think this has to be a per-driver optimization, so
the common case would just have an irqthread.

> 3) For packed request support, I did not see an example that block
> driver can dispatch a request from the IO scheduler in queue_rq() and
> no APIs supported from blk-mq. And we do not know where can dispatch a
> request in queue_rq(), from IO scheduler? from ctx? or from
> hctx->dispatch list? and if this request can not be passed to host
> now, how to do it? Seems lots of complicated things.

The only way I can see is the ->last flag, so if blk_mq submits multiple
requests in a row to queue_rq() with this flag cleared and  calls
->commit_rqs() after the last one. This seems to be what the scsi
disk driver and the nvme driver rely on, and we should be able to use
it the same way for packed cmds, by checking each time in queue_rq()
whether requests can/should be combined and reporting busy otherwise
(after preparing a combined mmc cmd).
blk_mq will then call commit_rqs, which should do the actual submission
to the hardware driver.

Now as you point out, the *big* problem with this is that we never
get multiple requests together in practice, i.e. the last flag is almost
always set, and any optimization around it has no effect.

This is where I'm a bit lost in the code as well, but it seems that
this is part of the current bfq design that only sends one request down
the driver stack at a time, and this would have to change first before
we can rely on this for packing requests.

Paolo, can you comment on why this is currently done, or if it can
be changed? It seems to me that sending multiple requests at
once would also have a significant benefit on the per-request overhead
on NVMe devices with with bfq.

> Moreover, we still need some interfaces for the packed request
> handling, from previous discussion, we still need something like MMC
> software queue based on  the CQE to help to handle the packed request.
>
> So I think I still need to introduce the MMC software queue, on the one
> hand is that it can really improve the performance from fio data and
> avoid a long latency, on the other hand we can expand it to support
> packed request easily in future. Thanks.
>
> (Anyway I will still post the V7 to address Adrian's comments and to
> see if we can get a consensus there).


     Arnd
