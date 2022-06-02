Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA6BC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiFBTFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiFBTFT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 15:05:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B690BF1;
        Thu,  2 Jun 2022 12:05:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a10so5713267pju.3;
        Thu, 02 Jun 2022 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErkdigvWJC7gN35TT0Xai2a2txPxDnW6A23kYtrzY/M=;
        b=NNZemRytfEOcVt9JCTksweDQQDt81iD8tK+Ty4aZJywf8A7xvEXGpdyZF6PH87xFnr
         8dZwvXFWWQy8oU9PeEZMDpmwEiasGU8yj1jZEZ72W/V9rbsCPw4qtl5+Gil3MfPROT4X
         tmf5gxBDK8odvuXWg8zyxNwf1ktizZcbcP8wzxGlt2kBYuDCp3jk1TgjI+EtocvTW5ju
         mSJv+h/dHVcy9ufFRY8gy1Eb0MPqjZL0vW5yim5PxacPhhL0LqkICfdUMeiqK7QRMwan
         rC0uEztTTcXSodh4PcYysHxue8AAl5rIHTM6YjJh+CV7vEh7obsvjqJZYb9uTbIYB2rN
         YdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ErkdigvWJC7gN35TT0Xai2a2txPxDnW6A23kYtrzY/M=;
        b=sskQ6VMZQ6uuKBsatctTiYx3Qh3e1ulPiZ3IDErjAHoC2B7fwZxnbBibF9qSvK7yBS
         cW5aCDGUwZmcH6+bdZEpUzFszzNbcpdDhcyfK6LwkPMFJTfKbzbYMel3+XQjo+CDlyGi
         dgPGF4loYdQCRPMti8Hh9AQxlYWzanNo67NkEJEgVv25PUFnlZor1pCYukVfyS0J1n+T
         nMCyqFttnqZ5/pEOJQrorz81utnRj0yz3+mEboAEU5Z14jYXhBn52Css+1VvH0IbQMzA
         /Eb7A63wndqNn6hTpira58wI8irDhXHO15cjod13u2UzAyWLNKDjsj4BxvcyzMuL+cRE
         nN2g==
X-Gm-Message-State: AOAM532hgxnfqqx3qjZZ5yUQMyVxbJeFmcRPhdNz5H/Wetio7JZIZBLC
        fpyXXxzlC4knOKYiG8HX83M=
X-Google-Smtp-Source: ABdhPJwsmlLDRJNrizBhCrCzqikbFQQ9w6ocCYHwh+qkEcGHzSvvqOd1b1rU60Gjr+0bbfGwAahZgA==
X-Received: by 2002:a17:90a:e7c6:b0:1e0:9cf7:d042 with SMTP id kb6-20020a17090ae7c600b001e09cf7d042mr6789683pjb.234.1654196716779;
        Thu, 02 Jun 2022 12:05:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:49ff])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090a6acb00b001d2bff34228sm6217735pjm.9.2022.06.02.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 12:05:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Jun 2022 09:05:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 4/4] blk-cgroup: Document the design of new lockless
 iostat_cpu list
Message-ID: <YpkJ6rDTR24ScuEq@slm.duckdns.org>
References: <20220602133543.128088-2-longman@redhat.com>
 <20220602185401.162937-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602185401.162937-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 02, 2022 at 02:54:01PM -0400, Waiman Long wrote:
> A set of percpu lockless lists per block cgroup (blkcg) is added to
> track the set of recently updated iostat_cpu structures. Add comment
> in the code to document the design of this new set of lockless lists.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
