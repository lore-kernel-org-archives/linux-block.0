Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE627C43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 16:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A905221872
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 16:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfADQ6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:58:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44241 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfADQ6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 11:58:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so40940579qte.11
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 08:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAsVEEYKBC/LgSjEHQZvDBZoXmy/HzGeSC4Gxh1fW7A=;
        b=DF3fusulUDLQcj6kRe9C5aw+wRJNjcwM77O1P34P9fLi3cjprf+YNREn0LdeE+ZJ0R
         z9f2katM5i3qGBylaQP9fAEUdfvRx3P13alP9q55IKU9+qjMc7P9nsC+F4yyQmlTKnlL
         xqwzKwyemxh//NwjA/N1G8QpM1lJTksdfIrwAwNq4sAj/fImv59KPBhoinsvGiqJk3Lm
         Q1+83EATjOxz6fR9ETMSGinBDA4B+ArTzgIlVsB0ftrnp3acx+vHPtg6iITYpK5mtBfx
         pMSx4VIihijS8mVrniqCbvcBF3lkbDd19OiT67eCcjYcOi9R2r9bvoHbxUxDINsvOd3Q
         tkMw==
X-Gm-Message-State: AJcUukdWmMgyMjXiGsfB8iiWN04tTHFjkiQar1UJqhbIcKH7Iz1RZibN
        XxcztKy1RlxbHQXdsS9TDUGdry4qbNs=
X-Google-Smtp-Source: AFSGD/WAlK7mr9Ic7VWc+6NmjMNOsHs8AQmhFdkMENLx9Df6jGsJWjo90tHMri5LCiGfV5KX/8rjrw==
X-Received: by 2002:ac8:53c6:: with SMTP id c6mr51768357qtq.278.1546621123823;
        Fri, 04 Jan 2019 08:58:43 -0800 (PST)
Received: from 2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-56ee-75ff-fe93-2951.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:56ee:75ff:fe93:2951])
        by smtp.gmail.com with ESMTPSA id k6sm33706507qtk.41.2019.01.04.08.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 08:58:43 -0800 (PST)
Message-ID: <1546621122.2666.4.camel@redhat.com>
Subject: Re: [PATCH] null_blk: add zoned config support information
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        John Pittman <jpittman@redhat.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Fri, 04 Jan 2019 11:58:42 -0500
In-Reply-To: <1546620417.163063.45.camel@acm.org>
References: <20190104154243.3538-1-jpittman@redhat.com>
         <1546620417.163063.45.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-01-04 at 08:46 -0800, Bart Van Assche wrote:
> On Fri, 2019-01-04 at 10:42 -0500, John Pittman wrote:
> >  static inline int null_zone_init(struct nullb_device *dev)
> >  {
> > +	pr_info("CONFIG_BLK_DEV_ZONED not enabled\n");
> >  	return -EINVAL;
> >  }
> 
> Have you considered to use pr_err() instead of pr_info()?
> 
> Thanks,
> 
> Bart.
Bart, good point, Thank you
Laurence
