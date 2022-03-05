Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBFAC433F5
	for <linux-block@archiver.kernel.org>; Sat,  5 Mar 2022 07:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiCEHid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Mar 2022 02:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiCEHic (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Mar 2022 02:38:32 -0500
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 23:37:41 PST
Received: from mail-m2836.qiye.163.com (mail-m2836.qiye.163.com [103.74.28.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9212898A
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 23:37:38 -0800 (PST)
Received: from [192.168.122.37] (unknown [218.94.118.90])
        by mail-m2836.qiye.163.com (Hmail) with ESMTPA id 5CF6CC00F5;
        Sat,  5 Mar 2022 15:29:33 +0800 (CST)
Message-ID: <bdff8d00-c936-72df-cac1-3c1d3131339f@easystack.cn>
Date:   Sat, 5 Mar 2022 15:29:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
From:   Dongsheng Yang <dongsheng.yang@easystack.cn>
In-Reply-To: <87tucsf0sr.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlCN1dZLVlBSVdZDwkaFQgSH1lBWUIZTkJWSEpDSUhLHU4YH0
        8dVRkRExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6SAw6FDI6DUMQPhwwFQIJ
        MBUaCwFVSlVKTU9NT01OSExITUxLVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
        V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSE9LSzcG
X-HM-Tid: 0a7f58fbd52e841ekuqw5cf6cc00f5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Gabriel,
     There is a project implement userspace block device: 
https://github.com/ubbd/ubbd

ubbd means Userspace Backend Block Device (as ubd was taken by UML block 
device.)

It has a kernel module ubbd.ko, userspace daemon ubbdd, and a tool ubbdadm.
(1) ubbd.ko depends on uio, providing cmd ring and complete ring.
(2) ubbdd implement different backends, currently file and rbd is done.
and ubbdd is designed for online restart. That means you can restart 
ubbdd with IO inflight.
(3) ubbdadm is an admin tool, providing map, unmap and config.

This project is under developing stage, but it is already tested by 
blktests and xfstests.

Also, there is some testing for rbd backend to compare performance with 
librbd and krbd.

You can find more information about it in github, if you are interested 
in it.

Thanx

在 2022/2/22 星期二 上午 3:59, Gabriel Krisman Bertazi 写道:
> I'd like to discuss an interface to implement user space block devices,
> while avoiding local network NBD solutions.  There has been reiterated
> interest in the topic, both from researchers [1] and from the community,
> including a proposed session in LSFMM2018 [2] (though I don't think it
> happened).
> 
> I've been working on top of the Google iblock implementation to find
> something upstreamable and would like to present my design and gather
> feedback on some points, in particular zero-copy and overall user space
> interface.
> 
> The design I'm pending towards uses special fds opened by the driver to
> transfer data to/from the block driver, preferably through direct
> splicing as much as possible, to keep data only in kernel space.  This
> is because, in my use case, the driver usually only manipulates
> metadata, while data is forwarded directly through the network, or
> similar. It would be neat if we can leverage the existing
> splice/copy_file_range syscalls such that we don't ever need to bring
> disk data to user space, if we can avoid it.  I've also experimented
> with regular pipes, But I found no way around keeping a lot of pipes
> opened, one for each possible command 'slot'.
> 
> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> 
