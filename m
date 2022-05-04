Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232EC433F5
	for <linux-block@archiver.kernel.org>; Wed,  4 May 2022 16:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353223AbiEDQX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353107AbiEDQX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 12:23:29 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F24667A
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 09:19:52 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id f186so1289184qke.8
        for <linux-block@vger.kernel.org>; Wed, 04 May 2022 09:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCWOLAng0ky+3TZhOm25Rcpf8GhMwRcDOjODF8uASO0=;
        b=DmwkkgNVtM9DlzB0Xq4ZBUsmqHTKq2tXB2bxrJ3t9CcV6qD5yuZBOybI6cuWd0I+7Y
         jLglEqHALb4gkbqXz4Sd4RHpaavTluXORrRBDma5lgxiSG+jDzPLAVFm2Db5vhgJnF5n
         sJKOPWON/oIItkWkR65+tRBnSbIgoDLeGLfmyJmMW3jC0VZgGRC5nGxom6d4k8tLdX8n
         6i7TguTCAp5JDdzeYN0J2lXi+yZSxD9daYgJ/8BG/I4hXqFaJYVDjrnkV5LoXlg6hT/H
         UNMq+6AJg1RvgEer9VQH9XVWdcDeWm/wLm8Y/ocOohwrgnfDcB55umLUC9it5NLwuwaH
         bwHg==
X-Gm-Message-State: AOAM531XUGghP7OwC7tfF+gYtjmfSqGGb93cogv/21thHkg0zpchNali
        I3eeSPkuRGHLx5p+U1/w62LM3haeXiYy
X-Google-Smtp-Source: ABdhPJxvYv/D+LeK192WsxKWhBgtreBaS8IX5xTLnYbc3ZQ1qQF49M/oTaFI5MN+S7gIhusOE+SS1g==
X-Received: by 2002:a37:48e:0:b0:69f:9bc8:720d with SMTP id 136-20020a37048e000000b0069f9bc8720dmr16154043qke.268.1651681191950;
        Wed, 04 May 2022 09:19:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h4-20020a37b704000000b0069fc13ce203sm7913475qkf.52.2022.05.04.09.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:19:51 -0700 (PDT)
Date:   Wed, 4 May 2022 12:19:50 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: remove superfluous calls to
 blkcg_bio_issue_init
Message-ID: <YnKnpk41vXttKEIB@redhat.com>
References: <20220504142950.567582-1-hch@lst.de>
 <20220504142950.567582-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504142950.567582-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 04 2022 at 10:29P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> blkcg_bio_issue_init is called in submit_bio.  There is no need to have
> extra calls that just get overriden in __bio_clone and the two places
> that copy and pasted from it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

