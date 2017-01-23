Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33422 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdAWH13 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 02:27:29 -0500
Received: by mail-oi0-f49.google.com with SMTP id w204so75545138oiw.0
        for <linux-block@vger.kernel.org>; Sun, 22 Jan 2017 23:27:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <92E1CE17-4F28-4934-BB60-358FA334AA5F@fb.com>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com> <CAA9_cmd_XMbw_26ePCSWLxP9PoTn36n8sO5buE2iTCoPnK+CHg@mail.gmail.com>
 <92E1CE17-4F28-4934-BB60-358FA334AA5F@fb.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 22 Jan 2017 23:27:27 -0800
Message-ID: <CAPcyv4hrcS13ijDU2+Mp59EKCqkWLMv7uj=BhKKewiz02YZiPA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] block level event logging for storage media management
To: Song Liu <songliubraving@fb.com>
Cc: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>, Jens Axboe <axboe@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>, green@linuxhacker.ru
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[ adding Oleg ]

On Sun, Jan 22, 2017 at 10:00 PM, Song Liu <songliubraving@fb.com> wrote:
> Hi Dan,
>
> I think the the block level event log is more like log only system. When en event
> happens,  it is not necessary to take immediate action. (I guess this is different
> to bad block list?).
>
> I would hope the event log to track more information. Some of these individual
> event may not be very interesting, for example, soft error or latency outliers.
> However, when we gather event log for a fleet of devices, these "soft event"
> may become valuable for health monitoring.

I'd be interested in this. It sounds like you're trying to fill a gap
between tracing and console log messages which I believe others have
encountered as well.
