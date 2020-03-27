Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6955BC43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 00:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD9F20663
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 00:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKb4GkzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgC0AUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:20:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgC0AUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 20:20:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R0JJSn128933;
        Fri, 27 Mar 2020 00:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wLL6oqJT+Wo/kFkyoapvPeJCKYiS22bl499rz/6IYlQ=;
 b=gKb4GkzCAPL2aTYe44GsE4kt5AVHMrePwKiC8CzEWEVgGKglPxW9q1W29nF3AIWs60q+
 rE81JQzkFoe/onBsJMN6/3P87PsaQtQIKT54zgom8jY/xb1EOtAsLTedHT1q1jgqwp3R
 7y/bcmzHti3o/jRAymEHwRM+LAMgZq6KbAL/8nEvUOxwZU/0kmZUs/68HcsEbWlW4yc+
 uAPysqwRt5X597sr8NUpDTpU6bUISQp63S8vQC9+iL+z74gO3H2UclNlIP0dJ/KRaoVf
 cOzcq4sFCXaHpIGiAN3HZzo0jIVtTR2+5oqcwgkZ9dc35AzeaCSu70677s54d66uOp2q Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3014598exd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 00:20:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R0K1ex133553;
        Fri, 27 Mar 2020 00:20:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3006r9cf2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 00:20:01 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02R0Jv4k027798;
        Fri, 27 Mar 2020 00:19:57 GMT
Received: from [10.159.246.150] (/10.159.246.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 17:19:57 -0700
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
To:     syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000047770d05a1c70ecb@google.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <ffabca27-309e-4a6e-eac2-d03a56a7493a@oracle.com>
Date:   Thu, 26 Mar 2020 17:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <00000000000047770d05a1c70ecb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270000
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think the issue is because of line 2827, that is, the q->nr_hw_queues is
updated too earlier. It is still possible the init would fail later.

2809 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
2810                                                 struct request_queue *q)
2811 {
2812         int i, j, end;
2813         struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
2814
2815         if (q->nr_hw_queues < set->nr_hw_queues) {
2816                 struct blk_mq_hw_ctx **new_hctxs;
2817
2818                 new_hctxs = kcalloc_node(set->nr_hw_queues,
2819                                        sizeof(*new_hctxs), GFP_KERNEL,
2820                                        set->numa_node);
2821                 if (!new_hctxs)
2822                         return;
2823                 if (hctxs)
2824                         memcpy(new_hctxs, hctxs, q->nr_hw_queues *
2825                                sizeof(*hctxs));
2826                 q->queue_hw_ctx = new_hctxs;
2827                 q->nr_hw_queues = set->nr_hw_queues;
2828                 kfree(hctxs);
2829                 hctxs = new_hctxs;
2830         }


Let's assume below line 2847 is failed (e.g.,
blk_mq_alloc_and_init_hctx()->blk_mq_alloc_hctx()->zalloc_cpumask_var_node(&hctx->cpumask,
gfp, node)).

As a result, we would come to line 2865 and 2866, and q->nr_hw_queues is already
set to set->nr_hw_queues at above line 2827.

2832         /* protect against switching io scheduler  */
2833         mutex_lock(&q->sysfs_lock);
2834         for (i = 0; i < set->nr_hw_queues; i++) {
2835                 int node;
2836                 struct blk_mq_hw_ctx *hctx;
2837
2838                 node =
blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], i);
2839                 /*
2840                  * If the hw queue has been mapped to another numa node,
2841                  * we need to realloc the hctx. If allocation fails, fallback
2842                  * to use the previous one.
2843                  */
2844                 if (hctxs[i] && (hctxs[i]->numa_node == node))
2845                         continue;
2846
2847                 hctx = blk_mq_alloc_and_init_hctx(set, q, i, node);
2848                 if (hctx) {
2849                         if (hctxs[i])
2850                                 blk_mq_exit_hctx(q, set, hctxs[i], i);
2851                         hctxs[i] = hctx;
2852                 } else {
2853                         if (hctxs[i])
2854                                 pr_warn("Allocate new hctx on node %d fails,\
2855                                                 fallback to previous one on
node %d\n",
2856                                                 node, hctxs[i]->numa_node);
2857                         else
2858                                 break;
2859                 }
2860         }
2861         /*
2862          * Increasing nr_hw_queues fails. Free the newly allocated
2863          * hctxs and keep the previous q->nr_hw_queues.
2864          */
2865         if (i != set->nr_hw_queues) {
2866                 j = q->nr_hw_queues;
2867                 end = i;
2868         } else {
2869                 j = i;
2870                 end = q->nr_hw_queues;
2871                 q->nr_hw_queues = set->nr_hw_queues;
2872         }

