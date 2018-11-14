Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E2CC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 19:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C40214F1
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 19:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="I1L9qvq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C40214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbeKOFu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:50:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42800 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOFu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 00:50:57 -0500
Received: by mail-io1-f66.google.com with SMTP id h19-v6so12613918iog.9
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 11:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+5c2g22DLCy8TAMyGrUfMCZ8HQyFO+/QKFQq3+UV1g=;
        b=I1L9qvq3UkzZd9O/HLmo6ZFBPAu85ijJ87W9EyToaVm7CwAaqzu+USwVXaW6bBDsXG
         u16pEbzlfyfmAts9Ve6kZa3PDm53N3Z5GZZjzy2kzAspaFEJZZGl5cbWactWyBULZ8zB
         sWo4lag2Fd3zW8K+NERWFFsgD0apF0l/JfqJbNNlERgD4+Gp2JbSuPz9CnX4MuYAKMHO
         Qk8uU2XxLaQ9iUQh+wZ6+uop5QCp4INspQFAFZYgJ0IeLn2oITwLJjlyVe0MK1s2yDrS
         z3DuonLphNVWqesevPlcKGqOmCZJ9Wq9Ok/FvrSASjwX+HxwXlIQTQHVPjtnHXDzsZ+7
         01EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+5c2g22DLCy8TAMyGrUfMCZ8HQyFO+/QKFQq3+UV1g=;
        b=DZ8NlauyTqC5UN84U0VC8IE78vqwx7Xay23nR9v1DCzQ71h3fJtLMP1lk3B2sulQnz
         taW5oDn81vGOAYNyK1eenR/mnWtrhSw53DmXiHPCbRbDULwqH9lrhKBjiivYq2mu10ox
         IuzpDL8E46sJCbhF1v6gtkDBWoaqRdrQp5T8jVkTIAxYgzBJd1I81POVbutCWsu7pNgj
         UOXjWIuQ6uvEi6zw2oL9tkJpufK2rWvttnh30OtJUyNjQnyrCbiObCRSI9p6FT3/Y+gP
         LZuqDAU1wY82ttRNJn3Zxl2x9Bw+w46nGE4yVrkzqYcrC5/mOb2OQn2CfQzdlZ8uM2fQ
         cFCw==
X-Gm-Message-State: AGRZ1gLkZXqYxXBIct2Bufz/cZG1igbNfUJLP9SorqanR73kLGFnIRAD
        2lU7kDxbP6Lv+W8d9FKe8ZFToQ==
X-Google-Smtp-Source: AJdET5ddCfpCezfTOOuBTXFZ3DSLgLpcIwjYOhFybqtr/qKQEZBZ1rq302yuxFHlVtb7Tfcx1FFtng==
X-Received: by 2002:a6b:620d:: with SMTP id f13-v6mr2560623iog.11.1542224783321;
        Wed, 14 Nov 2018 11:46:23 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:2a61])
        by smtp.gmail.com with ESMTPSA id y21sm2787280iof.51.2018.11.14.11.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:46:22 -0800 (PST)
Date:   Wed, 14 Nov 2018 11:46:20 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] makefile: Add install rule
Message-ID: <20181114194620.GE4173@vader>
References: <CAPUE2uuGz5qOZ0aFVsuATPqt3XCtmj_nSd0rE44wpihRPzkskA@mail.gmail.com>
 <20181114193931.90009-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114193931.90009-1-gwendal@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 11:39:31AM -0800, Gwendal Grignou wrote:
> Add rule to install to a target directory, /usr/local/blktests by
> default.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Pushed with a slightly expanded description in the README. Thanks!
