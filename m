Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7399BC432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4C62075A
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4A2sJws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfK3WFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:05:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36189 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfK3WFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 17:05:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id y10so36782144qto.3;
        Sat, 30 Nov 2019 14:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LavGqVWdCa+DgEJijwHbAU0oPvPk/rvkw7rn6vGHe94=;
        b=s4A2sJwsb7TgqnsHw/GTBPDuz7XkDrPomjfcp991BO0a1XcmM8BwZ5Hao4Vcboim29
         7EWGGQ5XtYgl4ZzKChRe31qVjEZhiYf8KJCF+36+CtByqBbx+Q/TzamBjKpbace0nrGT
         ecLpX8RTH6MlIb5o3rCO65H79wgTIAy91QhMXcM78M+KivJ4pKqH2iMOyAb79S8zmi2L
         Jk9HcQ5V2KQQeeZhrzpwu37Nv4532oxHd00i4gLqxNFIPxnQKxTjSlYa0YeQsmfZFiVx
         oYeVWdjOcSZKWTflBPlPbqq6FLqPDeteCYwwCHZzlmmEYCRkAekt9HGl5lhvSQ+dhARu
         bJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LavGqVWdCa+DgEJijwHbAU0oPvPk/rvkw7rn6vGHe94=;
        b=kgwKf9lGvl5gy+SuR5vWdcv90YrN0+6wfXmPTav/6DVWJf3guEeE7TA4DqcZruRR1j
         t0RIQdSd4CpneKfw0cePK5kgsluTPozcQ0EQVrUZxW9d6Lznwk1PNu8nX1Qo2qxXzt3x
         cP/aW1rhyARnl0UMHzxn7Xpgrz4sf7RfggkgY6iHXlRbPcFI3RthXdQDct/2SdGRZ2yX
         vKk40FdSc+Scr4wYvl/LUAMow8tGckpwCAnuatEIzIFEhTtUm8RtimgkoCn1EDDRd/c0
         2mkwuIkFj/cqRTU581e7iD6obM2WKTlwQgbg5QfihldTv7ZrX7/02Nlqno/xnqPBxkXc
         rCHQ==
X-Gm-Message-State: APjAAAVlico8Rg9hHbzWLO3pVv8CFuPD6BA0BSAGVAUnpbumoISvYKjG
        WKGolfnR07+r0VeuZLtwhjA=
X-Google-Smtp-Source: APXvYqzTU9c13zW91d8JiG3CkIJUp+ndwSysFJrulNhocQrAsWtPE/0I97hN+dA7VDf4mt/1dO67Eg==
X-Received: by 2002:ac8:37b6:: with SMTP id d51mr50374025qtc.261.1575151503469;
        Sat, 30 Nov 2019 14:05:03 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 24sm4129561qka.32.2019.11.30.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 14:05:02 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 30 Nov 2019 17:05:00 -0500
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, nivedita@alum.mit.edu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: optimise bvec_iter_advance()
Message-ID: <20191130220458.GA297712@rani.riverdale.lan>
References: <cover.1575144884.git.asml.silence@gmail.com>
 <b1408bd6cc3f04fe22ce64f97174b6fbf9ffea40.1575144884.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1408bd6cc3f04fe22ce64f97174b6fbf9ffea40.1575144884.git.asml.silence@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 30, 2019 at 11:23:52PM +0300, Pavel Begunkov wrote:
> bvec_iter_advance() is quite popular, but compilers fail to do proper
> alias analysis and optimise it good enough. The assembly is checked
> for gcc 9.2, x86-64.
> 
> - remove @iter->bi_size from min(...), as it's always less than @bytes.
> Modify at the beginning and forget about it.
> 
> - the compiler isn't able to collapse memory dependencies and remove
> writes in the loop. Help it by explicitely using local vars.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: simplify code (Arvind Sankar)
> 

Thanks :)

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Btw, I discovered that gcc 9.2 doesn't optimize away the second
comparison in something like

	m = min(a,b);
	return m>a;

So the WARN_ONCE bit doesn't get optimized away even in cases like
bio_for_each_bvec where it's guaranteed at compile-time to not trigger.
