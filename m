Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B6FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 23:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiEQXrf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEQXre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 19:47:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB84ECD4
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 16:47:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so4010614pjr.1
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ysJF4XM43y/fSy8sU+xRfX8p6G59gQY61NVV4iA9+hU=;
        b=J+IvTmSTGYb9oKhTFmuSHbmJI3fA1UkjQGFnRIAi7lkIgccNLk+F4B20Sf+RrKbijf
         Os4ZhCKGywUxIcncZgWlocJg7+O/0Q57pvAymnkZSd1zswwAmBrbyGuwnFpJRsZVO1Mp
         yWn24T5hFvm+ES+sHjexWqfN4DH+zF188o3lS2kWm2yRsB21z2WFt+A/bmp+dQWpsZVZ
         ofaE38DWc6T4pf1W1ECW0DGhCzD0HOvW5zhk5fsFK/gqdfQ5gastwEyqaIT8g8mqfitL
         tsQVViUzvEreVPLVYZfqiMe8qIMM/egoc4Xjmu5fECcJsHPmedxq8ZzdDFbHL7eafiqS
         e4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ysJF4XM43y/fSy8sU+xRfX8p6G59gQY61NVV4iA9+hU=;
        b=bIe0CZeFbNOopxpg4ykPqELYqjIJG8m7RLMcWXuIZtJaYckp7YWY5WsvZGxJPrhPfa
         6uZrG4RsCwX7gnZRJB4hksFIQwMVgbHr7ze6uh+pR40jsoRBeUj+NI0OR7vTmx9WdlCd
         mlfnLmTxIr7Dhcwz9lliuOobTBWuVVTIG88DLM6FZNR88CvWb8xmLB87ah7VJHGiyRJW
         LxySA6EQD7OllqzfwLD5u/IluHcKnUehOcnuY/ATu5AVPNMGKvekjDfQ7Xe2Y6rNIgwR
         58M98exVVonz7iUt4I+WQSCGi+ywGldl0WjgWhB/zxkwOhabS3u2Tc0qDLes+bN76oWT
         LuhQ==
X-Gm-Message-State: AOAM530gY240p2qjWaFJ3gP+TMLFYHSxtWZncVysUofIf9Cvsej9ZSPd
        XqUz6W22X/2EhKrY8BAxAD3KWVWr33Z5DA==
X-Google-Smtp-Source: ABdhPJxIFKvrloDcf7qqHK4BK4ip+opxD5ldCHH2eEfZjbDmlDnRzuf3LRF3xen18akrgPg1UnAslg==
X-Received: by 2002:a17:90b:4a07:b0:1df:7c10:7d3e with SMTP id kk7-20020a17090b4a0700b001df7c107d3emr7780600pjb.109.1652831253175;
        Tue, 17 May 2022 16:47:33 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::e2ec])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090b018600b001cd4989ff42sm171449pjs.9.2022.05.17.16.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 16:47:32 -0700 (PDT)
Date:   Tue, 17 May 2022 16:47:31 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Alan Adamson <alan.adamson@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: Re: blktests v4 tests/nvme: add tests for error logging
Message-ID: <YoQ0E8s6gFczuppP@relinquished.localdomain>
References: <20220516225539.81588-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516225539.81588-1-alan.adamson@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 16, 2022 at 03:55:37PM -0700, Alan Adamson wrote:
> Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
> run with or without NVME_VERBOSE_ERRORS configured.
> 
> These test verify the functionality delivered by the follow:
>         commit bd83fe6f2cd2 ("nvme: add verbose error logging")
> 
> V2 - Update from suggestions from shinichiro.kawasaki@wdc.com
> V3 - Add error injector helper functions to nvme/rc
> V4 - Comments from shinichiro.kawasaki@wdc.com 
> 
> Alan Adamson (2):
>   tests/nvme: add helper routine to use error injector
>   tests/nvme: add tests for error logging
> 
>  tests/nvme/039     | 153 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/039.out |   7 +++
>  tests/nvme/rc      |  44 +++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100755 tests/nvme/039
>  create mode 100644 tests/nvme/039.out

Thanks, applied.
