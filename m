Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 18:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57C460F4B
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 18:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhI0SVN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhI0SVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 14:21:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5FC061575
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 11:19:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so436884pjb.1
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zKrL812IZj983CDNoTAXGWrzyYsFXUo70xd8d5OVRw=;
        b=Jsb0eKvqCXj6YljT8mnNPPjr3BIta8VJgkFwUhes6b/1qGEctJiqdGoU7reuK1AZM/
         dRzwyM05Kp1f84uAdAfp6lpa6Kk6KrCctynYJjcNFlJqW67E/6X+ki37v3QUWU0m1/u9
         TcXQwmHrrC+9oANWkZnWvfG0vHePNl6ImGj+TPhUqDGEZvuThtKyx/QVWv+BDBO5CxEH
         nrnvSk8H17UdAOfIRs/v4MaCJiFlW6Utx65qH2WPjcTKzOWfyynuYxqSqy7z5IXJyz+K
         HWDDhB4TmrlY5XL9sfDfM16NI7TUx5PNG6Ocitq0UJCYq9SmfPkhVoCkM5WUHXeUawcz
         7uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zKrL812IZj983CDNoTAXGWrzyYsFXUo70xd8d5OVRw=;
        b=DnKsPiKYgZZ6RM0G3BqbPn9F7wS80I0WGsV59iOEIAQFej08p+h6Eiw4OA7JDSgtGW
         eeO6MRS+/JUe8OMvpox6GfkN1qUWHbvxlPmxEI0Qj2W3FZM9OLThq37MOtSOFbkl2fCb
         5aI66oCWLNtTLHrF+oR+tZD3xmiFml1xCRHl0rjXx5GQGWXk4eYTo+Wlc+hxdaos/HLo
         gipjpe4bzhT5h0naCwuwsgxkPL+kmX0XA4Q7gWAge9kkzGHzNs83dk8fFcD304+rYQuj
         sw+L5eLyt+6jGTKTuXwhMsaa0UP74oVcx/mjDDPkc4e6z0TjPNoPRd/bDxQbzyIMpJGv
         Wqfw==
X-Gm-Message-State: AOAM5302J8XJdUOJnqthpSSHIQk3ROVMrsunrNOGVlI3C9yOx2ELWEs6
        l8G5t/r/d2hQLS3wBx1pIfO88JI9KPTXsYUWAmVFzQ==
X-Google-Smtp-Source: ABdhPJzYACAhNeBki+5sxnyzl/I1D8hsXspGBbTtTNOTP9ryqsZwhQMC1+Cl+YsUD0Vcn6/Cm7DGttsgpUvEDzyH18I=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr573260pju.8.1632766774563;
 Mon, 27 Sep 2021 11:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210922183331.2455043-1-hch@lst.de>
In-Reply-To: <20210922183331.2455043-1-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 11:19:26 -0700
Message-ID: <CAPcyv4g-H20sh_CLmNFycQ28BYGmVK8q_v6-8k2-YoctqwwUNQ@mail.gmail.com>
Subject: Re: fix a dax/block device attribute registration regression
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 22, 2021 at 11:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Dan and Jens,
>
> this series fixed a regression in how the dax/write_cache attribute of the
> pmem devices was registere.  It does so by both fixing the API abuse in the
> driver and (temporarily) the behavior change in the block layer that made
> this API abuse not work anymore.

I took patch1 into for-5.15/libnvdimm, patch2 into for-5.16/libnvdimm,
and I'll leave patch3 for Jens.
