Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26114ECAAD4
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 13:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbiHZNdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiHZNdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 09:33:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC0DC5CC
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 06:33:00 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i8so825686ilk.8
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=T7rDv8bfpF0NKm6b91fWsribvdEGLUAR/frSiVzPKqg=;
        b=oyPJVLCalZx8UQW/8LMEaZK4V8yP72pYIcmHOO1UEBZFE7chLsb5aYAuL7NnEd7TXk
         AUxBbIWAeGvWEaEYho8j47cQnBfeXT46er+lY3qqTDJEo3/NPDDT7kyh7AMNM28jIofj
         tq2bO/EKSllOUqbUbcZqqbuOliKir4GOS4VAx64E/PN6xFa8ojp35Db+jICGBZ5KpTJU
         Xb5gBYx8cDZp1aQkuHo/M01rtzX1qEk83dXE1lP2bOIQVtZi3Qbs+9czRzuBOEEY8ThF
         YtwCsbzMho2RIj+QBuLhwyNeDBm9HadH9O/KnO1LVLCMtdHXZUOAdEw35Zofh79Edq+R
         nvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T7rDv8bfpF0NKm6b91fWsribvdEGLUAR/frSiVzPKqg=;
        b=p33NHDCXCt+l3CJupVjWHOg/QlLFZLV2mmOy/M6JnfuTXMg8y/eWFK9gXqAE3OIu6A
         C0OU2Lh++xbeAH5pnyQWXkx6mqr1eUY3ukBA0GWbL2AVguE0kY9cWkzsnGYrEyxsFNpK
         WdlWCYWImn0J/aQ4GkppPU8OxsyQo1e+SsayPVUjumeKexaKLPgvYfUulD0H8HNfU5xa
         99lxRG8AfHTURH8zhhpj6nAJKXUAL0WaJ362Qd61mV1HRgQO4Bb6FjI9vBLZg1KQf0s1
         XxC+c78/ffN/tFZ5/b6dn6uOXgxsSJJ1vcYbm+O2tmsYjvg7CQkXzKUnyyVfJ6MYFzKy
         gucA==
X-Gm-Message-State: ACgBeo2/JIHlkOzu0xc9fjihEgP8reRS9Y34YQ3hug40UlEE1C/ygwyY
        iAyqSgOMy0Oylpv746d44mstopyQ1Gix1g==
X-Google-Smtp-Source: AA6agR48/u+wutZSalsjtPS42hEBqPHVA6Yh8DJzUfL5H55tIcHUdeX0NRjKsgeViJ3qKhUzaHL1TQ==
X-Received: by 2002:a05:6e02:12e7:b0:2ea:70fb:cc8a with SMTP id l7-20020a056e0212e700b002ea70fbcc8amr3526471iln.276.1661520779690;
        Fri, 26 Aug 2022 06:32:59 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e6-20020a6bf106000000b0067bcb28e036sm1090113iog.49.2022.08.26.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 06:32:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <1661483653-27326-1-git-send-email-liusong@linux.alibaba.com>
References: <1661483653-27326-1-git-send-email-liusong@linux.alibaba.com>
Subject: Re: [RFC PATCH] sbitmap: remove unnecessary code in __sbitmap_queue_get_batch
Message-Id: <166152077799.21944.9327436933138809735.b4-ty@kernel.dk>
Date:   Fri, 26 Aug 2022 07:32:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 26 Aug 2022 11:14:13 +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> If "nr + nr_tags <= map_depth", then the value of nr_tags will not be
> greater than map_depth, so no additional comparison is required.
> 
> 

Applied, thanks!

[1/1] sbitmap: remove unnecessary code in __sbitmap_queue_get_batch
      commit: ddbfc34fcf5d0bc33b006b90c580c56edeb31068

Best regards,
-- 
Jens Axboe


