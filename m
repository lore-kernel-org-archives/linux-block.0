Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E686C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E262A60F43
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhIWQtW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhIWQtV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C53C061574;
        Thu, 23 Sep 2021 09:47:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h3so6932388pgb.7;
        Thu, 23 Sep 2021 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XwHjIKgk8eS5XqWT9Kni8aRMXAG2u3vYTTL4J9FiqpA=;
        b=Ddv64i+ECH4vNrICBPZ6G1kSfCtqM4SyCDR0/CB68ZcWQz+6kFXeawJLWSKKvabO0Z
         4SIPcnE62VJNJ8ELF4WiUDmaGnC/ehZiogL6JGUpA/nR1liLJSH+pSlS/SsIuSNjV68S
         o2yz4xMuH9fbvzWarjb9ONY7BgDIxmfFd0+0mY4U3yTY3PXWoieaW+51bJiYA2ejlaVi
         KTEnFVMiptzuB73V0TkuD5CeoDyT78hr2MRm9LRphRA2ocGdcr/b7R96qChDjhmfpNgE
         9CyHS/KRZj0tLBeqJFR9Gzmuou3HCmqdAf/XJ/Kp3lWkLY+/VnpeY8AmBnFKJGPAO2xw
         C8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XwHjIKgk8eS5XqWT9Kni8aRMXAG2u3vYTTL4J9FiqpA=;
        b=xSuRzDLIir690Fh0/hYydSptLOb6+lWkTRXA7Y8uGzKOCJiUZHSjpg0lE1GRMNf7IY
         iHbxJYD5CkCfkjUiXkRzuoDrtHZdAIkXI+3wCryetS8CKNu7TM8Hz4UQvazGe5z2JQq7
         /+0EwHRZQnCd474CEmLc39jhaGR1tyF9qMy9HxFqF9F7DBe6MCNPHOZTREtHAJp9z8LW
         pmnO9NExN6dPKCnDOcgK3OfPQuzRQqPtFsfNmM9xJheiqtbQvbDL6E5BlN+BxpGfxkLd
         NfaPmMaxAMHHTly0RtrrW8UWnujLbzJznCpiU3dub4fCTfZ58wyzok2vy9N+ICjy/ye2
         2xGA==
X-Gm-Message-State: AOAM533gYd+GXTjUoPAe25CzZI3HMz590qQyyasW0dCX0AaPCAGMFj49
        G4p/zwuLuJv4vbxZxJH1ltM=
X-Google-Smtp-Source: ABdhPJztvNYbXx+hJkQXjwYRAqDO1gtCE4huaQwLMR/xRNZ9Wm2y9E1wOIhcx6zIY4Ll4am5rasWoA==
X-Received: by 2002:aa7:9e9a:0:b0:43e:d9b:cd93 with SMTP id p26-20020aa79e9a000000b0043e0d9bcd93mr5515716pfq.50.1632415669453;
        Thu, 23 Sep 2021 09:47:49 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:5571:502d:54ea:90d6])
        by smtp.gmail.com with ESMTPSA id j3sm6361857pgn.12.2021.09.23.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:47:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 23 Sep 2021 09:47:44 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v4] zram: Introduce an aged idle interface
Message-ID: <YUyvsJz+aMCtlRxD@google.com>
References: <20210917210640.214211-1-bgeffon@google.com>
 <20210923130115.1344361-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923130115.1344361-1-bgeffon@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 06:01:15AM -0700, Brian Geffon wrote:
> This change introduces an aged idle interface to the existing
> idle sysfs file for zram.
> 
> When CONFIG_ZRAM_MEMORY_TRACKING is enabled the idle file
> now also accepts an integer argument. This integer is the
> age (in seconds) of pages to mark as idle. The idle file
> still supports 'all' as it always has. This new approach
> allows for much more control over which pages get marked
> as idle.
> 
>   v3 -> v4:
>         - Remove base10 restriction.
> 
>   v2 -> v3:
> 	- Correct unused variable warning when
> 	  CONFIG_ZRAM_MEMORY_TRACKING is not enabled.
>   v1 -> v2:
> 	- Switch to using existing idle file.
> 	- Dont compare ktime directly.
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>
