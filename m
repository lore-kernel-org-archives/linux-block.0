Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF51CA9EC7
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 23:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D62087E
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 23:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gONGGSLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfJ3XUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 19:20:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34427 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfJ3XUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 19:20:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so5885263qto.1;
        Wed, 30 Oct 2019 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eq1yFNqRbX5oXHA7cRAuOcjtnHFRC37UNq/RAe1IY8M=;
        b=gONGGSLeT+gVr1DX8wbpc78s4v4bhcEGPe0N5eKHhKbeec1MQq9MtOvWKwFEok1qc7
         R9eeIjk1WgjCJ/pWEf4koPblNYwE5cAnQx/0WZ/gmrQUpf9X+/YIACOzl7Tj7nSqvosw
         Of1c8qIdqv3Ma0z+Lm3icUJpZ0UXv4Y/ftEVvVhEHQbPt7+Yn8tUTqkEoZjxJ5Y1DaSd
         MUbruIZp+k7ImIZSlEjc9+FQSu5CPWsUK4BqbH9jfXtJ2VI9yrAwTmyq2obKO0+YKmht
         CLlBs9fZcCZ4ErEk8aoMQC6lzDak1MbMz5Qhcjp7cZzBuBsrxAe2rClG+jfAt8MDpUld
         57vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eq1yFNqRbX5oXHA7cRAuOcjtnHFRC37UNq/RAe1IY8M=;
        b=gP3WnmfcdtqoCO0XZaXl7jB4J8+pNPVYYaStb3n0khS1DoLpWMvttHVp63wkvIzCB6
         VO1iFpyouplsg4EVzJYhRqLlaY0u5rHoUWbdBOuqcJjqYhi6gL7m5poZFAj6PInH9eNO
         C7730ZAZ2jJpIbzLxbIgY+V1xmZ6+bFHzAOHivH/BqyItl6KG8HXKDKlGC51/16ktbAp
         DVHxj5z4b4XiedErFIQnYtBL6UjVk2h/RQbB+tD8mG9IeS1Ju86mFLK5N/z+KWcIggRZ
         MJ2UAnTRMVTS8A/APpBjZ6o+TqzRpc6RHSqmAWruS/U6rkaqRqe84e/pfehlODohvq96
         yNsw==
X-Gm-Message-State: APjAAAUfMR2S4k6fHs8tKkex+nyElD/PcFG+DRHfAG+TtoQSixbvKiFo
        Sqar+xol9ZeovUCgAi//LBMdyDKsjT/EfuGl8s4=
X-Google-Smtp-Source: APXvYqyvGeNOl87wx0ENiHy038JYbl6zzSmG1Hdz3NgWaI9PwsCQE/KXbe9y9SFlQOxvSWHxZaPjVrgafRT/xsxHP7E=
X-Received: by 2002:ac8:6f44:: with SMTP id n4mr1296553qtv.379.1572477651197;
 Wed, 30 Oct 2019 16:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191025070856.76761-1-hare@suse.de>
In-Reply-To: <20191025070856.76761-1-hare@suse.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 30 Oct 2019 16:20:40 -0700
Message-ID: <CAPhsuW5Wof-5jaP_oeEz3MeBO5w-bfVdsy0-LxT7-AJZmWyrdw@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: avoid soft lockup under high load
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.com>,
        Neil Brown <neilb@suse.com>, linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 25, 2019 at 12:25 PM Hannes Reinecke <hare@suse.de> wrote:
>
> As all I/O is being pushed through a kernel thread the softlockup
> watchdog might be triggered under high load.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Applied to md-next. Thanks!

Song
