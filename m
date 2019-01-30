Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2CC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DE3218A4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c0OZheBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfA3Pfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:35:39 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36784 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfA3Pfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 10:35:39 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so11115442itj.1
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 07:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TvwUEisJewc6/fT3EtlmZTvMCkdTvf5SH3EEqUgY1Gc=;
        b=c0OZheBEi99IDp4Oboc/hS9+yO10ZJPgFvAsiuZFgiUlmGx8enDcEicRdNarFMeRMn
         Ynfk7GUQBSK7uks6zeQXS+DzYsVtG9pUM/ocpQ0Bh8CA38dqJ0z2umyUX1i8x8sMD3nS
         RM3XMqdd9LALQOz8F6oJ9Tt94LXJpaOewhWHOc+T3DWFRfv4yMcvFG88p8E7pBMoHhN1
         05yjkNx00qcHTf06OkIeJfAKFWFi6JWNAcgvtgoNx5pYL+H9YrWi4pVKI0u+ZzZTQuGG
         AF5Ukw9FQgZUHrqVCrWNaS+zpV68EpkBadsBcFWWMZlP/UN/8bmPAIkOSl84USmTWuFq
         VZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvwUEisJewc6/fT3EtlmZTvMCkdTvf5SH3EEqUgY1Gc=;
        b=YiJmPcAXZx/5dlYS3cXaOJakdhQt0XJaS3Y2vq4FivYpe1sghE5W3RINK4/LBP+FQQ
         cKhR1qc/mAVUyG3DjLa+SFiQxIn3C5Y0FKm5TaHQSaWOmWHui5mbCvpcgX3Xct/cQkUF
         SK/91tT3LY8TAOgyin2Y6OBPJw/MEC0FXhZd8fBmzjecwWcznvUjUK3e7gvWEX+Xvs5J
         dD8lp8Oi997rXdzxFVcwulADnUTbt7PreCTnY9x2fLJ207CYEM5tpE1D6HbwklddIfut
         7RgwRyBNf6elvqhzx6Vfjygj0HJQsBfywHm5eZXIkjeItepiGma5mFE9wrtopKHyB3AQ
         xX9A==
X-Gm-Message-State: AJcUukcmk/mjCxLB6TK97AGqtffqCIDm6xUfo2xa1x6pLhXGYBSzHC34
        /jOcq+BGXtK3jfIB8JRObPN/1g==
X-Google-Smtp-Source: ALg8bN4wqnN+LYAPO2UltQCrs5CTmBaLdxY/o4GrWh4HyAyIpVjCkSes0WE8rM+VYcKxF/A79NNgdA==
X-Received: by 2002:a24:bd48:: with SMTP id x69mr15055767ite.81.1548862538043;
        Wed, 30 Jan 2019 07:35:38 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c31sm1376471itd.25.2019.01.30.07.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 07:35:37 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a54c68d0-7069-a72c-5604-37b0e1ed53bf@kernel.dk>
