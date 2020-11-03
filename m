Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55C7C2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE5A221FB
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="D4UHq7dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKCRAR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCRAR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Nov 2020 12:00:17 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB4BC0613D1
        for <linux-block@vger.kernel.org>; Tue,  3 Nov 2020 09:00:17 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id r7so15331801qkf.3
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2020 09:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iJnXv0Jwsde3O3oEWNodcFfjp3Bap9KYUTkDBs3BMm0=;
        b=D4UHq7dLxqxZPGPF4a1OIPwJgR0uIzYcvluQp4XvV0FzTFyksROTOKJpc6qaXYhLFc
         qmpB2ds0DhSU6/KtQDvLlPQA+eCXFGODr/5YKHk/qnQfYTudoc2c+DheZN/SRB5XDx6j
         QMSbQZnj8/wHWfVjAx1sineN5hsemvoXOkQG7p1MR8Ht/1+zlud2YClr+RXr3AoWEoie
         S7n2w7kwXSV8/khx9S6l6aNlrCo+ULqtBEAHcSEP2P3Yz4Qcr6V1ysPbSvquk60+EB9O
         DbKSIrsG3Fj+1yFjshbMRRPVVbaVWp+0US3jSJ6XtcEMlDeLCpINKw31tMiUUw8oEXpM
         I2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJnXv0Jwsde3O3oEWNodcFfjp3Bap9KYUTkDBs3BMm0=;
        b=hC//hofEVZJ6rQdhGwXxWtpq68aQ+6q/n2l5sMgXh1aze5oZqOtO5EDUcpC1xbr8mr
         wElTakk8Iib1tkLitcOdO16LhzWvBiY/IwFB+7yuagYswOf5XHwR4qWglIqnMxjhCGZR
         2/SGFd4CSkLhm3yiG3UuLnOsMNLNliozm9+PCduDVZRnwfjEHZdhWAROFnh5WwQxjv8V
         gDHwQ+aBKnnlT3uGzySYJkHLldNxlJ1unyOmL1amGoT+dZ4TXgKOSbEZXgwjtoHpUlay
         lAfahEwcXdNT96PLEo5JrERU464zsyp4jQYajSGsi5/mCFYOjkrnktmxCZp218XyfIvg
         1tvg==
X-Gm-Message-State: AOAM533+tArOvSwgXXoPEtnMwLQi4Xyx64GXFovp0pqMe6k6fpSt86FH
        YOfU7GWgOQbxG0DktXclt7MPSQ==
X-Google-Smtp-Source: ABdhPJwAwCU/5gO8d+oZYH0SPZMfkPh33C5GKc45Ey5VvNsZuUiWAAGxk+YXFLHzVqAd2/ecZi1VeQ==
X-Received: by 2002:a05:620a:142d:: with SMTP id k13mr20542471qkj.315.1604422814000;
        Tue, 03 Nov 2020 09:00:14 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 68sm10586801qkg.108.2020.11.03.09.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 09:00:13 -0800 (PST)
Subject: Re: [PATCH v3 1/2] nbd: fix use-after-freed crash for nbd->recv_workq
To:     xiubli@redhat.com, axboe@kernel.dk, ming.lei@redhat.com
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de
References: <20201103065156.342756-1-xiubli@redhat.com>
 <20201103065156.342756-2-xiubli@redhat.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f14ee0ba-df7c-4891-7fb9-00c003a0065a@toxicpanda.com>
Date:   Tue, 3 Nov 2020 12:00:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103065156.342756-2-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/20 1:51 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> The crash call trace:
> 
> <6>[ 1012.319386] block nbd1: NBD_DISCONNECT
> <1>[ 1012.319437] BUG: kernel NULL pointer dereference, address: 0000000000000020
> <1>[ 1012.319439] #PF: supervisor write access in kernel mode
> <1>[ 1012.319441] #PF: error_code(0x0002) - not-present page
> <6>[ 1012.319442] PGD 0 P4D 0
> <4>[ 1012.319448] Oops: 0002 [#1] SMP NOPTI
> <4>[ 1012.319454] CPU: 9 PID: 25111 Comm: rbd-nbd Tainted: G            E     5.9.0+ #6
>     [...]
> <4>[ 1012.319505] PKRU: 55555554
> <4>[ 1012.319506] Call Trace:
> <4>[ 1012.319560]  flush_workqueue+0x81/0x440
> <4>[ 1012.319598]  nbd_disconnect_and_put+0x50/0x70 [nbd]
> <4>[ 1012.319607]  nbd_genl_disconnect+0xc7/0x170 [nbd]
> <4>[ 1012.319627]  genl_rcv_msg+0x1dd/0x2f9
> <4>[ 1012.319642]  ? genl_start+0x140/0x140
> <4>[ 1012.319644]  netlink_rcv_skb+0x49/0x110
> <4>[ 1012.319649]  genl_rcv+0x24/0x40
> <4>[ 1012.319651]  netlink_unicast+0x1a5/0x280
> <4>[ 1012.319653]  netlink_sendmsg+0x23d/0x470
> <4>[ 1012.319667]  sock_sendmsg+0x5b/0x60
> <4>[ 1012.319676]  ____sys_sendmsg+0x1ef/0x260
> <4>[ 1012.319679]  ? copy_msghdr_from_user+0x5c/0x90
> <4>[ 1012.319680]  ? ____sys_recvmsg+0xa5/0x180
> <4>[ 1012.319682]  ___sys_sendmsg+0x7c/0xc0
> <4>[ 1012.319683]  ? copy_msghdr_from_user+0x5c/0x90
> <4>[ 1012.319685]  ? ___sys_recvmsg+0x89/0xc0
> <4>[ 1012.319692]  ? __wake_up_common_lock+0x87/0xc0
> <4>[ 1012.319715]  ? __check_object_size+0x46/0x173
> <4>[ 1012.319727]  ? _copy_to_user+0x22/0x30
> <4>[ 1012.319729]  ? move_addr_to_user+0xc3/0x100
> <4>[ 1012.319731]  __sys_sendmsg+0x57/0xa0
> <4>[ 1012.319744]  do_syscall_64+0x33/0x40
> <4>[ 1012.319760]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[ 1012.319780] RIP: 0033:0x7f5baa8e3ad5
> 
> In case the reference of nbd->config has reached zero and the
> related resource has been released, if another process tries to
> send the DISCONENCT cmd by using the netlink, it will potentially
> crash like this.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
