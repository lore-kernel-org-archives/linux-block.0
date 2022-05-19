Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05B3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 17:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiESRz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 13:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbiESRzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 13:55:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CD03A190
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 10:55:17 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d3so4145663ilr.10
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m8eq6dPWUoWeZS1L7nj7RcIbqUi0YUVwYlZrz6HT0go=;
        b=uOhwFDU9U3y2+r0pdUEQCp8Vo4e3bzsSgI3f9CRLmLTI+QLyzyypw0Zusk6bZREcon
         tFizgfwiBBAwU0TgSJIm82/pp8xlB6nCtUt7Fl93tLfdcbFy2KvWgbfXEPmqQ/zbIC7l
         jMrs3ikN6wAy27St9PEZefgiPVH1Bs98qW5I9KYHnezPuHsJUZbs7NNbT1hNWtkMlAW5
         dO/UwnVCnn6ZEYauC2RdcX9zCR4BpmHqNE7Z8c4LrJIharfm6EDYwa++6tVBqwl3Gvy4
         zQ+Srdx2gtQaRkIMj0mqDXu+eJnr6si4y/7PQkFb9iZX5MwQf7Q+lP5tz8A9+c0QveXP
         nqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m8eq6dPWUoWeZS1L7nj7RcIbqUi0YUVwYlZrz6HT0go=;
        b=hMELQAdxcy9LE+I6bqcutzhlWZC9m1AExtVn7qdHI4VPJ/ib1YyRMOsYQybCoKao14
         DMcbxZrnZGym2JV6m82RxMRcq6dG90B9li2jICA1BcMygTZzq2OHrCtiFtfaSPBPo7qZ
         JADWHnAiAE0ZAlKm1XkHUAq/v4Jia0A5qDUnAV3pxjqiQR20EMGUllAwdB4ZQIAAZUN5
         W43pW4RAV0r6PgXHLGP+Un2Nc0pVzZkj+xbXolnT5+JIiXYEwEKzXvkcCB5m9GzKu+tU
         oR8ccGwoCVz6J6MlycapH5VGRypJL+2T0QQjs6CdQE0Sz/QxUVm//610qtqMkCR4HzBi
         RCGA==
X-Gm-Message-State: AOAM530Or/oR0Kto82IJyQme5qP3lnG2YmttXvOStUkuC8fniQRmIMKm
        HMc4k3g3abwP6z4tTFpJ0E6T6Q==
X-Google-Smtp-Source: ABdhPJwa6aVQFkLlTNi1aQWv4SOYTcIHaKZtohX4UGWJLcs0j2xXt49h/1RxCRvR3WGv479fmq8XmQ==
X-Received: by 2002:a92:d149:0:b0:2d1:5bd:1ec2 with SMTP id t9-20020a92d149000000b002d105bd1ec2mr3401610ilg.100.1652982916874;
        Thu, 19 May 2022 10:55:16 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x17-20020a029711000000b0032e36d3843fsm77678jai.19.2022.05.19.10.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 10:55:16 -0700 (PDT)
Message-ID: <27cf9159-341a-5e26-fa72-fb3b07f4eb80@kernel.dk>
Date:   Thu, 19 May 2022 11:55:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [blk] 77c570a1ea: WARNING:at_block/blk-cgroup.c:#blkg_create
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        kernel test robot <oliver.sang@intel.com>,
        Fanjun Kong <bh1scw@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20220519070506.GA34017@xsang-OptiPlex-9020>
 <cb7d3a8a-c393-a691-4d20-2cfcbb075201@gnuweeb.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cb7d3a8a-c393-a691-4d20-2cfcbb075201@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 11:41 AM, Ammar Faizi wrote:
> 
> Adding the committer, reviewer and acker to the CC list. See the full message here:
> https://lore.kernel.org/all/20220519070506.GA34017@xsang-OptiPlex-9020/

This has been fixed:

https://lore.kernel.org/linux-block/52f2c742-9e64-63b0-25c3-8052f7e85883@kernel.dk/

-- 
Jens Axboe

