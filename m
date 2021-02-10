Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B17C433E6
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 16:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8439864E74
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 16:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhBJQ0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhBJQ0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 11:26:37 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFCC061574
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 08:25:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w20so1949832qta.0
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VFKJ1VfMBcbGkawO76gmyG8p+Q1Mad1n6dxTBahJkr0=;
        b=uv/G2ftC4Tas4KOvuDL3kAaYQ3qUipYuDYZkBomqwNx47G381mc1mjfa9w+T1GiVuv
         U+MYgxwQDiBFBLgEaZI9CjCZ/s+pcpt9qwVbIWkiLlr8qMM/5UBhIororO4lg7i+cmHh
         HuFmc0sAPx0I2dIYGrHsP51zoyYVEYYWUwblmObaJzV3dSQomLPNfdh0nswZGyY/SXCA
         OEWnpNl8G8pl7c/uJo4/7+XcEQgV/Dq+jqBF+3JmHjUejmOpy4uRzjRhiuYlIVpUmzN2
         nG/+D3UE4TcMCybqaMZZzy7sy/7BjHtJ56PBEpzwwItlcSrYApe0rHNlNAdnxi/B1jXh
         TZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFKJ1VfMBcbGkawO76gmyG8p+Q1Mad1n6dxTBahJkr0=;
        b=jip1oQhaZaDh2OqKLtxeRIshVE6qeFPzNCIgRuxmuAopiSawlXteEyepXEuT5ekmDv
         4qwCGNroERlvzBL7HspqATz7fZF9cxvhe1S5W/KTktKs/qqYqs4Jc0Ccr8ISHMAwPmbi
         DkU2cX4710XWTprZHjv1t1W2YGr2/ruHWjxMjBzHP8VygDwjeuUkwYNeRk/fHfhN8SVu
         pymvcsoK0lZxhaJNXkvELio5bMFxQGrwIYYaPlYxKeigAm5GdBj0tRuCbHEcv2F1vcj0
         kmoC3kbs50Dmkua5hH08n8V8KujL+kJME1YBtRBWpkfRLqMUcIUJJOs7Rn7Vm+/CLWK1
         EMOg==
X-Gm-Message-State: AOAM533GaJfJ1I4CUK/QNEDPPqpwnJiWt9cqYWYwICEMlPuhkTKcJ6bA
        UEWCpRl77HrIhbewE5L6CqkqXA==
X-Google-Smtp-Source: ABdhPJyLNYwtdOwsmR+YuZQDNKjNbCtVCbBJOXVazA5w/jgTriOpufEKNoQuPuJUv+AE3j7HbMf8hQ==
X-Received: by 2002:ac8:7cad:: with SMTP id z13mr3464858qtv.96.1612974356366;
        Wed, 10 Feb 2021 08:25:56 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f131sm1815319qke.15.2021.02.10.08.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:25:55 -0800 (PST)
Subject: Re: [PATCH v5 1/2] nbd: Fix NULL pointer in flush_workqueue
To:     Sun Ke <sunke32@huawei.com>, axboe@kernel.dk, Markus.Elfring@web.de
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20210205065650.2357457-1-sunke32@huawei.com>
 <20210205065650.2357457-2-sunke32@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a38d7926-5989-dfd8-b27b-37a2b92797f0@toxicpanda.com>
