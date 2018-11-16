Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6253C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 02:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749B32145D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 02:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="mxj5a+9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749B32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeKPM2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 07:28:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38218 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeKPM2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 07:28:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so2625767pfi.5
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 18:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uWxOI7EW+B6BaLJ4pF1Ucb4JKvaIuWDE5mYJ2nvblqE=;
        b=mxj5a+9WhaUzzn6ENIPyyJMDBjBRDUGhUl2p38GDhnPH+yLz97xJGMlhaOjc+x0c96
         SZP6XEZfRQZo5jsFCwlLfiDojuqLbpzRHVh52QfLDd9K55bag+4IyroxO1cq3SrkGVbp
         wpNoT55+M98lKeG/wuihGyrjfR1RhTKeyN+f8S/X2Ktx1Q0eqUJz5rqTgM/A4Pbv7duR
         LB28WnNvGsapqmb77uTNrgtK4BqM45hHGbHpDKezmNiNdQB2AJf/s09zpqWwyhfB/ShX
         C70fPi4L089v3cKjZaCZGf6oYE4VzreeOOSc997WA0dDu7InSYJwxQSzz1KHpuUeoL4Q
         F6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uWxOI7EW+B6BaLJ4pF1Ucb4JKvaIuWDE5mYJ2nvblqE=;
        b=IYg4bPnpERi4GIoem+bPyqV8IPKEQBTjw6uK55c9r/bGwOqzj127w/6bo/xMOuUQlq
         ut77HOKBwYXayQUXQiuDZvBAatXvteZftKxpaGmLTYyWn34IAXG2cw1rpSfTtfy6KvLf
         DArtoCFB92Pi2/GDac+9TnECybpRl4SF71mLlZt//gntx1P0wUgmagSMWrzAmgvyp1Yo
         IHh/Ytrtj2864GdFIqxG6DmCZS6y+v5I5JIwnIBCoHXrZYmEUv6lcJKJ7xsKeY2vJTnX
         L8TE/QQenmeeN1jQzLUom+OVXDkdh2wQ7iuZ2IZ4NdCOuXBTWBanl+xqax9e4mW17xor
         1Kug==
X-Gm-Message-State: AGRZ1gJROD+wXYNBz0UmMIVN9iYM+CDQhaQJ2ebMds3W5sE5KkRCN/tQ
        XBgfMoFxaRNZGd1xZ14YccgwQA==
X-Google-Smtp-Source: AJdET5cfhaHk05TqW2Jq6nTxtIdo0ficfDaKFmLY+f8LDNaSqXZd501bp6MC6dyRxNdzTO6b9nJlNw==
X-Received: by 2002:a63:101d:: with SMTP id f29mr8219269pgl.38.1542334693471;
        Thu, 15 Nov 2018 18:18:13 -0800 (PST)
Received: from vader ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id v15sm8249986pfn.94.2018.11.15.18.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 18:18:12 -0800 (PST)
Date:   Thu, 15 Nov 2018 18:18:11 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Coly Li <colyli@suse.de>,
        linux-bcache@vger.kernel.org, Boaz Harrosh <ooo@electrozaur.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: Re: [PATCH V10 18/19] block: kill QUEUE_FLAG_NO_SG_MERGE
Message-ID: <20181116021811.GM23828@vader>
References: <20181115085306.9910-1-ming.lei@redhat.com>
 <20181115085306.9910-19-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115085306.9910-19-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 04:53:05PM +0800, Ming Lei wrote:
> Since bdced438acd83ad83a6c ("block: setup bi_phys_segments after splitting"),
> physical segment number is mainly figured out in blk_queue_split() for
> fast path, and the flag of BIO_SEG_VALID is set there too.
> 
> Now only blk_recount_segments() and blk_recalc_rq_segments() use this
> flag.
> 
> Basically blk_recount_segments() is bypassed in fast path given BIO_SEG_VALID
> is set in blk_queue_split().
> 
> For another user of blk_recalc_rq_segments():
> 
> - run in partial completion branch of blk_update_request, which is an unusual case
> 
> - run in blk_cloned_rq_check_limits(), still not a big problem if the flag is killed
> since dm-rq is the only user.
> 
> Multi-page bvec is enabled now, QUEUE_FLAG_NO_SG_MERGE doesn't make sense any more.

This commit message wasn't very clear. Is it the case that
QUEUE_FLAG_NO_SG_MERGE is no longer set by any drivers?
