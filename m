Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2C2C3DA7A
	for <linux-block@archiver.kernel.org>; Mon,  2 Jan 2023 16:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjABQxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Jan 2023 11:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjABQxi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jan 2023 11:53:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC61E02
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 08:53:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b2so30026940pld.7
        for <linux-block@vger.kernel.org>; Mon, 02 Jan 2023 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/cxfl/LR9GgO9ZvS/ZvJXYf6jxwd1F3cUMP6lmAYpI=;
        b=mmntdGgr7TfOTVqLvYs4G7k/SpKn+gpvtuPloVB2LEPAIA+WeUZgVv1UjLHQFhAj6O
         aQG7pGbwezQRE2dvn/5uJuKj3TNPdQz9AvtTKU1+w/2xP2EX+l+22ByQGP8K8rF7Bohc
         KXSzXT3cCYHoRTiyB89cG7QRHYY94dWjERbfKCB1t9VnhudXvC7ZAwcSI/9T0M44wjwi
         Ky1fjOjgleVLQxUHdP7DUpxdtqnzCvEXDa7Lk7YRrH5id+eeKzA+C3CCna96yQX8hEVQ
         m+9m4uReFdr62USHq4yMpdQRaQadH8nWpCDquQ+OGt7CZdDW/z/zoF17/hK/lblsTiQa
         9f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/cxfl/LR9GgO9ZvS/ZvJXYf6jxwd1F3cUMP6lmAYpI=;
        b=5552uCKgIFeig85aIh4bKgQ19wcKIrZMLgg0os8tPDiv+m+iG/z4ckvFNV+PpgczkC
         FzIBBUXv76PnvWrHPk30hwWbteZQrIdAkQvvakNcSHw3mwnXuVPVw2nXTWKUn576UHNf
         bZ9vmBxZdF3dmaF3icZ0lDXwoHRuWbQ/VaQV8v+RIwVN3tKp+nZNo92sqtNRwkaNNs4a
         Qp/qpZJrGuRZ7WF0gdSZlX3KhffDaE5fAhA9aW4tX+GOqj88nq785rXDQFNeDmoakyKr
         AUD2f2ThsT3lG3zJSI1dFqo9FkwricIRDAQG6PF6FnD7nwdZZSjFd0CPIoIdH6Q2k7aW
         A/RA==
X-Gm-Message-State: AFqh2koXwhhlV44Fhbt6Dl5lnvgLCqIMJ+UdlcmX9KUCUaz5un9ZfOCU
        PcL50AKDnH+GXaQh6mOb75po+dO/SLIcjVbW
X-Google-Smtp-Source: AMrXdXuDyzl3mRGjAOUDPdqwWXpAqM8HKZ629fDDGtE4QLCE/aeGvJpusjDyAqhHyPpCbS6gvzZQkw==
X-Received: by 2002:a05:6a21:398b:b0:ab:9997:8ee2 with SMTP id ad11-20020a056a21398b00b000ab99978ee2mr12332900pzc.6.1672678416492;
        Mon, 02 Jan 2023 08:53:36 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v63-20020a626142000000b005828071bf7asm1924910pfb.22.2023.01.02.08.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:53:35 -0800 (PST)
Message-ID: <9a01e386-0fb5-b074-a7b1-7e4bcf1ca204@kernel.dk>
Date:   Mon, 2 Jan 2023 09:53:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V13 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com
References: <20221229203707.68458-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221229203707.68458-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/29/22 1:36 PM, Paolo Valente wrote:
> Hi,
> here is the V13, it differs from V12 in that it applies the
> recommendation by Damien in [2].

This doesn't apply to current master. Can you send one that
does?

-- 
Jens Axboe


