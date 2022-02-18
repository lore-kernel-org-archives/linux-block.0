Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D57C433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Feb 2022 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbiBRT77 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:59:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiBRT76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 14:59:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CEE318;
        Fri, 18 Feb 2022 11:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=45tIpttbNmvxojqHc4cb86xvAY0WWzmRzTgs25skYgA=; b=VWFrVYgNL5ubTusKFcT1it2rBC
        xHeaOF0Qdh40XJNaw7CPyMQ9mbyEfvSE+2GCzPfwLn3WGvdVG3xnZobw8evo9sEwxVqxj2ZKjd8mk
        0f6xCQpW+GrK5SpGeEpyfsjawmEttV5rP0vG8DDlBiS1Q8qBLBLhSq1+8SiNK14kfeiyzb90tbIMm
        NBSvujAr6F39ohdkfpg/pQo3DjG4VvYFIH/YU1UCMHYAthmrgegwG4WDqVtJ/v34nV6gxK0VeBhRv
        rlvBJAq7MAMRtJHBjHGC3M5Tn0tWsZ9fNTKLVbkJ/EsTLfbxkCbZjdqGiHq4JbM8R6EAtl7sk6n2/
        JSpRdLWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL9Pk-00GtPo-6c; Fri, 18 Feb 2022 19:59:36 +0000
Date:   Fri, 18 Feb 2022 19:59:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 01/13] fs: Add flags parameter to
 __block_write_begin_int
Message-ID: <Yg/6qDCDuCLGkYux@casper.infradead.org>
References: <20220218195739.585044-1-shr@fb.com>
 <20220218195739.585044-2-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218195739.585044-2-shr@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 18, 2022 at 11:57:27AM -0800, Stefan Roesch wrote:
> This adds a flags parameter to the __begin_write_begin_int() function.
> This allows to pass flags down the stack.

Still no.
