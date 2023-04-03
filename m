Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE8C76196
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 01:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDCBMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Apr 2023 21:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDCBMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Apr 2023 21:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BD6A5F7
        for <linux-block@vger.kernel.org>; Sun,  2 Apr 2023 18:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680484288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQE8Zgt4vs0BP5OpIWmWFH54NBQOZeUZ1VG+31AaATI=;
        b=V0zlXHU48dHE0HZ66hFaVwP0cRSS8395Q6BdWMx61na54IRTwjGtEIuUrleryVolIleZ9X
        Von13numZUOTe9mUcDuvGPjzV3gsxheiQ+nMof7+X4KW+szIajZ/2z9LveIwv2b6et2zXm
        gQ25ramO2YOYjOz4m1b0ea0P5HcRPHI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-uKq9kBVwPJGFRqjSzmVk-w-1; Sun, 02 Apr 2023 21:11:25 -0400
X-MC-Unique: uKq9kBVwPJGFRqjSzmVk-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 903203804507;
        Mon,  3 Apr 2023 01:11:24 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28F762166B3F;
        Mon,  3 Apr 2023 01:11:16 +0000 (UTC)
Date:   Mon, 3 Apr 2023 09:11:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>, ming.lei@redhat.com
Subject: Re: [PATCH V6 00/17] io_uring/ublk: add generic IORING_OP_FUSED_CMD
Message-ID: <ZConr0f8e/mEL0Cl@ovpn-8-18.pek2.redhat.com>
References: <20230330113630.1388860-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330113630.1388860-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 30, 2023 at 07:36:13PM +0800, Ming Lei wrote:
> Hello Jens and Guys,
> 
> Add generic fused command, which can include one primary command and multiple
> secondary requests. This command provides one safe way to share resource between
> primary command and secondary requests, and primary command is always
> completed after all secondary requests are done, and resource lifetime
> is bound with primary command.
> 
> With this way, it is easy to support zero copy for ublk/fuse device, and
> there could be more potential use cases, such as offloading complicated logic
> into userspace, or decouple kernel subsystems.
> 
> Follows ublksrv code, which implements zero copy for loop, nbd and
> qcow2 targets with fused command:
> 
> https://github.com/ming1/ubdsrv/tree/fused-cmd-zc-for-v6
> 
> All three(loop, nbd and qcow2) ublk targets have supported zero copy by passing:
> 
> 	ublk add -t [loop|nbd|qcow2] -z .... 
> 
> Also add liburing test case for covering fused command based on miniublk
> of blktest.
> 
> https://github.com/ming1/liburing/tree/fused_cmd_miniublk_for_v6
> 
> Performance improvement is obvious on memory bandwidth related workloads,
> such as, 1~2X improvement on 64K/512K BS IO test on loop with ramfs backing file.
> ublk-null shows 5X IOPS improvement on big BS test when the copy is avoided.
> 
> Please review and consider for v6.4.
> 
> V6:
> 	- re-design fused command, and make it more generic, moving sharing buffer
> 	as one plugin of fused command, so in future we can implement more plugins
> 	- document potential other use cases of fused command
> 	- drop support for builtin secondary sqe in SQE128, so all secondary
> 	  requests has standalone SQE
> 	- make fused command as one feature
> 	- cleanup & improve naming

Hi Jens,

Can you apply ublk cleanup patches 7~11 on for-6.4? For others, we may
delay to 6.5, and I am looking at other approach too.


Thanks,
Ming