Date:   Wed, 10 Feb 2021 11:25:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205065650.2357457-2-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/21 1:56 AM, Sun Ke wrote:
> Open /dev/nbdX first, the config_refs will be 1 and
> the pointers in nbd_device are still null. Disconnect
> /dev/nbdX, then reference a null recv_workq. The
> protection by config_refs in nbd_genl_disconnect is useless.
> 
> [  656.366194] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [  656.368943] #PF: supervisor write access in kernel mode
> [  656.369844] #PF: error_code(0x0002) - not-present page
> [  656.370717] PGD 10cc87067 P4D 10cc87067 PUD 1074b4067 PMD 0
> [  656.371693] Oops: 0002 [#1] SMP
> [  656.372242] CPU: 5 PID: 7977 Comm: nbd-client Not tainted 5.11.0-rc5-00040-g76c057c84d28 #1
> [  656.373661] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> [  656.375904] RIP: 0010:mutex_lock+0x29/0x60
> [  656.376627] Code: 00 0f 1f 44 00 00 55 48 89 fd 48 83 05 6f d7 fe 08 01 e8 7a c3 ff ff 48 83 05 6a d7 fe 08 01 31 c0 65 48 8b 14 25 00 6d 01 00 <f0> 48 0f b1 55 d
> [  656.378934] RSP: 0018:ffffc900005eb9b0 EFLAGS: 00010246
> [  656.379350] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  656.379915] RDX: ffff888104cf2600 RSI: ffffffffaae8f452 RDI: 0000000000000020
> [  656.380473] RBP: 0000000000000020 R08: 0000000000000000 R09: ffff88813bd6b318
> [  656.381039] R10: 00000000000000c7 R11: fefefefefefefeff R12: ffff888102710b40
> [  656.381599] R13: ffffc900005eb9e0 R14: ffffffffb2930680 R15: ffff88810770ef00
> [  656.382166] FS:  00007fdf117ebb40(0000) GS:ffff88813bd40000(0000) knlGS:0000000000000000
> [  656.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  656.383261] CR2: 0000000000000020 CR3: 0000000100c84000 CR4: 00000000000006e0
> [  656.383819] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  656.384370] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  656.384927] Call Trace:
> [  656.385111]  flush_workqueue+0x92/0x6c0
> [  656.385395]  nbd_disconnect_and_put+0x81/0xd0
> [  656.385716]  nbd_genl_disconnect+0x125/0x2a0
> [  656.386034]  genl_family_rcv_msg_doit.isra.0+0x102/0x1b0
> [  656.386422]  genl_rcv_msg+0xfc/0x2b0
> [  656.386685]  ? nbd_ioctl+0x490/0x490
> [  656.386954]  ? genl_family_rcv_msg_doit.isra.0+0x1b0/0x1b0
> [  656.387354]  netlink_rcv_skb+0x62/0x180
> [  656.387638]  genl_rcv+0x34/0x60
> [  656.387874]  netlink_unicast+0x26d/0x590
> [  656.388162]  netlink_sendmsg+0x398/0x6c0
> [  656.388451]  ? netlink_rcv_skb+0x180/0x180
> [  656.388750]  ____sys_sendmsg+0x1da/0x320
> [  656.389038]  ? ____sys_recvmsg+0x130/0x220
> [  656.389334]  ___sys_sendmsg+0x8e/0xf0
> [  656.389605]  ? ___sys_recvmsg+0xa2/0xf0
> [  656.389889]  ? handle_mm_fault+0x1671/0x21d0
> [  656.390201]  __sys_sendmsg+0x6d/0xe0
> [  656.390464]  __x64_sys_sendmsg+0x23/0x30
> [  656.390751]  do_syscall_64+0x45/0x70
> [  656.391017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> v4: Share exception handling code for if branches
> v3: Do not use unlock and add put_nbd.
> v2: Use jump target unlock.
> ---
>   drivers/block/nbd.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index e6ea5d344f87..3c9b3bf3f4c2 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2014,17 +2014,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>   	mutex_lock(&nbd_index_mutex);
>   	nbd = idr_find(&nbd_index_idr, index);
>   	if (!nbd) {
> -		mutex_unlock(&nbd_index_mutex);
>   		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
>   		       index);
> -		return -EINVAL;
> +		goto unlock_index;
>   	}
> -	if (!refcount_inc_not_zero(&nbd->refs)) {
> -		mutex_unlock(&nbd_index_mutex);
> +	mutex_lock(&nbd->config_lock);
> +	if (!refcount_inc_not_zero(&nbd->refs) || !nbd->recv_workq) {

We can't safely take the ->config_log if we don't have a ref.  Just add

if (nbd->recv_workq)
	flush_workqueue(nbd->recv_workq);

to nbd_disconnect_and_put().  Problem solved, we can't drop it until we drop our 
last config ref, and we're holding a config ref here.  We could probably add it 
in the meantime, but at this point we've disconnected all of our sockets so it 
doesn't matter.  Thanks,

Josef
