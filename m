Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D46C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62582084A
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 09:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfENJ1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 05:27:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfENJ1k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 05:27:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EA52AEAF;
        Tue, 14 May 2019 09:27:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 May 2019 11:27:38 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-block-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] io_uring: fix infinite wait in khread_park() on
 io_finish_async()
In-Reply-To: <18e65f75e5a3972bec42d830ac397501@suse.de>
References: <20190513182028.29912-1-rpenyaev@suse.de>
 <bcf3f935-e2c0-6bcf-92fb-760583ff5500@kernel.dk>
 <18e65f75e5a3972bec42d830ac397501@suse.de>
Message-ID: <849f15736e98ea04106924349260aa61@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-05-14 11:17, Roman Penyaev wrote:
> I see.  Do you think it makes sense to fix this is kthread?  With 
> something
> as the following:
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index be4e8795561a..191f8be5c9e0 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -472,6 +472,10 @@ void kthread_unpark(struct task_struct *k)
>  {
>         struct kthread *kthread = to_kthread(k);
> 
> +       if (!__kthread_should_park(k))
> +               /* Nop if thread was never parked */
> +               break;

return of course, not break.

--
Roman

