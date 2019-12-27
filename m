Return-Path: <SRS0=cIu3=2R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989CEC2D0C6
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 15:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1520882
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 15:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KzLzCJFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0Pyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Dec 2019 10:54:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45889 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Pyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Dec 2019 10:54:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so14605882pgk.12
        for <linux-block@vger.kernel.org>; Fri, 27 Dec 2019 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5tmJ7pFrmFzYzeB9duDLlIXotQmxNCWC6b/fIBvaYCk=;
        b=KzLzCJFpbtP/oJwyBNQ25kfgreR370en2dKVxMdyxJJXuCCMZoytDGHdkhZ/Q+iJjI
         wfoN6ft8uMihOQ5SxXCF9ksuEolbVxqx7I/e8vIpvZ0EZoNiYPv07HV+JQt+I/hR1iBO
         sE87usxT9O5hytFGqTUinsg/Zw4o8sfBEeodb9WdxDGD832+9j8OwMR3U6GFP2xx2XoA
         6pMWeDt6AtMpijj5Zu11f0w2xSI62A6lc/hFTfohmZQ6YfcK7OgRt8GwwUQo4NtSynET
         LrushROkNN+qYR3f3/xWEsh1uSPQJ3hn6CK8S69ExFwByMP1LzP5ljA8QFfWomcwkBxX
         +UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tmJ7pFrmFzYzeB9duDLlIXotQmxNCWC6b/fIBvaYCk=;
        b=QhXHxGFMp3NO/lJAhJqsdr39htNYD8IFSI6s5rVXvvI03V84anTbZ2/ihchdwtHFY3
         r6JttFDDtZkoqphhlhSnvKjFguY9aQr5xFG+4ET83A6j0XS634N4iDaOQPeeBIIBVn0Q
         qDGix+iATbaWL9g1JrtRLiRjj2AVlZqHrus+Dl4507j+7D5YnQY8SbpJxUwxbBnVhCLc
         ALpjSQn/n5exA+GSec+6NVOGDlbxFJyXqtnzbOgc6N7pnLGHqNFRtWsC8fg+4X/qhUhu
         Hl6ioRbXLcMAMjY+vcfWh7TzWuZi49ticWrguf70ay2hmeQzkezY6XvxRnhmvETCAfKL
         RZfg==
X-Gm-Message-State: APjAAAUf9ci45zHC6GiKrgYGpBwNZrFL0F9lFK4BMEYur3DWe4yGYHFg
        97P2DeX+mxNlgjWPbz1oZuJqBA==
X-Google-Smtp-Source: APXvYqwriT6+++f0WbF5wJkls137egx/03pjzMGgKvJ+IOmh+HZhBsWos/+tWFHwgwcLXbNkun89aw==
X-Received: by 2002:a63:1210:: with SMTP id h16mr54486504pgl.171.1577462072890;
        Fri, 27 Dec 2019 07:54:32 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id h26sm44211250pfr.9.2019.12.27.07.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 07:54:32 -0800 (PST)
Subject: Re: [PATCH] block: add bio_truncate to fix guard_bio_eod
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
References: <20191227083658.23912-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8e77b65-5653-39bc-3593-ec6a939d1ecb@kernel.dk>
Date:   Fri, 27 Dec 2019 08:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227083658.23912-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/27/19 1:36 AM, Ming Lei wrote:
> Some filesystem, such as vfat, may send bio which crosses device boundary,
> and the worse thing is that the IO request starting within device boundaries
> can contain more than one segment past EOD.
> 
> Commit dce30ca9e3b6 ("fs: fix guard_bio_eod to check for real EOD errors")
> tries to fix this issue by returning -EIO for this situation. However,
> this way lets fs user code lose chance to handle -EIO, then sync_inodes_sb()
> may hang forever.
> 
> Also the current truncating on last segment is dangerous by updating the
> last bvec, given the bvec table becomes not immutable, and fs bio users
> may lose to retrieve pages via bio_for_each_segment_all() in its .end_io
> callback.
> 
> Fixes this issue by supporting multi-segment truncating. And the
> approach is simpler:
> 
> - just update bio size since block layer can make correct bvec with
> the updated bio size. Then bvec table becomes really immutable.
> 
> - zero all truncated segments for read bio

This looks good to me, but we don't need the export of the symbol.

-- 
Jens Axboe