Date:   Wed, 30 Jan 2019 08:35:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 6:29 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>> We normally have to fget/fput for each IO we do on a file. Even with
>> the batching we do, the cost of the atomic inc/dec of the file usage
>> count adds up.
>>
>> This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
>> for the io_uring_register(2) system call. The arguments passed in must
>> be an array of __s32 holding file descriptors, and nr_args should hold
>> the number of file descriptors the application wishes to pin for the
>> duration of the io_uring context (or until IORING_UNREGISTER_FILES is
>> called).
>>
>> When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
>> member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
>> to the index in the array passed in to IORING_REGISTER_FILES.
>>
>> Files are automatically unregistered when the io_uring context is
>> torn down. An application need only unregister if it wishes to
>> register a new set of fds.
> 
> Crazy idea:
> 
> Taking a step back, at a high level, basically this patch creates sort
> of the same difference that you get when you compare the following
> scenarios for normal multithreaded I/O in userspace:
> 
> ===========================================================
> ~/tests/fdget_perf$ cat fdget_perf.c
> #define _GNU_SOURCE
> #include <sys/wait.h>
> #include <sched.h>
> #include <unistd.h>
> #include <stdbool.h>
> #include <string.h>
> #include <err.h>
> #include <signal.h>
> #include <sys/eventfd.h>
> #include <stdio.h>
> 
> // two different physical processors on my machine
> #define CORE_A 0
> #define CORE_B 14
> 
> static void pin_to_core(int coreid) {
>   cpu_set_t set;
>   CPU_ZERO(&set);
>   CPU_SET(coreid, &set);
>   if (sched_setaffinity(0, sizeof(cpu_set_t), &set))
>     err(1, "sched_setaffinity");
> }
> 
> static int fd = -1;
> 
> static volatile int time_over = 0;
> static void alarm_handler(int sig) { time_over = 1; }
> static void run_stuff(void) {
>   unsigned long long iterations = 0;
>   if (signal(SIGALRM, alarm_handler) == SIG_ERR) err(1, "signal");
>   alarm(10);
>   while (1) {
>     uint64_t val;
>     read(fd, &val, sizeof(val));
>     if (time_over) {
>       printf("iterations = 0x%llx\n", iterations);
>       return;
>     }
>     iterations++;
>   }
> }
> 
> static int child_fn(void *dummy) {
>   pin_to_core(CORE_B);
>   run_stuff();
>   return 0;
> }
> 
> static char child_stack[1024*1024];
> 
> int main(int argc, char **argv) {
>   fd = eventfd(0, EFD_NONBLOCK);
>   if (fd == -1) err(1, "eventfd");
> 
>   if (argc != 2) errx(1, "bad usage");
>   int flags = SIGCHLD;
>   if (strcmp(argv[1], "shared") == 0) {
>     flags |= CLONE_FILES;
>   } else if (strcmp(argv[1], "cloned") == 0) {
>     /* nothing */
>   } else {
>     errx(1, "bad usage");
>   }
>   pid_t child = clone(child_fn, child_stack+sizeof(child_stack), flags, NULL);
>   if (child == -1) err(1, "clone");
> 
>   pin_to_core(CORE_A);
>   run_stuff();
>   int status;
>   if (wait(&status) != child) err(1, "wait");
>   return 0;
> }
> ~/tests/fdget_perf$ gcc -Wall -o fdget_perf fdget_perf.c
> ~/tests/fdget_perf$ ./fdget_perf shared
> iterations = 0x8d3010
> iterations = 0x92d894
> ~/tests/fdget_perf$ ./fdget_perf cloned
> iterations = 0xad3bbd
> iterations = 0xb08838
> ~/tests/fdget_perf$ ./fdget_perf shared
> iterations = 0x8cc340
> iterations = 0x8e4e64
> ~/tests/fdget_perf$ ./fdget_perf cloned
> iterations = 0xada5f3
> iterations = 0xb04b6f
> ===========================================================
> 
> This kinda makes me wonder whether this is really something that
> should be implemented specifically for the io_uring API, or whether it
> would make sense to somehow handle part of this in the generic VFS
> code and give the user the ability to prepare a new files_struct that
> can then be transferred to the worker thread, or something like
> that... I'm not sure whether there's a particularly clean way to do
> that though.
> 
> Or perhaps you could add a userspace API for marking file descriptor
> table entries as "has percpu refcounting" somehow, with one percpu
> refcount per files_struct and one bit per fd, allocated when percpu
> refcounting is activated for the files_struct the first time, or
> something like that...

There's undoubtedly a win by NOT sharing, obviously. Not sure how to do
this in a generalized fashion, cleanly, it's easier (and a better fit)
to do it for specific cases, like io_uring here. If others want to go
down that path, io_uring could always be adapted to use that
infrastructure.

-- 
Jens Axboe

