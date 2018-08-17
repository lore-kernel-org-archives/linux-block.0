Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34514 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQU5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 16:57:18 -0400
Received: by mail-lj1-f173.google.com with SMTP id f8-v6so7010888ljk.1
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 10:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <5F152F61-4DBE-4394-939B-D5F82EEE72AE@linaro.org> <CAPybu_3_ZJ8KopMM6fxvHXkXmdLUyqPZoXx=fx=nDYOXsvesHg@mail.gmail.com>
 <82A59CD0-9B59-4F5B-BE9B-BCDD3FDCA177@linaro.org>
In-Reply-To: <82A59CD0-9B59-4F5B-BE9B-BCDD3FDCA177@linaro.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 17 Aug 2018 19:52:41 +0200
Message-ID: <CAPybu_20-bSH5aw5L0mrmLRTD3Q02Sj0yez5LxJ1YHcDAZeoBg@mail.gmail.com>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
To: paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Paolo

On Fri, Aug 17, 2018 at 7:42 PM Paolo Valente <paolo.valente@linaro.org> wrote:

>
> Try bfq too, as it is probably the one containing also the most old
> way heuristics.  If bfq fails too, we will at least know that the issue
> is out of the schedulers. Or in every scheduler! :)

I believe that for this specific setup: A disk reader with a cfast via
USB3, the best approach might be to have a single queue and respect
the tool sequence. But definitely the io layer is out of my expertise
;)

Monday morning will performe the tests.

Thanks again and best regards!


-- 
Ricardo Ribalda
