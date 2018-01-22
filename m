Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44143 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750878AbeAVDLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jan 2018 22:11:16 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: blk-mq hangs easily with LLVM+clang test suite
From: David Zarzycki <dave@znu.io>
In-Reply-To: <964830FA-5F0F-49D3-8608-FBCAF7D60326@znu.io>
Date: Sun, 21 Jan 2018 22:11:13 -0500
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <1967E715-FE89-4D89-AD20-DE8A20D46769@znu.io>
References: <83F7B94F-562A-44A5-92F9-939FE4FD5A99@znu.io>
 <1516555064.3434.5.camel@wdc.com>
 <964830FA-5F0F-49D3-8608-FBCAF7D60326@znu.io>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

Looks like I got lucky. Here is the output with the branch and patch you =
suggested:

[root@dell block]# find . -type f -exec grep -aH . {} \;
./nvme0n1/hctx6/cpu319/completed:0 0
./nvme0n1/hctx6/cpu319/merged:0
./nvme0n1/hctx6/cpu319/dispatched:0 0
./nvme0n1/hctx6/cpu317/completed:0 0
./nvme0n1/hctx6/cpu317/merged:0
./nvme0n1/hctx6/cpu317/dispatched:0 0
./nvme0n1/hctx6/cpu315/completed:0 0
./nvme0n1/hctx6/cpu315/merged:0
./nvme0n1/hctx6/cpu315/dispatched:0 0
./nvme0n1/hctx6/cpu313/completed:0 0
./nvme0n1/hctx6/cpu313/merged:0
./nvme0n1/hctx6/cpu313/dispatched:0 0
./nvme0n1/hctx6/cpu311/completed:0 0
./nvme0n1/hctx6/cpu311/merged:0
./nvme0n1/hctx6/cpu311/dispatched:0 0
./nvme0n1/hctx6/cpu309/completed:0 0
./nvme0n1/hctx6/cpu309/merged:0
./nvme0n1/hctx6/cpu309/dispatched:0 0
./nvme0n1/hctx6/cpu307/completed:0 0
./nvme0n1/hctx6/cpu307/merged:0
./nvme0n1/hctx6/cpu307/dispatched:0 0
./nvme0n1/hctx6/cpu305/completed:0 0
./nvme0n1/hctx6/cpu305/merged:0
./nvme0n1/hctx6/cpu305/dispatched:0 0
./nvme0n1/hctx6/cpu303/completed:0 0
./nvme0n1/hctx6/cpu303/merged:0
./nvme0n1/hctx6/cpu303/dispatched:0 0
./nvme0n1/hctx6/cpu301/completed:0 0
./nvme0n1/hctx6/cpu301/merged:0
./nvme0n1/hctx6/cpu301/dispatched:0 0
./nvme0n1/hctx6/cpu299/completed:0 0
./nvme0n1/hctx6/cpu299/merged:0
./nvme0n1/hctx6/cpu299/dispatched:0 0
./nvme0n1/hctx6/cpu297/completed:0 0
./nvme0n1/hctx6/cpu297/merged:0
./nvme0n1/hctx6/cpu297/dispatched:0 0
./nvme0n1/hctx6/cpu295/completed:0 0
./nvme0n1/hctx6/cpu295/merged:0
./nvme0n1/hctx6/cpu295/dispatched:0 0
./nvme0n1/hctx6/cpu293/completed:0 0
./nvme0n1/hctx6/cpu293/merged:0
./nvme0n1/hctx6/cpu293/dispatched:0 0
./nvme0n1/hctx6/cpu291/completed:0 0
./nvme0n1/hctx6/cpu291/merged:0
./nvme0n1/hctx6/cpu291/dispatched:0 0
./nvme0n1/hctx6/cpu289/completed:0 0
./nvme0n1/hctx6/cpu289/merged:0
./nvme0n1/hctx6/cpu289/dispatched:0 0
./nvme0n1/hctx6/cpu287/completed:0 0
./nvme0n1/hctx6/cpu287/merged:0
./nvme0n1/hctx6/cpu287/dispatched:0 0
./nvme0n1/hctx6/cpu285/completed:0 0
./nvme0n1/hctx6/cpu285/merged:0
./nvme0n1/hctx6/cpu285/dispatched:0 0
./nvme0n1/hctx6/cpu283/completed:0 0
./nvme0n1/hctx6/cpu283/merged:0
./nvme0n1/hctx6/cpu283/dispatched:0 0
./nvme0n1/hctx6/cpu281/completed:0 0
./nvme0n1/hctx6/cpu281/merged:0
./nvme0n1/hctx6/cpu281/dispatched:0 0
./nvme0n1/hctx6/cpu279/completed:0 0
./nvme0n1/hctx6/cpu279/merged:0
./nvme0n1/hctx6/cpu279/dispatched:0 0
./nvme0n1/hctx6/cpu277/completed:0 0
./nvme0n1/hctx6/cpu277/merged:0
./nvme0n1/hctx6/cpu277/dispatched:0 0
./nvme0n1/hctx6/cpu275/completed:0 0
./nvme0n1/hctx6/cpu275/merged:0
./nvme0n1/hctx6/cpu275/dispatched:0 0
./nvme0n1/hctx6/cpu273/completed:0 0
./nvme0n1/hctx6/cpu273/merged:0
./nvme0n1/hctx6/cpu273/dispatched:0 0
./nvme0n1/hctx6/cpu271/completed:0 0
./nvme0n1/hctx6/cpu271/merged:0
./nvme0n1/hctx6/cpu271/dispatched:0 0
./nvme0n1/hctx6/cpu269/completed:0 0
./nvme0n1/hctx6/cpu269/merged:0
./nvme0n1/hctx6/cpu269/dispatched:0 0
./nvme0n1/hctx6/cpu267/completed:0 0
./nvme0n1/hctx6/cpu267/merged:0
./nvme0n1/hctx6/cpu267/dispatched:0 0
./nvme0n1/hctx6/cpu265/completed:0 0
./nvme0n1/hctx6/cpu265/merged:0
./nvme0n1/hctx6/cpu265/dispatched:0 0
./nvme0n1/hctx6/cpu263/completed:0 0
./nvme0n1/hctx6/cpu263/merged:0
./nvme0n1/hctx6/cpu263/dispatched:0 0
./nvme0n1/hctx6/cpu261/completed:0 0
./nvme0n1/hctx6/cpu261/merged:0
./nvme0n1/hctx6/cpu261/dispatched:0 0
./nvme0n1/hctx6/cpu259/completed:0 0
./nvme0n1/hctx6/cpu259/merged:0
./nvme0n1/hctx6/cpu259/dispatched:0 0
./nvme0n1/hctx6/cpu257/completed:0 0
./nvme0n1/hctx6/cpu257/merged:0
./nvme0n1/hctx6/cpu257/dispatched:0 0
./nvme0n1/hctx6/cpu255/completed:0 0
./nvme0n1/hctx6/cpu255/merged:0
./nvme0n1/hctx6/cpu255/dispatched:0 0
./nvme0n1/hctx6/cpu253/completed:0 0
./nvme0n1/hctx6/cpu253/merged:0
./nvme0n1/hctx6/cpu253/dispatched:0 0
./nvme0n1/hctx6/cpu251/completed:0 0
./nvme0n1/hctx6/cpu251/merged:0
./nvme0n1/hctx6/cpu251/dispatched:0 0
./nvme0n1/hctx6/cpu249/completed:0 0
./nvme0n1/hctx6/cpu249/merged:0
./nvme0n1/hctx6/cpu249/dispatched:0 0
./nvme0n1/hctx6/cpu247/completed:0 0
./nvme0n1/hctx6/cpu247/merged:0
./nvme0n1/hctx6/cpu247/dispatched:0 0
./nvme0n1/hctx6/cpu245/completed:0 0
./nvme0n1/hctx6/cpu245/merged:0
./nvme0n1/hctx6/cpu245/dispatched:0 0
./nvme0n1/hctx6/cpu243/completed:0 0
./nvme0n1/hctx6/cpu243/merged:0
./nvme0n1/hctx6/cpu243/dispatched:0 0
./nvme0n1/hctx6/cpu241/completed:0 0
./nvme0n1/hctx6/cpu241/merged:0
./nvme0n1/hctx6/cpu241/dispatched:0 0
./nvme0n1/hctx6/active:0
./nvme0n1/hctx6/run:0
./nvme0n1/hctx6/queued:0
./nvme0n1/hctx6/dispatched:       0	0
./nvme0n1/hctx6/dispatched:       1	0
./nvme0n1/hctx6/dispatched:       2	0
./nvme0n1/hctx6/dispatched:       4	0
./nvme0n1/hctx6/dispatched:       8	0
./nvme0n1/hctx6/dispatched:      16	0
./nvme0n1/hctx6/dispatched:      32+	0
./nvme0n1/hctx6/io_poll:considered=3D0
./nvme0n1/hctx6/io_poll:invoked=3D0
./nvme0n1/hctx6/io_poll:success=3D0
./nvme0n1/hctx6/tags_bitmap:00000000: 0000 0000 0000 0000 0000 0000 0000 =
0000
./nvme0n1/hctx6/tags:nr_tags=3D127
./nvme0n1/hctx6/tags:nr_reserved_tags=3D0
./nvme0n1/hctx6/tags:active_queues=3D0
./nvme0n1/hctx6/tags:bitmap_tags:
./nvme0n1/hctx6/tags:depth=3D127
./nvme0n1/hctx6/tags:busy=3D0
./nvme0n1/hctx6/tags:bits_per_word=3D16
./nvme0n1/hctx6/tags:map_nr=3D8
./nvme0n1/hctx6/tags:alloc_hint=3D{113, 51, 38, 42, 44, 126, 87, 87, =
105, 123, 41, 68, 99, 69, 11, 76, 59, 27, 61, 63, 84, 80, 17, 9, 123, =
117, 102, 101, 115, 52, 17, 99, 73, 81, 89, 88, 8, 28, 10, 69, 30, 35, =
31, 41, 123, 25, 87, 25, 78, 8, 46, 0, 60, 47, 65, 94, 0, 42, 108, 90, =
72, 110, 96, 37, 125, 69, 4, 17, 53, 40, 31, 112, 50, 59, 7, 0, 98, 81, =
126, 107, 82, 48, 92, 109, 118, 123, 87, 80, 104, 54, 43, 103, 91, 105, =
11, 97, 24, 9, 23, 115, 99, 28, 90, 16, 15, 14, 72, 91, 45, 1, 74, 88, =
112, 26, 56, 102, 101, 72, 62, 8, 110, 33, 85, 55, 105, 63, 60, 100, 86, =
39, 58, 108, 117, 27, 9, 23, 20, 96, 35, 46, 116, 34, 86, 118, 108, 59, =
65, 113, 74, 107, 87, 68, 36, 52, 85, 72, 82, 81, 69, 62, 42, 124, 120, =
92, 56, 104, 23, 24, 35, 24, 64, 51, 55, 100, 89, 88, 43, 111, 124, 23, =
55, 64, 92, 56, 25, 106, 109, 117, 6, 121, 32, 124, 125, 79, 84, 58, 54, =
66, 46, 85, 16, 65, 84, 8, 7, 3, 28, 18, 71, 87, 93, 115, 100, 14, 49, =
10, 70, 75, 64, 122, 113, 2, 60, 54, 75, 73, 66, 99, 42, 89, 38, 33, 70, =
106, 88, 16, 74, 84, 28, 28, 106, 68, 75, 58, 70, 125, 7, 39, 121, 58, =
8, 125, 60, 38, 13, 104, 2, 96, 41, 18, 92, 34, 22, 93, 54, 7, 27, 119, =
109, 79, 122, 36, 26, 103, 105, 86, 66, 114, 33, 28, 37, 116, 120, 29, =
86, 74, 99, 13, 51, 124, 37, 108, 105, 49, 55, 119, 21, 61, 105, 121, =
50, 28, 19, 90, 60, 101, 86, 99, 109, 40, 45, 80, 32, 7, 35, 80, 92, =
106, 52, 23}
./nvme0n1/hctx6/tags:wake_batch=3D8
./nvme0n1/hctx6/tags:wake_index=3D0
./nvme0n1/hctx6/tags:ws=3D{
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx6/tags:}
./nvme0n1/hctx6/tags:round_robin=3D0
./nvme0n1/hctx6/ctx_map:00000000: 0000 0000 00
./nvme0n1/hctx6/flags:alloc_policy=3DFIFO SHOULD_MERGE
./nvme0n1/hctx5/cpu239/completed:0 0
./nvme0n1/hctx5/cpu239/merged:0
./nvme0n1/hctx5/cpu239/dispatched:0 0
./nvme0n1/hctx5/cpu237/completed:0 0
./nvme0n1/hctx5/cpu237/merged:0
./nvme0n1/hctx5/cpu237/dispatched:0 0
./nvme0n1/hctx5/cpu235/completed:0 0
./nvme0n1/hctx5/cpu235/merged:0
./nvme0n1/hctx5/cpu235/dispatched:0 0
./nvme0n1/hctx5/cpu233/completed:0 0
./nvme0n1/hctx5/cpu233/merged:0
./nvme0n1/hctx5/cpu233/dispatched:0 0
./nvme0n1/hctx5/cpu231/completed:0 0
./nvme0n1/hctx5/cpu231/merged:0
./nvme0n1/hctx5/cpu231/dispatched:0 0
./nvme0n1/hctx5/cpu229/completed:0 0
./nvme0n1/hctx5/cpu229/merged:0
./nvme0n1/hctx5/cpu229/dispatched:0 0
./nvme0n1/hctx5/cpu227/completed:0 0
./nvme0n1/hctx5/cpu227/merged:0
./nvme0n1/hctx5/cpu227/dispatched:0 0
./nvme0n1/hctx5/cpu225/completed:0 0
./nvme0n1/hctx5/cpu225/merged:0
./nvme0n1/hctx5/cpu225/dispatched:0 0
./nvme0n1/hctx5/cpu223/completed:0 0
./nvme0n1/hctx5/cpu223/merged:0
./nvme0n1/hctx5/cpu223/dispatched:0 0
./nvme0n1/hctx5/cpu221/completed:0 0
./nvme0n1/hctx5/cpu221/merged:0
./nvme0n1/hctx5/cpu221/dispatched:0 0
./nvme0n1/hctx5/cpu219/completed:0 0
./nvme0n1/hctx5/cpu219/merged:0
./nvme0n1/hctx5/cpu219/dispatched:0 0
./nvme0n1/hctx5/cpu217/completed:0 0
./nvme0n1/hctx5/cpu217/merged:0
./nvme0n1/hctx5/cpu217/dispatched:0 0
./nvme0n1/hctx5/cpu215/completed:0 0
./nvme0n1/hctx5/cpu215/merged:0
./nvme0n1/hctx5/cpu215/dispatched:0 0
./nvme0n1/hctx5/cpu213/completed:0 0
./nvme0n1/hctx5/cpu213/merged:0
./nvme0n1/hctx5/cpu213/dispatched:0 0
./nvme0n1/hctx5/cpu211/completed:0 0
./nvme0n1/hctx5/cpu211/merged:0
./nvme0n1/hctx5/cpu211/dispatched:0 0
./nvme0n1/hctx5/cpu209/completed:0 0
./nvme0n1/hctx5/cpu209/merged:0
./nvme0n1/hctx5/cpu209/dispatched:0 0
./nvme0n1/hctx5/cpu207/completed:0 0
./nvme0n1/hctx5/cpu207/merged:0
./nvme0n1/hctx5/cpu207/dispatched:0 0
./nvme0n1/hctx5/cpu205/completed:0 0
./nvme0n1/hctx5/cpu205/merged:0
./nvme0n1/hctx5/cpu205/dispatched:0 0
./nvme0n1/hctx5/cpu203/completed:0 0
./nvme0n1/hctx5/cpu203/merged:0
./nvme0n1/hctx5/cpu203/dispatched:0 0
./nvme0n1/hctx5/cpu201/completed:0 0
./nvme0n1/hctx5/cpu201/merged:0
./nvme0n1/hctx5/cpu201/dispatched:0 0
./nvme0n1/hctx5/cpu199/completed:0 0
./nvme0n1/hctx5/cpu199/merged:0
./nvme0n1/hctx5/cpu199/dispatched:0 0
./nvme0n1/hctx5/cpu197/completed:0 0
./nvme0n1/hctx5/cpu197/merged:0
./nvme0n1/hctx5/cpu197/dispatched:0 0
./nvme0n1/hctx5/cpu195/completed:0 0
./nvme0n1/hctx5/cpu195/merged:0
./nvme0n1/hctx5/cpu195/dispatched:0 0
./nvme0n1/hctx5/cpu193/completed:0 0
./nvme0n1/hctx5/cpu193/merged:0
./nvme0n1/hctx5/cpu193/dispatched:0 0
./nvme0n1/hctx5/cpu191/completed:0 0
./nvme0n1/hctx5/cpu191/merged:0
./nvme0n1/hctx5/cpu191/dispatched:0 0
./nvme0n1/hctx5/cpu189/completed:0 0
./nvme0n1/hctx5/cpu189/merged:0
./nvme0n1/hctx5/cpu189/dispatched:0 0
./nvme0n1/hctx5/cpu187/completed:0 0
./nvme0n1/hctx5/cpu187/merged:0
./nvme0n1/hctx5/cpu187/dispatched:0 0
./nvme0n1/hctx5/cpu185/completed:0 0
./nvme0n1/hctx5/cpu185/merged:0
./nvme0n1/hctx5/cpu185/dispatched:0 0
./nvme0n1/hctx5/cpu183/completed:0 0
./nvme0n1/hctx5/cpu183/merged:0
./nvme0n1/hctx5/cpu183/dispatched:0 0
./nvme0n1/hctx5/cpu181/completed:0 0
./nvme0n1/hctx5/cpu181/merged:0
./nvme0n1/hctx5/cpu181/dispatched:0 0
./nvme0n1/hctx5/cpu179/completed:0 0
./nvme0n1/hctx5/cpu179/merged:0
./nvme0n1/hctx5/cpu179/dispatched:0 0
./nvme0n1/hctx5/cpu177/completed:0 0
./nvme0n1/hctx5/cpu177/merged:0
./nvme0n1/hctx5/cpu177/dispatched:0 0
./nvme0n1/hctx5/cpu175/completed:0 0
./nvme0n1/hctx5/cpu175/merged:0
./nvme0n1/hctx5/cpu175/dispatched:0 0
./nvme0n1/hctx5/cpu173/completed:0 0
./nvme0n1/hctx5/cpu173/merged:0
./nvme0n1/hctx5/cpu173/dispatched:0 0
./nvme0n1/hctx5/cpu171/completed:0 0
./nvme0n1/hctx5/cpu171/merged:0
./nvme0n1/hctx5/cpu171/dispatched:0 0
./nvme0n1/hctx5/cpu169/completed:0 0
./nvme0n1/hctx5/cpu169/merged:0
./nvme0n1/hctx5/cpu169/dispatched:0 0
./nvme0n1/hctx5/cpu167/completed:0 0
./nvme0n1/hctx5/cpu167/merged:0
./nvme0n1/hctx5/cpu167/dispatched:0 0
./nvme0n1/hctx5/cpu165/completed:0 0
./nvme0n1/hctx5/cpu165/merged:0
./nvme0n1/hctx5/cpu165/dispatched:0 0
./nvme0n1/hctx5/cpu163/completed:0 0
./nvme0n1/hctx5/cpu163/merged:0
./nvme0n1/hctx5/cpu163/dispatched:0 0
./nvme0n1/hctx5/cpu161/completed:0 0
./nvme0n1/hctx5/cpu161/merged:0
./nvme0n1/hctx5/cpu161/dispatched:0 0
./nvme0n1/hctx5/active:0
./nvme0n1/hctx5/run:0
./nvme0n1/hctx5/queued:0
./nvme0n1/hctx5/dispatched:       0	0
./nvme0n1/hctx5/dispatched:       1	0
./nvme0n1/hctx5/dispatched:       2	0
./nvme0n1/hctx5/dispatched:       4	0
./nvme0n1/hctx5/dispatched:       8	0
./nvme0n1/hctx5/dispatched:      16	0
./nvme0n1/hctx5/dispatched:      32+	0
./nvme0n1/hctx5/io_poll:considered=3D0
./nvme0n1/hctx5/io_poll:invoked=3D0
./nvme0n1/hctx5/io_poll:success=3D0
./nvme0n1/hctx5/tags_bitmap:00000000: 0000 0000 0000 0000 0000 0000 0000 =
0000
./nvme0n1/hctx5/tags:nr_tags=3D127
./nvme0n1/hctx5/tags:nr_reserved_tags=3D0
./nvme0n1/hctx5/tags:active_queues=3D0
./nvme0n1/hctx5/tags:bitmap_tags:
./nvme0n1/hctx5/tags:depth=3D127
./nvme0n1/hctx5/tags:busy=3D0
./nvme0n1/hctx5/tags:bits_per_word=3D16
./nvme0n1/hctx5/tags:map_nr=3D8
./nvme0n1/hctx5/tags:alloc_hint=3D{110, 99, 50, 93, 67, 82, 4, 118, 64, =
105, 112, 111, 124, 41, 61, 69, 66, 37, 108, 52, 84, 85, 58, 85, 68, 61, =
119, 68, 4, 14, 40, 19, 9, 78, 36, 108, 3, 49, 123, 93, 126, 74, 57, 90, =
110, 73, 14, 97, 69, 56, 64, 95, 113, 26, 117, 35, 29, 46, 126, 124, 67, =
17, 94, 83, 115, 38, 1, 72, 22, 82, 60, 18, 79, 5, 104, 42, 66, 120, 20, =
45, 18, 57, 49, 1, 44, 25, 66, 92, 48, 121, 104, 75, 85, 67, 114, 74, 8, =
37, 26, 43, 29, 59, 93, 106, 111, 56, 115, 80, 55, 99, 97, 93, 77, 25, =
24, 84, 113, 7, 74, 104, 52, 21, 74, 121, 19, 100, 91, 100, 113, 35, 56, =
12, 46, 80, 107, 73, 122, 35, 81, 57, 63, 85, 11, 19, 49, 101, 105, 26, =
106, 66, 81, 39, 52, 40, 31, 121, 121, 81, 116, 50, 83, 107, 32, 33, 18, =
65, 79, 93, 121, 50, 61, 76, 29, 5, 101, 9, 32, 116, 73, 53, 19, 121, 8, =
34, 75, 74, 53, 62, 121, 92, 102, 35, 20, 119, 0, 64, 51, 6, 53, 120, =
27, 38, 92, 1, 116, 94, 56, 109, 107, 6, 111, 66, 53, 10, 90, 37, 109, =
122, 18, 97, 86, 121, 56, 8, 11, 107, 53, 12, 66, 36, 119, 64, 22, 105, =
3, 109, 108, 27, 81, 95, 21, 18, 81, 74, 19, 0, 113, 38, 92, 79, 39, 4, =
12, 120, 112, 104, 30, 77, 94, 52, 106, 63, 43, 126, 46, 3, 107, 90, =
101, 111, 101, 96, 0, 120, 121, 63, 49, 99, 112, 121, 40, 126, 60, 76, =
107, 110, 70, 47, 7, 6, 11, 20, 74, 42, 10, 39, 56, 83, 126, 92, 11, 54, =
0, 19, 41, 62, 20, 88, 123, 83, 33, 44, 47, 123, 117, 71, 50, 67, 84, =
25}
./nvme0n1/hctx5/tags:wake_batch=3D8
./nvme0n1/hctx5/tags:wake_index=3D0
./nvme0n1/hctx5/tags:ws=3D{
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx5/tags:}
./nvme0n1/hctx5/tags:round_robin=3D0
./nvme0n1/hctx5/ctx_map:00000000: 0000 0000 00
./nvme0n1/hctx5/flags:alloc_policy=3DFIFO SHOULD_MERGE
./nvme0n1/hctx4/cpu159/completed:0 0
./nvme0n1/hctx4/cpu159/merged:0
./nvme0n1/hctx4/cpu159/dispatched:0 0
./nvme0n1/hctx4/cpu157/completed:0 0
./nvme0n1/hctx4/cpu157/merged:0
./nvme0n1/hctx4/cpu157/dispatched:0 0
./nvme0n1/hctx4/cpu155/completed:0 0
./nvme0n1/hctx4/cpu155/merged:0
./nvme0n1/hctx4/cpu155/dispatched:0 0
./nvme0n1/hctx4/cpu153/completed:0 0
./nvme0n1/hctx4/cpu153/merged:0
./nvme0n1/hctx4/cpu153/dispatched:0 0
./nvme0n1/hctx4/cpu151/completed:0 0
./nvme0n1/hctx4/cpu151/merged:0
./nvme0n1/hctx4/cpu151/dispatched:0 0
./nvme0n1/hctx4/cpu149/completed:0 0
./nvme0n1/hctx4/cpu149/merged:0
./nvme0n1/hctx4/cpu149/dispatched:0 0
./nvme0n1/hctx4/cpu147/completed:0 0
./nvme0n1/hctx4/cpu147/merged:0
./nvme0n1/hctx4/cpu147/dispatched:0 0
./nvme0n1/hctx4/cpu145/completed:0 0
./nvme0n1/hctx4/cpu145/merged:0
./nvme0n1/hctx4/cpu145/dispatched:0 0
./nvme0n1/hctx4/cpu143/completed:0 0
./nvme0n1/hctx4/cpu143/merged:0
./nvme0n1/hctx4/cpu143/dispatched:0 0
./nvme0n1/hctx4/cpu141/completed:0 0
./nvme0n1/hctx4/cpu141/merged:0
./nvme0n1/hctx4/cpu141/dispatched:0 0
./nvme0n1/hctx4/cpu139/completed:0 0
./nvme0n1/hctx4/cpu139/merged:0
./nvme0n1/hctx4/cpu139/dispatched:0 0
./nvme0n1/hctx4/cpu137/completed:0 0
./nvme0n1/hctx4/cpu137/merged:0
./nvme0n1/hctx4/cpu137/dispatched:0 0
./nvme0n1/hctx4/cpu135/completed:0 0
./nvme0n1/hctx4/cpu135/merged:0
./nvme0n1/hctx4/cpu135/dispatched:0 0
./nvme0n1/hctx4/cpu133/completed:0 0
./nvme0n1/hctx4/cpu133/merged:0
./nvme0n1/hctx4/cpu133/dispatched:0 0
./nvme0n1/hctx4/cpu131/completed:0 0
./nvme0n1/hctx4/cpu131/merged:0
./nvme0n1/hctx4/cpu131/dispatched:0 0
./nvme0n1/hctx4/cpu129/completed:0 0
./nvme0n1/hctx4/cpu129/merged:0
./nvme0n1/hctx4/cpu129/dispatched:0 0
./nvme0n1/hctx4/cpu127/completed:0 0
./nvme0n1/hctx4/cpu127/merged:0
./nvme0n1/hctx4/cpu127/dispatched:0 0
./nvme0n1/hctx4/cpu125/completed:0 0
./nvme0n1/hctx4/cpu125/merged:0
./nvme0n1/hctx4/cpu125/dispatched:0 0
./nvme0n1/hctx4/cpu123/completed:0 0
./nvme0n1/hctx4/cpu123/merged:0
./nvme0n1/hctx4/cpu123/dispatched:0 0
./nvme0n1/hctx4/cpu121/completed:0 0
./nvme0n1/hctx4/cpu121/merged:0
./nvme0n1/hctx4/cpu121/dispatched:0 0
./nvme0n1/hctx4/cpu119/completed:0 0
./nvme0n1/hctx4/cpu119/merged:0
./nvme0n1/hctx4/cpu119/dispatched:0 0
./nvme0n1/hctx4/cpu117/completed:0 0
./nvme0n1/hctx4/cpu117/merged:0
./nvme0n1/hctx4/cpu117/dispatched:0 0
./nvme0n1/hctx4/cpu115/completed:0 0
./nvme0n1/hctx4/cpu115/merged:0
./nvme0n1/hctx4/cpu115/dispatched:0 0
./nvme0n1/hctx4/cpu113/completed:0 0
./nvme0n1/hctx4/cpu113/merged:0
./nvme0n1/hctx4/cpu113/dispatched:0 0
./nvme0n1/hctx4/cpu111/completed:0 0
./nvme0n1/hctx4/cpu111/merged:0
./nvme0n1/hctx4/cpu111/dispatched:0 0
./nvme0n1/hctx4/cpu109/completed:0 0
./nvme0n1/hctx4/cpu109/merged:0
./nvme0n1/hctx4/cpu109/dispatched:0 0
./nvme0n1/hctx4/cpu107/completed:0 0
./nvme0n1/hctx4/cpu107/merged:0
./nvme0n1/hctx4/cpu107/dispatched:0 0
./nvme0n1/hctx4/cpu105/completed:0 0
./nvme0n1/hctx4/cpu105/merged:0
./nvme0n1/hctx4/cpu105/dispatched:0 0
./nvme0n1/hctx4/cpu103/completed:0 0
./nvme0n1/hctx4/cpu103/merged:0
./nvme0n1/hctx4/cpu103/dispatched:0 0
./nvme0n1/hctx4/cpu101/completed:0 0
./nvme0n1/hctx4/cpu101/merged:0
./nvme0n1/hctx4/cpu101/dispatched:0 0
./nvme0n1/hctx4/cpu99/completed:0 0
./nvme0n1/hctx4/cpu99/merged:0
./nvme0n1/hctx4/cpu99/dispatched:0 0
./nvme0n1/hctx4/cpu97/completed:0 0
./nvme0n1/hctx4/cpu97/merged:0
./nvme0n1/hctx4/cpu97/dispatched:0 0
./nvme0n1/hctx4/cpu95/completed:588 562
./nvme0n1/hctx4/cpu95/merged:0
./nvme0n1/hctx4/cpu95/dispatched:588 562
./nvme0n1/hctx4/cpu94/completed:517 584
./nvme0n1/hctx4/cpu94/merged:0
./nvme0n1/hctx4/cpu94/dispatched:517 584
./nvme0n1/hctx4/cpu93/completed:586 492
./nvme0n1/hctx4/cpu93/merged:0
./nvme0n1/hctx4/cpu93/dispatched:586 492
./nvme0n1/hctx4/cpu92/completed:494 481
./nvme0n1/hctx4/cpu92/merged:0
./nvme0n1/hctx4/cpu92/dispatched:494 481
./nvme0n1/hctx4/cpu47/completed:866 682
./nvme0n1/hctx4/cpu47/merged:0
./nvme0n1/hctx4/cpu47/dispatched:866 682
./nvme0n1/hctx4/cpu46/completed:786 642
./nvme0n1/hctx4/cpu46/merged:0
./nvme0n1/hctx4/cpu46/dispatched:786 642
./nvme0n1/hctx4/cpu45/completed:689 532
./nvme0n1/hctx4/cpu45/merged:0
./nvme0n1/hctx4/cpu45/dispatched:689 532
./nvme0n1/hctx4/cpu44/completed:1363 1357
./nvme0n1/hctx4/cpu44/merged:0
./nvme0n1/hctx4/cpu44/dispatched:1363 1357
./nvme0n1/hctx4/active:0
./nvme0n1/hctx4/run:9501
./nvme0n1/hctx4/queued:11213
./nvme0n1/hctx4/dispatched:       0	0
./nvme0n1/hctx4/dispatched:       1	9490
./nvme0n1/hctx4/dispatched:       2	7
./nvme0n1/hctx4/dispatched:       4	0
./nvme0n1/hctx4/dispatched:       8	0
./nvme0n1/hctx4/dispatched:      16	0
./nvme0n1/hctx4/dispatched:      32+	0
./nvme0n1/hctx4/io_poll:considered=3D0
./nvme0n1/hctx4/io_poll:invoked=3D0
./nvme0n1/hctx4/io_poll:success=3D0
./nvme0n1/hctx4/tags_bitmap:00000000: 0000 0000 0000 0000 0000 0000 0000 =
0000
./nvme0n1/hctx4/tags:nr_tags=3D127
./nvme0n1/hctx4/tags:nr_reserved_tags=3D0
./nvme0n1/hctx4/tags:active_queues=3D0
./nvme0n1/hctx4/tags:bitmap_tags:
./nvme0n1/hctx4/tags:depth=3D127
./nvme0n1/hctx4/tags:busy=3D0
./nvme0n1/hctx4/tags:bits_per_word=3D16
./nvme0n1/hctx4/tags:map_nr=3D8
./nvme0n1/hctx4/tags:alloc_hint=3D{55, 75, 115, 36, 62, 41, 54, 61, 40, =
111, 121, 67, 7, 78, 112, 10, 86, 75, 13, 61, 38, 126, 44, 28, 68, 30, =
75, 82, 63, 106, 91, 22, 72, 84, 71, 38, 109, 26, 14, 93, 106, 27, 96, =
102, 9, 57, 123, 14, 71, 40, 60, 77, 2, 73, 64, 93, 13, 17, 70, 78, 67, =
82, 110, 93, 102, 71, 67, 50, 99, 91, 34, 38, 82, 71, 4, 124, 70, 10, =
42, 53, 95, 76, 112, 6, 55, 101, 54, 126, 126, 1, 62, 74, 3, 90, 8, 81, =
34, 49, 20, 94, 88, 59, 9, 111, 67, 61, 88, 30, 98, 69, 70, 16, 39, 43, =
40, 50, 3, 13, 110, 12, 18, 65, 46, 72, 73, 66, 67, 83, 99, 123, 43, 27, =
43, 56, 17, 55, 71, 118, 58, 53, 70, 17, 15, 14, 101, 13, 124, 53, 61, =
15, 20, 23, 117, 15, 107, 10, 80, 18, 122, 81, 9, 28, 18, 116, 94, 82, =
80, 62, 63, 14, 6, 75, 113, 92, 64, 79, 86, 25, 1, 84, 5, 93, 29, 108, =
18, 107, 16, 63, 59, 55, 39, 109, 26, 60, 83, 101, 124, 99, 32, 71, 94, =
65, 114, 100, 78, 66, 45, 16, 106, 19, 25, 1, 4, 108, 9, 34, 81, 62, =
123, 24, 69, 24, 123, 121, 34, 93, 31, 61, 95, 126, 61, 65, 85, 109, =
119, 3, 12, 101, 60, 13, 98, 11, 50, 34, 17, 50, 74, 115, 110, 75, 83, =
67, 35, 120, 103, 96, 28, 51, 98, 80, 13, 78, 20, 116, 10, 33, 36, 46, =
82, 119, 36, 64, 28, 27, 71, 74, 30, 23, 125, 9, 98, 39, 104, 74, 35, =
30, 124, 51, 16, 64, 101, 84, 3, 13, 106, 25, 1, 52, 88, 40, 89, 108, =
52, 76, 110, 70, 110, 67, 52, 111, 99, 87, 68, 10, 69, 93, 77, 46, 39, =
35}
./nvme0n1/hctx4/tags:wake_batch=3D8
./nvme0n1/hctx4/tags:wake_index=3D0
./nvme0n1/hctx4/tags:ws=3D{
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx4/tags:}
./nvme0n1/hctx4/tags:round_robin=3D0
./nvme0n1/hctx4/ctx_map:00000000: 0000 0000 00
./nvme0n1/hctx4/flags:alloc_policy=3DFIFO SHOULD_MERGE
./nvme0n1/hctx3/cpu91/completed:518 588
./nvme0n1/hctx3/cpu91/merged:0
./nvme0n1/hctx3/cpu91/dispatched:518 588
./nvme0n1/hctx3/cpu90/completed:573 586
./nvme0n1/hctx3/cpu90/merged:0
./nvme0n1/hctx3/cpu90/dispatched:573 586
./nvme0n1/hctx3/cpu89/completed:613 500
./nvme0n1/hctx3/cpu89/merged:0
./nvme0n1/hctx3/cpu89/dispatched:613 500
./nvme0n1/hctx3/cpu88/completed:557 545
./nvme0n1/hctx3/cpu88/merged:0
./nvme0n1/hctx3/cpu88/dispatched:557 545
./nvme0n1/hctx3/cpu87/completed:690 538
./nvme0n1/hctx3/cpu87/merged:0
./nvme0n1/hctx3/cpu87/dispatched:690 538
./nvme0n1/hctx3/cpu86/completed:698 602
./nvme0n1/hctx3/cpu86/merged:0
./nvme0n1/hctx3/cpu86/dispatched:698 602
./nvme0n1/hctx3/cpu85/completed:574 575
./nvme0n1/hctx3/cpu85/merged:0
./nvme0n1/hctx3/cpu85/dispatched:574 575
./nvme0n1/hctx3/cpu84/completed:543 597
./nvme0n1/hctx3/cpu84/merged:0
./nvme0n1/hctx3/cpu84/dispatched:543 597
./nvme0n1/hctx3/cpu83/completed:572 588
./nvme0n1/hctx3/cpu83/merged:0
./nvme0n1/hctx3/cpu83/dispatched:572 588
./nvme0n1/hctx3/cpu82/completed:471 548
./nvme0n1/hctx3/cpu82/merged:0
./nvme0n1/hctx3/cpu82/dispatched:471 548
./nvme0n1/hctx3/cpu81/completed:665 589
./nvme0n1/hctx3/cpu81/merged:0
./nvme0n1/hctx3/cpu81/dispatched:665 589
./nvme0n1/hctx3/cpu80/completed:696 542
./nvme0n1/hctx3/cpu80/merged:0
./nvme0n1/hctx3/cpu80/dispatched:696 542
./nvme0n1/hctx3/cpu79/completed:564 576
./nvme0n1/hctx3/cpu79/merged:0
./nvme0n1/hctx3/cpu79/dispatched:564 576
./nvme0n1/hctx3/cpu78/completed:717 548
./nvme0n1/hctx3/cpu78/merged:0
./nvme0n1/hctx3/cpu78/dispatched:717 548
./nvme0n1/hctx3/cpu77/completed:691 606
./nvme0n1/hctx3/cpu77/merged:0
./nvme0n1/hctx3/cpu77/dispatched:691 606
./nvme0n1/hctx3/cpu76/completed:548 603
./nvme0n1/hctx3/cpu76/merged:0
./nvme0n1/hctx3/cpu76/dispatched:548 603
./nvme0n1/hctx3/cpu75/completed:644 608
./nvme0n1/hctx3/cpu75/merged:0
./nvme0n1/hctx3/cpu75/dispatched:644 608
./nvme0n1/hctx3/cpu74/completed:645 626
./nvme0n1/hctx3/cpu74/merged:0
./nvme0n1/hctx3/cpu74/dispatched:645 626
./nvme0n1/hctx3/cpu73/completed:626 619
./nvme0n1/hctx3/cpu73/merged:0
./nvme0n1/hctx3/cpu73/dispatched:626 619
./nvme0n1/hctx3/cpu72/completed:650 517
./nvme0n1/hctx3/cpu72/merged:0
./nvme0n1/hctx3/cpu72/dispatched:650 517
./nvme0n1/hctx3/cpu43/completed:606 656
./nvme0n1/hctx3/cpu43/merged:0
./nvme0n1/hctx3/cpu43/dispatched:606 656
./nvme0n1/hctx3/cpu42/completed:683 594
./nvme0n1/hctx3/cpu42/merged:0
./nvme0n1/hctx3/cpu42/dispatched:683 594
./nvme0n1/hctx3/cpu41/completed:640 643
./nvme0n1/hctx3/cpu41/merged:0
./nvme0n1/hctx3/cpu41/dispatched:640 643
./nvme0n1/hctx3/cpu40/completed:452 614
./nvme0n1/hctx3/cpu40/merged:0
./nvme0n1/hctx3/cpu40/dispatched:452 614
./nvme0n1/hctx3/cpu39/completed:777 644
./nvme0n1/hctx3/cpu39/merged:0
./nvme0n1/hctx3/cpu39/dispatched:777 644
./nvme0n1/hctx3/cpu38/completed:614 623
./nvme0n1/hctx3/cpu38/merged:0
./nvme0n1/hctx3/cpu38/dispatched:614 623
./nvme0n1/hctx3/cpu37/completed:659 597
./nvme0n1/hctx3/cpu37/merged:0
./nvme0n1/hctx3/cpu37/dispatched:659 597
./nvme0n1/hctx3/cpu36/completed:791 784
./nvme0n1/hctx3/cpu36/merged:0
./nvme0n1/hctx3/cpu36/dispatched:791 784
./nvme0n1/hctx3/cpu35/completed:734 625
./nvme0n1/hctx3/cpu35/merged:0
./nvme0n1/hctx3/cpu35/dispatched:734 625
./nvme0n1/hctx3/cpu34/completed:756 586
./nvme0n1/hctx3/cpu34/merged:0
./nvme0n1/hctx3/cpu34/dispatched:756 586
./nvme0n1/hctx3/cpu33/completed:738 666
./nvme0n1/hctx3/cpu33/merged:0
./nvme0n1/hctx3/cpu33/dispatched:738 666
./nvme0n1/hctx3/cpu32/completed:746 636
./nvme0n1/hctx3/cpu32/merged:0
./nvme0n1/hctx3/cpu32/dispatched:746 636
./nvme0n1/hctx3/cpu31/completed:866 738
./nvme0n1/hctx3/cpu31/merged:0
./nvme0n1/hctx3/cpu31/dispatched:866 738
./nvme0n1/hctx3/cpu30/completed:647 589
./nvme0n1/hctx3/cpu30/merged:0
./nvme0n1/hctx3/cpu30/dispatched:647 589
./nvme0n1/hctx3/cpu29/completed:817 713
./nvme0n1/hctx3/cpu29/merged:0
./nvme0n1/hctx3/cpu29/dispatched:817 713
./nvme0n1/hctx3/cpu28/completed:790 751
./nvme0n1/hctx3/cpu28/merged:0
./nvme0n1/hctx3/cpu28/dispatched:790 751
./nvme0n1/hctx3/cpu27/completed:1223 762
./nvme0n1/hctx3/cpu27/merged:0
./nvme0n1/hctx3/cpu27/dispatched:1223 762
./nvme0n1/hctx3/cpu26/completed:850 730
./nvme0n1/hctx3/cpu26/merged:0
./nvme0n1/hctx3/cpu26/dispatched:850 730
./nvme0n1/hctx3/cpu25/completed:1152 838
./nvme0n1/hctx3/cpu25/merged:0
./nvme0n1/hctx3/cpu25/dispatched:1152 838
./nvme0n1/hctx3/cpu24/completed:9925 2583
./nvme0n1/hctx3/cpu24/merged:0
./nvme0n1/hctx3/cpu24/dispatched:9925 2583
./nvme0n1/hctx3/active:0
./nvme0n1/hctx3/run:49477
./nvme0n1/hctx3/queued:63472
./nvme0n1/hctx3/dispatched:       0	0
./nvme0n1/hctx3/dispatched:       1	49341
./nvme0n1/hctx3/dispatched:       2	78
./nvme0n1/hctx3/dispatched:       4	0
./nvme0n1/hctx3/dispatched:       8	0
./nvme0n1/hctx3/dispatched:      16	0
./nvme0n1/hctx3/dispatched:      32+	0
./nvme0n1/hctx3/io_poll:considered=3D0
./nvme0n1/hctx3/io_poll:invoked=3D0
./nvme0n1/hctx3/io_poll:success=3D0
./nvme0n1/hctx3/tags_bitmap:00000000: 0000 0000 0000 0000 0000 0000 0000 =
0000
./nvme0n1/hctx3/tags:nr_tags=3D127
./nvme0n1/hctx3/tags:nr_reserved_tags=3D0
./nvme0n1/hctx3/tags:active_queues=3D0
./nvme0n1/hctx3/tags:bitmap_tags:
./nvme0n1/hctx3/tags:depth=3D127
./nvme0n1/hctx3/tags:busy=3D0
./nvme0n1/hctx3/tags:bits_per_word=3D16
./nvme0n1/hctx3/tags:map_nr=3D8
./nvme0n1/hctx3/tags:alloc_hint=3D{72, 115, 41, 0, 46, 4, 77, 73, 92, =
18, 59, 27, 11, 93, 94, 77, 67, 83, 123, 123, 76, 80, 29, 10, 26, 71, 1, =
2, 0, 26, 109, 39, 80, 42, 94, 32, 73, 9, 3, 15, 96, 125, 68, 6, 81, 83, =
51, 90, 40, 101, 25, 34, 85, 37, 95, 71, 90, 24, 75, 116, 52, 53, 120, =
13, 98, 122, 30, 111, 86, 57, 14, 44, 107, 9, 94, 95, 102, 4, 108, 90, =
64, 93, 38, 33, 58, 107, 81, 56, 30, 67, 37, 122, 50, 37, 19, 108, 81, =
55, 25, 50, 57, 50, 122, 20, 116, 118, 5, 90, 88, 61, 68, 49, 88, 121, =
47, 59, 43, 29, 121, 17, 86, 31, 116, 92, 81, 68, 12, 115, 110, 77, 92, =
76, 94, 94, 81, 35, 77, 47, 9, 4, 47, 123, 76, 45, 80, 26, 19, 76, 110, =
16, 92, 81, 103, 59, 101, 97, 23, 46, 57, 58, 12, 46, 18, 122, 38, 80, =
69, 114, 32, 56, 73, 91, 55, 78, 81, 7, 17, 48, 77, 49, 92, 7, 18, 6, =
79, 24, 123, 22, 56, 34, 54, 13, 117, 88, 3, 63, 85, 13, 19, 99, 54, 16, =
68, 21, 26, 51, 96, 37, 83, 43, 72, 89, 108, 103, 93, 114, 123, 123, 18, =
85, 46, 41, 52, 18, 77, 45, 80, 20, 41, 26, 2, 69, 10, 73, 16, 77, 47, =
47, 55, 63, 13, 5, 7, 48, 122, 14, 28, 13, 24, 29, 99, 119, 75, 38, 30, =
94, 82, 117, 61, 64, 97, 39, 27, 77, 92, 115, 77, 13, 15, 81, 64, 110, =
0, 116, 117, 111, 54, 44, 116, 2, 78, 110, 16, 68, 47, 54, 85, 35, 39, =
32, 57, 103, 54, 81, 35, 84, 57, 60, 20, 105, 59, 35, 107, 125, 18, 57, =
67, 51, 118, 67, 7, 93, 21, 4, 96, 85, 7, 105, 26, 29}
./nvme0n1/hctx3/tags:wake_batch=3D8
./nvme0n1/hctx3/tags:wake_index=3D0
./nvme0n1/hctx3/tags:ws=3D{
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx3/tags:}
./nvme0n1/hctx3/tags:round_robin=3D0
./nvme0n1/hctx3/ctx_map:00000000: 0000 0000 00
./nvme0n1/hctx3/flags:alloc_policy=3DFIFO SHOULD_MERGE
./nvme0n1/hctx2/cpu318/completed:0 0
./nvme0n1/hctx2/cpu318/merged:0
./nvme0n1/hctx2/cpu318/dispatched:0 0
./nvme0n1/hctx2/cpu316/completed:0 0
./nvme0n1/hctx2/cpu316/merged:0
./nvme0n1/hctx2/cpu316/dispatched:0 0
./nvme0n1/hctx2/cpu314/completed:0 0
./nvme0n1/hctx2/cpu314/merged:0
./nvme0n1/hctx2/cpu314/dispatched:0 0
./nvme0n1/hctx2/cpu312/completed:0 0
./nvme0n1/hctx2/cpu312/merged:0
./nvme0n1/hctx2/cpu312/dispatched:0 0
./nvme0n1/hctx2/cpu310/completed:0 0
./nvme0n1/hctx2/cpu310/merged:0
./nvme0n1/hctx2/cpu310/dispatched:0 0
./nvme0n1/hctx2/cpu308/completed:0 0
./nvme0n1/hctx2/cpu308/merged:0
./nvme0n1/hctx2/cpu308/dispatched:0 0
./nvme0n1/hctx2/cpu306/completed:0 0
./nvme0n1/hctx2/cpu306/merged:0
./nvme0n1/hctx2/cpu306/dispatched:0 0
./nvme0n1/hctx2/cpu304/completed:0 0
./nvme0n1/hctx2/cpu304/merged:0
./nvme0n1/hctx2/cpu304/dispatched:0 0
./nvme0n1/hctx2/cpu302/completed:0 0
./nvme0n1/hctx2/cpu302/merged:0
./nvme0n1/hctx2/cpu302/dispatched:0 0
./nvme0n1/hctx2/cpu300/completed:0 0
./nvme0n1/hctx2/cpu300/merged:0
./nvme0n1/hctx2/cpu300/dispatched:0 0
./nvme0n1/hctx2/cpu298/completed:0 0
./nvme0n1/hctx2/cpu298/merged:0
./nvme0n1/hctx2/cpu298/dispatched:0 0
./nvme0n1/hctx2/cpu296/completed:0 0
./nvme0n1/hctx2/cpu296/merged:0
./nvme0n1/hctx2/cpu296/dispatched:0 0
./nvme0n1/hctx2/cpu294/completed:0 0
./nvme0n1/hctx2/cpu294/merged:0
./nvme0n1/hctx2/cpu294/dispatched:0 0
./nvme0n1/hctx2/cpu292/completed:0 0
./nvme0n1/hctx2/cpu292/merged:0
./nvme0n1/hctx2/cpu292/dispatched:0 0
./nvme0n1/hctx2/cpu290/completed:0 0
./nvme0n1/hctx2/cpu290/merged:0
./nvme0n1/hctx2/cpu290/dispatched:0 0
./nvme0n1/hctx2/cpu288/completed:0 0
./nvme0n1/hctx2/cpu288/merged:0
./nvme0n1/hctx2/cpu288/dispatched:0 0
./nvme0n1/hctx2/cpu286/completed:0 0
./nvme0n1/hctx2/cpu286/merged:0
./nvme0n1/hctx2/cpu286/dispatched:0 0
./nvme0n1/hctx2/cpu284/completed:0 0
./nvme0n1/hctx2/cpu284/merged:0
./nvme0n1/hctx2/cpu284/dispatched:0 0
./nvme0n1/hctx2/cpu282/completed:0 0
./nvme0n1/hctx2/cpu282/merged:0
./nvme0n1/hctx2/cpu282/dispatched:0 0
./nvme0n1/hctx2/cpu280/completed:0 0
./nvme0n1/hctx2/cpu280/merged:0
./nvme0n1/hctx2/cpu280/dispatched:0 0
./nvme0n1/hctx2/cpu278/completed:0 0
./nvme0n1/hctx2/cpu278/merged:0
./nvme0n1/hctx2/cpu278/dispatched:0 0
./nvme0n1/hctx2/cpu276/completed:0 0
./nvme0n1/hctx2/cpu276/merged:0
./nvme0n1/hctx2/cpu276/dispatched:0 0
./nvme0n1/hctx2/cpu274/completed:0 0
./nvme0n1/hctx2/cpu274/merged:0
./nvme0n1/hctx2/cpu274/dispatched:0 0
./nvme0n1/hctx2/cpu272/completed:0 0
./nvme0n1/hctx2/cpu272/merged:0
./nvme0n1/hctx2/cpu272/dispatched:0 0
./nvme0n1/hctx2/cpu270/completed:0 0
./nvme0n1/hctx2/cpu270/merged:0
./nvme0n1/hctx2/cpu270/dispatched:0 0
./nvme0n1/hctx2/cpu268/completed:0 0
./nvme0n1/hctx2/cpu268/merged:0
./nvme0n1/hctx2/cpu268/dispatched:0 0
./nvme0n1/hctx2/cpu266/completed:0 0
./nvme0n1/hctx2/cpu266/merged:0
./nvme0n1/hctx2/cpu266/dispatched:0 0
./nvme0n1/hctx2/cpu264/completed:0 0
./nvme0n1/hctx2/cpu264/merged:0
./nvme0n1/hctx2/cpu264/dispatched:0 0
./nvme0n1/hctx2/cpu262/completed:0 0
./nvme0n1/hctx2/cpu262/merged:0
./nvme0n1/hctx2/cpu262/dispatched:0 0
./nvme0n1/hctx2/cpu260/completed:0 0
./nvme0n1/hctx2/cpu260/merged:0
./nvme0n1/hctx2/cpu260/dispatched:0 0
./nvme0n1/hctx2/cpu258/completed:0 0
./nvme0n1/hctx2/cpu258/merged:0
./nvme0n1/hctx2/cpu258/dispatched:0 0
./nvme0n1/hctx2/cpu256/completed:0 0
./nvme0n1/hctx2/cpu256/merged:0
./nvme0n1/hctx2/cpu256/dispatched:0 0
./nvme0n1/hctx2/cpu254/completed:0 0
./nvme0n1/hctx2/cpu254/merged:0
./nvme0n1/hctx2/cpu254/dispatched:0 0
./nvme0n1/hctx2/cpu252/completed:0 0
./nvme0n1/hctx2/cpu252/merged:0
./nvme0n1/hctx2/cpu252/dispatched:0 0
./nvme0n1/hctx2/cpu250/completed:0 0
./nvme0n1/hctx2/cpu250/merged:0
./nvme0n1/hctx2/cpu250/dispatched:0 0
./nvme0n1/hctx2/cpu248/completed:0 0
./nvme0n1/hctx2/cpu248/merged:0
./nvme0n1/hctx2/cpu248/dispatched:0 0
./nvme0n1/hctx2/cpu246/completed:0 0
./nvme0n1/hctx2/cpu246/merged:0
./nvme0n1/hctx2/cpu246/dispatched:0 0
./nvme0n1/hctx2/cpu244/completed:0 0
./nvme0n1/hctx2/cpu244/merged:0
./nvme0n1/hctx2/cpu244/dispatched:0 0
./nvme0n1/hctx2/cpu242/completed:0 0
./nvme0n1/hctx2/cpu242/merged:0
./nvme0n1/hctx2/cpu242/dispatched:0 0
./nvme0n1/hctx2/cpu240/completed:0 0
./nvme0n1/hctx2/cpu240/merged:0
./nvme0n1/hctx2/cpu240/dispatched:0 0
./nvme0n1/hctx2/cpu238/completed:0 0
./nvme0n1/hctx2/cpu238/merged:0
./nvme0n1/hctx2/cpu238/dispatched:0 0
./nvme0n1/hctx2/cpu236/completed:0 0
./nvme0n1/hctx2/cpu236/merged:0
./nvme0n1/hctx2/cpu236/dispatched:0 0
./nvme0n1/hctx2/cpu234/completed:0 0
./nvme0n1/hctx2/cpu234/merged:0
./nvme0n1/hctx2/cpu234/dispatched:0 0
./nvme0n1/hctx2/cpu232/completed:0 0
./nvme0n1/hctx2/cpu232/merged:0
./nvme0n1/hctx2/cpu232/dispatched:0 0
./nvme0n1/hctx2/cpu230/completed:0 0
./nvme0n1/hctx2/cpu230/merged:0
./nvme0n1/hctx2/cpu230/dispatched:0 0
./nvme0n1/hctx2/cpu228/completed:0 0
./nvme0n1/hctx2/cpu228/merged:0
./nvme0n1/hctx2/cpu228/dispatched:0 0
./nvme0n1/hctx2/cpu226/completed:0 0
./nvme0n1/hctx2/cpu226/merged:0
./nvme0n1/hctx2/cpu226/dispatched:0 0
./nvme0n1/hctx2/cpu224/completed:0 0
./nvme0n1/hctx2/cpu224/merged:0
./nvme0n1/hctx2/cpu224/dispatched:0 0
./nvme0n1/hctx2/cpu222/completed:0 0
./nvme0n1/hctx2/cpu222/merged:0
./nvme0n1/hctx2/cpu222/dispatched:0 0
./nvme0n1/hctx2/cpu220/completed:0 0
./nvme0n1/hctx2/cpu220/merged:0
./nvme0n1/hctx2/cpu220/dispatched:0 0
./nvme0n1/hctx2/cpu218/completed:0 0
./nvme0n1/hctx2/cpu218/merged:0
./nvme0n1/hctx2/cpu218/dispatched:0 0
./nvme0n1/hctx2/cpu216/completed:0 0
./nvme0n1/hctx2/cpu216/merged:0
./nvme0n1/hctx2/cpu216/dispatched:0 0
./nvme0n1/hctx2/cpu214/completed:0 0
./nvme0n1/hctx2/cpu214/merged:0
./nvme0n1/hctx2/cpu214/dispatched:0 0
./nvme0n1/hctx2/active:0
./nvme0n1/hctx2/run:0
./nvme0n1/hctx2/queued:0
./nvme0n1/hctx2/dispatched:       0	0
./nvme0n1/hctx2/dispatched:       1	0
./nvme0n1/hctx2/dispatched:       2	0
./nvme0n1/hctx2/dispatched:       4	0
./nvme0n1/hctx2/dispatched:       8	0
./nvme0n1/hctx2/dispatched:      16	0
./nvme0n1/hctx2/dispatched:      32+	0
./nvme0n1/hctx2/io_poll:considered=3D0
./nvme0n1/hctx2/io_poll:invoked=3D0
./nvme0n1/hctx2/io_poll:success=3D0
./nvme0n1/hctx2/tags_bitmap:00000000: 0000 0000 0000 0000 0000 0000 0000 =
0000
./nvme0n1/hctx2/tags:nr_tags=3D127
./nvme0n1/hctx2/tags:nr_reserved_tags=3D0
./nvme0n1/hctx2/tags:active_queues=3D0
./nvme0n1/hctx2/tags:bitmap_tags:
./nvme0n1/hctx2/tags:depth=3D127
./nvme0n1/hctx2/tags:busy=3D0
./nvme0n1/hctx2/tags:bits_per_word=3D16
./nvme0n1/hctx2/tags:map_nr=3D8
./nvme0n1/hctx2/tags:alloc_hint=3D{50, 15, 76, 117, 63, 64, 126, 44, =
117, 23, 92, 103, 23, 17, 42, 9, 120, 7, 24, 82, 59, 60, 76, 21, 122, =
24, 71, 53, 25, 44, 80, 17, 9, 51, 28, 125, 89, 93, 58, 11, 115, 82, 93, =
51, 15, 91, 40, 85, 59, 95, 79, 87, 14, 13, 47, 120, 120, 122, 55, 114, =
80, 37, 12, 70, 30, 31, 125, 63, 64, 55, 28, 76, 65, 17, 122, 16, 10, =
28, 118, 33, 28, 25, 114, 110, 58, 97, 126, 9, 46, 49, 72, 93, 31, 46, =
112, 115, 45, 65, 88, 122, 80, 53, 29, 75, 76, 40, 88, 51, 30, 57, 108, =
120, 113, 59, 55, 63, 106, 46, 119, 109, 75, 75, 12, 67, 70, 58, 1, 13, =
30, 107, 102, 27, 104, 52, 78, 32, 77, 1, 70, 100, 88, 4, 75, 102, 31, =
35, 3, 100, 53, 109, 39, 21, 101, 77, 9, 17, 15, 91, 70, 55, 64, 106, =
94, 60, 3, 60, 5, 57, 120, 2, 118, 7, 2, 55, 70, 38, 14, 21, 102, 120, =
81, 60, 73, 48, 25, 18, 96, 118, 48, 28, 117, 16, 2, 110, 39, 33, 53, =
109, 102, 54, 82, 74, 125, 74, 121, 49, 16, 75, 58, 96, 55, 12, 113, 31, =
86, 114, 100, 51, 54, 24, 85, 118, 11, 58, 34, 100, 48, 80, 32, 56, 69, =
49, 53, 64, 37, 79, 55, 25, 24, 14, 45, 92, 9, 19, 24, 50, 115, 99, 67, =
25, 42, 70, 81, 5, 65, 7, 8, 85, 112, 79, 2, 28, 4, 110, 108, 78, 70, =
115, 96, 36, 22, 82, 38, 0, 34, 99, 25, 39, 22, 83, 38, 125, 80, 5, 96, =
17, 32, 76, 17, 82, 96, 61, 19, 19, 66, 100, 9, 92, 69, 34, 1, 26, 52, =
35, 30, 30, 18, 73, 90, 45, 69, 39, 94, 122, 37, 122, 95, 102, 24, 104}
./nvme0n1/hctx2/tags:wake_batch=3D8
./nvme0n1/hctx2/tags:wake_index=3D0
./nvme0n1/hctx2/tags:ws=3D{
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx2/tags:}
./nvme0n1/hctx2/tags:round_robin=3D0
./nvme0n1/hctx2/ctx_map:00000000: 0000 0000 0000 00
./nvme0n1/hctx2/flags:alloc_policy=3DFIFO SHOULD_MERGE
./nvme0n1/hctx1/cpu212/completed:0 0
./nvme0n1/hctx1/cpu212/merged:0
./nvme0n1/hctx1/cpu212/dispatched:0 0
./nvme0n1/hctx1/cpu210/completed:0 0
./nvme0n1/hctx1/cpu210/merged:0
./nvme0n1/hctx1/cpu210/dispatched:0 0
./nvme0n1/hctx1/cpu208/completed:0 0
./nvme0n1/hctx1/cpu208/merged:0
./nvme0n1/hctx1/cpu208/dispatched:0 0
./nvme0n1/hctx1/cpu206/completed:0 0
./nvme0n1/hctx1/cpu206/merged:0
./nvme0n1/hctx1/cpu206/dispatched:0 0
./nvme0n1/hctx1/cpu204/completed:0 0
./nvme0n1/hctx1/cpu204/merged:0
./nvme0n1/hctx1/cpu204/dispatched:0 0
./nvme0n1/hctx1/cpu202/completed:0 0
./nvme0n1/hctx1/cpu202/merged:0
./nvme0n1/hctx1/cpu202/dispatched:0 0
./nvme0n1/hctx1/cpu200/completed:0 0
./nvme0n1/hctx1/cpu200/merged:0
./nvme0n1/hctx1/cpu200/dispatched:0 0
./nvme0n1/hctx1/cpu198/completed:0 0
./nvme0n1/hctx1/cpu198/merged:0
./nvme0n1/hctx1/cpu198/dispatched:0 0
./nvme0n1/hctx1/cpu196/completed:0 0
./nvme0n1/hctx1/cpu196/merged:0
./nvme0n1/hctx1/cpu196/dispatched:0 0
./nvme0n1/hctx1/cpu194/completed:0 0
./nvme0n1/hctx1/cpu194/merged:0
./nvme0n1/hctx1/cpu194/dispatched:0 0
./nvme0n1/hctx1/cpu192/completed:0 0
./nvme0n1/hctx1/cpu192/merged:0
./nvme0n1/hctx1/cpu192/dispatched:0 0
./nvme0n1/hctx1/cpu190/completed:0 0
./nvme0n1/hctx1/cpu190/merged:0
./nvme0n1/hctx1/cpu190/dispatched:0 0
./nvme0n1/hctx1/cpu188/completed:0 0
./nvme0n1/hctx1/cpu188/merged:0
./nvme0n1/hctx1/cpu188/dispatched:0 0
./nvme0n1/hctx1/cpu186/completed:0 0
./nvme0n1/hctx1/cpu186/merged:0
./nvme0n1/hctx1/cpu186/dispatched:0 0
./nvme0n1/hctx1/cpu184/completed:0 0
./nvme0n1/hctx1/cpu184/merged:0
./nvme0n1/hctx1/cpu184/dispatched:0 0
./nvme0n1/hctx1/cpu182/completed:0 0
./nvme0n1/hctx1/cpu182/merged:0
./nvme0n1/hctx1/cpu182/dispatched:0 0
./nvme0n1/hctx1/cpu180/completed:0 0
./nvme0n1/hctx1/cpu180/merged:0
./nvme0n1/hctx1/cpu180/dispatched:0 0
./nvme0n1/hctx1/cpu178/completed:0 0
./nvme0n1/hctx1/cpu178/merged:0
./nvme0n1/hctx1/cpu178/dispatched:0 0
./nvme0n1/hctx1/cpu176/completed:0 0
./nvme0n1/hctx1/cpu176/merged:0
./nvme0n1/hctx1/cpu176/dispatched:0 0
./nvme0n1/hctx1/cpu174/completed:0 0
./nvme0n1/hctx1/cpu174/merged:0
./nvme0n1/hctx1/cpu174/dispatched:0 0
./nvme0n1/hctx1/cpu172/completed:0 0
./nvme0n1/hctx1/cpu172/merged:0
./nvme0n1/hctx1/cpu172/dispatched:0 0
./nvme0n1/hctx1/cpu170/completed:0 0
./nvme0n1/hctx1/cpu170/merged:0
./nvme0n1/hctx1/cpu170/dispatched:0 0
./nvme0n1/hctx1/cpu168/completed:0 0
./nvme0n1/hctx1/cpu168/merged:0
./nvme0n1/hctx1/cpu168/dispatched:0 0
./nvme0n1/hctx1/cpu166/completed:0 0
./nvme0n1/hctx1/cpu166/merged:0
./nvme0n1/hctx1/cpu166/dispatched:0 0
./nvme0n1/hctx1/cpu164/completed:0 0
./nvme0n1/hctx1/cpu164/merged:0
./nvme0n1/hctx1/cpu164/dispatched:0 0
./nvme0n1/hctx1/cpu162/completed:0 0
./nvme0n1/hctx1/cpu162/merged:0
./nvme0n1/hctx1/cpu162/dispatched:0 0
./nvme0n1/hctx1/cpu160/completed:0 0
./nvme0n1/hctx1/cpu160/merged:0
./nvme0n1/hctx1/cpu160/dispatched:0 0
./nvme0n1/hctx1/cpu158/completed:0 0
./nvme0n1/hctx1/cpu158/merged:0
./nvme0n1/hctx1/cpu158/dispatched:0 0
./nvme0n1/hctx1/cpu156/completed:0 0
./nvme0n1/hctx1/cpu156/merged:0
./nvme0n1/hctx1/cpu156/dispatched:0 0
./nvme0n1/hctx1/cpu154/completed:0 0
./nvme0n1/hctx1/cpu154/merged:0
./nvme0n1/hctx1/cpu154/dispatched:0 0
./nvme0n1/hctx1/cpu152/completed:0 0
./nvme0n1/hctx1/cpu152/merged:0
./nvme0n1/hctx1/cpu152/dispatched:0 0
./nvme0n1/hctx1/cpu150/completed:0 0
./nvme0n1/hctx1/cpu150/merged:0
./nvme0n1/hctx1/cpu150/dispatched:0 0
./nvme0n1/hctx1/cpu148/completed:0 0
./nvme0n1/hctx1/cpu148/merged:0
./nvme0n1/hctx1/cpu148/dispatched:0 0
./nvme0n1/hctx1/cpu146/completed:0 0
./nvme0n1/hctx1/cpu146/merged:0
./nvme0n1/hctx1/cpu146/dispatched:0 0
./nvme0n1/hctx1/cpu144/completed:0 0
./nvme0n1/hctx1/cpu144/merged:0
./nvme0n1/hctx1/cpu144/dispatched:0 0
./nvme0n1/hctx1/cpu142/completed:0 0
./nvme0n1/hctx1/cpu142/merged:0
./nvme0n1/hctx1/cpu142/dispatched:0 0
./nvme0n1/hctx1/cpu140/completed:0 0
./nvme0n1/hctx1/cpu140/merged:0
./nvme0n1/hctx1/cpu140/dispatched:0 0
./nvme0n1/hctx1/cpu138/completed:0 0
./nvme0n1/hctx1/cpu138/merged:0
./nvme0n1/hctx1/cpu138/dispatched:0 0
./nvme0n1/hctx1/cpu136/completed:0 0
./nvme0n1/hctx1/cpu136/merged:0
./nvme0n1/hctx1/cpu136/dispatched:0 0
./nvme0n1/hctx1/cpu134/completed:0 0
./nvme0n1/hctx1/cpu134/merged:0
./nvme0n1/hctx1/cpu134/dispatched:0 0
./nvme0n1/hctx1/cpu132/completed:0 0
./nvme0n1/hctx1/cpu132/merged:0
./nvme0n1/hctx1/cpu132/dispatched:0 0
./nvme0n1/hctx1/cpu130/completed:0 0
./nvme0n1/hctx1/cpu130/merged:0
./nvme0n1/hctx1/cpu130/dispatched:0 0
./nvme0n1/hctx1/cpu128/completed:0 0
./nvme0n1/hctx1/cpu128/merged:0
./nvme0n1/hctx1/cpu128/dispatched:0 0
./nvme0n1/hctx1/cpu126/completed:0 0
./nvme0n1/hctx1/cpu126/merged:0
./nvme0n1/hctx1/cpu126/dispatched:0 0
./nvme0n1/hctx1/cpu124/completed:0 0
./nvme0n1/hctx1/cpu124/merged:0
./nvme0n1/hctx1/cpu124/dispatched:0 0
./nvme0n1/hctx1/cpu122/completed:0 0
./nvme0n1/hctx1/cpu122/merged:0
./nvme0n1/hctx1/cpu122/dispatched:0 0
./nvme0n1/hctx1/cpu120/completed:0 0
./nvme0n1/hctx1/cpu120/merged:0
./nvme0n1/hctx1/cpu120/dispatched:0 0
./nvme0n1/hctx1/cpu118/completed:0 0
./nvme0n1/hctx1/cpu118/merged:0
./nvme0n1/hctx1/cpu118/dispatched:0 0
./nvme0n1/hctx1/cpu116/completed:0 0
./nvme0n1/hctx1/cpu116/merged:0
./nvme0n1/hctx1/cpu116/dispatched:0 0
./nvme0n1/hctx1/cpu114/completed:0 0
./nvme0n1/hctx1/cpu114/merged:0
./nvme0n1/hctx1/cpu114/dispatched:0 0
./nvme0n1/hctx1/cpu112/completed:0 0
./nvme0n1/hctx1/cpu112/merged:0
./nvme0n1/hctx1/cpu112/dispatched:0 0
./nvme0n1/hctx1/cpu110/completed:0 0
./nvme0n1/hctx1/cpu110/merged:0
./nvme0n1/hctx1/cpu110/dispatched:0 0
./nvme0n1/hctx1/cpu108/completed:0 0
./nvme0n1/hctx1/cpu108/merged:0
./nvme0n1/hctx1/cpu108/dispatched:0 0
./nvme0n1/hctx1/active:0
./nvme0n1/hctx1/run:0
./nvme0n1/hctx1/queued:0
./nvme0n1/hctx1/dispatched:       0	0
./nvme0n1/hctx1/dispatched:       1	0
./nvme0n1/hctx1/dispatched:       2	0
./nvme0n1/hctx1/dispatched:       4	0
./nvme0n1/hctx1/dispatched:       8	0
./nvme0n1/hctx1/dispatched:      16	0
./nvme0n1/hctx1/dispatched:      32+	0
./nvme0n1/hctx1/io_poll:considered=3D0
./nvme0n1/hctx1/io_poll:invoked=3D0
./nvme0n1/hctx1/io_poll:success=3D0
./nvme0n1/hctx1/tags_bitmap:00000000: 0000 0000 0000 0000 0000 0000 0000 =
0000
./nvme0n1/hctx1/tags:nr_tags=3D127
./nvme0n1/hctx1/tags:nr_reserved_tags=3D0
./nvme0n1/hctx1/tags:active_queues=3D0
./nvme0n1/hctx1/tags:bitmap_tags:
./nvme0n1/hctx1/tags:depth=3D127
./nvme0n1/hctx1/tags:busy=3D0
./nvme0n1/hctx1/tags:bits_per_word=3D16
./nvme0n1/hctx1/tags:map_nr=3D8
./nvme0n1/hctx1/tags:alloc_hint=3D{110, 16, 22, 31, 13, 36, 28, 5, 54, =
50, 45, 69, 43, 35, 68, 126, 18, 125, 41, 19, 51, 105, 57, 11, 69, 103, =
97, 2, 126, 57, 95, 48, 59, 72, 54, 88, 33, 105, 67, 58, 41, 14, 85, 55, =
55, 41, 113, 37, 56, 45, 120, 44, 69, 89, 37, 42, 126, 16, 75, 5, 74, =
97, 110, 2, 39, 123, 104, 41, 48, 48, 34, 61, 61, 113, 90, 121, 54, 100, =
55, 109, 80, 15, 94, 21, 61, 34, 106, 87, 77, 11, 104, 64, 38, 8, 108, =
112, 8, 101, 113, 43, 4, 50, 75, 106, 73, 20, 98, 112, 112, 27, 64, 49, =
20, 115, 84, 72, 40, 122, 111, 117, 46, 86, 41, 2, 22, 86, 25, 99, 88, =
0, 28, 85, 48, 6, 126, 116, 7, 7, 89, 49, 38, 65, 94, 22, 113, 10, 49, =
12, 0, 2, 30, 38, 34, 36, 101, 21, 83, 7, 28, 57, 90, 99, 80, 54, 48, =
18, 64, 110, 15, 8, 107, 77, 95, 95, 59, 97, 67, 71, 110, 42, 57, 30, =
80, 83, 2, 59, 57, 112, 22, 58, 110, 32, 6, 89, 28, 68, 10, 82, 87, 52, =
120, 44, 21, 2, 71, 7, 35, 124, 112, 96, 10, 42, 89, 43, 81, 83, 46, 94, =
20, 117, 124, 86, 61, 125, 74, 78, 8, 67, 82, 34, 62, 6, 97, 22, 98, 98, =
101, 87, 19, 0, 112, 119, 2, 88, 31, 73, 92, 57, 105, 98, 22, 120, 109, =
51, 22, 1, 37, 99, 109, 122, 44, 96, 27, 76, 101, 44, 31, 92, 86, 123, =
66, 86, 61, 119, 42, 46, 85, 103, 122, 34, 54, 16, 15, 94, 106, 49, 24, =
20, 101, 53, 107, 63, 7, 100, 96, 53, 79, 39, 65, 87, 90, 57, 93, 2, 58, =
104, 44, 36, 78, 29, 119, 85, 99, 13, 16, 68, 86, 42, 100, 98}
./nvme0n1/hctx1/tags:wake_batch=3D8
./nvme0n1/hctx1/tags:wake_index=3D0
./nvme0n1/hctx1/tags:ws=3D{
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx1/tags:}
./nvme0n1/hctx1/tags:round_robin=3D0
./nvme0n1/hctx1/ctx_map:00000000: 0000 0000 0000 00
./nvme0n1/hctx1/flags:alloc_policy=3DFIFO SHOULD_MERGE
./nvme0n1/hctx0/cpu106/completed:0 0
./nvme0n1/hctx0/cpu106/merged:0
./nvme0n1/hctx0/cpu106/dispatched:0 0
./nvme0n1/hctx0/cpu104/completed:0 0
./nvme0n1/hctx0/cpu104/merged:0
./nvme0n1/hctx0/cpu104/dispatched:0 0
./nvme0n1/hctx0/cpu102/completed:0 0
./nvme0n1/hctx0/cpu102/merged:0
./nvme0n1/hctx0/cpu102/dispatched:0 0
./nvme0n1/hctx0/cpu100/completed:0 0
./nvme0n1/hctx0/cpu100/merged:0
./nvme0n1/hctx0/cpu100/dispatched:0 0
./nvme0n1/hctx0/cpu98/completed:0 0
./nvme0n1/hctx0/cpu98/merged:0
./nvme0n1/hctx0/cpu98/dispatched:0 0
./nvme0n1/hctx0/cpu96/completed:0 0
./nvme0n1/hctx0/cpu96/merged:0
./nvme0n1/hctx0/cpu96/dispatched:0 0
./nvme0n1/hctx0/cpu71/completed:413 398
./nvme0n1/hctx0/cpu71/merged:0
./nvme0n1/hctx0/cpu71/dispatched:413 398
./nvme0n1/hctx0/cpu70/completed:478 465
./nvme0n1/hctx0/cpu70/merged:0
./nvme0n1/hctx0/cpu70/dispatched:478 465
./nvme0n1/hctx0/cpu69/completed:411 451
./nvme0n1/hctx0/cpu69/merged:0
./nvme0n1/hctx0/cpu69/dispatched:411 451
./nvme0n1/hctx0/cpu68/completed:412 449
./nvme0n1/hctx0/cpu68/merged:0
./nvme0n1/hctx0/cpu68/dispatched:412 449
./nvme0n1/hctx0/cpu67/completed:340 431
./nvme0n1/hctx0/cpu67/merged:0
./nvme0n1/hctx0/cpu67/dispatched:340 431
./nvme0n1/hctx0/cpu66/completed:515 464
./nvme0n1/hctx0/cpu66/merged:0
./nvme0n1/hctx0/cpu66/dispatched:515 464
./nvme0n1/hctx0/cpu65/completed:395 453
./nvme0n1/hctx0/cpu65/merged:0
./nvme0n1/hctx0/cpu65/dispatched:395 453
./nvme0n1/hctx0/cpu64/completed:467 457
./nvme0n1/hctx0/cpu64/merged:0
./nvme0n1/hctx0/cpu64/dispatched:467 457
./nvme0n1/hctx0/cpu63/completed:429 456
./nvme0n1/hctx0/cpu63/merged:0
./nvme0n1/hctx0/cpu63/dispatched:429 456
./nvme0n1/hctx0/cpu62/completed:419 480
./nvme0n1/hctx0/cpu62/merged:0
./nvme0n1/hctx0/cpu62/dispatched:419 480
./nvme0n1/hctx0/cpu61/completed:394 492
./nvme0n1/hctx0/cpu61/merged:0
./nvme0n1/hctx0/cpu61/dispatched:394 492
./nvme0n1/hctx0/cpu60/completed:344 431
./nvme0n1/hctx0/cpu60/merged:0
./nvme0n1/hctx0/cpu60/dispatched:344 431
./nvme0n1/hctx0/cpu59/completed:373 433
./nvme0n1/hctx0/cpu59/merged:0
./nvme0n1/hctx0/cpu59/dispatched:373 433
./nvme0n1/hctx0/cpu58/completed:390 395
./nvme0n1/hctx0/cpu58/merged:0
./nvme0n1/hctx0/cpu58/dispatched:390 395
./nvme0n1/hctx0/cpu57/completed:439 414
./nvme0n1/hctx0/cpu57/merged:0
./nvme0n1/hctx0/cpu57/dispatched:439 414
./nvme0n1/hctx0/cpu56/completed:524 526
./nvme0n1/hctx0/cpu56/merged:0
./nvme0n1/hctx0/cpu56/dispatched:524 526
./nvme0n1/hctx0/cpu55/completed:438 434
./nvme0n1/hctx0/cpu55/merged:0
./nvme0n1/hctx0/cpu55/dispatched:438 434
./nvme0n1/hctx0/cpu54/completed:517 447
./nvme0n1/hctx0/cpu54/merged:0
./nvme0n1/hctx0/cpu54/dispatched:517 447
./nvme0n1/hctx0/cpu53/completed:362 508
./nvme0n1/hctx0/cpu53/merged:0
./nvme0n1/hctx0/cpu53/dispatched:362 508
./nvme0n1/hctx0/cpu52/completed:477 457
./nvme0n1/hctx0/cpu52/merged:0
./nvme0n1/hctx0/cpu52/dispatched:477 457
./nvme0n1/hctx0/cpu51/completed:439 514
./nvme0n1/hctx0/cpu51/merged:0
./nvme0n1/hctx0/cpu51/dispatched:439 514
./nvme0n1/hctx0/cpu50/completed:514 454
./nvme0n1/hctx0/cpu50/merged:0
./nvme0n1/hctx0/cpu50/dispatched:514 454
./nvme0n1/hctx0/cpu49/completed:452 456
./nvme0n1/hctx0/cpu49/merged:0
./nvme0n1/hctx0/cpu49/dispatched:452 456
./nvme0n1/hctx0/cpu48/completed:337 430
./nvme0n1/hctx0/cpu48/merged:0
./nvme0n1/hctx0/cpu48/dispatched:337 430
./nvme0n1/hctx0/cpu23/completed:536 464
./nvme0n1/hctx0/cpu23/merged:0
./nvme0n1/hctx0/cpu23/dispatched:536 464
./nvme0n1/hctx0/cpu22/completed:416 489
./nvme0n1/hctx0/cpu22/merged:0
./nvme0n1/hctx0/cpu22/dispatched:416 489
./nvme0n1/hctx0/cpu21/completed:538 527
./nvme0n1/hctx0/cpu21/merged:0
./nvme0n1/hctx0/cpu21/dispatched:538 527
./nvme0n1/hctx0/cpu20/completed:410 474
./nvme0n1/hctx0/cpu20/merged:0
./nvme0n1/hctx0/cpu20/dispatched:410 474
./nvme0n1/hctx0/cpu19/completed:468 471
./nvme0n1/hctx0/cpu19/merged:0
./nvme0n1/hctx0/cpu19/dispatched:468 471
./nvme0n1/hctx0/cpu18/completed:474 451
./nvme0n1/hctx0/cpu18/merged:0
./nvme0n1/hctx0/cpu18/dispatched:474 451
./nvme0n1/hctx0/cpu17/completed:449 470
./nvme0n1/hctx0/cpu17/merged:0
./nvme0n1/hctx0/cpu17/dispatched:449 470
./nvme0n1/hctx0/cpu16/completed:670 779
./nvme0n1/hctx0/cpu16/merged:0
./nvme0n1/hctx0/cpu16/dispatched:670 779
./nvme0n1/hctx0/cpu15/completed:448 481
./nvme0n1/hctx0/cpu15/merged:0
./nvme0n1/hctx0/cpu15/dispatched:448 481
./nvme0n1/hctx0/cpu14/completed:517 635
./nvme0n1/hctx0/cpu14/merged:0
./nvme0n1/hctx0/cpu14/dispatched:517 635
./nvme0n1/hctx0/cpu13/completed:599 504
./nvme0n1/hctx0/cpu13/merged:0
./nvme0n1/hctx0/cpu13/dispatched:599 504
./nvme0n1/hctx0/cpu12/completed:668 483
./nvme0n1/hctx0/cpu12/merged:0
./nvme0n1/hctx0/cpu12/dispatched:668 483
./nvme0n1/hctx0/cpu11/completed:474 633
./nvme0n1/hctx0/cpu11/merged:0
./nvme0n1/hctx0/cpu11/dispatched:474 633
./nvme0n1/hctx0/cpu10/completed:475 514
./nvme0n1/hctx0/cpu10/merged:0
./nvme0n1/hctx0/cpu10/dispatched:475 514
./nvme0n1/hctx0/cpu9/completed:644 489
./nvme0n1/hctx0/cpu9/merged:0
./nvme0n1/hctx0/cpu9/dispatched:644 489
./nvme0n1/hctx0/cpu8/completed:690 636
./nvme0n1/hctx0/cpu8/merged:0
./nvme0n1/hctx0/cpu8/dispatched:690 636
./nvme0n1/hctx0/cpu7/completed:607 510
./nvme0n1/hctx0/cpu7/merged:0
./nvme0n1/hctx0/cpu7/dispatched:607 510
./nvme0n1/hctx0/cpu6/completed:618 550
./nvme0n1/hctx0/cpu6/merged:0
./nvme0n1/hctx0/cpu6/dispatched:618 550
./nvme0n1/hctx0/cpu5/completed:681 563
./nvme0n1/hctx0/cpu5/merged:0
./nvme0n1/hctx0/cpu5/dispatched:681 563
./nvme0n1/hctx0/cpu4/completed:843 500
./nvme0n1/hctx0/cpu4/merged:0
./nvme0n1/hctx0/cpu4/dispatched:843 500
./nvme0n1/hctx0/cpu3/completed:837 605
./nvme0n1/hctx0/cpu3/merged:0
./nvme0n1/hctx0/cpu3/dispatched:837 605
./nvme0n1/hctx0/cpu2/completed:890 655
./nvme0n1/hctx0/cpu2/merged:0
./nvme0n1/hctx0/cpu2/dispatched:890 655
./nvme0n1/hctx0/cpu1/completed:1424 706
./nvme0n1/hctx0/cpu1/merged:0
./nvme0n1/hctx0/cpu1/dispatched:1424 706
./nvme0n1/hctx0/cpu0/completed:9621 5169
./nvme0n1/hctx0/cpu0/merged:0
./nvme0n1/hctx0/cpu0/dispatched:9621 5169
./nvme0n1/hctx0/active:0
./nvme0n1/hctx0/run:48382
./nvme0n1/hctx0/queued:62812
./nvme0n1/hctx0/dispatched:       0	0
./nvme0n1/hctx0/dispatched:       1	48214
./nvme0n1/hctx0/dispatched:       2	98
./nvme0n1/hctx0/dispatched:       4	0
./nvme0n1/hctx0/dispatched:       8	0
./nvme0n1/hctx0/dispatched:      16	0
./nvme0n1/hctx0/dispatched:      32+	0
./nvme0n1/hctx0/io_poll:considered=3D0
./nvme0n1/hctx0/io_poll:invoked=3D0
./nvme0n1/hctx0/io_poll:success=3D0
./nvme0n1/hctx0/tags_bitmap:00000000: 0000 0000 0000 0000 0000 0000 0000 =
1000
./nvme0n1/hctx0/tags:nr_tags=3D127
./nvme0n1/hctx0/tags:nr_reserved_tags=3D0
./nvme0n1/hctx0/tags:active_queues=3D0
./nvme0n1/hctx0/tags:bitmap_tags:
./nvme0n1/hctx0/tags:depth=3D127
./nvme0n1/hctx0/tags:busy=3D1
./nvme0n1/hctx0/tags:bits_per_word=3D16
./nvme0n1/hctx0/tags:map_nr=3D8
./nvme0n1/hctx0/tags:alloc_hint=3D{46, 8, 42, 80, 106, 1, 10, 90, 2, 68, =
81, 39, 9, 108, 2, 63, 115, 33, 88, 64, 63, 84, 123, 10, 19, 104, 24, =
113, 108, 51, 9, 81, 67, 110, 23, 80, 55, 66, 60, 90, 23, 58, 123, 98, =
99, 74, 44, 59, 1, 36, 124, 14, 113, 85, 46, 126, 112, 46, 23, 66, 37, =
4, 107, 66, 5, 119, 99, 31, 79, 48, 11, 118, 64, 65, 95, 34, 11, 77, 60, =
28, 123, 106, 44, 77, 118, 37, 34, 106, 97, 102, 92, 103, 60, 34, 26, =
96, 52, 100, 110, 54, 120, 37, 47, 7, 104, 99, 64, 11, 36, 67, 75, 85, =
107, 95, 42, 73, 2, 46, 61, 65, 22, 5, 1, 106, 40, 36, 70, 85, 93, 59, =
23, 25, 117, 109, 74, 97, 48, 100, 58, 59, 71, 125, 124, 89, 102, 123, =
69, 95, 2, 65, 37, 112, 73, 33, 92, 89, 67, 36, 47, 105, 13, 52, 81, 84, =
6, 70, 30, 119, 85, 86, 40, 110, 104, 55, 4, 9, 95, 112, 19, 120, 60, 3, =
57, 112, 126, 21, 122, 86, 7, 32, 91, 126, 27, 124, 110, 20, 110, 19, =
109, 114, 94, 61, 2, 106, 88, 46, 76, 56, 104, 78, 32, 111, 39, 15, 33, =
73, 93, 56, 91, 100, 64, 82, 115, 8, 79, 17, 8, 118, 112, 76, 91, 24, =
22, 62, 41, 18, 71, 54, 99, 59, 19, 110, 118, 30, 19, 51, 33, 105, 38, =
44, 51, 61, 115, 62, 42, 59, 4, 46, 8, 106, 63, 103, 80, 43, 11, 103, =
29, 104, 68, 5, 22, 10, 62, 5, 30, 119, 12, 80, 61, 68, 124, 83, 118, =
41, 5, 28, 52, 45, 41, 80, 92, 108, 91, 68, 41, 80, 75, 65, 112, 29, 9, =
121, 53, 44, 125, 119, 123, 22, 107, 111, 112, 41, 57, 43, 113, 70, 0, =
3, 2, 36}
./nvme0n1/hctx0/tags:wake_batch=3D8
./nvme0n1/hctx0/tags:wake_index=3D0
./nvme0n1/hctx0/tags:ws=3D{
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:	{.wait_cnt=3D8, .wait=3Dinactive},
./nvme0n1/hctx0/tags:}
./nvme0n1/hctx0/tags:round_robin=3D0
./nvme0n1/hctx0/ctx_map:00000000: 0000 0000 0000 00
./nvme0n1/hctx0/busy:00000000f3b15ad9 {.op=3DWRITE, .cmd_flags=3D, =
.rq_flags=3DDONTPREP|IO_STAT|STATS, complete=3D0, .tag=3D116, =
.internal_tag=3D-1}
./nvme0n1/hctx0/flags:alloc_policy=3DFIFO SHOULD_MERGE
./nvme0n1/write_hints:hint0: 0
./nvme0n1/write_hints:hint1: 0
./nvme0n1/write_hints:hint2: 0
./nvme0n1/write_hints:hint3: 0
./nvme0n1/write_hints:hint4: 0
=
./nvme0n1/state:SAME_COMP|NONROT|IO_STAT|DISCARD|INIT_DONE|NO_SG_MERGE|POL=
L|WC|FUA|STATS|REGISTERED
./nvme0n1/poll_stat:read  (512 Bytes): samples=3D0
./nvme0n1/poll_stat:write (512 Bytes): samples=3D0
./nvme0n1/poll_stat:read  (1024 Bytes): samples=3D0
./nvme0n1/poll_stat:write (1024 Bytes): samples=3D0
./nvme0n1/poll_stat:read  (2048 Bytes): samples=3D0
./nvme0n1/poll_stat:write (2048 Bytes): samples=3D0
./nvme0n1/poll_stat:read  (4096 Bytes): samples=3D0
./nvme0n1/poll_stat:write (4096 Bytes): samples=3D0
./nvme0n1/poll_stat:read  (8192 Bytes): samples=3D0
./nvme0n1/poll_stat:write (8192 Bytes): samples=3D0
./nvme0n1/poll_stat:read  (16384 Bytes): samples=3D0
./nvme0n1/poll_stat:write (16384 Bytes): samples=3D0
./nvme0n1/poll_stat:read  (32768 Bytes): samples=3D0
./nvme0n1/poll_stat:write (32768 Bytes): samples=3D0
./nvme0n1/poll_stat:read  (65536 Bytes): samples=3D0
./nvme0n1/poll_stat:write (65536 Bytes): samples=3D0
[root@dell block]#=20


> On Jan 21, 2018, at 12:39, David Zarzycki <dave@znu.io> wrote:
>=20
> Hi Bart,
>=20
> I can do [1] and [2] but I won=E2=80=99t be able to provide the =
command output because the hang is almost total. No new commands can run =
because the scheduler is hung. For example, see this backtrace:
>=20
> http://znu.io/IMG_0362.jpg
>=20
> Is there another approach I can use?
>=20
> Dave
>=20
>> On Jan 21, 2018, at 12:17, Bart Van Assche <Bart.VanAssche@wdc.com> =
wrote:
>>=20
>> On Sun, 2018-01-21 at 11:19 -0500, David Zarzycki wrote:
>>> How can I help debug this further?
>>=20
>> Please apply patch [1] on top of Jens' for-next branch [2], reproduce =
the
>> hang and provide the output of the following command:
>>=20
>> (cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)
>>=20
>> Thanks,
>>=20
>> Bart.
>>=20
>> [1] [PATCH] blk-mq-debugfs: Also show requests that have not yet been =
started
>> =
https://www.mail-archive.com/linux-block@vger.kernel.org/msg17313.html
>> [2] http://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-next
>=20
