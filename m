Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A220CC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4442084A
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DciL//Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeLPQN4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:13:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37916 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPQN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:13:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so4960718plb.5
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dss0kq05eW7Rq0+tbppAxUriNjNOIcwHVigf7s+DGbY=;
        b=DciL//IoPDUA9GdZt+a002MCFvxR5sVkRGcpTGLV8UVHV2kp67oyCsByIUQyFsSKpq
         mSnOPQrUY4wIaJ+unSWN1KS4+9WkXpZnkO0r3yFwfiDRlVugs69DTP9nIVrghKxIYaI2
         YH50onzlD+TjOxz6lOhLNnGLlQpU19rBKkwfsaTL97Z03RDfl5IKV615gEkCzJ1Sbf+H
         6vZY5Fu0DFnuhpbWR6pJ0PG11ZQyjzCLMqsGQORRoF7DOwNT/9sbVTeaLEvUTZRIJIs/
         K9Syk8p7Am9uKYrtV+DOpwGXNGZ3LALPoa9HHUDrOc55ByeqbVP98ZAr6P7UDdhjb2JY
         pPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dss0kq05eW7Rq0+tbppAxUriNjNOIcwHVigf7s+DGbY=;
        b=kZDk5y36Ch1zb96SwvYVZXcNmE/ht9VZ2AecH6jPLsa9Z4o22ZBlSsO/DXYkbv7yew
         L+/d3A0m/Rjt8W8wT+aQBi3geqvTOh5N6prH3rxqXKpjou8je+Nd6swUWzWKvgn0xLqn
         7Si9lMcQewLXZ+onSv4DuKkZpoI9MRGZBBDzcc8iUoKg5C+eAWiZu5nI5phLishZ+PQ9
         sJOB6TIENevelAmJ3UCqSbKTbDJZjTu7F1f1j6O927qnos1BjOAR+a6qfbvQoLymPJjL
         8uAM61aJeil+Mye81LHhX+QlTIH1B60dLse0Rd59xVWFw7IkS/DCYh4uADcZqy4xtoOg
         JCLA==
X-Gm-Message-State: AA+aEWZLF7vfydgte+PpF2KVIk97gs4icXRqPZzwEnxfd28Bunf/ESF4
        NSymB/KS0OZhGTwhk2/HzZad5w==
X-Google-Smtp-Source: AFSGD/Wnv0DmGrUytTAauG1vDrJpnV+7PsILI6lCJGAYkFUQPbVTnhFEUooBKL4QNPx92C40bs/96g==
X-Received: by 2002:a17:902:292b:: with SMTP id g40mr9951107plb.82.1544976835894;
        Sun, 16 Dec 2018 08:13:55 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a4sm11280726pgv.70.2018.12.16.08.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:13:54 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq-debugfs: support rq_qos
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20181214113926.7451-1-ming.lei@redhat.com>
 <20181214113926.7451-2-ming.lei@redhat.com>
 <1544814707.185366.425.camel@acm.org>
 <68f580d7-b704-c4cf-dbca-558ad5b5ea98@kernel.dk>
 <20181216160955.GA9957@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <526361e5-2726-bbec-51f4-41fd37ae9c8b@kernel.dk>
Date:   Sun, 16 Dec 2018 09:13:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216160955.GA9957@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 9:09 AM, Christoph Hellwig wrote:
> On Sun, Dec 16, 2018 at 09:04:37AM -0700, Jens Axboe wrote:
>> It would fit better with the style in that code do to:
>>
>> rqos = q->rq_qos;
>> while (rqos) {
>>     ....
>>     rqos = rqos->next;
>> }
> 
> But that is just a really strangly written for loop to start with..

I think it looks fine, and it's more readable than using a for()
loop for something like this.

> Maybe Bart need to send a cleanup patch for the whole file, especially
> given that this patch has been applied already.

As mentioned in the same thread, I dropped these since I had to
amend a commit anyway. So we're free to do whatever.

-- 
Jens Axboe

