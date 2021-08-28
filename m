Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F16C432BE
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE84A60EDF
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhH1NvN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Aug 2021 09:51:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58327 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhH1NvN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Aug 2021 09:51:13 -0400
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17SDo620018918;
        Sat, 28 Aug 2021 22:50:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 28 Aug 2021 22:50:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17SDo570018911
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 28 Aug 2021 22:50:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
 <20210827184302.GA29967@lst.de>
 <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
 <20210828071832.GA31755@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c5e509ec-2361-af25-ec73-e033b5b46ebb@i-love.sakura.ne.jp>
Date:   Sat, 28 Aug 2021 22:50:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210828071832.GA31755@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/28 16:18, Christoph Hellwig wrote:
> On Sat, Aug 28, 2021 at 10:10:36AM +0900, Tetsuo Handa wrote:
>> That is, it seems that unregister_transfer_cb() is there in case forced module
>> unload of cryptoloop module was requested. And in that case, there is no point
>> with crashing the kernel via panic_on_warn == 1 && WARN_ON_ONCE(). Simple printk()
>> will be sufficient.
> 
> If we have that case for forced module unload a WARN_ON is the right thing.
> That being said we can simply do the cmpxchg based protection for that
> case as well if you want to keep it.  That will lead to a spurious
> loop remove failure with -EBUSY when a concurrent force module removal
> for cryptoloop is happening, but if you do something like that you get
> to keep the pieces.

Oh, given that commit 222013f9ac30b9ce ("cryptoloop: add a deprecation warning") was
already merged into linux.git , there is no point with worrying about forced module
unloading. Then, I would warn like

+#ifdef CONFIG_MODULE_UNLOAD
+       if (module_refcount(xfer->owner) != -1)
+               pr_err("Unregistering a transfer function in use. Expect kernel crashes.\n");
+#endif

than

+	idr_for_each_entry(&loop_index_idr, lo, id)
+		WARN_ON_ONCE(lo->lo_encryption == xfer);

in your patch.
(Actually, nobody calls loop_unregister_transfer() if CONFIG_MODULE_UNLOAD=n ...)

Then, your atomic_cmpxchg(&lo->idr_visible, 1, 0) == 0 approach will be OK
(I would use

+	atomic_set(&lo->idr_visible, 1);

than

+	atomic_inc(&lo->idr_visible);

because it is "Show this loop device again.").
