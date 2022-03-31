Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF06C433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 18:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbiCaS6g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiCaS6f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 14:58:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8BA19CCE4
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 11:56:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p21so605870ioj.4
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+g4ZNpIxBnSkme/wNFOytxoH6v9mTIXDnbrIqG4r6aY=;
        b=EvHbhnlW2WmAIO20yqRruynjvVlKl5NzFw6BsDBjCNtXz5Ihn4uGH0sfXRAG6xqBn7
         JfJ+09677YCnAxT2G/pWFkysXOs9IpbBbwfMAW+R3krXaWCQZj+f1VmhYpqBYaTR5/M2
         mO2nbkChoZpTexjArhRoOffq+FFSutfl6dVBgYwiHoQ/OGe+RId06zBQcztWdiug8g/R
         vqLkIj8efE4sNFevzht/Y/g2BclZPdafECHPSOWjfSVTfCNMKvUDb65pP0IlTAoSHYov
         tcYuNuWpbXxelZI0j/CdAckDCt0xArsffjmD3bE7RFfdIrIOj1/yzZYENjgvmMlDzAB3
         tDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+g4ZNpIxBnSkme/wNFOytxoH6v9mTIXDnbrIqG4r6aY=;
        b=StWK5r5gACR7bBgKy4p4VRiQhvJSjy8MkXjKOSMcFeuYHfdVfiHranD5w8yAKOPzXb
         l2QkNauUcapJliQ5xqqQ9H+skktdjnmup+qNI+vuf9Z1qmHMoxyhPOZ5P1viTWbtOx5Z
         L0g1GGVK2KZbnPghkVAyOXJxJ/BNn17dBsJLtgzQiYG7nvgAB8NGqdhD/OwFcoDHunjq
         0kYnHloTvEwvuEfGIRZs3EzOQRscf/XkRI9JXo1VrrcEaHmpPFMLctDEQK1H4VvhwGtY
         FKy1rQxoIKdEwabKZSk4BM+0lO8WBf+shOqcy8ZBH/Bpix6ihwfw3uaK12mDXCI+Fhzp
         sZpQ==
X-Gm-Message-State: AOAM530fahEn0KInp69YpBsybqSWxy8To2LlTcXTnXIGKsudE7lcf5Yo
        0TG7A1Ab+FHR4dR+x2UvciKSlQ==
X-Google-Smtp-Source: ABdhPJzc0hwAInyQ3w0FQhKRTQnho2kqwyjIN5xbQ6E8t46bUjtOOVOI5AqaleePK/Db7WFYguHCLg==
X-Received: by 2002:a05:6638:4128:b0:323:62b4:30c3 with SMTP id ay40-20020a056638412800b0032362b430c3mr3999511jab.318.1648753007479;
        Thu, 31 Mar 2022 11:56:47 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p3-20020a056e02104300b002c9f5a5cb7csm126515ilj.42.2022.03.31.11.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:56:46 -0700 (PDT)
Message-ID: <d5bb15f0-6531-383f-8e78-0dad58828689@kernel.dk>
Date:   Thu, 31 Mar 2022 12:56:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] blk-wbt: remove wbt_track stub
Content-Language: en-US
To:     trix@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220331185458.3427454-1-trix@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220331185458.3427454-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/22 12:54 PM, trix@redhat.com wrote:

Not sure how you sent this patch, but there's no body, just an
attachment. Regular tooling doesn't like that.

-- 
Jens Axboe

