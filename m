Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E388AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C5D610C8
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhJUIox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhJUIov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 04:44:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA3C06174E;
        Thu, 21 Oct 2021 01:42:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g141so226442wmg.4;
        Thu, 21 Oct 2021 01:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rg3MoPfc/jIT72UkjhQ3bRSBD9WVLdMFqrLxascU6vE=;
        b=J8lx5GcNvpCfylAR36hKknuP17QJUlmSdSnGYy1KzOKQBxgLUVNRLBa4UfPVxM7hA+
         4kcnl6AWQAjpJL61GfSNKB2ZkJMuceRr3eXvH/Qt4hQg5z/5vrMh+3fZyiB6Kix8JcuX
         cQ4brh/u+yB2gHulg1ycGpr8ODuonI+stgtM0rhlIENaP5MwD4kPNOwYuZ1d0OWrQfLI
         UuOSH1H/7+wxHXYvUq1Yae57dcs/P8nllXDzUCjrwIKw+4n5AfEvMp654F/qOTeZsIQC
         cC5lpG5bR+DMsCS5sITfFqcbT8LqkNq9QWBb3KcxRf+o8s3qTPMTe3UpiNBVjAzD96sK
         yn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rg3MoPfc/jIT72UkjhQ3bRSBD9WVLdMFqrLxascU6vE=;
        b=48YeT3v2uppPk9S55PC/JPlEZQ/5mU6B7I3Ev6GviID2WbjAEqRCfb7a4D7t7xn2d2
         k4tz0n2Otl/uoX/h7ncQrg4Ain+JGBgeCZgrvO9T9zxNXZmHtMcL026j46S87r+2ziPj
         B4PbDp2xESR9MsLeHwuUFSP9BwQYXDUQAMYq8I81naLZV5BjgaBTOxP3J9lqJtuNnonJ
         fLHTD1cYfibPYHzQT1I1c055mZ6Api85aNrX4UBpaGuAKQpPoZcHexl8pw7rl+0cTY6g
         ES9Sg0+EoyUSNKAOl+hTCEeY9Ctn8S8grw6aZ9qFQ5vLNpWtwW3Ag7Vkcjls3PKZAPGN
         Rg2w==
X-Gm-Message-State: AOAM533x2wuyqZShbOsucBp988dRjBff2zwV6L84tKDsfECZVkeCdU+0
        ylxN0g3BSBdZ8oTJMmrf4dOLEvi+UJ030g==
X-Google-Smtp-Source: ABdhPJwrDBueRILuwGt/ztGEEyJ28Vx3A44WYepubYpl3y0FykK8FQCvAQjrxvBXWXQ4VJc90m0oAw==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr20354996wmf.61.1634805754314;
        Thu, 21 Oct 2021 01:42:34 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id p18sm4790076wmq.4.2021.10.21.01.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:42:34 -0700 (PDT)
Message-ID: <e7319f50-999b-2540-62f1-201afcb29bf3@gmail.com>
Date:   Thu, 21 Oct 2021 09:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] percpu_ref: percpu_ref_tryget_live() version holding
 RCU
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>
References: <cover.1634759754.git.asml.silence@gmail.com>
 <d65d6d60faf773293e5189bd2b95c7bbc034976b.1634759754.git.asml.silence@gmail.com>
 <YXB3n2pxiKYbd2Il@slm.duckdns.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YXB3n2pxiKYbd2Il@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 21:10, Tejun Heo wrote:
> On Wed, Oct 20, 2021 at 09:03:18PM +0100, Pavel Begunkov wrote:
>> +/**
>> + * percpu_ref_tryget_live_rcu - same as percpu_ref_tryget_live() but the
>> + * caller is responsible for taking RCU.
>> + *
>> + * This function is safe to call as long as @ref is between init and exit.
>> + */
>> +static inline bool percpu_ref_tryget_live_rcu(struct percpu_ref *ref)
>> +{
>> +	unsigned long __percpu *percpu_count;
>> +	bool ret = false;
>> +
>> +	if (likely(__ref_is_percpu(ref, &percpu_count))) {
>> +		this_cpu_inc(*percpu_count);
>> +		ret = true;
>> +	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
>> +		ret = atomic_long_inc_not_zero(&ref->data->count);
>> +	}
>> +	return ret;
>> +}
> 
> Can we please add rcu_read_lock_held() assertion? Other than that, looks
> fine to me.

Will add, thanks

-- 
Pavel Begunkov
