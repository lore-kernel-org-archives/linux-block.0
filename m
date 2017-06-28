Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbdF1Q4O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:56:14 -0400
Date: Wed, 28 Jun 2017 12:56:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 08/12] blktrace: export cgroup info in trace
Message-ID: <20170628125610.39acd449@gandalf.local.home>
In-Reply-To: <8b9d3b0fba6863e458a6c6b380ee3880b990985a.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
        <8b9d3b0fba6863e458a6c6b380ee3880b990985a.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 28 Jun 2017 09:29:58 -0700
Shaohua Li <shli@kernel.org> wrote:

> From: Shaohua Li <shli@fb.com>
> 
> Currently blktrace isn't cgroup aware. blktrace prints out task name of
> current context, but the task of current context isn't always in the
> cgroup where the BIO comes from. We can't use task name to find out IO
> cgroup. For example, Writeback BIOs always comes from flusher thread but
> the BIOs are for different blk cgroups. Request could be requeued and
> dispatched from completely different tasks. MD/DM are another examples.
> 
> This patch tries to fix the gap. We print out cgroup fhandle info in
> blktrace. Userspace can use open_by_handle_at() syscall to find the
> cgroup by fhandle. Or userspace can use name_to_handle_at() syscall to
> find fhandle for a cgroup and use a BPF program to filter out blktrace
> for a specific cgroup.
> 
> We add a new 'blk_cgroup' trace option for blk tracer. It's default off.
> Application which doesn't know the new option isn't affected.  When it's
> on, we output fhandle info right after blk_io_trace with an extra bit
> set in event action. So from application point of view, blktrace with
> the option will output new actions.
> 
> I didn't change blk trace event yet, since I'm not sure if changing the
> trace event output is an ABI issue. If not, I'll do it later.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  include/uapi/linux/blktrace_api.h |   3 +
>  kernel/trace/blktrace.c           | 231 ++++++++++++++++++++++++++------------
>  2 files changed, 161 insertions(+), 73 deletions(-)

Doing a quick scan of the patch, nothing sticks out as an issue to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