The above would not change q->nr_hw_queues again, although hctx are not
allocated successfully. Later we hit fault at line 2501 and line 2502.

2494 static void blk_mq_map_swqueue(struct request_queue *q)
2495 {
2496         unsigned int i, j, hctx_idx;
2497         struct blk_mq_hw_ctx *hctx;
2498         struct blk_mq_ctx *ctx;
2499         struct blk_mq_tag_set *set = q->tag_set;
2500
2501         queue_for_each_hw_ctx(q, hctx, i) {
2502                 cpumask_clear(hctx->cpumask);
2503                 hctx->nr_ctx = 0;
2504                 hctx->dispatch_from = NULL;
2505         }


I can reproduce on purpose with below patch.

https://github.com/finallyjustice/patchset/blob/master/syzbot%2B313d95e8a7a49263f88d-reproducer.patch

The patch is used to emulate a memory allocation failure for:

blk_mq_alloc_and_init_hctx()
 -> blk_mq_alloc_hctx()
     ->zalloc_cpumask_var_node(&hctx->cpumask, gfp, node)).


Dongli Zhang

On 3/26/20 12:33 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://urldefense.com/v3/__https://syzkaller.appspot.com/x/log.txt?x=15e31ba7e00000__;!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhujio9zJzSQ$ 
> kernel config:  https://urldefense.com/v3/__https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692__;!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhujiOaxMATc$ 
> dashboard link: https://urldefense.com/v3/__https://syzkaller.appspot.com/bug?extid=313d95e8a7a49263f88d__;!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhujiid_YjTs$ 
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://urldefense.com/v3/__https://syzkaller.appspot.com/x/repro.syz?x=13850447e00000__;!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhujiAWmy3bw$ 
> C reproducer:   https://urldefense.com/v3/__https://syzkaller.appspot.com/x/repro.c?x=119a26f5e00000__;!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhujiMv3YHnM$ 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com
> 
> RSP: 002b:00007ffca409c958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffca409c970 RCX: 00000000004411c9
> RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> ==================================================================
> BUG: KASAN: null-ptr-deref in memset include/linux/string.h:366 [inline]
> BUG: KASAN: null-ptr-deref in bitmap_zero include/linux/bitmap.h:232 [inline]
> BUG: KASAN: null-ptr-deref in cpumask_clear include/linux/cpumask.h:406 [inline]
> BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0xea/0xe90 block/blk-mq.c:2502
> Write of size 8 at addr 0000000000000118 by task syz-executor083/7593
> 
> CPU: 0 PID: 7593 Comm: syz-executor083 Not tainted 5.6.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  __kasan_report.cold+0x5/0x32 mm/kasan/report.c:510
>  kasan_report+0xe/0x20 mm/kasan/common.c:641
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x128/0x190 mm/kasan/generic.c:192
>  memset+0x20/0x40 mm/kasan/common.c:108
>  memset include/linux/string.h:366 [inline]
>  bitmap_zero include/linux/bitmap.h:232 [inline]
>  cpumask_clear include/linux/cpumask.h:406 [inline]
>  blk_mq_map_swqueue+0xea/0xe90 block/blk-mq.c:2502
>  blk_mq_init_allocated_queue+0xf21/0x13c0 block/blk-mq.c:2943
>  blk_mq_init_queue+0x5c/0xa0 block/blk-mq.c:2733
>  loop_add+0x2cb/0x8a0 drivers/block/loop.c:2022
>  loop_control_ioctl drivers/block/loop.c:2175 [inline]
>  loop_control_ioctl+0x153/0x340 drivers/block/loop.c:2157
>  vfs_ioctl fs/ioctl.c:47 [inline]
>  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
>  __do_sys_ioctl fs/ioctl.c:772 [inline]
>  __se_sys_ioctl fs/ioctl.c:770 [inline]
>  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4411c9
> Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffca409c958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffca409c970 RCX: 00000000004411c9
> RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://urldefense.com/v3/__https://goo.gl/tpsmEJ__;!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhuji0GhH8ds$  for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://urldefense.com/v3/__https://goo.gl/tpsmEJ*status__;Iw!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhuji-FPYYaM$  for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://urldefense.com/v3/__https://goo.gl/tpsmEJ*testing-patches__;Iw!!GqivPVa7Brio!JzLj_P7A2CZ5lDE3ebmGzrvRKgaonmEiUGcG7zyHXS3fLkHfwlOva46qhujip-J1ifc$ 
> 
