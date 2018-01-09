Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751496AbeAIJOi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jan 2018 04:14:38 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w099DoTm093036
        for <linux-block@vger.kernel.org>; Tue, 9 Jan 2018 04:14:38 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fctpvgump-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 09 Jan 2018 04:14:35 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <abdhalee@linux.vnet.ibm.com>;
        Tue, 9 Jan 2018 02:14:31 -0700
Subject: [linux-next][qla2xxx][85caa95]kernel BUG at lib/list_debug.c:31!
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        mpe <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        sim <sim@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>
Date: Tue, 09 Jan 2018 14:44:24 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1515489264.3648.18.camel@abdul.in.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Greeting's, 

Linux next kernel panics on powerpc when module qla2xxx is load/unload.

Machine Type: Power 8 PowerVM LPAR
Kernel : 4.15.0-rc2-next-20171211
gcc : version 4.8.5
Test type: module load/unload few times

Trace messages:
---------------
qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.03-k.
qla2xxx [0106:a0:00.0]-001a: : MSI-X vector count: 32.
qla2xxx [0106:a0:00.0]-001d: : Found an ISP2532 irq 505 iobase 0x00000000aeb324e6.
qla2xxx [0106:a0:00.0]-00c6:1: MSI-X: Failed to enable support with 32 vectors, using 16 vectors.
qla2xxx [0106:a0:00.0]-00fb:1: QLogic QLE2562 - PCIe 2-port 8Gb FC Adapter.
qla2xxx [0106:a0:00.0]-00fc:1: ISP2532: PCIe (5.0GT/s x8) @ 0106:a0:00.0 hdma- host#=1 fw=8.06.00 (90d5).
qla2xxx [0106:a0:00.1]-001a: : MSI-X vector count: 32.
qla2xxx [0106:a0:00.1]-001d: : Found an ISP2532 irq 506 iobase 0x00000000a46f1774.
qla2xxx [0106:a0:00.1]-00c6:2: MSI-X: Failed to enable support with 32 vectors, using 16 vectors.
2xxx
qla2xxx [0106:a0:00.1]-00fb:2: QLogic QLE2562 - PCIe 2-port 8Gb FC Adapter.
qla2xxx [0106:a0:00.1]-00fc:2: ISP2532: PCIe (5.0GT/s x8) @ 0106:a0:00.1 hdma- host#=2 fw=8.06.00 (90d5).
0:00.0]-500a:1: LOOP UP detected (8 Gbps). 
qla2xxx [0106:a0:00.1]-500a:2: LOOP UP detected (8 Gbps).
list_add double add: new=000000008d33e594, prev=000000008d33e594, next=00000000adef1df4.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31! 
Oops: Exception in kernel mode, sig: 5 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries 
Dumping ftrace buffer: 
   (ftrace buffer empty)
Modules linked in: qla2xxx(E) tg3(E) ibmveth(E) xt_CHECKSUM(E)
iptable_mangle(E) ipt_MASQUERADE(E) nf_nat_masquerade_ipv4(E)
iptable_nat(E) nf_nat_ipv4(E) nf_nat(E) nf_conntrack_ipv4(E)
nf_defrag_ipv4(E) xt_conntrack(E) nf_conntrack(E) ipt_REJECT(E)
nf_reject_ipv4(E) tun(E) bridge(E) stp(E) llc(E) kvm_pr(E) kvm(E)
sctp_diag(E) sctp(E) libcrc32c(E) tcp_diag(E) udp_diag(E)
ebtable_filter(E) ebtables(E) dccp_diag(E) ip6table_filter(E) dccp(E)
ip6_tables(E) iptable_filter(E) inet_diag(E) unix_diag(E)
af_packet_diag(E) netlink_diag(E) xts(E) sg(E) vmx_crypto(E)
pseries_rng(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
sunrpc(E) binfmt_misc(E) ip_tables(E) ext4(E) mbcache(E) jbd2(E)
fscrypto(E) sd_mod(E) ibmvscsi(E) scsi_transport_srp(E) nvme_fc(E)
nvme_fabrics(E) nvme_core(E) scsi_transport_fc(E)
 ptp(E) pps_core(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
[last unloaded: qla2xxx]
CPU: 7 PID: 22230 Comm: qla2xxx_1_dpc Tainted: G            E    4.15.0-rc2-next-20171211-autotest-autotest #1
NIP:  c000000000511040 LR: c00000000051103c CTR: 0000000000655170        
REGS: 000000009b7356fa TRAP: 0700   Tainted: G            E     (4.15.0-rc2-next-20171211-autotest-autotest)
MSR:  800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22000022  XER: 00000009  
CFAR: c000000000170594 SOFTE: 0 
GPR00: c00000000051103c c0000000fc293ac0 c0000000010f1d00 0000000000000058 
GPR04: c00000028fcccdd0 c00000028fce3798 80000000374060b8 ffffffffffffffff 
GPR08: 0000000000000000 c000000000d435ec 000000028ef90000 0000000000002717 
GPR12: 0000000000000000 c00000000e734980 c0000000001215d8 c0000002886996c0 
GPR16: 0000000000000000 0000000000000020 c0000002813d83f8 0000000000000001 
GPR20: 0000000020000000 0000000000002000 0000000000000002 c0000002813dc808 
GPR24: 0000000000000003 0000000000000001 c00000027f5a5c20 c0000002813dced0 
GPR28: c00000027f5a5d90 c00000027f5a5d90 c00000027f5a5c00 c0000002813dc7f8 
NIP [c000000000511040] __list_add_valid+0x70/0xb0
LR [c00000000051103c] __list_add_valid+0x6c/0xb0
Call Trace:
[c0000000fc293ac0] [c00000000051103c] __list_add_valid+0x6c/0xb0 (unreliable)
[c0000000fc293b20] [d0000000051f1a08] qla24xx_async_gnl+0x108/0x420 [qla2xxx]
[c0000000fc293bc0] [d0000000051e762c] qla2x00_do_work+0x18c/0x8c0 [qla2xxx]
[c0000000fc293ce0] [d0000000051e8180] qla2x00_relogin+0x420/0xff0 [qla2xxx]
[c0000000fc293dc0] [c00000000012172c] kthread+0x15c/0x1a0
[c0000000fc293e30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
Instruction dump:
41de0018 38210060 38600001 e8010010 7c0803a6 4e800020 3c62ffae 7d445378 
38631748 7d254b78 4bc5f51d 60000000 <0fe00000> 3c62ffae 7cc43378 386316f8 
---[ end trace a41bc8bd434657f1 ]---

Kernel panic - not syncing: Fatal exception
Dumping ftrace buffer: 
   (ftrace buffer empty)
Rebooting in 10 seconds..

This trace back to the below code path:

# gdb -batch vmlinux -ex 'list *(0xc000000000511040)'
0xc000000000511040 is in __list_add_valid (lib/list_debug.c:29).
24				"list_add corruption. next->prev should be prev (%p), but was %p. (next=%p).\n",
25				prev, next->prev, next) ||
26		    CHECK_DATA_CORRUPTION(prev->next != next,
27				"list_add corruption. prev->next should be next (%p), but was %p. (prev=%p).\n",
28				next, prev->next, prev) ||
29		    CHECK_DATA_CORRUPTION(new == prev || new == next,
30				"list_add double add: new=%p, prev=%p, next=%p.\n",
31				new, prev, next))
32			return false;
33	


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
