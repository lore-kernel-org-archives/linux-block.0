Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26725C432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028012080F
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 09:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKZJyW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:54:22 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:45003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfKZJyW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 04:54:22 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MIcux-1id3ni2ZFN-00Efhg; Tue, 26 Nov 2019 10:54:19 +0100
Received: by mail-qv1-f50.google.com with SMTP id t5so162603qvs.5;
        Tue, 26 Nov 2019 01:54:19 -0800 (PST)
X-Gm-Message-State: APjAAAWytZ+TnxxhQykXakGeTpTnytGBlQEHkltdCYIT7uidqL9O9RpR
        LtoZpb7GL+XGAGyPC6EZrA8NeMHu9b6emaj5Gww=
X-Google-Smtp-Source: APXvYqzfzjkp9uCV/32ns/7FRgNOHtxQYJSAtQE1mAt193WKi70vgeZxBNUsgLiFbHYA3VpUR2G+JAWWe+LrlJHioYc=
X-Received: by 2002:ad4:404e:: with SMTP id r14mr32738089qvp.4.1574762058335;
 Tue, 26 Nov 2019 01:54:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com> <1C0831B6-CA26-4794-9686-E7384713C756@linaro.org>
In-Reply-To: <1C0831B6-CA26-4794-9686-E7384713C756@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Nov 2019 10:54:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a27PLB_rXkxuyOuK_eKvSSi29fekebcwsoTRLSAOmRX+w@mail.gmail.com>
Message-ID: <CAK8P3a27PLB_rXkxuyOuK_eKvSSi29fekebcwsoTRLSAOmRX+w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F4qBgONcda6uvVnW/sY+/qgy/oA8tIrpZ0Ug69hENvuxR7e1QFZ
 GVtk3336XAPu6j44gZNVR0aZaQJoGuEZuSyqxEvXnT8FPsS1cNLw7wIGwaN2GxXImb4Abem
 Djva5NMFgIq4vAug39A6Ll0vwiqZll3nvDWp07/PZ6XSLtV81XvQev7D6LxiX72AjUZ735i
 4dTqGIrwkF4scyU7Uk1/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9juBk/clAeQ=:7lxmgSuGXYgYG4mFNRV5ky
 EgIhUJjBmo6Poe0zd7sQOSz2l86811OMt0m8yFWj7KRFGsb+VujbbnSar2cKGmIjxmS+DytkR
 76dOD4BPiks6uthQ6HYMwChaX4TAeXmy+cLcObZnSfwTjRHkbfJvxUuew87SJE2VylnVFk5nj
 jpJ5K4AZbjaimY75DynryB7ii95yVWLSQqrynPF/oK199NqNNanhUCfFI6sFLakboRbGOVNva
 XMUj/musrBWWwuxomKYcv2ckpIQlKkpUZDxKb4PV/VmlPAsb6HzPLzgshxHxxxPwj+0qFayDU
 ndsNHh1QAWDuGdMjZVrjXC6o9xK3aR/ZfHG2PI6BICWBBVxut/86PbWnAWvvH96pO3soj+eU2
 6dnFMWrVZasYSUZaJTRljU8uIdtULTYpjQSwFxtsLLliJMtR1WDaxSy+U0zLdA4z3fXeTChAf
 Qfg4jJZbuBa+gaGOtZD/emGzYQBuvMJWxaa4qMl2l8PEFE+fimeF353Ah39QZ/5P+fXjnvAuk
 zh4k17/dD3kq9muONF2BnovnjZR6KcM3VXOpzqXnqReHSKi+EAVJfWFj5D6V/gfi4Xku10GDu
 K8u+Rp83WUgDnAizXOZSLb/MMSrPyYVqNQ3aIJxrg0kDrFJR+XcJ+QS+9OOReGlntRua799iw
 s1IwVejyxC5PTw0y0isACEIDmz0xcvCVTBDuwPNMMVn7BwJ8bJUJoTnVZrnMXDVBMvN8gt15W
 JbraY1uRYr5Ty7Mpk1vlYZ5znBWdx3+pH4bdkvUoLnTkD5Sd7EskT0wSWxDJt7uax8ykeKyIT
 esA+l870E6mQBPG1XinvPGF+AY+yP8MtLbBzeKmpS21ur5vazgZyv1+naqfDKKM5fa5jzdYb8
 3FP76n/dLJqIRxyyqhxg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 8:41 AM Paolo Valente <paolo.valente@linaro.org> wrote:
> > Il giorno 22 nov 2019, alle ore 10:50, Arnd Bergmann <arnd@arndb.de> ha scritto:
> > On Mon, Nov 18, 2019 at 11:04 AM (Exiting) Baolin Wang <baolin.wang@linaro.org> wrote:
> > Paolo, can you comment on why this is currently done, or if it can
> > be changed? It seems to me that sending multiple requests at
> > once would also have a significant benefit on the per-request overhead
> > on NVMe devices with with bfq.
> >
>
> Hi,
> actually, "one request dispatched at a time" is not a peculiarity of
> bfq.  Any scheduler can provide only one request at a time, with the
> current blk-mq API for I/O schedulers.
>
> Yet, when it is time to refill an hardware queue, blk-mq pulls as many
> requests as it deems appropriate from the scheduler, by invoking the
> latter multiple times.  See blk_mq_do_dispatch_sched() in
> block/blk-mq-sched.c.
>
> I don't know where the glitch for MMC is with respect to this scheme.

Right, this is what is puzzling me as well: in both blk_mq_do_dispatch_sched()
and blk_mq_do_dispatch_ctx(), we seem to always take one request from
the scheduler and dispatch it to the device, regardless of the driver or
the scheduler, so there should only ever be one request in the local list.

Yet, both the blk_mq_dispatch_rq_list() function and the NVMe driver
appear to be written based on the idea that there are multiple entries
in this list. The one place that I see putting multiple requests on the
local list before dispatching them is the end of
blk_mq_sched_dispatch_requests():

        if (!list_empty(&rq_list)) {
              ...
                }
        } else if (has_sched_dispatch) {
                blk_mq_do_dispatch_sched(hctx);
        } else if (hctx->dispatch_busy) {
                /* dequeue request one by one from sw queue if queue is busy */
                blk_mq_do_dispatch_ctx(hctx);
        } else {
->             blk_mq_flush_busy_ctxs(hctx, &rq_list);        <----
                blk_mq_dispatch_rq_list(q, &rq_list, false);
        }

So as you said, if we use an elevator (has_sched_dispatch == true),
we only get one request, but without an elevator, we get into this
optimized path.

Could we perhaps change the ops.dispatch_request() function to pass
down the list as in https://paste.ubuntu.com/p/MfSRwKqFCs/ ?

      Arnd
