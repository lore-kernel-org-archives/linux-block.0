Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D8DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 17:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbiCJRcc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiCJRca (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 12:32:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3DF4D35
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 09:31:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h5so5210448qtb.7
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7J8e206Bwozad+xJPF02nCEZhsFp5sZ0xZvk63VV68=;
        b=UkGo0vpr4SaQ7VeIYfKdoCqVYOfqyZ3ua0gxQaiJfTvuIAdcEhC7UzaOYUa+8sTpBI
         wYGfW0Oyu3FfBBXPWw6SmL7k9/Ix6fjwuGHvkSm5lrOgl0ENo1rP0RrjvEBxzxAp03Gh
         zQ/3YctkGkQXC22sPfWYmqkvHsQeraa8bVSTnn2NJXnxYA2o5wMomQMsd54TRQk6BinA
         66SHzCNzlLrkOoGYPJbmY/C9U3RloqxiyhcEza5IJT17waUWq6Pr7CkjrynsZ5QIxT6A
         Ty6Wst/a7i05d2X56zLTgO7XY9bwMpKsT3BIpaI3jYkRcGuzXkvWvLMzj9Mop7ypQ0PI
         yD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7J8e206Bwozad+xJPF02nCEZhsFp5sZ0xZvk63VV68=;
        b=l7KiSg0vATF6/nkziWQJtJJVpAY3s70WwWObm+JTuuE31UdMik2nyyCjYms6kAsbSQ
         8gFDuC0w46SVVAOG+57yzFOBPkR48RHLyHC87pXB/ueKSzVXgZBpTg9KMuuhHhHy2SJ0
         9G/5hJaaLIO1XQVdMXfoMdUHgEba0NHERLB2/l3mAoJ3zowRR5EaEtXrduNHH/rvSJQ0
         1GvnQqBHMnzudE1FAWCuaekgq6hzyPX8IVCddbG/0JzLoYyw+qj3ST2SG4kKmbj2FQ93
         blHqafu+yfg3w102fhhCytOlawkAJGBQvn0X6J/0jJdCmS2OEC/m2eoxYhIf841gMKYg
         cuDQ==
X-Gm-Message-State: AOAM530f/gV8uLh41FjMW006Mq8BnXGE35PKzb2lL2c4cgeY1lgMME9s
        JKrxDBanW4JjY/aveIQjuMTDow==
X-Google-Smtp-Source: ABdhPJwXrthz2QtCLsnFtqyDL0e1w0h1YTxxQQFSEJP3ZvHCIAN7kMeF7r6fRWtGJMhwK1gVmjpSbw==
X-Received: by 2002:a05:622a:550:b0:2e0:7422:a1d5 with SMTP id m16-20020a05622a055000b002e07422a1d5mr5001583qtx.444.1646933488129;
        Thu, 10 Mar 2022 09:31:28 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b004b2d02f8a92sm2579261qkb.126.2022.03.10.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:31:27 -0800 (PST)
Date:   Thu, 10 Mar 2022 12:31:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     cgel.zte@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: remove PSI annotations from submit_bio
Message-ID: <Yio17pXawRuuVJFO@cmpxchg.org>
References: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
 <Yij9eygSYy5MSIA0@cmpxchg.org>
 <Yime3HdbEqFgRVtO@infradead.org>
 <YiokaQLWeulWpiCx@cmpxchg.org>
 <Yiok1xi0Hqmh1fbi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiok1xi0Hqmh1fbi@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 08:18:31AM -0800, Christoph Hellwig wrote:
> On Thu, Mar 10, 2022 at 11:16:41AM -0500, Johannes Weiner wrote:
> > The first version did that, but it was sprawling and not well-received:
> > 
> > https://lkml.org/lkml/2019/7/22/1261
> 
> Well, Dave's comments are spot on.  Except that we replaced it with
> something even more horrible and not something sensible as he suggested.

Confused. I changed it the way Dave suggested, to which he replied
"this is much cleaner and easier to maintain". Are we reading
different threads? Care to elaborate?
