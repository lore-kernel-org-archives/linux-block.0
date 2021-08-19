Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D8C4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1B61131
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 14:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhHSOsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:48:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60169 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhHSOsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 10:48:11 -0400
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17JEl70b093940;
        Thu, 19 Aug 2021 23:47:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 19 Aug 2021 23:47:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17JEl7Sw093937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Aug 2021 23:47:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <20210818134752.GA7453@lst.de>
 <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
 <YR0cGE1sgS8+UhXV@kroah.com>
 <a6fee3cb-6e5b-bc91-415d-2b100a1d7c83@i-love.sakura.ne.jp>
 <20210819091608.GA12883@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <34f51acb-97db-4a93-5831-f52777eacbb1@i-love.sakura.ne.jp>
Date:   Thu, 19 Aug 2021 23:47:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819091608.GA12883@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/19 18:16, Christoph Hellwig wrote:
> On Wed, Aug 18, 2021 at 11:51:24PM +0900, Tetsuo Handa wrote:
>> The loop module is one of critical components for syzkaller fuzzing.
>> Bugs which involves the loop module prevents syzkaller from finding/testing
>> other bugs. But changes are continuously applied without careful review.
>> Therefore, the changes and code are not getting correct. Stable work cannot
>> come afterwards...
> 
> I know a very simple solution: review them and provide detailed feedback.
> It's not like patches just appear in a tree somewhere.
> 

You don't know, and nobody knows, a simple solution that can apply to my case:

  I'm not your exclusive reviewer, and I'm not familiar with the block layer.
  Actually, I'm not a developer living in block layer, and I'm not subscribed
  to linux-block mailing list. I check bugs reported by syzbot, and analyze
  and try to write patches. I can't afford monitoring patches of all mailing
  lists.

  In order words, I can't review your patches and can't provide detailed feedback
  (unless you cc me with detailed explanation of why it is safe to make such change).

Bugs are merged everywhere but I can't prevent bugs from getting merged. I monitor
bugs reported by syzbot. It is exactly like patches just appear in a tree somewhere.

