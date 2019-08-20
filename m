Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24387C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13F222CF7
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 12:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfHTMrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTMrK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 08:47:10 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB2857E42A
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 12:47:09 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id b20so937929ljj.17
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 05:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUbitF4Zl7iTmYHdwo0TD8IGtAHMzvLSb9qBKyb7d1M=;
        b=E+ZV0zgZyyzPsnWc6XLQuYGFxgAcMY4A+LcaFunotbGX+gwt1/7XE6zsLtrZxOLkj1
         UJctTrdRKHbBtm2VjPeXd+6R5mmq7JoMcqtqdCsiZE9v9ThLTZhqt4uU1f0qAo9OyJL2
         NAcQA/CwNwvt4Cw0i7pn23oOBC0Q2puMltNhgeDhniNOpE1rEEHo2mjfmW5HuGBJe0p+
         uL8sQqz/b1nY0agtlTIaqgDYfXdjRADJTsNANB9bzR5V7Cerhv9A5dfYkwSvzdRPjq36
         V6vHBt6CQDj8sC4zDQd2sTcBrNHDpJRT8mM0REe5R8nfmSqNeX/E6A6RSkLViYkTzjM0
         S4+A==
X-Gm-Message-State: APjAAAU//5/zb8zeEF4GI3ZJ41CaXY2GF6qZDSyufwbitUHnS7EIUblN
        i9e+kq/jDknYK22SSMl+wMSOjHiyPn6ZtJTr5J78MYNiWQ5YhJ07gOsHxAi8yf5cJo3CSyD4KdV
        OxQjOrn2prdZ1gGNol83wz1bpCOqSXz90eHND6KM=
X-Received: by 2002:a2e:8455:: with SMTP id u21mr15052746ljh.20.1566305228422;
        Tue, 20 Aug 2019 05:47:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKinzUm2NNANHeLOTgngpHs9xSn/+1fbqrf8ihQ304elnQBdBd7Isytwe978knUSzgSwDz6GAmcM5PYC787qg=
X-Received: by 2002:a2e:8455:: with SMTP id u21mr15052740ljh.20.1566305228292;
 Tue, 20 Aug 2019 05:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190812123933.24814-1-jusual@redhat.com> <201e7900-1b3a-b1ce-fe49-d9fa4c3b8cb3@kernel.dk>
In-Reply-To: <201e7900-1b3a-b1ce-fe49-d9fa4c3b8cb3@kernel.dk>
From:   Julia Suvorova <jusual@redhat.com>
Date:   Tue, 20 Aug 2019 14:46:57 +0200
Message-ID: <CAMDeoFUvHqS0DMZBRf5Yu3e=y+1EkA9mZ2mB3=QpCtdahY+iVQ@mail.gmail.com>
Subject: Re: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 4:46 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/12/19 6:39 AM, Julia Suvorova wrote:
> > The names of the barriers conflict with the namespaces of other projects
> > when trying to directly include liburing.h. Avoid using popular global
> > names.
>
> I have applied this now. I don't think we can avoid having the
> barriers in the namespace, as we do need them in various macros.

Thanks. I've sent a follow-up patch to cover arm barriers too.

Best regards, Julia Suvorova.
