Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7525C5AC81
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9550A2086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfARRio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:38:44 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38586 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfARRin (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 12:38:43 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id B770B13F861;
        Fri, 18 Jan 2019 18:38:16 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>, Jens Axboe <axboe@kernel.dk>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2f64f6b8-2941-f2f1-a91a-889668ae5db2@free.fr>
Date:   Fri, 18 Jan 2019 18:38:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/01/2019 16:18, jianchao.wang wrote:

> It looks like the blk_mq_run_work_fn went to sleep with rcu lock (preempt), isn't it ?
> Can you share the symbol of the following address ?

Note: if I boot with 'nosmp', then the system reboots without logging anything.
(Perhaps some kind of HW watchdog, or secure OS)

I no longer get the 'rcu_preempt detected stalls' message...

Regards.
