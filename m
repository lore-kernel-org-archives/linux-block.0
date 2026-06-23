Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA912D2394;
	Tue, 23 Jun 2026 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194022; cv=none; b=lpEiA56y3bADJ6IJ7Cvl/4I3SXte+BCON6T+NTI8nH+Tvjn4aobxLesrZrpEjhQi0W1P5IuCdMmfrtMAsVlcMYT12FVa8MFJ7ItWND5RaUMdJmKqpgRnC/6pxeiCdyN9XzKfXcWpitatL43od9hRWuOGmP5flPs3X3Dtd94abQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194022; c=relaxed/simple;
	bh=DXVB+AIQxJRT997wUDnNmJ1ALbn4NQv3o54NwGjMWUw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=CGo1H+veWE0ZR56vUIXGta8rqzRAArsYJLNqV1rX1GWDyVV2W3QlZq8AdNobwC8ByZv9RpuSOaRs7CNGmTfgxJOxkMrltRu3kmDng/6KDNyeQnTSxlXqJ9K323knaoNfiP0vLw20uec8JngUTTGjJIR4J6kYPcmMHRz9dHq8HJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=pxw1r28X; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="pxw1r28X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782193942;
	bh=3Jb4hbovMhXjoPYlBFxuuBMSsi9viUd+26z34ZL5FCU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=pxw1r28XOdqjpbztYBUXi8N0+1BeEyOwhMvBV7vWDLTl3tKAjqkbxF+QrP0+Wbam2
	 9/SjDp9zLNGqMo0XnQ0MuXbSXIIhSpyrmzdXJIy0my8EQFjUIX3ivripTirXAp/Bh7
	 cFftaSdKDbPAer5PiAjKVwTQyd26pzhPhfDhM+nU=
X-QQ-mid: esmtpgz14t1782193936t595f704e
X-QQ-Originating-IP: 0bFXOGvfhcAf2Y9nMW7jvmbowcCu3T3bou4PCndmFyc=
Received: from [127.0.0.1] ( [36.152.24.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 13:51:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 478658043353222059
Message-ID: <B518B1A813407AC5+004c9da2-4504-44ce-ac1b-7b46bf0c30db@smail.nju.edu.cn>
Date: Tue, 23 Jun 2026 13:51:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: josef@toxicpanda.com, linux-block@vger.kernel.org
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] nbd: backend string memory leaked when device_create_file()
 fails in nbd_genl_connect()
Cc: axboe@kernel.dk, nbd@other.debian.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Nw9C1WBu09hPPr1LIL0enW0m0WeO7SUQw1ebHSzHs1PHzZWHvWfGJ85/
	3I9Majy+apGqbNDDyk8/Hiit4gJVTJKo6kuoUF+ia1tv2Z3L7jMGYtuuZZs8Zxx56bk+gCF
	70k9edLxGAGEaRpEfHYq+7mCEOqE+XkK3esPWAiQLI1IzjJwB1huHtG88sTQCbwFRFk742p
	7s2ReNDCOch24ztXcJ3JtnLkY/XplSeF2/bTTWVvL3bRUAe4jrIJrgz/g1eyBYz/r1TgXiE
	Qvek0bhTkC/qy1QjJpXrSBQDW0FDF+Ye8LYl+DRMun90oZQWOWt7n7Hwj0JRBzDM+wf4ctZ
	4Eravzr+dhOQ+c7k0UTzShG3YN0sVXtYmLAwp7shHNwcSIjf8UQakm2ENuFTTIUsn4DLQbZ
	M+WsATKTdVWuWLgubtFUfdva3Pl4aRlu3M9xnZLYqIUF03YfHIZKA5BpPLNpQM1TSYIvB24
	yRlFDM6rX08EFsamPg5SOwQOTX2gwYOXY7X3LxYR1rDWtsT9EfhZ2P5LAUWDDhe74ErI3+/
	rpwNyWz3f9Ceki5L+D1I6yGgKSk93rcm1OG7HCIDZPQl5bF0yK1YJUUBh6CfhGbTJbkKPAp
	JJJdrz8ahM2pQQycHc5lG3auRo/98YoDWr6oNOJzKsE3gNy96dxAqJrx41w645WCwEb0Mug
	cOWLxkQZB+e3UP4r9/LV1HFHL3GRAGeoduLsYuoALUEz6EcGwrmYjOgZq4VfEOBeXhF0Rnh
	ysk6DTraJYOlS4fjWuIWbs1Dk7NhBusTTOIH1wAEP1zMyEKzOLC049XD7p0X9unUzKsWBlr
	adtSI92OB+SwJBCU4kYrsYel04AJHdgjNJNTmIhIlGhWRKo9BPwSnKx01H+ZSdbIznm8Wzl
	RfWAFAeJFIfXD8AWZfDq81bLt1s+o2r65s+3vj4uYIfnq8VTs8fSOjDVf4jTn81eWLfOucz
	aaGYyX1B9iNYZU5LfXTRwuLpHJ0/0wq1GCvl9FpN89mMGOWb96Td3UT4N2pO0KsR+EW6WBq
	rOCHc1PqXfpUQZpZILFjQ+uc6CBHM=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Hello Linux kernel developers and maintainers,

I found a memory leak in drivers/block/nbd.c when fuzzing with Syzkaller.

Kernel version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1).
And the leak is also possible in the current mainline.

