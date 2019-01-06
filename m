Return-Path: <SRS0=sA/n=PO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AE5C43387
	for <linux-block@archiver.kernel.org>; Sun,  6 Jan 2019 17:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971962085A
	for <linux-block@archiver.kernel.org>; Sun,  6 Jan 2019 17:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cpB30Oc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfAFR6t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:58:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40030 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAFR6t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Jan 2019 12:58:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so19747878plq.7
        for <linux-block@vger.kernel.org>; Sun, 06 Jan 2019 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0OEMYSAbvlEMnPmB4RHCAdYP+ZdVMVQyrKEc45S5CmM=;
        b=cpB30Oc7kuX+KVB6g897NFtrSMgpHC/5fan6tojXe9z5XxhBWLUJUbOfF+EyXuihpu
         5bLNJ+pgMyIi5e5HDA/ezEAYb9TlRL3hxgLlgYjH/U55YRtk/8kGCoLHc3iJiAKPtdHv
         RyiddqGLWyHZB2MNB80fwH0oxthwXMCe+a44l/nSzFl0N4m3cWBJSys76a6HXMmIcdPb
         xaZYcXfyQmqhzL6+PPRK3keAa2gxrccdb20eULC9j60hilLHRDxE9wdjwKvWFAJtp5Fr
         lW92UqWVV5ceu65CXf3bpgQw4THGxRl9T/0p8yHNTpE9xGMIL6W5O9BajpqEhzWUqb8g
         p/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0OEMYSAbvlEMnPmB4RHCAdYP+ZdVMVQyrKEc45S5CmM=;
        b=i4wL5VYAMI4be/jhXZTMi6UYMqaq6UaEK+ta1zhc7Wva7PmrOTqUhNvF268bsAC5fH
         SWWpJl/1mxeIXancEB97fxAoArsy3sO9gOhRbxUKoBGC13HQpvLy9ZlUqQu185OTlLPv
         0ekN1nbKQJO5B6sYRzhu9AbzUAECLyu7S9lItPL3vqFYy/zH7mgIT2yXYNYHtYCWQOF4
         9+8+FGoS4JvUWlqieueT1YTZ8oklXL7Jok2yfXvOV/i+A7OxsAJewdfkdwzLBml7M7rz
         Z/NmCutXNRApElWgjMN0TqLj9Qobg8k6Hjc0HbWc7OReyvTWPCet5NKEHV2J7YWJO3n8
         JAyg==
X-Gm-Message-State: AJcUukeBu7YF4os+i8b3iKwXMeWaqZ28U5Eql3SDXy6/VGfZ16GkEXDo
        pTocSDLhYjQpw/tHqkLIhxZIwoPRB5H6eQ==
X-Google-Smtp-Source: ALg8bN5ON9GKrlneGu2KnJTSN0JrrmuQXYmDOvLsqwibzFyKsxOtHuDgUYwCr04o7k/VjH1gMqE0mQ==
X-Received: by 2002:a17:902:8c98:: with SMTP id t24mr58311942plo.130.1546797529066;
        Sun, 06 Jan 2019 09:58:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x3sm198520135pgt.45.2019.01.06.09.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:58:48 -0800 (PST)
Subject: Re: [PATCH v2] null_blk: add zoned config support information
To:     John Pittman <jpittman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
References: <20190104170637.8218-1-jpittman@redhat.com>
 <1546638578.83374.6.camel@acm.org>
 <CA+RJvhy1tJ93g3Ne2D4RLFRF62nU5=dWvofZpmPUa0yZt0EFhQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <45d53ef5-6460-e4ed-ff2d-9232c659f8f1@kernel.dk>
Date:   Sun, 6 Jan 2019 10:58:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+RJvhy1tJ93g3Ne2D4RLFRF62nU5=dWvofZpmPUa0yZt0EFhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/5/19 5:44 AM, John Pittman wrote:
> Jens, Bart, It occurred to me just now that on the pr_err() message,
> "null_blk: CONFIG_BLK_DEV_ZONED not enabled" is a little better
> than "CONFIG_BLK_DEV_ZONED not enabled".  It was my intent
> to include that 'null_blk:', but it slipped my mind at the last moment.

I applied it just now, and added the prefix to the error message.

-- 
Jens Axboe

