Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CE4C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D09620866
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="jQtFbDri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfFNNln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:41:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34480 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfFNNln (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:41:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so1683367qkt.1
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yb0/sevEMdafr2vXQ3qC01lm6vSKeakGcpjhBltDdpk=;
        b=jQtFbDrieAPENr34h0NUQDNe209XEw+cgr6byx7mhVe+H/I4OpVT5Rmtkwu7rOTXDf
         UZyyDSms5H7OeZUnR29dpbgr+m10jg7GwyH4EjG9Ift7e1mZBpK4rQRKA5x4zK9cIUam
         PFXJWxFZ6irPMweVHfjT48XHVwUaLlv+WO9I8Y36/SMVyJdGBJdbhncsXKKVQ7hH+pq1
         lqPArqtDo8LoKzaNMBpxhNCABn++pc4m+hJgJEN5Lt2W6uFoh20WmEjYvxnYorDjx7sw
         aS7oYnV14PWuNtxeFf9la+DtngnBiNQEOROSSRJrSkgZJRuTXnUNfuUU02ZE43H3xx1Y
         d5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yb0/sevEMdafr2vXQ3qC01lm6vSKeakGcpjhBltDdpk=;
        b=NiJglDkic0r0TmysJ8Kn3njQkDQsLNQLyrqaE6WKa+NUPyhkh7paRsoyditwp3PNWi
         9h6oUQkrtOnS8VEEnZKeYzELYWZVZqUdGhTsuFO7zaEkzOXwFmIOK+a4ykIYQe5hCt9P
         7fXy1MjROcrNc8kS7K2uIHvNZo7CEsVSVC9BtmU0IkVH31xHDbDbdE96gDBvp986r61c
         q3tlasZg4eHiG6Oqlj+viduIU/kGoezkw5yE7BEvRS4qF1gGa2EyZXIg9KCua3ywa+0q
         NBl7O70mg/BjpY9kDO/g74ZlAU4GX6NtTnWIsv8IwPzIe6fRRyX+XaYsD4s1Ee9FtLe0
         Vexw==
X-Gm-Message-State: APjAAAW29Pls5MJKoH5p7WtD3i4vjG7hCnJWndjCGFFtc5NFH4+PF3HA
        71H5G5sXFs9Em0RmwZFVEz77qA==
X-Google-Smtp-Source: APXvYqy95F8IXy3awZMsVz6XFn2JcaEs7ITo2Lhv35mkO5CbPjyv/eOkl5aUm+OphfRVf0h+M09noQ==
X-Received: by 2002:a37:4b56:: with SMTP id y83mr32892834qka.338.1560519702426;
        Fri, 14 Jun 2019 06:41:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id l88sm1602172qte.33.2019.06.14.06.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:41:41 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:41:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/8] blkcg, writeback: Implement wbc_blkcg_css()
Message-ID: <20190614134139.miko2ypm5znqho6f@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-3-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:44PM -0700, Tejun Heo wrote:
> Add a helper to determine the target blkcg from wbc.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
