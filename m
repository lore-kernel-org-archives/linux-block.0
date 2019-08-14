Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA30C32750
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 02:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ED920844
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 02:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9ndCYzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHNCEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:04:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38059 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHNCEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 22:04:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so5708122edo.5;
        Tue, 13 Aug 2019 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yClt4IiYnvtlCU9uUEc5mhIYUjABpvyWOso+HI4mu3o=;
        b=l9ndCYzlwR5qGpefWEgVLiJsPd4v8Dk4nsao6j4NOxiRFw3jG0aPROGqZxMVJR3lpC
         GgflwMHAjzTKnoSfg6myFWphE5+A5HM8M2CC4ZNWiHjcMVl9lJ/c+PaDElSrNzJrfBGb
         BniQUVDawR1ghe7yEsAp2HWpQJrndum1p0fxY5vT+knYDfn0SUqQPRT2Fgy1pQLXrb+I
         WtvdlASjkuw+vO/1ZJ0V56F047OwOcNphKVmF3q3LEuJ6bEUsRuU1v5RdOVyx6oBNJbf
         7glrhkCTTq7yr9ZGLALrsby9RiapZVvRb2IKimk68pRikKBjUMxUDjEVDYoqd8rLVkoM
         IM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yClt4IiYnvtlCU9uUEc5mhIYUjABpvyWOso+HI4mu3o=;
        b=PJgHaZPnbKXJKqkVYvGMnUNUfRFlbwaYKHASInI+ak4LtttNCCeqJ76LQ8L0kRUoMu
         nb5khdCVbmC5yh8dkT0NiG4h3oyi6ZRFbHx0u2aaGPIF1z5XztRWriuun9s3PPocmx2E
         wpX5Ae06CvRJMVxBORvj4gc6PXxW5UDLjhTp79JsSkjwKsqS6zvLuKux4keZGxszKP1M
         0Y7u3MC18JU6ogMhXIfwoDQzCfFmDOJ/qIAU1Gmy6oiQKjS7rPecf2pQDfIqQ++15yho
         V9LSMp1lrd4A03viztn2IfuerY1ZcEskeJgL4TAiesCI9Iaf8giwUncg5d5Wj8SLIFKQ
         UBYA==
X-Gm-Message-State: APjAAAWlXr3axFgvQqD2sIfb/UNK9sdsTFp/dycanfm8SpF3HM98KvXi
        puMwbSm/91qLiPRMIFJ65qA=
X-Google-Smtp-Source: APXvYqxhOvGYIm/p1syoBfmRH4Nh5i7jAhIt7mkfGBb6oygRhVeG0iblgw2hn7e0AoAKsPwHBKza7g==
X-Received: by 2002:a50:b48f:: with SMTP id w15mr45996037edd.260.1565748268455;
        Tue, 13 Aug 2019 19:04:28 -0700 (PDT)
Received: from continental ([186.212.91.40])
        by smtp.gmail.com with ESMTPSA id x11sm25444255eda.80.2019.08.13.19.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 19:04:27 -0700 (PDT)
Date:   Tue, 13 Aug 2019 23:05:40 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/4] blk_execute_rq{_nowait} cleanup part1
Message-ID: <20190814020540.GA27622@continental>
References: <20190809105433.8946-1-marcos.souza.org@gmail.com>
 <55246cff-6d32-e7d5-bee0-9940bc59250a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55246cff-6d32-e7d5-bee0-9940bc59250a@kernel.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 11, 2019 at 07:47:17AM -0600, Jens Axboe wrote:
> On 8/9/19 3:54 AM, Marcos Paulo de Souza wrote:
> > After checking the request_queue argument of funtion blk_execute_rq_nowait, I
> > now added three more patches, one to remove the same argument from
> > blk_execute_rq and other two to change the at_head argument from
> > blk_exeute_rq_{nowait} from int to bool.
> > 
> > Original patch can be checked here[1].
> > 
> > After this patch gets merged, my plan is to analyse the usage the gendisk
> > argument, is being set as NULL but the majority of callers.
> > 
> > [1]: https://lkml.org/lkml/2019/8/6/31
> 
> Don't ever send something out that hasn't even been compiled. I already
> detest doing kernel-wide cleanup changes like this, but when I do, I
> need absolute confidence in it actually being tested. The fact that it
> hasn't even been compiled is a big black mark on the submitter.

My bad. I compiled the code locally and tested in VM, but later on I removed
the semicolon by mistake while reviewing the changes once more and the code
was commited without the semicolon. I'm improving my setup (scripts
and whatnot) to avoid this happening again in the future.

> 
> -- 
> Jens Axboe
> 
