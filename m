Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A280C77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbjELPJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbjELPJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:09:29 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA40D064
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-760dff4b701so59895339f.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683904165; x=1686496165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6Kb7yZjmJ5yxlvZEPRG52JYAHhDFh9h2lYypPPkqcw=;
        b=Sq3IszFbAfr0dBcFeQc+ndjqWUOfTGuPgRYKpnCQs2Ej8nCJamegrISypbevzvBgwk
         lGzrg5Wc+JXqST9u0gqSmlUWPSy8m185ntWd1ZskhZWfmG7fm22e+LFmAnVmJZ+EaWBN
         yYCis/m7n9G6CXW+R99sSg0nvFM9QK6LKVoqEIuQIInkOdMZgztt43nZfAqelN1HQ8JN
         0Z7D+o4dUFlj2LCZK5FZ1Ug2ehwR9lj+MhCVIxOnn/PYrfEF83UqJLsM4OQCtiSzoVfX
         TGLPEUpWBF4xwdvSrWgTn7Nl/H/LzPOXaCIzv47rkIc7hBieME+ezWv9J/G7shyqidcD
         CY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904165; x=1686496165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6Kb7yZjmJ5yxlvZEPRG52JYAHhDFh9h2lYypPPkqcw=;
        b=R3EALmzdX2zOdjPjiq4e1eFBi6h+ojFFbSiAOJWYz6tsm823WpNZH7oI+mL42X3MsY
         jnF/alYGzGRDT+S1iGD+kFkBIjfnh13KJ1h+G41q4EUKY8gQgz0GXIoo7k0xChsIqXS9
         hFCS2Rkf+gdixxY/LHBmUUkxGhYTEIuT03Ge2+0N9HAej430QQCAvikmjfA/GXPJRlTv
         TPjxXeJoFoXIpkP9nZ4R81A+/2FKXYe7V6N7hF7p7Db5gPkfSkMEmPhRayOQxM3d7l0+
         F5rYIGSTDMmqDAzgF3mhUKoym5VfoQUiYMXEJreIcE49Fw/WPXvNyCF+WIfYQB4qpVlB
         JcxQ==
X-Gm-Message-State: AC+VfDyoBzt51004IfXU6jAwlIJ0+M+5sr0wxDM9R5/knyQsFdt/E0DE
        wbwlAik5OEyekaUgQRKpiA29mPeXkOLHXMN8v2U=
X-Google-Smtp-Source: ACHHUZ4x4vXbEvwWgfGkuxZPgkMn3LPgJyyo2QBsDQXxbTfDLlHy3ulcwmflfg6x8m61ywuMl/i+Lg==
X-Received: by 2002:a6b:8d8c:0:b0:76c:77b9:b82e with SMTP id p134-20020a6b8d8c000000b0076c77b9b82emr3485929iod.0.1683904165527;
        Fri, 12 May 2023 08:09:25 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k26-20020a02c65a000000b0040fd1340997sm5076921jan.140.2023.05.12.08.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:09:24 -0700 (PDT)
Message-ID: <4f862845-5321-4559-3d0f-20fb618894ef@kernel.dk>
Date:   Fri, 12 May 2023 09:09:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ublk: fix command op code check
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20230505153142.1258336-1-ming.lei@redhat.com>
 <ZF5Wb7L3I8YLqaaJ@ovpn-8-16.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZF5Wb7L3I8YLqaaJ@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 9:08 AM, Ming Lei wrote:
> On Fri, May 05, 2023 at 11:31:42PM +0800, Ming Lei wrote:
>> In case of CONFIG_BLKDEV_UBLK_LEGACY_OPCODES, type of cmd opcode could
>> be 0 or 'u'; and type can only be 'u' if CONFIG_BLKDEV_UBLK_LEGACY_OPCODES
>> isn't set.
>>
>> So fix the wrong check.
>>
>> Fixes: 2d786e66c966 ("block: ublk: switch to ioctl command encoding")
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Hello Jens,
> 
> Can you queue this fix for 6.3?

Done, for 6.4 though.

-- 
Jens Axboe


