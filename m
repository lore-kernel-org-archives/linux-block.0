Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049D0C352AA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D035D21920
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FgFy2yn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfJAKDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:03:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43594 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfJAKDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 06:03:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id u3so9378815lfl.10
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfEC1TGjCjlUPWaqoa/5iDRLy0eOrlVNBmTC/RZtswg=;
        b=FgFy2yn9Vseh4V6b9FZsBr3u//+h6GwKFTqjNjIbcWJ0mQaiQGTSiWRyVPO45NIUDA
         +kv/fjRM0CDNs1rfcmp0D/jYCNq+AmiTjx7BXAvYmzxUk7nyzEIjh9Hb0oLtdyYlmc8N
         Uu+43KrFKPApQMGy0aT/d0tG5v2NIftz3uBiUcule0IGt35ijHdj78a0X00ycX4GLRQC
         aSTSWo/+hbV18WQ631WP8I2b395r4XwHm88odG30ryQoqka/S3USYW5D1KAKybhNtUqz
         Os/f8U7dEe46GTDepjDbV2mTb4yOHBK5reOhbnITEQIoJfeboQW1gNb6y8PWK4UwMhev
         qC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfEC1TGjCjlUPWaqoa/5iDRLy0eOrlVNBmTC/RZtswg=;
        b=YypXMYgGz1fvwPVrEnZE9n2rDe+uTdMrDIJHkEFbg6peHPtILmTxTIBT3lUEzr4CWc
         K7w/M0P97JMKk9RreguDxoCL3CFT6ypxMYt/9jluZBqHHl9PNSVLVqZt0RaswOncjbkU
         S2KIZssf7IPzcQ0y7FwLLYJ1J0HwiieMhe7bWZvZMVOLo9fQ+cYntsPQNLib3CiR8jd4
         wkAe5SDf4yltKEoDLvHXuHe44d0OCcbHMZOyBsxjNV01791+sKiGtXHy6ZhGwScOvC4i
         gdxqsv9hHNCbeqaJRpBiv1HG9zpdjrLEiCMv0qPZ9tZnGoRlasP4pOvCnilqrRpcYqpb
         asvQ==
X-Gm-Message-State: APjAAAW9aWqfKLK0DekddY+e/jULKwWbmEWAv1shWejPXQZAn1mnECg/
        0OJtacuZgmFGxunwQ/9pBYtqLni6VK9P5ALBSFSobA==
X-Google-Smtp-Source: APXvYqzhkD7UlRzoO0uUjEuC4Yfk22O8a6MQo5HB3/Lxq6PF5WJDvAxfTvdSjbsjJNtoOirXvj3Zg7Jlffnv64l+Pq0=
X-Received: by 2002:a19:c6d5:: with SMTP id w204mr13871509lff.53.1569924211487;
 Tue, 01 Oct 2019 03:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190828103229.191853-1-maco@android.com> <20190904194901.165883-1-maco@android.com>
 <20190930082412.GA9460@infradead.org>
In-Reply-To: <20190930082412.GA9460@infradead.org>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 1 Oct 2019 12:03:20 +0200
Message-ID: <CAB0TPYHVGNaM=0Tz8rJdy7ts4-0PE37kXQT-7D5O51zd7pvAcw@mail.gmail.com>
Subject: Re: [PATCH v2] loop: change queue block size to match when using DIO.
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 30, 2019 at 10:24 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks Christoph! Jens, Ming, are you also ok with taking this?
