Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A28C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1536520859
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iMLX7rrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfAOEbm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:31:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46170 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfAOEbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 23:31:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so1095493ljh.13
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 20:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQnBN5/Jx81RiLADTLUbDOi14v+DA6NTSGhZCm0jiJk=;
        b=iMLX7rrw8zwmiiVQ/iOh26XJYOc/uX9iQK4Uvqz1lvlTMdMRx0usVNwm01PJFDuDtc
         R3ufnI1GzV7MClV4t5g3PsMF7Wqru3wgBZxQ8K6BEaM1q+152nlvDfP5heAk0QvjaBlk
         iJGeW7mhsvppVapnClwE4Lpp5+jCBv06aAagk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQnBN5/Jx81RiLADTLUbDOi14v+DA6NTSGhZCm0jiJk=;
        b=ewiOYigDFyBdMulRHevb0pNrG9GSy5MlCR6y2i+B7VI/DENREaTT/9tQ8OLdyOwOlM
         iuxZ0F8gPPxi+CV+ygnKHAomO6OdA1DlMEM9mt2+I1DiIc6rzzsxvdOKRHmWlp901TWl
         O+rU/MmiXG2I692r1njqicrc1h6sKmIUCiwV4p+a2t8CEm0sftLGro/+eB5YMadYjVaa
         UjRRX7mBnhy/hl+yl6yo7Q/o4lO/mFxXjf6xN3TtmnE3fTlsfaZZxkSh3eEP8C2tf7wz
         ja2kPrH3Zsy6p026DzrOK1shIUuALW1Z2Gor8aXnlxPJ5v9NT30S1tYo5F8GPZfHrE1s
         aJDA==
X-Gm-Message-State: AJcUukeQIKv/jLODEWx7esG1TYVYScpww6iL7vJd0ZVAhAj0EajpT030
        rW6NELz8FcyBA5Dgk0H+nSex6GnrUCg=
X-Google-Smtp-Source: ALg8bN6VcQFDkdNDIP/rP40QVoqGz45MClPqq2zh9nVAnic3SKL3m0NElEclrCDJgOENcLgMkXaKFA==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr1289885ljg.164.1547526700108;
        Mon, 14 Jan 2019 20:31:40 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d15-v6sm373024lja.38.2019.01.14.20.31.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 20:31:39 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id g11-v6so1160675ljk.3
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 20:31:39 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr1395922ljx.6.1547526698543;
 Mon, 14 Jan 2019 20:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20190115035952.13325-1-ming.lei@redhat.com> <e2bebd6a-cc89-d6c2-8203-718b5c12ea4f@kernel.dk>
In-Reply-To: <e2bebd6a-cc89-d6c2-8203-718b5c12ea4f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jan 2019 16:31:22 +1200
X-Gmail-Original-Message-ID: <CAHk-=wg76gE51qx6erfMxNh4B_cYvwxgVr1ReqEyzpNjkpMJQw@mail.gmail.com>
Message-ID: <CAHk-=wg76gE51qx6erfMxNh4B_cYvwxgVr1ReqEyzpNjkpMJQw@mail.gmail.com>
Subject: Re: [PATCH] sbitmap: Protect swap_lock from hardirq
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 4:28 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Thanks Ming, I'll queue this up for shipping this week.

Oops. I _just_ applied it to my tree as a follow-up to Steven's
softirq version. I just hadn't had time to build test and push out
yet.

               Linus
