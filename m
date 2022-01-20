Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E038C433F5
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 10:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiATKJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 05:09:42 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55629 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiATKJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 05:09:42 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20KA9W74058705;
        Thu, 20 Jan 2022 19:09:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 20 Jan 2022 19:09:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20KA9VoH058702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Jan 2022 19:09:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1ae05b2c-1ccf-2e31-4cc9-f89c54486bff@I-love.SAKURA.ne.jp>
Date:   Thu, 20 Jan 2022 19:09:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Racy loop device reuse logic
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>, Jan Kara <jack@suse.cz>
Cc:     util-linux@vger.kernel.org, linux-block@vger.kernel.org
References: <20220113154735.hdzi4cqsz5jt6asp@quack3.lan>
 <20220119085247.duhblxzp6joukarw@quack3.lan>
 <28a360a3-b559-24ec-6c3d-3fe6e8302393@I-love.SAKURA.ne.jp>
 <20220119213415.csieaktdqmshemiy@quack3.lan>
 <20220120085009.xecitkc7f2digut6@ws.net.home>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220120085009.xecitkc7f2digut6@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/20 17:50, Karel Zak wrote:
> On Wed, Jan 19, 2022 at 10:34:15PM +0100, Jan Kara wrote:
>> On Wed 19-01-22 20:30:52, Tetsuo Handa wrote:
>>> I found a way to avoid this race by splitting lo_open() into two phases
>>> using task_work_add().  Christoph Hellwig is trying to take a look at
>>> https://lkml.kernel.org/r/f6b947d0-1047-66b3-0243-af5017c9ab55@I-love.SAKURA.ne.jp
>>> .
>>
>> No, you have found a way to make the race window for mount(8) smaller. And
>> I still disagree with that kernel change because it is making kernel more
>> complex only to make the race window smaller. On another machine or with
>> different scheduling decisions, you can still hit this race. This problem
>> must be fixed in mount...
> 
> +1
> 
> I think Jan is right. In this case mount(8) is not robust enough. It
> reads info about the device from /sys and then it opens the device.
> Unfortunately, whatever can happen before the open() call.
> 

I'm not objecting to fix /bin/mount itself. Please check
[PATCH 4/4] loop: wait for __loop_clr_fd() to complete upon lo_open()
in https://lkml.kernel.org/r/cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp .

  /bin/mount needs to be updated to check ioctl(LOOP_GET_STATUS) after open()
  in order to confirm that lo->lo_state remains Lo_bound. But we need some
  migration period for allowing users to update their util-linux package.
  Thus, meantime emulate serialization between lo_open() and lo_release()
  without using disk->open_mutex.

