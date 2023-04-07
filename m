Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB24C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 06:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbjDGG0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 02:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjDGG0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 02:26:14 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3B4A26D
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 23:26:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pt7fj2gY3z4f3k6L
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 14:26:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCJ9ty9kPtBGGQ--.25542S3;
        Fri, 07 Apr 2023 14:26:06 +0800 (CST)
Subject: Re: file server freezes with all nfsds stuck in D state after upgrade
 to Debian bookworm
To:     Christian Herzog <herzog@phys.ethz.ch>,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <ZC76dIshWvaWlki4@phys.ethz.ch>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <50766556-cd33-7506-13b1-64940b5995bb@huaweicloud.com>
Date:   Fri, 7 Apr 2023 14:26:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZC76dIshWvaWlki4@phys.ethz.ch>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCJ9ty9kPtBGGQ--.25542S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr18GryDGrykXrWkCF13twb_yoW5Kw4Dpa
        yYganIkr1DAw1UAws7A3WUu3WIva1Yqw47Xry3ur1SvFs5Zr1UWFyfJayUWFy5Aw4UX3y8
        Zay8t34vgw4kta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/04/07 0:59, Christian Herzog Ð´µÀ:
> Dear all,
> 
> disclaimer: this email was originally posted to linux-nfs since we believed
> the problem to be nfsd, but Chuck Lever suggested that rq_qos_wait hinted at a
> problem further down in the storage stack and referred to you guys, so here we
> are:
> 
> for our researchers we are running file servers in the hundreds-of-TiB to
> low-PiB range that export via NFS and SMB. Storage is iSCSI-over-Infiniband
> LUNs LVM'ed into individual XFS file systems. With Ubuntu 18.04 nearing EOL,
> we prepared an upgrade to Debian bookworm and tests went well. About a week
> after one of the upgrades, we ran into the first occurence of our problem: all
> of a sudden, all nfsds enter the D state and are not recoverable. However, the
> underlying file systems seem fine and can be read and written to. The only way
> out appears to be to reboot the server. The only clues are the frozen nfsds
> and strack traces like
> 
> [<0>] rq_qos_wait+0xbc/0x130
> [<0>] wbt_wait+0xa2/0x110
> [<0>] __rq_qos_throttle+0x20/0x40
> [<0>] blk_mq_submit_bio+0x2d3/0x580
> [<0>] submit_bio_noacct_nocheck+0xf7/0x2c0
> [<0>] iomap_submit_ioend+0x4b/0x80
> [<0>] iomap_do_writepage+0x4b4/0x820
> [<0>] write_cache_pages+0x180/0x4c0
> [<0>] iomap_writepages+0x1c/0x40
> [<0>] xfs_vm_writepages+0x79/0xb0 [xfs]
> [<0>] do_writepages+0xbd/0x1c0
> [<0>] filemap_fdatawrite_wbc+0x5f/0x80
> [<0>] __filemap_fdatawrite_range+0x58/0x80
> [<0>] file_write_and_wait_range+0x41/0x90
> [<0>] xfs_file_fsync+0x5a/0x2a0 [xfs]
> [<0>] nfsd_commit+0x93/0x190 [nfsd]
> [<0>] nfsd4_commit+0x5e/0x90 [nfsd]
> [<0>] nfsd4_proc_compound+0x352/0x660 [nfsd]
> [<0>] nfsd_dispatch+0x167/0x280 [nfsd]
> [<0>] svc_process_common+0x286/0x5e0 [sunrpc]
> [<0>] svc_process+0xad/0x100 [sunrpc]
> [<0>] nfsd+0xd5/0x190 [nfsd]
> [<0>] kthread+0xe6/0x110
> [<0>] ret_from_fork+0x1f/0x30

I'm not familiar with nfsd, but since above thread is waiting for
inflight request to be done, it'll be helper to monitor following
debugfs:

under /sys/kernel/debug/block/[device]/:

rqos/wbt/inflight
hctx*/tags
hctx*/sched_tags
hctx*/busy
hctx*/dispatch

This can provide a preliminary conclusion that this is due to io is too
slow or there is a bug and io is hanged.

Thanks,
Kuai
> 
> (we've also seen nfsd3). It's very sporadic, we have no idea what's triggering
> it and it has now happened 4 times on one server and once on a second.
> Needless to say, these are production systems, so we have a window of a few
> minutes for debugging before people start yelling. We've thrown everything we
> could at our test setup but so far haven't been able to trigger it.
> Any pointers would be highly appreciated.
> 
> 
> thanks and best regards,
> -Christian
> 
> 
> 
> cat /etc/os-release
> PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
> 
> uname -vr
> 6.1.0-7-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.20-1 (2023-03-19)
> 
> apt list --installed '*nfs*'
> libnfsidmap1/testing,now 1:2.6.2-4 amd64 [installed,automatic]
> nfs-common/testing,now 1:2.6.2-4 amd64 [installed]
> nfs-kernel-server/testing,now 1:2.6.2-4 amd64 [installed]
> 
> nfsconf -d
> [exportd]
>   debug = all
> [exportfs]
>   debug = all
> [general]
>   pipefs-directory = /run/rpc_pipefs
> [lockd]
>   port = 32769
>   udp-port = 32769
> [mountd]
>   debug = all
>   manage-gids = True
>   port = 892
> [nfsd]
>   debug = all
>   port = 2049
>   threads = 48
> [nfsdcld]
>   debug = all
> [nfsdcltrack]
>   debug = all
> [sm-notify]
>   debug = all
>   outgoing-port = 846
> [statd]
>   debug = all
>   outgoing-port = 2020
>   port = 662
> 
> 
> 

