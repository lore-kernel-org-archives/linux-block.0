Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E052C65BAF
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 08:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E909C20855
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 08:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="aGFBg6jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E909C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLJIKq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:10:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54910 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLJIKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 03:10:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2447842wmh.4
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 00:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sjkW69AJsjNm9vM+hyYZea61s4UL+vXEnJM9jpCEopw=;
        b=aGFBg6jj2+k5H6gKvJUaTJYPYrWRnzaouEynMksQECt+IEHJfzEOejStT4xCFCztRe
         +GsZs1YALWJkaBREYSq0MgvmEy/Qq3LpX2LnZnLskd79FivmfTwbSHdC9VtMoAYkUJwW
         U0aG9sf+HIwG8+GS+AGjOKpiFETtK27QgiKF1zOautPvpaIj/bVI+fRPxMetsmryQO50
         MsbtuXYJi477payIkCVR87MPYmgdHHDJSantTSELjlnlqiKZI6FuYJShY7FXGLkZPEbO
         YoLTSnNttYpqQhVWt4BLLAQ8dK/J3q8RDAdabDcUs3QTktqL2B5sdEEVDKkRM9C1pkI2
         rMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sjkW69AJsjNm9vM+hyYZea61s4UL+vXEnJM9jpCEopw=;
        b=Fr+A7N7KFQDca1tV1EpYz624JZXtERGqc0NAHSHfzWWpJwgvkbEwOD/mKz6IhHr1wl
         8jbbshkNnd8poCM2JfxtgYBsLsPBjQ2JcSG69TX+nHmjvNW08owEzeWn7SHxuaTKZj2F
         MEd/rhV6BWUg6FZ8ajKR2J33kOAU2cfN+lmxBYyUVHNg+2vYjCKhEvdEMUQ/IrPPrYPE
         TpKw6mK7NYmm+xA6DXcRVN17StK5CtLWzaU0AHnIhYEE5dQeDFrIe3YLMoo+OoTR9xvv
         vf4CsvR/V1JYRYqd8LtBgCqZN4TQRvcl9ti9Ox4qg8qaWsqGWprDtw1i/l5xYWqBQBza
         e4ew==
X-Gm-Message-State: AA+aEWa4EYVqDLLTg+SCGOKllrL9ckvGhdTBNY8+cdYR8tthwSnXVi7a
        HTXcyfDJspvVz2i3OfDaXVRQ1A==
X-Google-Smtp-Source: AFSGD/U/bqDUzoB03b3/Sn97hzwOKJJPGBzJxjjLwXi85jyaXzd+6v+6rI7hNTbDEd4bPLTcACr3Rw==
X-Received: by 2002:a1c:1112:: with SMTP id 18mr10315704wmr.30.1544429443709;
        Mon, 10 Dec 2018 00:10:43 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id o81sm16772282wmd.10.2018.12.10.00.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 00:10:43 -0800 (PST)
Message-ID: <ae5d39e8f3ed97e854d005697fa1b076edc7c405.camel@scylladb.com>
Subject: Re: [PATCH 15/26] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Date:   Mon, 10 Dec 2018 10:10:41 +0200
In-Reply-To: <ad13ccdd-cdc5-adc9-35ca-958a30a9477d@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
         <20181207222016.29387-16-axboe@kernel.dk>
         <e0494161918d30787fbc759f9d2b77953249ab8b.camel@scylladb.com>
         <ad13ccdd-cdc5-adc9-35ca-958a30a9477d@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2018-12-09 at 07:36 -0700, Jens Axboe wrote:
> On 12/9/18 3:02 AM, Benny Halevy wrote:
> > > +static int __aio_iopoll_check(struct kioctx *ctx, struct io_event __user *event,
> > > +			      unsigned int *nr_events, long min_nr, long max_nr)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	while (!*nr_events || !need_resched()) {
> > 
> > Hmm, it doesn't make sense to spin in this loop
> > if the user got _all_ the events he requested, even
> > if !need_resched().  How about:
> > 
> > 	while (!*nr_events || (!need_resched() && *nr_events < max_nr)) {
> 
> That checking is done io aio_iopoll_getevents(), there are other
> conditions where we don't want to spin, like nr_events >= min_nr for
> instance. But all that logic is in aio_iopoll_getevents(), from here we

Right.  We'll break from the loop in this case.

> just know that we probably need to continue if nr_events == 0.
> 
> I don't think there's an issue here, and no spinning when we don't need
> it.
> 


