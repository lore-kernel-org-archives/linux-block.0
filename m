Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D0CA9EC8
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 23:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837A21D7C
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 23:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vtx1dqyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfJQX22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 19:28:28 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33063 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441686AbfJQX21 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 19:28:27 -0400
Received: by mail-pg1-f182.google.com with SMTP id i76so2257338pgc.0
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2019 16:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SM2pGjs7eERwodoor6ExqPgfO/oST5cuHUExEmzvoj4=;
        b=Vtx1dqyNHmC7TZ2gAunIg7QjUSP20NnMBF3dCIFwRL9Kt5DD0DbN8gMTTsMG7KSuqu
         4eMxCtz2RthI09mdvcWyJlssoVNxTekL36N6B6PNe5Mb60ZXjz4z+6qs4Bw/8wKbvw/K
         eQ9jmkHfWKrzs+wzBalykK2boOje6VniqeTmAgJ9SdwRGTnI5fcfWdef7CXQAgXZRFOJ
         y4SqfucKfWcYuc8fqE9X9jPBtXzq6T3eZkUrOANIz8VXFBDV8/PMLFKrxS5X07WSabFs
         0BMr6tFPNUQ7PYuq6TDZKeUA0i3ZY0RdfbVwXx3Oee5rYFA+Ge7sA5nJH+PokIEoUVeK
         mLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SM2pGjs7eERwodoor6ExqPgfO/oST5cuHUExEmzvoj4=;
        b=uBifV93LD0UG8BbTUHBFqTpwl7R1p3JHsUhxcJettS8kB57tts3z06Mf/z93WUrssb
         SVNWj3xmcMgiIUpY0gWW4AFQza/JqBADYL/EfBnHFA8tfptMEX5SovZHgB889cqDZ60D
         H1T6lYPFm9DU0V8t12p+aSd/gocwWekbCcdlmbgzeRxOPwFt3NIVxL4vFflDiTKUUPQz
         6Enuo7RTS4fqIRQfTOHMrmQ/xHa29KG9G1QOk9sVwYladN3lC6ReT+1kWrP+Nlilm1ep
         JHRs49o5YaqUwe15LU6MqkDHewtgcJdGyFwLrOlrAN4kbIqFYO+c4cuAYkGtBUwPECp/
         fL+g==
X-Gm-Message-State: APjAAAVQyUeX1j7SZzlEVoluoLrF0zFi2o+IdUD8lDbW71Q0aTVd5iya
        BWrYdstBUrR7JkfipZ5hveFlUzJth+FHtw==
X-Google-Smtp-Source: APXvYqyGBnJM7sHAQQQt+V7WXbqXjyjIYcJqz3FVVW6ixHXO0TqUAZk65aOlWairAN1zp788136AKw==
X-Received: by 2002:a63:d916:: with SMTP id r22mr6870074pgg.46.1571354906212;
        Thu, 17 Oct 2019 16:28:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::1120? ([2620:10d:c090:180::9d76])
        by smtp.gmail.com with ESMTPSA id t141sm5820247pfc.65.2019.10.17.16.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 16:28:25 -0700 (PDT)
Subject: Re: [RFC v3] io_uring: add set of tracing events
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, linux-block@vger.kernel.org
References: <20191015170201.27131-1-9erthalion6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af0fc0a7-11cc-08e6-cdfd-6b55fc208c8f@kernel.dk>
Date:   Thu, 17 Oct 2019 17:28:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015170201.27131-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/19 11:02 AM, Dmitrii Dolgov wrote:
> To trace io_uring activity one can get an information from workqueue and
> io trace events, but looks like some parts could be hard to identify via
> this approach. Making what happens inside io_uring more transparent is
> important to be able to reason about many aspects of it, hence introduce
> the set of tracing events.
> 
> All such events could be roughly divided into two categories:
> 
> * those, that are helping to understand correctness (from both kernel
>    and an application point of view). E.g. a ring creation, file
>    registration, or waiting for available CQE. Proposed approach is to
>    get a pointer to an original structure of interest (ring context, or
>    request), and then find relevant events. io_uring_queue_async_work
>    also exposes a pointer to work_struct, to be able to track down
>    corresponding workqueue events.
> 
> * those, that provide performance related information. Mostly it's about
>    events that change the flow of requests, e.g. whether an async work
>    was queued, or delayed due to some dependencies. Another important
>    case is how io_uring optimizations (e.g. registered files) are
>    utilized.

Looks good to me, I've applied it for some testing. Thanks!

-- 
Jens Axboe

