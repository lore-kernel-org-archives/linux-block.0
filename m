Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A792C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 06:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B520857
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 06:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Z5dWzW6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDTGvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTGvl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 02:51:41 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8EC061A0C
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2020 23:51:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u11so9771185iow.4
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2020 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9C3JrepzlEGKADW5HtDCdCafm4wqGu05lhff6+4aJMo=;
        b=Z5dWzW6BfU0AxZMGyd/x/5DWnIt79HKY/2Ig+sWHu3mNttFNGXQUsMaT11ArAmgRYy
         8wqw3/tKMcLttzqIX+rs0RFmqYsj9b40NBk9SwU8c/QkeRJPAmBoRXEXbWHkqwubRnAL
         ZXvkI2tF1yjqERyVlJlzSQQsnqAJ92+fDx9AqV16TPYjnAA6A8ebQxEGVY4bdzwqlF5x
         mpyy8zOJRiXZF4dpK73XfREd7q5bIX19jR5j4RE+u4QdoS16OQBLqw5A2aPYZpxKGH0N
         bVZooo+1yWSAmuiCBOb/QbDjcnHkBoQf3xctjmFrDHVd9oz3dJBRUf/BXBUUiKcnit5D
         o02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9C3JrepzlEGKADW5HtDCdCafm4wqGu05lhff6+4aJMo=;
        b=JkuD507XKmv8O23i5EthQMlShIlxA456Qn5+kdUGFJMBhf85844hlbQcw/4GBPhc0Z
         VWB8FZQUWlMqffDS+h9/5olHn7pDt5mDhzVg31rRlRekLOs3gwnkW7wOCTixFpEoMAke
         3JVBZ9O0ERUZF99qzYLGR2AAOB6prZo4jORBQ6vYk4qdpZYhl7/5JedS63FbHNiP8zYT
         S6QVus8mheDVy24trS0kZcE2H0Erd2Vn+nHDE965TWUZK1qz0vOfGPiyHGguz1rUBqBc
         C3SJRF1DL79f6mwYS+NFTlsLYFweyaWqNIOEedGWAvhnpPoktafKFNpnnXO8Jz/dGlkM
         xHiQ==
X-Gm-Message-State: AGi0PubPuETkuWGgd5Pi2jn5Ypdo+GHVq6NJEK3/Zcef9zfGd29sXGeT
        yvEhwjmCXQtKjyEV6nN/qg04sWbw8pwVXGuvldQ2NA==
X-Google-Smtp-Source: APiQypKLPuWd7ZldCVfSRJfvL21fUUq92hk74PDs5Jvylw5blzaJclVs0sMWwxK36H6w5FLLtDy/Unj9IupikBxv29M=
X-Received: by 2002:a6b:b955:: with SMTP id j82mr14375012iof.54.1587365500541;
 Sun, 19 Apr 2020 23:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-16-danil.kipnis@cloud.ionos.com> <d972a2e2-a26d-fa24-d5ba-6beac2ee2b69@acm.org>
In-Reply-To: <d972a2e2-a26d-fa24-d5ba-6beac2ee2b69@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 08:51:32 +0200
Message-ID: <CAMGffE=ji5Qe+-9gbbTou-qxF54tFzt2FXQtsPEKUvJSi8=iMw@mail.gmail.com>
Subject: Re: [PATCH v12 15/25] block/rnbd: private headers with rnbd protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 1:01 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > These are common private headers with rnbd protocol structures,
> > logging, sysfs and other helper functions, which are used on
> > both client and server sides.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
