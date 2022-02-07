Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594E7C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Feb 2022 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiBGR0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384175AbiBGRSB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 12:18:01 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0835C0401E9
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 09:17:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id s21so15927307ejx.12
        for <linux-block@vger.kernel.org>; Mon, 07 Feb 2022 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+x0yu+l5gRNEA0QtHe7jspCvvoGDqhGxc2x1qQ+kRw8=;
        b=nhjAqvfsGZyoSHJ/ghPwnVbcNlCD5MwcUpxIHy5iYH9yt42hlKEsyEPAHQOnywyXTj
         Z5/HrzP2LEEwruYd+/KaY0qh44TkHSkdDTuaKd/5RTK+tLRi2j+ZYopKQ79G6cBjAiW+
         rJcmrfXjKGWydMkaW6XRG1yBtgR6KFZHekFPd0+QZUC+sQuVvpmw9ql2Pkoa2WQ26B+J
         v8P0UybSnWQKd7bRs1tDz6cxOegh/LPzz3uHCjZz2avbkZTzPVO/2QiJR2b4Mbwgtk21
         QZLtRzcFNAYWKqS/xYrVM26A5LXSx/VoXNBxQJlLVnL7WU2CBrfgkN3yqWOhY0tmwGiH
         t1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+x0yu+l5gRNEA0QtHe7jspCvvoGDqhGxc2x1qQ+kRw8=;
        b=cFiA3Ac6YjeHK3CY+j7Bf72D5jU5uPUEzQVB95nZWQbRQlvTujmHDb7ZvbdCdhGS1F
         601R528kE2MSP4/7fTBJzGZH7g6qVmeU5cel127ESZ8W9qexn2IIJtrrdpbVrYAuxXtp
         tP1CylEGZ4KqLQebg+fk6ttyHRHleA+neW3COU1U71l3VKgEihHQ4zuAIiymHcbRUFiO
         eY7dTaAYtAE8BJ23+KEdOPw4lW6OifWZ7ECUoXJwIXyusfHC58mK+ZqcjdU6RlBidVYH
         0zNFDuSop6vsZdcmo1e7zzbuq94JbOy1RhAEcAhu33UdEfHHnoI6fE0nTkLZJB5uSU3H
         UYBQ==
X-Gm-Message-State: AOAM531ltuLKyWVxtv0NiMPyIRLYMTr/wjCdqZzCUvb2theP9DIU7p6B
        axl7AEZVsEAiYEG8rENtPdMz5ixQNCBuvs+z47M=
X-Google-Smtp-Source: ABdhPJxhlhjoVSVHyqYa16k7/eubuxcbb613lOtvzRolBySylZw3wwseFqKRudnHxquWRIPuMVP8r9u8RMau0KBuFpc=
X-Received: by 2002:a17:907:3e1c:: with SMTP id hp28mr101272ejc.377.1644254274268;
 Mon, 07 Feb 2022 09:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20220205091150.6105-1-chaitanyak@nvidia.com>
In-Reply-To: <20220205091150.6105-1-chaitanyak@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Feb 2022 09:17:42 -0800
Message-ID: <CAHbLzkp6P_1F2oCPvzT7BP830S6YcyVd46gEJdgvpKSJmwvQ7Q@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] block: introduce block_rq_error tracepoint
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 5, 2022 at 1:12 AM Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> Hi Yang,
>
> I spent sometime generating V7 and testing the same. I kept your
> original authorship for the 2nd patch and added a prep patch.
> Let me know if you find anything wrong with this series.

Hi Chaitanya,

Thank you so much for preparing the patches. They look good to me. But
it seems you forgot cc Steven Rostedt. Looped him in.

