Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46855 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeCFAsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Mar 2018 19:48:32 -0500
Subject: Re: EXT4 Oops (Re: [PATCH V15 06/22] mmc: block: Add blk-mq support)
To: Theodore Ts'o <tytso@mit.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-ext4@vger.kernel.org
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
 <1511962879-24262-7-git-send-email-adrian.hunter@intel.com>
 <bc65b542-9703-aa04-f1c7-b10584e44391@gmail.com>
 <829308a3-3bf6-c173-65fa-e2a0f45f7f61@intel.com>
 <68886f99-97f5-897a-f754-6f414741bd5a@gmail.com>
 <22580b82-0257-b156-9f0c-79afa34067e5@gmail.com>
 <8876217f-ede6-fc81-2e05-b4fc976b3235@intel.com>
 <6a1267b0-6242-fc9f-60ed-02bf34677b62@intel.com>
 <20180301160418.GA2490@thunk.org>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9490a366-1847-d849-05cc-85ee01310365@gmail.com>
Date: Tue, 6 Mar 2018 03:48:13 +0300
MIME-Version: 1.0
In-Reply-To: <20180301160418.GA2490@thunk.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01.03.2018 19:04, Theodore Ts'o wrote:
> On Thu, Mar 01, 2018 at 10:55:37AM +0200, Adrian Hunter wrote:
>> On 27/02/18 11:28, Adrian Hunter wrote:
>>> On 26/02/18 23:48, Dmitry Osipenko wrote:
>>>> But still something is wrong... I've been getting occasional EXT4 Ooops's, like
>>>> the one below, and __wait_on_bit() is always figuring in the stacktrace. It
>>>> never happened with blk-mq disabled, though it could be a coincidence and
>>>> actually unrelated to blk-mq patches.
>>>
>>>> [ 6625.992337] Unable to handle kernel NULL pointer dereference at virtual
>>>> address 0000001c
>>>> [ 6625.993004] pgd = 00b30c03
>>>> [ 6625.993257] [0000001c] *pgd=00000000
>>>> [ 6625.993594] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>>> [ 6625.994022] Modules linked in:
>>>> [ 6625.994326] CPU: 1 PID: 19355 Comm: dpkg Not tainted
>>>> 4.16.0-rc2-next-20180220-00095-ge9c9f5689a84-dirty #2090
>>>> [ 6625.995078] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>>> [ 6625.995595] PC is aht dx_probe+0x68/0x684
>>>> [ 6625.995947] LR is at __wait_on_bit+0xac/0xc8
> 
> This doesn't seem to make sense; the PC is where we are currently
> executing, and LR is the "Link Register" where the flow of control
> will be returning after the current function returns, right?  Well,
> dx_probe should *not* be returning to __wait_on_bit().  So this just
> seems.... weird.
> 
> Ignoring the LR register, this stack trace looks sane...  I can't see
> which pointer could be NULL and getting dereferenced, though.  How
> easily can you reproduce the problem?  Can you either (a) translate
> the PC into a line number, or better yet, if you can reproduce, add a
> series of BUG_ON's so we can see what's going on?
> 
> +	BUG_ON(frame);
> 	memset(frame_in, 0, EXT4_HTREE_LEVEL * sizeof(frame_in[0]));
> 	frame->bh = ext4_read_dirblock(dir, 0, INDEX);
> 	if (IS_ERR(frame->bh))
> 		return (struct dx_frame *) frame->bh;
> 
> +	BUG_ON(frame->bh);
> +	BUG_ON(frame->bh->b_data);
> 	root = (struct dx_root *) frame->bh->b_data;
> 	if (root->info.hash_version != DX_HASH_TEA &&
> 	    root->info.hash_version != DX_HASH_HALF_MD4 &&
> 	    root->info.hash_version != DX_HASH_LEGACY) {
> 
> These are "could never" happen scenarios from looking at the code, but
> that will help explain what is going on.
> 
> If this is reliably only happening with mq, the only way I could see
> that if is something is returning an error when it previously wasn't.
> This isn't a problem we're seeing with any of our testing, though.

It happened today again, "BUG_ON(!frame->bh->b_data);" has been trapped.

kernel BUG at fs/ext4/namei.c:751!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 296 Comm: cron Not tainted
4.16.0-rc2-next-20180220-00095-ge9c9f5689a84-dirty #2100
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
PC is at dx_probe+0x308/0x694
LR is at __wait_on_bit+0xac/0xc8
pc : [<c033bc00>]    lr : [<c0bfbff4>]    psr: 60040013
sp : d545bc20  ip : c0170e88  fp : d545bc74
r10: 00000000  r9 : d545bca0  r8 : d4209300
r7 : 00000000  r6 : 00000000  r5 : d656e838  r4 : d545bcbc
r3 : 0000007b  r2 : d5830800  r1 : d5831000  r0 : d4209300
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 1552004a  DAC: 00000051
Process cron (pid: 296, stack limit = 0x4d1ebf14)
Stack: (0xd545bc20 to 0xd545c000)
bc20: 000002ea c0c019d4 60040113 014000c0 c029e640 d6cf3540 d545bc7c d545bc48
bc40: c02797f4 c0152804 d545bca4 00000007 d5830800 00000000 d656e838 00000001
bc60: d545bca0 00000000 d545bd0c d545bc78 c033d578 c033b904 c029e714 c029b088
bc80: 00000148 c0c01984 d65f6be0 00000000 d545be10 d545bd24 d545bd00 d5830800
bca0: d65f6bf8 d65f6c0c 00000007 d6547720 8420edbe c029eec8 00000000 d4209300
bcc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bce0: d545bd48 d65f6be0 d656e838 d65f6be0 d6547720 00000001 d545be10 00000000
bd00: d545bd44 d545bd10 c033d7c0 c033d1c8 d545bd34 d656e8b8 d656e838 d545be08
bd20: d656e838 00000000 d65f6be0 d656e838 d656e8b8 d6547720 d545bd8c d545bd48
bd40: c028ea50 c033d774 00000000 dead4ead ffffffff ffffffff d545bd58 d545bd58
bd60: d6d7f015 d545be08 00000000 00000000 d545bee8 d545bee8 d545bf28 00000000
bd80: d545bdd4 d545bd90 c028f310 c028e9b0 d545be08 80808080 d545be08 d6d7f010
bda0: d545bdd4 d545bdb0 c028df9c d545be08 d6d7f010 00000000 d545bee8 d545bee8
bdc0: d545bf28 00000000 d545be04 d545bdd8 c0290e24 c028f160 c0111a1c c0111674
bde0: d545be04 d545bdf0 00000001 d6d7f000 d545be08 00000001 d545beb4 d545be08
be00: c0293848 c0290da4 d6dd0310 d6547720 8420edbe 00000007 d6d7f015 0000000c
be20: d6dd0310 d6547098 d656e838 00000001 00000002 00000fe0 00000000 00000000
be40: 00000000 d545be48 c02797f4 00000ff0 d6d7f010 c102b4c8 d5522db8 d6d7f000
be60: c130bbdc 004f73f8 00000000 00000001 d545bf28 00000000 d6d7f000 00000000
be80: c0293570 00000002 ffffff9c 00000001 ffffff9c 00000001 ffffff9c d545bee8
bea0: ffffff9c 004f73f8 d545bedc d545beb8 c0293990 c02937b4 00000000 00000000
bec0: 00000000 beb93970 00000001 00000800 d545bf1c d545bee0 c028859c c0293948
bee0: 00000000 d545bfb0 00509070 00508d7c d545bfac beb93970 00000003 beb95cd0
bf00: 000000c3 c01011e4 d545a000 00000000 d545bfa4 d545bf20 c0288df4 c0288540
bf20: 000007ff c0152868 00000fff 000043d8 00000002 00001000 00000000 00000000
bf40: 00000874 00000000 0006037f 00000000 0b300031 00000000 00000000 0000006d
bf60: 00001000 00000000 5a9c7e8b 2d4cae00 5a0d222f 00000000 5a8c9273 22358b29
bf80: 5a8c8591 301168da 00000008 b6ea94fc 00030030 b6f91ab8 00000000 d545bfa8
bfa0: c0101000 c0288dc8 b6f91ab8 00000003 004f73f8 beb93970 beb93a90 3dc50800
bfc0: b6f91ab8 00000003 beb95cd0 000000c3 00509cec 00509070 00508d7c 00000002
bfe0: 000000c3 beb93968 b6ea354b b6e2ccf6 20030030 004f73f8 17bfd861 17bfdc61
[<c033bc00>] (dx_probe) from [<c033d578>] (ext4_find_entry+0x3bc/0x5ac)
[<c033d578>] (ext4_find_entry) from [<c033d7c0>] (ext4_lookup+0x58/0x1f4)
[<c033d7c0>] (ext4_lookup) from [<c028ea50>] (lookup_slow+0xac/0x15c)
[<c028ea50>] (lookup_slow) from [<c028f310>] (walk_component+0x1bc/0x2f0)
[<c028f310>] (walk_component) from [<c0290e24>] (path_lookupat+0x8c/0x1f0)
[<c0290e24>] (path_lookupat) from [<c0293848>] (filename_lookup+0xa0/0xfc)
[<c0293848>] (filename_lookup) from [<c0293990>] (user_path_at_empty+0x54/0x5c)
[<c0293990>] (user_path_at_empty) from [<c028859c>] (vfs_statx+0x68/0xc4)
[<c028859c>] (vfs_statx) from [<c0288df4>] (SyS_stat64+0x38/0x54)
[<c0288df4>] (SyS_stat64) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xd545bfa8 to 0xd545bff0)
bfa0:                   b6f91ab8 00000003 004f73f8 beb93970 beb93a90 3dc50800
bfc0: b6f91ab8 00000003 beb95cd0 000000c3 00509cec 00509070 00508d7c 00000002
bfe0: 000000c3 beb93968 b6ea354b b6e2ccf6
Code: e2833094 e587300c eaffff72 e7f001f2 (e7f001f2)
---[ end trace 60fa8eaa4e57e458 ]---
