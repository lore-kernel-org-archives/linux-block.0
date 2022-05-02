Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C79C433F5
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 16:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiEBQMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbiEBQMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 12:12:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453BDEEF
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 09:09:08 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so4818246otl.0
        for <linux-block@vger.kernel.org>; Mon, 02 May 2022 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B/uVoCQZXpNP+GXZdJL2KWam3nupYPtn4R/1jFNhGMk=;
        b=lwblONIsZDB+Fy8xHPeMtApBA1FRlAmXviH0g8LwpG+s38JxuHTD5IUm6uZBCswOEK
         Q7Pk+1rrl7j/by6mdXtrgm22xnEhy0JLHZnezngwZGtqgIThY+LKKd77RPe0MrG7fwlM
         NeSmTA8cb1r2dnRPZiqjF0+3tTssR6UtLbWmIjKWb5cKsQOEr6NGhx6QQNM0QTevgOKC
         yr+MVQ3g60Q82zjEE3BrY5DHdkXDFhtDGXIcBwgEbNlYQiWPB4dQm1zGM1024PdLxfMD
         1dAUp3+GZOQ6Ecc2/S4qukzyI9u6M9bjKU6rK8zWVuI3Ubruy89ezrtuFuJ9BmA4KNpa
         sOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/uVoCQZXpNP+GXZdJL2KWam3nupYPtn4R/1jFNhGMk=;
        b=P1GEW5UocdEmb3ASrsUNhj0RQBqAq8AN4aeBL4kCQWOerMNrqe1QsTm2+zX8DRBz6n
         VRGUPcMy+N9GG5uliNkFqPaG16F0U2gqb4JkwI+eaJGPxkvWlg1o+eoR27O3HgfZn4uk
         kATq7SBN2qmK8OHzPynR+oslOCCo3XLBIp+mOMKmQ7hupBRQAC+pWJm6dyf8+CapszKx
         c9xvmmYRkrT2ttp6wGCw07954YjCY58ZJfia7yoR1Jg0Y2n7Ny0VIJeIHHfCUlhJkZ1t
         KXq71u9mvBkVAfN5NFGI9Mb+pCvWD4PFJi6lqDA5p/EYXpqnizJXUWyMgZesGc/1jjea
         pTSA==
X-Gm-Message-State: AOAM533bTBM4nymxo1Gow7HdGVxwNFYwJKkxzG1FC+G1Nle21hhsT/Wx
        /CNf3uUecZG977bjT6DokEqz8w==
X-Google-Smtp-Source: ABdhPJxBtgB8cf9G0gTqD6sxO7iVbiEZZVlT5BfOupTX6WPWjyQwJ/fHDClS9RQLbei4sOaU0rqslA==
X-Received: by 2002:a9d:6d06:0:b0:606:133c:e7e8 with SMTP id o6-20020a9d6d06000000b00606133ce7e8mr2567540otp.83.1651507747821;
        Mon, 02 May 2022 09:09:07 -0700 (PDT)
Received: from relinquished.localdomain ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id i1-20020a056870a68100b000e686d138a0sm5996008oam.58.2022.05.02.09.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:09:07 -0700 (PDT)
Date:   Mon, 2 May 2022 09:09:05 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Omar Sandoval <osandov@fb.com>,
        Christian Brauner <christian.brauner@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF TOPIC] block namespaces
Message-ID: <YnACIcvUBH8/eKdC@relinquished.localdomain>
References: <7dca874a-b8ef-59bf-a368-595d0ed2838f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dca874a-b8ef-59bf-a368-595d0ed2838f@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 02, 2022 at 01:14:48AM +0200, Hannes Reinecke wrote:
> Hi Omar,
> 
> here's a late topic for the I/O Track: Block namespaces
> 
> We already proposed it for the (canceled) LSF last year, and now I found
> that Christian Brauner is actually present here at LSF.
> 
> What this is about: Similarly to network namespaces we'd like to explore the
> possibility of block namespaces.
> Canonical use-case here is iscsi sessions within containers: if one
> container starts up an iscsi session, why should this session be visible to
> the other containers?
> The discussion should be about general design and possible use-cases.

Hey, Hannes,

How much does this overlap with Chris Leech's "network storage
transports managed within a container" topic?
