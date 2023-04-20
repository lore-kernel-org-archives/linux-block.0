Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4740AC77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 12:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDTM5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTM5l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 08:57:41 -0400
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511281FFD
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 05:57:40 -0700 (PDT)
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
        by phd-imap.ethz.ch (Postfix) with ESMTP id 4Q2HkV2Jkqz3D;
        Thu, 20 Apr 2023 14:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
        s=2023; t=1681995458;
        bh=Z4MWX3VwhFYFX0qs1bSu3B8t/XLbQRc4QjgX0KP4uzY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=goXhP4T76nkuUbtb8hltNuv1qWudJ4oAOcJu19wrV9JymokSIa83YQyYetYmde/nO
         OPUjroPIvUD1WkY9/X6BjGe+RbG2zTc/wdm9v0V4ZdFCms7F3aeZfiMyAS96EC2Yet
         89RHjTCA7yzb6BoFOl/Pafy4ixWFD9l0wGa+NFjlr19FRjOtn4y6tvkqP1/rTNrRlA
         255Mhi45G5q+Cu83tqajpZ0M2pNvB91/Qyo+IvBMqKKQcev9rtH3ffR97ZgTnw9LTQ
         IydTfP+nQS54AzVVo/HYT8hyGvgPDN3qeUnixir9wX5y7tPIsxvkx2vJugU7o7tAlp
         caBr2kTroM7kQ==
X-Virus-Scanned: Debian amavisd-new at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
        by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavisd-new, port 10024)
        with LMTP id WZ6rfxVDfBML; Thu, 20 Apr 2023 14:57:38 +0200 (CEST)
Received: from phys.ethz.ch (mothership.ethz.ch [192.33.96.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daduke@phd-mxin.ethz.ch)
        by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4Q2HkV1QsQz9x;
        Thu, 20 Apr 2023 14:57:38 +0200 (CEST)
Date:   Thu, 20 Apr 2023 14:57:37 +0200
From:   Christian Herzog <herzog@phys.ethz.ch>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: file server freezes with all nfsds stuck in D state after
 upgrade to Debian bookworm
Message-ID: <ZEE2wZPpY7JBWbY8@phys.ethz.ch>
Reply-To: Christian Herzog <herzog@phys.ethz.ch>
References: <ZC76dIshWvaWlki4@phys.ethz.ch>
 <50766556-cd33-7506-13b1-64940b5995bb@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50766556-cd33-7506-13b1-64940b5995bb@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear all,

we just had another freeze on one of our bookworm file servers. The scenario
is a bit different, but the root cause might be just the same. So what
happened:

- the server had been happily serving NFS + SMB for two weeks
- today I noticed a left-over rsync process from a recent backup run that
  didn't do any IO and was in D state
- I killed this rsync process, but since it was in D, it never died
- after a few minutes I noticed an nfsd in D state too (but just one). I
  watched it for a bit and then decided to try "service nfs-kernel-server
  restart" to see if again nfs was involved. I guess it was...
- from then on, all sorts of processes entered eternal D: several smbd,
  autofs, the rsync and one nfsd
- however: at all times, the underlying file systems seemed perfectly fine. We
  could write to every single one of them and gdu the hundred-TiB ones without
  a problem
- my impression is that at least this time, nfsd was just one of the victims
  of a deeper problem
- we took all the forensics suggested last time by Kuai and Bob. I don't
  really understand them, but here's the facts:
  - memory on the machine is completely uncritical, < 20% used
  - the rqos/wbt/inflight of all block devices are 0 (remember: those are
    iSCSI LUNs)
  - all the hctx* values seem unsuspicious to me, but what do I know
  - the stacks traces of the D processes don't show any rq_qos_wait this time

here's the D rsync trace:

[<0>] iterate_dir+0x52/0x1c0
[<0>] __x64_sys_getdents64+0x84/0x120
[<0>] do_syscall_64+0x58/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd


and the D nfsd:

[<0>] vfs_rename+0x266/0xd70
[<0>] nfsd_rename+0x327/0x470 [nfsd]
[<0>] nfsd4_rename+0x53/0x110 [nfsd]
[<0>] nfsd4_proc_compound+0x352/0x660 [nfsd]
[<0>] nfsd_dispatch+0x167/0x280 [nfsd]
[<0>] svc_process_common+0x286/0x5e0 [sunrpc]
[<0>] svc_process+0xad/0x100 [sunrpc]
[<0>] nfsd+0xd5/0x190 [nfsd]
[<0>] kthread+0xe6/0x110
[<0>] ret_from_fork+0x1f/0x30

all the forensics are contained in
https://people.phys.ethz.ch/~daduke/freeze.tgz

we would be extremely grateful for any hints how we can debug (or even solve)
this. We're really at a loss here...


thanks and kind regards,
-Christian


-- 
Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
Head, IT Services Group, HPT H 8              voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://isg.phys.ethz.ch/
