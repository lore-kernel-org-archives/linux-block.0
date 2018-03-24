Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:39380 "EHLO othala.iewc.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753102AbeCXViZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Mar 2018 17:38:25 -0400
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "pieterk@uls.co.za" <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
 <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
 <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
 <1520737695.8740.4.camel@wdc.com>
 <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
 <1520744455.8740.9.camel@wdc.com>
 <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
 <1520950225.2921.0.camel@wdc.com>
 <cca75546-a02e-bed3-fda0-0003ccc5d158@uls.co.za>
 <1520953606.2638.5.camel@wdc.com>
 <b9f2421d-6350-1136-86ea-bdb70a59b6d9@uls.co.za>
 <1520961846.2638.25.camel@wdc.com>
From: Jaco Kroon <jaco@uls.co.za>
Message-ID: <ee32fa2f-3470-0ba8-a1a6-a362877b2fcc@uls.co.za>
Date: Sat, 24 Mar 2018 23:38:01 +0200
MIME-Version: 1.0
In-Reply-To: <1520961846.2638.25.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

Does the following go with your theory:

[452545.945561] sysrq: SysRq : Show backtrace of all active CPUs
[452545.946182] NMI backtrace for cpu 5
[452545.946185] CPU: 5 PID: 31921 Comm: bash Tainted: G          I    
4.14.13-uls #2
[452545.946186] Hardware name: Supermicro
SSG-5048R-E1CR36L/X10SRH-CLN4F, BIOS T20140520103247 05/20/2014
[452545.946187] Call Trace:
[452545.946196]  dump_stack+0x46/0x5a
[452545.946200]  nmi_cpu_backtrace+0xb3/0xc0
[452545.946205]  ? irq_force_complete_move+0xd0/0xd0
[452545.946208]  nmi_trigger_cpumask_backtrace+0x8f/0xc0
[452545.946212]  __handle_sysrq+0xec/0x140
[452545.946216]  write_sysrq_trigger+0x26/0x30
[452545.946219]  proc_reg_write+0x38/0x60
[452545.946222]  __vfs_write+0x1e/0x130
[452545.946225]  vfs_write+0xab/0x190
[452545.946228]  SyS_write+0x3d/0xa0
[452545.946233]  entry_SYSCALL_64_fastpath+0x13/0x6c
[452545.946236] RIP: 0033:0x7f6b85db52d0
[452545.946238] RSP: 002b:00007fff6f9479e8 EFLAGS: 00000246
[452545.946241] Sending NMI from CPU 5 to CPUs 0-4:
[452545.946272] NMI backtrace for cpu 0 skipped: idling at pc
0xffffffff8162b0a0
[452545.946275] NMI backtrace for cpu 3 skipped: idling at pc
0xffffffff8162b0a0
[452545.946279] NMI backtrace for cpu 4 skipped: idling at pc
0xffffffff8162b0a0
[452545.946283] NMI backtrace for cpu 2 skipped: idling at pc
0xffffffff8162b0a0
[452545.946287] NMI backtrace for cpu 1 skipped: idling at pc
0xffffffff8162b0a0

I'm not sure how to link that address back to some function or
something, and had to reboot, so not sure if that can be done still.

Kind Regards,
Jaco

On 13/03/2018 19:24, Bart Van Assche wrote:
> On Tue, 2018-03-13 at 19:16 +0200, Jaco Kroon wrote:
>> The server in question is the destination of  numerous rsync/ssh cases
>> (used primarily for backups) and is not intended as a real-time system.
>> I'm happy to enable the options below that you would indicate would be
>> helpful in pinpointing the problem (assuming we're not looking at a 8x
>> more CPU required type of degrading as I've recently seen with asterisk
>> lock debugging enabled). I've marked in bold below what I assume would
>> be helpful.  If you don't mind confirming for me I'll enable and
>> schedule a reboot.
> Hello Jaco,
>
> My recommendation is to wait until the mpt3sas maintainers post a fix
> for what I reported yesterday on the linux-scsi mailing list. Enabling
> CONFIG_DEBUG_ATOMIC_SLEEP has namely a very annoying consequence for the
> mpt3sas driver: the first process that hits the "sleep in atomic context"
> bug gets killed. I don't think that you want this kind of behavior on a
> production setup.
>
> Bart.
>
>
>
>
