Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7241C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 13:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiBXN7n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiBXN7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 08:59:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7291CF099
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 05:59:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h15so2959553edv.7
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1b6ODtXjGkLhwW4cQUSwmSTk3bQuPqn7DzrMrcdDeK8=;
        b=CRAK9G+FO11xtxUzAOTWRHzyamOAyNwpSDRVR38de4jqXZVuWMdpf2bboA74ZIWJk0
         J+NR1+y+39QVtuZFDJ4159lZPMzuinksPFWoL+gpbctK6zuTiS7p3J9CqUy7UrModHG3
         sO+snK1vEHa03yrl42W1a7OnpK861RuX80LN4FtENLRvLfgzSlNlaDsC1aKEsdB6rI2y
         fH6m0k6C/GW3yx+jiVVH2bm7or7pBifCfupCq5xtRlUig0iZzzla1/qi1YIBhwtX8aLd
         5T5fzzMDH0Q1HOJrNGXx2jMCsHZk9wrqQMcRgC6mf3IYuADVWJr6fRs67pkSOEOgAAaA
         GQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1b6ODtXjGkLhwW4cQUSwmSTk3bQuPqn7DzrMrcdDeK8=;
        b=rgwx+gIStISA0Ym9FveouJ0QJ+fW0C/ZTKm9p7F0fEmZe90B7EHChTn3pZi/LFCD09
         N8n5M753yZI2q654GwVMeGJqejHyIarhnD+MSO8rH75Hc4jeBCP9AZFpMH2yqHU3jtP8
         sA40x61C3tQjNst9dDgZTUH4ICI9aQj+Pju/guEmktJs0pl8Sklcm37hYGm49OFiPkZI
         dEr+fxonrvxyTUU2d9MAxbNf4A+hunoR0WLRFUd2pFEH/+tD0rfHWLnyDaZCwo1mX8zW
         TYb3kxs9RMLLcIe2azJBQhqnQH4nsrq1FvSmPXPZpH87LKN3wR7WAfMPq02ZWw1CmM+Y
         +h3A==
X-Gm-Message-State: AOAM531k3amUxjifwh6k3u6pC5zOBC6h+KtiQ4oLiGFKbKit4NviHPzm
        BAigtZEoBzXHigpxv0PLt6vv4Wvg9khShIsVfACa
X-Google-Smtp-Source: ABdhPJxUVIFwulhc3A3Y/zW/itJbFP/8KLqmDi95Xmj1eM4dAra67uc43c+5fKEcyYF9JRzjhCIWieOCwz/Y+q5sBKU=
X-Received: by 2002:a05:6402:220a:b0:413:5d5e:4470 with SMTP id
 cq10-20020a056402220a00b004135d5e4470mr2022436edb.200.1645711151356; Thu, 24
 Feb 2022 05:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20220223133627.102-1-xieyongji@bytedance.com> <YheJUTK8BKCjEQYF@infradead.org>
In-Reply-To: <YheJUTK8BKCjEQYF@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 24 Feb 2022 21:59:00 +0800
Message-ID: <CACycT3u+p6sBE76fP2uZBmBKjiGV9i7N+WAO3c_-NmHnYVfxNw@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: Check the max discard segment for discard request
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 24, 2022 at 9:34 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Feb 23, 2022 at 09:36:27PM +0800, Xie Yongji wrote:
> > Currently we have a BUG_ON() to make sure the number of sg list
> > does not exceed queue_max_segments() in virtio_queue_rq().
> > However, the block layer uses queue_max_discard_segments()
> > instead of queue_max_segments() to limit the sg list for
> > discard requests. So the BUG_ON() might be triggered if
> > virtio-blk device reports a larger value for max discard
> > segment than queue_max_segments(). To fix it, this patch
> > checks the max discard segment for the discard request
> > in the BUG_ON() instead.
>
> This looks god, but jut removing the BUG_ON might be even better.

LGTM. If no objection, I will do it in v2.

Thanks,
Yongji
