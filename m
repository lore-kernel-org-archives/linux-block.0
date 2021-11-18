Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F5BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9061548
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 14:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhKROye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 09:54:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:50512 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKROye (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 09:54:34 -0500
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AIEpOaQ071203;
        Thu, 18 Nov 2021 23:51:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Thu, 18 Nov 2021 23:51:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AIEpNxM071200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Nov 2021 23:51:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <1ebd5c91-442c-1ab0-f71f-0feff04e37f5@i-love.sakura.ne.jp>
Date:   Thu, 18 Nov 2021 23:51:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] loop: mask loop_control_ioctl parameter only as minor
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, wangyangbo <yangbonis@icloud.com>,
        axboe@kernel.dk
References: <20211118023640.32559-1-yangbonis@icloud.com>
 <c685d6dc-3918-6ee5-df59-f2d814635228@I-love.SAKURA.ne.jp>
In-Reply-To: <c685d6dc-3918-6ee5-df59-f2d814635228@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/18 23:15, Tetsuo Handa wrote:
> On 2021/11/18 11:36, wangyangbo wrote:
>> @@ -2170,11 +2170,11 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>>  {
>>  	switch (cmd) {
>>  	case LOOP_CTL_ADD:
>> -		return loop_add(parm);
>> +		return loop_add(MINOR(parm));
> 
> Better to return -EINVAL or something if out of minor range?

Well, this is not specific to loop devices.
Shouldn't the minor range be checked by device_add_disk() ?