>
> Following is the cover-letter for everyone else:-
>
> Currently, rasdaemon uses existing tracepoint block_rq_complete
> and filters out non-error cases in order to capture block disk errors.
> The generic tracepoint brings overhead see below and requires filtering
> for the requests which are failed due to error :-
>
> block_rq_complete() tracepint enabled fio randread :-
>
>   read: IOPS=107k, BW=418MiB/s (439MB/s)(24.5GiB/60001msec)
>   read: IOPS=107k, BW=419MiB/s (439MB/s)(24.5GiB/60001msec)
>   read: IOPS=106k, BW=416MiB/s (436MB/s)(24.4GiB/60001msec)
>   read: IOPS=107k, BW=417MiB/s (437MB/s)(24.4GiB/60001msec)
>   read: IOPS=107k, BW=418MiB/s (438MB/s)(24.5GiB/60001msec)
>   read: IOPS=106k, BW=414MiB/s (434MB/s)(24.3GiB/60001msec)
>   read: IOPS=107k, BW=418MiB/s (438MB/s)(24.5GiB/60001msec)
>   read: IOPS=106k, BW=413MiB/s (434MB/s)(24.2GiB/60001msec)
>   read: IOPS=106k, BW=414MiB/s (434MB/s)(24.2GiB/60001msec)
>   read: IOPS=109k, BW=425MiB/s (445MB/s)(24.9GiB/60001msec)
>   AVG = 417 MiB/s
>
> block_rq_complete() tracepint disabled fio randread :-
>   read: IOPS=110k, BW=428MiB/s (449MB/s)(25.1GiB/60001msec)
>   read: IOPS=107k, BW=418MiB/s (438MB/s)(24.5GiB/60001msec)
>   read: IOPS=108k, BW=421MiB/s (442MB/s)(24.7GiB/60001msec)
>   read: IOPS=107k, BW=419MiB/s (439MB/s)(24.5GiB/60001msec)
>   read: IOPS=108k, BW=422MiB/s (442MB/s)(24.7GiB/60001msec)
>   read: IOPS=108k, BW=422MiB/s (443MB/s)(24.7GiB/60001msec)
>   read: IOPS=108k, BW=422MiB/s (442MB/s)(24.7GiB/60001msec)
>   read: IOPS=108k, BW=422MiB/s (443MB/s)(24.8GiB/60001msec)
>   read: IOPS=108k, BW=421MiB/s (442MB/s)(24.7GiB/60001msec)
>   read: IOPS=108k, BW=423MiB/s (443MB/s)(24.8GiB/60001msec)
>   AVG = 421 MiB/s
>
> Introduce a new tracepoint block_rq_error() just for the error case to
> reduce the overhead of generic block_rq_complete() tracepoint to only
> trace requests with errors.
>
> Below is the detailed log of testing block_rq_complete() and
> block_rq_error() tracepoints.
>
> -ck
>
> The v3 patch was submitted in Feb 2020, and Steven reviewed the patch, but
> it was not merged to upstream. See
> https://lore.kernel.org/lkml/20200203053650.8923-1-xiyou.wangcong@gmail.com/.
>
> The problems fixed by that patch still exist and we do need it to make
> disk error handling in rasdaemon easier. So this resurrected it and
> continued the version number.
>
> V6 --> V7:
>  * Declare new trace event block_rq_completion and use it with
>    bio_rq_complete and bio_rq_error() to avoid code repetation.
>  * Add cover letter and document details.
>  * Add performance numbers.
>
> v5 --> v6:
>  * Removed disk name per Christoph and Chaitanya
>  * Kept errno since I didn't find any other block tracepoints print blk
>    status code and userspace (i.e. rasdaemon) does expect errno.
> v4 --> v5:
>  * Report the actual block layer status code instead of the errno per
>    Christoph Hellwig.
> v3 --> v4:
>  * Rebased to v5.17-rc1.
>  * Collected reviewed-by tag from Steven.
>
>
> Chaitanya Kulkarni (1):
>   block: create event class for rq completion
>
> Yang Shi (1):
>   block: introduce block_rq_error tracepoint
>
>  block/blk-mq.c               |  4 ++-
>  include/trace/events/block.h | 49 ++++++++++++++++++++++++++----------
>  2 files changed, 39 insertions(+), 14 deletions(-)
>
>
>
> * Detailed test log for two tracepoints block_rq_complete() and
>   block_rq_error():
>
> * Modified null_blk to fail any incoming REQ_OP_WRITE for
>    testing :-
>
> root@dev linux-block (for-next) # git diff drivers/block/null_blk/main.c
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 13004beb48ca..0376d0f46fdf 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1414,6 +1414,9 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
>                         return sts;
>         }
>
> +       if (op == REQ_OP_WRITE)
> +               return BLK_STS_IOERR;
> +
>         if (op == REQ_OP_FLUSH) {
>                 cmd->error = errno_to_blk_status(null_handle_flush(nullb));
>                 goto out;
> root@dev tracing # modprobe null_blk
> root@dev tracing # ls -l /dev/nullb0
> brw-rw----. 1 root disk 251, 0 Feb  4 02:45 /dev/nullb0
> root@dev tracing # # note the above major number
>
> * Test both block_rq_complete() and block_rq_error() tracepoints :-
>
> + cd tracing
> + modprobe -r null_blk
> + rm -fr /dev/nullb0
> + modprobe null_blk
> + sleep 1
> + set +x
> ###############################################################
> # Disable block_rq_[complete|error] tracepoints
> #
> + echo 0
> + echo 0
> + cat events/block/block_rq_complete/enable
> 0
> + cat events/block/block_rq_error/enable
> 0
> + set +x
> ###############################################################
> # Enable block_rq_complete() tracepoint and generate write error
> #
> + echo 1
> + cat events/block/block_rq_complete/enable
> 1
> + dd if=/dev/zero of=/dev/nullb0 bs=64k count=10 oflag=direct seek=1024
> dd: error writing '/dev/nullb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.00268675 s, 0.0 kB/s
> + cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 1/1   #P:48
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>     kworker/0:1H-1090    [000] .....   586.020342: block_rq_complete: 251,0 WS () 131072 + 128 [-5]
> + echo ''
> + set +x
> ###############################################################
> # Enable block_rq_[complete|error]() tracepoint and
> # generate write error
> #
> + echo 1
> + cat events/block/block_rq_error/enable
> 1
> + dd if=/dev/zero of=/dev/nullb0 bs=64k count=10 oflag=direct seek=10240
> dd: error writing '/dev/nullb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.0022944 s, 0.0 kB/s
> + cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 2/2   #P:48
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>     kworker/0:1H-1090    [000] .....   586.064527: block_rq_complete: 251,0 WS () 1310720 + 128 [-5]
>     kworker/0:1H-1090    [000] .....   586.066135: block_rq_error: 251,0 WS () 1310720 + 128 [-5]
> + echo ''
> + set +x
> ###############################################################
> # Disable block_rq_complete() and keep block_rq_error()
> # tracepoint enabled and generate write error
> #
> + echo 0
> + cat events/block/block_rq_complete/enable
> 0
> + dd if=/dev/zero of=/dev/nullb0 bs=64k count=10 oflag=direct seek=10240
> dd: error writing '/dev/nullb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.00235022 s, 0.0 kB/s
> + cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 1/1   #P:48
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>     kworker/0:1H-1090    [000] .....   586.110419: block_rq_error: 251,0 WS () 1310720 + 128 [-5]
> + echo ''
> + modprobe -r null_blk
> + set +x
>
> --
> 2.29.0
>
