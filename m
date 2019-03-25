Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947AAC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF55206C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="h74DMeM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfCYTEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:04:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36882 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTEo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 15:04:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so7033259pgq.4
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Li+sxRVgcUzu/xXlsU1OxR4yU6f2WuWuRdaytlj5/m4=;
        b=h74DMeM2MVeYvzYBCQpG3VDlYOH1q6qpEj2h0ZDrh9NYl1Vp3oZ/6vZZA5oP9xgH/r
         +xjm11OX65mHM2c41Lj1T1VkvMuYuQjNZOiInhbHMjCU0DsI2hg9Woskn1Dgsih3PF/K
         9sYMgludze+zivzEyaVqZ8qOIpMVqPG72MWqAre1rPBvDPohkI2SgN+czBWa1e+DatXP
         YoLAysbRwygZouXCw+9HgSm5KfTIrEs7DU9yVSXVDY6754uZP1+GB7CqugXzpn+SP3BV
         reYh3iqrDDa7w6xA2+xyZy44aQF/Ra3muh66cC9jE9N46UecuDo1mRlX0AE4I3UvO63M
         T+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Li+sxRVgcUzu/xXlsU1OxR4yU6f2WuWuRdaytlj5/m4=;
        b=p06DzIsEZhMj80e5VNtiXIi8VXyQl+e5hIkryAiDkLW0AoofmsVHKtZ35wjdb8PQh7
         SvXa3B9n4z+hz3xfFUZqjDJ/uxmZLKQJZUTXVOofUurAuLvZ9jHjYlzgVkAXfFsHjkBl
         jhistgCY7OwG7HC9woTiKYEhQ04i4YusKIasB3fnJa3uJnI37b9miP8ThiNLSfBDg4m4
         BtFMd3ZD1gigl+jSoNtXmPWw8njZ/WQyGO3aykEoPuGME3XjmSi32J0W6JJNqvHpnXmN
         mT1r21lwAxAzSzoVP3pQMRJhtnQq8FCB1oiC36yh4Owq3wf5ZRdzo/FBZ2ZYM5x145Ta
         qXYA==
X-Gm-Message-State: APjAAAXmOhLgUkSuxSw5vE8A4eRO4b1L7vP9rUn8m4ZBertxHvO8v9aN
        AG/l5W4DC58DPToF47RQQU/6gA==
X-Google-Smtp-Source: APXvYqzHCzsUlv9RJoPatljjhn7c0Qx/UnP2GGKkXzCIk9c8hK31DrWyrY+JpCpaa3lvnnQdTdZw1g==
X-Received: by 2002:a63:28c:: with SMTP id 134mr19673550pgc.278.1553540683180;
        Mon, 25 Mar 2019 12:04:43 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:b619])
        by smtp.gmail.com with ESMTPSA id i64sm24433053pfb.112.2019.03.25.12.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 12:04:42 -0700 (PDT)
Date:   Mon, 25 Mar 2019 12:04:41 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: fix sbitmap ws_active for shared tags
Message-ID: <20190325190441.GG5826@vader>
References: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
 <20190325185635.GF5826@vader>
 <5ed3aa61-e12d-2dc4-2a8d-e9cc02788371@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed3aa61-e12d-2dc4-2a8d-e9cc02788371@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 12:58:47PM -0600, Jens Axboe wrote:
> On 3/25/19 12:56 PM, Omar Sandoval wrote:
> > On Mon, Mar 25, 2019 at 10:22:50AM -0600, Jens Axboe wrote:
> >> We now wrap sbitmap waitqueues in an active counter, so we can avoid
> >> iterating wakeups unless we have waiters there. This works as long as
> >> everyone that's manipulating the waitqueues use the proper helpers. For
> >> the tag wait case for shared tags, however, we add ourselves to the
> >> waitqueue without incrementing/decrementing the ->ws_active count. This
> >> means that wakeups can take a long time to happen.
> >>
> >> Fix this by manually doing the inc/dec as needed for the wait queue
> >> handling.
> >>
> >> Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Can this use the helpers we added in 9f6b7ef6c3eb ("sbitmap: add helpers
> > for add/del wait queue handling")?
> 
> I don't think so without adding more, which seems kind of silly for this
> very specialized use case of openly manipulating the wait queues. The
> blk-mq setup there is very special cased.

Yup, I see. Assuming it fixes the issue,

Reviewed-by: Omar Sandoval <osandov@fb.com>
