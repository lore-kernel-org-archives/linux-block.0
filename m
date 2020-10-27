Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D026C4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 07:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1013C22264
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 07:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S4OidH0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgJ0HZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:25:29 -0400
Received: from m12-13.163.com ([220.181.12.13]:54169 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731322AbgJ0HZ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 03:25:29 -0400
X-Greylist: delayed 14442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 03:25:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=8xjrP
        oZl0LE4NJ4jZ4CpWo8I6Cx3nIDJmye1dff5iis=; b=S4OidH0BUxrN92CHQmToA
        usN9sFGEqnbBkaULgDTo0Z2/tJn47xE9Z8hF+MuNmUCVKNXeyGexYcyNTQQnuWua
        mMOj1jufuHD+wCdAurrx6wO+wvYL829FDWjFO3Im/pP5X9d+qeX77NTmHrsDmmAn
        YCByIC/mveHCRVpHrQgQEQ=
Received: from [172.20.145.84] (unknown [223.112.105.132])
        by smtp9 (Coremail) with SMTP id DcCowAAXrGqwh5df9SmeNQ--.4678S2;
        Tue, 27 Oct 2020 10:36:34 +0800 (CST)
Subject: Re: [bug report] NBD: rbd-nbd + ext4 stuck after nbd resized
To:     Ming Lei <ming.lei@redhat.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, yunchuan.wen@kylin-cloud.com,
        ceph-users@ceph.io, donglifekernel@126.com, magicdx@gmail.com,
        yanhaishuang@cmss.chinamobile.com
References: <AA00244F-0E5A-4E52-B358-4F36A3486EBF@163.com>
 <20201027011801.GA1828887@T590>
From:   lining <lining2020x@163.com>
Message-ID: <7aa067eb-dc31-94d4-86ee-f99ad486b332@163.com>
Date:   Tue, 27 Oct 2020 10:35:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027011801.GA1828887@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAXrGqwh5df9SmeNQ--.4678S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFWUAryftr4xuw15Jry3XFb_yoWxCr4rpr
        4UtFWUCF4kJr1UJF4UJF1UGw15JFs2va1UX347Aryvy3W5Ww17Xr4jyrWUA34DKr4Du347
        tF4DWw10k34qyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAjjDUUUUU=
X-Originating-IP: [223.112.105.132]
X-CM-SenderInfo: polqx0bjsqjir06rljoofrz/1tbiUBPKNlWBpCcsfgAAs6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming,

Thanks for following up on this issue. It can be reproduced on v5.9 kernel.

I reproduced it just now. Here is the details.

ln@ubuntu:linux>$ git describe HEAD
v5.9-14722-gd76913908102

ln@ubuntu:linux>$ uname -a
Linux ubuntu 5.9.0+ #3 SMP Mon Oct 26 16:56:48 CST 2020 x86_64 x86_64 
x86_64 GNU/Linux

ln@ubuntu:~>$ sudo bash -x repro.sh
+ umount /tmp/mntnbd
umount: /tmp/mntnbd: no mount point specified.
+ rbd-nbd unmap kcp/foo
rbd-nbd: kcp/foo is not mapped
+ rbd rm kcp/foo
Removing image: 100% complete...done.
+ rbd create -s 2G kcp/foo
+ rbd-nbd map kcp/foo
/dev/nbd0
+ mkfs.ext4 /dev/nbd0
mke2fs 1.45.5 (07-Jan-2020)
Discarding device blocks: done
Creating filesystem with 524288 4k blocks and 131072 inodes
Filesystem UUID: f4b9635c-152f-4042-b9ca-602428628cf0
Superblock backups stored on blocks:
         32768, 98304, 163840, 229376, 294912

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

+ mkdir -p /tmp/mntnbd
+ mount /dev/nbd0 /tmp/mntnbd
+ rbd resize kcp/foo --size 4G
Resizing image: 100% complete...done.
ln@ubuntu:~>$ ls /tmp/mntnbd/

^C^C


ln@ubuntu:~>$ top
top - 10:30:19 up 7 min,  2 users,  load average: 2.06, 1.63, 0.82
Tasks: 378 total,   2 running, 376 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  8.3 sy,  0.0 ni, 91.6 id,  0.0 wa,  0.0 hi,  0.0 si, 
  0.0 st
MiB Mem :  15787.1 total,  13036.7 free,    970.5 used,   1779.8 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.  14529.2 avail Mem

     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ 
COMMAND
    3020 ln        20   0    6508    828    724 R 100.0   0.0   5:48.08 ls
     199 root      20   0       0      0      0 I   0.3   0.0   0:00.18 
kworker/10:2-events
    1058 root      20   0       0      0      0 I   0.3   0.0   0:00.03 
kworker/8:2-events


ln@ubuntu:~>$ dmesg
...
[   75.279029] EXT4-fs (nbd0): mounted filesystem with ordered data 
mode. Opts: (null)
[   78.490171] BUG: kernel NULL pointer dereference, address: 
0000000000000010
[   78.490212] #PF: supervisor read access in kernel mode
[   78.490223] #PF: error_code(0x0000) - not-present page
[   78.490254] PGD 0 P4D 0
[   78.490262] Oops: 0000 [#1] SMP PTI
[   78.490271] CPU: 9 PID: 2972 Comm: ext4lazyinit Not tainted 5.9.0+ #3
[   78.490297] Hardware name: VMware, Inc. VMware Virtual Platform/440BX 
Desktop Reference Platform, BIOS 6.00 07/22/2020
[   78.490321] RIP: 0010:__ext4_journal_get_write_access+0x2c/0x120
[   78.490347] Code: 44 00 00 55 48 89 e5 41 57 49 89 cf 41 56 41 55 41 
54 49 89 d4 53 48 83 ec 18 48 89 7d d0 89 75 cc e8 78 74 7b 00 49 8b 47 
30 <4c> 8b 68 10 4d 85 ed 74 2f 49 8b 85 d8 00 00 00 49 8b 9d 80 03 00
[   78.490379] RSP: 0018:ffffb0f581793dd0 EFLAGS: 00010246
[   78.490389] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 
ffff9167954c4000
[   78.490402] RDX: ffff91679550f690 RSI: 000000000000061f RDI: 
ffffffff84c4aa50
[   78.490416] RBP: ffffb0f581793e10 R08: 0000000000001ff5 R09: 
0000000000000001
[   78.490428] R10: ffff916784cb0a00 R11: 000000000a002b8c R12: 
ffff91679550f690
[   78.490441] R13: ffff9167901ce000 R14: 0000000000000200 R15: 
ffff9167954c4000
[   78.490454] FS:  0000000000000000(0000) GS:ffff916aae040000(0000) 
knlGS:0000000000000000
[   78.490469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.490479] CR2: 0000000000000010 CR3: 000000010a1d8004 CR4: 
00000000003706e0
[   78.490537] Call Trace:
[   78.490547]  ? __ext4_journal_start_sb+0x106/0x120
[   78.490558]  ext4_init_inode_table+0x168/0x390
[   78.490976]  ext4_lazyinit_thread+0x38b/0x520
[   78.491359]  kthread+0x114/0x150
[   78.491603]  ? ext4_journalled_writepage_callback+0x60/0x60
[   78.491849]  ? kthread_park+0x90/0x90
[   78.492103]  ret_from_fork+0x22/0x30
[   78.492348] Modules linked in: nbd rfcomm xt_conntrack xt_MASQUERADE 
nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype 
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 
bnep bonding vsock_loopback vmw_vsock_virtio_transport_common vsock 
binfmt_misc intel_rapl_msr intel_rapl_common kvm_intel kvm 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel 
crypto_simd cryptd glue_helper rapl btusb btrtl btbcm btintel bluetooth 
joydev vmw_balloon psmouse input_leds ecdh_generic ecc e1000 vmw_vmci 
i2c_piix4 mac_hid sch_fq_codel btrfs blake2b_generic libcrc32c xor 
zstd_compress raid6_pq overlay iptable_filter ip6table_filter ip6_tables 
br_netfilter serio_raw bridge mptspi scsi_transport_spi ahci mptscsih 
libahci mptbase pata_acpi stp llc arp_tables vmwgfx hid_generic 
drm_kms_helper usbhid hid syscopyarea sysfillrect sysimgblt fb_sys_fops 
cec ttm drm parport_pc ppdev lp parport ip_tables x_tables autofs4
[   78.495718] CR2: 0000000000000010
[   78.496074] ---[ end trace d98825069bfe2e2a ]---
[   78.496425] RIP: 0010:__ext4_journal_get_write_access+0x2c/0x120
[   78.496775] Code: 44 00 00 55 48 89 e5 41 57 49 89 cf 41 56 41 55 41 
54 49 89 d4 53 48 83 ec 18 48 89 7d d0 89 75 cc e8 78 74 7b 00 49 8b 47 
30 <4c> 8b 68 10 4d 85 ed 74 2f 49 8b 85 d8 00 00 00 49 8b 9d 80 03 00
[   78.497834] RSP: 0018:ffffb0f581793dd0 EFLAGS: 00010246
[   78.498259] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 
ffff9167954c4000
[   78.498606] RDX: ffff91679550f690 RSI: 000000000000061f RDI: 
ffffffff84c4aa50
[   78.498944] RBP: ffffb0f581793e10 R08: 0000000000001ff5 R09: 
0000000000000001
[   78.499295] R10: ffff916784cb0a00 R11: 000000000a002b8c R12: 
ffff91679550f690
[   78.499630] R13: ffff9167901ce000 R14: 0000000000000200 R15: 
ffff9167954c4000
[   78.499964] FS:  0000000000000000(0000) GS:ffff916aae040000(0000) 
knlGS:0000000000000000
[   78.500316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.500655] CR2: 0000000000000010 CR3: 000000010a1d8004 CR4: 
00000000003706e0
...


在 2020/10/27 9:18, Ming Lei 写道:
> On Wed, Oct 21, 2020 at 09:08:10AM +0800, lining wrote:
>> (Sorry for sending this mail again, this one add nbd@other.debian.org)
>>
>> Hi kernel、ceph comunity:
>>
>> We run into an issue that mainly related to the (kernel) nbd driver and (ceph) rbd-nbd.
>> After some investigations, I found that the root cause of the problem seems to be related to the change in the block size of nbd.
>>
>> I am not sure whether it is the nbd driver or rbd-nbd bug, however there is such a problem.
>>
>>
>> What happened：
>> It will always hang when accessing the mount point of nbd device with ext4 after nbd resized.
>>
>>
>> Environment information:
>> - kernel:               v4.19.25 or master
>> - rbd-nbd(ceph):  v12.2.0 Luminous or master
>> - the fs of nbd:    ext4
> 
> Hello lining,
> 
> Can you reproduce this issue on v5.9 kernel?
> 
> 
> Thanks,
> Ming
> 

