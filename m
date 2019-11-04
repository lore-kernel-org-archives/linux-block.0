Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7152CCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537EF218BA
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDOIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:08:09 -0500
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:47015 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727766AbfKDOIJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 09:08:09 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 09:08:08 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 631D018026108;
        Mon,  4 Nov 2019 13:59:11 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A5FAF18223251;
        Mon,  4 Nov 2019 13:59:09 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: pot84_899e0f45ebd55
X-Filterd-Recvd-Size: 3574
Received: from grimm.local.home (unknown [146.247.46.6])
        (Authenticated sender: rostedt@goodmis.org)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 13:59:05 +0000 (UTC)
Date:   Mon, 4 Nov 2019 08:59:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kernfs: Convert to u64 id
Message-ID: <20191104085901.06035a26@grimm.local.home>
In-Reply-To: <20191104084520.398584-2-namhyung@kernel.org>
References: <20191104084520.398584-1-namhyung@kernel.org>
        <20191104084520.398584-2-namhyung@kernel.org>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon,  4 Nov 2019 17:45:19 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> From: Tejun Heo <tj@kernel.org>
> 
> The kernfs_id was an union type sharing a 64bit id with 32bit ino +
> gen.  But it resulted in using 32bit inode even on 64bit systems.
> Also dealing with an union is annoying especially if you just want to
> use a single id.
> 
> Thus let's get rid of the kernfs_node_id type and use u64 directly.
> The upper 32bit is used for gen and lower is for ino on 32bit systems.
> The kernfs_id_ino() and kernfs_id_gen() helpers will take care of the
> bit handling depends on the system word size.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-block@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Tejun Heo <tj@kernel.org>
> [namhyung: fix build error in bpf_get_current_cgroup_id()]
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  fs/kernfs/dir.c                  | 36 ++++++++-----
>  fs/kernfs/file.c                 |  4 +-
>  fs/kernfs/inode.c                |  4 +-
>  fs/kernfs/kernfs-internal.h      |  2 -
>  fs/kernfs/mount.c                | 92 +++++++++++++++++++-------------
>  include/linux/cgroup.h           | 17 +++---
>  include/linux/exportfs.h         |  5 ++
>  include/linux/kernfs.h           | 47 +++++++++-------

>  include/trace/events/writeback.h | 92 ++++++++++++++++----------------

I only looked at the above file, and didn't see anything bad about it.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  kernel/bpf/helpers.c             |  2 +-
>  kernel/cgroup/cgroup.c           |  5 +-
>  kernel/trace/blktrace.c          | 66 +++++++++++------------
>  net/core/filter.c                |  4 +-
>  13 files changed, 207 insertions(+), 169 deletions(-)

