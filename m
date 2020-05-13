Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29F4C433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27D6205ED
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 23:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbgEMXYv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 19:24:51 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38372 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbgEMXYu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 19:24:50 -0400
Received: by mail-wm1-f54.google.com with SMTP id g12so30400281wmh.3
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 16:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dnw+eOO9krUbxVKPSPtp0kxzIsSiBA3RLA5zi/EKdJGxk30aVpOEJrHHFy/y+kkl3N
         o195ubR9DhAK7IF50C8/abLP6o7KmFFRkb3aBsUWeJDEMj6dvOG65cZlVMSQTZs+uJVK
         pL/N0mGyfjne7qe0qNiTKlX1e+2Ag07bRZ5bm7mHy28T25cbIlsulQOQnZCsEZj6XFf2
         ZwYSlxIZEPAj3ibuGSE3WWZFjXt8IZiw6Lk+6Fa6wLYYA6iXO978NXQgPCAzKQuukcgb
         WJQns7De1DMW0+x7TRUfGyoHnrTfzqgg1z0Hh4fUzRnflSO7Yj/4PufZCp5dK2uVi/oB
         wTaQ==
X-Gm-Message-State: AGi0PuaVnenmMaGFLH3Vu2ck9AmGjQWw9FAlWguZddXw0VVCefM15Gps
        7eJJcdWZLoTt3n5bkO6jpGCa0Gv1
X-Google-Smtp-Source: APiQypJOU1buJx3IswvXNlosWlp79Xr+5m9OgwXhAzOzawKA7i3m/0CM5znJMgKLIlnPk9K5v1Q90A==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr45568456wma.32.1589412287846;
        Wed, 13 May 2020 16:24:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59e0:deac:a73c:5d11? ([2601:647:4802:9070:59e0:deac:a73c:5d11])
        by smtp.gmail.com with ESMTPSA id v20sm1587520wrd.9.2020.05.13.16.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:24:47 -0700 (PDT)
Subject: Re: [PATCH 7/9] blk-mq: remove dead check from
 blk_mq_dispatch_rq_list
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-8-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <95f72935-4cf0-86c0-edbd-21be120c36a8@grimberg.me>
Date:   Wed, 13 May 2020 16:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513095443.2038859-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
