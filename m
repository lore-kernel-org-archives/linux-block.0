Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC2C432C3
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 23:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833642464D
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 23:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPPh1IqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK2XYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 18:24:49 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:40364 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfK2XYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 18:24:49 -0500
Received: by mail-qv1-f46.google.com with SMTP id i3so12208997qvv.7;
        Fri, 29 Nov 2019 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7psSbHOKLJpqliURvH6SJP6ewWlxb+84oSgJepvpTDE=;
        b=iPPh1IqXeuqZKr7hNdJhqOh0WXR00d+2SHZGEcjY29V3w06kpCRL/4YjWCmQkH6p97
         K0GXsMg7JcYeiyr12OdWI0X5iTTsABbtwRnV4RDg0/AoCp0kC+GPH3mqim+a5n/nI6TK
         ZEwmE341ySXETtqoKM606+xtWG04seeF3hyXxlhWYobQTrhxUPHmKU8yPod1JZ2IfRYH
         +23yBJAJG46rRhWFNzaK/7y/dAJA9jNRKUYJmBZvqjDn5zVQsB1RmH6yZokSlGqM3pMj
         K15nbQuy/vat+cwMq6D6CkctjxgREAhgMyoWpv44zJzgrakuszU++ewjntUCCK564QpS
         WTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7psSbHOKLJpqliURvH6SJP6ewWlxb+84oSgJepvpTDE=;
        b=sGMkB2WkrgqVU+Z+M4D8lyvZ0poXxM0zWfqB5BOuo4ZNXfPLW4IaKiZuP1t/9w/Tim
         m15PZJ7VuZtUUGnzcopxkgEn9h+qXon8fOJ81NYS8S/2LXonUCysb1p5XU1PXuDup7QU
         AnFflSiuQGLve7g4V69gLjWuctg/1dloPkoutnu6Ko/FO6g3FtZVVrx359O/wlciOTtS
         IKXXwrNzsebcLx2lbHYln29wTZh2DM8XJGcHyH8E4bKiEYBv1kyNjtClR5N1jPfLJOjn
         juL4zQL7C4fe+fkML1NnlumIhwkd+aDEbWu05Lrsey+zXzVg+YYd5/q24Aiwdpp+YTZV
         p+Hw==
X-Gm-Message-State: APjAAAUkwyPZqAu0/iGDr+OXMOd8DHzbxOgDmesfAyrKWuCkHvWoKQGW
        3yP93lxg4WabVgvv+hCN4vc=
X-Google-Smtp-Source: APXvYqymDGzj8Qg/iaokUv+3A9t9ETxQuEnBELeKAXoybfAWfAQdTHuRUDrNCVKMPI3FYwxCMJeHXQ==
X-Received: by 2002:ad4:57aa:: with SMTP id g10mr20582814qvx.164.1575069888483;
        Fri, 29 Nov 2019 15:24:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v45sm5153070qtb.32.2019.11.29.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 15:24:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 29 Nov 2019 18:24:46 -0500
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@canonical.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
Message-ID: <20191129232445.GA1331087@rani.riverdale.lan>
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 30, 2019 at 01:47:16AM +0300, Pavel Begunkov wrote:
> On 30/11/2019 01:17, Arvind Sankar wrote:
> > 
> > The loop can be simplified a bit further, as done has to be 0 once we go
> > beyond the current bio_vec. See below for the simplified version.
> > 
> 
> Thanks for the suggestion! I thought about it, and decided to not
> for several reasons. I prefer to not fine-tune and give compilers
> more opportunity to do their job. And it's already fast enough with
> modern architectures (MOVcc, complex addressing, etc).
> 
> Also need to consider code clarity and the fact, that this is inline,
> so should be brief and register-friendly.
> 

It should be more register-friendly, as it uses fewer variables, and I
think it's easier to see what the loop is doing, i.e. that we advance
one bio_vec per iteration: in the existing code, it takes a bit of
thinking to see that we won't spend more than one iteration within the
same bio_vec.

I don't see this as fine-tuning, rather simplifying the code. I do agree
that it's not going to make much difference for performance of the loop
itself, as the most common case I think is that we either stay in the
current bio_vec or advance by one.

> 
> > I also check if bi_size became zero so we can skip the rest of the
> > calculations in that case. If we want to preserve the current behavior of
> > updating iter->bi_idx and iter->bi_bvec_done even if bi_size is going to
> > become zero, the loop condition should change to
> > 
> > 		while (bytes && bytes >= cur->bv_len)
> 
> Probably, it's better to leave it in a consistent state. Shouldn't be
> a problem, but never know when and who will screw it up. 
> 

The WARN_ONCE case does leave it inconsistent, though that's not
supposed to happen, so less of a pitfall there.
