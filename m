Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3FFC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7987A218D4
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="dHLZkIPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfCUWHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:07:19 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:36283 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfCUWHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 18:07:18 -0400
Received: by mail-pf1-f170.google.com with SMTP id p10so49209pff.3
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9E2WphSU4sE3SR2gZSSum2SuQyS8UlXzhst80Cz1UQ=;
        b=dHLZkIPS+bOQEdPjfW0fiIDuiiPRLx1oP9lQYEqvb+LgW0c6XpB+rqXitSHY5hTfWW
         pIxbC13/wg00osZ1zwFYFX6ASpqUYDnqTBO+Egctt9gbk/0uKKo0LUkm2YBFtb4q257a
         75hhaLhIVFICCu52PNopJk22Rqh+SSl5qZ7Xbxsc3tgkYaoySUSsyd4/svRmbiZKLfzm
         1T8Er+lsWXkn5jDT93mBMFSIywSK0OnFBtkc4QZbqCzmL409SKbhismRPZv4rocFglRU
         eY71cRnJ8zqQPjgB/r394u1u180n+zfE+aZ/D9nkdR870qefTFu+0aX6QbcKCo16OP9P
         Rdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9E2WphSU4sE3SR2gZSSum2SuQyS8UlXzhst80Cz1UQ=;
        b=XVq8Eag+umLf2Yc28veeQvJO+fcDZd4Hr+BirjppmPFx3ewv5cG1VugWepAhS8BW+u
         Iz2QfYANIAuFqL5dtqEFNP8KrlQ+IHLthYKiJLynrys7G8yy6GT/uYHOgJJXdwuavAC3
         S8ce+bqij+lakdU+3vhjf+u4B4yO5p2Ubc5juqGlroUxiBi2AO7yMhQdxdpCsJviK6fH
         FHytcQVY5itXmWw35+J+s2Pgpro3l088ps/h9KTgCn6ZE8Yr/v8ALhV9/8q664Vq1asi
         cCguZcPmAwJXtLabLXdfH67rx5wXr9RZTAy3R0Ysa2W2uK+WyqYXCtFEHmQOU4CJEglj
         cWiA==
X-Gm-Message-State: APjAAAWDHJGZ3xFb3vntZDICfETE5iWYBaP+4TbYD0c3C6aieW3d6Ssc
        VACVPYA0Am3edi4DwkkL6mvoNQ==
X-Google-Smtp-Source: APXvYqxpj/3SvpCQZCuSpplNdMDOmME3jBaRoHIh7W8vQz27OKSMiFM0ISnXjAc4pmaGTkiifQSzlA==
X-Received: by 2002:a63:c242:: with SMTP id l2mr5588130pgg.138.1553206036904;
        Thu, 21 Mar 2019 15:07:16 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:1643])
        by smtp.gmail.com with ESMTPSA id g143sm878502pfb.157.2019.03.21.15.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 15:07:16 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:07:15 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Xiao Liang <xiliang@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests] add checking nvmet module in nvme
 002,003,004,015,018 test
Message-ID: <20190321220715.GA20838@vader>
References: <20190313071317.8723-1-xiliang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313071317.8723-1-xiliang@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 13, 2019 at 03:13:17PM +0800, Xiao Liang wrote:
> Signed-off-by: Xiao Liang <xiliang@redhat.com>
> ---
>  tests/nvme/002 | 2 +-
>  tests/nvme/003 | 2 +-
>  tests/nvme/004 | 2 +-
>  tests/nvme/015 | 2 +-
>  tests/nvme/018 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Thanks, applied.
