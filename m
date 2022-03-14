Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EEEC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 09:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiCNJ5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCNJ5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 05:57:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092834B98
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 02:55:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t22so1828037plo.0
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gNT8l/5DJR/KFmEDvTGTz/MWUJ9Ykrp+Vhri+d4qxt0=;
        b=BGWUEoW7LQv4eGN4gJ3VPhS8/fgozF1RE3vAC3mQERlERaUKOaDAY6YVARC7Fl58fr
         lKTooSvsP/Iyu9WGT/DVJicu6MQrbTF/aAflM9f1ilO8+kC45oa3auoT94NcmXiFKJa+
         yQShywR99235ZCmXO6PFfSSEmhNTGyVm4kVGSHP+cV/4h1Wc+soxIJDNY85qqf5wKJhQ
         D0yxBkVRuWFGztkdXpdEpk5D/os1Q+TxHq0LdbSdDWSeIjaxRL1IF06lTTOqLo1op1xo
         zsobFWRtSeyLRD8QXRO6aOqiw8ET502Opb8Ezq4LbSQWOyhhOE/3l18lJU5WBD+bT4/8
         MF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gNT8l/5DJR/KFmEDvTGTz/MWUJ9Ykrp+Vhri+d4qxt0=;
        b=qEccHX7X7LmHzXr4S8cue2u1IM1LuktUgnxOI6m84gHQfLgqtkiru1GzxTDeKBrxWp
         JEAekD3g3f7xd4gfFfatm1yEcSa1OQQMtr+8qasNDGLCwYlTmasrRoeQFVR+/29j4IqF
         bAwbNXJY+AhiwIqDA19LvD/9gFY+3gV5yMZAPz8S9cqVy8aeJ6oEtxKFSw/dc+mKB8Jz
         XoHB8/T1h29bH2tCB3/ztoeN2A+Vhh36uX1xgaGsEKKWnb20OF5k9aP6RLtZqLU8bgZ7
         7qpZCeRykI7H93XiwD4WugycxJgER5kpudYXkzK5X5IBcVr0WXGbZzjPTwOqb4RSCPwX
         fEYg==
X-Gm-Message-State: AOAM532G39xKeJuXzavGOjNSWm9Hqn0aqDn10EYb1m+iflI4pyOWimoC
        WQrRtxNME19qM9n450d/DQ0=
X-Google-Smtp-Source: ABdhPJxSbkUcrfythTFLpiGJaKbQctzgHtPt/TUSphf0qDLo9O7QyPYNcS/QFBWdmfE2Y3bCNDnf/A==
X-Received: by 2002:a17:902:8a91:b0:14f:969b:f6be with SMTP id p17-20020a1709028a9100b0014f969bf6bemr22772487plo.161.1647251753534;
        Mon, 14 Mar 2022 02:55:53 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a0022d500b004f7a420c330sm8699242pfj.12.2022.03.14.02.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 02:55:53 -0700 (PDT)
Date:   Mon, 14 Mar 2022 18:55:48 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, suwan027.kim@gmail.com
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <Yi8RJHO4XDDKYHAF@localhost.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <c851906c-c619-4e87-3272-9c41ac256052@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c851906c-c619-4e87-3272-9c41ac256052@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 13, 2022 at 12:42:58PM +0200, Max Gurtovoy wrote:
> 
> On 3/11/2022 5:28 PM, Suwan Kim wrote:
> > This patch supports polling I/O via virtio-blk driver. Polling
> > feature is enabled based on "VIRTIO_BLK_F_MQ" feature and the number
> > of polling queues can be set by QEMU virtio-blk-pci property
> > "num-poll-queues=N". This patch improves the polling I/O throughput
> > and latency.
> > 
> > The virtio-blk driver doesn't not have a poll function and a poll
> > queue and it has been operating in interrupt driven method even if
> > the polling function is called in the upper layer.
> > 
> > virtio-blk polling is implemented upon 'batched completion' of block
> > layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> > and later, virtblk_complete_batch() calls unmap function and ends
> > the requests in batch.
> 
> Maybe we can do the batch in separate commit ?
> 
> For implementing batch in the right way you need to implement .queue_rqs
> call back.
> 
> See NVMe PCI driver implementation.
> 
> If we're here, I would really like to see an implementation of
> blk_mq_ops.timeout callback in virtio-blk.
> 
> I think it will take this driver to the next level.

Thanks for the feedback. I will implement .queue_rqs for virtio-blk
and make a seperate commit. Later, I will try to implement
blk_mq_ops.timeout as you mentioned.

I will send the patch series soon as below.
[1] support .queue_rqs for batch submission
[2] support polling I/O

Regards,
Suwan Kim
