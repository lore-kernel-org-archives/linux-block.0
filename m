Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43621 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1041694AbdDUSTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 14:19:51 -0400
Subject: Re: for-4.12/block branch
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1492788745.2550.1.camel@sandisk.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
Date: Fri, 21 Apr 2017 10:25:34 -0600
MIME-Version: 1.0
In-Reply-To: <1492788745.2550.1.camel@sandisk.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/21/2017 09:32 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> Since yesterday the following complaint is reported frequently after having
> installed the for-4.12/block branch on my test setup. Unless someone has a
> better proposal, I will run a bisect.
> 
> BUG: sleeping function called from invalid context at ./include/linux/buffer_head.h:349
> in_atomic(): 1, irqs_disabled(): 0, pid: 8019, name: find
> CPU: 10 PID: 8019 Comm: find Tainted: G        W I     4.11.0-rc4-dbg+ #2
> Call Trace:
>  dump_stack+0x68/0x93
>  ___might_sleep+0x16e/0x230
>  __might_sleep+0x4a/0x80
>  __ext4_get_inode_loc+0x1e0/0x4e0
>  ext4_iget+0x70/0xbc0
>  ext4_iget_normal+0x2f/0x40
>  ext4_lookup+0xb6/0x1f0
>  lookup_slow+0x104/0x1e0
>  walk_component+0x19a/0x330
>  path_lookupat+0x4b/0x100
>  filename_lookup+0x9a/0x110
>  user_path_at_empty+0x36/0x40
>  vfs_statx+0x67/0xc0
>  SYSC_newfstatat+0x20/0x40
>  SyS_newfstatat+0xe/0x10
>  entry_SYSCALL_64_fastpath+0x18/0xad

How are you reproducing this? I've been running testing on the test box
and I run it on my laptop as well, but I haven't seen anything odd.

-- 
Jens Axboe
