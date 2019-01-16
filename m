Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E05DC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7820675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbfAPPla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:41:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43415 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfAPPla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:41:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so7561298qtj.10;
        Wed, 16 Jan 2019 07:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VHG1nTtUBTQX0WxDW77vH6Cy6V/jQdhdGjvFbrjqWY=;
        b=dX1tsBZGeXUOoWzJZVoLz/7vYiYmgGoBs+X/8m94iMYVxMttP8cOrzWWRH/Vky0RhY
         0xRUEaXCLNArGzhTywsw+t+WiwnHIInwujf+W0cWvLKA9yArzQj40i/uZuX1tTsYUqHJ
         5ibujuGShMbsPivWUPqG80ayvKgflkfEoX+iFDC8oR0ySyJiK8qIpPmF85nQI60fnDYp
         BW55xBKszU0VEvl12RFP4Di5oscquMg1GQi6eI1CdUuftP+TRAk4Ewm8lWfJ1DS9Q8Z1
         NPJarlzv4igxvfiYWKonfYQZFjrUvI28nVGNiOWZflq0GLGGh/TuwLTHJDjHF2RjepmD
         I2Fw==
X-Gm-Message-State: AJcUukfVRsM/VSu9mbCqJw0Wreg2/wac65wJtVDnHZF8x4ZxBFnnbWwb
        QifTZ2zsAbZW+/eUpqkvkIXjHMazqvRMIQkZRws=
X-Google-Smtp-Source: ALg8bN6LIN6iPFbGTb6xGEwfg5+3gGqHjvqdLJhDDs6fwJlgtBe2TR9zAREf8QPPt/D4fXZRUFZ9BoqQO+RT5CH1Vp4=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr7457996qte.212.1547653288670;
 Wed, 16 Jan 2019 07:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-14-axboe@kernel.dk>
 <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
 <075af26b-c685-a0db-05e4-fa73f8725b8a@kernel.dk> <331f63c0-002f-b373-b831-73af9e98f2ef@kernel.dk>
In-Reply-To: <331f63c0-002f-b373-b831-73af9e98f2ef@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 16:41:12 +0100
Message-ID: <CAK8P3a2E8dLoL5sgucp=-LDkGMN=qnG8M_phHoHCBg5ipWgBjQ@mail.gmail.com>
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO buffers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 4:32 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/16/19 8:14 AM, Jens Axboe wrote:
> > On 1/16/19 3:53 AM, Arnd Bergmann wrote:
> >> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> >>> index 542757a4c898..e36c264d74e8 100644
> >>> --- a/include/linux/syscalls.h
> >>> +++ b/include/linux/syscalls.h
> >>> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
> >>>                                 struct io_uring_params __user *p);
> >>>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
> >>>                                 u32 min_complete, u32 flags);
> >>> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
> >>> +                               void __user *arg);
> >>>
> >>
> >> Would it be possible to make this a typed pointer instead? If this needs to
> >> be extended later to pass a different structure, a new system call may
> >> be better for consistency than overloading the argument in various
> >> ways.
> >
> > As you can see from the later patch for registering files, it'll be used
> > for other structs too. Feels a little silly to add an extra system call
> > for that. I agree the void * isn't the prettiest thing in the world, but
> > at least it allows us to extend the API without having to add even more
> > system calls down the line.
>
> With the __u64 changes, we end up with this:
>
> struct io_uring_register_buffers {
>         __u64 iovecs;           /* pointer to iovecs array */
>         __u32 nr_iovecs;        /* number of iovecs in array */
>         __u32 pad;
> };
>
> struct io_uring_register_files {
>         __u64 fds;
>         __u32 nr_fds;
>         __u32 pad;
> };
>
> which are identical. So the question then becomes if I should just make
> these opaque enough to be the same thing, ala:
>
> struct io_uring_register_data {
>         __u64 data;
>         __u32 nr_elems;
>         __u32 pad;
> };

Right, that looks good in either form.

> and then probably add a bit more reserved space so we have something
> that can be extended...

Or maybe go the opposite way and pass the two members you have
directly to the system call:

int io_uring_register(unsigned int fd, unsigned int opcode, void
__user *, arg, unsigned count)
{
      ...
}

Where 'arg' now points to the array of iovecs or the the array of file
descriptors, or whatever else you need.

       Arnd