Relevant kernel config:

  CONFIG_BLK_DEV_NBD=y
  CONFIG_DEBUG_KMEMLEAK=y
  CONFIG_FAULT_INJECTION=y
  CONFIG_FAILSLAB=y
  CONFIG_FAULT_INJECTION_DEBUG_FS=y

=============================
The original Syzkaller report
=============================

BUG: memory leak
unreferenced object 0xffff888011d17420 (size 16):
  comm "syz.3.80", pid 9959, jiffies 4294977483
  hex dump (first 16 bytes):
    2f 64 65 76 2f 6e 62 64 23 00 00 00 00 00 00 00  /dev/nbd#.......
  backtrace (crc 889be63d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4575 [inline]
    slab_alloc_node mm/slub.c:4899 [inline]
    __do_kmalloc_node mm/slub.c:5295 [inline]
    __kmalloc_noprof+0x552/0x850 mm/slub.c:5308
    kmalloc_noprof include/linux/slab.h:954 [inline]
    nla_strdup+0xc6/0x150 lib/nlattr.c:816
    nbd_genl_connect+0x1231/0x1c10 drivers/block/nbd.c:2224
    genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1114
    genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
    genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1209
    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2555
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
    netlink_unicast+0x584/0x850 net/netlink/af_netlink.c:1344
    netlink_sendmsg+0x8ba/0xd60 net/netlink/af_netlink.c:1899
    sock_sendmsg_nosec net/socket.c:787 [inline]
    __sock_sendmsg net/socket.c:802 [inline]
    ____sys_sendmsg+0x9eb/0xb80 net/socket.c:2699
    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2753
    __sys_sendmsg+0x16d/0x220 net/socket.c:2785
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>


==========
Root cause
==========

nbd_genl_connect() allocates the backend string unconditionally BEFORE
creating the sysfs file:

    /* drivers/block/nbd.c (v7.1, around line 2223) */
    if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
        nbd->backend = nla_strdup(...);       /* (1) heap alloc */
        if (!nbd->backend) {
            ret = -ENOMEM;
            goto out;                         /* (2) backend is NULL here, no leak */
        }
    }

    ret = device_create_file(disk_to_dev(nbd->disk), &backend_attr);
    if (ret) {
        dev_err(...);
        goto out;                             /* (3) LEAK: flag not yet set */
    }

    set_bit(NBD_RT_HAS_BACKEND_FILE, &config->runtime_flags); /* (4) skipped */

    ret = nbd_start_device(nbd);
out:
    ...
    mutex_unlock(&nbd->config_lock);
    nbd_config_put(nbd);
    ...

The cleanup path in nbd_config_put() frees nbd->backend ONLY when
NBD_RT_HAS_BACKEND_FILE is set:

    /* drivers/block/nbd.c (v7.1, around line 1445) */
    if (test_and_clear_bit(NBD_RT_HAS_BACKEND_FILE,
                           &config->runtime_flags)) {
        device_remove_file(disk_to_dev(nbd->disk), &backend_attr);
        kfree(nbd->backend);      /* never reached here if flag is not set */
        nbd->backend = NULL;
    }

When device_create_file() at step (3) fails (e.g. due to OOM or fault injection),
execution jumps to out before step (4) sets the flag.
nbd_config_put() is then called with config_refs dropping to zero,
but since NBD_RT_HAS_BACKEND_FILE is not set, it skips the kfree().
The string allocated at step (1) is therefore leaked.

The size of a single leak equals the length of the NBD_ATTR_BACKEND_IDENTIFIER
netlink string rounded up to the next slab boundary.
The nla_policy entry for this attribute has no .len constraint, so in theory a single connect call
could leak up to ~65507 bytes (NLA_STRING maximum).
During Syzkaller fuzzing, the fuzzer produced a 16-byte string.


============
Proposed Fix
============

Decouple device_remove_file() (which correctly requires the flag to avoid
removing a file that was never created) from kfree(nbd->backend) (which only
needs the pointer to be non-NULL):

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1445,9 +1445,9 @@ static void nbd_config_put(struct nbd_device *nbd)
 		if (test_and_clear_bit(NBD_RT_HAS_BACKEND_FILE,
 				       &config->runtime_flags)) {
 			device_remove_file(disk_to_dev(nbd->disk), &backend_attr);
-			kfree(nbd->backend);
-			nbd->backend = NULL;
 		}
+		kfree(nbd->backend);
+		nbd->backend = NULL;


The flag still guards device_remove_file() so we never try to remove a sysfs
file that was never created.  nbd->backend is always freed if non-NULL,
regardless of whether the file creation succeeded.

Note: the line number in the above diff is valid in the v7.1 kernel.
I will adjust it according to the mainline kernel if this patch is considered resonable.


Best,
Peiyang
