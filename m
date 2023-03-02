Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A68C7EE30
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 20:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCBUc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCBUcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 15:32:14 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F759401;
        Thu,  2 Mar 2023 12:31:14 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so3991325pjg.4;
        Thu, 02 Mar 2023 12:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWCN7inZP0TRGmA/GhTlkv0mfyiqej/kk0d66K5ZY/U=;
        b=PfBNcboDPymSnSduvPacoCQBnLM5OptMgGdqXuOgTC+qCv2n5cadssPthdwKmRx8sI
         OIMDgBlBBFKdtZdVAIAf8fnfAGzEwPmlKqRmy1zBkFx9Mc1Qy2IJfe2BKFjh/h0Yz+0N
         PYAgmXU0fbjvBa7Tpg2in4T1fSdFImlge8k/wbnq7KDeJBT4nG2eebBN8Mm0h4OwiU+P
         JkQIo0whL9p5Db7dX5fBhMFprRlA/OOyWxR0w2po0evT+0RxzViZcjUskBY399TH7D0y
         wtiO2W64zQMTgDIa0+kaHXOsygYnIwte7NfME4u4ALi01p3fIGLm9QeXwdaT7symJX6F
         E5jg==
X-Gm-Message-State: AO0yUKXiaCvCJUIpV4L+TQEABUqYdIZxwJOi1F48GXPF/nykUtTK3XM8
        yn92zc1unh75fssfFZuC3EE=
X-Google-Smtp-Source: AK7set/dzwMgUfMZCmT4k38vnVXEQEHngPvINzs7z28UQPic1vLaGzHuZP18iMftRf0DEt05tt9bzA==
X-Received: by 2002:a05:6a21:7881:b0:bf:8a97:6e48 with SMTP id bf1-20020a056a21788100b000bf8a976e48mr13727498pzc.37.1677789051377;
        Thu, 02 Mar 2023 12:30:51 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:30f3:595a:48e5:cb41? ([2620:15c:211:201:30f3:595a:48e5:cb41])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b005e00086250asm100939pfo.125.2023.03.02.12.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 12:30:50 -0800 (PST)
Message-ID: <cd00d1bc-3646-a465-920a-110b80cb887c@acm.org>
Date:   Thu, 2 Mar 2023 12:30:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y/7L74P6jSWwOvWt@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/23 19:52, Theodore Ts'o wrote:
> Unfortunately most common storage devices have
> not supported write hints, and support for write hints were ripped out
> last year.

Work is ongoing in T10 to add write hint support to SBC. We plan to 
propose to restore write hint support after there is agreement in T10 
about the approach. See also "Constrained SBC-5 Streams" 
(http://www.t10.org/cgi-bin/ac.pl?t=d&f=23-024r0.pdf). This proposal has 
been uploaded yesterday.

Bart.

