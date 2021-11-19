Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 07:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA7461AFD
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 07:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhKSHSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhKSHSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 02:18:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC5C061574
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 23:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hKsbesjFFQWd0LupVlwCC0Z5vLWG9xmlYvZ1SX4AE9o=; b=W+7zOm3gPvjVYCfjSVQtYPVCox
        eomntNGzDl46wBMKa/RPyuPs059FQUHeKf4mlfCkFgSn3y1o4itU5h5ghmFVf7yGtnR/B8rfVJGez
        ngLoyMBHy/hE7qsMH0HvVmP7WcnKC0NYAJUDwPl/+9GTno/VHmspd/lDkXsfQUXcVwfqG+l2bL6Vt
        AMcSDyjHWOz4Qkcja1+qA0sJhsJUAxzU4ZIS7OEbGkppgh6ZvA089kx0t6CicgHpE5YC2rKwGDVga
        i2PYCQvzzqhFcf8DnWogeI5fe4/nGsY9IBHrED+KdYLnEZZ5XSl1eICdVQwDj0sa0hzkpIQ7bDJHa
        2/5PCFZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mny6w-009Zrk-Hy; Fri, 19 Nov 2021 07:15:02 +0000
Date:   Thu, 18 Nov 2021 23:15:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        wangyangbo <yangbonis@icloud.com>, axboe@kernel.dk
Subject: Re: [PATCH] loop: mask loop_control_ioctl parameter only as minor
Message-ID: <YZdO9nhqsHvDW53v@infradead.org>
References: <20211118023640.32559-1-yangbonis@icloud.com>
 <c685d6dc-3918-6ee5-df59-f2d814635228@I-love.SAKURA.ne.jp>
 <1ebd5c91-442c-1ab0-f71f-0feff04e37f5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebd5c91-442c-1ab0-f71f-0feff04e37f5@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 18, 2021 at 11:51:21PM +0900, Tetsuo Handa wrote:
> On 2021/11/18 23:15, Tetsuo Handa wrote:
> > On 2021/11/18 11:36, wangyangbo wrote:
> >> @@ -2170,11 +2170,11 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
> >>  {
> >>  	switch (cmd) {
> >>  	case LOOP_CTL_ADD:
> >> -		return loop_add(parm);
> >> +		return loop_add(MINOR(parm));
> > 
> > Better to return -EINVAL or something if out of minor range?
> 
> Well, this is not specific to loop devices.
> Shouldn't the minor range be checked by device_add_disk() ?

Yes, that probably makes sense.
