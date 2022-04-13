Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0199C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 05:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiDMFd0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMFdZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 01:33:25 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE23054E
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 22:31:03 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23D5UswY018396;
        Wed, 13 Apr 2022 14:30:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Wed, 13 Apr 2022 14:30:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23D5UoD0018301
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Apr 2022 14:30:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7adb8272-6836-77f6-70c8-6fbd180c0e2e@I-love.SAKURA.ne.jp>
Date:   Wed, 13 Apr 2022 14:30:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] block/rnbd: client: avoid flush_workqueue(system_long_wq)
 usage
Content-Language: en-US
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
References: <becb2389-e249-0aa2-7701-2c02155aedf2@I-love.SAKURA.ne.jp>
 <55006f3b-9571-9167-eaf0-6a2caec747ad@I-love.SAKURA.ne.jp>
 <CAMGffEnXi8AiC2rqZaHER1rrcsCPR0UNocKyxr9H6hXRwjj4MQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAMGffEnXi8AiC2rqZaHER1rrcsCPR0UNocKyxr9H6hXRwjj4MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/04/13 14:21, Jinpu Wang wrote:
> I feel the simple approach is to replace the global system_long_wq
> with a local workqueue for rnbd_client.

OK. Please post a patch.
